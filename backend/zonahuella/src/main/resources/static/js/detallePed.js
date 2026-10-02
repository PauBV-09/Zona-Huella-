document.addEventListener('DOMContentLoaded', async () => {
    try {
        const id=new URLSearchParams(location.search).get('id');
        if(!id) throw new Error('Selecciona un pedido desde Mis Pedidos.');
        const orders=await ZonaAPI.request('/api/pedidos?usuarioId='+ZonaAPI.userId());
        if(!orders.some(p=>String(p.idPedido)===id)) throw new Error('No se encontró este pedido en tu cuenta.');
        const p=await ZonaAPI.request('/api/pedidos/'+encodeURIComponent(id));
        document.querySelector('.pedido > h1').textContent='Pedido #'+p.idPedido;
        document.querySelector('.inPed').textContent='Inicio / Pedido #'+p.idPedido;
        document.querySelector('#preparation h1').textContent=p.estado || 'Pedido registrado';
        document.querySelector('.date').textContent='Realizado el '+new Date(p.fechaPedido).toLocaleDateString('es-MX');
        const list=document.querySelector('.productos');list.replaceChildren();
        (p.detalles || []).forEach(d=>{
            const product=ZonaAPI.product(d.producto),row=document.createElement('div');row.className='productos-ind';
            const img=document.createElement('img');img.className='productos-img';img.alt=product.nombre;if(product.imagen) img.src=product.imagen;
            const info=document.createElement('div');info.className='info';const name=document.createElement('h3');name.textContent=product.nombre;const count=document.createElement('p');count.textContent='Cantidad: '+d.cantidad;info.append(name,count);
            const price=document.createElement('h3');price.className='precio';price.textContent='$'+Number(d.subtotal).toFixed(2);row.append(img,info,price);list.append(row);
        });
        document.querySelector('.entrega h4').textContent=p.usuario.nombre;
        const delivery=document.querySelectorAll('.entrega p');delivery[0].textContent=[p.direccion.calle,p.direccion.numero,p.direccion.alcaldiaMunicipio,p.direccion.ciudad,p.direccion.estado,p.direccion.codigoPostal].join(', ');delivery[1].textContent=p.direccion.referencias || '';
        document.querySelector('.resumen .resumender').textContent='$'+Number(p.total).toFixed(2);
        document.querySelector('.resumen .resumenizq[id="totalp"]').textContent='$'+Number(p.total).toFixed(2);
    } catch(error) {ZonaAPI.error(error);}
});
