USE [master]
GO
CREATE DATABASE [DBSISTEMA_VENTA]
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET COMPATIBILITY_LEVEL = 160
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
ALTER DATABASE [DBSISTEMA_VENTA] SET QUERY_STORE = ON
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [DBSISTEMA_VENTA]
GO
/****** Object:  UserDefinedTableType [dbo].[EDetalle_Compra]    Script Date: 04/05/2024 10:31:37 p. m. ******/
CREATE TYPE [dbo].[EDetalle_Compra] AS TABLE(
	[IdProducto] [int] NULL,
	[PrecioCompra] [decimal](18, 2) NULL,
	[PrecioVenta] [decimal](18, 2) NULL,
	[Cantidad] [int] NULL,
	[MontoTotal] [decimal](18, 2) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[EDetalle_Venta]    Script Date: 04/05/2024 10:31:37 p. m. ******/
CREATE TYPE [dbo].[EDetalle_Venta] AS TABLE(
	[IdProducto] [int] NULL,
	[PrecioVenta] [decimal](18, 2) NULL,
	[Cantidad] [int] NULL,
	[Subtotal] [decimal](18, 2) NULL
)
GO
/****** Object:  Table [dbo].[CATEGORIA]    Script Date: 04/05/2024 10:31:37 p. m. ******/
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
/****** Object:  Table [dbo].[COMPRA]    Script Date: 04/05/2024 10:31:37 p. m. ******/
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
/****** Object:  Table [dbo].[DETALLE_COMPRA]    Script Date: 04/05/2024 10:31:37 p. m. ******/
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
/****** Object:  Table [dbo].[DETALLE_VENTA]    Script Date: 04/05/2024 10:31:37 p. m. ******/
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
/****** Object:  Table [dbo].[DEVOLUCION]    Script Date: 04/05/2024 10:31:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEVOLUCION](
	[IdDevolucion] [int] NOT NULL,
	[IdVenta] [int] NOT NULL,
	[IdProducto] [int] NOT NULL,
	[Motivo] [varchar](60) NULL,
	[Cantidad] [int] NOT NULL,
	[MontoRembolso] [money] NOT NULL,
	[FechaDevolucion] [datetime] NULL,
 CONSTRAINT [PK_DEVOLUCION] PRIMARY KEY CLUSTERED 
(
	[IdDevolucion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FACTURA]    Script Date: 04/05/2024 10:31:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FACTURA](
	[IdFactura] [int] IDENTITY(1,1) NOT NULL,
	[IdVenta] [int] NOT NULL,
	[IdUsuario] [int] NOT NULL,
	[NombreCliente] [varchar](50) NOT NULL,
	[PrimerApellido] [varchar](50) NOT NULL,
	[SegundoApellido] [varchar](50) NOT NULL,
	[Calle] [varchar](100) NOT NULL,
	[NumExt] [int] NOT NULL,
	[NumInt] [int] NULL,
	[Colonia] [varchar](50) NOT NULL,
	[Municipio] [varchar](50) NOT NULL,
	[Pais] [varchar](50) NOT NULL,
	[CP] [varchar](5) NOT NULL,
	[RFC] [varchar](12) NOT NULL,
	[Correo] [varchar](80) NOT NULL,
	[Telefono] [varchar](10) NOT NULL,
	[RazonSocial] [varchar](50) NOT NULL,
	[UsoCFDI] [varchar](50) NOT NULL,
	[Fecha] [datetime] NOT NULL,
 CONSTRAINT [PK_FACTURA] PRIMARY KEY CLUSTERED 
(
	[IdFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HISTORIAL]    Script Date: 04/05/2024 10:31:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HISTORIAL](
	[IdUsuario] [int] NULL,
	[IdMovimiento] [int] NOT NULL,
	[FechaMovimiento] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PERMISO]    Script Date: 04/05/2024 10:31:37 p. m. ******/
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
/****** Object:  Table [dbo].[PRODUCTO]    Script Date: 04/05/2024 10:31:37 p. m. ******/
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
/****** Object:  Table [dbo].[PROVEEDOR]    Script Date: 04/05/2024 10:31:37 p. m. ******/
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
/****** Object:  Table [dbo].[ROL]    Script Date: 04/05/2024 10:31:37 p. m. ******/
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
/****** Object:  Table [dbo].[TIPO_MOVIMIENTO]    Script Date: 04/05/2024 10:31:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPO_MOVIMIENTO](
	[IdMovimiento] [int] NOT NULL,
	[Descripcion] [varchar](50) NOT NULL,
	[Activo] [bit] NOT NULL,
	[FechaRegistro] [datetime] NULL,
 CONSTRAINT [PK_TIPO_MOVIMIENTO] PRIMARY KEY CLUSTERED 
(
	[IdMovimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USUARIO]    Script Date: 04/05/2024 10:31:37 p. m. ******/
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
/****** Object:  Table [dbo].[VENTA]    Script Date: 04/05/2024 10:31:37 p. m. ******/
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
SET IDENTITY_INSERT [dbo].[CATEGORIA] ON 

INSERT [dbo].[CATEGORIA] ([IdCategoria], [Descripcion], [Estado], [FechaRegistro]) VALUES (1, N'Comida chatarra', 0, CAST(N'2023-06-01T21:40:11.557' AS DateTime))
INSERT [dbo].[CATEGORIA] ([IdCategoria], [Descripcion], [Estado], [FechaRegistro]) VALUES (2, N'Dulces', 1, CAST(N'2023-06-01T21:40:17.660' AS DateTime))
INSERT [dbo].[CATEGORIA] ([IdCategoria], [Descripcion], [Estado], [FechaRegistro]) VALUES (3, N'Limpieza', 1, CAST(N'2023-06-01T21:40:21.560' AS DateTime))
INSERT [dbo].[CATEGORIA] ([IdCategoria], [Descripcion], [Estado], [FechaRegistro]) VALUES (4, N'Bebidas', 1, CAST(N'2023-06-01T21:41:24.157' AS DateTime))
INSERT [dbo].[CATEGORIA] ([IdCategoria], [Descripcion], [Estado], [FechaRegistro]) VALUES (5, N'Bebidas Alcoholicas', 1, CAST(N'2023-06-01T21:41:30.410' AS DateTime))
INSERT [dbo].[CATEGORIA] ([IdCategoria], [Descripcion], [Estado], [FechaRegistro]) VALUES (6, N'Lacteos', 1, CAST(N'2024-02-27T20:11:56.450' AS DateTime))
INSERT [dbo].[CATEGORIA] ([IdCategoria], [Descripcion], [Estado], [FechaRegistro]) VALUES (7, N'Higiene', 1, CAST(N'2024-02-27T21:31:34.867' AS DateTime))
SET IDENTITY_INSERT [dbo].[CATEGORIA] OFF
GO
SET IDENTITY_INSERT [dbo].[COMPRA] ON 

INSERT [dbo].[COMPRA] ([IdCompra], [IdUsuario], [IdProveedor], [TipoDocumento], [NumeroDocumento], [MontoTotal], [FechaRegistro]) VALUES (1, 6, 8, N'Boleta', N'00001', CAST(1400.00 AS Decimal(10, 2)), CAST(N'2024-02-27T20:16:16.440' AS DateTime))
INSERT [dbo].[COMPRA] ([IdCompra], [IdUsuario], [IdProveedor], [TipoDocumento], [NumeroDocumento], [MontoTotal], [FechaRegistro]) VALUES (2, 6, 9, N'Boleta', N'00002', CAST(150.00 AS Decimal(10, 2)), CAST(N'2024-02-27T20:18:56.473' AS DateTime))
INSERT [dbo].[COMPRA] ([IdCompra], [IdUsuario], [IdProveedor], [TipoDocumento], [NumeroDocumento], [MontoTotal], [FechaRegistro]) VALUES (3, 5, 10, N'Boleta', N'00003', CAST(120.00 AS Decimal(10, 2)), CAST(N'2024-02-27T21:34:24.827' AS DateTime))
SET IDENTITY_INSERT [dbo].[COMPRA] OFF
GO
SET IDENTITY_INSERT [dbo].[DETALLE_COMPRA] ON 

INSERT [dbo].[DETALLE_COMPRA] ([IdDetalleCompra], [IdCompra], [IdProducto], [PrecioCompra], [PrecioVenta], [Cantidad], [MontoTotal], [FechaRegistro]) VALUES (1, 1, 14, CAST(28.00 AS Decimal(10, 2)), CAST(40.00 AS Decimal(10, 2)), 50, CAST(1400.00 AS Decimal(10, 2)), CAST(N'2024-02-27T20:16:16.440' AS DateTime))
INSERT [dbo].[DETALLE_COMPRA] ([IdDetalleCompra], [IdCompra], [IdProducto], [PrecioCompra], [PrecioVenta], [Cantidad], [MontoTotal], [FechaRegistro]) VALUES (2, 2, 13, CAST(10.00 AS Decimal(10, 2)), CAST(25.00 AS Decimal(10, 2)), 15, CAST(150.00 AS Decimal(10, 2)), CAST(N'2024-02-27T20:18:56.473' AS DateTime))
INSERT [dbo].[DETALLE_COMPRA] ([IdDetalleCompra], [IdCompra], [IdProducto], [PrecioCompra], [PrecioVenta], [Cantidad], [MontoTotal], [FechaRegistro]) VALUES (3, 3, 15, CAST(12.00 AS Decimal(10, 2)), CAST(17.00 AS Decimal(10, 2)), 10, CAST(120.00 AS Decimal(10, 2)), CAST(N'2024-02-27T21:34:24.830' AS DateTime))
SET IDENTITY_INSERT [dbo].[DETALLE_COMPRA] OFF
GO
SET IDENTITY_INSERT [dbo].[DETALLE_VENTA] ON 

INSERT [dbo].[DETALLE_VENTA] ([IdDetalleVenta], [IdVenta], [IdProducto], [PrecioVenta], [Cantidad], [SubTotal], [FechaRegistro]) VALUES (1, 1, 2, CAST(15.00 AS Decimal(10, 2)), 2, CAST(30.00 AS Decimal(10, 2)), CAST(N'2023-06-02T16:55:10.303' AS DateTime))
INSERT [dbo].[DETALLE_VENTA] ([IdDetalleVenta], [IdVenta], [IdProducto], [PrecioVenta], [Cantidad], [SubTotal], [FechaRegistro]) VALUES (2, 1, 12, CAST(16.00 AS Decimal(10, 2)), 2, CAST(32.00 AS Decimal(10, 2)), CAST(N'2023-06-02T16:55:10.303' AS DateTime))
INSERT [dbo].[DETALLE_VENTA] ([IdDetalleVenta], [IdVenta], [IdProducto], [PrecioVenta], [Cantidad], [SubTotal], [FechaRegistro]) VALUES (3, 2, 1, CAST(120.00 AS Decimal(10, 2)), 1, CAST(120.00 AS Decimal(10, 2)), CAST(N'2023-06-02T16:56:13.820' AS DateTime))
INSERT [dbo].[DETALLE_VENTA] ([IdDetalleVenta], [IdVenta], [IdProducto], [PrecioVenta], [Cantidad], [SubTotal], [FechaRegistro]) VALUES (4, 2, 4, CAST(60.00 AS Decimal(10, 2)), 2, CAST(120.00 AS Decimal(10, 2)), CAST(N'2023-06-02T16:56:13.820' AS DateTime))
INSERT [dbo].[DETALLE_VENTA] ([IdDetalleVenta], [IdVenta], [IdProducto], [PrecioVenta], [Cantidad], [SubTotal], [FechaRegistro]) VALUES (5, 3, 9, CAST(50.00 AS Decimal(10, 2)), 1, CAST(50.00 AS Decimal(10, 2)), CAST(N'2023-06-02T17:40:49.993' AS DateTime))
INSERT [dbo].[DETALLE_VENTA] ([IdDetalleVenta], [IdVenta], [IdProducto], [PrecioVenta], [Cantidad], [SubTotal], [FechaRegistro]) VALUES (6, 3, 8, CAST(50.00 AS Decimal(10, 2)), 1, CAST(50.00 AS Decimal(10, 2)), CAST(N'2023-06-02T17:40:49.993' AS DateTime))
INSERT [dbo].[DETALLE_VENTA] ([IdDetalleVenta], [IdVenta], [IdProducto], [PrecioVenta], [Cantidad], [SubTotal], [FechaRegistro]) VALUES (7, 4, 6, CAST(15.00 AS Decimal(10, 2)), 1, CAST(15.00 AS Decimal(10, 2)), CAST(N'2024-02-27T20:20:55.273' AS DateTime))
INSERT [dbo].[DETALLE_VENTA] ([IdDetalleVenta], [IdVenta], [IdProducto], [PrecioVenta], [Cantidad], [SubTotal], [FechaRegistro]) VALUES (8, 4, 10, CAST(20.00 AS Decimal(10, 2)), 1, CAST(20.00 AS Decimal(10, 2)), CAST(N'2024-02-27T20:20:55.273' AS DateTime))
INSERT [dbo].[DETALLE_VENTA] ([IdDetalleVenta], [IdVenta], [IdProducto], [PrecioVenta], [Cantidad], [SubTotal], [FechaRegistro]) VALUES (9, 4, 3, CAST(20.00 AS Decimal(10, 2)), 1, CAST(20.00 AS Decimal(10, 2)), CAST(N'2024-02-27T20:20:55.273' AS DateTime))
INSERT [dbo].[DETALLE_VENTA] ([IdDetalleVenta], [IdVenta], [IdProducto], [PrecioVenta], [Cantidad], [SubTotal], [FechaRegistro]) VALUES (10, 4, 13, CAST(25.00 AS Decimal(10, 2)), 1, CAST(25.00 AS Decimal(10, 2)), CAST(N'2024-02-27T20:20:55.273' AS DateTime))
INSERT [dbo].[DETALLE_VENTA] ([IdDetalleVenta], [IdVenta], [IdProducto], [PrecioVenta], [Cantidad], [SubTotal], [FechaRegistro]) VALUES (11, 5, 5, CAST(30.00 AS Decimal(10, 2)), 1, CAST(30.00 AS Decimal(10, 2)), CAST(N'2024-02-27T20:41:50.497' AS DateTime))
INSERT [dbo].[DETALLE_VENTA] ([IdDetalleVenta], [IdVenta], [IdProducto], [PrecioVenta], [Cantidad], [SubTotal], [FechaRegistro]) VALUES (12, 6, 5, CAST(30.00 AS Decimal(10, 2)), 1, CAST(30.00 AS Decimal(10, 2)), CAST(N'2024-02-27T21:37:02.867' AS DateTime))
INSERT [dbo].[DETALLE_VENTA] ([IdDetalleVenta], [IdVenta], [IdProducto], [PrecioVenta], [Cantidad], [SubTotal], [FechaRegistro]) VALUES (13, 6, 3, CAST(20.00 AS Decimal(10, 2)), 2, CAST(40.00 AS Decimal(10, 2)), CAST(N'2024-02-27T21:37:02.867' AS DateTime))
INSERT [dbo].[DETALLE_VENTA] ([IdDetalleVenta], [IdVenta], [IdProducto], [PrecioVenta], [Cantidad], [SubTotal], [FechaRegistro]) VALUES (14, 6, 11, CAST(60.00 AS Decimal(10, 2)), 2, CAST(120.00 AS Decimal(10, 2)), CAST(N'2024-02-27T21:37:02.867' AS DateTime))
INSERT [dbo].[DETALLE_VENTA] ([IdDetalleVenta], [IdVenta], [IdProducto], [PrecioVenta], [Cantidad], [SubTotal], [FechaRegistro]) VALUES (15, 7, 3, CAST(20.00 AS Decimal(10, 2)), 1, CAST(20.00 AS Decimal(10, 2)), CAST(N'2024-05-02T09:47:39.547' AS DateTime))
INSERT [dbo].[DETALLE_VENTA] ([IdDetalleVenta], [IdVenta], [IdProducto], [PrecioVenta], [Cantidad], [SubTotal], [FechaRegistro]) VALUES (16, 8, 5, CAST(30.00 AS Decimal(10, 2)), 1, CAST(30.00 AS Decimal(10, 2)), CAST(N'2024-05-04T21:11:44.820' AS DateTime))
INSERT [dbo].[DETALLE_VENTA] ([IdDetalleVenta], [IdVenta], [IdProducto], [PrecioVenta], [Cantidad], [SubTotal], [FechaRegistro]) VALUES (17, 9, 6, CAST(15.00 AS Decimal(10, 2)), 1, CAST(15.00 AS Decimal(10, 2)), CAST(N'2024-05-04T21:15:14.893' AS DateTime))
INSERT [dbo].[DETALLE_VENTA] ([IdDetalleVenta], [IdVenta], [IdProducto], [PrecioVenta], [Cantidad], [SubTotal], [FechaRegistro]) VALUES (18, 10, 1, CAST(120.00 AS Decimal(10, 2)), 1, CAST(120.00 AS Decimal(10, 2)), CAST(N'2024-05-04T21:16:56.817' AS DateTime))
INSERT [dbo].[DETALLE_VENTA] ([IdDetalleVenta], [IdVenta], [IdProducto], [PrecioVenta], [Cantidad], [SubTotal], [FechaRegistro]) VALUES (19, 11, 4, CAST(60.00 AS Decimal(10, 2)), 1, CAST(60.00 AS Decimal(10, 2)), CAST(N'2024-05-04T21:27:01.830' AS DateTime))
INSERT [dbo].[DETALLE_VENTA] ([IdDetalleVenta], [IdVenta], [IdProducto], [PrecioVenta], [Cantidad], [SubTotal], [FechaRegistro]) VALUES (20, 12, 4, CAST(60.00 AS Decimal(10, 2)), 1, CAST(60.00 AS Decimal(10, 2)), CAST(N'2024-05-04T21:39:09.233' AS DateTime))
SET IDENTITY_INSERT [dbo].[DETALLE_VENTA] OFF
GO
INSERT [dbo].[HISTORIAL] ([IdUsuario], [IdMovimiento], [FechaMovimiento]) VALUES (1, 14, CAST(N'2024-05-04T21:11:44.820' AS DateTime))
INSERT [dbo].[HISTORIAL] ([IdUsuario], [IdMovimiento], [FechaMovimiento]) VALUES (1, 14, CAST(N'2024-05-04T21:15:14.893' AS DateTime))
INSERT [dbo].[HISTORIAL] ([IdUsuario], [IdMovimiento], [FechaMovimiento]) VALUES (1, 14, CAST(N'2024-05-04T21:16:56.820' AS DateTime))
INSERT [dbo].[HISTORIAL] ([IdUsuario], [IdMovimiento], [FechaMovimiento]) VALUES (1, 14, CAST(N'2024-05-04T21:27:01.833' AS DateTime))
INSERT [dbo].[HISTORIAL] ([IdUsuario], [IdMovimiento], [FechaMovimiento]) VALUES (1, 14, CAST(N'2024-05-04T21:39:09.237' AS DateTime))
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
INSERT [dbo].[PERMISO] ([IdPermiso], [IdRol], [NombreMenu], [FechaRegistro]) VALUES (14, 1, N'Ayuda', CAST(N'2024-05-04T00:00:00.000' AS DateTime))
INSERT [dbo].[PERMISO] ([IdPermiso], [IdRol], [NombreMenu], [FechaRegistro]) VALUES (15, 2, N'Ayuda', CAST(N'2024-05-04T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[PERMISO] OFF
GO
SET IDENTITY_INSERT [dbo].[PRODUCTO] ON 

INSERT [dbo].[PRODUCTO] ([IdProducto], [Codigo], [Nombre], [Descripcion], [IdCategoria], [Stock], [PrecioCompra], [PrecioVenta], [Estado], [FechaRegistro]) VALUES (1, N'1324', N'Tecate Light', N'6 pack', 5, 98, CAST(100.00 AS Decimal(10, 2)), CAST(120.00 AS Decimal(10, 2)), 1, CAST(N'2023-06-01T21:42:03.243' AS DateTime))
INSERT [dbo].[PRODUCTO] ([IdProducto], [Codigo], [Nombre], [Descripcion], [IdCategoria], [Stock], [PrecioCompra], [PrecioVenta], [Estado], [FechaRegistro]) VALUES (2, N'34561', N'Fritos', N'Papitas marca Fritos', 1, 76, CAST(10.00 AS Decimal(10, 2)), CAST(15.00 AS Decimal(10, 2)), 1, CAST(N'2023-06-01T21:43:25.387' AS DateTime))
INSERT [dbo].[PRODUCTO] ([IdProducto], [Codigo], [Nombre], [Descripcion], [IdCategoria], [Stock], [PrecioCompra], [PrecioVenta], [Estado], [FechaRegistro]) VALUES (3, N'23546', N'Sabritas', N'Sabritas sabor Limon', 1, 86, CAST(12.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), 1, CAST(N'2023-06-01T21:44:30.647' AS DateTime))
INSERT [dbo].[PRODUCTO] ([IdProducto], [Codigo], [Nombre], [Descripcion], [IdCategoria], [Stock], [PrecioCompra], [PrecioVenta], [Estado], [FechaRegistro]) VALUES (4, N'87954', N'Cerveza Indio', N'Caguama', 5, 46, CAST(40.00 AS Decimal(10, 2)), CAST(60.00 AS Decimal(10, 2)), 1, CAST(N'2023-06-01T21:44:53.030' AS DateTime))
INSERT [dbo].[PRODUCTO] ([IdProducto], [Codigo], [Nombre], [Descripcion], [IdCategoria], [Stock], [PrecioCompra], [PrecioVenta], [Estado], [FechaRegistro]) VALUES (5, N'68794', N'Fabuloso', N'Fabuloso olor floral', 3, 17, CAST(15.00 AS Decimal(10, 2)), CAST(30.00 AS Decimal(10, 2)), 1, CAST(N'2023-06-01T21:46:32.450' AS DateTime))
INSERT [dbo].[PRODUCTO] ([IdProducto], [Codigo], [Nombre], [Descripcion], [IdCategoria], [Stock], [PrecioCompra], [PrecioVenta], [Estado], [FechaRegistro]) VALUES (6, N'34512', N'Skwinkles', N'N/A', 2, 18, CAST(10.00 AS Decimal(10, 2)), CAST(15.00 AS Decimal(10, 2)), 1, CAST(N'2023-06-01T21:46:49.620' AS DateTime))
INSERT [dbo].[PRODUCTO] ([IdProducto], [Codigo], [Nombre], [Descripcion], [IdCategoria], [Stock], [PrecioCompra], [PrecioVenta], [Estado], [FechaRegistro]) VALUES (7, N'87943', N'Pelon Pelo Rico', N'N/A', 2, 30, CAST(8.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(10, 2)), 1, CAST(N'2023-06-01T21:47:41.650' AS DateTime))
INSERT [dbo].[PRODUCTO] ([IdProducto], [Codigo], [Nombre], [Descripcion], [IdCategoria], [Stock], [PrecioCompra], [PrecioVenta], [Estado], [FechaRegistro]) VALUES (8, N'65134', N'Trapeador', N'N/A', 3, 10, CAST(20.00 AS Decimal(10, 2)), CAST(50.00 AS Decimal(10, 2)), 1, CAST(N'2023-06-01T21:47:54.490' AS DateTime))
INSERT [dbo].[PRODUCTO] ([IdProducto], [Codigo], [Nombre], [Descripcion], [IdCategoria], [Stock], [PrecioCompra], [PrecioVenta], [Estado], [FechaRegistro]) VALUES (9, N'76843', N'Escoba', N'N/A', 3, 10, CAST(20.00 AS Decimal(10, 2)), CAST(50.00 AS Decimal(10, 2)), 1, CAST(N'2023-06-01T21:48:04.260' AS DateTime))
INSERT [dbo].[PRODUCTO] ([IdProducto], [Codigo], [Nombre], [Descripcion], [IdCategoria], [Stock], [PrecioCompra], [PrecioVenta], [Estado], [FechaRegistro]) VALUES (10, N'42579', N'Galletas Emperador', N'Sabor limón', 1, 29, CAST(12.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), 1, CAST(N'2023-06-01T21:52:02.110' AS DateTime))
INSERT [dbo].[PRODUCTO] ([IdProducto], [Codigo], [Nombre], [Descripcion], [IdCategoria], [Stock], [PrecioCompra], [PrecioVenta], [Estado], [FechaRegistro]) VALUES (11, N'86541', N'Panque', N'Con nueces', 1, 18, CAST(30.00 AS Decimal(10, 2)), CAST(60.00 AS Decimal(10, 2)), 1, CAST(N'2023-06-01T21:52:22.970' AS DateTime))
INSERT [dbo].[PRODUCTO] ([IdProducto], [Codigo], [Nombre], [Descripcion], [IdCategoria], [Stock], [PrecioCompra], [PrecioVenta], [Estado], [FechaRegistro]) VALUES (12, N'65432', N'CocaCola', N'200 ml', 4, 98, CAST(8.00 AS Decimal(10, 2)), CAST(16.00 AS Decimal(10, 2)), 1, CAST(N'2023-06-02T16:52:29.640' AS DateTime))
INSERT [dbo].[PRODUCTO] ([IdProducto], [Codigo], [Nombre], [Descripcion], [IdCategoria], [Stock], [PrecioCompra], [PrecioVenta], [Estado], [FechaRegistro]) VALUES (13, N'78561', N'Agua Ciel', N'150 ml', 4, 164, CAST(10.00 AS Decimal(10, 2)), CAST(25.00 AS Decimal(10, 2)), 1, CAST(N'2023-06-02T16:53:52.300' AS DateTime))
INSERT [dbo].[PRODUCTO] ([IdProducto], [Codigo], [Nombre], [Descripcion], [IdCategoria], [Stock], [PrecioCompra], [PrecioVenta], [Estado], [FechaRegistro]) VALUES (14, N'11111', N'Leche Lala', N'2lt', 6, 49, CAST(28.00 AS Decimal(10, 2)), CAST(40.00 AS Decimal(10, 2)), 1, CAST(N'2024-02-27T20:12:34.360' AS DateTime))
INSERT [dbo].[PRODUCTO] ([IdProducto], [Codigo], [Nombre], [Descripcion], [IdCategoria], [Stock], [PrecioCompra], [PrecioVenta], [Estado], [FechaRegistro]) VALUES (15, N'454112', N'Jabon de tocador', N'DOVE', 7, 10, CAST(12.00 AS Decimal(10, 2)), CAST(17.00 AS Decimal(10, 2)), 1, CAST(N'2024-02-27T21:32:15.837' AS DateTime))
SET IDENTITY_INSERT [dbo].[PRODUCTO] OFF
GO
SET IDENTITY_INSERT [dbo].[PROVEEDOR] ON 

INSERT [dbo].[PROVEEDOR] ([IdProveedor], [Documento], [RazonSocial], [Correo], [Telefono], [Estado], [FechaRegistro]) VALUES (1, N'15346', N'Bimbo', N'bimo@mexico.com', N'8146623546', 1, CAST(N'2023-05-31T15:37:30.717' AS DateTime))
INSERT [dbo].[PROVEEDOR] ([IdProveedor], [Documento], [RazonSocial], [Correo], [Telefono], [Estado], [FechaRegistro]) VALUES (2, N'11456', N'Marinela', N'marinela@mexico.com', N'8144562941', 1, CAST(N'2023-05-31T15:44:53.040' AS DateTime))
INSERT [dbo].[PROVEEDOR] ([IdProveedor], [Documento], [RazonSocial], [Correo], [Telefono], [Estado], [FechaRegistro]) VALUES (3, N'53153', N'Gamesa', N'gamesa@mexico.com', N'8164534261', 1, CAST(N'2023-05-31T15:48:35.160' AS DateTime))
INSERT [dbo].[PROVEEDOR] ([IdProveedor], [Documento], [RazonSocial], [Correo], [Telefono], [Estado], [FechaRegistro]) VALUES (5, N'65748', N'Limpieza Supreme', N'limpiezasupreme@mexico.com', N'8119463654', 1, CAST(N'2023-06-01T21:49:36.200' AS DateTime))
INSERT [dbo].[PROVEEDOR] ([IdProveedor], [Documento], [RazonSocial], [Correo], [Telefono], [Estado], [FechaRegistro]) VALUES (6, N'98764', N'Dulcerias Gonzalitos', N'dulcesgonzalitos@mexico.com', N'8125647923', 1, CAST(N'2023-06-01T21:50:21.840' AS DateTime))
INSERT [dbo].[PROVEEDOR] ([IdProveedor], [Documento], [RazonSocial], [Correo], [Telefono], [Estado], [FechaRegistro]) VALUES (7, N'56762', N'Cerveceria México', N'cerveceria@mexico.com', N'8125467926', 1, CAST(N'2023-06-01T21:51:12.337' AS DateTime))
INSERT [dbo].[PROVEEDOR] ([IdProveedor], [Documento], [RazonSocial], [Correo], [Telefono], [Estado], [FechaRegistro]) VALUES (8, N'121212', N'Coca Cola', N'cocacola@hotmail.com', N'', 1, CAST(N'2024-02-27T20:14:15.437' AS DateTime))
INSERT [dbo].[PROVEEDOR] ([IdProveedor], [Documento], [RazonSocial], [Correo], [Telefono], [Estado], [FechaRegistro]) VALUES (9, N'010101', N'Pepsi', N'pepsico@hotmail.com', N'', 1, CAST(N'2024-02-27T20:17:45.397' AS DateTime))
INSERT [dbo].[PROVEEDOR] ([IdProveedor], [Documento], [RazonSocial], [Correo], [Telefono], [Estado], [FechaRegistro]) VALUES (10, N'35123', N'DOVE', N'dove@hotmail.com', N'8111223131', 1, CAST(N'2024-02-27T21:33:23.557' AS DateTime))
SET IDENTITY_INSERT [dbo].[PROVEEDOR] OFF
GO
SET IDENTITY_INSERT [dbo].[ROL] ON 

INSERT [dbo].[ROL] ([IdRol], [Descripcion], [FechaRegistro]) VALUES (1, N'ADMINISTRADOR', CAST(N'2023-04-04T00:31:29.180' AS DateTime))
INSERT [dbo].[ROL] ([IdRol], [Descripcion], [FechaRegistro]) VALUES (2, N'EMPLEADO', CAST(N'2023-04-04T21:27:37.533' AS DateTime))
SET IDENTITY_INSERT [dbo].[ROL] OFF
GO
INSERT [dbo].[TIPO_MOVIMIENTO] ([IdMovimiento], [Descripcion], [Activo], [FechaRegistro]) VALUES (1, N'Insertar Categoria', 1, CAST(N'2024-05-02T00:00:00.000' AS DateTime))
INSERT [dbo].[TIPO_MOVIMIENTO] ([IdMovimiento], [Descripcion], [Activo], [FechaRegistro]) VALUES (2, N'Editar Categoria', 1, CAST(N'2024-05-02T00:00:00.000' AS DateTime))
INSERT [dbo].[TIPO_MOVIMIENTO] ([IdMovimiento], [Descripcion], [Activo], [FechaRegistro]) VALUES (3, N'Eliminar Categoria', 1, CAST(N'2024-05-02T00:00:00.000' AS DateTime))
INSERT [dbo].[TIPO_MOVIMIENTO] ([IdMovimiento], [Descripcion], [Activo], [FechaRegistro]) VALUES (4, N'Insertar Producto', 1, CAST(N'2024-05-02T00:00:00.000' AS DateTime))
INSERT [dbo].[TIPO_MOVIMIENTO] ([IdMovimiento], [Descripcion], [Activo], [FechaRegistro]) VALUES (5, N'Editar Producto', 1, CAST(N'2024-05-02T00:00:00.000' AS DateTime))
INSERT [dbo].[TIPO_MOVIMIENTO] ([IdMovimiento], [Descripcion], [Activo], [FechaRegistro]) VALUES (6, N'Eliminar Producto', 1, CAST(N'2024-05-02T00:00:00.000' AS DateTime))
INSERT [dbo].[TIPO_MOVIMIENTO] ([IdMovimiento], [Descripcion], [Activo], [FechaRegistro]) VALUES (7, N'Insertar Proveedor', 1, CAST(N'2024-05-02T00:00:00.000' AS DateTime))
INSERT [dbo].[TIPO_MOVIMIENTO] ([IdMovimiento], [Descripcion], [Activo], [FechaRegistro]) VALUES (8, N'Editar Proveedor', 1, CAST(N'2024-05-02T00:00:00.000' AS DateTime))
INSERT [dbo].[TIPO_MOVIMIENTO] ([IdMovimiento], [Descripcion], [Activo], [FechaRegistro]) VALUES (9, N'Eliminar Proveedor', 1, CAST(N'2024-05-02T00:00:00.000' AS DateTime))
INSERT [dbo].[TIPO_MOVIMIENTO] ([IdMovimiento], [Descripcion], [Activo], [FechaRegistro]) VALUES (10, N'Insertar Usuario', 1, CAST(N'2024-05-02T00:00:00.000' AS DateTime))
INSERT [dbo].[TIPO_MOVIMIENTO] ([IdMovimiento], [Descripcion], [Activo], [FechaRegistro]) VALUES (11, N'Editar Usuario', 1, CAST(N'2024-05-02T00:00:00.000' AS DateTime))
INSERT [dbo].[TIPO_MOVIMIENTO] ([IdMovimiento], [Descripcion], [Activo], [FechaRegistro]) VALUES (12, N'Eliminar Usuario', 1, CAST(N'2024-05-02T00:00:00.000' AS DateTime))
INSERT [dbo].[TIPO_MOVIMIENTO] ([IdMovimiento], [Descripcion], [Activo], [FechaRegistro]) VALUES (13, N'Insertar Compra', 1, CAST(N'2024-05-02T00:00:00.000' AS DateTime))
INSERT [dbo].[TIPO_MOVIMIENTO] ([IdMovimiento], [Descripcion], [Activo], [FechaRegistro]) VALUES (14, N'Insertar Venta', 1, CAST(N'2024-05-02T00:00:00.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[USUARIO] ON 

INSERT [dbo].[USUARIO] ([IdUsuario], [Documento], [NombreCompleto], [Correo], [Clave], [IdRol], [Estado], [FechaRegistro]) VALUES (1, N'1899885', N'ADMIN', N'@gmail.com', N'123', 1, 1, CAST(N'2023-04-04T00:32:48.910' AS DateTime))
INSERT [dbo].[USUARIO] ([IdUsuario], [Documento], [NombreCompleto], [Correo], [Clave], [IdRol], [Estado], [FechaRegistro]) VALUES (2, N'123', N'Emp1', N'@hotmail.com', N'123', 2, 1, CAST(N'2023-04-04T22:14:43.833' AS DateTime))
INSERT [dbo].[USUARIO] ([IdUsuario], [Documento], [NombreCompleto], [Correo], [Clave], [IdRol], [Estado], [FechaRegistro]) VALUES (3, N'456', N'pruebas2', N'text@gmail.com', N'456', 2, 1, CAST(N'2023-04-12T15:45:42.547' AS DateTime))
INSERT [dbo].[USUARIO] ([IdUsuario], [Documento], [NombreCompleto], [Correo], [Clave], [IdRol], [Estado], [FechaRegistro]) VALUES (5, N'0606', N'Yesi', N'yesi@hotmail.com', N'123', 1, 1, CAST(N'2024-02-27T20:06:11.480' AS DateTime))
INSERT [dbo].[USUARIO] ([IdUsuario], [Documento], [NombreCompleto], [Correo], [Clave], [IdRol], [Estado], [FechaRegistro]) VALUES (6, N'25', N'Leonardo', N'', N'1212', 2, 1, CAST(N'2024-02-27T20:10:08.770' AS DateTime))
INSERT [dbo].[USUARIO] ([IdUsuario], [Documento], [NombreCompleto], [Correo], [Clave], [IdRol], [Estado], [FechaRegistro]) VALUES (7, N'11111', N'Rocio', N'', N'123', 1, 1, CAST(N'2024-02-27T20:58:13.887' AS DateTime))
INSERT [dbo].[USUARIO] ([IdUsuario], [Documento], [NombreCompleto], [Correo], [Clave], [IdRol], [Estado], [FechaRegistro]) VALUES (8, N'26311', N'Andrea', N'andrea@hotmail.com', N'123', 2, 1, CAST(N'2024-02-27T21:30:04.410' AS DateTime))
SET IDENTITY_INSERT [dbo].[USUARIO] OFF
GO
SET IDENTITY_INSERT [dbo].[VENTA] ON 

INSERT [dbo].[VENTA] ([IdVenta], [IdUsuario], [TipoDocumento], [NumeroDocumento], [MontoPago], [MontoCambio], [MontoTotal], [FechaRegistro]) VALUES (1, 1, N'Boleta', N'00001', CAST(100.00 AS Decimal(10, 2)), CAST(38.00 AS Decimal(10, 2)), CAST(62.00 AS Decimal(10, 2)), CAST(N'2023-06-02T16:55:10.303' AS DateTime))
INSERT [dbo].[VENTA] ([IdVenta], [IdUsuario], [TipoDocumento], [NumeroDocumento], [MontoPago], [MontoCambio], [MontoTotal], [FechaRegistro]) VALUES (2, 1, N'Boleta', N'00002', CAST(300.00 AS Decimal(10, 2)), CAST(60.00 AS Decimal(10, 2)), CAST(240.00 AS Decimal(10, 2)), CAST(N'2023-06-02T16:56:13.820' AS DateTime))
INSERT [dbo].[VENTA] ([IdVenta], [IdUsuario], [TipoDocumento], [NumeroDocumento], [MontoPago], [MontoCambio], [MontoTotal], [FechaRegistro]) VALUES (3, 1, N'Boleta', N'00003', CAST(120.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(100.00 AS Decimal(10, 2)), CAST(N'2023-06-02T17:40:49.993' AS DateTime))
INSERT [dbo].[VENTA] ([IdVenta], [IdUsuario], [TipoDocumento], [NumeroDocumento], [MontoPago], [MontoCambio], [MontoTotal], [FechaRegistro]) VALUES (4, 6, N'Boleta', N'00004', CAST(100.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(80.00 AS Decimal(10, 2)), CAST(N'2024-02-27T20:20:55.270' AS DateTime))
INSERT [dbo].[VENTA] ([IdVenta], [IdUsuario], [TipoDocumento], [NumeroDocumento], [MontoPago], [MontoCambio], [MontoTotal], [FechaRegistro]) VALUES (5, 6, N'Boleta', N'00005', CAST(30.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(30.00 AS Decimal(10, 2)), CAST(N'2024-02-27T20:41:50.497' AS DateTime))
INSERT [dbo].[VENTA] ([IdVenta], [IdUsuario], [TipoDocumento], [NumeroDocumento], [MontoPago], [MontoCambio], [MontoTotal], [FechaRegistro]) VALUES (6, 5, N'Boleta', N'00006', CAST(200.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(10, 2)), CAST(190.00 AS Decimal(10, 2)), CAST(N'2024-02-27T21:37:02.867' AS DateTime))
INSERT [dbo].[VENTA] ([IdVenta], [IdUsuario], [TipoDocumento], [NumeroDocumento], [MontoPago], [MontoCambio], [MontoTotal], [FechaRegistro]) VALUES (7, 1, N'Boleta', N'00007', CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(N'2024-05-02T09:47:39.543' AS DateTime))
INSERT [dbo].[VENTA] ([IdVenta], [IdUsuario], [TipoDocumento], [NumeroDocumento], [MontoPago], [MontoCambio], [MontoTotal], [FechaRegistro]) VALUES (8, 1, N'Boleta', N'00008', CAST(50.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(30.00 AS Decimal(10, 2)), CAST(N'2024-05-04T21:11:44.820' AS DateTime))
INSERT [dbo].[VENTA] ([IdVenta], [IdUsuario], [TipoDocumento], [NumeroDocumento], [MontoPago], [MontoCambio], [MontoTotal], [FechaRegistro]) VALUES (9, 1, N'Boleta', N'00009', CAST(20.00 AS Decimal(10, 2)), CAST(5.00 AS Decimal(10, 2)), CAST(15.00 AS Decimal(10, 2)), CAST(N'2024-05-04T21:15:14.893' AS DateTime))
INSERT [dbo].[VENTA] ([IdVenta], [IdUsuario], [TipoDocumento], [NumeroDocumento], [MontoPago], [MontoCambio], [MontoTotal], [FechaRegistro]) VALUES (10, 1, N'Factura', N'00010', CAST(120.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(120.00 AS Decimal(10, 2)), CAST(N'2024-05-04T21:16:56.817' AS DateTime))
INSERT [dbo].[VENTA] ([IdVenta], [IdUsuario], [TipoDocumento], [NumeroDocumento], [MontoPago], [MontoCambio], [MontoTotal], [FechaRegistro]) VALUES (11, 1, N'Factura', N'00011', CAST(60.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(60.00 AS Decimal(10, 2)), CAST(N'2024-05-04T21:27:01.830' AS DateTime))
INSERT [dbo].[VENTA] ([IdVenta], [IdUsuario], [TipoDocumento], [NumeroDocumento], [MontoPago], [MontoCambio], [MontoTotal], [FechaRegistro]) VALUES (12, 1, N'Boleta', N'00012', CAST(100.00 AS Decimal(10, 2)), CAST(40.00 AS Decimal(10, 2)), CAST(60.00 AS Decimal(10, 2)), CAST(N'2024-05-04T21:39:09.233' AS DateTime))
SET IDENTITY_INSERT [dbo].[VENTA] OFF
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
ALTER TABLE [dbo].[TIPO_MOVIMIENTO] ADD  CONSTRAINT [DF_TIPO_MOVIMIENTO_Activo]  DEFAULT ((1)) FOR [Activo]
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
ALTER TABLE [dbo].[DEVOLUCION]  WITH CHECK ADD  CONSTRAINT [FK_DEVOLUCION_PRODUCTO] FOREIGN KEY([IdProducto])
REFERENCES [dbo].[PRODUCTO] ([IdProducto])
GO
ALTER TABLE [dbo].[DEVOLUCION] CHECK CONSTRAINT [FK_DEVOLUCION_PRODUCTO]
GO
ALTER TABLE [dbo].[DEVOLUCION]  WITH CHECK ADD  CONSTRAINT [FK_DEVOLUCION_VENTA] FOREIGN KEY([IdVenta])
REFERENCES [dbo].[VENTA] ([IdVenta])
GO
ALTER TABLE [dbo].[DEVOLUCION] CHECK CONSTRAINT [FK_DEVOLUCION_VENTA]
GO
ALTER TABLE [dbo].[FACTURA]  WITH CHECK ADD  CONSTRAINT [FK_FACTURA_USUARIO] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[USUARIO] ([IdUsuario])
GO
ALTER TABLE [dbo].[FACTURA] CHECK CONSTRAINT [FK_FACTURA_USUARIO]
GO
ALTER TABLE [dbo].[FACTURA]  WITH CHECK ADD  CONSTRAINT [FK_FACTURA_VENTA] FOREIGN KEY([IdVenta])
REFERENCES [dbo].[VENTA] ([IdVenta])
GO
ALTER TABLE [dbo].[FACTURA] CHECK CONSTRAINT [FK_FACTURA_VENTA]
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
/****** Object:  StoredProcedure [dbo].[SP_EditarCategoria]    Script Date: 04/05/2024 10:31:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*PROCEDIMIENTO PARA MODIFICAR CATEGORÍA*/
CREATE PROCEDURE [dbo].[SP_EditarCategoria](
@IdCategoria int,
@Descripcion varchar(50),
@Estado bit,
@Resultado bit output,
@Mensaje varchar (500) output
) AS
BEGIN 
	SET @Resultado = 1

	IF NOT EXISTS (SELECT * FROM CATEGORIA WHERE Descripcion = @Descripcion AND IdCategoria != @IdCategoria)
	BEGIN
		UPDATE CATEGORIA 
		SET Descripcion = @Descripcion,
			Estado = @Estado
		WHERE IdCategoria = @IdCategoria
	END
	ELSE
	BEGIN
		SET @Resultado = 0
		SET @Mensaje = 'No se puede repetir la descripción de una categoría'
	END

	IF @Resultado = 1
	BEGIN
		INSERT INTO HISTORIAL (IdMovimiento, FechaMovimiento)
		VALUES (2, GETDATE())
	END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_EDITARCLAVE]    Script Date: 04/05/2024 10:31:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_EDITARCLAVE](
@IdUsuario int,
@Documento varchar(50),
@Clave varchar(100),
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
		Clave = @Clave
		where IdUsuario = @IdUsuario

		set @Respuesta = 1	
	end
	else
		set @Mensaje = 'No se encuentra al usuario con este folio'
end
GO
/****** Object:  StoredProcedure [dbo].[SP_EditarProducto]    Script Date: 04/05/2024 10:31:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*PROCEDIMIENTO PARA EDITAR PRODUCTO*/
CREATE PROC [dbo].[SP_EditarProducto](
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

	IF @Resultado = 1
	BEGIN
		INSERT INTO HISTORIAL (IdMovimiento, FechaMovimiento)
		VALUES (5, GETDATE())
	END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_EditarProveedor]    Script Date: 04/05/2024 10:31:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_EditarProveedor](
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
	IF @Resultado = 1
	BEGIN
		INSERT INTO HISTORIAL (IdMovimiento, FechaMovimiento)
		VALUES (8, GETDATE())
	END
end

GO
/****** Object:  StoredProcedure [dbo].[SP_EDITARUSUARIO]    Script Date: 04/05/2024 10:31:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_EDITARUSUARIO](
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

	IF @Respuesta = 1
	BEGIN
		INSERT INTO HISTORIAL (IdMovimiento, FechaMovimiento)
		VALUES (11, GETDATE())
	END
end
GO
/****** Object:  StoredProcedure [dbo].[SP_EliminarCategoria]    Script Date: 04/05/2024 10:31:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*PROCEDIMIENTO PARA ELIMINAR CATEGORÍA*/
CREATE PROCEDURE [dbo].[SP_EliminarCategoria](
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

	IF @Resultado = 1
	BEGIN
		INSERT INTO HISTORIAL (IdMovimiento, FechaMovimiento)
		VALUES (3, GETDATE())
	END

END
GO
/****** Object:  StoredProcedure [dbo].[SP_EliminarProducto]    Script Date: 04/05/2024 10:31:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_EliminarProducto](
@IdProducto int,
@Resultado  bit output,
@Mensaje varchar (500) output
) AS
BEGIN 
	SET @Resultado = 0
	SET @Mensaje = ' '
	DECLARE @PasoReglas bit = 1

	IF EXISTS (SELECT * FROM DETALLE_COMPRA WHERE IdProducto = @IdProducto)
	BEGIN
		SET @PasoReglas = 0
		SET @Resultado = 0
		SET @Mensaje = @Mensaje + 'No se puede eliminar porque se encuentra relacionado a una COMPRA\n'
	END

	IF EXISTS (SELECT * FROM DETALLE_VENTA WHERE IdProducto = @IdProducto)
	BEGIN
		SET @PasoReglas = 0
		SET @Resultado = 0
		SET @Mensaje = @Mensaje + 'No se puede eliminar porque se encuentra relacionado a una VENTA\n'
	END

	IF (@PasoReglas = 1)
	BEGIN
		DELETE FROM PRODUCTO WHERE IdProducto = @IdProducto
		SET @Resultado = 1
	END

	IF @Resultado = 1
	BEGIN
		INSERT INTO HISTORIAL (IdMovimiento, FechaMovimiento)
		VALUES (6, GETDATE())
	END
END

/****** Object:  StoredProcedure [dbo].[sp_EliminarProveedor]    Script Date: 02/06/2023 06:12:47 p. m. ******/
SET ANSI_NULLS ON
GO
/****** Object:  StoredProcedure [dbo].[sp_EliminarProveedor]    Script Date: 04/05/2024 10:31:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_EliminarProveedor](
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
	
	IF @Resultado = 1
	BEGIN
		INSERT INTO HISTORIAL (IdMovimiento, FechaMovimiento)
		VALUES (9, GETDATE())
	END
end
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINARUSUARIO]    Script Date: 04/05/2024 10:31:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SP_ELIMINARUSUARIO](
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

	IF @Respuesta = 1
	BEGIN
		INSERT INTO HISTORIAL (IdMovimiento, FechaMovimiento)
		VALUES (12, GETDATE())
	END
end
GO
/****** Object:  StoredProcedure [dbo].[SP_RegistrarCategoria]    Script Date: 04/05/2024 10:31:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* ----- PROCEDIMIENTO PARA CATEGORÍA -----*/

/*PROCEDIMIENTO PARA GUARDAR CATEGORÍA*/
CREATE PROCEDURE [dbo].[SP_RegistrarCategoria](
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

	IF @Resultado = 1
	BEGIN
		INSERT INTO HISTORIAL (IdMovimiento, FechaMovimiento)
		VALUES (1, GETDATE())
	END
END

GO
/****** Object:  StoredProcedure [dbo].[sp_RegistrarCompra]    Script Date: 04/05/2024 10:31:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_RegistrarCompra](
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

	IF @Resultado = 1
	BEGIN
		INSERT INTO HISTORIAL (IdUsuario, IdMovimiento, FechaMovimiento)
		VALUES (@IdUsuario,13, GETDATE())
	END
end

GO
/****** Object:  StoredProcedure [dbo].[sp_RegistrarFactura]    Script Date: 04/05/2024 10:31:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_RegistrarFactura](
@IdUsuario int,
@IdVenta int,
@NombreCliente varchar(50),
@PrimerApellido varchar(50),
@SegundoApellido varchar(50),
@Calle varchar(100),
@NumExt int,
@NumInt int,
@Colonia varchar(50),
@Municipio varchar(50),
@Pais varchar(50),
@CP varchar(5),
@RFC varchar(12),
@Correo varchar(80),
@Telefono varchar(10),
@RazonSocial varchar(50),
@UsoCFDI varchar(50),
@Fecha datetime,
@Resultado bit output,
@Mensaje varchar(500) output
)
AS 
BEGIN	
	SET @Resultado = 0
	INSERT INTO FACTURA(IdUsuario,IdVenta,NombreCliente,PrimerApellido,SegundoApellido,Calle,NumExt,NumInt,Colonia,Municipio,Pais,CP,RFC,Correo,Telefono,RazonSocial,UsoCFDI,Fecha) values
	(@IdUsuario,@IdVenta,@NombreCliente,@PrimerApellido,@SegundoApellido,@Calle,@NumExt,@NumInt,@Colonia,@Municipio,@Pais,@CP,@RFC,@Correo,@Telefono,@RazonSocial,@UsoCFDI,@Fecha)
	SET @Resultado = SCOPE_IDENTITY()

	IF @Resultado != 0
	BEGIN
		INSERT INTO HISTORIAL (IdUsuario, IdMovimiento, FechaMovimiento)
		VALUES (@IdUsuario,10, GETDATE())
	END
END
GO

/****** Object:  StoredProcedure [dbo].[sp_RegistrarFactura]    Script Date: 04/05/2024 10:31:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ConsultarFactura](
@idventa int
)
AS
BEGIN
	SELECT * FROM FACTURA F
	INNER JOIN USUARIO u ON u.IdUsuario = F.IdUsuario
	WHERE IdVenta = @idventa

	SELECT * FROM VENTA v
	WHERE IdVenta = @idventa

	SELECT Nombre, p.PrecioVenta, Cantidad, SubTotal FROM DETALLE_VENTA dv
	INNER JOIN PRODUCTO p ON p.IdProducto = dv.IdProducto
	where dv.IdVenta = @idventa
END

/****** Object:  StoredProcedure [dbo].[sp_RegistrarProducto]    Script Date: 04/05/2024 10:31:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*REGISTRAR PRODUCTO*/
CREATE PROCEDURE [dbo].[sp_RegistrarProducto](
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

	IF @Resultado = 1
	BEGIN
		INSERT INTO HISTORIAL (IdMovimiento, FechaMovimiento)
		VALUES (4, GETDATE())
	END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_RegistrarProveedor]    Script Date: 04/05/2024 10:31:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------PROCEDIMIENTOS PARA PROVEEDOR---------------
create PROC [dbo].[sp_RegistrarProveedor](
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
/****** Object:  StoredProcedure [dbo].[SP_REGISTRARUSUARIO]    Script Date: 04/05/2024 10:31:37 p. m. ******/
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

	IF @IdUsuarioResultado = 1
	BEGIN
		INSERT INTO HISTORIAL (IdMovimiento, FechaMovimiento)
		VALUES (10, GETDATE())
	END
end
GO
/****** Object:  StoredProcedure [dbo].[sp_RegistrarVenta]    Script Date: 04/05/2024 10:31:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_RegistrarVenta](
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

	IF @Resultado = 1
	BEGIN
		INSERT INTO HISTORIAL (IdUsuario, IdMovimiento, FechaMovimiento)
		VALUES (@IdUsuario,14, GETDATE())
	END

end
GO
/****** Object:  StoredProcedure [dbo].[sp_ReporteCompras]    Script Date: 04/05/2024 10:31:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_ReporteCompras](
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

GO
/****** Object:  StoredProcedure [dbo].[sp_ReporteVentas]    Script Date: 04/05/2024 10:31:37 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[sp_ReporteVentas](
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

GO
USE [master]
GO
ALTER DATABASE [DBSISTEMA_VENTA] SET  READ_WRITE 
GO
