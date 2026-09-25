package com.generation.zonahuella.controller;

import com.generation.zonahuella.model.Mascota;
import com.generation.zonahuella.service.MascotaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/mascotas")
@CrossOrigin(origins = "*")
public class MascotaController {

    @Autowired
    private MascotaService mascotaService;

    @GetMapping
    public List<Mascota> listar() {
        return mascotaService.listar();
    }

    @GetMapping("/{id}")
    public Optional<Mascota> obtener(@PathVariable Integer id) {
        return mascotaService.obtener(id);
    }

    @PostMapping
    public Mascota crear(@RequestBody Mascota mascota) {
        return mascotaService.crear(mascota);
    }

    @PutMapping("/{id}")
    public Mascota actualizar(@PathVariable Integer id, @RequestBody Mascota mascota) {
        return mascotaService.actualizar(id, mascota);
    }

    @DeleteMapping("/{id}")
    public void eliminar(@PathVariable Integer id) {
        mascotaService.eliminar(id);
    }
}