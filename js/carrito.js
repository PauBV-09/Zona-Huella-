const productos = [
	{
		id: 1,
		nombre: "Patines",
		precio: 1200,
		calificacion: 4.8,
		descripcion:
			"Los patines de alto rendimiento están diseñados para ofrecer estabilidad, control y comodidad en cada movimiento.",
		img: "https://m.media-amazon.com/images/I/81MduxuxPaL._AC_SX679_.jpg ",
	},
	{
		id: 2,
		nombre: "Ruedas",
		precio: 800,
		calificacion: 5.0,
		descripcion:
			"Las ruedas de repuesto están diseñadas para mantener el máximo rendimiento y durabilidad de tus patines.",
		img: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqX6ZGJn0vCaN_aymgdtz6H9Z3jgsZhLhai6tj01V-0A&s=10 ",
	},
	{
		id: 3,
		nombre: "Rodilleras y coderas",
		precio: 456,
		calificacion: 4.8,
		descripcion:
			"El kit de protección incluye rodilleras, coderas y muñequeras ergonómicas que garantizan seguridad sin limitar la movilidad.",
		img: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRd8Od2StjVcmyLGL1b3jLkGmj8cod-RpiTCqrjgm9pHQ&s=10 ",
	},
	{
		id: 4,
		nombre: "Casco",
		precio: 900,
		calificacion: 4.0,
		descripcion:
			"El casco de seguridad para patinaje está diseñado para ofrecer máxima protección y confort durante tus entrenamientos y competencias.",
		img: "https://m.media-amazon.com/images/I/51Uejz-7XJL._AC_UF894,1000_QL80_.jpg",
	},
	{
		id: 5,
		nombre: "Maleta para Patines",
		precio: 600,
		calificacion: 4.6,
		descripcion:
			"La bolsa para patines está diseñada para transportar tu equipo con comodidad y estilo.",
		img: "https://m.media-amazon.com/images/I/81UnLSTj4YL.jpg ",
	},
	{
		id: 6,
		nombre: "Goggles",
		precio: 600,
		calificacion: 4.5,
		descripcion:
			"Los goggles antiempañantes ofrecen una visión clara y nítida bajo el agua gracias a su tecnología de lentes tratadas contra el vaho.",
		img: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNt7ARlQqNOhkS2HzTXWEIH00INWZjPM-VO7OUAG3RTw&s=10",
	},
	{
		id: 7,
		nombre: "Aletas de natacion",
		precio: 800,
		calificacion: 4.8,
		descripcion:
			"Las aletas de entrenamiento están diseñadas para mejorar la técnica y fortalecer los músculos de las piernas.",
		img: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGF9BCRH0_TSl227Fmb5Iro7lDzuwnZXs-AXh0lQ53MQ&s=10",
	},
	{
		id: 8,
		nombre: "Traje de baño",
		precio: 500,
		calificacion: 4,
		descripcion:
			"El traje de baño deportivo combina rendimiento y confort con un diseño ajustado que reduce la resistencia al agua.",
		img: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGuOgBLuau9T3H9RpJCNHlPc1U80DkQeE0B-l8OFJa1w&s=10",
	},
	{
		id: 9,
		nombre: "Toallas natacion",
		precio: 250,
		calificacion: 4.6,
		descripcion:
			"La toalla de microfibra para natación ofrece un secado rápido y eficiente gracias a su tejido ultraligero y absorbente.",
		img: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwOFog6Fpu2L55TL8AaQebBj9KqIUca6N6FThDkYuCAw&s=10",
	},
	{
		id: 10,
		nombre: "Gorro de Natacion",
		precio: 400,
		calificacion: 4.2,
		descripcion:
			"El gorro de natación está diseñado para mejorar la hidrodinámica y proteger el cabello del cloro.",
		img: "https://arenaswim.com.mx/cdn/shop/files/a3c49fe6-f0b6-40ae-9c7c-7d8bc6356a51.jpg?v=1756133930 ",
	},
	{
		id: 11,
		nombre: "Basketball: balon oficial",
		precio: 600,
		calificacion: 5,
		descripcion:
			"El balón oficial de basketball está diseñado para ofrecer un agarre superior y un rebote constante en cada jugada.",
		img: "https://contents.mediadecathlon.com/p2879501/k$5cb026f63716fb3fab53038700780172/picture.jpg?format=auto&f=969x0",
	},
	{
		id: 12,
		nombre: "Tenis basketball",
		precio: 1500,
		calificacion: 4.6,
		descripcion:
			"Los tenis de basketball combinan amortiguación, estabilidad y estilo para maximizar tu rendimiento en la cancha.",
		img: "https://th.bing.com/th/id/R.874298276998f8ff492214260f6ddbab?rik=U3Rvg1bzTMtr8Q&pid=ImgRaw&r=0 ",
	},
	{
		id: 13,
		nombre: "Muñequeras deportivas",
		precio: 200,
		calificacion: 4.3,
		descripcion:
			"Las muñequeras deportivas son el accesorio esencial para mantener la comodidad y el rendimiento durante el juego.",
		img: "https://tse3.mm.bing.net/th/id/OIP.NQSpF-7bwagPOJBtdnFp1wAAAA?r=0&rs=1&pid=ImgDetMain&o=7&rm=3",
	},
	{
		id: 14,
		nombre: "Uniforme deportivo",
		precio: 800,
		calificacion: 4.1,
		descripcion:
			"El uniforme deportivo para basketball combina comodidad, rendimiento y estilo en cada partido.",
		img: "https://image.made-in-china.com/2f0j00RNLiEqMhEcom/Basketball-Uniform-Suit-Men-prime-S-Custom-Printing-Jersey-Sports-Quick-Drying-Vest-Custom-Made-Training-Competition-Team-Uniforms-Custom-Made.jpg",
	},
	{
		id: 15,
		nombre: "Rodilleras Basketball",
		precio: 400,
		calificacion: 4.7,
		descripcion:
			"Las rodilleras deportivas están diseñadas para brindar protección y soporte durante los entrenamientos y partidos de basketball.",
		img: "https://acdn-us.mitiendanube.com/stores/002/609/666/products/241-e69cbda6c96ba6849b17099313075882-1024-1024.webp ",
	},
	{
		id: 16,
		nombre: "Zapatillas Con Placa De Fibra De Carbono",
		precio: 1530,
		calificacion: 4.1,
		descripcion:
			"Composición del exterior: 80% lienzo Composición de la suela: 40% de poliuretano Materiales de palma: Espuma EVA.",
		img: "https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcQ_1-sHlBw240gvExlAljE1mkvChZm3MM2D9XH5QdDnFuRQg_rwy1bFVO2kG68MhVkHO0cq2i7jctj85CXJinDg0wxE2HYyJGySdTWzXoE44zsnXSJ9gEAIYA",
	},
	{
		id: 17,
		nombre: "Smartwatch Llamadas GPS Monitoreo Salud",
		precio: 1456,
		calificacion: 4.8,
		descripcion:
			"Brújula, GPS (Sistema de Posicionamiento Global), ritmo cardiaco, oxigeno en sangre, monitoreo de sueno, sensor de gravedad, altavoz, microfono y motor de vibracion.",
		img: "https://http2.mlstatic.com/D_NQ_NP_2X_774581-MLA112984655578_072026-F.webp",
	},
	{
		id: 18,
		nombre: "SOAR Sudadera Running",
		precio: 500,
		calificacion: 4.0,
		descripcion:
			"Mañanas frías. Arranques rápidos. El Tempo Top está diseñado para rendir en el frío: ligero, ajustado al cuerpo y con alta transpirabilidad cuando el ritmo sube.",
		img: "https://www.pangeamovements.com/cdn/shop/files/773b3ca469_480x.webp?v=1786130161",
	},
	{
		id: 19,
		nombre: "Cinturón para Correr con Botella de Agua",
		precio: 350,
		calificacion: 3.8,
		descripcion:
			"Este cinturón para correr está hecho de Neopreno, es un tejido ligero que respira bien mientras que todavía logra mantener un gran estiramiento.",
		img: "https://m.media-amazon.com/images/I/51JMCcVxN9L._AC_SX679_.jpg",
	},
	{
		id: 20,
		nombre: "Lentes de Atletismo antireflejantes",
		precio: 400,
		calificacion: 3.5,
		descripcion:
			"Los lentes deportivos están diseñados para ofrecer protección, comodidad y rendimiento durante tus entrenamientos y competencias al aire libre.",
		img: "https://m.media-amazon.com/images/I/31PDgrQMrgL._AC_SY350_.jpg",
	},
];

const carrito = [];

function agregarCarrito(id) {
	const producto = productos.find((p) => p.id === id);
	const cantidadProducto = document.getElementById(`cantidad_${id}`);
	const cantidad = parseInt(cantidadProducto.value);

	// Buscar si ya existe en el carrito
	let carrito = JSON.parse(localStorage.getItem("carrito")) || [];
	const existe = carrito.find((item) => item.id === id);
	if (existe) {
		existe.cantidad += cantidad;
	} else {
		carrito.push({ ...producto, cantidad });
	}

	// Guardar carrito en localStorage
	localStorage.setItem("carrito", JSON.stringify(carrito));

	console.log("Carrito actualizado:", carrito);

	actualizarBadgeCarrito();
}

function renderCarrito() {
	const lista = document.getElementById("lista-carrito");
	if (!lista) return;
	lista.innerHTML = "";

	const carrito = JSON.parse(localStorage.getItem("carrito")) || [];
	let total = 0;

	carrito.forEach((item) => {
		const subtotal = item.precio * item.cantidad;
		total += subtotal;

		const card = document.createElement("div");
		card.className = "card shadow-sm p-3 d-flex flex-row align-items-center";

		card.innerHTML = `
      <img src="${item.img}" alt="${item.nombre}" class="img-thumbnail me-3" style="width:100px; height:100px; object-fit:cover;">
      <div class="flex-grow-1">
        <h5>${item.nombre}</h5>
        <p>Precio: $${item.precio} x ${item.cantidad}</p>
        <p class="fw-bold">Subtotal: $${subtotal}</p>
      </div>
      <div class="d-flex flex-column align-items-end">
        <input type="number" id="eliminar_${item.id}" class="form-control form-control-sm mb-2" 
               value="1" min="1" max="${item.cantidad}">
        <button class="btn btn-sm btn-danger" onclick="eliminarProducto(${item.id})">Eliminar</button>
      </div>
    `;
		lista.appendChild(card);
	});

	const totalElement = document.getElementById("total");
	if (totalElement) {
		totalElement.textContent = `$${total}`;
	}
}

function actualizarBadgeCarrito() {
	const badge = document.getElementById("carrito-badge");
	if (!badge) return;

	const carrito = JSON.parse(localStorage.getItem("carrito")) || [];
	if (carrito.length > 0) {
		badge.classList.remove("d-none"); // mostrar badge
	} else {
		badge.classList.add("d-none"); // ocultar badge
	}
}

function eliminarProducto(id) {
	let carrito = JSON.parse(localStorage.getItem("carrito")) || [];
	const cantidadEliminar = parseInt(
		document.getElementById(`eliminar_${id}`).value,
	);

	const producto = carrito.find((item) => item.id === id);
	if (producto) {
		if (cantidadEliminar >= producto.cantidad) {
			// Si se elimina igual o más de lo que hay, quitar el producto completo
			carrito = carrito.filter((item) => item.id !== id);
		} else {
			// Restar la cantidad indicada
			producto.cantidad -= cantidadEliminar;
		}
	}

	localStorage.setItem("carrito", JSON.stringify(carrito));
	renderCarrito();
	actualizarBadgeCarrito();
}

window.onload = () => {
	renderCarrito();
	actualizarBadgeCarrito();
};
