USE [master]
GO
/****** Object:  Database [FacturacionDb]    Script Date: 12/05/2017 10:32:53 p. m. ******/
CREATE DATABASE [FacturacionDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FacturacionDb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\FacturacionDb.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'FacturacionDb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\FacturacionDb_log.ldf' , SIZE = 2560KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [FacturacionDb] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FacturacionDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FacturacionDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FacturacionDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FacturacionDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FacturacionDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FacturacionDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [FacturacionDb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [FacturacionDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FacturacionDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FacturacionDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FacturacionDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FacturacionDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FacturacionDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FacturacionDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FacturacionDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FacturacionDb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [FacturacionDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FacturacionDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FacturacionDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FacturacionDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FacturacionDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FacturacionDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [FacturacionDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FacturacionDb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [FacturacionDb] SET  MULTI_USER 
GO
ALTER DATABASE [FacturacionDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FacturacionDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FacturacionDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FacturacionDb] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [FacturacionDb] SET DELAYED_DURABILITY = DISABLED 
GO
USE [FacturacionDb]
GO
/****** Object:  UserDefinedFunction [dbo].[f_DescontarProducto]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[f_DescontarProducto]
(
@idProducto varchar(50),
@cantidad decimal(9,2)
)
returns decimal(9,2)
as
begin
	declare @existencia decimal(9,2)
	declare @actual decimal(9,2)
	set @actual = (select p.existencia from dbo.Productos p
	where p.idProducto =@idProducto)
	set @existencia = (@actual -@cantidad)

	return @existencia
end
GO
/****** Object:  Table [dbo].[Categorias]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Categorias](
	[idCategoria] [int] NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[descripcion] [varchar](300) NULL,
	[imagen] [image] NULL,
 CONSTRAINT [PK_Categorias] PRIMARY KEY CLUSTERED 
(
	[idCategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Clientes](
	[nit] [varchar](50) NOT NULL,
	[nombre] [varchar](70) NOT NULL,
	[direccion] [varchar](70) NOT NULL,
	[telefono] [varchar](15) NULL,
	[email] [varchar](50) NULL,
	[creado] [datetime] NULL,
	[modificado] [datetime] NULL,
 CONSTRAINT [PK_Clientes] PRIMARY KEY CLUSTERED 
(
	[nit] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Compras]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Compras](
	[idCompra] [int] NOT NULL,
	[idFactura] [int] NOT NULL,
	[idProveedor] [varchar](50) NOT NULL,
	[total] [decimal](10, 2) NULL,
	[fecha] [datetime] NOT NULL,
	[modificado] [datetime] NULL,
	[usuario] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[idCompra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Detalles]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Detalles](
	[idDetalle] [int] NOT NULL,
	[idFactura] [int] NOT NULL,
	[idProducto] [varchar](50) NOT NULL,
	[cantidad] [decimal](9, 2) NOT NULL,
	[precio] [decimal](9, 2) NOT NULL,
	[descuento] [decimal](2, 2) NULL,
	[subTotal] [decimal](9, 2) NULL,
 CONSTRAINT [PK_Detalles] PRIMARY KEY CLUSTERED 
(
	[idDetalle] ASC,
	[idFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DetallesCompra]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DetallesCompra](
	[idCompra] [int] NOT NULL,
	[idDetalle] [int] NOT NULL,
	[idProducto] [varchar](50) NOT NULL,
	[cantidad] [decimal](10, 2) NOT NULL,
	[precio] [decimal](10, 2) NULL,
	[precioVenta] [decimal](10, 2) NULL,
	[descuento] [decimal](2, 2) NULL,
	[subTotal] [decimal](10, 2) NULL,
	[observaciones] [varchar](200) NULL,
 CONSTRAINT [PK__Detalles__EC253398662E0C22] PRIMARY KEY CLUSTERED 
(
	[idCompra] ASC,
	[idDetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Facturas]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Facturas](
	[idFactura] [int] NOT NULL,
	[nitCliente] [varchar](50) NULL,
	[nombre] [varchar](50) NULL,
	[direccion] [varchar](50) NULL,
	[fecha] [datetime] NOT NULL,
	[subTotal] [decimal](10, 2) NULL,
	[descuento] [decimal](2, 2) NULL,
	[total] [decimal](9, 2) NULL,
	[usuario] [varchar](50) NULL,
 CONSTRAINT [PK_Facturas] PRIMARY KEY CLUSTERED 
(
	[idFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Productos](
	[idProducto] [varchar](50) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[precioCompra] [decimal](10, 2) NULL,
	[precio] [decimal](9, 2) NOT NULL,
	[descuentoVenta] [decimal](2, 2) NULL,
	[existencia] [decimal](9, 2) NULL,
	[observacion] [varchar](200) NULL,
	[idCategoria] [int] NULL,
	[imagen] [image] NULL,
	[creado] [datetime] NULL,
	[modificado] [datetime] NULL,
 CONSTRAINT [PK_Productos] PRIMARY KEY CLUSTERED 
(
	[idProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Proveedores]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Proveedores](
	[idProveedor] [varchar](50) NOT NULL,
	[empresa] [varchar](50) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[direccion] [varchar](50) NOT NULL,
	[telefono] [varchar](15) NOT NULL,
	[email] [varchar](50) NULL,
	[creado] [datetime] NULL,
	[modificado] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idProveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuarios](
	[email] [varchar](50) NOT NULL,
	[pass] [varchar](150) NOT NULL,
	[nombre] [varchar](75) NOT NULL,
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Compras]  WITH CHECK ADD FOREIGN KEY([idProveedor])
REFERENCES [dbo].[Proveedores] ([idProveedor])
GO
ALTER TABLE [dbo].[Detalles]  WITH CHECK ADD  CONSTRAINT [FK_Detalles_Facturas] FOREIGN KEY([idFactura])
REFERENCES [dbo].[Facturas] ([idFactura])
GO
ALTER TABLE [dbo].[Detalles] CHECK CONSTRAINT [FK_Detalles_Facturas]
GO
ALTER TABLE [dbo].[Detalles]  WITH CHECK ADD  CONSTRAINT [FK_Detalles_Productos] FOREIGN KEY([idProducto])
REFERENCES [dbo].[Productos] ([idProducto])
GO
ALTER TABLE [dbo].[Detalles] CHECK CONSTRAINT [FK_Detalles_Productos]
GO
ALTER TABLE [dbo].[DetallesCompra]  WITH CHECK ADD  CONSTRAINT [FK_DetallesCompra_Compras] FOREIGN KEY([idCompra])
REFERENCES [dbo].[Compras] ([idCompra])
GO
ALTER TABLE [dbo].[DetallesCompra] CHECK CONSTRAINT [FK_DetallesCompra_Compras]
GO
ALTER TABLE [dbo].[DetallesCompra]  WITH CHECK ADD  CONSTRAINT [FK_DetallesCompra_Productos] FOREIGN KEY([idProducto])
REFERENCES [dbo].[Productos] ([idProducto])
GO
ALTER TABLE [dbo].[DetallesCompra] CHECK CONSTRAINT [FK_DetallesCompra_Productos]
GO
ALTER TABLE [dbo].[Facturas]  WITH CHECK ADD  CONSTRAINT [FK_Facturas_Clientes] FOREIGN KEY([nitCliente])
REFERENCES [dbo].[Clientes] ([nit])
GO
ALTER TABLE [dbo].[Facturas] CHECK CONSTRAINT [FK_Facturas_Clientes]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [FK_Productos_Categorias] FOREIGN KEY([idCategoria])
REFERENCES [dbo].[Categorias] ([idCategoria])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [FK_Productos_Categorias]
GO
/****** Object:  StoredProcedure [dbo].[sp_ActualizarCliente]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_ActualizarCliente](@nit varchar(50), @nombre varchar(50), @direccion varchar(70), @telefono varchar(15))
as
begin
	begin try
	if (@nit is null) or (@nombre is null) or (@direccion is null) or (@telefono is null)
	return 0;
	else
	UPDATE dbo.Clientes SET
	nombre =@nombre,
	direccion =@direccion,
	telefono =@telefono
	WHERE nit =@nit
	
	return 1;
	end try
	begin catch
	return 0;
	end catch
	
	
end
GO
/****** Object:  StoredProcedure [dbo].[sp_ActualizarDetalle]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_ActualizarDetalle](
@idDetalle int,
@idFactura int,
@idProducto varchar(50),
@precio decimal(9,2),
@subTotal decimal (9,2),
@cantidad decimal(9,2)
)
as
begin
	begin try
		return 1;
		if(@idDetalle is null) or (@idFactura is null) or (@idProducto is null) or (@precio is null) or(@subTotal is null)
			return 0;
		else
			select cast (@idDetalle as int)
			select cast (@idFactura as int)
			select cast (@precio as decimal (9,2))
			select cast (@subTotal as decimal (9,2))
			select cast (@cantidad as decimal (9,2))

			update dbo.Detalles set
			cantidad =@cantidad,
			subTotal=@subTotal
			where idDetalle=@idDetalle and idFactura=@idFactura and idProducto=@idProducto
			
	end try
	begin catch
		return 0;
	end catch
end

GO
/****** Object:  StoredProcedure [dbo].[sp_ActualizarFactura]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_ActualizarFactura](
@idFactura int,
@total decimal(9,2)
)
as
begin
begin try
	if(@idFactura is null) or (@total is null)
		return 0;
	else
		select cast(@idFactura as int)
		select cast(@total as decimal(9,2))
		UPDATE DBO.Facturas SET
		total =@total
		where idFactura= @idFactura
		return 1;
end try
begin catch
	return 0;
end catch
end
GO
/****** Object:  StoredProcedure [dbo].[sp_ActualizarProducto]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_ActualizarProducto](
@idProducto varchar(50),
@nombre varchar(50),
@precio decimal(9,2),
@existencia decimal(9,2),
@observaciones varchar(200),
@imagen image
)
as
begin
	begin try
		if(@idProducto is null) or (@nombre is null) or (@precio is null) or(@existencia is null)
			return 0;
		else
			select cast(@precio as decimal(9,2))
			select cast(@existencia as decimal(9,2))
			UPDATE dbo.Productos SET
			nombre = @nombre,
			precio =@precio,
			existencia =@existencia,
			observacion =@observaciones,
			imagen =@imagen
			where idProducto= @idProducto
	end try
	begin catch
		return 0;
	end catch
end
GO
/****** Object:  StoredProcedure [dbo].[sp_ActualizarUsuario]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_ActualizarUsuario](
@email varchar(50),
@pass varchar(150),
@nombre varchar(75) 
)
as
begin
	begin try
		if(@email is null) or (@pass is null) or( @nombre is null) 
		return 0
		else
		update  dbo.Usuarios set 
		pass=@pass, 
		nombre=@nombre
		where email = @email
		return 1
	end try
	begin catch
	return 0;
	end catch
end

GO
/****** Object:  StoredProcedure [dbo].[sp_BuscarClienteNit]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_BuscarClienteNit](@nit varchar(50))
as
begin
	select c.nit, c.nombre, c.direccion, c.telefono 
	FROM Clientes c
	where nit =@nit
end
GO
/****** Object:  StoredProcedure [dbo].[sp_BuscarClienteNombre]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_BuscarClienteNombre](@nombre varchar(50))
as
begin
	select c.nit, c.nombre, c.direccion, c.telefono 
	FROM Clientes c
	where nombre =@nombre
end

GO
/****** Object:  StoredProcedure [dbo].[sp_BuscarFacturaId]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_BuscarFacturaId](
@idFactura int
)
as
begin
	select* from dbo.Facturas
	where idFactura=@idFactura
end
GO
/****** Object:  StoredProcedure [dbo].[sp_BuscarFacturanit]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_BuscarFacturanit](
@nitCliente varchar(50)
)
as
begin
	select* from dbo.Facturas
	where nitCliente=@nitCliente
end
GO
/****** Object:  StoredProcedure [dbo].[sp_BuscarProductoId]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_BuscarProductoId](
@idProducto varchar(50)

)
as
begin
	 select* from dbo.Productos
	 where idProducto=@idProducto		
end
GO
/****** Object:  StoredProcedure [dbo].[sp_BuscarUsuario]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_BuscarUsuario](@email varchar(50))
as
begin
	select *  from dbo.Usuarios
	where email=@email;
	
end;


GO
/****** Object:  StoredProcedure [dbo].[sp_CrearCliente]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_CrearCliente](@nit varchar(50), @nombre varchar(50), @direccion varchar(70), @telefono varchar(15))
as
begin
	begin try
	if (@nit is null) or (@nombre is null) or (@direccion is null) or (@telefono is null)
	return 0;
	else
	INSERT INTO dbo.Clientes(nit, nombre, direccion, telefono)
	VALUES (@nit, @nombre, @direccion, @telefono)
	return 1;
	end try
	begin catch
	return 0;
	end catch
	
	
end
GO
/****** Object:  StoredProcedure [dbo].[sp_CrearDetalle]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_CrearDetalle](
@idDetalle int,
@idFactura int,
@idProducto varchar(50),
@precio decimal(9,2),
@subTotal decimal (9,2),
@cantidad decimal(9,2)
)
as
begin
	begin try
		return 1;
		if(@idDetalle is null) or (@idFactura is null) or (@idProducto is null) or (@precio is null) or(@subTotal is null)
			return 0;
		else
			select cast (@idDetalle as int)
			select cast (@idFactura as int)
			select cast (@precio as decimal (9,2))
			select cast (@subTotal as decimal (9,2))
			select cast (@cantidad as decimal (9,2))

			INSERT INTO dbo.Detalles(idDetalle, idFactura, idProducto, cantidad, precio, subTotal)
			VALUES (@idDetalle, @idFactura, @idProducto, @cantidad, @precio, @subTotal)
			return 1;
	end try
	begin catch
		return 0;
	end catch
end

GO
/****** Object:  StoredProcedure [dbo].[sp_CrearFactura]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_CrearFactura](
@idFactura int,
@nitCliente varchar(50),
@fecha datetime,
@total decimal(9,2),
@usuario varchar(50)
)
as
begin
begin try
	if(@idFactura is null) or (@nitCliente is null) or (@fecha is null)
		return 0;
	else
		select cast(@idFactura as int)
		select cast(@fecha as datetime)
		select cast(@total as decimal(9,2))
		INSERT INTO DBO.Facturas(idFactura, nitCliente, fecha, total, usuario)
		VALUES (@idFactura, @nitCliente, @fecha, @total, @usuario)
		return 1;
end try
begin catch
	return 0;
end catch
end
GO
/****** Object:  StoredProcedure [dbo].[sp_CrearProducto]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_CrearProducto](
@idProducto varchar(50),
@nombre varchar(50),
@precio decimal(9,2),
@existencia decimal(9,2),
@observaciones varchar(200),
@imagen image
)
as
begin
	begin try
		if(@idProducto is null) or (@nombre is null) or (@precio is null) or(@existencia is null)
			return 0;
		else
			select cast(@precio as decimal(9,2))
			select cast(@existencia as decimal(9,2))
			INSERT INTO dbo.Productos(idProducto, nombre, precio, existencia, observacion, imagen)
			VALUES (@idProducto, @nombre, @precio, @existencia, @observaciones, @imagen)
			return 1;
	end try
	begin catch
		return 0;
	end catch
end
GO
/****** Object:  StoredProcedure [dbo].[sp_CrearUsuario]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_CrearUsuario](
@email varchar(50),
@pass varchar(150),
@nombre varchar(75) 
)
as
begin
	begin try
		if(@email is null) or (@pass is null) or( @nombre is null) 
		return 0
		else
		insert into Usuarios(email, pass, nombre)
		values (@email, @pass, @nombre)
		return 1
	end try
	begin catch
	return 0;
	end catch
end

GO
/****** Object:  StoredProcedure [dbo].[sp_DetalleFacturaId]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_DetalleFacturaId](
@idFactura int
)
as
begin
	select f.idFactura, f.nitCliente, f.fecha, d.idDetalle, d.idProducto, p.nombre, d.precio, d.subTotal, f.total, f.usuario
	from Facturas f, Detalles d, Productos p
	where f.idFactura =@idFactura and f.idFactura=d.idFactura and d.idProducto=p.idProducto
end
GO
/****** Object:  StoredProcedure [dbo].[sp_EliminarCliente]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_EliminarCliente](@nit varchar(50))
as
begin
	begin try
	if (@nit is null)
	return 0;
	else
	DELETE FROM dbo.Clientes 
	WHERE nit =@nit
	return 1;
	end try
	begin catch
	return 0;
	end catch
	
end
GO
/****** Object:  StoredProcedure [dbo].[sp_EliminarDetalles]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_EliminarDetalles](@idDetalle int, @idFactura int)
as
begin
	delete from dbo.Detalles
	where idDetalle= @idDetalle and idFactura= @idFactura
end

GO
/****** Object:  StoredProcedure [dbo].[sp_EliminarFactura]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_EliminarFactura](
@idFactura int
)
as
begin
begin try
	if(@idFactura is null) 
		return 0;
	else
		select cast(@idFactura as int)
		delete from DBO.Facturas 
		where idFactura= @idFactura
		return 1;
end try
begin catch
	return 0;
end catch
end
GO
/****** Object:  StoredProcedure [dbo].[sp_EliminarProducto]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_EliminarProducto](
@idProducto varchar(50)

)
as
begin

		if(@idProducto is null) 
			return 0;
		else
		delete from dbo.Productos where idProducto =@idProducto
			
end
GO
/****** Object:  StoredProcedure [dbo].[sp_EliminarUsuario]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_EliminarUsuario](@email varchar(50))
as
begin
  begin try
  if (@email is null)
  return 0;
  else
  DELETE FROM Usuarios 
  where email = @email
  return 1;
  end try
  begin catch
  return 0;
  end catch
end
GO
/****** Object:  StoredProcedure [dbo].[sp_ListarClientes]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_ListarClientes]
as
begin
	select * from Clientes
end
GO
/****** Object:  StoredProcedure [dbo].[sp_ListarDetalles]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_ListarDetalles]
as
begin

			select * from dbo.Detalles

			

end

GO
/****** Object:  StoredProcedure [dbo].[sp_ListarDetallesId]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_ListarDetallesId](
@idDetalle int,
@idFactura int
)
as
begin
	
			select cast (@idDetalle as int)
			select cast (@idFactura as int)
			select * from dbo.Detalles
			where idDetalle=@idDetalle and idFactura=@idFactura
			

end

GO
/****** Object:  StoredProcedure [dbo].[sp_ListarProductos]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_ListarProductos]
as
begin
	 select* from dbo.Productos
		
end
GO
/****** Object:  StoredProcedure [dbo].[sp_ListarUsuarios]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_ListarUsuarios]
as
begin
	select * from dbo.Usuarios;
	
end;
GO
/****** Object:  StoredProcedure [dbo].[sp_LoginUsuario]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_LoginUsuario](
@email varchar(50),
@pass varchar(150)
)
as
begin
	declare @logeado int;

	select @logeado =COUNT(u.nombre) from dbo.Usuarios u
	where email =@email and pass = @pass

	
end
GO
/****** Object:  StoredProcedure [dbo].[sp_ObtenerIdFactura]    Script Date: 12/05/2017 10:32:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_ObtenerIdFactura]
as
begin
select max(idFactura)
from Facturas
end
GO
USE [master]
GO
ALTER DATABASE [FacturacionDb] SET  READ_WRITE 
GO
