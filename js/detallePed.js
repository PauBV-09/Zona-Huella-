const API_PEDIDOS = "http://localhost:8080/api/pedidos";


document.addEventListener("DOMContentLoaded", () => {

    iniciarDetallePedido();

});


async function iniciarDetallePedido() {

    const parametros = new URLSearchParams(
        window.location.search
    );

    const idPedido = parametros.get("id");


    if (!idPedido) {

        mostrarError(
            "No se especificó un pedido."
        );

        return;
    }


    try {

        const pedido = await obtenerPedido(idPedido);

        mostrarPedido(pedido);

    } catch (error) {

        console.error(
            "Error al cargar el pedido:",
            error
        );

        mostrarError(error.message);

    }
}


async function obtenerPedido(idPedido) {

    const respuesta = await fetch(
        `${API_PEDIDOS}/${idPedido}`
    );


    if (!respuesta.ok) {

        if (respuesta.status === 404) {

            throw new Error(
                `No existe el pedido con ID ${idPedido}.`
            );

        }


        throw new Error(
            "No fue posible obtener la información del pedido."
        );

    }


    return await respuesta.json();
}


function mostrarPedido(pedido) {

    mostrarInformacionGeneral(pedido);

    mostrarProductos(pedido.detalles);

    mostrarEntrega(pedido);

    mostrarResumen(pedido);

}


function mostrarInformacionGeneral(pedido) {

    const numeroPedido = crearNumeroPedido(
        pedido.idPedido,
        pedido.fechaPedido
    );


    const breadcrumb =
        document.getElementById(
            "pedido-breadcrumb"
        );

    const titulo =
        document.getElementById(
            "numero-pedido"
        );

    const fecha =
        document.getElementById(
            "fecha-pedido"
        );


    breadcrumb.textContent =
        numeroPedido;

    titulo.textContent =
        `Pedido ${numeroPedido}`;

    fecha.textContent =
        `Realizado el ${formatearFecha(
            pedido.fechaPedido
        )}`;

}


function mostrarProductos(detalles) {

    const contenedor =
        document.getElementById(
            "lista-productos"
        );


    contenedor.innerHTML = "";


    if (!detalles || detalles.length === 0) {

        const mensaje =
            document.createElement("p");

        mensaje.textContent =
            "Este pedido no contiene productos.";

        contenedor.appendChild(mensaje);

        return;

    }


    detalles.forEach(detalle => {

        const tarjeta =
            crearTarjetaProducto(detalle);

        contenedor.appendChild(tarjeta);

    });

}


function crearTarjetaProducto(detalle) {

    const producto =
        detalle.producto;


    const contenedor =
        document.createElement("div");

    contenedor.classList.add(
        "productos-ind"
    );


    /*
        IMAGEN
    */

    const imagen =
        document.createElement("img");

    imagen.classList.add(
        "productos-img"
    );


    if (
        producto.imagenes &&
        producto.imagenes.length > 0
    ) {

        imagen.src =
            producto.imagenes[0].fuente;

    } else {

        imagen.src =
            "../assets/logo Huella.png";

    }


    imagen.alt =
        producto.nombre;


    /*
        INFORMACIÓN
    */

    const informacion =
        document.createElement("div");

    informacion.classList.add("info");


    const nombre =
        document.createElement("h3");

    nombre.textContent =
        producto.nombre;


    const detallesCompra =
        document.createElement("p");


    detallesCompra.textContent =
        `Cantidad: ${detalle.cantidad} | ` +
        `${formatearMoneda(detalle.precioUnitario)} c/u`;


    informacion.appendChild(nombre);

    informacion.appendChild(
        detallesCompra
    );


    /*
        SUBTOTAL
    */

    const subtotal =
        document.createElement("h3");

    subtotal.classList.add("precio");

    subtotal.textContent =
        formatearMoneda(
            detalle.subtotal
        );


    /*
        ARMAR TARJETA
    */

    contenedor.appendChild(imagen);

    contenedor.appendChild(
        informacion
    );

    contenedor.appendChild(
        subtotal
    );


    return contenedor;

}


function mostrarEntrega(pedido) {

    const nombreCliente =
        document.getElementById(
            "nombre-cliente"
        );

    const direccionEntrega =
        document.getElementById(
            "direccion-entrega"
        );


    nombreCliente.textContent =
        pedido.usuario?.nombre ??
        "Cliente";


    direccionEntrega.textContent =
        construirDireccion(
            pedido.direccion
        );

}


function construirDireccion(direccion) {

    if (!direccion) {

        return "Dirección no disponible";

    }


    const partes = [];


    if (direccion.calle) {

        let calle =
            direccion.calle;


        if (direccion.numero) {

            calle +=
                ` ${direccion.numero}`;

        }


        partes.push(calle);

    }


    if (direccion.alcaldiaMunicipio) {

        partes.push(
            direccion.alcaldiaMunicipio
        );

    }


    if (direccion.ciudad) {

        partes.push(
            direccion.ciudad
        );

    }


    if (direccion.estado) {

        partes.push(
            direccion.estado
        );

    }


    if (direccion.codigoPostal) {

        partes.push(
            `C.P. ${direccion.codigoPostal}`
        );

    }


    return partes.join(", ");

}


function mostrarResumen(pedido) {

    const subtotalElemento =
        document.getElementById(
            "subtotal-pedido"
        );

    const totalElemento =
        document.getElementById(
            "total-pedido"
        );


    /*
        Calculamos el subtotal usando
        los DetallePedido.

        Esto también nos sirve para comprobar
        que los datos del backend coincidan
        con pedido.total.
    */

    const subtotal =
        pedido.detalles.reduce(
            (acumulado, detalle) => {

                return acumulado +
                    Number(
                        detalle.subtotal
                    );

            },
            0
        );


    subtotalElemento.textContent =
        formatearMoneda(subtotal);


    totalElemento.textContent =
        formatearMoneda(
            pedido.total
        );

}


function crearNumeroPedido(
    idPedido,
    fechaPedido
) {

    /*
        Si la fecha existe obtenemos su año.
        Si no, utilizamos el año actual.
    */

    let anio =
        new Date().getFullYear();


    if (fechaPedido) {

        const fecha =
            new Date(fechaPedido);

        anio =
            fecha.getFullYear();

    }


    const numero =
        String(idPedido)
            .padStart(3, "0");


    return `#ZH-${anio}-${numero}`;

}


function formatearFecha(fechaPedido) {

    if (!fechaPedido) {

        return "Fecha no disponible";

    }


    const fecha =
        new Date(fechaPedido);


    return new Intl.DateTimeFormat(
        "es-MX",
        {
            day: "numeric",
            month: "long",
            year: "numeric"
        }
    ).format(fecha);

}


function formatearMoneda(valor) {

    return new Intl.NumberFormat(
        "es-MX",
        {
            style: "currency",
            currency: "MXN"
        }
    ).format(
        Number(valor)
    );

}


function mostrarError(mensaje) {

    const elementoError =
        document.getElementById(
            "mensaje-error"
        );


    elementoError.textContent =
        mensaje;

    elementoError.classList.remove(
        "d-none"
    );


    const titulo =
        document.getElementById(
            "numero-pedido"
        );


    titulo.textContent =
        "No fue posible cargar el pedido";

}