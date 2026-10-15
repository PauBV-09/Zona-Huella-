package com.generation.zonahuella.dto;

public class DetallePedidoDTO {

    private Integer idProducto;
    private Integer cantidad;

    public DetallePedidoDTO() {
    }

    public DetallePedidoDTO(Integer idProducto, Integer cantidad) {
        this.idProducto = idProducto;
        this.cantidad = cantidad;
    }

    public Integer getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(Integer idProducto) {
        this.idProducto = idProducto;
    }

    public Integer getCantidad() {
        return cantidad;
    }

    public void setCantidad(Integer cantidad) {
        this.cantidad = cantidad;
    }
}
