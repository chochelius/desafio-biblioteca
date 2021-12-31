-- Creando base de datos

postgres=# CREATE DATABASE biblioteca;
CREATE DATABASE
postgres=# \c biblioteca
Ahora está conectado a la base de datos «biblioteca» con el usuario «administrador».

-- creando tablas

biblioteca=# CREATE TABLE socio(rut VARCHAR(10) PRIMARY KEY, nombre VARCHAR(15), apellido VARCHAR(15), direccion VARCHAR(30), telefono INT);
CREATE TABLE
biblioteca=# SELECT * FROM socio;
 rut | nombre | apellido | direccion | telefono
-----+--------+----------+-----------+----------
(0 filas)

biblioteca=# CREATE TABLE autor(codigo_autor INT PRIMARY KEY, tipo_autor VARCHAR(10), nombre VARCHAR(15), apellido VARCHAR(15), nacimiento INT, defuncion INT);
CREATE TABLE
biblioteca=# SELECT * FROM autor;
 codigo_autor | tipo_autor | nombre | apellido | nacimiento | defuncion
--------------+------------+--------+----------+------------+-----------
(0 filas)

biblioteca=# CREATE TABLE libro(isbn VARCHAR(15) PRIMARY KEY, codigo_autor INT REFERENCES autor(codigo_autor), codigo_coautor INT REFERENCES autor(codigo_autor), titulo VARCHAR(50), paginas INT);
CREATE TABLE
biblioteca=# SELECT * FROM libro;
 isbn | codigo_autor | codigo_coautor | titulo | paginas
------+--------------+----------------+--------+---------
(0 filas)

biblioteca=# CREATE TABLE libro_autor(id SERIAL PRIMARY KEY, isbn VARCHAR(15) REFERENCES libro(isbn), codigo_autor INT REFERENCES autor(codigo_autor));
CREATE TABLE
biblioteca=# SELECT * FROM libro_autor;
 id | isbn | codigo_autor
----+------+--------------
(0 filas)

biblioteca=# CREATE TABLE prestamo(id SERIAL PRIMARY KEY, socio_rut VARCHAR(10) REFERENCES socio(rut), id_libro VARCHAR(15) REFERENCES libro(isbn), inicio DATE, devolucion_esp DATE, devolucion DATE, dias INT);
CREATE TABLE
biblioteca=# SELECT * FROM prestamo;
 id | socio_rut | id_libro | inicio | devolucion_esp | devolucion | dias
----+-----------+----------+--------+----------------+------------+------
(0 filas)

-- insertar datos

biblioteca=# INSERT INTO socio (rut, nombre, apellido, direccion, telefono) VALUES ('1111111-1', 'JUAN', 'SOTO', 'AVENIDA 1, SANTIAGO', 911111111), ('2222222-2', 'ANA', 'PEREZ', 'PASAJE 2, SANTIAGO', 922222222), ('3333333-3', 'SANDRA', 'AGUILAR', 'AVENIDA 2, SANTIAGO', 933333333), ('4444444-4', 'ESTEBAN', 'JEREZ', 'AVENIDA 3, SANTIAGO', 944444444), ('5555555-5', 'SILVANA', 'MUÑOZ', 'PASAJE 3, SANTIAGO', 955555555);
INSERT 0 5
biblioteca=# SELECT * FROM socio;
    rut    | nombre  | apellido |      direccion      | telefono
-----------+---------+----------+---------------------+-----------
 1111111-1 | JUAN    | SOTO     | AVENIDA 1, SANTIAGO | 911111111
 2222222-2 | ANA     | PEREZ    | PASAJE 2, SANTIAGO  | 922222222
 3333333-3 | SANDRA  | AGUILAR  | AVENIDA 2, SANTIAGO | 933333333
 4444444-4 | ESTEBAN | JEREZ    | AVENIDA 3, SANTIAGO | 944444444
 5555555-5 | SILVANA | MUÑOZ    | PASAJE 3, SANTIAGO  | 955555555
(5 filas)

biblioteca=# INSERT INTO autor (codigo_autor, tipo_autor, nombre, apellido, nacimiento, defuncion) VALUES (1, 'PRINCIPAL', 'ANDRES', 'ULLOA', 1982, NULL), (2, 'PRINCIPAL', 'SERGIO', 'MARDONES', 1950, 2012), (3, 'PRINCIPAL', 'JOSE', 'SALGADO', 1968, 2020), (4, 'COAUTOR', 'ANA', 'SALGADO', 1972, NULL), (5, 'PRINCIPAL', 'MARTIN', 'PORTA', 1976, NULL);
INSERT 0 5
biblioteca=# SELECT * FROM autor;
 codigo_autor | tipo_autor | nombre | apellido | nacimiento | defuncion
--------------+------------+--------+----------+------------+-----------
            1 | PRINCIPAL  | ANDRES | ULLOA    |       1982 |
            2 | PRINCIPAL  | SERGIO | MARDONES |       1950 |      2012
            3 | PRINCIPAL  | JOSE   | SALGADO  |       1968 |      2020
            4 | COAUTOR    | ANA    | SALGADO  |       1972 |
            5 | PRINCIPAL  | MARTIN | PORTA    |       1976 |
(5 filas)

biblioteca=# INSERT INTO libro (isbn, codigo_autor, codigo_coautor, titulo, paginas) VALUES ('111-1111111-111', 3, 4, 'CUENTOS DE TERROR', 344), ('222-2222222-222', 1 , NULL, 'POESÍAS CONTEMPORANEAS', 167), ('333-3333333-333', 2, NULL, 'HISTORIA DE ASIA', 511), ('444-4444444-444', 5, NULL, 'MANUAL DE MECÁNICA', 298);
INSERT 0 4
biblioteca=# SELECT * FROM libro;
      isbn       | codigo_autor | codigo_coautor |         titulo         | paginas
-----------------+--------------+----------------+------------------------+---------
 111-1111111-111 |            3 |              4 | CUENTOS DE TERROR      |     344
 222-2222222-222 |            1 |                | POESÍAS CONTEMPORANEAS |     167
 333-3333333-333 |            2 |                | HISTORIA DE ASIA       |     511
 444-4444444-444 |            5 |                | MANUAL DE MECÁNICA     |     298
(4 filas)

biblioteca=# INSERT INTO libro_autor (isbn, codigo_autor) VALUES ('111-1111111-111', 3), ('111-1111111-111', 4), ('222-2222222-222', 1), ('333-3333333-333', 2), ('444-4444444-444', 5);
INSERT 0 5
biblioteca=# SELECT * FROM libro_autor;
 id |      isbn       | codigo_autor
----+-----------------+--------------
  1 | 111-1111111-111 |            3
  2 | 111-1111111-111 |            4
  3 | 222-2222222-222 |            1
  4 | 333-3333333-333 |            2
  5 | 444-4444444-444 |            5
(5 filas)

biblioteca=# INSERT INTO prestamo (socio_rut, id_libro, inicio, devolucion, dias) VALUES ('1111111-1', '111-1111111-111', '2020-01-20', '2020-01-27', 7), ('5555555-5', '222-2222222-222', '2020-01-20', '2020-01-27', 7), ('3333333-3', '333-3333333-333', '2020-01-22', '2020-02-05', 14), ('4444444-4', '444-4444444-444', '2020-01-23', '2020-02-06', 14), ('2222222-2', '111-1111111-111', '2020-01-27', '2020-02-03', 7), ('1111111-1', '444-4444444-444', '2020-01-31', '2020-02-14', 14), ('3333333-3', '222-2222222-222', '2020-01-31', '2020-02-07', 7);
INSERT 0 7
biblioteca=# SELECT * FROM prestamo;
 id | socio_rut |    id_libro     |   inicio   | devolucion_esp | devolucion | dias
----+-----------+-----------------+------------+----------------+------------+------
  1 | 1111111-1 | 111-1111111-111 | 2020-01-20 |                | 2020-01-27 |    7
  2 | 5555555-5 | 222-2222222-222 | 2020-01-20 |                | 2020-01-27 |    7
  3 | 3333333-3 | 333-3333333-333 | 2020-01-22 |                | 2020-02-05 |   14
  4 | 4444444-4 | 444-4444444-444 | 2020-01-23 |                | 2020-02-06 |   14
  5 | 2222222-2 | 111-1111111-111 | 2020-01-27 |                | 2020-02-03 |    7
  6 | 1111111-1 | 444-4444444-444 | 2020-01-31 |                | 2020-02-14 |   14
  7 | 3333333-3 | 222-2222222-222 | 2020-01-31 |                | 2020-02-07 |    7
(7 filas)

-- mostrar libros de menos de 300pag

biblioteca=# SELECT * FROM libro WHERE paginas < 300;
      isbn       | codigo_autor | codigo_coautor |         titulo         | paginas
-----------------+--------------+----------------+------------------------+---------
 222-2222222-222 |            1 |                | POESÍAS CONTEMPORANEAS |     167
 444-4444444-444 |            5 |                | MANUAL DE MECÁNICA     |     298
(2 filas)

-- mostrar autores nacidos despues del 01-01-1970

biblioteca=# SELECT * FROM autor WHERE nacimiento >= '1970';
 codigo_autor | tipo_autor | nombre | apellido | nacimiento | defuncion
--------------+------------+--------+----------+------------+-----------
            1 | PRINCIPAL  | ANDRES | ULLOA    |       1982 |
            4 | COAUTOR    | ANA    | SALGADO  |       1972 |
            5 | PRINCIPAL  | MARTIN | PORTA    |       1976 |
(3 filas)

-- libro más solicitado


biblioteca=# SELECT COUNT(isbn), libro.titulo FROM prestamo LEFT JOIN libro ON prestamo.id_libro = libro.isbn GROUP BY prestamo.id_libro, libro.titulo HAVING COUNT (isbn)=(SELECT MAX(maxlibro) FROM (SELECT COUNT(isbn) maxlibro FROM prestamo GROUP BY id_libro) as libro) LIMIT 2;
 count |         titulo
-------+------------------------
     2 | POESÍAS CONTEMPORANEAS
     2 | CUENTOS DE TERROR
(2 filas)


-- la última no la supe hacer.
