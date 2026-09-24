package com.generation.zonahuella.service;

import com.generation.zonahuella.model.Producto;
import com.generation.zonahuella.repository.ProductoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductoService {
    private final ProductoRepository productoRepository;

    @Autowired
    public ProductoService(ProductoRepository productoRepository) {
        this.productoRepository = productoRepository;
    }

    public List<Producto> obtenerProductos(){
        return productoRepository.findAll();
    }




}
