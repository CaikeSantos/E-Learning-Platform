import random
import psycopg2
from datetime import date, timedelta

# Conexão com o banco de dados
conn = psycopg2.connect(
    host="localhost",
    database="seu_banco_de_dados",
    user="seu_usuario",
    password="sua_senha"
)
cursor = conn.cursor()

# Função para gerar CPFs aleatórios
def generate_random_cpf():
    return str(random.randint(30000000000, 30000999999))

# Função para gerar códigos de curso aleatórios
def generate_random_course_code():
    return random.randint(1, 200000)

# Função para gerar datas aleatórias
def generate_random_date(start_date, end_date):
    time_between = end_date - start_date
    random_number_of_days = random.randrange(time_between.days)
    random_date = start_date + timedelta(days=random_number_of_days)
    return random_date

# Inserção de dados
for _ in range(200000):
    cpf_aluno = generate_random_cpf()
    codigo_curso = generate_random_course_code()
    data_assinatura = generate_random_date(date(2023, 1, 1), date(2023, 12, 31))
    certificado = random.choice([True, False])
    ultimo_acesso = generate_random_date(data_assinatura, date(2023, 12, 31))

    query = f"INSERT INTO Assina (cpf_aluno, codigo_curso, data_assinatura, certificado, ultimo_acesso) VALUES ('{cpf_aluno}', {codigo_curso}, '{data_assinatura}', {certificado}, '{ultimo_acesso}')"
    cursor.execute(query)

# Confirmação das inserções
conn.commit()

# Fechamento da conexão com o banco de dados
cursor.close()
conn.close()
