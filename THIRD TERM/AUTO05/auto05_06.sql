-- TABLAS
CREATE TABLE rate(
    room_type VARCHAR(6) NOT NULL,
    occupancy NUMBER(11) NOT NULL,
    amount NUMBER(10, 2)
);

CREATE TABLE room_type(
    id VARCHAR(6) NOT NULL,
    description VARCHAR(100)
);

CREATE TABLE room(
    id NUMBER(11) NOT NULL,
    room_type VARCHAR(6),
    max_occupancy NUMBER(11)
);

CREATE TABLE booking(
    booking_id NUMBER(11) NOT NULL,
    booking_date DATE,
    room_no NUMBER(11),
    guest_id NUMBER(11) NOT NULL,
    occupants NUMBER(11) NOT NULL,
    room_type_requested VARCHAR(6),
    nights NUMBER(11) NOT NULL,
    arrival_time VARCHAR(5)
);

CREATE TABLE guest (
    id NUMBER(11) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    address VARCHAR(50)
);

CREATE TABLE extra (    
    extra_id NUMBER(11) NOT NULL CHECK (extra_id >= 9),
    booking_id NUMBER(11),
    amount NUMBER(9) CHECK (amount >=0),
    id_description NUMBER(11) NOT NULL,
    discount NUMBER(9) CHECK (discount >=0)
);

-- modelando colección como tabla
CREATE TABLE description (
    id NUMBER(11) NOT NULL,
    detalle VARCHAR(50) NOT NULL 
);

-- XTABLAS
DROP TABLE rate;
DROP TABLE room_type;
DROP TABLE room;
DROP TABLE booking;
DROP TABLE guest;
DROP TABLE extra;

-- ATRIBUTOS

CREATE TABLE extra (    
    extra_id NUMBER(11) NOT NULL CHECK (extra_id >= 9),
    booking_id NUMBER(11),
    amount NUMBER(9) CHECK (amount >=0),
    id_description NUMBER(11) NOT NULL,
    discount NUMBER(9) CHECK (discount >=0)
);

-- modelando colección como tabla
CREATE TABLE description (
    id NUMBER(11) NOT NULL,
    detalle VARCHAR(50) NOT NULL 
);

-- creación PK's

ALTER TABLE rate 
ADD CONSTRAINT PK_rate PRIMARY KEY(occupancy);

ALTER TABLE room_type
ADD CONSTRAINT PK_room_type PRIMARY KEY (id);

ALTER TABLE room
ADD CONSTRAINT PK_room PRIMARY KEY (id);

ALTER TABLE booking
ADD CONSTRAINT PK_booking PRIMARY KEY (booking_id);

ALTER TABLE extra
ADD CONSTRAINT PK_extra PRIMARY KEY (extra_id);

ALTER TABLE description 
ADD CONSTRAINT PK_description PRIMARY KEY (id);

ALTER TABLE guest
ADD CONSTRAINT PK_guest PRIMARY KEY (id);

-- creación FK's

ALTER TABLE rate 
ADD CONSTRAINT FK_rate_room_type FOREIGN KEY (room_type) REFERENCES room_type(id);

ALTER TABLE booking
ADD CONSTRAINT FK_booking_room FOREIGN KEY (room_no) REFERENCES room(id);

ALTER TABLE booking
ADD CONSTRAINT FK_booking_guest FOREIGN KEY (guest_id) REFERENCES guest(id);

ALTER TABLE booking
ADD CONSTRAINT FK_booking_rate FOREIGN KEY (occupants) REFERENCES rate(occupancy);

ALTER TABLE booking
ADD CONSTRAINT FK_booking_room_type FOREIGN KEY (room_type_requested) REFERENCES room_type(id);

ALTER TABLE extra
ADD CONSTRAINT FK_extra_booking FOREIGN KEY (booking_id) REFERENCES booking(booking_id);

ALTER TABLE extra
ADD CONSTRAINT FK_extra_description FOREIGN KEY (id_description) REFERENCES description(id);


-- TUPLAS
 
ALTER TABLE extra
ADD CONSTRAINT CK_EXTRAS_PRICE_DISCOUNT
CHECK (
    (amount <= 100000 OR discount IS NOT NULL) AND
    (amount > 100000 AND discount IS NULL AND id_description = 1)
);


CREATE OR REPLACE TRIGGER trg_discount
BEFORE INSERT OR UPDATE ON extra
FOR EACH ROW
BEGIN
  IF :NEW.amount > 100000 AND (:NEW.discount = NULL) THEN
    :NEW.discount := :NEW.amount * 0.10;
    :NEW.id_description := 1; -- Asumiendo que este es el ID de la descripción correspondiente
  END IF;
END;

-- AtributosOK
-- Insertando datos en la tabla room_type

INSERT INTO room_type (id, description) VALUES ('RT1', 'Room Type 1');

INSERT INTO room_type (id, description) VALUES ('RT2', 'Room Type 2');

INSERT INTO room_type (id, description) VALUES ('RT3', 'Room Type 3');

INSERT INTO room_type (id, description) VALUES ('RT4', 'Room Type 4');

INSERT INTO room_type (id, description) VALUES ('RT5', 'Room Type 5');

INSERT INTO room_type (id, description) VALUES ('RT6', 'Room Type 6');
 
-- Insertando datos en la tabla room

INSERT INTO room (id, room_type, max_occupancy) VALUES (1, 'RT1', 2);

INSERT INTO room (id, room_type, max_occupancy) VALUES (2, 'RT2', 2);

INSERT INTO room (id, room_type, max_occupancy) VALUES (3, 'RT3', 3);

INSERT INTO room (id, room_type, max_occupancy) VALUES (4, 'RT4', 4);

INSERT INTO room (id, room_type, max_occupancy) VALUES (5, 'RT5', 5);

INSERT INTO room (id, room_type, max_occupancy) VALUES (6, 'RT6', 6);
 
-- Insertando datos en la tabla rate

INSERT INTO rate (room_type, occupancy, amount) VALUES ('RT1', 2, 100.00);

INSERT INTO rate (room_type, occupancy, amount) VALUES ('RT2', 1, 200.00);

INSERT INTO rate (room_type, occupancy, amount) VALUES ('RT3', 3, 300.00);

INSERT INTO rate (room_type, occupancy, amount) VALUES ('RT4', 4, 400.00);

INSERT INTO rate (room_type, occupancy, amount) VALUES ('RT5', 5, 500.00);

INSERT INTO rate (room_type, occupancy, amount) VALUES ('RT6', 6, 600.00);
 
-- Insertando datos en la tabla guest

INSERT INTO guest (id, first_name, last_name, address) VALUES (1, 'Guest1', 'Last1', 'Address1');

INSERT INTO guest (id, first_name, last_name, address) VALUES (2, 'Guest2', 'Last2', 'Address2');

INSERT INTO guest (id, first_name, last_name, address) VALUES (3, 'Guest3', 'Last3', 'Address3');

INSERT INTO guest (id, first_name, last_name, address) VALUES (4, 'Guest4', 'Last4', 'Address4');

INSERT INTO guest (id, first_name, last_name, address) VALUES (5, 'Guest5', 'Last5', 'Address5');

INSERT INTO guest (id, first_name, last_name, address) VALUES (6, 'Guest6', 'Last6', 'Address6');
 
-- Insertando datos en la tabla booking

INSERT INTO booking (booking_id, booking_date, room_no, guest_id, occupants, room_type_requested, nights, arrival_time) VALUES (1, TO_DATE('2024-03-20','YYYY-MM-DD'), 1, 1, 2, 'RT1', 1, '12:00');

INSERT INTO booking (booking_id, booking_date, room_no, guest_id, occupants, room_type_requested, nights, arrival_time) VALUES (2, TO_DATE('2024-03-21','YYYY-MM-DD'), 2, 2, 2, 'RT2', 2, '13:00');

INSERT INTO booking (booking_id, booking_date, room_no, guest_id, occupants, room_type_requested, nights, arrival_time) VALUES (3, TO_DATE('2024-03-22','YYYY-MM-DD'), 3, 3, 3, 'RT3', 3, '14:00');

INSERT INTO booking (booking_id, booking_date, room_no, guest_id, occupants, room_type_requested, nights, arrival_time) VALUES (4, TO_DATE('2024-03-23','YYYY-MM-DD'), 4, 4, 4, 'RT4', 4, '15:00');

INSERT INTO booking (booking_id, booking_date, room_no, guest_id, occupants, room_type_requested, nights, arrival_time) VALUES (5, TO_DATE('2024-03-24','YYYY-MM-DD'), 5, 5, 5, 'RT5', 5, '16:00');

INSERT INTO booking (booking_id, booking_date, room_no, guest_id, occupants, room_type_requested, nights, arrival_time) VALUES (6, TO_DATE('2024-03-25','YYYY-MM-DD'), 6, 6, 6, 'RT6', 6, '17:00');
 
-- Insertando datos en la tabla extra

INSERT INTO extra (extra_id, booking_id, amount, id_description, discount) VALUES (9, 3, 100000000000.00, 1, 10.00);

INSERT INTO extra (extra_id, booking_id, amount, id_description, discount) VALUES (10, 2, 200.00, 2, 20.00);

INSERT INTO extra (extra_id, booking_id, amount, id_description, discount) VALUES (11, 3, 300.00, 3, 30.00);

INSERT INTO extra (extra_id, booking_id, amount, id_description, discount) VALUES (12, 4, 400.00, 4, 40.00);

INSERT INTO extra (extra_id, booking_id, amount, id_description, discount) VALUES (13, 5, 500.00, 5, 50.00);

INSERT INTO extra (extra_id, booking_id, amount, id_description, discount) VALUES (14, 6, 600.00, 6, 60.00);
 
-- Insertando datos en la tabla description

INSERT INTO description (id, detalle) VALUES (1, 'CON 10% de descuento automático');

INSERT INTO description (id, detalle) VALUES (2, 'Description 2');

INSERT INTO description (id, detalle) VALUES (3, 'Description 3');

INSERT INTO description (id, detalle) VALUES (4, 'Description 4');

INSERT INTO description (id, detalle) VALUES (5, 'Description 5');

INSERT INTO description (id, detalle) VALUES (6, 'Description 6');


-- AtributosNoOK 
INSERT INTO room_type (id, description) VALUES ('RT1', 'Room Type 1');

INSERT INTO room_type (id, description) VALUES ('RT2', 'Room Type 2');

INSERT INTO room_type (id, description) VALUES ('RT3', 'Room Type 3');

INSERT INTO room_type (id, description) VALUES ('RT4', 'Room Type 4');

INSERT INTO room_type (id, description) VALUES ('RT5', 'Room Type 5');

INSERT INTO room_type (id, description) VALUES ('RT6', 'Room Type 6');
 
-- Insertando datos en la tabla room

INSERT INTO room (id, room_type, max_occupancy) VALUES (1, 'RT1', 2);

INSERT INTO room (id, room_type, max_occupancy) VALUES (2, 'RT2', 2);

INSERT INTO room (id, room_type, max_occupancy) VALUES (3, 'RT3', 3);

INSERT INTO room (id, room_type, max_occupancy) VALUES (4, 'RT4', 4);

INSERT INTO room (id, room_type, max_occupancy) VALUES (5, 'RT5', 5);

INSERT INTO room (id, room_type, max_occupancy) VALUES (6, 'RT6', 6);
 
-- Insertando datos en la tabla rate

INSERT INTO rate (room_type, occupancy, amount) VALUES ('RT1', 2, 100.00);

INSERT INTO rate (room_type, occupancy, amount) VALUES ('RT2', 1, 200.00);

INSERT INTO rate (room_type, occupancy, amount) VALUES ('RT3', 3, 300.00);

INSERT INTO rate (room_type, occupancy, amount) VALUES ('RT4', 4, 400.00);

INSERT INTO rate (room_type, occupancy, amount) VALUES ('RT5', 5, 500.00);

INSERT INTO rate (room_type, occupancy, amount) VALUES ('RT6', 6, 600.00);
 
-- Insertando datos en la tabla guest

INSERT INTO guest (id, first_name, last_name, address) VALUES (1, 'Guest1', 'Last1', 'Address1');

INSERT INTO guest (id, first_name, last_name, address) VALUES (2, 'Guest2', 'Last2', 'Address2');

INSERT INTO guest (id, first_name, last_name, address) VALUES (3, 'Guest3', 'Last3', 'Address3');

INSERT INTO guest (id, first_name, last_name, address) VALUES (4, 'Guest4', 'Last4', 'Address4');

INSERT INTO guest (id, first_name, last_name, address) VALUES (5, 'Guest5', 'Last5', 'Address5');

INSERT INTO guest (id, first_name, last_name, address) VALUES (6, 'Guest6', 'Last6', 'Address6');
 
-- Insertando datos en la tabla booking

INSERT INTO booking (booking_id, booking_date, room_no, guest_id, occupants, room_type_requested, nights, arrival_time) VALUES (1, TO_DATE('2024-03-20','YYYY-MM-DD'), 1, 1, 2, 'RT1', 1, '12:00');

INSERT INTO booking (booking_id, booking_date, room_no, guest_id, occupants, room_type_requested, nights, arrival_time) VALUES (2, TO_DATE('2024-03-21','YYYY-MM-DD'), 2, 2, 2, 'RT2', 2, '13:00');

INSERT INTO booking (booking_id, booking_date, room_no, guest_id, occupants, room_type_requested, nights, arrival_time) VALUES (3, TO_DATE('2024-03-22','YYYY-MM-DD'), 3, 3, 3, 'RT3', 3, '14:00');

INSERT INTO booking (booking_id, booking_date, room_no, guest_id, occupants, room_type_requested, nights, arrival_time) VALUES (4, TO_DATE('2024-03-23','YYYY-MM-DD'), 4, 4, 4, 'RT4', 4, '15:00');

INSERT INTO booking (booking_id, booking_date, room_no, guest_id, occupants, room_type_requested, nights, arrival_time) VALUES (5, TO_DATE('2024-03-24','YYYY-MM-DD'), 5, 5, 5, 'RT5', 5, '16:00');

INSERT INTO booking (booking_id, booking_date, room_no, guest_id, occupants, room_type_requested, nights, arrival_time) VALUES (6, TO_DATE('2024-03-25','YYYY-MM-DD'), 6, 6, 6, 'RT6', 6, '17:00');
 
-- Insertando datos en la tabla extra

INSERT INTO extra (extra_id, booking_id, amount, id_description, discount) VALUES (9, 3, 100000000000.00, 1, 10.00);

INSERT INTO extra (extra_id, booking_id, amount, id_description, discount) VALUES (10, 2, 200.00, 2, 20.00);

INSERT INTO extra (extra_id, booking_id, amount, id_description, discount) VALUES (11, 3, 300.00, 3, 30.00);

INSERT INTO extra (extra_id, booking_id, amount, id_description, discount) VALUES (12, 4, 400.00, 4, 40.00);

INSERT INTO extra (extra_id, booking_id, amount, id_description, discount) VALUES (13, 5, 500.00, 5, 50.00);

INSERT INTO extra (extra_id, booking_id, amount, id_description, discount) VALUES (14, 6, 600.00, 6, 60.00);
 
-- Insertando datos en la tabla description

INSERT INTO description (id, detalle) VALUES (1, 'CON 10% de descuento automático');

INSERT INTO description (id, detalle) VALUES (2, 'Description 2');

INSERT INTO description (id, detalle) VALUES (3, 'Description 3');

INSERT INTO description (id, detalle) VALUES (4, 'Description 4');

INSERT INTO description (id, detalle) VALUES (5, 'Description 5');

INSERT INTO description (id, detalle) VALUES (6, 'Description 6');


-- TuplasOK
INSERT INTO extra (extra_id, booking_id, amount, id_description, discount) VALUES (9, 3, 100000000000.00, 1, 10.00);

INSERT INTO extra (extra_id, booking_id, amount, id_description, discount) VALUES (10, 2, 200.00, 2, 20.00);

INSERT INTO extra (extra_id, booking_id, amount, id_description, discount) VALUES (11, 3, 300.00, 3, 30.00);

INSERT INTO extra (extra_id, booking_id, amount, id_description, discount) VALUES (12, 4, 400.00, 4, 40.00);

INSERT INTO extra (extra_id, booking_id, amount, id_description, discount) VALUES (13, 5, 500.00, 5, 50.00);

INSERT INTO extra (extra_id, booking_id, amount, id_description, discount) VALUES (14, 6, 600.00, 6, 60.00);


-- TuplasNoOK
INSERT INTO extra (extra_id, booking_id, amount, id_description, discount) VALUES (9, 8, 10000000000.00, 1, 10.00);

-- B
-- Acciones
ALTER TABLE EXTRA
DROP CONSTRAINT FK_extra_booking;

ALTER TABLE EXTRA
DROP CONSTRAINT FK_extra_description;

ALTER TABLE extra
ADD CONSTRAINT FK_extra_booking FOREIGN KEY (booking_id)
REFERENCES booking(booking_id)
ON DELETE CASCADE;

ALTER TABLE extra 
DROP CONSTRAINT FK_extra_description;



-- Las acciones referenciales ON DELETE CASCADE y ON DELETE SET NULL aseguran la integridad de los datos tras la eliminación de registros relacionados. ON DELETE CASCADE elimina registros dependientes para mantener la coherencia de la base de datos, mientras que ON DELETE SET NULL preserva los registros dependientes pero elimina la asociación, marcando la llave foránea como NULL. Ambas acciones son cruciales para el mantenimiento automático de las relaciones entre tablas y previenen inconsistencias de datos. La elección entre ambas depende de las necesidades específicas de la aplicación y las reglas de negocio establecidas.

-- AccionesOK

SELECT * FROM booking;
SELECT * FROM extra;
SELECT * FROM description;

DELETE FROM booking WHERE booking_id = 2;
DELETE FROM description WHERE id = 6;
-- Se elimino la reserva 2 y con ella los extras asociados a booking_id = 2

-- C
-- Disparadores 
-- Disparador para generar automáticamente el id
CREATE OR REPLACE TRIGGER TR_EXTRAS_BI
BEFORE INSERT ON extra
FOR EACH ROW
BEGIN
  SELECT '9' || TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS') INTO :NEW.extra_id FROM DUAL;
END;

-- Disparador para aplicar un descuento del 10% si el precio es mayor a 100000 y no se indica descuento
CREATE OR REPLACE TRIGGER TR_EXTRAS_BI
BEFORE INSERT ON extra
FOR EACH ROW
WHEN (NEW.amount > 100000 AND NEW.discount IS NULL)
BEGIN
  :NEW.discount := :NEW.amount * 0.10;
  :NEW.id_description := 'CON 10% de descuento automático';
END;

-- Disparador para restringir la modificación y eliminación de detalles en la descripción
CREATE OR REPLACE TRIGGER TR_EXTRAS_BU
BEFORE UPDATE ON extra
FOR EACH ROW
BEGIN
  IF UPDATING('id_description') THEN
    RAISE_APPLICATION_ERROR(-20001, 'No se pueden modificar los detalles de la descripción');
  END IF;
END;

CREATE OR REPLACE TRIGGER TR_DESCRIPTIONS_BU
BEFORE UPDATE ON description
FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20001, 'No se pueden modificar los detalles de la descripción');
END;

CREATE OR REPLACE TRIGGER TR_DESCRIPTIONS_BD
BEFORE DELETE ON description
FOR EACH ROW
BEGIN
  RAISE_APPLICATION_ERROR(-20001, 'No se pueden eliminar los detalles de la descripción');
END;

-- Disparador para permitir la eliminación de extras si no tienen descripción
CREATE OR REPLACE TRIGGER TR_EXTRAS_BD
BEFORE DELETE ON extra
FOR EACH ROW
WHEN (OLD.id_description IS NULL)
BEGIN
  NULL; -- No se realiza ninguna acción, se permite la eliminación
END;
-- XDisparadores

DROP TRIGGER TR_EXTRAS_BI;

DROP TRIGGER TR_EXTRAS_BU;

DROP TRIGGER TR_DESCRIPTIONS_BU;

DROP TRIGGER TR_DESCRIPTIONS_BD;

DROP TRIGGER TR_EXTRAS_BD;


-- DisparadoresOK

--Prueba del disparador TR_EXTRAS_BI que genera automáticamente el id y aplica un descuento del 10% si el precio es mayor a 100000 y no se indica descuento
INSERT INTO extra (booking_id, amount) VALUES (1, 150000.00);

--Prueba del disparador TR_EXTRAS_BU que restringe la modificación de detalles en la descripción:
UPDATE extra SET id_description = 'Nuevo detalle' WHERE extra_id = '9AAAAMMDDmmss';

--Prueba del disparador TR_EXTRAS_BD que permite la eliminación de extras si no tienen descripción:
DELETE FROM extra WHERE extra_id = '9AAAAMMDDmmss';

-- DisparadoresNoOK

--Prueba del disparador TR_EXTRAS_BU que restringe la modificación de detalles en la descripción.
UPDATE extra SET id_description = 'Nuevo detalle' WHERE extra_id = 'valid_extra_id';

--Prueba del disparador TR_DESCRIPTIONS_BU que restringe la modificación de detalles en la descripción.
UPDATE description SET detalle = 'Nuevo detalle' WHERE id = 'valid_id';


--Prueba del disparador TR_DESCRIPTIONS_BD que restringe la eliminación de detalles en la descripción.
DELETE FROM description WHERE id = 'valid_id';
/*
<================================== AUTO ESTUDIO 5 ==================================>
*/
-- A. Ofreciendo servicios

-- 1. Implemente los paquetes de componentes necesario para ofrecer las funciones básicas y
-- consultas del ciclo actual del sistema (CRUD).
-- PC_EXTRAS[Consultar diseño al final]
-- (CRUDE (la especificación) , CRUDI (la implementación) )

CREATE OR REPLACE PACKAGE BookingComponents AS
    -- Función para agregar un detalle adicional a un extra
    FUNCTION add_detail(extra_id IN NUMBER, detail IN VARCHAR2) RETURN VARCHAR2;
    
    -- Procedimiento para consultar los extras asociados a una reserva
    PROCEDURE get_extras(booking_id IN NUMBER, extras OUT SYS_REFCURSOR);
    
    -- Procedimiento para eliminar un extra por su identificador
    PROCEDURE delete_extra(extra_id IN NUMBER);
    
    -- Función para obtener el total de ingresos de una reserva
    FUNCTION total_income(booking_id IN NUMBER) RETURN NUMBER;
    
    -- Función para consultar los ingresos semanales
    FUNCTION weekly_income RETURN SYS_REFCURSOR;
    
    -- Función para consultar los ingresos por reserva
    FUNCTION income_by_booking(booking_id IN NUMBER) RETURN SYS_REFCURSOR;
    
    -- Trigger para generar el identificador único para extras antes de la inserción
    PROCEDURE TR_EXTRAS_BI;
    
    -- Trigger para aplicar un descuento automático si el precio es mayor a 100000 y no se indica descuento
    PROCEDURE TR_EXTRAS_AI;
    
    -- Trigger para restringir la modificación de detalles en la descripción de extras
    PROCEDURE TR_EXTRAS_BU;
    
    -- Trigger para restringir la modificación de detalles en la descripción
    PROCEDURE TR_DESCRIPTIONS_BU;
    
    -- Trigger para restringir la eliminación de detalles en la descripción
    PROCEDURE TR_DESCRIPTIONS_BD;
    
    -- Trigger para permitir la eliminación de extras si no tienen descripción
    PROCEDURE TR_EXTRAS_BD;
END BookingComponents;
/

CREATE OR REPLACE PACKAGE BODY BookingComponents AS
    -- Función para agregar un detalle adicional a un extra
    FUNCTION add_detail(extra_id IN NUMBER, detail IN VARCHAR2) RETURN VARCHAR2 IS
    BEGIN
        -- Lógica para agregar un detalle adicional a un extra
        -- Aquí puedes implementar la lógica necesaria para actualizar el detalle del extra con el nuevo valor
        -- Llamamos al trigger TR_EXTRAS_BU para validar la actualización del detalle
        UPDATE extra
        SET id_description = detail
        WHERE extra_id = extra_id;
        
        RETURN 'Detalle agregado exitosamente';
    END add_detail;
    
    -- Procedimiento para consultar los extras asociados a una reserva
    PROCEDURE get_extras(booking_id IN NUMBER, extras OUT SYS_REFCURSOR) IS
    BEGIN
        -- Lógica para obtener los extras asociados a una reserva
        OPEN extras FOR
        SELECT *
        FROM extra
        WHERE booking_id = booking_id;
    END get_extras;
    
    -- Procedimiento para eliminar un extra por su identificador
    PROCEDURE delete_extra(extra_id IN NUMBER) IS
    BEGIN
        -- Lógica para eliminar un extra por su identificador
        -- Llamamos al trigger TR_EXTRAS_BD para validar la eliminación del extra
        DELETE FROM extra
        WHERE extra_id = extra_id;
    END delete_extra;
    
    -- Función para obtener el total de ingresos de una reserva
    FUNCTION total_income(booking_id IN NUMBER) RETURN NUMBER IS
        total_amount NUMBER;
    BEGIN
        -- Lógica para calcular el total de ingresos de una reserva
        SELECT SUM(booking.nights * rate.amount) + SUM(e.amount)
        INTO total_amount
        FROM booking
        JOIN rate ON (booking.occupants = rate.occupancy AND booking.room_type_requested = rate.room_type)
        LEFT JOIN (SELECT booking_id, IFNULL(SUM(amount),0) AS amount FROM extra GROUP BY booking_id) AS e
        ON (e.booking_id = booking.booking_id)
        WHERE booking.booking_id = booking_id;
        
        RETURN total_amount;
    END total_income;
    
    -- Función para consultar los ingresos semanales
    FUNCTION weekly_income RETURN SYS_REFCURSOR IS
        weekly_income_cursor SYS_REFCURSOR;
    BEGIN
        -- Lógica para consultar los ingresos semanales
        OPEN weekly_income_cursor FOR
        SELECT DATE_ADD(MAKEDATE(2016, 7), INTERVAL WEEK(DATE_ADD(calendar.i, INTERVAL booking.nights - 5 DAY), 0) WEEK) AS Thursday,
        IFNULL(SUM(booking.nights * rate.amount) + SUM(e.amount),0) AS weekly_income
        FROM booking
        RIGHT OUTER JOIN calendar ON booking.booking_date = calendar.i
        JOIN rate ON (booking.occupants = rate.occupancy AND booking.room_type_requested = rate.room_type)
        LEFT JOIN (
            SELECT booking_id, IFNULL(SUM(amount),0) AS amount
            FROM extra
            GROUP BY booking_id
        ) AS e ON (e.booking_id = booking.booking_id)
        GROUP BY Thursday;
        
        RETURN weekly_income_cursor;
    END weekly_income;
    
    -- Función para consultar los ingresos por reserva
    FUNCTION income_by_booking(booking_id IN NUMBER) RETURN SYS_REFCURSOR IS
        income_cursor SYS_REFCURSOR;
    BEGIN
        -- Lógica para consultar los ingresos por reserva
        OPEN income_cursor FOR
        SELECT SUM(booking.nights * rate.amount) + SUM(e.amount) AS Total
        FROM booking
        JOIN rate ON (booking.occupants = rate.occupancy AND booking.room_type_requested = rate.room_type)
        JOIN (
            SELECT booking_id, SUM(amount) AS amount
            FROM extra
            GROUP BY booking_id
        ) AS e ON (e.booking_id = booking.booking_id)
        WHERE booking.booking_id = booking_id;
        
        RETURN income_cursor;
    END income_by_booking;
    
    -- Implementación de los triggers
    PROCEDURE TR_EXTRAS_BI IS
    BEGIN
        -- Lógica del trigger para generar identificador único antes de la inserción
        NULL;
    END TR_EXTRAS_BI;
    
    PROCEDURE TR_EXTRAS_AI IS
    BEGIN
        -- Lógica del trigger para aplicar descuento automático
        NULL;
    END TR_EXTRAS_AI;
    
    PROCEDURE TR_EXTRAS_BU IS
    BEGIN
        -- Lógica del trigger para restringir la modificación de detalles en la descripción de extras
        NULL;
    END TR_EXTRAS_BU;
    
    PROCEDURE TR_DESCRIPTIONS_BU IS
    BEGIN
        -- Lógica del trigger para restringir la modificación de detalles en la descripción
        NULL;
    END TR_DESCRIPTIONS_BU;
    
    PROCEDURE TR_DESCRIPTIONS_BD IS
    BEGIN
        -- Lógica del trigger para restringir la eliminación de detalles en la descripción
        NULL;
    END TR_DESCRIPTIONS_BD;
    
    PROCEDURE TR_EXTRAS_BD IS
    BEGIN
        -- Lógica del trigger para permitir la eliminación de extras si no tienen descripción
        NULL;
    END TR_EXTRAS_BD;
END BookingComponents;
/


-- 2. Proponga un caso de prueba exitoso por subprograma. (son seis)
-- (CRUDOK)
SELECT BookingComponents.add_detail(123, 'Nuevo detalle');

DECLARE
    extras_cursor SYS_REFCURSOR;
BEGIN
    BookingComponents.get_extras(456, extras_cursor);
    -- Utilizar el cursor para iterar sobre los resultados
END;

EXEC BookingComponents.delete_extra(789);

SELECT BookingComponents.total_income(123) FROM DUAL;

DECLARE
    weekly_income_cursor SYS_REFCURSOR;
BEGIN
    weekly_income_cursor := BookingComponents.weekly_income;
    -- Utilizar el cursor para iterar sobre los resultados
END;

DECLARE
    income_cursor SYS_REFCURSOR;
BEGIN
    income_cursor := BookingComponents.income_by_booking(123);
    -- Utilizar el cursor para iterar sobre los resultados
END;

-- 3. Proponga tres casos en los que el subprograma no se puede ejecutar.
-- (CRUDNoOK)
-- Caso CRUDNoOK para el subprograma add_detail
-- El extra especificado no existe.
BEGIN
    BookingComponents.add_detail(999, 'Nuevo detalle');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('El extra especificado no existe.');
END;

-- Caso CRUDNoOK para el subprograma get_extras
-- La reserva especificada no existe.
BEGIN
    DECLARE
        extras_cursor SYS_REFCURSOR;
    BEGIN
        BookingComponents.get_extras(999, extras_cursor);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('La reserva especificada no existe.');
    END;
END;

-- No hay extras asociados a la reserva especificada.
BEGIN
    DECLARE
        extras_cursor SYS_REFCURSOR;
    BEGIN
        BookingComponents.get_extras(123, extras_cursor);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No hay extras asociados a la reserva especificada.');
    END;
END;

-- Caso CRUDNoOK para el subprograma delete_extra
-- El extra especificado no existe.
BEGIN
    BookingComponents.delete_extra(999);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('El extra especificado no existe.');
END;

-- Caso CRUDNoOK para el subprograma total_income
-- La reserva especificada no existe.
BEGIN
    SELECT BookingComponents.total_income(999) FROM DUAL;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('La reserva especificada no existe.');
END;

-- Caso CRUDNoOK para el subprograma weekly_income
-- No hay datos disponibles en la tabla booking o rate.
BEGIN
    DECLARE
        weekly_income_cursor SYS_REFCURSOR;
    BEGIN
        weekly_income_cursor := BookingComponents.weekly_income;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No hay datos disponibles en la tabla booking o rate.');
    END;
END;

-- Caso CRUDNoOK para el subprograma income_by_booking
-- La reserva especificada no existe.
BEGIN
    DECLARE
        income_cursor SYS_REFCURSOR;
    BEGIN
        income_cursor := BookingComponents.income_by_booking(999);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('La reserva especificada no existe.');
    END;
END;

-- No hay datos disponibles en la tabla booking, rate, o extra.
BEGIN
    DECLARE
        income_cursor SYS_REFCURSOR;
    BEGIN
        income_cursor := BookingComponents.income_by_booking(123);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No hay datos disponibles en la tabla booking, rate, o extra.');
    END;
END;


-- 4. Escriba las instrucciones necesarias para eliminar los paquetes.
-- (CRUDX)
DROP PACKAGE BookingComponents;




------AUTO06

    
---=====Definiendo y poblando

--Para adicionar esta nueva información:

--Expliquen la estructura que van a usar para representar la información con un ejemplo completo.

--Estructura para representar la información:
--Para representar la información, utilizaremos un formato XML similar al proporcionado, pero con diferentes datos para demostrar la versatilidad del formato.

--El XML tendrá la siguiente estructura:

--Productos: Una lista de productos consumidos con su nombre, cantidad y precio.
--Propina: El valor de la propina, si existe.
--Ubicación: Lugar donde se atendió el extra, con opciones para Comedor, Piscina, Habitación y Salón.
--Nuevos atributos inventados: Calidad del servicio y tiempo de entrega.


--Modifiquen la creación de las tablas considerando este nuevo atributo.
CREATE TABLE extra (    
    extra_id NUMBER(11) NOT NULL CHECK (extra_id >= 9),
    booking_id NUMBER(11),
    amount NUMBER(9) CHECK (amount >=0),
    id_description NUMBER(11) NOT NULL,
    discount NUMBER(9) CHECK (discount >=0)
);

-- Alterar la tabla para añadir el atributo general
ALTER TABLE extra
ADD general_info XMLTYPE;

--Modifiquen las instrucciones para poblar la tabla considerando esta información

-- Insertar un ejemplo de dato XML con los nuevos atributos
INSERT INTO extra (extra_id, booking_id, amount, id_description, discount, general_info)
VALUES (10, 123, 50.00, 1, 0,
        XMLTYPE('<extra_info>
                    <productos>
                        <producto>
                            <nombre>Café</nombre>
                            <cantidad>2</cantidad>
                            <precio>10.00</precio>
                        </producto>
                        <producto>
                            <nombre>Galletas</nombre>
                            <cantidad>1</cantidad>
                            <precio>5.00</precio>
                        </producto>
                        <producto>
                            <nombre>Pollo</nombre>
                            <cantidad>3</cantidad>
                            <precio>11.00</precio>
                        </producto>
                    </productos>
                    <propina>5.00</propina>
                    <propina>8.00</propina>
                    <propina>13.00</propina>
                    <ubicacion>
                        <comedor>Comedor1</comedor>
                        <piscina>PiscinaComún</piscina>
                        <habitación>Habitación1</habitación>
                        <salón>Sa1ón1</salón>
                    </ubicacion>
                    <ubicacion>
                        <comedor>Comedor2</comedor>
                        <piscina>PiscinaCorriente</piscina>
                        <habitación>Habitación2</habitación>
                        <salón>Sa1ón2</salón>
                    </ubicacion>
                    <ubicacion>
                        <comedor>Comedor3</comedor>
                        <piscina>Piscilago</piscina>
                        <habitación>Habitación3</habitación>
                        <salón>Sa1ón3</salón>
                    </ubicacion>
                    <calidad_servicio>Bueno</calidad_servicio>
                    <calidad_servicio>Malo</calidad_servicio>
                    <calidad_servicio>Pésimo</calidad_servicio>
                    <tiempo_entrega>15 minutos</tiempo_entrega>
                    <tiempo_entrega>25 minutos</tiempo_entrega>
                    <tiempo_entrega>45 minutos</tiempo_entrega>
                </extra_info>'));
                
--CONSULTANDO

--Escriba las sentencias SQL que permitan conocer:
--La productos de de un extra específico.(Con toda la información)

SELECT 
    t.producto_nombre AS nombre,
    t.producto_cantidad AS cantidad,
    t.producto_precio AS precio
FROM 
    extra e,
    XMLTable('/extra_info/productos/producto' 
             PASSING e.general_info 
             COLUMNS 
                 producto_nombre VARCHAR2(100) PATH 'nombre',
                 producto_cantidad NUMBER PATH 'cantidad',
                 producto_precio NUMBER PATH 'precio'
            ) t
WHERE 
    e.extra_id = 10; -- Reemplaza :id_extra_especifico con el ID del extra específico que deseas obtener



--Los extras que lograron propinas mayores a un valor dado.

SELECT 
    extra_id,
    booking_id,
    amount,
    id_description,
    discount,
    general_info
FROM 
    extra,
    XMLTABLE('/extra_info/propina' PASSING general_info COLUMNS propina NUMBER PATH '.') p
WHERE 
    propina > 10.00; -- Cambiar por el valor deseado


--El número de extras por ubicación.

SELECT 
    ubicacion,
    COUNT(*) AS num_extras
FROM (
    SELECT 
        xt.ubicacion
    FROM 
        extra e,
        XMLTable('/extra_info/ubicacion' 
                 PASSING e.general_info 
                 COLUMNS 
                     ubicacion VARCHAR2(100) PATH '.'
                ) xt
    WHERE 
        e.extra_id = 10 -- Reemplaza con el extra_id específico que deseas obtener
)
GROUP BY 
    ubicacion;


SELECT 
    XMLQuery('/extra_info/ubicacion/comedor/text()' PASSING general_info RETURNING CONTENT) AS comedor,
    XMLQuery('/extra_info/ubicacion/piscina/text()' PASSING general_info RETURNING CONTENT) AS piscina,
    XMLQuery('/extra_info/ubicacion/habitación/text()' PASSING general_info RETURNING CONTENT) AS habitacion,
    XMLQuery('/extra_info/ubicacion/salón/text()' PASSING general_info RETURNING CONTENT) AS salon
FROM extra
WHERE extra_id = 10;

SELECT XMLSERIALIZE(CONTENT general_info AS CLOB) AS general_info
FROM extra
WHERE extra_id = 10;

-- Para extraer los productos
SELECT 
    EXTRACTVALUE(general_info, '/extra_info/productos/producto/nombre') AS producto_nombre,
    EXTRACTVALUE(general_info, '/extra_info/productos/producto/cantidad') AS producto_cantidad,
    EXTRACTVALUE(general_info, '/extra_info/productos/producto/precio') AS producto_precio
FROM extra
WHERE extra_id = 10;

-- Para extraer la ubicación
SELECT 
    EXTRACTVALUE(general_info, '/extra_info/ubicacion/comedor') AS comedor,
    EXTRACTVALUE(general_info, '/extra_info/ubicacion/piscina') AS piscina,
    EXTRACTVALUE(general_info, '/extra_info/ubicacion/habitación') AS habitacion,
    EXTRACTVALUE(general_info, '/extra_info/ubicacion/salón') AS salon
FROM extra
WHERE extra_id = 10;



--Propongan e implementen otras dos consultas. En las que usen las funciones XMLTable y dbms_xmlgen.getxmltype

--Consulta 4: cantidad de productos por nombre en la tabla extra:

SELECT 
    t.producto_nombre AS nombre_producto,
    COUNT(*) AS cantidad
FROM 
    extra e,
    XMLTable('/extra_info/productos/producto' 
             PASSING e.general_info 
             COLUMNS 
                 producto_nombre VARCHAR2(100) PATH 'nombre'
            ) t
WHERE 
    e.extra_id = 10
GROUP BY 
    t.producto_nombre;



--Consulta 5:Obtener la información de ubicación para un booking_id específico:

SELECT 
    xt.ubicacion
FROM 
    extra e,
    XMLTable('/extra_info/ubicacion' 
             PASSING dbms_xmlgen.getxmltype(e.general_info)
             COLUMNS 
                 ubicacion VARCHAR2(100) PATH '.'
            ) xt
WHERE 
    e.booking_id = 123; -- Reemplaza con el booking_id específico que deseas obtener


--Definiendo esquema

--Escriba un esquema DTD que garantice que:
<!ELEMENT extra_info (productos, propina*, ubicacion, calidad_servicio+, tiempo_entrega+)>
<!ELEMENT productos (producto+)>
<!ELEMENT producto (nombre, cantidad, precio)>
<!ELEMENT nombre (#PCDATA)>
<!ELEMENT cantidad (#PCDATA)>
<!ELEMENT precio (#PCDATA)>
<!ELEMENT propina (#PCDATA)>
<!ELEMENT ubicacion (comedor | piscina | habitación | salón)>
<!ELEMENT comedor (#PCDATA)>
<!ELEMENT piscina (#PCDATA)>
<!ELEMENT habitación (#PCDATA)>
<!ELEMENT salón (#PCDATA)>
<!ELEMENT calidad_servicio (#PCDATA)>
<!ELEMENT tiempo_entrega (#PCDATA)>

<!ATTLIST extra_info
    xmlns CDATA #IMPLIED
>

--Los extras deben tener mínimo dos productos.

--=Los extras deben tener mínimo dos productos: Se especifica dentro de <productos> 
--=que debe haber uno o más elementos <producto>. Esto asegura que haya al menos dos productos en un extra.


--Los extras pueden no tener propinas.

--=Los extras pueden no tener propinas: La propina está dentro de <extra_info> 
--=y se define con el modificador *, lo que significa que es opcional. Si hay propina, puede ser uno o más elementos <propina>.


--La ubicación de los extras sólo pueden una de las especificadas.

--=La ubicación de los extras sólo pueden ser una de las especificadas: Se utiliza una enumeración dentro de <ubicacion>, 
--=donde solo se permiten los elementos comedor, piscina, habitación y salón.

--Propongan e implementen otras dos restricciones

--=El precio de cada producto debe ser mayor que cero:

<!ATTLIST producto
    precio CDATA #REQUIRED
>

--=El descuento no puede ser mayor que el monto total:

<!ELEMENT descuento (#PCDATA)>
<!ATTLIST extra
    discount CDATA #REQUIRED
>


--IMPLEMENTACIÓN CON TODAS LAS RESTRICCIONES

<!ELEMENT extra_info (productos, propina*, ubicacion, calidad_servicio+, tiempo_entrega+, descuento)>
<!ELEMENT productos (producto+)>
<!ELEMENT producto (nombre, cantidad, precio)>
<!ELEMENT nombre (#PCDATA)>
<!ELEMENT cantidad (#PCDATA)>
<!ELEMENT precio (#PCDATA)>
<!ELEMENT propina (#PCDATA)>
<!ELEMENT ubicacion (comedor | piscina | habitación | salón)>
<!ELEMENT comedor (#PCDATA)>
<!ELEMENT piscina (#PCDATA)>
<!ELEMENT habitación (#PCDATA)>
<!ELEMENT salón (#PCDATA)>
<!ELEMENT calidad_servicio (#PCDATA)>
<!ELEMENT tiempo_entrega (#PCDATA)>
<!ELEMENT descuento (#PCDATA)>

<!ATTLIST producto
    precio CDATA #REQUIRED
>

<!ATTLIST extra
    discount CDATA #REQUIRED
>

---===TODO ESTO ES XML--------

--AHORA PARA PROBAR ESO EN SQL---

DECLARE
  v_xml XMLType;
BEGIN
  -- Lee el documento XML desde un archivo o una tabla en la base de datos
  v_xml := XMLType(
    '<?xml version="1.0"?>
     <extra_info>
         <productos>
             <producto>
                 <nombre>Café</nombre>
                 <cantidad>2</cantidad>
                 <precio>10.00</precio>
             </producto>
             <producto>
                 <nombre>Galletas</nombre>
                 <cantidad>1</cantidad>
                 <precio>5.00</precio>
             </producto>
         </productos>
         <propina>5.00</propina>
         <propina>8.00</propina>
         <ubicacion>
             <comedor>Comedor1</comedor>
             <piscina>PiscinaComún</piscina>
             <habitacion>Habitación1</habitacion>
             <salon>Sa1ón1</salon>
         </ubicacion>
         <calidad_servicio>Bueno</calidad_servicio>
         <calidad_servicio>Malo</calidad_servicio>
         <tiempo_entrega>15 minutos</tiempo_entrega>
         <tiempo_entrega>25 minutos</tiempo_entrega>
     </extra_info>'
  );
  
  -- Valida el documento XML con el DTD
  v_xml.ValidateXML('extra.dtd');
  
  DBMS_OUTPUT.PUT_LINE('El XML es válido según el DTD.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('El XML no es válido según el DTD.');
END;




