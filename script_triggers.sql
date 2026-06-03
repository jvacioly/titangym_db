-- Bloquei de limite de Turma
CREATE OR REPLACE FUNCTION checar_capacidade_aula()
RETURNS TRIGGER AS $$
DECLARE
    qtd_atual INT;
    capacidade_max INT;
BEGIN
    -- Conta quantos alunos já estão cadastrados nesta aula específica
    SELECT COUNT(*) INTO qtd_atual FROM participa WHERE id_aula = NEW.id_aula;
    
    -- Descobre qual é a capacidade máxima que o instrutor definiu para a aula
    SELECT capacidade INTO capacidade_max FROM aula_coletiva WHERE id_aula = NEW.id_aula;

    -- A regra de ouro: se já estiver lotado, bloqueia a inserção!
    IF qtd_atual >= capacidade_max THEN
        RAISE EXCEPTION 'Operação bloqueada: A aula coletiva atingiu sua capacidade máxima!';
    END IF;

    -- Se tiver vaga, deixa a inserção acontecer normalmente
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_limite_capacidade
BEFORE INSERT ON participa
FOR EACH ROW
EXECUTE FUNCTION checar_capacidade_aula();


-- Bloqueio de Choque de Horário
CREATE OR REPLACE FUNCTION checar_choque_horario_instrutor()
RETURNS TRIGGER AS $$
DECLARE
    qtd_conflitos INT;
BEGIN
    -- Conta se já existe alguma aula para este instrutor, no mesmo dia e mesmo horário
    SELECT COUNT(*) INTO qtd_conflitos
    FROM aula_coletiva
    WHERE id_instrutor_ministra = NEW.id_instrutor_ministra
      AND dia_semana = NEW.dia_semana
      AND horario = NEW.horario
      -- A linha abaixo garante que, num UPDATE, ele não conte a própria aula
      AND id_aula IS DISTINCT FROM NEW.id_aula; 

    -- Se achar qualquer conflito, bloqueia imediatamente!
    IF qtd_conflitos > 0 THEN
        RAISE EXCEPTION 'Operação bloqueada: Choque de agenda! Este instrutor já tem uma aula neste dia e horário.';
    END IF;

    -- Se estiver tudo livre, permite a inserção/atualização
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_evitar_choque_horario
BEFORE INSERT OR UPDATE ON aula_coletiva
FOR EACH ROW
EXECUTE FUNCTION checar_choque_horario_instrutor();