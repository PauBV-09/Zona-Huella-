package com.generation.zonahuella.model;

import jakarta.persistence.*;

import java.math.BigDecimal;

@Entity
@Table(name = "productos")
public class Producto {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_producto")
    private Integer idProducto;

    @Column(name = "nombre", nullable = false, length = 150)
    private String nombre;

    @Column(name = "marca", nullable = false, length = 100)
    private String marca;

    @Column(name = "precio", nullable = false, precision = 10, scale = 2)
    private BigDecimal precio;

    @Column(name = "descripcion", columnDefinition = "TEXT")
    private String descripcion;

    @Column(name = "stock", nullable = false)
    private Integer stock;

    @Column(name = "descuento", precision = 5, scale = 2)
    private BigDecimal descuento;

    @Column(name = "en_oferta", nullable = false)
    private Boolean enOferta = false;

    public Producto() {
    }

    public Producto(Integer idProducto, String nombre, String marca, BigDecimal precio, String descripcion, Integer stock, BigDecimal descuento, Boolean enOferta) {
        this.idProducto = idProducto;
        this.nombre = nombre;
        this.marca = marca;
        this.precio = precio;
        this.descripcion = descripcion;
        this.stock = stock;
        this.descuento = descuento;
        this.enOferta = enOferta;
    }

    public Integer getIdProducto() {
        return idProducto;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public BigDecimal getPrecio() {
        return precio;
    }

    public void setPrecio(BigDecimal precio) {
        this.precio = precio;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Integer getStock() {
        return stock;
    }

    public void setStock(Integer stock) {
        this.stock = stock;
    }

    public BigDecimal getDescuento() {
        return descuento;
    }

    public void setDescuento(BigDecimal descuento) {
        this.descuento = descuento;
    }

    public Boolean getEnOferta() {
        return enOferta;
    }

    public void setEnOferta(Boolean enOferta) {
        this.enOferta = enOferta;
    }

    @Override
    public String toString() {
        return "Producto{" +
                "idProducto=" + idProducto +
                ", nombre='" + nombre + '\'' +
                ", marca='" + marca + '\'' +
                ", precio=" + precio +
                ", descripcion='" + descripcion + '\'' +
                ", stock=" + stock +
                ", descuento=" + descuento +
                ", enOferta=" + enOferta +
                '}';
    }
}
