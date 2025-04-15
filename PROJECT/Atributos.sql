------------------------------Clientes:

ALTER TABLE clientes
ADD CONSTRAINT CHK_Correo_Valido
CHECK (
    Correo LIKE '%@%' AND
    Correo NOT LIKE '%@%@%' AND
    Correo LIKE '%.%'
);
 
------------------------------Direcciones
ALTER TABLE direcciones_Cliente
ADD CONSTRAINT CHK_Direccion_Valida
CHECK (
    LENGTH(direccionCliente) <= 50 AND 
    direccionCliente LIKE '%Calle%' AND 
    direccionCliente LIKE '%Numero%' AND 
    direccionCliente LIKE '%Ciudad%'

);

--------------------------------Empresas
             

---------------------------------CarritoCompras
ALTER TABLE carritosCompras
ADD CONSTRAINT CHK_PrecioPositivo
CHECK (precio > 0);

---------------------------------Auditorias
ALTER TABLE auditorias_delizia
ADD CONSTRAINT CHK1_platos_vendidos
CHECK (platos_vendidos >= 0);

ALTER TABLE auditorias_delizia
ADD CONSTRAINT CHK1_platos_por_vender
CHECK (platos_por_vender >= 0);

ALTER TABLE auditorias_delizia
ADD CONSTRAINT CHK1_ganancias
CHECK (ganancias >= 0);

ALTER TABLE auditorias_delizia
ADD CONSTRAINT CHK1_perdidas 
CHECK (perdidas  >= 0);


---------------------------------Donaciones
ALTER TABLE donaciones
ADD CONSTRAINT CHK_estado_Donacion
CHECK (
    tipo IN ('P', 'D')
);

ALTER TABLE donaciones
ADD CONSTRAINT CHK_PrecioPositivoD
CHECK (cantidad >= 0);

---------------------------------MenusAleatorios
ALTER TABLE menusAleatorios
ADD CONSTRAINT CHK2_PrecioPositivo
CHECK (precio > 0);

/*
ALTER TABLE menusAleatorios
ADD CONSTRAINT CHK_tipo_Menu
CHECK (
    tipo IN ('E', 'P','A')
);
*/

--------------------------------Plato
ALTER TABLE platos
ADD CONSTRAINT CHK3_PrecioPositivo
CHECK (precio > 0);

--------------------------------Pedido
ALTER TABLE pedidos
ADD CONSTRAINT CHK_estado_Pedido
CHECK (
    estado IN ('P', 'A','C','E')
);

ALTER TABLE pedidos
ADD CONSTRAINT CHK_Direccion2_Valida
CHECK (
    LENGTH(direccionConsumidor) <= 50 AND
    direccionConsumidor LIKE '%Calle%' AND
    direccionConsumidor LIKE '%Numero%' AND
    direccionConsumidor LIKE '%Ciudad%'
);

ALTER TABLE pedidos
ADD CONSTRAINT CHK_PrecioPositivoP
CHECK (costo > 0);

----------------------------------Factura
ALTER TABLE facturas
ADD CONSTRAINT CHK4_PrecioPositivo
CHECK (total > 0);

-----------------------------------Envio
ALTER TABLE envios
ADD CONSTRAINT CHK_estado_Envio
CHECK (
    estado IN ('C', 'E','R','P')
);

ALTER TABLE envios
ADD CONSTRAINT CHK_PrecioPositivoE
CHECK (costo > 0);

---------------------------------Bonos
ALTER TABLE bonos_delizia
ADD CONSTRAINT CHK5_PrecioPositivo
CHECK (valor > 0);

ALTER TABLE bonos_delizia
ADD CONSTRAINT CHK6_PrecioPositivo
CHECK (porcentajeDescuento > 0 AND porcentajeDescuento <= 100);

ALTER TABLE bonos_delizia
ADD CONSTRAINT CHK_estado_bono_delizia
CHECK (
    estado IN ('ACTIVO','INACTIVO')
);

----------------------------------Domiciliario
ALTER TABLE domiciliarios
ADD CONSTRAINT CHK_Direccion3_Valida
CHECK (
    LENGTH(direccion) <= 50 AND
    direccion LIKE '%Calle%' AND
    direccion LIKE '%Numero%' AND
    direccion LIKE '%Ciudad%'
);

ALTER TABLE domiciliarios
ADD CONSTRAINT CHK1_Correo_Valido
CHECK (
    correo LIKE '%@%' AND
    correo NOT LIKE '%@%@%' AND
    correo LIKE '%.%'
);

ALTER TABLE domiciliarios
ADD CONSTRAINT CHK1_duracion_pedido
CHECK (duracion > 0);

----------------------------------calificaciones
ALTER TABLE calificaciones_delizia
ADD CONSTRAINT CHK_calificaciones_5_estrellas
CHECK (cantidadEstrellas >= 1 AND cantidadEstrellas <5);

----------------------------------PLATOS_EMPRESAS
ALTER TABLE platos_empresas 
ADD CONSTRAINT CH_unidades_disponibles_positivas
CHECK (unidadesDisponibles >= 0);

ALTER TABLE platos_empresas 
ADD CONSTRAINT CH_unidades_vendidas_positivas
CHECK (unidadesVendidas >= 0);