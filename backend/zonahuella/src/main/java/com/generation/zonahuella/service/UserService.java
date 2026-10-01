package com.generation.zonahuella.service;

import com.generation.zonahuella.exception.UserNotFoundException;
import com.generation.zonahuella.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import com.generation.zonahuella.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class UserService {
    private final UserRepository userRepository;


    @Autowired
    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public List<User> getUsuarios() {
        return userRepository.findAll();
    }

    public User createUsuario(User newUsuario){
        newUsuario.setIdUsuario(null);
        return userRepository.save(newUsuario);
    }

    public User findByEmail(String email){
        return userRepository.findByEmail(email);
    }

    public User findById(Integer id){
        return userRepository.findById(id)
                .orElseThrow(() -> new UserNotFoundException(id));
    }

    // 4. deleteUser
    public void deleteById(Integer id_usuario){
        if (userRepository.existsById(id_usuario)){
            userRepository.deleteById(id_usuario);
        }else{
            throw new UserNotFoundException(id_usuario);
        }
    }

    public User updateUsuarios(User usuarios, Integer id_usuario){
        return userRepository.findById(id_usuario)
                .map(data -> {
                    data.setNombre(usuarios.getNombre());
                    data.setEmail(usuarios.getEmail());
                    data.setContrasenia(usuarios.getContrasenia());
                    data.setTelefono(usuarios.getTelefono());
                    data.setRol(usuarios.getRol());
                    return userRepository.save(data);
                })
                .orElseThrow(()-> new UserNotFoundException(id_usuario));
    }

}


