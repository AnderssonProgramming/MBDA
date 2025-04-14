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
ADD CONSTRAINT prioridad_check CHECK (prioridad IN ('A','M','B')
 
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
SELECT *
FROM mbda.DATA
where nombres = 'Julian Santiago Cardenas';
 
SELECT COUNT(DISTINCT nombres) FROM mbda.DATA;
 
SELECT COUNT(DISTINCT UNOMBRE) FROM mbda.DATA;
 
 
INSERT INTO mbda.DATA(UCODIGO,UNOMBRE, UDIRECCION, NID, NOMBRES) VALUES (111,'ESCUELA', 'AK 45 (Autonorte) #205-59', 1000096183,'Andersson Sánchez');
INSERT INTO MBDA.DATA (UCODIGO,UNOMBRE,UDIRECCION,NID,NOMBRES) VALUES(111,'ESCUELA','AK 45 (Autonorte) #205-59','1000098857','Cristian Santiago Pedraza');
 
SELECT * FROM MBDA.DATA where NID IN ('1000098857','1000096183');
SELECT * FROM MBDA.DATA where NID = '1000096183';
 
UPDATE MBDA.DATA
SET NOMBRES = 'Andersson'
WHERE NID = '1000096183';
 
UPDATE MBDA.DATA
SET NOMBRES = 'Cristian Pedraza'
WHERE NID = '1000098857';
 
DELETE FROM MBDA.DATA 
WHERE NID = '1000098857';
 
DELETE FROM MBDA.DATA 
WHERE NID = '1000096183';
 
 
SELECT DISTINCT(UNOMBRE) FROM mbda.DATA;
 
 
SELECT
--    CODALEATORIO,
    UCODIGO, -- El código generado aleatoriamente    
    'CC' AS TID, -- Tipo de documento siempre es 'CC'
    NID, -- Número de documento
    NOMBRES, -- Nombre del cliente
    CASE 
        WHEN UNOMBRE = 'ESCUELA' THEN 'Ingeniería'
        WHEN UNOMBRE = 'ROSARIO' THEN 'Derecho'
        WHEN UNOMBRE = 'JAVERIANA' THEN 'Medicina'
        ELSE 'Por definir'
    END AS PROGRAMA, -- Convertir el nombre de la universidad al programa correspondiente
    SUBSTR(NOMBRES, 1, INSTR(NOMBRES, ' ') - 1) || LOWER(SUBSTR(UNOMBRE, 1, 7)) || '@mail.edu.co' AS CORREO,
    SYSDATE AS REGISTRO, -- Fecha de registro (hoy),
--    'No' AS SUSPENSION, -- Ningún cliente ha sido suspendido
    0 AS NSUSPENSIONES -- Inicializar el número de suspensiones en 0
FROM MBDA.DATA;
SELECT
--    CODALEATORIO,
    UCODIGO, -- El código generado aleatoriamente    
    'CC' AS TID, -- Tipo de documento siempre es 'CC'
    NID, -- Número de documento
    NOMBRES, -- Nombre del cliente
    CASE 
        WHEN UNOMBRE = 'ESCUELA' THEN 'Ingeniería'
        WHEN UNOMBRE = 'ROSARIO' THEN 'Derecho'
        WHEN UNOMBRE = 'JAVERIANA' THEN 'Medicina'
        ELSE 'Por definir'
    END AS PROGRAMA, -- Convertir el nombre de la universidad al programa correspondiente
    SUBSTR(NOMBRES, 1, INSTR(NOMBRES, ' ') - 1) || LOWER(SUBSTR(UNOMBRE, 1, 7)) || '@edu.co' AS CORREO,
    SYSDATE AS REGISTRO -- Fecha de registro (hoy)
--    'No' AS SUSPENSION, -- Ningún cliente ha sido suspendido
--    0 AS NSUSPENSIONES -- Inicializar el número de suspensiones en 0
FROM MBDA.DATA;
SELECT
--    CODALEATORIO,
    UCODIGO, -- El código generado aleatoriamente    
    'CC' AS TID, -- Tipo de documento siempre es 'CC'
    NID, -- Número de documento
    NOMBRES, -- Nombre del cliente
    CASE 
        WHEN UNOMBRE = 'ESCUELA' THEN 'Ingeniería'
        WHEN UNOMBRE = 'ROSARIO' THEN 'Derecho'
        WHEN UNOMBRE = 'JAVERIANA' THEN 'Medicina'
        ELSE 'Por definir'
    END AS PROGRAMA, -- Convertir el nombre de la universidad al programa correspondiente
    SUBSTR(NOMBRES, 1, INSTR(NOMBRES, ' ') - 1) || LOWER(SUBSTR(UNOMBRE, 1, 7)) || '@mail.escuelaing.edu.co' AS CORREO,
    SYSDATE AS REGISTRO -- Fecha de registro (hoy)
--    'No' AS SUSPENSION, -- Ningún cliente ha sido suspendido
--    0 AS NSUSPENSIONES -- Inicializar el número de suspensiones en 0
FROM MBDA.DATA;
SELECT
--    CODALEATORIO,
    UCODIGO, -- El código generado aleatoriamente    
    'CC' AS TID, -- Tipo de documento siempre es 'CC'
    NID, -- Número de documento
    NOMBRES, -- Nombre del cliente
    CASE 
        WHEN UNOMBRE = 'ESCUELA' THEN 'Ingeniería'
        WHEN UNOMBRE = 'ROSARIO' THEN 'Derecho'
        WHEN UNOMBRE = 'JAVERIANA' THEN 'Medicina'
        ELSE 'Por definir'
    END AS PROGRAMA, -- Convertir el nombre de la universidad al programa correspondiente
    SUBSTR(NOMBRES, 1, INSTR(NOMBRES, ' ') - 1) || LOWER(SUBSTR(UNOMBRE, 1, 7)) || '.edu.co' AS CORREO,
    SYSDATE AS REGISTRO -- Fecha de registro (hoy)
--    'No' AS SUSPENSION, -- Ningún cliente ha sido suspendido
--    0 AS NSUSPENSIONES -- Inicializar el número de suspensiones en 0
FROM MBDA.DATA;
SELECT
--    CODALEATORIO,
    UCODIGO, -- El código generado aleatoriamente    
    'CC' AS TID, -- Tipo de documento siempre es 'CC'
    NID, -- Número de documento
    NOMBRES, -- Nombre del cliente
    CASE 
        WHEN UNOMBRE = 'ESCUELA' THEN 'Ingeniería'
        WHEN UNOMBRE = 'ROSARIO' THEN 'Derecho'
        WHEN UNOMBRE = 'JAVERIANA' THEN 'Medicina'
        ELSE 'Por definir'
    END AS PROGRAMA, -- Convertir el nombre de la universidad al programa correspondiente
    --CONCAT(SUBSTRING_INDEX(NOMBRES, ' ', 1), LOWER(SUBSTRING_INDEX(UNOMBRE, ' ', 1)), '.edu.co') AS CORREO -- Construir el correo
    SYSDATE AS REGISTRO -- Fecha de registro (hoy)
--    'No' AS SUSPENSION, -- Ningún cliente ha sido suspendido
--    0 AS NSUSPENSIONES -- Inicializar el número de suspensiones en 0
FROM MBDA.DATA;
SELECT
--    CODALEATORIO,
    UCODIGO, -- El código generado aleatoriamente    
    'CC' AS TID, -- Tipo de documento siempre es 'CC'
    NID, -- Número de documento
    NOMBRES, -- Nombre del cliente
    CASE 
        WHEN UNOMBRE = 'ESCUELA' THEN 'Ingeniería'
        WHEN UNOMBRE = 'ROSARIO' THEN 'Derecho'
        WHEN UNOMBRE = 'JAVERIANA' THEN 'Medicina'
        ELSE 'Por definir'
    END AS PROGRAMA -- Convertir el nombre de la universidad al programa correspondiente
    --CONCAT(SUBSTRING_INDEX(NOMBRES, ' ', 1), LOWER(SUBSTRING_INDEX(UNOMBRE, ' ', 1)), '.edu.co') AS CORREO -- Construir el correo
    --SELECT SYSDATE FROM DUAL AS REGISTRO -- Fecha de registro (hoy)
--    'No' AS SUSPENSION, -- Ningún cliente ha sido suspendido
--    0 AS NSUSPENSIONES -- Inicializar el número de suspensiones en 0
FROM MBDA.DATA;
SELECT SYSDATE FROM DUAL
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

ALTER TABLE usuarios 
ENABLE CONSTRAINT UK2_usuarios
 
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

ALTER TABLE universidades
DISABLE CONSTRAINT FK_universidades_usuarios;
 
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

ALTER TABLE usuarios
DISABLE CONSTRAINT correo_check 
 
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
---
-- Insertar universidades asignando los códigos de universidad correspondientes
INSERT INTO universidades (codigo, nombre, direccion, codigoUsuario) 
VALUES ('001', 'SABANA', 'Dirección A', 'codigoU1');

INSERT INTO universidades (codigo, nombre, direccion, codigoUsuario) 
VALUES ('002', 'ESCUELA', 'Dirección B', 'codigoU2');

INSERT INTO universidades (codigo, nombre, direccion, codigoUsuario) 
VALUES ('003', 'ANDES', 'Dirección C', 'codigoU3');

INSERT INTO universidades (codigo, nombre, direccion, codigoUsuario) 
VALUES ('004', 'ESCUELA', 'Dirección A', 'codigoU4');

INSERT INTO universidades (codigo, nombre, direccion, codigoUsuario) 
VALUES ('005', 'JAVERIANA', 'Dirección B', 'codigoU5');

INSERT INTO universidades (codigo, nombre, direccion, codigoUsuario) 
VALUES ('006', 'ROSARIO', 'Dirección C', 'codigoU6');

 
 
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
SELECT CURLDATE()
 
select * from auditorias
select * from evaluaciones

-- <========================================================= LAB05 ==========================================================================>
/*INSERT INTO usuarios (CODIGO, CODIGOUNIVERSIDAD, TID, NID, NOMBRE, PROGRAMA, CORREO, REGISTRO, SUSPENSION, NSUSPENSIONES)
SELECT
--    CODALEATORIO,
    --UPPER(DBMS_RANDOM.STRING('X', 10), -- El código generado aleatoriamente    
    'CC' AS TID, -- Tipo de documento siempre es 'CC'
    NID, -- Número de documento
    NOMBRES, -- Nombre del cliente
    CASE 
        WHEN UNOMBRE = 'ESCUELA' THEN 'Ingeniería'
        WHEN UNOMBRE = 'ROSARIO' THEN 'Derecho'
        WHEN UNOMBRE = 'JAVERIANA' THEN 'Medicina'
        ELSE 'Por definir'
    END AS PROGRAMA, -- Convertir el nombre de la universidad al programa correspondiente
    SUBSTR(NOMBRES, 1, INSTR(NOMBRES, ' ') - 1) || LOWER(SUBSTR(UNOMBRE, 1, 7)) || '@mail.edu.co' AS CORREO,
    SYSDATE AS REGISTRO, -- Fecha de registro (hoy),
    null AS SUSPENSION, -- Ningún cliente ha sido suspendido
    0 AS NSUSPENSIONES -- Inicializar el número de suspensiones en 0
FROM MBDA.DATA;
*/

select * from usuarios 
INSERT INTO universidades (codigo, nombre, direccion, codigoUsuario) VALUES ('111', 'ESCUELA', 'Direcci n H', 'codigoU4'); 
ALTER TABLE universidades DISABLE CONSTRAINT UK_CODIGO_USUARIOS;


INSERT INTO usuarios (CODIGO, CODIGOUNIVERSIDAD, TID, NID, NOMBRE, PROGRAMA, CORREO, REGISTRO, SUSPENSION, NSUSPENSIONES)
    SELECT
        UPPER(codigo_aleatorio) AS CODALEATORIO,
        'CC' AS TID,
        NID,
        NOMBRES,
        CASE 
            WHEN UNOMBRE = 'ESCUELA' THEN 'Ingeniería'
            WHEN UNOMBRE = 'ROSARIO' THEN 'Derecho'
            WHEN UNOMBRE = 'JAVERIANA' THEN 'Medicina'
            ELSE 'Por definir'
        END AS PROGRAMA,
        SUBSTR(NOMBRES, 1, INSTR(NOMBRES, ' ') - 1) || LOWER(SUBSTR(UNOMBRE, 1, 7)) || '@mail.edu.co' AS CORREO,
        SYSDATE AS REGISTRO,
        NULL AS SUSPENSION,
        0 AS NSUSPENSIONES
    FROM (
        SELECT DISTINCT DBMS_RANDOM.STRING('X', 10) AS codigo_aleatorio, 
               NID, 
               NOMBRES, 
               UNOMBRE
        FROM MBDA.DATA
        ORDER BY DBMS_RANDOM.RANDOM
    ) WHERE ROWNUM <= 600; -- Cambia el número 10 por la cantidad de filas que deseas seleccionar
FROM MBDA.DATA;

INSERT INTO usuarios (CODIGO, CODIGOUNIVERSIDAD, TID, NID, NOMBRE, PROGRAMA, CORREO, REGISTRO, SUSPENSION, NSUSPENSIONES)
    SELECT
        UPPER(codigo_aleatorio) AS CODALEATORIO,
        NULL AS CODIGOUNIVERSIDAD, -- Aquí debes especificar qué valor deseas para CODIGOUNIVERSIDAD
        'CC' AS TID,
        NID,
        NOMBRES,
        CASE 
            WHEN UNOMBRE = 'ESCUELA' THEN 'Ingeniería'
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
    ) WHERE ROWNUM <= 218; -- Cambia el número 10 por la cantidad de filas que deseas seleccionar

SELECT * FROM USUARIOS

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
        RAISE_APPLICATION_ERROR(-20040, 'Las evaluaciones se pueden eliminar si no tienen anomalías.');
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
        RAISE_APPLICATION_ERROR(-20010, 'El registro no está asociado al año-mes definido en la evaluación.');
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


--> PAQUETES -------------------------------------------------------------------
-- Paquete PK_ARTICULOS: ---------------------->

CREATE OR REPLACE PACKAGE PK_ARTICULOS AS
    PROCEDURE ad();
    PROCEDURE mo();
    PROCEDURE el();
    FUNCTION co RETURN SYS_REFCURSOR;
    PROCEDURE articuloCategEval(p_codigoCategoria IN VARCHAR2);
END PK_ARTICULOS;
/

CREATE OR REPLACE PACKAGE BODY PK_ARTICULOS AS
    PROCEDURE ad() AS
    BEGIN
        -- Implementa la lógica para añadir un nuevo artículo
        NULL;
    END ad;
    
    PROCEDURE mo() AS
    BEGIN
        -- Implementa la lógica para modificar un artículo existente
        NULL;
    END mo;
    
    PROCEDURE el() AS
    BEGIN
        -- Implementa la lógica para eliminar un artículo
        NULL;
    END el;
    
    FUNCTION co RETURN SYS_REFCURSOR AS
        c_articulos SYS_REFCURSOR;
    BEGIN
        OPEN c_articulos FOR
        SELECT * FROM articulos;
        RETURN c_articulos;
    END co;
    
    PROCEDURE articuloCategEval(p_codigoCategoria IN VARCHAR2) AS
    BEGIN
        -- Implementa la lógica para consultar los artículos de una categoría específica y sus evaluaciones
        NULL;
    END articuloCategEval;
END PK_ARTICULOS;
/

Casos de prueba para PK_ARTICULOS:


BEGIN
    PK_ARTICULOS.ad();
    DBMS_OUTPUT.PUT_LINE('Éxito al añadir artículo');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al añadir artículo: ' || SQLERRM);
END;

BEGIN
    PK_ARTICULOS.mo();
    DBMS_OUTPUT.PUT_LINE('Éxito al modificar artículo');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al modificar artículo: ' || SQLERRM);
END;

BEGIN
    PK_ARTICULOS.el();
    DBMS_OUTPUT.PUT_LINE('Éxito al eliminar artículo');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al eliminar artículo: ' || SQLERRM);
END;

BEGIN
    DECLARE
        cur SYS_REFCURSOR;
        -- Declarar variables para almacenar datos de artículo
        v_idArticulo articulos.idArticulo%TYPE;
        v_descripcion articulos.descripcion%TYPE;
        -- Agregar más variables según la estructura de la tabla
    BEGIN
        cur := PK_ARTICULOS.co;
        LOOP
            FETCH cur INTO v_idArticulo, v_descripcion;
            EXIT WHEN cur%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('ID_ARTICULO: ' || v_idArticulo || ', DESCRIPCIÓN: ' || v_descripcion);
            -- Agregar más datos si es necesario
        END LOOP;
        CLOSE cur;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al consultar artículos: ' || SQLERRM);
    END;
END;

BEGIN
    PK_ARTICULOS.articuloCategEval('CATEGORIA_XYZ');
    DBMS_OUTPUT.PUT_LINE('Éxito al consultar artículos de una categoría y sus evaluaciones');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al consultar artículos de una categoría y sus evaluaciones: ' || SQLERRM);
END;

-- Paquete PK_AUDITORIAS: ---------------------->

CREATE OR REPLACE PACKAGE PK_AUDITORIAS AS
    PROCEDURE ad();
    PROCEDURE mo();
    PROCEDURE el();
    FUNCTION co RETURN SYS_REFCURSOR;
END PK_AUDITORIAS;
/

CREATE OR REPLACE PACKAGE BODY PK_AUDITORIAS AS
    PROCEDURE ad() AS
    BEGIN
        -- Implementa la lógica para añadir una nueva auditoría
        NULL;
    END ad;
    
    PROCEDURE mo() AS
    BEGIN
        -- Implementa la lógica para modificar una auditoría existente
        NULL;
    END mo;
    
    PROCEDURE el() AS
    BEGIN
        -- Implementa la lógica para eliminar una auditoría
        NULL;
    END el;
    
    FUNCTION co RETURN SYS_REFCURSOR AS
        c_auditorias SYS_REFCURSOR;
    BEGIN
        OPEN c_auditorias FOR
        SELECT * FROM auditorias;
        RETURN c_auditorias;
    END co;
END PK_AUDITORIAS;
/

Casos de prueba para PK_AUDITORIAS

BEGIN
    PK_AUDITORIAS.ad();
    DBMS_OUTPUT.PUT_LINE('Éxito al añadir auditoría');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al añadir auditoría: ' || SQLERRM);
END;

BEGIN
    PK_AUDITORIAS.mo();
    DBMS_OUTPUT.PUT_LINE('Éxito al modificar auditoría');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al modificar auditoría: ' || SQLERRM);
END;

BEGIN
    PK_AUDITORIAS.el();
    DBMS_OUTPUT.PUT_LINE('Éxito al eliminar auditoría');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al eliminar auditoría: ' || SQLERRM);
END;

BEGIN
    DECLARE
        cur SYS_REFCURSOR;
        -- Declarar variables para almacenar datos de auditoría
        v_idAuditoria auditorias.idAuditoria%TYPE;
        v_fecha auditorias.fecha%TYPE;
        -- Agregar más variables según la estructura de la tabla
    BEGIN
        cur := PK_AUDITORIAS.co;
        LOOP
            FETCH cur INTO v_idAuditoria, v_fecha;
            EXIT WHEN cur%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('ID_AUDITORIA: ' || v_idAuditoria || ', FECHA: ' || TO_CHAR(v_fecha, 'DD-MON-YYYY'));
            -- Agregar más datos si es necesario
        END LOOP;
        CLOSE cur;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al consultar auditorías: ' || SQLERRM);
    END;
END;

-- Paquete PK_CATEGORIAS: ---------------------->

CREATE OR REPLACE PACKAGE PK_CATEGORIAS AS
    PROCEDURE ad();
    PROCEDURE mo();
    PROCEDURE el();
    FUNCTION co RETURN SYS_REFCURSOR;
    FUNCTION masArticulos RETURN SYS_REFCURSOR;
END PK_CATEGORIAS;
/

CREATE OR REPLACE PACKAGE BODY PK_CATEGORIAS AS
    PROCEDURE ad() AS
    BEGIN
        -- Implementa la lógica para añadir una nueva categoría
        NULL;
    END ad;
    
    PROCEDURE mo() AS
    BEGIN
        -- Implementa la lógica para modificar una categoría existente
        NULL;
    END mo;
    
    PROCEDURE el() AS
    BEGIN
        -- Implementa la lógica para eliminar una categoría
        NULL;
    END el;
    
    FUNCTION co RETURN SYS_REFCURSOR AS
        c_categorias SYS_REFCURSOR;
    BEGIN
        OPEN c_categorias FOR
        SELECT * FROM categorias;
        RETURN c_categorias;
    END co;
    
    FUNCTION masArticulos RETURN SYS_REFCURSOR AS
        c_masArticulos SYS_REFCURSOR;
    BEGIN
        OPEN c_masArticulos FOR
        SELECT c.codigo, c.nombre, COUNT(a.idArticulo) AS total_articulos
        FROM categorias c
        LEFT JOIN articulos a ON c.codigo = a.codigoCategoria
        GROUP BY c.codigo, c.nombre
        ORDER BY total_articulos DESC;
        RETURN c_masArticulos;
    END masArticulos;
END PK_CATEGORIAS;
/

Casos de prueba para PK_CATEGORIAS:

BEGIN
    PK_CATEGORIAS.ad();
    DBMS_OUTPUT.PUT_LINE('Éxito al añadir categoría');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al añadir categoría: ' || SQLERRM);
END;

BEGIN
    PK_CATEGORIAS.mo();
    DBMS_OUTPUT.PUT_LINE('Éxito al modificar categoría');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al modificar categoría: ' || SQLERRM);
END;

BEGIN
    PK_CATEGORIAS.el();
    DBMS_OUTPUT.PUT_LINE('Éxito al eliminar categoría');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al eliminar categoría: ' || SQLERRM);
END;

BEGIN
    DECLARE
        cur SYS_REFCURSOR;
        -- Declarar variables para almacenar datos de categoría
        v_codigo categorias.codigo%TYPE;
        v_nombre categorias.nombre%TYPE;
        -- Agregar más variables según la estructura de la tabla
    BEGIN
        cur := PK_CATEGORIAS.co;
        LOOP
            FETCH cur INTO v_codigo, v_nombre;
            EXIT WHEN cur%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('CÓDIGO: ' || v_codigo || ', NOMBRE: ' || v_nombre);
            -- Agregar más datos si es necesario
        END LOOP;
        CLOSE cur;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al consultar categorías: ' || SQLERRM);
    END;
END;

BEGIN
    DECLARE
        cur SYS_REFCURSOR;
        -- Declarar variables para almacenar datos de categoría con más artículos
        v_codigo categorias.codigo%TYPE;
        v_nombre categorias.nombre%TYPE;
        v_total_articulos NUMBER;
        -- Agregar más variables según la estructura de la tabla
    BEGIN
        cur := PK_CATEGORIAS.masArticulos;
        LOOP
            FETCH cur INTO v_codigo, v_nombre, v_total_articulos;
            EXIT WHEN cur%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('CÓDIGO: ' || v_codigo || ', NOMBRE: ' || v_nombre || ', TOTAL_ARTICULOS: ' || v_total_articulos);
            -- Agregar más datos si es necesario
        END LOOP;
        CLOSE cur;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al consultar categorías con más artículos: ' || SQLERRM);
    END;
END;

-- Paquete PK_ANOMALIAS: ---------------------->

CREATE OR REPLACE PACKAGE PK_ANOMALIAS AS
    PROCEDURE ad();
    PROCEDURE mo();
    PROCEDURE el();
    FUNCTION co RETURN SYS_REFCURSOR;
    FUNCTION prioridadEstadoPendiente RETURN SYS_REFCURSOR;
END PK_ANOMALIAS;
/

CREATE OR REPLACE PACKAGE BODY PK_ANOMALIAS AS
    PROCEDURE ad() AS
    BEGIN
        -- Implementa la lógica para añadir una nueva anomalía
        NULL;
    END ad;
    
    PROCEDURE mo() AS
    BEGIN
        -- Implementa la lógica para modificar una anomalía existente
        NULL;
    END mo;
    
    PROCEDURE el() AS
    BEGIN
        -- Implementa la lógica para eliminar una anomalía
        NULL;
    END el;
    
    FUNCTION co RETURN SYS_REFCURSOR AS
        c_anomalias SYS_REFCURSOR;
    BEGIN
        OPEN c_anomalias FOR
        SELECT * FROM anomalias;
        RETURN c_anomalias;
    END co;
    
    FUNCTION prioridadEstadoPendiente RETURN SYS_REFCURSOR AS
        c_pendientes SYS_REFCURSOR;
    BEGIN
        OPEN c_pendientes FOR
        SELECT *
        FROM anomalias
        WHERE prioridad = 'A' AND estado = 'P';
        RETURN c_pendientes;
    END prioridadEstadoPendiente;
END PK_ANOMALIAS;
/

Casos de prueba para PK_ANOMALIAS:

BEGIN
    PK_ANOMALIAS.ad();
    DBMS_OUTPUT.PUT_LINE('Éxito al añadir anomalía');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al añadir anomalía: ' || SQLERRM);
END;

BEGIN
    PK_ANOMALIAS.mo();
    DBMS_OUTPUT.PUT_LINE('Éxito al modificar anomalía');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al modificar anomalía: ' || SQLERRM);
END;

BEGIN
    PK_ANOMALIAS.el();
    DBMS_OUTPUT.PUT_LINE('Éxito al eliminar anomalía');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al eliminar anomalía: ' || SQLERRM);
END;

BEGIN
    DECLARE
        cur SYS_REFCURSOR;
        -- Declarar variables para almacenar datos de anomalía
        v_id_anomalia anomalias.id_anomalia%TYPE;
        v_texto_descriptivo anomalias.texto_descriptivo%TYPE;
        -- Agregar más variables según la estructura de la tabla
    BEGIN
        cur := PK_ANOMALIAS.co;
        LOOP
            FETCH cur INTO v_id_anomalia, v_texto_descriptivo;
            EXIT WHEN cur%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('ID_ANOMALIA: ' || v_id_anomalia || ', TEXTO: ' || v_texto_descriptivo);
            -- Agregar más datos si es necesario
        END LOOP;
        CLOSE cur;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al consultar anomalías: ' || SQLERRM);
    END;
END;

BEGIN
    DECLARE
        cur SYS_REFCURSOR;
        -- Declarar variables para almacenar datos de anomalía con prioridad alta y estado pendiente
        v_id_anomalia anomalias.id_anomalia%TYPE;
        v_texto_descriptivo anomalias.texto_descriptivo%TYPE;
        -- Agregar más variables según la estructura de la tabla
    BEGIN
        cur := PK_ANOMALIAS.prioridadEstadoPendiente;
        LOOP
            FETCH cur INTO v_id_anomalia, v_texto_descriptivo;
            EXIT WHEN cur%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('ID_ANOMALIA: ' || v_id_anomalia || ', TEXTO: ' || v_texto_descriptivo);
            -- Agregar más datos si es necesario
        END LOOP;
        CLOSE cur;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al consultar anomalías con prioridad alta y estado pendiente: ' || SQLERRM);
    END;
END;

--–2. Prueben los paquetes construidos con los casos más significativos: 5 éxito y 3 de fracaso. 
-- CRUDOK
-- CRUDNoOK
-- Casos de Prueba para PK_ARTICULOS (CRUDOK):

-- Casos de Éxito:

-- Añadir un nuevo artículo.
BEGIN
    PK_ARTICULOS.ad();
    COMMIT;
END;

-- Modificar un artículo existente.
BEGIN
    PK_ARTICULOS.mo();
    COMMIT;
END;

-- Eliminar un artículo.
BEGIN
    PK_ARTICULOS.el();
    COMMIT;
END;

-- Consultar todos los artículos.
BEGIN
    FOR art IN PK_ARTICULOS.co() LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || art.idArticulo || ', Descripción: ' || art.descripcion);
    END LOOP;
END;

-- Consultar los artículos de una categoría específica.
BEGIN
    FOR art IN PK_ARTICULOS.articuloCategEval() LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || art.idArticulo || ', Descripción: ' || art.descripcion);
    END LOOP;
END;

-- Casos de Fracaso:

-- Intentar añadir un artículo (falla intencional).
BEGIN
    PK_ARTICULOS.ad();
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al añadir artículo: ' || SQLERRM);
        ROLLBACK;
END;

-- Intentar modificar un artículo (falla intencional).
BEGIN
    PK_ARTICULOS.mo();
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al modificar artículo: ' || SQLERRM);
        ROLLBACK;
END;

-- Intentar eliminar un artículo (falla intencional).
BEGIN
    PK_ARTICULOS.el();
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al eliminar artículo: ' || SQLERRM);
        ROLLBACK;
END;

--Casos de Prueba para PK_AUDITORIAS (CRUDOK):
-- Casos de Éxito:

-- Añadir una nueva auditoría.
BEGIN
    PK_AUDITORIAS.ad();
    COMMIT;
END;

-- Modificar una auditoría existente.
BEGIN
    PK_AUDITORIAS.mo();
    COMMIT;
END;

-- Eliminar una auditoría.
BEGIN
    PK_AUDITORIAS.el();
    COMMIT;
END;

-- Consultar todas las auditorías.
BEGIN
    FOR aud IN PK_AUDITORIAS.co() LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || aud.idAuditoria || ', Acción: ' || aud.accion);
    END LOOP;
END;

-- Casos de Fracaso:

-- Intentar añadir una auditoría (falla intencional).
BEGIN
    PK_AUDITORIAS.ad();
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al añadir auditoría: ' || SQLERRM);
        ROLLBACK;
END;

-- Intentar modificar una auditoría (falla intencional).
BEGIN
    PK_AUDITORIAS.mo();
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al modificar auditoría: ' || SQLERRM);
        ROLLBACK;
END;

-- Intentar eliminar una auditoría (falla intencional).
BEGIN
    PK_AUDITORIAS.el();
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al eliminar auditoría: ' || SQLERRM);
        ROLLBACK;
END;

--Casos de Prueba para PK_ANOMALIAS (CRUDOK):
-- Casos de Éxito:

-- Añadir una nueva anomalía.
BEGIN
    PK_ANOMALIAS.ad();
    COMMIT;
END;

-- Modificar una anomalía existente.
BEGIN
    PK_ANOMALIAS.mo();
    COMMIT;
END;

-- Eliminar una anomalía.
BEGIN
    PK_ANOMALIAS.el();
    COMMIT;
END;

-- Consultar todas las anomalías.
BEGIN
    FOR anm IN PK_ANOMALIAS.co() LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || anm.id_anomalia || ', Descripción: ' || anm.texto_descriptivo);
    END LOOP;
END;

-- Consultar las anomalías con prioridad 'A' y estado 'Pendiente'.
BEGIN
    FOR anm IN PK_ANOMALIAS.prioridadEstadoPendiente() LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || anm.id_anomalia || ', Descripción: ' || anm.texto_descriptivo);
    END LOOP;
END;

-- Casos de Fracaso:

-- Intentar añadir una anomalía (falla intencional).
BEGIN
    PK_ANOMALIAS.ad();
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al añadir anomalía: ' || SQLERRM);
        ROLLBACK;
END;

-- Intentar modificar una anomalía (falla intencional).
BEGIN
    PK_ANOMALIAS.mo();
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al modificar anomalía: ' || SQLERRM);
        ROLLBACK;
END;

-- Intentar eliminar una anomalía (falla intencional).
BEGIN
    PK_ANOMALIAS.el();
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al eliminar anomalía: ' || SQLERRM);
        ROLLBACK;
END;

-- Casos de Prueba para PK_EVALUACIONES (CRUDOK):
-- Casos de Éxito:

-- Añadir una nueva evaluación.
BEGIN
    PK_EVALUACIONES.ad();
    COMMIT;
END;

-- Modificar una evaluación existente.
BEGIN
    PK_EVALUACIONES.mo();
    COMMIT;
END;

-- Eliminar una evaluación.
BEGIN
    PK_EVALUACIONES.el();
    COMMIT;
END;

-- Consultar todas las evaluaciones.
BEGIN
    FOR eval IN PK_EVALUACIONES.co() LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || eval.a_omes || ', Descripción: ' || eval.descripcion);
    END LOOP;
END;

-- Casos de Fracaso:

-- Intentar añadir una evaluación (falla intencional).
BEGIN
    PK_EVALUACIONES.ad();
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al añadir evaluación: ' || SQLERRM);
        ROLLBACK;
END;

-- Intentar modificar una evaluación (falla intencional).
BEGIN
    PK_EVALUACIONES.mo();
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al modificar evaluación: ' || SQLERRM);
        ROLLBACK;
END;

-- Intentar eliminar una evaluación (falla intencional).
BEGIN
    PK_EVALUACIONES.el();
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al eliminar evaluación: ' || SQLERRM);
        ROLLBACK;
END;
