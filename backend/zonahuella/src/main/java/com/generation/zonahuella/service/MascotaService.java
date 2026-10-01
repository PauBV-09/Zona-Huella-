package com.generation.zonahuella.service;

import com.generation.zonahuella.dto.MascotaDTO;
import com.generation.zonahuella.exceptions.RecursoNoEncontradoExceptions;
import com.generation.zonahuella.model.*;
import com.generation.zonahuella.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.List;
import java.util.Optional;

@Service
public class MascotaService {
    @Autowired
    private MascotaRepository mascotaRepo;

    @Autowired
    private UserRepository usuarioRepo;

    @Autowired
    private EspecieRepository especieRepo;

    @Autowired
    private EtapaVidaRepository etapaVidaRepo;

    @Autowired
    private TamanioRepository tamanioRepo;


    public java.util.Map<String, Object> catalogos() {
        return java.util.Map.of("especies", especieRepo.findAll(),
                "etapasVida", etapaVidaRepo.findAll(), "tamanios", tamanioRepo.findAll());
    }

    public List<Mascota> listar() {
        return mascotaRepo.findAll();
    }

    public Optional<Mascota> obtener(Integer id) {
        return mascotaRepo.findById(id);
    }

    public List<Mascota> listarPorUsuario(Integer idUsuario) {
        if (!usuarioRepo.existsById(idUsuario)) {
            throw new RecursoNoEncontradoExceptions("Usuario no encontrado con ID: " + idUsuario);
        }
        return mascotaRepo.findByUsuarioIdUsuario(idUsuario);
    }

    public List<Mascota> listarPorEspecie(Integer idEspecie) {
        if (!especieRepo.existsById(idEspecie)) {
            throw new RecursoNoEncontradoExceptions("Especie no encontrada con ID: " + idEspecie);
        }
        return mascotaRepo.findByEspecieIdEspecie(idEspecie);
    }

    public List<Mascota> listarPorTamanio(Integer idTamanio) {

        if (!tamanioRepo.existsById(idTamanio)) {
            throw new RecursoNoEncontradoExceptions(
                    "Tamaño no encontrado con ID: " + idTamanio
            );
        }

        return mascotaRepo.findByTamanioIdTamanio(idTamanio);
    }

    public List<Mascota> listarPorEtapaVida(Integer idEtapaVida) {

        if (!etapaVidaRepo.existsById(idEtapaVida)) {
            throw new RecursoNoEncontradoExceptions(
                    "Etapa de vida no encontrada con ID: " + idEtapaVida
            );
        }

        return mascotaRepo.findByEtapaVidaIdEtapaVida(idEtapaVida);
    }

    public Mascota crear(MascotaDTO dto) {
        User usuario = usuarioRepo.findById(dto.getIdUsuario())
                .orElseThrow(() -> new RecursoNoEncontradoExceptions("Usuario no encontrado con ID: " + dto.getIdUsuario()));

        Especie especie = especieRepo.findById(dto.getIdEspecie())
                .orElseThrow(() -> new RecursoNoEncontradoExceptions("Especie no encontrada con ID: " + dto.getIdEspecie()));

        EtapaVida etapaVida = null;
        if (dto.getIdEtapaVida() != null) {
            etapaVida = etapaVidaRepo.findById(dto.getIdEtapaVida())
                    .orElseThrow(() -> new RecursoNoEncontradoExceptions("Etapa de vida no encontrada con ID: " + dto.getIdEtapaVida()));
        }

        Tamanio tamanio = null;
        if (dto.getIdTamanio() != null) {
            tamanio = tamanioRepo.findById(dto.getIdTamanio())
                    .orElseThrow(() -> new RecursoNoEncontradoExceptions("Tamaño no encontrado con ID: " + dto.getIdTamanio()));
        }

        Mascota mascota = new Mascota();
        mascota.setNombre(dto.getNombre());
        mascota.setUsuario(usuario);
        mascota.setEspecie(especie);
        mascota.setEtapaVida(etapaVida);
        mascota.setTamanio(tamanio);
        mascota.setSexo(dto.getSexo());
        mascota.setFoto(dto.getFoto());

        return mascotaRepo.save(mascota);
    }

    public Mascota actualizar(Integer id, MascotaDTO dto) {
        Mascota mascota = mascotaRepo.findById(id)
                .orElseThrow(() -> new RecursoNoEncontradoExceptions("Mascota no encontrada con ID: " + id));

        if (dto.getNombre() != null) {
            mascota.setNombre(dto.getNombre());
        }

        if (dto.getIdUsuario() != null) {
            User usuario = usuarioRepo.findById(dto.getIdUsuario())
                    .orElseThrow(() -> new RecursoNoEncontradoExceptions("Usuario no encontrado con ID: " + dto.getIdUsuario()));
            mascota.setUsuario(usuario);
        }

        if (dto.getIdEspecie() != null) {
            Especie especie = especieRepo.findById(dto.getIdEspecie())
                    .orElseThrow(() -> new RecursoNoEncontradoExceptions("Especie no encontrada con ID: " + dto.getIdEspecie()));
            mascota.setEspecie(especie);
        }

        if (dto.getIdEtapaVida() != null) {
            EtapaVida etapaVida = etapaVidaRepo.findById(dto.getIdEtapaVida())
                    .orElseThrow(() -> new RecursoNoEncontradoExceptions("Etapa de vida no encontrada con ID: " + dto.getIdEtapaVida()));
            mascota.setEtapaVida(etapaVida);
        }

        if (dto.getIdTamanio() != null) {
            Tamanio tamanio = tamanioRepo.findById(dto.getIdTamanio())
                    .orElseThrow(() -> new RecursoNoEncontradoExceptions("Tamaño no encontrado con ID: " + dto.getIdTamanio()));
            mascota.setTamanio(tamanio);
        }

        if (dto.getSexo() != null) {
            mascota.setSexo(dto.getSexo());
        }

        if (dto.getFoto() != null) {
            mascota.setFoto(dto.getFoto());
        }

        return mascotaRepo.save(mascota);
    }


    public void eliminar(Integer id) {
        if (!mascotaRepo.existsById(id)) {
            throw new RecursoNoEncontradoExceptions("Mascota no encontrada con ID: " + id);
        }
        mascotaRepo.deleteById(id);
    }
}