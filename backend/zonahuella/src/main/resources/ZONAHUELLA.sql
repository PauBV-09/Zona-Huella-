DROP DATABASE IF EXISTS zona_huella_leonel;

CREATE DATABASE zona_huella_leonel;
USE zona_huella_leonel;

CREATE TABLE Usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    contrasenia VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    rol ENUM('CLIENTE', 'ADMIN') NOT NULL DEFAULT 'CLIENTE'
);

CREATE TABLE Especies (
    id_especie INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
);
INSERT INTO Especies (nombre)
VALUES
('PERRO'),
('GATO');

CREATE TABLE Tamanios (
    id_tamanio INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL UNIQUE
);
INSERT INTO Tamanios (nombre)
VALUES
('PEQUENO'),
('MEDIANO'),
('GRANDE');
/* Checar los posibles valores de Etapa Vida*/
CREATE TABLE Etapa_Vida (
    id_etapa_vida INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL UNIQUE
);
INSERT INTO Etapa_Vida (nombre)
VALUES
('CACHORRO'),
('ADULTO');

CREATE TABLE Categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion VARCHAR(255)
);
INSERT INTO Categorias (nombre, descripcion)
VALUES
('ALIMENTOS', 'Alimentos para mascotas'),
('HIGIENE', 'Productos de higiene y cuidado'),
('JUGUETES', 'Juguetes para mascotas'),
('ACCESORIOS', 'Accesorios para mascotas');

CREATE TABLE Mascotas (
    id_mascota INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_especie INT NOT NULL,
    id_tamanio INT,
    id_etapa_vida INT,
    nombre VARCHAR(50) NOT NULL,
    sexo ENUM('MACHO', 'HEMBRA'),
    foto VARCHAR(255),

    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_especie) REFERENCES Especies(id_especie),
    FOREIGN KEY (id_tamanio) REFERENCES Tamanios(id_tamanio),
    FOREIGN KEY (id_etapa_vida) REFERENCES Etapa_Vida(id_etapa_vida)
);

/*Apartir de aqui ya no rellenare las tablas*/
CREATE TABLE Direcciones (
    id_direccion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    calle VARCHAR(100) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    alcaldia_municipio VARCHAR(100) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    estado VARCHAR(100) NOT NULL,
    codigo_postal VARCHAR(10) NOT NULL,
    referencias VARCHAR(255),

    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

CREATE TABLE Productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    marca VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL CHECK (precio>0),
    descripcion TEXT,
    stock INT NOT NULL CHECK (stock>=0),
    descuento DECIMAL(5,2) CHECK (descuento >= 0 AND descuento < 100),
    en_oferta BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE ProductoImagenes (
    id_imagen INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    fuente VARCHAR(255) NOT NULL,
    orden INT NOT NULL CHECK (orden > 0),

    CONSTRAINT UQ_producto_orden UNIQUE (id_producto, orden),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);

CREATE TABLE ProductoTamanioMascota (
	id_producto INT NOT NULL,
    id_tamanio INT NOT NULL,
    
    CONSTRAINT PK_producto_tamanio PRIMARY KEY (id_producto, id_tamanio),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto),
    FOREIGN KEY (id_tamanio) REFERENCES Tamanios(id_tamanio)
);

CREATE TABLE ProductoEspecie (
	id_producto INT NOT NULL,
    id_especie INT NOT NULL,
    
    CONSTRAINT PK_producto_especie PRIMARY KEY (id_producto, id_especie),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto),
    FOREIGN KEY (id_especie) REFERENCES Especies(id_especie)
);

CREATE TABLE ProductoEtapaVida (
	id_producto INT NOT NULL,
    id_etapa_vida INT NOT NULL,
    
    CONSTRAINT PK_producto_etapa_vida PRIMARY KEY (id_producto, id_etapa_vida),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto),
    FOREIGN KEY (id_etapa_vida) REFERENCES Etapa_Vida(id_etapa_vida)
);

CREATE TABLE ProductoCategoria (
	id_producto INT NOT NULL,
    id_categoria INT NOT NULL,
    
    CONSTRAINT PK_producto_categoria PRIMARY KEY (id_producto, id_categoria),
	FOREIGN KEY (id_producto) REFERENCES Productos(id_producto),
	FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria)
);

CREATE TABLE Pedidos (
	id_pedido INT AUTO_INCREMENT PRIMARY KEY,
	id_usuario INT NOT NULL,
    id_direccion INT NOT NULL,
    fecha_pedido DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2) NOT NULL CHECK (total >=0),
    metodo_pago VARCHAR(50),
    notas VARCHAR(255),
    
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_direccion) REFERENCES Direcciones(id_direccion)
);

CREATE TABLE DetallePedido (
	id_pedido INT NOT NULL,
	id_producto INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10,2) NOT NULL CHECK (precio_unitario >= 0),
    subtotal DECIMAL(10,2) NOT NULL CHECK (subtotal >= 0),
    
    CONSTRAINT PK_detalle_pedido PRIMARY KEY (id_pedido, id_producto),
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);

CREATE TABLE Favoritos (
	id_usuario INT NOT NULL,
    id_producto INT NOT NULL,
    
    CONSTRAINT PK_favorito PRIMARY KEY (id_usuario, id_producto),
	FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);
