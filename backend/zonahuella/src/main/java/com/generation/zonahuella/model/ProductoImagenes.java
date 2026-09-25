package com.generation.zonahuella.model;

import jakarta.persistence.*;

@Entity
@Table(name = "productoImagenes")
public class ProductoImagenes {
    @Id
    @GeneratedValue
    @Column(name = "id_imagen")
    private Long id;
    @Column(nullable = false)
    private String fuente;
    @Column(nullable = false)
    private Integer orden;

    @ManyToOne
    @JoinColumn(name = "id_producto")
    private Producto producto;

    public ProductoImagenes(Long id, String fuente, Integer orden) {
        this.id = id;
        this.fuente = fuente;
        this.orden = orden;
    }

    public ProductoImagenes() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
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

    @Override
    public String toString() {
        return "ProductoImagenes{" +
                "id=" + id +
                ", fuente='" + fuente + '\'' +
                ", order=" + orden +
                '}';
    }
}
