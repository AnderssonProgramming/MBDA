ALTER TABLE clientes
ADD CONSTRAINT PK_clientes PRIMARY KEY (id);

ALTER TABLE direcciones_Cliente
ADD CONSTRAINT PK_direcciones_Cliente PRIMARY KEY (id);

ALTER TABLE celulares_Cliente
ADD CONSTRAINT PK_celulares_Cliente PRIMARY KEY (id); 

ALTER TABLE consumidores
ADD CONSTRAINT PK_consumidores PRIMARY KEY (id);

ALTER TABLE empresas
ADD CONSTRAINT PK_empresas PRIMARY KEY (nit);

ALTER TABLE auditorias_delizia
ADD CONSTRAINT PK_auditorias_delizia PRIMARY KEY (id);

ALTER TABLE donaciones
ADD CONSTRAINT PK_donaciones PRIMARY KEY (id);

ALTER TABLE carritosCompras
ADD CONSTRAINT PK_carritosCompras PRIMARY KEY (id);

ALTER TABLE menusAleatorios
ADD CONSTRAINT PK_menusAleatorios PRIMARY KEY (id);

ALTER TABLE platos
ADD CONSTRAINT PK_platos PRIMARY KEY (id);

ALTER TABLE menus_platos
ADD CONSTRAINT PK_menus_platos PRIMARY KEY (idMenuAleatorio,idPlato);

ALTER TABLE carritosMenus
ADD CONSTRAINT PK_carritosMenus PRIMARY KEY (idCarrito, idMenu);

ALTER TABLE pedidos
ADD CONSTRAINT PK_pedidos PRIMARY KEY (id);

ALTER TABLE calificaciones_delizia
ADD CONSTRAINT PK_calificaciones_delizia PRIMARY KEY (id);

ALTER TABLE facturas
ADD CONSTRAINT PK_facturas PRIMARY KEY (id);

ALTER TABLE envios
ADD CONSTRAINT PK_envios PRIMARY KEY (id);

ALTER TABLE bonos_delizia
ADD CONSTRAINT PK_bonos_delizia PRIMARY KEY (id);

ALTER TABLE domiciliarios
ADD CONSTRAINT PK_domiciliarios PRIMARY KEY (id);

ALTER TABLE tiposBono
ADD CONSTRAINT PK_tiposBono PRIMARY KEY (id);

ALTER TABLE platos_empresas
ADD CONSTRAINT PK_platos_empresas PRIMARY KEY (idPlato,nitEmpresa,fechaCaducidad);