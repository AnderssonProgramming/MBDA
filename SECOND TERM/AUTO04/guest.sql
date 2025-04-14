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



-- Las acciones referenciales `ON DELETE CASCADE` y `ON DELETE SET NULL` aseguran la integridad de los datos tras la eliminación de registros relacionados. `ON DELETE CASCADE` elimina registros dependientes para mantener la coherencia de la base de datos, mientras que `ON DELETE SET NULL` preserva los registros dependientes pero elimina la asociación, marcando la llave foránea como `NULL`. Ambas acciones son cruciales para el mantenimiento automático de las relaciones entre tablas y previenen inconsistencias de datos. La elección entre ambas depende de las necesidades específicas de la aplicación y las reglas de negocio establecidas.

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


