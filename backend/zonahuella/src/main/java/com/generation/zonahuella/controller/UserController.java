package com.generation.zonahuella.controller;


import com.generation.zonahuella.exception.UserNotFoundException;
import com.generation.zonahuella.model.User;
import com.generation.zonahuella.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/usuarios")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }


    @PostMapping("/login")
    public ResponseEntity<User> login(@RequestBody User credenciales) {
        User usuario = userService.findByEmail(credenciales.getEmail());
        if (usuario == null || credenciales.getContrasenia() == null
                || !credenciales.getContrasenia().equals(usuario.getContrasenia())) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        return ResponseEntity.ok(usuario);
    }

    @GetMapping
    public List<User> getUsuarios() {
        return userService.getUsuarios();
    }


    @GetMapping("/{id}")
    public ResponseEntity<User> findById(
            @PathVariable Integer id) {

        return ResponseEntity.ok(
                userService.findById(id)
        );
    }


    @GetMapping(params = "email")
    public ResponseEntity<User> getByEmail(
            @RequestParam String email) {

        User usuario = userService.findByEmail(email);

        if (usuario == null) {
            return ResponseEntity.notFound().build();
        }

        return ResponseEntity.ok(usuario);
    }


    @PostMapping
    public ResponseEntity<User> createUsuario(
            @RequestBody User nuevoUsuario) {

        User usuarioExistente =
                userService.findByEmail(
                        nuevoUsuario.getEmail()
                );

        if (usuarioExistente != null) {
            return ResponseEntity
                    .status(HttpStatus.CONFLICT)
                    .build();
        }

        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(
                        userService.createUsuario(
                                nuevoUsuario
                        )
                );
    }


    @PutMapping("/{id}")
    public ResponseEntity<User> updateUser(
            @RequestBody User usuario,
            @PathVariable Integer id) {

        return ResponseEntity.ok(
                userService.updateUsuarios(
                        usuario,
                        id
                )
        );
    }


    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteById(
            @PathVariable Integer id) {

        userService.deleteById(id);

        return ResponseEntity.noContent().build();
    }
}
