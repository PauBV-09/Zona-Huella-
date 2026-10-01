const buttons = document.querySelectorAll(".barra_lateral button");
const breadcrumbSection = document.getElementById("breadcrumb_section");
const sections = document.querySelectorAll(".section");

const modalCerrarSesion = document.getElementById("modal-cerrar-sesion");
const btnConfirmarSi = document.getElementById("btn-confirmar-si");
const btnConfirmarNo = document.getElementById("btn-confirmar-no");

buttons.forEach((btn) => {
	btn.addEventListener("click", () => {
		const target = btn.getAttribute("data-target");

		// Caso especial: cerrar sesión -> mostrar popup en lugar de cambiar de sección
		if (target === "sesion") {
			modalCerrarSesion.style.display = "flex";
			return;
		}

		// quitar active de todos
		buttons.forEach((b) => b.classList.remove("active"));
		// poner active al clicado
		btn.classList.add("active");

		// ocultar todas las secciones
		sections.forEach((sec) => (sec.style.display = "none"));
		// mostrar la sección correspondiente
		document.getElementById(target).style.display = "block";

		breadcrumbSection.textContent = btn.textContent;
	});
});

// Botón "No" del modal: simplemente cerrar el popup
btnConfirmarNo.addEventListener("click", () => {
	modalCerrarSesion.style.display = "none";
});

// Cerrar el modal si se hace clic fuera del cuadro
modalCerrarSesion.addEventListener("click", (e) => {
	if (e.target === modalCerrarSesion) {
		modalCerrarSesion.style.display = "none";
	}
});

// Botón "Sí" del modal: aquí va la lógica real de cerrar sesión
btnConfirmarSi.addEventListener("click", () => {
    // 1. Borramos al usuario del almacenamiento local
    localStorage.removeItem("usuario");
    // 2. Redirigimos inmediatamente a la pantalla de inicio de sesión
    window.location.href = "../html/login.html";
	modalCerrarSesion.style.display = "none";
});
