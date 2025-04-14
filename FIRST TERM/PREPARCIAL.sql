-- CREACIÓN DE TABLAS

CREATE TABLE clientesPRE(
    numDoc NUMBER (15) NOT NULL, 
    tipoDoc VARCHAR(10) NOT NULL,
    nombreApellido VARCHAR(200) NOT NULL,
    correoElectronico VARCHAR(100) NOT NULL
    );

CREATE TABLE oyentesPago (
    direccion VARCHAR (100) NOT NULL,
    celular CHAR(10) NOT NULL,
    numMesesNoNotif NUMBER NOT NULL,
    numDoc NUMBER (15) NOT NULL,
    tipoDoc VARCHAR(10) NOT NULL
    );
    
CREATE TABLE tarjetasCredito (
    numDoc NUMBER (15) NOT NULL,
    tipoDoc VARCHAR(10) NOT NULL,
    tarjetaCredito VARCHAR(19) NOT NULL
    );

CREATE TABLE oyentesGratuito (
    academia VARCHAR (200) NOT NULL, 
    numDoc NUMBER (15) NOT NULL,
    tipoDoc VARCHAR(10) NOT NULL
    );

CREATE TABLE bibliotecas (
    id NUMBER NOT NULL,
    nombre VARCHAR (50) NOT NULL ,
    numDoc NUMBER (15) NOT NULL,
    tipoDoc VARCHAR(10) NOT NULL
    );

CREATE TABLE canciones (
    nombre VARCHAR (50) NOT NULL ,
    duracion NUMBER NOT NULL ,
    fechaCreacion DATE, 
    idBiblioteca NUMBER NOT NULL
    );

CREATE TABLE episodios (
    titulo VARCHAR (50) NOT NULL,
    descripcion VARCHAR(100),
    idBiblioteca NUMBER NOT NULL
    );
    
CREATE TABLE facturasPRE (
    fecha DATE NOT NULL,
    montoSuscripcion NUMBER(5,2) NOT NULL,
    montoPagar NUMBER (5,2) NOT NULL,
    url VARCHAR(100) NOT NULL, 
    estado VARCHAR(1) NOT NULL,
    id NUMBER(10) NOT NULL,
    numDoc NUMBER (15) NOT NULL,
    tipoDoc VARCHAR(10) NOT NULL,
    idBono VARCHAR(3) NOT NULL
    );

CREATE TABLE notificacionesIncumplimiento (
    id NUMBER NOT NULL,
    fechaTransaccion DATE NOT NULL,
    tarjetaCredito VARCHAR(19) NOT NULL,
    monto NUMBER(5,2) NOT NULL,
    descripcion VARCHAR (100) NOT NULL,
    idFactura NUMBER (10) NOT NULL
    );

CREATE TABLE bonosPromocional (   
    iniciativa VARCHAR(3) NOT NULL,
    porcentaje NUMBER(2,2) NOT NULL,
    mensaje VARCHAR(100),
    numDoc NUMBER (15) NOT NULL,
    tipoDoc VARCHAR(10) NOT NULL
    );
    
--PRIMARY KEYS

ALTER TABLE clientesPRE
ADD CONSTRAINT PK_clientesPRE PRIMARY KEY (numDoc, tipoDoc);

ALTER TABLE oyentesPago
ADD CONSTRAINT PK_oyentesPago PRIMARY KEY (numDoc, tipoDoc);

ALTER TABLE oyentesGratuito
ADD CONSTRAINT PK_oyentesGratuito PRIMARY KEY (numDoc, tipoDoc);

ALTER TABLE tarjetasCredito
ADD CONSTRAINT PK_tarjetasCredito PRIMARY KEY (tarjetaCredito);

ALTER TABLE bibliotecas
ADD CONSTRAINT PK_bibliotecas PRIMARY KEY (id);

ALTER TABLE canciones
ADD CONSTRAINT PK_canciones PRIMARY KEY (nombre);

ALTER TABLE episodios
ADD CONSTRAINT PK_episodios PRIMARY KEY (titulo);

ALTER TABLE facturasPRE
ADD CONSTRAINT PK_facturasPRE PRIMARY KEY (id);

ALTER TABLE notificacionesIncumplimiento
ADD CONSTRAINT PK_notificacionesIncumplimiento PRIMARY KEY (id);

ALTER TABLE bonosPromocional
ADD CONSTRAINT PK_bonosPromocional PRIMARY KEY (iniciativa);

--UNIQUE KEYS

ALTER TABLE clientesPRE
ADD CONSTRAINT UK_clientesPRE UNIQUE (correoElectronico);

ALTER TABLE bibliotecas
ADD CONSTRAINT UK_bibliotecas UNIQUE (nombre);

ALTER TABLE facturasPRE
ADD CONSTRAINT UK_facturasPRE1 UNIQUE (url);

ALTER TABLE facturasPRE
ADD CONSTRAINT UK_facturasPRE2 UNIQUE (idBono);

--FOREIGN KEYS

ALTER TABLE oyentesPago
ADD CONSTRAINT FK_oyentesPago_clientesPRE 
FOREIGN KEY (numDoc, tipoDoc) REFERENCES clientesPRE(numDoc,tipoDoc);

ALTER TABLE oyentesGratuito
ADD CONSTRAINT FK_oyentesGratuito_clientesPRE
FOREIGN KEY (numDoc, tipoDoc) REFERENCES clientesPRE(numDoc,tipoDoc);

ALTER TABLE tarjetasCredito
ADD CONSTRAINT FK_tarjetasCredito_oyentesPago 
FOREIGN KEY (numDoc, tipoDoc) REFERENCES oyentesPago(numDoc,tipoDoc);

ALTER TABLE bibliotecas
ADD CONSTRAINT FK_bibliotecas_oyentesPago
FOREIGN KEY (numDoc, tipoDoc) REFERENCES oyentesPago(numDoc,tipoDoc);

ALTER TABLE bibliotecas
ADD CONSTRAINT FK_bibliotecas_clientesPRE
FOREIGN KEY (numDoc, tipoDoc) REFERENCES clientesPRE(numDoc,tipoDoc);

ALTER TABLE canciones
ADD CONSTRAINT FK_canciones_bibliotecas
FOREIGN KEY (idBiblioteca) REFERENCES bibliotecas(id);

ALTER TABLE episodios
ADD CONSTRAINT FK_episodios_bibliotecas
FOREIGN KEY (idBiblioteca) REFERENCES bibliotecas(id);

ALTER TABLE facturasPRE
ADD CONSTRAINT FK_facturasPRE_oyentesPago
FOREIGN KEY (numDoc, tipoDoc) REFERENCES oyentesPago(numDoc,tipoDoc)
ON DELETE CASCADE;

ALTER TABLE facturasPRE
ADD CONSTRAINT FK_facturasPRE_BonoPromocional
FOREIGN KEY (idBono) REFERENCES bonosPromocional(iniciativa);

ALTER TABLE notificacionesIncumplimiento
ADD CONSTRAINT FK_notificacionesIncumplimiento_factura
FOREIGN KEY (idFactura) REFERENCES facturasPRE(id);

ALTER TABLE bonosPromocional
ADD CONSTRAINT FK_bonosPromocional_oyentesPago
FOREIGN KEY (numDoc, tipoDoc) REFERENCES oyentesPago(numDoc,tipoDoc);

--INTEGRIDAD DECLARATIVA

--Para TCredito almacenaremos 19 posiciones, solo los primeros 6 dígitos y los últimos 4 de resto se informará con X. Ejemplo: 123456XXXXXXXXX3456

-- Para TCredito almacenaremos 19 posiciones, solo los primeros 6 dígitos y los últimos 4 de resto se informará con X. Ejemplo: 123456XXXXXXXXX3456
ALTER TABLE tarjetasCredito
ADD CONSTRAINT CK_TarjetaCifrada
CHECK (REGEXP_LIKE(tarjetaCredito, '^[0-9]{6}X{9}[0-9]{4}$'));

INSERT INTO clientesPRE (numDoc, tipoDoc, nombreApellido, correoElectronico) 
VALUES (123456789, 'DNI', 'Nombre Apellido', 'correo@example.com');

INSERT INTO oyentesPago (numDoc, tipoDoc, direccion, celular, numMesesNoNotif) 
VALUES (123456789, 'DNI', 'Dirección de ejemplo', '1234567890', 0);

INSERT INTO tarjetasCredito (numDoc, tipoDoc, tarjetaCredito) VALUES
(123456789, 'DNI', '123456XXXXXXXXX3456'); --well done


--El estado de una factura puede ser: A-Aceptado, R-Rechazado y P-En Proceso.
ALTER TABLE facturasPRE
ADD CONSTRAINT CK_estadoFactura 
CHECK (estado IN ('A', 'R', 'P'));

INSERT INTO bonosPromocional (iniciativa, porcentaje, mensaje, numDoc, tipoDoc) 
VALUES ('001', 1.1, 'Mensaje de ejemplo', 123456789, 'DNI');


ALTER TABLE bonosPromocional MODIFY porcentaje NUMBER(4,2);

INSERT INTO facturasPRE (fecha, montoSuscripcion, montoPagar, url, estado, id, numDoc, tipoDoc, idBono) 
VALUES (TO_DATE('2025-04-01', 'YYYY-MM-DD'), 5.0, 5.0, 'http://example.com/factura5', 'R', 1, 1234568789, 'DNIL', '001');



--No pueden existir más de 20 notificaciones de una misma factura

CREATE OR REPLACE TRIGGER trg_20NotificacionFactura
BEFORE INSERT ON notificacionesIncumplimiento
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM notificacionesIncumplimiento
    WHERE idFactura = :NEW.idFactura;

    IF v_count >= 20 THEN
        RAISE_APPLICATION_ERROR(-20002, 'No pueden existir más de 20 notificaciones para una misma factura.');
    END IF;
END;
/


-- Deshabilitar el disparador trg_20NotificacionFactura temporalmente
ALTER TRIGGER trg_20NotificacionFactura DISABLE;

-- Realizar la inserción de datos
INSERT INTO notificacionesIncumplimiento (id, fechaTransaccion, tarjetaCredito, monto, descripcion, idFactura) 
SELECT ROWNUM, SYSDATE, '123456XXXXXXXXX3456', 50.00, 'Pago no realizado', 1 
FROM dual CONNECT BY ROWNUM <= 20;

-- Habilitar el disparador trg_20NotificacionFactura nuevamente
ALTER TRIGGER trg_20NotificacionFactura ENABLE;




--Una Biblioteca puede estar compuesta por Canciones o Episodios de un Podcast.

CREATE OR REPLACE TRIGGER trg_Episodio_cancion_Biblioteca
BEFORE INSERT OR UPDATE ON bibliotecas
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM (
        SELECT idBiblioteca FROM canciones WHERE idBiblioteca = :NEW.id
        UNION ALL
        SELECT idBiblioteca FROM episodios WHERE idBiblioteca = :NEW.id
    );

    IF v_count > 1 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Una Biblioteca solo puede contener Canciones o Episodios de un Podcast.');
    END IF;
END;
/

-- Suponiendo que la biblioteca con id 1 contiene tanto canciones como episodios

INSERT INTO bibliotecas (id, nombre, numDoc, tipoDoc) 
VALUES (1, 'Nombre de la Biblioteca', 123456789, 'DNI');

INSERT INTO canciones (nombre, duracion, fechaCreacion, idBiblioteca) 
VALUES ('Cancion1', 180, TO_DATE('2026-04-01', 'YYYY-MM-DD'), 1);


INSERT INTO episodios (titulo, descripcion, idBiblioteca) VALUES
('Episodio1', 'Descripción del episodio', 1);    --well done


--INTEGRIDAD PROCEDIMENTAL

--Adicionar
    --Sólo se permitirá crear una notificación de incumplimiento 5 días después de generada la factura asociada y además que se encuentre con un pago pendiente)
CREATE OR REPLACE TRIGGER trg_CrearNotificacionIncumplimiento
BEFORE INSERT ON notificacionesIncumplimiento
FOR EACH ROW
DECLARE
    v_fechaFactura DATE;
BEGIN
    -- Obtener la fecha de la factura asociada
    SELECT TO_DATE(fecha, 'YYYY-MM-DD') INTO v_fechaFactura
    FROM facturasPRE
    WHERE id = :NEW.idFactura;

    -- Verificar si la factura tiene estado pendiente y se creó hace más de 5 días
    IF SYSDATE - v_fechaFactura > 5 AND :NEW.idFactura IN (SELECT id FROM facturasPRE WHERE estado = 'P') THEN
        -- Permitir la inserción
        NULL;
    ELSE
        -- Evitar la inserción
        RAISE_APPLICATION_ERROR(-20001, 'No se puede crear una notificación de incumplimiento para esta factura.');
    END IF;
END;
/

-- Insertar una factura con estado pendiente creada hace más de 5 días
INSERT INTO facturasPRE (fecha, montoSuscripcion, montoPagar, url, estado, id, numDoc, tipoDoc, idBono) 
VALUES (TO_DATE('2024-03-20', 'YYYY-MM-DD'), 50.00, 50.00, 'http://example.com/factura2', 'P', 2, 123456789, 'DNI', '002');

-- Insertar una notificación de incumplimiento asociada a la factura anterior
INSERT INTO notificacionesIncumplimiento (id, fechaTransaccion, tarjetaCredito, monto, descripcion, idFactura) 
VALUES (1, TO_DATE('2024-03-25', 'YYYY-MM-DD'), '123456XXXXXXXXX3456', 50.00, 'Pago no realizado', 2);




    --El tipo TIniciativa es calculado de la siguiente manera: primera posición número de meses sin notificación, segunda y tercera posición: últimos digitos del año en curso.
CREATE OR REPLACE TRIGGER trg_CalcularTIniciativa
BEFORE INSERT ON bonosPromocional
FOR EACH ROW
DECLARE
    v_mesesSinNotif NUMBER;
BEGIN
    -- Obtener el número de meses sin notificación del oyente
    SELECT numMesesNoNotif INTO v_mesesSinNotif
    FROM oyentesPago
    WHERE numDoc = :NEW.numDoc AND tipoDoc = :NEW.tipoDoc;

    -- Calcular el tipo TIniciativa
    :NEW.iniciativa := LPAD(v_mesesSinNotif, 1, '0') || SUBSTR(TO_CHAR(SYSDATE, 'YYYY'), 3);

END;
/

-- Insertar un nuevo registro en bonosPromocional
INSERT INTO bonosPromocional (iniciativa, porcentaje, mensaje, numDoc, tipoDoc) 
VALUES ('004', 0.10, 'Mensaje de ejemplo5', 123456789141, 'DNILG'); --I think it



    --Cada vez que el Oyente Pago tenga una notificación por incumplimiento el número de meses sin notificación se reinicia a 0.
CREATE OR REPLACE TRIGGER trg_BeforeInsertNotifIncumplimiento
BEFORE INSERT ON notificacionesIncumplimiento
FOR EACH ROW
DECLARE
    v_numDoc NUMBER;
    v_tipoDoc VARCHAR2(10);
BEGIN
    SELECT numDoc, tipoDoc
    INTO v_numDoc, v_tipoDoc
    FROM facturasPRE
    WHERE id = :NEW.idFactura;

    :NEW.numDoc := v_numDoc;
    :NEW.tipoDoc := v_tipoDoc;
END;
/

CREATE OR REPLACE TRIGGER trg_ReiniciarMesesSinNotificacion
AFTER INSERT ON notificacionesIncumplimiento
FOR EACH ROW
BEGIN
    -- Reiniciar el número de meses sin notificación a 0
    UPDATE oyentesPago op
    SET numMesesNoNotif = 0
    WHERE EXISTS (
        SELECT 1
        FROM facturasPRE fp
        WHERE fp.id = :NEW.idFactura
        AND fp.numDoc = op.numDoc
        AND fp.tipoDoc = op.tipoDoc
    );
END;
/


-- Insertar una notificación de incumplimiento para disparar el trigger
INSERT INTO notificacionesIncumplimiento (id, fechaTransaccion, tarjetaCredito, monto, descripcion, idFactura) 
VALUES (1, SYSDATE, '123456XXXXXXXXX3456', 100.00, 'Pago no realizado', 1);



--Modificar
    --No es posible actualizar una factura con estado aprobado o en proceso. Y solo puede ser modificado, el estado, Url.
CREATE OR REPLACE TRIGGER trg_ModificarFactura
BEFORE UPDATE ON facturasPRE
FOR EACH ROW
BEGIN
    IF :OLD.estado IN ('A', 'P') THEN
        IF :NEW.estado != :OLD.estado OR :NEW.url != :OLD.url THEN
            RAISE_APPLICATION_ERROR(-20002, 'No se puede modificar una factura con estado aprobado o en proceso.');
        END IF;
    END IF;
END;
/

-- Actualizar el estado de una factura existente (estado en proceso)
UPDATE facturasPRE SET estado = 'R' WHERE id = 1;


    --No es posible modificar una notificación de incumplimiento.
CREATE OR REPLACE TRIGGER trg_ModificarNotificacion
BEFORE UPDATE ON notificacionesIncumplimiento
FOR EACH ROW
BEGIN
    RAISE_APPLICATION_ERROR(-20001, 'No es posible modificar una notificación de incumplimiento.');
END;
/

-- Intentar actualizar una notificación de incumplimiento
UPDATE notificacionesIncumplimiento SET descripcion = 'Descripción modificada' WHERE id = 1;




    --Del BonoPromocional sólo es posible modificar su mensaje.
ALTER TABLE bonosPromocional
ADD CONSTRAINT CK_ModificarMensaje
CHECK (mensaje IS NOT NULL);

--Eliminar
    --Al eliminar el BonoPromocional no se elimina la factura de su aplicación.
CREATE OR REPLACE TRIGGER trg_NoEliminarFacturas
BEFORE DELETE ON bonosPromocional
FOR EACH ROW
BEGIN
    IF :OLD.iniciativa IS NOT NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'No se pueden eliminar un BonoPromocional con facturas asociadas.');
    END IF;
END;
/

-- Intentar eliminar un BonoPromocional asociado a facturas
DELETE FROM bonosPromocional WHERE iniciativa = '001';



    --Las notificaciones de incumplimiento y facturas no se pueden eliminar.
CREATE OR REPLACE TRIGGER trg_NoEliminarNotificaciones
BEFORE DELETE ON notificacionesIncumplimiento
FOR EACH ROW
BEGIN
    RAISE_APPLICATION_ERROR(-20001, 'No se pueden eliminar notificaciones de incumplimiento.');
END;
/

-- Intentar eliminar una notificación de incumplimiento
DELETE FROM notificacionesIncumplimiento WHERE id = 1;



CREATE OR REPLACE TRIGGER trg_NoEliminarFacturasDELETE
BEFORE DELETE ON facturasPRE
FOR EACH ROW
BEGIN
    RAISE_APPLICATION_ERROR(-20002, 'No se pueden eliminar facturas.');
END;
/

-- Intentar eliminar una factura
DELETE FROM facturasPRE WHERE id = 1;





    

    

    
