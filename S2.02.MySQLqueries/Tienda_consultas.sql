USE tienda;

-- 1. Llista el nom de tots els productes que hi ha en la taula producto.
SELECT nombre FROM producto ORDER BY nombre;
-- 2. Llista els noms i els preus de tots els productes de la taula producto.
SELECT nombre, precio FROM producto ORDER BY nombre;
-- 3. Llista totes les columnes de la taula producto.
SELECT * FROM producto;
-- 4. Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD).
SELECT nombre, precio AS precio€, ROUND(precio*1.09,2) AS precio$ FROM producto ORDER BY nombre;
-- 5. Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD). Utilitza els següents àlies per a les columnes: nom de producto, euros, dòlars.
SELECT nombre AS "nom de producto", precio AS euros, ROUND(precio*1.09,2) AS dòlars FROM producto ORDER BY nombre;
-- 6. Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a majúscula.
SELECT UPPER(nombre) AS nombre, precio FROM producto ORDER BY nombre;
-- 7. Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a minúscula.
SELECT LOWER(nombre) AS nombre, precio FROM producto ORDER BY nombre;
-- 8. Llista el nom de tots els fabricants en una columna, i en una altra columna obtingui en majúscules els dos primers caràcters del nom del fabricant.
SELECT nombre, UPPER(SUBSTRING(nombre,1,2)) AS "primeros 2 caracteres" FROM fabricante ORDER BY nombre;
-- 9. Llista els noms i els preus de tots els productes de la taula producto, arrodonint el valor del preu.
SELECT nombre, ROUND(precio) AS precio FROM producto ORDER BY nombre;
-- 10. Llista els noms i els preus de tots els productes de la taula producto, truncant el valor del preu per a mostrar-lo sense cap xifra decimal.
SELECT nombre, TRUNCATE(precio,0) AS precio FROM producto ORDER BY nombre;
-- 11. Llista el codi dels fabricants que tenen productes en la taula producto.
SELECT codigo_fabricante AS "codigo fabricante" FROM producto ORDER BY codigo_fabricante;
-- 12. Llista el codi dels fabricants que tenen productes en la taula producto, eliminant els codis que apareixen repetits.
SELECT DISTINCT(codigo_fabricante) AS "codigo fabricante" FROM producto ORDER BY codigo_fabricante;
-- 13. Llista els noms dels fabricants ordenats de manera ascendent.
SELECT nombre FROM fabricante ORDER BY nombre;
-- 14. Llista els noms dels fabricants ordenats de manera descendent.
SELECT nombre FROM fabricante ORDER BY nombre DESC;
-- 15. Llista els noms dels productes ordenats, en primer lloc, pel nom de manera ascendent i, en segon lloc, pel preu de manera descendent.
SELECT nombre, precio FROM producto ORDER BY nombre, precio DESC;
-- 16. Retorna una llista amb les 5 primeres files de la taula fabricante.
SELECT * FROM fabricante LIMIT 5;
-- 17. Retorna una llista amb 2 files a partir de la quarta fila de la taula fabricante. La quarta fila també s'ha d'incloure en la resposta.
SELECT * FROM fabricante LIMIT 3,2;
-- 18. Llista el nom i el preu del producte més barat. (Utilitza solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MIN(preu), necessitaria GROUP BY.
SELECT nombre, precio FROM producto ORDER BY precio LIMIT 1;
-- 19. Llista el nom i el preu del producte més car. (Utilitza solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MAX(preu), necessitaria GROUP BY.
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;
-- 20. Llista el nom de tots els productes del fabricant el codi de fabricant del qual és igual a 2.
SELECT nombre FROM producto WHERE codigo_fabricante = 2 ORDER BY nombre;
-- 21. Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades.
SELECT producto.nombre AS "nombre producto", precio, fabricante.nombre AS "nombre fabricante" FROM producto 
	JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY producto.nombre; 
-- 22. Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades. Ordena el resultat pel nom del fabricant, per ordre alfabètic.
SELECT producto.nombre AS "nombre producto", precio, fabricante.nombre AS "nombre fabricante" FROM producto 
	JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY fabricante.nombre; 
-- 23. Retorna una llista amb el codi del producte, nom del producte, codi del fabricador i nom del fabricador, de tots els productes de la base de dades.
SELECT producto.codigo AS "codigo producto", producto.nombre AS "nombre producto", producto.codigo_fabricante AS "codigo del fabricante", fabricante.nombre AS "nombre fabricante"
	FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;
-- 24. Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més barat.
SELECT producto.nombre AS "nombre producto", precio, fabricante.nombre AS "nombre fabricante" 
	FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY precio LIMIT 1;
-- 25. Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més car.
SELECT producto.nombre AS "nombre producto", precio, fabricante.nombre AS "nombre fabricante" 
	FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY precio DESC LIMIT 1;
-- 26. Retorna una llista de tots els productes del fabricant Lenovo.
SELECT producto.nombre AS "nombre producto" FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
	WHERE fabricante.nombre = "Lenovo" ORDER BY producto.nombre;
-- 27. Retorna una llista de tots els productes del fabricant Crucial que tinguin un preu major que 200 €.
SELECT producto.nombre AS "nombre producto" FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
	WHERE fabricante.nombre = "Crucial" AND producto.precio>200 ORDER BY producto.nombre;
-- 28. Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packard i Seagate. Sense utilitzar l'operador IN.
SELECT producto.nombre AS "nombre producto" FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
	WHERE fabricante.nombre = "Asus" OR fabricante.nombre = "Hewlett-Packard" OR fabricante.nombre = "Seagate" ORDER BY producto.nombre;
-- 29. Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packardy Seagate. Fent servir l'operador IN.
SELECT producto.nombre AS "nombre producto" FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
	WHERE fabricante.nombre IN ("Asus", "Hewlett-Packard", "Seagate") ORDER BY producto.nombre;
-- 30. Retorna un llistat amb el nom i el preu de tots els productes dels fabricants el nom dels quals acabi per la vocal e.
SELECT producto.nombre AS "nombre producto", precio FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
	WHERE RIGHT(fabricante.nombre,1) = 'e' ORDER BY producto.nombre;
-- 31. Retorna un llistat amb el nom i el preu de tots els productes el nom de fabricant dels quals contingui el caràcter w en el seu nom.
SELECT producto.nombre AS "nombre producto", precio FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
	WHERE fabricante.nombre LIKE '%w%' ORDER BY producto.nombre;
-- 32. Retorna un llistat amb el nom de producte, preu i nom de fabricant, de tots els productes que tinguin un preu major o igual a 180 €. Ordena el resultat, en primer lloc, pel preu (en ordre descendent) i, en segon lloc, pel nom (en ordre ascendent).
SELECT producto.nombre AS "nombre producto", precio, fabricante.nombre AS "nombre fabricante" FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
	WHERE precio>=180 ORDER BY precio DESC, producto.nombre;
-- 33. Retorna un llistat amb el codi i el nom de fabricant, solament d'aquells fabricants que tenen productes associats en la base de dades.
SELECT fabricante.codigo, fabricante.nombre FROM fabricante JOIN producto ON fabricante.codigo = producto.codigo_fabricante;
-- 34. Retorna un llistat de tots els fabricants que existeixen en la base de dades, juntament amb els productes que té cadascun d'ells. El llistat haurà de mostrar també aquells fabricants que no tenen productes associats.
SELECT fabricante.nombre AS "nombre fabricante", producto.nombre AS "nombre producto" FROM fabricante 
	LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante;
-- 35. Retorna un llistat on només apareguin aquells fabricants que no tenen cap producte associat.
SELECT fabricante.nombre FROM fabricante LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante
	WHERE producto.codigo IS NULL;
-- 36. Retorna tots els productes del fabricador Lenovo. (Sense utilitzar INNER JOIN).
SELECT nombre FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = "Lenovo");
-- 37. Retorna totes les dades dels productes que tenen el mateix preu que el producte més car del fabricant Lenovo. (Sense usar INNER JOIN).
SELECT * FROM producto WHERE precio = (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = "Lenovo"));
-- 38. Llista el nom del producte més car del fabricant Lenovo.
SELECT producto.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = "Lenovo"
	ORDER BY precio DESC LIMIT 1;
-- 39. Llista el nom del producte més barat del fabricant Hewlett-Packard.
SELECT producto.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = "Hewlett-Packard"
	ORDER BY precio LIMIT 1;
-- 40. Retorna tots els productes de la base de dades que tenen un preu major o igual al producte més car del fabricant Lenovo.
SELECT * FROM producto WHERE precio >= (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = "Lenovo"));
-- 41. Llista tots els productes del fabricant Asus que tenen un preu superior al preu mitjà de tots els seus productes.
SELECT * FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = "Asus") 
	AND precio > (SELECT AVG(precio) FROM producto WHERE codigo_Fabricante = (SELECT codigo FROM fabricante WHERE nombre = "Asus"));