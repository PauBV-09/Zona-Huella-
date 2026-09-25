package com.generation.zonahuella.service;

import com.generation.zonahuella.exceptions.RecursoNoEncontradoExceptions;
import com.generation.zonahuella.model.Direccion;
import com.generation.zonahuella.repository.DireccionRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service

public class DireccionService {
    private final DireccionRepository repository;

    public DireccionService(DireccionRepository repository) {
        this.repository = repository;
    }

    public List<Direccion> listar() {
        return repository.findAll();
    }

    public Direccion buscarPorId(Long id) {
        return repository.findById(id)
                .orElseThrow(() -> new RecursoNoEncontradoExceptions("Direccion no encontrada: " + id));
    }

    public Direccion guardar(Direccion obj) {
        return repository.save(obj);
    }

    public Direccion actualizar(Long id, Direccion obj) {
        buscarPorId(id);
        obj.setId(id);
        return repository.save(obj);
    }

    public void eliminar(Long id) {
        Direccion existente = buscarPorId(id);
        repository.delete(existente);
    }
}
