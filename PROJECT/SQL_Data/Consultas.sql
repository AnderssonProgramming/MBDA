SELECT constraint_name, constraint_type, table_name
FROM user_constraints
WHERE table_name IN ('clientes', 'direcciones_Cliente', 'celulares_Cliente', 'consumidores', 'empresas', 'auditorias', 'donaciones', 'carritosCompras', 'listaProductos', 'menusAleatorios', 'platos', 'pedidos', 'calificaciones', 'facturas', 'envios', 'puntosRecogida', 'horariosAtencion', 'bonos', 'domiciliarios');

SELECT 
    menusaleatorios.nitempresa,
    (SELECT idPlato 
     FROM (
         SELECT idPlato 
         FROM menus_platos mp 
         WHERE mp.idMenuAleatorio = menusAleatorios.id 
         ORDER BY DBMS_RANDOM.VALUE 
     ) 
     WHERE ROWNUM = 1) AS id_plato_aleatorio
FROM 
    facturas 
JOIN 
    pedidos ON facturas.idPedido = pedidos.id
JOIN 
    carritosCompras ON pedidos.idCarritoCompras = carritosCompras.id
JOIN 
    carritosMenus ON carritosMenus.idCarrito = carritosCompras.id
JOIN 
    menusAleatorios ON carritosMenus.idMenu = menusAleatorios.id;


SELECT idPlato 
         FROM menus_platos mp 
         WHERE mp.idMenuAleatorio = 2
         ORDER BY DBMS_RANDOM.VALUE;

SELECT idPlato
FROM (
    SELECT idPlato, ROW_NUMBER() OVER (ORDER BY DBMS_RANDOM.VALUE) AS rn
    FROM menus_platos mp
    WHERE mp.idMenuAleatorio = 1
)
WHERE rn = 1;



SELECT 
    pedidos.idcarritocompras,
    carritosmenus.idmenu,
    carritosmenus.ID_PLATO_ALEATORIO_SELECCIONADO,
    platos.nombre as nombre_plato,
    platos.precio
FROM pedidos
JOIN carritoscompras ON pedidos.idcarritocompras = carritoscompras.id
JOIN carritosmenus ON pedidos.idcarritocompras = carritosmenus.idcarrito
JOIN platos ON carritosmenus.ID_PLATO_ALEATORIO_SELECCIONADO = platos.id;

-- dando solo el valor para un id particular
SELECT     
    SUM(platos.precio) as total_carrito_compra
FROM pedidos
JOIN carritoscompras ON pedidos.idcarritocompras = carritoscompras.id
JOIN carritosmenus ON pedidos.idcarritocompras = carritosmenus.idcarrito
JOIN platos ON carritosmenus.ID_PLATO_ALEATORIO_SELECCIONADO = platos.id WHERE carritosmenus.idcarrito = '1';

-- BONOS DISPONIBLES POR CONSUMIDOR a la fecha actual, es decir, que no ha espirado. 
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
    AND tb.fechaExpiracion > SYSDATE;
