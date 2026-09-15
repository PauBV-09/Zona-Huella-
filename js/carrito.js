const carrito = [];

// Agrega al carrito un producto recibido como objeto completo.
function agregarProductoAlCarrito(producto) {
  if (producto.id === undefined || producto.id === null) {
    console.warn(`"${producto.nombre}" no tiene id, no se agregó al carrito.`);
    return;
  }

  const precioNumerico =
    typeof producto.precio === "number"
      ? producto.precio
      : parseFloat(String(producto.precio).replace(/[^0-9.]/g, ""));

  let carrito = JSON.parse(localStorage.getItem("carrito")) || [];
  const existe = carrito.find((item) => item.id === producto.id);

  if (existe) {
    existe.cantidad += 1;
  } else {
    carrito.push({
      id: producto.id,
      nombre: producto.nombre,
      precio: precioNumerico,
      img: producto.img,
      cantidad: 1,
    });
  }

  localStorage.setItem("carrito", JSON.stringify(carrito));
  actualizarBadgeCarrito();
}

function renderCarrito() {
  const lista = document.getElementById("lista-carrito");
  if (!lista) return;
  lista.innerHTML = "";

  const carrito = JSON.parse(localStorage.getItem("carrito")) || [];
  let total = 0;

  if (carrito.length === 0) {
    lista.innerHTML = `
      <div class="d-flex flex-column align-items-center text-center py-5">
        <i class="bi bi-cart-x display-1 text-muted mb-3"></i>
        <h4 class="mb-2">Tu carrito está vacío</h4>
        <p class="text-muted mb-4">Explora nuestros productos y encuentra algo para tu mascota.</p>
        <a href="listProd.html" class="ver_productos px-4">Ver productos</a>
      </div>
    `;

    const totalElement = document.getElementById("total");
    if (totalElement) {
      totalElement.textContent = "$0";
    }
    return;
  }

  carrito.forEach((item) => {
    const subtotal = item.precio * item.cantidad;
    total += subtotal;

    const card = document.createElement("div");
    card.className =
      "card shadow-sm p-3 d-flex flex-column flex-md-row align-items-center gap-3";

    card.innerHTML = `
      <img src="${item.img}" alt="${item.nombre}" class="img-thumbnail me-3" style="width:100px; height:100px; object-fit:cover;">
      <div class="flex-grow-1 text-center text-md-start w-100">
        <h5>${item.nombre}</h5>
        <p>Precio: $${item.precio}</p>
        <p class="fw-bold">Subtotal: $${subtotal}</p>
      </div>
      <div class="d-flex flex-column align-items-center align-items-md-end gap-2">
        <div class="d-flex align-items-center gap-2">
          <div class="btn-group" role="group" aria-label="Cantidad">
            <button class="btn btn-sm btn-outline-secondary" onclick="restarCantidad('${item.id}')">-</button>
            <span class="btn btn-sm btn-outline-secondary pe-none fw-bold px-3">${item.cantidad}</span>
            <button class="btn btn-sm btn-outline-secondary" onclick="sumarCantidad('${item.id}')">+</button>
          </div>
          <button class="btn btn-sm btn-danger" onclick="eliminarProducto('${item.id}')" title="Eliminar producto">
            <i class="bi bi-trash"></i>
          </button>
        </div>
      </div>
    `;
    lista.appendChild(card);
  });

  const totalElement = document.getElementById("total");
  if (totalElement) {
    totalElement.textContent = `$${total}`;
  }
}

const navbarContainer = document.getElementById("navbar-container");
if (navbarContainer) {
  const badgeObserver = new MutationObserver(() => {
    actualizarBadgeCarrito();
  });
  badgeObserver.observe(navbarContainer, { childList: true, subtree: true });
}

function actualizarBadgeCarrito() {
  const badge = document.getElementById("cart-badge");
  if (!badge) return;

  const carrito = JSON.parse(localStorage.getItem("carrito")) || [];
  if (carrito.length > 0) {
    badge.classList.remove("d-none"); // mostrar badge
  } else {
    badge.classList.add("d-none"); // ocultar badge
  }
}

function sumarCantidad(id) {
  let carrito = JSON.parse(localStorage.getItem("carrito")) || [];
  const producto = carrito.find((item) => item.id === id);
  if (producto) {
    producto.cantidad += 1;
  }

  localStorage.setItem("carrito", JSON.stringify(carrito));
  renderCarrito();
  actualizarBadgeCarrito();
}

function restarCantidad(id) {
  let carrito = JSON.parse(localStorage.getItem("carrito")) || [];
  const producto = carrito.find((item) => item.id === id);

  if (producto) {
    if (producto.cantidad <= 1) {
      // Si ya está en 1, restar lo elimina por completo
      carrito = carrito.filter((item) => item.id !== id);
    } else {
      producto.cantidad -= 1;
    }
  }

  localStorage.setItem("carrito", JSON.stringify(carrito));
  renderCarrito();
  actualizarBadgeCarrito();
}

function eliminarProducto(id) {
  let carrito = JSON.parse(localStorage.getItem("carrito")) || [];
  carrito = carrito.filter((item) => item.id !== id);

  localStorage.setItem("carrito", JSON.stringify(carrito));
  renderCarrito();
  actualizarBadgeCarrito();
}

window.onload = () => {
  renderCarrito();
  actualizarBadgeCarrito();
};
