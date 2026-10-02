package com.generation.zonahuella.controller;

import com.generation.zonahuella.dto.PedidoDTO;
import com.generation.zonahuella.model.Pedido;
import com.generation.zonahuella.service.PedidoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/pedidos")
public class PedidoController {

    private final PedidoService pedidoService;

    @Autowired
    public PedidoController(PedidoService pedidoService) {
        this.pedidoService = pedidoService;
    }

    // GET /api/pedidos
    @GetMapping
    public List<Pedido> obtenerTodos() {
        return pedidoService.obtenerTodos();
    }

    // GET /api/pedidos/{id}
    @GetMapping("/{id}")
    public ResponseEntity<Pedido> obtenerPorId(@PathVariable Integer id) {

        Optional<Pedido> pedido = pedidoService.obtenerPorId(id);

        return pedido
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    // POST /api/pedidos
    @PostMapping
    public ResponseEntity<Pedido> crearPedido(
            @RequestBody PedidoDTO dto) {

        Pedido nuevoPedido
                = pedidoService.guardarPedido(dto);

        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(nuevoPedido);
    }

    // PUT /api/pedidos/{id}
    @PutMapping("/{id}")
    public ResponseEntity<Pedido> actualizarPedido(
            @PathVariable Integer id,
            @RequestBody PedidoDTO dto) {

        Pedido pedidoActualizado
                = pedidoService.actualizarPedido(id, dto);

        return ResponseEntity.ok(pedidoActualizado);
    }

    // DELETE /api/pedidos/{id}
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarPedido(
            @PathVariable Integer id) {

        pedidoService.eliminarPedido(id);

        return ResponseEntity.noContent().build();
    }

    //Obtener por usuario
    @GetMapping(params = "usuarioId")
    public List<Pedido> obtenerPorUsuario(
            @RequestParam Integer usuarioId) {

        return pedidoService.obtenerPorUsuario(usuarioId);
    }
}
