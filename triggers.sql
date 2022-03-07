/*La siguiente tabla ayudara a visualizar cambios hechos en las notas de los estudiantes, por la pandemia se implementaron pruebas virtuales, 
pero el gobierno Colombiano prefiere realizarlas presenciales para evitar plagios, es por esto que puede llegar el caso en que se digite de manera incorrecta 
un resultado, la siguiente tabal guardara las notas iniciales y las correcciones que se hagan, los campos que digan antigua tendrá la nota desactualizada y 
los campos con nueva tendrán la nota actualizada, se puede realizar un cambio o varios (una o mas materias). */
DROP TABLE IF EXISTS  log_cambio_nota,cantidad_estu_pre_examen;
CREATE TABLE log_cambio_nota (
id INT NOT NULL auto_increment PRIMARY KEY,
id_estudiante INT NOT NULL,
presentacion_examen_antiguo INT,
presentacion_examen_nuevo INT,
lectura_antigua INT,
lectura_nueva INT,
mat_antigua INT,
mat_nueva INT,
ciencias_antigua INT,
ciencias_nueva INT,
sociales_antigua INT,
sociales_nueva INT,
ingles_antigua INT,
ingles_nueva INT,
nota_antigua INT,
nota_nueva INT,
fecha_cambio datetime
);

/* el siguiente trigger registrara los cambios en la nota y los almacenara n la tabla log_cambio_nota, 
este trigger se activará cuando se actualice la tabla presentación examen.
Si se intenta actualizar el id del estudiante o del examen se mostrará un mensaje de error, 
en caso contrario se realizara el INSERT con los respectivos datos en la tabla log_cambio_nota. */

DELIMITER $$
CREATE TRIGGER log_notas
AFTER UPDATE ON presentacion_examen
FOR EACH ROW
begin
IF new.id_presentacion_examen <> old.id_presentacion_examen OR new.id_estudiante <> old.id_estudiante then
	signal sqlstate 'ER123';
ELSE
	INSERT INTO log_cambio_nota VALUES (DEFAULT, id_estudiante, 
				old.lectura_critica,new.lectura_critica,
                old.matematica,new.matematica,
                old.c_naturales,new.c_naturales,
                old.sociales,new.sociales,
                old.ingles,new.ingles,
                old.punt_global,new.punt_global,
                now());
end if;
end $$


DELIMITER ;

/*la siguiente tabla registrara la cantidad de usuarios que han presentado examen y mostrara la última fecha de la que se tenga registro, 
cada vez que se haga una inserción se sumara a el total que se tenga*/
CREATE TABLE cantidad_estu_pre_examen(
id INT NOT NULL auto_increment PRIMARY KEY,
fecha_ingreso_dato datetime,
total INT);


/*el trigger se activa cada vez que se incerte un dato en  la tabla presentacion_examen, alamacenara los datos y el total de presentaciiones
de examen en la la tabla cantidad_estu_pre_examen*/
CREATE TRIGGER cantidad_presentacion_examen 
BEFORE INSERT ON presentacion_examen
FOR EACH ROW  
INSERT INTO cantidad_estu_pre_examen VALUES (DEFAULT,NOW(),(select count(*) from presentacion_examen));



