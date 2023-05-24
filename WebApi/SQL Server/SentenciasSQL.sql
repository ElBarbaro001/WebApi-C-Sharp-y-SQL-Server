USE [master]
GO
/****** Object:  Database [Gestion]    Script Date: 22/05/2023 23:19:23 ******/
CREATE DATABASE [Gestion]
GO
USE [Gestion]
GO
/****** Object:  Table [dbo].[TBClientes]    Script Date: 22/05/2023 23:18:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBClientes](
	[codigo] [int] IDENTITY(1,1) NOT NULL,
	[tp_documento] [char](3) NOT NULL,
	[documento] [int] NOT NULL,
	[nombres] [varchar](30) NOT NULL,
	[primer_apellido] [varchar](30) NOT NULL,
	[segundo_apellido] [varchar](30) NOT NULL,
	[genero] [char](1) NOT NULL,
	[fecha_nacimiento] [date] NOT NULL,
	[dir_casa] [varchar](100) NOT NULL,
	[dir_trabajo] [varchar](100) NOT NULL,
	[tfno_casa] [varchar](20) NOT NULL,
	[tfno_trabajo] [varchar](20) NOT NULL,
	[email] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TBClientes] PRIMARY KEY CLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
use Gestion
go
---********************************* Validar si Existe el Procedimiento Almacenado ******************************---
if exists (select * from sys.objects where type = 'P' and name = 'reg_cliente')
drop procedure reg_cliente
go
create procedure reg_cliente(
	@tp_documento char(3),
	@documento int,
	@nombres varchar(30),
	@primer_apellido varchar(30),
	@segundo_apellido varchar(30),
	@genero char(1),
	@fecha_nacimiento date,
	@dir_casa varchar(100),
	@dir_trabajo varchar(100),
	@tfno_casa varchar(20),
	@tfno_trabajo varchar(20),
	@email varchar(50)
)
as 
begin
insert into Gestion.dbo.TBClientes(tp_documento,documento,nombres,primer_apellido,segundo_apellido,genero,fecha_nacimiento,dir_casa,dir_trabajo,tfno_casa,tfno_trabajo,email)
values(
	@tp_documento,
	@documento,
	@nombres,
	@primer_apellido,
	@segundo_apellido,
	@genero,
	@fecha_nacimiento,
	@dir_casa,
	@dir_trabajo,
	@tfno_casa,
	@tfno_trabajo,
	@email
)
end
go
if exists (select * from sys.objects where type = 'P' and name = 'sp_listar_clientes')
drop procedure sp_listar_clientes
go
create procedure sp_listar_clientes
as 
begin
select
	*
from
	Gestion.dbo.TBClientes
end
go

---************************* Ejecutar Procedimiento Almacenado ***************************************----
exec reg_cliente 'RC','232','Lucho','Diaz','Presly','M','1979-07-04','Medellin','Medellin','0000000000','0000000000000','tem@gil.com';
exec reg_cliente 'CC','12322','Real','Falcao','Presly','M','1989-05-30','Medellin','Medellin','0000000000','0000000000000','tem@gil.com';
exec reg_cliente 'RC','12123','Leb','JJ','Jordan','M','2000-12-31','Medellin','Medellin','0000000000','0000000000000','tem@gil.com';
exec reg_cliente 'TI','312113','Kobe','Jordan','Presly','M','1950-10-01','Medellin','Medellin','0000000000','0000000000000','tem@gil.com';
----******************-------------------------
exec sp_listar_clientes;
---************************************************-------------

select
	*
from
	Gestion.dbo.TBClientes
order by documento desc

go
--------******************************** Procedimiento para Eliminar un Cliente mediante su Documento de Identidad --------*******************************
if exists (select * from sys.objects where type = 'P' and name = 'sp_eliminar_cliente')
drop procedure sp_eliminar_cliente
go
create procedure sp_eliminar_cliente(
@documento int
)
as
begin
delete from 
	Gestion.dbo.TBClientes
where 
	dbo.TBClientes.documento = @documento
end
go
exec sp_eliminar_cliente '123';
go
-------------------- ************************** Procedimiento para Modificar los Datos de un Cliente ---------------- ********************************
if exists (select * from sys.objects where type = 'P' and name = 'sp_modificar_cliente')
drop procedure sp_modificar_cliente
go
create procedure sp_modificar_cliente(
	@codigo int,
	@tp_documento char(3),
	@documento int,
	@fecha_nacimiento date
)
as
begin
update Gestion.dbo.TBClientes set 
tp_documento = @tp_documento,
documento = @documento,
fecha_nacimiento = @fecha_nacimiento
where codigo = @codigo
end
go
exec sp_modificar_cliente 655,'RC','123','2000-01-01';
go
select 
	*
	from Gestion.dbo.TBClientes
------------------ ******************** Filtros Consultar Cliente por Nombre Completo -------------- **************************

------------------------------***************Buscar Clientes ********************-
if exists (select * from sys.objects where type = 'P' and name = 'sp_buscar_cliente')
drop procedure sp_buscar_cliente
go
create procedure sp_buscar_cliente(
@cadena varchar(30)
)
as
begin
select 
	* 
from 
	Gestion.dbo.TBClientes
where 
	Gestion.dbo.TBClientes.nombres like '%'+@cadena+'%' or  
	Gestion.dbo.TBClientes.primer_apellido like '%'+@cadena+'%' or 
	Gestion.dbo.TBClientes.segundo_apellido like '%'+@cadena+'%'
order by nombres ASC
end
go
------------------- *******************   Consultar los clientes por número de documento, 
---------------------------------------   el resultado de la búsqueda debe organizarse de mayor a menor, 
---------------------------------------   mostrando el número de documento y nombre completo del cliente.  *************----------------------

if exists (select * from sys.objects where type = 'P' and name = 'sp_buscar_cliente_documento')
drop procedure sp_buscar_cliente_documento
go
create procedure sp_buscar_cliente_documento(
@documento int
)
as
begin
select 
	tp_documento,
	documento,
	nombres,
	primer_apellido,
	segundo_apellido
from 
	Gestion.dbo.TBClientes
where 
	Gestion.dbo.TBClientes.documento = @documento
order by documento desc
end
go

-------------------********************* Consultar los clientes por fecha de nacimiento, 
---------------------------------------- de acuerdo a la elección de un rango de fechas, es decir debe permitir elegir una fecha inicial y final de consulta,  
----------------------------------------- el resultado debe permitir visualizar los clientes de acuerdo a la fecha de nacimiento más antigua a la más reciente , seguida del nombre completo del cliente.

if exists (select * from sys.objects where type = 'P' and name = 'sp_buscar_cliente_fecnato')
drop procedure sp_buscar_cliente_fecnato
go
create procedure sp_buscar_cliente_fecnato(
	@fechainicial date,
	@fechafinal date
)
as
begin
select 
	fecha_nacimiento,
	nombres,
	primer_apellido,
	segundo_apellido
from 
	Gestion.dbo.TBClientes
where 
	Gestion.dbo.TBClientes.fecha_nacimiento between  @fechainicial  and @fechafinal
order by fecha_nacimiento asc
end
go
exec sp_buscar_cliente_fecnato '1980-01-01 00:00:00','2000-01-01 00:00:00'
-------------------- ****************** Consultar los clientes que tienen más de un teléfono, 
-------------el resultado de la búsqueda debe retornar el nombre completo del cliente y la cantidad de números registrados en base de datos.
select 
	*
from
	Gestion.dbo.TBClientes
where 
	dbo.TBClientes.tfno_casa <> null and
	dbo.TBClientes.tfno_trabajo <> null;
exec reg_cliente 'TI','312113','Kobe','Jordan','Presly','M','1950-10-01','Medellin','Medellin',null,'0000000000000','tem@gil.com';