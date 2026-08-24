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

function formatPrice(value) {
  const numero = typeof value === "number" ? value : parseFloat(String(value).replace(/[^0-9.]/g, ""));
  return isNaN(numero) ? "$0.00" : "$" + numero.toFixed(2);
}

function renderProducts(list) {
  const grid = document.getElementById("productGrid");
  grid.innerHTML = "";

  list.forEach((product, index) => {
    const card = document.createElement("div");
    card.className = "card";

    const imageHTML = product.image
      ? `<img src="${product.image}" alt="${product.title}">`
      : `Producto`;

    card.innerHTML = `
      <div class="card-image ${product.image ? "" : "empty"}">
        ${imageHTML}
      </div>
      
      <h3 class="card-title">${product.title}</h3>
      <p class="card-subtitle">${product.subtitle}</p>
      <div class="own-card-footer">
        <span class="card-price">${formatPrice(product.price)}</span>
        <button class="add-btn" data-index="${index}" aria-label="Agregar al carrito">+</button>
      </div>
    `;

    grid.appendChild(card);
  });

  grid.querySelectorAll(".add-btn").forEach(btn => {
    btn.addEventListener("click", () => {
      const i = btn.dataset.index;
      console.log("Agregado al carrito:", list[i].title);
      btn.textContent = "✓";
      setTimeout(() => (btn.textContent = "+"), 800);
    });
  });
}

function mapearFilaCSV(fila) {
  return {
    category: fila.marca || fila.categoria || "Categoría",
    title: fila.nombre || "Producto para mascota",
    subtitle: [fila.marca, fila.tamano].filter(Boolean).join(" · ") || "Marca · Tamaño",
    price: parseFloat(String(fila.precio).replace(/[^0-9.]/g, "")) || 0,
    image: fila.imagen || ""
  };
}

function cargarProductosDesdeCSV(rutaCSV) {
  Papa.parse(rutaCSV, {
    download: true,
    header: true,
    skipEmptyLines: true,
    complete: (resultados) => {
      const productos = resultados.data.map(mapearFilaCSV);
      renderProducts(productos);
    },
    error: (error) => {
      console.error("Error al cargar el CSV:", error);
    }
  });
}

cargarProductosDesdeCSV("../csv/dogsecos.csv");