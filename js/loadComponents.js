// Carga asíncrona de componentes modulares
async function loadComponent(elementId, filePath) {
  try {
    const response = await fetch(filePath);
    if (!response.ok) {
      throw new Error(`Error al cargar el archivo ${filePath}: ${response.statusText}`);
    }
    const html = await response.text();
    const container = document.getElementById(elementId);
    
     if (container) {
      // 1. Primero inyectamos el HTML en la página
      container.innerHTML = html;
      
      // 2. Ejecutamos la actualización porque el HTML ya existe en el DOM
      if (elementId === 'navbar-container') {
        actualizarNavbar();
      }
      
      // Actualizar automáticamente el año si es el footer
      if (elementId === 'footer-container') {
        const yearElement = document.getElementById('current-year');
        if (yearElement) {
          yearElement.textContent = new Date().getFullYear();
        }
      }
      
    }
  } catch (error) {
    console.error(error);
  }
}
 // Funcion para alterar el botón de Cuenta segun si esta activo
 function actualizarNavbar(){
   const cuentaLink = document.getElementById("nav-cuenta-link");
   if(!cuentaLink) return; //Si no encuentra el botón, detiene la función
   //Comprobamos si hay un usuario logeado en el almacenamiento local
   const usuarioLogeado = localStorage.getItem("usuario");
   if(usuarioLogeado){
    cuentaLink.href = "../html/miCuenta.html";
    cuentaLink.title = "Mi Cuenta";
    cuentaLink.innerHTML = '<i class="bi bi-person-circle fs-5 d-inline d-lg-none"></i><span class="d-none d-lg-inline">Mi cuenta</span>';
   }else{
    cuentaLink.href = "../html/login.html"
    cuentaLink.title = "Cuenta";
    cuentaLink.innerHTML = '<i class="bi bi-person-circle fs-5 d-inline d-lg-none"></i><span class="d-none d-lg-inline">Iniciar Sesión</span>';
   }
 }

// Inyección automática al cargar el documento
document.addEventListener('DOMContentLoaded', () => {
  loadComponent('navbar-container', '../components/navbar.html');
  loadComponent('footer-container', '../components/footer.html');
});