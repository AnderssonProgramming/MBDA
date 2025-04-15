-- Paquete domiciliario
CREATE OR REPLACE PACKAGE BODY PK_DOMICILIARIO AS
		PROCEDURE print_consultar_envios AS
		BEGIN
			PK_ENVIOS.print_consultar_envios;
		END print_consultar_envios;
		----
		PROCEDURE adicionarDomiciliario(p_nombre IN VARCHAR2, p_direccion IN VARCHAR2, p_duracion IN NUMBER, p_correo IN VARCHAR2)AS
		BEGIN
			PK_DOMICILIARIOS.adicionarDomiciliario(p_nombre, p_direccion, p_duracion, p_correo);
		END adicionarDomiciliario;
		PROCEDURE printConsultarDomiciliarios AS
		BEGIN
			PK_DOMICILIARIOS.printConsultarDomiciliarios;
		END printConsultarDomiciliarios;
END PK_DOMICILIARIO;


CREATE OR REPLACE PACKAGE BODY PK_GERENTE AS
		PROCEDURE printConsultarAuditorias AS
		BEGIN
			PK_AUDITORIAS_DELIZIA.printConsultarAuditorias;
		END printConsultarAuditorias;
END PK_GERENTE;



-- Paquete consumidor
CREATE OR REPLACE PACKAGE BODY PK_CONSUMIDOR AS
	--------Consumidor-----------
	PROCEDURE adicionar_consumidor(    
        p_nombre IN CHAR,
        p_preferencia IN VARCHAR2,
        p_correo IN VARCHAR2)
	AS
	BEGIN
		PK_CONSUMIDORES.adicionar_consumidor(p_nombre,p_preferencia,p_correo);
	END adicionar_consumidor;
	
	PROCEDURE modificar_consumidor(
		p_id_consumidor IN CHAR,
        p_columna IN VARCHAR2,
        p_nuevo_valor IN VARCHAR2)
    AS
	BEGIN
		PK_CONSUMIDORES.modificar_consumidor(p_id_consumidor,p_columna,p_nuevo_valor);
	END modificar_consumidor;

    PROCEDURE eliminar_consumidor(
        p_id IN CHAR)
    AS
	BEGIN
		PK_CONSUMIDORES.eliminar_consumidor(p_id);
	END eliminar_consumidor;
    
    PROCEDURE print_consultar_consumidores
	AS
	BEGIN
		PK_CONSUMIDORES.print_consultar_consumidores;
	END print_consultar_consumidores;
	
	--------Empresa---------------------
	
	PROCEDURE print_consultar_empresas AS
	BEGIN
		PK_EMPRESAS.print_consultar_empresas;
	END print_consultar_empresas;
	
	
	--------CarritosCompras-------------
	
	PROCEDURE registrar_carrito(        
        p_id_consumidor IN CHAR)
    AS
	BEGIN
		PK_CARRITOS_COMPRAS.registrar_carrito(p_id_consumidor);
	END registrar_carrito;

    PROCEDURE modificar_carrito(
        p_id_carrito IN VARCHAR2,
        p_columna IN VARCHAR2,
        p_nuevo_valor IN VARCHAR2)
    AS
	BEGIN
		PK_CARRITOS_COMPRAS.modificar_carrito(p_id_carrito,p_columna,p_nuevo_valor);
	END modificar_carrito;                    
  
    PROCEDURE print_consultar_carritos AS
	BEGIN 
		PK_CARRITOS_COMPRAS.print_consultar_carritos;
	END print_consultar_carritos;
	
    
    ---------CarritosMenus----------
	
	
    PROCEDURE registrar_menu_a_carrito(
		p_id_carrito IN VARCHAR2,
		p_id_menu IN VARCHAR2,				
		p_nit_empresa IN CHAR)
	AS 
	BEGIN 
		PK_CARRITOS_COMPRAS.registrar_menu_a_carrito(p_id_carrito,p_id_menu,p_nit_empresa);
	END registrar_menu_a_carrito;
		
    PROCEDURE eliminar_menu_de_carrito(
			p_id IN VARCHAR2)
	AS
	BEGIN
		PK_CARRITOS_COMPRAS.eliminar_menu_de_carrito(p_id);
	END eliminar_menu_de_carrito;
			
    PROCEDURE vaciar_carrito(
			p_id_carrito IN VARCHAR2)
	AS
	BEGIN
		PK_CARRITOS_COMPRAS.vaciar_carrito(p_id_carrito);
	END vaciar_carrito;
	

    PROCEDURE printconsultar_menus_en_carritos AS
	BEGIN
		PK_CARRITOS_COMPRAS.printconsultar_menus_en_carritos;
	END printconsultar_menus_en_carritos;
	
	
	---------------CALIFICACIONES---------------------
	PROCEDURE adicionarCalificacion(
		p_cantidadEstrellas IN NUMBER, 
		p_comentario IN VARCHAR2, 
		p_idPedido IN VARCHAR2)
	AS 
	BEGIN 
		PK_CALIFICACIONES_DELIZIA.adicionarCalificacion(p_cantidadEstrellas,p_comentario,p_idPedido);
	END adicionarCalificacion;
	
	
    PROCEDURE modificarCalificacion(
		p_id IN VARCHAR2, 
		p_columna IN VARCHAR2, 
		p_nuevoValor IN VARCHAR2)
	AS
	BEGIN
		PK_CALIFICACIONES_DELIZIA.modificarCalificacion(p_id,p_columna,p_nuevoValor);
	END modificarCalificacion;
	
	
    PROCEDURE eliminarCalificacion(p_id IN VARCHAR2)AS
	BEGIN
		PK_CALIFICACIONES_DELIZIA.eliminarCalificacion(p_id);
	END eliminarCalificacion;
	
	
    PROCEDURE printConsultarCalificaciones AS
	BEGIN
		PK_CALIFICACIONES_DELIZIA.printConsultarCalificaciones;
	END printConsultarCalificaciones;
	
	
	--------------MENUSALEATORIOS-----------------
	
	PROCEDURE print_consultar_menus_aleatorios AS
	BEGIN
		PK_MENUS_ALEATORIOS.print_consultar_menus_aleatorios;
	END print_consultar_menus_aleatorios;
	
	
	-------------PLATOS-----------------------
	
	PROCEDURE print_consultar_platos
	AS
	BEGIN
		PK_PLATOS.print_consultar_platos;
	END print_consultar_platos;
	
	
	-----------MENUSPLATOS--------------------
	
	PROCEDURE print_consultar_platos_de_menus_aleatorios
	AS
	BEGIN
		PK_MENUS_ALEATORIOS.print_consultar_platos_de_menus_aleatorios;
	END print_consultar_platos_de_menus_aleatorios;
	
	
	----------ENVIOS----------------------
	
	PROCEDURE print_consultar_envios
	AS 
	BEGIN
		PK_ENVIOS.print_consultar_envios;
	END print_consultar_envios;
	
	
	
	---------PEDIDOS-------------------
	
	PROCEDURE print_consultar_pedidos
	AS
	BEGIN
		PK_PEDIDOS.print_consultar_pedidos;
	END print_consultar_pedidos;
	
	
	----------FACTURAS----------------
	
	PROCEDURE printConsultarFacturas
	AS
	BEGIN
		PK_FACTURAS.printConsultarFacturas;
	END printConsultarFacturas;
	
	
	--------------BONOSDELIZIA------------
	
	PROCEDURE print_consultar_bonos_delizia
	AS 
	BEGIN
		PK_BONOS_DELIZIA.print_consultar_bonos_delizia;
	END print_consultar_bonos_delizia;
	
	
	--------------TIPOSBONO------------
	
	PROCEDURE print_consultar_tipos_bonos
	AS
	BEGIN
		PK_TIPOS_BONO.print_consultar_tipos_bonos;
	END print_consultar_tipos_bonos;
	    
END PK_CONSUMIDOR;
/


-- Paquete empresa
CREATE OR REPLACE PACKAGE BODY PK_EMPRESA AS


	----------EMPRESAS--------------
	
	PROCEDURE adicionar_empresa(    
        p_nombre IN CHAR,
        p_tipoNegocio IN VARCHAR2,
        p_correo IN VARCHAR2)
	AS
	BEGIN 
		PK_EMPRESAS.adicionar_empresa(p_nombre,p_tipoNegocio,p_correo);
	END adicionar_empresa;

    PROCEDURE modificar_empresa(
		p_nit_empresa IN CHAR,
        p_columna IN VARCHAR2,
        p_nuevo_valor IN VARCHAR2)
	AS
	BEGIN
		PK_EMPRESAS.modificar_empresa(p_nit_empresa,p_columna,p_nuevo_valor);
	END modificar_empresa;
   

    PROCEDURE eliminar_empresa(
        p_nit_empresa IN CHAR)
	AS
	BEGIN
		PK_EMPRESAS.eliminar_empresa(p_nit_empresa);
	END eliminar_empresa;
    
    
    PROCEDURE print_consultar_empresas
	AS
	BEGIN
		PK_EMPRESAS.print_consultar_empresas;
	END print_consultar_empresas;
	
	
	----------CONSUMIDORES--------------
	
	PROCEDURE print_consultar_consumidores
	AS
	BEGIN
		PK_CONSUMIDORES.print_consultar_consumidores;
	END print_consultar_consumidores;

	
	
	----------MENUSALEATORIOS-------------------------------
	
	
	PROCEDURE adicionar_menu_aleatorio(            
        p_nit_empresa IN CHAR,
        p_tipo IN VARCHAR2,
        p_precio IN NUMBER,
        p_nombre IN VARCHAR2)
	AS
	BEGIN
		PK_MENUS_ALEATORIOS.adicionar_menu_aleatorio(p_nit_empresa,p_tipo,p_precio,p_nombre);
	END adicionar_menu_aleatorio;
  

    PROCEDURE modificar_menu_aleatorio(
        p_id IN VARCHAR2,
        p_columna IN VARCHAR2,
        p_nuevo_valor IN VARCHAR2)
	AS
	BEGIN
		PK_MENUS_ALEATORIOS.modificar_menu_aleatorio(p_id,p_columna,p_nuevo_valor);
	END modificar_menu_aleatorio;
    

    PROCEDURE eliminar_menu_aleatorio(
        p_id IN VARCHAR2)
	AS
	BEGIN
		PK_MENUS_ALEATORIOS.eliminar_menu_aleatorio(p_id);
	END eliminar_menu_aleatorio;
    
    
    PROCEDURE print_consultar_menus_aleatorios
	AS
	BEGIN
		PK_MENUS_ALEATORIOS.print_consultar_menus_aleatorios;
	END print_consultar_menus_aleatorios;
	
	
	----------PLATOS--------------
	
	PROCEDURE adicionar_platos(    
        p_nombre IN VARCHAR2,
        p_precio IN NUMBER,
        p_nit_empresa IN CHAR)
	AS
	BEGIN
		PK_PLATOS.adicionar_platos(p_nombre,p_precio,p_nit_empresa);
	END adicionar_platos;
    

    PROCEDURE modificar_platos(
        p_id_plato IN VARCHAR2,
        p_columna IN VARCHAR2,
        p_nuevo_valor IN VARCHAR2)
	AS
	BEGIN
		PK_PLATOS.modificar_platos(p_id_plato,p_columna,p_nuevo_valor);
	END modificar_platos;
    

    PROCEDURE eliminar_platos(
        p_id_plato IN VARCHAR2)
	AS
	BEGIN
		PK_PLATOS.eliminar_platos(p_id_plato);
	END eliminar_platos;
    

    PROCEDURE print_consultar_platos
	AS
	BEGIN
		PK_PLATOS.print_consultar_platos;
	END print_consultar_platos;
    
    PROCEDURE modificar_platos_fecha_caducidad_plato_platos_empresa(
        p_id_plato IN VARCHAR2,
        p_fecha_caducidad DATE)
	AS
	BEGIN
		PK_PLATOS.modificar_platos_fecha_caducidad_plato_platos_empresa(p_id_plato,p_fecha_caducidad);
	END modificar_platos_fecha_caducidad_plato_platos_empresa;
	
	----------CARRITOSMENUS--------------
	
	PROCEDURE printconsultar_menus_en_carritos
	AS
	BEGIN
		PK_CARRITOS_COMPRAS.printconsultar_menus_en_carritos;
	END printconsultar_menus_en_carritos;
	
	----------CALIFICACIONES--------------
	
	PROCEDURE printConsultarCalificaciones
	AS
	BEGIN
		PK_CALIFICACIONES_DELIZIA.printConsultarCalificaciones;
	END printConsultarCalificaciones;
	
	----------ENVIOS--------------
	
	PROCEDURE adicionar_envio(
        p_id_pedido IN VARCHAR2)
    AS
	BEGIN
		PK_ENVIOS.adicionar_envio(p_id_pedido);
	END adicionar_envio;

    PROCEDURE modificar_envio(
        p_id_envio IN VARCHAR2,
        p_columna IN VARCHAR2,
        p_nuevo_valor IN VARCHAR2)
    AS
	BEGIN
		PK_ENVIOS.modificar_envio(p_id_envio,p_columna,p_nuevo_valor);
	END modificar_envio;

    PROCEDURE print_consultar_envios
	AS
	BEGIN
		PK_ENVIOS.print_consultar_envios;
	END print_consultar_envios;
	
	----------TIPOSBONO--------------
	
	PROCEDURE adicionar_tipo_bono(
        p_descripcion IN VARCHAR2,
        p_nombre_bono IN VARCHAR2,
        p_nit_empresa IN CHAR,
        p_porcentaje_descuento IN NUMBER,
        p_estado IN VARCHAR2,
        p_fecha_expiracion IN DATE)
	AS
	BEGIN
		PK_TIPOS_BONO.adicionar_tipo_bono(p_descripcion,p_nombre_bono,p_nit_empresa,p_porcentaje_descuento,p_estado,p_fecha_expiracion);
	END adicionar_tipo_bono;
    

    PROCEDURE modificar_tipo_bono(
        p_id_tipo_bono IN VARCHAR2,
        p_columna IN VARCHAR2,
        p_nuevo_valor IN VARCHAR2)
	AS
	BEGIN
		PK_TIPOS_BONO.modificar_tipo_bono(p_id_tipo_bono,p_columna,p_nuevo_valor);
	END modificar_tipo_bono;
    

    PROCEDURE eliminar_tipo_bono(
        p_id_tipo_bono IN VARCHAR2)
	AS
	BEGIN
		PK_TIPOS_BONO.eliminar_tipo_bono(p_id_tipo_bono);
	END eliminar_tipo_bono;
    

    PROCEDURE print_consultar_tipos_bonos
	AS
	BEGIN
		PK_TIPOS_BONO.print_consultar_tipos_bonos;
	END print_consultar_tipos_bonos;
	
	----------DOMICILIARIOS--------------
	
	
	PROCEDURE adicionarDomiciliario(
		p_nombre IN VARCHAR2, 
		p_direccion IN VARCHAR2, 
		p_duracion IN NUMBER, 
		p_correo IN VARCHAR2)
	AS
	BEGIN 
		PK_DOMICILIARIOS.adicionarDomiciliario(p_nombre,p_direccion,p_duracion,p_correo);
	END adicionarDomiciliario;
	
    PROCEDURE modificarDomiciliario(
		p_id IN VARCHAR2, 
		p_columna IN VARCHAR2, 
		p_nuevoValor IN VARCHAR2)
	AS
	BEGIN
		PK_DOMICILIARIOS.modificarDomiciliario(p_id,p_columna,p_nuevoValor);
	END modificarDomiciliario;
	
	
    PROCEDURE printConsultarDomiciliarios
	AS
	BEGIN
		PK_DOMICILIARIOS.printConsultarDomiciliarios;
	END printConsultarDomiciliarios;
	
	
	----------PEDIDOS--------------
	
	PROCEDURE registrar_pedido(
        p_id_consumidor IN CHAR,        
        p_id_carrito_compras IN VARCHAR,
        p_envio IN NUMBER)
	AS
	BEGIN
		PK_PEDIDOS.registrar_pedido(p_id_consumidor,p_id_carrito_compras,p_envio);
	END registrar_pedido;
    

    PROCEDURE modificar_pedido(
        p_id_pedido IN VARCHAR2,
        p_columna IN VARCHAR2,
        p_nuevo_valor IN VARCHAR2)
	AS
	BEGIN
		PK_PEDIDOS.modificar_pedido(p_id_pedido,p_columna,p_nuevo_valor);
	END modificar_pedido;
    
    
    PROCEDURE print_consultar_pedidos
	AS
	BEGIN
		PK_PEDIDOS.print_consultar_pedidos;
	END print_consultar_pedidos;
	
	----------FACTURAS--------------
	
	PROCEDURE adicionarFactura(        
        p_id_consumidor IN CHAR,                
        p_id_bono IN VARCHAR2,
        p_id_pedido IN VARCHAR2)
    AS
	BEGIN
		PK_FACTURAS.adicionarFactura(p_id_consumidor,p_id_bono,p_id_pedido);
	END adicionarFactura;
 
    
    PROCEDURE printConsultarFacturas
	AS
	BEGIN
		PK_FACTURAS.printConsultarFacturas;
	END printConsultarFacturas;
 
    PROCEDURE print_consultar_bonos(p_id_consumidor IN CHAR)
	AS
	BEGIN
		PK_FACTURAS.print_consultar_bonos(p_id_consumidor);
	END print_consultar_bonos;
	
	----------BONOSDELIZIA--------------
	
	PROCEDURE registrar_bono(
        p_id_consumidor IN CHAR,
        p_id_tipo_bono IN VARCHAR2)
	AS
	BEGIN
		PK_BONOS_DELIZIA.registrar_bono(p_id_consumidor,p_id_tipo_bono);
	END registrar_bono;
    

    PROCEDURE modificar_bono(
        p_id_bono IN VARCHAR2,
        p_columna IN VARCHAR2,
        p_nuevo_valor IN VARCHAR2)
    AS
	BEGIN
		PK_BONOS_DELIZIA.modificar_bono(p_id_bono,p_columna,p_nuevo_valor);
	END modificar_bono;

    PROCEDURE eliminar_bono(
        p_id_bono IN VARCHAR2)
	AS
	BEGIN
		PK_BONOS_DELIZIA.eliminar_bono(p_id_bono);
	END eliminar_bono;
    

    PROCEDURE print_consultar_bonos_delizia
	AS
	BEGIN
		PK_BONOS_DELIZIA.print_consultar_bonos_delizia;
	END print_consultar_bonos_delizia;
	
	----------MENUSPLATOS--------------
	
	PROCEDURE adicionar_plato_a_menu_aleatorio(
        p_id_menu_aleatorio IN VARCHAR2,
        p_id_plato IN VARCHAR2)
	AS
	BEGIN
		PK_MENUS_ALEATORIOS.adicionar_plato_a_menu_aleatorio(p_id_menu_aleatorio,p_id_plato);
	END adicionar_plato_a_menu_aleatorio;
    
    
    PROCEDURE eliminar__plato_a_menu_aleatorio(
        p_id_menu IN VARCHAR2,
        p_id_plato IN VARCHAR2)
	AS
	BEGIN
		PK_MENUS_ALEATORIOS.eliminar__plato_a_menu_aleatorio(p_id_menu,p_id_plato);
	END eliminar__plato_a_menu_aleatorio;
    
    
    PROCEDURE print_consultar_platos_de_menus_aleatorios
	AS
	BEGIN 
		PK_MENUS_ALEATORIOS.print_consultar_platos_de_menus_aleatorios;
	END print_consultar_platos_de_menus_aleatorios;
	
	
	
	----------DONACIONES--------------
	
	PROCEDURE registrar_donacion(        
        p_fecha IN DATE,
        p_cantidad IN NUMBER,
        p_tipo IN VARCHAR2,
        p_nit_empresa IN CHAR)
	AS
	BEGIN
		PK_DONACIONES.registrar_donacion(p_fecha,p_cantidad,p_tipo,p_nit_empresa);
	END registrar_donacion;
    

    PROCEDURE modificar_donacion(
        p_id_donacion IN VARCHAR2,
        p_columna IN VARCHAR2,
        p_nuevo_valor IN VARCHAR2)
	AS
	BEGIN
		PK_DONACIONES.modificar_donacion(p_id_donacion,p_columna,p_nuevo_valor);
	END modificar_donacion;

    PROCEDURE eliminar_donacion(
        p_id_donacion IN VARCHAR2)
	AS
	BEGIN
		PK_DONACIONES.eliminar_donacion(p_id_donacion);
	END eliminar_donacion;
    

    PROCEDURE print_consultar_donaciones
	AS
	BEGIN 
		PK_DONACIONES.print_consultar_donaciones;
	END print_consultar_donaciones;
	
	
	----------AUDITORIAS--------------
	
	PROCEDURE printConsultarAuditorias
	AS
	BEGIN
		PK_AUDITORIAS_DELIZIA.printConsultarAuditorias;
	END printConsultarAuditorias;

END PK_EMPRESA;