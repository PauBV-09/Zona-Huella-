package com.generation.zonahuella.controller;


import com.generation.zonahuella.exception.ProductoNotFoundExceptionnn;
import com.generation.zonahuella.model.ProductoImagenes;
import com.generation.zonahuella.service.ProductoImagenesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/imagenes")
public class ProductoImagenesController {

    private final ProductoImagenesService productoImagenesService;

    public ProductoImagenesController(
            ProductoImagenesService productoImagenesService) {

        this.productoImagenesService =
                productoImagenesService;
    }


    @GetMapping
    public ResponseEntity<List<ProductoImagenes>> obtenerImagenes() {

        return ResponseEntity.ok(
                productoImagenesService.obtenerImagenes()
        );
    }


    @GetMapping("/{id}")
    public ResponseEntity<ProductoImagenes> obtenerPorId(
            @PathVariable Integer id) {

        return ResponseEntity.ok(
                productoImagenesService.buscarPorId(id)
        );
    }


    @PostMapping
    public ResponseEntity<ProductoImagenes> crearImagen(
            @RequestParam Integer productoId,
            @RequestBody ProductoImagenes imagen) {

        ProductoImagenes creada =
                productoImagenesService.crearImagen(
                        productoId,
                        imagen
                );

        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(creada);
    }


    @PutMapping("/{id}")
    public ResponseEntity<ProductoImagenes> actualizarImagen(
            @PathVariable Integer id,
            @RequestBody ProductoImagenes imagen) {

        return ResponseEntity.ok(
                productoImagenesService
                        .actualizarImagen(id, imagen)
        );
    }


    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarImagen(
            @PathVariable Integer id) {

        productoImagenesService.eliminarImagen(id);

        return ResponseEntity.noContent().build();
    }
}
