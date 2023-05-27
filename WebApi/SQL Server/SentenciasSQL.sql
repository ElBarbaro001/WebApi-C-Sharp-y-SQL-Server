USE [master]
GO
/****** Object:  Database [Cooperativa]    Script Date: 22/05/2023 23:19:23 ******/
CREATE DATABASE [Cooperativa]
GO
USE [Cooperativa]
GO
/****** Object:  Table [dbo].[DBCFAClientes]    Script Date: 22/05/2023 23:18:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DBCFAClientes](
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
 CONSTRAINT [PK_DBCFAClientes] PRIMARY KEY CLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
use Cooperativa
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
insert into Cooperativa.dbo.DBCFAClientes(tp_documento,documento,nombres,primer_apellido,segundo_apellido,genero,fecha_nacimiento,dir_casa,dir_trabajo,tfno_casa,tfno_trabajo,email)
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
	Cooperativa.dbo.DBCFAClientes
end
go

---************************* Ejecutar Procedimiento Almacenado ***************************************----
exec reg_cliente 'RC','1076816962','Real','Mosquera','Moreno','M','1986-09-04','El Salvador Medellin','El Salvador Medellin','0000000000','0000000000000','casystem0@gmail.com';
exec reg_cliente 'TI','1076816965','Ivan','Diaz','Hurtado','M','1986-09-04','El Salvador Medellin','El Salvador Medellin','0000000000','0000000000000','casystem0@gmail.com';
exec reg_cliente 'CC','1076816967','Andres','Perez','Escobar','M','1986-09-04','El Salvador Medellin','El Salvador Medellin','0000000000','0000000000000','casystem0@gmail.com';
exec reg_cliente 'CC','2076816967','Mayor','Perez','Escobar','M','1986-09-04','El Salvador Medellin','El Salvador Medellin','0000000000','0000000000000','casystem0@gmail.com';
exec reg_cliente 'RC','976816967','Mediano','Perez','Escobar','M','1986-09-04','El Salvador Medellin','El Salvador Medellin','0000000000','0000000000000','casystem0@gmail.com';
exec reg_cliente 'TI','376816967','Menor','Perez','Escobar','M','1986-09-04','El Salvador Medellin','El Salvador Medellin','0000000000','0000000000000','casystem0@gmail.com';
----******************-------------------------
exec sp_listar_clientes;
---************************************************-------------

select
	*
from
	Cooperativa.dbo.DBCFAClientes
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
	Cooperativa.dbo.DBCFAClientes
where 
	dbo.DBCFAClientes.documento = @documento
end
go
exec sp_eliminar_cliente '1076816963';
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
update Cooperativa.dbo.DBCFAClientes set 
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
	from Cooperativa.dbo.DBCFAClientes
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
	Cooperativa.dbo.DBCFAClientes
where 
	Cooperativa.dbo.DBCFAClientes.nombres like '%'+@cadena+'%' or  
	Cooperativa.dbo.DBCFAClientes.primer_apellido like '%'+@cadena+'%' or 
	Cooperativa.dbo.DBCFAClientes.segundo_apellido like '%'+@cadena+'%'
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
	Cooperativa.dbo.DBCFAClientes
where 
	Cooperativa.dbo.DBCFAClientes.documento = @documento
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
	Cooperativa.dbo.DBCFAClientes
where 
	Cooperativa.dbo.DBCFAClientes.fecha_nacimiento between  @fechainicial  and @fechafinal
order by fecha_nacimiento asc
end
go
exec sp_buscar_cliente_fecnato '1980-01-01 00:00:00','2000-01-01 00:00:00'
-------------------- ****************** Consultar los clientes que tienen más de un teléfono, 
-------------el resultado de la búsqueda debe retornar el nombre completo del cliente y la cantidad de números registrados en base de datos.
select 
	*
from
	Cooperativa.dbo.DBCFAClientes
where 
	dbo.DBCFAClientes.tfno_casa <> null and
	dbo.DBCFAClientes.tfno_trabajo <> null;
exec reg_cliente 'TI','376816968','Menor','Perez','Rodriguez','M','1980-11-11','Medellin','Medellin','0000000000','0000000000000','ca@gmail.com';

go

if exists (select * from sys.objects where type = 'P' and name = 'sp_leer_documentos')
drop procedure sp_leer_documentos
go
create procedure sp_leer_documentos
as 
begin
select
	c.documento
from 
	Cooperativa.dbo.DBCFAClientes c
where c.documento = '376816967'
end
go

create index documento
on Cooperativa.dbo.DBCFAClientes(documento);
exec reg_cliente 'TI','376816968','Menor','Perez','Rodriguez','M','1980-11-11','Medellin','Medellin','0000000000','0000000000000','ca@gmail.com';
exec sp_listar_clientes
exec sp_eliminar_cliente '376816967'
select * from Cooperativa.dbo.DBCFAClientes
go
if exists (select * from sys.objects where type = 'P' and name = 'sp_listar_clientes')
drop procedure sp_listar_clientes
go
create procedure sp_listar_clientes
as 
begin
select
	c.codigo,
	c.tp_documento,
	c.documento,
	c.nombres,
	c.primer_apellido,
	c.segundo_apellido,
	c.genero,
	c.fecha_nacimiento,
	c.dir_casa,
	c.dir_trabajo,
	c.tfno_casa,
	c.tfno_trabajo,
	c.email
from
	Cooperativa.dbo.DBCFAClientes c
end
exec sp_listar_clientes
exec sp_eliminar_cliente '376816968'
exec reg_cliente 'TI','376816968','Menor','Perez','Rodriguez','M','1980-11-11','Medellin','Medellin','0000000000','0000000000000','ca@gmail.com';


SELECT DATEDIFF(year,'2006-01-01 00:00:00.0000000','2023-04-25') edad;
if exists (select * from sys.objects where type = 'P' and name = 'sp_calcular_edad')
drop procedure sp_calcular_edad
go
create procedure sp_calcular_edad(
	@fechanacimiento varchar(20),
	@fechactual varchar(20)
)
as
begin
SELECT DATEDIFF(year,@fechanacimiento,@fechactual) age;
end

exec sp_calcular_edad '2000-09-04','2023-05-25'
exec sp_listar_clientes

-----------************************** Funcion Calcular edad pasando un solo parametro
if exists (select * from sys.objects where type = 'P' and name = 'sp_calcular_edad')
drop procedure sp_calcular_edad
go
create procedure sp_calcular_edad(
	@fechanacimiento varchar(20)
)
as
begin
SELECT DATEDIFF(year,@fechanacimiento,GETDATE()) age;
end

select DATEDIFF(year,'2000',GETDATE())age;

exec sp_calcular_edad '2000'