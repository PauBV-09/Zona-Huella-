// ==========================================================================
// 1. LECTURA DE USUARIOS REGISTRADOS (Array guardado por Register.js)
// ==========================================================================
let usuariosRegistrados = JSON.parse(localStorage.getItem('usuarios')) || [];

// Usuarios de prueba por defecto, en formato array, solo si no hay ninguno guardado
if (usuariosRegistrados.length === 0) {
    usuariosRegistrados = [
        { username: "admin", password: "Password123" },
        { username: "equipo@zonahuella.com", password: "Huella2026" },
        { username: "FullStackers", password: "Contraseña123" }
    ];
    localStorage.setItem('usuarios', JSON.stringify(usuariosRegistrados));
}


// ==========================================================================
// 2. DETECCIÓN ADAPTATIVA Y SEGURA DE ELEMENTOS HTML
// ==========================================================================
const userInput = document.getElementById('username') || 
document.getElementById('reg-username') || 
document.querySelector('input[type="text"]');

const passwordInput = document.getElementById('password') || 
document.getElementById('reg-password') || 
document.querySelector('input[type="password"]');

const loginForm = document.getElementById('loginForm') || 
document.getElementById('registerForm') || 
document.querySelector('form');

// ==========================================================================
// 3. CONTROLADOR DE INICIO DE SESIÓN
// ==========================================================================
if (loginForm) {
    loginForm.addEventListener('submit', function(event) {
        event.preventDefault();
        
        if (!userInput || !passwordInput) {
            console.error("❌ Error Crítico: No se pudieron localizar los campos de entrada de datos en el HTML.");
            alert("Ocurrió un problema técnico en la interfaz. Por favor, repórtalo con soporte.");
            return;
        }

        const usuario = userInput.value.trim();
        const password = passwordInput.value;
        
        if (usuario === "" || password === "") {
            alert("⚠️ Por favor, llena todos los campos necesarios.");
            if (usuario === "") userInput.focus();
            else passwordInput.focus();
            return;
        }
        
        console.log("Intentando iniciar sesión con el usuario:", usuario);
        
        // Buscamos el usuario dentro del array
        const usuarioEncontrado = usuariosRegistrados.find(u => u.username === usuario);
        
        if (usuarioEncontrado) {
            if (usuarioEncontrado.password === password) {
                alert(`¡Qué onda, ${usuario}! Has iniciado sesión correctamente. 🎉`);
                localStorage.setItem('sesionActiva', usuario);
                window.location.href = '../index.html';
            } else {
                alert("❌ Contraseña incorrecta. Inténtalo de nuevo.");
                passwordInput.value = "";
                passwordInput.focus();
            }
        } else {
            alert("❌ El nombre de usuario o correo no se encuentra registrado.");
            userInput.focus();
        }
    });
} else {
    console.warn("⚠️ Advertencia: No se encontró ninguna etiqueta <form> en este archivo HTML.");
    
    const usuarioEncontrado = usuariosRegistrados.find(
        u => u.username === usuario || u.email === usuario
    );
}
