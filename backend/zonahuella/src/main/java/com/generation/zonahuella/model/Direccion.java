package com.generation.zonahuella.model;

import jakarta.persistence.*;

@Entity
@Table(name = "direcciones")
public class Direccion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_direccion")
    private Long id;

    @Column(name = "id_usuario", nullable = false)
    private Long id_usuario = 1L;

    @Column(name = "calle", nullable = false, length = 100)
    private String calle;

    @Column(name = "numero", nullable = false, length = 10)
    private String numero;

    @Column(name = "alcaldia_municipio", nullable = false, length = 100)
    private String alcaldia_municipio;

    @Column(name = "ciudad", nullable = false, length = 100)
    private String ciudad;

    @Column(name = "estado", nullable = false, length = 100)
    private String estado;

    @Column(name = "codigo_postal", nullable = false, length = 10)
    private String codigo_postal;

    @Column(name = "referencias",length = 250)
    private String referencias;

    public Direccion() {
    }

    public Direccion(String alcaldia_municipio, String calle, String ciudad, String codigo_postal, String numero, Long id, String estado, String referencias) {
        this.alcaldia_municipio = alcaldia_municipio;
        this.calle = calle;
        this.ciudad = ciudad;
        this.codigo_postal = codigo_postal;
        this.numero = numero;
        this.id = id;
        this.estado = estado;
        this.referencias = referencias;
    }

    public String getAlcaldia_municipio() {
        return alcaldia_municipio;
    }

    public void setAlcaldia_municipio(String alcaldia_municipio) {
        this.alcaldia_municipio = alcaldia_municipio;
    }

    public String getCalle() {
        return calle;
    }

    public void setCalle(String calle) {
        this.calle = calle;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public String getCodigo_postal() {
        return codigo_postal;
    }

    public void setCodigo_postal(String codigo_postal) {
        this.codigo_postal = codigo_postal;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public String getReferencias() {
        return referencias;
    }

    public void setReferencias(String referencias) {
        this.referencias = referencias;
    }
}
