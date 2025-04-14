-- REFACTORIZACIÓN CICLO 
-- === CICLO 1: TABLAS
CREATE TABLE universidades (
    codigo CHAR(3) NOT NULL,
    nombre VARCHAR2(20) NOT NULL,
    direccion VARCHAR2(50) NOT NULL,
    codigoUsuario CHAR(10) NOT NULL 
    );
    
CREATE TABLE usuarios ( 
    codigo CHAR(10) NOT NULL,
    codigoUniversidad CHAR(3) NOT NULL,
    tid VARCHAR2(2) NOT NULL,
    nid CHAR(10) NOT NULL,
    nombre VARCHAR2(50) NOT NULL,
    programa VARCHAR2(50) NOT NULL,
    correo VARCHAR2(50) NOT NULL,
    registro DATE NOT NULL,
    suspension DATE,
    nSuspensiones NUMBER(3) NOT NULL
    );

-- Up - codigoUsuario(10)
CREATE TABLE calificaciones (
    codigoUniversidad CHAR(3) NOT NULL,
    codigoUsuario CHAR(3) NOT NULL,
    estrellas NUMBER(1) NOT NULL,
    codigoArticulo NUMBER(16) NOT NULL
    );
    


CREATE TABLE articulos (
    idArticulo NUMBER(16) NOT NULL,
    descripcion CHAR(20) NOT NULL,
    idCaracteristicas number(10) NOT NULL,
    estado CHAR(1) NOT NULL,
    foto VARCHAR2(100) NOT NULL,
    precio NUMBER(3) NOT NULL,
    disponible VARCHAR2(5) NOT NULL,
    codigoCategoria VARCHAR(5) NOT NULL,
    codigoUsuario CHAR(10) NOT NULL,
    codigoUniversidad CHAR(3) NOT NULL
    );
    
CREATE TABLE caracteristicas(
    id NUMBER(10) NOT NULL,
    descripcion VARCHAR2(20) NOT NULL
);
    
CREATE TABLE ropa (
    idArticulo NUMBER(16) NOT NULL,
    talla VARCHAR2(2) NOT NULL,
    material VARCHAR2(10) NOT NULL, 
    color VARCHAR2(10) NOT NULL
    );
      
CREATE TABLE perecederos (
    idArticulo NUMBER(16) NOT NULL,
    vencimiento DATE NOT NULL
    );

CREATE TABLE evaluaciones (
    a_omes VARCHAR2(6) NOT NULL,
    tid VARCHAR2(2) NOT NULL,
    nid VARCHAR2(10) NOT NULL,
    fecha DATE NOT NULL,
    descripcion VARCHAR2(100),
    reporte VARCHAR2(100) NOT NULL,
    resultado VARCHAR2(2) NOT NULL,
    idRespuesta number(10) NOT NULL
    );

CREATE TABLE respuestas(
    idRespuesta number(10) NOT NULL,
    respuestas VARCHAR2(50) NOT NULL 
);

CREATE TABLE auditorias (
    idAuditoria VARCHAR2(2) NOT NULL,
    fecha DATE NOT NULL,
    accion VARCHAR2(1) NOT NULL,
    nombre VARCHAR2(20) NOT NULL,
    codigoCategoria VARCHAR2(5),
    codigo_a_omes VARCHAR2(6) NOT NULL
    );
    
CREATE TABLE categorias (
    codigo VARCHAR2(5) NOT NULL,
    nombre VARCHAR2(20) NOT NULL,
    tipo CHAR (1) NOT NULL,
    minimo NUMBER(3) NOT NULL,
    maximo NUMBER(3) NOT NULL,
    codigo1 VARCHAR2(5) 
    ); 

-- === CICLO 1: XTablas
/*
DROP TABLE universidades;
DROP TABLE usuarios;
DROP TABLE calificaciones;
DROP TABLE ropa;
DROP TABLE articulos;
DROP TABLE caracteristicas;
DROP TABLE perecederos;
DROP TABLE evaluaciones;
DROP TABLE categorias; 
DROP TABLE auditorias;
DROP TABLE respuestas

CREATE DOMAIN = CHECK
TUPLA = CHECK LIKE

*/
-- === CICLO 1: PoblarOK(1)

-- === CICLO 1: XPoblar (Eliminar los datos)

TRUNCATE TABLE universidades;
TRUNCATE TABLE usuarios;
TRUNCATE TABLE calificaciones;
TRUNCATE TABLE ropa;
TRUNCATE TABLE articulos; 
TRUNCATE TABLE perecederos;
TRUNCATE TABLE evaluaciones;
TRUNCATE TABLE categorias; 
TRUNCATE TABLE auditorias;


-- === CICLO 1: Atributos
   
-- === CICLO 1: Primarias

ALTER TABLE usuarios 
ADD CONSTRAINT PK_usuarios PRIMARY KEY (codigo,codigoUniversidad);

ALTER TABLE universidades 
ADD CONSTRAINT PK_universidades PRIMARY KEY (codigo,codigoUsuario);

ALTER TABLE usuarios
DROP CONSTRAINT PK_usuarios;

ALTER TABLE calificaciones
ADD CONSTRAINT PK_calificaciones PRIMARY KEY (codigoUsuario,codigoUniversidad,codigoArticulo); 

ALTER TABLE articulos
ADD CONSTRAINT PK_articulos PRIMARY KEY (idArticulo);

ALTER TABLE caracteristicas
ADD CONSTRAINT PK_caracteristicas PRIMARY KEY (id);

ALTER TABLE ropa
ADD CONSTRAINT PK_ropa PRIMARY KEY (idArticulo);

ALTER TABLE perecederos
ADD CONSTRAINT PK_perecederos PRIMARY KEY (idArticulo);

ALTER TABLE evaluaciones
ADD CONSTRAINT PK_evaluaciones PRIMARY KEY (a_omes);

ALTER TABLE categorias
ADD CONSTRAINT PK_categorias PRIMARY KEY (codigo);

ALTER TABLE auditorias
ADD CONSTRAINT PK_auditorias PRIMARY KEY (idAuditoria);

ALTER TABLE respuestas
ADD CONSTRAINT PK_respuestas PRIMARY KEY (idRespuesta)


-- === CICLO 1: Únicas

ALTER TABLE usuarios 
ADD CONSTRAINT UK_usuarios UNIQUE (tid);

ALTER TABLE usuarios
DROP CONSTRAINT UK_usuarios;

ALTER TABLE usuarios 
ADD CONSTRAINT UK2_usuarios UNIQUE (nid);

ALTER TABLE articulos 
ADD CONSTRAINT UK_articulos UNIQUE (foto);

ALTER TABLE evaluaciones
ADD CONSTRAINT UK_evaluaciones UNIQUE (reporte);

ALTER TABLE universidades
ADD CONSTRAINT UK_codigo_usuarios UNIQUE (codigoUsuario);


-- === CICLO 1: Foráneas

-- Resolvemos relación todo parte en donde si se elimina una universidad, se eliminan todos los usuarios asociados a esa universidad
ALTER TABLE usuarios ADD CONSTRAINT FK_usuario_universidad 
FOREIGN KEY (codigoUniversidad,codigo) REFERENCES universidades(codigo,codigoUsuario); --

ALTER TABLE universidades ADD CONSTRAINT FK_universidades_usuarios
FOREIGN KEY (codigoUsuario,codigo) REFERENCES usuarios(codigo,codigoUniversidad); --

ALTER TABLE calificaciones ADD CONSTRAINT FK_calificacionUsuario
FOREIGN KEY (codigoUsuario,codigoUniversidad) REFERENCES usuarios(codigo,codigoUniversidad);   -- ya se creo

ALTER TABLE calificaciones ADD CONSTRAINT FK_calificacionArticulo -- ya se creos
FOREIGN KEY (codigoArticulo) REFERENCES articulos(idArticulo);

ALTER TABLE ropa ADD CONSTRAINT FK_ropaArticulo
FOREIGN KEY (idArticulo) REFERENCES articulos(idArticulo);

ALTER TABLE perecederos ADD CONSTRAINT FK_perecederoArticulo
FOREIGN KEY (idArticulo) REFERENCES articulos(idArticulo);

ALTER TABLE articulos ADD CONSTRAINT FK_articulos_caracteristicas
FOREIGN KEY (idCaracteristicas) REFERENCES caracteristicas(id);--

ALTER TABLE articulos ADD CONSTRAINT FK_articuloCategoria
FOREIGN KEY (codigoCategoria) REFERENCES categorias(codigo);

ALTER TABLE articulos 
ENABLE CONSTRAINT FK_articuloCategoria;


ALTER TABLE articulos ADD CONSTRAINT FK_articuloUsuario
FOREIGN KEY (codigoUsuario,codigoUniversidad) REFERENCES usuarios(codigo,codigoUniversidad);

ALTER TABLE evaluaciones ADD CONSTRAINT FK_evaluaciones_respuestas
FOREIGN KEY (idRespuesta) REFERENCES respuestas(idRespuesta);

ALTER TABLE auditorias ADD CONSTRAINT FK_auditoriasCategoria
FOREIGN KEY (codigoCategoria) REFERENCES categorias(codigo);

ALTER TABLE auditorias ADD CONSTRAINT FK_auditorias_evaluaciones
FOREIGN KEY (codigo_a_omes) REFERENCES evaluaciones(a_omes);

ALTER TABLE categorias ADD CONSTRAINT FK_categoriaCategoria
FOREIGN KEY (codigo1) REFERENCES categorias(codigo);

ALTER TABLE  categorias
ENABLE CONSTRAINT FK_categoriaCategoria;



-- === CICLO 1: PoblarNoOK(2)

-- Para la tabla usuarios

ALTER TABLE usuarios
ADD CONSTRAINT tid_check CHECK (tid IN ('CC', 'TI'));

ALTER TABLE usuarios
ADD CONSTRAINT correo_check CHECK (REGEXP_LIKE(correo, '^[^\s@]+@[^\s@]+\.[^\s@]{2,}$'));

-- Para la tabla calificaciones
ALTER TABLE calificaciones
ADD CONSTRAINT estrellas_check CHECK (estrellas BETWEEN 1 AND 5);

-- Para la tabla articulos
ALTER TABLE articulos
ADD CONSTRAINT idArticulo_check CHECK (REGEXP_LIKE(idArticulo, '^\d{16}$'));

ALTER TABLE articulos
ADD CONSTRAINT estado_check CHECK (estado IN ('U', 'N'));

ALTER TABLE articulos
ADD CONSTRAINT foto_check CHECK (REGEXP_LIKE(foto, '^https:\/\/.*\.pdf$'));

ALTER TABLE articulos
ADD CONSTRAINT precio_check CHECK (precio IN (50, 100, 150, 200, 250));

-- Para la tabla ropa
ALTER TABLE ropa
ADD CONSTRAINT talla_check CHECK (talla IN ('XS', 'S', 'M', 'L', 'XL'));

-- Para la tabla evaluaciones
ALTER TABLE evaluaciones
ADD CONSTRAINT a_omes_check CHECK (REGEXP_LIKE(a_omes, '^\d{6}$') AND TO_NUMBER(SUBSTR(a_omes, 1, 4)) > 2000 AND TO_NUMBER(SUBSTR(a_omes, 5, 2)) BETWEEN 1 AND 12); 
--Cadena (6)AAAAMM ;AAAA mayor a 2000; MM entre 01 y 12

ALTER TABLE evaluaciones
ADD CONSTRAINT descripcion_check CHECK (INSTR(descripcion, '(A)') > 0 OR INSTR(descripcion, '(M)') > 0 OR INSTR(descripcion, '(B)') > 0);

ALTER TABLE evaluaciones
ADD CONSTRAINT reporte_check CHECK (REGEXP_LIKE(reporte, '^https:\/\/.*\.pdf$'));

ALTER TABLE evaluaciones
ADD CONSTRAINT resultado_check CHECK (resultado IN ('AP', 'PE'));

-- Para la tabla auditorias
ALTER TABLE auditorias
ADD CONSTRAINT id_check CHECK (idAuditoria > 0);

ALTER TABLE auditorias
ADD CONSTRAINT accion_check CHECK (accion IN ('I', 'D', 'U'));

-- Para la tabla categorías
ALTER TABLE categorias
ADD CONSTRAINT tipo_check CHECK (tipo IN ('A', 'R', 'L', 'T', 'O'));

ALTER TABLE categorias
ADD CONSTRAINT minimo_check CHECK (minimo IN (50, 100, 150, 200, 250));

ALTER TABLE categorias
ADD CONSTRAINT maximo_check CHECK (maximo IN (50, 100, 150, 200, 250));

-- INVENTADOS
/*
ALTER TABLE articulos
ADD CONSTRAINT chk_PrecioMayorOIgualA100 CHECK (precio >= 100);

ALTER TABLE articulos
ADD CONSTRAINT chk_EstadoArticulo 
CHECK (estado IN ('nuevo', 'usado', 'dañado'));

ALTER TABLE articulos DROP CONSTRAINT chk_EstadoArticulo;
*/
-- CICLO 1: CRUD : Mantener categoría + Generar registro de auditoría
-- Atributos
-- En la sección creación tablas
-- Tuplas
/*
ALTER TABLE usuarios 
ADD CONSTRAINT PK_usuarios PRIMARY KEY (codigo,codigoUniversidad);

ALTER TABLE universidades 
ADD CONSTRAINT PK_universidades PRIMARY KEY (codigo,codigoUsuario);

ALTER TABLE calificaciones
ADD CONSTRAINT PK_calificaciones PRIMARY KEY (codigoUsuario,codigoUniversidad,codigoArticulo); 

ALTER TABLE usuarios ADD CONSTRAINT FK_usuario_niversidad 
FOREIGN KEY (codigoUniversidad,codigo) REFERENCES universidades(codigo,codigoUsuario); --

ALTER TABLE universidades 
ADD CONSTRAINT FK_universidades_usuarios
FOREIGN KEY (codigoUsuario,codigo) REFERENCES usuarios(codigo,codigoUniversidad); --

ALTER TABLE calificaciones ADD CONSTRAINT FK_calificacionUsuario
FOREIGN KEY (codigoUsuario,codigoUniversidad) REFERENCES usuarios(codigo,codigoUniversidad);

ALTER TABLE articulos ADD CONSTRAINT FK_articuloUsuario
FOREIGN KEY (codigoUsuario,codigoUniversidad) REFERENCES usuarios(codigo,codigoUniversidad);
*/
-- TuplasOK
-- ====================================================================================
-- Insertar datos en la tabla universidades INSERTADOS
INSERT INTO universidades (codigo, nombre, direccion, codigoUsuario) VALUES ('001', 'Universidad A', 'Dirección A', 'codigoU1'); 
INSERT INTO universidades (codigo, nombre, direccion, codigoUsuario) VALUES ('002', 'Universidad B', 'Dirección B', 'codigoU2');
INSERT INTO universidades (codigo, nombre, direccion, codigoUsuario) VALUES ('003', 'Universidad C', 'Dirección C', 'codigoU3');


-- ====================================================================================

-- Insertar datos en la tabla usuarios INSERTADOS
INSERT INTO usuarios (codigo, codigoUniversidad, tid, nid, nombre, programa, correo, registro, suspension, nSuspensiones); 
VALUES('codigoU1', '001', 'CC', '1234567890', 'Usuario 1', 'Programa 1', 'correo_valido@example.com', CURRENT_DATE, NULL, 0);

INSERT INTO usuarios (codigo, codigoUniversidad, tid, nid, nombre, programa, correo, registro, suspension, nSuspensiones) 
VALUES ('codigoU2', '002', 'TI', '0987654321', 'Usuario 2', 'Programa 2', 'correo_valido1@example.com', CURRENT_DATE, NULL, 0);
INSERT INTO usuarios (codigo, codigoUniversidad, tid, nid, nombre, programa, correo, registro, suspension, nSuspensiones) 
VALUES('codigoU3', '003', 'CC', '1357908642', 'Usuario 3', 'Programa 3', 'correo@example.com', CURRENT_DATE, NULL, 0);
 
-- ====================================================================================
-- Insertar datos en la tabla calificaciones - INSERTADOS

INSERT INTO calificaciones (codigoUniversidad, codigoUsuario, estrellas, codigoArticulo) VALUES ('001', 'codigoU1', 4, 1234567890123456);

INSERT INTO calificaciones (codigoUniversidad, codigoUsuario, estrellas, codigoArticulo) VALUES ('002', 'codigoU2', 5, 6543210987654321);

INSERT INTO calificaciones (codigoUniversidad, codigoUsuario, estrellas, codigoArticulo) VALUES ('003', 'codigoU3', 3, 9876543210123456);


-- ==================================================================================== 
-- Insertar datos en la tabla articulos - INSERTADOS

INSERT INTO articulos (idArticulo, descripcion, idCaracteristicas, estado, foto, precio, disponible, codigoCategoria, codigoUsuario, codigoUniversidad)
VALUES (1234567890123456, 'Artículo 1', 1, 'U', 'https://example.com/articulo1.pdf', 100, 'Si', '001', 'codigoU1', '001');

INSERT INTO articulos (idArticulo, descripcion, idCaracteristicas, estado, foto, precio, disponible, codigoCategoria, codigoUsuario, codigoUniversidad)
VALUES (6543210987654321, 'Artículo 2', 2, 'N', 'https://example.com/articulo2.pdf', 150, 'No', '002', 'codigoU2', '002');

INSERT INTO articulos (idArticulo, descripcion, idCaracteristicas, estado, foto, precio, disponible, codigoCategoria, codigoUsuario, codigoUniversidad)
VALUES (9876543210123456, 'Artículo 3', 3, 'U', 'https://example.com/articulo3.pdf', 200, 'Si', '003', 'codigoU3', '003');


-- ====================================================================================
-- Insertar datos en la tabla caracteristicas - INSERTADOS
INSERT INTO caracteristicas (id, descripcion) VALUES (1, 'Caracteristica 1');
INSERT INTO caracteristicas (id, descripcion) VALUES (2, 'Caracteristica 2');
INSERT INTO caracteristicas (id, descripcion) VALUES (3, 'Caracteristica 3');


-- ==================================================================================== 
-- Insertar datos en la tabla ropa - INSERTADOS

INSERT INTO ropa (idArticulo, talla, material, color) VALUES (1234567890123456, 'M', 'Algodón', 'Azul');

INSERT INTO ropa (idArticulo, talla, material, color) VALUES (6543210987654321, 'L', 'Seda', 'Rojo');

INSERT INTO ropa (idArticulo, talla, material, color) VALUES (9876543210123456, 'XL', 'Lana', 'Verde');

-- ====================================================================================  
 
-- Insertar datos en la tabla perecederos - INSERTADOS

INSERT INTO perecederos (idArticulo, vencimiento) VALUES (1234567890123456, TO_DATE('2024-04-30', 'YYYY-MM-DD'));

INSERT INTO perecederos (idArticulo, vencimiento) VALUES (6543210987654321, TO_DATE('2024-05-15', 'YYYY-MM-DD'));

INSERT INTO perecederos (idArticulo, vencimiento) VALUES (9876543210123456, TO_DATE('2024-03-31', 'YYYY-MM-DD'));
 
 
-- ====================================================================================  
-- Insertar datos en la tabla evaluaciones - INSERTADO

INSERT INTO evaluaciones (a_omes, tid, nid, fecha, descripcion, reporte, resultado, idRespuesta)
VALUES ('202401', 'CC', '1234567890', CURRENT_DATE, '(A)Descripción evaluación 1', 'https://example.com/evaluacion1.pdf', 'AP', 1);

INSERT INTO evaluaciones (a_omes, tid, nid, fecha, descripcion, reporte, resultado, idRespuesta)
VALUES ('202402', 'TI', '0987654321', CURRENT_DATE, '(M)Descripción evaluación 2', 'https://example.com/evaluacion2.pdf', 'PE', 2);

INSERT INTO evaluaciones (a_omes, tid, nid, fecha, descripcion, reporte, resultado, idRespuesta)
VALUES ('202403', 'CC', '1357908642', CURRENT_DATE, '(B)Descripción evaluación 3', 'https://example.com/evaluacion3.pdf', 'AP', 3);



-- ====================================================================================  
-- Insertar datos en la tabla respuestas - INSERTADO

INSERT INTO respuestas (idRespuesta, respuestas) VALUES (1, 'Respuesta 1');

INSERT INTO respuestas (idRespuesta, respuestas) VALUES (2, 'Respuesta 2');

INSERT INTO respuestas (idRespuesta, respuestas) VALUES (3, 'Respuesta 3');

-- ====================================================================================   
-- Insertar datos en la tabla auditorias - INSERTADO

INSERT INTO auditorias (idAuditoria, fecha, accion, nombre, codigoCategoria, codigo_a_omes) 
VALUES ('01', CURRENT_DATE, 'I', 'Nombre 1', 'C001', '202401');

INSERT INTO auditorias (idAuditoria, fecha, accion, nombre, codigoCategoria, codigo_a_omes) 
VALUES ('02', CURRENT_DATE, 'D', 'Nombre 2', 'B002', '202402');

INSERT INTO auditorias (idAuditoria, fecha, accion, nombre, codigoCategoria, codigo_a_omes) 
VALUES ('03', CURRENT_DATE, 'U', 'Nombre 3', 'A003', '202403');
 
-- ====================================================================================   
-- Insertar datos en la tabla categorias - INSERTADO

INSERT INTO categorias (codigo, nombre, tipo, minimo, maximo, codigo1) VALUES ('001', 'Categoria 1', 'A', 50, 150, '002');

INSERT INTO categorias (codigo, nombre, tipo, minimo, maximo, codigo1) VALUES ('002', 'Categoria 2', 'R', 100, 200, '003');

INSERT INTO categorias (codigo, nombre, tipo, minimo, maximo, codigo1) VALUES ('003', 'Categoria 3', 'L', 150, 250, NULL)

-- TuplasNoOK
-- Se violó la restricción de integridad referencial de universidades dado que se está intentando ingresar una universidad cuyo representante (codigoUsuario no existe)
INSERT INTO universidades (codigo, nombre, direccion, codigoUsuario) VALUES ('001', 'Universidad A', 'Dirección A', 'codigoU100'); 
INSERT INTO universidades (codigo, nombre, direccion, codigoUsuario) VALUES ('002', 'Universidad B', 'Dirección B', 'codigoU20');
INSERT INTO universidades (codigo, nombre, direccion, codigoUsuario) VALUES ('003', 'Universidad C', 'Dirección C', 'codigoU31');

-- Se violó la restricción de integridad referencial de calificaciones dado que se esta intentando crear una calificacion con una universidad que no existe que no existe, lo cual daría origen a una llave primaria nula
INSERT INTO calificaciones (codigoUniversidad, codigoUsuario, estrellas, codigoArticulo) VALUES ('001', 'codigoU10', 4, 1234567890123456);

-- Atributos

-- ADICIONAR
-- Los códigos deben iniciar con una letra mayúscula - FUNCIONA 
ALTER TABLE categorias
ADD CONSTRAINT ck_categoria_codigo CHECK (REGEXP_LIKE(codigo, '^[A-Z]'));

-- El precio mínimo debe ser menor que el máximo - FUNCIONA
ALTER TABLE categorias
ADD CONSTRAINT ck_categoria_preciominimo_preciomaximo CHECK (minimo < maximo);

/*
ALTER TABLE evaluaciones
ADD CONSTRAINT a_omes_year_month_check 
CHECK (TO_CHAR(fecha, 'YYYYMM') = SUBSTR(a_omes, 1, 4) || SUBSTR(a_omes, 5, 2));
*/

-- Acciones 
-- ELIMINAR
-- Únicamente se pueden eliminar los que no tienen artículos asociados FUNCIONA 
/*
ALTER TABLE categorias
ADD CONSTRAINT fk_categorias_articulos_on_delete_restrict
FOREIGN KEY (codigo) REFERENCES articulos (codigoCategoria)
ON DELETE RESTRICT;
*/
 
 CREATE OR REPLACE TRIGGER trg_categoria_borrar 
BEFORE DELETE ON categorias
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM articulos
    WHERE codigoCategoria = :OLD.codigo;
    
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'No se puede eliminar la categoría debido a que tiene artículos asociados.');
    END IF;
END;
/

SELECT * FROM CATEGORIAS;
SELECT * FROM ARTICULOS;
-- Validaciones
DELETE FROM categorias
WHERE codigo = 'A003'
-- AccionesOK
--Se implementaron implcítamente en la inserción de datos
-- Disparadores
-- Caso de uso 1: Mantener categoría + Generar registro de auditoría

-- FUNCIONA
-- Si no se indica el nombre se le asigna 'Nombre de <codigo>'
-- Si no se indica el precio máximo se supone que es el doble del mínimo
CREATE OR REPLACE TRIGGER tr_categoria_bi
BEFORE INSERT ON categorias
FOR EACH ROW
BEGIN
    IF :NEW.nombre IS NULL THEN
        :NEW.nombre := 'Nombre de ' || :NEW.codigo;
    END IF;
    IF :NEW.maximo IS NULL THEN
        :NEW.maximo := :NEW.minimo * 2;
    END IF;
END;
-- Validación 
SELECT * FROM categorias
INSERT INTO categorias (codigo, nombre, tipo, minimo, maximo, codigo1) VALUES ('C009', NULL, 'A', 50, NULL, NULL);

/
 


-- MODIFICAR
-- Los únicos datos que se pueden modificar son el mínimo y el máximo. Únicamente pueden aumentar. - FUNCIONA
-- Si se modifica el mínimo, el máximo debe modificarse en el mismo valor - FUNCIOA
CREATE OR REPLACE TRIGGER tr_categoria_bu
BEFORE UPDATE ON categorias
FOR EACH ROW
BEGIN
    IF :NEW.codigo <>:OLD.codigo OR
        :NEW.nombre <> :OLD.nombre OR
        :NEW.tipo <> :OLD.tipo OR
        :NEW.codigo1 <> :OLD.codigo1 THEN
         RAISE_APPLICATION_ERROR(-20001, 'Los únicos datos que se pueden modificar son el mínimo y el máximo');
    END IF;
    IF :NEW.minimo < :OLD.minimo OR :NEW.maximo < :OLD.maximo THEN
        RAISE_APPLICATION_ERROR(-20001, 'El mínimo y el máximo solo pueden aumentar.');
    END IF;
    IF :NEW.minimo <> :OLD.minimo THEN
        :NEW.maximo := :NEW.maximo + (:NEW.minimo - :OLD.minimo);
    END IF;
END;

SELECT * FROM categorias
-- Validaciones
-- 1
UPDATE categorias
SET nombre = 'No sirvio'
WHERE codigo = 'A003';
-- 2
UPDATE categorias
SET minimo = 100,maximo = 50
WHERE codigo = 'A003';
--3
UPDATE categorias
SET minimo = 100
WHERE codigo = 'C001';
-- ========================================== DIFICIL
-- En todos los escenarios se debe generar el registro de auditoría

DROP TRIGGER tr_categoria_bI
CREATE OR REPLACE TRIGGER tr_categoria_bd
BEFORE DELETE ON categorias
FOR EACH ROW
BEGIN
    INSERT INTO auditorias (idAuditoria, fecha, accion, nombre, codigoCategoria, codigo_a_omes)
    VALUES ('61', SYSDATE, 'D', :OLD.nombre, :OLD.codigo, NULL);
END;

CREATE OR REPLACE TRIGGER tr_categoria_bI
BEFORE INSERT ON categorias
FOR EACH ROW
BEGIN
    INSERT INTO auditorias (idAuditoria, fecha, accion, nombre, codigoCategoria, codigo_a_omes)
    VALUES ('62', SYSDATE, 'I', :OLD.nombre, :OLD.codigo, NULL);
END;

CREATE OR REPLACE TRIGGER tr_categoria_bu
BEFORE DELETE ON categorias
FOR EACH ROW
BEGIN
    INSERT INTO auditorias (idAuditoria, fecha, accion, nombre, codigoCategoria, codigo_a_omes)
    VALUES ('63', SYSDATE, 'U', :OLD.nombre, :OLD.codigo, NULL);
END;
/
-- ========================================== DIFICIL 
-- Caso de uso 2: Registrar Evaluación
 
-- ADICIONAR
-- La fecha de la evaluación se genera automáticamente y debe ser posterior al año-mes evaluado
CREATE OR REPLACE TRIGGER tr_evaluacion_bi
BEFORE INSERT ON evaluaciones
FOR EACH ROW
BEGIN
    IF TO_CHAR(:NEW.fecha, 'YYYYMM') <= SUBSTR(:NEW.a_omes, 1, 6) THEN
        RAISE_APPLICATION_ERROR(-20001, 'La fecha de la evaluación debe ser posterior al año-mes evaluado.');
    END IF;
    IF :NEW.tid IS NULL THEN
        :NEW.tid := 'CC';
    END IF;
END;

INSERT INTO evaluaciones (a_omes, tid, nid, fecha, descripcion, reporte, resultado, idRespuesta)
VALUES ('202406', 'CC', '1357908642', CURRENT_DATE, '(B)Descripción evaluación 3', 'https://example.com/evaluacion3.pdf', 'AP', 3);
-- Los registros asociados son los correspondientes al año-mes definido
/*
CREATE OR REPLACE TRIGGER tr_evaluacion_bi
BEFORE INSERT ON evaluaciones
FOR EACH ROW
BEGIN
    -- Insertar el registro correspondiente en la tabla auditorias
    INSERT INTO auditorias (idAuditoria, fecha, accion, nombre, codigoCategoria, codigo_a_omes)
    VALUES (:NEW.a_omes, SYSDATE, 'I', :NEW.descripcion, :NEW.codigoCategoria, :NEW.a_omes);
END;
*/
 
 
 
-- MODIFICAR
-- El único dato que se puede modificar es el resultado de las auditorías - FUNCIONA
-- Solo es posible adicionar respuestas de las anomalías si el estado de la auditoría es pendiente - FUNCIONA
CREATE OR REPLACE TRIGGER tr_evaluaciones_bu
BEFORE UPDATE ON evaluaciones
FOR EACH ROW
DECLARE
BEGIN
        IF :OLD.a_omes <> :NEW.a_omes OR
           :OLD.tid <> :NEW.tid OR
           :OLD.nid <> :NEW.nid OR
           :OLD.fecha <> :NEW.fecha OR
           :OLD.descripcion <> :NEW.descripcion OR
           :OLD.reporte <> :NEW.reporte THEN
            RAISE_APPLICATION_ERROR(-20001, 'No puedes modificar ninguna columna excepto el resultado de las auditorías.');
        END IF;
        IF :NEW.resultado <> 'PE' THEN
            RAISE_APPLICATION_ERROR(-20001, 'Solo es posible adicionar respuestas de las anomalías si el estado de la auditoría es pendiente.');
        END IF;
END;


UPDATE evaluaciones
SET idrespuesta = 3
WHERE a_omes = '202408'

-- ELIMINAR
-- Las evaluaciones se pueden eliminar si no tienen anomalías - FUNCIONA
CREATE OR REPLACE TRIGGER tr_evaluaciones_bd
BEFORE DELETE ON evaluaciones
FOR EACH ROW
BEGIN
    IF :OLD.resultado IS NOT NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'No se pueden eliminar evaluaciones que tienen anomalías.');
    END IF;
END;

DELETE FROM evaluaciones 
WHERE a_omes = '202408'
-- DisparadoresOK
-- Se implementaron bajo cada trigger en la sección validación 

-- DisparadoresNoOK
--Se implementaron bajo cada trigger también
-- Xdisparadores
-- Drops de los checks
ALTER TABLE categorias DROP CONSTRAINT ck_categoria_codigo;
ALTER TABLE categorias DROP CONSTRAINT ck_categoria_preciominimo_preciomaximo;
 
-- Drops de los triggers
DROP TRIGGER trg_categoria_borrar;
DROP TRIGGER tr_categoria_bi;
DROP TRIGGER tr_categoria_bu;
DROP TRIGGER tr_categoria_bd;
DROP TRIGGER tr_evaluacion_bi;
DROP TRIGGER tr_evaluaciones_bu;
DROP TRIGGER tr_evaluaciones_bd;
-- WRONG
DROP TRIGGER tr_categoria_insert;

SELECT SYSDATE FROM DUAL;

select * from auditorias
select * from evaluaciones





















