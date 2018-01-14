-- P7E2 ejercicios

-- 1. Obtener todos los detalles de todos los artículos de Bernal.
select * from articulos where ciudad = 'Bernal';

-- 2. Obtener todos los valores de IdProv para los proveedores que abastecen el artículo T1.
select distinct idProv from envios where idArt = 'T1';

-- 3. Obtener la lista de pares de atributos (Color, Ciudad) de la tabla componentes eliminando los pares duplicados.
select color, ciudad from componentes
group by color, ciudad;

-- 4. Obtener de la tabla de artículos los valores de IdArt y Ciudad donde el nombre de la Ciudad acaba en D o contiene al menos una E.
select idArt, ciudad from articulos where ciudad like '%d' or ciudad like '%e%';

-- 5. Obtener los valores de IdProv para los proveedores que suministran para el artículo T1 el componente C1.
select distinct idProv from envios where idArt = 'T1' and idComp = 'C1';

-- 6. Obtener los valores de ArtNombre en orden alfabético para los artículos abastecidos por el proveedor P1.
select distinct idArt, artNombre
from envios natural join articulos
where idProv = 'P1' order by artNombre asc;

-- 7. Obtener los valores de IdComp para los componentes suministrados para cualquier artículo de Capital Federal.
select distinct idComp
from envios
natural join articulos
where ciudad = 'Cap. Fed.';

-- 8. Obtener el IdComp del (o los) componente(s) que tienen el menor peso.
select idComp from componentes
where peso = (select min(peso) from componentes);

-- 9. Obtener los valores de IdProv para los proveedores que suministren los artículos T1 y T2.
select distinct idProv from envios where idArt in ('T1', 'T2');

select distinct idProv from envios
where idProv in (select idProv from envios where idArt = 'T1')
  and idProv in (select idProv from envios where idArt = 'T2');

select idProv
from envios where idArt in ('T1', 'T2')
group by idProv
having count(distinct idArt) > 1
order by idProv asc;

-- 10. Obtener los valores de IdProv para los proveedores que suministran para un artículo de La Plata o Capital Federal un componente Rojo.
select distinct idProv from envios as env
join articulos as art on art.idArt = env.idArt
join componentes as com on com.idComp = env.idComp
where art.ciudad in ('La Plata', 'Cap. Fed') and com.color = 'Rojo' ;

-- 11. Obtener, mediante subconsultas, los valores de IdComp para los componentes suministrados para algún artículo
--     de La Plata por un proveedor de La Plata.
select distinct idComp from envios
where idArt in (select idArt from articulos where ciudad = 'La Plata')
  and idProv in (select idProv from proveedores where ciudad = 'La Plata');

-- 12. Obtener los valores de IdArt para los artículos que usan al menos un componente que se puede obtener con el proveedor P1.
select distinct idArt from envios where idProv = 'P1';

-- 13. Obtener todas las ternas (Ciudad, IdComp, Ciudad) tales que un proveedor de la primera Ciudad suministre 
--     el componente especificado para un artículo montado en la segunda Ciudad.
select prov.ciudad, env.idComp, art.ciudad from envios as env
join proveedores as prov on prov.idProv = env.idProv
join articulos as art on art.idArt = env.idArt;

-- 14. Repetir el ejercicio anterior pero sin recuperar las ternas en los que los dos valores de Ciudad sean los mismos.
select distinct prov.ciudad, env.idComp, art.ciudad from envios as env
join proveedores as prov on prov.idProv = env.idProv
join articulos as art on art.idArt = env.idArt;

-- 15. Obtener el número de suministros, el de artículos distintos suministrados y la cantidad total de artículos 
--     suministrados por el proveedor P2.
select sum(cantidad) as suministros, count(distinct idArt) as artDistintos, count(idArt) artTotal
from envios
where idProv = 'P2';

select idProv, sum(cantidad) as suministros, count(distinct idArt) as artDistintos, count(idArt) artTotal
from envios
group by idProv;

-- 16. Para cada artículo y componente suministrado obtener los valores de IdComp, IdArt y la cantidad total correspondiente.
select idComp, idArt, cantidad
from envios
order by idComp, idArt;

select idComp, idArt, sum(cantidad) as cantidadTotal
from envios
group by idComp, idArt
order by idComp, idArt;

-- 17. Obtener los valores de IdArt de los artículos abastecidos al menos por un proveedor que no viva en 
--     Capital Federal y que no esté en la misma Ciudad en la que se monta el artículo.
select distinct env.idArt from envios as env
join articulos as art on art.idArt = env.idArt
where idProv in (select idProv from proveedores where ciudad not in ('Cap. Fed.', art.ciudad));

-- 18. Obtener los valores de IdProv para los proveedores que suministran al menos un componente 
--     suministrado al menos por un proveedor que suministra al menos un componente Rojo.
select distinct idProv from envios as e1
where idComp in (
	select idComp from envios as e2 where idProv in (
		select idProv from envios as e3 join componentes as c on c.idComp = e3.idComp
		where c.color = 'Rojo'
	)
); -- esta bien??

-- 19. Obtener los identificadores de artículos, IdArt, para los que se ha suministrado algún componente del que 
--     se haya suministrado una media superior a 320 artículos.
select * from envios
where idArt in (
	select idArt from envios where idComp in (
		select idComp from envios
		group by idComp having avg(cantidad) > 320
	)
); -- esta bien??

-- 20. Seleccionar los identificadores de proveedores que hayan realizado algún envío con cantidad mayor 
--     que la media de los envíos realizados para el componente a que corresponda dicho envío. 
select distinct idProv from envios as e1
where cantidad > (
	select avg(cantidad) from envios as e2 where e2.idComp = e1.idComp
); -- esta bien??

-- 21. Seleccionar los identificadores de componentes suministrados para el artículo ’T2’ por el proveedor ’P2’.
select distinct idComp from envios where idArt = 'T2' and idProv = 'P2';

-- 22. Seleccionar todos los datos de los envíos realizados de componentes cuyo color no sea ’Rojo’.
select idProv, env.idComp, idArt, cantidad
from envios as env
join componentes as comp on comp.idComp = env.idComp
where comp.color <> 'Rojo';

-- 23. Seleccionar los identificadores de componentes que se suministren para los artículos ’T1’ y ’T2’.
select distinct idComp from envios where idArt in ('T1', 'T2');

-- 24. Seleccionar el identificador de proveedor y el número de envíos de componentes de color ’Rojo’ llevados a cabo por cada proveedor.
select idProv, count(env.idComp) as cantComponentes
from envios as env
join componentes as comp on comp.idComp = env.idComp and color = 'Rojo'
group by idProv;

-- 25. Seleccionar los colores de componentes suministrados por el proveedor ’P1’.
select color
from envios as env
join componentes as comp on comp.idComp = env.idComp
where idProv = 'P1'
group by color;

-- 26. Seleccionar los datos de envío y nombre de Ciudad de aquellos envíos que cumplan que el artículo, 
--     proveedor y componente son de la misma Ciudad.
select env.idProv, env.idComp, env.idArt, cantidad, prov.ciudad
from envios as env
join proveedores as prov on prov.idProv = env.idProv
join articulos as art on art.idArt = env.idArt
join componentes as comp on comp.idComp = env.idComp
where prov.ciudad = art.ciudad and art.ciudad = comp.ciudad;

-- 27. Seleccionar los nombres de los componentes que son suministrados en una cantidad total superior a 500.
select compNombre from envios as env
join componentes as comp on comp.idComp = env.idComp
group by compNOmbre having sum(cantidad) > 500;

-- 28. Seleccionar los identificadores de proveedores que residan en La Plata y no suministren más de dos artículos distintos.
select env.idProv from envios as env
join proveedores as prov on prov.idProv = env.idProv and prov.ciudad = 'La Plata'
group by env.idProv having count(distinct idArt) <= 2;

-- 29. Seleccionar los identificadores de artículos para los cuales todos sus componentes se fabrican en una misma Ciudad.
select idArt from envios as env
join componentes as comp on comp.idComp = env.idComp
group by idArt having count(distinct comp.ciudad) = 1
order by idArt asc;

-- 30. Seleccionar los identificadores de artículos para los que se provean envíos de todos los componentes existentes en la base de datos.
select idArt
from envios
group by idArt
having count(distinct idComp) = (select count(*) from componentes);
