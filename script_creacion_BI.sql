USE GD1C2024
GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'LA_TERCERA_ES_LA_VENCIDA_GDD')
BEGIN 
	EXEC ('CREATE SCHEMA LA_TERCERA_ES_LA_VENCIDA_GDD')
END


CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Localidad ( 
    ID_Provincia INT,
	ID_Localidad INT,
    Nombre_Provincia VARCHAR(32),
	Nombre_Localidad VARCHAR(64)
    PRIMARY KEY ([ID_Provincia],[ID_Localidad])
	
)


CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Sucursal
(
ID_Sucursal INT PRIMARY KEY,
Nombre_Sucursal VARCHAR(64),
Direccion VARCHAR(64),
ID_Localidad INT,--> FK
ID_Provincia INT --> FK
FOREIGN KEY ([ID_Provincia],[ID_Localidad]) REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Localidad
)



CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Empleado (
    Legajo INT PRIMARY KEY,
    Nombre VARCHAR(32),
    Apellido VARCHAR(32),
    Rango_Etario VARCHAR(10) CHECK (Rango_Etario IN ('<25','25-35','35-50','>50')),
    Fecha_Nacimiento DATE,
    Fecha_Registro DATE,
    ID_Sucursal INT --> FK
	FOREIGN KEY (ID_Sucursal) REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Sucursal
)

CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Cliente (
    Legajo INT PRIMARY KEY,
    Nombre VARCHAR(32),
    Apellido VARCHAR(32),
    Rango_Etario VARCHAR(10) CHECK (Rango_Etario IN ('<25','25-35','35-50','>50')),
    Fecha_Nacimiento DATE,
	ID_Localidad INT,--> FK
	ID_Provincia INT --> FK
	FOREIGN KEY ([ID_Provincia],[ID_Localidad]) REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Localidad

)


CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Tiempo
(
	codigo INT IDENTITY PRIMARY KEY,
	anio INT,
	cuatrimestre INT,
	mes INT,
	semana INT,
	dia INT,
)

CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Turno
(
	codigo INT IDENTITY PRIMARY KEY,
	nombre VARCHAR(32) 
)

CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Caja
(
	codigo INT IDENTITY PRIMARY KEY,
	nombre VARCHAR(32) 
)

CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Medio_Pago
(
	codigo INT IDENTITY PRIMARY KEY,
	nombre VARCHAR(255) 
)



CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Categoria(
    Cod_Categoria INT PRIMARY KEY,
    Nombre VARCHAR(255)
)


CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.BI_SubCategoria(
Cod_SubCategoria INT PRIMARY KEY,
Cod_Categoria_Padre INT,
Nombre VARCHAR(255)
FOREIGN KEY (Cod_Categoria_Padre) REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Categoria
)


CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Producto(
    Cod_Prod INT PRIMARY KEY,
    Nombre VARCHAR(255),
    Precio_unit DECIMAL(10,2),
    Subcategoria INT
    FOREIGN KEY (Subcategoria) REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.BI_SubCategoria
)

CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Promocion_Producto(
ID INT PRIMARY KEY,
Promocion INT,
Producto INT
FOREIGN KEY (Producto) REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Producto
)

CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Detalle_Ticket(
	ID INT PRIMARY KEY,
	Producto_ID INT,
	Fecha_hora DATETIME,
	ID_Fecha_hora INT
	FOREIGN KEY (Producto_ID) REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Producto,
	FOREIGN KEY (ID_Fecha_hora) REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Tiempo	
)



  --------------------------------------
  --------- TABLAS DE HECHOS -----------
  --------------------------------------
  
  --------------------------------------
  --------- TABLAS DE TICKET -----------
  --------------------------------------

CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Ticket
(
	ID_Ticket INT PRIMARY KEY,
	Fecha_Hora DATETIME,
	Tiempo INT,
	Turno INT,
	Nro_Ticket INT,
	ID_Sucursal INT,
	ID_Empleado INT,
	ID_Cliente INT,
	Caja INT,
	Sub_Total_Ticket DECIMAL(10,2),
	Total_Promociones DECIMAL(10,2),
	Total_Descuento_Medio DECIMAL(10,2),
	Importe_Total DECIMAL(10,2),
	Cantidad_Artículos INT,
	FOREIGN KEY (ID_Sucursal) REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Sucursal,
	FOREIGN KEY (ID_Empleado) REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Empleado,
	FOREIGN KEY (ID_Cliente) REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Cliente,
	FOREIGN KEY (Tiempo) REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Tiempo,
	FOREIGN KEY (Turno) REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Turno

)
  --------------------------------------
  --------- TABLAS DE ENVIO  -----------
  --------------------------------------

  CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Envio
(
	Nro_Envio INT PRIMARY KEY,
	ID_Cliente INT,
	ID_Sucursal INT,
	Costo DECIMAL(10,2),
	Fecha_Entrega DATETIME,
	Fecha_Programada DATETIME,
	Horario_Inicio INT,
	Horario_Fin INT,
	ID_Tiempo_Fecha_Entrega INT,
	ID_Tiempo_Fecha_Programado INT
	
	FOREIGN KEY (ID_Tiempo_Fecha_Programado) REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Tiempo,
	FOREIGN KEY (ID_Tiempo_Fecha_Entrega) REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Tiempo,
	FOREIGN KEY (ID_Cliente) REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Cliente,
	FOREIGN KEY (ID_Sucursal) REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Sucursal
)

  --------------------------------------
  --------- TABLA DE PAGO    -----------
  --------------------------------------
  CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Pago
  (
	Nro_Pago INT PRIMARY KEY,
	Fecha_Pago DATE,
	ID_Tiempo_Fecha_Pago INT,
	ID_Sucursal INT,
	Importe DECIMAL (10,2),
	Monto_Descontado DECIMAL(10,2),
	ID_Medio_Pago INT,
	ID_Cliente INT,
	Cuotas INT

	FOREIGN KEY (ID_Tiempo_Fecha_Pago) REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Tiempo,
	FOREIGN KEY (ID_Sucursal) REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Sucursal,
	FOREIGN KEY (ID_Medio_Pago) REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Medio_Pago,
	FOREIGN KEY (ID_Cliente) REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Cliente

  )

  --------------------------------------
  --------- TABLA DE PROMOCION ---------
  --------------------------------------

  CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Promocion_Aplicada(
DetalleTicket INT,
Ticket_Promo INT,
Descuento INT
FOREIGN KEY (DetalleTicket) REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Detalle_Ticket,
FOREIGN KEY (Ticket_Promo) REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Promocion_Producto
)



  --------------------------------------
  --------- INSERTAR  DATO   -----------
  --------------------------------------

CREATE FUNCTION dbo.rangoEtario(@Fecha_Nacimiento DATE)
RETURNS VARCHAR(10)
AS
BEGIN
    DECLARE @Rango VARCHAR(10)

    SELECT @Rango = CASE
        WHEN DATEDIFF(YEAR, @Fecha_Nacimiento, GETDATE()) < 25 THEN '<25'
        WHEN DATEDIFF(YEAR, @Fecha_Nacimiento, GETDATE()) BETWEEN 25 AND 34 THEN '25-35'
        WHEN DATEDIFF(YEAR, @Fecha_Nacimiento, GETDATE()) BETWEEN 35 AND 49 THEN '35-50'
        ELSE '>50'
    END

    RETURN @Rango
END;


INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Localidad(ID_Localidad,ID_Provincia,Nombre_Localidad,Nombre_Provincia)
	SELECT Localidad.ID,Provincia.ID,Localidad.Nombre,Provincia.Nombre FROM LA_TERCERA_ES_LA_VENCIDA_GDD.Localidad_Provincia as Localidad_Provincia
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Localidad as Localidad ON ( Localidad.ID = Localidad_Provincia.LocalidadID )
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Provincia as Provincia ON ( Provincia.ID = Localidad_Provincia.ProvinciaID )


INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Sucursal(ID_Sucursal,Nombre_Sucursal,Direccion,ID_Localidad,ID_Provincia)
	SELECT Sucursal.ID,Sucursal.Nombre,Sucursal.Direccion,Localidad.ID_Localidad,Localidad.ID_Provincia FROM LA_TERCERA_ES_LA_VENCIDA_GDD.Sucursal as Sucursal
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Localidad_Provincia as Localidad_Provincia ON ( Localidad_Provincia.ID = Sucursal.Localidad_Provincia )
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Localidad as Localidad ON (Localidad.ID_Localidad = Localidad_Provincia.LocalidadID AND Localidad_Provincia.ProvinciaID = Localidad.ID_Provincia )


INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Empleado(Legajo,Nombre,Apellido,Fecha_Nacimiento,Fecha_Registro, ID_Sucursal, Rango_Etario)
	SELECT Legajo,Nombre,Apellido,Fecha_Nacimiento,Fecha_Registro, Sucursal.ID_Sucursal,dbo.rangoEtario(Empleado.Fecha_Nacimiento) FROM LA_TERCERA_ES_LA_VENCIDA_GDD.Empleado as Empleado
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Sucursal as Sucursal ON (Sucursal.ID_Sucursal = Empleado.Sucursal)


INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Cliente(Legajo,Nombre,Apellido,Fecha_Nacimiento,ID_Localidad,ID_Provincia, Rango_Etario)
	SELECT Cliente.ID,Nombre,Apellido,Fecha_Nacimiento,Localidad.ID_Localidad,Localidad.ID_Provincia, dbo.rangoEtario(Cliente.Fecha_Nacimiento) FROM LA_TERCERA_ES_LA_VENCIDA_GDD.Cliente as Cliente
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Localidad_Provincia as Localidad_Provincia ON ( Localidad_Provincia.ID = Cliente.Localidad_Provincia )
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Localidad as Localidad ON (Localidad.ID_Localidad = Localidad_Provincia.LocalidadID AND Localidad_Provincia.ProvinciaID = Localidad.ID_Provincia )


INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Tiempo(anio, cuatrimestre, mes, semana, dia)
SELECT DISTINCT
    YEAR(c.Fecha_Hora) AS anio,
    DATEPART(QUARTER, c.Fecha_Hora) AS cuatrimestre,
    MONTH(c.Fecha_Hora) AS mes,
    DATEPART(WEEK, c.Fecha_Hora) AS semana,
    DAY(c.Fecha_Hora) AS dia
FROM LA_TERCERA_ES_LA_VENCIDA_GDD.Ticket c

UNION

SELECT DISTINCT
    YEAR(c.Fecha_Programada) AS anio,
    DATEPART(QUARTER, c.Fecha_Programada) AS cuatrimestre,
    MONTH(c.Fecha_Programada) AS mes,
    DATEPART(WEEK, c.Fecha_Programada) AS semana,
    DAY(c.Fecha_Programada) AS dia
FROM LA_TERCERA_ES_LA_VENCIDA_GDD.Envío c;



INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Turno(nombre)
	VALUES ('08:00 - 12:00'),('12:00 - 16:00'),('16:00 - 20:00'),('Otros')


INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Caja(nombre)
	SELECT Nombre FROM LA_TERCERA_ES_LA_VENCIDA_GDD.Tipo_Caja 


INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Medio_Pago(nombre)
	SELECT Nombre FROM LA_TERCERA_ES_LA_VENCIDA_GDD.Medio_Pago



INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Ticket(ID_Ticket,Nro_Ticket,ID_Sucursal,ID_Empleado,ID_Cliente,Tiempo,Fecha_Hora,Turno,Importe_Total, Caja,Total_Descuento_Medio, Cantidad_Artículos, Sub_Total_Ticket,Total_Promociones ) -- TODO
	SELECT Ticket.ID,Ticket.Nro_Ticket,Sucursal.ID_Sucursal,Empleado.Legajo,Cliente.Legajo,Tiempo.codigo,Ticket.Fecha_Hora,Turno.codigo,Ticket.Importe_total,CajaBI.codigo,Ticket.Total_descuento_medio, SUM(Detalle.Cantidad), Ticket.Sub_total_ticket, Ticket.Total_promociones FROM LA_TERCERA_ES_LA_VENCIDA_GDD.Ticket as Ticket
		JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Sucursal as Sucursal ON ( Sucursal.ID_Sucursal = Ticket.Sucursal )
		JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Empleado as Empleado ON (Empleado.Legajo = Ticket.Empleado)
		LEFT JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Cliente  as Cliente ON (Ticket.Cliente = Cliente.Legajo)
		JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Tiempo as Tiempo ON ( 
			YEAR(Ticket.Fecha_Hora) = Tiempo.anio AND
			DATEPART(QUARTER, Ticket.Fecha_Hora) = Tiempo.cuatrimestre AND
			MONTH(Ticket.Fecha_Hora) = Tiempo.mes AND
			DATEPART(WEEK, Ticket.Fecha_Hora) = Tiempo.semana AND
			DAY(Ticket.Fecha_Hora) = Tiempo.dia
			)
		JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Detalle_Ticket as Detalle ON (Detalle.ID_TICKET = Ticket.ID)
		JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Turno as Turno ON ( 
			(DATEPART(HOUR, Ticket.Fecha_Hora) BETWEEN 8 AND 12 AND Turno.nombre = '08:00 - 12:00') OR
			(DATEPART(HOUR, Ticket.Fecha_Hora) BETWEEN 13 AND 16 AND Turno.nombre = '12:00 - 16:00') OR
			(DATEPART(HOUR, Ticket.Fecha_Hora) BETWEEN 17 AND 20 AND Turno.nombre = '16:00 - 20:00') OR
			((DATEPART(HOUR, Ticket.Fecha_Hora) BETWEEN 0 AND 7 OR  (DATEPART(HOUR, Ticket.Fecha_Hora) BETWEEN 21 AND 24 ) ) AND Turno.nombre = 'Otros')
		)
		JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Caja as Caja ON (Caja.Numero = Ticket.Caja AND Ticket.Sucursal = Caja.Sucursal)
		JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Tipo_Caja as Tipo ON (Tipo.ID = Caja.Tipo_caja)
		JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Caja as CajaBI ON (Tipo.Nombre = CajaBI.nombre)
	GROUP BY Ticket.ID,Ticket.Nro_Ticket,Sucursal.ID_Sucursal,Empleado.Legajo,Cliente.Legajo,Fecha_Hora,Tiempo.codigo,Turno.codigo,CajaBI.codigo,Ticket.Total_descuento_medio,Ticket.Importe_total,Ticket.Sub_total_ticket, Ticket.Total_promociones

INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Envio(Nro_Envio,Fecha_Entrega,Fecha_Programada,ID_Tiempo_Fecha_Entrega,ID_Tiempo_Fecha_Programado,ID_Cliente, ID_Sucursal, Horario_Inicio, Horario_Fin, Costo)
	SELECT Nro_Envío,Fecha_Entrega,Fecha_Programada,TiempoEntrega.codigo,TiempoEntrega.codigo,Cliente.Legajo,Ticket.ID_Sucursal,Envio.Horario_Inicio,Horario_Fin, Envio.Costo FROM LA_TERCERA_ES_LA_VENCIDA_GDD.Envío AS Envio
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Tiempo as TiempoEntrega ON ( 
			YEAR(Envio.Fecha_Entrega) = TiempoEntrega.anio AND
			DATEPART(QUARTER, Envio.Fecha_Entrega) = TiempoEntrega.cuatrimestre AND
			MONTH(Envio.Fecha_Entrega) = TiempoEntrega.mes AND
			DATEPART(WEEK, Envio.Fecha_Entrega) = TiempoEntrega.semana AND
			DAY(Envio.Fecha_Entrega) = TiempoEntrega.dia
		)
    JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Ticket as Ticket ON (Ticket.ID_Ticket = Envio.Ticket)
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Cliente as Cliente ON (Cliente.Legajo = Ticket.ID_Cliente)


INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Pago(Nro_Pago,Fecha_Pago,ID_Tiempo_Fecha_Pago,ID_Sucursal,Importe,Monto_Descontado,ID_Medio_Pago,ID_Cliente,Cuotas)
  SELECT Pago.Nro_pago,Pago.Fecha_pago,Ticket.Tiempo,Ticket.ID_Sucursal,Pago.Importe,Pago.Monto_descontado,MedioPago.codigo,Ticket.ID_Cliente,Detalle.Cuotas FROM LA_TERCERA_ES_LA_VENCIDA_GDD.Pago as Pago
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Ticket as Ticket ON (Pago.TicketID = Ticket.ID_Ticket) 
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Medio_Pago as MedioPago ON (Pago.Medio_pago = MedioPago.codigo)
	LEFT JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Detalle_Pago as Detalle ON (Detalle.Pago = Pago.Nro_pago)


INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Categoria(Cod_Categoria, Nombre)
SELECT Cod_categoria, Nombre FROM LA_TERCERA_ES_LA_VENCIDA_GDD.Categoria

INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.BI_SubCategoria(Cod_SubCategoria, Cod_Categoria_Padre, Nombre)
SELECT SubCategoria.Cod_SubCategoria, SubCategoria.Cod_categoria_padre, SubCategoria.Nombre FROM LA_TERCERA_ES_LA_VENCIDA_GDD.SubCategoria as SubCategoria
JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Categoria AS Categoria ON SubCategoria.Cod_categoria_padre = Categoria.Cod_Categoria 

INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Producto(Cod_Prod, Nombre, Precio_unit, Subcategoria)
SELECT Producto.Cod_Prod, Producto.Nombre, Producto.Precio_unit, SubCategoria.Cod_SubCategoria FROM LA_TERCERA_ES_LA_VENCIDA_GDD.Producto AS Producto
JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_SubCategoria AS SubCategoria ON SubCategoria.Cod_SubCategoria = Producto.Subcategoria


INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Detalle_Ticket(ID,Producto_ID,ID_Fecha_hora,Fecha_hora)
SELECT 
    Det_Ticket.ID, 
    Det_Ticket.ID_PRODUCTO,
	Tiempo.codigo,
	Ticket.Fecha_hora
FROM LA_TERCERA_ES_LA_VENCIDA_GDD.Detalle_Ticket AS Det_Ticket 
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Ticket AS Ticket ON (Det_Ticket.ID_TICKET = Ticket.ID_Ticket) 
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Producto AS Producto  ON (Det_Ticket.ID_PRODUCTO = Producto.Cod_Prod)
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Tiempo AS Tiempo ON (Tiempo.codigo = Ticket.Tiempo)

INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Promocion_Producto(ID, Promocion, Producto)
SELECT PromoProd.ID, PromoProd.Promocion, Producto.Cod_Prod FROM LA_TERCERA_ES_LA_VENCIDA_GDD.Promocion_Producto AS PromoProd
JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Producto AS Producto ON PromoProd.Producto = Producto.Cod_Prod 

INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Promocion_Aplicada(DetalleTicket, Ticket_Promo, Descuento)
SELECT PromoAplicada.ID_Ticket, PromoAplicada.ID_Promo, Descuento FROM LA_TERCERA_ES_LA_VENCIDA_GDD.Promocion_Aplicada AS PromoAplicada
JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Detalle_Ticket AS Det_Ticket ON PromoAplicada.ID_Ticket = Det_Ticket.ID
JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Promocion_Producto AS PromoProd ON PromoAplicada.ID_Promo = PromoProd.ID

  --------------------------------------
  ---------     VISTAS       -----------
  --------------------------------------



	-- PRIMERA VISTA PUNTO 1

CREATE VIEW Ticket_Promedio_Mensual (Localidad,Anio,mes, valorPromedio) 
	AS 
	SELECT Localidad.Nombre_Localidad ,Tiempo.Anio, Tiempo.Mes,  AVG(Ticket.Importe_total) FROM LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Ticket as Ticket
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Sucursal as Sucursal ON (Ticket.ID_Sucursal = Sucursal.ID_Sucursal)
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Localidad as Localidad ON (Localidad.ID_Localidad = Sucursal.ID_Localidad AND Localidad.ID_Provincia = Sucursal.ID_Provincia)
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Tiempo as Tiempo ON ( Ticket.Tiempo = Tiempo.codigo )
	GROUP BY Localidad.Nombre_Localidad ,Tiempo.Anio, Tiempo.Mes
	

	--SEGUNDA VISTA PUNTO 2

CREATE VIEW Cant_Unidades_Promedio(Turno,Cuatrimestre,Anio,Promedio)
	AS
	SELECT Turno.nombre,Tiempo.cuatrimestre, Tiempo.anio, AVG(Ticket.Cantidad_Artículos) FROM LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Ticket AS Ticket
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Turno as Turno ON ( Turno.codigo = Ticket.Turno )
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Tiempo as Tiempo ON ( Ticket.tiempo = Tiempo.codigo )
	GROUP BY Turno.nombre,Tiempo.cuatrimestre, Tiempo.anio


	--TERCERA VISTA PUNTO 3

CREATE VIEW Porcentaje_Anual_De_Ventas (Rango_Etario,Tipo_Caja,Cuatrimestre,Porcentaje)
	AS
	SELECT Empleado.Rango_Etario, Caja.Nombre, Tiempo.Cuatrimestre, CAST ( COUNT(*) AS FLOAT) / CAST ( (Select COUNT(*) FROM LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Ticket) AS FLOAT)
		FROM LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Ticket AS Ticket
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Caja AS Caja ON (Caja.codigo = Ticket.Caja)
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Tiempo AS Tiempo ON (Tiempo.codigo = Ticket.Tiempo)
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Empleado AS Empleado ON (Empleado.Legajo = Ticket.ID_Empleado)
	GROUP BY Empleado.Rango_Etario, Caja.Nombre, Tiempo.Cuatrimestre


	--CUARTA VISTA PUNTO 4

CREATE VIEW Cant_De_Ventas_Registradas_X_Turno(Turno, Localidad, Mes, Anio, CantidadDeVentas)
AS
	SELECT Turno.nombre, Localidad.Nombre_Localidad, Tiempo.mes, Tiempo.anio, COUNT(*) FROM LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Ticket AS Ticket
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Turno as Turno ON ( Ticket.Turno = Turno.codigo )
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Sucursal as Sucursal ON (Ticket.ID_Sucursal = Sucursal.ID_Sucursal)
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Localidad as Localidad ON (Localidad.ID_Localidad = Sucursal.ID_Localidad AND Localidad.ID_Provincia = Sucursal.ID_Provincia)
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Tiempo as Tiempo ON ( Ticket.Tiempo = Tiempo.codigo )
	GROUP BY Turno.nombre, Localidad.Nombre_Localidad, Tiempo.mes, Tiempo.anio


	--QUINTA VISTA PUNTO 5

CREATE VIEW Porcetaje_De_Descuento_Aplicados_Funcion_Total_Tickets(Mes,Anio,Porcentaje)
AS
	SELECT Tiempo.mes,Tiempo.anio, SUM(Ticket.Total_Descuento_Medio + Ticket.Total_Promociones)/SUM(Ticket.Importe_Total) FROM LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Ticket AS Ticket
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Tiempo AS Tiempo ON (Ticket.Tiempo = Tiempo.codigo)
	GROUP BY Tiempo.mes,Tiempo.anio


	--SEXTA VISTA PUNTO 6
	
	CREATE VIEW Tres_Categorias_Con_Mayor_Descuento_Aplicado_Por_Cuatri(Anio,Cuatri,Categoria,Descuento)
	AS
	SELECT SubGrupo.Cod_Categoria, SubGrupo.anio, SubGrupo.cuatrimestre, SubGrupo.Descuento FROM (SELECT Categoria.Cod_Categoria, Tiempo.anio, Tiempo.cuatrimestre, SUM(PromoAplicada.Descuento) AS Descuento, ROW_NUMBER() OVER (PARTITION BY Tiempo.anio, Tiempo.cuatrimestre ORDER BY Tiempo.anio, Tiempo.cuatrimestre, SUM(PromoAplicada.Descuento) DESC) AS Grupo
        FROM LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Categoria AS Categoria
		JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_SubCategoria AS SubCategoria ON (Categoria.Cod_Categoria = SubCategoria.Cod_Categoria_Padre)
		JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Producto AS Producto ON (Producto.Subcategoria = Subcategoria.Cod_SubCategoria)
		JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Detalle_Ticket AS Detalle ON (Detalle.Producto_ID = Producto.Cod_Prod)
		JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Promocion_Producto AS Promocion ON (Promocion.Producto = Producto.Cod_Prod)
		JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Promocion_Aplicada AS PromoAplicada ON ( Detalle.ID = PromoAplicada.DetalleTicket AND Promocion.ID = PromoAplicada.Ticket_Promo)
		JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Ticket AS Ticket ON ( Ticket.ID_Ticket = Detalle.ID)
		JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Tiempo AS Tiempo ON (Tiempo.codigo = Ticket.Tiempo)
		GROUP BY Categoria.Cod_Categoria, Tiempo.anio, Tiempo.cuatrimestre
	 ) AS SubGrupo 
	 WHERE SubGrupo.Grupo <=3



	--SEPTIMA VISTA PUNTO 7

CREATE VIEW Porcentaje_De_Cumplimiento_De_Envios(Sucursal,Anio,Mes,Total_Envios,Porcentaje,Desvio)
AS
SELECT
	Sucursal.ID_Sucursal,Tiempo.anio,Tiempo.mes,COUNT(*),
     (SUM(CASE WHEN DATEPART(HOUR, Envio.Fecha_Entrega) BETWEEN Envio.Horario_Inicio AND Envio.Horario_fin  THEN 1 ELSE 0 END) * 100.0 / COUNT(*)),
     AVG(DATEDIFF(HOUR, Envio.Fecha_Programada, Envio.Fecha_Entrega)) 
FROM LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Envio AS Envio
    JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Sucursal AS Sucursal ON (Sucursal.ID_Sucursal = Envio.ID_Sucursal)
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Tiempo AS Tiempo ON (Tiempo.codigo = Envio.ID_Tiempo_Fecha_Entrega)
GROUP BY Sucursal.ID_Sucursal,Tiempo.anio,Tiempo.mes


	--OCTAVA VISTA PUNTO 8

CREATE VIEW Cantidad_De_Envios_Por_Rango_Etario_De_Clientes(CantidadEnvios,Rango, Cuatrimestre, Anio)
AS
SELECT COUNT(Cliente.Rango_Etario), Cliente.Rango_Etario, Tiempo.cuatrimestre, Tiempo.anio 
	FROM LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Envio as Envio
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Cliente as Cliente ON (Envio.ID_Cliente = Cliente.Legajo)
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Tiempo as Tiempo ON (Tiempo.codigo = Envio.ID_Tiempo_Fecha_Entrega)
	GROUP BY Cliente.Rango_Etario, Tiempo.cuatrimestre, Tiempo.anio 


	--NOVENA VISTA PUNTO 9

CREATE VIEW Las_Cinco_Localidades_Mayor_Costo_Envio(Localidad,Provincia, CostoEnvio)
AS
SELECT TOP 5 Localidad.Nombre_Localidad, Localidad.Nombre_Provincia, Envio.Costo 
	 FROM LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Envio as Envio
	 JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Cliente as Cliente ON (Envio.ID_Cliente = Cliente.Legajo)
	 JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Localidad as Localidad ON ( Cliente.ID_Provincia = Localidad.ID_Provincia AND Cliente.ID_Localidad = Localidad.ID_Localidad)
	 ORDER BY Envio.Costo DESC


	--DECIMA VISTA PUNTO 10

CREATE VIEW Las_Tres_Sucursales_Con_Mayor_Importe_En_Cuotas(Anio,Mes,Sucursal,MedioPago, Importe)
AS
SELECT SubGrupo.Anio, SubGrupo.Mes, Pago.ID_Sucursal, MedioPago.Nombre, SUM(Pago.Importe)
    FROM 
        LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Pago AS Pago
        JOIN ( SELECT  PagoTO.Nro_Pago, TiempoTO.Anio, TiempoTO.Mes,  ROW_NUMBER() OVER (PARTITION BY TiempoTO.Anio, TiempoTO.Mes ORDER BY TiempoTO.Anio, TiempoTO.Mes, SUM(PagoTo.Importe) DESC) AS Grupo 
					FROM LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Pago as PagoTO
					JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Tiempo as TiempoTO ON (PagoTO.ID_Tiempo_Fecha_Pago = TiempoTO.codigo)
					JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Medio_Pago AS MedioPago ON MedioPago.codigo = PagoTO.ID_Medio_Pago
					WHERE MedioPago.codigo != 3
					GROUP BY PagoTO.Nro_Pago, TiempoTO.Anio, TiempoTO.Mes
			  ) As SubGrupo ON (SubGrupo.Nro_Pago = Pago.Nro_Pago)
        JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Medio_Pago AS MedioPago ON MedioPago.codigo = Pago.ID_Medio_Pago
		WHERE SubGrupo.Grupo <= 3 
		GROUP BY SubGrupo.Anio, SubGrupo.Mes, Pago.ID_Sucursal, MedioPago.Nombre
	

	--ONCEAVA VISTA PUNTO 11

CREATE VIEW Promedio_de_importe
AS
SELECT AVG(Pago.Importe), Cliente.Rango_Etario FROM LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Pago AS Pago
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Cliente AS Cliente	ON (Cliente.Legajo = Pago.ID_Cliente)
	GROUP BY Cliente.Rango_Etario


	--DOCEAVA VISTA PUNTO 12

CREATE VIEW Porcetaje_De_Descuento_Aplicado(Cuatrimestre,MedioPago,Porcentaje)
AS
SELECT Tiempo.Cuatrimestre, MedioPago.Nombre, SUM (Pago.Monto_Descontado) / SUM(Pago.Importe + Pago.Monto_Descontado)
	FROM LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Pago AS Pago
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Tiempo AS Tiempo ON (Tiempo.codigo = Pago.ID_Tiempo_Fecha_Pago)
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.BI_Medio_Pago AS MedioPago ON (MedioPago.codigo = Pago.ID_Medio_Pago )
	GROUP BY Tiempo.Cuatrimestre, MedioPago.Nombre
	




--------------------------------------
--------------- TESTS ----------------
--------------------------------------

-- (1)
SELECT * from ticket_promedio_mensual
ORDER BY mes

-- (2)
SELECT * from Cant_Promedio_X_Cuatrimestre
ORDER BY Cuatrimestre

-- (3)
SELECT * from Porcentaje_Anual_De_Ventas
ORDER BY Rango_Etario

-- (4)
SELECT * from Cant_De_Ventas_Registradas_X_Turno

-- (5)
SELECT * from Porcetaje_De_Descuento_Aplicados_Funcion_Total_Tickets

-- (6)
SELECT * from Tres_Categorias_Con_Mayor_Descuento_Aplicado_Por_Cuatri

-- (7)
SELECT * FROM Porcentaje_De_Cumplimiento_De_Envios

-- (8)
SELECT * FROM Cantidad_De_Envios_Por_Rango_Etario_De_Clientes
order by Rango,Cuatrimestre

-- (9)
SELECT * FROM Las_Cinco_Localidades_Mayor_Costo_Envio

-- (10)
SELECT * FROM Las_Tres_Sucursales_Con_Mayor_Importe_En_Cuotas
ORDER BY 1,2,4 desc

-- (11)
SELECT * FROM Promedio_de_importe

-- (12)
SELECT * FROM Porcetaje_De_Descuento_Aplicado
ORDER BY 1,2
