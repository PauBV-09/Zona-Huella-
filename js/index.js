// Renderiza las tarjetas de "Recomendado para tu mascota" en index.html
// a partir de un catálogo de productos en JSON.

// Igual que en listProd.js: ajusta el precio cuando viene como texto
// (ej. "$1,560.00") o cuando no hay precio disponible.
function formatPrice(value) {
  if (!value || value === "Sin precio") return "Sin precio";
  const numero =
    typeof value === "number"
      ? value
      : parseFloat(String(value).replace(/[^0-9.]/g, ""));
  return isNaN(numero) ? "Sin precio" : "$" + numero.toFixed(2);
}

async function cargarRecomendados(rutaJSON, cantidad = 4) {
  const contenedor = document.querySelector(".cards_recomendado");
  if (!contenedor) return;

  try {
    const productos = await ZonaAPI.recommendedProducts();

    // Nombre de categoría derivado del archivo (ej. "dogsecos.json" -> "dogsecos")
    // Se usa como prefijo del id para no chocar con otras categorías.
    const categoria = rutaJSON.split("/").pop().replace(".json", "");

    const seleccionados = productos.slice(0, cantidad);

    contenedor.innerHTML = "";
    if (!seleccionados.length) {
      const message = document.createElement('p');
      message.textContent = 'No hay productos que coincidan con la especie, edad y tamaño de tu mascota.';
      message.setAttribute('role','status'); contenedor.appendChild(message);
    }

    seleccionados.forEach((producto) => {
      const card = document.createElement("div");
      card.className = "card_recomendado";

      card.innerHTML = `
				<img src="${producto.imagen}" alt="${producto.nombre}" />
				<div class="text_recomendado">
					<h2>${producto.nombre}</h2>
					<p>${producto.marca || "Zona Huella"}</p>
					<div class="last_section_card">
						<p class="precio">${formatPrice(producto.precio)}</p>
						<button class="add_cart" aria-label="Agregar al carrito">+</button>
					</div>
				</div>
			`;

      const btnAgregar = card.querySelector(".add_cart");
      btnAgregar.addEventListener("click", () => {
        agregarProductoAlCarrito({
          id: producto.id,
          nombre: producto.nombre,
          precio: producto.precio,
          img: producto.imagen,
        });

        btnAgregar.textContent = "✓";
        setTimeout(() => (btnAgregar.textContent = "+"), 800);
      });

    card.querySelectorAll('h2, h3, img').forEach(el => el.addEventListener('click', () => {
        window.location.href = 'html/detalleProd.html?id=' + producto.id;
    }));
      contenedor.appendChild(card);
    });
  } catch (error) {
    ZonaAPI.error(error);
  }
}

cargarRecomendados("json/dogsecos.json", 6);
