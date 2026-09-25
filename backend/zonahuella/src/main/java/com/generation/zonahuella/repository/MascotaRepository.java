package com.generation.zonahuella.repository;

import com.generation.zonahuella.model.Mascota;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MascotaRepository extends JpaRepository<Mascota, Integer> {

    List<Mascota> findByUsuarioIdUsuario(Integer idUsuario);

    List<Mascota> findByEspecieIdEspecie(Integer idEspecie);
}