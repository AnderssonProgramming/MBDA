-------------PK_DOMICILIARIO-----------
 
CREATE OR REPLACE PACKAGE PK_DOMICILIARIO AS
		PROCEDURE print_consultar_envios;
		PROCEDURE adicionarDomiciliario(p_nombre IN VARCHAR2, p_direccion IN VARCHAR2, p_duracion IN NUMBER, p_correo IN VARCHAR2);
		PROCEDURE printConsultarDomiciliarios;
END PK_DOMICILIARIO;
/ 



-------------PK_GERENTE-----------------------
 
CREATE OR REPLACE PACKAGE PK_GERENTE AS
		PROCEDURE printConsultarAuditorias;
END PK_GERENTE;
/ 




-----------------PK_CONSUMIDOR-------------------------------

CREATE OR REPLACE PACKAGE PK_CONSUMIDOR AS
	---------Consumidor---------------
	PROCEDURE adicionar_consumidor(    
        p_nombre IN CHAR,
        p_preferencia IN VARCHAR2,
        p_correo IN VARCHAR2
	);
	
	PROCEDURE modificar_consumidor(
    p_id_consumidor IN CHAR,
        p_columna IN VARCHAR2,
        p_nuevo_valor IN VARCHAR2
    );

    PROCEDURE eliminar_consumidor(
        p_id IN CHAR
    );
    
    PROCEDURE print_consultar_consumidores;  
	
	
	----------Empresa-----------------
	PROCEDURE print_consultar_empresas;
	
	
	--------CarritosCompras -------------
	
	PROCEDURE registrar_carrito(        
        p_id_consumidor IN CHAR
    );

    PROCEDURE modificar_carrito(
        p_id_carrito IN VARCHAR2,
        p_columna IN VARCHAR2,
        p_nuevo_valor IN VARCHAR2
    );

    PROCEDURE print_consultar_carritos;
    
    ---------CarritosMenus----------
	
	
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
	
    PROCEDURE printconsultar_menus_en_carritos;
	
	
	-----------CALIFICACIONES---------------------
	
	PROCEDURE adicionarCalificacion(p_cantidadEstrellas IN NUMBER, p_comentario IN VARCHAR2, p_idPedido IN VARCHAR2);
    PROCEDURE modificarCalificacion(p_id IN VARCHAR2, p_columna IN VARCHAR2, p_nuevoValor IN VARCHAR2);
    PROCEDURE eliminarCalificacion(p_id IN VARCHAR2);
    PROCEDURE printConsultarCalificaciones;
	
	
	--------------MENUSALEATORIOS-----------------
	
	PROCEDURE print_consultar_menus_aleatorios;
	
	
	-------------PLATOS-----------------------
	
	PROCEDURE print_consultar_platos;
	
	
	
	-----------MENUSPLATOS--------------------
	
	PROCEDURE print_consultar_platos_de_menus_aleatorios;
	
	
	----------ENVIOS----------------------
	
	PROCEDURE print_consultar_envios;
	
	
	
	-----------------PEDIDOS-------------------
	
    PROCEDURE print_consultar_pedidos;
	
	
	------------FACTURAS----------------
	
	PROCEDURE printConsultarFacturas;
	
	
	--------------BONOSDELIZIA------------
	
	PROCEDURE print_consultar_bonos_delizia;
	
	
	--------------TIPOSBONO------------
	
	PROCEDURE print_consultar_tipos_bonos;
	
	
	
END PK_CONSUMIDOR;
/








-----------------PK_EMPRESA-------------------------------

CREATE OR REPLACE PACKAGE PK_EMPRESA AS

	----------EMPRESAS--------------
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
    
    PROCEDURE print_consultar_empresas;
    
    
	----------CONSUMIDORES--------------
	
	PROCEDURE print_consultar_consumidores;
	
	
	----------MENUSALEATORIOS-------------------------------
	
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
    
    PROCEDURE print_consultar_menus_aleatorios;
	
	
	----------PLATOS--------------
	
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

    PROCEDURE print_consultar_platos;
    
    PROCEDURE modificar_platos_fecha_caducidad_plato_platos_empresa(
        p_id_plato IN VARCHAR2,
        p_fecha_caducidad DATE
        );
	
	----------CARRITOSMENUS--------------
	
	PROCEDURE printconsultar_menus_en_carritos;
	
	----------CALIFICACIONES--------------
	
	PROCEDURE printConsultarCalificaciones;
	
	----------ENVIOS--------------
	
	PROCEDURE adicionar_envio(
        p_id_pedido IN VARCHAR2
    );

    PROCEDURE modificar_envio(
        p_id_envio IN VARCHAR2,
        p_columna IN VARCHAR2,
        p_nuevo_valor IN VARCHAR2
    );

    PROCEDURE print_consultar_envios;
	
	----------TIPOSBONO--------------
	
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

    PROCEDURE print_consultar_tipos_bonos;
	
	----------DOMICILIARIOS--------------
	
	PROCEDURE adicionarDomiciliario(p_nombre IN VARCHAR2, p_direccion IN VARCHAR2, p_duracion IN NUMBER, p_correo IN VARCHAR2);
    PROCEDURE modificarDomiciliario(p_id IN VARCHAR2, p_columna IN VARCHAR2, p_nuevoValor IN VARCHAR2);    
    PROCEDURE printConsultarDomiciliarios;
	
	----------PEDIDOS--------------
	
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
    
    PROCEDURE print_consultar_pedidos;
	
	----------FACTURAS--------------
	
	PROCEDURE adicionarFactura(        
        p_id_consumidor IN CHAR,                
        p_id_bono IN VARCHAR2,
        p_id_pedido IN VARCHAR2
    );
 
    
    PROCEDURE printConsultarFacturas;
 
    PROCEDURE print_consultar_bonos(p_id_consumidor IN CHAR);
	
	
	----------BONOSDELIZIA--------------
	
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

    PROCEDURE print_consultar_bonos_delizia;
	
	
	----------MENUSPLATOS--------------
	
	PROCEDURE adicionar_plato_a_menu_aleatorio(
        p_id_menu_aleatorio IN VARCHAR2,
        p_id_plato IN VARCHAR2
    );
    
    PROCEDURE eliminar__plato_a_menu_aleatorio(
        p_id_menu IN VARCHAR2,
        p_id_plato IN VARCHAR2
    );
    
    PROCEDURE print_consultar_platos_de_menus_aleatorios;
	
	
	
	----------DONACIONES--------------
	
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

    
    PROCEDURE print_consultar_donaciones;
	
	----------AUDITORIAS--------------
	
	PROCEDURE printConsultarAuditorias;
	
END PK_EMPRESA;
/