package com.generation.zonahuella.dto;

import java.util.List;

public class PedidoDTO {
    private Integer idUsuario;
    private Integer idDireccion;
    private String metodoPago;
    private String notas;
    private List<DetallePedidoDTO> detalles;

    public PedidoDTO() {
    }

    public PedidoDTO(Integer idUsuario, Integer idDireccion, String metodoPago, String notas, List<DetallePedidoDTO> detalles) {
        this.idUsuario = idUsuario;
        this.idDireccion = idDireccion;
        this.metodoPago = metodoPago;
        this.notas = notas;
        this.detalles = detalles;
    }

    public Integer getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(Integer idUsuario) {
        this.idUsuario = idUsuario;
    }

    public Integer getIdDireccion() {
        return idDireccion;
    }

    public void setIdDireccion(Integer idDireccion) {
        this.idDireccion = idDireccion;
    }

    public String getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(String metodoPago) {
        this.metodoPago = metodoPago;
    }

    public String getNotas() {
        return notas;
    }

    public void setNotas(String notas) {
        this.notas = notas;
    }

    public List<DetallePedidoDTO> getDetalles() {
        return detalles;
    }

    public void setDetalles(List<DetallePedidoDTO> detalles) {
        this.detalles = detalles;
    }
}
