package com.generation.zonahuella.exception;

public class ProductoNotFoundExceptionnn extends RuntimeException {
    public ProductoNotFoundExceptionnn(Long id) {
        super("Not found Product with the ID: " + id);
    }
}
