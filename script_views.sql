CREATE VIEW vw_perfil_aluno AS
SELECT 
    a.id_aluno,
    a.nome AS nome_aluno,
    p.nome_plano,
    p.tipo_acesso,
    u.nome AS unidade_matricula
FROM aluno a
JOIN plano_assinatura p ON a.id_plano_assinatura = p.id_plano
JOIN unidade u ON a.id_unidade_matriculado = u.id_unidade;

CREATE VIEW vw_ficha_treino AS
SELECT 
    a.id_aluno,
    a.nome AS nome_aluno,
    pt.objetivo,
    ie.ordem_exercicio,
    ie.descricao_aparelho,
    ie.series,
    ie.repeticoes,
    ie.carga
FROM aluno a
JOIN plano_treino pt ON a.id_aluno = pt.id_aluno
JOIN item_exercicio ie ON pt.id_treino = ie.id_treino;

CREATE VIEW vw_faturamento_unidade AS
SELECT 
    u.id_unidade,
    u.nome AS unidade,
    SUM(p.valor) AS faturamento_bruto
FROM unidade u
LEFT JOIN aluno a ON u.id_unidade = a.id_unidade_matriculado
LEFT JOIN plano_assinatura p ON a.id_plano_assinatura = p.id_plano
GROUP BY u.id_unidade, u.nome;

CREATE VIEW vw_equipe_publica AS
SELECT 
    c.id_colab,
    c.nome AS colaborador,
    c.cidade,
    COALESCE(i.cref, 'Equipe Administrativa') AS registro_profissional,
    COALESCE(adm.cargo, 'Instrutor(a)') AS cargo_atuacao
FROM colaborador c
LEFT JOIN instrutor i ON c.id_colab = i.id_colab
LEFT JOIN administrativo adm ON c.id_colab = adm.id_colab;