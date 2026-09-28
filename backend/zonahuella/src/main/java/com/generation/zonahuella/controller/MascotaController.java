package com.generation.zonahuella.controller;

import com.generation.zonahuella.dto.MascotaDTO;
import com.generation.zonahuella.model.Mascota;
import com.generation.zonahuella.service.MascotaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "*")
public class MascotaController {

    @Autowired
    private MascotaService mascotaService;

    @GetMapping("/mascotas")
    public List<Mascota> listar() {
        return mascotaService.listar();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Mascota> obtener(@PathVariable Integer id) {
        return mascotaService.obtener(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/usuario/{idUsuario}")
    public List<Mascota> listarPorUsuario(@PathVariable Integer idUsuario) {
        return mascotaService.listarPorUsuario(idUsuario);
    }

    @GetMapping("/especie/{idEspecie}")
    public List<Mascota> listarPorEspecie(@PathVariable Integer idEspecie) {
        return mascotaService.listarPorEspecie(idEspecie);
    }

    @PostMapping
    public ResponseEntity<Mascota> crear(@RequestBody MascotaDTO mascotaDTO) {
        Mascota nuevaMascota = mascotaService.crear(mascotaDTO);
        return new ResponseEntity<>(nuevaMascota, HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Mascota> actualizar(@PathVariable Integer id, @RequestBody MascotaDTO mascotaDTO) {
        Mascota mascotaActualizada = mascotaService.actualizar(id, mascotaDTO);
        return ResponseEntity.ok(mascotaActualizada);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Integer id) {
        mascotaService.eliminar(id);
        return ResponseEntity.noContent().build();
    }
}