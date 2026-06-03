-- =========================================================
-- 1. TABELAS INDEPENDENTES (Nível 1)
-- =========================================================

CREATE TABLE pagador (
    id_pagador SERIAL PRIMARY KEY
);

CREATE TABLE plano_assinatura (
    id_plano SERIAL PRIMARY KEY,
    nome_plano VARCHAR(100) NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    tipo_acesso VARCHAR(50)
);

CREATE TABLE colaborador (
    id_colab SERIAL PRIMARY KEY,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    nome VARCHAR(100) NOT NULL,
    salario DECIMAL(10, 2),
    rua VARCHAR(100),
    numero VARCHAR(20),
    cep VARCHAR(20),
    cidade VARCHAR(100),
    uf VARCHAR(2)
);

CREATE TABLE unidade (
    id_unidade SERIAL PRIMARY KEY,
    cnpj VARCHAR(20) UNIQUE NOT NULL,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    rua VARCHAR(100),
    numero VARCHAR(20),
    cep VARCHAR(20),
    cidade VARCHAR(100),
    uf VARCHAR(2)
);

-- =========================================================
-- 2. SUBCLASSES E DEPENDENTES DIRETOS (Nível 2)
-- =========================================================

CREATE TABLE empresa_parceira (
    cnpj VARCHAR(20) PRIMARY KEY,
    razao_social VARCHAR(150) NOT NULL,
    email_financeiro VARCHAR(100),
    id_pagador INT UNIQUE,
    CONSTRAINT fk_empresa_pagador FOREIGN KEY (id_pagador) REFERENCES pagador(id_pagador)
);

CREATE TABLE administrativo (
    id_colab INT PRIMARY KEY,
    cargo VARCHAR(100),
    turno VARCHAR(50),
    CONSTRAINT fk_admin_colab FOREIGN KEY (id_colab) REFERENCES colaborador(id_colab)
);

CREATE TABLE instrutor (
    id_colab INT PRIMARY KEY,
    cref VARCHAR(50) UNIQUE NOT NULL,
    CONSTRAINT fk_instrutor_colab FOREIGN KEY (id_colab) REFERENCES colaborador(id_colab)
);

CREATE TABLE telefone_colaborador (
    id_colab INT,
    telefone VARCHAR(20),
    PRIMARY KEY (id_colab, telefone),
    CONSTRAINT fk_tel_colab FOREIGN KEY (id_colab) REFERENCES colaborador(id_colab)
);

CREATE TABLE equipamento (
    id_equipamento SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    fabricante VARCHAR(100),
    data_ultima_manutencao DATE,
    id_unidade_alocado INT,
    CONSTRAINT fk_equip_unidade FOREIGN KEY (id_unidade_alocado) REFERENCES unidade(id_unidade)
);

-- =========================================================
-- 3. TABELAS DE LIGAÇÃO DE NÍVEL 3
-- =========================================================

CREATE TABLE especialidade_instrutor (
    id_colab INT,
    especialidade VARCHAR(100),
    PRIMARY KEY (id_colab, especialidade),
    CONSTRAINT fk_especialidade_inst FOREIGN KEY (id_colab) REFERENCES instrutor(id_colab)
);

CREATE TABLE aula_coletiva (
    id_aula SERIAL PRIMARY KEY,
    modalidade VARCHAR(100) NOT NULL,
    dia_semana VARCHAR(20),
    horario TIME,
    capacidade INT,
    id_unidade_sedia INT,
    id_instrutor_ministra INT,
    CONSTRAINT fk_aula_unidade FOREIGN KEY (id_unidade_sedia) REFERENCES unidade(id_unidade),
    CONSTRAINT fk_aula_instrutor FOREIGN KEY (id_instrutor_ministra) REFERENCES instrutor(id_colab)
);

-- =========================================================
-- 4. A TABELA CENTRAL: ALUNO
-- =========================================================

CREATE TABLE aluno (
    id_aluno SERIAL PRIMARY KEY,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE,
    rua VARCHAR(100),
    numero VARCHAR(20),
    cep VARCHAR(20),
    cidade VARCHAR(100),
    uf VARCHAR(2),
    id_unidade_matriculado INT,
    id_plano_assinatura INT,
    id_pagador_responsavel INT,
    CONSTRAINT fk_aluno_unidade FOREIGN KEY (id_unidade_matriculado) REFERENCES unidade(id_unidade),
    CONSTRAINT fk_aluno_plano FOREIGN KEY (id_plano_assinatura) REFERENCES plano_assinatura(id_plano),
    CONSTRAINT fk_aluno_pagador FOREIGN KEY (id_pagador_responsavel) REFERENCES pagador(id_pagador)
);

-- =========================================================
-- 5. DEPENDENTES DO ALUNO E N:M (Nível 5)
-- =========================================================

CREATE TABLE telefone_aluno (
    id_aluno INT,
    telefone VARCHAR(20),
    PRIMARY KEY (id_aluno, telefone),
    CONSTRAINT fk_tel_aluno FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno)
);

CREATE TABLE pagador_individual (
    id_aluno INT PRIMARY KEY,
    id_pagador INT UNIQUE,
    dados_cartao VARCHAR(100),
    CONSTRAINT fk_pag_ind_aluno FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno),
    CONSTRAINT fk_pag_ind_pagador FOREIGN KEY (id_pagador) REFERENCES pagador(id_pagador)
);

CREATE TABLE participa (
    id_aluno INT,
    id_aula INT,
    data_inscricao DATE,
    PRIMARY KEY (id_aluno, id_aula),
    CONSTRAINT fk_participa_aluno FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno),
    CONSTRAINT fk_participa_aula FOREIGN KEY (id_aula) REFERENCES aula_coletiva(id_aula)
);

CREATE TABLE plano_treino (
    id_treino SERIAL PRIMARY KEY,
    objetivo VARCHAR(255),
    data_criacao DATE,
    id_aluno INT,
    CONSTRAINT fk_treino_aluno FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno)
);

-- =========================================================
-- 6. ENTIDADE FRACA (Nível 6)
-- =========================================================

CREATE TABLE item_exercicio (
    id_treino INT,
    ordem_exercicio INT,
    descricao_aparelho VARCHAR(100),
    series INT,
    repeticoes VARCHAR(50),
    carga VARCHAR(50),
    PRIMARY KEY (id_treino, ordem_exercicio),
    -- Adicionei CASCADE para facilitar: se apagar o treino, os exercícios apagam juntos
    CONSTRAINT fk_item_treino FOREIGN KEY (id_treino) REFERENCES plano_treino(id_treino) ON DELETE CASCADE 
);