package com.generation.zonahuella.model;


import jakarta.persistence.*;

@Entity
@Table(name = "Tamanios")
public class Tamanio {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_tamanio")
    private Integer idTamanio;

    @Column(nullable = false, unique = true, length = 30)
    private String nombre;

    public Integer getIdTamanio() { return idTamanio; }
    public void setIdTamanio(Integer idTamanio) { this.idTamanio = idTamanio; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
}





