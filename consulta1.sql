-- Índice na coluna "genero" da tabela "Aluno"
CREATE INDEX idx_aluno_genero ON Aluno (genero);

-- Índice na coluna "categoria" da tabela "Curso"
CREATE INDEX idx_curso_categoria ON Curso (categoria);

-- Índice na coluna "cpf_aluno" da tabela "Assina"
CREATE INDEX idx_assina_cpf_aluno ON Assina (cpf_aluno);

-- Índice na coluna "cpf_professor" da tabela "Curso"
CREATE INDEX idx_curso_cpf_professor ON Curso (cpf_professor);

SELECT
    a.nome AS aluno_nome,
    c.titulo AS curso_titulo,
    c.categoria AS curso_categoria,
    a.genero AS aluno_genero,
    a.idade AS aluno_idade,
    ass.data_assinatura,
    ass.certificado,
    ass.ultimo_acesso,
    ass.quantidade_de_acessos,
    ass.comentario_aluno
FROM
    Aluno a
    INNER JOIN Assina ass ON a.cpf = ass.cpf_aluno
    INNER JOIN Curso c ON ass.codigo_curso = c.codigo
WHERE
    a.genero = 'masculino'
    AND c.categoria = 'Tecnologia'
    AND ass.comentario_aluno ~* 'curso|gostei|otimo' --expressao regular, a tag * significa -i oque torna a expressao regular case-insensitive
    AND ass.data_assinatura >= '2023-01-01';