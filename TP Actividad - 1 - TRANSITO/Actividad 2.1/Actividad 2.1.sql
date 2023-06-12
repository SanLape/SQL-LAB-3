
-- Actividad 2.1
-- # Consulta
-- ===========================

use AgenciaTransito

-- 1 Apellido, nombres y fecha de ingreso de todos los agentes
SELECT Apellidos, Nombres, FechaIngreso FROM Agentes

-- 2 Apellido, nombres y antigüedad de todos los agentes

SELECT Apellidos, Nombres, DATEDIFF(YEAR, FechaIngreso, GETDATE()) AS 'ANTIGUEDAD' FROM Agentes

-- 3 Apellido y nombres de aquellos colaboradores que no estén activos.

SELECT Apellidos, Nombres, Activo FROM Agentes WHERE Activo = 1

-- 4 Apellido y nombres y antigüedad de aquellos colaboradores cuyo sueldo sea entre
-- 50000 y 100000.

-- 5 Apellidos y nombres y edad de los colaboradores con legajos A001, A005 y A015

SELECT Apellidos, Nombres, FechaNacimiento 
FROM Agentes 
WHERE Legajo LIKE 'A0%[01-05-15]'

-- 6 Todos los datos de todas las multas ordenadas por monto de forma descendente.

SELECT IdMulta, IdTipoInfraccion, IDLocalidad, IdAgente, Patente, FechaHora, Monto, Pagada 
FROM Multas 
ORDER BY Monto ASC

-- 7 Todos los datos de las multas realizadas en el mes 02 de 2023.

SELECT IdMulta, IdTipoInfraccion, IDLocalidad, IdAgente, Patente, FechaHora, Monto, Pagada 
FROM MULTAS 
WHERE DATEPART(MONTH, FechaHora) = 02 AND DATEPART(YEAR, FechaHora) = 2023 

-- 8 Todos los datos de todas las multas que hayan superado el monto de $20000.

SELECT IdMulta, IdTipoInfraccion, IDLocalidad, IdAgente, Patente, FechaHora, Monto, Pagada 
FROM Multas
WHERE Monto > 20000

-- 9 Apellido y nombres de los agentes que no hayan registrado teléfono.

SELECT Apellidos, Nombres FROM Agentes
WHERE Telefono IS NULL

-- 10 Apellido y nombres de los agentes que hayan registrado mail pero no teléfono.

SELECT Apellidos, Nombres FROM Agentes 
WHERE Email IS NOT NULL AND Telefono IS NULL

-- 11 Apellidos, nombres y datos de contacto de todos los agentes.
-- Nota: En datos de contacto debe figurar el número de celular, si no tiene celular el
-- número de teléfono fijo y si no tiene este último el mail. En caso de no tener ninguno
-- de los tres debe figurar 'Incontactable'.

SELECT Apellidos, Nombres,
    CASE 
        WHEN Celular IS NOT NULL THEN Celular
        WHEN Telefono IS NOT NULL THEN Telefono
        WHEN Email IS NOT NULL THEN Email
        ELSE 'INCONTACTABLE'
    END AS CONTATTO 
FROM Agentes 

-- 12 Apellidos, nombres y medio de contacto de todos los agentes. Si tiene celular debe
-- figurar 'Celular'. Si no tiene celular pero tiene teléfono fijo debe figurar 'Teléfono fijo'
-- de lo contrario y si tiene Mail debe figurar 'Email'. Si no posee ninguno de los tres
-- debe figurar NULL.

SELECT Apellidos, Nombres, 
    CASE
        WHEN Celular IS NOT NULL THEN 'CELULAR'
        WHEN Telefono IS NOT NULL THEN 'TELEFONO FIJO'
        WHEN Email IS NOT NULL THEN 'EMAIL'
    END AS CONTACTO 
FROM Agentes

-- 13 Todos los datos de los agentes que hayan nacido luego del año 2000

SELECT IdAgente, Legajo, Nombres, Apellidos, FechaNacimiento, FechaIngreso, Email, Telefono, Celular, Activo FROM Agentes
WHERE DATEDIFF(YEAR, FechaNacimiento, GETDATE()) > 2000 

-- 14 Todos los datos de los agentes que hayan nacido entre los meses de Enero y Julio
-- (inclusive)

SELECT IdAgente, Legajo, Nombres, Apellidos, FechaNacimiento, FechaIngreso, Email, Telefono, Celular, Activo FROM Agentes
WHERE MONTH(FechaNacimiento) BETWEEN 1 AND 8

-- 15 Todos los datos de los agentes cuyo apellido finalice con vocal

SELECT IdAgente, Legajo, Nombres, Apellidos, FechaNacimiento, FechaIngreso, Email, Telefono, Celular, Activo FROM Agentes
WHERE Apellidos LIKE '%[A-E-I-O-U]'

-- 16 Todos los datos de los agentes cuyo nombre comience con 'A' y contenga al menos
-- otra 'A'. Por ejemplo, Ana, Anatasia, Aaron, etc

SELECT IdAgente, Legajo, Nombres, Apellidos, FechaNacimiento, FechaIngreso, Email, Telefono, Celular, Activo FROM Agentes
WHERE Nombres LIKE '[A]%[A]'

-- 17 Todos los agentes que tengan más de 10 años de antigüedad

SELECT IdAgente, Legajo, Nombres, Apellidos, FechaNacimiento, FechaIngreso, Email, Telefono, Celular, Activo FROM Agentes
WHERE DATEDIFF(YEAR, FechaIngreso, GETDATE()) > 10

-- 18 Las patentes, sin repetir, que hayan registrado multas

SELECT DISTINCT patente FROM Multas

-- 19 Todos los datos de todas las multas labradas en el mes de marzo de 2023 con un
-- recargo del 25% en una columna llamada NuevoImporte.

SELECT IdMulta, IdTipoInfraccion, IDLocalidad, IdAgente, Patente, FechaHora, Monto, Pagada, Monto * 1.25 AS 'NUEVO IMPORTE'
FROM Multas 
WHERE MONTH(FechaHora) = 3 AND YEAR(FechaHora) = 2023

-- 20 Todos los datos de todos los colaboradores ordenados por apellido
-- ascendentemente en primera instancia y por nombre descendentemente en segunda
-- instancia.

SELECT IdAgente, Legajo, Nombres, Apellidos, FechaNacimiento, FechaIngreso, Email, Telefono, Celular, Activo 
FROM Agentes
ORDER BY Apellidos ASC, Nombres DESC
