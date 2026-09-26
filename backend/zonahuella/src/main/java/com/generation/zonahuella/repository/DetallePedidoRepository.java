package com.generation.zonahuella.repository;

import com.generation.zonahuella.model.DetallePedido;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DetallePedidoRepository extends JpaRepository<DetallePedido, Integer> {
    List<DetallePedido> findByPedido_IdPedido(Integer PedidoId);
    List<DetallePedido> findByProducto_IdProducto(Integer Productoid);
}