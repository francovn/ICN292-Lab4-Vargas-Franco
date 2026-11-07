DROP database IF exists austral;
CREATE database	austral ; -- Crea una base de datos, una "carpeta" 
USE austral; -- Con esto, "abrimos esa carpeta"

CREATE table autores -- Crea una tabla, el "archivo"
(id_autor INT AUTO_INCREMENT, -- columna, id del autor generado automaticamente
nombre VARCHAR(80) NOT NULL, -- columna, nombres de hasta 80 caracteres
pais VARCHAR(60) ,
genero ENUM('Cómic','Ensayo', 'Infantil', 'Novela','Poesía') NOT NULL, -- define los 5 generos permitidos y no addmite valores nulos
PRIMARY KEY(id_autor)); -- Garantiza que cada autor tenga un identificador único y no nulo.

CREATE table colecciones
(id_coleccion INT AUTO_INCREMENT ,
 titulo VARCHAR(120) NOT NULL,
 fecha_publicacion DATE NOT NULL,
 PRIMARY KEY(id_coleccion));

CREATE table libros
(id_libro INT AUTO_INCREMENT,
id_autor INT,
id_coleccion INT,
titulo VARCHAR(120) NOT NULL,
paginas INT,
ejemplares_vendidos INT,
anio INT,
PRIMARY KEY(id_libro),
FOREIGN KEY(id_autor) REFERENCES autores(id_autor), -- Si se registra un identificador de autor, debe existir en autores
FOREIGN KEY(id_coleccion) REFERENCES colecciones(id_coleccion));

CREATE table pagos 
(id_pago INT AUTO_INCREMENT,
 id_autor INT NOT NULL,
 fecha_pago DATE NOT NULL,
 monto DECIMAL(10,2) NOT NULL,
 PRIMARY KEY(id_pago),
 FOREIGN KEY(id_autor) REFERENCES autores(id_autor)); -- Establece la relación y comprueba que el identificador ingresado exista en autores
 
 INSERT INTO autores (nombre, pais, genero) -- Inserta a la tabla autores los valores con cada respectivo formato
 VALUES ('Elena Pizarro', 'Chile', 'Novela'),
 ('Harold Finch', 'Inglaterra', 'Ensayo'),
 ('Rodrigo Bahamonde', 'Chile', 'Poesía'),
 ('Valentina Correa', 'Argentina', 'Infantil'),
 ('Nora Keller', 'Estados Unidos', 'Novela'),
 ('Kenji Arakawa', NULL, 'Cómic');	
 
 SELECT id_autor, nombre, pais, genero FROM autores -- Indica las columnas que queremos ver e indica de qué tabla leerlas
 ORDER BY id_autor; -- Ordena de menor a mayor identificador
 
 INSERT INTO libros (id_autor, titulo, paginas, ejemplares_vendidos, anio) 
 VALUES (1, 'Cielo de Enero', 210, 1500, 2024),
(1, 'Marea Baja', 185, 800, 2023),
(1, 'El Norte', 200, 2200, 2024),
(2, 'Estrellas que Caen', 240, 3000, 2022),
(2, 'Máquinas', 215, 450, 2024),
(3, 'Luz Artificial', 300, 1200, 2024),
(3, 'Ruido Blanco', 280, 600, 2023),
(4, 'El Barrio de Lila', 190, 5000, 2024),
(4, 'Antes del Amanecer', 205, 2700, 2024),
(4, 'La Calle 8', 175, 900, 2023),
(5, 'Flor de Hierro', 195, 4100, 2024),
(5, 'Hora Dorada', 220, 1800, 2022);
 
 SELECT id_libro, id_autor, id_coleccion, titulo, paginas, ejemplares_vendidos, anio FROM libros
 ORDER BY id_libro;
 
 
 -- Consulta 1
 SELECT nombre, genero FROM autores
 WHERE pais <> 'Chile' OR pais IS NULL -- Incluye a quienes tienen un país registrado distinto de Chile e incorpora a quienes no tienen un país registrado
 ORDER BY nombre; 
 
 -- Consulta 2
 SELECT titulo, paginas FROM libros
 WHERE paginas >= 190 AND paginas <= 220
 ORDER BY paginas;
 
 -- Consulta 3
 SELECT COUNT(id_libro) AS numero_de_libros, -- Centa los id's de totales
 SUM(ejemplares_vendidos) AS ejemplares_vendidos, -- Suma
 AVG(paginas) AS promedio_paginas, -- Promedio
 MIN(anio) AS año_mas_antiguo, -- El año más antiguo
 MAX(ejemplares_vendidos) AS mayor_cantidad_de_ejemplares_vendidos FROM libros;
 
 -- Consulta 4
 SELECT DISTINCT genero FROM autores
 ORDER BY genero;
 
 -- Consulta 5
 SELECT autores.nombre, COUNT(libros.id_libro) AS cantidad_libros
 FROM libros
 JOIN autores ON autores.id_autor = libros.id_autor -- Busca comparar datos en amas tablas pero deben de tener el mismo id
 WHERE libros.anio = 2024 
 GROUP BY autores.id_autor, autores.nombre -- Agrupar por la cantidad de libros por autor y laa columna que no está en COUNT
 HAVING COUNT(libros.id_libro) > 1 -- Es como "teniendo en cuenta que"
 ORDER BY autores.nombre;
 
 -- Consulta 6
 SELECT titulo, ejemplares_vendidos FROM libros
 WHERE ejemplares_vendidos >  2000 AND anio = 2024
 ORDER BY ejemplares_vendidos DESC
 LIMIT 3;
 
 -- COnsulta 7
 INSERT INTO libros (id_autor, titulo, paginas, ejemplares_vendidos, anio)
 VALUE (3, 'Papel Mojado', 260, 50, 2024);
 
 SELECT * FROM libros -- Muestra todos los datos de la tabla
 WHERE titulo = 'Papel Mojado';
 
 DELETE FROM libros
 WHERE titulo = 'Papel Mojado';
 
SELECT * FROM libros 
 WHERE titulo = 'Papel Mojado';
 
 -- Consulta 8
 SELECT * FROM libros
 WHERE titulo = 'Cielo de Enero';
 
 UPDATE libros
SET ejemplares_vendidos = ejemplares_vendidos + 100
WHERE titulo = 'Cielo de Enero';

SELECT * FROM libros
WHERE titulo = 'Cielo de Enero';

-- Consulta 9
INSERT INTO colecciones (titulo, fecha_publicacion)
VALUES ('Narrativa e imaginación', '1954-07-29'),
('Ideas y poesía', '2009-09-01');

SELECT * FROM colecciones;

UPDATE libros
SET id_coleccion = 1
WHERE id_autor IN (1, 4, 5);

UPDATE libros
SET id_coleccion = 2
WHERE id_autor IN (2, 3);

SELECT libros.titulo AS titulo_libro, colecciones.titulo AS titulo_coleccion, colecciones.fecha_publicacion 
FROM libros
JOIN colecciones ON libros.id_coleccion = colecciones.id_coleccion;

-- Consulta 10
INSERT INTO pagos (id_autor, fecha_pago, monto)
VALUES (1, '2024-08-01', 27000000),
(1, '2025-09-11', 33000000),
(3, '2025-04-19',17000000);

SELECT * FROM pagos;

SELECT autores.nombre, pagos.fecha_pago, pagos.monto FROM autores
JOIN pagos ON pagos.id_autor = autores.id_autor;

SELECT autores.nombre, SUM(pagos.monto) FROM autores
JOIN pagos ON pagos.id_autor = autores.id_autor
GROUP BY pagos.id_autor, autores.nombre;