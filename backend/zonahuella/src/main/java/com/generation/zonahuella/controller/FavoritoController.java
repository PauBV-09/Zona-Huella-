package com.generation.zonahuella.controller;

import com.generation.zonahuella.model.Favorito;
import com.generation.zonahuella.service.FavoritoService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/favoritos")
@CrossOrigin(origins = "*")
public class FavoritoController {

    private final FavoritoService favoritoService;

    public FavoritoController(FavoritoService favoritoService) {
        this.favoritoService = favoritoService;
    }

    @GetMapping("/usuario/{idUsuario}")
    public List<Favorito> obtenerFavoritos(
            @PathVariable Integer idUsuario) {

        return favoritoService.obtenerFavoritosPorUsuario(idUsuario);
    }

    @PostMapping("/usuario/{idUsuario}/producto/{idProducto}")
    public Favorito agregarFavorito(
            @PathVariable Integer idUsuario,
            @PathVariable Integer idProducto) {

        return favoritoService.agregarFavorito(idUsuario, idProducto);
    }

    @DeleteMapping("/usuario/{idUsuario}/producto/{idProducto}")
    public void eliminarFavorito(
            @PathVariable Integer idUsuario,
            @PathVariable Integer idProducto) {

        favoritoService.eliminarFavorito(idUsuario, idProducto);
    }
}