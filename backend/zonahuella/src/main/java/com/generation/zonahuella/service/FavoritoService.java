package com.generation.zonahuella.service;

import com.generation.zonahuella.model.Favorito;
import com.generation.zonahuella.model.FavoritoId;
import com.generation.zonahuella.model.Producto;
import com.generation.zonahuella.model.Usuario;
import com.generation.zonahuella.repository.FavoritoRepository;
import com.generation.zonahuella.repository.ProductoRepository;
import com.generation.zonahuella.repository.UsuarioRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FavoritoService {

    private final FavoritoRepository favoritoRepository;
    private final ProductoRepository productoRepository;
    private final UsuarioRepository usuarioRepository;

    public FavoritoService(
            FavoritoRepository favoritoRepository,
            ProductoRepository productoRepository,
            UsuarioRepository usuarioRepository) {

        this.favoritoRepository = favoritoRepository;
        this.productoRepository = productoRepository;
        this.usuarioRepository = usuarioRepository;
    }

    public List<Favorito> obtenerFavoritosPorUsuario(Integer idUsuario) {
        return favoritoRepository.findByUsuario_IdUsuario(idUsuario);
    }


    public Favorito agregarFavorito(Integer idUsuario, Integer idProducto) {

        Usuario usuario = usuarioRepository.findById(idUsuario)
                .orElseThrow(() ->
                        new RuntimeException("Usuario no encontrado"));

        Producto producto = productoRepository.findById(idProducto)
                .orElseThrow(() ->
                        new RuntimeException("Producto no encontrado"));

        FavoritoId id = new FavoritoId(idUsuario, idProducto);

        if (favoritoRepository.existsById(id)) {
            throw new RuntimeException(
                    "El producto ya está en favoritos"
            );
        }

        Favorito favorito = new Favorito(usuario, producto);

        return favoritoRepository.save(favorito);
    }

    public void eliminarFavorito(
            Integer idUsuario,
            Integer idProducto) {

        FavoritoId id = new FavoritoId(idUsuario, idProducto);

        if (!favoritoRepository.existsById(id)) {
            throw new RuntimeException(
                    "El favorito no existe"
            );
        }

        favoritoRepository.deleteById(id);
    }
}