import random
import string
import psycopg2
from faker import Faker

fake = Faker()
fake.locale = 'en_US'

# Função para gerar CPFs baseados em um contador
def generate_cpf(counter):
    cpf = str(30000000000 + counter)
    return cpf

# Função para gerar e-mails baseados no nome e nos 2 últimos dígitos do CPF
def generate_email(first_name, last_name, cpf):
    domains = ['gmail.com', 'hotmail.com', 'yahoo.com']
    domain = random.choice(domains)
    email = f'{first_name.lower()}{last_name.lower()}{cpf[-2:]}@{domain}'
    return email


# Conexão com o banco de dados
conn = psycopg2.connect(
    host="localhost",
    database="seu_banco_de_dados",
    user="seu_usuario",
    password="sua_senha"
)
cursor = conn.cursor()

# Inserção de dados
for counter in range(1000000):
    name = fake.name().split()  # Gera um nome real e retorna uma lista com o nome completo
    first_name = name[0]  # Primeiro nome
    last_name = name[-1]  # Último nome
    cpf = generate_cpf(counter)
    age = random.randint(18, 40)
    gender = random.choice(['masculino', 'feminino', 'outro'])
    email = generate_email(name, cpf)

    query = f"INSERT INTO Aluno (cpf, nome, idade, genero, email) VALUES ('{cpf}', '{first_name} {last_name}', {age}, '{gender}', '{email}')"
    cursor.execute(query)

# Confirmação das inserções
conn.commit()

# Fechamento da conexão com o banco de dados
cursor.close()
conn.close()
