CREATE VIEW viewPuntoRecogida AS
SELECT e.nit, d.direccionCliente 
FROM empresas e
JOIN direcciones_Cliente d ON e.nit = d.idCliente;


CREATE VIEW auditorias_view AS
    SELECT platos_empresas.nitempresa,SUM(platos_empresas.unidadesvendidas) AS platos_vendidos, SUM(platos_empresas.unidadesdisponibles) as platos_por_vender, SUM(platos_empresas.unidadesdisponibles * platos.precio) as total_perdidas, SUM(platos_empresas.unidadesvendidas *platos.precio) as total_ganancias
    from platos_empresas
    JOIN platos ON platos_empresas.idplato = platos.id
    GROUP BY platos_empresas.nitempresa

CREATE VIEW pedidoConsumidor AS
	SELECT pedidos.id, pedidos.idConsumidor, pedidos.estado,pedidos.idCarritoCompras,pedidos.envio,consumidores.nombre,direcciones_Cliente.direccionCliente
	FROM pedidos 
	JOIN consumidores ON pedidos.idConsumidor = consumidores.id 
	JOIN clientes ON consumidores.id = clientes.id
	JOIN direcciones_Cliente ON direcciones_Cliente.idCliente = clientes.id;

CREATE VIEW envioDomiciliario AS
	SELECT envios.id, envios.fecha, envios.fechaEntrega,envios.estado,envios.idDomiciliario,envios.idPedido,domiciliarios.nombre,domiciliarios.correo,envios.costo
	FROM envios
	JOIN domiciliarios ON envios.idDomiciliario = domiciliarios.id;	
