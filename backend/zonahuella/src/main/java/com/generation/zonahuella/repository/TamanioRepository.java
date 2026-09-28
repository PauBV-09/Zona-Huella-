package com.generation.zonahuella.repository;

import com.generation.zonahuella.model.Tamanio;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface TamanioRepository extends JpaRepository<Tamanio, Integer> {
    Optional<Tamanio> findByNombreIgnoreCase(String nombre);
}