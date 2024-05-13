import random
import string
import psycopg2
from faker import Faker

fake = Faker()
fake.locale = 'en_US'

# Função para gerar CPFs baseados em um contador
def generate_cpf(counter):
    cpf = str(20000000000 + counter)
    return cpf

# Função para gerar e-mails baseados no nome e nos 2 últimos dígitos do CPF
def generate_email(first_name, last_name, cpf):
    domains = ['gmail.com', 'hotmail.com', 'yahoo.com']
    domain = random.choice(domains)
    email = f'{first_name.lower()}{last_name.lower()}{cpf[-2:]}@{domain}'
    return email


# Função para gerar uma data de cadastro aleatória no ano de 2023
def generate_registration_date():
    start_date = fake.date_between(start_date='2023-01-01', end_date='2023-12-31')
    return start_date

# Conexão com o banco de dados
conn = psycopg2.connect(
    host="localhost",
    database="seu_banco_de_dados",
    user="seu_usuario",
    password="sua_senha"
)
cursor = conn.cursor()

# Inserção de dados
for counter in range(500000):
    name = fake.name().split()  # Gera um nome real e retorna uma lista com o nome completo
    first_name = name[0]  # Primeiro nome
    last_name = name[-1]  # Último nome
    cpf = generate_cpf(counter)
    age = random.randint(20, 60)
    gender = random.choice(['masculino', 'feminino', 'outro'])
    registration_date = generate_registration_date()
    email = generate_email(name, cpf)

    query = f"INSERT INTO Professor (cpf, nome, idade, genero, data_cadastro, email) VALUES ('{cpf}', '{first_name} {last_name}', {age}, '{gender}', '{registration_date}', '{email}')"
    cursor.execute(query)

# Confirmação das inserções
conn.commit()

# Fechamento da conexão com o banco de dados
cursor.close()
conn.close()
