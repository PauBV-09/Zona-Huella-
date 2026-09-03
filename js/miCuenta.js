const buttons = document.querySelectorAll(".barra_lateral button");
const sections = document.querySelectorAll(".section");

buttons.forEach((btn) => {
	btn.addEventListener("click", () => {
		// quitar active de todos
		buttons.forEach((b) => b.classList.remove("active"));
		// poner active al clicado
		btn.classList.add("active");

		// ocultar todas las secciones
		sections.forEach((sec) => (sec.style.display = "none"));
		// mostrar la sección correspondiente
		const target = btn.getAttribute("data-target");
		document.getElementById(target).style.display = "block";
	});
});
