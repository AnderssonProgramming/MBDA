------------ PK_CLIENTES --------------
select * from menus_aleatorios;
CREATE OR REPLACE PACKAGE PK_CLIENTES AS    
    PROCEDURE adicionar__direccion_cliente (
        p_idcliente IN CHAR,
        p_direccion_cliente IN VARCHAR
    );
    
    PROCEDURE adicionar__celular_cliente (
        p_idcliente IN CHAR,
        p_celular_cliente IN NUMBER
    );    
    
    PROCEDURE modificar__direccion_cliente (   
        p_id_direccion IN CHAR,
        p_idcliente IN CHAR,
        p_nuevo_direccion_cliente IN VARCHAR
    );
    
    PROCEDURE modificar__celular_cliente (
        p_id_celular IN CHAR,
        p_idcliente IN CHAR,
        p_nuevo_celular_cliente IN NUMBER
    );
    
    
    PROCEDURE eliminar__direccion_cliente (
        p_id_direccion IN CHAR,
        p_idcliente IN CHAR
    );
    
    PROCEDURE eliminar__celular_cliente (
        p_id_celular IN CHAR,
        p_idcliente IN CHAR        
    );    
        
    FUNCTION consultar_direcciones_cliente RETURN SYS_REFCURSOR;
    PROCEDURE print_consultar_direcciones_cliente;
    FUNCTION consultar_celulares_cliente RETURN SYS_REFCURSOR;    
    PROCEDURE print_consultar_celulares_cliente;
        
    -- PROCEDURE mejoresConsumidores;
END PK_CLIENTES;
/

CREATE OR REPLACE PACKAGE BODY PK_CLIENTES AS
   PROCEDURE adicionar__direccion_cliente (
        p_idcliente IN CHAR,
        p_direccion_cliente IN VARCHAR
    )
    AS 
    BEGIN 
        INSERT INTO direcciones_Cliente (idcliente, direccioncliente)
        VALUES (p_idcliente, p_direccion_cliente);
        COMMIT;
    EXCEPTION 
        WHEN OTHERS THEN
        ROLLBACK; -- Deshacer los cambios en caso de cualquier error
        DBMS_OUTPUT.PUT_LINE('Ocurri� un error, la transacci�n ha sido revertida.');
        RAISE;
    END adicionar__direccion_cliente;
    
    PROCEDURE adicionar__celular_cliente (
        p_idcliente IN CHAR,
        p_celular_cliente IN NUMBER
        )
    AS 
    BEGIN 
        INSERT INTO celulares_Cliente (idcliente, celularCliente)
        VALUES (p_idcliente, p_celular_cliente);
        COMMIT;
    EXCEPTION 
        WHEN OTHERS THEN
        ROLLBACK; -- Deshacer los cambios en caso de cualquier error
        DBMS_OUTPUT.PUT_LINE('Ocurri� un error, la transacci�n ha sido revertida.');
        RAISE;
    END adicionar__celular_cliente;

    PROCEDURE modificar__direccion_cliente (   
        p_id_direccion IN CHAR,
        p_idcliente IN CHAR,
        p_nuevo_direccion_cliente IN VARCHAR
    )
    AS
    BEGIN        
            UPDATE direcciones_cliente SET direccioncliente = p_nuevo_direccion_cliente WHERE id = p_id_direccion  AND 
            idcliente = p_idcliente;        
        COMMIT;
    EXCEPTION 
        WHEN OTHERS THEN
        ROLLBACK; -- Deshacer los cambios en caso de cualquier error
        DBMS_OUTPUT.PUT_LINE('Ocurri� un error, la transacci�n ha sido revertida.');
        RAISE;
    END modificar__direccion_cliente;
    
    PROCEDURE modificar__celular_cliente (
        p_id_celular IN CHAR,
        p_idcliente IN CHAR,
        p_nuevo_celular_cliente IN NUMBER
    )
     AS
    BEGIN        
            UPDATE celulares_cliente SET celularcliente = p_nuevo_celular_cliente WHERE id = p_id_celular AND 
            idcliente = p_idcliente;        
        COMMIT;
    EXCEPTION 
        WHEN OTHERS THEN
        ROLLBACK; -- Deshacer los cambios en caso de cualquier error
        DBMS_OUTPUT.PUT_LINE('Ocurri� un error, la transacci�n ha sido revertida.');
        RAISE;
    END modificar__celular_cliente;
    
    PROCEDURE eliminar__direccion_cliente (
        p_id_direccion IN CHAR,
        p_idcliente IN CHAR
    )
    AS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM direcciones_cliente  
        WHERE id = p_id_direccion;

        -- Si no se encuentra ninguna fila con el ID proporcionado, lanzar una excepci�n
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'El ID de la direccion no existe en la base de datos.');
        END IF;
        
        DELETE FROM direcciones_cliente WHERE id = p_id_direccion and idcliente = p_idcliente;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            -- Manejar cualquier otra excepci�n que pueda ocurrir durante la ejecuci�n del procedimiento
            ROLLBACK; -- Revertir los cambios en caso de error
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error, la transacci�n ha sido revertida.');
            RAISE; -- Relanzar la excepci�n para que sea manejada en un nivel superior
    
    END eliminar__direccion_cliente;
    
    PROCEDURE eliminar__celular_cliente (
        p_id_celular IN CHAR,
        p_idcliente IN CHAR        
    )
    AS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM celulares_Cliente
        WHERE id = p_id_celular;

        -- Si no se encuentra ninguna fila con el ID proporcionado, lanzar una excepci�n
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'El ID del numero de celular no existe en la base de datos.');
        END IF;
        
        DELETE FROM celulares_cliente WHERE id = p_id_celular and idcliente = p_idcliente;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            -- Manejar cualquier otra excepci�n que pueda ocurrir durante la ejecuci�n del procedimiento
            ROLLBACK; -- Revertir los cambios en caso de error
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error, la transacci�n ha sido revertida.');
            RAISE; -- Relanzar la excepci�n para que sea manejada en un nivel superior
    END eliminar__celular_cliente;
------------------------------------------------------------------------------------------------------------------------------------        
    FUNCTION consultar_direcciones_cliente RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN 
        OPEN v_cursor FOR
            SELECT *
            FROM direcciones_Cliente;            
        RETURN v_cursor;
    END consultar_direcciones_cliente;
    
    PROCEDURE print_consultar_direcciones_cliente
    AS
        v_direccion direcciones_Cliente.direccionCliente%TYPE;
        v_id_cliente direcciones_Cliente.idcliente%TYPE;  
        v_id direcciones_Cliente.id%TYPE;        
        v_direcciones_cursor SYS_REFCURSOR;
    BEGIN
        v_direcciones_cursor := PK_CLIENTES.consultar_direcciones_cliente;
        LOOP
            FETCH v_direcciones_cursor INTO v_id, v_id_cliente, v_direccion;
            EXIT WHEN v_direcciones_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('id_direccion: ' || v_id || ' id cliente: ' || v_id_cliente || 'Direcci�n: ' || v_direccion);
        END LOOP;
        CLOSE v_direcciones_cursor;        
    END print_consultar_direcciones_cliente;    

    FUNCTION consultar_celulares_cliente RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN 
        OPEN v_cursor FOR
            SELECT *
            FROM celulares_Cliente;            
        RETURN v_cursor;
    END consultar_celulares_cliente;    

    PROCEDURE print_consultar_celulares_cliente
    AS  v_id celulares_Cliente.id%TYPE;
        v_id_cliente celulares_Cliente.idcliente%TYPE;
        v_celular celulares_Cliente.celularCliente%TYPE;
        v_celulares_cursor SYS_REFCURSOR;
        
    BEGIN
        v_celulares_cursor := PK_CLIENTES.consultar_celulares_cliente;
        LOOP
            FETCH v_celulares_cursor INTO v_id,v_id_cliente,v_celular;
            EXIT WHEN v_celulares_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('Id celcular: ' || v_id || 'Id cliente: ' || v_id_cliente || 'Celular: ' || v_celular);
        END LOOP;
        CLOSE v_celulares_cursor;        
    END print_consultar_celulares_cliente;
    
END PK_CLIENTES;

------------ PK_CONSUMIDORES ------------
CREATE OR REPLACE PACKAGE PK_CONSUMIDORES AS
    PROCEDURE adicionar_consumidor(    
        p_nombre IN CHAR,
        p_preferencia IN VARCHAR2,
        p_correo IN VARCHAR2
        -- funciones y consultas gerenciales
    );

    PROCEDURE modificar_consumidor(
    p_id_consumidor IN CHAR,
        p_columna IN VARCHAR2,
        p_nuevo_valor IN VARCHAR2
    );

    PROCEDURE eliminar_consumidor(
        p_id IN CHAR
    );
    
    FUNCTION consultar_consumidores RETURN SYS_REFCURSOR;
    PROCEDURE print_consultar_consumidores;  
    -- PROCEDURE mejoresConsumidores;
END PK_CONSUMIDORES;
/

CREATE OR REPLACE PACKAGE BODY PK_CONSUMIDORES AS
    PROCEDURE adicionar_consumidor(
        p_nombre IN CHAR,
        p_preferencia IN VARCHAR2,
        p_correo IN VARCHAR2
    )
    AS
    id_auto_incremental_calculado CHAR(10);
    BEGIN
        INSERT INTO clientes (correo) 
        VALUES (p_correo);
        -- Tomamos el id que se creo por el trigger gracias a que el correo es unico
        SELECT id 
        INTO id_auto_incremental_calculado
        FROM clientes
        WHERE correo = p_correo;
        
        INSERT INTO consumidores (id,nombre, preferencia_Alimento)
        VALUES (id_auto_incremental_calculado, p_nombre, p_preferencia);
        
        COMMIT;
    EXCEPTION 
        WHEN OTHERS THEN
        ROLLBACK; -- Deshacer los cambios en caso de cualquier error
        DBMS_OUTPUT.PUT_LINE('Ocurri� un error, la transacci�n ha sido revertida.');
        RAISE; -- Propagar el error para que pueda ser manejado por el llamador
    END adicionar_consumidor;

    PROCEDURE modificar_consumidor(
        p_id_consumidor IN CHAR,
        p_columna IN VARCHAR2,
        p_nuevo_valor IN VARCHAR2   
    ) AS
    BEGIN
        IF p_columna = 'correo' THEN
            UPDATE clientes SET correo = p_nuevo_valor WHERE id = p_id_consumidor;
        ELSIF p_columna = 'nombre' THEN
            UPDATE consumidores SET nombre = p_nuevo_valor WHERE id = p_id_consumidor;
        ELSIF p_columna = 'preferencia_Alimento' THEN
            UPDATE consumidores SET preferencia_Alimento = p_nuevo_valor WHERE id = p_id_consumidor;
         ELSE
            RAISE_APPLICATION_ERROR(-20002, 'Columna no v�lida');
        END IF;
        COMMIT;
    EXCEPTION 
        WHEN OTHERS THEN
        ROLLBACK; -- Deshacer los cambios en caso de cualquier error
        DBMS_OUTPUT.PUT_LINE('Ocurri� un error, la transacci�n ha sido revertida.');
        RAISE;        
    END modificar_consumidor;

    PROCEDURE eliminar_consumidor(
        p_id IN CHAR
    ) AS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM clientes
        WHERE id = p_id;

        -- Si no se encuentra ninguna fila con el ID proporcionado, lanzar una excepci�n
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'El ID del consumidor no existe en la base de datos.');
        END IF;
        
        DELETE FROM consumidores WHERE id = p_id;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            -- Manejar cualquier otra excepci�n que pueda ocurrir durante la ejecuci�n del procedimiento
            ROLLBACK; -- Revertir los cambios en caso de error
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error, la transacci�n ha sido revertida.');
            RAISE; -- Relanzar la excepci�n para que sea manejada en un nivel superior            
    END eliminar_consumidor;

    FUNCTION consultar_consumidores RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN 
        OPEN v_cursor FOR
            SELECT 
                clientes.id,
                clientes.correo,
                consumidores.nombre,
                consumidores.preferencia_alimento
            FROM consumidores
            JOIN clientes
            ON clientes.id = consumidores.id;
        RETURN v_cursor;
    END consultar_consumidores;

    PROCEDURE print_consultar_consumidores
    AS
    v_consumidor_cursor SYS_REFCURSOR;
    v_id clientes.id%TYPE;
    v_correo clientes.correo%TYPE;
    v_nombre consumidores.nombre%TYPE;
    v_preferencia_alimento consumidores.preferencia_alimento%TYPE;
    BEGIN
        v_consumidor_cursor := PK_CONSUMIDORES.consultar_consumidores;
        LOOP
            FETCH v_consumidor_cursor INTO v_id,v_correo,v_nombre,v_preferencia_alimento;
            EXIT WHEN v_consumidor_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('id: ' || v_id || 'correo: ' || v_correo || 'nombre: ' || v_nombre|| 'preferencia_alimento: ' || v_preferencia_alimento);
        END LOOP;
        CLOSE v_consumidor_cursor;        
    END print_consultar_consumidores;
/*
    PROCEDURE mejoresConsumidores IS
    BEGIN
        -- Consulta de los mejores consumidores
    END mejoresConsumidores;
*/    
END PK_CONSUMIDORES;
/

------------ PK_EMPRESAS ------------
CREATE OR REPLACE PACKAGE PK_EMPRESAS AS
    PROCEDURE adicionar_empresa(    
        p_nombre IN CHAR,
        p_tipoNegocio IN VARCHAR2,
        p_correo IN VARCHAR2
        -- funciones y consultas gerenciales
    );

    PROCEDURE modificar_empresa(
    p_nit_empresa IN CHAR,
        p_columna IN VARCHAR2,
        p_nuevo_valor IN VARCHAR2
    );

    PROCEDURE eliminar_empresa(
        p_nit_empresa IN CHAR
    );
    
    FUNCTION consultar_empresas RETURN SYS_REFCURSOR;
    PROCEDURE print_consultar_empresas;
    
    -- PROCEDURE mejoresConsumidores;
END PK_EMPRESAS;
/

CREATE OR REPLACE PACKAGE BODY PK_EMPRESAS AS
    PROCEDURE adicionar_empresa(    
        p_nombre IN CHAR,
        p_tipoNegocio IN VARCHAR2,
        p_correo IN VARCHAR2
        -- funciones y consultas gerenciales
    )
    AS
    nit_auto_incremental_calculado CHAR(10);
    BEGIN
        INSERT INTO clientes (correo) 
        VALUES (p_correo);
        -- Tomamos el nit que se creo por el trigger gracias a que el correo es unico
        SELECT id 
        INTO nit_auto_incremental_calculado
        FROM clientes
        WHERE correo = p_correo;
        
        INSERT INTO empresas (nit,nombre, tiponegocio)
        VALUES (nit_auto_incremental_calculado, p_nombre, p_tipoNegocio);        
        COMMIT;
    EXCEPTION 
        WHEN OTHERS THEN
        ROLLBACK; -- Deshacer los cambios en caso de cualquier error
        DBMS_OUTPUT.PUT_LINE('Ocurri� un error, la transacci�n ha sido revertida.');
        RAISE; -- Propagar el error para que pueda ser manejado por el llamador
    END adicionar_empresa;
	
	PROCEDURE modificar_empresa(
        p_nit_empresa IN CHAR,
        p_columna IN VARCHAR2,
        p_nuevo_valor IN VARCHAR2   
    ) AS
    BEGIN
        IF p_columna = 'nombre' THEN
            UPDATE empresas SET nombre = p_nuevo_valor WHERE nit = p_nit_empresa;
        ELSIF p_columna = 'tipoNegocio' THEN
            UPDATE empresas SET tipoNegocio = p_nuevo_valor WHERE nit = p_nit_empresa;
         ELSE
            RAISE_APPLICATION_ERROR(-20002, 'Columna no v�lida');
        END IF;
        COMMIT;
    EXCEPTION 
        WHEN OTHERS THEN
            ROLLBACK; -- Deshacer los cambios en caso de cualquier error
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error, la transacci�n ha sido revertida.');
            RAISE;        
    END modificar_empresa;

    PROCEDURE eliminar_empresa(
        p_nit_empresa IN CHAR
    ) AS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM clientes
        WHERE id = p_nit_empresa;

        -- Si no se encuentra ninguna fila con el ID proporcionado, lanzar una excepci�n
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'El ID del consumidor no existe en la base de datos.');
        END IF;
        
        DELETE FROM empresas WHERE nit = p_nit_empresa;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            -- Manejar cualquier otra excepci�n que pueda ocurrir durante la ejecuci�n del procedimiento
            ROLLBACK; -- Revertir los cambios en caso de error
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error, la transacci�n ha sido revertida.');
            RAISE; -- Relanzar la excepci�n para que sea manejada en un nivel superior            
    END eliminar_empresa;

    FUNCTION consultar_empresas RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN 
        OPEN v_cursor FOR
            SELECT 
                clientes.id,
                clientes.correo,
                empresas.nombre,
                empresas.tiponegocio
            FROM empresas
            JOIN clientes
            ON clientes.id = empresas.nit;
        RETURN v_cursor;
    END consultar_empresas;

    PROCEDURE print_consultar_empresas
    AS
        v_empresa_cursor SYS_REFCURSOR;
        v_id clientes.id%TYPE;
        v_correo clientes.correo%TYPE;
        v_nombre empresas.nombre%TYPE;
        v_tiponegocio empresas.tiponegocio%TYPE;
    BEGIN
        v_empresa_cursor := PK_EMPRESAS.consultar_empresas;
        LOOP
            FETCH v_empresa_cursor INTO v_id, v_correo, v_nombre, v_tiponegocio;
            EXIT WHEN v_empresa_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('id: ' || v_id || ' correo: ' || v_correo || ' nombre: ' || v_nombre || ' tipo negocio: ' || v_tiponegocio);
        END LOOP;
        CLOSE v_empresa_cursor;        
    END print_consultar_empresas;
/*
    PROCEDURE mejoresConsumidores IS
    BEGIN
        -- Consulta de los mejores consumidores
    END mejoresConsumidores;
*/    

END PK_EMPRESAS;
/

------------ PK_PLATOS ------------
CREATE OR REPLACE PACKAGE PK_PLATOS AS
    PROCEDURE adicionar_platos(    
        p_nombre IN VARCHAR2,
        p_precio IN NUMBER,
        p_nit_empresa IN CHAR
    );

    PROCEDURE modificar_platos(
        p_id_plato IN VARCHAR2,
        p_columna IN VARCHAR2,
        p_nuevo_valor IN VARCHAR2
    );

    PROCEDURE eliminar_platos(
        p_id_plato IN VARCHAR2
    );

    FUNCTION consultar_platos RETURN SYS_REFCURSOR;
    PROCEDURE print_consultar_platos;
    
    PROCEDURE modificar_platos_fecha_caducidad_plato_platos_empresa(
        p_id_plato IN VARCHAR2,
        p_fecha_caducidad DATE
        );

END PK_PLATOS;
/

CREATE OR REPLACE PACKAGE BODY PK_PLATOS AS
    PROCEDURE adicionar_platos(    
    p_nombre IN VARCHAR2,
    p_precio IN NUMBER,
    p_nit_empresa IN CHAR
)
AS
    id_auto_incremental_calculado VARCHAR2(10); 
    v_estado_plato VARCHAR2(20);
BEGIN
    -- Verificar si el plato ya existe y su estado
    SELECT estado INTO v_estado_plato 
    FROM platos 
    WHERE nombre = p_nombre 
    AND nit_empresa = p_nit_empresa;
    
    IF v_estado_plato = 'no disponible' THEN
        -- Si el plato existe y su estado es no disponible, actualizar el estado a disponible
        UPDATE platos 
        SET estado = 'disponible' 
        WHERE nombre = p_nombre 
        AND nit_empresa = p_nit_empresa;        
        DBMS_OUTPUT.PUT_LINE('El plato "' || p_nombre || '" ha sido actualizado a estado disponible.');
    ELSIF v_estado_plato = 'disponible' THEN
        -- Si el plato existe y su estado es disponible, lanzar un error
        RAISE_APPLICATION_ERROR(-20001, 'El plato "' || p_nombre || '" ya existe y su estado es disponible.');
    ELSE
        -- Si el plato no existe, continuar con la inserci�n
        SELECT TO_CHAR(SEQ_PLATOS.NEXTVAL) INTO id_auto_incremental_calculado FROM dual;

        -- Insertar el plato en platos
        INSERT INTO platos (id, nombre, precio, nit_empresa, estado) 
        VALUES (id_auto_incremental_calculado, p_nombre, p_precio, p_nit_empresa, 'disponible');
        
        -- Insertar el plato en platos_empresas
        INSERT INTO platos_empresas (idPlato, nitEmpresa, fechaCaducidad, unidadesDisponibles, unidadesVendidas)
        VALUES (id_auto_incremental_calculado, p_nit_empresa, '0-0-0', 0, 0);

        -- Mostrar un mensaje indicando la inserci�n exitosa
        DBMS_OUTPUT.PUT_LINE('Se ha insertado un nuevo plato con id_plato: ' || id_auto_incremental_calculado || ' para la empresa con NIT: ' || p_nit_empresa);
    END IF;

    COMMIT;
EXCEPTION 
    WHEN NO_DATA_FOUND THEN
        -- Si no se encuentra ning�n plato con el nombre proporcionado, continuar con la inserci�n
        SELECT TO_CHAR(SEQ_PLATOS.NEXTVAL) INTO id_auto_incremental_calculado FROM dual;

        -- Insertar el plato en platos
        INSERT INTO platos (id, nombre, precio, nit_empresa, estado) 
        VALUES (id_auto_incremental_calculado, p_nombre, p_precio, p_nit_empresa, 'disponible');
        
        -- Insertar el plato en platos_empresas
        INSERT INTO platos_empresas (idPlato, nitEmpresa, fechaCaducidad, unidadesDisponibles, unidadesVendidas)
        VALUES (id_auto_incremental_calculado, p_nit_empresa, '0-0-0', 0, 0);

        -- Mostrar un mensaje indicando la inserci�n exitosa
        DBMS_OUTPUT.PUT_LINE('Se ha insertado un nuevo plato con id_plato: ' || id_auto_incremental_calculado || ' para la empresa con NIT: ' || p_nit_empresa);
        COMMIT;
    WHEN OTHERS THEN
        -- Deshacer los cambios en caso de cualquier error
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Ocurri� un error, la transacci�n ha sido revertida.');
        RAISE; -- Propagar el error para que pueda ser manejado por el llamador
END adicionar_platos;
    
    PROCEDURE modificar_platos(
        p_id_plato IN VARCHAR2,
        p_columna IN VARCHAR2,
        p_nuevo_valor IN VARCHAR2   
    ) AS
    BEGIN
        IF p_columna = 'nombre' THEN
            UPDATE platos SET nombre = p_nuevo_valor WHERE id = p_id_plato;
        ELSIF p_columna = 'precio' THEN
            UPDATE platos SET precio = TO_NUMBER(p_nuevo_valor) WHERE id = p_id_plato;
        ELSIF p_columna = 'estado' THEN
            UPDATE platos SET estado = p_nuevo_valor WHERE id = p_id_plato;
        ELSE
            RAISE_APPLICATION_ERROR(-20002, 'Columna no v�lida');
        END IF;
        DBMS_OUTPUT.PUT_LINE(p_columna || ' modificado con �xito ');        
        COMMIT;
    EXCEPTION 
        WHEN OTHERS THEN
            ROLLBACK; -- Deshacer los cambios en caso de cualquier error
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error, la transacci�n ha sido revertida.');
            RAISE;        
    END modificar_platos;

    PROCEDURE eliminar_platos(
        p_id_plato IN VARCHAR2
    ) AS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM platos
        WHERE id = p_id_plato;

        -- Si no se encuentra ninguna fila con el ID proporcionado, lanzar una excepci�n
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'El ID del plato no existe en la base de datos.');
        END IF;
        
        UPDATE platos SET estado = 'no disponible' WHERE id = p_id_plato;
        DBMS_OUTPUT.PUT_LINE('El plato con id: ' || p_id_plato || ' eliminado con �xito.');
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            -- Manejar cualquier otra excepci�n que pueda ocurrir durante la ejecuci�n del procedimiento
            ROLLBACK; -- Revertir los cambios en caso de error
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error, la transacci�n ha sido revertida.');
            RAISE; -- Relanzar la excepci�n para que sea manejada en un nivel superior            
    END eliminar_platos;

    FUNCTION consultar_platos RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN 
        OPEN v_cursor FOR
            SELECT id, nombre, precio
            FROM platos;
        RETURN v_cursor;
    END consultar_platos;

    PROCEDURE print_consultar_platos
    AS
        v_plato_cursor SYS_REFCURSOR;
        v_id platos.id%TYPE;
        v_nombre platos.nombre%TYPE;
        v_precio platos.precio%TYPE;
    BEGIN
        v_plato_cursor := PK_PLATOS.consultar_platos;
        LOOP
            FETCH v_plato_cursor INTO v_id, v_nombre, v_precio;
            EXIT WHEN v_plato_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('id: ' || v_id || ' nombre: ' || v_nombre || ' precio: ' || v_precio);
        END LOOP;
        CLOSE v_plato_cursor;        
    END print_consultar_platos;
    
    PROCEDURE modificar_platos_fecha_caducidad_plato_platos_empresa(
        p_id_plato IN VARCHAR2,
        p_fecha_caducidad DATE
        ) AS
        v_count NUMBER;
    BEGIN 
        SELECT COUNT(*)
        INTO v_count
        FROM platos_empresas
        WHERE idplato = p_id_plato;
        
         -- Si no se encuentra ninguna fila con el ID proporcionado, lanzar una excepci�n
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'El ID del plato no existe en la base de datos.');
        END IF;
        
        UPDATE platos_empresas SET fechacaducidad =  p_fecha_caducidad WHERE idplato = p_id_plato;        
        DBMS_OUTPUT.PUT_LINE( 'La fechad de caducidad del plato con id: ' || p_id_plato || ' se ha modificado con �xito ');        
        COMMIT;
    EXCEPTION 
        WHEN OTHERS THEN
            ROLLBACK; -- Deshacer los cambios en caso de cualquier error
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error, la transacci�n ha sido revertida.');
            RAISE;
        END modificar_platos_fecha_caducidad_plato_platos_empresa;        
END PK_PLATOS;
/
------------ PK_MENUS_ALEATORIOS ------------

CREATE OR REPLACE PACKAGE PK_MENUS_ALEATORIOS AS
    PROCEDURE adicionar_menu_aleatorio(            
        p_nit_empresa IN CHAR,
        p_tipo IN VARCHAR2,
        p_precio IN NUMBER,
        p_nombre IN VARCHAR2
    );

    PROCEDURE modificar_menu_aleatorio(
        p_id IN VARCHAR2,
        p_columna IN VARCHAR2,
        p_nuevo_valor IN VARCHAR2
    );

    PROCEDURE eliminar_menu_aleatorio(
        p_id IN VARCHAR2
    );
    
    FUNCTION consultar_menus_aleatorios RETURN SYS_REFCURSOR;
    PROCEDURE print_consultar_menus_aleatorios;
    -------------------- menus_platos
    
    PROCEDURE adicionar_plato_a_menu_aleatorio(
        p_id_menu_aleatorio IN VARCHAR2,
        p_id_plato IN VARCHAR2
    );
    
    PROCEDURE eliminar__plato_a_menu_aleatorio(
        p_id_menu IN VARCHAR2,
        p_id_plato IN VARCHAR2
    );
    
    FUNCTION consultar_platos_de_menus_aleatorios RETURN SYS_REFCURSOR;
    PROCEDURE print_consultar_platos_de_menus_aleatorios;
END PK_MENUS_ALEATORIOS;
/

CREATE OR REPLACE PACKAGE BODY PK_MENUS_ALEATORIOS AS
    PROCEDURE adicionar_menu_aleatorio(            
    p_nit_empresa IN CHAR,
    p_tipo IN VARCHAR2,
    p_precio IN NUMBER,
    p_nombre IN VARCHAR2
    )
    AS
        v_estado_menu VARCHAR2(20);
    BEGIN
        -- Verificar si el men� ya existe y su estado
        SELECT estado INTO v_estado_menu 
        FROM menusAleatorios 
        WHERE nombre = p_nombre 
        AND nitEmpresa = p_nit_empresa;
                
        IF v_estado_menu = 'no disponible' THEN
            -- Si el men� existe y su estado es no disponible, actualizar el estado a disponible
            UPDATE menusAleatorios 
            SET estado = 'disponible', precio = p_precio, tipo = p_tipo
            WHERE nombre = p_nombre 
            AND nitEmpresa = p_nit_empresa;
            DBMS_OUTPUT.PUT_LINE('El men� "' || p_nombre || '" ha sido actualizado a estado disponible.');
        ELSIF v_estado_menu = 'disponible' THEN
            -- Si el men� existe y su estado es disponible, lanzar un error
            RAISE_APPLICATION_ERROR(-20001, 'El men� "' || p_nombre || '" ya existe y su estado es disponible.');
        END IF;
        
        COMMIT;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            -- Si no se encuentra ning�n men� con el nombre proporcionado, continuar con la inserci�n
            INSERT INTO menusAleatorios (nitEmpresa, tipo, precio, nombre, estado)
            VALUES (p_nit_empresa, p_tipo, p_precio, p_nombre, 'disponible');
            DBMS_OUTPUT.PUT_LINE('Se ha insertado un nuevo men� con nombre: ' || p_nombre || ' para la empresa con NIT: ' || p_nit_empresa);
                    
            COMMIT;        
        WHEN OTHERS THEN
            -- Deshacer los cambios en caso de cualquier error
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error, la transacci�n ha sido revertida.');
            RAISE; -- Propagar el error para que pueda ser manejado por el llamador
    END adicionar_menu_aleatorio;

    PROCEDURE modificar_menu_aleatorio(
        p_id IN VARCHAR2,
        p_columna IN VARCHAR2,
        p_nuevo_valor IN VARCHAR2
    ) AS
    BEGIN        
        IF p_columna = 'tipo' THEN
            UPDATE menusAleatorios SET tipo = p_nuevo_valor WHERE id = p_id;
        ELSIF p_columna = 'precio' THEN
            UPDATE menusAleatorios SET precio = TO_NUMBER(p_nuevo_valor) WHERE id = p_id;
        ELSIF p_columna = 'nombre' THEN
            UPDATE menusAleatorios SET nombre = p_nuevo_valor WHERE id = p_id;
        ELSIF p_columna = 'estado' THEN
            UPDATE menusAleatorios SET estado = p_nuevo_valor WHERE id = p_id;
        ELSE
            RAISE_APPLICATION_ERROR(-20002, 'Columna no v�lida');
        END IF;
        COMMIT;
    EXCEPTION 
        WHEN OTHERS THEN
            ROLLBACK; 
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error, la transacci�n ha sido revertida.');
            RAISE;        
    END modificar_menu_aleatorio;

    PROCEDURE eliminar_menu_aleatorio(
        p_id IN VARCHAR2
    ) AS
    v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM menusaleatorios
        WHERE id = p_id;
        
        -- Si no se encuentra ninguna fila con el ID proporcionado, lanzar una excepci�n
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'El ID del menu no existe en la base de datos.');
        END IF;
        
        UPDATE menusaleatorios SET estado = 'no disponible' WHERE id = p_id;
        DBMS_OUTPUT.PUT_LINE('El manualeatorio con id: ' || p_id || ' eliminado con �xito.');
        COMMIT;    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK; 
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error, la transacci�n ha sido revertida.');
            RAISE;           
    END eliminar_menu_aleatorio;

    FUNCTION consultar_menus_aleatorios RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN 
        OPEN v_cursor FOR
            SELECT * FROM menusAleatorios;
        RETURN v_cursor;
    END consultar_menus_aleatorios;

    PROCEDURE print_consultar_menus_aleatorios
    AS
        v_menu_cursor SYS_REFCURSOR;
        v_id menusAleatorios.id%TYPE;
        v_nit_empresa menusAleatorios.nitEmpresa%TYPE;
        v_tipo menusAleatorios.tipo%TYPE;
        v_precio menusAleatorios.precio%TYPE;
        v_nombre menusAleatorios.nombre%TYPE;
        v_estado menusAleatorios.estado%TYPE;
    BEGIN
        v_menu_cursor := PK_MENUS_ALEATORIOS.consultar_menus_aleatorios;
        LOOP
            FETCH v_menu_cursor INTO v_id, v_nit_empresa, v_tipo, v_precio, v_nombre,v_estado;
            EXIT WHEN v_menu_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('id: ' || v_id || ', nitEmpresa: ' || v_nit_empresa || ', tipo: ' || v_tipo || ', precio: ' || v_precio || ', nombre: ' || v_nombre || ', estado: ' || v_estado);
        END LOOP;
        CLOSE v_menu_cursor;        
    END print_consultar_menus_aleatorios;
    
    PROCEDURE adicionar_plato_a_menu_aleatorio(
        p_id_menu_aleatorio IN VARCHAR2,
        p_id_plato IN VARCHAR2
    )
    AS
        v_estado_menu VARCHAR2(20);
        v_tipo_menu   VARCHAR2(1);
        v_nombre_menu VARCHAR2(50);
        v_precio_plato NUMBER(8);
        v_nombre_plato VARCHAR2(50);
    BEGIN
        -- Verificar si el men� ya existe y su estado        
        SELECT estado, tipo, nombre INTO v_estado_menu, v_tipo_menu, v_nombre_menu
        FROM menusAleatorios 
        WHERE id = p_id_menu_aleatorio;
            
        SELECT precio, nombre INTO v_precio_plato, v_nombre_plato
        FROM platos
        WHERE id = p_id_plato;
            
        IF v_estado_menu = 'no disponible' THEN
                RAISE_APPLICATION_ERROR(-20002, 'El menu no se encuentra disponible, esto es por que ha sido borrado del sistema.');
 
        ELSIF v_estado_menu = 'disponible' THEN
                IF (v_tipo_menu = 'E' AND (v_precio_plato < 1 OR v_precio_plato > 50)) THEN                               
                    RAISE_APPLICATION_ERROR(-20002, 'El plato: ' || v_nombre_plato ||' con precio: $' || v_precio_plato ||' no cumple con las restricciones del tipo de men� Estandar, del menu: ' || v_nombre_menu || ', precio debe ser mayor a $1 y menor a $50');
                ELSIF (v_tipo_menu = 'P' AND v_precio_plato < 50) THEN
                    RAISE_APPLICATION_ERROR(-20002, 'El plato: ' || v_nombre_plato ||' con precio: $' || v_precio_plato ||' no cumple con las restricciones del tipo de men� Premium, del menu: ' || v_nombre_menu || ', el precio del plato debe ser mayor a $50');
                END IF;
        END IF;
        INSERT INTO menus_platos (idMenuAleatorio, idPlato)
        VALUES (p_id_menu_aleatorio, p_id_plato);
        DBMS_OUTPUT.PUT_LINE('El plato: ' || v_nombre_plato ||' con precio: $' || v_precio_plato ||' se ha a�adido con �xito al menu: ' || v_nombre_menu || ', con tipo de menu: ' || v_tipo_menu);
        COMMIT;
    EXCEPTION 
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error al agregar el plato al men�.');
            RAISE;
    END adicionar_plato_a_menu_aleatorio;

    PROCEDURE eliminar__plato_a_menu_aleatorio(
        p_id_menu IN VARCHAR2,
        p_id_plato IN VARCHAR2
    )
    AS
    BEGIN
        DELETE FROM menus_platos WHERE idMenuAleatorio = p_id_menu AND idPlato = p_id_plato;
        COMMIT;
    EXCEPTION 
        WHEN OTHERS THEN
            ROLLBACK; 
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error, la transacci�n ha sido revertida.');
            RAISE; 
    END eliminar__plato_a_menu_aleatorio;

    FUNCTION consultar_platos_de_menus_aleatorios RETURN SYS_REFCURSOR
    AS
        v_cursor SYS_REFCURSOR;
    BEGIN 
        OPEN v_cursor FOR
            SELECT * FROM menus_platos;
        RETURN v_cursor;
    END consultar_platos_de_menus_aleatorios;  
    
    
    PROCEDURE print_consultar_platos_de_menus_aleatorios
    AS
        v_plato_cursor SYS_REFCURSOR;
        v_id_menu_aleatorio menus_platos.idmenualeatorio%TYPE;        
        v_id_plato menus_platos.idplato%TYPE;
    BEGIN
        v_plato_cursor := PK_MENUS_ALEATORIOS.consultar_platos_de_menus_aleatorios;
        LOOP
            FETCH v_plato_cursor INTO v_id_plato, v_id_menu_aleatorio;
            EXIT WHEN v_plato_cursor%NOTFOUND;            
            -- Imprimir detalles del plato
            DBMS_OUTPUT.PUT_LINE('id_menu_aleatorio: ' || v_id_menu_aleatorio || ', id: ' || v_id_plato);
        END LOOP;
        CLOSE v_plato_cursor;        
    END print_consultar_platos_de_menus_aleatorios;
END PK_MENUS_ALEATORIOS;
/

------------ PK_TIPOS_BONO ------------
CREATE OR REPLACE PACKAGE PK_TIPOS_BONO AS
    PROCEDURE adicionar_tipo_bono(
        p_descripcion IN VARCHAR2,
        p_nombre_bono IN VARCHAR2,
        p_nit_empresa IN CHAR,
        p_porcentaje_descuento IN NUMBER,
        p_estado IN VARCHAR2,
        p_fecha_expiracion IN DATE
    );

    PROCEDURE modificar_tipo_bono(
        p_id_tipo_bono IN VARCHAR2,
        p_columna IN VARCHAR2,
        p_nuevo_valor IN VARCHAR2
    );

    PROCEDURE eliminar_tipo_bono(
        p_id_tipo_bono IN VARCHAR2
    );

    FUNCTION consultar_tipos_bonos RETURN SYS_REFCURSOR;
    PROCEDURE print_consultar_tipos_bonos;

END PK_TIPOS_BONO;
/

CREATE OR REPLACE PACKAGE BODY PK_TIPOS_BONO AS
    PROCEDURE adicionar_tipo_bono(
        p_descripcion IN VARCHAR2,
        p_nombre_bono IN VARCHAR2,
        p_nit_empresa IN CHAR,
        p_porcentaje_descuento IN NUMBER,
        p_estado IN VARCHAR2,
        p_fecha_expiracion IN DATE
    )
    AS
    BEGIN
        INSERT INTO tiposBono (descripcion, nombreBono, nitEmpresa, porcentajeDescuento, estado, fechaExpiracion)
        VALUES (p_descripcion, p_nombre_bono, p_nit_empresa, p_porcentaje_descuento, p_estado, p_fecha_expiracion);
        COMMIT;
    EXCEPTION 
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error al agregar el tipo de bono.');
            RAISE;
    END adicionar_tipo_bono;

    PROCEDURE modificar_tipo_bono(
    p_id_tipo_bono IN VARCHAR2,
    p_columna IN VARCHAR2,
    p_nuevo_valor IN VARCHAR2
    )
    AS
    BEGIN
        IF p_columna = 'descripcion' THEN
            UPDATE tiposBono SET descripcion = p_nuevo_valor WHERE id = p_id_tipo_bono;
        ELSIF p_columna = 'nombre_bono' THEN
            UPDATE tiposBono SET nombreBono = p_nuevo_valor WHERE id = p_id_tipo_bono;        
        ELSIF p_columna = 'porcentaje_descuento' THEN
            UPDATE tiposBono SET porcentajeDescuento = TO_NUMBER(p_nuevo_valor) WHERE id = p_id_tipo_bono;
        ELSIF p_columna = 'estado' THEN
            UPDATE tiposBono SET estado = p_nuevo_valor WHERE id = p_id_tipo_bono;
        ELSIF p_columna = 'fecha_expiracion' THEN
            UPDATE tiposBono SET fechaExpiracion = TO_DATE(p_nuevo_valor, 'YYYY-MM-DD') WHERE id = p_id_tipo_bono;
        ELSE
            RAISE_APPLICATION_ERROR(-20002, 'Columna no v�lida');
        END IF;
        COMMIT;
    EXCEPTION 
        WHEN OTHERS THEN
            ROLLBACK; 
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error, la transacci�n ha sido revertida.');
            RAISE;        
    END modificar_tipo_bono;

    PROCEDURE eliminar_tipo_bono(
    p_id_tipo_bono IN VARCHAR2
    )
    AS
        v_count NUMBER;
    BEGIN
        -- Verificar si existe el tipo de bono con el ID proporcionado
        SELECT COUNT(*)
        INTO v_count
        FROM tiposBono
        WHERE id = p_id_tipo_bono;
        
        -- Si no se encuentra ninguna fila con el ID proporcionado, lanzar una excepci�n
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'El ID del tipo de bono no existe en la base de datos.');
        END IF;
        
        UPDATE tiposBono SET estado = 'no activo' WHERE id = p_id_tipo_bono;
        
        DBMS_OUTPUT.PUT_LINE('El tipo de bono con ID: ' || p_id_tipo_bono || ' ha sido eliminado con �xito.');
        COMMIT;    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK; 
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error, la transacci�n ha sido revertida.');
            RAISE;           
    END eliminar_tipo_bono;
    
    FUNCTION consultar_tipos_bonos RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN 
        OPEN v_cursor FOR
            SELECT id, descripcion, nombreBono, nitEmpresa, porcentajeDescuento, estado, fechaExpiracion FROM tiposBono;
        RETURN v_cursor;
    END consultar_tipos_bonos;

    PROCEDURE print_consultar_tipos_bonos
    AS
        v_tipo_bono_cursor SYS_REFCURSOR;
        v_id tiposBono.id%TYPE;
        v_descripcion tiposBono.descripcion%TYPE;
        v_nombre_bono tiposBono.nombreBono%TYPE;
        v_nit_empresa tiposBono.nitEmpresa%TYPE;
        v_porcentaje_descuento tiposBono.porcentajeDescuento%TYPE;
        v_estado tiposBono.estado%TYPE;
        v_fecha_expiracion tiposBono.fechaExpiracion%TYPE;
    BEGIN
        v_tipo_bono_cursor := PK_TIPOS_BONO.consultar_tipos_bonos;
        LOOP
            FETCH v_tipo_bono_cursor INTO v_id, v_descripcion, v_nombre_bono, v_nit_empresa, v_porcentaje_descuento, v_estado, v_fecha_expiracion;
            EXIT WHEN v_tipo_bono_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('ID: ' || v_id || ', Descripci�n: ' || v_descripcion || ', Nombre Bono: ' || v_nombre_bono || ', Nit Empresa: ' || v_nit_empresa || ', Porcentaje Descuento: ' || v_porcentaje_descuento || ', Estado: ' || v_estado || ', Fecha Expiraci�n: ' || v_fecha_expiracion);
        END LOOP;
        CLOSE v_tipo_bono_cursor;
    END print_consultar_tipos_bonos;
END PK_TIPOS_BONO;
/

------------ PK_BONOS_DELIZIA ------------

CREATE OR REPLACE PACKAGE PK_bonos_delizia AS
    PROCEDURE registrar_bono(
        p_id_consumidor IN CHAR,
        p_id_tipo_bono IN VARCHAR2
    );

    PROCEDURE modificar_bono(
        p_id_bono IN VARCHAR2,
        p_columna IN VARCHAR2,
        p_nuevo_valor IN VARCHAR2
    );

    PROCEDURE eliminar_bono(
        p_id_bono IN VARCHAR2
    );

    FUNCTION consultar_bonos_delizia RETURN SYS_REFCURSOR;
    PROCEDURE print_consultar_bonos_delizia;

END PK_bonos_delizia;
/

CREATE OR REPLACE PACKAGE BODY PK_bonos_delizia AS
    PROCEDURE registrar_bono(        
        p_id_consumidor IN CHAR,
        p_id_tipo_bono IN VARCHAR2
    )
    AS
    BEGIN
        INSERT INTO bonos_delizia (idConsumidor, idTipoBono)
        VALUES (p_id_consumidor, p_id_tipo_bono);
        COMMIT;
    EXCEPTION 
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error al agregar el bono.');
            RAISE;
    END registrar_bono;

    PROCEDURE modificar_bono(
        p_id_bono IN VARCHAR2,
        p_columna IN VARCHAR2,
        p_nuevo_valor IN VARCHAR2
    )
    AS
    BEGIN
        IF p_columna = 'idConsumidor' THEN
            UPDATE bonos_delizia SET idConsumidor = p_nuevo_valor WHERE id = p_id_bono;
        ELSIF p_columna = 'idTipoBono' THEN
            UPDATE bonos_delizia SET idTipoBono = p_nuevo_valor WHERE id = p_id_bono;
        ELSE
            RAISE_APPLICATION_ERROR(-20002, 'Columna no v�lida');
        END IF;
        COMMIT;
    EXCEPTION 
        WHEN OTHERS THEN
            ROLLBACK; 
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error al modificar el bono.');
            RAISE;        
    END modificar_bono;

    PROCEDURE eliminar_bono(
        p_id_bono IN VARCHAR2
    )
    AS
        v_count NUMBER;
    BEGIN
        -- Verificar si existe el bono con el ID proporcionado
        SELECT COUNT(*)
        INTO v_count
        FROM bonos_delizia
        WHERE id = p_id_bono;
        
        -- Si no se encuentra ninguna fila con el ID proporcionado, lanzar una excepci�n
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'El ID del bono no existe en la base de datos.');
        END IF;
        
        DELETE FROM bonos_delizia WHERE id = p_id_bono;
        DBMS_OUTPUT.PUT_LINE('El bono con ID: ' || p_id_bono || ' ha sido eliminado con �xito.');
        COMMIT;    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK; 
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error al eliminar el bono.');
            RAISE;           
    END eliminar_bono;
    
    FUNCTION consultar_bonos_delizia RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN 
        OPEN v_cursor FOR
            SELECT * FROM bonos_delizia;
        RETURN v_cursor;
    END consultar_bonos_delizia;

    PROCEDURE print_consultar_bonos_delizia
    AS
        v_bono_cursor SYS_REFCURSOR;
        v_id bonos_delizia.id%TYPE;
        v_id_consumidor bonos_delizia.idConsumidor%TYPE;
        v_id_tipo_bono bonos_delizia.idTipoBono%TYPE;
    BEGIN
        v_bono_cursor := PK_bonos_delizia.consultar_bonos_delizia;
        LOOP
            FETCH v_bono_cursor INTO v_id, v_id_consumidor, v_id_tipo_bono;
            EXIT WHEN v_bono_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('ID: ' || v_id || ', ID Consumidor: ' || v_id_consumidor || ', ID Tipo Bono: ' || v_id_tipo_bono);
        END LOOP;
        CLOSE v_bono_cursor;
    END print_consultar_bonos_delizia;
END PK_bonos_delizia;
/

------------ PK_DONACIONES ------------

CREATE OR REPLACE PACKAGE PK_DONACIONES AS
    PROCEDURE registrar_donacion(        
        p_fecha IN DATE,
        p_cantidad IN NUMBER,
        p_tipo IN VARCHAR2,
        p_nit_empresa IN CHAR
    );

    PROCEDURE modificar_donacion(
        p_id_donacion IN VARCHAR2,
        p_columna IN VARCHAR2,
        p_nuevo_valor IN VARCHAR2
    );

    PROCEDURE eliminar_donacion(
        p_id_donacion IN VARCHAR2
    );

    FUNCTION consultar_donaciones RETURN SYS_REFCURSOR;
    PROCEDURE print_consultar_donaciones;

END PK_DONACIONES;
/

CREATE OR REPLACE PACKAGE BODY PK_DONACIONES AS
    PROCEDURE registrar_donacion(        
        p_fecha IN DATE,
        p_cantidad IN NUMBER,
        p_tipo IN VARCHAR2,
        p_nit_empresa IN CHAR
    )
    AS
    BEGIN
        INSERT INTO donaciones (fecha, cantidad, tipo, nit_empresa)
        VALUES (p_fecha, p_cantidad, p_tipo, p_nit_empresa);
        COMMIT;
    EXCEPTION 
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error al agregar la donaci�n.');
            RAISE;
    END registrar_donacion;

    PROCEDURE modificar_donacion(
        p_id_donacion IN VARCHAR2,
        p_columna IN VARCHAR2,
        p_nuevo_valor IN VARCHAR2
    )
    AS
    BEGIN
        IF p_columna = 'fecha' THEN
            UPDATE donaciones SET fecha = TO_DATE(p_nuevo_valor, 'YYYY-MM-DD') WHERE id = p_id_donacion;
        ELSIF p_columna = 'cantidad' THEN
            UPDATE donaciones SET cantidad = TO_NUMBER(p_nuevo_valor) WHERE id = p_id_donacion;
        ELSIF p_columna = 'tipo' THEN
            UPDATE donaciones SET tipo = p_nuevo_valor WHERE id = p_id_donacion;        
        ELSE
            RAISE_APPLICATION_ERROR(-20002, 'Columna no v�lida');
        END IF;
        COMMIT;
    EXCEPTION 
        WHEN OTHERS THEN
            ROLLBACK; 
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error al modificar la donaci�n.');
            RAISE;        
    END modificar_donacion;

    PROCEDURE eliminar_donacion(
        p_id_donacion IN VARCHAR2
    )
    AS
        v_count NUMBER;
    BEGIN
        -- Verificar si existe la donaci�n con el ID proporcionado
        SELECT COUNT(*)
        INTO v_count
        FROM donaciones
        WHERE id = p_id_donacion;
        
        -- Si no se encuentra ninguna fila con el ID proporcionado, lanzar una excepci�n
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'El ID de la donaci�n no existe en la base de datos.');
        END IF;
        
        DELETE FROM donaciones WHERE id = p_id_donacion;
        DBMS_OUTPUT.PUT_LINE('La donaci�n con ID: ' || p_id_donacion || ' ha sido eliminada con �xito.');
        COMMIT;    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK; 
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error al eliminar la donaci�n.');
            RAISE;           
    END eliminar_donacion;
    
    FUNCTION consultar_donaciones RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN 
        OPEN v_cursor FOR
            SELECT * FROM donaciones;
        RETURN v_cursor;
    END consultar_donaciones;

    PROCEDURE print_consultar_donaciones
    AS
        v_donacion_cursor SYS_REFCURSOR;
        v_id donaciones.id%TYPE;
        v_fecha donaciones.fecha%TYPE;
        v_cantidad donaciones.cantidad%TYPE;
        v_tipo donaciones.tipo%TYPE;
        v_nit_empresa donaciones.nit_empresa%TYPE;
    BEGIN
        v_donacion_cursor := PK_DONACIONES.consultar_donaciones;
        LOOP
            FETCH v_donacion_cursor INTO v_id, v_fecha, v_cantidad, v_tipo, v_nit_empresa;
            EXIT WHEN v_donacion_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('ID: ' || v_id || ', Fecha: ' || v_fecha || ', Cantidad: ' || v_cantidad || ', Tipo: ' || v_tipo || ', NIT Empresa: ' || v_nit_empresa);
        END LOOP;
        CLOSE v_donacion_cursor;
    END print_consultar_donaciones;
END PK_DONACIONES;
/

------------ PK_CARRITOS_COMPRAS ------------
CREATE OR REPLACE PACKAGE PK_CARRITOS_COMPRAS AS
    PROCEDURE registrar_carrito(        
        p_id_consumidor IN CHAR
    );

    PROCEDURE modificar_carrito(
        p_id_carrito IN VARCHAR2,
        p_columna IN VARCHAR2,
        p_nuevo_valor IN VARCHAR2
    );

	/* NO SE PUEDEN ELIMINAR CARRITOS
    PROCEDURE eliminar_carrito(
        p_id_carrito IN VARCHAR2
    );
	*/
    FUNCTION consultar_carritos RETURN SYS_REFCURSOR;
    PROCEDURE print_consultar_carritos;
    
    -- carritos menus
    PROCEDURE registrar_menu_a_carrito(
		p_id_carrito IN VARCHAR2,
		p_id_menu IN VARCHAR2,				
		p_nit_empresa IN CHAR
	);
		
    PROCEDURE eliminar_menu_de_carrito(
			p_id IN VARCHAR2
	);
			
    PROCEDURE vaciar_carrito(
			p_id_carrito IN VARCHAR2
	);
	
    FUNCTION consultar_menus_en_carritos RETURN SYS_REFCURSOR;
    PROCEDURE printconsultar_menus_en_carritos;
    

END PK_CARRITOS_COMPRAS;
/

CREATE OR REPLACE PACKAGE BODY PK_CARRITOS_COMPRAS AS
    PROCEDURE registrar_carrito(        
        p_id_consumidor IN CHAR
    )
    AS        
    BEGIN
        INSERT INTO carritosCompras (idConsumidor)
        VALUES (p_id_consumidor);                        
        COMMIT;
    EXCEPTION         
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error al agregar el carrito de compras.');
            RAISE;
    END registrar_carrito;

    PROCEDURE modificar_carrito(
        p_id_carrito IN VARCHAR2,
        p_columna IN VARCHAR2,
        p_nuevo_valor IN VARCHAR2
    )
    AS
    BEGIN
        IF p_columna = 'idConsumidor' THEN
            UPDATE carritosCompras SET idConsumidor = p_nuevo_valor WHERE id = p_id_carrito;
        ELSE
            RAISE_APPLICATION_ERROR(-20002, 'Columna no v�lida');
        END IF;
        COMMIT;
    EXCEPTION 
        WHEN OTHERS THEN
            ROLLBACK; 
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error al modificar el carrito de compras.');
            RAISE;        
    END modificar_carrito;

	/*
	-- NO SE PUEDEN ELIMINAR CARRITOS
    PROCEDURE eliminar_carrito(
        p_id_carrito IN VARCHAR2
    )
    AS
        v_count NUMBER;
    BEGIN
        -- Verificar si existe el carrito de compras con el ID proporcionado
        SELECT COUNT(*)
        INTO v_count
        FROM carritosCompras
        WHERE id = p_id_carrito;
        
        -- Si no se encuentra ninguna fila con el ID proporcionado, lanzar una excepci�n
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'El ID del carrito de compras no existe en la base de datos.');
        END IF;
        
        DELETE FROM carritosCompras WHERE id = p_id_carrito;
        DBMS_OUTPUT.PUT_LINE('El carrito de compras con ID: ' || p_id_carrito || ' ha sido eliminado con �xito.');
        COMMIT;    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK; 
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error al eliminar el carrito de compras.');
            RAISE;           
    END eliminar_carrito;
	*/
    
    PROCEDURE vaciar_carrito(
			p_id_carrito IN VARCHAR2
	)
    AS
        v_count NUMBER;
    BEGIN
        -- Verificar si existe el carrito de compras con el ID proporcionado
        SELECT COUNT(*)
        INTO v_count
        FROM carritosmenus        
        WHERE idcarrito = p_id_carrito;
        
        -- Si no se encuentra ninguna fila con el ID proporcionado, lanzar una excepci�n
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'El ID del carrito de compras no existe en la base de datos.');
        END IF;
        
        DELETE FROM carritosmenus WHERE idcarrito = p_id_carrito;
        DBMS_OUTPUT.PUT_LINE('El carrito de compras con ID: ' || p_id_carrito || ' ha sido vaciado con �xito');
        COMMIT;    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK; 
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error al eliminar el carrito de compras.');
            RAISE;
    END vaciar_carrito;
    
    FUNCTION consultar_carritos RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN 
        OPEN v_cursor FOR
            SELECT * FROM carritosCompras;
        RETURN v_cursor;
    END consultar_carritos;

    PROCEDURE print_consultar_carritos
    AS
        v_carrito_cursor SYS_REFCURSOR;
        v_id carritosCompras.id%TYPE;
        v_id_consumidor carritosCompras.idConsumidor%TYPE;
    BEGIN
        v_carrito_cursor := PK_CARRITOS_COMPRAS.consultar_carritos;
        LOOP
            FETCH v_carrito_cursor INTO v_id, v_id_consumidor;
            EXIT WHEN v_carrito_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('ID: ' || v_id || ', ID Consumidor: ' || v_id_consumidor);
        END LOOP;
        CLOSE v_carrito_cursor;
    END print_consultar_carritos;
    
    -- CARRITOS MENUS
    PROCEDURE registrar_menu_a_carrito(
		p_id_carrito IN VARCHAR2,
		p_id_menu IN VARCHAR2,				
		p_nit_empresa IN CHAR
	)
    AS
        v_precio_minimo platos.precio%TYPE;
        v_precio_maximo platos.precio%TYPE;
    BEGIN
        -- Obtener el precio m�nimo y m�ximo del men� aleatorio
        SELECT MIN(platos.precio), MAX(platos.precio)
        INTO v_precio_minimo, v_precio_maximo
        FROM menusAleatorios
        JOIN menus_platos ON menusAleatorios.id = menus_platos.idMenuAleatorio
        JOIN platos ON platos.id = menus_platos.idPlato
        WHERE menusAleatorios.id = p_id_menu;
        
        -- Verificar si se encontraron datos
        IF v_precio_minimo IS NULL OR v_precio_maximo IS NULL THEN
            DBMS_OUTPUT.PUT_LINE('Lo sentimos pero parece que el menu aleatorio: ' || p_id_menu ||' no tiene platos, lo invitamos a que seleccione otro menu con platos' || p_id_menu);
            RETURN;
        END IF;

        -- Imprimir el precio m�nimo y m�ximo en la consola
        DBMS_OUTPUT.PUT_LINE('Precio m�nimo para el men�: ' || v_precio_minimo);
        DBMS_OUTPUT.PUT_LINE('Precio m�ximo para el men�: ' || v_precio_maximo);

        -- Insertar en carritosMenus
        INSERT INTO carritosMenus (idCarrito, idMenu, nit_empresa)
        VALUES (p_id_carrito, p_id_menu, p_nit_empresa);
        COMMIT;
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No se encontraron datos para el men� con ID: ' ||p_id_carrito);
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error al agregar el men� al carrito.');
            RAISE;
    END registrar_menu_a_carrito;

    PROCEDURE eliminar_menu_de_carrito(p_id IN VARCHAR2)
    AS
		v_count NUMBER;
    BEGIN
		SELECT COUNT(*)
        INTO v_count
        FROM carritosmenus        
        WHERE id = p_id;
        
        -- Si no se encuentra ninguna fila con el ID proporcionado, lanzar una excepci�n
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'El menu no esta en el carrito');
        END IF;
		
        DELETE FROM carritosMenus WHERE id = p_id;
        COMMIT;
    EXCEPTION 
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error al eliminar el men� del carrito.');
            RAISE;
    END eliminar_menu_de_carrito;

    FUNCTION consultar_menus_en_carritos RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN 
        OPEN v_cursor FOR
            SELECT * FROM carritosMenus;
        RETURN v_cursor;
    END consultar_menus_en_carritos;

    PROCEDURE printconsultar_menus_en_carritos
    AS
        v_carrito_menu_cursor SYS_REFCURSOR;
        v_id_carrito carritosMenus.idCarrito%TYPE;
        v_id_menu carritosMenus.idMenu%TYPE;        
        v_id carritosMenus.id%TYPE;
        v_id_plato_aleatorio_seleccionado carritosMenus.id_plato_aleatorio_seleccionado%TYPE;
        v_nit_empresa carritosMenus.nit_empresa%TYPE;
    BEGIN
        v_carrito_menu_cursor := PK_CARRITOS_COMPRAS.consultar_menus_en_carritos;
        LOOP
            FETCH v_carrito_menu_cursor INTO v_id_carrito, v_id_menu, v_id, v_id_plato_aleatorio_seleccionado, v_nit_empresa;
            EXIT WHEN v_carrito_menu_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('ID Carrito: ' || v_id_carrito || ', ID Men�: ' || v_id_menu || ', ID: ' || v_id || ', ID Plato Aleatorio Seleccionado: ' || v_id_plato_aleatorio_seleccionado || ', Nit Empresa: ' || v_nit_empresa);
        END LOOP;
        CLOSE v_carrito_menu_cursor;
    END printconsultar_menus_en_carritos;    
END PK_CARRITOS_COMPRAS;
/

------------------ PK_PEDIDOS -------------------------

CREATE OR REPLACE PACKAGE pk_pedidos AS
    PROCEDURE registrar_pedido(
        p_id_consumidor IN CHAR,        
        p_id_carrito_compras IN VARCHAR,
        p_envio IN NUMBER
    );

    PROCEDURE modificar_pedido(
        p_id_pedido IN VARCHAR2,
        p_columna IN VARCHAR2,
        p_nuevo_valor IN VARCHAR2
    );
    /*
    PROCEDURE eliminar_pedido(
        id_pedido IN VARCHAR2
    );
    */
    FUNCTION consultar_pedidos RETURN SYS_REFCURSOR;

    PROCEDURE print_consultar_pedidos;
    
    -- modulo - ENVIOS   
END pk_pedidos;
/

CREATE OR REPLACE PACKAGE BODY pk_pedidos AS
    PROCEDURE registrar_pedido(        
        p_id_consumidor IN CHAR,        
        p_id_carrito_compras IN VARCHAR,
        p_envio IN NUMBER
    )
    AS
    BEGIN        
        INSERT INTO pedidos (idconsumidor, estado, idcarritocompras, envio)
        VALUES (p_id_consumidor, 'A', p_id_carrito_compras, p_envio);        
        DBMS_OUTPUT.PUT_LINE('El pedido se ha registrado con exito');
        COMMIT;            
    EXCEPTION 
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error al agregar el pedido.');
            RAISE;
    END registrar_pedido;

    PROCEDURE modificar_pedido(
        p_id_pedido IN VARCHAR2,
        p_columna IN VARCHAR2,
        p_nuevo_valor IN VARCHAR2
    )
    AS
    BEGIN
        IF p_columna = 'estado' THEN
            UPDATE pedidos SET estado = p_nuevo_valor WHERE id = p_id_pedido;
        ELSIF p_columna = 'envio' THEN
        UPDATE pedidos SET envio = TO_NUMBER(p_nuevo_valor) WHERE id = p_id_pedido;
        ELSE
        RAISE_APPLICATION_ERROR(-20002, 'Columna no v�lida');
        END IF;
        DBMS_OUTPUT.PUT_LINE('El estado del pedido se ha modificado con exito a: ' || p_nuevo_valor);
        COMMIT;
    EXCEPTION 
        WHEN OTHERS THEN
            ROLLBACK; 
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error al modificar el pedido.');
            RAISE;
    END modificar_pedido;

    /*
    PROCEDURE eliminar_pedido(
        id_pedido IN VARCHAR2
    )
    AS
    BEGIN
        DELETE FROM pedidos WHERE id = id_pedido;
        COMMIT;
    EXCEPTION 
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error al eliminar el pedido.');
            RAISE;
    END eliminar_pedido;
    */
    FUNCTION consultar_pedidos RETURN SYS_REFCURSOR 
    AS
        v_cursor SYS_REFCURSOR;
    BEGIN 
        OPEN v_cursor FOR
            SELECT * FROM pedidos;
        RETURN v_cursor;
    END consultar_pedidos;

    PROCEDURE print_consultar_pedidos
    AS
        v_pedido_cursor SYS_REFCURSOR;
        v_id pedidos.id%TYPE;
        v_id_consumidor pedidos.idconsumidor%TYPE;
        v_estado pedidos.estado%TYPE;
        v_id_carrito_compras pedidos.idcarritocompras%TYPE;
        v_envio pedidos.envio%TYPE;
    BEGIN
        v_pedido_cursor := pk_pedidos.consultar_pedidos;
        LOOP
            FETCH v_pedido_cursor INTO v_id, v_id_consumidor, v_estado, v_id_carrito_compras, v_envio;
            EXIT WHEN v_pedido_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('ID Pedido: ' || v_id || ', ID Consumidor: ' || v_id_consumidor || ', Estado: ' || v_estado || ', ID Carrito Compras: ' || v_id_carrito_compras || ', Env�o: ' || v_envio);
        END LOOP;
        CLOSE v_pedido_cursor;
    END print_consultar_pedidos;
    
    -- MODULO ENVIOS--   
END pk_pedidos;
/
    
------------- PK_ENV�OS ---------------
CREATE OR REPLACE PACKAGE pk_envios AS
         PROCEDURE adicionar_envio(
        p_id_pedido IN VARCHAR2
    );

    PROCEDURE modificar_envio(
        p_id_envio IN VARCHAR2,
        p_columna IN VARCHAR2,
        p_nuevo_valor IN VARCHAR2
    );

    FUNCTION consultar_envios RETURN SYS_REFCURSOR;

    PROCEDURE print_consultar_envios;

END pk_envios;
/

CREATE OR REPLACE PACKAGE BODY pk_envios AS
  PROCEDURE adicionar_envio(        
         p_id_pedido IN VARCHAR2
    )
    AS
        v_id_domiciliario VARCHAR2(10);
        v_nombre_domiciliario VARCHAR(50);
        v_tiene_envio NUMBER(1);

    BEGIN
        SELECT envio INTO v_tiene_envio
        FROM pedidos WHERE id = p_id_pedido;
        
       IF v_tiene_envio = 1 THEN
         -- seleccionar el id domiciliario asignado al envio de forma aleatorioa -  no tenemos parametros como ruta optima para determinar el mejor domiciliario    
            SELECT id, nombre
            INTO v_id_domiciliario, v_nombre_domiciliario
            FROM (
                SELECT id, nombre, ROW_NUMBER() OVER (ORDER BY DBMS_RANDOM.VALUE) AS rn
                FROM domiciliarios
            )
            WHERE rn = 1;
    
            INSERT INTO envios (fecha, fechaentrega, estado, iddomiciliario, costo, idpedido)
            VALUES (SYSDATE, SYSDATE + 3, 'C', v_id_domiciliario, 5, p_id_pedido);
            DBMS_OUTPUT.PUT_LINE('El envio ha sido asignado al domiciliario: ' || v_nombre_domiciliario);
        ELSE 
            DBMS_OUTPUT.PUT_LINE('El pedido ' || p_id_pedido || ' no se ha especificado para tener envio, primero asigne el pedido con envio y luego a�ada un envio al pedido.' );    
        END IF;
        COMMIT;
    EXCEPTION 
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error al agregar el env�o.');
            RAISE;
    END adicionar_envio;

    PROCEDURE modificar_envio(
        p_id_envio IN VARCHAR2,
        p_columna IN VARCHAR2,
        p_nuevo_valor IN VARCHAR2
    )
    AS
    BEGIN
        IF p_columna = 'estado' THEN
            UPDATE envios SET estado = p_nuevo_valor WHERE id = p_id_envio;
        ELSIF p_columna = 'iddomiciliario' THEN
            UPDATE envios SET iddomiciliario = p_nuevo_valor WHERE id = p_id_envio;
        ELSIF p_columna = 'costo' THEN
            UPDATE envios SET costo = TO_NUMBER(p_nuevo_valor) WHERE id = p_id_envio;
        ELSIF p_columna = 'fechaentrega' THEN
            UPDATE envios SET fechaentrega = TO_DATE(p_nuevo_valor, 'YYYY-MM-DD') WHERE id = p_id_envio;
        ELSE
            RAISE_APPLICATION_ERROR(-20002, 'Columna no v�lida');
        END IF;
        COMMIT;
    EXCEPTION 
        WHEN OTHERS THEN
            ROLLBACK; 
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error al modificar el env�o.');
            RAISE;        
    END modificar_envio;

    FUNCTION consultar_envios RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN 
        OPEN v_cursor FOR
            SELECT * FROM envios;
        RETURN v_cursor;
    END consultar_envios;

    PROCEDURE print_consultar_envios
    AS
        v_envio_cursor SYS_REFCURSOR;
        v_id envios.id%TYPE;
        v_fecha envios.fecha%TYPE;
        v_fecha_entrega envios.fechaentrega%TYPE;
        v_estado envios.estado%TYPE;
        v_id_domiciliario envios.iddomiciliario%TYPE;
        v_costo envios.costo%TYPE;
        v_id_pedido envios.idpedido%TYPE;
    BEGIN
        v_envio_cursor := pk_envios.consultar_envios;
        LOOP
            FETCH v_envio_cursor INTO v_id, v_fecha, v_fecha_entrega, v_estado, v_id_domiciliario, v_costo, v_id_pedido;
            EXIT WHEN v_envio_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('ID Env�o: ' || v_id || ', Fecha: ' || v_fecha || ', Fecha de Entrega: ' || v_fecha_entrega || ', Estado: ' || v_estado || ', ID Domiciliario: ' || v_id_domiciliario || ', Costo: ' || v_costo || ', ID Pedido: ' || v_id_pedido);
        END LOOP;
        CLOSE v_envio_cursor;
    END print_consultar_envios;
END pk_envios;
/


-------------- PK_FACTURAS -----------
create or replace PACKAGE PK_FACTURAS AS
    PROCEDURE adicionarFactura(        
        p_id_consumidor IN CHAR,                
        p_id_bono IN VARCHAR2,
        p_id_pedido IN VARCHAR2
    );

    FUNCTION consultarFacturas RETURN SYS_REFCURSOR;

    PROCEDURE printConsultarFacturas;

    FUNCTION consultarBonos(p_id_consumidor IN CHAR) RETURN SYS_REFCURSOR;
    PROCEDURE print_consultar_bonos(p_id_consumidor IN CHAR);

END PK_FACTURAS;
/
create or replace PACKAGE BODY PK_FACTURAS AS
    PROCEDURE adicionarFactura(        
        p_id_consumidor IN CHAR,        
        p_id_bono IN VARCHAR2,
        p_id_pedido IN VARCHAR2
    )
    AS
        -- Variables para almacenar el total de la factura y el descuento del bono
        v_total_factura NUMBER(10);
        v_descuento_bono NUMBER(10);
        v_id_carrito_compra VARCHAR(10); 
        v_total_carrito_compra NUMBER(10) := 0; -- Inicializado
        v_tiene_envio NUMBER(1) := 0; -- Inicializado


        -- Variable para verificar si el bono pertenece al consumidor
        v_bono_pertenece NUMBER(1);
    BEGIN

        -- traer el id carrito compra
        SELECT idcarritocompras INTO v_id_carrito_compra FROM pedidos
        WHERE id = p_id_pedido;

        -- calculando el total de la suma de los platos en el carrito del consumidor
        SELECT     
            SUM(platos.precio) as total_carrito_compra INTO v_total_carrito_compra
        FROM pedidos
        JOIN carritoscompras ON pedidos.idcarritocompras = carritoscompras.id
        JOIN carritosmenus ON pedidos.idcarritocompras = carritosmenus.idcarrito
        JOIN platos ON carritosmenus.ID_PLATO_ALEATORIO_SELECCIONADO = platos.id WHERE carritosmenus.idcarrito = v_id_carrito_compra;
        -- Verificar si el bono existe y pertenece al consumidor
        SELECT COUNT(*)
        INTO v_bono_pertenece
        FROM bonos_delizia b
        WHERE b.id = p_id_bono
        AND b.idConsumidor = p_id_consumidor;

        -- VERIFICAMOS SI TIENE ENVIO
        SELECT envio INTO v_tiene_envio
        FROM pedidos WHERE id = p_id_pedido;

        IF v_total_carrito_compra IS NULL THEN
            DBMS_OUTPUT.PUT_LINE('El carrito esta vacio y no se puede hacer el proceso de facturaci�n');
        ELSE

            -- Caso 1: Bono existe y pertenece al consumidor
            IF v_bono_pertenece = 1 THEN
                -- Calcular el descuento del bono
                SELECT porcentajeDescuento
                INTO v_descuento_bono
                FROM tiposBono tb
                JOIN bonos_delizia b ON tb.id = b.idTipoBono
                WHERE b.id = p_id_bono;

                -- Calcular el total de la factura
                v_total_factura := v_total_carrito_compra - (v_total_carrito_compra * v_descuento_bono / 100);

            -- Caso 2: Bono existe pero no pertenece al consumidor
            ELSE
                -- Mandar mensaje de error
                DBMS_OUTPUT.PUT_LINE('El bono con ID ' || p_id_bono || ' existe pero no pertenece al consumidor. La factura se genero sin descuentos por bonos');

                -- Calcular el total de la factura sin descuento
                v_total_factura := v_total_carrito_compra;
            END IF;

            -- Aplicar costo de env�o si es necesario
            IF v_tiene_envio = 1 THEN
                v_total_factura := v_total_factura + 5;
            END IF;

            -- Insertar factura en la base de datos
            INSERT INTO facturas (idConsumidor, fecha, total, idBono, idPedido)
            VALUES (p_id_consumidor, SYSDATE, v_total_factura, p_id_bono, p_id_pedido);  
        END IF;
        COMMIT;
    EXCEPTION 
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error al agregar la factura.');
            RAISE;
    END adicionarFactura;

    FUNCTION consultarFacturas RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN 
        OPEN v_cursor FOR
            SELECT * FROM facturas;
        RETURN v_cursor;
    END consultarFacturas;

    PROCEDURE printConsultarFacturas
    AS
        v_factura_cursor SYS_REFCURSOR;
        v_id facturas.id%TYPE;
        v_id_consumidor facturas.idConsumidor%TYPE;
        v_fecha facturas.fecha%TYPE;
        v_total facturas.total%TYPE;
        v_id_bono facturas.idBono%TYPE;
        v_id_pedido facturas.idPedido%TYPE;
    BEGIN
        v_factura_cursor := PK_FACTURAS.consultarFacturas;
        LOOP
            FETCH v_factura_cursor INTO v_id, v_id_consumidor, v_fecha, v_total, v_id_bono, v_id_pedido;
            EXIT WHEN v_factura_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('ID: ' || v_id || ', ID Consumidor: ' || v_id_consumidor || ', Fecha: ' || v_fecha || ', Total: ' || v_total || ', ID Bono: ' || v_id_bono || ', ID Pedido: ' || v_id_pedido);
        END LOOP;
        CLOSE v_factura_cursor;
    END printConsultarFacturas;

    FUNCTION consultarBonos(p_id_consumidor IN CHAR) RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN 
        OPEN v_cursor FOR
            SELECT 
                c.id AS id_consumidor,
                c.nombre AS nombre_consumidor,
                b.id AS id_bono,
                tb.nombreBono AS nombre_bono,
                tb.descripcion AS descripcion_bono,
                tb.porcentajeDescuento AS porcentaje_descuento,
                tb.fechaExpiracion AS fecha_expiracion,
                tb.estado AS estado_bono
            FROM 
                consumidores c
            JOIN 
                bonos_delizia b ON c.id = b.idConsumidor
            JOIN 
                tiposBono tb ON b.idTipoBono = tb.id
            WHERE 
                tb.estado = 'activo'
                AND tb.fechaExpiracion > SYSDATE
                AND c.id = p_id_consumidor;
        RETURN v_cursor;
    END consultarBonos;

    PROCEDURE print_consultar_bonos(p_id_consumidor IN CHAR) AS
        v_bono_cursor SYS_REFCURSOR;
        v_id_consumidor consumidores.id%TYPE;
        v_nombre_consumidor consumidores.nombre%TYPE;
        v_id_bono bonos_delizia.id%TYPE;
        v_nombre_bono tiposBono.nombreBono%TYPE;
        v_descripcion_bono tiposBono.descripcion%TYPE;
        v_porcentaje_descuento tiposBono.porcentajeDescuento%TYPE;
        v_fecha_expiracion tiposBono.fechaExpiracion%TYPE;
        v_estado_bono tiposBono.estado%TYPE;
    BEGIN
        -- Abrir el cursor y obtener los detalles de los bonos
        v_bono_cursor := consultarBonos(p_id_consumidor);
        LOOP
            FETCH v_bono_cursor INTO 
                v_id_consumidor, 
                v_nombre_consumidor, 
                v_id_bono, 
                v_nombre_bono, 
                v_descripcion_bono, 
                v_porcentaje_descuento, 
                v_fecha_expiracion, 
                v_estado_bono;
            EXIT WHEN v_bono_cursor%NOTFOUND;
            -- Imprimir los detalles de los bonos
            DBMS_OUTPUT.PUT_LINE('ID Consumidor: ' || v_id_consumidor);
            DBMS_OUTPUT.PUT_LINE('Nombre Consumidor: ' || v_nombre_consumidor);
            DBMS_OUTPUT.PUT_LINE('ID Bono: ' || v_id_bono);
            DBMS_OUTPUT.PUT_LINE('Nombre Bono: ' || v_nombre_bono);
            DBMS_OUTPUT.PUT_LINE('Descripci�n Bono: ' || v_descripcion_bono);
            DBMS_OUTPUT.PUT_LINE('Porcentaje Descuento: ' || v_porcentaje_descuento);
            DBMS_OUTPUT.PUT_LINE('Fecha Expiraci�n: ' || TO_CHAR(v_fecha_expiracion, 'YYYY-MM-DD'));
            DBMS_OUTPUT.PUT_LINE('Estado Bono: ' || v_estado_bono);
            DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
        END LOOP;
        CLOSE v_bono_cursor;
    END print_consultar_bonos;

END PK_FACTURAS;

----------------- CALIFICACIONES --------------
-- Creaci�n del paquete
CREATE OR REPLACE PACKAGE PK_CALIFICACIONES_DELIZIA AS
    PROCEDURE adicionarCalificacion(p_cantidadEstrellas IN NUMBER, p_comentario IN VARCHAR2, p_idPedido IN VARCHAR2);
    PROCEDURE modificarCalificacion(p_id IN VARCHAR2, p_columna IN VARCHAR2, p_nuevoValor IN VARCHAR2);
    PROCEDURE eliminarCalificacion(p_id IN VARCHAR2);
    FUNCTION consultarCalificaciones RETURN SYS_REFCURSOR;
    PROCEDURE printConsultarCalificaciones;
END PK_CALIFICACIONES_DELIZIA;
/
 
-- Creaci�n del cuerpo del paquete
CREATE OR REPLACE PACKAGE BODY PK_CALIFICACIONES_DELIZIA AS
 
    PROCEDURE adicionarCalificacion(p_cantidadEstrellas IN NUMBER, p_comentario IN VARCHAR2, p_idPedido IN VARCHAR2) AS
    BEGIN
        INSERT INTO calificaciones_delizia (cantidadEstrellas, comentario, idPedido)
        VALUES (p_cantidadEstrellas, p_comentario, p_idPedido); -- Asumiendo que calificaciones_delizia_seq es la secuencia
        COMMIT;
    EXCEPTION 
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error al agregar la calificaci�n.');
            RAISE;
    END adicionarCalificacion;
 
    PROCEDURE modificarCalificacion(p_id IN VARCHAR2, p_columna IN VARCHAR2, p_nuevoValor IN VARCHAR2) AS
    BEGIN
        IF p_columna = 'cantidadEstrellas' THEN
            UPDATE calificaciones_delizia
            SET cantidadEstrellas = TO_NUMBER(p_nuevoValor)
            WHERE id = p_id;
        ELSIF p_columna = 'comentario' THEN
            UPDATE calificaciones_delizia
            SET comentario = p_nuevoValor
            WHERE id = p_id;
        ELSE
            RAISE_APPLICATION_ERROR(-20002, 'Columna no v�lida');
        END IF;
        COMMIT;
    EXCEPTION 
        WHEN OTHERS THEN
            ROLLBACK; 
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error, la transacci�n ha sido revertida.');
            RAISE;        
    END modificarCalificacion;
 
    PROCEDURE eliminarCalificacion(p_id IN VARCHAR2) AS
    BEGIN
        DELETE FROM calificaciones_delizia
        WHERE id = p_id;
        COMMIT;
    EXCEPTION 
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error al eliminar la calificaci�n.');
            RAISE;
    END eliminarCalificacion;
 
    FUNCTION consultarCalificaciones RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN 
        OPEN v_cursor FOR
            SELECT * FROM calificaciones_delizia;
        RETURN v_cursor;
    END consultarCalificaciones;
 
    PROCEDURE printConsultarCalificaciones AS
        v_calificacion_cursor SYS_REFCURSOR;
        v_id calificaciones_delizia.id%TYPE;
        v_cantidad_estrellas calificaciones_delizia.cantidadEstrellas%TYPE;
        v_comentario calificaciones_delizia.comentario%TYPE;
        v_id_pedido calificaciones_delizia.idPedido%TYPE;
    BEGIN
        v_calificacion_cursor := PK_CALIFICACIONES_DELIZIA.consultarCalificaciones;
        LOOP
            FETCH v_calificacion_cursor INTO v_id, v_cantidad_estrellas, v_comentario, v_id_pedido;
            EXIT WHEN v_calificacion_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('ID: ' || v_id || ', Cantidad de Estrellas: ' || v_cantidad_estrellas || ', Comentario: ' || v_comentario || ', ID Pedido: ' || v_id_pedido);
        END LOOP;
        CLOSE v_calificacion_cursor;
    END printConsultarCalificaciones;
 
END PK_CALIFICACIONES_DELIZIA;
/

SELECT * FROM domiciliarios;
-------------------- DOMICILIARIOS-------------------- 

CREATE OR REPLACE PACKAGE PK_DOMICILIARIOS AS
    PROCEDURE adicionarDomiciliario(p_nombre IN VARCHAR2, p_direccion IN VARCHAR2, p_duracion IN NUMBER, p_correo IN VARCHAR2);
    PROCEDURE modificarDomiciliario(p_id IN VARCHAR2, p_columna IN VARCHAR2, p_nuevoValor IN VARCHAR2);    
    FUNCTION consultarDomiciliarios RETURN SYS_REFCURSOR;
    PROCEDURE printConsultarDomiciliarios;
END PK_DOMICILIARIOS;
/

CREATE OR REPLACE PACKAGE BODY PK_DOMICILIARIOS AS
    PROCEDURE adicionarDomiciliario(p_nombre IN VARCHAR2, p_direccion IN VARCHAR2, p_duracion IN NUMBER, p_correo IN VARCHAR2) AS
    BEGIN
        INSERT INTO domiciliarios (nombre, direccion, duracion, correo)
        VALUES (p_nombre, p_direccion, p_duracion, p_correo);
        COMMIT;
    EXCEPTION 
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error al adicionar el domiciliario.');
            RAISE;
    END adicionarDomiciliario;

    PROCEDURE modificarDomiciliario(
        p_id IN VARCHAR2,
        p_columna IN VARCHAR2,
        p_nuevoValor IN VARCHAR2
    ) AS
    BEGIN
        IF p_columna = 'nombre' THEN
            UPDATE domiciliarios
            SET nombre = p_nuevoValor
            WHERE id = p_id;
        ELSIF p_columna = 'direccion' THEN
            UPDATE domiciliarios
            SET direccion = p_nuevoValor
            WHERE id = p_id;
        ELSIF p_columna = 'duracion' THEN
            UPDATE domiciliarios
            SET duracion = TO_NUMBER(p_nuevoValor)
            WHERE id = p_id;
        ELSIF p_columna = 'correo' THEN
            UPDATE domiciliarios
            SET correo = p_nuevoValor
            WHERE id = p_id;
        ELSE
            RAISE_APPLICATION_ERROR(-20002, 'Columna no v�lida');
        END IF;
    
        DBMS_OUTPUT.PUT_LINE('El domiciliario ha sido modificado con �xito en la columna: ' || p_columna || ' a: ' || p_nuevoValor);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error al modificar el domiciliario.');
            RAISE;
    END modificarDomiciliario;
    
    FUNCTION consultarDomiciliarios RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN 
        OPEN v_cursor FOR
            SELECT * FROM domiciliarios;
        RETURN v_cursor;
    END consultarDomiciliarios;

    PROCEDURE printConsultarDomiciliarios AS
        v_domiciliario_cursor SYS_REFCURSOR;
        v_id domiciliarios.id%TYPE;
        v_nombre domiciliarios.nombre%TYPE;
        v_direccion domiciliarios.direccion%TYPE;
        v_duracion domiciliarios.duracion%TYPE;
        v_correo domiciliarios.correo%TYPE;
    BEGIN
        v_domiciliario_cursor := PK_DOMICILIARIOS.consultarDomiciliarios;
        LOOP
            FETCH v_domiciliario_cursor INTO v_id, v_nombre, v_direccion, v_duracion, v_correo;
            EXIT WHEN v_domiciliario_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('ID: ' || v_id || ', Nombre: ' || v_nombre || ', Direcci�n: ' || v_direccion || ', Duraci�n: ' || v_duracion || ', Correo: ' || v_correo);
        END LOOP;
        CLOSE v_domiciliario_cursor;
    END printConsultarDomiciliarios;
END PK_DOMICILIARIOS;
/


------------  AUDITORIAS
CREATE OR REPLACE PACKAGE PK_AUDITORIAS_DELIZIA AS
    FUNCTION consultarAuditorias RETURN SYS_REFCURSOR;
    PROCEDURE printConsultarAuditorias;
END PK_AUDITORIAS_DELIZIA;
/
 
CREATE OR REPLACE PACKAGE BODY PK_AUDITORIAS_DELIZIA AS
    FUNCTION consultarAuditorias RETURN SYS_REFCURSOR AS
        v_cursor SYS_REFCURSOR;
    BEGIN 
        OPEN v_cursor FOR
            SELECT * FROM auditorias_view;
        RETURN v_cursor;
    END consultarAuditorias;
 
    PROCEDURE printConsultarAuditorias
    AS
        v_auditoria_cursor SYS_REFCURSOR;
        v_nit_empresa auditorias_view.nitempresa%TYPE;
        v_platos_vendidos auditorias_view.platos_vendidos%TYPE;
        v_platos_por_vender auditorias_view.platos_por_vender%TYPE;
        v_total_perdidas auditorias_view.total_perdidas%TYPE;
        v_total_ganancias auditorias_view.total_ganancias%TYPE;
    BEGIN
        v_auditoria_cursor := PK_AUDITORIAS_DELIZIA.consultarAuditorias;
        LOOP
            FETCH v_auditoria_cursor INTO v_nit_empresa, v_platos_vendidos, v_platos_por_vender, v_total_perdidas, v_total_ganancias;
            EXIT WHEN v_auditoria_cursor%NOTFOUND;
            
            -- Imprimir los detalles de la auditor�a
            DBMS_OUTPUT.PUT_LINE('Nit Empresa: ' || v_nit_empresa || 
                                 ', Platos Vendidos: ' || v_platos_vendidos || 
                                 ', Platos por Vender: ' || v_platos_por_vender || 
                                 ', Total Perdidas: ' || v_total_perdidas || 
                                 ', Total Ganancias: ' || v_total_ganancias);

            -- Insertar los datos en la tabla auditorias_delizia
            INSERT INTO auditorias_delizia (                
                nitEmpresa, 
                platos_vendidos, 
                platos_por_vender, 
                ganancias, 
                perdidas, 
                fecha_auditoria
            ) VALUES (                
                v_nit_empresa,
                v_platos_vendidos,
                v_platos_por_vender,
                v_total_ganancias,
                v_total_perdidas,
                SYSDATE
            );
        END LOOP;
        CLOSE v_auditoria_cursor;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Ocurri� un error durante la inserci�n de auditor�as.');
            RAISE;
    END printConsultarAuditorias;
END PK_AUDITORIAS_DELIZIA;
/

