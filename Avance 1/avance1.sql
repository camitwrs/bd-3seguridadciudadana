create table Banco(
	codigo varchar(10) not null,
	nombre varchar(50) not null,
	
	constraint pk_banco primary key (codigo)
);


create table Vigilante(
	rut varchar(20) not null,
	edad smallint,
	nombre varchar(50) not null,
	correo varchar(50),
	accesoSistema boolean not null,
	fechaContrato date not null,
	
	constraint pk_vigilante primary key (rut),
	constraint chk_rut check ( rut like '%_-_' ),
	constraint chk_correo check (correo is null or correo like '%_@%_.%_' )
);

create table Sucursal(
	codigo varchar(10) not null,
	gerente varchar(50) not null,
	direccion varchar(100),
	region varchar(100),
	banco varchar(10) not null,
	vigilante varchar(20) not null,
	
	constraint pk_sucursal primary key (codigo),
	constraint fk_sucursal_banco foreign key (banco)
		references Banco(codigo),
	constraint fk_sucursal_vigilante foreign key (vigilante)
		references Vigilante(rut)
);

create table Personal(
	rut varchar(20) not null,
	edad smallint,
	nombre varchar(50) not null,
	correo varchar(50),
	accesoSistema boolean not null,
	sucursal varchar(10) not null,
	
	constraint pk_personal primary key (rut),
	constraint fk_personal_sucursal foreign key (sucursal)
		references Sucursal(codigo),
	constraint chk_rut check ( rut like '%_-_' ),
	constraint chk_correo check (correo is null or correo like '%_@%_.%_' )
);

create table Empleado(
	rut varchar(20) not null,
	edad smallint,
	nombre varchar(50) not null,
	correo varchar(50),
	accesoSistema boolean not null,
	sucursal varchar(10) not null,
	
	constraint pk_empleado primary key (rut),
	constraint fk_empleado_sucursal foreign key (sucursal)
		references Sucursal(codigo),
	constraint chk_rut check ( rut like '%_-_' ),
	constraint chk_correo check (correo is null or correo like '%_@%_.%_' )
);

create table Reporte(
	id_rep smallint not null generated always as identity,
	fecha date,
	descripcion varchar(500),
	hora varchar(10),
	tipoIncidente varchar(50),
	vigilante varchar(20) not null,
	sucursal varchar(10) not null,
	
	constraint pk_reporte primary key (id_rep),
	constraint fk_reporte_vigilante foreign key (vigilante)
		references Vigilante(rut),
	constraint fk_reporte_sucursal foreign key (sucursal)
		references Sucursal(codigo)
);

create table Registro(
	id_reg smallint not null generated always as identity,
	hora varchar(10),
	fecha date,
	tipo varchar(10) not null,
	observaciones varchar(500),
	empleado varchar(20) not null,
	sucursal varchar(10) not null,
	
	constraint pk_registro primary key (id_reg),
	constraint fk_registro_empleado foreign key (empleado)
		references Empleado(rut),
	constraint fk_registro_sucursal foreign key (sucursal)
		references Sucursal(codigo)
);


-- CREACION DE LA TABLA QUE ALMACENA LA INFORMACION TEMPORALMENTE 
CREATE TABLE temporaldata(
	referencia integer PRIMARY KEY, 
	codigo_banco varchar(10) not null,
	nombre_banco varchar(50) not null,
	codigo_sucursal varchar(10) not null,
	direccion_sucursal varchar(100),
	region_sucursal varchar(100),
	nombre_gerente varchar(50) not null, 
	rut_empleado varchar(20) not null,
	nombre_empleado varchar(50) not null, 
	correo_empleado varchar(50),
	edad_empleado smallint,
	acceso_empleado boolean not null,
	rut_vigilante varchar(20) not null,
	nombre_vigilante varchar(50) not null, 
	correo_vigilante varchar(50),
	edad_vigilante smallint,
	acceso_vigilante boolean not null,
	fecha_contrato date not null,
	hora_registro varchar(10),
	fecha_registro date,
	tipo_registro varchar(10) not null,
	observacion_registro varchar(500),
	hora_reporte varchar(10),
	fecha_reporte date,
	incidente varchar(50),
	descripcion_reporte varchar(500)
);


-- COPIAR LA INFORMACIÓN DEL ARCHIVO CSV HACIA LA TABLA TEMPORALDATA
COPY temporaldata 
FROM 'C:\Users\milat\Desktop\bd-sc.csv' 
DELIMITER ',' 
CSV HEADER;

-- VERIFICAR SI SE TRASPASO BIEN LA INFORMACION
SELECT * FROM temporaldata;


