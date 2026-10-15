document.addEventListener("DOMContentLoaded", () => {

    const btnAviso = document.getElementById("btnAviso");
    const modalPrivacidad = document.getElementById("modalPrivacidad");
    const cerrarAviso = document.getElementById("cerrarAviso");

    // Abrir 
    btnAviso.addEventListener("click", () => {
        modalPrivacidad.classList.add("activo");

    });
    // Cerrar
    cerrarAviso.addEventListener("click", () => {
        modalPrivacidad.classList.remove("activo");
    });

    // Cerrar con la tecla ESC
    document.addEventListener("keydown", (event) => {
        if (event.key === "Escape") {
            modalPrivacidad.classList.remove("activo");
        }
    });

    // Validar checkbox antes de enviar
    const formulario = document.getElementById("FormContact");
    const checkbox = document.getElementById("acepto");
    const errorAviso = document.getElementById("errorAviso");

    formulario.addEventListener("submit", (event) => {

        if (!checkbox.checked) {
            event.preventDefault();
            errorAviso.textContent =
              "Debes aceptar el Aviso de Privacidad para continuar !";
            errorAviso.style.color = "#FF7E29";
        } else {
            errorAviso.textContent = "";
        }

    });

});