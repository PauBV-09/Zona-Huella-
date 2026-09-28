package com.generation.zonahuella.controller;

import com.generation.zonahuella.model.DetallePedido;
import com.generation.zonahuella.service.DetallePedidoService;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/pedidos/{idPedido}/detalles")
public class DetallePedidoController {

    private final DetallePedidoService detalleService;

    public DetallePedidoController(DetallePedidoService detalleService) {
        this.detalleService = detalleService;
    }

    @GetMapping
    public List<DetallePedido> listar(@PathVariable Integer idPedido) {
        return detalleService.listar(idPedido);
    }

    @GetMapping("/{idProducto}")
    public DetallePedido obtener(@PathVariable Integer idPedido,
                                 @PathVariable Integer idProducto) {
        return detalleService.obtener(idPedido, idProducto);
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public DetallePedido agregar(@PathVariable Integer idPedido,
                                 @RequestParam Integer idProducto,
                                 @RequestParam Integer cantidad) {
        return detalleService.agregar(idPedido, idProducto, cantidad);
    }

    @PutMapping("/{idProducto}")
    public DetallePedido cambiarCantidad(@PathVariable Integer idPedido,
                                         @PathVariable Integer idProducto,
                                         @RequestParam Integer cantidad) {
        return detalleService.cambiarCantidad(idPedido, idProducto, cantidad);
    }

    @DeleteMapping("/{idProducto}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void quitar(@PathVariable Integer idPedido,
                       @PathVariable Integer idProducto) {
        detalleService.quitar(idPedido, idProducto);
    }
}