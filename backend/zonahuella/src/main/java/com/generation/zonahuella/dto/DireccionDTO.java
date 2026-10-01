package com.generation.zonahuella.dto;

public class DireccionDTO {

    private Integer idUsuario;
    private String calle;
    private String numero;
    private String alcaldiaMunicipio;
    private String ciudad;
    private String estado;
    private String codigoPostal;
    private String referencias;

    public DireccionDTO() {
    }

    public DireccionDTO(
            Integer idUsuario,
            String calle,
            String numero,
            String alcaldiaMunicipio,
            String ciudad,
            String estado,
            String codigoPostal,
            String referencias) {

        this.idUsuario = idUsuario;
        this.calle = calle;
        this.numero = numero;
        this.alcaldiaMunicipio = alcaldiaMunicipio;
        this.ciudad = ciudad;
        this.estado = estado;
        this.codigoPostal = codigoPostal;
        this.referencias = referencias;
    }

    public Integer getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(Integer idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getCalle() {
        return calle;
    }

    public void setCalle(String calle) {
        this.calle = calle;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public String getAlcaldiaMunicipio() {
        return alcaldiaMunicipio;
    }

    public void setAlcaldiaMunicipio(String alcaldiaMunicipio) {
        this.alcaldiaMunicipio = alcaldiaMunicipio;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getCodigoPostal() {
        return codigoPostal;
    }

    public void setCodigoPostal(String codigoPostal) {
        this.codigoPostal = codigoPostal;
    }

    public String getReferencias() {
        return referencias;
    }

    public void setReferencias(String referencias) {
        this.referencias = referencias;
    }
}