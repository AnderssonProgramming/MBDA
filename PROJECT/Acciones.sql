ALTER TABLE menusAleatorios ADD CONSTRAINT FK_menuAleatorio_empresa
FOREIGN KEY (nitEmpresa) REFERENCES empresas(nit) ON DELETE CASCADE; 