-- BASE NUEVA EXCLUSIVAMENTE: tablas de datos vacías y catálogos poblados.
-- No ejecutar sobre una BD que ya tenga los cinco productos de Relleno 1.
-- Conserva los usuarios de ejemplo del original; NO son contraseñas para producción.
-- Cambiar el esquema según el equipo. Los cinco productos iniciales usan IDs 1-5 del esquema limpio.
USE zona_huella_leonel;
START TRANSACTION;

INSERT INTO Usuarios (nombre, email, contrasenia, telefono, rol)
VALUES
('Leonel Ríos', 'leonel.rios@example.com', 'Le0nel', '5512345678', 'CLIENTE'),
('Fatima Paulina', 'fatima.pau@example.com', 'Fatima123', '5587654321', 'CLIENTE'),
('Jose Esquivel', 'jose.esquivel@example.com', 'Jos33squivel', '5523456789', 'CLIENTE'),
('Cristian Hernandez', 'cristian.hernandez@example.com', 'Cr1st1an', '5598765432', 'CLIENTE'),
('Jorge Trujillo', 'jorge.trujillo@example.com', 'truji110', '5545678901', 'ADMIN'),
('Amairany Canul', 'amairany.canul@example.com', '4m4a1rany', '5523456789', 'CLIENTE'),
('Lucila Romero', 'lucila.romero@example.com', '1uci14', '5598765432', 'CLIENTE'),
('Alexis Castillo', 'alexis.castillo@example.com', '413x15', '5545678901', 'ADMIN');

INSERT INTO Direcciones
(id_usuario, calle, numero, alcaldia_municipio, ciudad, estado, codigo_postal, referencias)
VALUES
(1, 'Avenida Central', '125', 'Ecatepec de Morelos', 'Ecatepec', 'Estado de México', '55000', 'Casa blanca junto a una farmacia'),
(2, 'Calle Reforma', '48', 'Cuauhtémoc', 'Ciudad de México', 'Ciudad de México', '06600', 'Edificio azul, departamento 302'),
(3, 'Avenida Insurgentes Sur', '850', 'Benito Juárez', 'Ciudad de México', 'Ciudad de México', '03100', 'Frente al parque'),
(4, 'Calle Morelos', '217', 'Naucalpan de Juárez', 'Naucalpan', 'Estado de México', '53000', 'Casa con portón negro'),
(5, 'Avenida Universidad', '430', 'Coyoacán', 'Ciudad de México', 'Ciudad de México', '04360', 'Casa esquina con Calle Hidalgo'),
(6, 'Calle Hidalgo', '72', 'Tlalnepantla de Baz', 'Tlalnepantla', 'Estado de México', '54000', 'Casa con puerta de madera'),
(7, 'Avenida Aztecas', '315', 'Coyoacán', 'Ciudad de México', 'Ciudad de México', '04380', 'Casa frente a una tienda'),
(8, 'Calle Independencia', '96', 'Ecatepec de Morelos', 'Ecatepec', 'Estado de México', '55100', 'Portón gris, casa de dos pisos');

INSERT INTO Mascotas
(id_usuario, id_especie, id_tamanio, id_etapa_vida, nombre, sexo, foto)
VALUES
(1, 1, 1, 1, 'Capuchino', 'MACHO', 'capuchino.jpg'),
(2, 1, 2, 2, 'Popisina', 'HEMBRA', 'popisina.jpg'),
(3, 1, 3, 2, 'El Diablo', 'MACHO', 'ElDiablo.jpg'),
(4, 1, 2, 1, 'Estela', 'HEMBRA', 'estela.jpg'),
(5, 1, 1, 2, 'Bruno', 'MACHO', 'bruno.jpg'),
(6, 1, 2, 2, 'Venus', 'HEMBRA', 'venus.jpg'),
(7, 1, 1, 2, 'Kiwi', 'MACHO', 'kiwi.jpg'),
(8, 1, 3, 2, 'Canela', 'HEMBRA', 'Canela.jpg');

/*Primer producto*/
INSERT INTO Productos
(nombre, marca, precio, descripcion, stock, descuento, en_oferta)
VALUES
(
    'Royal Canin Kitten',
    'Royal Canin',
    879.00,
    'Alimento seco para gatitos, formulado para apoyar el crecimiento, la salud digestiva y el desarrollo durante su primera etapa de vida.',
    8,
    10.00,
    TRUE
);

INSERT INTO ProductoEspecie (id_producto, id_especie)
VALUES (1, 2);

INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
VALUES (1, 1);

INSERT INTO ProductoCategoria (id_producto, id_categoria)
VALUES (1, 1);

INSERT INTO ProductoImagenes (id_producto, fuente, orden)
VALUES
(1, 'https://marspetcareaprimocdn.petcare.global/2dd98ecb-c8c2-45b0-bc05-b1ef000eda2b/2dd98ecb-c8c2-45b0-bc05-b1ef000eda2b_DownloadAsJpg.jpg?w=90&width=90&auto=webp&format=jpg&optimize=medium', 1),
(1, 'https://marspetcareaprimocdn.petcare.global/a1ebde9a-7e5b-4b78-8ce7-b1ef000f065c/a1ebde9a-7e5b-4b78-8ce7-b1ef000f065c_DownloadAsJpg.jpg?w=640&width=640&auto=webp&format=jpg&optimize=medium', 2);

/*Segundo Producto*/
INSERT INTO Productos
(nombre, marca, precio, descripcion, stock, descuento, en_oferta)
VALUES
(
    'Pro Plan Kitten Optistart Sabor Pollo',
    'Purina Pro Plan',
    682.00,
    'Alimento seco sabor pollo para gatitos en crecimiento, formulado para apoyar sus defensas, desarrollo y salud digestiva.',
    3,
    0.00,
    FALSE
);
INSERT INTO ProductoEspecie (id_producto, id_especie)
VALUES (2, 2);

INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
VALUES (2, 1);

INSERT INTO ProductoCategoria (id_producto, id_categoria)
VALUES (2, 1);

INSERT INTO ProductoImagenes (id_producto, fuente, orden)
VALUES
(2, 'https://m.media-amazon.com/images/I/713a8D6l-xL._AC_SL1500_.jpg', 1),
(2, 'https://m.media-amazon.com/images/I/41Hgsdu7EJL._AC_.jpg', 2),
(2, 'https://m.media-amazon.com/images/I/71kQUE5lUVL._AC_SL1500_.jpg', 3),
(2, 'https://m.media-amazon.com/images/I/71VfnZdHkSL._AC_SL1500_.jpg', 4),
(2, 'https://m.media-amazon.com/images/I/713VCn7sJ5L._AC_SL1500_.jpg', 5);

/*Tercer Producto*/
INSERT INTO Productos
(nombre, marca, precio, descripcion, stock, descuento, en_oferta)
VALUES
(
    'Hill''s Science Diet Adult Receta Pollo 1.8 kg',
    'Hill''s Science Diet',
    700.00,
    'Alimento seco sabor pollo para gatos adultos, formulado con proteína de alta calidad, taurina, minerales balanceados, vitamina E y ácidos grasos omega-6.',
    10,
    15.00,
    TRUE
);

INSERT INTO ProductoEspecie (id_producto, id_especie)
VALUES (3, 2);

INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
VALUES (3, 2);

INSERT INTO ProductoCategoria (id_producto, id_categoria)
VALUES (3, 1);

INSERT INTO ProductoImagenes (id_producto, fuente, orden)
VALUES
(3, 'https://m.media-amazon.com/images/I/71Id3vj4PVL._AC_SL1500_.jpg', 1),
(3, 'https://m.media-amazon.com/images/I/71FSxkUIPWL._AC_SL1500_.jpg', 2),
(3, 'https://m.media-amazon.com/images/I/712vNUE0LZL._AC_SL1500_.jpg', 3),
(3, 'https://m.media-amazon.com/images/I/71tCMgWqr3L._AC_SL1500_.jpg', 4);

/*Cuarto Producto*/
INSERT INTO Productos
(nombre, marca, precio, descripcion, stock, descuento, en_oferta)
VALUES
(
    'Hill''s Science Diet Adult Indoor Receta Pollo 1.6 kg',
    'Hill''s Science Diet',
    700.00,
    'Alimento seco sabor pollo para gatos adultos de interior, formulado con fibra natural para favorecer la salud digestiva y proteínas de alta calidad para ayudar a mantener músculos magros.',
    1,
    5.00,
    FALSE
);
INSERT INTO ProductoEspecie (id_producto, id_especie)
VALUES (4, 2);

INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
VALUES (4, 2);

INSERT INTO ProductoCategoria (id_producto, id_categoria)
VALUES (4, 1);

INSERT INTO ProductoImagenes (id_producto, fuente, orden)
VALUES
(4, 'https://m.media-amazon.com/images/I/81Wfs-PIUdL._AC_SL1500_.jpg', 1),
(4, 'https://m.media-amazon.com/images/I/81oGfNW-oqL._AC_SL1500_.jpg', 2),
(4, 'https://m.media-amazon.com/images/I/81Y-tQLpWZL._AC_SL1500_.jpg', 3),
(4, 'https://m.media-amazon.com/images/I/710gH1b1suL._AC_SL1500_.jpg', 4);

/*Quinto Producto*/
INSERT INTO Productos
(nombre, marca, precio, descripcion, stock, descuento, en_oferta)
VALUES
(
    'Purina ONE Adultos Pollo y Salmón 2 kg',
    'Purina ONE',
    549.00,
    'Alimento seco completo y balanceado para gatos adultos, elaborado con pollo y salmón, con proteínas de alta calidad y prebióticos para favorecer la salud digestiva.',
    0,
    20.00,
    FALSE
);

INSERT INTO ProductoEspecie (id_producto, id_especie)
VALUES (5, 2);

INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
VALUES (5, 2);

INSERT INTO ProductoCategoria (id_producto, id_categoria)
VALUES (5, 1);

INSERT INTO ProductoImagenes (id_producto, fuente, orden)
VALUES
(5, 'https://m.media-amazon.com/images/I/71rsY+ImBLL._AC_SL1500_.jpg', 1),
(5, 'https://m.media-amazon.com/images/I/71nMWc0NePL._AC_SL1500_.jpg', 2),
(5, 'https://m.media-amazon.com/images/I/71rJfVoCgML._AC_SL1500_.jpg', 3),
(5, 'https://m.media-amazon.com/images/I/81RTk5n6OsL._AC_SL1500_.jpg', 4),
(5, 'https://m.media-amazon.com/images/I/81lFBWhv-RL._AC_SL1500_.jpg', 5);

-- PRODUCTOS ADICIONALES NORMALIZADOS (6 A 40)
SET @PERRO = (SELECT id_especie FROM Especies WHERE nombre='PERRO' LIMIT 1);
SET @GATO = (SELECT id_especie FROM Especies WHERE nombre='GATO' LIMIT 1);
SET @PEQUENO = (SELECT id_tamanio FROM Tamanios WHERE nombre='PEQUENO' LIMIT 1);
SET @MEDIANO = (SELECT id_tamanio FROM Tamanios WHERE nombre='MEDIANO' LIMIT 1);
SET @GRANDE = (SELECT id_tamanio FROM Tamanios WHERE nombre='GRANDE' LIMIT 1);
SET @CACHORRO = (SELECT id_etapa_vida FROM Etapa_Vida WHERE nombre='CACHORRO' LIMIT 1);
SET @ADULTO = (SELECT id_etapa_vida FROM Etapa_Vida WHERE nombre='ADULTO' LIMIT 1);
SET @ALIMENTOS = (SELECT id_categoria FROM Categorias WHERE nombre='ALIMENTOS' LIMIT 1);
SET @HIGIENE = (SELECT id_categoria FROM Categorias WHERE nombre='HIGIENE' LIMIT 1);
SET @JUGUETES = (SELECT id_categoria FROM Categorias WHERE nombre='JUGUETES' LIMIT 1);
SET @ACCESORIOS = (SELECT id_categoria FROM Categorias WHERE nombre='ACCESORIOS' LIMIT 1);

-- Producto original del equipo #6: Árbol para gatos
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'Árbol para gatos' AND marca = 'FEANDREA' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'Árbol para gatos', 'FEANDREA', 1099.99,
       'Este árbol para gatos tiene dos plataformas con bordes acolchados y una cueva, ofrece amplio espacio para observar y descansar. Adecuado para familias con varios gatos', 12, 30.00, TRUE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @GATO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @GATO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @ADULTO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @ADULTO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @JUGUETES
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @JUGUETES);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/712m3CsM1AL._AC_SX425_.jpg', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/712m3CsM1AL._AC_SX425_.jpg' OR orden = 1)
);

-- Producto original del equipo #7: Juguete ratón para gato
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'Juguete ratón para gato' AND marca = 'Naturance Ecoplay' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'Juguete ratón para gato', 'Naturance Ecoplay', 85.00,
       'Disminuye la ansiedad, el estrés y aburrimiento en el gato.', 20, 0.00, FALSE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @GATO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @GATO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @CACHORRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @CACHORRO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @JUGUETES
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @JUGUETES);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/61bC+5Z3KbL._AC_SX425_.jpg', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/61bC+5Z3KbL._AC_SX425_.jpg' OR orden = 1)
);

-- Producto original del equipo #8: Rascador para gato
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'Rascador para gato' AND marca = 'YAYANQING' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'Rascador para gato', 'YAYANQING', 129.00,
       'Este rascadores para gato satisface eficazmente la necesidad innata de rascar de tu gato, lo que reduce de manera efectiva que el gato arañe el sofá, las cortinas y las mantas. Protege tus muebles.', 100, 0.00, FALSE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @GATO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @GATO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @ADULTO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @ADULTO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @JUGUETES
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @JUGUETES);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71reVP+u0CL._AC_SY450_.jpg', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71reVP+u0CL._AC_SY450_.jpg' OR orden = 1)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/81wwvLM0G8L._AC_SY450_.jpg', 2
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/81wwvLM0G8L._AC_SY450_.jpg' OR orden = 2)
);

-- Producto original del equipo #9: Juguetes para gatos con resortes coloridos
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'Juguetes para gatos con resortes coloridos' AND marca = 'SPOT' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'Juguetes para gatos con resortes coloridos', 'SPOT', 165.00,
       'Muelles coloridos para entretener a tu gato con movimientos de rebote aleatorios.', 10, 5.00, TRUE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @GATO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @GATO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @CACHORRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @CACHORRO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @JUGUETES
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @JUGUETES);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71Bs5GEsSfL._AC_SY606_.jpg', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71Bs5GEsSfL._AC_SY606_.jpg' OR orden = 1)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/81QAK59+GiL._AC_SX425_.jpg', 2
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/81QAK59+GiL._AC_SX425_.jpg' OR orden = 2)
);

-- Producto original del equipo #10: Túnel extensible para gatos (120 cm)
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'Túnel extensible para gatos (120 cm)' AND marca = 'Pubamall' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'Túnel extensible para gatos (120 cm)', 'Pubamall', 239.00,
       'El marco de acero con estructura de resorte resistente y sólida sobresale y se retrae fácilmente para una diversión portátil y un almacenamiento fácil.', 25, 5.00, TRUE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @GATO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @GATO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @CACHORRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @CACHORRO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @JUGUETES
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @JUGUETES);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/616CQ3oVedL._AC_SX425_.jpg', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/616CQ3oVedL._AC_SX425_.jpg' OR orden = 1)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/61QYZ8FzyAL._AC_SX425_.jpg', 2
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/61QYZ8FzyAL._AC_SX425_.jpg' OR orden = 2)
);

-- Producto original del equipo #11: Shampoo Essentials Gato, 250 ml
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'Shampoo Essentials Gato, 250 ml' AND marca = 'Fancy Pets' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'Shampoo Essentials Gato, 250 ml', 'Fancy Pets', 120.00,
       'Shampoo de uso veterinario con esencia de mora azul. Limpia, desenreda y da brillo.', 15, 0.00, FALSE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @GATO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @GATO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @CACHORRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @CACHORRO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @HIGIENE
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @HIGIENE);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71-I23sfSmL._AC_SX679_.jpg', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71-I23sfSmL._AC_SX679_.jpg' OR orden = 1)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/61CnCOUJKML._AC_SL1000_.jpg', 2
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/61CnCOUJKML._AC_SL1000_.jpg' OR orden = 2)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/617G2NEEKSL._AC_SL1000_.jpg', 3
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/617G2NEEKSL._AC_SL1000_.jpg' OR orden = 3)
);

-- Producto original del equipo #12: Espuma Gato Consentido Cuidado Premium, 150 ml
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'Espuma Gato Consentido Cuidado Premium, 150 ml' AND marca = 'Grisi Pet Care' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'Espuma Gato Consentido Cuidado Premium, 150 ml', 'Grisi Pet Care', 185.00,
       'Espuma limpiadora y deodorizante en seco (no requiere enjuague) con Aloe Vera. Antiséptica y preventiva.', 20, 10.00, TRUE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @GATO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @GATO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @CACHORRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @CACHORRO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @HIGIENE
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @HIGIENE);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://http2.mlstatic.com/D_NQ_NP_2X_685346-MLM115696575402_092026-F.webp', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://http2.mlstatic.com/D_NQ_NP_2X_685346-MLM115696575402_092026-F.webp' OR orden = 1)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://http2.mlstatic.com/D_Q_NP_633473-MLM117145701411_092026-R.webp', 2
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://http2.mlstatic.com/D_Q_NP_633473-MLM117145701411_092026-R.webp' OR orden = 2)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://http2.mlstatic.com/D_Q_NP_963184-MLM117145761387_092026-R.webp', 3
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://http2.mlstatic.com/D_Q_NP_963184-MLM117145761387_092026-R.webp' OR orden = 3)
);

-- Producto original del equipo #13: Limpiador de manchas y olores para superficies
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'Limpiador de manchas y olores para superficies' AND marca = 'Nature''s Miracle' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'Limpiador de manchas y olores para superficies', 'Nature''s Miracle', 250.00,
       'Producto líquido limpiador en formato de botella con atomizador de gatillo para aplicación directa.', 8, 0.00, FALSE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @GATO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @GATO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @HIGIENE
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @HIGIENE);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/61ghbAxPIuL._AC_SL1500_.jpg', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/61ghbAxPIuL._AC_SL1500_.jpg' OR orden = 1)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/61MKFPSYYfL._AC_SL1500_.jpg', 2
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/61MKFPSYYfL._AC_SL1500_.jpg' OR orden = 2)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/7144v0-68JL._AC_SL1500_.jpg', 3
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/7144v0-68JL._AC_SL1500_.jpg' OR orden = 3)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71XP7WUkteL._AC_SL1500_.jpg', 4
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71XP7WUkteL._AC_SL1500_.jpg' OR orden = 4)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71XKir-ECwL._AC_SL1500_.jpg', 5
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71XKir-ECwL._AC_SL1500_.jpg' OR orden = 5)
);

-- Producto original del equipo #14: Dander Reducing Wipes (Toallitas para gatos), 50 pzas
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'Dander Reducing Wipes (Toallitas para gatos), 50 pzas' AND marca = 'Burt''s Bees' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'Dander Reducing Wipes (Toallitas para gatos), 50 pzas', 'Burt''s Bees', 195.00,
       'Toallitas húmedas formuladas con harina de avena coloidal, diseñadas específicamente para reducir la caspa.', 12, 5.00, FALSE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @GATO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @GATO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @CACHORRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @CACHORRO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @HIGIENE
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @HIGIENE);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/51laBXp4-YL._AC_SL1080_.jpg', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/51laBXp4-YL._AC_SL1080_.jpg' OR orden = 1)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/81vkkWVVg-L._AC_SL1500_.jpg', 2
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/81vkkWVVg-L._AC_SL1500_.jpg' OR orden = 2)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71wcYeR-3+L._AC_SL1500_.jpg', 3
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71wcYeR-3+L._AC_SL1500_.jpg' OR orden = 3)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/61DF+cJneVL._AC_SL1500_.jpg', 4
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/61DF+cJneVL._AC_SL1500_.jpg' OR orden = 4)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71-vMtox12L._AC_SL1500_.jpg', 5
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71-vMtox12L._AC_SL1500_.jpg' OR orden = 5)
);

-- Producto original del equipo #15: Spray Limpiador Biodegradable
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'Spray Limpiador Biodegradable' AND marca = 'Respet' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'Spray Limpiador Biodegradable', 'Respet', 160.00,
       'Spray multipropósito 100% biodegradable. Limpia, desinfecta, neutraliza olores y funciona como repelente.', 10, 0.00, FALSE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @GATO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @GATO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @HIGIENE
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @HIGIENE);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/517G80luTwL._AC_SL1000_.jpg', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/517G80luTwL._AC_SL1000_.jpg' OR orden = 1)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71aYBCyF1gL._AC_SL1254_.jpg', 2
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71aYBCyF1gL._AC_SL1254_.jpg' OR orden = 2)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71+KhEtKNSL._AC_SL1254_.jpg', 3
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71+KhEtKNSL._AC_SL1254_.jpg' OR orden = 3)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71Hqj7EfDFL._AC_SL1254_.jpg', 4
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71Hqj7EfDFL._AC_SL1254_.jpg' OR orden = 4)
);

-- Producto original del equipo #16: Mochila Transportadora de Mascotas, Gatos (Máximo 7Kg)
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'Mochila Transportadora de Mascotas, Gatos (Máximo 7Kg)' AND marca = 'Raganet' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'Mochila Transportadora de Mascotas, Gatos (Máximo 7Kg)', 'Raganet', 300.00,
       'Raganet, Mochila Transportadora de Mascotas, Perros y Gatos, Back Pack Portátil para Mascota Pequeña (Máximo 7Kg) Medidas: Ancho 23cm Largo 33cm Altura 42cm (Color Negro)', 5, 10.00, FALSE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @PERRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @PERRO);
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @GATO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @GATO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @CACHORRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @CACHORRO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @ADULTO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @ADULTO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @ACCESORIOS
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @ACCESORIOS);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @PEQUENO
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @PEQUENO);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/61u8bmR3H7L._AC_SX679_.jpg', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/61u8bmR3H7L._AC_SX679_.jpg' OR orden = 1)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71p5j6u69yL._AC_SX679_.jpg', 2
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71p5j6u69yL._AC_SX679_.jpg' OR orden = 2)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/81nrD0x5uVL._AC_SX679_.jpg', 3
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/81nrD0x5uVL._AC_SX679_.jpg' OR orden = 3)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71MwliQ5oBL._AC_SX679_.jpg', 4
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71MwliQ5oBL._AC_SX679_.jpg' OR orden = 4)
);

-- Producto original del equipo #17: YIYAHA Fuente de Agua para Gato de 74 oz/2.2 L, Bebedero para Gato
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'YIYAHA Fuente de Agua para Gato de 74 oz/2.2 L, Bebedero para Gato' AND marca = 'YIYAHA' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'YIYAHA Fuente de Agua para Gato de 74 oz/2.2 L, Bebedero para Gato', 'YIYAHA', 350.00,
       'Fuente para Mascotas con 4 Capas Sistema de Filtración, Bomba Ultra Silenciosa, Sin BPA, Dispensador de Agua para Gato Perro', 2, 0.00, FALSE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @PERRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @PERRO);
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @GATO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @GATO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @ACCESORIOS
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @ACCESORIOS);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71fx9bCGgLL._AC_SX679_.jpg', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71fx9bCGgLL._AC_SX679_.jpg' OR orden = 1)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/711D-n57XFL._AC_SX679_.jpg', 2
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/711D-n57XFL._AC_SX679_.jpg' OR orden = 2)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/61DEB3u64NL._AC_SX679_.jpg', 3
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/61DEB3u64NL._AC_SX679_.jpg' OR orden = 3)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71rvaLKRo8L._AC_SX679_.jpg', 4
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71rvaLKRo8L._AC_SX679_.jpg' OR orden = 4)
);

-- Producto original del equipo #18: Cuenco elevado para gatos, 2 piezas
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'Cuenco elevado para gatos, 2 piezas' AND marca = 'FEAWIAI' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'Cuenco elevado para gatos, 2 piezas', 'FEAWIAI', 130.00,
       'Cuenco para Gatos,2 Pzs Cuenco De Pie Alto Para Gatos,Comedero Gato Inclinable Tazón,Juego de Platos Ergonómicos para Gatos para Gato,Gatito,Cachorro, Perro Pequeño', 3, 10.00, TRUE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @PERRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @PERRO);
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @GATO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @GATO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @CACHORRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @CACHORRO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @ADULTO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @ADULTO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @ACCESORIOS
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @ACCESORIOS);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @PEQUENO
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @PEQUENO);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/41JeIz+RRHL._AC_SX679_.jpg', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/41JeIz+RRHL._AC_SX679_.jpg' OR orden = 1)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/613KSkrsfJL._AC_SX679_.jpg', 2
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/613KSkrsfJL._AC_SX679_.jpg' OR orden = 2)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/61S+RmrUKFL._AC_SX679_.jpg', 3
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/61S+RmrUKFL._AC_SX679_.jpg' OR orden = 3)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/617kQipcw4L._AC_SX679_.jpg', 4
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/617kQipcw4L._AC_SX679_.jpg' OR orden = 4)
);

-- Producto original del equipo #19: Hamaca de Aseo para Perros y Gatos con Soporte Plegable
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'Hamaca de Aseo para Perros y Gatos con Soporte Plegable' AND marca = 'FEAWIAI' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'Hamaca de Aseo para Perros y Gatos con Soporte Plegable', 'FEAWIAI', 569.00,
       'Malla de secado rápido y lavable a máquina, con acero inoxidable resistente al óxido y patas antideslizantes', 5, 5.00, FALSE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @PERRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @PERRO);
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @GATO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @GATO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @CACHORRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @CACHORRO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @ADULTO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @ADULTO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @ACCESORIOS
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @ACCESORIOS);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71VV6JwfrbL._AC_SX679_.jpg', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71VV6JwfrbL._AC_SX679_.jpg' OR orden = 1)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/51kLwJJbR9L._AC_US40_.jpg', 2
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/51kLwJJbR9L._AC_US40_.jpg' OR orden = 2)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71tz3ZojkEL._AC_SX679_.jpg', 3
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71tz3ZojkEL._AC_SX679_.jpg' OR orden = 3)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/81Y8Uxs7qYL._AC_SX679_.jpg', 4
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/81Y8Uxs7qYL._AC_SX679_.jpg' OR orden = 4)
);

-- Producto original del equipo #20: Pala de aluminio para arena de gatos con 2 piezas
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'Pala de aluminio para arena de gatos con 2 piezas' AND marca = 'YUAYAP' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'Pala de aluminio para arena de gatos con 2 piezas', 'YUAYAP', 126.00,
       'Aleación De Aluminio De Pala Gato, Pala De Arena para Gatos con 2 Piezas Ganchos Transparentes, Malla En Forma De Gato Pala Gato Adecuado para Todos Los Gatos', 3, 0.00, FALSE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @GATO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @GATO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @CACHORRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @CACHORRO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @ADULTO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @ADULTO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @ACCESORIOS
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @ACCESORIOS);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/61zOloZeoAL._AC_SX679_.jpg', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/61zOloZeoAL._AC_SX679_.jpg' OR orden = 1)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71egZQ6MCiL._AC_SX679_.jpg', 2
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71egZQ6MCiL._AC_SX679_.jpg' OR orden = 2)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71qVk2ZHjLL._AC_SX679_.jpg', 3
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71qVk2ZHjLL._AC_SX679_.jpg' OR orden = 3)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/717bLm6tOxL._AC_SX679_.jpg', 4
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/717bLm6tOxL._AC_SX679_.jpg' OR orden = 4)
);

-- Producto original del equipo #21: Optihealth Alimento Seco para Perro Adulto Raza Mediana Receta Pollo y Arroz, 15 kg
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'Optihealth Alimento Seco para Perro Adulto Raza Mediana Receta Pollo y Arroz, 15 kg' AND marca = 'Pro Plan' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'Optihealth Alimento Seco para Perro Adulto Raza Mediana Receta Pollo y Arroz, 15 kg', 'Pro Plan', 2025.00,
       'Alimento Seco para Perro Adulto Raza Mediana Receta Pollo y Arroz', 4, 10.00, FALSE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @PERRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @PERRO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @ADULTO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @ADULTO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @ALIMENTOS
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @ALIMENTOS);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @MEDIANO
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @MEDIANO);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://estacionmascota.com/2414-large_default/pro-plan-adulto-razas-medianas.jpg', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://estacionmascota.com/2414-large_default/pro-plan-adulto-razas-medianas.jpg' OR orden = 1)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://i5.walmartimages.com/asr/de592d2c-5275-4231-9a2b-a291ddbe24b1.35444de3ff83ac6a83174adfa6835cb9.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF', 2
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://i5.walmartimages.com/asr/de592d2c-5275-4231-9a2b-a291ddbe24b1.35444de3ff83ac6a83174adfa6835cb9.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF' OR orden = 2)
);

-- Producto original del equipo #22: Optihealth Alimento Seco para Perro Adulto Raza Pequeña Receta Pollo y Arroz
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'Optihealth Alimento Seco para Perro Adulto Raza Pequeña Receta Pollo y Arroz' AND marca = 'Pro Plan' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'Optihealth Alimento Seco para Perro Adulto Raza Pequeña Receta Pollo y Arroz', 'Pro Plan', 1300.00,
       'Alimento Seco para Perro Adulto Raza Pequeña Receta Pollo y Arroz', 5, 15.00, FALSE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @PERRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @PERRO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @ADULTO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @ADULTO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @ALIMENTOS
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @ALIMENTOS);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @PEQUENO
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @PEQUENO);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/61rVBD-wqUL._AC_SX679_.jpg', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/61rVBD-wqUL._AC_SX679_.jpg' OR orden = 1)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/41z0Vw4chDL._AC_SX679_.jpg', 2
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/41z0Vw4chDL._AC_SX679_.jpg' OR orden = 2)
);

-- Producto original del equipo #23: ActivBiome+ Croquetas Perro Adulto Razas Pequeñas, Alimento Para Perros Sabor pollo, 7 kg
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'ActivBiome+ Croquetas Perro Adulto Razas Pequeñas, Alimento Para Perros Sabor pollo, 7 kg' AND marca = 'Hills Science Diet' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'ActivBiome+ Croquetas Perro Adulto Razas Pequeñas, Alimento Para Perros Sabor pollo, 7 kg', 'Hills Science Diet', 1920.00,
       'Alimento Seco para Perro Adulto Raza Pequeña Receta Pollo y Arroz', 5, 15.00, FALSE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @PERRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @PERRO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @ADULTO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @ADULTO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @ALIMENTOS
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @ALIMENTOS);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @PEQUENO
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @PEQUENO);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71UhclHneWL._AC_SX425_.jpg', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71UhclHneWL._AC_SX425_.jpg' OR orden = 1)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/61i6jJtROaL._AC_SX679_.jpg', 2
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/61i6jJtROaL._AC_SX679_.jpg' OR orden = 2)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/61S2pmsGziL._AC_SL1065_.jpg', 3
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/61S2pmsGziL._AC_SL1065_.jpg' OR orden = 3)
);

-- Producto original del equipo #24: Alimento seco para Perro Ganador 20kg
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'Alimento seco para Perro Ganador 20kg' AND marca = 'Ganador' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'Alimento seco para Perro Ganador 20kg', 'Ganador', 721.00,
       'Alimento Seco para Perro Adulto Raza Adulta Pollo', 3, 5.00, FALSE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @PERRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @PERRO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @ADULTO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @ADULTO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @ALIMENTOS
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @ALIMENTOS);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @GRANDE
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @GRANDE);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/61IkerBql0L._AC_SX679_.jpg', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/61IkerBql0L._AC_SX679_.jpg' OR orden = 1)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/611v2-wUpqL._AC_SX679_.jpg', 2
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/611v2-wUpqL._AC_SX679_.jpg' OR orden = 2)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/61QdXh13LnL._AC_SX679_.jpg', 3
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/61QdXh13LnL._AC_SX679_.jpg' OR orden = 3)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/61VlEMvEEQL._AC_SX679_.jpg', 4
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/61VlEMvEEQL._AC_SX679_.jpg' OR orden = 4)
);

-- Producto original del equipo #25: Ganador Premium Superfoods 20kg, Alimento para Perros Adultos de Razas Medianas y Grandes
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'Ganador Premium Superfoods 20kg, Alimento para Perros Adultos de Razas Medianas y Grandes' AND marca = 'Ganador Premium' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'Ganador Premium Superfoods 20kg, Alimento para Perros Adultos de Razas Medianas y Grandes', 'Ganador Premium', 900.00,
       'Alimento Seco para Perro Adulto Raza Adulta, Medianas y Grandes', 3, 15.00, TRUE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @PERRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @PERRO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @ADULTO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @ADULTO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @ALIMENTOS
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @ALIMENTOS);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @GRANDE
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @GRANDE);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @MEDIANO
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @MEDIANO);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/51RN9izccSL._AC_SX679_.jpg', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/51RN9izccSL._AC_SX679_.jpg' OR orden = 1)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/51s+Qrc0kRL._AC_SX679_.jpg', 2
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/51s+Qrc0kRL._AC_SX679_.jpg' OR orden = 2)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/51mp4h4wuKL._AC_SX679_.jpg', 3
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/51mp4h4wuKL._AC_SX679_.jpg' OR orden = 3)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/710AHrT0-QL._AC_SL1000_.jpg', 4
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/710AHrT0-QL._AC_SL1000_.jpg' OR orden = 4)
);

-- Producto original del equipo #26: Juguete de Masticar Chirriante para Perros
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'Juguete de Masticar Chirriante para Perros' AND marca = 'SCHITEC' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'Juguete de Masticar Chirriante para Perros', 'SCHITEC', 202.00,
       'SCHITEC Juguete de Masticar Chirriante para Perros Grandes Mastigadores agresivos, Hueso de Goma Resistente e Interactivo para el Corte de Dientes', 4, 10.00, FALSE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @PERRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @PERRO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @CACHORRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @CACHORRO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @JUGUETES
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @JUGUETES);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @GRANDE
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @GRANDE);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/61Kbec8NZwL._AC_SX679_.jpg', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/61Kbec8NZwL._AC_SX679_.jpg' OR orden = 1)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71TIBe+CUeL._AC_SX679_.jpg', 2
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71TIBe+CUeL._AC_SX679_.jpg' OR orden = 2)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71LpzX6J32L._AC_SX679_.jpg', 3
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71LpzX6J32L._AC_SX679_.jpg' OR orden = 3)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/61cvEnpXOuL._AC_SX679_.jpg', 4
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/61cvEnpXOuL._AC_SX679_.jpg' OR orden = 4)
);

-- Producto original del equipo #27: Juguete mordedor con forma de zapato para perro
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'Juguete mordedor con forma de zapato para perro' AND marca = 'CHENGBAO' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'Juguete mordedor con forma de zapato para perro', 'CHENGBAO', 140.00,
       'Muelas de Perro Juguetes Duraderos Para Masticar Para Perros，Vocalización Juguete Seguro Chirriante Para Perros', 5, 0.00, FALSE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @PERRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @PERRO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @CACHORRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @CACHORRO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @JUGUETES
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @JUGUETES);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @PEQUENO
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @PEQUENO);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @MEDIANO
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @MEDIANO);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @GRANDE
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @GRANDE);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/51332pk4q1L._AC_SX679_.jpg', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/51332pk4q1L._AC_SX679_.jpg' OR orden = 1)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/61ww6qEi0AL._AC_SX679_.jpg', 2
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/61ww6qEi0AL._AC_SX679_.jpg' OR orden = 2)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/61MDTvfXVEL._AC_SX679_.jpg', 3
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/61MDTvfXVEL._AC_SX679_.jpg' OR orden = 3)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/61S+i2FyFzL._AC_SX679_.jpg', 4
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/61S+i2FyFzL._AC_SX679_.jpg' OR orden = 4)
);

-- Producto original del equipo #28: Juguete interactivo automático para perros y gatos
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'Juguete interactivo automático para perros y gatos' AND marca = 'Genérico' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'Juguete interactivo automático para perros y gatos', 'Genérico', 290.00,
       'Genérico Bola De Perro De Perro Interactiva, New Jugguete Electro con Carga USB, Juguetes Interactivos para Gatos Toyes Automáticos para Perros Autónomos, 360° Smart Automatic', 2, 10.00, FALSE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @PERRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @PERRO);
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @GATO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @GATO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @CACHORRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @CACHORRO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @ADULTO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @ADULTO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @JUGUETES
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @JUGUETES);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @PEQUENO
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @PEQUENO);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @MEDIANO
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @MEDIANO);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @GRANDE
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @GRANDE);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/61Ds9HzvSbL._AC_SX679_.jpg', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/61Ds9HzvSbL._AC_SX679_.jpg' OR orden = 1)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/711YSBr9XJL._AC_SX679_.jpg', 2
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/711YSBr9XJL._AC_SX679_.jpg' OR orden = 2)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/61FZDfihf+L._AC_SX679_.jpg', 3
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/61FZDfihf+L._AC_SX679_.jpg' OR orden = 3)
);

-- Producto original del equipo #29: Juguete mordedor para Perros
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'Juguete mordedor para Perros' AND marca = 'Fancy Pets' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'Juguete mordedor para Perros', 'Fancy Pets', 91.00,
       'Juguete de SOGA con Pelota para Perros Grandes, 45 cm, Algodón Multicolor con Agarradera, Resistente', 4, 0.00, FALSE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @PERRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @PERRO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @CACHORRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @CACHORRO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @ADULTO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @ADULTO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @JUGUETES
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @JUGUETES);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @GRANDE
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @GRANDE);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/61hV+bKr-OL._AC_SX679_.jpg', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/61hV+bKr-OL._AC_SX679_.jpg' OR orden = 1)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/7195PZIsOyL._AC_SX679_.jpg', 2
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/7195PZIsOyL._AC_SX679_.jpg' OR orden = 2)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/512wd5I1VLL._AC_SX679_.jpg', 3
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/512wd5I1VLL._AC_SX679_.jpg' OR orden = 3)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/51I08APsSyL._AC_SX679_.jpg', 4
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/51I08APsSyL._AC_SX679_.jpg' OR orden = 4)
);

-- Producto original del equipo #30: Juguetes de Rompecabezas para Perro
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'Juguetes de Rompecabezas para Perro' AND marca = 'Fancy Pets' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'Juguetes de Rompecabezas para Perro', 'Fancy Pets', 200.00,
       'Juguetes de Rompecabezas para Perro - Juguetes Interactivos para Perro para Entrenamiento de Alimentación', 4, 10.00, TRUE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @PERRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @PERRO);
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @GATO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @GATO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @CACHORRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @CACHORRO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @ADULTO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @ADULTO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @JUGUETES
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @JUGUETES);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @PEQUENO
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @PEQUENO);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @MEDIANO
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @MEDIANO);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @GRANDE
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @GRANDE);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71rwxAtdD+L._AC_SX679_.jpg', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71rwxAtdD+L._AC_SX679_.jpg' OR orden = 1)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71Y9Q58P1GL._AC_SX679_.jpg', 2
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71Y9Q58P1GL._AC_SX679_.jpg' OR orden = 2)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71Rrlounp9L._AC_SX679_.jpg', 3
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71Rrlounp9L._AC_SX679_.jpg' OR orden = 3)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/715DRkpzSBL._AC_SX679_.jpg', 4
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/715DRkpzSBL._AC_SX679_.jpg' OR orden = 4)
);

-- Producto original del equipo #31: Furbo 360°: Cámara para Perros
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'Furbo 360°: Cámara para Perros' AND marca = 'Furbo' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'Furbo 360°: Cámara para Perros', 'Furbo', 1370.00,
       'Alertas de Seguridad para Perros, Premios, Giro de 360°, Historial de Video y Audio de 2 Vías', 2, 0.00, FALSE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @PERRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @PERRO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @CACHORRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @CACHORRO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @ADULTO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @ADULTO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @ACCESORIOS
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @ACCESORIOS);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @PEQUENO
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @PEQUENO);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @MEDIANO
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @MEDIANO);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @GRANDE
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @GRANDE);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71zfSRKnyNL._AC_SX569_.jpg', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71zfSRKnyNL._AC_SX569_.jpg' OR orden = 1)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71UUSgHFrRL._AC_SX569_.jpg', 2
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71UUSgHFrRL._AC_SX569_.jpg' OR orden = 2)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71Pd3VrjHgL._AC_SX569_.jpg', 3
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71Pd3VrjHgL._AC_SX569_.jpg' OR orden = 3)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/810JkXwH0IL._AC_SX569_.jpg', 4
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/810JkXwH0IL._AC_SX569_.jpg' OR orden = 4)
);

-- Producto original del equipo #32: Fancy Pets Kit Dental Progresivo para Perro con Pasta Dental Comestible 90 g
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'Fancy Pets Kit Dental Progresivo para Perro con Pasta Dental Comestible 90 g' AND marca = 'FANCY' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'Fancy Pets Kit Dental Progresivo para Perro con Pasta Dental Comestible 90 g', 'FANCY', 120.00,
       'Fancy Pets Kit Dental Progresivo para Perro con Pasta Dental Comestible 90 g (3.17 oz) y Dedales Incluye Cepillo Doble Cabezal Higiene Bucal Canina', 20, 0.00, FALSE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @PERRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @PERRO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @CACHORRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @CACHORRO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @ADULTO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @ADULTO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @HIGIENE
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @HIGIENE);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @PEQUENO
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @PEQUENO);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @MEDIANO
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @MEDIANO);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @GRANDE
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @GRANDE);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/61yAxJhLrEL._AC_SX679_.jpg', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/61yAxJhLrEL._AC_SX679_.jpg' OR orden = 1)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/7144Jr2EW-L._AC_SX679_.jpg', 2
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/7144Jr2EW-L._AC_SX679_.jpg' OR orden = 2)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/61qSdO-FwYL._AC_SX679_.jpg', 3
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/61qSdO-FwYL._AC_SX679_.jpg' OR orden = 3)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/61Nze-2OvcL._AC_SX679_.jpg', 4
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/61Nze-2OvcL._AC_SX679_.jpg' OR orden = 4)
);

-- Producto original del equipo #33: Fancy Pets Tapete de Entrenamiento para Perros Doggie Grass
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'Fancy Pets Tapete de Entrenamiento para Perros Doggie Grass' AND marca = 'FANCY' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'Fancy Pets Tapete de Entrenamiento para Perros Doggie Grass', 'FANCY', 600.00,
       'Tapete de Entrenamiento para Perros Doggie Grass GDE | Pasto Sintético con Bandeja y Rejilla | Control de Olores y Fácil Limpieza', 8, 0.00, FALSE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @PERRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @PERRO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @CACHORRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @CACHORRO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @ADULTO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @ADULTO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @ACCESORIOS
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @ACCESORIOS);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @PEQUENO
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @PEQUENO);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @MEDIANO
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @MEDIANO);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @GRANDE
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @GRANDE);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/61seNBWzj6L._AC_SX679_.jpg', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/61seNBWzj6L._AC_SX679_.jpg' OR orden = 1)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/81rLgXO-uyL._AC_SX679_.jpg', 2
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/81rLgXO-uyL._AC_SX679_.jpg' OR orden = 2)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71RGn1LQ8EL._AC_SX679_.jpg', 3
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71RGn1LQ8EL._AC_SX679_.jpg' OR orden = 3)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/61DtOWWN28L._AC_SX679_.jpg', 4
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/61DtOWWN28L._AC_SX679_.jpg' OR orden = 4)
);

-- Producto original del equipo #34: Arnés para perro ajustable con correa de 1.5 m
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'Arnés para perro ajustable con correa de 1.5 m' AND marca = 'MESVIER' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'Arnés para perro ajustable con correa de 1.5 m', 'MESVIER', 250.00,
       'Arnés para Perro Mediano Grande Pequeño con Correa 1.5m, Pechera para Perro Ajustable Reflectante Transpirable', 5, 0.00, FALSE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @PERRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @PERRO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @CACHORRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @CACHORRO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @ADULTO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @ADULTO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @ACCESORIOS
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @ACCESORIOS);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @PEQUENO
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @PEQUENO);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @MEDIANO
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @MEDIANO);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @GRANDE
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @GRANDE);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/81OHFYaW4yL._AC_SX679_.jpg', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/81OHFYaW4yL._AC_SX679_.jpg' OR orden = 1)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71u6+Ew20dL._AC_SX679_.jpg', 2
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71u6+Ew20dL._AC_SX679_.jpg' OR orden = 2)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71xhX2NzNZL._AC_SX679_.jpg', 3
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71xhX2NzNZL._AC_SX679_.jpg' OR orden = 3)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/81lfvawYe4L._AC_SX679_.jpg', 4
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/81lfvawYe4L._AC_SX679_.jpg' OR orden = 4)
);

-- Producto original del equipo #35: Perfume para Perro Talco Bebé 250ml Spray
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'Perfume para Perro Talco Bebé 250ml Spray' AND marca = 'AURA BENDITA' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'Perfume para Perro Talco Bebé 250ml Spray', 'AURA BENDITA', 468.00,
       'Perfume para Perro Talco Bebé 250ml Spray para Perros Mascotas Aura Bendita', 10, 0.00, FALSE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @PERRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @PERRO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @CACHORRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @CACHORRO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @ADULTO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @ADULTO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @HIGIENE
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @HIGIENE);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @PEQUENO
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @PEQUENO);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @MEDIANO
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @MEDIANO);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @GRANDE
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @GRANDE);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/81EVKBpaFVL._AC_SX569_.jpg', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/81EVKBpaFVL._AC_SX569_.jpg' OR orden = 1)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71fGG2ixHbL._AC_SX569_.jpg', 2
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71fGG2ixHbL._AC_SX569_.jpg' OR orden = 2)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/818gzsWFW3L._AC_SX569_.jpg', 3
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/818gzsWFW3L._AC_SX569_.jpg' OR orden = 3)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71m+bU+BcML._AC_SX569_.jpg', 4
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71m+bU+BcML._AC_SX569_.jpg' OR orden = 4)
);

-- Producto original del equipo #36: Secadora para Perro
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'Secadora para Perro' AND marca = 'YAYANQING' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'Secadora para Perro', 'YAYANQING', 238.00,
       'Secadora para Perro, 2 en 1 300W Secadora de Pelo para Perro con Cepillo', 10, 0.00, FALSE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @PERRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @PERRO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @CACHORRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @CACHORRO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @ADULTO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @ADULTO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @HIGIENE
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @HIGIENE);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @PEQUENO
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @PEQUENO);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @MEDIANO
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @MEDIANO);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @GRANDE
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @GRANDE);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71dci7inGnL._AC_SX679_.jpg', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71dci7inGnL._AC_SX679_.jpg' OR orden = 1)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/711c3isFhAL._AC_SX679_.jpg', 2
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/711c3isFhAL._AC_SX679_.jpg' OR orden = 2)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/812446T3IXL._AC_SX679_.jpg', 3
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/812446T3IXL._AC_SX679_.jpg' OR orden = 3)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71f7lGeMKHL._AC_SX679_.jpg', 4
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71f7lGeMKHL._AC_SX679_.jpg' OR orden = 4)
);

-- Producto original del equipo #37: Toallitas para oídos de Mascotas para Perros y Gatos
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'Toallitas para oídos de Mascotas para Perros y Gatos' AND marca = 'JMHRJKL' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'Toallitas para oídos de Mascotas para Perros y Gatos', 'JMHRJKL', 210.00,
       'Toallitas para oídos de Mascotas para Perros y Gatos, 50 Tabletas Limpiador de Orejas para Perro, Elimina Cera y residuos', 15, 0.00, FALSE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @PERRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @PERRO);
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @GATO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @GATO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @CACHORRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @CACHORRO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @ADULTO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @ADULTO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @HIGIENE
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @HIGIENE);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @PEQUENO
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @PEQUENO);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @MEDIANO
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @MEDIANO);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @GRANDE
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @GRANDE);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71+TyW+H4fL._AC_SX679_.jpg', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71+TyW+H4fL._AC_SX679_.jpg' OR orden = 1)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71dUHs1z0eL._AC_SX679_.jpg', 2
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71dUHs1z0eL._AC_SX679_.jpg' OR orden = 2)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/7135pStHAXL._AC_SX679_.jpg', 3
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/7135pStHAXL._AC_SX679_.jpg' OR orden = 3)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/718oKS7vwrL._AC_SX679_.jpg', 4
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/718oKS7vwrL._AC_SX679_.jpg' OR orden = 4)
);

-- Producto original del equipo #38: Limpiador de patas para perros y gatos
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'Limpiador de patas para perros y gatos' AND marca = 'Edacype' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'Limpiador de patas para perros y gatos', 'Edacype', 299.00,
       'Limpiador de Patas para Perros y Gatos, Lavapatas Espumoso sin Aclarado con Cepillo Incorporado para Patas Sucias y Embarradas', 10, 0.00, FALSE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @PERRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @PERRO);
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @GATO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @GATO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @CACHORRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @CACHORRO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @ADULTO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @ADULTO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @HIGIENE
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @HIGIENE);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @PEQUENO
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @PEQUENO);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @MEDIANO
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @MEDIANO);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @GRANDE
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @GRANDE);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71yA6m0CVOL._AC_SX679_.jpg', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71yA6m0CVOL._AC_SX679_.jpg' OR orden = 1)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71gu1tV4xHL._AC_SX679_.jpg', 2
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71gu1tV4xHL._AC_SX679_.jpg' OR orden = 2)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71gHUt+NuqL._AC_SX679_.jpg', 3
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71gHUt+NuqL._AC_SX679_.jpg' OR orden = 3)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71ZyupuH4VL._AC_SX679_.jpg', 4
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71ZyupuH4VL._AC_SX679_.jpg' OR orden = 4)
);

-- Producto original del equipo #39: Set de aseo para perros y gatos, 8 piezas
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'Set de aseo para perros y gatos, 8 piezas' AND marca = 'SINOLL' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'Set de aseo para perros y gatos, 8 piezas', 'SINOLL', 359.00,
       'Set Aseo Mascota 8 Piezas, Perros y Gatos, Cortaúñas, Peine Desenredante, Estuche Portátil', 10, 0.00, FALSE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @PERRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @PERRO);
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @GATO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @GATO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @CACHORRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @CACHORRO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @ADULTO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @ADULTO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @HIGIENE
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @HIGIENE);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @PEQUENO
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @PEQUENO);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @MEDIANO
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @MEDIANO);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @GRANDE
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @GRANDE);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/714nMiOYCcL._AC_SX569_.jpg', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/714nMiOYCcL._AC_SX569_.jpg' OR orden = 1)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71VR0SaI9AL._AC_SX569_.jpg', 2
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71VR0SaI9AL._AC_SX569_.jpg' OR orden = 2)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71NuaJ-Tl-L._AC_SX569_.jpg', 3
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71NuaJ-Tl-L._AC_SX569_.jpg' OR orden = 3)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/71zcgWS+ZcL._AC_SX569_.jpg', 4
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/71zcgWS+ZcL._AC_SX569_.jpg' OR orden = 4)
);

-- Producto original del equipo #40: Shampoo Claudio para Perros Piel Sensible. 500 ml
-- Identificación por nombre+marca para permitir una segunda ejecución sin duplicar el producto.
SET @idProducto = (SELECT id_producto FROM Productos WHERE nombre = 'Shampoo Claudio para Perros Piel Sensible. 500 ml' AND marca = 'Claudio' ORDER BY id_producto LIMIT 1);
INSERT INTO Productos (nombre, marca, precio, descripcion, stock, descuento, en_oferta)
SELECT 'Shampoo Claudio para Perros Piel Sensible. 500 ml', 'Claudio', 70.00,
       'Shampoo limpieza y acondicionamiento del pelaje de perros con piel sensible o afecciones cutáneas', 50, 0.00, FALSE
WHERE @idProducto IS NULL;
SET @idProducto = COALESCE(@idProducto, LAST_INSERT_ID());
INSERT INTO ProductoEspecie (id_producto, id_especie)
SELECT @idProducto, @PERRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEspecie WHERE id_producto = @idProducto AND id_especie = @PERRO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @CACHORRO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @CACHORRO);
INSERT INTO ProductoEtapaVida (id_producto, id_etapa_vida)
SELECT @idProducto, @ADULTO
WHERE NOT EXISTS (SELECT 1 FROM ProductoEtapaVida WHERE id_producto = @idProducto AND id_etapa_vida = @ADULTO);
INSERT INTO ProductoCategoria (id_producto, id_categoria)
SELECT @idProducto, @HIGIENE
WHERE NOT EXISTS (SELECT 1 FROM ProductoCategoria WHERE id_producto = @idProducto AND id_categoria = @HIGIENE);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @PEQUENO
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @PEQUENO);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @MEDIANO
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @MEDIANO);
INSERT INTO ProductoTamanioMascota (id_producto, id_tamanio)
SELECT @idProducto, @GRANDE
WHERE NOT EXISTS (SELECT 1 FROM ProductoTamanioMascota WHERE id_producto = @idProducto AND id_tamanio = @GRANDE);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/518YVfEw8kL._AC_SX679_.jpg', 1
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/518YVfEw8kL._AC_SX679_.jpg' OR orden = 1)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/61LMDbRJ9wL._AC_SX679_.jpg', 2
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/61LMDbRJ9wL._AC_SX679_.jpg' OR orden = 2)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/61ADEm7Gs3L._AC_SX679_.jpg', 3
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/61ADEm7Gs3L._AC_SX679_.jpg' OR orden = 3)
);
INSERT INTO ProductoImagenes (id_producto, fuente, orden)
SELECT @idProducto, 'https://m.media-amazon.com/images/I/717vaoTUPWL._AC_SX679_.jpg', 4
WHERE NOT EXISTS (
    SELECT 1 FROM ProductoImagenes
    WHERE id_producto = @idProducto AND (fuente = 'https://m.media-amazon.com/images/I/717vaoTUPWL._AC_SX679_.jpg' OR orden = 4)
);

COMMIT;
