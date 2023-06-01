USE [master]
GO
/****** Object:  Database [DBSISTEMA_VENTA]    Script Date: 26/05/2023 01:48:14 p. m. ******/
CREATE DATABASE [DBSISTEMA_VENTA]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DBSISTEMA_VENTA', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\DBSISTEMA_VENTA.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DBSISTEMA_VENTA_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\DBSISTEMA_VENTA_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DBSISTEMA_VENTA].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET ARITHABORT OFF 
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET  MULTI_USER 
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET QUERY_STORE = OFF
GO
USE [DBSISTEMA_VENTA]
GO
/****** Object:  UserDefinedTableType [dbo].[EDetalle_Venta]    Script Date: 26/05/2023 01:48:14 p. m. ******/
CREATE TYPE [dbo].[EDetalle_Venta] AS TABLE(
	[IdProducto] [int] NULL,
	[PrecioVenta] [decimal](18, 2) NULL,
	[Cantidad] [int] NULL,
	[Subtotal] [decimal](18, 2) NULL
)
GO
/****** Object:  Table [dbo].[CATEGORIA]    Script Date: 26/05/2023 01:48:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CATEGORIA](
	[IdCategoria] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](100) NULL,
	[Estado] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[COMPRA]    Script Date: 26/05/2023 01:48:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COMPRA](
	[IdCompra] [int] IDENTITY(1,1) NOT NULL,
	[IdUsuario] [int] NULL,
	[IdProveedor] [int] NULL,
	[TipoDocumento] [varchar](50) NULL,
	[NumeroDocumento] [varchar](50) NULL,
	[MontoTotal] [decimal](10, 2) NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCompra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DETALLE_COMPRA]    Script Date: 26/05/2023 01:48:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DETALLE_COMPRA](
	[IdDetalleCompra] [int] IDENTITY(1,1) NOT NULL,
	[IdCompra] [int] NULL,
	[IdProducto] [int] NULL,
	[PrecioCompra] [decimal](10, 2) NULL,
	[PrecioVenta] [decimal](10, 2) NULL,
	[Cantidad] [int] NULL,
	[MontoTotal] [decimal](10, 2) NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdDetalleCompra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DETALLE_VENTA]    Script Date: 26/05/2023 01:48:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DETALLE_VENTA](
	[IdDetalleVenta] [int] IDENTITY(1,1) NOT NULL,
	[IdVenta] [int] NULL,
	[IdProducto] [int] NULL,
	[PrecioVenta] [decimal](10, 2) NULL,
	[Cantidad] [int] NULL,
	[SubTotal] [decimal](10, 2) NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdDetalleVenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PERMISO]    Script Date: 26/05/2023 01:48:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PERMISO](
	[IdPermiso] [int] IDENTITY(1,1) NOT NULL,
	[IdRol] [int] NULL,
	[NombreMenu] [varchar](100) NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdPermiso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PRODUCTO]    Script Date: 26/05/2023 01:48:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTO](
	[IdProducto] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](50) NULL,
	[Nombre] [varchar](50) NULL,
	[Descripcion] [varchar](50) NULL,
	[IdCategoria] [int] NULL,
	[Stock] [int] NOT NULL,
	[PrecioCompra] [decimal](10, 2) NULL,
	[PrecioVenta] [decimal](10, 2) NULL,
	[Estado] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PROVEEDOR]    Script Date: 26/05/2023 01:48:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PROVEEDOR](
	[IdProveedor] [int] IDENTITY(1,1) NOT NULL,
	[Documento] [varchar](50) NULL,
	[RazonSocial] [varchar](50) NULL,
	[Correo] [varchar](50) NULL,
	[Telefono] [varchar](50) NULL,
	[Estado] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdProveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ROL]    Script Date: 26/05/2023 01:48:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ROL](
	[IdRol] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdRol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USUARIO]    Script Date: 26/05/2023 01:48:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USUARIO](
	[IdUsuario] [int] IDENTITY(1,1) NOT NULL,
	[Documento] [varchar](50) NULL,
	[NombreCompleto] [varchar](100) NULL,
	[Correo] [varchar](100) NULL,
	[Clave] [varchar](100) NULL,
	[IdRol] [int] NULL,
	[Estado] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
 CONSTRAINT [PK__USUARIO__5B65BF9750456D16] PRIMARY KEY CLUSTERED 
(
	[IdUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VENTA]    Script Date: 26/05/2023 01:48:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VENTA](
	[IdVenta] [int] IDENTITY(1,1) NOT NULL,
	[IdUsuario] [int] NULL,
	[TipoDocumento] [varchar](50) NULL,
	[NumeroDocumento] [varchar](50) NULL,
	[MontoPago] [decimal](10, 2) NULL,
	[MontoCambio] [decimal](10, 2) NULL,
	[MontoTotal] [decimal](10, 2) NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdVenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[PERMISO] ON 

INSERT [dbo].[PERMISO] ([IdPermiso], [IdRol], [NombreMenu], [FechaRegistro]) VALUES (1, 1, N'menuusuario', CAST(N'2023-04-04T21:19:58.570' AS DateTime))
INSERT [dbo].[PERMISO] ([IdPermiso], [IdRol], [NombreMenu], [FechaRegistro]) VALUES (2, 1, N'menumantenedor', CAST(N'2023-04-04T21:19:58.570' AS DateTime))
INSERT [dbo].[PERMISO] ([IdPermiso], [IdRol], [NombreMenu], [FechaRegistro]) VALUES (3, 1, N'menuventas', CAST(N'2023-04-04T21:19:58.570' AS DateTime))
INSERT [dbo].[PERMISO] ([IdPermiso], [IdRol], [NombreMenu], [FechaRegistro]) VALUES (4, 1, N'menucompras', CAST(N'2023-04-04T21:19:58.570' AS DateTime))
INSERT [dbo].[PERMISO] ([IdPermiso], [IdRol], [NombreMenu], [FechaRegistro]) VALUES (5, 1, N'menuclientes', CAST(N'2023-04-04T21:19:58.570' AS DateTime))
INSERT [dbo].[PERMISO] ([IdPermiso], [IdRol], [NombreMenu], [FechaRegistro]) VALUES (6, 1, N'menuproveedores', CAST(N'2023-04-04T21:19:58.570' AS DateTime))
INSERT [dbo].[PERMISO] ([IdPermiso], [IdRol], [NombreMenu], [FechaRegistro]) VALUES (7, 1, N'menureportes', CAST(N'2023-04-04T21:19:58.570' AS DateTime))
INSERT [dbo].[PERMISO] ([IdPermiso], [IdRol], [NombreMenu], [FechaRegistro]) VALUES (8, 1, N'menuacercade', CAST(N'2023-04-04T21:19:58.570' AS DateTime))
INSERT [dbo].[PERMISO] ([IdPermiso], [IdRol], [NombreMenu], [FechaRegistro]) VALUES (9, 2, N'menuventas', CAST(N'2023-04-04T21:29:28.810' AS DateTime))
INSERT [dbo].[PERMISO] ([IdPermiso], [IdRol], [NombreMenu], [FechaRegistro]) VALUES (10, 2, N'menucompras', CAST(N'2023-04-04T21:29:28.810' AS DateTime))
INSERT [dbo].[PERMISO] ([IdPermiso], [IdRol], [NombreMenu], [FechaRegistro]) VALUES (11, 2, N'menuclientes', CAST(N'2023-04-04T21:29:28.810' AS DateTime))
INSERT [dbo].[PERMISO] ([IdPermiso], [IdRol], [NombreMenu], [FechaRegistro]) VALUES (12, 2, N'menuproveedores', CAST(N'2023-04-04T21:29:28.810' AS DateTime))
INSERT [dbo].[PERMISO] ([IdPermiso], [IdRol], [NombreMenu], [FechaRegistro]) VALUES (13, 2, N'menuacercade', CAST(N'2023-04-04T21:29:28.810' AS DateTime))
SET IDENTITY_INSERT [dbo].[PERMISO] OFF
GO
SET IDENTITY_INSERT [dbo].[ROL] ON 

INSERT [dbo].[ROL] ([IdRol], [Descripcion], [FechaRegistro]) VALUES (1, N'ADMINISTRADOR', CAST(N'2023-04-04T00:31:29.180' AS DateTime))
INSERT [dbo].[ROL] ([IdRol], [Descripcion], [FechaRegistro]) VALUES (2, N'EMPLEADO', CAST(N'2023-04-04T21:27:37.533' AS DateTime))
SET IDENTITY_INSERT [dbo].[ROL] OFF
GO
SET IDENTITY_INSERT [dbo].[USUARIO] ON 

INSERT [dbo].[USUARIO] ([IdUsuario], [Documento], [NombreCompleto], [Correo], [Clave], [IdRol], [Estado], [FechaRegistro]) VALUES (1, N'1899885', N'ADMIN', N'@gmail.com', N'123', 1, 1, CAST(N'2023-04-04T00:32:48.910' AS DateTime))
INSERT [dbo].[USUARIO] ([IdUsuario], [Documento], [NombreCompleto], [Correo], [Clave], [IdRol], [Estado], [FechaRegistro]) VALUES (2, N'123', N'Emp1', N'@hotmail.com', N'123', 2, 1, CAST(N'2023-04-04T22:14:43.833' AS DateTime))
INSERT [dbo].[USUARIO] ([IdUsuario], [Documento], [NombreCompleto], [Correo], [Clave], [IdRol], [Estado], [FechaRegistro]) VALUES (3, N'456', N'pruebas2', N'text@gmail.com', N'456', 2, 1, CAST(N'2023-04-12T15:45:42.547' AS DateTime))
INSERT [dbo].[USUARIO] ([IdUsuario], [Documento], [NombreCompleto], [Correo], [Clave], [IdRol], [Estado], [FechaRegistro]) VALUES (4, N'1898931', N'Ulises', N'ulisesorlando13@gmail.com', N'1712', 2, 1, CAST(N'2023-05-10T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[USUARIO] OFF
GO
ALTER TABLE [dbo].[CATEGORIA] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[COMPRA] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[DETALLE_COMPRA] ADD  DEFAULT ((0)) FOR [PrecioCompra]
GO
ALTER TABLE [dbo].[DETALLE_COMPRA] ADD  DEFAULT ((0)) FOR [PrecioVenta]
GO
ALTER TABLE [dbo].[DETALLE_COMPRA] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[DETALLE_VENTA] ADD  DEFAULT ((0)) FOR [PrecioVenta]
GO
ALTER TABLE [dbo].[DETALLE_VENTA] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[PERMISO] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[PRODUCTO] ADD  DEFAULT ((0)) FOR [Stock]
GO
ALTER TABLE [dbo].[PRODUCTO] ADD  DEFAULT ((0)) FOR [PrecioCompra]
GO
ALTER TABLE [dbo].[PRODUCTO] ADD  DEFAULT ((0)) FOR [PrecioVenta]
GO
ALTER TABLE [dbo].[PRODUCTO] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[PROVEEDOR] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[ROL] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF__USUARIO__FechaRe__440B1D61]  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[VENTA] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[COMPRA]  WITH CHECK ADD FOREIGN KEY([IdProveedor])
REFERENCES [dbo].[PROVEEDOR] ([IdProveedor])
GO
ALTER TABLE [dbo].[COMPRA]  WITH CHECK ADD  CONSTRAINT [FK__COMPRA__IdUsuari__46E78A0C] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[USUARIO] ([IdUsuario])
GO
ALTER TABLE [dbo].[COMPRA] CHECK CONSTRAINT [FK__COMPRA__IdUsuari__46E78A0C]
GO
ALTER TABLE [dbo].[DETALLE_COMPRA]  WITH CHECK ADD FOREIGN KEY([IdCompra])
REFERENCES [dbo].[COMPRA] ([IdCompra])
GO
ALTER TABLE [dbo].[DETALLE_COMPRA]  WITH CHECK ADD FOREIGN KEY([IdProducto])
REFERENCES [dbo].[PRODUCTO] ([IdProducto])
GO
ALTER TABLE [dbo].[DETALLE_VENTA]  WITH CHECK ADD FOREIGN KEY([IdProducto])
REFERENCES [dbo].[PRODUCTO] ([IdProducto])
GO
ALTER TABLE [dbo].[DETALLE_VENTA]  WITH CHECK ADD FOREIGN KEY([IdVenta])
REFERENCES [dbo].[VENTA] ([IdVenta])
GO
ALTER TABLE [dbo].[PERMISO]  WITH CHECK ADD FOREIGN KEY([IdRol])
REFERENCES [dbo].[ROL] ([IdRol])
GO
ALTER TABLE [dbo].[PRODUCTO]  WITH CHECK ADD FOREIGN KEY([IdCategoria])
REFERENCES [dbo].[CATEGORIA] ([IdCategoria])
GO
ALTER TABLE [dbo].[USUARIO]  WITH CHECK ADD  CONSTRAINT [FK__USUARIO__IdRol__4316F928] FOREIGN KEY([IdRol])
REFERENCES [dbo].[ROL] ([IdRol])
GO
ALTER TABLE [dbo].[USUARIO] CHECK CONSTRAINT [FK__USUARIO__IdRol__4316F928]
GO
ALTER TABLE [dbo].[VENTA]  WITH CHECK ADD  CONSTRAINT [FK__VENTA__IdUsuario__5BE2A6F2] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[USUARIO] ([IdUsuario])
GO
ALTER TABLE [dbo].[VENTA] CHECK CONSTRAINT [FK__VENTA__IdUsuario__5BE2A6F2]
GO
/****** Object:  StoredProcedure [dbo].[SP_EDITARUSUARIO]    Script Date: 26/05/2023 01:48:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_EDITARUSUARIO](
@IdUsuario int,
@Documento varchar(50),
@NombreCompleto varchar(100),
@Correo varchar(100),
@Clave varchar(100),
@IdRol int,
@Estado bit,
@Respuesta bit output,
@Mensaje varchar(500)output
)
as 
begin
	set @Respuesta = 0
	set @Mensaje = ''

	if not exists (select * from USUARIO where Documento = @Documento and IdUsuario != @IdUsuario)
	begin
		update USUARIO set
		Documento = @Documento,
		NombreCompleto = @NombreCompleto,
		Correo = @Correo,
		Clave = @Clave,
		IdRol = @IdRol,
		Estado = @Estado
		where IdUsuario = @IdUsuario

		set @Respuesta = 1	
	end
	else
		set @Mensaje = 'No se puede repetir el documento para más de un usuario'
end
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINARUSUARIO]    Script Date: 26/05/2023 01:48:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_ELIMINARUSUARIO](
@IdUsuario int,
@Respuesta bit output,
@Mensaje varchar(500)output
)
as 
begin
	set @Respuesta = 0
	set @Mensaje = ''
	declare  @pasoreglas bit = 1

	--cuando se elimina un usuario relacionado a una compra
	IF EXISTS (SELECT * FROM COMPRA C
	INNER JOIN USUARIO U ON U.IdUsuario = C.IdUsuario
	WHERE U.IdUsuario = @IdUsuario)
	BEGIN
		set @pasoreglas = 0
		set @Respuesta = 0
		set @Mensaje = @Mensaje + 'No se puede eliminar porque el usuario se encuentra relacionado a una COMPRA\n'
	END

	--cuando se elimina un usuario relacionado a una venta
	IF EXISTS (SELECT * FROM VENTA V
	INNER JOIN USUARIO U ON U.IdUsuario = V.IdUsuario
	WHERE U.IdUsuario = @IdUsuario)
	BEGIN
		set @pasoreglas = 0
		set @Respuesta = 0
		set @Mensaje = @Mensaje + 'No se puede eliminar porque el usuario se encuentra relacionado a una VENTA\n'
	END

	--si paso las reglas entonces procede a borrar usuario
	IF (@pasoreglas = 1)
	BEGIN
		delete from USUARIO WHERE IdUsuario = @IdUsuario
		set @Respuesta=1
	END

end
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTRARUSUARIO]    Script Date: 26/05/2023 01:48:14 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_REGISTRARUSUARIO](
@Documento varchar(50),
@NombreCompleto varchar(100),
@Correo varchar(100),
@Clave varchar(100),
@IdRol int,
@Estado bit,
@IdUsuarioResultado int output,
@Mensaje varchar(500)output
)
as 
begin
	set @IdUsuarioResultado = 0
	set @Mensaje = ''

	if not exists (select * from USUARIO where Documento = @Documento)
	begin
		insert into USUARIO(Documento,NombreCompleto,Correo,Clave,IdRol,Estado) values
		(@Documento,@NombreCompleto,@Correo,@Clave,@IdRol,@Estado)
		set @IdUsuarioResultado = SCOPE_IDENTITY()	
	end
	else
		set @Mensaje = 'No se puede repetir el documento para más de un usuario'
end
GO

/* ----- PROCEDIMIENTO PARA CATEGORÍA -----*/

/*PROCEDIMIENTO PARA GUARDAR CATEGORÍA*/
CREATE PROCEDURE SP_RegistrarCategoria(
@Descripcion varchar(50),
@Estado bit,
@Resultado int output,
@Mensaje varchar (500) output
)as
begin 
	SET @Resultado = 0 
	IF NOT EXISTS (SELECT * FROM CATEGORIA WHERE Descripcion = @Descripcion)
	begin 
		insert into CATEGORIA (Descripcion, Estado) VALUES (@Descripcion, @Estado)
		SET @Resultado = SCOPE_IDENTITY()
	END
	ELSE
	SET @Mensaje = 'No se puede repetir la descripción de una categoría'
END

GO
/*PROCEDIMIENTO PARA MODIFICAR CATEGORÍA*/
CREATE PROCEDURE SP_EditarCategoria(
@IdCategoria int,
@Descripcion varchar(50),
@Estado bit,
@Resultado bit output,
@Mensaje varchar (500) output
)as
begin 
	SET @Resultado=1
	IF NOT EXISTS (SELECT * FROM CATEGORIA WHERE Descripcion = @Descripcion and IdCategoria != @IdCategoria)
		UPDATE CATEGORIA SET
		Descripcion = @Descripcion,
		Estado = @Estado
		WHERE IdCategoria = @IdCategoria
	ELSE
	BEGIN
		SET @Resultado=0
		SET @Mensaje = 'No se puede repetir la descripción de una categoría'
	END

END
GO
/*PROCEDIMIENTO PARA ELIMINAR CATEGORÍA*/
CREATE PROCEDURE SP_EliminarCategoria(
@IdCategoria int,
@Resultado bit output,
@Mensaje varchar (500) output
)as
begin 
	SET @Resultado = 1
	IF NOT EXISTS (
		SELECT * FROM CATEGORIA c 
		INNER JOIN PRODUCTO p ON p.IdCategoria = c.IdCategoria
		WHERE c.IdCategoria = @IdCategoria
	)
	BEGIN
		DELETE TOP(1) FROM CATEGORIA WHERE IdCategoria= @IdCategoria
	END
	ELSE
	BEGIN
		SET @Resultado=0
		SET @Mensaje = 'La categoría no se encuentra relacionada a un producto'
	END

END
GO

/*PROCEDIMIENTO PARA EDITAR PRODUCTO*/
CREATE PROC SP_EditarProducto(
@IdProducto int,
@Codigo varchar (20),
@Nombre varchar (30),
@Descripcion varchar (30),
@IdCategoria int,
@Estado bit,
@Resultado int output,
@Mensaje varchar (500) output
)as
begin 
	SET @Resultado=1
	IF NOT EXISTS (SELECT * FROM PRODUCTO WHERE Codigo = @Codigo and IdProducto != @IdProducto)
		UPDATE PRODUCTO SET
		Codigo = @Codigo,
		Nombre = @Codigo,
		Descripcion=@Descripcion,
		IdCategoria=@IdCategoria
		WHERE IdProducto=@IdProducto
	ELSE
	BEGIN
		SET @Resultado=0
		SET @Mensaje = 'Ya existe un producto con el mismo código'
	END
END
GO
/*PROCEDIMIENTO PARA ELIMINAR PRODUCTO*/
CREATE PROC SP_EliminarProducto(
@IdProducto int,
@Respuesta varchar (30),
@Mensaje varchar (500) output
)as
begin 
	SET @Respuesta=0
	SET @Mensaje= ' '
	DECLARE @PasoReglas bit = 1
	IF NOT EXISTS (SELECT * FROM DETALLE_COMPRA dc  
	INNER JOIN PRODUCTO p ON p.IdProducto = dc.IdProducto
	WHERE p.IdProducto = @IdProducto)
	BEGIN
		SET @PasoReglas=0
		SET @Respuesta=0
		SET @Mensaje= @Mensaje + 'No se puede eliminar porque se encuentra relacionado a una COMPRA\n'
	END
	IF NOT EXISTS (SELECT * FROM DETALLE_VENTA dv  
	INNER JOIN PRODUCTO p ON p.IdProducto = dv.IdProducto
	WHERE p.IdProducto = @IdProducto)
	BEGIN
		SET @PasoReglas=0
		SET @Respuesta=0
		SET @Mensaje= @Mensaje + 'No se puede eliminar porque se encuentra relacionado a una VENTA\n'
	END
	IF (@PasoReglas=1)
	BEGIN
	DELETE FROM PRODUCTO WHERE IdProducto = @IdProducto
	SET @Respuesta =1
	END
END
GO
/*REGISTRAR PRODUCTO*/
CREATE PROCEDURE sp_RegistrarProducto(
@Codigo varchar(20),
@Nombre varchar(30),
@Descripcion varchar(30),
@IdCategoria int,
@Estado bit,
@Resultado bit output,
@Mensaje varchar (500) output
)as
begin 
	SET @Resultado = 0
	IF NOT EXISTS (SELECT * FROM PRODUCTO WHERE Codigo = @Codigo)
	BEGIN
		INSERT INTO PRODUCTO (Codigo,Nombre,Descripcion,IdCategoria, Estado) VALUES (@Codigo,@Nombre,@Descripcion,@IdCategoria,@Estado)
		SET @Resultado = SCOPE_IDENTITY()
	END
	ELSE
		SET @Mensaje = 'Ya existe un producto con el mismo código'
END
GO

/*PROCESOS PARA REGISTRAR UNA COMPRA*/

CREATE TYPE [dbo].[EDetalle_Compra] AS TABLE(
	[IdProducto] int NULL,
	[PrecioCompra] decimal(18,2) NULL,
	[PrecioVenta] decimal(18,2) NULL,
	[Cantidad] int NULL,
	[MontoTotal] decimal(18,2) NULL
)

GO

CREATE PROCEDURE sp_RegistrarCompra(
@IdUsuario int,
@IdProveedor int,
@TipoDocumento varchar(500),
@NumeroDocumento varchar(500),
@MontoTotal decimal(18,2),
@DetalleCompra [EDetalle_Compra] READONLY,
@Resultado bit output,
@Mensaje varchar(500) output
)
as
begin

	begin try

		declare @idcompra int = 0
		set @Resultado = 1
		set @Mensaje = ' '

		begin transaction registro

		insert into COMPRA(IdUsuario, IdProveedor, TipoDocumento, NumeroDocumento, MontoTotal)
		values(@IdUsuario,@IdProveedor,@TipoDocumento,@NumeroDocumento,@MontoTotal)

		set @idcompra = SCOPE_IDENTITY()

		insert into DETALLE_COMPRA(IdCompra,IdProducto,PrecioCompra,PrecioVenta,Cantidad,MontoTotal)
		select @idcompra,IdProducto,PrecioCompra,PrecioVenta,Cantidad,MontoTotal from @DetalleCompra

		update p set p.Stock = p.Stock + dc.Cantidad,
		p.PrecioCompra = dc.PrecioCompra,
		p.PrecioVenta = dc.PrecioVenta
		from PRODUCTO p
		inner join @DetalleCompra dc on dc.IdProducto= p.IdProducto

		commit transaction registro

	end try
	begin catch
		set @Resultado = 0
		set @Mensaje = ERROR_MESSAGE()
		rollback transaction registro

	end catch

end

/* PROCESOS PARA REGISTRAR UNA VENTA */

CREATE TYPE [dbo].[EDetalle_Venta] AS TABLE(
	[IdProducto] int NULL,
	[PrecioVenta] decimal(18,2) NULL,
	[Cantidad] int NULL,
	[Subtotal] decimal(18,2) NULL
)

GO

CREATE PROCEDURE sp_RegistrarVenta(
@IdUsuario int,
@TipoDocumento varchar(500),
@NumeroDocumento varchar(500),
@MontoPago decimal(18,2),
@MontoCambio decimal(18,2),
@MontoTotal decimal(18,2),
@DetalleVenta [EDetalle_Venta] READONLY,
@Resultado bit output,
@Mensaje varchar(500) output
)
as
begin

	begin try
		
		declare @idventa int = 0
		set @Resultado = 1
		set @Mensaje = ''

		begin transaction registro
		
		insert into VENTA(IdUsuario,TipoDocumento,NumeroDocumento,MontoPago,MontoCambio,MontoTotal)
		values(@IdUsuario,@TipoDocumento,@NumeroDocumento,@MontoPago,@MontoCambio,@MontoTotal)
	
		set @idventa = SCOPE_IDENTITY()

		insert into DETALLE_VENTA(IdVenta,IdProducto,PrecioVenta,Cantidad,SubTotal)
		select @idventa,IdProducto,PrecioVenta,Cantidad,SubTotal from @DetalleVenta

		commit transaction registro

	end try
	begin catch
		set @Resultado = 0
		set @Mensaje = ERROR_MESSAGE()
		rollback transaction registro
	end catch

end

------------PROCEDIMIENTOS PARA PROVEEDOR---------------
create PROC sp_RegistrarProveedor(
@Documento varchar(50),
@RazonSocial varchar(50), 
@Correo varchar(50),
@Telefono varchar(50),
@Estado bit,
@Resultado int output,
@Mensaje varchar(500) output
)as
begin
    SET @Resultado = 0
    DECLARE @IDPERSONA INT
    IF NOT EXISTS (SELECT * FROM PROVEEDOR WHERE Documento = @Documento)
    begin
        insert into PROVEEDOR(Documento, RazonSocial, Correo, Telefono, Estado) values (
        @Documento, @RazonSocial, @Correo, @Telefono, @Estado)

        set @Resultado = SCOPE_IDENTITY()
    end
    else
        set @Mensaje = 'El numero de documento ya existe'
end

GO

create PROC sp_EditarProveedor(
@IdProveedor int,
@Documento varchar(50),
@RazonSocial varchar(50), 
@Correo varchar(50),
@Telefono varchar(50),
@Estado bit,
@Resultado bit output,
@Mensaje varchar(500) output
)as
begin
    SET @Resultado = 1
    DECLARE @IDPERSONA INT
    IF NOT EXISTS (SELECT * FROM PROVEEDOR WHERE Documento = @Documento and IdProveedor !=IdProveedor)
    begin
        update PROVEEDOR set
        Documento = @Documento,
        RazonSocial = @RazonSocial,
        Correo = @Correo,
        Telefono = @Telefono,
        Estado = @Estado
        where IdProveedor = @IdProveedor
    end
    else
    begin
        SET @Resultado = 0
        set @Mensaje = 'El numero de documento ya existe'
    end
end

go

create procedure sp_EliminarProveedor(
@IdProveedor int,
@Resultado bit output,
@Mensaje varchar (500) output
)
as
begin
    SET @Resultado = 1
    IF NOT EXISTS(
        select * from PROVEEDOR p
        inner join COMPRA c on p.IdProveedor = c.IdProveedor
        where p.IdProveedor = @IdProveedor
    )
    begin
        delete top (1) from PROVEEDOR where IdProveedor = @IdProveedor
    end
    ELSE
    begin
        SET @Resultado = 0
        set @Mensaje = 'El proveedor se encuentra relacionado a una compra'
    end
end

go

create proc sp_ReporteCompras(
@fechainicio varchar(10),
@fechafin varchar(10),
@idproveedor int
)
as
begin

SET DATEFORMAT dmy;
select
CONVERT(char(10),c.FechaRegistro,103)[FechaRegistro],c.TipoDocumento,c.NumeroDocumento,c.MontoTotal,
u.NombreCompleto[UsuarioRegistro],
pr.Documento[DocumentoProveedor],pr.RazonSocial,
p.Codigo[CodigoProducto],p.Nombre[NombreProducto],
ca.Descripcion[Categoria],
dc.PrecioCompra,dc.PrecioVenta,dc.Cantidad,dc.MontoTotal[SubTotal]
from COMPRA c
inner join USUARIO u on u.IdUsuario = c.IdUsuario
inner join PROVEEDOR pr on pr.IdProveedor = c.IdProveedor
inner join DETALLE_COMPRA dc on dc.IdCompra = c.IdCompra
inner join PRODUCTO p on p.IdProducto = dc.IdProducto
inner join CATEGORIA ca on ca.IdCategoria = p.IdCategoria
where CONVERT(date,c.FechaRegistro) between @fechainicio and @fechafin and pr.IdProveedor = IIF(@idproveedor=0,pr.IdProveedor,@idproveedor)
end

go

create proc sp_ReporteVentas(
@fechainicio varchar(10),
@fechafin varchar(10)
)
as
begin

SET DATEFORMAT dmy;
select
CONVERT(char(10),v.FechaRegistro,103)[FechaRegistro],v.TipoDocumento,v.NumeroDocumento,v.MontoTotal,
u.NombreCompleto[UsuarioRegistro],
p.Codigo[CodigoProducto],p.Nombre[NombreProducto],ca.Descripcion[Categoria],dv.PrecioVenta,dv.Cantidad,dv.SubTotal
from VENTA v
inner join USUARIO u on u.IdUsuario = v.IdUsuario
inner join DETALLE_VENTA dv on dv.IdVenta = v.IdVenta
inner join PRODUCTO p on p.IdProducto = dv.IdProducto
inner join CATEGORIA ca on ca.IdCategoria = p.IdCategoria
where CONVERT(date,v.FechaRegistro) between @fechainicio and @fechafin
end

go
