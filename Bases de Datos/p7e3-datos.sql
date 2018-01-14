drop table if exists TRABAJADOR;
CREATE TABLE trabajador (
	legajo INT NOT NULL PRIMARY KEY,
	nombre CHAR(20) NOT NULL,
	tarifa REAL NOT NULL,
	oficio CHAR(15) NOT NULL
);

ALTER TABLE trabajador
ADD legajo_supv INT NULL REFERENCES trabajador;

drop table if exists EDIFICIO;
CREATE TABLE edificio (
	id_e INT NOT NULL PRIMARY KEY,
	dir CHAR(30) NOT NULL,
	tipo CHAR(15) NOT NULL,
	nivel_calidad CHAR(10) NOT NULL,
	categoria INT NOT NULL
);

drop table if exists ASIGNACION;
CREATE TABLE asignacion (
	legajo INT NOT NULL REFERENCES trabajador,
	id_e INT NOT NULL REFERENCES edificio,
	fecha_inicio DATE NOT NULL,
	num_dias INT,
	PRIMARY KEY (legajo, id_e, fecha_inicio)
);

INSERT INTO trabajador
VALUES
(1235, "M. Fernandez", 12.5, "electricista", 1311),
(1311, "C. García", 15.5, "electricista", 1311),
(1412, "C. Gonzalez", 13.75, "plomero", 1520),
(1520, "H. Caballero", 11.75, "plomero", 1520),
(2920, "R. Perez", 10.0, "albañil", 2920),
(3001, "J. Gutierrez", 8.2, "carpintero", 3231), 
(3231, "P. Alvarez", 17.4, "carpintero", 3231);

INSERT INTO edificio
VALUES
(111,"Av. Paseo Colón 1213", "oficina", 4, 1),
(210,"Rivadavia 1011", "oficina", 3, 1),
(312,"Tucumán 123", "oficina", 2, 2),
(435,"Cabildo 456", "comercio", 1, 1),
(460,"Santa Fe 1415", "almacén", 3, 3),
(515,"Chile 789", "residencia", 3, 2);


INSERT INTO asignacion
VALUES
(1235, 312, '2014-10-10', 5),
(1235, 515, '2014-10-17', 22),
(1311, 435, '2014-10-08', 12),
(1311, 460, '2014-10-23', 24),
(1412, 111, '2014-12-01', 4),
(1412, 210, '2014-11-15', 12),
(1412, 312, '2014-10-01', 10),
(1412, 435, '2014-10-15', 15),
(1412, 460, '2014-10-08', 18),
(1412, 515, '2014-11-05', 8),
(1520, 312, '2014-10-30', 17),
(1520, 515, '2014-10-09', 14),
(2920, 210, '2014-11-10', 15),
(2920, 460, '2014-05-20', 18),
(3001, 111, '2014-10-08', 14),
(3001, 210, '2014-10-27', 14),
(3231, 111, '2014-10-10', 8),
(3231, 312, '2014-10-24', 20);
