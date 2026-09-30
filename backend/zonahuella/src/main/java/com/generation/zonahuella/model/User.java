package com.generation.zonahuella.model;

import jakarta.persistence.*;

@Entity
@Table (name = "usuarios")

public class User {

    @Id // Definir PK
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_usuario")
    private Integer id_usuario;

    @Column(unique = true, nullable = false, length = 100)
    private String nombre;

    @Column(unique = true, nullable = false, length = 200)
    private String email;

    @Column(nullable = false, length = 60)
    private String contrasenia;

    @Column(nullable = false, length = 10)
    private String telefono;

    public User(Integer id_usuario, String nombre, String email, String contrasenia, String telefono) {
        this.id_usuario = id_usuario;
        this.nombre = nombre;
        this.email = email;
        this.contrasenia = contrasenia;
        this.telefono = telefono;
    }

    public User() {
    }

    public Integer getId_usuario() {
        return id_usuario;
    }

    public User setId_usuario(Integer id_usuario) {
        this.id_usuario = id_usuario;
        return this;
    }

    public String getNombre() {
        return nombre;
    }

    public User setNombre(String nombre) {
        this.nombre = nombre;
        return this;
    }

    public String getEmail() {
        return email;
    }

    public User setEmail(String email) {
        this.email = email;
        return this;
    }

    public String getContrasenia() {
        return contrasenia;
    }

    public User setContrasenia(String contrasenia) {
        this.contrasenia = contrasenia;
        return this;
    }

    public String getTelefono() {
        return telefono;
    }

    public User setTelefono(String telefono) {
        this.telefono = telefono;
        return this;
    }

    @Override
    public String toString() {
        return "User{" +
                "id_usuario=" + id_usuario +
                ", nombre='" + nombre + '\'' +
                ", email='" + email + '\'' +
                ", contrasenia='" + contrasenia + '\'' +
                ", telefono='" + telefono + '\'' +
                '}';
    }
}





