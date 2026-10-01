package com.generation.zonahuella.service;

import com.generation.zonahuella.exception.UserNotFoundException;
import com.generation.zonahuella.exceptions.RecursoNoEncontradoExceptions;
import com.generation.zonahuella.model.Producto;
import com.generation.zonahuella.model.User;
import com.generation.zonahuella.repository.ProductoRepository;
import com.generation.zonahuella.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.Set;

@Service
public class FavoritoService {

    private final UserRepository userRepository;
    private final ProductoRepository productoRepository;

    @Autowired
    public FavoritoService(
            UserRepository userRepository,
            ProductoRepository productoRepository) {

        this.userRepository = userRepository;
        this.productoRepository = productoRepository;
    }

    //Obtener lista de productos favoritos segun el Id del usuario
    @Transactional(readOnly = true)
    public Set<Producto> obtenerFavoritos(Integer idUsuario) {

        User usuario = userRepository.findById(idUsuario)
                .orElseThrow(() ->
                        new UserNotFoundException(idUsuario)
                );

        return new HashSet<>(usuario.getFavoritos());
    }

    //Agragar favorito segun el id del usuario e id del producto
    @Transactional
    public Producto agregarFavorito(
            Integer idUsuario,
            Integer idProducto) {

        User usuario = userRepository.findById(idUsuario)
                .orElseThrow(() ->
                        new UserNotFoundException(idUsuario)
                );

        Producto producto = productoRepository.findById(idProducto)
                .orElseThrow(() ->
                        new RecursoNoEncontradoExceptions(
                                "Producto no encontrado con ID: " + idProducto
                        )
                );

        boolean yaExiste = usuario.getFavoritos()
                .stream()
                .anyMatch(favorito ->
                        favorito.getIdProducto().equals(idProducto)
                );

        if (yaExiste) {
            throw new IllegalArgumentException(
                    "El producto ya está en favoritos"
            );
        }

        usuario.getFavoritos().add(producto);

        userRepository.save(usuario);

        return producto;
    }

    //Eliminar producto de lista de favoritos usando id del usuario e id del producto
    @Transactional
    public void eliminarFavorito(
            Integer idUsuario,
            Integer idProducto) {

        User usuario = userRepository.findById(idUsuario)
                .orElseThrow(() ->
                        new UserNotFoundException(idUsuario)
                );

        Producto producto = productoRepository.findById(idProducto)
                .orElseThrow(() ->
                        new RecursoNoEncontradoExceptions(
                                "Producto no encontrado con ID: " + idProducto
                        )
                );

        boolean eliminado = usuario.getFavoritos()
                .removeIf(favorito ->
                        favorito.getIdProducto().equals(idProducto)
                );

        if (!eliminado) {
            throw new IllegalArgumentException(
                    "El producto no se encuentra en favoritos"
            );
        }

        userRepository.save(usuario);
    }

    //Saber si el producto es Favorito
    @Transactional(readOnly = true)
    public boolean esFavorito(
            Integer idUsuario,
            Integer idProducto) {

        User usuario = userRepository.findById(idUsuario)
                .orElseThrow(() ->
                        new UserNotFoundException(idUsuario)
                );

        if (!productoRepository.existsById(idProducto)) {
            throw new RecursoNoEncontradoExceptions(
                    "Producto no encontrado con ID: " + idProducto
            );
        }

        return usuario.getFavoritos()
                .stream()
                .anyMatch(producto ->
                        producto.getIdProducto().equals(idProducto)
                );
    }
}
