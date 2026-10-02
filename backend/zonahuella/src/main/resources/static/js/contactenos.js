const btn = document.querySelector("button");
btn.addEventListener("click", () => {
  btn.textContent = "Enviado";
  setTimeout(() => {
    btn.textContent = "Enviar";
  }, 1000);
});