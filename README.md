# ICN292-Lab4-Vargas-Franco

Laboratorio 4 del curso **ICN-292 Sistemas de Información para la Gestión** (Departamento de Industrias, Universidad Técnica Federico Santa María, Campus Vitacura, segundo semestre 2026).

**Autor:** [Franco Vargas Nieto]

## Descripción

Austral Editores es una editorial que registra a sus autores y los libros que cada uno publica. Un libro pertenece a un único autor y un autor puede tener muchos libros.

El laboratorio consiste en reconstruir en **MySQL 8** la base de datos `austral`, que perdió tablas y relaciones por un error, volver a cargar los datos oficiales y dejar escritas las diez consultas con las que se revisa el negocio. Todo se ejecutó en MySQL Workbench.

## Contenido del repositorio

```
.
├── ICN292-Lab4-Vargas-Franco.pdf   Informe 
├── ICN292-Lab4-Vargas-Franco.docx   Fuente LaTeX del informe
├── ICN292-Lab4-Vargas-Franco.sql   Script completo: creación, carga oficial y consultas
├── ICN292-Lab4-Vargas-Franco.png   Modelo entidad-relación (Workbench, Reverse Engineer)
└── Consultas/                      Capturas de resultados usadas en el informe

```


## Modelo de datos

La base `austral` tiene cuatro tablas:

| Tabla | Columnas | Claves |
|---|---|---|
| `autores` | `id_autor`, `nombre`, `pais`, `genero` | PK: `id_autor` (AUTO_INCREMENT) |
| `colecciones` | `id_coleccion`, `titulo`, `fecha_publicacion` | PK: `id_coleccion` (AUTO_INCREMENT) |
| `libros` | `id_libro`, `id_autor`, `id_coleccion`, `titulo`, `paginas`, `ejemplares_vendidos`, `anio` | PK: `id_libro`; FK: `id_autor` → `autores`, `id_coleccion` → `colecciones` |
| `pagos` | `id_pago`, `id_autor`, `fecha_pago`, `monto` | PK: `id_pago`; FK: `id_autor` → `autores` |

Detalles de tipos:

- `genero` es un `ENUM` con los valores `'Cómic'`, `'Ensayo'`, `'Infantil'`, `'Novela'`, `'Poesía'`, en ese orden, y no admite nulos.
- `pais` admite `NULL` (un autor puede no tener país registrado).
- `fecha_publicacion` y `fecha_pago` son `DATE`; `monto` es `DECIMAL(10,2)`.
- Los identificadores los asigna `AUTO_INCREMENT`; ningún `INSERT` los escribe.

## Carga de datos

- **Carga oficial:** 6 autores y 12 libros, insertados con `INSERT INTO ... VALUES` nombrando las columnas.
- **Datos de prueba (propios):** 2 colecciones y 3 pagos (dos de ellos al mismo autor), necesarios para las consultas 9 y 10.

## Consultas

| N.º | Qué resuelve |
|---|---|
| 1 | Nombre y género de los autores cuyo país no es Chile, incluyendo a quien no tiene país registrado. |
| 2 | Título y páginas de los libros con entre 190 y 220 páginas (ambos incluidos), de menor a mayor. |
| 3 | Una fila con número de libros, suma de ejemplares vendidos, promedio de páginas, año más antiguo y mayor cantidad de ejemplares vendidos de un libro. |
| 4 | Géneros distintos de los autores, ordenados alfabéticamente. |
| 5 | Autores con más de un libro publicado en 2024 y cuántos son. |
| 6 | Los tres libros de 2024 con más de 2000 ejemplares vendidos, de mayor a menor. |
| 7 | `INSERT` del libro «Papel Mojado», `SELECT` antes y después de eliminarlo con `DELETE` filtrando por título. |
| 8 | `UPDATE` que suma 100 ejemplares vendidos a «Cielo de Enero», con `SELECT` previo y posterior. |
| 9 | Título de cada libro con el título y la fecha de publicación de su colección. |
| 10 | Pagos con nombre del autor, fecha y monto; y total pagado a cada autor. |

Las consultas 1 a 6 se ejecutan sobre la carga oficial, antes de las modificaciones de las consultas 7 y 8.

## Cómo reproducir

Requisitos: MySQL 8 y MySQL Workbench.

1. Abre `ICN292-Lab4-Vargas-Franco.sql` en Workbench.
2. Ejecuta el script completo (de principio a fin). Parte con `DROP DATABASE IF EXISTS austral;`, por lo que **elimina y recrea la base `austral`** si ya existía.
3. Si Workbench muestra el error 1175 (*Safe Updates*) en un `UPDATE` o `DELETE` que filtra por título, agrega `SET SQL_SAFE_UPDATES = 0;` después de `USE austral;` o desactiva esa opción en las preferencias del editor SQL.

## Informe

El informe está escrito en LaTeX. Para compilarlo, ten en la misma carpeta el `.tex`, los dos logos y la carpeta `Consultas/`, y compila con `pdflatex` dos veces (para resolver las referencias).
