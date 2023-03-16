#CREACIÓN BASE DE DATOS
CREATE SCHEMA minimarket_jose;

USE minimarket_jose;

#CREACIÓN DE TABLAS
CREATE TABLE tipo_producto (
tipo_producto_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre VARCHAR (20),
categoria VARCHAR (40)
);

CREATE TABLE proveedor (
proveedor_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre_contacto VARCHAR (50),
telefono INTEGER (12),
email VARCHAR (50)
);

CREATE TABLE producto (
producto_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre VARCHAR (50),
precio INTEGER (7)
);

CREATE TABLE boleta (
boleta_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
fecha DATE,
total INTEGER (7)
);

#TABLA RELACIONAL BOLETA-PRODUCTO
CREATE TABLE boleta_producto (
boleta_id INTEGER NOT NULL,
producto_id INTEGER NOT NULL,
cantidad INTEGER,
PRIMARY KEY (boleta_id, producto_id),
FOREIGN KEY (boleta_id) REFERENCES boleta (boleta_id),
FOREIGN KEY (producto_id) REFERENCES producto (producto_id)
);

#RELACIÓN ENTRE TABLAS
ALTER TABLE producto 
ADD COLUMN tipo_producto_id INTEGER,
ADD FOREIGN KEY (tipo_producto_id) REFERENCES tipo_producto (tipo_producto_id);

ALTER TABLE producto
ADD COLUMN proveedor_id INTEGER,
ADD FOREIGN KEY (proveedor_id) REFERENCES proveedor (proveedor_id);

#AÑADIR TIPOS DE PRODUCTOS
INSERT INTO tipo_producto (nombre, categoria) VALUES 
('Carnes', 'Alimentos refrigerados'), 
('Frutas y verduras', 'Alimentos frescos'), 
('Lácteos', 'Alimentos refrigerados'), 
('Pan y repostería', 'Alimentos secos');

#AÑADIR PRODUCTOS
INSERT INTO producto (nombre, precio, tipo_producto_id) VALUES
('Leche', 1000, 3),
('Pan', 1000, 4),
('Pollo', 5000, 1),
('Manzana', 1200, 2),
('Cebolla', 1500, 2);

#AÑADIR ID DE PROVEEDORES
UPDATE producto SET proveedor_id = 1 WHERE producto_id IN (1);
UPDATE producto SET proveedor_id = 2 WHERE producto_id IN (2);
UPDATE producto SET proveedor_id = 3 WHERE producto_id IN (3);
UPDATE producto SET proveedor_id = 4 WHERE producto_id IN (4);
UPDATE producto SET proveedor_id = 4 WHERE producto_id IN (5);

#AÑADIR PROVEEDORES
INSERT INTO proveedor (nombre_contacto, telefono, email) VALUES
('Carlos Gómez', 99384956, 'carlosgomez@gmail.com'),
('Pedro Días', 993637956, 'pedrodiaz@gmail.com'),
('Juan Pérez', 993846578, 'juanperez@gmail.com'),
('Claudia González', 99364797, 'claudiagonzalez@gmail.com');

#CONSULTAS BÁSICAS
SELECT nombre, precio FROM producto;

SELECT nombre, categoria FROM tipo_producto;

#CONSULTA CON LEFT JOIN PARA OBTENER PROVEEDOR Y TIPO DE PRODUCTO QUE TRAEN
SELECT proveedor.nombre_contacto, tipo_producto.nombre
FROM producto
LEFT JOIN tipo_producto ON producto.tipo_producto_id = tipo_producto.tipo_producto_id
LEFT JOIN proveedor ON producto.proveedor_id = proveedor.proveedor_id;


#CONSULTA GANANCIAS ANUAL
#Esta sería una posible consulta para saber cuánto se gana anualmente en el minimarket.
SELECT YEAR(fecha) AS anio, SUM(total) AS ganancias_anuales
FROM boleta
GROUP BY YEAR(fecha);

