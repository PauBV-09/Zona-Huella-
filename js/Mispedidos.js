/* =========================================================
   MIS PEDIDOS — ZONA HUELLA
   =========================================================
   Lee (o genera, si no existen) la lista de pedidos del
   usuario desde localStorage, cada uno con su propio ID único,
   y la pinta agrupada por fecha, con búsqueda, filtro por
   categoría y orden por fecha.
   ========================================================= */

const ORDERS_STORAGE_KEY = "pedidosZonaHuella";
const CART_STORAGE_KEY   = "carritoZonaHuella";

document.addEventListener("DOMContentLoaded", () => {

    const groupsContainer = document.getElementById("ordersGroups");
    const emptyState      = document.getElementById("ordersEmpty");
    const countLabel      = document.getElementById("ordersCount");
    const searchInput     = document.getElementById("ordersSearch");
    const categoriaSelect = document.getElementById("filterCategoria");
    const fechaSelect      = document.getElementById("filterFecha");

    const detailModalEl  = document.getElementById("orderDetailModal");
    const detailBody     = document.getElementById("orderDetailBody");
    const detailModal    = new bootstrap.Modal(detailModalEl);

    let pedidos = getPedidos();

    render();

    searchInput.addEventListener("input", render);
    categoriaSelect.addEventListener("change", render);
    fechaSelect.addEventListener("change", render);

    groupsContainer.addEventListener("click", handleGroupsClick);


    /* -----------------------------------------------------
       OBTENER / GENERAR PEDIDOS
       ----------------------------------------------------- */

    function getPedidos() {
        const stored = localStorage.getItem(ORDERS_STORAGE_KEY);

        if (stored) {
            return JSON.parse(stored);
        }

        const seed = buildSeedPedidos();
        localStorage.setItem(ORDERS_STORAGE_KEY, JSON.stringify(seed));
        return seed;
    }

    // Datos de ejemplo, solo para que la página no se vea vacía la
    // primera vez. En cuanto conectes tu flujo real de compra, en
    // vez de esto deberías llamar a addPedido(...) (ver abajo) cada
    // vez que el usuario complete una compra.
    function buildSeedPedidos() {
        return [
            {
                id: generatePedidoId(1),
                fecha: "2026-08-06",
                estado: "entregado",
                categoria: "gatos",
                producto: "Arena aglomerante para gatos 10kg",
                cantidad: 1,
                vendedor: "Tienda oficial Zona Huella"
            },
            {
                id: generatePedidoId(2),
                fecha: "2026-08-06",
                estado: "camino",
                categoria: "perros",
                producto: "Correa retráctil para perro mediano",
                cantidad: 1,
                vendedor: "PetSupplies MX"
            },
            {
                id: generatePedidoId(3),
                fecha: "2026-07-25",
                estado: "entregado",
                categoria: "perros",
                producto: "Croquetas adulto raza pequeña 3kg",
                cantidad: 2,
                vendedor: "Tienda oficial Zona Huella"
            },
            {
                id: generatePedidoId(4),
                fecha: "2026-07-25",
                estado: "cancelado",
                categoria: "ofertas",
                producto: "Rascador para gato con torre",
                cantidad: 1,
                vendedor: "CatWorld"
            }
        ];
    }

    function generatePedidoId(secuencia) {
        const year = new Date().getFullYear();
        return `ZH-${year}-${String(secuencia).padStart(6, "0")}`;
    }

    // Úsala desde tu flujo de compra real para agregar un pedido
    // nuevo con un ID único generado automáticamente.
    function addPedido(datosPedido) {
        const nuevoId = generatePedidoId(pedidos.length + 1);
        const pedido = { id: nuevoId, fecha: new Date().toISOString().slice(0, 10), ...datosPedido };

        pedidos.push(pedido);
        localStorage.setItem(ORDERS_STORAGE_KEY, JSON.stringify(pedidos));

        return pedido;
    }


    /* -----------------------------------------------------
       RENDER
       ----------------------------------------------------- */

    function render() {
        const filtrados = applyFilters(pedidos);

        countLabel.textContent = `${filtrados.length} ${filtrados.length === 1 ? "pedido" : "pedidos"}`;

        if (filtrados.length === 0) {
            groupsContainer.innerHTML = "";
            emptyState.classList.remove("d-none");
            return;
        }

        emptyState.classList.add("d-none");
        groupsContainer.innerHTML = buildGroupsHtml(filtrados);
    }

    function applyFilters(lista) {
        const texto = searchInput.value.trim().toLowerCase();
        const categoria = categoriaSelect.value;

        let resultado = lista.filter((pedido) => {
            const coincideTexto = !texto
                || pedido.producto.toLowerCase().includes(texto)
                || pedido.vendedor.toLowerCase().includes(texto)
                || pedido.id.toLowerCase().includes(texto);

            const coincideCategoria = categoria === "todas" || pedido.categoria === categoria;

            return coincideTexto && coincideCategoria;
        });

        resultado.sort((a, b) => {
            const diferencia = new Date(a.fecha) - new Date(b.fecha);
            return fechaSelect.value === "recientes" ? -diferencia : diferencia;
        });

        return resultado;
    }

    function buildGroupsHtml(lista) {
        const grupos = new Map();

        lista.forEach((pedido) => {
            if (!grupos.has(pedido.fecha)) {
                grupos.set(pedido.fecha, []);
            }
            grupos.get(pedido.fecha).push(pedido);
        });

        return Array.from(grupos.entries())
            .map(([fecha, pedidosDelDia]) => `
                <section class="orders-group">
                    <div class="orders-group-header">
                        <span class="orders-group-date">${formatearFecha(fecha)}</span>
                        <button type="button" class="orders-group-action" data-action="recomprar-grupo" data-fecha="${fecha}">
                            Volver a comprar todo
                        </button>
                    </div>
                    ${pedidosDelDia.map(buildOrderCardHtml).join("")}
                </section>
            `)
            .join("");
    }

    function buildOrderCardHtml(pedido) {
        return `
            <article class="order-card" data-id="${pedido.id}">
                <div class="order-thumb">
                    <i class="bi ${iconoPorCategoria(pedido.categoria)}"></i>
                </div>

                <div class="order-info">
                    <span class="order-status status-${pedido.estado}">${etiquetaEstado(pedido.estado)}</span>
                    <p class="order-product">${pedido.producto}</p>
                    <p class="order-meta">Cantidad: ${pedido.cantidad} · ID: ${pedido.id}</p>
                    <p class="order-seller">Vendido por <strong>${pedido.vendedor}</strong></p>
                </div>

                <div class="order-actions">
                    <button type="button" class="btn-order-primary" data-action="ver">Ver pedido</button>
                    <button type="button" class="btn-order-secondary" data-action="recomprar">Volver a comprar</button>
                </div>
            </article>
        `;
    }

    function etiquetaEstado(estado) {
        const etiquetas = {
            entregado: "Entregado",
            camino: "En camino",
            cancelado: "Cancelado"
        };
        return etiquetas[estado] || estado;
    }

    function iconoPorCategoria(categoria) {
        const iconos = {
            perros: "bi-dribbble", // reemplaza por el ícono/imagen real de tu catálogo
            gatos: "bi-egg",
            ofertas: "bi-tag"
        };
        return iconos[categoria] || "bi-box-seam";
    }

    function formatearFecha(fechaISO) {
        const fecha = new Date(`${fechaISO}T00:00:00`);
        return fecha.toLocaleDateString("es-MX", { day: "numeric", month: "long" });
    }


    /* -----------------------------------------------------
       ACCIONES (ver detalle / volver a comprar)
       ----------------------------------------------------- */

    function handleGroupsClick(event) {
        const boton = event.target.closest("button[data-action]");
        if (!boton) return;

        const accion = boton.dataset.action;

        if (accion === "ver") {
            const id = boton.closest(".order-card").dataset.id;
            mostrarDetalle(id);
        }

        if (accion === "recomprar") {
            const id = boton.closest(".order-card").dataset.id;
            agregarAlCarrito(id);
        }

        if (accion === "recomprar-grupo") {
            const fecha = boton.dataset.fecha;
            pedidos
                .filter((pedido) => pedido.fecha === fecha)
                .forEach((pedido) => agregarAlCarrito(pedido.id, { silencioso: true }));

            boton.textContent = "¡Agregado al carrito!";
            setTimeout(() => (boton.textContent = "Volver a comprar todo"), 1800);
        }
    }

    function mostrarDetalle(id) {
        const pedido = pedidos.find((p) => p.id === id);
        if (!pedido) return;

        detailBody.innerHTML = `
            <div class="orders-detail-row"><span>ID del pedido</span><span>${pedido.id}</span></div>
            <div class="orders-detail-row"><span>Producto</span><span>${pedido.producto}</span></div>
            <div class="orders-detail-row"><span>Cantidad</span><span>${pedido.cantidad}</span></div>
            <div class="orders-detail-row"><span>Estado</span><span>${etiquetaEstado(pedido.estado)}</span></div>
            <div class="orders-detail-row"><span>Fecha</span><span>${formatearFecha(pedido.fecha)}</span></div>
            <div class="orders-detail-row"><span>Vendedor</span><span>${pedido.vendedor}</span></div>
        `;

        detailModal.show();
    }

    function agregarAlCarrito(id, opciones = {}) {
        const pedido = pedidos.find((p) => p.id === id);
        if (!pedido) return;

        const carrito = JSON.parse(localStorage.getItem(CART_STORAGE_KEY) || "[]");
        carrito.push({
            producto: pedido.producto,
            cantidad: pedido.cantidad,
            precioReferencia: null // reemplaza con el precio real de tu catálogo
        });
        localStorage.setItem(CART_STORAGE_KEY, JSON.stringify(carrito));

        if (!opciones.silencioso) {
            const boton = groupsContainer.querySelector(`.order-card[data-id="${id}"] .btn-order-secondary`);
            if (boton) {
                const textoOriginal = boton.textContent;
                boton.textContent = "¡Agregado!";
                setTimeout(() => (boton.textContent = textoOriginal), 1500);
            }
        }
    }

});