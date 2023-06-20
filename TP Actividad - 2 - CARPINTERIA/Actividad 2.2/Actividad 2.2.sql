-- Actividad 2.2
-- # Consulta
-- =================

USE Carpinteria

-- 1 Por cada producto listar la descripción del producto, el precio y el nombre de la
-- categoría a la que pertenece.

SELECT 
    P.Descripcion, P.Precio, C.Nombre
FROM 
    Productos AS P
LEFT JOIN 
    Categorias AS C
    ON P.IDCategoria = C.ID

-- 2 Listar las categorías de producto de las cuales no se registren productos.

SELECT DISTINCT 
    C.ID, C.NOMBRE 
FROM 
    Categorias AS C
LEFT JOIN 
    Productos AS P
    ON P.IDCategoria = C.ID
    WHERE P.ID IS NULL

-- 3 Listar el nombre de la categoría de producto de aquel o aquellos productos que más
-- tiempo lleven en construir.

SELECT TOP 1 WITH TIES      -- WITH TIES - DEVUELVE VALORES Q EMPATEN EN LA BUSQUEDA 
    C.Nombre, P.DiasConstruccion
FROM 
    Categorias AS C
LEFT JOIN 
    Productos AS P
    ON P.IDCategoria = C.ID
    ORDER BY P.DiasConstruccion DESC 

-- 4 Listar apellidos y nombres y dirección de mail de aquellos clientes que no hayan
-- registrado pedidos.

SELECT DISTINCT
    C.Apellidos, C.Nombres, C.Mail
FROM 
    Clientes AS C
LEFT JOIN
    Pedidos AS P
    ON P.IDCliente = C.ID
WHERE 
    P.IDCliente IS NULL

-- 5 Listar apellidos y nombres, mail, teléfono y celular de aquellos clientes que hayan
-- realizado algún pedido cuyo costo supere $1000000

SELECT DISTINCT
    C.Apellidos, C.Nombres, C.Mail, C.Telefono, C.Celular
FROM
    Clientes AS C
LEFT JOIN 
    Pedidos AS P
    ON C.ID = P.IDCliente
WHERE
    P.Costo > 100000

-- 6 Listar IDPedido, Costo, Fecha de solicitud y fecha de finalización, descripción del
-- producto, costo y apellido y nombre del cliente. Sólo listar aquellos registros de
-- pedidos que hayan sido pagados.

SELECT
    P.ID, P.Costo, P.FechaSolicitud, P.FechaFinalizacion, PRO.Descripcion, PRO.Costo, C.Apellidos, C.Nombres, P.Pagado
FROM
    Pedidos AS P
LEFT JOIN 
    Productos AS PRO
    ON P.IDProducto = PRO.ID
LEFT JOIN
    Clientes AS C
    ON P.IDCliente = C.ID
WHERE 
    P.Pagado = 1

-- 7 Listar IDPedido, Fecha de solicitud, fecha de finalización, días de construcción del
-- producto, días de construcción del pedido (fecha de finalización - fecha de solicitud)
-- y una columna llamada Tiempo de construcción con la siguiente información:
-- 'Con anterioridad' → Cuando la cantidad de días de construcción del pedido sea
-- menor a los días de construcción del producto.
-- 'Exacto'' → Si la cantidad de días de construcción del pedido y el producto son
-- iguales
-- 'Con demora' → Cuando la cantidad de días de construcción del pedido sea mayor a
-- los días de construcción del producto.

SELECT
    P.ID, P.FechaSolicitud, P.FechaFinalizacion, PRO.DiasConstruccion, DATEDIFF(DAY,P.FechaSolicitud,P.FechaFinalizacion) AS 'CONSTRUCCION DEL PEDIDO',
    CASE
        WHEN DATEDIFF(DAY,P.FechaSolicitud,P.FechaFinalizacion) < PRO.DiasConstruccion THEN 'CON ANTERIORIDAD'
        WHEN DATEDIFF(DAY,P.FechaSolicitud,P.FechaFinalizacion) = PRO.DiasConstruccion THEN 'EXACTO'
        ELSE 'CON DEMORA'
    END AS 'TIEMPO DE CONSTRUCCION'
FROM 
    Pedidos AS P
LEFT JOIN 
    Productos AS PRO
    ON P.IDProducto = PRO.ID

-- 8 Listar por cada cliente el apellido y nombres y los nombres de las categorías de
-- aquellos productos de los cuales hayan realizado pedidos. No deben figurar
-- registros duplicados.

SELECT DISTINCT 
    C.Apellidos, C.Nombres, CAT.Nombre
FROM 
    Clientes AS C
LEFT JOIN 
    Pedidos AS P
    ON P.IDCliente = C.ID
LEFT JOIN 
    Productos AS PRO
    ON P.IDProducto = PRO.ID
LEFT JOIN 
    Categorias AS CAT
    ON PRO.IDCategoria = CAT.ID

-- 9 Listar apellidos y nombres de aquellos clientes que hayan realizado algún pedido
-- cuya cantidad sea exactamente igual a la cantidad considerada mayorista del
-- producto.

SELECT 
    C.Nombres, C.Apellidos
FROM
    Clientes AS C
LEFT JOIN
    Pedidos AS P
    ON C.ID = P.IDCliente
LEFT JOIN 
    Productos AS PRO
    ON P.IDProducto = PRO.ID
WHERE 
    P.Cantidad = PRO.CantidadMayorista

-- 10 Listar por cada producto el nombre del producto, el nombre de la categoría, el precio
-- de venta minorista, el precio de venta mayorista y el porcentaje de ahorro que se
-- obtiene por la compra mayorista a valor mayorista en relación al valor minorista.
