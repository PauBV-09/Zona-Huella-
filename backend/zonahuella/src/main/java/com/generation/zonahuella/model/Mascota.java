package com.generation.zonahuella.model;


import jakarta.persistence.*;

@Entity
@Table(name = "mascotas")

public class Mascota {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_mascota")
    private Integer idMascota;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_usuario", nullable = false)
    private Usuario usuario;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_especie", nullable = false)
    private Especie especie;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_tamanio")
    private Tamanio tamanio;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_etapa_vida")
    private EtapaVida etapaVida;

    @Column(nullable = false, length = 50)
    private String nombre;

    @Enumerated(EnumType.STRING)
    @Column(length = 10)
    private Sexo sexo;

    @Column(length = 255)
    private String foto;

    public enum Sexo { MACHO, HEMBRA }
    public Integer getIdMascota() {
        return idMascota;
    }

    public void setIdMascota(Integer idMascota) {
        this.idMascota = idMascota;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public Especie getEspecie() {
        return especie;
    }

    public void setEspecie(Especie especie) {
        this.especie = especie;
    }

    public Tamanio getTamanio() {
        return tamanio;
    }

    public void setTamanio(Tamanio tamanio) {
        this.tamanio = tamanio;
    }

    public EtapaVida getEtapaVida() {
        return etapaVida;
    }

    public void setEtapaVida(EtapaVida etapaVida) {
        this.etapaVida = etapaVida;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Sexo getSexo() {
        return sexo;
    }

    public void setSexo(Sexo sexo) {
        this.sexo = sexo;
    }

    public String getFoto() {
        return foto;
    }

    public void setFoto(String foto) {
        this.foto = foto;
    }
}