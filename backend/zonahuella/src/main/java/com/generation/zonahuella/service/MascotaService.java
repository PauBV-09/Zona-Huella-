package com.generation.zonahuella.service;

import com.generation.zonahuella.model.Mascota;
import com.generation.zonahuella.repository.MascotaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class MascotaService {

    @Autowired
    private MascotaRepository mascotaRepo;

    public List<Mascota> listar() {
        return mascotaRepo.findAll();
    }

    public Optional<Mascota> obtener(Integer id) {
        return mascotaRepo.findById(id);
    }

    public Mascota crear(Mascota mascota) {
        return mascotaRepo.save(mascota);
    }

    public Mascota actualizar(Integer id, Mascota mascota) {
        mascota.setIdMascota(id);
        return mascotaRepo.save(mascota);
    }

    public void eliminar(Integer id) {
        mascotaRepo.deleteById(id);
    }
}