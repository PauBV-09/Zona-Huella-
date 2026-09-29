package com.generation.zonahuella.controller;

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
@CrossOrigin(origins = "*")
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
    public ResponseEntity<Pedido> crearPedido(@RequestBody Pedido pedido) {

        Pedido nuevoPedido = pedidoService.guardarPedido(pedido);

        return new ResponseEntity<>(nuevoPedido, HttpStatus.CREATED);
    }

    // PUT /api/pedidos/{id}
    @PutMapping("/{id}")
    public ResponseEntity<Pedido> actualizarPedido(
            @PathVariable Integer id,
            @RequestBody Pedido pedido) {

        Pedido pedidoActualizado = pedidoService.actualizarPedido(id, pedido);

        if (pedidoActualizado != null) {
            return ResponseEntity.ok(pedidoActualizado);
        }

        return ResponseEntity.notFound().build();
    }

    // DELETE /api/pedidos/{id}
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarPedido(@PathVariable Integer id) {

        boolean eliminado = pedidoService.eliminarPedido(id);

        if (eliminado) {
            return ResponseEntity.noContent().build();
        }

        return ResponseEntity.notFound().build();
    }
}