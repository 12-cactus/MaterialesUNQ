-- 1. Nombre de los trabajadores cuya tarifa está entre 10 y 12 pesos.
select * from trabajador where tarifa between 10 and 12; -- [10, 12]

insert into trabajador values (9999, "Cosme Fulanito", 12, "electricista", 1311);

-- 2. Cuáles son los oficios de los trabajadores asignados al edificio 435?
select t.nombre 
from asignacion as a
join trabajador as t on t.legajo = a.legajo
where id_e = 435;

-- 3. Indicar el nombre del trabajador y el de su supervisor.
select trab.nombre as trabajador, sup.nombre as supervisor
from trabajador as trab
join trabajador as sup on sup.legajo = trab.legajo_supv;

-- 4. Nombre de los trabajadores asignados a oficinas.
select t.nombre as trabajador
from asignacion as a
join trabajador as t on t.legajo = a.legajo
join edificio as e on e.id_e = a.id_e
where tipo = 'oficina';

-- 5. Qué trabajadores reciben una tarifa por hora mayor que la de su supervisor?
select trab.nombre as trabajador
from trabajador as trab
join trabajador as sup on sup.legajo = trab.legajo_supv and trab.tarifa > sup.tarifa;

-- 6. Cuál es el número total de días que se han dedicado a plomería en el edificio 312?
select sum(num_dias)
from asignacion as a
join trabajador as t on t.legajo = a.legajo
where oficio = 'plomero';

-- 7. Cuántos tipos de oficios diferentes hay?
select distinct oficio from trabajador;

-- 8. Para cada supervisor, cuál es la tarifa por hora más alta que se paga a un trabajador que informa a ese supervisor?
select sup.legajo, max(trab.tarifa) as maxTarifa
from trabajador as sup
join trabajador as trab on trab.legajo_supv = sup.legajo
where sup.legajo = sup.legajo_supv
group by sup.legajo;

-- 9. Para cada supervisor que supervisa a más de un trabajador, cuál es la tarifa más alta que se paga a un trabajador
--    que informa a ese supervisor?
select sup.legajo, max(trab.tarifa) as maxTarifa
from trabajador as sup
join trabajador as trab on trab.legajo_supv = sup.legajo
where sup.legajo = sup.legajo_supv
group by sup.legajo
having count(trab.legajo) > 1;

-- 10. Para cada tipo de edificio, cuál es el nivel de calidad medio de los edificios con categoría 1?
--     Considérense sólo aquellos tipos de edificios que tienen un nivel de calidad máximo no mayor que 3.
select tipo, avg(nivel_calidad) as calidadMedia
from edificio
where categoria = 1
group by tipo
having max(nivel_calidad) <= 3;

-- 11. Qué trabajadores reciben una tarifa por hora menor que la del promedio?
select nombre, tarifa 
from trabajador
where tarifa < (select avg(tarifa) from trabajador);

-- 12. Qué trabajadores reciben una tarifa por hora menor que la del promedio de los trabajadores que tienen su mismo oficio?
select nombre, tarifa 
from trabajador as t1
where tarifa < (
	select avg(tarifa) from trabajador as t2
	where t2.oficio = t1.oficio
);

-- 13. Qué trabajadores reciben una tarifa por hora menor que la del promedio de los trabajadores que dependen del mismo supervisor que él?
select nombre, tarifa 
from trabajador as t1
where tarifa < (
	select avg(tarifa) from trabajador as t2
	where t2.legajo_supv = t1.legajo_supv
);

-- 14. Seleccione el nombre de los electricistas asignados al edificio 435 y la fecha en la que empezaron a trabajar en él.
select nombre, min(fecha_inicio)
from asignacion as a
join trabajador as t on t.legajo = a.legajo and t.oficio = 'electricista'
where id_e = 435
group by nombre;

-- 15. Qué supervisores tienen trabajadores que tienen una tarifa por hora por encima de los 12 euros?
select distinct sup.nombre 
from trabajador as sup
join trabajador as trab on trab.legajo_supv = sup.legajo
where sup.legajo = sup.legajo_supv
  and trab.tarifa > 12;
