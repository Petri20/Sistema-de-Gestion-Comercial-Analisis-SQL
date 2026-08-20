# Sistema de Gestión Comercial — Análisis SQL

Modelo relacional y consultas de análisis de negocio para una pyme distribuidora de insumos de oficina (proyecto con datos ficticios, con fines de portfolio).

## 🎯 Objetivo del proyecto

Diseñar una base de datos relacional que represente el flujo comercial real de una pyme (clientes, productos, empleados, ventas) y resolver **10 preguntas de negocio** típicas de un rol administrativo o de análisis de datos: ranking de clientes, evolución de ventas, control de stock, producto más vendido, rendimiento por vendedor, entre otras.

## 🗂️ Modelo de datos

El esquema tiene 5 tablas relacionadas:

- **clientes** — datos de contacto y alta de cada cliente
- **empleados** — vendedores y su fecha de ingreso
- **productos** — catálogo con categoría, precio y stock
- **ventas** — cabecera de cada operación comercial
- **detalle_ventas** — líneas de producto vendidas por operación (relación muchos a muchos entre ventas y productos)

```
clientes ──┐
           ├──< ventas >──┐
empleados ─┘              ├──< detalle_ventas >── productos
```

## 🔎 Preguntas de negocio resueltas

1. Top 5 clientes por monto total comprado
2. Ventas totales por mes
3. Productos sin stock o con stock crítico
4. Producto más vendido por unidades
5. Ingreso total por categoría de producto
6. Empleado con mayor cantidad de ventas
7. Clientes inactivos (sin compras en los últimos 30 días)
8. Ticket promedio por venta
9. Ranking de productos por ingresos generados (usando `RANK() OVER`)
10. Ventas agrupadas por ciudad del cliente

## 🛠️ Tecnologías

- SQL (compatible con MySQL 8+ y PostgreSQL 14+)
- Funciones de ventana (`RANK() OVER`)
- Joins múltiples, subconsultas y funciones de agregación

## 🚀 Cómo correrlo

```bash
# 1. Crear la base de datos y las tablas con datos de prueba
mysql -u tu_usuario -p < 01_esquema_y_datos.sql

# 2. Ejecutar las consultas de negocio
mysql -u tu_usuario -p tu_base < 02_consultas_de_negocio.sql
```

También podés pegar el contenido de cada archivo en cualquier entorno online como [DB Fiddle](https://www.db-fiddle.com/) o [SQLite Online](https://sqliteonline.com/) para probarlo sin instalar nada.

## 📌 Sobre este proyecto

Desarrollado como práctica personal para consolidar el manejo de SQL aplicado a análisis de negocio, en el marco de la Tecnicatura Universitaria en Programación (UTN).

**Autor:** Valentin Petri
