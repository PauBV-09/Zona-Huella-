document.addEventListener('DOMContentLoaded', async () => {
    try {
        const id = new URLSearchParams(location.search).get('id');
        if (!id) throw new Error('Selecciona un producto desde el catálogo.');
        const p = ZonaAPI.product(await ZonaAPI.request('/api/productos/' + encodeURIComponent(id)));
        const text = (selector,value) => {document.querySelector(selector).textContent = value;};
        text('.product-name', p.nombre); text('.product-price', '$' + Number(p.precio).toFixed(2));
        text('.product-summary', p.descripcion || '');
        text('.product-category', (p.categorias || []).map(c => c.nombre).join(', '));
        text('.stock-status', p.stock > 0 ? 'Disponible' : 'Agotado');
        const descriptions = document.querySelectorAll('.description-content p');
        descriptions[0].textContent = p.descripcion || ''; descriptions[1].textContent = '';
        const details = document.querySelectorAll('.detail-value');
        details[0].textContent = p.marca; details[1].textContent = (p.categorias || []).map(c=>c.nombre).join(', ');
        details[2].textContent = (p.especies || []).map(c=>c.nombre).join(', ');
        const images = (p.imagenes || []).slice().sort((a,b)=>a.orden-b.orden);
        let current = 0;
        const main = document.getElementById('mainProductImage');
        const show = () => {if (images.length) main.src = images[current].fuente; main.alt = p.nombre;};
        const thumbnails = document.querySelector('.thumbnail-list'); thumbnails.replaceChildren();
        images.forEach((image,i) => {
            const button = document.createElement('button'); button.className = 'thumbnail'; button.type = 'button';
            const img = document.createElement('img'); img.src = image.fuente; img.alt = p.nombre; button.append(img);
            button.onclick = () => {current = i; show();}; thumbnails.append(button);
        });
        document.querySelectorAll('.previous-image,.previous-thumbnail').forEach(b => b.onclick = () => {current = (current+images.length-1)%images.length; show();});
        document.querySelectorAll('.next-image,.next-thumbnail').forEach(b => b.onclick = () => {current = (current+1)%images.length; show();}); show();
        let quantity = 1;
        const quantityLabel = document.getElementById('productQuantity');
        document.querySelectorAll('.quantity-button').forEach((b,i) => b.onclick = () => {
            quantity = Math.max(1, Math.min(p.stock || 1, quantity+(i ? 1 : -1))); quantityLabel.textContent = quantity;
        });
        const add = document.querySelector('.add-cart-button'); add.disabled = !p.stock;
        add.onclick = () => {
            try {ZonaAPI.userId(); for(let i=0;i<quantity;i++) agregarProductoAlCarrito({id:p.id,nombre:p.nombre,precio:p.precio,img:p.imagen}); alert('Producto agregado al carrito.');}
            catch(error) {ZonaAPI.error(error);}
        };
        const favorite = document.querySelector('.fav-btn');
        const selected = value => {favorite.classList.toggle('favorito',value); favorite.textContent = value ? '❤️' : '♡'; favorite.setAttribute('aria-pressed',value);};
        if (localStorage.getItem('usuarioId')) selected(await ZonaAPI.request(`/api/favoritos/verificar?usuarioId=${ZonaAPI.userId()}&productoId=${id}`));
        favorite.onclick = async () => {try {const value = !favorite.classList.contains('favorito'); await ZonaAPI.favorite(id,value); selected(value);} catch(error) {ZonaAPI.error(error);}};
    } catch(error) {ZonaAPI.error(error);}
});
