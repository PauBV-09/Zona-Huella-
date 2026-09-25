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
@RequestMapping("/api/v1")
public class ProductoImagenesController {
    private final ProductoImagenesService productoImagenesService;

    @Autowired
    public ProductoImagenesController(ProductoImagenesService productoImagenesService){
        this.productoImagenesService = productoImagenesService;
    }

    // Mappear getImagenesService()
    @GetMapping("/")
    public List<ProductoImagenes> getImagenesService() {
        return productoImagenesService.getImagenes();
    }

    // Mapear addImagen() -- ResponseEntity para manejar codigos de estado de peticion
    @PostMapping("imagen")
    public ResponseEntity<ProductoImagenes> addImagen(@RequestBody ProductoImagenes newImagen){
        // Validar si el usuario existe mediante id
        ProductoImagenes imagenById = productoImagenesService.findById(newImagen.getId());
        // Si un usuario existe te lanza un estado
        if (imagenById != null){
            return new ResponseEntity<>(HttpStatus.CONFLICT);
        } else {
            // Si no existe crearlo y mostrar codigo de estado 201 (CREATED)
            return ResponseEntity.status(HttpStatus.CREATED)
                    .body(productoImagenesService.addUser(newImagen));
        }
    }

    // Mapear findById() -- ResponseEntity para manejar codigos de estado de peticion
    @GetMapping("/imagen/{id}")
    public ResponseEntity<ProductoImagenes> findById(@PathVariable Long id){
        // 200 o 404
        try {
            return ResponseEntity.ok(productoImagenesService.findById(id));
        } catch (ProductoNotFoundExceptionnn e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    // Mapear deleteById
    @DeleteMapping("/adios-imagen/{id}")
    public ResponseEntity<?> deleteById(@PathVariable Long id){
        try {
            // 204
            productoImagenesService.deleteById(id);
            return ResponseEntity.noContent().build();
        } catch (ProductoNotFoundExceptionnn e) { //404
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    // Mapear updateById
    @PutMapping("/update-imagen/{id}")
    public ResponseEntity<?> updateById(@RequestBody ProductoImagenes imagen, @PathVariable Long id){
        try {
            // 204
            productoImagenesService.updateById(imagen, id);
            return ResponseEntity.noContent().build();
        } catch (ProductoNotFoundExceptionnn e) { //404
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}
