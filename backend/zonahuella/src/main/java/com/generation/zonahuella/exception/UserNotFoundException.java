package com.generation.zonahuella.exception;

public class UserNotFoundException extends RuntimeException {
    public UserNotFoundException(Integer idUsuario) {
        super("No se encuentra usuario con ID: " + idUsuario);
    }
}
