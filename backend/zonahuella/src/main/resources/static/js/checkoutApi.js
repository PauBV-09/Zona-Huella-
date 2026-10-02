document.addEventListener('DOMContentLoaded', async () => {
    const shipping = document.getElementById('form-envio');
    const payment = document.querySelector('.tarjeta-pago');
    const cart = JSON.parse(localStorage.getItem('carrito') || '[]');
    const list = document.getElementById('lista-pedido') || document.querySelector('.resumen-detalles');
    const total = document.getElementById('total-pedido') || document.querySelector('.total-pedido strong');
    if(list) {list.replaceChildren(); cart.forEach(p => {const row=document.createElement('p'); row.textContent=`${p.nombre} × ${p.cantidad} — $${(p.precio*p.cantidad).toFixed(2)}`;list.append(row);});}
    if(total) total.textContent = '$'+cart.reduce((n,p)=>n+p.precio*p.cantidad,0).toFixed(2);
    let uid;
    try {uid=ZonaAPI.userId();} catch(error) {ZonaAPI.error(error); return;}
    const value = id => document.getElementById(id).value.trim();
    if(shipping) {
        let previous;
        try {
            const [user,addresses] = await Promise.all([ZonaAPI.request('/api/usuarios/'+uid),ZonaAPI.request('/api/v1/direcciones?usuarioId='+uid)]);
            const names=user.nombre.split(/\s+/); document.getElementById('nombre').value=names.shift();document.getElementById('apellidos').value=names.join(' ');
            previous=addresses.find(a=>a.idDireccion===Number(sessionStorage.getItem('direccionPedido'))) || addresses[0];
            if(previous) {document.getElementById('calle').value=previous.calle+' '+previous.numero; ['codigoPostal','ciudad','estado','referencias','alcaldiaMunicipio'].forEach(id=>document.getElementById(id).value=previous[id] || '');}
        } catch(error) {ZonaAPI.error(error);}
        shipping.addEventListener('submit', async e => {
            e.preventDefault();const button=document.getElementById('btn-continuar');button.disabled=true;
            try {
                if(!cart.length) throw new Error('Tu carrito está vacío.');
                const street=value('calle').match(/^(.+?)\s+(\d+\S*)$/);
                if(!street) throw new Error('Escribe la calle seguida del número, por ejemplo: Avenida Reforma 125.');
                const reuse=previous && document.getElementById('guardarDireccion').checked;
                const address=await ZonaAPI.request('/api/v1/direcciones'+(reuse ? '/'+previous.idDireccion : ''),reuse ? 'PUT' : 'POST',{
                    idUsuario:uid,calle:street[1],numero:street[2],alcaldiaMunicipio:value('alcaldiaMunicipio'),ciudad:value('ciudad'),estado:value('estado'),codigoPostal:value('codigoPostal'),referencias:value('referencias')
                });
                sessionStorage.setItem('direccionPedido',address.idDireccion);location.href='metodoPago.html';
            } catch(error) {ZonaAPI.error(error);button.disabled=false;}
        });
    }
    if(payment) {
        const toggle=()=>{const card=payment.querySelector('[name="metodo-pago"]:checked').value==='tarjeta';document.querySelector('.datos-tarjeta').hidden=!card;document.querySelector('.datos-transferencia').hidden=card;};
        payment.querySelectorAll('[name="metodo-pago"]').forEach(r=>r.addEventListener('change',toggle));toggle();
        const button=payment.querySelector('.btn-pagar');
        const create=async e=>{
            e.preventDefault();if(button.disabled) return;button.disabled=true;
            try {
                const address=Number(sessionStorage.getItem('direccionPedido'));
                if(!address) throw new Error('Selecciona primero la dirección de envío.');
                if(!cart.length || cart.some(p=>!Number.isInteger(Number(p.id)))) throw new Error('Agrega productos del catálogo conectado antes de realizar el pedido.');
                if(!payment.querySelector('[name="terminos"]').checked) throw new Error('Acepta los términos de compra.');
                const order=await ZonaAPI.request('/api/pedidos','POST',{idUsuario:uid,idDireccion:address,metodoPago:payment.querySelector('[name="metodo-pago"]:checked').value,notas:'',detalles:cart.map(p=>({idProducto:Number(p.id),cantidad:p.cantidad}))});
                localStorage.removeItem('carrito');sessionStorage.removeItem('direccionPedido');
                alert('Pedido registrado. El pago está pendiente; esta API no procesa cobros.');location.href='detallePed.html?id='+order.idPedido;
            } catch(error) {ZonaAPI.error(error);button.disabled=false;}
        };
        button.addEventListener('click',create);payment.addEventListener('submit',create);
    }
});
