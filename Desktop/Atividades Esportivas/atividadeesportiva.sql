
CREATE DATABASE esporte;

USE esporte;




CREATE TABLE atividade_esportiva (
    id_atividade INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(255),
    tipo ENUM('Individual', 'Coletiva') NOT NULL,
    nivel ENUM('Iniciante', 'Intermediário', 'Avançado') NOT NULL,
    duracao_minutos INT NOT NULL,
    vagas INT NOT NULL,
    data_atividade DATE NOT NULL,
    horario TIME NOT NULL,
    local VARCHAR(100) NOT NULL,
    status ENUM('Ativa', 'Inativa') DEFAULT 'Ativa'
);



DELIMITER $$

CREATE PROCEDURE cadastrar_atividade(
    IN p_nome VARCHAR(100),
    IN p_descricao VARCHAR(255),
    IN p_tipo VARCHAR(20),
    IN p_nivel VARCHAR(20),
    IN p_duracao INT,
    IN p_vagas INT,
    IN p_data DATE,
    IN p_horario TIME,
    IN p_local VARCHAR(100)
)
BEGIN

    
    IF p_nome IS NULL OR TRIM(p_nome) = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: o nome da atividade é obrigatório.';
    END IF;

   
    IF p_tipo NOT IN ('Individual', 'Coletiva') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: o tipo deve ser Individual ou Coletiva.';
    END IF;

    
    IF p_nivel NOT IN ('Iniciante', 'Intermediário', 'Avançado') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: nível inválido.';
    END IF;

   
    IF p_duracao <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: a duração deve ser maior que zero.';
    END IF;

    
    IF p_vagas <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: a quantidade de vagas deve ser maior que zero.';
    END IF;

    
    IF p_data IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: a data da atividade é obrigatória.';
    END IF;

    
    IF p_horario IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: o horário da atividade é obrigatório.';
    END IF;

    
    IF p_local IS NULL OR TRIM(p_local) = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: o local da atividade é obrigatório.';
    END IF;

    
    INSERT INTO atividade_esportiva (
        nome,
        descricao,
        tipo,
        nivel,
        duracao_minutos,
        vagas,
        data_atividade,
        horario,
        local
    )
    VALUES (
        p_nome,
        p_descricao,
        p_tipo,
        p_nivel,
        p_duracao,
        p_vagas,
        p_data,
        p_horario,
        p_local
    );

   
    SELECT 'Atividade cadastrada com sucesso!' AS mensagem;

END $$

DELIMITER ;




CALL cadastrar_atividade(
    'Futebol',
    'Treino de futebol para alunos',
    'Coletiva',
    'Intermediário',
    90,
    20,
    '2026-10-05',
    '18:00:00',
    'Quadra Esportiva'
);



CALL cadastrar_atividade(
    'Corrida',
    'Treino de corrida',
    'Individual',
    'Iniciante',
    60,
    30,
    '2026-10-06',
    '07:00:00',
    'Pista de Atletismo'
);



CALL cadastrar_atividade(
    'Vôlei',
    'Treino de vôlei em equipe',
    'Coletiva',
    'Avançado',
    120,
    12,
    '2026-10-07',
    '19:00:00',
    'Ginásio'
);



SELECT * FROM atividade_esportiva;