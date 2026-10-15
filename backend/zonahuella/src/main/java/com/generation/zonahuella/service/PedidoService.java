package com.generation.zonahuella.service;

import com.generation.zonahuella.dto.DetallePedidoDTO;
import com.generation.zonahuella.dto.PedidoDTO;
import com.generation.zonahuella.exception.UserNotFoundException;
import com.generation.zonahuella.exceptions.RecursoNoEncontradoExceptions;
import com.generation.zonahuella.model.*;
import com.generation.zonahuella.repository.DireccionRepository;
import com.generation.zonahuella.repository.PedidoRepository;
import com.generation.zonahuella.repository.ProductoRepository;
import com.generation.zonahuella.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.util.*;

@Service
public class PedidoService {

    private final PedidoRepository pedidoRepository;
    private final UserRepository userRepository;
    private final DireccionRepository direccionRepository;
    private final ProductoRepository productoRepository;

    public PedidoService(PedidoRepository pedidoRepository, UserRepository userRepository, DireccionRepository direccionRepository, ProductoRepository productoRepository) {
        this.pedidoRepository = pedidoRepository;
        this.userRepository = userRepository;
        this.direccionRepository = direccionRepository;
        this.productoRepository = productoRepository;
    }

    @Autowired


    // Obtener todos los pedidos
    public List<Pedido> obtenerTodos() {
        return pedidoRepository.findAll();
    }

    // Obtener un pedido por ID
    public Optional<Pedido> obtenerPorId(Integer id) {
        return pedidoRepository.findById(id);
    }

    //Obtener los pedidos de un Usuario
    public List<Pedido> obtenerPorUsuario(Integer idUsuario) {

        if (!userRepository.existsById(idUsuario)) {
            throw new UserNotFoundException(idUsuario);
        }

        return pedidoRepository.findByUsuarioIdUsuario(idUsuario);
    }

    // Crear un pedido
    @Transactional
    public Pedido guardarPedido(PedidoDTO dto) {

        User usuario = userRepository.findById(dto.getIdUsuario())
                .orElseThrow(() ->
                        new UserNotFoundException(dto.getIdUsuario())
                );

        Direccion direccion = direccionRepository
                .findById(dto.getIdDireccion())
                .orElseThrow(() ->
                        new RecursoNoEncontradoExceptions(
                                "Dirección no encontrada con ID: "
                                        + dto.getIdDireccion()
                        )
                );

        if (!direccion.getUsuario().getIdUsuario()
                .equals(usuario.getIdUsuario())) {

            throw new IllegalArgumentException(
                    "La dirección no pertenece al usuario indicado"
            );
        }

        if (dto.getDetalles() == null || dto.getDetalles().isEmpty()) {
            throw new IllegalArgumentException(
                    "El pedido debe contener al menos un producto"
            );
        }

        Pedido pedido = new Pedido();

        pedido.setUsuario(usuario);
        pedido.setDireccion(direccion);
        pedido.setFechaPedido(LocalDateTime.now());
        pedido.setMetodoPago(dto.getMetodoPago());
        pedido.setNotas(dto.getNotas());

        BigDecimal total = BigDecimal.ZERO;

        List<DetallePedido> detalles = new ArrayList<>();

        Set<Integer> productosAgregados = new HashSet<>();

        for (DetallePedidoDTO detalleDTO : dto.getDetalles()) {

            if (!productosAgregados.add(detalleDTO.getIdProducto())) {
                throw new IllegalArgumentException(
                        "El producto con ID "
                                + detalleDTO.getIdProducto()
                                + " está repetido en el pedido"
                );
            }

            Producto producto = productoRepository
                    .findById(detalleDTO.getIdProducto())
                    .orElseThrow(() ->
                            new RecursoNoEncontradoExceptions(
                                    "Producto no encontrado con ID: "
                                            + detalleDTO.getIdProducto()
                            )
                    );

            if (detalleDTO.getCantidad() == null
                    || detalleDTO.getCantidad() <= 0) {

                throw new IllegalArgumentException(
                        "La cantidad debe ser mayor a 0"
                );
            }

            if (producto.getStock() < detalleDTO.getCantidad()) {

                throw new IllegalArgumentException(
                        "Stock insuficiente para el producto: "
                                + producto.getNombre()
                );
            }

            BigDecimal precioUnitario =
                    calcularPrecioUnitario(producto);

            BigDecimal subtotal =
                    precioUnitario.multiply(
                            BigDecimal.valueOf(
                                    detalleDTO.getCantidad()
                            )
                    );

            DetallePedido detalle = new DetallePedido();

            detalle.setPedido(pedido);
            detalle.setProducto(producto);
            detalle.setCantidad(detalleDTO.getCantidad());
            detalle.setPrecioUnitario(precioUnitario);
            detalle.setSubtotal(subtotal);

            detalles.add(detalle);

            total = total.add(subtotal);

            producto.setStock(
                    producto.getStock()
                            - detalleDTO.getCantidad()
            );
        }

        pedido.setDetalles(detalles);
        pedido.setTotal(total);

        return pedidoRepository.save(pedido);
    }

    // Actualizar un pedido
    @Transactional
    public Pedido actualizarPedido(Integer id, PedidoDTO dto) {

        Pedido pedido = pedidoRepository.findById(id)
                .orElseThrow(() ->
                        new RecursoNoEncontradoExceptions(
                                "Pedido no encontrado con ID: " + id
                        )
                );

        User usuario = userRepository.findById(dto.getIdUsuario())
                .orElseThrow(() ->
                        new UserNotFoundException(dto.getIdUsuario())
                );

        Direccion direccion = direccionRepository
                .findById(dto.getIdDireccion())
                .orElseThrow(() ->
                        new RecursoNoEncontradoExceptions(
                                "Dirección no encontrada con ID: "
                                        + dto.getIdDireccion()
                        )
                );

        if (!direccion.getUsuario().getIdUsuario()
                .equals(usuario.getIdUsuario())) {

            throw new IllegalArgumentException(
                    "La dirección no pertenece al usuario indicado"
            );
        }

        if (dto.getDetalles() == null || dto.getDetalles().isEmpty()) {
            throw new IllegalArgumentException(
                    "El pedido debe contener al menos un producto"
            );
        }


        // 1. Regresar al stock todo lo que tenía el pedido anterior
        for (DetallePedido detalle : pedido.getDetalles()) {

            Producto producto = detalle.getProducto();

            producto.setStock(
                    producto.getStock() + detalle.getCantidad()
            );
        }


        pedido.setUsuario(usuario);
        pedido.setDireccion(direccion);
        pedido.setMetodoPago(dto.getMetodoPago());
        pedido.setNotas(dto.getNotas());


        BigDecimal total = BigDecimal.ZERO;

        Set<Integer> productosNuevos = new HashSet<>();


        // 2. Procesar los detalles nuevos
        for (DetallePedidoDTO detalleDTO : dto.getDetalles()) {

            if (!productosNuevos.add(detalleDTO.getIdProducto())) {
                throw new IllegalArgumentException(
                        "El producto con ID "
                                + detalleDTO.getIdProducto()
                                + " está repetido en el pedido"
                );
            }

            Producto producto = productoRepository
                    .findById(detalleDTO.getIdProducto())
                    .orElseThrow(() ->
                            new RecursoNoEncontradoExceptions(
                                    "Producto no encontrado con ID: "
                                            + detalleDTO.getIdProducto()
                            )
                    );

            if (detalleDTO.getCantidad() == null
                    || detalleDTO.getCantidad() <= 0) {

                throw new IllegalArgumentException(
                        "La cantidad debe ser mayor a 0"
                );
            }

            if (producto.getStock() < detalleDTO.getCantidad()) {

                throw new IllegalArgumentException(
                        "Stock insuficiente para el producto: "
                                + producto.getNombre()
                );
            }


            // 3. Buscar si ese producto ya estaba en el pedido
            DetallePedido detalle = pedido.getDetalles()
                    .stream()
                    .filter(d ->
                            d.getProducto()
                                    .getIdProducto()
                                    .equals(detalleDTO.getIdProducto())
                    )
                    .findFirst()
                    .orElse(null);


            // 4. Si no estaba, creamos un detalle nuevo
            if (detalle == null) {

                detalle = new DetallePedido();

                detalle.setPedido(pedido);
                detalle.setProducto(producto);

                pedido.getDetalles().add(detalle);
            }


            BigDecimal precioUnitario =
                    calcularPrecioUnitario(producto);

            BigDecimal subtotal =
                    precioUnitario.multiply(
                            BigDecimal.valueOf(detalleDTO.getCantidad())
                    );


            // 5. Actualizamos el detalle existente o recién creado
            detalle.setCantidad(detalleDTO.getCantidad());
            detalle.setPrecioUnitario(precioUnitario);
            detalle.setSubtotal(subtotal);


            total = total.add(subtotal);


            // 6. Descontamos el nuevo stock
            producto.setStock(
                    producto.getStock()
                            - detalleDTO.getCantidad()
            );
        }


        // 7. Eliminar detalles cuyos productos ya no vienen en el PUT
        pedido.getDetalles().removeIf(detalle ->
                !productosNuevos.contains(
                        detalle.getProducto().getIdProducto()
                )
        );


        pedido.setTotal(total);

        return pedidoRepository.save(pedido);
    }

    // Eliminar un pedido
    @Transactional
    public void eliminarPedido(Integer id) {

        Pedido pedido = pedidoRepository.findById(id)
                .orElseThrow(() ->
                        new RecursoNoEncontradoExceptions(
                                "Pedido no encontrado con ID: " + id
                        )
                );


        for (DetallePedido detalle : pedido.getDetalles()) {

            Producto producto = detalle.getProducto();

            producto.setStock(
                    producto.getStock() + detalle.getCantidad()
            );
        }


        pedidoRepository.delete(pedido);
    }

    //Calcular precio final
    private BigDecimal calcularPrecioUnitario(Producto producto) {

        BigDecimal precio = producto.getPrecio();

        if (!producto.isEnOferta()
                || producto.getDescuento() == null
                || producto.getDescuento().compareTo(BigDecimal.ZERO) <= 0) {

            return precio.setScale(2, RoundingMode.HALF_UP);
        }

        BigDecimal porcentajeAPagar =
                new BigDecimal("100").subtract(producto.getDescuento());

        return precio
                .multiply(porcentajeAPagar)
                .divide(
                        new BigDecimal("100"),
                        2,
                        RoundingMode.HALF_UP
                );
    }
}