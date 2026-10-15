/* =====================================================================
   admin.js — Alta de productos (Zona Huella)
   ===================================================================== */
const API =
	window.API_BASE_URL ||
	(window.ZONA_API_URL ||
		`${window.location.protocol}//${window.location.hostname}:8080`) + "/api";

// Opciones de clasificación. Cada "id" es el que tiene el registro en la base de datos
// (AUTO_INCREMENT según el orden de los INSERT). Si agregas filas nuevas en SQL, agrégalas aquí también.
const CATALOGOS = {
	categorias: {
		idKey: "idCategoria",
		opciones: [
			{ id: 1, nombre: "Alimentos" },
			{ id: 2, nombre: "Higiene" },
			{ id: 3, nombre: "Juguetes" },
			{ id: 4, nombre: "Accesorios" },
		],
	},
	especies: {
		idKey: "idEspecie",
		opciones: [
			{ id: 1, nombre: "Perro" },
			{ id: 2, nombre: "Gato" },
		],
	},
	tamanios: {
		idKey: "idTamanio",
		opciones: [
			{ id: 1, nombre: "Pequeño" },
			{ id: 2, nombre: "Mediano" },
			{ id: 3, nombre: "Grande" },
		],
	},
	etapasVida: {
		idKey: "idEtapaVida",
		opciones: [
			{ id: 1, nombre: "Cachorro" },
			{ id: 2, nombre: "Adulto" },
		],
	},
};

const form = document.getElementById("form-producto");
const alertBox = document.getElementById("admin-alert");
const btnGuardar = document.getElementById("btn-guardar");
const listaImagenes = document.getElementById("lista-imagenes");

const JSON_HEADERS = { "Content-Type": "application/json" };

/* ---------- Mensajes ---------- */
function mostrarMensaje(texto, tipo, caja = alertBox) {
	caja.textContent = texto;
	caja.className = `admin-alert is-${tipo}`;
	caja.hidden = false;
	caja.scrollIntoView({ behavior: "smooth", block: "center" });
}

// Estado: null = creando un producto nuevo; número = editando ese idProducto
let editandoId = null;
let imagenesEliminadas = []; // ids de imágenes ya guardadas que se borrarán al guardar los cambios

/* ---------- Chips (categorías, especies, tamaños, etapas de vida) ---------- */
function cargarCatalogo(grupo) {
	const contenedor = document.getElementById(`chips-${grupo}`);
	contenedor.innerHTML = "";

	CATALOGOS[grupo].opciones.forEach((op) => {
		const label = document.createElement("label");
		label.className = "admin-chip";
		label.innerHTML = `<input type="checkbox" name="${grupo}" value="${op.id}"><span></span>`;
		label.querySelector("span").textContent = op.nombre;
		contenedor.appendChild(label);
	});
}

function seleccionados(grupo) {
	const idKey = CATALOGOS[grupo].idKey;
	return [...document.querySelectorAll(`#chips-${grupo} input:checked`)].map(
		(i) => ({
			[idKey]: Number(i.value),
		}),
	);
}

/* ---------- Imágenes ---------- */
// Sin argumento: fila vacía (imagen nueva). Con { id, fuente, orden }: imagen ya guardada.
function agregarFilaImagen(guardada = null) {
	const fila = document.createElement("div");
	fila.className = "admin-image-row";
	fila.innerHTML = `
		<input type="url" class="form-control admin-input" placeholder="https://…" aria-label="URL de la imagen">
		<button type="button" class="admin-image-row__remove" aria-label="Quitar imagen">
			<i class="bi bi-trash3" aria-hidden="true"></i>
		</button>`;
	if (guardada) {
		fila._original = guardada;
		fila.querySelector("input").value = guardada.fuente;
	}
	fila.querySelector("button").addEventListener("click", () => {
		if (fila._original) imagenesEliminadas.push(fila._original.id); // se borra en el servidor al guardar
		fila.remove();
	});
	listaImagenes.appendChild(fila);
}

document
	.getElementById("btn-agregar-imagen")
	.addEventListener("click", () => agregarFilaImagen());

/* ---------- Validación ---------- */
function validar() {
	let valido = true;
	form.querySelectorAll("[required]").forEach((campo) => {
		const ok = campo.checkValidity() && campo.value.trim() !== "";
		campo.classList.toggle("is-invalid", !ok);
		if (!ok) valido = false;
	});

	const desc = document.getElementById("descuento");
	const okDesc = desc.value === "" || desc.checkValidity();
	desc.classList.toggle("is-invalid", !okDesc);
	return valido && okDesc;
}

form.addEventListener("input", (e) => e.target.classList.remove("is-invalid"));

/* ---------- Envío ---------- */
function construirProducto() {
	const descuento = document.getElementById("descuento").value;
	return {
		nombre: document.getElementById("nombre").value.trim(),
		marca: document.getElementById("marca").value.trim(),
		precio: parseFloat(document.getElementById("precio").value),
		descripcion: document.getElementById("descripcion").value.trim(),
		stock: parseInt(document.getElementById("stock").value, 10),
		descuento: descuento === "" ? null : parseFloat(descuento),
		enOferta: document.getElementById("enOferta").checked,
		categorias: seleccionados("categorias"),
		especies: seleccionados("especies"),
		tamanios: seleccionados("tamanios"),
		etapasVida: seleccionados("etapasVida"),
	};
}

// Sincroniza las imágenes con el backend: borra las quitadas, actualiza las modificadas
// o reordenadas (PUT) y crea las nuevas (POST). Devuelve cuántas peticiones fallaron.
async function sincronizarImagenes(idProducto) {
	let fallidas = 0;

	async function intentar(url, metodo, cuerpo) {
		try {
			const resp = await fetch(url, {
				method: metodo,
				headers: JSON_HEADERS,
				body: cuerpo ? JSON.stringify(cuerpo) : undefined,
			});
			if (!resp.ok) throw new Error(resp.status);
		} catch (err) {
			console.error(`Error en ${metodo} ${url}:`, err);
			fallidas++;
		}
	}

	for (const id of imagenesEliminadas) {
		await intentar(`${API}/imagenes/${id}`, "DELETE");
	}

	let orden = 0;
	for (const fila of listaImagenes.querySelectorAll(".admin-image-row")) {
		const original = fila._original;
		const fuente =
			fila.querySelector("input").value.trim() ||
			(original ? original.fuente : "");
		if (!fuente) continue;
		orden++;

		if (original) {
			if (fuente !== original.fuente || orden !== original.orden) {
				await intentar(`${API}/imagenes/${original.id}`, "PUT", {
					fuente,
					orden,
				});
			}
		} else {
			await intentar(`${API}/imagenes?productoId=${idProducto}`, "POST", {
				fuente,
				orden,
			});
		}
	}
	return fallidas;
}

function limpiarFormulario() {
	form.reset();
	form
		.querySelectorAll(".is-invalid")
		.forEach((el) => el.classList.remove("is-invalid"));
	listaImagenes.innerHTML = "";
	agregarFilaImagen();
}

function etiquetaGuardar() {
	return editandoId === null ? "Guardar producto" : "Guardar cambios";
}

form.addEventListener("submit", async (e) => {
	e.preventDefault();
	alertBox.hidden = true;

	if (!validar()) {
		mostrarMensaje("Revisa los campos marcados en rojo.", "error");
		return;
	}

	const editando = editandoId !== null;
	btnGuardar.disabled = true;
	btnGuardar.textContent = "Guardando…";

	try {
		const resp = await fetch(
			editando ? `${API}/productos/${editandoId}` : `${API}/productos`,
			{
				method: editando ? "PUT" : "POST",
				headers: JSON_HEADERS,
				body: JSON.stringify(construirProducto()),
			},
		);
		if (!resp.ok)
			throw new Error((await resp.text()) || `Error ${resp.status}`);

		const guardado = await resp.json();
		const fallidas = await sincronizarImagenes(guardado.idProducto);

		if (editando) {
			// Vuelve al listado ya actualizado y avisa ahí
			salirModoEdicion();
			cambiarPanel("panel-lista");
			mostrarMensaje(
				fallidas > 0
					? `Producto "${guardado.nombre}" actualizado, pero ${fallidas} cambio(s) de imágenes fallaron.`
					: `Producto "${guardado.nombre}" actualizado correctamente.`,
				fallidas > 0 ? "error" : "success",
				document.getElementById("lista-alert"),
			);
		} else {
			if (fallidas > 0) {
				mostrarMensaje(
					`Producto guardado, pero ${fallidas} imagen(es) no se pudieron subir.`,
					"error",
				);
			} else {
				mostrarMensaje(
					`Producto "${guardado.nombre}" guardado correctamente.`,
					"success",
				);
			}
			limpiarFormulario();
			cargarProductos(); // deja la lista al día para cuando se abra "Ver productos"
		}
	} catch (err) {
		console.error("Error al guardar el producto:", err);
		mostrarMensaje(`No se pudo guardar el producto. ${err.message}`, "error");
	} finally {
		btnGuardar.disabled = false;
		btnGuardar.textContent = etiquetaGuardar();
	}
});

form.addEventListener("reset", (e) => {
	// En modo edición el botón funciona como "Cancelar": descarta los cambios y vuelve al listado
	if (editandoId !== null) {
		e.preventDefault();
		salirModoEdicion();
		cambiarPanel("panel-lista");
		return;
	}
	alertBox.hidden = true;
	imagenesEliminadas = [];
	listaImagenes.innerHTML = "";
	agregarFilaImagen();
});

/* ---------- Modo edición ---------- */
function ponerModoEdicion(activo) {
	document.getElementById("form-titulo").textContent = activo
		? "Editar producto"
		: "Nuevo producto";
	document.getElementById("form-subtitulo").textContent = activo
		? "Corrige los datos, actualiza precio o stock, o cambia las imágenes."
		: "Llena los datos para agregarlo al catálogo de la tienda.";
	document.getElementById("btn-limpiar").textContent = activo
		? "Cancelar"
		: "Limpiar";
	btnGuardar.textContent = etiquetaGuardar();
}

function salirModoEdicion() {
	if (editandoId === null) return;
	editandoId = null;
	imagenesEliminadas = [];
	form.reset(); // vuelve a dejar el formulario vacío, listo para un producto nuevo
	form
		.querySelectorAll(".is-invalid")
		.forEach((el) => el.classList.remove("is-invalid"));
	ponerModoEdicion(false);
}

function iniciarEdicion(p) {
	salirModoEdicion();
	form.reset();
	form
		.querySelectorAll(".is-invalid")
		.forEach((el) => el.classList.remove("is-invalid"));
	editandoId = p.idProducto;
	imagenesEliminadas = [];

	document.getElementById("nombre").value = p.nombre ?? "";
	document.getElementById("marca").value = p.marca ?? "";
	document.getElementById("descripcion").value = p.descripcion ?? "";
	document.getElementById("precio").value = p.precio ?? "";
	document.getElementById("stock").value = p.stock ?? "";
	document.getElementById("descuento").value = p.descuento ?? "";
	document.getElementById("enOferta").checked = !!p.enOferta;

	Object.entries(CATALOGOS).forEach(([grupo, { idKey }]) => {
		const ids = new Set((p[grupo] || []).map((item) => item[idKey]));
		document.querySelectorAll(`#chips-${grupo} input`).forEach((chk) => {
			chk.checked = ids.has(Number(chk.value));
		});
	});

	listaImagenes.innerHTML = "";
	const fotos = [...(p.imagenes || [])].sort(
		(a, b) => (a.orden ?? 0) - (b.orden ?? 0),
	);
	fotos.forEach((foto) => agregarFilaImagen(foto));
	if (!fotos.length) agregarFilaImagen();

	ponerModoEdicion(true);
	alertBox.hidden = true;
	cambiarPanel("panel-nuevo");
	// Editar es una sub-vista del listado: ninguna pestaña queda marcada
	document.querySelectorAll(".admin-tab").forEach((tab) => {
		tab.classList.remove("is-active");
		tab.setAttribute("aria-pressed", "false");
	});
	window.scrollTo({ top: 0, behavior: "smooth" });
}

/* ---------- Pestañas: Ver productos / Agregar producto ---------- */
function cambiarPanel(idPanel) {
	document.getElementById("lista-alert").hidden = true;
	document.querySelectorAll(".admin-tab").forEach((tab) => {
		const activa = tab.dataset.panel === idPanel;
		tab.classList.toggle("is-active", activa);
		tab.setAttribute("aria-pressed", activa);
	});
	document.getElementById("panel-lista").hidden = idPanel !== "panel-lista";
	document.getElementById("panel-nuevo").hidden = idPanel !== "panel-nuevo";

	if (idPanel === "panel-lista") cargarProductos(); // siempre se muestra la lista actualizada
}

document.querySelectorAll(".admin-tab").forEach((tab) => {
	tab.addEventListener("click", () => {
		salirModoEdicion();
		cambiarPanel(tab.dataset.panel);
	});
});

/* ---------- Listado de productos ---------- */
// Usa el nombre "bonito" de CATALOGOS (Pequeño) en vez del de la BD (PEQUENO)
function nombreOpcion(grupo, item) {
	const { idKey, opciones } = CATALOGOS[grupo];
	const op = opciones.find((o) => o.id === item[idKey]);
	return op ? op.nombre : item.nombre;
}

function clasificacion(producto) {
	return ["categorias", "especies", "tamanios", "etapasVida"].flatMap((grupo) =>
		(producto[grupo] || []).map((item) => nombreOpcion(grupo, item)),
	);
}

function crearElemento(tag, clase, texto) {
	const el = document.createElement(tag);
	el.className = clase;
	if (texto !== undefined) el.textContent = texto;
	return el;
}

// Foto principal + miniaturas (si el producto tiene más de una). Ordenadas por "orden".
function crearMedia(p) {
	const fotos = (p.imagenes || [])
		.filter((i) => i.fuente)
		.sort((a, b) => (a.orden ?? 0) - (b.orden ?? 0));

	const media = crearElemento("div", "producto-card__media");
	const marco = crearElemento("div", "producto-card__foto");

	const vacio = crearElemento("div", "producto-card__sinfoto");
	vacio.innerHTML =
		'<i class="bi bi-image" aria-hidden="true"></i><span>Sin foto</span>';

	const img = document.createElement("img");
	img.className = "producto-card__img";
	img.alt = p.nombre;
	img.loading = "lazy";
	img.addEventListener("error", () => marco.classList.add("sin-foto")); // URL rota → muestra "Sin foto"

	marco.append(vacio, img);
	media.appendChild(marco);

	if (!fotos.length) {
		marco.classList.add("sin-foto");
		return media;
	}
	img.src = fotos[0].fuente;

	if (fotos.length > 1) {
		const tira = crearElemento("div", "producto-card__thumbs");
		fotos.forEach((foto, i) => {
			const btn = crearElemento(
				"button",
				"producto-card__thumb" + (i === 0 ? " is-active" : ""),
			);
			btn.type = "button";
			btn.setAttribute("aria-label", `Ver foto ${i + 1} de ${fotos.length}`);

			const mini = document.createElement("img");
			mini.src = foto.fuente;
			mini.alt = "";
			mini.loading = "lazy";
			mini.addEventListener("error", () => (btn.hidden = true));
			btn.appendChild(mini);

			btn.addEventListener("click", () => {
				marco.classList.remove("sin-foto");
				img.src = foto.fuente;
				tira
					.querySelectorAll(".producto-card__thumb")
					.forEach((b) => b.classList.toggle("is-active", b === btn));
			});
			tira.appendChild(btn);
		});
		media.appendChild(tira);
	}
	return media;
}

function crearCardProducto(p) {
	const card = crearElemento("article", "producto-card");
	card.appendChild(crearMedia(p));

	const cuerpo = crearElemento("div", "producto-card__body");
	cuerpo.appendChild(crearElemento("h3", "producto-card__nombre", p.nombre));

	const tags = crearElemento("div", "producto-card__tags");
	const etiquetas = clasificacion(p);
	if (etiquetas.length) {
		etiquetas.forEach((t) =>
			tags.appendChild(crearElemento("span", "producto-tag", t)),
		);
	} else {
		tags.appendChild(
			crearElemento(
				"span",
				"producto-tag producto-tag--vacio",
				"Sin clasificación",
			),
		);
	}
	cuerpo.appendChild(tags);

	const pie = crearElemento("div", "producto-card__footer");
	const precio = Number(p.precio).toLocaleString("es-MX", {
		style: "currency",
		currency: "MXN",
	});
	pie.appendChild(crearElemento("span", "producto-card__precio", precio));
	pie.appendChild(
		crearElemento("span", "producto-card__stock", `Stock: ${p.stock}`),
	);
	cuerpo.appendChild(pie);

	const editar = crearElemento(
		"button",
		"btn admin-btn-outline producto-card__editar",
	);
	editar.type = "button";
	editar.innerHTML =
		'<i class="bi bi-pencil-square" aria-hidden="true"></i> Editar';
	editar.setAttribute("aria-label", `Editar ${p.nombre}`);
	editar.addEventListener("click", () => iniciarEdicion(p));
	cuerpo.appendChild(editar);

	card.appendChild(cuerpo);
	return card;
}

async function cargarProductos() {
	const lista = document.getElementById("lista-productos");
	const contador = document.getElementById("contador-productos");
	lista.innerHTML = '<p class="producto-estado">Cargando productos…</p>';

	try {
		const resp = await fetch(`${API}/productos`);
		if (!resp.ok) throw new Error(resp.status);
		const productos = await resp.json();

		lista.innerHTML = "";
		if (!productos.length) {
			contador.textContent = "";
			lista.innerHTML =
				'<p class="producto-estado">Aún no hay productos. Usa "Agregar producto" para crear el primero.</p>';
			return;
		}

		contador.textContent = `${productos.length} ${productos.length === 1 ? "producto dado de alta" : "productos dados de alta"}`;
		productos.forEach((p) => lista.appendChild(crearCardProducto(p)));
	} catch (err) {
		console.error("No se pudieron cargar los productos:", err);
		contador.textContent = "";
		lista.innerHTML = `<p class="producto-estado">No se pudieron cargar los productos (${err.message}).</p>`;
	}
}

/* ---------- Inicio ---------- */
document.addEventListener("DOMContentLoaded", () => {
	agregarFilaImagen();
	Object.keys(CATALOGOS).forEach(cargarCatalogo);
	cargarProductos();
});
