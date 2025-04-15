--Trigger para validar datos ingresados:
CREATE OR REPLACE TRIGGER validar_correo_cliente    ---IMPLEMENTADO
BEFORE INSERT OR UPDATE ON clientes
FOR EACH ROW
BEGIN
    IF (INSTR(:NEW.correo, '@') = 0 OR INSTR(:NEW.correo, '@', 1, 2) > 0 OR INSTR(:NEW.correo, '.') = 0) THEN
        RAISE_APPLICATION_ERROR(-20001, 'El formato del correo electrónico es inválido');
    END IF;
END;
/
INSERT INTO clientes (id, correo) VALUES ('1', 'correoinvalido');


--Trigger para ejecutar acciones específicas después de ciertos eventos:
CREATE OR REPLACE TRIGGER actualizar_estado_platos
AFTER INSERT ON pedidos
FOR EACH ROW
BEGIN
    UPDATE platos_empresas SET unidadesDisponibles = unidadesDisponibles - 1 WHERE idPlato = :NEW.idPlato AND nitEmpresa = :NEW.nitEmpresa;
    UPDATE platos_empresas SET unidadesDisponibles = unidadesVendidas + 1 WHERE idPlato = :NEW.idPlato AND nitEmpresa = :NEW.nitEmpresa;
END;
/
-- Insertar pedido
INSERT INTO pedidos (id, idConsumidor, nombreConsumidor, direccionConsumidor, estado, idCarritoCompras, idCalificacion, idFactura, idEnvio, costo)
VALUES ('1', '1', 'Cliente', '123 Calle Principal', 'P', '1', '1', '1', '1', 100);

-- Asegurarse de que haya suficientes unidades disponibles del plato en la tabla platos_empresas
UPDATE platos_empresas SET unidadesDisponibles = 10 WHERE idPlato = '1' AND nitEmpresa = 'empresa1';

-- Insertar nuevo pedido
INSERT INTO pedidos (id, idConsumidor, nombreConsumidor, direccionConsumidor, estado, idCarritoCompras, idCalificacion, idFactura, idEnvio, costo, idPlato, nitEmpresa)
VALUES ('2', '2', 'Cliente2', '456 Calle Secundaria', 'P', '2', '2', '2', '2', 150, '1', 'empresa1');


--Trigger para manejar restricciones de integridad referencial
CREATE OR REPLACE TRIGGER evitar_eliminar_cliente_referenciado
BEFORE DELETE ON clientes
FOR EACH ROW
DECLARE
    cnt NUMBER;
BEGIN
    SELECT COUNT(*) INTO cnt FROM pedidos WHERE idConsumidor = :OLD.id;
    IF cnt > 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'No se puede eliminar este cliente porque tiene pedidos asociados');
    END IF;
END;
/
INSERT INTO clientes (id, correo) VALUES ('2222', 'cliente1@example.com');

INSERT INTO pedidos (id, idConsumidor, nombreConsumidor, direccionConsumidor, estado, idCarritoCompras, idCalificacion, idFactura, idEnvio, costo)
VALUES ('1', '1', 'Cliente1', '123 Calle Principal', 'P', '1', '1', '1', '1', 100);

DELETE FROM clientes WHERE id = '2222';



--Trigger para generar números de identificación únicos
CREATE OR REPLACE TRIGGER generar_id_donacion  --IMPORTANTE
BEFORE INSERT ON donaciones
FOR EACH ROW
BEGIN
    SELECT 'DON' || TO_CHAR(SYSDATE, 'YYYYMMDD') || LPAD(donaciones_seq.NEXTVAL, 5, '0') INTO :NEW.id FROM dual;
END;
/
INSERT INTO donaciones (fecha, cantidad, tipo) VALUES (SYSDATE, 100, 'P');

--Trigger para verificar que la fecha es menor que la fecha de entrega
CREATE OR REPLACE TRIGGER verificar_fecha_envio
BEFORE INSERT OR UPDATE ON envios
FOR EACH ROW
BEGIN
    IF :NEW.fecha >= :NEW.fechaEntrega THEN
        RAISE_APPLICATION_ERROR(-20001, 'La fecha de envío debe ser anterior a la fecha de entrega');
    END IF;
END;
/


--Trigger para manejar acciones después de una operación DML:
CREATE OR REPLACE TRIGGER actualizar_total_factura  --IMPORTANTE
AFTER INSERT OR UPDATE OR DELETE ON pedidos
DECLARE
    v_total NUMBER;
BEGIN
    IF INSERTING OR UPDATING THEN
        SELECT SUM(precio) INTO v_total FROM pedidos WHERE idConsumidor = :NEW.idConsumidor;
        UPDATE facturas SET total = v_total WHERE idConsumidor = :NEW.idConsumidor;
    ELSE
        SELECT SUM(precio) INTO v_total FROM pedidos WHERE idConsumidor = :OLD.idConsumidor;
        UPDATE facturas SET total = v_total WHERE idConsumidor = :OLD.idConsumidor;
    END IF;
END;
/

--MANEJAR DESCUENTO DEL 10% SI EL TIPO ES P O A 
CREATE OR REPLACE TRIGGER TRG_MENUS_ALEATORIOS_DESCUENTO
BEFORE INSERT ON menusAleatorios
FOR EACH ROW
BEGIN
    IF :NEW.tipo IN ('P', 'A') THEN
        -- Aplica descuento del 10%
        :NEW.precio := :NEW.precio * 0.9;
    END IF;
END;
/


--PUBLICIDAD

CREATE OR REPLACE TRIGGER TRG_PUBLICIDAD_CLIENTES
AFTER INSERT ON clientes
FOR EACH ROW
DECLARE
    v_mensaje VARCHAR2(4000);
    v_oferta_id VARCHAR2(10);
    v_plato_nombre VARCHAR2(50);
    v_plato_precio NUMBER(8,2);
    v_empresa_nombre VARCHAR2(100);
BEGIN
    -- Obtener una oferta aleatoria de la tabla menusAleatorios
    SELECT id, nombre, precio, nitEmpresa
    INTO v_oferta_id, v_plato_nombre, v_plato_precio, v_empresa_nombre
    FROM (
        SELECT id, nombre, precio, idPlato, nitEmpresa
        FROM menusAleatorios
        ORDER BY dbms_random.value
    )
    WHERE ROWNUM = 1;

    -- Componer el mensaje de publicidad
    v_mensaje := '¡Hola ' || :NEW.correo || '! Bienvenido a nuestra plataforma.';

    -- Añadir información sobre la oferta
    v_mensaje := v_mensaje || ' Descubre nuestra oferta del día en ' || v_empresa_nombre || ':';
    v_mensaje := v_mensaje || ' "' || v_plato_nombre || '" con un precio original de ' || TO_CHAR(v_plato_precio, 'FM$9999.99') || '.';

    -- Aplicar descuento si es necesario
    IF v_oferta_id IS NOT NULL THEN
        v_mensaje := v_mensaje || ' ¡Hoy puedes disfrutarlo con un descuento del 10%!';
        v_plato_precio := v_plato_precio * 0.9; -- Aplicar descuento
    END IF;

    -- Finalizar el mensaje
    v_mensaje := v_mensaje || ' ¡No te lo pierdas!';

    -- Imprimir el mensaje como publicidad
    DBMS_OUTPUT.PUT_LINE(v_mensaje);

    -- Actualizar el precio del plato en la oferta con el descuento aplicado
    IF v_oferta_id IS NOT NULL THEN
        UPDATE menusAleatorios
        SET precio = v_plato_precio
        WHERE id = v_oferta_id;
    END IF;
END;
/

-- Trigger para validar que la fecha de expiración de un bono no sea menor a la fecha actual
CREATE OR REPLACE TRIGGER TRG_validar_fecha_expiracion_tipobono_mayor_fecha_actual
BEFORE INSERT OR UPDATE ON tiposBono
FOR EACH ROW
DECLARE
BEGIN
        IF :NEW.FECHAEXPIRACION < SYSDATE THEN
            RAISE_APPLICATION_ERROR(-20001, 'La fecha de expiraci�n de un bono no puede ser menor a la fecha actual.');
    END IF;
END;
/



CREATE OR REPLACE TRIGGER generar_id_plato_aleatorio
BEFORE INSERT ON carritosMenus
FOR EACH ROW
DECLARE
    v_id_plato VARCHAR2(10);
BEGIN
    -- Seleccionar un ID de plato aleatorio
    SELECT idPlato
    INTO v_id_plato
    FROM (
        SELECT idPlato, ROW_NUMBER() OVER (ORDER BY DBMS_RANDOM.VALUE) AS rn
        FROM menus_platos
    )
    WHERE rn = 1; -- Seleccionar solo la primera fila (ID de plato aleatorio)
    
    -- Insertar el ID de plato aleatorio en la tabla carritosMenus
    :NEW.id_plato_aleatorio_seleccionado := v_id_plato;
END;
/

-- Trigger para actualizar el estado de los platos vendidos y disponibles
CREATE OR REPLACE TRIGGER actualizar_estado_platos_vendidos_disponible
AFTER INSERT ON carritosMenus
FOR EACH ROW
BEGIN
    UPDATE platos_empresas SET unidadesDisponibles = unidadesDisponibles - 1 WHERE idPlato = :NEW.id_plato_aleatorio_seleccionado AND nitEmpresa = :NEW.nit_Empresa;
    UPDATE platos_empresas SET unidadesVendidas  = unidadesVendidas + 1 WHERE idPlato = :NEW.id_plato_aleatorio_seleccionado AND nitEmpresa = :NEW.nit_Empresa;    
END;
/


-- Trigger para validar que la fecha de envío sea menor a la fecha de entrega
CREATE OR REPLACE TRIGGER verificar_fecha_envio
BEFORE INSERT OR UPDATE ON envios
FOR EACH ROW
BEGIN
    IF :NEW.fecha >= :NEW.fechaEntrega THEN
        RAISE_APPLICATION_ERROR(-20001, 'La fecha de env�o debe ser anterior a la fecha de entrega');
    END IF;
END;
/