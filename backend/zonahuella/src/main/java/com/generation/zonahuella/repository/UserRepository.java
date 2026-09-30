package com.generation.zonahuella.repository;

import com.generation.zonahuella.model.User;
import com.generation.zonahuella.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    User findByNombre(String nombre);
    User findByEmail(String email);
}
