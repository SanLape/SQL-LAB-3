
-- Actividad 2.1
-- # Consulta
-- ======================
USE Carpinteria

-- 1 Apellido, nombres y fecha de ingreso de todos los colaboradores

SELECT Apellidos, Nombres, AñoIngreso FROM Colaboradores

-- 2 Apellido, nombres y antigüedad de todos los colaboradores

SELECT
    Apellidos, 
    Nombres,
    YEAR(GETDATE()) - AñoIngreso AS 'ANTIGUEDAD' 
FROM Colaboradores

-- 3 Apellido y nombres de aquellos colaboradores que trabajen part-time.

SELECT 
    Apellidos, 
    Nombres
FROM Colaboradores
WHERE ModalidadTrabajo = 'P'

-- 4 Apellido y nombres, antigüedad y modalidad de trabajo de aquellos colaboradores
-- cuyo sueldo sea entre 50000 y 100000.

SELECT
    Apellidos,
    Nombres,
    YEAR(GETDATE()) - AñoIngreso AS 'ANTIGUEDAD',
    ModalidadTrabajo,
    Sueldo
FROM Colaboradores
WHERE Sueldo 
    BETWEEN 50000 AND 100000

-- 5 Apellidos y nombres y edad de los colaboradores con legajos 4, 6, 12 y 25.

SELECT 
    Apellidos,
    Nombres,
    DATEDIFF(YEAR,FechaNacimiento,GETDATE()) AS 'EDAD'
FROM Colaboradores

-- 6 Todos los datos de todos los productos ordenados por precio de venta. Del más
-- caro al más barato

SELECT
    ID,
    IDCategoria,
    Descripcion,
    DiasConstruccion,
    Costo,
    Precio,
    PrecioVentaMayorista,
    CantidadMayorista,
    Estado
FROM Productos 
ORDER BY Precio DESC

-- 7 El nombre del producto más costoso.

SELECT TOP 1 Descripcion 
FROM Productos
ORDER BY Precio DESC

-- 8 Todos los datos de todos los pedidos que hayan superado el monto de $20000.

SELECT
    ID,
    IDCliente,
    IDProducto,
    Cantidad,
    FechaSolicitud,
    FechaFinalizacion,
    Costo,
    Pagado,
    Estado
FROM Pedidos
WHERE
    Costo > 20000

-- 9 Apellido y nombres de los clientes que no hayan registrado teléfono.

SELECT 
    Apellidos,
    Nombres
FROM Clientes
WHERE
    Telefono IS NULL

-- 10 Apellido y nombres de los clientes que hayan registrado mail pero no teléfono.

SELECT
    Apellidos,
    Nombres
FROM Clientes
WHERE
    Mail IS NOT NULL AND
    Telefono IS NULL

-- 11 Apellidos, nombres y datos de contacto de todos los clientes.
-- Nota: En datos de contacto debe figurar el número de celular, si no tiene celular el
-- número de teléfono fijo y si no tiene este último el mail. En caso de no tener ninguno
-- de los tres debe figurar 'Incontactable'.



-- 12 Apellidos, nombres y medio de contacto de todos los clientes. Si tiene celular debe
-- figurar 'Celular'. Si no tiene celular pero tiene teléfono fijo debe figurar 'Teléfono fijo'
-- de lo contrario y si tiene Mail debe figurar 'Email'. Si no posee ninguno de los tres
-- debe figurar NULL.
-- 13 Todos los datos de los colaboradores que hayan nacido luego del año 2000
-- 14 Todos los datos de los colaboradores que hayan nacido entre los meses de Enero y
-- Julio (inclusive)
-- 15 Todos los datos de los clientes cuyo apellido finalice con vocal
-- 16 Todos los datos de los clientes cuyo nombre comience con 'A' y contenga al menos
-- otra 'A'. Por ejemplo, Ana, Anatasia, Aaron, etc
-- 17 Todos los colaboradores que tengan más de 10 años de antigüedad
-- 18 Los códigos de producto, sin repetir, que hayan registrado al menos un pedido
-- 19 Todos los datos de todos los productos con su precio aumentado en un 20%
-- 20 Todos los datos de todos los colaboradores ordenados por apellido
-- ascendentemente en primera instancia y por nombre descendentemente en segunda
-- instancia.