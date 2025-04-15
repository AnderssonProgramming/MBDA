-- PRUEBAS PAQUETES --
SET SERVEROUTPUT ON

------------------------------------------------------------------------ PK_CLIENTES ------------------------------------------------------------------------ OK
-- adicionar direccion - OK
BEGIN
    PK_CLIENTES.adicionar__direccion_cliente('3','Calle: y, Numero: 026, Ciudad: u');    
END;

-- adicionar celular - OK
BEGIN
    PK_CLIENTES.adicionar__celular_cliente('5',3123178087);    
END;

-- modificar__direccion_cliente - OK
BEGIN
    PK_CLIENTES.modificar__direccion_cliente('3','5','Calle: works, Numero: 026, Ciudad: u');    
END;

-- modificar__celular_cliente - OK
BEGIN
    PK_CLIENTES.modificar__celular_cliente('5', '5', 1111111111);    
END;


-- eliminar__direccion_cliente - OK
BEGIN
    PK_CLIENTES.eliminar__direccion_cliente('3', '5');    
END;


-- eliminar__celular_cliente - OK
BEGIN
    PK_CLIENTES.eliminar__celular_cliente('5', '5');    
END;

-- print_consultar_direcciones_cliente - OK
BEGIN
    PK_CLIENTES.print_consultar_direcciones_cliente;
END;

-- print_consultar_celulares_cliente - OK
BEGIN
    PK_CLIENTES.print_consultar_celulares_cliente;
END;


------------------------------------------------------------------------ PK_CONSUMIDORES ------------------------------------------------------------------------ OK
-- == CRUD ==
-- adicionar consumidor
BEGIN 
    PK_CONSUMIDORES.ADICIONAR('David Ariza','Monster Hambuger','davidd@gmail.com');
END;

-- moficar
BEGIN 
    PK_CONSUMIDORES.MODIFICAR('6','nombre','Michel Jackson');
END;

-- eliminar   
BEGIN 
    PK_CONSUMIDORES.ELIMINAR('6');
END;
-- consultar
BEGIN 
    PK_CONSUMIDORES.print_consultar;
END;

-- -- adicionar direccion consumidor
BEGIN 
    PK_CONSUMIDORES.adicionar__direccion_consumidor('5','Calle: y, Numero: 026, Ciudad: u');
END;
-- -- adicionar celular consumidor
BEGIN 
    PK_CONSUMIDORES.adicionar__celular_consumidor('5',3123179067);
END;


------------------------------------------------------------------------ PK_EMPRESAS ------------------------------------------------------------------------ OK
-- == CRUD ==
-- adicionar empresa
BEGIN 
    PK_EMPRESAS.ADICIONAR('Frizby','COE','Frizby@Frizby.com');
END;
-- moficar
BEGIN 
    PK_EMPRESAS.MODIFICAR('7','nombre','Frizby God');
END;

-- eliminar   
BEGIN 
    PK_EMPRESAS.ELIMINAR('7');
END;
-- consultar
BEGIN 
    PK_EMPRESAS.print_consultar;
END;
-- -- adicionar direccion consumidor
BEGIN 
    PK_EMPRESAS.adicionar_direccion_empresa('2','Calle: y, Numero: 026, Ciudad: u');
END;
-- -- adicionar celular consumidor
BEGIN 
    PK_EMPRESAS.adicionar_celular_empresa('2',3123179060);
END;

------------------------------------------------------------------------ PK_PLATOS ------------------------------------------------------------------------ OK
    
-- Adicionar un plato
BEGIN
    PK_PLATOS.adicionar('Bistec de caballo', 6, '2');
END;
/


-- UPDATE platos SET estado = 'no disponible' WHERE id = 37

-- Modificar un plato (nombre)
BEGIN
    PK_PLATOS.modificar('35', 'nombre', 'Alitas rancheraz PEQUE�AS');
END;
/

-- Modificar un plato (precio)
BEGIN
    PK_PLATOS.modificar('35', 'precio', '7');
END;
/

-- Eliminar un plato
BEGIN
    PK_PLATOS.eliminar('35');
END;
/

-- Consultar platos
BEGIN
    PK_PLATOS.print_consultar;
END;
/
-- modificar fecha expiracion plato_empresa
BEGIN 
    PK_PLATOS.modificar_fecha_caducidad_plato_platos_empresa('36','30-MAY-25');
END;



------------------------------------------------------------------------ PK_MENUSALEATORIOS ------------------------------------------------------------------------ 
-- adicionar - OK
BEGIN 
    PK_MENUS_ALEATORIOS.adicionar_menu_aleatorio('2','E',12,'Choco world');
END;

-- modificar - OK
BEGIN 
    PK_MENUS_ALEATORIOS.modificar_menu_aleatorio('1','estado','disponible');
END;

-- eliminar - OK
BEGIN 
    PK_MENUS_ALEATORIOS.eliminar_menu_aleatorio('1');
END;

-- consultar - OK
BEGIN 
    PK_MENUS_ALEATORIOS.print_consultar_menus_aleatorios;
END;

------- sub modulo -> menus_platos ---------

-- adicionar_plato_a_menu - NOOK
BEGIN 
    PK_MENUS_ALEATORIOS.adicionar_plato_a_menu_aleatorio('2','35');
END;

-------------- ADICIONAR PLATOS SIGUIENDO LA POLITICA DE DATOS PROVEIDA POR LOS ESTADOS PREMIUM, ESTANDAR Y AVENTURERA (AVENTURERA ENCIERRA AMBAS, ESTANDAR Y PREMIUM)
BEGIN 
    PK_MENUS_ALEATORIOS.adicionar_plato_a_menu_aleatorio('3','33'); -- OK
END;

-- UPDATE MENUSALEATORIOS SET ESTADO = 'disponible' WHERE id = '1';
BEGIN 
    PK_MENUS_ALEATORIOS.adicionar_plato_a_menu_aleatorio('2','33'); -- NoOK
END;


SELECT * FROM platos;
SELECT * FROM menus_platos;



BEGIN 
    PK_MENUS_ALEATORIOS.adicionar_plato_a_menu_aleatorio('2','37');
END;


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- eliminar_plato_a_menu - OK
BEGIN 
    PK_MENUS_ALEATORIOS.eliminar__plato_a_menu_aleatorio('2','35');
END;

-- print_consultar_platos_menu - OK
BEGIN 
    PK_MENUS_ALEATORIOS.print_consultar_platos_de_menus_aleatorios;
END;

---- MENUS PLATOS
BEGIN 
    PK_MENUS_ALEATORIOS.adicionar_menu_plato('2','1');
END;

BEGIN 
    PK_MENUS_ALEATORIOS.eliminar_menu_plato('2','1');
END;

BEGIN 
    PK_MENUS_ALEATORIOS.print_consultar_menus_platos;
END;

BEGIN 
    PK_MENUS_ALEATORIOS.print_consultar_menus_platos;
END;
-- select * from platos
-- select * from menus_platos;

------------------------------------------------------------------------ PK_TIPOS_BONO ------------------------------------------------------------------------ 
-- adicionar - OK
BEGIN 
    PK_TIPOS_BONO.adicionar('Bono descuento de verano', 'VERANO10', '2', 10, 'ACTIVO', TO_DATE('2024-08-31', 'YYYY-MM-DD'));
END;

-- modificar - OK
BEGIN 
    PK_TIPOS_BONO.modificar('6', 'estado', 'activo');
END;

-- eliminar - OK
BEGIN 
    PK_TIPOS_BONO.eliminar('7');
END;

-- consultar - OK
BEGIN 
    PK_TIPOS_BONO.print_consultar;
END;

-- UPDATE tiposbono set estado = 'activo';
-- SELECT * FROM tiposbono

--select * from platos

--SELECT * FROM PEDIDOS

------------------------------------------------------------------------ PK_BONOS_DELIZIA ------------------------------------------------------------------------

-- registrar_bono - OK
BEGIN 
    PK_bonos_delizia.registrar_bono(
        '1',
        '7'
    );
END;
/

-- modificar_bono - OK
BEGIN 
    PK_bonos_delizia.modificar_bono(
        '6',
        'idConsumidor',
        '5'
    );
END;
/



-- eliminar_bono - OK
BEGIN 
    PK_bonos_delizia.eliminar_bono(
        '6'
    );
END;
/

-- consultar_bonos_delizia - OK
BEGIN 
    PK_bonos_delizia.print_consultar_bonos_delizia;
END;
/

-- SELECT * FROM bonos_delizia;

------------------------------------------------------------------------ PK_DONACIONES ------------------------------------------------------------------------

-- registrar_donacion - OK
BEGIN 
    PK_DONACIONES.registrar_donacion(
        TO_DATE('2024-05-17', 'YYYY-MM-DD'),
        1000,
        'D',
        '2'
    );
END;
/


-- modificar_donacion - OK
BEGIN 
    PK_DONACIONES.modificar_donacion(
        '3',
        'cantidad',
        '1500'
    );
END;
/

-- eliminar_donacion - OK
BEGIN 
    PK_DONACIONES.eliminar_donacion(
        '4'
    );
END;
/

-- consultar_donaciones - OK
BEGIN 
    -- PK_DONACIONES.print_consultar_donaciones;
    SELECT * FROM PK_DONACIONES.consultar_donaciones;
END;
/

------------ PK_CARRITOS_COMPRAS ------------

-- registrar_carrito - OK
BEGIN 
    PK_CARRITOS_COMPRAS.registrar_carrito('3');
END;
/


-- modificar_carrito - OK
BEGIN 
    PK_CARRITOS_COMPRAS.modificar_carrito('2', 'idConsumidor', '1');
END;
/



/*
-- NO SE PUEDEN ELIMINAR CARRITOS
-- eliminar_carrito - OK
BEGIN 
    PK_CARRITOS_COMPRAS.eliminar_carrito('CARR001');
END;
/
*/

-- vaciar_carrito - OK
BEGIN 
    PK_CARRITOS_COMPRAS.vaciar_carrito('3');
END;
/

-- consultar_carritos - OK
BEGIN 
    PK_CARRITOS_COMPRAS.print_consultar_carritos;
END;
/



-- registrar_menu_a_carrito - OK
BEGIN 
    PK_CARRITOS_COMPRAS.registrar_menu_a_carrito('3', '2', '2');
END;
/



-- UPDATE platos_empresas SET unidadesdisponibles = unidadesdisponibles + 100;

--SELECT * FROM CARRITOSMENUS
--SELECT * FROM MENUS_PLATOS
-- eliminar_menu_de_carrito - OK
BEGIN 
    PK_CARRITOS_COMPRAS.eliminar_menu_de_carrito('100');
END;
/

-- consultar_menus_en_carritos - OK
BEGIN 
    PK_CARRITOS_COMPRAS.printconsultar_menus_en_carritos;
END;
/

------------ PK_PEDIDOS ------------

-- Registrar un nuevo 
BEGIN 
    pk_pedidos.registrar_pedido('3', '3', 0);
END;
/


-- Registrar un nuevo pedido con id 'P002', idConsumidor 'C002', estado 'P' (Pendiente), idCarritoCompras 'CARR002', envio 0 (No enviado)
BEGIN 
    pk_pedidos.registrar_pedido('P002', 'C002', 'P', 'CARR002', 0);
END;
/

-- Registrar un nuevo pedido con id 'P003', idConsumidor 'C003', estado 'E' (Enviado), idCarritoCompras 'CARR003', envio 1 (Enviado)
BEGIN 
    pk_pedidos.registrar_pedido('P003', 'C003', 'E', 'CARR003', 1);
END;
/

-- Modificar el estado del pedido con id 'P001' a 'C' (Completado)
BEGIN 
    pk_pedidos.modificar_pedido('P001', 'estado', 'C');
END;
/

-- Modificar el idConsumidor del pedido con id 'P002' a 'C004'
BEGIN 
    pk_pedidos.modificar_pedido('P002', 'idConsumidor', 'C004');
END;
/

-- Modificar el idCarritoCompras del pedido con id 'P003' a 'CARR004'
BEGIN 
    pk_pedidos.modificar_pedido('P003', 'idCarritoCompras', 'CARR004');
END;
/

-- Intentar modificar una columna no v�lida del pedido con id 'P001'
BEGIN 
    pk_pedidos.modificar_pedido('P001', 'columna_invalida', 'nuevo_valor');
END;
/

-- Consultar todos los pedidos
BEGIN 
    pk_pedidos.print_consultar_pedidos;
END;
/

-- Consultar la tabla pedidos para verificar los registros realizados
SELECT * FROM pedidos;
/


------------- PK_ENVIOS --------------
-- Prueba para adicionar_envio
BEGIN 
    pk_envios.adicionar_envio('2');
END;
/



-- Prueba para modificar_envio - estado
BEGIN 
    pk_envios.modificar_envio('1', 'estado', 'E');
END;
/
/*
-- Prueba para modificar_envio - iddomiciliario
BEGIN 
    pk_envios.modificar_envio('ENV001', 'iddomiciliario', 'DOM002');
END;
/
-- Prueba para modificar_envio - costo
BEGIN 
    pk_envios.modificar_envio('ENV001', 'costo', '15');
END;
/
-- Prueba para modificar_envio - fechaentrega
BEGIN 
    pk_envios.modificar_envio('ENV001', 'fechaentrega', '2024-06-01');
END;
/
-- Prueba para modificar_envio - columna inv�lida
BEGIN 
    pk_envios.modificar_envio('ENV001', 'columna_invalida', 'valor');
END;
/*
-- Prueba para print_consultar_envios
BEGIN 
    pk_envios.print_consultar_envios;
END;
/
-- Consultar la tabla de env�os para verificar cambios
SELECT * FROM envios;
/

----- PK_FACTURAS ------------

select * from BONOS_delizia
select * from tiposbono

------ FACTURAS ------
-- Adicionar Factura
BEGIN 
    PK_FACTURAS.adicionarFactura('3','3', '6');
END;
/

SELECT * FROM PEDIDOS

SELECT * FROM CARRITOSMENUS;
SELECT * FROM PLATOS;

SELECT * FROM pedidos
select * from platos
select * from bonos_delizia
SELECT * FROM tiposBono
SELECT * FROM FACTURAS

TRUNCATE TABLE FACTURAS

DELETE FROM facturas WHERE id = 1;

-- Consultar Facturas
BEGIN 
    PK_FACTURAS.printConsultarFacturas;
END;
/

SELECT * FROM BONOS_DELIZIA
-- Consultar Bonos
BEGIN 
    PK_FACTURAS.print_consultar_bonos('1');
END;
/

----- CALIFICACIONES -------
BEGIN

    PK_CALIFICACIONES_DELIZIA.adicionarCalificacion(5, 'Excelente servicio', '2');
END;
select * from pedidos
/


BEGIN

    PK_CALIFICACIONES_DELIZIA.modificarCalificacion('1', 'cantidadEstrellas', '4');

END;

/

BEGIN

    PK_CALIFICACIONES_DELIZIA.modificarCalificacion('2', 'comentario', 'Servicio muy bueno y r�pido');

END;
/

select * from calificaciones_delizia

BEGIN

    PK_CALIFICACIONES_DELIZIA.eliminarCalificacion('8');

END;

SELECT * FROM CALIFICACIONES_DELIZIA
/
BEGIN

    PK_CALIFICACIONES_DELIZIA.printConsultarCalificaciones;

END;

/


---- DOMICILIARIOS -----
-- Caso de prueba 1: Adicionar un nuevo domiciliario
BEGIN
    PK_DOMICILIARIOS.adicionarDomiciliario('John Doe', 'Calle 41, Numero 136, Ciudad GHI', 4, 'john.doe@example.com');
END;
/

-- Caso de prueba 1: Modificar el nombre de un domiciliario existente
BEGIN
    PK_DOMICILIARIOS.modificarDomiciliario('', 'nombre', 'Johnathan Doe');
END;
/


BEGIN
    PK_DOMICILIARIOS.printConsultarDomiciliarios;
END;
/

---- AUTIDORIAS -----
BEGIN
    PK_AUDITORIAS_DELIZIA.printConsultarAuditorias;
END;
/

SELECT * FROM auditorias_delizia;