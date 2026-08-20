// Captura el formulario usando exactamente tu ID 'loginForm'
const loginForm = document.getElementById('loginForm');

// Escucha el evento cuando el usuario presiona el botón para acceder
loginForm.addEventListener('submit', function(event) {
    
    // Evita que la página se recargue automáticamente
    event.preventDefault(); 
    
    // Captura los valores que el usuario escribió
    const usernameInput = document.getElementById('username').value;
    const passwordInput = document.getElementById('password').value;
    
    // Validación básica en español de México
    if (usernameInput.trim() === "" || passwordInput.trim() === "") {
        alert("⚠️ Por favor, llena todos los campos necesarios.");
    } else {
        console.log("Intentando iniciar sesión con el usuario:", usernameInput);
        alert(`¡Qué onda, ${usernameInput}! Has iniciado sesión correctamente.`);
        
    }
});

