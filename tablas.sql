
CREATE DATABASE ICFES;
USE ICFES;
CREATE TABLE pais (
    id_pais INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50)    
);

CREATE TABLE etnia (
    id_etnia INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50)
);   

CREATE TABLE examen (
    id_examen INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    ectura_critica INT,
    desemp_lectura_critica INT,
    matematica INT,
    desemp_mate INT,
    c_naturales INT,
    desem_c_natu INT,
    sociales INT,
    desem_sociales INT,
    ingles INT,
    desemp_ingles INT,
    punt_global INT     
);  

CREATE TABLE info_familia (
    id_info_familia INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    estrato INT,
    can_personas_hogar VARCHAR(20),
    cuartos VARCHAR(20),
    internet VARCHAR(10),
    TV VARCHAR(10),
    computador VARCHAR(10),
    lavadora VARCHAR(10),
    horno VARCHAR(10),
    auto VARCHAR(10),
    moto VARCHAR(10),
    consola_video VARCHAR(10),
    can_libros VARCHAR(30),
    comen_leche_derivados VARCHAR(30),
    comen_carnes VARCHAR(30),
    situacion_economica INT
);   


CREATE TABLE departamento (
    id_departamento INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50),
    id_pais INT,
    CONSTRAINT fk_pais FOREIGN KEY(id_pais) REFERENCES pais(id_pais)
);

CREATE TABLE municipio (
    id_municipio INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50),
    id_departamento INT,
    CONSTRAINT fk_departamento FOREIGN KEY(id_departamento) REFERENCES departamento(id_departamento)
);

CREATE TABLE colegio (
    id_colegio INT  PRIMARY KEY NOT NULL AUTO_INCREMENT,
    cod_dane INT,
    nombre VARCHAR(30),
    calendario VARCHAR(10),
    bilingüe BOOL,
    caracter VARCHAR(10),
    id_departamento INT,
    CONSTRAINT fk_departamento_co FOREIGN KEY(id_departamento) REFERENCES departamento(id_departamento),
    CONSTRAINT u_cod_dane UNIQUE(cod_dane)
    
);

CREATE TABLE estudiante (
    id_estudiante INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    genero VARCHAR(20),
    fecha_nacimiento DATE,
    privado_libertad BOOL,
    dedicacion_lect VARCHAR(30),
    dedicacion_int VARCHAR(30),
    horas_trabajo VARCHAR(30),
    tipo_remuneracion VARCHAR(30),
    id_etnia INT,
    id_municipio_nacimiento INT,
    id_municipio_recidencia INT,
    id_colegio INT,
    CONSTRAINT fk_etnia FOREIGN KEY(id_etnia) REFERENCES etnia(id_etnia), 
    CONSTRAINT fk_municipio_nacimiento FOREIGN KEY(id_municipio_nacimiento) REFERENCES municipio(id_municipio), 
    CONSTRAINT fk_municipio_residencia FOREIGN KEY(id_municipio_recidencia) REFERENCES municipio(id_municipio),
    CONSTRAINT fk_colegio FOREIGN KEY(id_colegio) REFERENCES colegio(id_colegio) 
);

CREATE TABLE info_padre (
    id_info_padre INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    tipo VARCHAR(10),
    educacion VARCHAR(50),
    trabajo VARCHAR(50),
    id_hijo INT,
    id_info_fa INT,
    CONSTRAINT fk_hijo FOREIGN KEY(id_hijo) REFERENCES estudiante(id_estudiante), 
    CONSTRAINT fk_info_fa FOREIGN KEY(id_info_fa) REFERENCES info_familia(id_info_familia)
);

CREATE TABLE presentacion_examen(
    id_presentacion_examen INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_estudiante INT,
    id_examen INT,
    id_municipio_pre INT,
    CONSTRAINT fk_id_es_p FOREIGN KEY(id_estudiante) REFERENCES estudiante(id_estudiante), 
    CONSTRAINT fk_id_examen FOREIGN KEY(id_examen) REFERENCES examen(id_examen),
    CONSTRAINT fk_municipio_pre FOREIGN KEY(id_municipio_pre) REFERENCES municipio(id_municipio)
);