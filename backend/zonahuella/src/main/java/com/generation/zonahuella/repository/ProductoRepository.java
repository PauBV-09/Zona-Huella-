package com.generation.zonahuella.repository;

import com.generation.zonahuella.model.Producto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

public interface ProductoRepository extends JpaRepository<Producto, Integer>, JpaSpecificationExecutor<Producto> {
    //Buscar por nombre de producto
    List<Producto> findByNombreContainingIgnoreCase(String nombre);
    //Buscar por marca
    List<Producto> findByMarcaContainingIgnoreCase(String marca);
    //Buscar productos en oferta
    List<Producto> findByEnOfertaTrue();
    //Buscar por Categoria
    List<Producto> findDistinctByCategorias_NombreIgnoreCase(String categoria);
    //Buscar por especie
    List<Producto> findDistinctByEspecies_NombreIgnoreCase(String especie);
    //Buscar por tamanio
    List<Producto> findDistinctByTamanios_NombreIgnoreCase(String tamanio);
    //Buscar por Etapa de vida
    List<Producto> findDistinctByEtapasVida_NombreIgnoreCase(String etapaVida);



}
