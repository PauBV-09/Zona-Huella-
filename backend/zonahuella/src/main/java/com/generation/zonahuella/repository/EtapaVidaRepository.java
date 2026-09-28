package com.generation.zonahuella.repository;

import com.generation.zonahuella.model.EtapaVida;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface EtapaVidaRepository extends JpaRepository<EtapaVida, Integer> {
    Optional<EtapaVida> findByNombreIgnoreCase(String nombre);
}