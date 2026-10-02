// Conexión compartida con el backend de Zona Huella.
window.ZonaAPI = {
	base:
		window.ZONA_API_URL ||
		`${window.location.protocol}//${window.location.hostname}:8080`,
	async request(path, method = "GET", body) {
		const response = await fetch(this.base + path, {
			method,
			headers: body === undefined ? {} : { "Content-Type": "application/json" },
			body: body === undefined ? undefined : JSON.stringify(body),
		});
		if (!response.ok) {
			const responseText = await response.text();
			const messages = {
				401: "Correo o contraseña incorrectos.",
				404: "No se encontró el registro.",
				409: "Ese correo ya está registrado.",
			};
			let serverMessage = responseText.trim();
			try {
				const body = JSON.parse(serverMessage);
				serverMessage = body.message || body.error || serverMessage;
			} catch {}
			throw new Error(
				serverMessage ||
					messages[response.status] ||
					`No se pudo completar la operación (${response.status}).`,
			);
		}
		const text = await response.text();
		return text ? JSON.parse(text) : null;
	},
	userId() {
		const id = Number(localStorage.getItem("usuarioId"));
		if (!id) throw new Error("Inicia sesión para continuar.");
		return id;
	},
	product(p) {
		return {
			...p,
			precio:
				p.enOferta && Number(p.descuento) > 0
					? Math.round(Number(p.precio) * (100 - Number(p.descuento))) / 100
					: Number(p.precio),
			id: String(p.idProducto),
			imagen:
				(p.imagenes || []).slice().sort((a, b) => a.orden - b.orden)[0]
					?.fuente || "",
		};
	},
	async searchProducts(term) {
		if (!term.trim()) return this.products();
		const query = encodeURIComponent(term.trim());
		const [names, brands] = await Promise.all([
			this.request("/api/productos/buscar/nombre?nombre=" + query),
			this.request("/api/productos/buscar/marca?marca=" + query),
		]);
		const unique = new Map([...names, ...brands].map((p) => [p.idProducto, p]));
		return [...unique.values()].map((p) => this.product(p));
	},
	async catalog(filters = {}, term = "", offers = false) {
		const groups = [];
		for (const [key, values] of Object.entries(filters)) {
			if (!values.length) continue;
			groups.push(
				Promise.all(
					values.map((value) =>
						this.request(
							"/api/productos/" + key + "/" + encodeURIComponent(value),
						),
					),
				).then((lists) => [
					...new Map(lists.flat().map((p) => [p.idProducto, p])).values(),
				]),
			);
		}
		if (offers) groups.push(this.request("/api/productos/ofertas"));
		if (term.trim()) groups.push(this.searchProducts(term));
		if (!groups.length) return this.products();
		const lists = await Promise.all(groups);
		const remaining = lists
			.slice(1)
			.map((list) => new Set(list.map((p) => String(p.idProducto ?? p.id))));
		return lists[0]
			.filter((p) =>
				remaining.every((ids) => ids.has(String(p.idProducto ?? p.id))),
			)
			.map((p) =>
				p.idProducto === undefined || p.id !== undefined ? p : this.product(p),
			);
	},
	photoUrl(path) {
		return path && path.startsWith("/api/mascotas/fotos/")
			? this.base + path
			: path;
	},
	async uploadPetPhoto(file) {
		const data = new FormData();
		data.append("foto", file);
		const response = await fetch(this.base + "/api/mascotas/fotos", {
			method: "POST",
			body: data,
		});
		if (!response.ok)
			throw new Error("No se pudo subir la foto. Usa JPG o PNG de hasta 5 MB.");
		return (await response.json()).foto;
	},
	async recommendedProducts() {
		const uid = Number(localStorage.getItem("usuarioId"));
		const setting = uid
			? JSON.parse(
					localStorage.getItem("recomendacionesMascota:" + uid) || "null",
				)
			: null;
		if (!setting?.enabled) return this.products();
		const pets = await this.request("/api/mascotas?usuarioId=" + uid);
		const pet = pets.find((p) => p.idMascota === setting.petId);
		if (!pet?.especie || !pet.etapaVida || !pet.tamanio) return [];
		return this.catalog({
			especie: [pet.especie.nombre],
			etapa: [pet.etapaVida.nombre],
			tamanio: [pet.tamanio.nombre],
		});
	},
	async products() {
		return (await this.request("/api/productos")).map((p) => this.product(p));
	},
	async favorite(id, selected) {
		return this.request(
			`/api/favoritos?usuarioId=${this.userId()}&productoId=${Number(id)}`,
			selected ? "POST" : "DELETE",
		);
	},
	error(error) {
		console.error(error);
		alert(
			error.message ||
				"No se pudo conectar con el backend. Comprueba que esté iniciado.",
		);
	},
};
