package com.generation.zonahuella.controller;

import com.generation.zonahuella.dto.DireccionDTO;
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
    public Direccion buscarPorId(@PathVariable Integer id) {
        return service.buscarPorId(id);
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Direccion crear(@RequestBody DireccionDTO dto) {
        return service.guardar(dto);
    }

    @PutMapping("/{id}")
    public Direccion actualizar(
            @PathVariable Integer id,
            @RequestBody DireccionDTO dto) {

        return service.actualizar(id, dto);
    }

    @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void eliminar(@PathVariable Integer id){
        service.eliminar(id);
    }

    @GetMapping(params = "usuarioId")
    public List<Direccion> listarPorUsuario(
            @RequestParam Integer usuarioId) {

        return service.listarPorUsuario(usuarioId);
    }
}
