const favoriteButton = document.querySelector(".fav-btn");

favoriteButton.addEventListener("click", () => {

    favoriteButton.classList.toggle("favorito");

    if (favoriteButton.classList.contains("favorito")) {

        favoriteButton.textContent = "❤️";
        favoriteButton.setAttribute("aria-pressed", "true");
        favoriteButton.setAttribute(
            "aria-label",
            "Eliminar producto de favoritos"
        );

        console.log("Producto añadido a favoritos");

    } else {

        favoriteButton.textContent = "♡";
        favoriteButton.setAttribute("aria-pressed", "false");
        favoriteButton.setAttribute(
            "aria-label",
            "Añadir producto a favoritos"
        );

        console.log("Producto eliminado de favoritos");

    }

});