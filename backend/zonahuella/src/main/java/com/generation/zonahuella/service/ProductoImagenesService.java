package com.generation.zonahuella.service;

import com.generation.zonahuella.exception.ProductoNotFoundExceptionnn;
import com.generation.zonahuella.model.ProductoImagenes;
import com.generation.zonahuella.repository.ProductoImagenesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductoImagenesService {
    private final ProductoImagenesRepository productoImagenesRepository;

    @Autowired
    public ProductoImagenesService(ProductoImagenesRepository productoImagenesRepository){
        this.productoImagenesRepository = productoImagenesRepository;
    }

    // 1. Metodo para visualizar las imagenes de los productos
    public List<ProductoImagenes> getImagenes(){
        return productoImagenesRepository.findAll();
    }

    // 2. Metodo para crear una nueva imagen de producto
    public ProductoImagenes addUser(ProductoImagenes newImagen) {
        return productoImagenesRepository.save(newImagen);
    }

    // 3. findById()
    public ProductoImagenes findById(Long id){
        return productoImagenesRepository.findById(id).orElseThrow(() -> new ProductoNotFoundExceptionnn(id));
    }

    // 4. deleteImagen()
    public void deleteById(Long id){
        if(productoImagenesRepository.existsById(id)){
            productoImagenesRepository.deleteById(id);
        } else {
            throw new ProductoNotFoundExceptionnn(id);
        }
    }

    // 5. updateUser()
    public ProductoImagenes updateById(ProductoImagenes productoImagenes, Long id){
        return productoImagenesRepository.findById(id)
                .map(data -> {
                    data.setFuente(productoImagenes.getFuente());
                    data.setOrden(productoImagenes.getOrden());
                    return productoImagenesRepository.save(data);
                })
                .orElseThrow(() -> new ProductoNotFoundExceptionnn(id));
    }
}
