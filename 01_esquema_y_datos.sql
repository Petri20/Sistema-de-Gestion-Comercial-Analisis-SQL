-- ============================================================
-- PROYECTO: Base de datos de gestión comercial
-- PyME: "Insumos Oficina SRL" (empresa ficticia)
-- Autor: Valentin Petri
-- Descripción: Modelo relacional para gestión de clientes,
-- productos, ventas y empleados de una distribuidora de
-- insumos de oficina.
-- Motor: compatible con MySQL 8+ y PostgreSQL 14+
-- ============================================================

-- Si usás PostgreSQL, comentá la siguiente línea (no existe CREATE DATABASE dentro de una transacción)
-- CREATE DATABASE insumos_oficina;
-- USE insumos_oficina;

-- ------------------------------------------------------------
-- 1. TABLA: clientes
-- ------------------------------------------------------------
CREATE TABLE clientes (
    id_cliente      INT PRIMARY KEY AUTO_INCREMENT,
    nombre          VARCHAR(100) NOT NULL,
    ciudad          VARCHAR(60)  NOT NULL,
    email           VARCHAR(100),
    telefono        VARCHAR(30),
    fecha_alta      DATE NOT NULL
);

-- ------------------------------------------------------------
-- 2. TABLA: empleados
-- ------------------------------------------------------------
CREATE TABLE empleados (
    id_empleado     INT PRIMARY KEY AUTO_INCREMENT,
    nombre          VARCHAR(100) NOT NULL,
    puesto          VARCHAR(60)  NOT NULL,
    fecha_ingreso   DATE NOT NULL
);

-- ------------------------------------------------------------
-- 3. TABLA: productos
-- ------------------------------------------------------------
CREATE TABLE productos (
    id_producto     INT PRIMARY KEY AUTO_INCREMENT,
    nombre          VARCHAR(100) NOT NULL,
    categoria       VARCHAR(50)  NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    stock           INT NOT NULL DEFAULT 0
);

-- ------------------------------------------------------------
-- 4. TABLA: ventas (cabecera de cada venta)
-- ------------------------------------------------------------
CREATE TABLE ventas (
    id_venta        INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente      INT NOT NULL,
    id_empleado     INT NOT NULL,
    fecha_venta     DATE NOT NULL,
    FOREIGN KEY (id_cliente)  REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);

-- ------------------------------------------------------------
-- 5. TABLA: detalle_ventas (líneas de producto por venta)
-- ------------------------------------------------------------
CREATE TABLE detalle_ventas (
    id_detalle      INT PRIMARY KEY AUTO_INCREMENT,
    id_venta        INT NOT NULL,
    id_producto     INT NOT NULL,
    cantidad        INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_venta)    REFERENCES ventas(id_venta),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- ============================================================
-- DATOS DE PRUEBA
-- ============================================================

-- --- Clientes (6) ---
INSERT INTO clientes (nombre, ciudad, email, telefono, fecha_alta) VALUES
('Estudio Contable Ríos',     'CABA',        'contacto@rios.com',      '11-4444-1111', '2024-02-10'),
('Papelería El Sol',          'San Nicolás', 'ventas@elsol.com',       '11-4444-2222', '2024-03-05'),
('Consultora Delta',          'CABA',        'info@delta.com',         '11-4444-3333', '2024-04-18'),
('Colegio San Martín',        'Vicente López','admin@sanmartin.edu',   '11-4444-4444', '2024-05-01'),
('Oficinas Norte SA',         'San Isidro',  'compras@norte.com',      '11-4444-5555', '2024-06-12'),
('Librería Central',          'CABA',        'central@libreria.com',   '11-4444-6666', '2024-07-20');

-- --- Empleados (4) ---
INSERT INTO empleados (nombre, puesto, fecha_ingreso) VALUES
('Lucía Fernández', 'Vendedora',        '2023-01-15'),
('Martín Gómez',     'Vendedor',        '2023-06-01'),
('Ana Torres',       'Coordinadora',    '2022-11-10'),
('Diego Pérez',      'Vendedor Jr.',    '2024-02-20');

-- --- Productos (10) ---
INSERT INTO productos (nombre, categoria, precio_unitario, stock) VALUES
('Resma A4 75g',              'Papelería',   4500.00, 120),
('Caja de birome azul x50',   'Papelería',   6800.00, 8),
('Toner HP 85A',              'Tecnología',  32000.00, 15),
('Silla ergonómica',          'Mobiliario',  95000.00, 5),
('Escritorio 120x60',         'Mobiliario',  110000.00, 3),
('Cartuchos tinta color',     'Tecnología',  18500.00, 0),
('Cinta adhesiva x10',        'Papelería',   3200.00, 40),
('Carpeta A4 con broche',     'Papelería',   1200.00, 200),
('Pendrive 32GB',             'Tecnología',  9500.00, 25),
('Calculadora científica',    'Tecnología',  14800.00, 12);

-- --- Ventas (12 ventas, fechas repartidas en 3 meses) ---
INSERT INTO ventas (id_cliente, id_empleado, fecha_venta) VALUES
(1, 1, '2025-06-03'),
(2, 2, '2025-06-07'),
(3, 1, '2025-06-15'),
(1, 3, '2025-06-22'),
(4, 2, '2025-07-02'),
(5, 4, '2025-07-05'),
(2, 1, '2025-07-11'),
(6, 2, '2025-07-18'),
(3, 3, '2025-07-25'),
(1, 1, '2025-08-01'),
(5, 4, '2025-08-06'),
(4, 2, '2025-08-12');

-- --- Detalle de ventas (líneas de producto) ---
INSERT INTO detalle_ventas (id_venta, id_producto, cantidad, precio_unitario) VALUES
(1, 1, 10, 4500.00),
(1, 8, 20, 1200.00),
(2, 2, 3,  6800.00),
(2, 7, 5,  3200.00),
(3, 3, 2, 32000.00),
(3, 9, 4,  9500.00),
(4, 1, 15, 4500.00),
(5, 4, 6, 95000.00),
(5, 5, 4, 110000.00),
(6, 10, 3, 14800.00),
(7, 1, 8, 4500.00),
(7, 8, 30, 1200.00),
(8, 3, 1, 32000.00),
(8, 9, 2,  9500.00),
(9, 2, 2,  6800.00),
(10, 1, 12, 4500.00),
(10, 7, 10, 3200.00),
(11, 4, 2, 95000.00),
(12, 10, 5, 14800.00),
(12, 8, 25, 1200.00);
