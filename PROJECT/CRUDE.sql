--### Paquete consumidores

CREATE OR REPLACE PACKAGE consumidores AS
    PROCEDURE adicionar(
        p_id IN CHAR(10),
        p_nombre IN CHAR(100),
        p_preferencia IN VARCHAR2(100),
        p_correo IN VARCHAR2(50)
    );

    PROCEDURE modificar(
        p_id IN CHAR(10),
        p_nombre IN CHAR(100),
        p_preferencia IN VARCHAR2(100),
        p_correo IN VARCHAR2(50)
    );

    PROCEDURE eliminar(
        p_id IN CHAR(10)
    );

    PROCEDURE consultar(
        p_id IN CHAR(10)
    );

    PROCEDURE mejoresConsumidores;
END consumidores;
/




--### Paquete empresas

CREATE OR REPLACE PACKAGE empresas AS
    PROCEDURE adicionar(
        p_nit IN CHAR(10),
        p_nombre IN CHAR(100),
        p_tipoNegocio IN VARCHAR2(3),
        p_cantidadDesAli IN NUMBER,
        p_cantidadAliVen IN NUMBER,
        p_cantidadAliDon IN NUMBER,
        p_idDonacion IN VARCHAR2(10)
    );

    PROCEDURE modificar(
        p_nit IN CHAR(10),
        p_nombre IN CHAR(100),
        p_tipoNegocio IN VARCHAR2(3),
        p_cantidadDesAli IN NUMBER,
        p_cantidadAliVen IN NUMBER,
        p_cantidadAliDon IN NUMBER,
        p_idDonacion IN VARCHAR2(10)
    );

    PROCEDURE eliminar(
        p_nit IN CHAR(10)
    );

    PROCEDURE consultar(
        p_nit IN CHAR(10)
    );

    PROCEDURE empresaMayorVenta;
    
    PROCEDURE gananciaPorEmpresa;
END empresas;
/



--### Paquete carritosCompras

CREATE OR REPLACE PACKAGE carritosCompras AS
    PROCEDURE adicionar(
        p_id IN CHAR(10),
        p_idConsumidor IN CHAR(10),
        p_idProducto IN CHAR(10),
        p_cantidad IN NUMBER,
        p_fecha IN DATE
    );

    PROCEDURE modificar(
        p_id IN CHAR(10),
        p_idConsumidor IN CHAR(10),
        p_idProducto IN CHAR(10),
        p_cantidad IN NUMBER,
        p_fecha IN DATE
    );

    PROCEDURE eliminar(
        p_id IN CHAR(10)
    );

    PROCEDURE consultar(
        p_id IN CHAR(10)
    );

    PROCEDURE listaProductos;
END carritosCompras;
/




--### Paquete calificaciones

CREATE OR REPLACE PACKAGE calificaciones AS
    PROCEDURE adicionar(
        p_id IN CHAR(10),
        p_idConsumidor IN CHAR(10),
        p_idProducto IN CHAR(10),
        p_estrellas IN NUMBER,
        p_comentario IN VARCHAR2(255)
    );

    PROCEDURE modificar(
        p_id IN CHAR(10),
        p_idConsumidor IN CHAR(10),
        p_idProducto IN CHAR(10),
        p_estrellas IN NUMBER,
        p_comentario IN VARCHAR2(255)
    );

    PROCEDURE eliminar(
        p_id IN CHAR(10)
    );

    PROCEDURE consultar(
        p_id IN CHAR(10)
    );

    PROCEDURE platosMasVendidos;
END calificaciones;
/




--### Paquete menusAleatorios

CREATE OR REPLACE PACKAGE menusAleatorios AS
    PROCEDURE adicionar(
        p_id IN CHAR(10),
        p_idEmpresa IN CHAR(10),
        p_nombre IN VARCHAR2(100),
        p_fecha IN DATE
    );

    PROCEDURE modificar(
        p_id IN CHAR(10),
        p_idEmpresa IN CHAR(10),
        p_nombre IN VARCHAR2(100),
        p_fecha IN DATE
    );

    PROCEDURE eliminar(
        p_id IN CHAR(10)
    );

    PROCEDURE consultar(
        p_id IN CHAR(10)
    );

    PROCEDURE probabilidadAparicionPlato;
    
    PROCEDURE generacionAutomatico;
END menusAleatorios;
/




--### Paquete platos

CREATE OR REPLACE PACKAGE platos AS
    PROCEDURE adicionar(
        p_id IN CHAR(10),
        p_nombre IN VARCHAR2(100),
        p_precio IN NUMBER,
        p_tipo IN CHAR(10),
        p_cantidad IN NUMBER
    );

    PROCEDURE modificar(
        p_id IN CHAR(10),
        p_nombre IN VARCHAR2(100),
        p_precio IN NUMBER,
        p_tipo IN CHAR(10),
        p_cantidad IN NUMBER
    );

    PROCEDURE eliminar(
        p_id IN CHAR(10)
    );

    PROCEDURE consultar(
        p_id IN CHAR(10)
    );

    PROCEDURE porcentajeAparicion;
END platos;
/




--### Paquete envios

CREATE OR REPLACE PACKAGE envios AS
    PROCEDURE adicionar(
        p_id IN CHAR(10),
        p_idPedido IN CHAR(10),
        p_idDomiciliario IN CHAR(10),
        p_fechaEnvio IN DATE,
        p_estado IN VARCHAR2(20)
    );

    PROCEDURE modificar(
        p_id IN CHAR(10),
        p_idPedido IN CHAR(10),
        p_idDomiciliario IN CHAR(10),
        p_fechaEnvio IN DATE,
        p_estado IN VARCHAR2(20)
    );

    PROCEDURE eliminar(
        p_id IN CHAR(10)
    );

    PROCEDURE consultar(
        p_id IN CHAR(10)
    );

    PROCEDURE envioAsignadoConsumidor;
END envios;
/




--### Paquete bonos

CREATE OR REPLACE PACKAGE bonos AS
    PROCEDURE adicionar(
        p_id IN CHAR(10),
        p_idFactura IN CHAR(10),
        p_valor IN NUMBER,
        p_tipo IN VARCHAR2(20)
    );

    PROCEDURE modificar(
        p_id IN CHAR(10),
        p_idFactura IN CHAR(10),
        p_valor IN NUMBER,
        p_tipo IN VARCHAR2(20)
    );

    PROCEDURE eliminar(
        p_id IN CHAR(10)
    );

    PROCEDURE consultar(
        p_id IN CHAR(10)
    );

    PROCEDURE bonoCompraPlatos;
END bonos;
/




--### Paquete facturas

CREATE OR REPLACE PACKAGE facturas AS
    PROCEDURE adicionar(
        p_id IN CHAR(10),
        p_fecha IN DATE,
        p_idPedido IN CHAR(10)
    );

    PROCEDURE modificar(
        p_id IN CHAR(10),
        p_fecha IN DATE,
        p_idPedido IN CHAR(10)
    );

    PROCEDURE eliminar(
        p_id IN CHAR(10)
    );

    PROCEDURE consultar(
        p_id IN CHAR(10)
    );

    PROCEDURE bonoPlato;
END facturas;
/




--### Paquete pedidos

CREATE OR REPLACE PACKAGE pedidos AS
    PROCEDURE adicionar(
        p_id IN CHAR(10),
        p_idConsumidor IN CHAR(10),
        p_idEmpresa IN CHAR(10),
        p_fecha IN DATE,
        p_valorTotal IN NUMBER
    );

    PROCEDURE modificar(
        p_id IN CHAR(10),
        p_idConsumidor IN CHAR(10),
        p_idEmpresa IN CHAR(10),
        p_fecha IN DATE,
        p_valorTotal IN NUMBER
    );

    PROCEDURE eliminar(
        p_id IN CHAR(10)
    );

    PROCEDURE consultar(
        p_id IN CHAR(10)
    );
END pedidos;
/



--### Paquete domiciliarios

CREATE OR REPLACE PACKAGE domiciliarios AS
    PROCEDURE adicionar(
        p_id IN CHAR(10),
        p_nombre IN VARCHAR2(100),
        p_telefono IN VARCHAR2(15),
        p_ciudad IN VARCHAR2(100)
    );

    PROCEDURE modificar(
        p_id IN CHAR(10),
        p_nombre IN VARCHAR2(100),
        p_telefono IN VARCHAR2(15),
        p_ciudad IN VARCHAR2(100)
    );

    PROCEDURE eliminar(
        p_id IN CHAR(10)
    );

    PROCEDURE consultar(
        p_id IN CHAR(10)
    );
END domiciliarios;
/




--### Paquete donaciones

CREATE OR REPLACE PACKAGE donaciones AS
    PROCEDURE adicionar(
        p_id IN CHAR(10),
        p_fecha IN DATE,
        p_cantidad IN NUMBER
    );

    PROCEDURE modificar(
        p_id IN CHAR(10),
        p_fecha IN DATE,
        p_cantidad IN NUMBER
    );

    PROCEDURE eliminar(
        p_id IN CHAR(10)
    );

    PROCEDURE consultar(
        p_id IN CHAR(10)
    );
END donaciones;
/



--### Paquete auditorias

CREATE OR REPLACE PACKAGE auditorias AS
    PROCEDURE adicionar(
        p_id IN CHAR(10),
        p_fecha IN DATE,
        p_actividad IN VARCHAR2(255)
    );

    PROCEDURE eliminar(
        p_id IN CHAR(10)
    );

   

 PROCEDURE consultar(
        p_id IN CHAR(10)
    );
END auditorias;
/

