ALTER TABLE clientes
ADD CONSTRAINT UK2_clientes UNIQUE (correo);

ALTER TABLE empresas
ADD CONSTRAINT UK_empresas UNIQUE (nombre);

-- ALTER TABLE pedidos
-- ADD CONSTRAINT UK_calificacion UNIQUE (idCalificacion);

ALTER TABLE calificaciones_delizia 
ADD CONSTRAINT UK_calificacion_pedido UNIQUE (idpedido)
