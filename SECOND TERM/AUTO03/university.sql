-- ========================= (tablas)

CREATE TABLE room (
    id NUMBER(11),
    room_type VARCHAR2(6),
    max_occupancy NUMBER(11)
);

CREATE TABLE room_type
(
    id VARCHAR2(6),
    description VARCHAR(100)
);

CREATE TABLE rate
(
    room_type VARCHAR2(6),
    occupancy NUMBER(11),
    amount DECIMAL(10,2)
)


-- ========================= Atributos, Primarias, Únicas, Foraneas
-- room
ALTER TABLE room
ADD CONSTRAINT PK_room PRIMARY KEY (id)

ALTER TABLE room
ADD CONSTRAINT FK_room_room_type FOREIGN KEY (room_type) REFERENCES room_type(id);

-- room_type
ALTER TABLE room_type
ADD CONSTRAINT PK_room_type PRIMARY KEY(id);

-- rate 
/*ALTER TABLE rate
ADD CONSTRAINT PK_rate PRIMARY KEY (ocuppcancy);

ALTER TABLE rate
DROP CONSTRAINT PK_rate;*/

ALTER TABLE rate
ADD CONSTRAINT PK_rate PRIMARY KEY (room_type,occupancy);

-- ========================= (PoblarOK)
INSERT INTO room_type VALUES ('single','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.');
INSERT INTO room_type VALUES ('twin','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.');
INSERT INTO room_type VALUES ('double','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.');
INSERT INTO room_type VALUES ('family','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.');

INSERT INTO room VALUES (1,'single',1);
INSERT INTO room VALUES (2,'twin',2);
INSERT INTO room VALUES (3,'double',4);
INSERT INTO room VALUES (4,'family',6);

INSERT INTO rate VALUES ('single',2,36);
INSERT INTO rate VALUES ('twin',4,2.36);
INSERT INTO rate VALUES ('double',8,21.99);
INSERT INTO rate VALUES ('family',12,32.36);

-- ========================= (PoblarNoOK)
INSERT INTO room_type VALUES ('single','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.');
INSERT INTO room VALUES (1,'single',1);
INSERT INTO rate VALUES ('single',2,36);


-- ========================= (Consultas)
SELECT room.id,room.room_type, rate.amount,rate.occupancy FROM room 
JOIN room_type ON room.room_type = room_type.id
JOIN rate ON room_type.id = rate.room_type;

SELECT id, room_type, max_occupancy FROM room;

SELECT room_type.id, room_type.description, room.max_occupancy, rate.amount FROM room
JOIN room_type ON room.room_type = room_type.id 
JOIN rate ON room_type.id = rate.room_type
ORDER by rate.amount;

SELECT COUNT(*) FROM room 
WHERE room_type = 'family';

SELECT room_type.id, room_type.description, COUNT(room.room_type),
TRUNC((COUNT(room.room_type)/30)*100)
FROM room_type JOIN room ON room_type.id = room.room_type
GROUP BY room_type.id,room_type.description;

-- ========================= (XPoblar) 

TRUNCATE TABLE room;
TRUNCATE TABLE room_type;
TRUNCATE TABLE rate;

-- ========================= (XTablas)

DROP TABLE room;
DROP TABLE room_type;
DROP TABLE rate;




