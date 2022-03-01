#info de la familia en general del estudiante
CREATE OR REPLACE VIEW familia(id_est,colegio, id_padre, padre_edu,padre_trabajo,cuartos,internet,
TV,computador,lavadora,horno,vehiculo,moto,consola_video,can_libros,comen_leche_derivados,
comen_carnes,situacion_economica)
 AS (SELECT e.id_estudiante, c.nombre, ip.id_info_padre, ip.educacion,ip.trabajo,
		inf.cuartos,inf.internet,inf.TV,inf.computador,inf.lavadora,inf.horno,inf.vehiculo,inf.moto,
        inf.consola_video,inf.can_libros,inf.comen_leche_derivados,inf.comen_carnes,
        inf.situacion_economica
		FROM estudiante e 
        INNER JOIN info_familia inf on e.id_info_familia = inf.id_info_familia
        INNER JOIN info_padre ip on ip.id_info_fa =inf.id_info_familia
        INNER JOIN colegio c on c.id_colegio=e.id_colegio
 );
 
 #pormedio general por institucion
 CREATE OR REPLACE VIEW promedios_por_colegio(id_colegio,colegio,global_t) 
 AS (SELECT c.id_colegio, c.nombre, AVG(pe.punt_global)
		FROM colegio c
        INNER JOIN estudiante e ON e.id_colegio= c.id_colegio
        INNER JOIN presentacion_examen pe ON pe.id_estudiante = e.id_estudiante
        GROUP BY c.id_colegio
        );
        
#informacion de la ciudad y de donde pertenece        
CREATE OR REPLACE VIEW  info_ciudad (id_municipo, municipio,departamento,pais)
AS (SELECT m.id_municipio, m.nombre, d.nombre, p.nombre
		FROM municipio m
        INNER JOIN departamento d ON d.id_departamento = m.id_departamento
        INNER JOIN pais p ON p.id_pais = d.id_pais
        );
        
#Fecha de presentacion del examen de cada estudiante        
CREATE OR REPLACE VIEW fecha_presentacion_examen (id_estudiante,examen_año) 
AS (SELECT pe.id_estudiante, e.fecha_presentacion FROM presentacion_examen pe
		INNER JOIN examen e ON pe.id_examen = e.id_examen);
        
 #pormedio general por municipio
 CREATE OR REPLACE VIEW promedios_por_municipio(id_municipio,municipio,global_t) 
 AS (SELECT m.id_municipio, m.nombre, AVG(pe.punt_global)
		FROM municipio m
        INNER JOIN presentacion_examen pe ON pe.id_municipio_pre= m.id_municipio
        GROUP BY m.id_municipio
        );
