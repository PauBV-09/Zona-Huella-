package com.generation.zonahuella.repository;

import com.generation.zonahuella.model.Producto;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ProductoRepository extends JpaRepository<Producto, Integer> {
    List<Producto> findByNombreContainingIgnoreCase(String nombre);

    List<Producto> findByMarcaContainingIgnoreCase(String marca);

    List<Producto> findByEnOfertaTrue();
}
