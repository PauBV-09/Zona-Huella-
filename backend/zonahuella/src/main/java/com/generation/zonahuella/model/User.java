package com.generation.zonahuella.model;

import jakarta.persistence.*;

@Entity
@Table (name = "users")

public class User {
    @Id // Definir PK
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_user")
    private Long id;

    @Column(unique = true, nullable = false, length = 100)
    private String username;

    @Column(unique = true, nullable = false, length = 200)
    private String email;

    @Column(nullable = false, length = 50)
    private String contrasenia;

    @Column(nullable = false, length = 10)
    private String telefono;

    public User(Long id, String username, String email, String contrasenia, String telefono) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.contrasenia = contrasenia;
        this.telefono = telefono;
    }

    public User() {
    }

    public Long getId() {
        return id;
    }

    public User setId(Long id) {
        this.id = id;
        return this;
    }

    public String getUsername() {
        return username;
    }

    public User setUsername(String username) {
        this.username = username;
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
                "id=" + id +
                ", username='" + username + '\'' +
                ", email='" + email + '\'' +
                ", contrasenia='" + contrasenia + '\'' +
                ", telefono='" + telefono + '\'' +
                '}';
    }

}





