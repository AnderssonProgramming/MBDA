ALTER TABLE consumidores ADD CONSTRAINT FK_consumidores_clientes
FOREIGN KEY (id) REFERENCES clientes(id);

ALTER TABLE empresas ADD CONSTRAINT FK_empresas_clientes
FOREIGN KEY (nit) REFERENCES clientes(id);

ALTER TABLE direcciones_Cliente ADD CONSTRAINT FK_direcciones_Cliente_cliente
FOREIGN KEY (idCliente) REFERENCES clientes(id);

ALTER TABLE celulares_Cliente ADD CONSTRAINT FK_celulares_Cliente_cliente
FOREIGN KEY (idCliente) REFERENCES clientes(id);

ALTER TABLE auditorias_delizia ADD CONSTRAINT FK_auditoriaEmpresa
FOREIGN KEY (nitEmpresa) REFERENCES empresas(nit);

ALTER TABLE carritosCompras ADD CONSTRAINT FK_carritoCompra_consumidor
FOREIGN KEY (idConsumidor) REFERENCES consumidores(id);

ALTER TABLE carritosCompras ADD CONSTRAINT FK_carritoCompra_menuAleatorio
FOREIGN KEY (idMenuAleatorio) REFERENCES menusAleatorios(id); 

ALTER TABLE menusAleatorios ADD CONSTRAINT FK_menuAleatorio_empresa
FOREIGN KEY (nitEmpresa) REFERENCES empresas(nit) ON DELETE CASCADE; 

ALTER TABLE menusAleatorios ADD CONSTRAINT FK_menuAleatorio_plato
FOREIGN KEY (idPlato) REFERENCES platos(id);
--
ALTER TABLE pedidos ADD CONSTRAINT FK_pedidoConsumidor
FOREIGN KEY (idConsumidor) REFERENCES consumidores(id);

ALTER TABLE pedidos ADD CONSTRAINT FK_pedidoCarrito
FOREIGN KEY (idCarritoCompras) REFERENCES carritosCompras(id);

ALTER TABLE pedidos ADD CONSTRAINT FK_pedidoCalificacion
FOREIGN KEY (idCalificacion) REFERENCES calificaciones_delizia(id);

ALTER TABLE pedidos ADD CONSTRAINT FK_pedidoFactura
FOREIGN KEY (idFactura) REFERENCES facturas(id);

ALTER TABLE pedidos ADD CONSTRAINT FK_pedidoEnvio
FOREIGN KEY (idEnvio) REFERENCES envios(id);

ALTER TABLE facturas ADD CONSTRAINT FK_facturasConsumidor
FOREIGN KEY (idConsumidor) REFERENCES consumidores(id);

ALTER TABLE facturas ADD CONSTRAINT FK_facturasBono
FOREIGN KEY (idBono) REFERENCES bonos_delizia(id);

ALTER TABLE envios ADD CONSTRAINT FK_envioDomiciliario
FOREIGN KEY (idDomiciliario) REFERENCES domiciliarios(id);

ALTER TABLE bonos_delizia ADD CONSTRAINT FK_bonoConsumidor
FOREIGN KEY (idConsumidor) REFERENCES consumidores(id);

ALTER TABLE bonos_delizia ADD CONSTRAINT FK_bonoEmpresa
FOREIGN KEY (nitEmpresa) REFERENCES empresas(nit);

ALTER TABLE bonos_delizia ADD CONSTRAINT FK_bono_TipoBono
FOREIGN KEY (idTipoBono) REFERENCES tiposBono(id);

ALTER TABLE platos_empresas ADD CONSTRAINT FK_platos_empresas_Plato
FOREIGN KEY (idPlato) REFERENCES platos(id);

ALTER TABLE platos_empresas ADD CONSTRAINT FK_platos_empresas_Empresa
FOREIGN KEY (nitEmpresa) REFERENCES empresas(nit);

ALTER TABLE platos ADD CONSTRAINT FK_platos_empresa 
FOREIGN KEY (nit_empresa) REFERENCES empresas(nit);

ALTER TABLE carritosMenus ADD CONSTRAINT FK_carritosMenus_carrito
FOREIGN KEY (idCarrito) REFERENCES carritosCompras(id);

ALTER TABLE carritosMenus ADD CONSTRAINT FK_carritosMenus_Menu
FOREIGN KEY (idMenu) REFERENCES menusAleatorios(id);

ALTER TABLE menus_platos ADD CONSTRAINT FK_menus_platos_menu
FOREIGN KEY (idMenuAleatorio) REFERENCES menusAleatorios(id);

ALTER TABLE menus_platos ADD CONSTRAINT FK_menus_platos_platos
FOREIGN KEY (idPlato) REFERENCES platos(id);

ALTER TABLE donaciones ADD CONSTRAINT FK_donaciones_empresas
FOREIGN KEY (nit_empresa) REFERENCES empresas(nit);

ALTER TABLE calificaciones_delizia ADD CONSTRAINT FK_calificaciones_pedidos
FOREIGN KEY (idpedido) REFERENCES pedidos(id);