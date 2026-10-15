const botonesMenu = document.querySelectorAll(".item-menu");
const secciones = document.querySelectorAll(".seccion");
function cambiarSeccion(seccionId) {
	botonesMenu.forEach((boton) => {
		boton.classList.toggle("activo", boton.dataset.seccion === seccionId);
	});
	secciones.forEach((seccion) => {
		seccion.classList.toggle("activa", seccion.id === seccionId);
	});
}
botonesMenu.forEach((boton) => {
	boton.addEventListener("click", () => {
		cambiarSeccion(boton.dataset.seccion);
	});
});