/* =========================================================
   MIS PEDIDOS — ZONA HUELLA
   =========================================================
   Lee la lista de pedidos del usuario desde la API,
   y la pinta agrupada por fecha, con búsqueda, filtro por
   categoría y orden por fecha.
   ========================================================= */


document.addEventListener("DOMContentLoaded", async () => {

    const groupsContainer = document.getElementById("ordersGroups");
    const emptyState      = document.getElementById("ordersEmpty");
    const countLabel      = document.getElementById("ordersCount");
    const searchInput     = document.getElementById("ordersSearch");
    const categoriaSelect = document.getElementById("filterCategoria");
    const fechaSelect      = document.getElementById("filterFecha");

    const detailModalEl  = document.getElementById("orderDetailModal");
    const detailBody     = document.getElementById("orderDetailBody");
    const detailModal    = new bootstrap.Modal(detailModalEl);

    let pedidos = [];
    try {
        pedidos = (await ZonaAPI.request('/api/pedidos?usuarioId='+ZonaAPI.userId())).map(p => ({
            id: String(p.idPedido), fecha: p.fechaPedido.slice(0,10), estado: p.estado || 'registrado',
            categoria: (p.detalles?.[0]?.producto?.especies?.[0]?.nombre || '').toLowerCase() === 'perro' ? 'perros' : (p.detalles?.[0]?.producto?.especies?.[0]?.nombre || '').toLowerCase() === 'gato' ? 'gatos' : '',
            producto: (p.detalles || []).map(d => d.producto.nombre).join(', '),
            cantidad: (p.detalles || []).reduce((n,d)=>n+d.cantidad,0), vendedor: 'Zona Huella', detalles:p.detalles || []
        }));
    } catch(error) { ZonaAPI.error(error); }


    render();

    searchInput.addEventListener("input", render);
    categoriaSelect.addEventListener("change", render);
    fechaSelect.addEventListener("change", render);

    groupsContainer.addEventListener("click", handleGroupsClick);


    /* -----------------------------------------------------
       OBTENER / GENERAR PEDIDOS
       ----------------------------------------------------- */

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

        pedido.detalles.forEach(d => {
            const p = ZonaAPI.product(d.producto);
            for(let i=0;i<d.cantidad;i++) agregarProductoAlCarrito({id:p.id,nombre:p.nombre,precio:p.precio,img:p.imagen});
        });

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