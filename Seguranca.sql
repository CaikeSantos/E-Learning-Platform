-- administrador
CREATE ROLE administrador LOGIN PASSWORD '1234' SUPERUSER;


-- aluno 
CREATE ROLE aluno LOGIN PASSWORD '1234' NOINHERIT;

-- permissao na tabela aluno
GRANT SELECT, UPDATE on aluno to aluno;

-- permissao na tabela aluno
GRANT SELECT, INSERT(comentario_aluno), UPDATE(comentario_aluno) on assina to aluno;

-- permissao na tabela curso
GRANT SELECT(codigo, titulo, categoria, horas_duracao, avaliacao, idioma) on curso to aluno;


-- professor
CREATE ROLE professor LOGIN PASSWORD '1234' NOINHERIT;

-- permissao na tabela assina
GRANT SELECT(codigo_curso, data_assinatura,certificado, ultimo_acesso, quantidade_de_acessos, comentario_aluno) on assina to professor

-- permissao na tabela curso
GRANT SELECT, INSERT, UPDATE, DELETE on curso to professor

-- permissao na tabela professor
GRANT SELECT, INSERT, UPDATE, DELETE on professor to professor


-- anonimo
CREATE ROLE anonimo LOGIN PASSWORD '1234' NOINHERIT;

-- permissao na tabela curso
GRANT SELECT on curso to anonimo