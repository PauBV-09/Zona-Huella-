package com.generation.zonahuella.service;

import com.generation.zonahuella.exceptions.RecursoNoEncontradoExceptions;
import com.generation.zonahuella.model.Producto;
import com.generation.zonahuella.model.ProductoImagenes;
import com.generation.zonahuella.repository.ProductoImagenesRepository;
import com.generation.zonahuella.repository.ProductoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductoImagenesService {

    private final ProductoRepository productoRepository;
    private final ProductoImagenesRepository productoImagenesRepository;

    @Autowired
    public ProductoImagenesService(ProductoRepository productoRepository, ProductoImagenesRepository productoImagenesRepository) {
        this.productoRepository = productoRepository;
        this.productoImagenesRepository = productoImagenesRepository;
    }

    // 1. Metodo para visualizar las imagenes de los productos
    public List<ProductoImagenes> obtenerImagenes() {
        return productoImagenesRepository.findAll();
    }

    // 2. Metodo para crear una nueva imagen de producto
    public ProductoImagenes crearImagen(
            Integer idProducto,
            ProductoImagenes nuevaImagen) {

        Producto producto = productoRepository
                .findById(idProducto)
                .orElseThrow(() ->
                        new IllegalArgumentException(
                                "No existe el producto con ID: "
                                        + idProducto
                        )
                );

        nuevaImagen.setId(null);
        nuevaImagen.setProducto(producto);

        return productoImagenesRepository.save(nuevaImagen);
    }

    // 3. findById()
    public ProductoImagenes buscarPorId(Integer id) {

        return productoImagenesRepository.findById(id)
                .orElseThrow(() ->
                        new RecursoNoEncontradoExceptions(
                                "Imagen no encontrada con ID: " + id
                        )
                );
    }

    // 4. deleteImagen()
    public void eliminarImagen(Integer id) {

        ProductoImagenes imagen = buscarPorId(id);

        productoImagenesRepository.delete(imagen);
    }

    // 5. updateUser()
    public ProductoImagenes actualizarImagen(
            Integer id,
            ProductoImagenes datosImagen) {

        ProductoImagenes imagen =
                buscarPorId(id);

        imagen.setFuente(datosImagen.getFuente());
        imagen.setOrden(datosImagen.getOrden());

        return productoImagenesRepository.save(imagen);
    }
}
