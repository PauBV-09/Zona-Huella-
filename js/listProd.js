//Sección de filtros para móvil, abrir y cerrar panel

const botonFiltrosMovil = document.querySelector(".boton-filtros-movil");
const panelFiltros = document.querySelector(".filtros");

botonFiltrosMovil.addEventListener("click", () => {

    panelFiltros.classList.toggle("activo");

    const filtrosAbiertos = panelFiltros.classList.contains("activo");

    botonFiltrosMovil.setAttribute(
        "aria-expanded",
        filtrosAbiertos
    );

    if (filtrosAbiertos) {
      botonFiltrosMovil.textContent = "X";
  } else {
      botonFiltrosMovil.textContent = "☰";
  }

});

// Para ajuste a formatPrice cuando viene "Sin precio"
function formatPrice(value) {
  if (!value || value === "Sin precio") return "Sin precio";
  const numero = typeof value === "number" ? value : parseFloat(String(value).replace(/[^0-9.]/g, ""));
  return isNaN(numero) ? "Sin precio" : "$" + numero.toFixed(2);
}

// Función para agregar elementos usando la estructura legitima del JSON
// Claves usadas directamente: producto.nombre, producto.marca, producto.precio, producto.imagen
function renderProducts(listaProductos) {
  const grid = document.getElementById("productGrid");
  grid.innerHTML = "";

  listaProductos.forEach((producto, index) => {
    const card = document.createElement("div");
    card.className = "card";

    // Usando directamente producto.imagen y producto.nombre
    const imageHTML = producto.imagen
      ? `<img src="${producto.imagen}" alt="${producto.nombre}">`
      : `Producto`;

    card.innerHTML = `
      <div class="card-image ${producto.imagen ? "" : "empty"}">
        ${imageHTML}
        <button class="fav-btn" data-index="${index}" aria-label="Añadir a favoritos">♡</button>
      </div>
      
      <h3 class="card-title">${producto.nombre}</h3>
      <p class="card-subtitle">${producto.marca || "Zona Huella"}</p>
      <div class="own-card-footer">
        <span class="card-price">${formatPrice(producto.precio)}</span>
        <button class="add-btn" data-index="${index}" aria-label="Agregar al carrito">+</button>
      </div>
    `;

    grid.appendChild(card);
  });

  //Para los botones de agregar
  grid.querySelectorAll(".add-btn").forEach(btn => {
    btn.addEventListener("click", () => {
      const i = btn.dataset.index;
      console.log("Agregado al carrito:", listaProductos[i].nombre);
      btn.textContent = "✓";
      setTimeout(() => (btn.textContent = "+"), 800);
    });
  });

  // Para botones de favoritos
  grid.querySelectorAll(".fav-btn").forEach(btn => {
    btn.addEventListener("click", (e) => {
      e.stopPropagation(); 
      const i = btn.dataset.index;
      const producto = listaProductos[i];
      btn.classList.toggle("favorito");
      if (btn.classList.contains("favorito")) {
        btn.textContent = "❤️";
        console.log("Añadido a favoritos:", producto.nombre);
      } else {
        btn.textContent = "♡";
        console.log("Eliminado de favoritos:", producto.nombre);
      }
    });
  });
}

//  Función para cargar el JSON y llamar la función de agregar
async function cargarProductosDesdeJSON(rutaJSON) {
  try {
    const respuesta = await fetch(rutaJSON);
    if (!respuesta.ok) {
      throw new Error(`Error HTTP: ${respuesta.status}`);
    }
    
    // Obtención de los productos con la estructura JSON directamente
    const productos = await respuesta.json();

    // Se envían directamente a la función que los agrega al contenedor/lista
    renderProducts(productos);

  } catch (error) {
    console.error("Error al cargar los productos:", error);
  }
}

// Enlace de la carpeta dogsecos.json
cargarProductosDesdeJSON("../json/dogsecos.json");