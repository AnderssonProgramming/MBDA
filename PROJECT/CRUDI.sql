-- Crear el paquete para la tabla consumidores
CREATE OR REPLACE PACKAGE BODY consumidores AS
    PROCEDURE adicionar(
        p_id IN CHAR(10),
        p_nombre IN CHAR(100),
        p_preferencia IN VARCHAR2(100),
        p_correo IN VARCHAR2(50)
    ) AS
    BEGIN
        INSERT INTO consumidores (id, nombre, preferencia_Alimento, correo) 
        VALUES (p_id, p_nombre, p_preferencia, p_correo);
    END adicionar;

    PROCEDURE modificar(
        p_id IN CHAR(10),
        p_nombre IN CHAR(100),
        p_preferencia IN VARCHAR2(100),
        p_correo IN VARCHAR2(50)
    ) AS
    BEGIN
        UPDATE consumidores 
        SET nombre = p_nombre, preferencia_Alimento = p_preferencia, correo = p_correo
        WHERE id = p_id;
    END modificar;

    PROCEDURE eliminar(
        p_id IN CHAR(10)
    ) AS
    BEGIN
        DELETE FROM consumidores WHERE id = p_id;
    END eliminar;

    PROCEDURE consultar(
        p_id IN CHAR(10)
    ) AS
    BEGIN
        -- Consulta de un consumidor específico
    END consultar;

    PROCEDURE mejoresConsumidores IS
    BEGIN
        -- Consulta de los mejores consumidores
    END mejoresConsumidores;
END consumidores;
/





-- Crear el paquete para la tabla empresas
CREATE OR REPLACE PACKAGE BODY empresas AS
    PROCEDURE adicionar(
        p_nit IN CHAR(10),
        p_nombre IN CHAR(100),
        p_tipoNegocio IN VARCHAR2(3),
        p_cantidadDesAli IN NUMBER,
        p_cantidadAliVen IN NUMBER,
        p_cantidadAliDon IN NUMBER,
        p_idDonacion IN VARCHAR2(10)
    ) AS
    BEGIN
        INSERT INTO empresas (nit, nombre, tipoNegocio, cantidadDesAli, cantidadAliVen, cantidadAliDon, idDonacion) 
        VALUES (p_nit, p_nombre, p_tipoNegocio, p_cantidadDesAli, p_cantidadAliVen, p_cantidadAliDon, p_idDonacion);
    END adicionar;

    PROCEDURE modificar(
        p_nit IN CHAR(10),
        p_nombre IN CHAR(100),
        p_tipoNegocio IN VARCHAR2(3),
        p_cantidadDesAli IN NUMBER,
        p_cantidadAliVen IN NUMBER,
        p_cantidadAliDon IN NUMBER,
        p_idDonacion IN VARCHAR2(10)
    ) AS
    BEGIN
        UPDATE empresas 
        SET nombre = p_nombre, tipoNegocio = p_tipoNegocio, cantidadDesAli = p_cantidadDesAli,
            cantidadAliVen = p_cantidadAliVen, cantidadAliDon = p_cantidadAliDon, idDonacion = p_idDonacion
        WHERE nit = p_nit;
    END modificar;

    PROCEDURE eliminar(
        p_nit IN CHAR(10)
    ) AS
    BEGIN
        DELETE FROM empresas WHERE nit = p_nit;
    END eliminar;

    PROCEDURE consultar(
        p_nit IN CHAR(10)
    ) AS
    BEGIN
        -- Consulta de una empresa específica
    END consultar;

   

 PROCEDURE empresaMayorVenta IS
    BEGIN
        -- Consulta de la empresa con mayor venta en los últimos meses
    END empresaMayorVenta;

    PROCEDURE gananciaPorEmpresa IS
    BEGIN
        -- Consulta de la ganancia en bruto producida por cada restaurante
    END gananciaPorEmpresa;
END empresas;
/


-- Crear el paquete para la tabla carritosCompras
CREATE OR REPLACE PACKAGE BODY carritosCompras AS
    PROCEDURE adicionar(
        p_id IN CHAR(10),
        p_idConsumidor IN CHAR(10),
        p_idProducto IN CHAR(10),
        p_cantidad IN NUMBER,
        p_fecha IN DATE
    ) AS
    BEGIN
        INSERT INTO carritosCompras (id, idConsumidor, idProducto, cantidad, fecha) 
        VALUES (p_id, p_idConsumidor, p_idProducto, p_cantidad, p_fecha);
    END adicionar;

    PROCEDURE modificar(
        p_id IN CHAR(10),
        p_idConsumidor IN CHAR(10),
        p_idProducto IN CHAR(10),
        p_cantidad IN NUMBER,
        p_fecha IN DATE
    ) AS
    BEGIN
        UPDATE carritosCompras 
        SET idConsumidor = p_idConsumidor, idProducto = p_idProducto, cantidad = p_cantidad, fecha = p_fecha
        WHERE id = p_id;
    END modificar;

    PROCEDURE eliminar(
        p_id IN CHAR(10)
    ) AS
    BEGIN
        DELETE FROM carritosCompras WHERE id = p_id;
    END eliminar;

    PROCEDURE consultar(
        p_id IN CHAR(10)
    ) AS
    BEGIN
        -- Consulta de un carrito de compras específico
    END consultar;

    PROCEDURE listaProductos IS
    BEGIN
        -- Consulta de la lista de productos del carrito de compras
    END listaProductos;
END carritosCompras;
/



-- Crear el paquete para la tabla calificaciones
CREATE OR REPLACE PACKAGE BODY calificaciones AS
    PROCEDURE adicionar(
        p_id IN CHAR(10),
        p_idConsumidor IN CHAR(10),
        p_idProducto IN CHAR(10),
        p_estrellas IN NUMBER,
        p_comentario IN VARCHAR2(255)
    ) AS
    BEGIN
        INSERT INTO calificaciones (id, idConsumidor, idProducto, estrellas, comentario) 
        VALUES (p_id, p_idConsumidor, p_idProducto, p_estrellas, p_comentario);
    END adicionar;

    PROCEDURE modificar(
        p_id IN CHAR(10),
        p_idConsumidor IN CHAR(10),
        p_idProducto IN CHAR(10),
        p_estrellas IN NUMBER,
        p_comentario IN VARCHAR2(255)
    ) AS
    BEGIN
        UPDATE calificaciones 
        SET idConsumidor = p_idConsumidor, idProducto = p_idProducto, estrellas = p_estrellas, comentario = p_comentario
        WHERE id = p_id;
    END modificar;

    PROCEDURE eliminar(
        p_id IN CHAR(10)
    ) AS
    BEGIN
        DELETE FROM calificaciones WHERE id = p_id;
    END eliminar;

    PROCEDURE consultar(
        p_id IN CHAR(10)
    ) AS
    BEGIN
        -- Consulta de una calificación específica
    END consultar;

    PROCEDURE platosMasVendidos IS
    BEGIN
        -- Consulta de calificaciones por encima de 3 estrellas para los platos más vendidos
    END platosMasVendidos;
END calificaciones;
/


-- Crear el paquete para la tabla menusAleatorios
CREATE OR REPLACE PACKAGE BODY menusAleatorios AS
    PROCEDURE adicionar(
        p_id IN CHAR(10),
        p_idEmpresa IN CHAR(10),
        p_nombre IN VARCHAR2(100),
        p_fecha IN DATE
    ) AS
    BEGIN
        INSERT INTO menusAleatorios (id, idEmpresa, nombre, fecha) 
        VALUES (p_id, p_idEmpresa, p_nombre, p_fecha);
    END adicionar;

    PROCEDURE modificar(
        p_id IN CHAR(10),
        p_idEmpresa IN CHAR(10),
        p_nombre IN VARCHAR2(100),
        p_fecha IN DATE
    ) AS
    BEGIN
        UPDATE menusAleatorios 
        SET idEmpresa = p_idEmpresa, nombre = p_nombre, fecha = p_fecha
        WHERE id = p_id;
    END modificar;

    PROCEDURE eliminar(
        p_id IN CHAR(10)
    ) AS
    BEGIN
        DELETE FROM menusAleatorios WHERE id = p_id;
    END eliminar;

    PROCEDURE consultar(
        p_id IN CHAR(10)
    ) AS
    BEGIN
        -- Consulta de un menú aleatorio específico
    END consultar;

    PROCEDURE probabilidadAparicionPlato IS
    BEGIN
        -- Consulta de los menús aleatorios y el detalle de los platos que pertenecen a dicho menú
    END probabilidadAparicionPlato;

    PROCEDURE generacionAutomatic

o IS
    BEGIN
        -- Creación automática de nuevos menús aleatorios basándose en los platos disponibles
    END generacionAutomatico;
END menusAleatorios;
/


-- Crear el paquete para la tabla platos
CREATE OR REPLACE PACKAGE BODY platos AS
    PROCEDURE adicionar(
        p_id IN CHAR(10),
        p_nombre IN VARCHAR2(100),
        p_precio IN NUMBER,
        p_tipo IN CHAR(10),
        p_cantidad IN NUMBER
    ) AS
    BEGIN
        INSERT INTO platos (id, nombre, precio, tipo, cantidad) 
        VALUES (p_id, p_nombre, p_precio, p_tipo, p_cantidad);
    END adicionar;

    PROCEDURE modificar(
        p_id IN CHAR(10),
        p_nombre IN VARCHAR2(100),
        p_precio IN NUMBER,
        p_tipo IN CHAR(10),
        p_cantidad IN NUMBER
    ) AS
    BEGIN
        UPDATE platos 
        SET nombre = p_nombre, precio = p_precio, tipo = p_tipo, cantidad = p_cantidad
        WHERE id = p_id;
    END modificar;

    PROCEDURE eliminar(
        p_id IN CHAR(10)
    ) AS
    BEGIN
        DELETE FROM platos WHERE id = p_id;
    END eliminar;

    PROCEDURE consultar(
        p_id IN CHAR(10)
    ) AS
    BEGIN
        -- Consulta de un plato específico
    END consultar;

    PROCEDURE porcentajeAparicion IS
    BEGIN
        -- Consulta de platos y su porcentaje de aparición en un menú
    END porcentajeAparicion;
END platos;
/


-- Crear el paquete para la tabla envios
CREATE OR REPLACE PACKAGE BODY envios AS
    PROCEDURE adicionar(
        p_id IN CHAR(10),
        p_idPedido IN CHAR(10),
        p_idDomiciliario IN CHAR(10),
        p_fechaEnvio IN DATE,
        p_estado IN VARCHAR2(20)
    ) AS
    BEGIN
        INSERT INTO envios (id, idPedido, idDomiciliario, fechaEnvio, estado) 
        VALUES (p_id, p_idPedido, p_idDomiciliario, p_fechaEnvio, p_estado);
    END adicionar;

    PROCEDURE modificar(
        p_id IN CHAR(10),
        p_idPedido IN CHAR(10),
        p_idDomiciliario IN CHAR(10),
        p_fechaEnvio IN DATE,
        p_estado IN VARCHAR2(20)
    ) AS
    BEGIN
        UPDATE envios 
        SET idPedido = p_idPedido, idDomiciliario = p_idDomiciliario, fechaEnvio = p_fechaEnvio, estado = p_estado
        WHERE id = p_id;
    END modificar;

    PROCEDURE eliminar(
        p_id IN CHAR(10)
    ) AS
    BEGIN
        DELETE FROM envios WHERE id = p_id;
    END eliminar;

    PROCEDURE consultar(
        p_id IN CHAR(10)
    ) AS
    BEGIN
        -- Consulta de un envío específico
    END consultar;

    PROCEDURE envioAsignadoConsumidor IS
    BEGIN
        -- Consulta de los envíos asignados
    END envioAsignadoConsumidor;
END envios;
/



-- Crear el paquete para la tabla bonos
CREATE OR REPLACE PACKAGE BODY bonos AS
    PROCEDURE adicionar(
        p_id IN CHAR(10),
        p_idFactura IN CHAR(10),
        p_valor IN NUMBER,
        p_tipo IN VARCHAR2(20)
    ) AS
    BEGIN
        INSERT INTO bonos (id, idFactura, valor, tipo) 
        VALUES (p_id, p_idFactura, p_valor, p_tipo);
    END adicionar;

    PROCEDURE modificar(
        p_id IN CHAR(10),
        p_idFactura IN CHAR(10),
        p_valor IN NUMBER,
        p_tipo IN VARCHAR2(20)
    ) AS
    BEGIN
        UPDATE bonos 
        SET idFactura = p_idFactura, valor = p_valor, tipo = p_tipo
        WHERE id = p_id;
    END modificar;

    PROCEDURE eliminar(
        p_id IN CHAR(10)
    ) AS
    BEGIN
        DELETE FROM bonos WHERE id = p_id;
    END eliminar;

    PROCEDURE consultar(
        p_id IN CHAR(10)
    ) AS
    BEGIN
        -- Consulta de un bono específico
    END consultar;

    PROCEDURE bonoCompraPlatos IS
    BEGIN
        -- Consulta del bono producido por la compra de platos en la factura
    END bonoCompraPlatos;
END bonos;
/



-- Crear el paquete para la tabla facturas
CREATE OR REPLACE PACKAGE BODY facturas AS
    PROCEDURE adicionar(
        p_id IN CHAR(10),
        p_fecha IN DATE,
        p_idPedido IN CHAR(10)
    ) AS
    BEGIN
        INSERT INTO facturas (id, fecha, idPedido) 
        VALUES (p_id, p_fecha, p_idPedido);
    END adicionar;

    PROCEDURE modificar(
        p_id IN CHAR(10),
        p_fecha IN DATE,
        p_idPedido IN CHAR(10)
    ) AS
    BEGIN
        UPDATE facturas 
        SET fecha = p_fecha, idPedido = p_idPedido
        WHERE id = p_id;
    END modificar;

    PROCEDURE eliminar(
        p_id IN CHAR(10)
    ) AS
    BEGIN
        DELETE FROM facturas WHERE id = p_id;
    END eliminar;

    PROCEDURE consultar(
        p_id IN CHAR(10)
    ) AS
    BEGIN
        -- Consulta de una factura específica
    END consultar;

    PROCEDURE bonoPlato IS
    BEGIN
        -- Consulta en una factura el bono de cada plato
    END bonoPlato;
END facturas;
/


-- Crear el paquete para la tabla pedidos
CREATE OR REPLACE PACKAGE BODY pedidos AS
    PROCEDURE adicionar(
        p_id IN CHAR(10),
        p_idConsumidor IN CHAR(10),
        p_idEmpresa IN CHAR(10),
        p_fecha IN DATE,
        p_valorTotal IN NUMBER
    ) AS
    BEGIN
        INSERT INTO pedidos (id, idConsumidor, idEmpresa, fecha, valorTotal) 
        VALUES (p_id, p_idConsumidor, p_idEmpresa, p_fecha, p_valorTotal);
    END adicionar;

    PROCEDURE modificar(
        p_id IN CHAR(10),
        p_idConsumidor IN CHAR(10),
        p_idEmpresa IN CHAR(10),
        p_fecha IN DATE,
        p_valorTotal IN NUMBER
    ) AS
    BEGIN
        UPDATE pedidos 
        SET idConsumidor = p_idConsumidor, idEmpresa = p_idEmpresa, fecha = p_fecha, valorTotal = p_valorTotal
        WHERE id = p_id;
    END modificar;

    PROCEDURE eliminar(
        p_id IN CHAR(10)
    ) AS
    BEGIN
        DELETE FROM pedidos WHERE id = p_id;
    END eliminar;

    PROCEDURE consultar(
        p_id IN CHAR(10)
    ) AS
    BEGIN
        -- Consulta de un pedido específico
    END consultar;
END pedidos;
/



-- Crear el paquete para la tabla domiciliarios
CREATE OR REPLACE PACKAGE BODY domiciliarios AS
    PROCEDURE adicionar(
        p_id IN CHAR(10),
        p_nombre IN VARCHAR2(100),
        p_telefono IN VARCHAR2(15),
        p_ciudad IN VARCHAR2(100)
    ) AS
    BEGIN
        INSERT INTO domiciliarios (id, nombre, telefono, ciudad) 
        VALUES (p_id, p_nombre, p_telefono, p_ciudad);
    END adicionar;

    PROCEDURE modificar(
        p_id IN CHAR(10),
        p_nombre IN VARCHAR2(100),
        p_telefono IN VARCHAR2(15),
        p_ciudad IN VARCHAR2(100)
    ) AS
    BEGIN
        UPDATE domiciliarios 
        SET nombre = p_nombre, telefono = p_telefono, ciudad = p_ciudad
        WHERE id = p_id;
    END modificar;

    PROCEDURE eliminar(
        p_id IN CHAR(10)
    ) AS
    BEGIN
        DELETE FROM domiciliarios WHERE id = p_id;
    END eliminar;

    PROCEDURE consultar(
        p_id IN CHAR(10)
    ) AS
    BEGIN
        -- Consulta de un domiciliario específico
    END consultar;
END domiciliarios;
/



-- Crear el paquete para la tabla donaciones
CREATE OR REPLACE PACKAGE BODY donaciones AS
    PROCEDURE adicionar(
        p_id IN CHAR(10),
        p_fecha IN DATE,
        p_cantidad IN NUMBER
    ) AS
    BEGIN
        INSERT INTO donaciones (id, fecha, cantidad) 
        VALUES (p_id, p_fecha, p_cantidad);
    END adicionar;

    PROCEDURE modificar(
        p_id IN CHAR(10),
        p_fecha IN DATE,
        p_cantidad IN NUMBER
    ) AS
    BEGIN
        UPDATE donaciones 
        SET fecha = p_fecha, cantidad = p_cantidad
        WHERE id = p_id;
    END modificar;

    PROCEDURE eliminar(
        p_id IN CHAR(10)
    ) AS
    BEGIN
        DELETE FROM donaciones WHERE id = p_id;
    END eliminar;

    PROCEDURE consultar(
        p_id IN CHAR(10)
    ) AS
    BEGIN
        -- Consulta de una donación específica
    END consultar;
END donaciones;
/




-- Crear el paquete para la tabla auditorias
CREATE OR REPLACE PACKAGE BODY auditorias AS
    PROCEDURE adicionar(
        p_id IN CHAR(10),
        p_fecha IN DATE,
        p_actividad IN VARCHAR2(255)
    ) AS
    BEGIN
        INSERT INTO auditorias (id, fecha, actividad) 
        VALUES (p_id, p_fecha, p_actividad);
    END adicionar;

    PROCEDURE eliminar(
        p_id IN CHAR(10)
    ) AS
    BEGIN
        DELETE FROM auditorias WHERE id = p_id;
    END eliminar;

    PROCEDURE consultar(
        p_id IN CHAR(10)
    ) AS
    BEGIN
        -- Consulta de una auditoría específica
    END consultar;
END auditorias;
/