-- P7E2 datos

create table proveedores (
    idProv varchar(10) not null,
    provNombre varchar(100) not null,
    categoria int,
    ciudad varchar(100),
    primary key (idProv)
);

create table componentes (
    idComp varchar(10) not null,
    compNombre varchar(15) not null,
    color varchar(20),
    peso int,
    ciudad varchar(100),
    primary key (idComp)
);

create table articulos (
    idArt varchar(10) not null,
    artNombre varchar(100) not null,
    ciudad varchar(100),
    primary key (idArt)
);

create table envios (
    idProv varchar(10) not null,
    idComp varchar(10) not null,
    idArt varchar(10) not null,
    cantidad int,
    primary key(idProv, idComp, idArt)
);


insert into proveedores values
('P1', 'Carlos', 20, 'La Plata'),
('P2', 'Juan', 10, 'Cap. Fed.'),
('P3', 'José', 30, 'La Plata'),
('P4', 'Dora', 20, 'La Plata'),
('P5', 'Eva', 30, 'Bernal');


insert into componentes values
('C1', 'X3A', 'Rojo', 12, 'La Plata'),
('C2', 'B85', 'Verde', 17, 'Cap. Fed.'),
('C3', 'C4B', 'Azul', 17, 'Quilmes'),
('C4', 'C4B', 'Rojo', 14, 'La Plata'),
('C5', 'VT8', 'Azul', 12, 'Cap. Fed.'),
('C6', 'C30', 'Rojo', 19, 'La Plata');

insert into articulos values
('T1', 'Clasificadora', 'Cap. Fed.'),
('T2', 'Perforadora', 'Quilmes'),
('T3', 'Lectora', 'Bernal'),
('T4', 'Consola', 'Bernal'),
('T5', 'Mezcladora', 'La Plata'),
('T6', 'Terminal', 'Berazategui'),
('T7', 'Cinta', 'La Plata');

insert into envios values
('P1', 'C1', 'T1', 200),
('P1', 'C1', 'T4', 700),
('P2', 'C3', 'T1', 400),
('P2', 'C3', 'T2', 200),
('P2', 'C3', 'T3', 200),
('P2', 'C3', 'T4', 500),
('P2', 'C3', 'T5', 600),
('P2', 'C3', 'T6', 400),
('P2', 'C3', 'T7', 800),
('P2', 'C5', 'T2', 100),
('P3', 'C3', 'T1', 200),
('P3', 'C4', 'T2', 100),
('P4', 'C6', 'T3', 300),
('P4', 'C6', 'T7', 300),
('P5', 'C2', 'T2', 200),
('P5', 'C2', 'T4', 100),
('P5', 'C5', 'T4', 500),
('P5', 'C5', 'T7', 100),
('P5', 'C6', 'T2', 200),
('P5', 'C1', 'T4', 100),
('P5', 'C3', 'T4', 200),
('P5', 'C4', 'T4', 800),
('P5', 'C5', 'T5', 400),
('P5', 'C6', 'T4', 500);
