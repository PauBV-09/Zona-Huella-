package com.generation.zonahuella.dto;

import com.generation.zonahuella.model.Mascota.Sexo;

public class MascotaDTO {

    private String nombre;
    private Integer idUsuario;
    private Integer idEspecie;
    private Integer idEtapaVida;
    private Integer idTamanio;
    private Sexo sexo;
    private String foto;

    public MascotaDTO() {
    }

    public MascotaDTO(String nombre, Integer idUsuario, Integer idEspecie, Integer idEtapaVida, Integer idTamanio, Sexo sexo, String foto) {
        this.nombre = nombre;
        this.idUsuario = idUsuario;
        this.idEspecie = idEspecie;
        this.idEtapaVida = idEtapaVida;
        this.idTamanio = idTamanio;
        this.sexo = sexo;
        this.foto = foto;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Integer getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(Integer idUsuario) {
        this.idUsuario = idUsuario;
    }

    public Integer getIdEspecie() {
        return idEspecie;
    }

    public void setIdEspecie(Integer idEspecie) {
        this.idEspecie = idEspecie;
    }

    public Integer getIdEtapaVida() {
        return idEtapaVida;
    }

    public void setIdEtapaVida(Integer idEtapaVida) {
        this.idEtapaVida = idEtapaVida;
    }

    public Integer getIdTamanio() {
        return idTamanio;
    }

    public void setIdTamanio(Integer idTamanio) {
        this.idTamanio = idTamanio;
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