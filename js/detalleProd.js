/* =========================================================
   DETALLE DE PRODUCTO
   Carga el producto desde el backend (Spring Boot) y llena la
   página. La reseña y las estrellas vienen en las columnas
   "resenas" y "estrellas" de la tabla productos.
   Se abre así:  detalleProd.html?id=5
   ========================================================= */

(() => {   // Todo va dentro de una función para no chocar con variables de loadComponents.js

// ⚙️ Ajusta esta ruta a la de tu ProductoController
const API_PRODUCTOS = "http://localhost:8080/api/productos";

// Imagen que se muestra si el producto no trae ninguna
const IMAGEN_POR_DEFECTO = "../assets/logo Huella.png";


/* ---------- Estado de la página ---------- */

const estado = {
    idProducto: null,
    producto: null,
    imagenes: [],
    imagenActual: 0,
    cantidad: 1,
    stock: null      // null = el backend no manda stock
};


/* ---------- Referencias al DOM ---------- */

const byId = (id) => document.getElementById(id);

const dom = {
    status: byId("productStatus"),
    content: byId("productContent"),

    breadcrumbCategory: byId("breadcrumbCategory"),
    breadcrumbProduct: byId("breadcrumbProduct"),

    mainImage: byId("mainProductImage"),
    prevImage: byId("prevImage"),
    nextImage: byId("nextImage"),
    thumbnailCarousel: byId("thumbnailCarousel"),
    thumbnailList: byId("thumbnailList"),
    prevThumbnails: byId("prevThumbnails"),
    nextThumbnails: byId("nextThumbnails"),

    category: byId("productCategory"),
    name: byId("productName"),

    ratingContainer: byId("productRatingContainer"),
    ratingStars: byId("ratingStars"),
    ratingValue: byId("ratingValue"),
    reviewsLink: byId("reviewsLink"),

    price: byId("productPrice"),
    stock: byId("stockStatus"),
    summary: byId("productSummary"),

    quantity: byId("productQuantity"),
    decrease: byId("decreaseQuantity"),
    increase: byId("increaseQuantity"),
    addCart: byId("addCartButton"),

    tabs: document.querySelectorAll(".detail-tab"),
    description: byId("productDescription"),
    detailsList: byId("detailsList"),

    reviewsList: byId("reviewsList"),

    favorite: document.querySelector(".fav-btn")
};


/* =========================================================
   UTILIDADES
   El modelo puede nombrar sus campos de distintas formas
   (precio / price, calificacion / estrellas...). Estas
   funciones buscan el primero que exista.
   ========================================================= */

function obtener(obj, ...claves) {
    for (const clave of claves) {
        const valor = obj?.[clave];
        if (valor !== undefined && valor !== null && valor !== "") {
            return valor;
        }
    }
    return null;
}

const CLAVES_ID = ["id", "idProducto", "productoId", "id_producto"];
const CLAVES_ESTRELLAS = ["calificacion", "estrellas", "puntuacion", "puntaje", "rating"];

function idDe(obj) {
    return obtener(obj, ...CLAVES_ID);
}

// "2026-09-30T10:00:00" -> "30 de septiembre de 2026"
function formatearFecha(valor) {
    const fecha = new Date(valor);
    if (Number.isNaN(fecha.getTime())) return String(valor);
    return fecha.toLocaleDateString("es-MX", { day: "numeric", month: "long", year: "numeric" });
}

const PARECE_FECHA = /^\d{4}-\d{2}-\d{2}([T ]\d{2}:\d{2})?/;

// Convierte un valor (texto, número, fecha u objeto relacionado) en texto mostrable
function aTexto(valor) {
    if (valor === null || valor === undefined || valor === "") return null;

    if (typeof valor === "boolean") return valor ? "Sí" : "No";

    if (Array.isArray(valor)) {
        const partes = valor.map(aTexto).filter(Boolean);
        return partes.length ? partes.join(", ") : null;
    }

    if (typeof valor === "object") {
        return obtener(valor, "nombre", "name", "titulo", "descripcion", "tipo", "valor");
    }

    if (typeof valor === "string" && PARECE_FECHA.test(valor)) {
        return formatearFecha(valor);
    }

    return String(valor);
}

function formatearPrecio(valor) {
    const numero = Number(valor);
    if (valor === null || Number.isNaN(numero)) return aTexto(valor) ?? "";

    return numero.toLocaleString("es-MX", {
        style: "currency",
        currency: "MXN"
    });
}

// "fechaCaducidad" -> "Fecha caducidad",  "peso_kg" -> "Peso kg"
function humanizar(clave) {
    const texto = clave
        .replace(/_/g, " ")
        .replace(/([a-záéíóúñ])([A-Z])/g, "$1 $2")
        .toLowerCase();

    return texto.charAt(0).toUpperCase() + texto.slice(1);
}

function crear(tag, clase, texto) {
    const el = document.createElement(tag);
    if (clase) el.className = clase;
    if (texto !== undefined) el.textContent = texto;
    return el;
}

async function pedirJSON(url) {
    const respuesta = await fetch(url);
    if (!respuesta.ok) {
        const error = new Error(`Error ${respuesta.status} en ${url}`);
        error.status = respuesta.status;
        throw error;
    }
    return respuesta.json();
}


/* =========================================================
   CARGA DEL PRODUCTO
   ========================================================= */

async function cargarProducto() {
    const id = new URLSearchParams(window.location.search).get("id");

    if (!id) {
        mostrarError("No se indicó qué producto mostrar.");
        return;
    }

    estado.idProducto = id;

    try {
        const producto = await pedirJSON(`${API_PRODUCTOS}/${encodeURIComponent(id)}`);
        estado.producto = producto;

        pintarProducto(producto);

        dom.status.hidden = true;
        dom.content.hidden = false;

    } catch (error) {
        console.error("Error al cargar el producto:", error);
        mostrarError(error.status === 404
            ? "Este producto no existe o ya no está disponible."
            : "No pudimos cargar el producto. Intenta de nuevo más tarde.");
    }
}

function mostrarError(mensaje) {
    dom.content.hidden = true;
    dom.status.hidden = false;
    dom.status.classList.add("is-error");
    dom.status.replaceChildren(
        crear("i", "bi bi-exclamation-circle"),
        crear("p", "", mensaje)
    );

    const volver = crear("a", "add-cart-button status-link", "Volver al inicio");
    volver.href = "../index.html";
    dom.status.appendChild(volver);
}


/* =========================================================
   PINTAR LA INFORMACIÓN
   ========================================================= */

function pintarProducto(p) {
    const nombre = aTexto(obtener(p, "nombre", "name", "titulo")) ?? "Producto";
    // En el modelo las categorías son una lista: se muestra la primera arriba
    const listaCategorias = obtener(p, "categorias", "categoria", "category");
    const categoria = Array.isArray(listaCategorias)
        ? aTexto(listaCategorias[0])
        : aTexto(listaCategorias);

    document.title = `${nombre} | Zona Huella`;

    // Breadcrumb
    dom.breadcrumbProduct.textContent = nombre;
    dom.breadcrumbCategory.textContent = categoria ? `${categoria} / ` : "";

    // Encabezado
    dom.name.textContent = nombre;
    dom.category.textContent = categoria ?? "";
    dom.category.hidden = !categoria;

    // Precio
    dom.price.textContent = formatearPrecio(obtener(p, "precio", "price"));

    // Resumen (si no hay uno corto, se usa el inicio de la descripción)
    const descripcion = aTexto(obtener(p, "descripcion", "description")) ?? "";
    const resumen = aTexto(obtener(p, "resumen", "descripcionCorta", "summary"))
        ?? recortar(descripcion, 160);

    dom.summary.textContent = resumen;
    dom.summary.hidden = !resumen;

    pintarDescripcion(descripcion);
    pintarStock(p);
    pintarImagenes(p, nombre);
    pintarDetalles(p);

    // Reseña y estrellas (columnas "resenas" y "estrellas" de productos)
    const resenas = resenasDelProducto(p);
    pintarCalificacion(p, resenas);
    pintarResenas(resenas);
}

function recortar(texto, max) {
    if (!texto || texto.length <= max) return texto;
    return texto.slice(0, texto.lastIndexOf(" ", max)) + "…";
}

function pintarDescripcion(descripcion) {
    dom.description.replaceChildren();

    if (!descripcion) {
        dom.description.appendChild(
            crear("p", "", "Este producto aún no tiene descripción.")
        );
        return;
    }

    // Respeta los saltos de línea que vengan de la base de datos
    descripcion
        .split(/\n+/)
        .filter((parrafo) => parrafo.trim())
        .forEach((parrafo) => {
            dom.description.appendChild(crear("p", "", parrafo.trim()));
        });
}


/* ---------- Stock ---------- */

function pintarStock(p) {
    const stock = obtener(p, "stock", "existencias", "cantidadDisponible", "inventario");
    const activo = obtener(p, "activo", "disponible");

    estado.stock = stock === null ? null : Number(stock);

    const agotado = activo === false || (estado.stock !== null && estado.stock <= 0);

    dom.stock.classList.remove("is-low", "is-out");

    if (agotado) {
        dom.stock.textContent = "Agotado";
        dom.stock.classList.add("is-out");
    } else if (estado.stock !== null && estado.stock <= 5) {
        dom.stock.textContent = estado.stock === 1 ? "¡Última pieza!" : `¡Últimas ${estado.stock} piezas!`;
        dom.stock.classList.add("is-low");
    } else {
        dom.stock.textContent = "Disponible";
    }

    dom.addCart.disabled = agotado;
    estado.cantidad = agotado ? 0 : 1;
    actualizarCantidad();
}


/* ---------- Galería ---------- */

function pintarImagenes(p, nombre) {
    const crudas = obtener(p, "imagenes", "imagen", "imagenUrl", "urlImagen", "img", "images", "image");

    let lista = [];

    if (Array.isArray(crudas)) {
        lista = crudas;
    } else if (typeof crudas === "string") {
        // Permite varias URLs separadas por coma (sin romper links que traen comas)
        lista = crudas.split(/,\s*(?=https?:\/\/)/);   // solo corta donde empieza otro link
    } else if (crudas) {
        lista = [crudas];
    }

    estado.imagenes = lista
        .map((img) => (typeof img === "string" ? img : obtener(img, "fuente", "url", "urlImagen", "imagenUrl", "src")))
        .filter(Boolean)
        .map((url) => url.trim())
        .filter(Boolean);

    if (estado.imagenes.length === 0) {
        estado.imagenes = [IMAGEN_POR_DEFECTO];
    }

    dom.mainImage.alt = nombre;
    dom.thumbnailList.replaceChildren();

    estado.imagenes.forEach((url, indice) => {
        const boton = crear("button", "thumbnail");
        boton.type = "button";
        boton.setAttribute("aria-label", `Ver imagen ${indice + 1}`);

        const img = crear("img");
        img.src = url;
        img.alt = "";
        img.loading = "lazy";
        img.addEventListener("error", () => { img.src = IMAGEN_POR_DEFECTO; }, { once: true });

        boton.appendChild(img);
        boton.addEventListener("click", () => mostrarImagen(indice));
        dom.thumbnailList.appendChild(boton);
    });

    // Con una sola imagen no tienen sentido las flechas ni las miniaturas
    const variasImagenes = estado.imagenes.length > 1;
    dom.prevImage.hidden = !variasImagenes;
    dom.nextImage.hidden = !variasImagenes;
    dom.thumbnailCarousel.hidden = !variasImagenes;

    mostrarImagen(0);
}

function mostrarImagen(indice) {
    const total = estado.imagenes.length;
    estado.imagenActual = (indice + total) % total;

    dom.mainImage.src = estado.imagenes[estado.imagenActual];

    dom.thumbnailList.querySelectorAll(".thumbnail").forEach((thumb, i) => {
        const activa = i === estado.imagenActual;
        thumb.classList.toggle("active-thumbnail", activa);
        thumb.setAttribute("aria-current", activa ? "true" : "false");

        if (activa && total > 1) {
            thumb.scrollIntoView({ block: "nearest", inline: "center", behavior: "smooth" });
        }
    });
}

dom.mainImage.addEventListener("error", () => {
    if (!dom.mainImage.src.endsWith(encodeURI(IMAGEN_POR_DEFECTO.split("/").pop()))) {
        dom.mainImage.src = IMAGEN_POR_DEFECTO;
    }
});

dom.prevImage.addEventListener("click", () => mostrarImagen(estado.imagenActual - 1));
dom.nextImage.addEventListener("click", () => mostrarImagen(estado.imagenActual + 1));

dom.prevThumbnails.addEventListener("click", () => {
    dom.thumbnailList.scrollBy({ left: -200, behavior: "smooth" });
});
dom.nextThumbnails.addEventListener("click", () => {
    dom.thumbnailList.scrollBy({ left: 200, behavior: "smooth" });
});


/* ---------- Pestaña "Detalles" ----------
   Recorre TODOS los campos que manda la base de datos y los
   muestra como filas. Si agregan una columna nueva (peso,
   edad, raza...), aparece sola sin tocar el HTML.
   Las relaciones (ej. categoria: {id, nombre}) se muestran
   por su nombre; si no tienen nombre, se muestran sus campos.
   ------------------------------------------------------- */

// Campos que ya se muestran en otra parte o que no le sirven al cliente
const CAMPOS_OCULTOS = new Set([
    ...CLAVES_ID,
    "nombre", "name", "titulo",
    "descripcion", "description", "resumen", "descripcionCorta", "summary",
    "precio", "price",
    "imagen", "imagenes", "imagenUrl", "urlImagen", "img", "images", "image",
    "resenas", "reseñas", "opiniones", "reviews",
    "calificacion", "rating", "promedioCalificacion", "estrellas",
    "activo", "disponible",
    "fechaCreacion", "fechaActualizacion", "createdAt", "updatedAt",
    "detallesPedido", "detallePedidos", "pedidos", "carritos", "favoritos",
    "password", "contrasena", "contraseña", "hibernateLazyInitializer", "handler"
]);

// Etiquetas más bonitas para campos comunes
const ETIQUETAS = {
    marca: "Marca",
    categoria: "Categoría",
    categorias: "Categorías",
    especies: "Especie",
    tamanios: "Tamaño de mascota",
    etapasVida: "Etapa de vida",
    especie: "Especie",
    mascota: "Mascota",
    tipoMascota: "Tipo de mascota",
    raza: "Raza",
    edad: "Edad recomendada",
    etapa: "Etapa de vida",
    peso: "Peso",
    tamano: "Tamaño",
    tamaño: "Tamaño",
    talla: "Talla",
    color: "Color",
    material: "Material",
    sabor: "Sabor",
    contenido: "Contenido",
    stock: "Piezas disponibles",
    existencias: "Piezas disponibles",
    sku: "SKU",
    proveedor: "Proveedor",
    fechaCaducidad: "Fecha de caducidad",
    descuento: "Descuento",
    enOferta: "En oferta",
    en_oferta: "En oferta"
};

// Formatos especiales para algunos campos
const FORMATOS = {
    // 0.10 -> "10%"   (si viene 10.00 también lo toma como 10%)
    descuento: (v) => {
        const n = Number(v);
        if (Number.isNaN(n)) return aTexto(v);
        if (n === 0) return "Sin descuento";
        const porcentaje = n <= 1 ? n * 100 : n;
        return `${Math.round(porcentaje)}%`;
    },
    // 1 / true -> "Sí",  0 / false -> "No"
    enOferta: (v) => (v === true || Number(v) === 1 ? "Sí" : "No"),
    en_oferta: (v) => (v === true || Number(v) === 1 ? "Sí" : "No")
};

function etiquetaDe(clave) {
    return ETIQUETAS[clave] ?? humanizar(clave);
}

// Devuelve [[etiqueta, texto], ...] para un campo; los objetos sin nombre se "abren"
function filasDeCampo(clave, valor, prefijo = "") {
    if (CAMPOS_OCULTOS.has(clave)) return [];

    const etiqueta = prefijo ? `${prefijo} · ${etiquetaDe(clave).toLowerCase()}` : etiquetaDe(clave);

    if (valor && typeof valor === "object" && !Array.isArray(valor)) {
        const texto = aTexto(valor);
        if (texto) return [[etiqueta, texto]];

        // Objeto sin "nombre": mostramos sus campos simples (un nivel)
        if (prefijo) return [];
        return Object.entries(valor)
            .filter(([, v]) => typeof v !== "object" || v === null)
            .flatMap(([k, v]) => filasDeCampo(k, v, etiqueta));
    }

    const texto = FORMATOS[clave] ? FORMATOS[clave](valor) : aTexto(valor);
    return texto ? [[etiqueta, texto]] : [];
}

function pintarDetalles(p) {
    dom.detailsList.replaceChildren();

    const filas = Object.entries(p).flatMap(([clave, valor]) => filasDeCampo(clave, valor));

    if (filas.length === 0) {
        dom.detailsList.appendChild(
            crear("p", "", "No hay detalles adicionales para este producto.")
        );
        return;
    }

    filas.forEach(([etiqueta, valor]) => {
        const fila = crear("div", "detail-row");
        fila.append(
            crear("span", "detail-name", etiqueta),
            crear("span", "detail-value", valor)
        );
        dom.detailsList.appendChild(fila);
    });
}


/* ---------- Pestañas Descripción / Detalles ---------- */

function activarPestana(pestana) {
    dom.tabs.forEach((tab) => {
        const activa = tab === pestana;
        const panel = document.getElementById(tab.getAttribute("aria-controls"));

        tab.classList.toggle("active-tab", activa);
        tab.setAttribute("aria-selected", String(activa));
        tab.tabIndex = activa ? 0 : -1;
        if (panel) panel.hidden = !activa;
    });
}

dom.tabs.forEach((tab, indice) => {
    tab.addEventListener("click", () => activarPestana(tab));

    // Navegación con flechas del teclado (accesibilidad)
    tab.addEventListener("keydown", (evento) => {
        if (evento.key !== "ArrowRight" && evento.key !== "ArrowLeft") return;

        const paso = evento.key === "ArrowRight" ? 1 : -1;
        const siguiente = dom.tabs[(indice + paso + dom.tabs.length) % dom.tabs.length];

        activarPestana(siguiente);
        siguiente.focus();
    });
});


/* =========================================================
   RESEÑAS
   En la base de datos la reseña vive en la tabla productos:
     resenas   -> texto de la reseña
     estrellas -> calificación de 0 a 5
   Se convierte en una lista para pintarla en tarjetas.
   (Si algún día crean una tabla aparte y el producto trae
   un arreglo de reseñas, también funciona.)
   ========================================================= */

function resenasDelProducto(p) {
    const crudas = obtener(p, "resenas", "reseñas", "opiniones", "reviews");

    if (Array.isArray(crudas)) return crudas;

    if (typeof crudas === "string" && crudas.trim()) {
        return [{
            comentario: crudas.trim(),
            estrellas: obtener(p, "estrellas", "calificacion", "rating")
        }];
    }

    return [];
}

function estrellasDe(resena) {
    const n = Number(obtener(resena, ...CLAVES_ESTRELLAS));
    return Number.isNaN(n) ? null : Math.max(0, Math.min(5, n));
}


/* ---------- Calificación (estrellas del encabezado) ---------- */

function pintarCalificacion(p, resenas) {
    const valores = resenas.map(estrellasDe).filter((n) => n !== null);

    // Se prioriza el promedio real de las reseñas; si no hay, el que mande el producto
    let calificacion = valores.length
        ? valores.reduce((a, b) => a + b, 0) / valores.length
        : obtener(p, "promedioCalificacion", "calificacion", "rating", "estrellas");

    if (calificacion === null || Number.isNaN(Number(calificacion))) {
        dom.ratingContainer.hidden = true;
        return;
    }

    const valor = Math.max(0, Math.min(5, Number(calificacion)));

    dom.ratingContainer.hidden = false;
    dom.ratingValue.textContent = valor.toFixed(1);
    dom.ratingStars.setAttribute("aria-label", `Calificación: ${valor.toFixed(1)} de 5 estrellas`);
    dom.ratingStars.replaceChildren(...crearEstrellas(valor));

    dom.reviewsLink.textContent = resenas.length
        ? `${resenas.length} ${resenas.length === 1 ? "reseña" : "reseñas"}`
        : "";
}

function crearEstrellas(valor) {
    const estrellas = [];

    for (let i = 1; i <= 5; i++) {
        let icono = "bi-star";
        if (valor >= i) icono = "bi-star-fill";
        else if (valor >= i - 0.5) icono = "bi-star-half";

        const estrella = crear("i", `bi ${icono}`);
        estrella.setAttribute("aria-hidden", "true");
        estrellas.push(estrella);
    }

    return estrellas;
}


/* ---------- Lista de reseñas ---------- */

function nombreDelAutor(r) {
    const usuario = obtener(r, "usuario", "cliente", "autor", "user");

    if (usuario && typeof usuario === "object") {
        const completo = [obtener(usuario, "nombre", "name"), obtener(usuario, "apellido", "apellidos", "lastName")]
            .filter(Boolean)
            .join(" ");
        return completo || obtener(usuario, "username", "nombreUsuario", "correo", "email") || "Cliente";
    }

    return aTexto(usuario) ?? aTexto(obtener(r, "nombreUsuario", "nombre")) ?? "Cliente";
}

function pintarResenas(resenas) {
    dom.reviewsList.replaceChildren();

    if (!resenas.length) {
        dom.reviewsList.appendChild(
            crear("p", "reviews-empty", "Este producto aún no tiene reseñas. ¡Sé el primero en opinar!")
        );
        return;
    }

    resenas.forEach((r) => {
        const comentario = aTexto(obtener(r, "comentario", "texto", "contenido", "opinion", "descripcion")) ?? "";
        const puntos = estrellasDe(r);
        const fecha = obtener(r, "fecha", "fechaResena", "fechaCreacion", "createdAt");

        const tarjeta = crear("article", "review-card");
        const encabezado = crear("div", "review-card-header");

        const autor = crear("div");
        autor.appendChild(crear("strong", "", nombreDelAutor(r)));
        if (fecha) {
            const cuando = crear("small", "d-block text-secondary", formatearFecha(fecha));
            autor.appendChild(cuando);
        }
        encabezado.appendChild(autor);

        if (puntos !== null) {
            const estrellas = crear("div", "review-stars");
            estrellas.setAttribute("role", "img");
            estrellas.setAttribute("aria-label", `${puntos} de 5 estrellas`);
            estrellas.append(...crearEstrellas(puntos));
            encabezado.appendChild(estrellas);
        }

        tarjeta.append(encabezado, crear("p", "", comentario));
        dom.reviewsList.appendChild(tarjeta);
    });
}


/* ---------- Cantidad ---------- */

function actualizarCantidad() {
    dom.quantity.textContent = estado.cantidad;

    const maximo = estado.stock ?? Infinity;
    dom.decrease.disabled = estado.cantidad <= 1;
    dom.increase.disabled = estado.cantidad === 0 || estado.cantidad >= maximo;
}

dom.decrease.addEventListener("click", () => {
    if (estado.cantidad > 1) {
        estado.cantidad--;
        actualizarCantidad();
    }
});

dom.increase.addEventListener("click", () => {
    const maximo = estado.stock ?? Infinity;
    if (estado.cantidad < maximo) {
        estado.cantidad++;
        actualizarCantidad();
    }
});


/* ---------- Favoritos (lógica original) ---------- */

dom.favorite.addEventListener("click", () => {
    dom.favorite.classList.toggle("favorito");

    if (dom.favorite.classList.contains("favorito")) {
        dom.favorite.textContent = "❤️";
        dom.favorite.setAttribute("aria-pressed", "true");
        dom.favorite.setAttribute("aria-label", "Eliminar producto de favoritos");
    } else {
        dom.favorite.textContent = "♡";
        dom.favorite.setAttribute("aria-pressed", "false");
        dom.favorite.setAttribute("aria-label", "Añadir producto a favoritos");
    }
});


/* ---------- Inicio ---------- */

cargarProducto();

})();