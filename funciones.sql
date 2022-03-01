USE icfes;
DELIMITER #
CREATE ` FUNCTION `NOTA_FINAL`(id_estudiante_v INT) RETURNS int
/* la siguiente funcion calcula la nota definitiva del estudiante*/
    DETERMINISTIC
BEGIN 
	DECLARE nota INT;
    SELECT distinct(punt_global) INTO nota
    FROM presentacion_examen
    WHERE id_estudiante = id_estudiante_v;
    RETURN nota;
END #


CREATE FUNCTION PROMEDIO_COLEGIO(id_colegio_v INT)
/* la siguiente funcion calcula el promedio de los estudiantes de cada institucion*/
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE promedio DECIMAL(5,2);
    SELECT AVG(pe.punt_global) INTO promedio FROM presentacion_examen pe
    INNER JOIN estudiante e ON e.id_estudiante = pe.id_estudiante
    INNER JOIN colegio c ON c.id_colegio = e.id_colegio AND c.id_colegio = id_colegio_v
    GROUP BY c.id_colegio;
    RETURN promedio;
END #



