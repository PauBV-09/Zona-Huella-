package com.generation.zonahuella.service;

import com.generation.zonahuella.exceptions.UserNotFoundException;
import com.generation.zonahuella.model.User;
import com.generation.zonahuella.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {
    private final UserRepository userRepository;

    @Autowired
    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public List<User> getUsers() {
        return userRepository.findAll();
    }

    public User createUser(User newUser){
        return userRepository.save(newUser);
    }


    public User findByUsername(String username){
        return userRepository.findByUsername(username);
    }


    public User findByEmail(String email){
        return userRepository.findByEmail(email);
    }


    public User findById(Long id){
        return userRepository.findById(id)
                .orElseThrow(() -> new UserNotFoundException(id));
    }

    // 4. deleteUser
    public void deleteById(Long id){
        if (userRepository.existsById(id)){
            userRepository.deleteById(id);
        }else{
            throw new UserNotFoundException(id);
        }
    }

    public User updateUser(User user, Long id){
        return userRepository.findById(id)
                .map(data -> {
                    data.setUsername(user.getUsername());
                    data.setEmail(user.getEmail());
                    data.setContrasenia(user.getContrasenia());
                    return userRepository.save(data);
                })
                .orElseThrow(()-> new UserNotFoundException(id));
    }

}


