package com.generation.zonahuella.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;

@Entity
@Table(name = "ProductoImagenes")
public class ProductoImagenes {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_imagen")
    private Integer id;

    @Column(name = "fuente", nullable = false)
    private String fuente;

    @Column(name = "orden", nullable = false)
    private Integer orden;

    @JsonBackReference
    @ManyToOne
    @JoinColumn(name = "id_producto", nullable = false)
    private Producto producto;

    public ProductoImagenes() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFuente() {
        return fuente;
    }

    public void setFuente(String fuente) {
        this.fuente = fuente;
    }

    public Integer getOrden() {
        return orden;
    }

    public void setOrden(Integer orden) {
        this.orden = orden;
    }

    public Producto getProducto() {
        return producto;
    }

    public void setProducto(Producto producto) {
        this.producto = producto;
    }
}