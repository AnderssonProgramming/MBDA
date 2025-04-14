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
    codigoUniversidad CHAR(3) NULL,
    tid VARCHAR2(2) NOT NULL,
    nid CHAR(10) NOT NULL,
    nombre VARCHAR2(50) NOT NULL,
    programa VARCHAR2(50) NOT NULL,
    correo VARCHAR2(50) NOT NULL,
    registro DATE NOT NULL,
    suspension DATE,
    nSuspensiones NUMBER(3) NOT NULL
    );

DROP TABLE usuarios CASCADE CONSTRAINTS; 

CREATE TABLE calificaciones (
    codigoUsuario CHAR(3) NOT NULL,
    estrellas NUMBER(1) NOT NULL,
    codigoArticulo NUMBER(16) NOT NULL
    );

DROP TABLE articulos CASCADE CONSTRAINTS; 
CREATE TABLE articulos (
    idArticulo NUMBER(16) NOT NULL,
    descripcion CHAR(20) NOT NULL,
    idCaracteristicas number(10) NOT NULL,
    estado CHAR(1) NOT NULL,
    foto VARCHAR2(100) NOT NULL,
    precio NUMBER(3) NOT NULL,
    disponible VARCHAR2(5) NOT NULL,
    codigoCategoria VARCHAR(5) NOT NULL,
    codigoUsuario CHAR(10) NOT NULL
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
    
CREATE TABLE anomalias (
    id_anomalia VARCHAR2(10)NOT NULL,
    id_evaluacion VARCHAR2(6) NOT NULL,
    texto_descriptivo VARCHAR2(100) NOT NULL,    
    prioridad VARCHAR2(1) NOT NULL        
    );

CREATE TABLE registros(
    id_registro VARCHAR2(10) NOT NULL,
    id_anomalia VARCHAR2(10) NOT NULL,
    registros VARCHAR2(100) NOT NULL
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
ADD CONSTRAINT PK_usuarios PRIMARY KEY (codigo);

ALTER TABLE universidades 
ADD CONSTRAINT PK_universidades PRIMARY KEY (codigo,codigoUsuario);
 
ALTER TABLE calificaciones
ADD CONSTRAINT PK_calificaciones PRIMARY KEY (codigoUsuario,codigoArticulo);
 
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

-------------

ALTER TABLE anomalias
ADD CONSTRAINT PK_anomalias PRIMARY KEY (id_anomalia)

ALTER TABLE registros 
ADD CONSTRAINT PK_registros PRIMARY KEY (id_registro)
 
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
--ALTER TABLE usuarios ADD CONSTRAINT FK_usuario_universidad 
--FOREIGN KEY (codigoUniversidad,codigo) REFERENCES universidades(codigo,codigoUsuario); --


ALTER TABLE universidades ADD CONSTRAINT FK_universidades_usuarios
FOREIGN KEY (codigoUsuario) REFERENCES usuarios(codigo) ON DELETE CASCADE; -- 


-- SELECT * FROM calificaciones;
ALTER TABLE calificaciones ADD CONSTRAINT FK_calificacionUsuario
FOREIGN KEY (codigoUsuario) REFERENCES usuarios(codigo);   -- ya se creo
 
ALTER TABLE calificaciones ADD CONSTRAINT FK_calificacionArticulo -- ya se creos
FOREIGN KEY (codigoArticulo) REFERENCES articulos(idArticulo);
 
ALTER TABLE ropa ADD CONSTRAINT FK_ropaArticulo
FOREIGN KEY (idArticulo) REFERENCES articulos(idArticulo);
 
ALTER TABLE perecederos ADD CONSTRAINT FK_perecederoArticulo
FOREIGN KEY (idArticulo) REFERENCES articulos(idArticulo);
 
--SELECT * FROM perecederos;
--TRUNCATE TABLE perecederos;
ALTER TABLE articulos ADD CONSTRAINT FK_articulos_caracteristicas
FOREIGN KEY (idCaracteristicas) REFERENCES caracteristicas(id);--
 
ALTER TABLE articulos ADD CONSTRAINT FK_articuloCategoria
FOREIGN KEY (codigoCategoria) REFERENCES categorias(codigo);
 
ALTER TABLE articulos 
ENABLE CONSTRAINT FK_articuloCategoria;
 
 
ALTER TABLE articulos ADD CONSTRAINT FK_articuloUsuario
FOREIGN KEY (codigoUsuario) REFERENCES usuarios(codigo);

 
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

-------------

ALTER TABLE anomalias ADD CONSTRAINT FK_anomalias_evaluaciones
FOREIGN KEY (id_evaluacion) REFERENCES evaluaciones(a_omes)

ALTER TABLE registros ADD CONSTRAINT FK_registros_anomalias 
FOREIGN KEY (id_anomalia) REFERENCES anomalias(id_anomalia)
 
 
-- === CICLO 1: PoblarNoOK(2)
 
-- Para la tabla usuarios
 
ALTER TABLE usuarios
ADD CONSTRAINT tid_check CHECK (tid IN ('CC', 'TI'));
 
ALTER TABLE usuarios
ADD CONSTRAINT correo_check CHECK (REGEXP_LIKE(correo, '^[^\s@]+@[^\s@]+\.[^\s@]{2,}$'));
SELECT * FROM USUARIOS;
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
-- ===========================
ALTER TABLE anomalias 
ADD CONSTRAINT prioridad_check CHECK (prioridad IN ('A','M','B');
 
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
INSERT INTO universidades (codigo, nombre, direccion, codigoUsuario) VALUES ('001', 'Universidad A', 'Dirección A', 'codigoU1'); 
INSERT INTO universidades (codigo, nombre, direccion, codigoUsuario) VALUES ('002', 'Universidad B', 'Dirección B', 'codigoU2');
INSERT INTO universidades (codigo, nombre, direccion, codigoUsuario) VALUES ('003', 'Universidad C', 'Dirección C', 'codigoU3');

 
 
-- ====================================================================================
 
-- Insertar datos en la tabla usuarios INSERTADOS
INSERT INTO usuarios (codigo, codigoUniversidad, tid, nid, nombre, programa, correo, registro, suspension, nSuspensiones)
VALUES('codigoU1',NULL, 'CC', '1234567890', 'Usuario 1', 'NO', 'correo_valido@example.com', CURRENT_DATE, NULL, 0);
 
INSERT INTO usuarios (codigo, codigoUniversidad, tid, nid, nombre, programa, correo, registro, suspension, nSuspensiones) 
VALUES ('codigoU2',NULL, 'TI', '0987654321', 'Usuario 2','NO', 'correo_valido1@example.com', CURRENT_DATE, NULL, 0);

SELECT * FROM usuarios;

INSERT INTO usuarios (codigo, codigoUniversidad, tid, nid, nombre, programa, correo, registro, suspension, nSuspensiones)
VALUES ('codigoU3', NULL, 'CC', '1234567810', 'Usuario 3', 'NO', 'correo_valido3@example.com', CURRENT_DATE, NULL, 0);

INSERT INTO usuarios (codigo, codigoUniversidad, tid, nid, nombre, programa, correo, registro, suspension, nSuspensiones)
VALUES ('codigoU4', NULL, 'CC', '1234567820', 'Usuario 4', 'NO', 'correo_valido4@example.com', CURRENT_DATE, NULL, 0);

INSERT INTO usuarios (codigo, codigoUniversidad, tid, nid, nombre, programa, correo, registro, suspension, nSuspensiones)
VALUES ('codigoU5', NULL, 'CC', '1234567830', 'Usuario 5', 'NO', 'correo_valido5@example.com', CURRENT_DATE, NULL, 0);

INSERT INTO usuarios (codigo, codigoUniversidad, tid, nid, nombre, programa, correo, registro, suspension, nSuspensiones)
VALUES ('codigoU6', NULL, 'CC', '1234567840', 'Usuario 6', 'NO', 'correo_valido6@example.com', CURRENT_DATE, NULL, 0);

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
SELECT CURLDATE()
 
select * from auditorias
select * from evaluaciones

-- <========================================================= LAB05 ==========================================================================>
 
 --1. Consulte la informaci�n que actualmente est� en la tabla
 
SELECT * FROM mbda.DATA
 
--�Cu�ntos usuarios hay en la tabla DATA? 
SELECT COUNT(DISTINCT nombres) FROM mbda.DATA;
 
--�Cu�ntas universidades?
SELECT COUNT(DISTINCT UNOMBRE) FROM mbda.DATA;
 
--�Cu�les universidades?
SELECT DISTINCT(UNOMBRE) FROM mbda.DATA;
 
 
--2.Incl�yanse como usuarios (personas)
 
INSERT INTO mbda.DATA(UCODIGO,UNOMBRE, UDIRECCION, NID, NOMBRES) VALUES (111,'ESCUELA', 'AK 45 (Autonorte) #205-59', 1000096183,'Andersson S�nchez');
 
INSERT INTO MBDA.DATA (UCODIGO,UNOMBRE,UDIRECCION,NID,NOMBRES) VALUES(111,'ESCUELA','AK 45 (Autonorte) #205-59','1000098857','Cristian Santiago Pedraza');
 
--�Ustedes en DATA?
 
SELECT * FROM MBDA.DATA where NID IN ('1000098857','1000096183');
 
 
--3.Traten de modificarse o borrarse. �qu� pasa?
 
--UPDATE
 
UPDATE MBDA.DATA
SET NOMBRES = 'Andersson'
WHERE NID = '1000096183';
 
UPDATE MBDA.DATA
SET NOMBRES = 'Cristian Pedraza'
WHERE NID = '1000098857';
 
--DELETE
 
DELETE FROM MBDA.DATA 
WHERE NID = '1000098857';
 
DELETE FROM MBDA.DATA 
WHERE NID = '1000096183';
 
 
--4.Escriban la instrucci�n necesaria para otorgar los permisos que actualmente tiene esa tabla. �qui�n la escribi�?}

GRANT SELECT, INSERT ON MBDA.DATA TO BD1000096183,BD1000098857
-- Lo escribi� el usuario MBDA

--5. Escriban las instrucciones necesarias para importar los datos de esa tabla a su base de datos como clientes. Los datos deben ser insertados en las tablas de su base de datos, considerando:
 
    --El c�digo corresponde a una cadena de caracteres generados aleatoriamente (en may�sculas)
    --Todas los usuarios tienen la c�dula (�CC�) como tipo de documento
    --El programa es �Ingenier�a�, si es de la Escuela; �Derecho�, si es del Rosario; �Medicina�, si es Javeriana; y �Por definir�, si es de otra universidad.
    --La fecha de registro es la fecha de hoy
    --El correo es el primer nombre, seguido de los primeros 7 caracteres del nombre --de la universidad en min�scula, seguido de .edu.co
    --Ninguno ha sido suspendido
 
INSERT INTO usuarios (CODIGO, CODIGOUNIVERSIDAD, TID, NID, NOMBRE, PROGRAMA, CORREO, REGISTRO, SUSPENSION, NSUSPENSIONES)
    SELECT
        UPPER(codigo_aleatorio) AS CODALEATORIO,
        NULL AS CODIGOUNIVERSIDAD, -- Aqu� debes especificar qu� valor deseas para CODIGOUNIVERSIDAD
        'CC' AS TID,
        NID,
        NOMBRES,
        CASE 
            WHEN UNOMBRE = 'ESCUELA' THEN 'Ingenier�a'
            WHEN UNOMBRE = 'ROSARIO' THEN 'Derecho'
            WHEN UNOMBRE = 'JAVERIANA' THEN 'Medicina'
            ELSE 'Por definir'
        END AS PROGRAMA,
        SUBSTR(NOMBRES, 1, INSTR(NOMBRES, ' ') - 1) || LOWER(SUBSTR(UNOMBRE, 1, 7)) || '@mail.edu.co' AS CORREO,
        SYSDATE AS REGISTRO,
        NULL AS SUSPENSION,
        0 AS NSUSPENSIONES
    FROM (
        SELECT DBMS_RANDOM.STRING('X', 10) AS codigo_aleatorio, 
               NID, 
               NOMBRES, 
               UNOMBRE
        FROM MBDA.DATA
        WHERE LENGTH(NID) <= 10
        ORDER BY DBMS_RANDOM.RANDOM
    ) WHERE ROWNUM <= 218; -- Cambia el n�mero 10 por la cantidad de filas que deseas seleccionar
SELECT * FROM USUARIOS
SELECT * FROM MBDA.DATA
  
ALTER TABLE universidades DISABLE CONSTRAINT UK_CODIGO_USUARIOS;

-- <================ TRIGGERS [Los tres que estan mal y los de anomalías =================>

-- TR_CATEGORIA_BD
CREATE OR REPLACE TRIGGER TR_CATEGORIA_BD
BEFORE DELETE ON categorias
FOR EACH ROW
BEGIN
    -- Insertar registro de auditoría al eliminar una categoría
    INSERT INTO auditorias (idAuditoria, fecha, accion, nombre, codigoCategoria, codigo_a_omes)
    VALUES ('A1', SYSDATE, 'D', :OLD.nombre, :OLD.codigo, NULL);
END;
/
-- Prueba para TR_CATEGORIA_BD
DELETE FROM categorias WHERE codigo = 'C1';

-- TR_EVALUACIONES_BU
CREATE OR REPLACE TRIGGER TR_EVALUACIONES_BU
BEFORE UPDATE OF resultado ON evaluaciones
FOR EACH ROW
BEGIN
    -- Verificar si el estado de la auditoría es pendiente para permitir adicionar respuestas
    IF :OLD.resultado <> 'PE' AND :NEW.resultado = 'PE' THEN
        RAISE_APPLICATION_ERROR(-20030, 'Solo es posible adicionar respuestas de las anomalías si el estado de la auditoría es pendiente.');
    END IF;
END;
/
-- Prueba para TR_EVALUACIONES_BU
-- Cambiar el resultado de una evaluación a 'PE' (pendiente)
UPDATE evaluaciones SET resultado = 'PE' WHERE a_omes = '202401';

-- TR_EVALUACIONES_BD
CREATE OR REPLACE TRIGGER TR_EVALUACIONES_BD
BEFORE DELETE ON evaluaciones
FOR EACH ROW
DECLARE
    v_anomalias NUMBER;
BEGIN
    -- Contar las anomalías asociadas a la evaluación
    SELECT COUNT(*) INTO v_anomalias
    FROM anomalias
    WHERE id_evaluacion = :OLD.a_omes;
    
    -- Verificar si hay anomalías asociadas a la evaluación
    IF v_anomalias > 0 THEN
        RAISE_APPLICATION_ERROR(-20040, 'Las evaluaciones se pueden eliminar si no tienen anomalias.');
    END IF;
END;
/
-- Prueba para TR_EVALUACIONES_BD
-- Eliminar una evaluación que tiene anomalías asociadas (debería lanzar un error)
DELETE FROM evaluaciones WHERE a_omes = '202401';

-- TR_REGISTROS_BI
CREATE OR REPLACE TRIGGER TR_REGISTROS_BI
BEFORE INSERT ON registros
FOR EACH ROW
DECLARE
    v_a_omes VARCHAR2(6);
BEGIN
    -- Obtener el año-mes definido en la evaluación asociada
    SELECT a_omes INTO v_a_omes
    FROM evaluaciones
    WHERE a_omes = :NEW.id_anomalia;
    
    -- Verificar si el registro está asociado al año-mes definido en la evaluación
    IF v_a_omes IS NULL THEN
        RAISE_APPLICATION_ERROR(-20010, 'El registro no esta asociado al año-mes definido en la evaluación.');
    END IF;
END;
/
-- Prueba para TR_REGISTROS_BI
-- Insertar un registro asociado a una evaluación existente
INSERT INTO registros (id_registro, id_anomalia, registros)
VALUES ('R001', '202401', 'Registro de prueba');

-- Prueba para TR_REGISTROS_BI (debería lanzar un error)
-- Insertar un registro no asociado a ninguna evaluación
INSERT INTO registros (id_registro, id_anomalia, registros)
VALUES ('R002', '202402', 'Registro de prueba');


-- PAQUETES 

-- <=========Paquete PK_ARTICULOS===========>

CREATE OR REPLACE PACKAGE PK_ARTICULOS AS
        PROCEDURE ad(p_idArticulo IN NUMBER ,p_descripcion IN CHAR ,p_idCaracteristicas IN number ,p_estado IN CHAR ,p_foto IN VARCHAR2 ,p_precio IN NUMBER ,p_disponible IN VARCHAR2 ,p_codigoCategoria IN VARCHAR ,p_codigoUsuario IN CHAR);
        PROCEDURE mo(p_id_articulo IN NUMBER, p_columna IN VARCHAR2, p_nuevo_valor IN VARCHAR2);
        PROCEDURE el(p_idArticulo IN NUMBER);
        FUNCTION co RETURN SYS_REFCURSOR;
        PROCEDURE print_co;
        FUNCTION co_esp (p_codigoCategoria IN VARCHAR2) RETURN SYS_REFCURSOR;
        PROCEDURE print_co_esp (p_codigoCategoria IN VARCHAR2);
        -- consultar los articulos de una categor�a especifica y sus evaluaciones.        
        /*PROCEDURE articuloCategEval(p_codigoCategoria IN VARCHAR2);*/
END PK_ARTICULOS;
/
-- select * from articulos
-- PRUEBA PAQUETE
-- AD
CREATE OR REPLACE PACKAGE BODY PK_ARTICULOS AS
    PROCEDURE ad(p_idArticulo IN NUMBER ,p_descripcion IN CHAR ,p_idCaracteristicas IN number ,p_estado IN CHAR ,p_foto IN VARCHAR2 ,p_precio IN NUMBER ,p_disponible IN VARCHAR2 ,p_codigoCategoria IN VARCHAR ,p_codigoUsuario IN CHAR) AS
    BEGIN
        INSERT INTO articulos (idArticulo, descripcion, idCaracteristicas, estado, foto, precio, disponible, codigoCategoria, codigoUsuario)
        VALUES (p_idArticulo ,p_descripcion ,p_idCaracteristicas ,p_estado ,p_foto ,p_precio ,p_disponible ,p_codigoCategoria ,p_codigoUsuario);
        COMMIT;
    END ad;
    
    PROCEDURE mo(p_id_articulo IN NUMBER, p_columna IN VARCHAR2, p_nuevo_valor IN VARCHAR2) AS
    BEGIN
        IF p_columna = 'descripcion' THEN
            UPDATE articulos SET descripcion = p_nuevo_valor WHERE idArticulo = p_id_articulo;
        ELSIF p_columna = 'estado' THEN
            UPDATE articulos SET estado = p_nuevo_valor WHERE idArticulo = p_id_articulo;
        ELSIF p_columna = 'foto' THEN
            UPDATE articulos SET foto = p_nuevo_valor WHERE idArticulo = p_id_articulo;
        ELSIF p_columna = 'idArticulo' THEN
            RAISE_APPLICATION_ERROR(-20001, 'No puedes modificar idArticulo, va contra la integridad de la base de datos');
        ELSE
            RAISE_APPLICATION_ERROR(-20002, 'Columna no v�lida');
        END IF;
        COMMIT; -- Confirmar los cambios
    END mo;
    
    PROCEDURE el(p_idArticulo IN NUMBER) AS
    v_count NUMBER;
BEGIN
    -- Verificar si el ID del art�culo existe en la tabla
    SELECT COUNT(*)
    INTO v_count
    FROM articulos
    WHERE idArticulo = p_idArticulo;

    -- Si no se encuentra ninguna fila con el ID proporcionado, lanzar una excepci�n
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El ID del art�culo no existe en la base de datos.');
    END IF;

    -- Si el ID del art�culo existe, eliminarlo
    DELETE FROM articulos WHERE idArticulo = p_idArticulo;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        -- Manejar cualquier otra excepci�n que pueda ocurrir durante la ejecuci�n del procedimiento
        ROLLBACK; -- Revertir los cambios en caso de error
        RAISE; -- Relanzar la excepci�n para que sea manejada en un nivel superior
END el;
    
    FUNCTION co RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN 
         -- Abrir el cursor con la consulta
        OPEN v_cursor FOR
            SELECT * FROM articulos;

        -- Mostrar los resultados (puedes hacer lo que necesites con los resultados aqu�)
        -- Aqu� se puede hacer un bucle FETCH para procesar fila por fila, o simplemente cerrar el cursor si no necesitas procesar los resultados aqu�.

        -- Cerrar el cursor
        RETURN v_cursor;
    END co;
    
    PROCEDURE print_co AS
    -- variable
    -- El %TYPE lo que hace es asignar a la variable el valor que tenga la columna de la tabla
    v_articulo_cursor SYS_REFCURSOR; 
    v_idArticulo articulos.idArticulo%TYPE;
    v_descripcion articulos.descripcion%TYPE;
    v_idCaracteristicas articulos.idCaracteristicas%TYPE;
    v_estado articulos.estado%TYPE;
    v_foto articulos.foto%TYPE;
    v_precio articulos.precio%TYPE;
    v_disponible articulos.disponible%TYPE;
    v_codigocategoria articulos.codigocategoria%TYPE;
    v_codigousuario articulos.codigousuario%TYPE;
    BEGIN 
        v_articulo_cursor := PK_ARTICULOS.co;
        LOOP
            FETCH v_articulo_cursor INTO v_idArticulo, v_descripcion, v_idCaracteristicas, v_estado, v_foto, v_precio, v_disponible, v_codigoCategoria, v_codigoUsuario;
            EXIT WHEN v_articulo_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('ID: ' || v_idArticulo || ', Descripci�n: ' || v_descripcion || ', Estado: ' || v_estado);
        END LOOP;
        CLOSE v_articulo_cursor;
    END print_co;
    
    FUNCTION co_esp(p_codigoCategoria IN VARCHAR2) RETURN SYS_REFCURSOR AS
        s_cursor SYS_REFCURSOR;
    BEGIN
        OPEN s_cursor FOR
            SELECT *
            FROM articulos
            WHERE codigoCategoria = p_codigoCategoria; -- Filtrar por la categor�a espec�fica
    
        RETURN s_cursor;
    END co_esp;
    
    PROCEDURE print_co_esp(p_codigoCategoria IN VARCHAR2) AS
        v_articulo_cursor SYS_REFCURSOR; 
        v_idArticulo articulos.idArticulo%TYPE;
        v_descripcion articulos.descripcion%TYPE;
        v_idCaracteristicas articulos.idCaracteristicas%TYPE;
        v_estado articulos.estado%TYPE;
        v_foto articulos.foto%TYPE;
        v_precio articulos.precio%TYPE;
        v_disponible articulos.disponible%TYPE;
        v_codigocategoria articulos.codigocategoria%TYPE;
        v_codigousuario articulos.codigousuario%TYPE;
    BEGIN
        v_articulo_cursor := PK_ARTICULOS.co_esp(p_codigoCategoria);
        LOOP
            FETCH v_articulo_cursor INTO v_idArticulo, v_descripcion, v_idCaracteristicas, v_estado, v_foto, v_precio, v_disponible, v_codigoCategoria, v_codigoUsuario;
            EXIT WHEN v_articulo_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('ID: ' || v_idArticulo || ', Descripci�n: ' || v_descripcion || ', Estado: ' || v_estado || ', codigocategoria: ' || v_codigocategoria);
        END LOOP;
        CLOSE v_articulo_cursor;
    END print_co_esp;
        
END PK_ARTICULOS;
/

--Casos de prueba para PK_ARTICULOS:
-- AD()
BEGIN
    PK_ARTICULOS.ad(6543210987654321, 'Articulo 2', 2, 'N', 'https://example.com/articulo4.pdf', 150, 'No', 'C001', '2MFOFOKLSL');
END;
/
-- MO()
select * from categorias
BEGIN 
    -- exito
    PK_ARTICULOS.mo(6543210987654321,'descripcion','Art�culo PRO MO');
    --fracaso 2
    PK_ARTICULOS.mo(6543210987654321,'no-existe','Art�culo PRO MO');
    PK_ARTICULOS.mo(6543210987654321,'idArticulo','Art�culo PRO MO');
    
END;
/
-- EL()

BEGIN 
    -- exito
    --PK_ARTICULOS.el(6543210987654321);
    --fracaso 1
    PK_ARTICULOS.el(6543210987654321);
END;
/

-- co - cursor ejecutado a travez de un procedure
BEGIN
    PK_ARTICULOS.print_co;
END;

-- co_especifica - cursor ejecutado a travez de un procedure
BEGIN
    PK_ARTICULOS.print_co_esp('C001');
END;

-- <=========Paquete PK_AUDITORIAS===========>

CREATE OR REPLACE PACKAGE PK_AUDITORIAS AS
        PROCEDURE ad (p_idAuditoria IN VARCHAR2 ,p_fecha IN DATE, p_accion IN VARCHAR2 ,p_nombre IN VARCHAR2 ,p_codigoCategoria IN VARCHAR2,p_codigo_a_omes IN VARCHAR2);
        PROCEDURE mo;
        PROCEDURE el(p_idAuditoria IN NUMBER);
        FUNCTION co RETURN SYS_REFCURSOR;
        PROCEDURE print_co;
END PK_AUDITORIAS;


CREATE OR REPLACE PACKAGE BODY PK_AUDITORIAS AS
    PROCEDURE ad(p_idAuditoria IN VARCHAR2 ,p_fecha IN DATE, p_accion IN VARCHAR2 ,p_nombre IN VARCHAR2 ,p_codigoCategoria IN VARCHAR2,p_codigo_a_omes IN VARCHAR2) AS
    BEGIN 
        INSERT INTO auditorias (idAuditoria, fecha, accion, nombre, codigoCategoria, codigo_a_omes)
        VALUES (p_idAuditoria,p_fecha,p_accion, p_nombre, p_codigoCategoria, p_codigo_a_omes);
        COMMIT;
    END ad;

    PROCEDURE mo AS
    BEGIN
        RAISE_APPLICATION_ERROR(-20003,'No se pueden modificar las auditorias');
    END mo;

    PROCEDURE el(p_idAuditoria IN NUMBER) AS
    BEGIN
        RAISE_APPLICATION_ERROR(-20004,'No se pueden eliminar las auditorias');
    END el;

    FUNCTION co RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR 
            SELECT * FROM auditorias;
        RETURN v_cursor;
    END co;

    PROCEDURE print_co AS 
    v_auditoria_cursor SYS_REFCURSOR;
    v_idAuditoria auditorias.idAuditoria%TYPE;
    v_fecha auditorias.fecha%TYPE;
    v_accion auditorias.accion%TYPE;
    v_nombre auditorias.nombre%TYPE;
    v_codigoCategoria auditorias.codigoCategoria%TYPE;
    v_codigo_a_omes auditorias.codigo_a_omes%TYPE;
    BEGIN
        v_auditoria_cursor := PK_AUDITORIAS.co;
        LOOP
            FETCH v_auditoria_cursor INTO v_idAuditoria,v_fecha,v_accion,v_nombre,v_codigoCategoria,v_codigo_a_omes;
            EXIT WHEN v_auditoria_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('ID: ' || v_idAuditoria || 'FECHA: ' || v_fecha || 'ACCION: ' || v_accion || 'NOMBRE: ' || v_nombre || 'CODIGO CATEGORIA: ' || v_codigoCategoria || 'CODIGO A OME: ' || v_codigo_a_omes);
        END LOOP;
        CLOSE v_auditoria_cursor;
    END print_co;
END PK_AUDITORIAS;

-- add
BEGIN 
    PK_AUDITORIAS.ad('06','27-MAR-24','D','Nombre 6',	'B002',	'202402');
END;
-- mo
BEGIN
    PK_AUDITORIAS.mo;
END;
-- el
BEGIN
    PK_AUDITORIAS.el('06');
END;
-- co
BEGIN
    PK_AUDITORIAS.print_co;
END;

-- <========= Paquete PK_CATEGORIAS ===========>
CREATE OR REPLACE PACKAGE PK_CATEGORIAS AS
        PROCEDURE ad(p_codigo IN VARCHAR2 ,p_nombre IN VARCHAR2 ,p_tipo IN VARCHAR,p_minimo IN NUMBER ,p_maximo IN NUMBER,p_codigo1 IN VARCHAR2);
        PROCEDURE mo(p_codigo IN VARCHAR2, p_columna IN VARCHAR2, p_nuevo_valor IN NUMBER);
        PROCEDURE el(p_codigo IN VARCHAR2);
        FUNCTION co RETURN SYS_REFCURSOR;
        PROCEDURE print_co;
        FUNCTION co_masArticulos RETURN SYS_REFCURSOR;
        PROCEDURE print_co_masArticulos;
END PK_CATEGORIAS;

CREATE OR REPLACE PACKAGE BODY PK_CATEGORIAS AS
        PROCEDURE ad(p_codigo IN VARCHAR2 ,p_nombre IN VARCHAR2 ,p_tipo IN VARCHAR,p_minimo IN NUMBER ,p_maximo IN NUMBER,p_codigo1 IN VARCHAR2) AS
        BEGIN 
            INSERT INTO categorias (codigo, nombre, tipo, minimo, maximo, codigo1) VALUES (p_codigo, p_nombre, p_tipo ,p_minimo, p_maximo, p_codigo1);
            COMMIT;
        END ad;
        
        PROCEDURE mo(p_codigo IN VARCHAR2, p_columna IN VARCHAR2, p_nuevo_valor IN NUMBER) AS
        BEGIN
            IF p_columna = 'minimo' THEN
                UPDATE categorias SET minimo = p_nuevo_valor WHERE codigo = p_codigo;
            ELSIF p_columna = 'maximo' THEN
                UPDATE categorias SET maximo = p_nuevo_valor WHERE codigo = p_codigo;
            ELSE
                RAISE_APPLICATION_ERROR(-20001, 'Columna no v�lida');
            END IF;
            COMMIT; -- Confirmar los cambios
        END mo;
        PROCEDURE el(p_codigo IN VARCHAR2)AS
        BEGIN
            DELETE FROM categorias WHERE codigo = p_codigo;
            COMMIT;
        END el;
           
        FUNCTION co RETURN SYS_REFCURSOR AS 
            v_cursor SYS_REFCURSOR;
        BEGIN 
            OPEN v_cursor FOR 
                SELECT * FROM categorias;
            RETURN v_cursor;
        END co;
        
        PROCEDURE print_co AS
            v_categorias_cursor SYS_REFCURSOR;
            v_codigo categorias.codigo%TYPE;
            v_nombre categorias.nombre%TYPE;
            v_tipo categorias.tipo%TYPE;
            v_minimo categorias.minimo%TYPE;
            v_maximo categorias.maximo%TYPE;
            v_codigo1 categorias.codigo1%TYPE;
        BEGIN 
            v_categorias_cursor := PK_CATEGORIAS.co;
        LOOP
            FETCH v_categorias_cursor INTO v_codigo, v_nombre, v_tipo, v_minimo, v_maximo, v_codigo1;
            EXIT WHEN v_categorias_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('C�DIGO: ' || v_codigo || ', NOMBRE: ' || v_nombre || ', TIPO: ' || v_tipo || ', M�NIMO: ' || v_minimo || ', M�XIMO: ' || v_maximo || ', C�DIGO1: ' || v_codigo1);
        END LOOP;
        CLOSE v_categorias_cursor;
        END print_co;
            

        FUNCTION co_masArticulos RETURN SYS_REFCURSOR AS
            v_cursor SYS_REFCURSOR;
        BEGIN 
            OPEN v_cursor FOR
               SELECT codigocategoria
                FROM (
                    SELECT codigocategoria, COUNT(*) AS total_articulos
                    FROM articulos
                    GROUP BY codigocategoria
                    ORDER BY COUNT(*) DESC
                ) 
                WHERE ROWNUM = 1; 
        RETURN v_cursor;
    END co_masArticulos;
        PROCEDURE print_co_masArticulos AS 
        v_articulo_cursor SYS_REFCURSOR;
        v_codigocategoria articulos.codigocategoria%TYPE;
        BEGIN 
            v_articulo_cursor := PK_categorias.co_masArticulos;
        LOOP
            FETCH v_articulo_cursor INTO v_codigocategoria;
            EXIT WHEN v_articulo_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('Categoria con m�s articulos: ' || v_codigocategoria);
        END LOOP;
        CLOSE v_articulo_cursor;
    END print_co_masArticulos;
END PK_CATEGORIAS;

-- Caso de prueba para el procedimiento ad
BEGIN 
    PK_CATEGORIAS.ad('C010', 'Nombre 6', 'R', 100, 200, 'A003');
END;

-- Caso de prueba para el procedimiento mo (actualizar 'minimo' de la categor�a con c�digo '06' a 150)
BEGIN
    PK_CATEGORIAS.mo('C010', 'minimo', 150);
END;
-- Caso de prueba para el procedimiento el (eliminar la categor�a con c�digo '06') - CASO DE FRACASO
BEGIN
    PK_CATEGORIAS.el('D006');
END;
SELECT * FROM CATEGORIAS
-- Caso de prueba para la funci�n co (imprimir todas las categor�as)
BEGIN
    PK_CATEGORIAS.print_co;
END;

-- Caso de prueba para la funci�n co_masArticulos (imprimir la categor�a con m�s art�culos)
BEGIN
    PK_CATEGORIAS.print_co_masArticulos;
END;

-- <=========Paquete PK_ANOMALIAS===========>
CREATE OR REPLACE PACKAGE PK_ANOMALIAS AS
        PROCEDURE ad(p_id_anomalia IN VARCHAR2, p_id_evaluacion IN VARCHAR2, p_texto_descriptivo IN VARCHAR2, p_prioridad IN VARCHAR2);
        PROCEDURE mo(p_id_anomalia IN VARCHAR2, p_columna IN VARCHAR2, p_nuevo_valor IN VARCHAR2);
        PROCEDURE el(p_id_anomalia IN VARCHAR2);
        FUNCTION co RETURN SYS_REFCURSOR;
        PROCEDURE print_co;
        FUNCTION co_prioridadEstadoPendiente RETURN SYS_REFCURSOR;
        PROCEDURE print_co_prioridadEstadoPendiente;
END PK_ANOMALIAS;

CREATE OR REPLACE PACKAGE BODY PK_ANOMALIAS AS
    PROCEDURE ad(p_id_anomalia IN VARCHAR2, p_id_evaluacion IN VARCHAR2, p_texto_descriptivo IN VARCHAR2, p_prioridad IN VARCHAR2) AS
    BEGIN 
        INSERT INTO anomalias (ID_ANOMALIA, ID_EVALUACION, TEXTO_DESCRIPTIVO, PRIORIDAD) 
        VALUES (p_id_anomalia, p_id_evaluacion, p_texto_descriptivo, p_prioridad);
        COMMIT;
    END ad;

    PROCEDURE mo(p_id_anomalia IN VARCHAR2, p_columna IN VARCHAR2, p_nuevo_valor IN VARCHAR2) AS
    BEGIN
        IF p_columna = 'prioridad' THEN
            UPDATE anomalias SET PRIORIDAD = p_nuevo_valor WHERE ID_ANOMALIA = p_id_anomalia;
	ELSIF p_columna = 'textoDescriptivo' THEN
            UPDATE anomalias SET texto_Descriptivo = p_nuevo_valor WHERE ID_ANOMALIA = p_id_anomalia;
        ELSE
            RAISE_APPLICATION_ERROR(-20001, 'Columna no v�lida');
        END IF;
        COMMIT;
    END mo;

    PROCEDURE el(p_id_anomalia IN VARCHAR2) AS
    existe_anomalia NUMBER;
    BEGIN
        SELECT COUNT(*) INTO existe_anomalia FROM anomalias WHERE ID_ANOMALIA = p_id_anomalia;
        IF existe_anomalia = 0 THEN 
            RAISE_APPLICATION_ERROR(-20004,'No existe la anomalia');
        END IF;
        
        DELETE FROM anomalias WHERE ID_ANOMALIA = p_id_anomalia;
        COMMIT;
    END el;

    FUNCTION co RETURN SYS_REFCURSOR AS 
        v_cursor SYS_REFCURSOR;
    BEGIN 
        OPEN v_cursor FOR 
            SELECT * FROM anomalias;
        RETURN v_cursor;
    END co;

    PROCEDURE print_co AS
        v_anomalias_cursor SYS_REFCURSOR;
        v_id_anomalia anomalias.ID_ANOMALIA%TYPE;
        v_id_evaluacion anomalias.ID_EVALUACION%TYPE;
        v_texto_descriptivo anomalias.TEXTO_DESCRIPTIVO%TYPE;
        v_prioridad anomalias.PRIORIDAD%TYPE;
    BEGIN 
        v_anomalias_cursor := PK_ANOMALIAS.co;
        LOOP
            FETCH v_anomalias_cursor INTO v_id_anomalia, v_id_evaluacion, v_texto_descriptivo, v_prioridad;
            EXIT WHEN v_anomalias_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('ID_ANOMALIA: ' || v_id_anomalia || ', ID_EVALUACION: ' || v_id_evaluacion || ', TEXTO_DESCRIPTIVO: ' || v_texto_descriptivo || ', PRIORIDAD: ' || v_prioridad);
        END LOOP;
        CLOSE v_anomalias_cursor;
    END print_co;

    FUNCTION co_prioridadEstadoPendiente RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN 
        OPEN v_cursor FOR
            SELECT ID_ANOMALIA, ID_EVALUACION, TEXTO_DESCRIPTIVO, PRIORIDAD 
            FROM anomalias 
            WHERE PRIORIDAD = 'P';
        RETURN v_cursor;
    END co_prioridadEstadoPendiente;

    PROCEDURE print_co_prioridadEstadoPendiente AS 
        v_anomalias_cursor SYS_REFCURSOR;
        v_id_anomalia anomalias.ID_ANOMALIA%TYPE;
        v_id_evaluacion anomalias.ID_EVALUACION%TYPE;
        v_texto_descriptivo anomalias.TEXTO_DESCRIPTIVO%TYPE;
        v_prioridad anomalias.PRIORIDAD%TYPE;
    BEGIN 
        v_anomalias_cursor := PK_ANOMALIAS.co_prioridadEstadoPendiente;
        LOOP
            FETCH v_anomalias_cursor INTO v_id_anomalia, v_id_evaluacion, v_texto_descriptivo, v_prioridad;
            EXIT WHEN v_anomalias_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('ID_ANOMALIA: ' || v_id_anomalia || ', ID_EVALUACION: ' || v_id_evaluacion || ', TEXTO_DESCRIPTIVO: ' || v_texto_descriptivo || ', PRIORIDAD: ' || v_prioridad);
        END LOOP;
        CLOSE v_anomalias_cursor;
    END print_co_prioridadEstadoPendiente;
END PK_ANOMALIAS;

-- Caso de prueba para el procedimiento ad
BEGIN 
    PK_ANOMALIAS.ad('A002', '202403', 'Texto de prueba', 'P');
END;

-- Caso de prueba para el procedimiento mo (actualizar 'prioridad' de la anomal�a con ID 'A001' a 'B')
BEGIN
    PK_ANOMALIAS.mo('A002', 'prioridad', 'B');
END;

-- Caso de prueba para el procedimiento el (eliminar la anomal�a con ID 'A001')
BEGIN
    PK_ANOMALIAS.el('A002');
END;

-- Caso de prueba para la funci�n co (imprimir todas las anomal�as)
BEGIN
    PK_ANOMALIAS.print_co;
END;

-- Caso de prueba para la funci�n co_prioridadEstadoPendiente (imprimir todas las anomal�as con prioridad 'Estado Pendiente')
BEGIN
    PK_ANOMALIAS.print_co_prioridadEstadoPendiente;
END;



-- CASOS NO OK  
-- Caso de prueba para el procedimiento ad con una anomal�a que ya existe (deber�a fallar)
BEGIN 
    PK_ANOMALIAS.ad('A001', 'E003', 'Texto de prueba', 'A');
END;

-- Caso de prueba para el procedimiento mo con una columna no v�lida (deber�a fallar)
BEGIN
    PK_ANOMALIAS.mo('A001', 'columna_invalida', 150);
END;

-- Caso de prueba para el procedimiento el con una anomal�a que no existe (deber�a fallar)
BEGIN
    PK_ANOMALIAS.el('A999');
END;

-- <=========Paquete PK_EVALUACIONES===========>

CREATE OR REPLACE PACKAGE PK_EVALUACIONES AS
        PROCEDURE ad(p_a_omes IN VARCHAR2,p_tid IN VARCHAR2 ,p_nid IN VARCHAR2,p_fecha IN DATE, p_descripcion IN VARCHAR2,p_reporte IN VARCHAR2, p_resultado IN VARCHAR2, p_idRespuesta IN NUMBER); 
        PROCEDURE mo(p_resultado IN VARCHAR2, p_a_omes IN VARCHAR2);
        PROCEDURE el(p_a_omes IN VARCHAR2);
        FUNCTION co RETURN SYS_REFCURSOR;
        PROCEDURE print_co;
END PK_EVALUACIONES;

CREATE OR REPLACE PACKAGE BODY PK_EVALUACIONES AS
    PROCEDURE ad(p_a_omes IN VARCHAR2, p_tid IN VARCHAR2, p_nid IN VARCHAR2, p_fecha IN DATE, p_descripcion IN VARCHAR2, p_reporte IN VARCHAR2, p_resultado IN VARCHAR2, p_idRespuesta IN NUMBER) AS
    BEGIN 
        INSERT INTO evaluaciones (a_omes, tid, nid, fecha, descripcion, reporte, resultado, idRespuesta) 
        VALUES (p_a_omes, p_tid, p_nid, p_fecha, p_descripcion, p_reporte, p_resultado, p_idRespuesta);
        COMMIT;
    END ad;
    
    PROCEDURE mo(p_resultado IN VARCHAR2, p_a_omes IN VARCHAR2) AS
        existe_evaluacion NUMBER;
    BEGIN
         SELECT COUNT(*) INTO existe_evaluacion FROM evaluaciones WHERE a_omes = p_a_omes;
        IF existe_evaluacion = 0 THEN 
            RAISE_APPLICATION_ERROR(-20004,'No existe la evaluacion');
        END IF;
        UPDATE evaluaciones SET resultado = p_resultado WHERE a_omes = p_a_omes;
        COMMIT; -- Confirmar los cambios
    END mo;
    
    PROCEDURE el(p_a_omes IN VARCHAR2) AS
        existe_evaluacion NUMBER;
    BEGIN
        SELECT COUNT(*) INTO existe_evaluacion FROM evaluaciones WHERE a_omes = p_a_omes;
        IF existe_evaluacion = 0 THEN 
            RAISE_APPLICATION_ERROR(-20004,'No existe la evaluacion');
        END IF;

        DELETE FROM evaluaciones WHERE a_omes = p_a_omes;
        COMMIT;
    END el;
       
    FUNCTION co RETURN SYS_REFCURSOR AS 
        v_cursor SYS_REFCURSOR;
    BEGIN 
        OPEN v_cursor FOR 
            SELECT * FROM evaluaciones;
        RETURN v_cursor;
    END co;
    
    PROCEDURE print_co AS
        v_evaluaciones_cursor SYS_REFCURSOR;
        v_a_omes evaluaciones.a_omes%TYPE;
        v_tid evaluaciones.tid%TYPE;
        v_nid evaluaciones.nid%TYPE;
        v_fecha evaluaciones.fecha%TYPE;
        v_descripcion evaluaciones.descripcion%TYPE;
        v_reporte evaluaciones.reporte%TYPE;
        v_resultado evaluaciones.resultado%TYPE;
        v_idRespuesta evaluaciones.idRespuesta%TYPE;
    BEGIN 
        v_evaluaciones_cursor := PK_EVALUACIONES.co;
    LOOP
        FETCH v_evaluaciones_cursor INTO v_a_omes, v_tid, v_nid, v_fecha, v_descripcion, v_reporte, v_resultado, v_idRespuesta;
        EXIT WHEN v_evaluaciones_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('A_OMES: ' || v_a_omes || ', TID: ' || v_tid || ', NID: ' || v_nid || ', FECHA: ' || v_fecha || ', DESCRIPCI�N: ' || v_descripcion || ', REPORTE: ' || v_reporte || ', RESULTADO: ' || v_resultado || ', ID_RESPUESTA: ' || v_idRespuesta);
    END LOOP;
    CLOSE v_evaluaciones_cursor;
    END print_co;
END PK_EVALUACIONES;

-- Caso de prueba para el procedimiento ad
BEGIN 
    PK_EVALUACIONES.ad('202410', 'CC', 'NID001', SYSDATE, '(A)Descripci�n evaluaci�n 1', 'https://example.com/evaluacion12.pdf', 'AP', 1);
END;

-- Caso de prueba para el procedimiento mo (actualizar el resultado de la evaluaci�n a 'Aprobado')
BEGIN
    PK_EVALUACIONES.mo('PE','202410');
END;
-- Caso de prueba para el procedimiento el (eliminar la evaluaci�n con a_omes '01') - CASO DE �XITO
BEGIN
    PK_EVALUACIONES.el('202410');
END;
-- Caso de prueba para la funci�n co (imprimir todas las evaluaciones)
BEGIN
    PK_EVALUACIONES.print_co;
END;

-- CASOS NO OK 
-- Caso de prueba para el procedimiento ad con un formato de fecha inv�lido
BEGIN 
    PK_EVALUACIONES.ad('202410', 'CC', 'NID001', SYSDATE, 'Descripci�n evaluaci�n 1', 'https://example.com/evaluacion12.pdf', 'AP', 1);
END;

-- Caso de prueba para el procedimiento mo con un resultado inv�lido
BEGIN
    PK_EVALUACIONES.mo('PE','151');
END;

-- Caso de prueba para el procedimiento el con un a_omes inexistente - CASO DE FRACASO
BEGIN
    PK_EVALUACIONES.el('99');
END;


-- =============================> D. Modelo f�sico. Seguridad

-- ======================================================================= AUDITOR =======================================================================
CREATE OR REPLACE PACKAGE PA_AUDITOR AS
        PROCEDURE auditorias_ad (p_idAuditoria IN VARCHAR2 ,p_fecha IN DATE, p_accion IN VARCHAR2 ,p_nombre IN VARCHAR2 ,p_codigoCategoria IN VARCHAR2,p_codigo_a_omes IN VARCHAR2);
        PROCEDURE auditorias_mo;
        PROCEDURE auditorias_el(p_idAuditoria IN NUMBER);
        PROCEDURE auditorias_print_co;
        ---
        PROCEDURE evaluaciones_ad(p_a_omes IN VARCHAR2,p_tid IN VARCHAR2 ,p_nid IN VARCHAR2,p_fecha IN DATE, p_descripcion IN VARCHAR2,p_reporte IN VARCHAR2, p_resultado IN VARCHAR2, p_idRespuesta IN NUMBER); 
        PROCEDURE evaluaciones_print_co;
        ---
        PROCEDURE anomalias_ad(p_id_anomalia IN VARCHAR2, p_id_evaluacion IN VARCHAR2, p_texto_descriptivo IN VARCHAR2, p_prioridad IN VARCHAR2);
        PROCEDURE anomalias_mo(p_id_anomalia IN VARCHAR2, p_columna IN VARCHAR2, p_nuevo_valor IN VARCHAR2);
        PROCEDURE anomalias_el(p_id_anomalia IN VARCHAR2);
        PROCEDURE anomalias_print_co;
        PROCEDURE anomalias_print_co_prioridadEstadoPendiente;
END PA_AUDITOR;

CREATE OR REPLACE PACKAGE BODY PA_AUDITOR AS
        PROCEDURE auditorias_ad (p_idAuditoria IN VARCHAR2 ,p_fecha IN DATE, p_accion IN VARCHAR2 ,p_nombre IN VARCHAR2 ,p_codigoCategoria IN VARCHAR2,p_codigo_a_omes IN VARCHAR2) AS
        BEGIN
            PK_AUDITORIAS.ad(p_idAuditoria,p_fecha,p_accion,p_nombre,p_codigoCategoria,	p_codigo_a_omes);
        END auditorias_ad;

        PROCEDURE auditorias_mo AS
        BEGIN
            PK_AUDITORIAS.mo;
        END auditorias_mo;

        PROCEDURE auditorias_el(p_idAuditoria IN NUMBER) AS
        BEGIN
            PK_AUDITORIAS.el(p_idAuditoria);
        END auditorias_el;

        PROCEDURE auditorias_print_co AS
        BEGIN
            PK_AUDITORIAS.print_co;
        END auditorias_print_co;
        ------
        PROCEDURE evaluaciones_ad(p_a_omes IN VARCHAR2,p_tid IN VARCHAR2 ,p_nid IN VARCHAR2,p_fecha IN DATE, p_descripcion IN VARCHAR2,p_reporte IN VARCHAR2, p_resultado IN VARCHAR2, p_idRespuesta IN NUMBER) AS
        BEGIN
            PK_EVALUACIONES.ad(p_a_omes,p_tid,p_nid,p_fecha,p_descripcion,p_reporte,p_resultado,p_idRespuesta);
        END evaluaciones_ad;

        PROCEDURE evaluaciones_print_co AS
        BEGIN 
            PK_EVALUACIONES.print_co;
        END evaluaciones_print_co;
        ------
        PROCEDURE anomalias_ad(p_id_anomalia IN VARCHAR2, p_id_evaluacion IN VARCHAR2, p_texto_descriptivo IN VARCHAR2, p_prioridad IN VARCHAR2) AS
        BEGIN 
            PK_ANOMALIAS.ad(p_id_anomalia, p_id_evaluacion, p_texto_descriptivo, p_prioridad);
        END anomalias_ad;

        PROCEDURE anomalias_mo(p_id_anomalia IN VARCHAR2, p_columna IN VARCHAR2, p_nuevo_valor IN VARCHAR2) AS
        BEGIN
            PK_ANOMALIAS.mo(p_id_anomalia, p_columna, p_nuevo_valor);
        END anomalias_mo;

        PROCEDURE anomalias_el(p_id_anomalia IN VARCHAR2) AS
        BEGIN
            PK_ANOMALIAS.el(p_id_anomalia);
        END;

        PROCEDURE anomalias_print_co AS
        BEGIN
            PK_ANOMALIAS.print_co;
        END anomalias_print_co;

        PROCEDURE anomalias_print_co_prioridadEstadoPendiente AS
        BEGIN
            PK_ANOMALIAS.print_co_prioridadEstadoPendiente;
        END anomalias_print_co_prioridadEstadoPendiente;
    END PA_AUDITOR;


-- PRUEBAS OK 
-- add
BEGIN 
    PA_AUDITOR.auditorias_ad('07','27-MAR-24','D','Nombre 6',	'B002',	'202402');
END;
    -- mo
BEGIN
    PA_AUDITOR.auditorias_mo;
END;
-- el
BEGIN
    PA_AUDITOR.auditorias_el('06');
END;
-- co
BEGIN
    PA_AUDITOR.auditorias_print_co;
END;

-- Caso de prueba para el procedimiento ad
BEGIN 
    PA_AUDITOR.evaluaciones_ad('202410', 'CC', 'NID001', SYSDATE, '(A)Descripci�n evaluaci�n 1', 'https://example.com/evaluacion12.pdf', 'AP', 1);
END;
 

-- Caso de prueba para la funci�n co (imprimir todas las evaluaciones)
BEGIN
    PA_AUDITOR.evaluaciones_print_co;
END;
 
-- CASOS NO OK 
-- Caso de prueba para el procedimiento ad con un formato de fecha inv�lido
BEGIN 
    PA_AUDITOR.evaluaciones_ad('202410', 'CC', 'NID001', SYSDATE, 'Descripci�n evaluaci�n 1', 'https://example.com/evaluacion12.pdf', 'AP', 1);
END;

-- ===================================================================== ANOMALIAS
-- Caso de prueba para el procedimiento ad
BEGIN 

    PA_AUDITOR.anomalias_ad('A002', '202403', 'Texto de prueba', 'P');

END;
 
-- Caso de prueba para el procedimiento mo (actualizar 'prioridad' de la anomal�a con ID 'A001' a 'B')

BEGIN

    PA_AUDITOR.anomalias_mo('A002', 'prioridad', 'B');

END;
 
-- Caso de prueba para el procedimiento el (eliminar la anomal�a con ID 'A001')

BEGIN

    PA_AUDITOR.anomalias_el('A002');

END;
 
-- Caso de prueba para la funci�n co (imprimir todas las anomal�as)

BEGIN

    PA_AUDITOR.anomalias_print_co;

END;
 
-- Caso de prueba para la funci�n co_prioridadEstadoPendiente (imprimir todas las anomal�as con prioridad 'Estado Pendiente')

BEGIN

    PA_AUDITOR.anomalias_print_co_prioridadEstadoPendiente;

END;
 
-- CASOS NO OK  

-- Caso de prueba para el procedimiento ad con una anomal�a que ya existe (deber�a fallar)

BEGIN 

    PA_AUDITOR.anomalias_ad('A001', 'E003', 'Texto de prueba', 'A');

END;
 
-- Caso de prueba para el procedimiento mo con una columna no v�lida (deber�a fallar)

BEGIN
PA_AUDITOR.anomalias_mo('A001', 'columna_invalida', 150);

END;
 
-- Caso de prueba para el procedimiento el con una anomal�a que no existe (deber�a fallar)

BEGIN

    PA_AUDITOR.anomalias_el('A999');

END;

-- ======================================================================= ADMINISTRADOR =======================================================================

CREATE OR REPLACE PACKAGE PA_ADMINISTRADOR AS
        PROCEDURE categoria_ad(p_codigo IN VARCHAR2 ,p_nombre IN VARCHAR2 ,p_tipo IN VARCHAR,p_minimo IN NUMBER ,p_maximo IN NUMBER,p_codigo1 IN VARCHAR2);
        PROCEDURE categoria_mo(p_codigo IN VARCHAR2, p_columna IN VARCHAR2, p_nuevo_valor IN NUMBER);
        PROCEDURE categoria_el(p_codigo IN VARCHAR2);
        PROCEDURE categoria_print_co;
        PROCEDURE categoria_print_co_masArticulos;
END PA_ADMINISTRADOR;

CREATE OR REPLACE PACKAGE BODY PA_ADMINISTRADOR AS
        PROCEDURE categoria_ad(p_codigo IN VARCHAR2 ,p_nombre IN VARCHAR2 ,p_tipo IN VARCHAR,p_minimo IN NUMBER ,p_maximo IN NUMBER,p_codigo1 IN VARCHAR2) AS
        BEGIN
            PK_CATEGORIAS.ad(p_codigo ,p_nombre ,p_tipo ,p_minimo ,p_maximo ,p_codigo1);
        END categoria_ad;

        PROCEDURE categoria_mo(p_codigo IN VARCHAR2, p_columna IN VARCHAR2, p_nuevo_valor IN NUMBER) AS
        BEGIN
            PK_CATEGORIAS.mo(p_codigo, p_columna, p_nuevo_valor);
        END categoria_mo;

        PROCEDURE categoria_el(p_codigo IN VARCHAR2) AS
        BEGIN
            PK_CATEGORIAS.el(p_codigo);
        END categoria_el;

        PROCEDURE categoria_print_co AS
        BEGIN
            PK_CATEGORIAS.print_co;
        END categoria_print_co;

        PROCEDURE categoria_print_co_masArticulos AS
        BEGIN
            PK_CATEGORIAS.print_co_masArticulos;
        END categoria_print_co_masArticulos;        
    END PA_ADMINISTRADOR;
    
-- CASOS DE PRUEBA
-- Caso de prueba para el procedimiento ad
BEGIN 
    PA_ADMINISTRADOR.categoria_ad('C010', 'Nombre 6', 'R', 100, 200, 'A003');
END;
 
-- Caso de prueba para el procedimiento mo (actualizar 'minimo' de la categor�a con c�digo '06' a 150)
BEGIN
    PA_ADMINISTRADOR.categoria_mo('C010', 'minimo', 150);
END;
-- Caso de prueba para el procedimiento el (eliminar la categor�a con c�digo '06') - CASO DE FRACASO
BEGIN
    PA_ADMINISTRADOR.categoria_el('D006');
END;

--SELECT * FROM CATEGORIAS;
-- Caso de prueba para la funci�n co (imprimir todas las categor�as)
BEGIN
    PA_ADMINISTRADOR.categoria_print_co;
END;
 
-- Caso de prueba para la funci�n co_masArticulos (imprimir la categor�a con m�s art�culos)
BEGIN
 PA_ADMINISTRADOR.categoria_print_co_masArticulos;
END;
--====================================== XCRUD
ALTER PACKAGE PK_ARTICULOS COMPILE INVALIDATE BODY;
ALTER PACKAGE PK_AUDITORIAS COMPILE INVALIDATE BODY;
ALTER PACKAGE PK_CATEGORIAS COMPILE INVALIDATE BODY;
ALTER PACKAGE PK_ANOMALIAS COMPILE INVALIDATE BODY;
ALTER PACKAGE PK_EVALUACIONES COMPILE INVALIDATE BODY;
ALTER PACKAGE PA_AUDITOR COMPILE INVALIDATE BODY;
ALTER PACKAGE PA_ADMINISTRADOR COMPILE INVALIDATE BODY;
DROP PACKAGE PK_ARTICULOS;
DROP PACKAGE PK_AUDITORIAS;
DROP PACKAGE PK_CATEGORIAS;
DROP PACKAGE PK_ANOMALIAS;
DROP PACKAGE PK_EVALUACIONES;
DROP PACKAGE PA_AUDITOR;
DROP PACKAGE PA_ADMINISTRADOR;

-- =============================> ROLES Y PERMISOS
-- Crear el primer rol para administradores de categor�as
CREATE ROLE ADMINISTRADOR;

-- Crear el segundo rol para usuarios con acceso a las categor�as
CREATE ROLE AUDITOR;

-- Otorgar permisos al primer rol
GRANT EXECUTE ON PA_ADMINISTRADOR TO ADMINISTRADOR;

-- Otorgar permisos al segundo rol
GRANT EXECUTE ON PA_AUDITOR TO AUDITOR;

-- ===========================> Seguridad y autorizaciones
-- Asignar roles a los usuarios espec�ficos
GRANT AUDITOR TO BD1000096183;

-- Si tienes usuarios que solo necesitan acceso de lectura a las categor�as
GRANT ADMINISTRADOR TO BD1000098178;    

-- ===== xseguridad
-- Revocar permisos de un rol
REVOKE EXECUTE ON PA_ADMINISTRADOR FROM ADMINISTRADOR;
REVOKE EXECUTE ON PA_AUDITOR FROM AUDITOR;

-- Eliminar roles
DROP ROLE ADMINISTRADOR;
DROP ROLE AUDITOR;

-- Si deseas revocar el rol asignado a un usuario espec�fico
REVOKE AUDITOR FROM BD1000096183;
REVOKE ADMINISTRADOR FROM BD1000095200;

-- D. Pruebas



-- Historia de Usuario:
-- Como usuario administrador del sistema, quiero poder agregar una nueva categor�a de productos para organizar mejor la informaci�n.

--Prueba de Aceptaci�n:

-- 1. Descripci�n: Como usuario administrador, quiero agregar una nueva categor�a de productos.
BEGIN
    PA_ADMINISTRADOR.categoria_ad('C013', 'Electr�nicos', 'A', 50, 100, 'B002');
END;


-- 2. Descripci�n: Verificar que la categor�a se agreg� correctamente.
SET SERVEROUTPUT ON;
BEGIN 
    PA_ADMINISTRADOR.categoria_print_co;
END;

-- 3. Descripci�n: Intentar agregar una categor�a con un c�digo que ya existe (acci�n no permitida).

BEGIN
    PA_ADMINISTRADOR.categoria_ad('C012', 'Electr�nicos', 'A', 50, 100, 'B002');
END;
-- Nota: Esto deber�a generar un error ya que el c�digo 'C012' ya est� en uso.

-- 4. Descripci�n: Verificar que la categor�a no se agreg� debido a un c�digo duplicado.
SET SERVEROUTPUT ON;
BEGIN 
    PA_ADMINISTRADOR.categoria_print_co;
END;

-- 5. Descripci�n: Agregar una categor�a con valores extremos para minimo y maximo.

BEGIN
    PA_ADMINISTRADOR.categoria_ad('C013', 'Libros', 'L', 50, 250, 'A003');
END;

-- 6. Descripci�n: Verificar que la categor�a se agreg� correctamente con valores extremos.

SET SERVEROUTPUT ON;
BEGIN 
    PA_ADMINISTRADOR.categoria_print_co;
END;

-- 7. Descripci�n: Intentar agregar una categor�a con un tipo de acceso no v�lido (acci�n no permitida).

BEGIN
    PA_ADMINISTRADOR.categoria_ad('C014', 'Herramientas', 'X', 10, 500, 'A004');
END;
-- Nota: Esto deber�a generar un error ya que el tipo de acceso 'X' no es v�lido.

-- 8. Descripci�n: Verificar que la categor�a no se agreg� debido a un tipo de acceso no v�lido.

SET SERVEROUTPUT ON;
BEGIN 
    PA_ADMINISTRADOR.categoria_print_co;
END;

-- 9. Descripci�n: Intentar agregar una categor�a con valores m�nimos y m�ximos invertidos (acci�n no permitida).
BEGIN
    PA_ADMINISTRADOR.categoria_ad('C015', 'Juguetes', 'R', 200, 50, 'A005');
END;

-- Nota: Esto deber�a generar un error ya que el valor m�nimo es mayor que el valor m�ximo.

-- 10. Descripci�n: Verificar que la categor�a no se agreg� debido a valores m�nimos y m�ximos invertidos.
SET SERVEROUTPUT ON;
BEGIN 
    PA_ADMINISTRADOR.categoria_print_co;
END;


-- <========================================================= LAB06 ==========================================================================>
-- PUNTO DOS. (XML � Oracle) trueques Evaluaci�n. TDescripcion
-- Este punto vamos a perfeccionar uno de los atributos de la base de datos.
-- 1) Proponga la estructura XML necesaria para tener la informaci�n del atributo descripci�n. DTD y ejemplos XML OK y XML NoOK. Explique.

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE descripciones [
    <!ELEMENT descripciones (descripcion+)>
    <!ELEMENT descripcion (anomalia*)>
    <!ELEMENT anomalia (texto_descriptivo+)>
    <!ATTLIST anomalia
        identificacion CDATA #REQUIRED
        prioridad (A|M|B) #REQUIRED
    >
    <!ELEMENT texto_descriptivo (#PCDATA)>
]>

<descripciones>
    <descripcion>
        <anomalia identificacion = "10001" prioridad = "A">
            <texto_descriptivo>La anomalia se debe a un mal funcionamiento de un trigger arbitrario</texto_descriptivo>
        </anomalia>
    </descripcion>
</descripciones>
-- 2) Actualice la tabla y los datos adicionados a la base de datos. (PoblandoOK, PoblandoNoOK).

ALTER TABLE evaluaciones ADD descripcion_xml XMLType;

SELECT * FROM evaluaciones

-- poblando ok

UPDATE evaluaciones 
SET DESCRIPCION_XML = '<descripciones>
    <descripcion>
        <anomalia identificacion = "10002" prioridad = "A">
            <texto_descriptivo>La anomalia se debe a un error en el storage procedure xxxx </texto_descriptivo>
        </anomalia>
    </descripcion>
</descripciones>'
WHERE A_OMES in (202410,202401,202402,202403,202404,202405,202409,202407,202408);

SELECT e.*, x.identificacion, x.prioridad, x.texto_descriptivo
FROM evaluaciones e,
     XMLTable('/descripciones/descripcion/anomalia' 
              PASSING e.descripcion_xml
              COLUMNS identificacion VARCHAR2(10) PATH '@identificacion',
                      prioridad VARCHAR2(1) PATH '@prioridad',
                      texto_descriptivo VARCHAR2(100) PATH 'texto_descriptivo') x;

-- poblando no ok
UPDATE evaluaciones 
SET DESCRIPCION_XML = '<descripciones>
    <descripcion>
        <anomalia identificacion = "10002" prioridad = "U">
            <texto_descriptivo>La anomalia se debe a un error en el storage procedure xxxx </texto_descriptivo>
        </anomalia>
    </descripcion>
</descripciones>'
WHERE A_OMES in (202410,202401,202402,202403,202404,202405,202409,202407,202408);
--debería mostrar mensaje de error al saber que no existe prioridad U
SELECT e.*, x.identificacion, x.prioridad, x.texto_descriptivo
FROM evaluaciones e,
     XMLTable('/descripciones/descripcion/anomalia' 
              PASSING e.descripcion_xml
              COLUMNS identificacion VARCHAR2(10) PATH '@identificacion',
                      prioridad VARCHAR2(1) PATH '@prioridad',
                      texto_descriptivo VARCHAR2(100) PATH 'texto_descriptivo') x;

-- 3) Implemente la consulta Consultar anomal�as de prioridad alta en estado pendiente.

SELECT *
FROM evaluaciones
WHERE XMLExists('/descripciones/descripcion/anomalia[@prioridad="B"]'
                PASSING descripcion_xml) AND resultado = 'PE';


-- 4) Proponga otra nueva consulta que use ese atributo (Dise�o e implementaci�n)

SELECT *
FROM evaluaciones
WHERE XMLExists('/descripciones/descripcion/anomalia[@prioridad="A"]'
                PASSING descripcion_xml) AND resultado = 'AP';
-- 5) Extienda la informaci�n de este atributo (DTD) y proponga una nueva consulta que ilustre la pertinencia de la nueva informaci�n registrada en XML. (Dise�o e implementaci�n)

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE descripciones [
    <!ELEMENT descripciones (descripcion+)>
    <!ELEMENT descripcion (anomalia*)>
    <!ELEMENT anomalia (texto_descriptivo+)>
    <!ATTLIST anomalia
        identificacion CDATA #REQUIRED
        prioridad (A|M|B|U) #REQUIREDA
    >
    <!ELEMENT texto_descriptivo (#PCDATA)>
]>

UPDATE evaluaciones 
SET DESCRIPCION_XML = '<descripciones>
    <descripcion>
        <anomalia identificacion = "10002" prioridad = "U">
            <texto_descriptivo>Anomali� urgente, se ha caido el sistema de base de datos de la region central de colombia </texto_descriptivo>
        </anomalia>
    </descripcion>
</descripciones>'
WHERE A_OMES = 202401;

                
SELECT e.*, x.identificacion, x.prioridad, x.texto_descriptivo
FROM evaluaciones e,
     XMLTable('/descripciones/descripcion/anomalia' 
              PASSING e.descripcion_xml
              COLUMNS identificacion VARCHAR2(10) PATH '@identificacion',
                      prioridad VARCHAR2(1) PATH '@prioridad',
                      texto_descriptivo VARCHAR2(100) PATH 'texto_descriptivo') x
                    WHERE XMLExists('/descripciones/descripcion/anomalia[@prioridad="U"]'
                PASSING descripcion_xml) AND resultado = 'PE';








