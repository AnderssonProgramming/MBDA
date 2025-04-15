ALTER TABLE envios
ADD CONSTRAINT CK_fecha_fechaEntrega
CHECK (fecha <= fechaEntrega);
