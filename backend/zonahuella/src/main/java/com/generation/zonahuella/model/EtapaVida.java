package com.generation.zonahuella.model;

import jakarta.persistence.*;

@Entity
@Table(name = "Etapa_Vida")
public class EtapaVida {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_etapa_vida")
    private Integer idEtapaVida;

    @Column(nullable = false, unique = true, length = 30)
    private String nombre;

    public Integer getIdEtapaVida() { return idEtapaVida; }
    public void setIdEtapaVida(Integer idEtapaVida) { this.idEtapaVida = idEtapaVida; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
}


