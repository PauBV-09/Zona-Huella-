package com.generation.zonahuella.service;

import com.generation.zonahuella.model.Pedido;
import com.generation.zonahuella.repository.PedidoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PedidoService {

    private final PedidoRepository pedidoRepository;

    @Autowired
    public PedidoService(PedidoRepository pedidoRepository) {
        this.pedidoRepository = pedidoRepository;
    }

    // Obtener todos los pedidos
    public List<Pedido> obtenerTodos() {
        return pedidoRepository.findAll();
    }

    // Obtener un pedido por ID
    public Optional<Pedido> obtenerPorId(Integer id) {
        return pedidoRepository.findById(id);
    }

    // Crear un pedido
    public Pedido guardarPedido(Pedido pedido) {
        return pedidoRepository.save(pedido);
    }

    // Actualizar un pedido
    public Pedido actualizarPedido(Integer id, Pedido pedido) {

        if (pedidoRepository.existsById(id)) {

            pedido.setIdPedido(id);

            return pedidoRepository.save(pedido);
        }

        return null;
    }

    // Eliminar un pedido
    public boolean eliminarPedido(Integer id) {
        if (pedidoRepository.existsById(id)) {
            pedidoRepository.deleteById(id);
            return true;
        }

        return false;
    }
}