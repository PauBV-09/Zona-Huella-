package com.generation.zonahuella.repository;

import com.generation.zonahuella.model.DetallePedido;
import com.generation.zonahuella.model.DetallePedidoId;
import com.generation.zonahuella.model.Pedido;
import com.generation.zonahuella.model.Producto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface DetallePedidoRepository extends JpaRepository<DetallePedido, DetallePedidoId> {

    List<DetallePedido> findByPedido_IdPedido(Integer idPedido);
    List<DetallePedido> findByProducto_IdProducto(Integer idProducto);

    List<DetallePedido> findByPedido(Pedido pedido);
    Optional<DetallePedido> findByPedidoAndProducto(Pedido pedido, Producto producto);
}