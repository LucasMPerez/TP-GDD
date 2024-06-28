USE GD1C2024
GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'LA_TERCERA_ES_LA_VENCIDA_GDD')
BEGIN 
	EXEC ('CREATE SCHEMA LA_TERCERA_ES_LA_VENCIDA_GDD')
END
GO



CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Descuento_Medio_Pago] (
  [ID] INT IDENTITY(1,1),
  [Cod_Descuento] INT,
  [Descripcion] VARCHAR(255),
  [Medio_Pago] INT,
  [Fecha_Inicio] DATE,
  [Fecha_Final] DATE,
  [Descuento] DECIMAL(5, 2),
  [Tope_De_Descuento] DECIMAL(10, 2),
  PRIMARY KEY ([ID])
);

CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Descuento_aplicado] (
  [Pago] INT,
  [Descuento] INT,
  PRIMARY KEY ([Pago], [Descuento])
);


CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Tipo_Comprobante] (
  [ID] INT IDENTITY(1,1),
  [nombre] VARCHAR(255),
  PRIMARY KEY ([ID])
);

CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Cliente] (
  [ID] INT IDENTITY(1,1),
  [Nombre] VARCHAR(255),
  [Apellido] VARCHAR(255),
  [Direccion] VARCHAR(255),
  [Localidad_Provincia] INT, --> FK
  [Mail] VARCHAR(255),
  [Fecha_Registro] DATETIME,
  [Fecha_Nacimiento] DATE,
  [Telefono] VARCHAR(255),
  [DNI] INT,
  PRIMARY KEY ([ID])
);


CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Localidad] (
  [ID] INT IDENTITY(1,1),
  [Nombre] VARCHAR(255),
  PRIMARY KEY ([ID])
);


CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Localidad_Provincia] (
  [ID] INT IDENTITY(1,1),	
  [ProvinciaID] INT ,
  [LocalidadID] INT,
  PRIMARY KEY ([ID])
);


CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Provincia] (
  [ID] INT IDENTITY(1,1),
  [Nombre] VARCHAR(255),
  PRIMARY KEY ([ID])
);

CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Detalle_Pago] (
  [ID] INT IDENTITY(1,1),
  [Cliente] INT,
  [Tarjeta] INT, --> FK
  [Pago] INT,
  [Cuotas] INT,
  PRIMARY KEY ([ID])
);
GO

CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Envío] (
  [Nro_Envío] INT IDENTITY(1,1),
  [Ticket] INT,
  [Fecha_Programada] DATETIME,
  [Horario_Inicio] INT,
  [Horario_fin] INT,
  [Cliente] INT,
  [Costo] DECIMAL(10, 2),
  [Fecha_Entrega] DATETIME,
  [Tipo_Estado] VARCHAR(255),
  PRIMARY KEY ([Nro_Envío])
);
GO


CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Promocion_Producto] (
  [Promocion] INT, --> FK
  [Producto] INT, --> Fk
  [ID] INT IDENTITY(1,1), --> pk
  [FechaInicio] DATE,
  [FechaFinalizacion] DATE,
  PRIMARY KEY ([ID])
);
GO

CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Promocion] ( 
  [ID] INT,
  [Descripcion] VARCHAR(255),
  PRIMARY KEY ([ID])
);
GO


CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Sucursal] (
  [ID] INT IDENTITY(1,1),
  [Nombre] VARCHAR(255),
  [Direccion] VARCHAR(255),
  [Localidad_Provincia] INT, --> FK
  PRIMARY KEY ([ID])
);
GO
CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Empleado] (
  [Legajo] INT IDENTITY(1,1),
  [Nombre] VARCHAR(255),
  [Apellido] VARCHAR(255),
  [Mail] VARCHAR(255),
  [Fecha_Registro] DATETIME,
  [Fecha_Nacimiento] DATE,
  [Telefono] VARCHAR(255),
  [DNI] INT,
  [Sucursal] INT,
  PRIMARY KEY ([Legajo])
);
GO


CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Ticket] (
  [ID] INT IDENTITY(1,1),	
  [Sucursal] INT,
  [Nro_Ticket] INT, 
  [Fecha_Hora] DATETIME,
  [Caja] INT,
  [Empleado] INT,
  [Tipo_Comprobante] INT,
  [Cliente] INT,
  [Sub_total_ticket] DECIMAL(10, 2),
  [Total_promociones] DECIMAL(10, 2),
  [Total_descuento_medio] DECIMAL(10, 2),
  [Importe_total] DECIMAL(10, 2),
  PRIMARY KEY ([ID])
);
GO

CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[SubCategoria] (
  [Cod_subcategoria] INT IDENTITY(1,1),
  [Cod_categoria_padre] INT,
  [Nombre] VARCHAR(255),
  PRIMARY KEY ([Cod_subcategoria])
);
GO

CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Producto] (
  [Cod_prod] INT IDENTITY(1,1), 
  [Nombre] VARCHAR(255),
  [Descripcion] VARCHAR(255),
  [SubCategoria] INT,
  [Precio_unit] DECIMAL(10, 2),
  [Marca] INT, --> FK
  PRIMARY KEY ([Cod_prod])
);
GO



GO
CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Marca_Producto] (
  [ID] INT IDENTITY(1,1), 
  [Nombre] VARCHAR(255),
  PRIMARY KEY ([ID])
);
GO

CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Detalle_Ticket] (
  [ID] INT IDENTITY(1,1),	
  [ID_TICKET] INT,
  [ID_PRODUCTO] INT, --> FK,PK
  [Cantidad] INT,
  [Precio_unit] DECIMAL(10, 2),
  [Total] DECIMAL(10, 2),
  PRIMARY KEY ([ID])
);
GO

CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Categoria] (
  [Cod_categoria] INT IDENTITY(1,1),
  [Nombre] VARCHAR(255),
  PRIMARY KEY ([Cod_categoria])
);
GO



CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Tipo_Caja] (
  [ID] INT IDENTITY(1,1),
  [Nombre] VARCHAR(255),
  PRIMARY KEY ([ID])
);
GO


CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Caja] (
  [Sucursal] INT, 
  [Tipo_caja] INT, 
  [Numero] INT, 
  PRIMARY KEY ([Sucursal], [Tipo_caja], [Numero])
);
GO


CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Regla] (
  [ID] INT IDENTITY(1,1),
  [Cantidad] INT,
  [Porcentaje] DECIMAL(5, 2),
  [CantidadUso] INT,
  [MismaMarca] BIT,
  [MismoProducto] BIT,
  [Descripcion] TEXT,
  [Promocion] INT,
  PRIMARY KEY ([ID])
);
GO

CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Tarjeta] (
  [ID] INT IDENTITY(1,1),
  [Cliente] INT, --> fk
  [Nro_Tarjeta]  VARCHAR(255),
  [Fecha_vencimiento] DATETIME,
  PRIMARY KEY ([ID])
);
GO

CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Medio_Pago] (
  [ID] INT IDENTITY(1,1),
  [Nombre] VARCHAR(255),
  PRIMARY KEY ([ID])
);
GO

CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Pago] (
  [Nro_pago] INT IDENTITY(1,1),
  [Fecha_pago] DATE,
  [Medio_pago] INT,
  [TicketID] INT,
  [Importe] DECIMAL(10, 2),
  [Monto_descontado] DECIMAL(10, 2),
  PRIMARY KEY ([Nro_pago])
);
GO

CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Supermercado] (
  [ID] INT IDENTITY(1,1),
  [Nombre] VARCHAR(255),
  [Razon_Social] VARCHAR(255),
  [Domicilio] VARCHAR(255),
  [Localidad_Provincia] INT, --> FK
  [Fecha_Inicio] DATE,
  [Condicion_Fiscal] VARCHAR(255),
  [IIBB] VARCHAR(255),
  [CUIT] VARCHAR(255),
  PRIMARY KEY ([ID])
);
GO



CREATE TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Promocion_Aplicada] (
  [ID] INT IDENTITY(1,1),
  [ID_Ticket] INT, --> FK
  [ID_Promo] INT, -->FK
  [Descuento] INT
  PRIMARY KEY ([ID])
);
GO

----------------------- FK ------------------
ALTER TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Detalle_Ticket] --> Entidad
ADD CONSTRAINT [FK_Detalle_Producto_Producto]
FOREIGN KEY ([ID_PRODUCTO])
REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.[Producto]([Cod_prod]);

ALTER TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Detalle_Ticket] --> Entidad
ADD CONSTRAINT [FK_Detalle_Ticket]
FOREIGN KEY ([ID_TICKET])
REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.[Ticket]([ID]);



ALTER TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Producto] --> Entidad
ADD CONSTRAINT [FK_Producto_Marca]
FOREIGN KEY ([Marca])
REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.[Marca_Producto]([ID]);

ALTER TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Producto] --> Entidad
ADD CONSTRAINT [FK_Producto_SubCategoria]
FOREIGN KEY ([SubCategoria])
REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.[SubCategoria]([Cod_subcategoria]);



ALTER TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[SubCategoria] --> Entidad
ADD CONSTRAINT [FK_SubCategoria_Categoria]
FOREIGN KEY ([Cod_categoria_padre])
REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.[Categoria]([Cod_categoria]);



ALTER TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Promocion_Producto] --> Entidad
ADD CONSTRAINT [FK_Promocion_Producto_Producto]
FOREIGN KEY ([Producto])
REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.[Producto]([Cod_prod]);

ALTER TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Promocion_Producto] --> Entidad
ADD CONSTRAINT [FK_Promocion_Producto_Promocion]
FOREIGN KEY ([Promocion])
REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.[Promocion]([ID]);




ALTER TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Caja] --> Entidad
ADD CONSTRAINT [FK_Caja_Tipo_caja]
FOREIGN KEY ([Tipo_caja])
REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.[Tipo_Caja]([ID]);

ALTER TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Caja] --> Entidad
ADD CONSTRAINT [FK_Caja_Sucursal]
FOREIGN KEY ([Sucursal])
REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.[Sucursal]([ID]);



ALTER TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Regla] --> Entidad
ADD CONSTRAINT [FK_Regla_Promocion]
FOREIGN KEY ([Promocion])
REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.[Promocion]([ID]);



ALTER TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Tarjeta] --> Entidad
ADD CONSTRAINT [FK_Tarjeta_Cliente]
FOREIGN KEY ([Cliente])
REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.[Cliente]([ID]);



ALTER TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Pago] --> Entidad
ADD CONSTRAINT [FK_Pago_Medio_pago]
FOREIGN KEY ([Medio_pago])
REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.[Medio_Pago]([ID]);

ALTER TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Pago] --> Entidad
ADD CONSTRAINT [FK_Pago_Ticket]
FOREIGN KEY ([TicketID])
REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.[Ticket]([ID]);



ALTER TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Localidad_Provincia] --> Entidad
ADD CONSTRAINT [FK_Localidad_Provincia_Provincia]
FOREIGN KEY ([ProvinciaID])
REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.[Provincia]([ID])

ALTER TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Localidad_Provincia] --> Entidad
ADD CONSTRAINT [FK_Localidad_Provincia_Localidad]
FOREIGN KEY ([LocalidadID])
REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.[Localidad]([ID])


ALTER TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Cliente] --> Entidad
ADD CONSTRAINT [FK_Cliente_Localidad_Provincia]
FOREIGN KEY ([Localidad_Provincia])
REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.[Localidad_Provincia]([ID])



ALTER TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Supermercado] --> Entidad
ADD CONSTRAINT [FK_Supermercado_Localidad_Provincia]
FOREIGN KEY ([Localidad_Provincia])
REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.[Localidad_Provincia]([ID])

ALTER TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Sucursal] --> Entidad
ADD CONSTRAINT [FK_Sucursal_Localidad_Provincia]
FOREIGN KEY ([Localidad_Provincia])
REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.[Localidad_Provincia]([ID])



ALTER TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Promocion_Aplicada] --> Entidad
ADD CONSTRAINT [FK_Promocion_Ticket]
FOREIGN KEY ([ID_Promo])
REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.[Promocion_Producto]([ID]);

ALTER TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Promocion_Aplicada] --> Entidad
ADD CONSTRAINT [FK_Promocion_Ticket_Ticket]
FOREIGN KEY ([ID_Ticket])
REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.[Detalle_Ticket]([ID]);




ALTER TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Descuento_aplicado] --> Entidad
ADD CONSTRAINT [FK_Descuento_aplicado_Pago]
FOREIGN KEY ([Pago])
REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.[Pago]([Nro_pago]);

ALTER TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Descuento_aplicado] --> Entidad
ADD CONSTRAINT [FK_Descuento_aplicado_Descuento]
FOREIGN KEY ([Descuento])
REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.[Descuento_Medio_Pago]([ID]);

ALTER TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Detalle_Pago] --> Entidad
ADD CONSTRAINT [FK_Detalle_Pago_Tarjeta]
FOREIGN KEY ([Tarjeta])
REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.[Tarjeta]([ID]);

ALTER TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Detalle_Pago] --> Entidad
ADD CONSTRAINT [FK_Detalle_Pago_Cliente]
FOREIGN KEY ([Cliente])
REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.[Cliente]([ID]);

ALTER TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Envío] --> Entidad
ADD CONSTRAINT [FK_Envío_Cliente]
FOREIGN KEY ([Cliente])
REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.[Cliente]([ID]);




ALTER TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Ticket]
ADD CONSTRAINT [FK_Ticket_Empleado]
FOREIGN KEY ([Empleado])
REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.[Empleado]([Legajo]);

ALTER TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Ticket]
ADD CONSTRAINT [FK_Ticket_Sucursal]
FOREIGN KEY ([Sucursal])
REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.[Sucursal]([ID]);

ALTER TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Ticket]
ADD CONSTRAINT [FK_Ticket_Tipo_Comprobante]
FOREIGN KEY ([Tipo_Comprobante])
REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.[Tipo_Comprobante]([ID]);

ALTER TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Ticket]
ADD CONSTRAINT [FK_Ticket_Cliente]
FOREIGN KEY ([Cliente])
REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.[Cliente]([ID]);



ALTER TABLE LA_TERCERA_ES_LA_VENCIDA_GDD.[Empleado]
ADD CONSTRAINT [FK_Empleado_Sucursal]
FOREIGN KEY ([Sucursal])
REFERENCES LA_TERCERA_ES_LA_VENCIDA_GDD.[Sucursal]([ID]);
GO
----------------- MIGRAR LAS BASES DE DATOS ----------------------

CREATE PROCEDURE LA_TERCERA_ES_LA_VENCIDA_GDD.migrarProvincia
AS
BEGIN
	INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.Provincia(Nombre) 
	SELECT DISTINCT CLIENTE_PROVINCIA FROM gd_esquema.Maestra
	WHERE  CLIENTE_PROVINCIA IS NOT NULL
END;
GO

CREATE PROCEDURE LA_TERCERA_ES_LA_VENCIDA_GDD.migrarLocalidad
AS
BEGIN
	INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.Localidad(Nombre) 
	SELECT DISTINCT CLIENTE_LOCALIDAD FROM gd_esquema.Maestra
	WHERE CLIENTE_LOCALIDAD IS NOT NULL 
END;
GO

CREATE PROCEDURE LA_TERCERA_ES_LA_VENCIDA_GDD.Localidad_x_Provincia
AS
BEGIN
	INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.Localidad_Provincia (LocalidadID, ProvinciaID)
	SELECT DISTINCT b.ID AS LocalidadID, c.ID AS ProvinciaID
	FROM gd_esquema.Maestra AS a
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Localidad AS b ON b.Nombre = a.CLIENTE_LOCALIDAD
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Provincia AS c ON c.Nombre = a.CLIENTE_PROVINCIA;
END;
GO

CREATE PROCEDURE LA_TERCERA_ES_LA_VENCIDA_GDD.migrarCliente
AS
BEGIN
    INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.Cliente(Nombre,Apellido,DNI,Direccion,Localidad_Provincia,Telefono,Mail,Fecha_Nacimiento,Fecha_Registro)
    SELECT DISTINCT CLIENTE_NOMBRE, CLIENTE_APELLIDO, CLIENTE_DNI, CLIENTE_DOMICILIO, D.ID,CLIENTE_TELEFONO, CLIENTE_MAIL, CLIENTE_FECHA_NACIMIENTO, CLIENTE_FECHA_REGISTRO  FROM gd_esquema.Maestra	AS A
	JOIN Localidad as B ON (A.CLIENTE_LOCALIDAD = B.Nombre)
	JOIN Provincia as C ON (A.CLIENTE_PROVINCIA = C.Nombre)
	JOIN Localidad_Provincia as D ON(D.LocalidadID = B.ID AND D.ProvinciaID = C.ID )  
END;
GO

CREATE PROCEDURE LA_TERCERA_ES_LA_VENCIDA_GDD.migrarSupermercado
AS
BEGIN
	INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.Supermercado(Nombre, Razon_Social, Domicilio,Localidad_Provincia,Fecha_Inicio,Condicion_Fiscal,CUIT,IIBB) 
	SELECT DISTINCT SUPER_NOMBRE, SUPER_RAZON_SOC, SUPER_DOMICILIO,D.ID,SUPER_FECHA_INI_ACTIVIDAD, SUPER_CONDICION_FISCAL, SUPER_CUIT,SUPER_IIBB FROM gd_esquema.Maestra AS a
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Localidad as B ON (A.SUPER_LOCALIDAD = B.Nombre)
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Provincia as C ON (A.SUPER_PROVINCIA = C.Nombre)
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Localidad_Provincia as D ON(D.LocalidadID = B.ID AND D.ProvinciaID = C.ID )   
END;
GO

CREATE PROCEDURE LA_TERCERA_ES_LA_VENCIDA_GDD.migrarSucursal
AS
BEGIN
	INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.Sucursal(Nombre, Direccion, Localidad_Provincia) 
	SELECT DISTINCT SUCURSAL_NOMBRE,SUCURSAL_DIRECCION , D.ID FROM gd_esquema.Maestra as a 
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Localidad as B ON (A.SUPER_LOCALIDAD = B.Nombre)
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Provincia as C ON (A.SUPER_PROVINCIA = C.Nombre)
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Localidad_Provincia as D ON(D.LocalidadID = B.ID AND D.ProvinciaID = C.ID )  
END;
GO

CREATE PROCEDURE LA_TERCERA_ES_LA_VENCIDA_GDD.migrarTipoCaja
AS
BEGIN
	INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.Tipo_Caja(Nombre) 
	SELECT DISTINCT CAJA_TIPO FROM gd_esquema.Maestra 
	WHERE CAJA_TIPO IS NOT NULL
END;
GO


CREATE PROCEDURE LA_TERCERA_ES_LA_VENCIDA_GDD.migrarCaja
AS
BEGIN
	INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.Caja(Numero,Tipo_caja,Sucursal) 
	SELECT DISTINCT CAJA_NUMERO,b.ID , c.ID FROM gd_esquema.Maestra as a
	JOIN Tipo_Caja as b ON ( b.Nombre = a.CAJA_TIPO) 
	JOIN Sucursal as c ON ( c.Nombre = a.SUCURSAL_NOMBRE)
END;
GO

CREATE PROCEDURE LA_TERCERA_ES_LA_VENCIDA_GDD.migrarTarjeta
AS
	BEGIN
		INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.Tarjeta(Nro_Tarjeta,Fecha_vencimiento,Cliente) 
		SELECT DISTINCT Maestra.PAGO_TARJETA_NRO, Maestra.PAGO_TARJETA_FECHA_VENC, Cliente.ID AS CLIENTE_DNI
		FROM gd_esquema.Maestra AS Maestra
		LEFT JOIN gd_esquema.Maestra AS Maestra2 ON Maestra2.SUCURSAL_NOMBRE = Maestra.SUCURSAL_NOMBRE AND Maestra2.TICKET_NUMERO = Maestra.TICKET_NUMERO AND Maestra2.CLIENTE_DNI IS NOT NULL
		LEFT JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Cliente as Cliente ON Cliente.DNI = Maestra2.CLIENTE_DNI
		WHERE Maestra.PAGO_TARJETA_NRO IS NOT NULL
	
END;
GO

CREATE PROCEDURE LA_TERCERA_ES_LA_VENCIDA_GDD.migrarEmpleado
AS
BEGIN
	INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.Empleado(Nombre,Apellido,Fecha_Nacimiento,Fecha_Registro,Telefono, Mail,DNI,Sucursal) 
	SELECT DISTINCT EMPLEADO_NOMBRE,EMPLEADO_APELLIDO,EMPLEADO_FECHA_NACIMIENTO,EMPLEADO_FECHA_REGISTRO,EMPLEADO_TELEFONO,EMPLEADO_MAIL,EMPLEADO_DNI,b.ID FROM gd_esquema.Maestra as a
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Sucursal as b ON (b.Nombre = a.SUCURSAL_NOMBRE)
	WHERE EMPLEADO_NOMBRE IS NOT NULL
		AND EMPLEADO_APELLIDO IS NOT NULL
		AND EMPLEADO_DNI IS NOT NULL;
END;
GO

CREATE PROCEDURE LA_TERCERA_ES_LA_VENCIDA_GDD.migrarTipoComprobante
AS
BEGIN
	INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.Tipo_Comprobante(Nombre) 
	SELECT DISTINCT TICKET_TIPO_COMPROBANTE FROM gd_esquema.Maestra
	WHERE  TICKET_TIPO_COMPROBANTE IS NOT NULL
END;
GO

CREATE PROCEDURE LA_TERCERA_ES_LA_VENCIDA_GDD.migrarMedioPago
AS
BEGIN
	INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.Medio_Pago(Nombre) 
	SELECT DISTINCT PAGO_MEDIO_PAGO FROM gd_esquema.Maestra
	WHERE  PAGO_MEDIO_PAGO IS NOT NULL
END;
GO
	
CREATE PROCEDURE LA_TERCERA_ES_LA_VENCIDA_GDD.migrarDescuentoMedioPago
AS
BEGIN
    INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.Descuento_Medio_Pago(Cod_Descuento, Descripcion, Medio_Pago, Fecha_Inicio, Fecha_Final, Descuento, Tope_De_Descuento) 
    SELECT DISTINCT DESCUENTO_CODIGO, DESCUENTO_DESCRIPCION, b.ID, DESCUENTO_FECHA_INICIO, DESCUENTO_FECHA_FIN, DESCUENTO_PORCENTAJE_DESC, DESCUENTO_TOPE FROM gd_esquema.Maestra as a
    JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Medio_Pago as b ON (ISNULL(b.Nombre, '') = ISNULL(a.PAGO_MEDIO_PAGO, ''))

END;
GO

CREATE PROCEDURE LA_TERCERA_ES_LA_VENCIDA_GDD.migrarPromocion
AS
BEGIN
    INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.Promocion(ID, Descripcion) 
    SELECT DISTINCT A.PROMO_CODIGO, A.PROMOCION_DESCRIPCION
    FROM gd_esquema.Maestra AS a
	WHERE A.PROMOCION_DESCRIPCION IS NOT NULL
	
	
END;
GO

CREATE PROCEDURE LA_TERCERA_ES_LA_VENCIDA_GDD.migrarRegla
AS
BEGIN
    INSERT INTO  LA_TERCERA_ES_LA_VENCIDA_GDD.Regla(Cantidad, Porcentaje, CantidadUso, MismaMarca, MismoProducto, Descripcion, Promocion) 
    SELECT DISTINCT REGLA_CANT_APLICABLE_REGLA, REGLA_CANT_APLICA_DESCUENTO, REGLA_CANT_MAX_PROD, REGLA_APLICA_MISMO_PROD, REGLA_APLICA_MISMO_PROD, REGLA_DESCRIPCION, B.ID
    FROM gd_esquema.Maestra as a
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Promocion as b ON(b.ID = a.PROMO_CODIGO)
	
END;
GO

CREATE PROCEDURE LA_TERCERA_ES_LA_VENCIDA_GDD.migrarTicket
AS
BEGIN
	INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.Ticket(Sucursal, Nro_Ticket, Fecha_Hora, Caja, Empleado, Tipo_Comprobante, Cliente, Sub_total_ticket, Total_promociones, Total_descuento_medio, Importe_total) 
	SELECT DISTINCT 
		Sucursal.ID, 
		c.TICKET_NUMERO, 
		c.TICKET_FECHA_HORA, 
		Caja.Numero AS CAJA,
		Empleado.Legajo AS EMPLEADO, 
		Tipo_comprobante.ID AS ID_TIPO_COMPROBANTE, 
		Cliente.ID AS ID_CLIENTE,
		c.TICKET_SUBTOTAL_PRODUCTOS, 
		c.TICKET_TOTAL_DESCUENTO_APLICADO, 
		c.TICKET_TOTAL_DESCUENTO_APLICADO_MP, 
		c.TICKET_TOTAL_TICKET 
	FROM ( 
		
		 SELECT DISTINCT
				Maestra.SUCURSAL_NOMBRE,
				Maestra.TICKET_NUMERO,
				Maestra.TICKET_FECHA_HORA,
				Maestra2.CLIENTE_DNI,
				Maestra.EMPLEADO_DNI, 
				Maestra.CAJA_NUMERO, 
				Maestra.TICKET_SUBTOTAL_PRODUCTOS,
				Maestra.TICKET_TOTAL_DESCUENTO_APLICADO,
				Maestra.TICKET_TOTAL_DESCUENTO_APLICADO_MP,
				Maestra.TICKET_TOTAL_TICKET,
				Maestra.TICKET_TIPO_COMPROBANTE
				FROM 
					gd_esquema.Maestra AS Maestra 
				LEFT JOIN gd_esquema.Maestra AS Maestra2 ON ( Maestra.SUCURSAL_NOMBRE = Maestra2.SUCURSAL_NOMBRE AND Maestra.TICKET_NUMERO = Maestra2.TICKET_NUMERO AND Maestra2.CLIENTE_DNI IS NOT NULL)
				WHERE Maestra.EMPLEADO_DNI IS NOT NULL
		) as c 
		JOIN
		LA_TERCERA_ES_LA_VENCIDA_GDD.Sucursal AS Sucursal ON Sucursal.Nombre = c.SUCURSAL_NOMBRE 
	    JOIN
		LA_TERCERA_ES_LA_VENCIDA_GDD.Caja AS Caja ON c.CAJA_NUMERO = Caja.Numero  
	    JOIN 
		LA_TERCERA_ES_LA_VENCIDA_GDD.Empleado AS Empleado ON c.EMPLEADO_DNI = Empleado.DNI
	    JOIN 
		LA_TERCERA_ES_LA_VENCIDA_GDD.Tipo_Comprobante AS Tipo_comprobante ON  Tipo_comprobante.nombre = c.TICKET_TIPO_COMPROBANTE
	    LEFT JOIN 
		LA_TERCERA_ES_LA_VENCIDA_GDD.Cliente AS Cliente ON   c.CLIENTE_DNI = Cliente.DNI
		
END;
GO

CREATE PROCEDURE LA_TERCERA_ES_LA_VENCIDA_GDD.migrarCategoria
AS
BEGIN
    INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.Categoria(Nombre)
    SELECT DISTINCT PRODUCTO_CATEGORIA
    FROM gd_esquema.Maestra
	WHERE PRODUCTO_CATEGORIA IS NOT NULL
END;
GO

CREATE PROCEDURE LA_TERCERA_ES_LA_VENCIDA_GDD.migrarSubCategoria
AS
BEGIN
    INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.SubCategoria(Nombre,Cod_categoria_padre)
    SELECT DISTINCT Maestra.PRODUCTO_SUB_CATEGORIA, Categoria.Cod_categoria
    FROM gd_esquema.Maestra AS Maestra
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Categoria AS Categoria ON (Maestra.PRODUCTO_CATEGORIA = Categoria.Nombre)
	
END;
GO

CREATE PROCEDURE LA_TERCERA_ES_LA_VENCIDA_GDD.MarcaProducto
AS
BEGIN
    INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.Marca_Producto(Nombre)
    SELECT DISTINCT	Maestra.PRODUCTO_MARCA
    FROM gd_esquema.Maestra AS Maestra
	WHERE Maestra.PRODUCTO_MARCA IS NOT NULL
	
END;
GO

CREATE PROCEDURE LA_TERCERA_ES_LA_VENCIDA_GDD.MigrarProducto
AS
BEGIN
    INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.Producto(Nombre,Descripcion,SubCategoria,Precio_unit,Marca)
    SELECT DISTINCT	PRODUCTO_NOMBRE, PRODUCTO_DESCRIPCION, SubCategoria.Cod_subcategoria,PRODUCTO_PRECIO, Marca.ID
    FROM gd_esquema.Maestra 
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.SubCategoria AS SubCategoria ON (Maestra.PRODUCTO_SUB_CATEGORIA = SubCategoria.Nombre)
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Categoria AS Categoria ON (Categoria.Cod_categoria = SubCategoria.Cod_categoria_padre AND Categoria.Nombre = Maestra.PRODUCTO_CATEGORIA)
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Marca_Producto AS Marca ON (Marca.Nombre = Maestra.PRODUCTO_MARCA)
	WHERE PRODUCTO_NOMBRE IS NOT NULL
END;
GO



CREATE PROCEDURE LA_TERCERA_ES_LA_VENCIDA_GDD.MigrarDetalleTicket
AS
BEGIN
    INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.Detalle_Ticket(ID_TICKET,ID_PRODUCTO,Precio_unit,Cantidad,Total)
	   SELECT Distinct Ticket.ID,Producto.Cod_prod,TICKET_DET_PRECIO, TICKET_DET_CANTIDAD, TICKET_DET_TOTAL
		FROM gd_esquema.Maestra as Maestra
		JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Sucursal as Sucursal ON (Sucursal.Nombre = Maestra.SUCURSAL_NOMBRE) 
		JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Ticket as Ticket ON (Sucursal.ID = Ticket.Sucursal AND Maestra.TICKET_NUMERO = Ticket.Nro_Ticket  AND Ticket.Fecha_Hora = Maestra.TICKET_FECHA_HORA)
		JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Producto as Producto ON (Producto.Nombre = Maestra.PRODUCTO_NOMBRE AND Producto.Precio_unit = Maestra.TICKET_DET_PRECIO)
		JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Marca_Producto as Marca ON (Producto.Marca = Marca.ID AND Maestra.PRODUCTO_MARCA = Marca.Nombre)
	
END;
GO



CREATE PROCEDURE LA_TERCERA_ES_LA_VENCIDA_GDD.migrarPromocionProducto
AS
BEGIN
	INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.Promocion_Producto(Promocion,Producto,FechaInicio,FechaFinalizacion)
	SELECT DISTINCT Promocion.ID ,Producto.Cod_prod, PROMOCION_FECHA_INICIO, PROMOCION_FECHA_FIN  FROM gd_esquema.Maestra AS Maestra
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Promocion AS Promocion ON ( Promocion.ID = Maestra.PROMO_CODIGO )
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Producto AS Producto ON ( Producto.Nombre = Maestra.PRODUCTO_NOMBRE AND Producto.Precio_unit = Maestra.PRODUCTO_PRECIO)
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Marca_Producto as Marca ON (Producto.Marca = Marca.ID AND Maestra.PRODUCTO_MARCA = Marca.Nombre)
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.SubCategoria as SubCategoria ON (SubCategoria.Nombre = Maestra.PRODUCTO_SUB_CATEGORIA AND Producto.SubCategoria = SubCategoria.Cod_subcategoria)
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Categoria as Categoria ON (Categoria.Nombre = Maestra.PRODUCTO_CATEGORIA AND Categoria.Cod_categoria = SubCategoria.Cod_categoria_padre)
		

END;
GO




CREATE PROCEDURE LA_TERCERA_ES_LA_VENCIDA_GDD.migrarPromocionAplicada
AS
BEGIN
    INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.Promocion_Aplicada(ID_Ticket, ID_Promo, Descuento)
	SELECT DISTINCT Detalle.ID, PromoProducto.ID, Maestra.PROMO_APLICADA_DESCUENTO  
	FROM gd_esquema.Maestra AS Maestra
		JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Sucursal as Sucursal ON ( Maestra.SUCURSAL_NOMBRE = Sucursal.Nombre)
		JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Ticket as Ticket ON (Ticket.Nro_Ticket = Maestra.TICKET_NUMERO AND Ticket.Sucursal = Sucursal.ID AND Ticket.Fecha_Hora = Maestra.TICKET_FECHA_HORA)
		
		JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Promocion as Promocion ON (Promocion.ID = Maestra.PROMO_CODIGO)

		JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Producto AS Producto ON ( Producto.Nombre = Maestra.PRODUCTO_NOMBRE AND Maestra.PRODUCTO_PRECIO = Producto.Precio_unit)
		JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Marca_Producto as Marca ON (Producto.Marca = Marca.ID AND Maestra.PRODUCTO_MARCA = Marca.Nombre)
		JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.SubCategoria as SubCategoria ON (SubCategoria.Nombre = Maestra.PRODUCTO_SUB_CATEGORIA AND Producto.SubCategoria = SubCategoria.Cod_subcategoria)
		JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Categoria as Categoria ON (Categoria.Nombre = Maestra.PRODUCTO_CATEGORIA AND Categoria.Cod_categoria = SubCategoria.Cod_categoria_padre)
	
		
		JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Detalle_Ticket as Detalle ON (Detalle.ID_TICKET = Ticket.ID AND Detalle.ID_PRODUCTO = Producto.Cod_prod AND Maestra.TICKET_DET_CANTIDAD = Detalle.Cantidad AND Maestra.TICKET_DET_TOTAL = Detalle.Total)
		
		
		JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Promocion_Producto as PromoProducto ON (Promocion.ID = PromoProducto.Promocion AND PromoProducto.Producto = Producto.Cod_prod)


END;
GO



CREATE PROCEDURE LA_TERCERA_ES_LA_VENCIDA_GDD.migrarEnvio
AS
BEGIN
    INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.[Envío] (Ticket, Fecha_Programada, Horario_Inicio, Horario_fin, Cliente, Costo, Fecha_Entrega, Tipo_Estado)
    SELECT DISTINCT Ticket.ID, Maestra.ENVIO_FECHA_PROGRAMADA, Maestra.ENVIO_HORA_INICIO, Maestra.ENVIO_HORA_FIN, Ticket.Cliente , Maestra.ENVIO_COSTO, Maestra.ENVIO_FECHA_ENTREGA,Maestra.ENVIO_ESTADO
    FROM gd_esquema.Maestra AS Maestra
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Sucursal AS Sucursal ON Maestra.SUCURSAL_NOMBRE = Sucursal.Nombre
    JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Ticket AS Ticket ON  Ticket.Nro_Ticket = Maestra.TICKET_NUMERO  AND Sucursal.ID = Ticket.Sucursal
	WHERE  ENVIO_FECHA_ENTREGA IS NOT NULL
	ORDER BY Ticket.ID
END;
GO 



CREATE PROCEDURE LA_TERCERA_ES_LA_VENCIDA_GDD.migrarPago
AS
BEGIN
    INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.Pago(Fecha_pago, Medio_Pago, TicketID, Importe, Monto_descontado)
    SELECT DISTINCT PAGO_FECHA, a.ID AS Medio_Pago, b.ID AS Ticket, PAGO_IMPORTE, PAGO_DESCUENTO_APLICADO FROM gd_esquema.Maestra 
    JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Medio_Pago AS a ON a.Nombre = PAGO_MEDIO_PAGO
	JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Sucursal AS c ON c.Nombre = Maestra.SUCURSAL_NOMBRE
    JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Ticket AS b ON (b.Nro_Ticket = TICKET_NUMERO) AND (b.Fecha_Hora = TICKET_FECHA_HORA) AND ( c.ID = b.Sucursal )
END;
GO

CREATE PROCEDURE LA_TERCERA_ES_LA_VENCIDA_GDD.migrarDetallePago
AS
BEGIN
    INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.Detalle_Pago(Tarjeta, Pago, Cuotas)
    SELECT DISTINCT Tarjeta.ID AS Tarjeta, Pago.Nro_Pago AS Pago, PAGO_TARJETA_CUOTAS
     FROM gd_esquema.Maestra AS Maestra 
    JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Tarjeta AS Tarjeta ON Tarjeta.Nro_Tarjeta = Maestra.PAGO_TARJETA_NRO
    JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Sucursal AS Sucursal ON Sucursal.Nombre = Maestra.SUCURSAL_NOMBRE
    JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Ticket AS Ticket ON Ticket.Nro_Ticket = Maestra.TICKET_NUMERO AND Ticket.Sucursal = Sucursal.ID AND Ticket.Fecha_Hora = Maestra.TICKET_FECHA_HORA
    JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Pago AS Pago ON (Pago.TicketID = Ticket.ID)
END; 
GO

CREATE PROCEDURE LA_TERCERA_ES_LA_VENCIDA_GDD.migrarDescuentoAplicado
AS
BEGIN
    INSERT INTO LA_TERCERA_ES_LA_VENCIDA_GDD.Descuento_aplicado(Descuento, Pago) 
    SELECT DISTINCT Codigo.ID AS Descuento, Pago.Nro_pago AS Pago FROM gd_esquema.Maestra as Maestra
    JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Sucursal AS Sucursal ON Sucursal.Nombre = Maestra.SUCURSAL_NOMBRE
    JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Ticket AS Ticket ON Ticket.Nro_Ticket = Maestra.TICKET_NUMERO AND Ticket.Sucursal = Sucursal.ID AND Ticket.Fecha_Hora = Maestra.TICKET_FECHA_HORA
    JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Pago AS Pago ON (Pago.TicketID = Ticket.ID)
    JOIN LA_TERCERA_ES_LA_VENCIDA_GDD.Descuento_Medio_Pago AS Codigo ON (Codigo.Cod_Descuento = Maestra.DESCUENTO_CODIGO)
END;
GO

CREATE PROCEDURE LA_TERCERA_ES_LA_VENCIDA_GDD.migrarBaseDeDatos
AS
BEGIN
	EXEC LA_TERCERA_ES_LA_VENCIDA_GDD.migrarProvincia
	EXEC LA_TERCERA_ES_LA_VENCIDA_GDD.migrarLocalidad
	EXEC LA_TERCERA_ES_LA_VENCIDA_GDD.Localidad_x_Provincia
	EXEC LA_TERCERA_ES_LA_VENCIDA_GDD.migrarCliente
	EXEC LA_TERCERA_ES_LA_VENCIDA_GDD.migrarSupermercado
	EXEC LA_TERCERA_ES_LA_VENCIDA_GDD.migrarSucursal
	EXEC LA_TERCERA_ES_LA_VENCIDA_GDD.migrarTipoCaja
	EXEC LA_TERCERA_ES_LA_VENCIDA_GDD.migrarCaja
	EXEC LA_TERCERA_ES_LA_VENCIDA_GDD.migrarTarjeta
	EXEC LA_TERCERA_ES_LA_VENCIDA_GDD.migrarEmpleado
	EXEC LA_TERCERA_ES_LA_VENCIDA_GDD.migrarTipoComprobante
	EXEC LA_TERCERA_ES_LA_VENCIDA_GDD.migrarMedioPago
	EXEC LA_TERCERA_ES_LA_VENCIDA_GDD.migrarDescuentoMedioPago
	EXEC LA_TERCERA_ES_LA_VENCIDA_GDD.migrarPromocion
	EXEC LA_TERCERA_ES_LA_VENCIDA_GDD.migrarRegla
	EXEC LA_TERCERA_ES_LA_VENCIDA_GDD.migrarTicket
	EXEC LA_TERCERA_ES_LA_VENCIDA_GDD.migrarCategoria
	EXEC LA_TERCERA_ES_LA_VENCIDA_GDD.migrarSubCategoria
	EXEC LA_TERCERA_ES_LA_VENCIDA_GDD.MarcaProducto
	EXEC LA_TERCERA_ES_LA_VENCIDA_GDD.migrarProducto
	EXEC LA_TERCERA_ES_LA_VENCIDA_GDD.migrarDetalleTicket
	EXEC LA_TERCERA_ES_LA_VENCIDA_GDD.migrarPromocionProducto
	EXEC LA_TERCERA_ES_LA_VENCIDA_GDD.migrarPromocionAplicada
	EXEC LA_TERCERA_ES_LA_VENCIDA_GDD.migrarEnvio
	EXEC LA_TERCERA_ES_LA_VENCIDA_GDD.migrarPago
	EXEC LA_TERCERA_ES_LA_VENCIDA_GDD.migrarDetallePago
	EXEC LA_TERCERA_ES_LA_VENCIDA_GDD.migrarDescuentoAplicado

END
GO

EXEC LA_TERCERA_ES_LA_VENCIDA_GDD.migrarBaseDeDatos 


-- CHEQUEOS promo aplicada
--SELECT distinct TICKET_NUMERO, SUCURSAL_NOMBRE, TICKET_FECHA_HORA, PROMO_CODIGO,PROMO_APLICADA_DESCUENTO, TICKET_DET_PRECIO, TICKET_DET_TOTAL, TICKET_DET_CANTIDAD, PROMOCION_FECHA_FIN,PROMOCION_FECHA_INICIO from gd_esquema.Maestra
--where PROMO_APLICADA_DESCUENTO IS NOT NULL

-- Chequeo de promocion producto
--select distinct PROMO_CODIGO,PROMOCION_FECHA_INICIO,PROMOCION_FECHA_FIN,PRODUCTO_NOMBRE,PRODUCTO_MARCA,PRODUCTO_CATEGORIA,PRODUCTO_SUB_CATEGORIA,PRODUCTO_PRECIO from gd_esquema.Maestra
--WHERE PRODUCTO_NOMBRE is not null and PROMO_CODIGO is not null
