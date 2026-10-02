document.addEventListener("DOMContentLoaded", async () => {
	try {
		if (location.hash === "#favoritos")
			document.querySelector('[data-target="favoritos"]').click();
		const uid = ZonaAPI.userId();
		const [user, addresses, pets, favorites] = await Promise.all([
			ZonaAPI.request("/api/usuarios/" + uid),
			ZonaAPI.request("/api/v1/direcciones?usuarioId=" + uid),
			ZonaAPI.request("/api/mascotas?usuarioId=" + uid),
			ZonaAPI.request("/api/favoritos?usuarioId=" + uid),
		]);
		const field = (id) => document.getElementById(id);
		const names = user.nombre.trim().split(/\s+/);
		field("nombre").value = names.shift() || "";
		field("apellidos").value = names.join(" ");
		field("correo").value = user.email;
		field("telefono").value = user.telefono || "";
		// El modelo de usuario no tiene fecha de nacimiento.
		field("fecha").required = false;
		field("fecha").disabled = true;
		field("fecha").title = "La API actual no contempla fecha de nacimiento.";
		const submit = (form, action) =>
			form.addEventListener("submit", async (e) => {
				e.preventDefault();
				const button = form.querySelector('[type="submit"]');
				button.disabled = true;
				try {
					await action();
					alert("Cambios guardados correctamente.");
				} catch (error) {
					ZonaAPI.error(error);
				} finally {
					button.disabled = false;
				}
			});
		submit(document.querySelector("#datos form"), async () => {
			const saved = await ZonaAPI.request("/api/usuarios/" + uid, "PUT", {
				nombre:
					field("nombre").value.trim() + " " + field("apellidos").value.trim(),
				email: field("correo").value.trim(),
				telefono: field("telefono").value,
				rol: user.rol,
			});
			localStorage.setItem("usuario", saved.nombre);
			localStorage.setItem("usuarioEmail", saved.email);
		});
		let address = addresses[0];
		if (address)
			[
				"calle",
				"numero",
				"ciudad",
				"estado",
				"alcaldiaMunicipio",
				"codigoPostal",
			].forEach((id) => (field(id).value = address[id] || ""));
		submit(document.querySelector("#direcciones form"), async () => {
			const data = {
				idUsuario: uid,
				referencias: address?.referencias || "",
			};
			[
				"calle",
				"numero",
				"ciudad",
				"estado",
				"alcaldiaMunicipio",
				"codigoPostal",
			].forEach((id) => (data[id] = field(id).value.trim()));
			address = await ZonaAPI.request(
				"/api/v1/direcciones" + (address ? "/" + address.idDireccion : ""),
				address ? "PUT" : "POST",
				data,
			);
		});
		const catalogs = await ZonaAPI.request("/api/mascotas/catalogos");
		[
			["especie", "especies", "idEspecie"],
			["edad", "etapasVida", "idEtapaVida"],
			["tamanio", "tamanios", "idTamanio"],
		].forEach(([id, key, pk]) => {
			const select = field(id);
			select.replaceChildren(new Option("Selecciona una opción", ""));
			catalogs[key].forEach((item) =>
				select.add(new Option(item.nombre, item[pk])),
			);
		});
		let pet = pets[0];
		function showPetPhoto(source) {
			const image = field("foto_mascota_preview");
			image.hidden = !source;
			document.querySelector(".pet-photo-placeholder").hidden = Boolean(source);
			if (source) image.src = source;
			else image.removeAttribute("src");
		}
		field("foto_mascota_preview").addEventListener("error", () =>
			showPetPhoto(null),
		);
		if (pet) {
			field("nombre_mascota").value = pet.nombre;
			field("especie").value = pet.especie.idEspecie;
			field("edad").value = pet.etapaVida?.idEtapaVida || "";
			field("tamanio").value = pet.tamanio?.idTamanio || "";
			if (pet.foto) showPetPhoto(ZonaAPI.photoUrl(pet.foto));
		}
		const preferenceKey = "recomendacionesMascota:" + uid;
		const preference = JSON.parse(
			localStorage.getItem(preferenceKey) || "null",
		);
		field("recomendaciones").checked = Boolean(
			preference?.enabled && preference.petId === pet?.idMascota,
		);
		let selectedPhoto = null;
		let previewUrl = null;

		field("foto_mascota").addEventListener("change", () => {
			const file = field("foto_mascota").files[0];
			if (
				file &&
				(!["image/jpeg", "image/png"].includes(file.type) ||
					file.size > 5 * 1024 * 1024)
			) {
				field("foto_mascota").value = "";
				selectedPhoto = null;
				if (previewUrl) URL.revokeObjectURL(previewUrl);
				previewUrl = null;
				showPetPhoto(ZonaAPI.photoUrl(pet?.foto));
				alert("Selecciona una foto JPG o PNG de hasta 5 MB.");
				return;
			}
			selectedPhoto = file || null;
			if (previewUrl) URL.revokeObjectURL(previewUrl);
			previewUrl = file ? URL.createObjectURL(file) : null;
			showPetPhoto(previewUrl || ZonaAPI.photoUrl(pet?.foto));
		});
		submit(document.querySelector("#perfil_mascota form"), async () => {
			const photo = selectedPhoto
				? await ZonaAPI.uploadPetPhoto(selectedPhoto)
				: pet?.foto || null;
			pet = await ZonaAPI.request(
				"/api/mascotas" + (pet ? "/" + pet.idMascota : ""),
				pet ? "PUT" : "POST",
				{
					idUsuario: uid,
					nombre: field("nombre_mascota").value.trim(),
					idEspecie: Number(field("especie").value),
					idEtapaVida: Number(field("edad").value),
					idTamanio: Number(field("tamanio").value),
					sexo: pet?.sexo || null,
					foto: photo,
				},
			);
			localStorage.setItem(
				preferenceKey,
				JSON.stringify({
					enabled: field("recomendaciones").checked,
					petId: pet.idMascota,
				}),
			);
			if (previewUrl) URL.revokeObjectURL(previewUrl);
			previewUrl = null;
			selectedPhoto = null;
			field("foto_mascota").value = "";
			showPetPhoto(ZonaAPI.photoUrl(pet.foto));
		});
		// NUEVO
		const list = field("lista-favoritos");
		list.replaceChildren();
		if (!favorites.length) list.textContent = "Todavía no tienes favoritos.";
		favorites.forEach((p) => {
			const url = "detalleProd.html?id=" + p.idProducto;
			const card = document.createElement("div");
			card.className = "favorito-card";
			// Imagen
			// Imagen
			const imgLink = document.createElement("a");
			imgLink.href = url;
			imgLink.className = "favorito-img";
			const img = document.createElement("img");
			const imagenes = (p.imagenes || [])
				.slice()
				.sort((a, b) => a.orden - b.orden);
			img.src = imagenes.length ? imagenes[0].fuente : "../img/placeholder.png";
			img.alt = p.nombre;
			imgLink.append(img);
			// Nombre y precio
			const info = document.createElement("div");
			info.className = "favorito-info";
			const nombre = document.createElement("a");
			nombre.href = url;
			nombre.className = "favorito-nombre";
			nombre.textContent = p.nombre;
			const precio = document.createElement("p");
			precio.className = "favorito-precio";
			precio.textContent = "Precio: $" + Number(p.precio).toFixed(2);
			info.append(nombre, precio);
			// Botón eliminar
			const button = document.createElement("button");
			button.type = "button";
			button.className = "favorito-eliminar";
			button.textContent = "Eliminar";
			button.onclick = async () => {
				try {
					await ZonaAPI.favorite(p.idProducto, false);
					card.remove();
				} catch (error) {
					ZonaAPI.error(error);
				}
			};
			card.append(imgLink, info, button);
			list.append(card);
		});
	} catch (error) {
		ZonaAPI.error(error);
	}
});
