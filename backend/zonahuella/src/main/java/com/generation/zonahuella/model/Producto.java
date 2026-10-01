package com.generation.zonahuella.model;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "Productos")
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
    private boolean enOferta = false;

    // Reseña del producto (columna "resenas" de la tabla Productos)
    @Column(name = "resenas", length = 500)
    private String resenas;

    // Calificación de 0 a 5 (columna "estrellas", admite medias: 4.5)
    @Column(name = "estrellas", precision = 2, scale = 1)
    private BigDecimal estrellas;

    @ManyToMany
    @JoinTable(
            name = "ProductoCategoria",
            joinColumns = @JoinColumn(name = "id_producto"),
            inverseJoinColumns = @JoinColumn(name = "id_categoria")
    )
    private Set<Categoria> categorias = new HashSet<>();

    @ManyToMany
    @JoinTable(
            name = "ProductoEspecie",
            joinColumns = @JoinColumn(name = "id_producto"),
            inverseJoinColumns = @JoinColumn(name = "id_especie")
    )
    private Set<Especie> especies = new HashSet<>();

    @ManyToMany
    @JoinTable(
            name = "ProductoTamanioMascota",
            joinColumns = @JoinColumn(name = "id_producto"),
            inverseJoinColumns = @JoinColumn(name = "id_tamanio")
    )
    private Set<Tamanio> tamanios = new HashSet<>();

    @ManyToMany
    @JoinTable(
            name = "ProductoEtapaVida",
            joinColumns = @JoinColumn(name = "id_producto"),
            inverseJoinColumns = @JoinColumn(name = "id_etapa_vida")
    )
    private Set<EtapaVida> etapasVida = new HashSet<>();

    @JsonManagedReference
    @OneToMany(
            mappedBy = "producto",
            cascade = CascadeType.ALL,
            orphanRemoval = true
    )
    @OrderBy("orden ASC")
    private List<ProductoImagenes> imagenes = new ArrayList<>();

    public Producto() {
    }

    public Producto(Integer idProducto, String nombre, String marca, BigDecimal precio, String descripcion, Integer stock, BigDecimal descuento, boolean enOferta) {
        this.idProducto = idProducto;
        this.nombre = nombre;
        this.marca = marca;
        this.precio = precio;
        this.descripcion = descripcion;
        this.stock = stock;
        this.descuento = descuento;
        this.enOferta = enOferta;
    }

    public Producto(Integer idProducto, String nombre, String marca, BigDecimal precio, String descripcion, Integer stock, BigDecimal descuento, boolean enOferta, Set<Categoria> categorias, Set<Especie> especies, Set<Tamanio> tamanios, Set<EtapaVida> etapasVida, List<ProductoImagenes> imagenes) {
        this.idProducto = idProducto;
        this.nombre = nombre;
        this.marca = marca;
        this.precio = precio;
        this.descripcion = descripcion;
        this.stock = stock;
        this.descuento = descuento;
        this.enOferta = enOferta;
        this.categorias = categorias;
        this.especies = especies;
        this.tamanios = tamanios;
        this.etapasVida = etapasVida;
        this.imagenes = imagenes;
    }

    public List<ProductoImagenes> getImagenes() {
        return imagenes;
    }

    public void setImagenes(List<ProductoImagenes> imagenes) {
        this.imagenes = imagenes;
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


    public void setIdProducto(Integer idProducto) {
        this.idProducto = idProducto;
    }

    public boolean isEnOferta() {
        return enOferta;
    }

    public void setEnOferta(boolean enOferta) {
        this.enOferta = enOferta;
    }

    public String getResenas() {
        return resenas;
    }

    public void setResenas(String resenas) {
        this.resenas = resenas;
    }

    public BigDecimal getEstrellas() {
        return estrellas;
    }

    public void setEstrellas(BigDecimal estrellas) {
        this.estrellas = estrellas;
    }

    public Set<Categoria> getCategorias() {
        return categorias;
    }

    public void setCategorias(Set<Categoria> categorias) {
        this.categorias = categorias;
    }

    public Set<Especie> getEspecies() {
        return especies;
    }

    public void setEspecies(Set<Especie> especies) {
        this.especies = especies;
    }

    public Set<Tamanio> getTamanios() {
        return tamanios;
    }

    public void setTamanios(Set<Tamanio> tamanios) {
        this.tamanios = tamanios;
    }

    public Set<EtapaVida> getEtapasVida() {
        return etapasVida;
    }

    public void setEtapasVida(Set<EtapaVida> etapasVida) {
        this.etapasVida = etapasVida;
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
                ", resenas='" + resenas + '\'' +
                ", estrellas=" + estrellas +
                ", categorias=" + categorias +
                ", especies=" + especies +
                ", tamanios=" + tamanios +
                ", etapasVida=" + etapasVida +
                '}';
    }
}