-- Criação do enum Genero
CREATE TYPE GeneroEnum AS ENUM ('masculino', 'feminino', 'outro');

-- Criação do enum Categoria
CREATE TYPE CategoriaEnum AS ENUM ('Técnoligia', 'Administração', 'Culinária', 'Enfermagem', 'Nutrição', 'Artes', 'Música', 'Engenharia', 'outro');

-- Criação do enum Idioma
CREATE TYPE IdiomaEnum AS ENUM ('Inglês', 'Espanhol', 'Francês', 'Alemão', 'Italiano', 'Português', 'Russo', 'Mandarim', 'Japonês', 'Outro');

--Criação do domínio CPF
CREATE DOMAIN CPF AS char(11)
    CONSTRAINT cpf_valido CHECK(
        VALUE ~ '^[0-9]{11}$'
    );


-- Criação da tabela Aluno
CREATE TABLE IF NOT EXISTS Aluno (
  cpf CPF NOT NULL,
  nome VARCHAR(30) NOT NULL,
  idade INT NOT NULL CHECK (idade >= 18),
  genero GeneroEnum NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  PRIMARY KEY (cpf)
);

-- Criação da tabela Professor
CREATE TABLE IF NOT EXISTS Professor (
  cpf CPF NOT NULL,
  nome VARCHAR(30) NOT NULL,
  idade INT NOT NULL CHECK (idade >= 20),
  genero GeneroEnum NOT NULL,
  data_cadastro DATE NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  PRIMARY KEY (cpf)
);

-- Criação da tabela Curso
CREATE TABLE IF NOT EXISTS Curso (
  codigo INT NOT NULL,
  titulo VARCHAR(255) NOT NULL,
  categoria CategoriaEnum NOT NULL,
  horas_duracao INT CHECK (horas_duracao >= 1),
  avaliacao INT CHECK (avaliacao >= 0 AND avaliacao <= 5),
  cpf_professor CPF NOT NULL UNIQUE,
  idioma IdiomaEnum NOT NULL,
  PRIMARY KEY (codigo),
  FOREIGN KEY (cpf_professor) REFERENCES Professor(cpf)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

-- Criação da tabela Assina
CREATE TABLE IF NOT EXISTS Assina (
  cpf_aluno CPF NOT NULL,
  codigo_curso INT NOT NULL,
  data_assinatura DATE NOT NULL,
  certificado BOOLEAN NOT NULL DEFAULT false,
  ultimo_acesso DATE NOT NULL,
  FOREIGN KEY (cpf_aluno) REFERENCES Aluno(cpf)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY (codigo_curso) REFERENCES Curso(codigo)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
    PRIMARY KEY (cpf_aluno, codigo_curso)
);