package com.generation.zonahuella.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.http.*;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import javax.imageio.ImageIO;
import java.nio.file.*;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/mascotas/fotos")
public class MascotaFotoController {
    private final Path folder = Path.of("uploads", "mascotas").toAbsolutePath().normalize();

    @PostMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public Map<String, String> subir(@RequestParam("foto") MultipartFile foto) throws IOException {
        if (foto.isEmpty() || foto.getSize() > 5 * 1024 * 1024) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Selecciona una foto de hasta 5 MB.");
        }
        java.awt.image.BufferedImage image;
        try (var input = foto.getInputStream()) { image = ImageIO.read(input); }
        if (image == null) throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Usa una imagen JPG o PNG válida.");
        String name = UUID.randomUUID() + ".png";
        Files.createDirectories(folder);
        ImageIO.write(image, "png", folder.resolve(name).toFile());
        return Map.of("foto", "/api/mascotas/fotos/" + name);
    }

    @GetMapping("/{name}")
    public ResponseEntity<Resource> obtener(@PathVariable String name) {
        if (!name.matches("[a-f0-9-]{36}\\.png")) throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        Path file = folder.resolve(name);
        if (!Files.isRegularFile(file)) throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        return ResponseEntity.ok().contentType(MediaType.IMAGE_PNG).body(new FileSystemResource(file));
    }
}
