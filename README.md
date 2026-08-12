# sakila-sql
## Descripción

Proyecto de análisis de datos con SQL utilizando la base de datos **Sakila**.

El objetivo del proyecto es poner en práctica los conocimientos adquiridos en SQL mediante la resolución de diferentes consultas sobre una base de datos relacional.

A lo largo del proyecto se trabajarán consultas simples y avanzadas, relaciones entre tablas, subconsultas, vistas y estructuras de datos temporales, prestando especial atención a las buenas prácticas y a la interpretación de los resultados obtenidos.

## Objetivos

- Explorar y comprender la estructura de una base de datos relacional.
- Realizar consultas SQL sobre una o varias tablas.
- Trabajar con relaciones entre tablas mediante JOINs.
- Utilizar subconsultas.
- Crear y utilizar vistas.
- Trabajar con estructuras de datos temporales.
- Aplicar buenas prácticas para escribir consultas claras y legibles.
- Analizar los resultados obtenidos y comprobar que sean coherentes.

## Herramientas utilizadas

- SQL
- DBeaver
- Git
- GitHub

## Base de datos

El proyecto utiliza la base de datos **Sakila**, que contiene información relacionada con el funcionamiento de un negocio de alquiler de películas.

Antes de comenzar las consultas se realizará una exploración de la base de datos para comprender sus tablas, los datos disponibles y las relaciones existentes entre ellas.

## Estructura del repositorio

- `README.md` → documentación y conclusiones del proyecto.
- `database/` → esquema de la base de datos.
- `queries/` → archivo SQL con las consultas realizadas.

## Desarrollo del proyecto

### 1. Exploración de la base de datos

Antes de comenzar con las consultas se realizó una exploración de la base de datos Sakila para comprender su estructura y las relaciones existentes entre sus tablas.

Sakila representa la actividad de un negocio de alquiler de películas. Entre sus principales tablas se encuentran `film`, que contiene la información de las películas; `actor`, con los datos de los actores y actrices; `customer`, con la información de los clientes; `inventory`, que representa las copias disponibles; y `rental`, donde se registran los alquileres.

Durante la exploración también se analizaron las claves primarias y foráneas para comprender cómo se relacionan las tablas. Por ejemplo, para conocer qué película corresponde a un alquiler es necesario seguir la relación:

`rental → inventory → film`

También existen tablas intermedias como `film_actor` y `film_category`, que permiten relacionar las películas con sus actores y categorías.

Como apoyo para comprender estas relaciones se generó un diagrama entidad-relación (ER) de la base de datos.

### 2. Resolución de consultas

*Pendiente de completar.*

### 3. Análisis de resultados

*Pendiente de completar.*

## 📊 Conclusiones

*Esta sección se completará al finalizar el análisis.*
