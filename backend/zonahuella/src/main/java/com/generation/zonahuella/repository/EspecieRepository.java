package com.generation.zonahuella.repository;

import com.generation.zonahuella.model.Especie;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface EspecieRepository extends JpaRepository<Especie, Integer> {
    Optional<Especie> findByNombreIgnoreCase(String nombre);
}
