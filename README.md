# sakila-sql
#Proyecto de SQL: Sakila

## 1. Descripción del proyecto

Este proyecto forma parte del Máster en Data Analyst de ThePower y consiste en resolver **64 ejercicios de SQL** utilizando la base de datos **Sakila** en PostgreSQL.

Sakila representa la actividad de un negocio de alquiler de películas. Sus tablas permiten consultar información sobre películas, actores, categorías, clientes, inventario, alquileres y pagos.

## 2. Objetivos

- Utilizar DBeaver para explorar y consultar una base de datos PostgreSQL.
- Realizar consultas sobre una sola tabla y sobre varias tablas relacionadas.
- Aplicar filtros, ordenaciones, agrupaciones y funciones de agregación.
- Utilizar diferentes tipos de `JOIN` y subconsultas.
- Crear y consultar vistas y tablas temporales.
- Organizar las consultas con buenas prácticas de legibilidad y documentación.
- Interpretar resultados para extraer conclusiones a partir de los datos disponibles.

## 3. Herramientas utilizadas

| Herramienta | Uso |
|---|---|
| PostgreSQL | Motor de base de datos utilizado para Sakila. |
| DBeaver | Exploración de tablas, visualización de relaciones y ejecución de consultas. |
| GitHub | Publicación del código SQL, el esquema y la documentación del proyecto. |

## 4. Archivos del repositorio

| Archivo | Contenido |
|---|---|
| `README.md` | Metodología, resultados y conclusiones del proyecto. |
| `postgres - Sakila - public.png` | Esquema visual de la base de datos y sus relaciones. |
| `proyecto_sakila_64 - final.sql` | Resolución de los 64 ejercicios, identificados por número y enunciado. |

## 5. Metodología y pasos seguidos

### 5.1. Exploración de Sakila

Se abrió la base de datos Sakila en DBeaver y se revisaron las tablas y sus columnas. Se identificaron claves primarias y foráneas para comprender cómo se relacionan los registros.

Entre las tablas utilizadas se encuentran:

- `film`: catálogo de películas y sus características.
- `actor` y `film_actor`: actores y su participación en películas.
- `category` y `film_category`: categorías asociadas a las películas.
- `customer`: datos de los clientes.
- `inventory`: copias registradas de cada película.
- `rental`: operaciones de alquiler.
- `payment`: importes de los pagos.

Por ejemplo, para conocer qué película corresponde a un alquiler se utiliza la relación `rental → inventory → film`. Para relacionar actores con películas se emplea la tabla intermedia `film_actor`.

Se exportó un esquema visual de la base de datos para facilitar la comprensión de estas relaciones.

### 5.2. Resolución de los ejercicios

Se preparó un archivo SQL con las 64 consultas solicitadas, identificadas con su número y enunciado. Los ejercicios abarcan:

- Consultas básicas: `SELECT`, `WHERE`, `ORDER BY`, `DISTINCT` y `LIMIT`.
- Agregaciones: `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, varianza y desviación estándar.
- Agrupaciones y filtros de grupos: `GROUP BY` y `HAVING`.
- Relaciones entre tablas: `INNER JOIN`, `LEFT JOIN`, `FULL OUTER JOIN` y `CROSS JOIN`.
- Subconsultas para comparar valores o filtrar registros.
- Creación de una vista con `CREATE VIEW`.
- Creación y consulta de tablas temporales con `CREATE TEMP TABLE`.

### 5.3. Comprobación en DBeaver

Se ejecutaron las consultas individualmente en DBeaver, conectado a Sakila, y no se observaron errores de ejecución en las comprobaciones realizadas. También se revisaron de forma específica algunos resultados y objetos creados.

Esta comprobación de ejecución no equivale a una verificación exhaustiva de que cada resultado sea la única interpretación posible de su enunciado.

## 6. Análisis de resultados

Los siguientes resultados corresponden a las consultas ejecutadas sobre la base de datos utilizada en el proyecto. **Los importes se presentan en unidades monetarias**, ya que no se ha verificado una moneda concreta para los datos.

### 6.1. Ingresos registrados — Ejercicio 15

La suma de los importes registrados en la tabla de pagos asciende a **67.416,51 unidades monetarias**.

Este valor representa el importe acumulado de los pagos contenidos en la base de datos consultada. Por sí solo no permite determinar beneficios, costes ni evolución temporal de los ingresos.

### 6.2. Clientes con mayor gasto — Ejercicio 34

Se agruparon los pagos por cliente para identificar los cinco con mayor gasto acumulado:

| Posición | Cliente | Gasto acumulado |
|---:|---|---:|
| 1 | Karl Seal | 221,55 |
| 2 | Eleanor Hunt | 216,54 |
| 3 | Clara Shaw | 195,58 |
| 4 | Rhonda Kennedy | 194,61 |
| 5 | Marion Snyder | 194,61 |

Estos cinco clientes acumulan **1.022,89 unidades monetarias**, aproximadamente el **1,52 %** del importe total registrado. La clasificación identifica a los clientes con mayor gasto, pero no basta por sí sola para describir la distribución del gasto de toda la clientela.

### 6.3. Alquileres por categoría — Ejercicio 61

Se relacionaron las tablas de categorías, películas, inventario y alquileres para contar las operaciones de alquiler asociadas a cada categoría.

| Categoría | Alquileres |
|---|---:|
| Sports | 1.179 |
| Animation | 1.166 |
| Action | 1.112 |
| Sci-Fi | 1.101 |
| Family | 1.096 |
| Drama | 1.060 |
| Documentary | 1.050 |
| Foreign | 1.033 |
| Games | 969 |
| Children | 945 |
| Comedy | 941 |
| New | 940 |
| Classics | 939 |
| Horror | 846 |
| Travel | 837 |
| Music | 830 |

**Sports** registra el mayor número de alquileres (1.179), seguida de **Animation** (1.166) y **Action** (1.112). **Music** presenta el menor recuento (830). La diferencia entre Sports y Music es de **349 alquileres**.

Estos datos describen la actividad registrada por categoría, pero no demuestran por sí solos cuáles son las preferencias relativas de los clientes: para compararlas con mayor precisión sería útil tener en cuenta el número de títulos y copias disponibles en cada categoría.

### 6.4. Duración media por clasificación — Ejercicio 13

Se calculó la duración media de las películas agrupadas según su clasificación por edades:

| Clasificación | Duración media (minutos) |
|---|---:|
| G | 111,05 |
| PG | 112,01 |
| PG-13 | 120,44 |
| R | 118,66 |
| NC-17 | 113,23 |

Las películas **PG-13** presentan la mayor duración media (**120,44 minutos**), mientras que las clasificadas como **G** presentan la menor (**111,05 minutos**). La diferencia es de **9,39 minutos**.

Se observan variaciones descriptivas entre grupos, pero estos resultados no permiten atribuir la duración de una película a su clasificación por edades.

## 7. Particularidades y decisiones técnicas

- **Ejercicio 4, Idioma original:** la comparación entre `language_id` y `original_language_id` no devolvió registros. Se comprobó que `original_language_id` estaba sin informar (`NULL`) en las 1.000 películas de la instalación utilizada. Esto explica el resultado vacío sin implicar un error de ejecución.
- **Ejercicio 11, Antepenúltimo alquiler:** se tomó el tercer alquiler desde el final al ordenar por fecha y utilizar el identificador para resolver posibles empates. El importe se obtuvo a partir de los pagos asociados.
- **Ejercicio 29, Copias en inventario:** se incluyeron todas las películas, incluso aquellas con cero copias registradas. El recuento de copias en inventario no equivale necesariamente al número de copias disponibles para alquilar en un momento concreto.
- **Ejercicio 44, CROSS JOIN:** genera todas las combinaciones posibles entre películas y categorías, sin respetar sus relaciones reales. Para identificar las categorías asociadas a cada película resulta más adecuado utilizar `film_category`. La justificación solicitada en el enunciado también se conserva después de la consulta en el archivo SQL.
- **Ejercicio 48, Vista:** se creó y consultó `actor_num_peliculas`, que muestra actores y número de películas asociadas.
- **Ejercicios 51 y 52, Tablas temporales:** se crearon estructuras temporales para almacenar, respectivamente, el número de alquileres por cliente y las películas alquiladas al menos diez veces. Estas tablas están vinculadas a la sesión de base de datos en la que se crean.

## 8. Conclusiones

El proyecto ha permitido practicar SQL sobre una base de datos relacional con varias tablas conectadas. Una parte importante del trabajo ha sido identificar qué tablas contienen cada dato y cómo relacionarlas mediante claves para responder a las preguntas planteadas.

Los resultados analizados muestran un importe acumulado de pagos de **67.416,51**, permiten identificar a los clientes con mayor gasto y muestran diferencias en el número de alquileres por categoría y en la duración media de las películas por clasificación.

También se ha comprobado que interpretar los resultados requiere conocer las limitaciones de los datos: una consulta puede ejecutarse correctamente y devolver cero filas, o una cifra puede necesitar contexto adicional antes de convertirse en una conclusión de negocio.

Finalmente, el uso de vistas, tablas temporales y documentación en GitHub permite organizar y presentar las consultas de forma reproducible y comprensible.
