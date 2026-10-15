package com.generation.zonahuella.controller;

import com.generation.zonahuella.model.Producto;
import com.generation.zonahuella.service.FavoritoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Set;

@RestController
@RequestMapping("/api/favoritos")
public class FavoritoController {
    private final FavoritoService favoritoService;

    @Autowired
    public FavoritoController(FavoritoService favoritoService) {
        this.favoritoService = favoritoService;
    }

    //Obtener lista de favoritos
    @GetMapping
    public ResponseEntity<Set<Producto>> obtenerFavoritos(
            @RequestParam Integer usuarioId) {

        return ResponseEntity.ok(
                favoritoService.obtenerFavoritos(usuarioId)
        );
    }
    //Agregar Favorito a lista de productos
    @PostMapping
    public ResponseEntity<Producto> agregarFavorito(
            @RequestParam Integer usuarioId,
            @RequestParam Integer productoId) {

        Producto producto = favoritoService
                .agregarFavorito(usuarioId, productoId);

        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(producto);
    }

    //Eliminar producto de las lista de favoritos
    @DeleteMapping
    public ResponseEntity<Void> eliminarFavorito(
            @RequestParam Integer usuarioId,
            @RequestParam Integer productoId) {

        favoritoService.eliminarFavorito(
                usuarioId,
                productoId
        );

        return ResponseEntity.noContent().build();
    }

    //Verificar si el producto ya está en favoritos
    @GetMapping("/verificar")
    public ResponseEntity<Boolean> esFavorito(
            @RequestParam Integer usuarioId,
            @RequestParam Integer productoId) {

        return ResponseEntity.ok(
                favoritoService.esFavorito(
                        usuarioId,
                        productoId
                )
        );
    }
}
