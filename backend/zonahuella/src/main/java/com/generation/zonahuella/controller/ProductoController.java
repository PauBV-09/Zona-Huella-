package com.generation.zonahuella.controller;

import com.generation.zonahuella.model.Producto;
import com.generation.zonahuella.service.ProductoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/productos")
public class ProductoController {

    private final ProductoService productoService;

    public ProductoController(ProductoService productoService) {
        this.productoService = productoService;
    }


    @GetMapping
    public ResponseEntity<List<Producto>> obtenerProductos() {
        return ResponseEntity.ok(productoService.obtenerProductos());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Producto> obtenerProductoPorId(
            @PathVariable Integer id) {

        return productoService.obtenerProductoPorId(id)
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Producto> crearProducto(
            @RequestBody Producto producto) {

        Producto productoCreado =
                productoService.crearProducto(producto);

        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(productoCreado);
    }


    @PutMapping("/{id}")
    public ResponseEntity<Producto> actualizarProducto(
            @PathVariable Integer id,
            @RequestBody Producto producto) {

        return productoService.actualizarProducto(id, producto)
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarProducto(
            @PathVariable Integer id) {

        if (productoService.eliminarProducto(id)) {
            return ResponseEntity.noContent().build();
        }

        return ResponseEntity.notFound().build();
    }


    // Buscar por nombre
    @GetMapping("/buscar/nombre")
    public ResponseEntity<List<Producto>> buscarPorNombre(
            @RequestParam String nombre) {

        return ResponseEntity.ok(
                productoService.buscarPorNombre(nombre)
        );
    }


    // Buscar por marca
    @GetMapping("/buscar/marca")
    public ResponseEntity<List<Producto>> buscarPorMarca(
            @RequestParam String marca) {

        return ResponseEntity.ok(
                productoService.buscarPorMarca(marca)
        );
    }


    // Obtener productos en oferta
    @GetMapping("/ofertas")
    public ResponseEntity<List<Producto>> obtenerProductosEnOferta() {

        return ResponseEntity.ok(
                productoService.obtenerProductosEnOferta()
        );
    }


    // Buscar por categoría
    @GetMapping("/categoria/{categoria}")
    public ResponseEntity<List<Producto>> buscarPorCategoria(
            @PathVariable String categoria) {

        return ResponseEntity.ok(
                productoService.buscarPorCategoria(categoria)
        );
    }


    // Buscar por especie
    @GetMapping("/especie/{especie}")
    public ResponseEntity<List<Producto>> buscarPorEspecie(
            @PathVariable String especie) {

        return ResponseEntity.ok(
                productoService.buscarPorEspecie(especie)
        );
    }


    // Buscar por tamaño
    @GetMapping("/tamanio/{tamanio}")
    public ResponseEntity<List<Producto>> buscarPorTamanio(
            @PathVariable String tamanio) {

        return ResponseEntity.ok(
                productoService.buscarPorTamanio(tamanio)
        );
    }


    // Buscar por etapa de vida
    @GetMapping("/etapa/{etapaVida}")
    public ResponseEntity<List<Producto>> buscarPorEtapaVida(
            @PathVariable String etapaVida) {

        return ResponseEntity.ok(
                productoService.buscarPorEtapaVida(etapaVida)
        );
    }

    //Filtos compuestos
    @GetMapping("/filtrar")
    public ResponseEntity<List<Producto>> filtrarProductos(
            @RequestParam(required = false) String categoria,
            @RequestParam(required = false) String especie,
            @RequestParam(required = false) String tamanio,
            @RequestParam(required = false) String etapaVida) {

        return ResponseEntity.ok(
                productoService.filtrarProductos(
                        categoria,
                        especie,
                        tamanio,
                        etapaVida
                )
        );
    }
}
