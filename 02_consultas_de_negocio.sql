-- ============================================================
-- CONSULTAS DE NEGOCIO
-- 10 preguntas típicas que resolvería un analista/administrativo
-- en una pyme comercial.
-- ============================================================

-- ------------------------------------------------------------
-- 1) TOP 5 CLIENTES POR MONTO TOTAL COMPRADO
-- Pregunta de negocio: ¿Quiénes son nuestros clientes más valiosos?
-- ------------------------------------------------------------
SELECT
    c.nombre AS cliente,
    SUM(dv.cantidad * dv.precio_unitario) AS monto_total
FROM clientes c
JOIN ventas v          ON v.id_cliente = c.id_cliente
JOIN detalle_ventas dv ON dv.id_venta = v.id_venta
GROUP BY c.nombre
ORDER BY monto_total DESC
LIMIT 5;

-- ------------------------------------------------------------
-- 2) VENTAS TOTALES POR MES
-- Pregunta de negocio: ¿Cómo evolucionaron las ventas mes a mes?
-- ------------------------------------------------------------
SELECT
    DATE_FORMAT(v.fecha_venta, '%Y-%m') AS mes,
    SUM(dv.cantidad * dv.precio_unitario) AS total_vendido
FROM ventas v
JOIN detalle_ventas dv ON dv.id_venta = v.id_venta
GROUP BY mes
ORDER BY mes;

-- ------------------------------------------------------------
-- 3) PRODUCTOS SIN STOCK O CON STOCK CRÍTICO (< 10 unidades)
-- Pregunta de negocio: ¿Qué hay que reponer con urgencia?
-- ------------------------------------------------------------
SELECT nombre, categoria, stock
FROM productos
WHERE stock < 10
ORDER BY stock ASC;

-- ------------------------------------------------------------
-- 4) PRODUCTO MÁS VENDIDO (por cantidad de unidades)
-- Pregunta de negocio: ¿Cuál es nuestro producto estrella?
-- ------------------------------------------------------------
SELECT
    p.nombre,
    SUM(dv.cantidad) AS unidades_vendidas
FROM productos p
JOIN detalle_ventas dv ON dv.id_producto = p.id_producto
GROUP BY p.nombre
ORDER BY unidades_vendidas DESC
LIMIT 1;

-- ------------------------------------------------------------
-- 5) INGRESO TOTAL POR CATEGORÍA DE PRODUCTO
-- Pregunta de negocio: ¿Qué categoría genera más facturación?
-- ------------------------------------------------------------
SELECT
    p.categoria,
    SUM(dv.cantidad * dv.precio_unitario) AS ingreso_total
FROM productos p
JOIN detalle_ventas dv ON dv.id_producto = p.id_producto
GROUP BY p.categoria
ORDER BY ingreso_total DESC;

-- ------------------------------------------------------------
-- 6) EMPLEADO CON MÁS VENTAS REALIZADAS (por cantidad de operaciones)
-- Pregunta de negocio: ¿Quién es el vendedor más activo?
-- ------------------------------------------------------------
SELECT
    e.nombre,
    e.puesto,
    COUNT(v.id_venta) AS cantidad_ventas
FROM empleados e
JOIN ventas v ON v.id_empleado = e.id_empleado
GROUP BY e.nombre, e.puesto
ORDER BY cantidad_ventas DESC;

-- ------------------------------------------------------------
-- 7) CLIENTES QUE NO COMPRARON DESDE HACE MÁS DE 30 DÍAS
-- Pregunta de negocio: ¿A quién hay que contactar para reactivar?
-- (fecha de referencia fija para que el resultado sea reproducible)
-- ------------------------------------------------------------
SELECT
    c.nombre,
    MAX(v.fecha_venta) AS ultima_compra
FROM clientes c
JOIN ventas v ON v.id_cliente = c.id_cliente
GROUP BY c.nombre
HAVING MAX(v.fecha_venta) < DATE_SUB('2025-08-15', INTERVAL 30 DAY)
ORDER BY ultima_compra ASC;

-- ------------------------------------------------------------
-- 8) TICKET PROMEDIO POR VENTA
-- Pregunta de negocio: ¿Cuánto gasta un cliente en promedio por operación?
-- ------------------------------------------------------------
SELECT
    ROUND(AVG(total_venta), 2) AS ticket_promedio
FROM (
    SELECT v.id_venta, SUM(dv.cantidad * dv.precio_unitario) AS total_venta
    FROM ventas v
    JOIN detalle_ventas dv ON dv.id_venta = v.id_venta
    GROUP BY v.id_venta
) AS ventas_totales;

-- ------------------------------------------------------------
-- 9) RANKING DE PRODUCTOS POR INGRESOS GENERADOS
-- Pregunta de negocio: ¿Qué productos priorizar en el próximo pedido a proveedores?
-- ------------------------------------------------------------
SELECT
    p.nombre,
    p.categoria,
    SUM(dv.cantidad * dv.precio_unitario) AS ingresos_generados,
    RANK() OVER (ORDER BY SUM(dv.cantidad * dv.precio_unitario) DESC) AS ranking
FROM productos p
JOIN detalle_ventas dv ON dv.id_producto = p.id_producto
GROUP BY p.nombre, p.categoria;

-- ------------------------------------------------------------
-- 10) VENTAS AGRUPADAS POR CIUDAD DEL CLIENTE
-- Pregunta de negocio: ¿En qué zonas geográficas conviene reforzar la distribución?
-- ------------------------------------------------------------
SELECT
    c.ciudad,
    COUNT(DISTINCT v.id_venta) AS cantidad_ventas,
    SUM(dv.cantidad * dv.precio_unitario) AS monto_total
FROM clientes c
JOIN ventas v          ON v.id_cliente = c.id_cliente
JOIN detalle_ventas dv ON dv.id_venta = v.id_venta
GROUP BY c.ciudad
ORDER BY monto_total DESC;
