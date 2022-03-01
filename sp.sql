CREATE PROCEDURE `becas`(IN tabla_orden VARCHAR(50), IN tipo_orden VARCHAR(15))
BEGIN
IF tabla_orden <> '' THEN
	SET @tabla = tabla_orden;
ELSE 
	SET @tabla = '';
END IF;
IF tipo_orden <> '' THEN
	SET @orden = tipo_orden;
ELSE 
	SET @orden = '';
END IF;

SET @query_t = concat('select e.id_estudiante codigo_estudiante, pe.punt_global puntaje from presentacion_examen pe
inner join estudiante e on e.id_estudiante = pe.id_estudiante
where punt_global >=350 ','ORDER BY ',@tabla, ' ',@orden);
PREPARE ejecucion from @query_t;
EXECUTE ejecucion;
deallocate prepare ejecucion;
END



CREATE PROCEDURE `agregar_colegio`(
IN inser_or_delete INT,
IN codigo_dane INT,
IN nombre_del_colegio VARCHAR(100),
IN calendario VARCHAR(10),
IN es_bilingue BOOL,
IN genero_per VARCHAR(20),
IN tipo_natu VARCHAR(20),
IN tipo_caracter VARCHAR(100),
IN municipio_colegio VARCHAR(200)

)
BEGIN
declare id_s INT;
if inser_or_delete = 1 THEN
	 if municipio_colegio IN (select nombre from municipio) THEN
		SET id_s = (select id_municipio from municipio where nombre = municipio_colegio);
		else 
			select 'Municipio no valido';  
	end if;
	insert into colegio values ( 
	NULL,
	 codigo_dane,
	 nombre_del_colegio,
	 calendario,
	 es_bilingue,
	 genero_per,
	 tipo_natu,
	 tipo_caracter,
	 id_s
	 );
elseif inser_or_delete = 2 then
	delete from colegio where nombre = nombre_del_colegio and cod_dane=codigo_dane;
else 
    select 'opcion no valida';
end if;
END