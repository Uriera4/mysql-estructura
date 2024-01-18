USE universidad;

-- Visualitza el diagrama E-R en un editor i efectua les següents consultes:
/* 1. Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. 
El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom. */
SELECT apellido1 AS "primer cognom", apellido2 AS "segon cognom", nombre AS "nom" FROM persona WHERE tipo = "alumno" ORDER BY apellido1, apellido2, nombre;
-- 2. Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT nombre AS "nom", apellido1 AS "primer cognom", apellido2 AS "segon cognom" FROM persona WHERE tipo = "alumno" AND telefono IS NULL ORDER BY nombre;
-- 3. Retorna el llistat dels alumnes que van néixer en 1999.
SELECT * FROM persona WHERE tipo = "alumno" AND fecha_nacimiento BETWEEN '1999-01-01' AND '1999-12-31';
-- 4. Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.
SELECT * FROM persona WHERE tipo = "profesor" AND RIGHT(nif,1) = 'K';
-- 5. Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
SELECT * FROM asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;
/* 6. Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. 
El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. 
El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom. */
SELECT apellido1 AS "primer cognom", apellido2 AS "segon cognom", persona.nombre AS "nom", departamento.nombre AS "nom del departament" FROM persona 
	JOIN profesor ON persona.id = profesor.id_profesor JOIN departamento ON profesor.id_departamento = departamento.id
    WHERE tipo = "profesor" ORDER BY apellido1, apellido2, persona.nombre;
-- 7. Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
SELECT asignatura.nombre AS "assignatura", anyo_inicio AS "any d'inici", anyo_fin AS "any de fi del curs" FROM asignatura
	JOIN alumno_se_matricula_asignatura ON asignatura.id = alumno_se_matricula_asignatura.id_asignatura
    JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id
    JOIN persona ON alumno_se_matricula_asignatura.id_alumno = persona.id
    WHERE nif = '26902806M';
-- 8. Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
SELECT departamento.nombre AS "nom departament" FROM departamento
	JOIN profesor ON departamento.id = profesor.id_departamento
	JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor
    JOIN grado ON asignatura.id_grado = grado.id
    WHERE grado.nombre = 'Grado en Ingeniería Informática (Plan 2015)' GROUP BY departamento.nombre;
-- 9. Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
SELECT nif, nombre, apellido1, apellido2, ciudad, direccion, telefono, fecha_nacimiento, sexo FROM persona
	JOIN alumno_se_matricula_asignatura ON persona.id = alumno_se_matricula_asignatura.id_alumno
	JOIN curso_Escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id
	WHERE tipo = "alumno" AND anyo_inicio = '2018' AND anyo_fin = '2019' GROUP BY persona.nombre;

-- Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.
/* 1. Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. 
El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. 
El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. 
El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom. */
SELECT departamento.nombre "nom departament", apellido1 AS "primer cognom", apellido2 AS "segon cognom", persona.nombre AS "nom professor" FROM persona
	LEFT JOIN profesor ON persona.id = profesor.id_profesor
    LEFT JOIN departamento ON profesor.id_departamento = departamento.id
    WHERE tipo = "profesor"
	ORDER BY departamento.nombre, apellido1, apellido2, persona.nombre;
-- 2. Retorna un llistat amb els professors/es que no estan associats a un departament.
SELECT nif, nombre, apellido1, apellido2, ciudad, direccion, telefono, fecha_nacimiento, sexo FROM persona 
	LEFT JOIN profesor ON persona.id = profesor.id_profesor
    WHERE tipo = "profesor" AND id_departamento IS NULL;
-- 3. Retorna un llistat amb els departaments que no tenen professors/es associats.
SELECT departamento.nombre AS "nom departament" FROM departamento
	LEFT JOIN profesor ON departamento.id = profesor.id_departamento
    WHERE id_departamento IS NULL;
-- 4. Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
SELECT nif, persona.nombre, apellido1, apellido2, ciudad, direccion, telefono, fecha_nacimiento, sexo FROM persona
	LEFT JOIN asignatura ON persona.id = asignatura.id_profesor
    WHERE persona.tipo = "profesor" AND id_profesor IS NULL;
-- 5. Retorna un llistat amb les assignatures que no tenen un professor/a assignat.
SELECT asignatura.nombre AS "nom assignatura" FROM profesor
	RIGHT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor
    WHERE asignatura.id_profesor IS NULL;
-- 6. Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
SELECT departamento.nombre AS "nom departament" FROM departamento
	LEFT JOIN profesor ON departamento.id = profesor.id_departamento
    LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor
    WHERE asignatura.id_profesor IS NULL GROUP BY departamento.nombre;

-- Consultes resum:
-- 1. Retorna el nombre total d'alumnes que hi ha.
SELECT COUNT(tipo) AS "nº total d'alumnes" FROM persona WHERE tipo = "alumno";
-- 2. Calcula quants alumnes van néixer en 1999.
SELECT COUNT(tipo) AS "nº total d'alumnes nascuts al 1999" FROM persona WHERE tipo = "alumno" AND fecha_nacimiento BETWEEN '1999-01-01' AND '1999-12-31';
/* 3. Calcula quants professors/es hi ha en cada departament. 
El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. 
El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es. */
SELECT departamento.nombre AS "nom departament", COUNT(id_departamento) AS "nº de profesors" FROM departamento
	RIGHT JOIN profesor ON departamento.id = profesor.id_departamento GROUP BY departamento.nombre ORDER BY COUNT(id_departamento) DESC;
/* 4. Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. 
Tingui en compte que poden existir departaments que no tenen professors/es associats. Aquests departaments també han d'aparèixer en el llistat. */
SELECT departamento.nombre AS "nom departament", COUNT(id_departamento) AS "nº de profesors" FROM departamento
	LEFT JOIN profesor ON departamento.id = profesor.id_departamento GROUP BY departamento.nombre ORDER BY COUNT(id_departamento) DESC;
/* 5. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. 
Tingues en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. 
El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures. */
SELECT grado.nombre AS "nom grau", COUNT(asignatura.id_grado) AS "nº assignatures" FROM grado
	LEFT JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre ORDER BY COUNT(asignatura.id_grado) DESC;
-- 6. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.
SELECT grado.nombre AS "nom grau", COUNT(asignatura.id_grado) AS "nº assignatures" FROM grado
	INNER JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre HAVING COUNT(asignatura.id_grado)>40;
/* 7. Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. 
El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus. */
SELECT grado.nombre AS "nom grau", asignatura.tipo AS "tipus d'assignatura", SUM(asignatura.creditos) AS "nº credits" FROM grado
	INNER JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre, asignatura.tipo;
/* 8. Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. 
El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats. */
SELECT curso_escolar.anyo_inicio AS "any inici", COUNT(DISTINCT(alumno_se_matricula_asignatura.id_alumno)) AS "nº alumnes matriculats" FROM curso_escolar
	INNER JOIN alumno_se_matricula_asignatura ON curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar
    GROUP BY anyo_inicio;
/* 9. Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. 
El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. 
El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. 
El resultat estarà ordenat de major a menor pel nombre d'assignatures. */
SELECT persona.id AS "id", persona.nombre AS "nom", persona.apellido1 AS "primer cognom", persona.apellido2 AS "segon cognom", COUNT(asignatura.id_profesor) AS "nº asignatures" FROM persona
	INNER JOIN profesor ON persona.id = profesor.id_profesor
    LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor
    GROUP BY persona.id ORDER BY COUNT(asignatura.id_profesor) DESC;
-- 10. Retorna totes les dades de l'alumne/a més jove.
SELECT * FROM persona WHERE tipo = "alumno" AND fecha_nacimiento = (SELECT MAX(fecha_nacimiento) FROM persona);
-- 11. Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura
SELECT persona.id, nif, persona.nombre, apellido1, apellido2, ciudad, direccion, telefono, fecha_nacimiento, sexo FROM persona
	INNER JOIN profesor ON persona.id = profesor.id_profesor
	INNER JOIN departamento ON profesor.id_departamento = departamento.id
    LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor
    WHERE asignatura.id_profesor IS NULL ORDER BY persona.id;
