CREATE INDEX indexMenu 
ON menusAleatorios(nombre || '_idx') NOLOGGING;

CREATE INDEX indexPedido
ON pedidos(estado);

CREATE INDEX indexPlato 
ON platos(nombre || '_idx') NOLOGGING;