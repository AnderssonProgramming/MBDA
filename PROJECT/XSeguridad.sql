--Elimina los paquetes de seguridad

-- Drop package PK_DOMICILIARIO
DROP PACKAGE PK_DOMICILIARIO;

-- Drop package PK_GERENTE
DROP PACKAGE PK_GERENTE;

-- Drop package PK_CONSUMIDOR
DROP PACKAGE PK_CONSUMIDOR;

-- Drop package PK_EMPRESA
DROP PACKAGE PK_EMPRESA;



-- Eliminar los roles
DROP ROLE consumidor;
DROP ROLE empresa;
DROP ROLE domiciliario;
DROP ROLE gerenteDelizia;


-- Revocar permisos del rol consumidor
REVOKE SELECT, INSERT, UPDATE ON consumidores FROM consumidor;
REVOKE SELECT ON empresas FROM consumidor;
REVOKE SELECT, INSERT, UPDATE ON carritosCompras FROM consumidor;
REVOKE SELECT, INSERT, UPDATE ON carritosMenus FROM consumidor;
REVOKE SELECT ON menusAleatorios FROM consumidor;
REVOKE SELECT ON platos FROM consumidor;
REVOKE SELECT ON envios FROM consumidor;
REVOKE SELECT ON pedidos FROM consumidor;
REVOKE SELECT ON facturas FROM consumidor;
REVOKE SELECT ON bonos_delizia FROM consumidor;
REVOKE SELECT ON menus_platos FROM consumidor;
REVOKE SELECT ON tiposBono FROM consumidor;
REVOKE SELECT, INSERT, UPDATE ON calificaciones_delizia FROM consumidor;

-- Revocar permisos del rol empresa
REVOKE SELECT, INSERT, UPDATE ON empresas FROM empresa;
REVOKE SELECT ON consumidores FROM empresa;
REVOKE SELECT, INSERT, UPDATE ON menusAleatorios FROM empresa;
REVOKE SELECT, INSERT, UPDATE ON platos FROM empresa;
REVOKE SELECT ON carritosMenus FROM empresa;
REVOKE SELECT ON calificaciones_delizia FROM empresa;
REVOKE SELECT, INSERT, UPDATE ON envios FROM empresa;
REVOKE SELECT, INSERT, UPDATE ON tiposBono FROM empresa;
REVOKE SELECT, INSERT, UPDATE ON domiciliarios FROM empresa;
REVOKE SELECT, INSERT, UPDATE ON pedidos FROM empresa;
REVOKE SELECT, INSERT, UPDATE ON facturas FROM empresa;
REVOKE SELECT, INSERT, UPDATE ON bonos_delizia FROM empresa;
REVOKE SELECT, INSERT, UPDATE ON menus_platos FROM empresa;
REVOKE SELECT, INSERT, UPDATE ON platos_empresas FROM empresa;
REVOKE SELECT, INSERT, UPDATE ON donaciones FROM empresa;
REVOKE SELECT ON auditorias_delizia FROM empresa;

-- Revocar permisos del rol domiciliario
REVOKE SELECT ON envios FROM domiciliario;
REVOKE SELECT, INSERT ON domiciliarios FROM domiciliario;

-- Revocar permisos del rol gerenteDelizia
REVOKE SELECT ON auditorias_delizia FROM gerenteDelizia;
