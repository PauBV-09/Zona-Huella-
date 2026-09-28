package com.generation.zonahuella.repository;

import com.generation.zonahuella.model.Favorito;
import com.generation.zonahuella.model.FavoritoId;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface FavoritoRepository extends JpaRepository<Favorito, FavoritoId> {

    List<Favorito> findByUsuario_IdUsuario(Integer idUsuario);

}