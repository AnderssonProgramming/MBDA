from faker import Faker
import random
import datetime

fake = Faker()

# Generate 2000 INSERT INTO statements for clientes table
clientes_inserts = [f"INSERT INTO clientes (id, correo) VALUES ('{str(i).zfill(10)}', '{fake.email()}')" for i in range(1, 2001)]

# Generate 2000 INSERT INTO statements for empresas table
empresas_inserts = [f"INSERT INTO empresas (nit, nombre, tipoNegocio) VALUES ('{str(i).zfill(10)}', '{fake.company()}', '{random.choice(['PYM', 'COE'])}')" for i in range(1, 2001)]

# Generate 2000 INSERT INTO statements for consumidores table
consumidores_inserts = [f"INSERT INTO consumidores (id, nombre, preferencia_Alimento) VALUES ('{str(i).zfill(10)}', '{fake.name()}', '{fake.word()}')" for i in range(1, 2001)]

# Generate a valid address for the direcciones_Cliente table
def generate_valid_address():
    street_name = fake.street_name()
    street_number = fake.building_number()
    city_name = fake.city()
    address = f"Calle: {street_name}, Numero: {street_number}, Ciudad: {city_name}"
    return address[:50]  # Trim to maximum length of 50 characters

# Generate 2000 INSERT INTO statements for direcciones_Cliente table
direcciones_inserts = [f"INSERT INTO direcciones_Cliente (id, idCliente, direccionCliente) VALUES ('{str(i).zfill(10)}', '{str(i).zfill(10)}', '{generate_valid_address()}')" for i in range(1, 2001)]

# Generate 2000 INSERT INTO statements for celulares_Cliente table
celulares_inserts = [f"INSERT INTO celulares_Cliente (id, idCliente, celularCliente) VALUES ('{str(i).zfill(10)}', '{str(i).zfill(10)}', '{fake.phone_number()}')" for i in range(1, 2001)]

# Generate 2000 INSERT INTO statements for auditorias_delizia table
auditorias_inserts = []
for i in range(1, 2001):
    nit_empresa = str(i).zfill(10)
    platos_vendidos = random.randint(0, 100)
    platos_por_vender = random.randint(0, 100)
    ganancias = random.randint(0, 10000)
    perdidas = random.randint(0, 10000)
    fecha_auditoria = fake.date_between(start_date=datetime.date(2020, 1, 1), end_date=datetime.date(2023, 12, 31))
    auditorias_inserts.append(f"INSERT INTO auditorias_delizia (id, nitEmpresa, platos_vendidos, platos_por_vender, ganancias, perdidas, fecha_auditoria) VALUES ('{str(i).zfill(10)}', '{nit_empresa}', {platos_vendidos}, {platos_por_vender}, {ganancias}, {perdidas}, TO_DATE('{fecha_auditoria}', 'YYYY-MM-DD'))")

# Generate 2000 INSERT INTO statements for donaciones table
donaciones_inserts = []
for i in range(1, 2001):
    fecha = fake.date_between(start_date=datetime.date(2020, 1, 1), end_date=datetime.date(2023, 12, 31))
    cantidad = random.randint(0, 10000)
    tipo = random.choice(['P', 'D'])
    nit_empresa = str(i).zfill(10)
    donaciones_inserts.append(f"INSERT INTO donaciones (id, fecha, cantidad, tipo, nit_empresa) VALUES ('{str(i).zfill(10)}', TO_DATE('{fecha}', 'YYYY-MM-DD'), {cantidad}, '{tipo}', '{nit_empresa}')")

# Generate 2000 INSERT INTO statements for menusAleatorios table
menus_aleatorios_inserts = []
for i in range(1, 2001):
    nit_empresa = str(i).zfill(10)
    tipo = random.choice(['E', 'P', 'A'])
    precio = random.randint(1, 10000)
    nombre = fake.word()
    estado = random.choice(['disponible', 'no disponible'])
    menus_aleatorios_inserts.append(f"INSERT INTO menusAleatorios (id, nitEmpresa, tipo, precio, nombre, estado) VALUES ('{str(i).zfill(10)}', '{nit_empresa}', '{tipo}', {precio}, '{nombre}', '{estado}')")

# Generate 2000 INSERT INTO statements for carritosCompras table
carritos_compras_inserts = []
for i in range(1, 2001):
    id_consumidor = str(i).zfill(10)
    id_menu = str(i).zfill(10)
    carritos_compras_inserts.append(f"INSERT INTO carritosCompras (id, idConsumidor, idMenuAleatorio) VALUES ('{str(i).zfill(10)}', '{id_consumidor}', '{id_menu}')")

# Output the INSERT INTO statements
all_inserts = (
    clientes_inserts +
    empresas_inserts +
    consumidores_inserts +
    direcciones_inserts +
    celulares_inserts +
    auditorias_inserts +
    donaciones_inserts +
    menus_aleatorios_inserts +
    carritos_compras_inserts
)

for insert in all_inserts:
    print(insert)
