// Diccionario local para guardar de forma temporal los usuarios y contraseñas
const usuariosRegistrados = {};

// Captura el formulario de registro por su ID
const registerForm = document.getElementById('registerForm');

registerForm.addEventListener('submit', function(event) {
    // Evita que la página se recargue sola
    event.preventDefault();

    // Captura los valores de las cajas de texto
    const username = document.getElementById('reg-username').value.trim();
    const password = document.getElementById('reg-password').value;
    const confirmPassword = document.getElementById('reg-confirm-password').value;

    // 1. Validación: Verificar que los campos no estén vacíos
    if (username === "" || password === "" || confirmPassword === "") {
        alert("⚠️ Por favor, rellena todos los campos.");
        return;
    }

    // 2. Validación: Confirmar que las dos contraseñas sean exactamente iguales
    if (password !== confirmPassword) {
        alert("❌ Las contraseñas no coinciden. Por favor, verifícalas bien.");
        return;
    }

    // 3. Guardar en el diccionario (la clave es el usuario y el valor es la contraseña)
    usuariosRegistrados[username] = password;
    console.log("Diccionario de usuarios actualizado:", usuariosRegistrados);

});
