-- Perfil do Aluno e Financeiro (JOIN Simples + Filtro) --
SELECT 
    a.nome AS nome_aluno,
    p.nome_plano,
    u.nome AS unidade_treino
FROM aluno a
JOIN plano_assinatura p ON a.id_plano_assinatura = p.id_plano
JOIN unidade u ON a.id_unidade_matriculado = u.id_unidade
WHERE p.nome_plano = 'Titan Gym Gold';

-- A Ficha de Treino (Entidade Fraca + Múltiplos JOINs) --
SELECT 
    a.nome AS nome_aluno,
    pt.objetivo,
    ie.ordem_exercicio,
    ie.descricao_aparelho,
    ie.series,
    ie.repeticoes,
    ie.carga
FROM aluno a
JOIN plano_treino pt ON a.id_aluno = pt.id_aluno
JOIN item_exercicio ie ON pt.id_treino = ie.id_treino
WHERE a.id_aluno = 1
ORDER BY ie.ordem_exercicio ASC;

-- Engajamento nas Aulas Coletivas (Relacionamento N:M) --
SELECT 
    ac.modalidade,
    ac.dia_semana,
    ac.horario,
    c.nome AS nome_instrutor,
    COUNT(p.id_aluno) AS total_alunos
FROM aula_coletiva ac
JOIN instrutor i ON ac.id_instrutor_ministra = i.id_colab
JOIN colaborador c ON i.id_colab = c.id_colab
LEFT JOIN participa p ON ac.id_aula = p.id_aula
GROUP BY ac.id_aula, ac.modalidade, ac.dia_semana, ac.horario, c.nome
ORDER BY total_alunos DESC;

-- Faturamento Mensal por Unidade (Agregação Financeira) --
SELECT 
    u.nome AS unidade,
    SUM(p.valor) AS faturamento_bruto
FROM unidade u
LEFT JOIN aluno a ON u.id_unidade = a.id_unidade_matriculado
LEFT JOIN plano_assinatura p ON a.id_plano_assinatura = p.id_plano
GROUP BY u.id_unidade, u.nome
ORDER BY faturamento_bruto DESC;

-- Controle de Equipamentos (Subconsulta / Filtro de Data) --
SELECT 
    nome AS unidade_precisa_manutencao
FROM unidade
WHERE id_unidade IN (
    SELECT id_unidade_alocado
    FROM equipamento
    WHERE data_ultima_manutencao < CURRENT_DATE - INTERVAL '3 months'
);