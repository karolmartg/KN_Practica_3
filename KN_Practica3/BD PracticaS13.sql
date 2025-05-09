USE [PracticaS12]
GO
/****** Object:  Table [dbo].[Abonos]    Script Date: 11/4/2025 20:05:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Abonos](
	[Id_Compra] [bigint] NOT NULL,
	[Id_Abono] [bigint] IDENTITY(1,1) NOT NULL,
	[Monto] [decimal](18, 2) NOT NULL,
	[Fecha] [datetime] NOT NULL,
 CONSTRAINT [PK_Abonos] PRIMARY KEY CLUSTERED 
(
	[Id_Abono] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Principal]    Script Date: 11/4/2025 20:05:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Principal](
	[Id_Compra] [bigint] IDENTITY(1,1) NOT NULL,
	[Precio] [decimal](18, 5) NOT NULL,
	[Saldo] [decimal](18, 5) NOT NULL,
	[Descripcion] [varchar](500) NOT NULL,
	[Estado] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Principal] PRIMARY KEY CLUSTERED 
(
	[Id_Compra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Principal] ON 

INSERT [dbo].[Principal] ([Id_Compra], [Precio], [Saldo], [Descripcion], [Estado]) VALUES (1, CAST(50000.00000 AS Decimal(18, 5)), CAST(50000.00000 AS Decimal(18, 5)), N'Producto 1', N'Pendiente')
INSERT [dbo].[Principal] ([Id_Compra], [Precio], [Saldo], [Descripcion], [Estado]) VALUES (2, CAST(13500.00000 AS Decimal(18, 5)), CAST(13500.00000 AS Decimal(18, 5)), N'Producto 2', N'Pendiente')
INSERT [dbo].[Principal] ([Id_Compra], [Precio], [Saldo], [Descripcion], [Estado]) VALUES (3, CAST(83600.00000 AS Decimal(18, 5)), CAST(83600.00000 AS Decimal(18, 5)), N'Producto 3', N'Pendiente')
INSERT [dbo].[Principal] ([Id_Compra], [Precio], [Saldo], [Descripcion], [Estado]) VALUES (4, CAST(1220.00000 AS Decimal(18, 5)), CAST(1220.00000 AS Decimal(18, 5)), N'Producto 4', N'Pendiente')
INSERT [dbo].[Principal] ([Id_Compra], [Precio], [Saldo], [Descripcion], [Estado]) VALUES (5, CAST(480.00000 AS Decimal(18, 5)), CAST(480.00000 AS Decimal(18, 5)), N'Producto 5', N'Pendiente')
SET IDENTITY_INSERT [dbo].[Principal] OFF
GO
ALTER TABLE [dbo].[Abonos]  WITH CHECK ADD  CONSTRAINT [FK_Abonos_Principal] FOREIGN KEY([Id_Compra])
REFERENCES [dbo].[Principal] ([Id_Compra])
GO
ALTER TABLE [dbo].[Abonos] CHECK CONSTRAINT [FK_Abonos_Principal]
GO
/****** Object:  StoredProcedure [dbo].[SP_Abonar_Saldo]    Script Date: 11/4/2025 20:05:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Abonar_Saldo]
	@Id_Compra BIGINT,
	@abono DECIMAL(18, 5)
AS
BEGIN
	DECLARE @SaldoAnterior DECIMAL(18,5)
	DECLARE @SaldoNuevo DECIMAL(18,5)

	-- Llamamos al SP para obtener el saldo anterior
	EXEC SP_Buscar_Producto @Id_Compra, @SaldoAnterior OUTPUT
	
	-- Si el abono es MENOR al saldo anterior
	IF @abono <= @SaldoAnterior
	BEGIN
		SET @SaldoNuevo = @SaldoAnterior - @abono
		
		-- Se actualiza el Saldo del producto
		UPDATE Principal
		SET Saldo = @SaldoNuevo
		WHERE Id_Compra = @Id_Compra

		-- Se registra el abono
		INSERT INTO Abonos (Id_Compra, Monto, Fecha)
		VALUES (@Id_Compra, @SaldoNuevo, GETDATE())

		-- Si el SaldoNuevo queda en 0, se actualiza el ESTADO
		IF @SaldoNuevo = 0
		BEGIN
			UPDATE Principal
			SET Estado = 'Cancelado'
			WHERE Id_Compra = @Id_Compra
		END

	END
	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Buscar_Producto]    Script Date: 11/4/2025 20:05:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Buscar_Producto]
	@Id_Compra bigint
AS
BEGIN
	SELECT Saldo
	FROM Principal
	WHERE Id_Compra = @Id_Compra;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Consultar_Producto]    Script Date: 11/4/2025 20:05:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Consultar_Producto]
  
AS
BEGIN
  SELECT *
  FROM Principal
  ORDER BY CASE WHEN Estado = 'Pendiente' 
  THEN 0 
  ELSE 1 
  END;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Listar_Compras]    Script Date: 11/4/2025 20:05:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Listar_Compras]
AS
BEGIN
	SELECT Id_Compra, 
		   Descripcion 
	FROM Principal;
END
GO
