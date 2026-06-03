-- Nivel 1 --
-- Inserindo 10 identificadores base de pagadores
INSERT INTO pagador (id_pagador) VALUES 
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

-- Inserindo 3 Planos de Assinatura
INSERT INTO plano_assinatura (id_plano, nome_plano, valor, tipo_acesso) VALUES
(1, 'Titan Basic', 99.90, 'Acesso apenas a unidade'),
(2, 'Titan Gym', 129.90, 'Acesso total'),
(3, 'Titan Gym Gold', 159.90, 'Acesso total + aulas');

-- Inserindo 5 Unidades da Academia
INSERT INTO unidade (id_unidade, cnpj, nome, telefone, rua, numero, cep, cidade, uf) VALUES
(1, '11.111.111/0001-11', 'Titan Boa Viagem', '8133331111', 'Av. Conselheiro Aguiar', '100', '51011-000', 'Recife', 'PE'),
(2, '22.222.222/0001-22', 'Titan Pina', '8133332222', 'Av. Herculano Bandeira', '200', '51110-000', 'Recife', 'PE'),
(3, '33.333.333/0001-33', 'Titan Derby', '8133333333', 'Rua do Paissandu', '300', '52010-000', 'Recife', 'PE'),
(4, '44.444.444/0001-44', 'Titan Casa Forte', '8133334444', 'Praça de Casa Forte', '400', '52061-000', 'Recife', 'PE'),
(5, '55.555.555/0001-55', 'Titan Graças', '8133335555', 'Rua Amélia', '500', '52011-000', 'Recife', 'PE');

-- Inserindo 10 Colaboradores (5 serão administrativos, 5 serão instrutores)
INSERT INTO colaborador (id_colab, cpf, nome, salario, rua, numero, cep, cidade, uf) VALUES
(1, '111.111.111-01', 'Carlos Silva', 2500.00, 'Rua A', '10', '50000-001', 'Recife', 'PE'),
(2, '222.222.222-02', 'Maria Oliveira', 2600.00, 'Rua B', '20', '50000-002', 'Recife', 'PE'),
(3, '333.333.333-03', 'João Santos', 2500.00, 'Rua C', '30', '50000-003', 'Recife', 'PE'),
(4, '444.444.444-04', 'Ana Costa', 3000.00, 'Rua D', '40', '50000-004', 'Recife', 'PE'),
(5, '555.555.555-05', 'Pedro Lima', 3500.00, 'Rua E', '50', '50000-005', 'Recife', 'PE'),
(6, '666.666.666-06', 'Rafael Mendes', 4000.00, 'Rua F', '60', '50000-006', 'Recife', 'PE'),
(7, '777.777.777-07', 'Juliana Rocha', 4200.00, 'Rua G', '70', '50000-007', 'Recife', 'PE'),
(8, '888.888.888-08', 'Lucas Alves', 3900.00, 'Rua H', '80', '50000-008', 'Recife', 'PE'),
(9, '999.999.999-09', 'Fernanda Gomes', 4500.00, 'Rua I', '90', '50000-009', 'Recife', 'PE'),
(10, '101.010.101-10', 'Tiago Ribeiro', 4100.00, 'Rua J', '100', '50000-010', 'Recife', 'PE');


-- Nivel 2 --

-- Especializando os Pagadores Jurídicos (IDs 6 a 10)
INSERT INTO empresa_parceira (cnpj, razao_social, email_financeiro, id_pagador) VALUES
('12.345.678/0001-01', 'Tech Corp S.A.', 'financeiro@techcorp.com', 6),
('23.456.789/0001-02', 'Banco Beta', 'pagamentos@bancobeta.com', 7),
('34.567.890/0001-03', 'Construtora Alfa', 'contas@alfa.com', 8),
('45.678.901/0001-04', 'Supermercados Sul', 'financas@sul.com', 9),
('56.789.012/0001-05', 'Logistica Express', 'faturamento@logexpress.com', 10);

-- Especializando os Colaboradores Administrativos (IDs 1 a 5)
INSERT INTO administrativo (id_colab, cargo, turno) VALUES
(1, 'Recepcionista', 'Manhã'),
(2, 'Recepcionista', 'Tarde'),
(3, 'Auxiliar de Limpeza', 'Noite'),
(4, 'Gerente Comercial', 'Integral'),
(5, 'Analista Financeiro', 'Integral');

-- Especializando os Colaboradores Instrutores (IDs 6 a 10)
INSERT INTO instrutor (id_colab, cref) VALUES
(6, '000111-G/PE'),
(7, '000222-G/PE'),
(8, '000333-G/PE'),
(9, '000444-G/PE'),
(10, '000555-G/PE');

-- Inserindo Telefones para alguns colaboradores
INSERT INTO telefone_colaborador (id_colab, telefone) VALUES
(1, '81988880001'),
(4, '81988880004'),
(6, '81988880006'),
(7, '81988880007'),
(9, '81988880009');

-- Inserindo 5 Equipamentos nas Unidades
INSERT INTO equipamento (id_equipamento, nome, fabricante, data_ultima_manutencao, id_unidade_alocado) VALUES
(1, 'Esteira Ergométrica', 'Movement', '2024-01-10', 1),
(2, 'Bicicleta Spinning', 'Matrix', '2024-02-15', 1),
(3, 'Leg Press 45', 'Life Fitness', '2024-03-20', 2),
(4, 'Crossover', 'Ipiranga', '2024-04-05', 3),
(5, 'Máquina de Remada', 'Concept2', '2024-05-12', 4);


-- Nivel 3 --

-- Inserindo 5 Especialidades para os Instrutores
INSERT INTO especialidade_instrutor (id_colab, especialidade) VALUES
(6, 'Musculação'),
(7, 'FitDance'),
(8, 'Crossfit'),
(9, 'Pilates'),
(10, 'Spinning');

-- Inserindo 5 Aulas Coletivas
INSERT INTO aula_coletiva (id_aula, modalidade, dia_semana, horario, capacidade, id_unidade_sedia, id_instrutor_ministra) VALUES
(1, 'Zumba', 'Segunda', '18:00:00', 30, 1, 7),
(2, 'Cross Training', 'Terça', '19:00:00', 20, 2, 8),
(3, 'Pilates de Solo', 'Quarta', '07:00:00', 15, 3, 9),
(4, 'Spinning', 'Quinta', '18:30:00', 25, 4, 10),
(5, 'FitDance', 'Sexta', '19:00:00', 40, 5, 7);

-- Inserindo 5 Alunos (Todos matriculados em unidades e planos diferentes, usando os Pagadores de 1 a 5)
INSERT INTO aluno (id_aluno, cpf, nome, data_nascimento, rua, numero, cep, cidade, uf, id_unidade_matriculado, id_plano_assinatura, id_pagador_responsavel) VALUES
(1, '123.456.789-01', 'Felipe Nunes', '1995-05-20', 'Rua K', '11', '51000-001', 'Recife', 'PE', 1, 3, 1),
(2, '234.567.890-02', 'Amanda Dias', '1998-08-15', 'Rua L', '12', '51000-002', 'Recife', 'PE', 2, 1, 2),
(3, '345.678.901-03', 'Bruno Castro', '1990-12-10', 'Rua M', '13', '51000-003', 'Recife', 'PE', 3, 2, 3),
(4, '456.789.012-04', 'Camila Barros', '2001-03-25', 'Rua N', '14', '51000-004', 'Recife', 'PE', 4, 1, 4),
(5, '567.890.123-05', 'Rodrigo Moraes', '1988-11-05', 'Rua O', '15', '51000-005', 'Recife', 'PE', 5, 3, 5);

-- 2. Criando o Plano de Treino Base
INSERT INTO plano_treino (id_treino, objetivo, data_criacao, id_aluno) 
VALUES (1, 'Força e Explosão (Alto Rendimento)', CURRENT_DATE, 1);

-- 3. Inserindo os detalhes da Ficha de Treino (Entidade Fraca)
INSERT INTO item_exercicio (id_treino, ordem_exercicio, descricao_aparelho, series, repeticoes, carga) VALUES
(1, 1, 'Agachamento Livre', 4, '8', '80kg'),
(1, 2, 'Puxada Alta na Polia', 4, '10', '60kg'),
(1, 3, 'Levantamento Terra', 3, '5', '100kg'),
(1, 4, 'Avanço (Passada) com Halteres', 3, '12', '24kg cada'),
(1, 5, 'Tiro na Esteira (Sprint)', 5, '1 min', 'Velocidade 16');