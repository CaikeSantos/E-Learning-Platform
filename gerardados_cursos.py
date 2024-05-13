import random
import requests

# Função para obter um nome de curso aleatório através da Random Data API
def get_random_curso_name():
    url = "https://random-data-api.com/api/course/random_course"  # URL da Random Data API para obter cursos aleatórios
    response = requests.get(url)
    if response.status_code == 200:
        curso = response.json()
        return curso['title']
    else:
        print("Erro ao obter o curso da API")
        return None

# Conexão com o banco de dados
conn = psycopg2.connect(
    host="localhost",
    database="seu_banco_de_dados",
    user="seu_usuario",
    password="sua_senha"
)
cursor = conn.cursor()

# Inserção de dados
for counter in range(200000):
    codigo = counter + 1
    titulo = get_random_curso_name()  # Obtém um nome de curso aleatório da API
    categoria = random.choice(['Tecnologia', 'Administração', 'Culinária', 'Enfermagem', 'Nutrição', 'Artes', 'Música', 'Engenharia', 'Outro'])
    horas_duracao = random.randint(1, 500)
    avaliacao = random.randint(0, 5)
    cpf_professor = random.randint(20000000000, 20000499999)
    idioma = random.choice(['Inglês', 'Espanhol', 'Francês', 'Alemão', 'Italiano', 'Português', 'Russo', 'Mandarim', 'Japonês', 'Outro'])

    query = f"INSERT INTO Curso (codigo, titulo, categoria, horas_duracao, avaliacao, cpf_professor, idioma) VALUES ({codigo}, '{titulo}', '{categoria}', {horas_duracao}, {avaliacao}, {cpf_professor}, '{idioma}')"
    cursor.execute(query)

# Confirmação das inserções
conn.commit()

# Fechamento da conexão com o banco de dados
cursor.close()
conn.close()
