-- Actividad 2.2
-- # Consulta
-- =================
USE AgenciaTransito

-- 1 Listado con las localidades, su ID, nombre y el nombre de la provincia a la que
-- pertenece.

SELECT 
    L.IDLocalidad, L.Localidad, P.Provincia
FROM 
    Localidades AS L
INNER JOIN 
    Provincias AS P
    ON L.IDProvincia = P.IDProvincia

-- 2 Listado que informe el ID de la multa, el monto a abonar y los datos del agente que
-- la realizó. Debe incluir los apellidos y nombres de los agentes. Así como también la
-- fecha de nacimiento y la edad.

SELECT
    M.IdMulta, M.Monto, M.IdAgente, A.Apellidos, A.Nombres, A.FechaNacimiento, DATEDIFF(YEAR,A.FechaNacimiento,GETDATE()) AS 'EDAD'
FROM 
    Multas AS M
LEFT JOIN
    Agentes AS A
    ON M.IdAgente = A.IdAgente

-- 3 Listar todos los datos de todas las multas realizadas por agentes que a la fecha de
-- hoy tengan más de 5 años de antigüedad.

SELECT 
    M.IdMulta, M.IdTipoInfraccion, M.IDLocalidad, M.IdAgente, M.Patente, CONVERT(DATE,M.FechaHora) AS 'FECHA', M.Monto, M.Pagada
FROM 
    Multas AS M
LEFT JOIN
    AGENTES AS A
    ON M.IdAgente = A.IdAgente
    WHERE 
        DATEDIFF(YEAR,FechaIngreso,GETDATE()) >= 5

-- 4 Listar todos los datos de todas las multas cuyo importe de referencia supere los
-- $15000.

SELECT 
    M.IdMulta, M.IdTipoInfraccion, M.IDLocalidad, M.IdAgente, M.Patente, CONVERT(DATE,M.FechaHora) AS 'FECHA', M.Monto, M.Pagada
FROM 
    Multas AS M
    WHERE M.Monto > 15000

-- 5 Listar los nombres y apellidos de los agentes, sin repetir, que hayan labrado multas
-- en la provincia de Buenos Aires (1) o en Cordoba (2).

SELECT DISTINCT 
    A.Nombres, A.Apellidos 
FROM 
    Agentes AS A
LEFT JOIN 
    Multas AS M
    ON A.IdAgente = M.IdAgente
    LEFT JOIN 
        Provincias AS P
        ON P.IDProvincia = M.IDLocalidad
    WHERE 
        M.IDLocalidad IN (1,2)

-- 6 Listar los nombres y apellidos de los agentes, sin repetir, que hayan labrado multas
-- del tipo "Exceso de velocidad" (1).

SELECT DISTINCT 
    A.Nombres, A.Apellidos
FROM 
    Agentes AS A
LEFT JOIN
    Multas AS M
    ON M.IdAgente = A.IdAgente
        LEFT JOIN
        TipoInfracciones AS TI
        ON TI.IdTipoInfraccion = M.IdTipoInfraccion
    WHERE 
        TI.Descripcion LIKE ('Exceso de velocidad')

-- 7 Listar apellidos y nombres de los agentes que no hayan labrado multas.

SELECT DISTINCT 
    A.Nombres, A.Apellidos
FROM 
    Agentes AS A
LEFT JOIN 
    Multas AS M
    ON A.IdAgente = M.IdAgente
    WHERE A.IdAgente IS NULL

    -- TODOS LOS AGENTES EMITIERON MULTAS

-- 8 Por cada multa, lista el nombre de la localidad y provincia, el tipo de multa, los
-- apellidos y nombres de los agentes y su legajo, el monto de la multa y la diferencia
-- en pesos en relación al tipo de infracción cometida.

SELECT 
    L.Localidad, P.Provincia, TI.Descripcion, A.Nombres, A.Apellidos, A.Legajo, M.Monto, (M.Monto - TI.ImporteReferencia) AS 'DIFERENCIA'
FROM 
    Multas AS M
LEFT JOIN 
    Localidades AS L
    ON L.IDLocalidad = M.IDLocalidad
    LEFT JOIN
        Provincias AS P
        ON L.IDProvincia = P.IDProvincia
    LEFT JOIN
        TipoInfracciones AS TI
        ON M.IdTipoInfraccion = TI.IdTipoInfraccion 
    LEFT JOIN
        Agentes AS A
        ON A.IdAgente = M.IdAgente

-- 9 Listar las localidades en las que no se hayan registrado multas.

SELECT DISTINCT 
    L.IDLocalidad, L.Localidad, L.IDProvincia
FROM
    Localidades AS L
LEFT JOIN
    Multas AS M 
    ON L.IDLocalidad = M.IDLocalidad
WHERE M.IdMulta IS NOT NULL

-- 10 Listar los datos de las multas pagadas que se hayan labrado en la provincia de
-- Buenos Aires.

SELECT 
    M.IdMulta, M.IdTipoInfraccion, M.IDLocalidad, M.IdAgente, M.Patente, M.FechaHora, M.Monto, M.Pagada  
FROM 
    Multas AS M
LEFT JOIN 
    Localidades AS L
    ON L.IDLocalidad = M.IDLocalidad
LEFT JOIN
    Provincias AS P
    ON L.IDProvincia = P.IDProvincia
WHERE 
    P.Provincia LIKE ('Buenos Aires') AND M.Pagada = 1

-- 11 Listar el ID de la multa, la patente, el monto y el importe de referencia a partir del tipo
-- de infracción cometida. También incluir una columna llamada TipoDeImporte a
-- partir de las siguientes condiciones:
-- 'Punitorio' si el monto de la multa es mayor al importe de referencia
-- 'Leve' si el monto de la multa es menor al importe de referencia
-- 'Justo' si el monto de la multa es igual al importe de referencia

SELECT 
    M.IdMulta, M.Patente, M.Monto, TI.ImporteReferencia, 
    CASE
        WHEN (M.Monto > TI.ImporteReferencia) THEN 'PUNITORIO'
        WHEN (M.Monto < TI.ImporteReferencia) THEN 'LEVE'
        WHEN (M.Monto = TI.ImporteReferencia) THEN 'JUSTO'
    END AS 'TIPO DE IMPORTE'
FROM 
    Multas AS M
LEFT JOIN
    TipoInfracciones AS TI
    ON TI.IdTipoInfraccion = M.IdTipoInfraccion
