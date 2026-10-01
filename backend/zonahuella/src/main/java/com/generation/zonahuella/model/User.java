package com.generation.zonahuella.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;

import java.util.HashSet;
import java.util.Set;

@Entity
@Table (name = "Usuarios")

public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_usuario")
    private Integer idUsuario;

    @Column(name = "nombre", nullable = false, length = 100)
    private String nombre;

    @Column(name = "email", nullable = false, unique = true, length = 100)
    private String email;

    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @Column(name = "contrasenia", nullable = false, length = 255)
    private String contrasenia;

    @Column(name = "telefono", length = 20)
    private String telefono;

    @Enumerated(EnumType.STRING)
    @Column(name = "rol", nullable = false)
    private Rol rol = Rol.CLIENTE;

    public enum Rol {
        CLIENTE,
        ADMIN
    }

    @JsonIgnore
    @ManyToMany
    @JoinTable(
            name = "Favoritos",
            joinColumns = @JoinColumn(name = "id_usuario"),
            inverseJoinColumns = @JoinColumn(name = "id_producto")
    )
    private Set<Producto> favoritos = new HashSet<>();

    public User() {
    }

    public Set<Producto> getFavoritos() {
        return favoritos;
    }

    public void setFavoritos(Set<Producto> favoritos) {
        this.favoritos = favoritos;
    }

    public Integer getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(Integer idUsuario) {
        this.idUsuario = idUsuario;
    }

    public Rol getRol() {
        return rol;
    }

    public void setRol(Rol rol) {
        this.rol = rol;
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
                "telefono='" + telefono + '\'' +
                ", rol=" + rol +
                ", favoritos=" + favoritos +
                ", email='" + email + '\'' +
                ", nombre='" + nombre + '\'' +
                ", idUsuario=" + idUsuario +
                '}';
    }
}





