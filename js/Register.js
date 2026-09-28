const registerForm = document.getElementById('registerForm');

const nombreInput = document.getElementById('reg-Nombre');
const apellidoInput = document.getElementById('reg-apellido');
const usernameInput = document.getElementById('reg-username');
const correoInput = document.getElementById('reg-correo');

const passwordInput = document.getElementById('reg-password');
const confirmPasswordInput = document.getElementById('reg-confirm-password');

const tooltip = document.getElementById('password-tooltip');

const reqLength = document.getElementById('req-length');
const reqLetters = document.getElementById('req-letters');
const reqNumbers = document.getElementById('req-numbers');

const terminosCheckbox = document.getElementById('terminos');

const btnRegistro = document.getElementById('btn-registro');


// ============================================================
// VALIDAR CONTRASEÑA
// ============================================================

function validarPassword() {

    const value = passwordInput.value;

    const hasLength = value.length >= 8;

    const hasLetters =
        /[a-z]/.test(value) &&
        /[A-Z]/.test(value);

    const hasNumbers = /\d/.test(value);


    // Actualizar indicadores visuales

    reqLength.classList.toggle('cumplido', hasLength);

    reqLetters.classList.toggle('cumplido', hasLetters);

    reqNumbers.classList.toggle('cumplido', hasNumbers);


    // Cambiar estado del tooltip

    tooltip.classList.toggle(
        'todo-valido',
        hasLength && hasLetters && hasNumbers
    );


    return (
        hasLength &&
        hasLetters &&
        hasNumbers
    );
}


// ============================================================
// VALIDAR CORREO
// ============================================================

function validarCorreo() {

    const correo = correoInput.value.trim();

    const patronCorreo = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    return patronCorreo.test(correo);
}


// ============================================================
// ACTUALIZAR ESTADO DEL BOTÓN
// ============================================================

function actualizarEstadoBoton() {

    // Datos personales

    const nombreValido =
        nombreInput.value.trim() !== "";

    const apellidoValido =
        apellidoInput.value.trim() !== "";

    const usernameValido =
        usernameInput.value.trim() !== "";

    const correoValido =
        validarCorreo();


    // Contraseña

    const passwordValida =
        validarPassword();


    // Confirmación

    const confirmMatch =
        passwordInput.value === confirmPasswordInput.value &&
        confirmPasswordInput.value !== "";


    // Términos

    const terminosAceptados =
        terminosCheckbox.checked;


    // ========================================================
    // FORMULARIO COMPLETAMENTE VÁLIDO
    // ========================================================

    const formularioValido =
        nombreValido &&
        apellidoValido &&
        usernameValido &&
        correoValido &&
        passwordValida &&
        confirmMatch &&
        terminosAceptados;


    // ========================================================
    // ACTIVAR / DESACTIVAR BOTÓN
    // ========================================================

    if (formularioValido) {

        btnRegistro.classList.add('activo');

        btnRegistro.disabled = false;

    } else {

        btnRegistro.classList.remove('activo');

        btnRegistro.disabled = true;

    }
}


// ============================================================
// ESCUCHAS EN TIEMPO REAL
// ============================================================

nombreInput.addEventListener(
    'input',
    actualizarEstadoBoton
);

apellidoInput.addEventListener(
    'input',
    actualizarEstadoBoton
);

usernameInput.addEventListener(
    'input',
    actualizarEstadoBoton
);

correoInput.addEventListener(
    'input',
    actualizarEstadoBoton
);

passwordInput.addEventListener(
    'input',
    actualizarEstadoBoton
);

confirmPasswordInput.addEventListener(
    'input',
    actualizarEstadoBoton
);

terminosCheckbox.addEventListener(
    'change',
    actualizarEstadoBoton
);


// ============================================================
// ENVÍO DEL FORMULARIO
// ============================================================

registerForm.addEventListener('submit', (e) => {

    e.preventDefault();


    // ========================================================
    // SEGUNDA VALIDACIÓN DE SEGURIDAD
    // ========================================================

    actualizarEstadoBoton();


    if (btnRegistro.disabled) {

        alert(
            'Completa todos los requisitos antes de registrarte.'
        );

        return;
    }


    // ========================================================
    // OBTENER DATOS
    // ========================================================

    const nombre =
        nombreInput.value.trim();

    const apellido =
        apellidoInput.value.trim();

    const username =
        usernameInput.value.trim();

    const correo =
        correoInput.value.trim();

    const nuevaPassword =
        passwordInput.value;


    // ========================================================
    // OBTENER USUARIOS EXISTENTES
    // ========================================================

    let usuariosRegistrados =
        JSON.parse(
            localStorage.getItem('usuarios')
        ) || [];


    // ========================================================
    // COMPROBAR USUARIO O CORREO DUPLICADO
    // ========================================================

    const existe =
        usuariosRegistrados.some(

            usuario =>
                usuario.username.toLowerCase() ===
                username.toLowerCase()

                ||

                usuario.email.toLowerCase() ===
                correo.toLowerCase()

        );


    if (existe) {

        alert(
            'Ese usuario o correo ya está registrado.'
        );

        return;
    }


    // ========================================================
    // CREAR NUEVO USUARIO
    // ========================================================

    const nuevoUsuario = {

        nombre: nombre,

        apellido: apellido,

        username: username,

        email: correo,

        password: nuevaPassword

    };


    // ========================================================
    // GUARDAR EN LOCALSTORAGE
    // ========================================================

    usuariosRegistrados.push(nuevoUsuario);

    localStorage.setItem(
        'usuarios',
        JSON.stringify(usuariosRegistrados)
    );


    // ========================================================
    // REGISTRO EXITOSO
    // ========================================================

    alert(
        '¡Registro completado correctamente!'
    );


    // ========================================================
    // REDIRECCIÓN AL LOGIN
    // ========================================================

    window.location.href = 'login.html';

});


// ============================================================
// ESTADO INICIAL
// ============================================================

actualizarEstadoBoton();