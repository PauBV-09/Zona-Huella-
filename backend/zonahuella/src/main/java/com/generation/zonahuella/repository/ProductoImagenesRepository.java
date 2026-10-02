package com.generation.zonahuella.repository;

import com.generation.zonahuella.model.ProductoImagenes;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductoImagenesRepository extends JpaRepository<ProductoImagenes, Integer> {
    // Metodos abstractos -- JPQL (Java Persistence Query Language)
    // Permite crear metodos abstractos para realizar consultas
}
