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
import java.util.List;

@Service
public class DetallePedidoService {

    private final DetallePedidoRepository detalleRepository;
    private final PedidoRepository pedidoRepository;
    private final ProductoRepository productoRepository;

    public DetallePedidoService(DetallePedidoRepository detalleRepository,
                                PedidoRepository pedidoRepository,
                                ProductoRepository productoRepository) {
        this.detalleRepository = detalleRepository;
        this.pedidoRepository = pedidoRepository;
        this.productoRepository = productoRepository;
    }

    @Transactional(readOnly = true)
    public List<DetallePedido> listar(Integer idPedido) {
        Pedido pedido = buscarPedido(idPedido);
        return detalleRepository.findByPedido(pedido);
    }

    @Transactional(readOnly = true)
    public DetallePedido obtener(Integer idPedido, Integer idProducto) {
        Pedido pedido = buscarPedido(idPedido);
        Producto producto = buscarProducto(idProducto);
        return buscarDetalle(pedido, producto);
    }

    @Transactional
    public DetallePedido agregar(Integer idPedido, Integer idProducto, Integer cantidad) {
        validarCantidad(cantidad);
        Pedido pedido = buscarPedido(idPedido);
        Producto producto = buscarProducto(idProducto);

        if (detalleRepository.findByPedidoAndProducto(pedido, producto).isPresent()) {
            throw new ResponseStatusException(HttpStatus.CONFLICT,
                    "El producto " + idProducto + " ya está en el pedido " + idPedido
                            + "; usa PUT para cambiar la cantidad");
        }

        DetallePedido detalle = new DetallePedido();
        detalle.setPedido(pedido);
        detalle.setProducto(producto);
        detalle.setCantidad(cantidad);
        // El precio se congela al momento de agregar el producto al pedido
        detalle.setPrecioUnitario(producto.getPrecio());
        detalle.setSubtotal(calcularSubtotal(detalle.getPrecioUnitario(), cantidad));

        DetallePedido guardado = detalleRepository.save(detalle);
        recalcularTotal(pedido);
        return guardado;
    }

    @Transactional
    public DetallePedido cambiarCantidad(Integer idPedido, Integer idProducto, Integer cantidad) {
        validarCantidad(cantidad);
        DetallePedido detalle = obtener(idPedido, idProducto);

        detalle.setCantidad(cantidad);
        detalle.setSubtotal(calcularSubtotal(detalle.getPrecioUnitario(), cantidad));

        DetallePedido guardado = detalleRepository.save(detalle);
        recalcularTotal(detalle.getPedido());
        return guardado;
    }

    @Transactional
    public void quitar(Integer idPedido, Integer idProducto) {
        DetallePedido detalle = obtener(idPedido, idProducto);
        Pedido pedido = detalle.getPedido();

        // Se quita también de la lista del pedido para que el cascade ALL no lo vuelva a guardar
        if (pedido.getDetalles() != null) {
            pedido.getDetalles().remove(detalle);
        }
        detalleRepository.delete(detalle);
        recalcularTotal(pedido);
    }

    // ---------- Métodos auxiliares ----------

    private Pedido buscarPedido(Integer idPedido) {
        return pedidoRepository.findById(idPedido)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND,
                        "No existe el pedido " + idPedido));
    }

    private Producto buscarProducto(Integer idProducto) {
        return productoRepository.findById(idProducto)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND,
                        "No existe el producto " + idProducto));
    }

    private DetallePedido buscarDetalle(Pedido pedido, Producto producto) {
        return detalleRepository.findByPedidoAndProducto(pedido, producto)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND,
                        "El producto no está en este pedido"));
    }

    private void recalcularTotal(Pedido pedido) {
        detalleRepository.flush();
        BigDecimal total = detalleRepository.findByPedido(pedido).stream()
                .map(DetallePedido::getSubtotal)
                .filter(subtotal -> subtotal != null)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        pedido.setTotal(total);
        pedidoRepository.save(pedido);
    }

    private void validarCantidad(Integer cantidad) {
        if (cantidad == null || cantidad <= 0) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST,
                    "La cantidad debe ser mayor a 0");
        }
    }

    private BigDecimal calcularSubtotal(BigDecimal precioUnitario, Integer cantidad) {
        if (precioUnitario == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST,
                    "El producto no tiene precio asignado");
        }
        return precioUnitario.multiply(BigDecimal.valueOf(cantidad));
    }
}