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
      container.innerHTML = html;
      
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

// Inyección automática al cargar el documento
document.addEventListener('DOMContentLoaded', () => {
  loadComponent('navbar-container', '../components/navbar.html');
  loadComponent('footer-container', '../components/footer.html');
});