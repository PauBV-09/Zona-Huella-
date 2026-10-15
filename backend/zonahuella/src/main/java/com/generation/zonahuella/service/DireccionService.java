package com.generation.zonahuella.service;

import com.generation.zonahuella.dto.DireccionDTO;
import com.generation.zonahuella.exception.UserNotFoundException;
import com.generation.zonahuella.exceptions.RecursoNoEncontradoExceptions;
import com.generation.zonahuella.model.Direccion;
import com.generation.zonahuella.model.User;
import com.generation.zonahuella.repository.DireccionRepository;
import com.generation.zonahuella.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service

public class DireccionService {
    private final DireccionRepository direccionRepository;
    private final UserRepository userRepository;

    @Autowired
    public DireccionService(DireccionRepository direccionRepository, UserRepository userRepository) {
        this.direccionRepository = direccionRepository;
        this.userRepository = userRepository;
    }

    public List<Direccion> listar() {
        return direccionRepository.findAll();
    }

    public Direccion buscarPorId(Integer id) {
        return direccionRepository.findById(id)
                .orElseThrow(() -> new RecursoNoEncontradoExceptions("Direccion no encontrada: " + id));
    }

    public List<Direccion> listarPorUsuario(Integer idUsuario) {

        if (!userRepository.existsById(idUsuario)) {
            throw new UserNotFoundException(idUsuario);
        }

        return direccionRepository.findByUsuarioIdUsuario(idUsuario);
    }

    public Direccion guardar(DireccionDTO dto) {

        User usuario = userRepository.findById(dto.getIdUsuario())
                .orElseThrow(() ->
                        new UserNotFoundException(dto.getIdUsuario())
                );

        Direccion direccion = new Direccion();

        direccion.setUsuario(usuario);
        direccion.setCalle(dto.getCalle());
        direccion.setNumero(dto.getNumero());
        direccion.setAlcaldiaMunicipio(dto.getAlcaldiaMunicipio());
        direccion.setCiudad(dto.getCiudad());
        direccion.setEstado(dto.getEstado());
        direccion.setCodigoPostal(dto.getCodigoPostal());
        direccion.setReferencias(dto.getReferencias());

        return direccionRepository.save(direccion);
    }

    public Direccion actualizar(Integer id, DireccionDTO dto) {

        Direccion direccion = buscarPorId(id);

        User usuario = userRepository.findById(dto.getIdUsuario())
                .orElseThrow(() ->
                        new UserNotFoundException(dto.getIdUsuario())
                );

        direccion.setUsuario(usuario);
        direccion.setCalle(dto.getCalle());
        direccion.setNumero(dto.getNumero());
        direccion.setAlcaldiaMunicipio(dto.getAlcaldiaMunicipio());
        direccion.setCiudad(dto.getCiudad());
        direccion.setEstado(dto.getEstado());
        direccion.setCodigoPostal(dto.getCodigoPostal());
        direccion.setReferencias(dto.getReferencias());

        return direccionRepository.save(direccion);
    }

    public void eliminar(Integer id) {
        Direccion existente = buscarPorId(id);
        direccionRepository.delete(existente);
    }
}
