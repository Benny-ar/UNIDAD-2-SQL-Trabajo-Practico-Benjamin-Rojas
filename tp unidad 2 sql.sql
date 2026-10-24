DROP DATABASE IF EXISTS tp_sql_unidad2;
CREATE DATABASE tp_sql_unidad2;

USE tp_sql_unidad2;

-- ============================================================================
-- PARTE A
-- ============================================================================


CREATE TABLE Documentos (
  cod_documento   INT          NOT NULL,
  descripcion     VARCHAR(50)  NOT NULL,
  PRIMARY KEY (cod_documento)
);


CREATE TABLE Oficinas (
  cod_oficina     INT          NOT NULL,
  codigo_director INT          NULL,          
  descripcion     VARCHAR(80)  NOT NULL,
  PRIMARY KEY (cod_oficina)
);

CREATE TABLE Empleados (
  cod_empleado    INT          NOT NULL,
  apellido        VARCHAR(40)  NOT NULL,
  nombre          VARCHAR(40)  NOT NULL,
  fecha_nacimiento DATE        NOT NULL,
  num_doc         VARCHAR(20)  NOT NULL,
  cod_jefe        INT          NULL,          
  cod_oficina     INT          NOT NULL,
  cod_documento   INT          NOT NULL,
  PRIMARY KEY (cod_empleado),
  FOREIGN KEY (cod_oficina)   REFERENCES Oficinas(cod_oficina),
  FOREIGN KEY (cod_documento) REFERENCES Documentos(cod_documento),
  FOREIGN KEY (cod_jefe)      REFERENCES Empleados(cod_empleado)
);

CREATE TABLE Datos_contratos (
  cod_empleado    INT          NOT NULL,
  fecha_contrato  DATE         NOT NULL,
  cuota           DECIMAL(12,2) NOT NULL,
  ventas          DECIMAL(12,2) NOT NULL DEFAULT 0,
  PRIMARY KEY (cod_empleado),
  FOREIGN KEY (cod_empleado) REFERENCES Empleados(cod_empleado)
);

CREATE TABLE Fabricantes (
  cod_fabricante  INT          NOT NULL,
  razon_social    VARCHAR(80)  NOT NULL,
  PRIMARY KEY (cod_fabricante)
);

CREATE TABLE Listas (
  cod_lista       INT          NOT NULL,
  descripcion     VARCHAR(50)  NOT NULL,
  ganancia        DECIMAL(5,2) NOT NULL,      
  PRIMARY KEY (cod_lista)
);

CREATE TABLE Productos (
  cod_producto    INT          NOT NULL,
  descripcion     VARCHAR(80)  NOT NULL,
  precio          DECIMAL(12,2) NOT NULL,    
  cantidad_stock  INT          NOT NULL DEFAULT 0,
  punto_reposicion INT         NOT NULL DEFAULT 0,
  cod_fabricante  INT          NOT NULL,
  PRIMARY KEY (cod_producto),
  FOREIGN KEY (cod_fabricante) REFERENCES Fabricantes(cod_fabricante)
);

CREATE TABLE Precios (
  cod_producto    INT          NOT NULL,
  cod_lista       INT          NOT NULL,
  precio          DECIMAL(12,2) NOT NULL,
  PRIMARY KEY (cod_producto, cod_lista),
  FOREIGN KEY (cod_producto) REFERENCES Productos(cod_producto),
  FOREIGN KEY (cod_lista)    REFERENCES Listas(cod_lista)
);

CREATE TABLE Clientes (
  cod_cliente     INT          NOT NULL,
  cod_lista       INT          NOT NULL,
  razon_social    VARCHAR(80)  NOT NULL,
  PRIMARY KEY (cod_cliente),
  FOREIGN KEY (cod_lista) REFERENCES Listas(cod_lista)
);

CREATE TABLE Pedidos (
  cod_pedido      INT          NOT NULL,
  fecha_pedido    DATE         NOT NULL,
  cod_empleado    INT          NOT NULL,
  cod_cliente     INT          NOT NULL,
  PRIMARY KEY (cod_pedido),
  FOREIGN KEY (cod_empleado) REFERENCES Empleados(cod_empleado),
  FOREIGN KEY (cod_cliente)  REFERENCES Clientes(cod_cliente)
);

CREATE TABLE Detalle_pedidos (
  cod_pedido      INT          NOT NULL,
  numero_linea    INT          NOT NULL,
  cod_producto    INT          NOT NULL,
  cantidad        INT          NOT NULL,
  PRIMARY KEY (cod_pedido, numero_linea),
  FOREIGN KEY (cod_pedido)   REFERENCES Pedidos(cod_pedido),
  FOREIGN KEY (cod_producto) REFERENCES Productos(cod_producto)
);


INSERT INTO Documentos (cod_documento, descripcion) VALUES
(1, 'DNI'),
(2, 'Pasaporte'),
(3, 'LC'),
(4, 'LE');

INSERT INTO Oficinas (cod_oficina, codigo_director, descripcion) VALUES
(1, 1, 'Casa Central'),
(2, 2, 'Sucursal Norte'),
(3, NULL, 'Sucursal Sur'),          
(4, 5, 'Sucursal Oeste'),
(5, NULL, 'Depósito');              

INSERT INTO Empleados (cod_empleado, apellido, nombre, fecha_nacimiento, num_doc, cod_jefe, cod_oficina, cod_documento) VALUES
(1, 'García',    'Juan',     '1975-03-12', '20111222', NULL, 1, 1),  
(2, 'López',     'María',    '1982-07-25', '25123456', 1,    2, 1),
(3, 'Pérez',     'Carlos',   '1990-11-08', '30111222', 1,    1, 1),
(4, 'Rodríguez', 'María',    '1988-01-15', '28555666', 2,    2, 1),
(5, 'Fernández', 'Ana',      '1970-09-30', '18123456', NULL, 4, 2),  
(6, 'Martínez',  'Pedro',    '1995-05-20', '35111222', 5,    4, 1),
(7, 'Gómez',     'Laura',    '1985-12-03', '27123456', 1,    1, 1),
(8, 'Díaz',      'María',    '1992-04-18', '32111222', 2,    3, 1);

INSERT INTO Datos_contratos (cod_empleado, fecha_contrato, cuota, ventas) VALUES
(1, '2005-02-01', 120000.00, 98000.00),
(2, '2010-06-15',  85000.00, 72000.00),
(3, '2018-03-20',  45000.00, 41000.00),
(4, '2015-09-01',  55000.00, 48000.00),
(5, '2008-11-10', 150000.00, 130000.00),
(6, '2020-01-15',  35000.00, 28000.00),
(7, '2012-07-22',  95000.00, 88000.00),
(8, '2019-04-05',  40000.00, 35000.00);

INSERT INTO Fabricantes (cod_fabricante, razon_social) VALUES
(1, 'TechParts SA'),
(2, 'ElectroMax SRL'),
(3, 'Componentes del Sur'),
(4, 'Innova Soft');

INSERT INTO Listas (cod_lista, descripcion, ganancia) VALUES
(1, 'Minorista',  30.00),
(2, 'Mayorista',  15.00),
(3, 'Distribuidor', 10.00);

INSERT INTO Productos (cod_producto, descripcion, precio, cantidad_stock, punto_reposicion, cod_fabricante) VALUES
(1, 'Mouse óptico',           1500.00,  80,  30, 1),
(2, 'Teclado mecánico',       8500.00,  25,  20, 1),
(3, 'Monitor 24"',           45000.00,  12,  15, 2),   
(4, 'Disco SSD 480GB',       22000.00,  40,  25, 2),
(5, 'Memoria RAM 8GB',        9500.00,   8,  20, 3),   
(6, 'Fuente 650W',           18500.00,  18,  15, 3),
(7, 'Motherboard B450',      32000.00,   5,  10, 4),   
(8, 'Webcam HD',              6200.00,  55,  20, 1),
(9, 'Auriculares USB',        4100.00,  70,  25, 2),
(10,'Cable HDMI 2m',           980.00, 120,  40, 3);

INSERT INTO Precios (cod_producto, cod_lista, precio) VALUES
(1, 1, 1950.00), (1, 2, 1725.00), (1, 3, 1650.00),
(2, 1, 11050.00), (2, 2, 9775.00),
(3, 1, 58500.00), (3, 2, 51750.00),
(4, 1, 28600.00), (4, 2, 25300.00),
(5, 1, 12350.00), (5, 2, 10925.00),
(6, 1, 24050.00), (6, 2, 21275.00),
(7, 1, 41600.00), (7, 2, 36800.00),
(8, 1, 8060.00),  (8, 2, 7130.00),
(9, 1, 5330.00),  (9, 2, 4715.00),
(10,1, 1274.00),  (10,2, 1127.00);

INSERT INTO Clientes (cod_cliente, cod_lista, razon_social) VALUES
(1, 1, 'Librería Central'),
(2, 2, 'Mayorista del Norte'),
(3, 1, 'CompuShop'),
(4, 2, 'Distribuidora López'),
(5, 3, 'Tech Distribuidores'),
(6, 1, 'Oficina Express'),
(7, 2, 'Logística Andina'),
(8, 1, 'Papelería del Sur');

INSERT INTO Pedidos (cod_pedido, fecha_pedido, cod_empleado, cod_cliente) VALUES
(1, '2024-03-05', 2, 1),
(2, '2024-03-12', 3, 2),
(3, '2024-03-28', 4, 3),
(4, '2024-04-02', 2, 4),
(5, '2024-04-15', 7, 2),
(6, '2024-04-20', 3, 5),
(7, '2024-05-01', 6, 1),
(8, '2024-03-18', 8, 6);

INSERT INTO Detalle_pedidos (cod_pedido, numero_linea, cod_producto, cantidad) VALUES
(1, 1, 1, 10),
(1, 2, 10, 5),
(2, 1, 3, 2),
(2, 2, 4, 3),
(3, 1, 2, 4),
(3, 2, 8, 6),
(4, 1, 5, 8),
(4, 2, 7, 1),
(5, 1, 1, 15),
(5, 2, 9, 10),
(6, 1, 6, 2),
(7, 1, 3, 1),
(8, 1, 10, 20),
(8, 2, 1, 5);



-- CONSULTAS SIMPLES

-- 1) Obtener una lista con los nombres de las distintas oficinas de la empresa.
SELECT descripcion AS nombre_oficina
FROM Oficinas
ORDER BY descripcion;

-- 2) Obtener una lista de todos los productos indicando descripción del producto,
--    su precio de costo y su precio de costo IVA incluido (IVA = 21%).
SELECT descripcion, precio AS precio_costo, ROUND(precio * 1.21, 2) AS precio_costo_con_iva
FROM Productos
ORDER BY descripcion;

-- 3) Obtener una lista indicando para cada empleado apellido, nombre,
--    fecha de cumpleaños y edad.
SELECT apellido, nombre, fecha_nacimiento AS fecha_cumpleanos, TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE()) AS edad
FROM Empleados
ORDER BY apellido, nombre;

-- 4) Listar todos los empleados que tiene un jefe asignado.
SELECT *
FROM Empleados
WHERE cod_jefe IS NOT NULL
ORDER BY apellido, nombre;

-- 5) Listar los empleados de nombre "María" ordenado por apellido.
SELECT *
FROM Empleados
WHERE nombre = 'María'
ORDER BY apellido;

-- 6) Listar los clientes cuya razón social comience con "L" ordenado por código de cliente.
SELECT *
FROM Clientes
WHERE razon_social LIKE 'L%'
ORDER BY cod_cliente;

-- 7) Listar toda la información de los pedidos de Marzo ordenado por fecha de pedido.
SELECT *
FROM Pedidos
WHERE MONTH(fecha_pedido) = 3
ORDER BY fecha_pedido;

-- 8) Listar las oficinas que no tienen asignado director.
SELECT *
FROM Oficinas
WHERE codigo_director IS NULL
ORDER BY cod_oficina;

-- 9) Listar los 4 productos de menor precio de costo.
SELECT *
FROM Productos
ORDER BY precio ASC
LIMIT 4;

-- 10) Listar los códigos de empleados de los tres que tengan la mayor cuota.
SELECT cod_empleado
FROM Datos_contratos
ORDER BY cuota DESC
LIMIT 3;


-- CONSULTAS MULTITABLAS

-- 1) De cada producto listar descripción, razón social del fabricante y stock
--    ordenado por razón social y descripción.
SELECT p.descripcion, f.razon_social, p.cantidad_stock AS stock
FROM Productos p
INNER JOIN Fabricantes f ON p.cod_fabricante = f.cod_fabricante
ORDER BY f.razon_social, p.descripcion;

-- 2) De cada pedido listar código de pedido, fecha de pedido,
--    apellido del empleado y razón social del cliente.
SELECT pe.cod_pedido, pe.fecha_pedido, e.apellido, c.razon_social
FROM Pedidos pe
INNER JOIN Empleados e ON pe.cod_empleado = e.cod_empleado
INNER JOIN Clientes  c ON pe.cod_cliente  = c.cod_cliente
ORDER BY pe.cod_pedido;

-- 3) Listar por cada empleado apellido, cuota asignada, oficina a la que pertenece
--    ordenado en forma descendente por cuota.
SELECT e.apellido, dc.cuota, o.descripcion AS oficina
FROM Empleados e
INNER JOIN Datos_contratos dc ON e.cod_empleado = dc.cod_empleado
INNER JOIN Oficinas o         ON e.cod_oficina  = o.cod_oficina
ORDER BY dc.cuota DESC;

-- 4) Listar sin repetir la razón social de todos aquellos clientes que
--    hicieron pedidos en Abril.
SELECT DISTINCT c.razon_social
FROM Clientes c
INNER JOIN Pedidos p ON c.cod_cliente = p.cod_cliente
WHERE MONTH(p.fecha_pedido) = 4
ORDER BY c.razon_social;

-- 5) Listar sin repetir los productos que fueron pedidos en Marzo.
SELECT DISTINCT pr.cod_producto, pr.descripcion
FROM Productos pr
INNER JOIN Detalle_pedidos dp ON pr.cod_producto = dp.cod_producto
INNER JOIN Pedidos pe         ON dp.cod_pedido   = pe.cod_pedido
WHERE MONTH(pe.fecha_pedido) = 3
ORDER BY pr.descripcion;

-- 6) Listar aquellos empleados que están contratados por más de 10 años
--    ordenado por cantidad de años en forma descendente.
SELECT e.cod_empleado, e.apellido, e.nombre, dc.fecha_contrato, TIMESTAMPDIFF(YEAR, dc.fecha_contrato, CURDATE()) AS anios_contratados
FROM Empleados e
INNER JOIN Datos_contratos dc ON e.cod_empleado = dc.cod_empleado
WHERE TIMESTAMPDIFF(YEAR, dc.fecha_contrato, CURDATE()) > 10
ORDER BY anios_contratados DESC;

-- 7) Obtener una lista de los clientes mayoristas ordenada por razón social.
--    (Se considera mayorista a los clientes cuya lista es "Mayorista")
SELECT c.cod_cliente, c.razon_social, l.descripcion AS tipo_lista
FROM Clientes c
INNER JOIN Listas l ON c.cod_lista = l.cod_lista
WHERE l.descripcion = 'Mayorista'
ORDER BY c.razon_social;

-- 8) Obtener una lista sin repetir que indique qué productos compró cada cliente,
--    ordenada por razón social y descripción.
SELECT DISTINCT c.razon_social, pr.descripcion AS producto
FROM Clientes c
INNER JOIN Pedidos pe         ON c.cod_cliente   = pe.cod_cliente
INNER JOIN Detalle_pedidos dp ON pe.cod_pedido   = dp.cod_pedido
INNER JOIN Productos pr       ON dp.cod_producto = pr.cod_producto
ORDER BY c.razon_social, pr.descripcion;

-- 9) Obtener una lista con la descripción de aquellos productos cuyo stock
--    está por debajo del punto de reposición indicando cantidad a comprar
--    y razón social del fabricante ordenada por razón social y descripción.
SELECT p.descripcion, (p.punto_reposicion - p.cantidad_stock) AS cantidad_a_comprar, f.razon_social
FROM Productos p
INNER JOIN Fabricantes f ON p.cod_fabricante = f.cod_fabricante
WHERE p.cantidad_stock < p.punto_reposicion
ORDER BY f.razon_social, p.descripcion;

-- 10) Listar aquellos empleados cuya cuota es menor a 50000 o mayor a 100000.
SELECT e.cod_empleado, e.apellido, e.nombre, dc.cuota
FROM Empleados e
INNER JOIN Datos_contratos dc ON e.cod_empleado = dc.cod_empleado
WHERE dc.cuota < 50000 OR dc.cuota > 100000
ORDER BY dc.cuota;


-- ============================================================================
-- PARTE B
-- ============================================================================
CREATE TABLE CLIENTES_B (
  codigo_cliente  INT          NOT NULL,
  nombre          VARCHAR(60)  NOT NULL,
  domicilio       VARCHAR(80)  NOT NULL,
  provincia       VARCHAR(40)  NOT NULL,
  PRIMARY KEY (codigo_cliente)
);

CREATE TABLE PRODUCTOS_B (
  codigo_producto INT          NOT NULL,
  nombre_producto VARCHAR(60)  NOT NULL,
  PRIMARY KEY (codigo_producto)
);

CREATE TABLE VENTAS (
  numero_factura  INT          NOT NULL,
  codigo_cliente  INT          NOT NULL,
  fecha           DATE         NOT NULL,
  PRIMARY KEY (numero_factura),
  FOREIGN KEY (codigo_cliente) REFERENCES CLIENTES_B(codigo_cliente)
);

CREATE TABLE ITEM_VENTAS (
  numero_factura  INT          NOT NULL,
  codigo_producto INT          NOT NULL,
  cantidad        INT          NOT NULL,
  precio          DECIMAL(12,2) NOT NULL,
  PRIMARY KEY (numero_factura, codigo_producto),
  FOREIGN KEY (numero_factura)  REFERENCES VENTAS(numero_factura),
  FOREIGN KEY (codigo_producto) REFERENCES PRODUCTOS_B(codigo_producto)
);

INSERT INTO CLIENTES_B (codigo_cliente, nombre, domicilio, provincia) VALUES
(1, 'Juan Pérez',      'Av. Rivadavia 1234', 'Buenos Aires'),
(2, 'María Gómez',     'Calle Falsa 123',    'Córdoba'),
(3, 'Carlos López',    'San Martín 456',     'Santa Fe'),
(4, 'Ana Rodríguez',   'Belgrano 789',       'Buenos Aires'),
(5, 'Pedro Martínez',  'Mitre 321',          'Mendoza');

INSERT INTO PRODUCTOS_B (codigo_producto, nombre_producto) VALUES
(1, 'Mouse'),
(2, 'Teclado'),
(3, 'Monitor'),
(4, 'Pendrive'),
(5, 'Auriculares');

INSERT INTO VENTAS (numero_factura, codigo_cliente, fecha) VALUES
(1001, 1, '2024-01-10'),
(1002, 2, '2024-01-15'),
(1003, 1, '2024-02-01'),
(1004, 3, '2024-02-10'),
(1005, 4, '2024-03-05'),
(1006, 1, '2024-03-12'),
(1007, 5, '2024-03-20'),
(1008, 2, '2024-04-01');

INSERT INTO ITEM_VENTAS (numero_factura, codigo_producto, cantidad, precio) VALUES
(1001, 1, 10, 1500.00),
(1001, 2,  5, 8500.00),
(1002, 1, 20, 1500.00),
(1002, 3,  2, 45000.00),
(1003, 4, 15, 2500.00),
(1003, 1,  8, 1500.00),
(1004, 2, 12, 8500.00),
(1004, 5,  6, 4100.00),
(1005, 3,  1, 45000.00),
(1005, 1, 25, 1500.00),
(1006, 4, 30, 2500.00),
(1006, 5, 10, 4100.00),
(1007, 2,  4, 8500.00),
(1008, 1, 18, 1500.00),
(1008, 3,  3, 45000.00);

-- 1) Obtener la cantidad de unidades máxima.
SELECT MAX(cantidad) AS cantidad_maxima
FROM ITEM_VENTAS;

-- 2) Obtener la cantidad total de unidades vendidas del producto con el código 1.
SELECT SUM(cantidad) AS total_unidades_producto_1
FROM ITEM_VENTAS
WHERE codigo_producto = 1;

-- 3) Cantidad de unidades vendidas por producto, indicando la descripción del producto,
--    ordenado de mayor a menor por las cantidades vendidas.
SELECT p.nombre_producto AS descripcion, SUM(i.cantidad)   AS total_unidades
FROM ITEM_VENTAS i
INNER JOIN PRODUCTOS_B p ON i.codigo_producto = p.codigo_producto
GROUP BY p.codigo_producto, p.nombre_producto
ORDER BY total_unidades DESC;

-- 4) Cantidad de unidades vendidas por producto, indicando la descripción del producto,
--    ordenado alfabéticamente por nombre de producto para los productos que
--    vendieron más de 30 unidades.
SELECT p.nombre_producto AS descripcion, SUM(i.cantidad)   AS total_unidades
FROM ITEM_VENTAS i
INNER JOIN PRODUCTOS_B p ON i.codigo_producto = p.codigo_producto
GROUP BY p.codigo_producto, p.nombre_producto
HAVING SUM(i.cantidad) > 30
ORDER BY p.nombre_producto;

-- 5) Obtener cuantas compras (1 factura = 1 compra) realizó cada cliente
--    indicando el código y nombre del cliente ordenado de mayor a menor.
SELECT c.codigo_cliente, c.nombre, COUNT(v.numero_factura) AS cantidad_compras
FROM CLIENTES_B c
INNER JOIN VENTAS v ON c.codigo_cliente = v.codigo_cliente
GROUP BY c.codigo_cliente, c.nombre
ORDER BY cantidad_compras DESC;

-- 6) Promedio de unidades vendidas por producto, indicando el código del producto
--    para el cliente 1.
SELECT i.codigo_producto, AVG(i.cantidad) AS promedio_unidades
FROM ITEM_VENTAS i
INNER JOIN VENTAS v ON i.numero_factura = v.numero_factura
WHERE v.codigo_cliente = 1
GROUP BY i.codigo_producto
ORDER BY i.codigo_producto;