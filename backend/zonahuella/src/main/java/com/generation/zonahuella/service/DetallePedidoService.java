package com.generation.zonahuella.service;

import com.generation.zonahuella.model.DetallePedido;
import com.generation.zonahuella.model.Pedido;
import com.generation.zonahuella.model.Producto;
import com.generation.zonahuella.repository.DetallePedidoRepository;
import com.generation.zonahuella.repository.PedidoRepository;
import com.generation.zonahuella.repository.ProductoRepository;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@Service
public class DetallePedidoService {

    private final DetallePedidoRepository detalleRepo;
    private final PedidoRepository pedidoRepo;
    private final ProductoRepository productoRepo;

    public DetallePedidoService(DetallePedidoRepository detalleRepo,
                                PedidoRepository pedidoRepo,
                                ProductoRepository productoRepo) {
        this.detalleRepo = detalleRepo;
        this.pedidoRepo = pedidoRepo;
        this.productoRepo = productoRepo;
    }

    @Transactional(readOnly = true)
    public List<DetallePedido> listar(Integer idPedido) {
        buscarPedido(idPedido);
        return detallesDelPedido(idPedido);
    }

    @Transactional(readOnly = true)
    public DetallePedido obtener(Integer idPedido, Integer idProducto) {
        buscarPedido(idPedido);
        DetallePedido detalle = buscarDetalle(idPedido, idProducto);
        if (detalle == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND,
                    "El producto " + idProducto + " no está en el pedido " + idPedido);
        }
        return detalle;
    }

    @Transactional
    public DetallePedido agregar(Integer idPedido, Integer idProducto, int cantidad) {
        validarCantidad(cantidad);
        Pedido pedido = buscarPedido(idPedido);
        Producto producto = buscarProducto(idProducto);

        // 1. Revisar y descontar stock
        if (producto.getStock() < cantidad) {
            throw new ResponseStatusException(HttpStatus.CONFLICT,
                    "Stock insuficiente de " + producto.getNombre()
                            + ". Disponible: " + producto.getStock());
        }
        producto.setStock(producto.getStock() - cantidad);
        productoRepo.save(producto);

        DetallePedido detalle = buscarDetalle(idPedido, idProducto);
        if (detalle == null) {
            detalle = new DetallePedido();
            detalle.setPedido(pedido);
            detalle.setProducto(producto);
            detalle.setCantidad(cantidad);
            detalle.setPrecioUnitario(producto.getPrecio());
        } else {
            detalle.setCantidad(detalle.getCantidad() + cantidad);
        }

        // 3. Calcular subtotal, guardar y actualizar total del pedido
        detalle.setSubtotal(calcularSubtotal(detalle));
        DetallePedido guardado = detalleRepo.save(detalle);
        actualizarTotal(pedido);
        return guardado;
    }

    @Transactional
    public DetallePedido cambiarCantidad(Integer idPedido, Integer idProducto, int nuevaCantidad) {
        validarCantidad(nuevaCantidad);
        Pedido pedido = buscarPedido(idPedido);
        DetallePedido detalle = obtener(idPedido, idProducto);
        Producto producto = buscarProducto(idProducto);


        int diferencia = nuevaCantidad - detalle.getCantidad();
        if (diferencia > 0 && producto.getStock() < diferencia) {
            throw new ResponseStatusException(HttpStatus.CONFLICT,
                    "Stock insuficiente de " + producto.getNombre()
                            + ". Disponible: " + producto.getStock());
        }
        producto.setStock(producto.getStock() - diferencia);
        productoRepo.save(producto);

        detalle.setCantidad(nuevaCantidad);
        detalle.setSubtotal(calcularSubtotal(detalle));
        DetallePedido guardado = detalleRepo.save(detalle);
        actualizarTotal(pedido);
        return guardado;
    }

    @Transactional
    public void quitar(Integer idPedido, Integer idProducto) {
        Pedido pedido = buscarPedido(idPedido);
        DetallePedido detalle = obtener(idPedido, idProducto);

        Producto producto = buscarProducto(idProducto);
        producto.setStock(producto.getStock() + detalle.getCantidad());
        productoRepo.save(producto);

        detalleRepo.delete(detalle);
        actualizarTotal(pedido);
    }


    private Pedido buscarPedido(Integer idPedido) {
        return pedidoRepo.findById(idPedido)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND,
                        "Pedido " + idPedido + " no encontrado"));
    }

    private Producto buscarProducto(Integer idProducto) {
        return productoRepo.findById(idProducto)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND,
                        "Producto " + idProducto + " no encontrado"));
    }

    private List<DetallePedido> detallesDelPedido(Integer idPedido) {
        List<DetallePedido> resultado = new ArrayList<>();
        for (DetallePedido d : detalleRepo.findAll()) {
            if (d.getPedido() != null && idPedido.equals(d.getPedido().getIdPedido())) {
                resultado.add(d);
            }
        }
        return resultado;
    }

    private DetallePedido buscarDetalle(Integer idPedido, Integer idProducto) {
        for (DetallePedido d : detallesDelPedido(idPedido)) {
            if (d.getProducto() != null && idProducto.equals(d.getProducto().getIdProducto())) {
                return d;
            }
        }
        return null;
    }

    private BigDecimal calcularSubtotal(DetallePedido detalle) {
        return detalle.getPrecioUnitario().multiply(BigDecimal.valueOf(detalle.getCantidad()));
    }

    private void actualizarTotal(Pedido pedido) {
        BigDecimal total = BigDecimal.ZERO;
        for (DetallePedido d : detallesDelPedido(pedido.getIdPedido())) {
            if (d.getSubtotal() != null) {
                total = total.add(d.getSubtotal());
            }
        }
        pedido.setTotal(total);
        pedidoRepo.save(pedido);
    }

    private void validarCantidad(int cantidad) {
        if (cantidad <= 0) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST,
                    "La cantidad debe ser mayor a 0");
        }
    }
}