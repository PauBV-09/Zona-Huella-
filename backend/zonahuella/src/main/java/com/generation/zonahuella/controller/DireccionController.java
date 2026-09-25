package com.generation.zonahuella.controller;

import com.generation.zonahuella.model.Direccion;
import com.generation.zonahuella.service.DireccionService;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/direcciones")
public class DireccionController {

    private final DireccionService service;

    public DireccionController(DireccionService service){
        this.service = service;
    }

    @GetMapping
    public List<Direccion> listar() {
        return service.listar();
    }
    @GetMapping("/{id}")
    public Direccion buscarPorId(@PathVariable Long id) {
        return service.buscarPorId(id);
    }

    @PostMapping("/crear_direccion")
    @ResponseStatus(HttpStatus.CREATED)
    public Direccion crear(@RequestBody Direccion obj) {
        return service.guardar(obj);
    }

    @PutMapping("/{id}")
    public Direccion actualizar(@PathVariable Long id, @RequestBody Direccion obj) {
        return service.actualizar(id, obj);
    }

    @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void eliminar(@PathVariable Long id){
        service.eliminar(id);
    }
}
