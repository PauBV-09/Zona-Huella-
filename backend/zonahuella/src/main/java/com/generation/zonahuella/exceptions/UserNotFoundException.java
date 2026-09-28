package com.generation.zonahuella.exceptions;

public class UserNotFoundException extends RuntimeException {

    public UserNotFoundException(Long id) {
        super("Usuario no encontrado con id: " + id);
    }
}