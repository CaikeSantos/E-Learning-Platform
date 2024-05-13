-- Primeira Consulta
SELECT
    a.nome AS aluno_nome,
    c.titulo AS curso_titulo,
    c.categoria AS curso_categoria,
    a.genero AS aluno_genero,
    a.idade AS aluno_idade,
    ass.data_assinatura,
    ass.comentario_aluno
FROM
    Aluno a
    INNER JOIN Assina ass ON a.cpf = ass.cpf_aluno
    INNER JOIN Curso c ON ass.codigo_curso = c.codigo
WHERE
    a.genero = <gênero>
    AND c.categoria = <categoria>
    AND ass.comentario_aluno ILIKE <palavra>


-- Segunda Consulta
SELECT
    a.cpf AS aluno_cpf,
    a.nome AS aluno_nome,
    a.idade AS aluno_idade,
    MIN(ass.data_assinatura) AS data_assinatura_primeiro_curso,
    COUNT(ass.codigo_curso) AS quantidade_cursos
FROM
    Aluno a
    INNER JOIN Assina ass ON a.cpf = ass.cpf_aluno
WHERE
    ass.certificado = true
    AND a.idade > <idade>
GROUP BY
    a.cpf
ORDER BY
    quantidade_cursos DESC;


-- Primeira Função
CREATE OR REPLACE FUNCTION get_aluno_curso_info(
	p_genero GeneroEnum,
    p_categoria CategoriaEnum,
    p_comentario varchar(255)
)
RETURNS TABLE (
    aluno_nome varchar(255),
    curso_titulo varchar(255),
    curso_categoria CategoriaEnum,
    aluno_genero GeneroEnum,
    aluno_idade integer,
    data_assinatura date,
    comentario_aluno varchar(255)
) AS $func$
BEGIN
    RETURN QUERY EXECUTE '
        SELECT
            a.nome AS aluno_nome,
            c.titulo AS curso_titulo,
            c.categoria AS curso_categoria,
            a.genero AS aluno_genero,
            a.idade AS aluno_idade,
            ass.data_assinatura,
            ass.comentario_aluno
        FROM
            Aluno a
            INNER JOIN Assina ass ON a.cpf = ass.cpf_aluno
            INNER JOIN Curso c ON ass.codigo_curso = c.codigo
        WHERE
            a.genero = CAST ($1 AS GeneroEnum)
            AND c.categoria = CAST ($2 AS CategoriaEnum)
            AND ass.comentario_aluno ILIKE $3
    '
    USING p_genero, p_categoria, '%' || p_comentario || '%';
END
$func$ LANGUAGE plpgsql;

-- Execução da primeira consulta
SELECT * FROM get_aluno_curso_info(<gênero>, <categoria>, <comentário>);


-- Segunda Função
CREATE OR REPLACE FUNCTION get_qtdd_curso(a_idade integer)
RETURNS TABLE (
    aluno_cpf CPF,
    aluno_nome varchar(255),
    aluno_idade integer,
    data_assinatura_primeiro_curso date,
	quantidade_cursos integer
) AS $func$
BEGIN
    RETURN QUERY EXECUTE '
       SELECT
			a.cpf AS aluno_cpf,
			a.nome AS aluno_nome,
			a.idade AS aluno_idade,
			MIN(ass.data_assinatura) AS data_assinatura_primeiro_curso,
			COUNT(ass.codigo_curso)::integer AS quantidade_cursos
		FROM
			Aluno a
			INNER JOIN Assina ass ON a.cpf = ass.cpf_aluno
		WHERE
			ass.certificado = true
			AND a.idade > $1
		GROUP BY
			a.cpf
		ORDER BY
			quantidade_cursos DESC;
    '
    USING a_idade;
END
$func$ LANGUAGE plpgsql;


-- Execução da segunda consulta
SELECT * FROM get_qtdd_curso(<idade>);