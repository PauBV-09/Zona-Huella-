//Sección de filtros para móvil, abrir y cerrar panel

const botonFiltrosMovil = document.querySelector(".boton-filtros-movil");
const panelFiltros = document.querySelector(".filtros");

botonFiltrosMovil.addEventListener("click", () => {
  panelFiltros.classList.toggle("activo");

  const filtrosAbiertos = panelFiltros.classList.contains("activo");

  botonFiltrosMovil.setAttribute("aria-expanded", filtrosAbiertos);

  if (filtrosAbiertos) {
    botonFiltrosMovil.textContent = "X";
  } else {
    botonFiltrosMovil.textContent = "☰";
  }
});

// Para ajuste a formatPrice cuando viene "Sin precio"
function formatPrice(value) {
  if (!value || value === "Sin precio") return "Sin precio";
  const numero =
    typeof value === "number"
      ? value
      : parseFloat(String(value).replace(/[^0-9.]/g, ""));
  return isNaN(numero) ? "Sin precio" : "$" + numero.toFixed(2);
}

// Función para agregar elementos usando la estructura legitima del JSON
// Claves usadas directamente: producto.nombre, producto.marca, producto.precio, producto.imagen
function renderProducts(listaProductos, categoria) {
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

    card.querySelectorAll('h2, h3, img').forEach(el => el.addEventListener('click', () => {
        window.location.href = 'detalleProd.html?id=' + producto.id;
    }));
    grid.appendChild(card);
  });

  //Para los botones de agregar
  grid.querySelectorAll(".add-btn").forEach((btn) => {
    btn.addEventListener("click", () => {
  
      // CANDADO DE AUTENTICACIÓN
      const usuarioLogueado = localStorage.getItem("usuario");

      if (!usuarioLogueado) {
        alert("¡Hola! Para poder añadir productos a tu carrito y realizar compras, necesitas iniciar sesión o crear una cuenta.");
        window.location.href = "../html/login.html"; // Redirige al login
        return; // Detiene la función por completo
      }

      const i = btn.dataset.index;
      const producto = listaProductos[i];
      console.log("Agregado al carrito:", listaProductos[i].nombre);

      // Se antepone la categoría (nombre del JSON) al id para que no
      // choque con productos de otras categorías que reutilicen el mismo id.
      agregarProductoAlCarrito({
        id: producto.id,
        nombre: producto.nombre,
        precio: producto.precio,
        img: producto.imagen,
      });

      btn.textContent = "✓";
      setTimeout(() => (btn.textContent = "+"), 800);
    });
  });

  // Para botones de favoritos
  grid.querySelectorAll(".fav-btn").forEach((btn) => {
    btn.addEventListener("click", async (e) => {
      e.stopPropagation();
      const i = btn.dataset.index;
      const producto = listaProductos[i];
      try { await ZonaAPI.favorite(producto.id, !btn.classList.contains('favorito')); }
      catch (error) { ZonaAPI.error(error); return; }
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

// Botones y filtros consultan los endpoints del catálogo.
const catalogParams = new URLSearchParams(location.search);
const filterFields = [['especie','especie'], ['tamaño','tamanio'], ['categoria','categoria'], ['etapa','etapa']];
for (const [name,key] of filterFields) {
    const initial = catalogParams.get(key);
    if (initial) document.querySelectorAll(`input[name="${name}"]`).forEach(input => {
        input.checked = input.value === initial;
    });
}
let catalogoProductos = [];
let catalogRequest = 0;
function mostrarCatalogo() {
    const lista = catalogoProductos.slice();
    const order = document.querySelector('.orden-productos').value;
    if (order !== 'recomendados') lista.sort((a,b) => order === 'precio-menor' ? a.precio-b.precio : b.precio-a.precio);
    renderProducts(lista, 'api');
    if (!lista.length) {
        const message = document.createElement('p');
        message.textContent = 'No se encontraron productos con esta búsqueda y filtros.';
        message.setAttribute('role', 'status');
        document.getElementById('productGrid').appendChild(message);
    }
    if (!localStorage.getItem('usuarioId')) return;
    const request = catalogRequest;
    ZonaAPI.request(`/api/favoritos?usuarioId=${ZonaAPI.userId()}`).then(favs => {
        if (request !== catalogRequest) return;
        const ids = new Set(favs.map(p => String(p.idProducto)));
        document.querySelectorAll('#productGrid .fav-btn').forEach(btn => {
            const selected = ids.has(lista[btn.dataset.index].id);
            btn.classList.toggle('favorito', selected); btn.textContent = selected ? '❤️' : '♡';
        });
    }).catch(() => {});
}
async function aplicarFiltros() {
    const request = ++catalogRequest;
    const filters = {};
    for (const [name,key] of filterFields) {
        filters[key] = Array.from(document.querySelectorAll(`input[name="${name}"]:checked`), input =>
            (input.value === 'chico' ? 'PEQUENO' : input.value.toUpperCase()));
    }
    const grid = document.getElementById('productGrid');
    grid.setAttribute('aria-busy', 'true');
    try {
        const products = await ZonaAPI.catalog(filters, catalogParams.get('q') || '', catalogParams.get('ofertas') === '1');
        if (request !== catalogRequest) return;
        catalogoProductos = products;
        mostrarCatalogo();
    } catch(error) {
        if (request !== catalogRequest) return;
        catalogoProductos = [];
        grid.replaceChildren();
        const message = document.createElement('p');
        message.textContent = 'No se pudo cargar el catálogo. Intenta aplicar los filtros de nuevo.';
        grid.appendChild(message);
        ZonaAPI.error(error);
    } finally {
        if (request === catalogRequest) grid.setAttribute('aria-busy', 'false');
    }
}
document.querySelector('.formulario-filtros').addEventListener('submit', e => {e.preventDefault(); aplicarFiltros();});
document.querySelector('.orden-productos').addEventListener('change', mostrarCatalogo);
aplicarFiltros();
