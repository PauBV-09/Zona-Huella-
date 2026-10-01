package com.generation.zonahuella.controller;

import com.generation.zonahuella.model.Mascota;
import com.generation.zonahuella.service.MascotaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.generation.zonahuella.dto.MascotaDTO;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/mascotas")
@CrossOrigin(origins = "*")
public class MascotaController {

    @Autowired
    private MascotaService mascotaService;

    @GetMapping("/catalogos")
    public java.util.Map<String, Object> catalogos() {
        return mascotaService.catalogos();
    }

    @GetMapping
    public List<Mascota> listar() {
        return mascotaService.listar();
    }

    @GetMapping("/{id}")
    public Optional<Mascota> obtener(@PathVariable Integer id) {
        return mascotaService.obtener(id);
    }

    @PostMapping
    public Mascota crear(@RequestBody MascotaDTO dto) {
        return mascotaService.crear(dto);
    }

    @PutMapping("/{id}")
    public Mascota actualizar(
            @PathVariable Integer id,
            @RequestBody MascotaDTO dto) {

        return mascotaService.actualizar(id, dto);
    }

    @DeleteMapping("/{id}")
    public void eliminar(@PathVariable Integer id) {
        mascotaService.eliminar(id);
    }

    @GetMapping(params = "usuarioId")
    public List<Mascota> listarPorUsuario(
            @RequestParam Integer usuarioId) {

        return mascotaService.listarPorUsuario(usuarioId);
    }

    @GetMapping(params = "especieId")
    public List<Mascota> listarPorEspecie(
            @RequestParam Integer especieId) {

        return mascotaService.listarPorEspecie(especieId);
    }

    @GetMapping(params = "etapaVidaId")
    public List<Mascota> listarPorEtapaVida(
            @RequestParam Integer etapaVidaId) {

        return mascotaService.listarPorEtapaVida(etapaVidaId);
    }

    @GetMapping(params = "tamanioId")
    public List<Mascota> listarPorTamanio(
            @RequestParam Integer tamanioId) {

        return mascotaService.listarPorTamanio(tamanioId);
    }


}