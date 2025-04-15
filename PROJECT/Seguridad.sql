-- ROLES


CREATE ROLE consumidor;
CREATE ROLE empresa;
CREATE ROLE domiciliario;
CREATE ROLE gerenteDelizia;


GRANT SELECT, INSERT, UPDATE ON consumidores TO consumidor;
GRANT SELECT ON empresas TO consumidor;
GRANT SELECT, INSERT, UPDATE ON consumidores TO consumidor;
GRANT SELECT, INSERT, UPDATE ON carritosCompras TO consumidor;
GRANT SELECT, INSERT, UPDATE ON carritosMenus TO consumidor;
GRANT SELECT ON menusAleatorios TO consumidor;
GRANT SELECT ON platos TO consumidor;
GRANT SELECT ON envios TO consumidor;
GRANT SELECT ON pedidos TO consumidor;
GRANT SELECT ON facturas TO consumidor;
GRANT SELECT ON bonos_delizia TO consumidor;
GRANT SELECT ON menus_platos TO consumidor;
GRANT SELECT, INSERT, UPDATE ON consumidores TO consumidor;
GRANT SELECT ON tiposBono TO consumidor;
GRANT SELECT, INSERT, UPDATE ON calificaciones_delizia TO consumidor;

GRANT SELECT, INSERT, UPDATE ON empresas TO empresa;
GRANT SELECT ON consumidores TO empresa;
GRANT SELECT, INSERT, UPDATE ON menusAleatorios TO empresa;
GRANT SELECT, INSERT, UPDATE ON platos TO empresa;
GRANT SELECT ON carritosMenus TO empresa;
GRANT SELECT ON calificaciones_delizia TO empresa;
GRANT SELECT, INSERT, UPDATE ON envios TO empresa;
GRANT SELECT, INSERT, UPDATE ON tiposBono TO empresa;
GRANT SELECT, INSERT, UPDATE ON domiciliarios TO empresa;
GRANT SELECT, INSERT, UPDATE ON pedidos TO empresa;
GRANT SELECT, INSERT, UPDATE ON facturas TO empresa;
GRANT SELECT, INSERT, UPDATE ON bonos_delizia TO empresa;
GRANT SELECT, INSERT, UPDATE ON menus_platos TO empresa;
GRANT SELECT, INSERT, UPDATE ON platos_empresas TO empresa;
GRANT SELECT, INSERT, UPDATE ON donaciones TO empresa;
GRANT SELECT ON auditorias_delizia TO empresa;

GRANT SELECT ON envios TO domiciliario;
GRANT SELECT, INSERT ON domiciliarios TO domiciliario;

GRANT SELECT ON auditorias_delizia TO gerenteDelizia;