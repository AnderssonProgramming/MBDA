-- === CICLO 1: TABLAS

CREATE TABLE clientes (
    id CHAR(10) NOT NULL,
    idDireccion VARCHAR2(10) NOT NULL,
    correo VARCHAR2(50),
    idCelular CHAR(10) NOT NULL 
    );
    
CREATE TABLE direcciones_Cliente (
    id CHAR(10) NOT NULL,
    direccionCliente1 VARCHAR(50) NOT NULL,
    direccionCliente2 VARCHAR(50),
    direccionCliente3 VARCHAR(50),
    direccionCliente4 VARCHAR(50),
    direccionCliente5 VARCHAR(50),
    direccionCliente6 VARCHAR(50),
    direccionCliente7 VARCHAR(50),
    direccionCliente8 VARCHAR(50),
    direccionCliente9 VARCHAR(50),
    direccionCliente10 VARCHAR(50)
    );
    
CREATE TABLE celulares_Cliente (
    id CHAR(10) NOT NULL,
    celularCliente1 NUMBER(20) NOT NULL,
    celularCliente2 NUMBER(20),
    celularCliente3 NUMBER(20),
    celularCliente4 NUMBER(20),
    celularCliente5 NUMBER(20),
    celularCliente6 NUMBER(20),
    celularCliente7 NUMBER(20),
    celularCliente8 NUMBER(20),
    celularCliente9 NUMBER(20),
    celularCliente10 NUMBER(20)
    );
    
CREATE TABLE consumidores (
    id VARCHAR(10) NOT NULL,
    nombre CHAR(100) NOT NULL, 
    preferencia_Alimento VARCHAR2(100) NOT NULL
    );
    
CREATE TABLE empresas (
    nit VARCHAR2(10) NOT NULL,
    nombre CHAR(100) NOT NULL,
    tipoNegocio VARCHAR2(3) NOT NULL,
    cantidadDesAli NUMBER NOT NULL,
    cantidadAliVen NUMBER NOT NULL,
    cantidadAliDon NUMBER NOT NULL,
    idDonacion VARCHAR2(10) NOT NULL
    );
    
CREATE TABLE auditorias (
    id VARCHAR2(10) NOT NULL,
    idnitEmpresa VARCHAR(10) NOT NULL,
    cantidadAlimentosSalv NUMBER NOT NULL, 
    valorMonetarioAho NUMBER(8) NOT NULL
    );
      

CREATE TABLE donaciones (
    id VARCHAR2(10) NOT NULL,
    fecha DATE NOT NULL,
    cantidad NUMBER NULL,
    tipo VARCHAR(1) NOT NULL
    );

CREATE TABLE carritosCompras (
    id VARCHAR(10) NOT NULL,
    precio NUMBER(8) NOT NULL,
    idProductos VARCHAR2(10) NOT NULL,
    idConsumidor VARCHAR(10) NOT NULL,
    idMenuAleatorio VARCHAR2(10) NOT NULL
    );

CREATE TABLE listaProductos(
    id VARCHAR(10) NOT NULL,
    producto VARCHAR(40)NOT NULL
    );

CREATE TABLE menusAleatorios (
    id VARCHAR2(10) NOT NULL,
    nitEmpresa VARCHAR2(10) NOT NULL,
    tipo VARCHAR2(50) NOT NULL,
    precio NUMBER(8) NOT NULL,
    nombre VARCHAR2(50) NOT NULL,
    idPlato VARCHAR(10)NOT NULL
    );
    
CREATE TABLE platos (
    id VARCHAR2(10) NOT NULL,
    nombre VARCHAR2(50) NOT NULL,
    precio NUMBER(8) NOT NULL
    );

CREATE TABLE pedidos (
    id VARCHAR2(10) NOT NULL,
    idConsumidor VARCHAR2(10) NOT NULL,
    nombreConsumidor VARCHAR2(50) NOT NULL,
    direccionConsumidor VARCHAR2(50) NOT NULL,
    estado VARCHAR2(1) NOT NULL,
    idCarritoCompras VARCHAR(10) NOT NULL,
    idCalificacion VARCHAR(10) NOT NULL,
    idFactura VARCHAR(10) NOT NULL,
    idEnvio VARCHAR(10) NOT NULL,
    idPuntoRecogida VARCHAR(10) NOT NULL
    );

CREATE TABLE calificaciones (
    id VARCHAR2(10) NOT NULL,
    cantidadEstrellas NUMBER NOT NULL,
    comentario VARCHAR2(100) NOT NULL
    );

CREATE TABLE facturas (
    id VARCHAR2(10) NOT NULL,
    idConsumidor VARCHAR2(10) NOT NULL,
    fecha DATE NOT NULL,
    total NUMBER(8) NOT NULL,
    idBono VARCHAR2(10) 
    );

CREATE TABLE envios (
    id VARCHAR2(10) NOT NULL,
    fecha DATE NOT NULL,
    fechaEntrega DATE NOT NULL,
    estado VARCHAR2(1) NOT NULL,
    idDomiciliario VARCHAR2(10) NOT NULL
    );

CREATE TABLE puntosRecogida (
    id VARCHAR2(10) NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    fecha DATE NOT NULL,
    idHorarioAtencion VARCHAR2(10) NOT NULL
    );

CREATE TABLE horariosAtencion (
    id VARCHAR(10) NOT NULL,
    horario VARCHAR2(50) NOT NULL
    );

CREATE TABLE bonos (
    id VARCHAR2(10) NOT NULL,
    idConsumidor VARCHAR(10) NOT NULL,
    nitEmpresa VARCHAR2(10) NOT NULL,
    estado VARCHAR2(10) NOT NULL,
    porcentajeDescuento NUMBER(8) NOT NULL,
    valor NUMBER(8) NOT NULL,
    descripcion VARCHAR2(50) NOT NULL
    );

CREATE TABLE domiciliarios (
    id VARCHAR2(10) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR2(50) NOT NULL,
    duracion NUMBER NOT NULL,
    correo VARCHAR2(50) NOT NULL
    );

-- === CICLO 1: XTablas

DROP TABLE clientes;
DROP TABLE direcciones_Cliente;
DROP TABLE celulares_Cliente;
DROP TABLE consumidores;
DROP TABLE empresas; 
DROP TABLE auditorias;
DROP TABLE donaciones;
DROP TABLE carritosCompras; 
DROP TABLE menusAleatorios;
DROP TABLE platos;
DROP TABLE pedidos;
DROP TABLE calificaciones;
DROP TABLE facturas;
DROP TABLE envios;
DROP TABLE puntosRecogida;
DROP TABLE horariosAtencion;
DROP TABLE bonos;
DROP TABLE domiciliarios;

-- === CICLO 1: Primarias

ALTER TABLE clientes
ADD CONSTRAINT PK_clientes PRIMARY KEY (id);

ALTER TABLE direcciones_Cliente
ADD CONSTRAINT PK_direcciones_Cliente PRIMARY KEY (id);

ALTER TABLE celulares_Cliente
ADD CONSTRAINT PK_celulares_Cliente PRIMARY KEY (id) 

ALTER TABLE consumidores
ADD CONSTRAINT PK_consumidores PRIMARY KEY (id);

ALTER TABLE empresas
ADD CONSTRAINT PK_empresas PRIMARY KEY (nit);

ALTER TABLE auditorias
ADD CONSTRAINT PK_auditorias PRIMARY KEY (id);

ALTER TABLE donaciones
ADD CONSTRAINT PK_donaciones PRIMARY KEY (id);

ALTER TABLE carritosCompras
ADD CONSTRAINT PK_carritosCompras PRIMARY KEY (id);

ALTER TABLE menusAleatorios
ADD CONSTRAINT PK_menusAleatorios PRIMARY KEY (id,nitEmpresa);

ALTER TABLE platos
ADD CONSTRAINT PK_platos PRIMARY KEY (id);

ALTER TABLE pedidos
ADD CONSTRAINT PK_pedidos PRIMARY KEY (id);

ALTER TABLE calificaciones
ADD CONSTRAINT PK_calificaciones PRIMARY KEY (id);

ALTER TABLE facturas
ADD CONSTRAINT PK_facturas PRIMARY KEY (id);

ALTER TABLE envios
ADD CONSTRAINT PK_envios PRIMARY KEY (id);

ALTER TABLE puntosRecogida
ADD CONSTRAINT PK_puntosRecogida PRIMARY KEY (id);

ALTER TABLE horariosAtencion
ADD CONSTRAINT PK_horariosAtencion PRIMARY KEY (id);

ALTER TABLE bonos
ADD CONSTRAINT PK_bonos PRIMARY KEY (id);

ALTER TABLE domiciliarios
ADD CONSTRAINT PK_domiciliarios PRIMARY KEY (id);


-- === CICLO 1: Únicas

ALTER TABLE clientes
ADD CONSTRAINT UK_clientes UNIQUE (correo, celular);

ALTER TABLE empresas
ADD CONSTRAINT UK_empresas UNIQUE (nombre);

ALTER TABLE menusAleatorios
ADD CONSTRAINT UK_menusAleatorios UNIQUE (nombre);

ALTER TABLE platos
ADD CONSTRAINT UK_platos UNIQUE (nombre);

ALTER TABLE facturas
ADD CONSTRAINT UK_facturas PRIMARY KEY (idBono);

-- === CICLO 1: Foráneas

ALTER TABLE clientes ADD CONSTRAINT FK_clientes_DireccionCliente 
FOREIGN KEY (direccionCliente) REFERENCES direcciones_Cliente(id);

ALTER TABLE clientes ADD CONSTRAINT FK_clientes_CelularCliente 
FOREIGN KEY (celular) REFERENCES celulares_Cliente(id);

ALTER TABLE consumidores ADD CONSTRAINT FK_consumidorCliente
FOREIGN KEY (id) REFERENCES clientes(id); 

ALTER TABLE empresas ADD CONSTRAINT FK_empresaCliente
FOREIGN KEY (nit) REFERENCES clientes(id);

ALTER TABLE empresas ADD CONSTRAINT FK_empresaDonacion
FOREIGN KEY (idDonacion) REFERENCES donaciones(id);

ALTER TABLE auditorias ADD CONSTRAINT FK_auditoriaEmpresa
FOREIGN KEY (nitEmpresa) REFERENCES empresas(nit);

ALTER TABLE carritosCompras ADD CONSTRAINT FK_carritoCompra_consumidor
FOREIGN KEY (idConsumidor) REFERENCES consumidores(id);

ALTER TABLE carritosCompras ADD CONSTRAINT FK_carritoCompra_menuAleatorio
FOREIGN KEY (idMenuAleatorio) REFERENCES menusAleatorios(id);

ALTER TABLE carritosCompras ADD CONSTRAINT FK_carritoCompra_consumidor
FOREIGN KEY (idConsumidor) REFERENCES consumidores(id);

ALTER TABLE menusAleatorios ADD CONSTRAINT FK_menuAleatorio_empresa
FOREIGN KEY (id,nitEmpresa) REFERENCES empresas(nit);

ALTER TABLE menusAleatorios ADD CONSTRAINT FK_menuAleatorio_plato
FOREIGN KEY (idPlato) REFERENCES platos(id);

ALTER TABLE pedidos ADD CONSTRAINT FK_pedidoConsumidor
FOREIGN KEY (idConsumidor) REFERENCES consumidores(id);

ALTER TABLE pedidos ADD CONSTRAINT FK_pedidoCarrito
FOREIGN KEY (idCarritoCompras) REFERENCES carritosCompras(id);

ALTER TABLE pedidos ADD CONSTRAINT FK_pedidoCalificaciop
FOREIGN KEY (idCalificacion) REFERENCES calificaciones(id);

ALTER TABLE pedidos ADD CONSTRAINT FK_pedidoFactura
FOREIGN KEY (idFactura) REFERENCES facturas(id);

ALTER TABLE pedidos ADD CONSTRAINT FK_pedidoEnvio
FOREIGN KEY (idEnvio) REFERENCES envios(id);

ALTER TABLE pedidos ADD CONSTRAINT FK_pedido_PuntoRecogida
FOREIGN KEY (idPuntoRecogida) REFERENCES puntosRecogida(id);

ALTER TABLE facturas ADD CONSTRAINT FK_facturasConsumidor
FOREIGN KEY (idConsumidor) REFERENCES consumidores(id);

ALTER TABLE facturas ADD CONSTRAINT FK_facturasBono
FOREIGN KEY (idBono) REFERENCES bonos(id);

ALTER TABLE envios ADD CONSTRAINT FK_envioDomiciliario
FOREIGN KEY (idDomiciliario) REFERENCES domiciliarios(id);

ALTER TABLE puntosRecogida ADD CONSTRAINT FK_puntosRecogida_HorarioAtencion
FOREIGN KEY (idHorarioAtencion) REFERENCES horariosAtencion(id);

ALTER TABLE bonos ADD CONSTRAINT FK_bonoConsumidor
FOREIGN KEY (idConsumidor) REFERENCES consumidores(id);

ALTER TABLE bonos ADD CONSTRAINT FK_bonoEmpresa
FOREIGN KEY (nitEmpresa) REFERENCES empresas(nit);


ALTER TABLE usuarios ADD CONSTRAINT FK_usuarioUniversidad 
FOREIGN KEY (codigoUniversidad) REFERENCES universidades(codigo)
ON DELETE CASCADE;



------------------------------clientes:

ALTER TABLE clientes

ADD CONSTRAINT CHK_Direccion_Valida

CHECK (

    Direccion LIKE '[A-Za-z0-9 ]{1,50}' AND

    Direccion LIKE '%Calle:%' AND

    Direccion LIKE '%Numero:%' AND

    Direccion LIKE '%Ciudad:%'

    );
 

--INSERT INTO Clientes (nombre, FK_id_direcciones)

--VALUES (

    --'NombreCliente',

    --(INSERT INTO Direcciones (Calle, Numero, Ciudad)

     --OUTPUT INSERTED.id_direcciones

    -- VALUES ('NombreCalle', NumeroUbicacion, 'NombreCiudad'))

--);

  

