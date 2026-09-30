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
@RequestMapping("/api/ZH")
public class UserController {
    private final UserService userService;


    @Autowired
    public UserController(UserService userService){ this.userService = userService;}

    @GetMapping("/UsuarioZH")
    public List<User> getUsuarios(){ return userService.getUsuarios();}

    @PostMapping("/crear-usuario")
    public ResponseEntity<User> createUsuario(@RequestBody User newUsuario){
        User userByNombre = userService.findByNombre(newUsuario.getNombre());
        User userByEmail = userService.findByEmail(newUsuario.getEmail());

        if (userByNombre != null || userByEmail != null) {
            return new ResponseEntity<>(HttpStatus.CONFLICT);
        }else {
            return ResponseEntity.status(HttpStatus.CREATED)
                    .body(userService.createUsuario(newUsuario));
        }
    }

    @GetMapping("/ZonaHuella/{id}")
    public ResponseEntity<User> findById(@PathVariable Integer id) {
        // 200 o 404
        try {
            return ResponseEntity.ok(userService.findById(id));
        } catch (UserNotFoundException e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    //4. Mapear deleteById
    @DeleteMapping("/eliminnar-usuario-ZH/{id}")
    public ResponseEntity<?> deleteById(@PathVariable Integer id) {
        try {
            //204
            userService.deleteById(id);
            return ResponseEntity.noContent().build();
        } catch (UserNotFoundException e) { //404
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    //updateById
    @PutMapping("/actualizar-ZH/{id}")
    public ResponseEntity<User> updateUser(@RequestBody User user, @PathVariable Integer id) {
        try { //204
            userService.updateUsuarios(user, id);
            return ResponseEntity.noContent().build();
        } catch (UserNotFoundException e) { //404
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    //Mapear findByEmail
    @GetMapping("/ZHmail")
    public ResponseEntity<User> getByEmail(@RequestParam String email){

        User userByEmail = userService.findByEmail(email);
        if(userByEmail ==null) { //404
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(userByEmail); //200
    }

}
