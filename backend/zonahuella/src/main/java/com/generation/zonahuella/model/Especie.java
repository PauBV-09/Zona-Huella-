package com.generation.zonahuella.model;

import jakarta.persistence.*;

@Entity
@Table(name = "Especies")
public class Especie {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_especie")
    private Integer idEspecie;

    @Column(nullable = false, unique = true, length = 50)
    private String nombre;

    public Integer getIdEspecie() { return idEspecie; }
    public void setIdEspecie(Integer idEspecie) { this.idEspecie = idEspecie; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
}



