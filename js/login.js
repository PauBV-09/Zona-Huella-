const loginForm = document.querySelector('form');
loginForm.addEventListener('submit', async event => {
    event.preventDefault();
    try {
        const user = await ZonaAPI.request('/api/usuarios/login', 'POST', {
            email: document.getElementById('username').value.trim(),
            contrasenia: document.getElementById('password').value
        });
        localStorage.setItem('usuario', user.nombre);
        localStorage.setItem('usuarioId', user.idUsuario);
        localStorage.setItem('usuarioEmail', user.email);
        localStorage.removeItem('carrito');
        sessionStorage.removeItem('direccionPedido');
        window.location.href = '../index.html';
    } catch (error) { ZonaAPI.error(error); }
});
