package com.generation.zonahuella.service;

import com.generation.zonahuella.model.*;
import com.generation.zonahuella.repository.*;
import jakarta.persistence.criteria.Join;
import jakarta.persistence.criteria.Predicate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class ProductoService {
    private final ProductoRepository productoRepository;
    private final CategoriaRepository categoriaRepository;
    private final EspecieRepository especieRepository;
    private final TamanioRepository tamanioRepository;
    private final EtapaVidaRepository etapaVidaRepository;

    @Autowired
    public ProductoService(ProductoRepository productoRepository, CategoriaRepository categoriaRepository, EspecieRepository especieRepository, TamanioRepository tamanioRepository, EtapaVidaRepository etapaVidaRepository) {
        this.productoRepository = productoRepository;
        this.categoriaRepository = categoriaRepository;
        this.especieRepository = especieRepository;
        this.tamanioRepository = tamanioRepository;
        this.etapaVidaRepository = etapaVidaRepository;
    }

    public List<Producto> obtenerProductos(){
        return productoRepository.findAll();
    }

    public Optional<Producto> obtenerProductoPorId(Integer id) {
        return productoRepository.findById(id);
    }

    public Producto crearProducto(Producto producto) {
        producto.setIdProducto(null);

        producto.setCategorias(
                obtenerCategoriasValidas(producto.getCategorias())
        );

        producto.setEspecies(
                obtenerEspeciesValidas(producto.getEspecies())
        );

        producto.setTamanios(
                obtenerTamaniosValidos(producto.getTamanios())
        );

        producto.setEtapasVida(
                obtenerEtapasVidaValidas(producto.getEtapasVida())
        );

        return productoRepository.save(producto);
    }

    public Optional<Producto> actualizarProducto(Integer id, Producto datosProducto) {

        return productoRepository.findById(id)
                .map(producto -> {

                    producto.setNombre(datosProducto.getNombre());
                    producto.setMarca(datosProducto.getMarca());
                    producto.setPrecio(datosProducto.getPrecio());
                    producto.setDescripcion(datosProducto.getDescripcion());
                    producto.setStock(datosProducto.getStock());
                    producto.setDescuento(datosProducto.getDescuento());
                    producto.setEnOferta(datosProducto.isEnOferta());

                    producto.setCategorias(obtenerCategoriasValidas(datosProducto.getCategorias()));

                    producto.setEspecies(obtenerEspeciesValidas(datosProducto.getEspecies()));

                    producto.setTamanios(obtenerTamaniosValidos(datosProducto.getTamanios()));

                    producto.setEtapasVida(obtenerEtapasVidaValidas(datosProducto.getEtapasVida()));

                    return productoRepository.save(producto);
                });
    }

    public boolean eliminarProducto(Integer id) {
        if (productoRepository.existsById(id)) {
            productoRepository.deleteById(id);
            return true;
        }

        return false;
    }

    public List<Producto> buscarPorNombre(String nombre) {
        return productoRepository.findByNombreContainingIgnoreCase(nombre);
    }

    public List<Producto> buscarPorMarca(String marca) {
        return productoRepository.findByMarcaContainingIgnoreCase(marca);
    }

    public List<Producto> obtenerProductosEnOferta() {
        return productoRepository.findByEnOfertaTrue();
    }

    // Buscar productos por categoría
    public List<Producto> buscarPorCategoria(String categoria) {
        return productoRepository
                .findDistinctByCategorias_NombreIgnoreCase(categoria);
    }

    // Buscar productos por especie
    public List<Producto> buscarPorEspecie(String especie) {
        return productoRepository
                .findDistinctByEspecies_NombreIgnoreCase(especie);
    }

    // Buscar productos por tamaño de mascota
    public List<Producto> buscarPorTamanio(String tamanio) {
        return productoRepository
                .findDistinctByTamanios_NombreIgnoreCase(tamanio);
    }

    // Buscar productos por etapa de vida
    public List<Producto> buscarPorEtapaVida(String etapaVida) {
        return productoRepository
                .findDistinctByEtapasVida_NombreIgnoreCase(etapaVida);
    }


    //Ingresar Categorias
    private Set<Categoria> obtenerCategoriasValidas(Set<Categoria> categorias) {

        Set<Categoria> categoriasValidas = new HashSet<>();

        for (Categoria categoria : categorias) {

            Categoria categoriaExistente = categoriaRepository
                    .findById(categoria.getIdCategoria())
                    .orElseThrow(() ->
                            new IllegalArgumentException(
                                    "No existe la categoría con ID: "
                                            + categoria.getIdCategoria()
                            )
                    );

            categoriasValidas.add(categoriaExistente);
        }

        return categoriasValidas;
    }

    //Ingresar Especies
    private Set<Especie> obtenerEspeciesValidas(Set<Especie> especies) {

        Set<Especie> especiesValidas = new HashSet<>();

        for (Especie especie : especies) {

            Especie especieExistente = especieRepository
                    .findById(especie.getIdEspecie())
                    .orElseThrow(() ->
                            new IllegalArgumentException(
                                    "No existe la especie con ID: "
                                            + especie.getIdEspecie()
                            )
                    );

            especiesValidas.add(especieExistente);
        }

        return especiesValidas;
    }

    //Ingresar Tamanios
    private Set<Tamanio> obtenerTamaniosValidos(Set<Tamanio> tamanios) {

        Set<Tamanio> tamaniosValidos = new HashSet<>();

        for (Tamanio tamanio : tamanios) {

            Tamanio tamanioExistente = tamanioRepository
                    .findById(tamanio.getIdTamanio())
                    .orElseThrow(() ->
                            new IllegalArgumentException(
                                    "No existe el tamaño con ID: "
                                            + tamanio.getIdTamanio()
                            )
                    );

            tamaniosValidos.add(tamanioExistente);
        }

        return tamaniosValidos;
    }

    //Ingresar etapas de vida
    private Set<EtapaVida> obtenerEtapasVidaValidas(
            Set<EtapaVida> etapasVida) {

        Set<EtapaVida> etapasValidas = new HashSet<>();

        for (EtapaVida etapaVida : etapasVida) {

            EtapaVida etapaExistente = etapaVidaRepository
                    .findById(etapaVida.getIdEtapaVida())
                    .orElseThrow(() ->
                            new IllegalArgumentException(
                                    "No existe la etapa de vida con ID: "
                                            + etapaVida.getIdEtapaVida()
                            )
                    );

            etapasValidas.add(etapaExistente);
        }

        return etapasValidas;
    }

    //Consutas Dinamicas
    public List<Producto> filtrarProductos(String categoria, String especie, String tamanio, String etapaVida) {

        return productoRepository.findAll((root, query, criteriaBuilder) -> {

            List<Predicate> condiciones = new ArrayList<>();

            if (categoria != null && !categoria.isBlank()) {

                Join<Producto, Categoria> categoriaJoin = root.join("categorias");

                condiciones.add(criteriaBuilder.equal(criteriaBuilder.upper(categoriaJoin.get("nombre")),
                                categoria.toUpperCase(Locale.ROOT)
                                )
                );
            }

            if (especie != null && !especie.isBlank()) {

                Join<Producto, Especie> especieJoin =
                        root.join("especies");

                condiciones.add(
                        criteriaBuilder.equal(
                                criteriaBuilder.upper(
                                        especieJoin.get("nombre")
                                ),
                                especie.toUpperCase(Locale.ROOT)
                        )
                );
            }

            if (tamanio != null && !tamanio.isBlank()) {

                Join<Producto, Tamanio> tamanioJoin =
                        root.join("tamanios");

                condiciones.add(
                        criteriaBuilder.equal(
                                criteriaBuilder.upper(
                                        tamanioJoin.get("nombre")
                                ),
                                tamanio.toUpperCase(Locale.ROOT)
                        )
                );
            }

            if (etapaVida != null && !etapaVida.isBlank()) {

                Join<Producto, EtapaVida> etapaJoin =
                        root.join("etapasVida");

                condiciones.add(
                        criteriaBuilder.equal(
                                criteriaBuilder.upper(
                                        etapaJoin.get("nombre")
                                ),
                                etapaVida.toUpperCase(Locale.ROOT)
                        )
                );
            }

            query.distinct(true);

            return criteriaBuilder.and(
                    condiciones.toArray(new Predicate[0])
            );
        });
    }



}
