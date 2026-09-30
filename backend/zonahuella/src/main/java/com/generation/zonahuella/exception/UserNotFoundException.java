package com.generation.zonahuella.exception;

public class UserNotFoundException extends RuntimeException {
    public UserNotFoundException(Integer id_usuario) {
        super("No se encuentra usuario con Id" + id_usuario);
    }
}
