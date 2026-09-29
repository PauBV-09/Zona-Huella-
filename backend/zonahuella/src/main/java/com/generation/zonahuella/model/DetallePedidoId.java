package com.generation.zonahuella.model;

import java.io.Serializable;
import java.util.Objects;

public class DetallePedidoId implements Serializable {
    private Integer pedido;
    private Integer producto;

    public DetallePedidoId() {}

    public Integer getPedido() { return pedido; }
    public void setPedido(Integer pedido) { this.pedido = pedido; }
    public Integer getProducto() { return producto; }
    public void setProducto(Integer producto) { this.producto = producto; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        DetallePedidoId that = (DetallePedidoId) o;
        return Objects.equals(pedido, that.pedido) && Objects.equals(producto, that.producto);
    }

    @Override
    public int hashCode() {
        return Objects.hash(pedido, producto);
    }
}