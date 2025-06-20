-- Drop das tabelas
DROP TABLE USUARIO CASCADE CONSTRAINTS;
DROP TABLE DOACAO CASCADE CONSTRAINTS;
DROP TABLE NOTICIA CASCADE CONSTRAINTS;
DROP TABLE ALERTA CASCADE CONSTRAINTS;
DROP TABLE ENDERECO CASCADE CONSTRAINTS;
DROP TABLE AUDITORIA CASCADE CONSTRAINTS;

-- Tabela USUARIO com IDENTITY
CREATE TABLE USUARIO (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) NOT NULL UNIQUE,
    senha VARCHAR2(100) NOT NULL,
    fl_doc_verificado CHAR(1) DEFAULT 'N',
    role VARCHAR2(10) DEFAULT 'USER',
    cep VARCHAR2(8) NOT NULL
);
ALTER TABLE USUARIO ADD CONSTRAINT chk_role CHECK (role IN ('USER', 'VOLUNTARIO', 'ADMIN'));

-- Tabela ENDERECO com IDENTITY
CREATE TABLE ENDERECO (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    usuario_id NUMBER REFERENCES USUARIO(id),
    logradouro VARCHAR2(100) NOT NULL,
    numero VARCHAR2(10),
    bairro VARCHAR2(60),
    cidade VARCHAR2(60),
    estado VARCHAR2(2),
    cep VARCHAR2(8)
);

-- Tabela ALERTA com IDENTITY
CREATE TABLE ALERTA (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    usuario_id NUMBER REFERENCES USUARIO(id),
    tipo_alerta VARCHAR2(50) NOT NULL,
    latitude NUMBER(9,6),
    longitude NUMBER(9,6)
);

-- Tabela DOACAO com IDENTITY
CREATE TABLE DOACAO (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    usuario_id NUMBER REFERENCES USUARIO(id),
    titulo VARCHAR2(200) NOT NULL,
    descricao VARCHAR2(500),
    valor NUMBER(10,2),
    data_criacao DATE DEFAULT SYSDATE
);

-- Tabela NOTICIA com IDENTITY
CREATE TABLE NOTICIA (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    usuario_id NUMBER REFERENCES USUARIO(id),
    titulo VARCHAR2(200) NOT NULL,
    subtitulo VARCHAR2(200),
    conteudo VARCHAR2(1000),
    link VARCHAR2(500)
);

-- Tabela AUDITORIA
CREATE TABLE AUDITORIA (
    id_auditoria NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    tabela_afetada VARCHAR2(50),
    operacao VARCHAR2(10),
    usuario VARCHAR2(50),
    data_alteracao TIMESTAMP DEFAULT SYSTIMESTAMP
);

-- Package de Gestão Supernova
CREATE OR REPLACE PACKAGE pkg_supernova AS
    PROCEDURE inserir_usuario(p_nome VARCHAR2, p_email VARCHAR2, p_senha VARCHAR2, p_fl_doc CHAR, p_role VARCHAR2, p_cep VARCHAR2);
    PROCEDURE atualizar_usuario(p_id NUMBER, p_nome VARCHAR2, p_email VARCHAR2, p_senha VARCHAR2, p_fl_doc CHAR, p_role VARCHAR2, p_cep VARCHAR2);
    PROCEDURE deletar_usuario(p_id NUMBER);
    PROCEDURE inserir_endereco(p_usuario_id NUMBER, p_logradouro VARCHAR2, p_numero VARCHAR2, p_bairro VARCHAR2, p_cidade VARCHAR2, p_estado VARCHAR2, p_cep VARCHAR2);
    PROCEDURE atualizar_endereco(p_id NUMBER, p_logradouro VARCHAR2, p_numero VARCHAR2, p_bairro VARCHAR2, p_cidade VARCHAR2, p_estado VARCHAR2, p_cep VARCHAR2);
    PROCEDURE deletar_endereco(p_id NUMBER);
    PROCEDURE inserir_alerta(p_usuario_id NUMBER, p_tipo_alerta VARCHAR2, p_latitude NUMBER, p_longitude NUMBER);
    PROCEDURE atualizar_alerta(p_id NUMBER, p_tipo_alerta VARCHAR2, p_latitude NUMBER, p_longitude NUMBER);
    PROCEDURE deletar_alerta(p_id NUMBER);
    PROCEDURE inserir_doacao(p_usuario_id NUMBER, p_titulo VARCHAR2, p_descricao VARCHAR2, p_valor NUMBER);
    PROCEDURE atualizar_doacao(p_id NUMBER, p_titulo VARCHAR2, p_descricao VARCHAR2, p_valor NUMBER);
    PROCEDURE deletar_doacao(p_id NUMBER);
    PROCEDURE inserir_noticia(p_usuario_id NUMBER, p_titulo VARCHAR2, p_subtitulo VARCHAR2, p_conteudo VARCHAR2, p_link VARCHAR2);
    PROCEDURE atualizar_noticia(p_id NUMBER, p_titulo VARCHAR2, p_subtitulo VARCHAR2, p_conteudo VARCHAR2, p_link VARCHAR2);
    PROCEDURE deletar_noticia(p_id NUMBER);
    FUNCTION calcular_risco_alerta(p_usuario_id NUMBER) RETURN VARCHAR2;
    PROCEDURE relatorio_doacoes;
END pkg_supernova;
/


-- Package Body
CREATE OR REPLACE PACKAGE BODY pkg_supernova AS
    -- Inserção de Usuário
    PROCEDURE inserir_usuario(
        p_nome VARCHAR2,
        p_email VARCHAR2,
        p_senha VARCHAR2,
        p_fl_doc CHAR,
        p_role VARCHAR2,
        p_cep VARCHAR2
    ) IS
    BEGIN
        INSERT INTO USUARIO (nome, email, senha, fl_doc_verificado, role, cep)
        VALUES (p_nome, p_email, p_senha, p_fl_doc, p_role, p_cep);
        COMMIT;
    END;

    -- Atualização de Usuário
    PROCEDURE atualizar_usuario(p_id NUMBER, p_nome VARCHAR2, p_email VARCHAR2, p_senha VARCHAR2, p_fl_doc CHAR, p_role VARCHAR2, p_cep VARCHAR2) IS
    BEGIN
        UPDATE USUARIO
        SET nome = p_nome, email = p_email, senha = p_senha, fl_doc_verificado = p_fl_doc, role = p_role, cep = p_cep
        WHERE id = p_id;
        COMMIT;
    END;

    -- Exclusão de Usuário
    PROCEDURE deletar_usuario(p_id NUMBER) IS
    BEGIN
        DELETE FROM USUARIO WHERE id = p_id;
        COMMIT;
    END;

    -- Inserção de Endereço
    PROCEDURE inserir_endereco(p_usuario_id NUMBER, p_logradouro VARCHAR2, p_numero VARCHAR2, p_bairro VARCHAR2, p_cidade VARCHAR2, p_estado VARCHAR2, p_cep VARCHAR2) IS
    BEGIN
        INSERT INTO ENDERECO (usuario_id, logradouro, numero, bairro, cidade, estado, cep)
        VALUES (p_usuario_id, p_logradouro, p_numero, p_bairro, p_cidade, p_estado, p_cep);
        COMMIT;
    END;

    -- Atualização de Endereço
    PROCEDURE atualizar_endereco(p_id NUMBER, p_logradouro VARCHAR2, p_numero VARCHAR2, p_bairro VARCHAR2, p_cidade VARCHAR2, p_estado VARCHAR2, p_cep VARCHAR2) IS
    BEGIN
        UPDATE ENDERECO
        SET logradouro = p_logradouro, numero = p_numero, bairro = p_bairro, cidade = p_cidade, estado = p_estado, cep = p_cep
        WHERE id = p_id;
        COMMIT;
    END;

    -- Exclusão de Endereço
    PROCEDURE deletar_endereco(p_id NUMBER) IS
    BEGIN
        DELETE FROM ENDERECO WHERE id = p_id;
        COMMIT;
    END;

    -- Inserção de Alerta
    PROCEDURE inserir_alerta(p_usuario_id NUMBER, p_tipo_alerta VARCHAR2, p_latitude NUMBER, p_longitude NUMBER) IS
    BEGIN
        INSERT INTO ALERTA (usuario_id, tipo_alerta, latitude, longitude)
        VALUES (p_usuario_id, p_tipo_alerta, p_latitude, p_longitude);
        COMMIT;
    END;

    -- Atualização de Alerta
    PROCEDURE atualizar_alerta(p_id NUMBER, p_tipo_alerta VARCHAR2, p_latitude NUMBER, p_longitude NUMBER) IS
    BEGIN
        UPDATE ALERTA
        SET tipo_alerta = p_tipo_alerta, latitude = p_latitude, longitude = p_longitude
        WHERE id = p_id;
        COMMIT;
    END;

    -- Exclusão de Alerta
    PROCEDURE deletar_alerta(p_id NUMBER) IS
    BEGIN
        DELETE FROM ALERTA WHERE id = p_id;
        COMMIT;
    END;

    -- Inserção de Doação
    PROCEDURE inserir_doacao(p_usuario_id NUMBER, p_titulo VARCHAR2, p_descricao VARCHAR2, p_valor NUMBER) IS
    BEGIN
        INSERT INTO DOACAO (usuario_id, titulo, descricao, valor)
        VALUES (p_usuario_id, p_titulo, p_descricao, p_valor);
        COMMIT;
    END;

    -- Atualização de Doação
    PROCEDURE atualizar_doacao(p_id NUMBER, p_titulo VARCHAR2, p_descricao VARCHAR2, p_valor NUMBER) IS
    BEGIN
        UPDATE DOACAO
        SET titulo = p_titulo, descricao = p_descricao, valor = p_valor
        WHERE id = p_id;
        COMMIT;
    END;

    -- Exclusão de Doação
    PROCEDURE deletar_doacao(p_id NUMBER) IS
    BEGIN
        DELETE FROM DOACAO WHERE id = p_id;
        COMMIT;
    END;

    -- Inserção de Notícia
    PROCEDURE inserir_noticia(p_usuario_id NUMBER, p_titulo VARCHAR2, p_subtitulo VARCHAR2, p_conteudo VARCHAR2, p_link VARCHAR2) IS
    BEGIN
        INSERT INTO NOTICIA (usuario_id, titulo, subtitulo, conteudo, link)
        VALUES (p_usuario_id, p_titulo, p_subtitulo, p_conteudo, p_link);
        COMMIT;
    END;

    -- Atualização de Notícia
    PROCEDURE atualizar_noticia(p_id NUMBER, p_titulo VARCHAR2, p_subtitulo VARCHAR2, p_conteudo VARCHAR2, p_link VARCHAR2) IS
    BEGIN
        UPDATE NOTICIA
        SET titulo = p_titulo, subtitulo = p_subtitulo, conteudo = p_conteudo, link = p_link
        WHERE id = p_id;
        COMMIT;
    END;

    -- Exclusão de Notícia
    PROCEDURE deletar_noticia(p_id NUMBER) IS
    BEGIN
        DELETE FROM NOTICIA WHERE id = p_id;
        COMMIT;
    END;

    -- Função de Cálculo de Risco de Alerta
    FUNCTION calcular_risco_alerta(p_usuario_id NUMBER) RETURN VARCHAR2 IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM ALERTA WHERE usuario_id = p_usuario_id;
        IF v_count > 5 THEN
            RETURN 'Alto';
        ELSIF v_count > 2 THEN
            RETURN 'Moderado';
        ELSE
            RETURN 'Baixo';
        END IF;
    END;

    -- Relatório de Doações
    PROCEDURE relatorio_doacoes IS
        CURSOR c_doacoes IS
            SELECT u.nome, d.titulo, d.valor
            FROM DOACAO d
            JOIN USUARIO u ON d.usuario_id = u.id
            ORDER BY d.valor DESC;

        v_rec c_doacoes%ROWTYPE;
    BEGIN
        OPEN c_doacoes;
        LOOP
            FETCH c_doacoes INTO v_rec;
            EXIT WHEN c_doacoes%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('Usuário: ' || v_rec.nome || ' - Título: ' || v_rec.titulo || ' - Valor: ' || v_rec.valor);
        END LOOP;
        CLOSE c_doacoes;
    END;
END pkg_supernova;
/

-- Triggers de Auditoria
CREATE OR REPLACE TRIGGER trg_auditoria_usuario
AFTER INSERT OR UPDATE OR DELETE ON USUARIO
FOR EACH ROW
DECLARE
    v_operacao VARCHAR2(10);
BEGIN
    IF INSERTING THEN v_operacao := 'INSERT';
    ELSIF UPDATING THEN v_operacao := 'UPDATE';
    ELSE v_operacao := 'DELETE';
    END IF;
    INSERT INTO AUDITORIA (tabela_afetada, operacao, usuario) VALUES ('USUARIO', v_operacao, USER);
END;
/


CREATE OR REPLACE TRIGGER trg_auditoria_doacao
AFTER INSERT OR UPDATE OR DELETE ON DOACAO
FOR EACH ROW
DECLARE
    v_operacao VARCHAR2(10);
BEGIN
    IF INSERTING THEN v_operacao := 'INSERT';
    ELSIF UPDATING THEN v_operacao := 'UPDATE';
    ELSE v_operacao := 'DELETE';
    END IF;
    INSERT INTO AUDITORIA (tabela_afetada, operacao, usuario) VALUES ('DOACAO', v_operacao, USER);
END;
/


CREATE OR REPLACE TRIGGER trg_auditoria_endereco
AFTER INSERT OR UPDATE OR DELETE ON ENDERECO
FOR EACH ROW
DECLARE
    v_operacao VARCHAR2(10);
BEGIN
    IF INSERTING THEN v_operacao := 'INSERT';
    ELSIF UPDATING THEN v_operacao := 'UPDATE';
    ELSE v_operacao := 'DELETE';
    END IF;
    INSERT INTO AUDITORIA (tabela_afetada, operacao, usuario) VALUES ('ENDERECO', v_operacao, USER);
END;
/


CREATE OR REPLACE TRIGGER trg_auditoria_alerta
AFTER INSERT OR UPDATE OR DELETE ON ALERTA
FOR EACH ROW
DECLARE
    v_operacao VARCHAR2(10);
BEGIN
    IF INSERTING THEN v_operacao := 'INSERT';
    ELSIF UPDATING THEN v_operacao := 'UPDATE';
    ELSE v_operacao := 'DELETE';
    END IF;
    INSERT INTO AUDITORIA (tabela_afetada, operacao, usuario) VALUES ('ALERTA', v_operacao, USER);
END;
/


CREATE OR REPLACE TRIGGER trg_auditoria_noticia
AFTER INSERT OR UPDATE OR DELETE ON NOTICIA
FOR EACH ROW
DECLARE
    v_operacao VARCHAR2(10);
BEGIN
    IF INSERTING THEN v_operacao := 'INSERT';
    ELSIF UPDATING THEN v_operacao := 'UPDATE';
    ELSE v_operacao := 'DELETE';
    END IF;
    INSERT INTO AUDITORIA (tabela_afetada, operacao, usuario) VALUES ('NOTICIA', v_operacao, USER);
END;
/

INSERT INTO USUARIO (nome, email, senha, fl_doc_verificado, role, cep) VALUES ('Ana Silva', 'ana.silva@example.com', 'senha123', 'S', 'USER', '01001000');
INSERT INTO USUARIO (nome, email, senha, fl_doc_verificado, role, cep) VALUES ('Bruno Costa', 'bruno.costa@example.com', 'senha456', 'N', 'VOLUNTARIO', '20040030');
INSERT INTO USUARIO (nome, email, senha, fl_doc_verificado, role, cep) VALUES ('Carla Mendes', 'carla.mendes@example.com', 'senha789', 'S', 'ADMIN', '30160020');
INSERT INTO USUARIO (nome, email, senha, fl_doc_verificado, role, cep) VALUES ('Diego Rocha', 'diego.rocha@example.com', 'senha321', 'N', 'USER', '40301200');
INSERT INTO USUARIO (nome, email, senha, fl_doc_verificado, role, cep) VALUES ('Eduarda Lima', 'eduarda.lima@example.com', 'senha654', 'S', 'VOLUNTARIO', '50050010');
INSERT INTO USUARIO (nome, email, senha, fl_doc_verificado, role, cep) VALUES ('Fabio Gomes', 'fabio.gomes@example.com', 'senha987', 'S', 'USER', '60060020');
INSERT INTO USUARIO (nome, email, senha, fl_doc_verificado, role, cep) VALUES ('Gabriela Souza', 'gabriela.souza@example.com', 'senha741', 'N', 'ADMIN', '70070030');
INSERT INTO USUARIO (nome, email, senha, fl_doc_verificado, role, cep) VALUES ('Hugo Martins', 'hugo.martins@example.com', 'senha852', 'S', 'USER', '80080040');
INSERT INTO USUARIO (nome, email, senha, fl_doc_verificado, role, cep) VALUES ('Isabela Ferreira', 'isabela.ferreira@example.com', 'senha963', 'N', 'VOLUNTARIO', '90090050');
INSERT INTO USUARIO (nome, email, senha, fl_doc_verificado, role, cep) VALUES ('João Pedro', 'joao.pedro@example.com', 'senha159', 'S', 'USER', '10101060');
INSERT INTO USUARIO (nome, email, senha, fl_doc_verificado, role, cep) VALUES ('Willian Dantas', 'willian.dantas@example.com', 'senha1542', 'S', 'ADMIN', '10101060');


INSERT INTO ENDERECO (usuario_id, logradouro, numero, bairro, cidade, estado, cep) VALUES (1, 'Rua A', '100', 'Centro', 'São Paulo', 'SP', '01001000');
INSERT INTO ENDERECO (usuario_id, logradouro, numero, bairro, cidade, estado, cep) VALUES (2, 'Rua B', '200', 'Jardim', 'Rio de Janeiro', 'RJ', '20040030');
INSERT INTO ENDERECO (usuario_id, logradouro, numero, bairro, cidade, estado, cep) VALUES (3, 'Rua C', '300', 'Savassi', 'Belo Horizonte', 'MG', '30160020');
INSERT INTO ENDERECO (usuario_id, logradouro, numero, bairro, cidade, estado, cep) VALUES (4, 'Rua D', '400', 'Comércio', 'Salvador', 'BA', '40301200');
INSERT INTO ENDERECO (usuario_id, logradouro, numero, bairro, cidade, estado, cep) VALUES (5, 'Rua E', '500', 'Boa Vista', 'Recife', 'PE', '50050010');
INSERT INTO ENDERECO (usuario_id, logradouro, numero, bairro, cidade, estado, cep) VALUES (6, 'Rua F', '600', 'Mooca', 'São Paulo', 'SP', '60060020');
INSERT INTO ENDERECO (usuario_id, logradouro, numero, bairro, cidade, estado, cep) VALUES (7, 'Rua G', '700', 'Ipanema', 'Rio de Janeiro', 'RJ', '70070030');
INSERT INTO ENDERECO (usuario_id, logradouro, numero, bairro, cidade, estado, cep) VALUES (8, 'Rua H', '800', 'Centro', 'Curitiba', 'PR', '80080040');
INSERT INTO ENDERECO (usuario_id, logradouro, numero, bairro, cidade, estado, cep) VALUES (9, 'Rua I', '900', 'Lourdes', 'Belo Horizonte', 'MG', '90090050');
INSERT INTO ENDERECO (usuario_id, logradouro, numero, bairro, cidade, estado, cep) VALUES (10, 'Rua J', '1000', 'Centro', 'Porto Alegre', 'RS', '10101060');

INSERT INTO ALERTA (usuario_id, tipo_alerta, latitude, longitude) VALUES (1, 'Enchente', -23.550520, -46.633308);
INSERT INTO ALERTA (usuario_id, tipo_alerta, latitude, longitude) VALUES (2, 'Incêndio', -22.906847, -43.172896);
INSERT INTO ALERTA (usuario_id, tipo_alerta, latitude, longitude) VALUES (3, 'Alagamento', -19.920830, -43.937778);
INSERT INTO ALERTA (usuario_id, tipo_alerta, latitude, longitude) VALUES (4, 'Deslizamento', -12.971399, -38.501305);
INSERT INTO ALERTA (usuario_id, tipo_alerta, latitude, longitude) VALUES (5, 'Epidemia', -8.047562, -34.877000);
INSERT INTO ALERTA (usuario_id, tipo_alerta, latitude, longitude) VALUES (6, 'Alagamento', -23.550520, -46.633308);
INSERT INTO ALERTA (usuario_id, tipo_alerta, latitude, longitude) VALUES (7, 'Enchente', -22.906847, -43.172896);
INSERT INTO ALERTA (usuario_id, tipo_alerta, latitude, longitude) VALUES (8, 'Incêndio', -19.920830, -43.937778);
INSERT INTO ALERTA (usuario_id, tipo_alerta, latitude, longitude) VALUES (9, 'Deslizamento', -12.971399, -38.501305);
INSERT INTO ALERTA (usuario_id, tipo_alerta, latitude, longitude) VALUES (10, 'Epidemia', -8.047562, -34.877000);

INSERT INTO DOACAO (usuario_id, titulo, descricao, valor) VALUES (1, 'Cesta Básica', 'Doação de alimentos para famílias carentes', 150.00);
INSERT INTO DOACAO (usuario_id, titulo, descricao, valor) VALUES (2, 'Roupas de Inverno', 'Casacos e cobertores', 200.00);
INSERT INTO DOACAO (usuario_id, titulo, descricao, valor) VALUES (3, 'Medicamentos', 'Kit de primeiros socorros', 300.00);
INSERT INTO DOACAO (usuario_id, titulo, descricao, valor) VALUES (4, 'Água Potável', 'Galões de água mineral', 100.00);
INSERT INTO DOACAO (usuario_id, titulo, descricao, valor) VALUES (5, 'Higiene Pessoal', 'Sabonetes e máscaras', 50.00);
INSERT INTO DOACAO (usuario_id, titulo, descricao, valor) VALUES (6, 'Alimentos', 'Pacotes de arroz e feijão', 180.00);
INSERT INTO DOACAO (usuario_id, titulo, descricao, valor) VALUES (7, 'Livros', 'Material escolar para crianças', 120.00);
INSERT INTO DOACAO (usuario_id, titulo, descricao, valor) VALUES (8, 'Brinquedos', 'Brinquedos educativos', 80.00);
INSERT INTO DOACAO (usuario_id, titulo, descricao, valor) VALUES (9, 'Material de Limpeza', 'Produtos de limpeza doméstica', 90.00);
INSERT INTO DOACAO (usuario_id, titulo, descricao, valor) VALUES (10, 'Alimentos', 'Pacotes de macarrão e óleo', 110.00);


INSERT INTO NOTICIA (usuario_id, titulo, subtitulo, conteudo, link) VALUES (1, 'Campanha de Doação', 'Ajude famílias carentes', 'Estamos organizando uma campanha para arrecadação de alimentos.', 'http://example.com/campanha1');
INSERT INTO NOTICIA (usuario_id, titulo, subtitulo, conteudo, link) VALUES (2, 'Voluntariado em Ação', 'Ajudando a comunidade', 'Voluntários se mobilizam para ajudar após enchente.', 'http://example.com/voluntariado2');
INSERT INTO NOTICIA (usuario_id, titulo, subtitulo, conteudo, link) VALUES (3, 'Doação de Roupas', 'Inverno rigoroso', 'Campanha para arrecadação de roupas de frio.', 'http://example.com/roupas3');
INSERT INTO NOTICIA (usuario_id, titulo, subtitulo, conteudo, link) VALUES (4, 'Vacinação Gratuita', 'Proteja-se contra epidemias', 'Postos de saúde oferecem vacinação gratuita.', 'http://example.com/vacinacao4');
INSERT INTO NOTICIA (usuario_id, titulo, subtitulo, conteudo, link) VALUES (5, 'Ação Solidária', 'Comunidade unida', 'Iniciativa de ajuda às famílias afetadas pela tempestade.', 'http://example.com/acao5');
INSERT INTO NOTICIA (usuario_id, titulo, subtitulo, conteudo, link) VALUES (6, 'Campanha Educativa', 'Importância da higiene', 'Escolas realizam campanha educativa sobre higiene.', 'http://example.com/campanha6');
INSERT INTO NOTICIA (usuario_id, titulo, subtitulo, conteudo, link) VALUES (7, 'Ajuda Emergencial', 'Resposta rápida', 'Voluntários atuam em áreas afetadas.', 'http://example.com/ajuda7');
INSERT INTO NOTICIA (usuario_id, titulo, subtitulo, conteudo, link) VALUES (8, 'Reforma Comunitária', 'Melhorias no bairro', 'Obras de melhoria nas áreas comunitárias.', 'http://example.com/reforma8');
INSERT INTO NOTICIA (usuario_id, titulo, subtitulo, conteudo, link) VALUES (9, 'Campanha de Doação', 'Doe alimentos', 'Ajude quem precisa com doações de alimentos.', 'http://example.com/campanha9');
INSERT INTO NOTICIA (usuario_id, titulo, subtitulo, conteudo, link) VALUES (10, 'Voluntariado', 'Juntos somos mais fortes', 'Participe do movimento voluntário local.', 'http://example.com/voluntariado10');

-- Inserção de doações utilizando o package pkg_supernova
BEGIN
  -- Doações para o usuário João Silva
  pkg_supernova.inserir_doacao(1, 'Doação 1', 'Doação de alimentos não perecíveis', 150.00);
  pkg_supernova.inserir_doacao(1, 'Doação 2', 'Doação de roupas e cobertores', 120.00);
  pkg_supernova.inserir_doacao(1, 'Doação 3', 'Campanha de arrecadação para a saúde', 300.00);

  -- Doações para o usuário Bruno Costa
  pkg_supernova.inserir_doacao(2, 'Doação 4', 'Ajuda para vítimas de enchente', 100.00);
  pkg_supernova.inserir_doacao(2, 'Doação 5', 'Materiais de limpeza para as famílias', 80.00);
  pkg_supernova.inserir_doacao(2, 'Doação 6', 'Alimentos e kits de higiene', 200.00);

  -- Doações para a usuária Carla Mendes
  pkg_supernova.inserir_doacao(3, 'Doação 7', 'Doação de brinquedos para crianças', 50.00);
  pkg_supernova.inserir_doacao(3, 'Doação 8', 'Roupas e agasalhos para o inverno', 150.00);

  -- Doações para o usuário Diego Rocha
  pkg_supernova.inserir_doacao(4, 'Doação 9', 'Produtos de higiene para idosos', 120.00);
  pkg_supernova.inserir_doacao(4, 'Doação 10', 'Doação de alimentos e medicamentos', 200.00);

  -- Doações para a usuária Eduarda Lima
  pkg_supernova.inserir_doacao(5, 'Doação 11', 'Alimentos e roupas para famílias carentes', 170.00);
  pkg_supernova.inserir_doacao(5, 'Doação 12', 'Kits de higiene pessoal', 90.00);
END;
/


-- Testando inserção de usuário
BEGIN
  pkg_supernova.inserir_usuario('Carlos Silva', 'carlos.silva@email.com', 'senhaCarlos', 'S', 'USER', '01001010');
END;
/

-- Verificando se o usuário foi inserido
SELECT * FROM USUARIO WHERE email = 'carlos.silva@email.com';

-- Verificando se a auditoria do usuário foi registrada
SELECT * FROM AUDITORIA WHERE tabela_afetada = 'USUARIO' ORDER BY data_alteracao DESC FETCH FIRST 1 ROWS ONLY;

------------------------------------------------------------

-- Testando inserção de endereço para o usuário inserido
DECLARE
  v_usuario_id NUMBER;
BEGIN
  SELECT id INTO v_usuario_id FROM USUARIO WHERE email = 'carlos.silva@email.com';

  pkg_supernova.inserir_endereco(v_usuario_id, 'Rua Teste', '101', 'Bairro Teste', 'São Paulo', 'SP', '01001010');
END;
/

-- Verificando o endereço inserido
SELECT * FROM ENDERECO WHERE usuario_id = (SELECT id FROM USUARIO WHERE email = 'carlos.silva@email.com');

-- Verificando se a auditoria do endereço foi registrada
SELECT * FROM AUDITORIA WHERE tabela_afetada = 'ENDERECO' ORDER BY data_alteracao DESC FETCH FIRST 1 ROWS ONLY;

------------------------------------------------------------

-- Testando a atualização de dados do usuário
BEGIN
  pkg_supernova.atualizar_usuario(1, 'Carlos Silva Jr.', 'carlos.jr@email.com', 'novaSenhaCarlos', 'S', 'ADMIN', '02002020');
END;
/

-- Verificando os dados do usuário após a atualização
SELECT * FROM USUARIO WHERE email = 'carlos.jr@email.com';

-- Verificando se a auditoria do usuário foi registrada para a atualização
SELECT * FROM AUDITORIA WHERE tabela_afetada = 'USUARIO' ORDER BY data_alteracao DESC FETCH FIRST 1 ROWS ONLY;

------------------------------------------------------------

-- Excluindo Registros Filhos
    BEGIN
    -- Excluir ALERTA do usuário
    DELETE FROM ALERTA WHERE usuario_id = 10;

    -- Excluir DOACAO do usuário
    DELETE FROM DOACAO WHERE usuario_id = 10;

    -- Excluir NOTICIA do usuário
    DELETE FROM NOTICIA WHERE usuario_id = 10;

    -- Excluir ENDERECO do usuário
    DELETE FROM ENDERECO WHERE usuario_id = 10;

    COMMIT;
END;

-- Testando exclusão do usuário
BEGIN
  pkg_supernova.deletar_usuario(10);
END;
/
BEGIN
  pkg_supernova.deletar_usuario(11);
END;
/

SELECT * FROM USUARIO;

-- Verificando se a auditoria do usuário foi registrada para a exclusão
SELECT * FROM AUDITORIA WHERE tabela_afetada = 'USUARIO' ORDER BY data_alteracao DESC FETCH FIRST 1 ROWS ONLY;

------------------------------------------------------------

-- Testando inserção de alerta
BEGIN
  pkg_supernova.inserir_alerta(1, 'Enchente', -23.550520, -46.633308);
END;
/

-- Verificando o alerta inserido
SELECT * FROM ALERTA WHERE tipo_alerta = 'Enchente';

-- Verificando se a auditoria do alerta foi registrada
SELECT * FROM AUDITORIA WHERE tabela_afetada = 'ALERTA' ORDER BY data_alteracao DESC FETCH FIRST 1 ROWS ONLY;

------------------------------------------------------------

-- Testando inserção de doação
DECLARE
  v_usuario_id NUMBER;
BEGIN
  SELECT id INTO v_usuario_id FROM USUARIO WHERE email = 'gabriela.souza@example.com';

  INSERT INTO DOACAO (usuario_id, titulo, descricao, valor)
  VALUES (v_usuario_id, 'Doação Alimentos', 'Doação de alimentos para famílias', 150.00);
  COMMIT;
END;
/

-- Verificando a doação inserida
SELECT * FROM DOACAO WHERE titulo = 'Doação Alimentos';

-- Verificando se a auditoria da doação foi registrada
SELECT * FROM AUDITORIA WHERE tabela_afetada = 'DOACAO' ORDER BY data_alteracao DESC FETCH FIRST 1 ROWS ONLY;

------------------------------------------------------------

-- Testando atualização de doação
BEGIN
  UPDATE DOACAO
  SET titulo = 'Doação Roupas', descricao = 'Doação de roupas para o inverno', valor = 200.00
  WHERE titulo = 'Doação Alimentos';
  COMMIT;
END;
/

-- Verificando os dados da doação após a atualização
SELECT * FROM DOACAO WHERE titulo = 'Doação Roupas';

-- Verificando se a auditoria da doação foi registrada para a atualização
SELECT * FROM AUDITORIA WHERE tabela_afetada = 'DOACAO' ORDER BY data_alteracao DESC FETCH FIRST 1 ROWS ONLY;

------------------------------------------------------------

-- Testando exclusão de doação
BEGIN
  DELETE FROM DOACAO WHERE titulo = 'Doação Roupas';
  COMMIT;
END;
/

-- Verificando se a doação foi excluída
SELECT * FROM DOACAO WHERE titulo = 'Doação Roupas';

-- Verificando se a auditoria da doação foi registrada para a exclusão
SELECT * FROM AUDITORIA WHERE tabela_afetada = 'DOACAO' ORDER BY data_alteracao DESC FETCH FIRST 1 ROWS ONLY;

------------------------------------------------------------

-- Testando o relatório de doações
BEGIN
  pkg_supernova.relatorio_doacoes;
END;
/

-- Testando a função de calcular risco de alerta
DECLARE
  v_risco VARCHAR2(20);
  v_usuario_id NUMBER;
BEGIN
  SELECT id INTO v_usuario_id FROM USUARIO WHERE email = 'gabriela.souza@example.com';
  v_risco := pkg_supernova.calcular_risco_alerta(v_usuario_id);
  DBMS_OUTPUT.PUT_LINE('Risco do usuário: ' || v_risco);
END;
/

------------------------------------------------------------

-- Teste de bloco anônimo com IF/ELSE e controle de fluxo
BEGIN
  DECLARE
    v_total_alertas NUMBER;
  BEGIN
    SELECT COUNT(*) INTO v_total_alertas FROM ALERTA WHERE tipo_alerta = 'Enchente';
    IF v_total_alertas > 3 THEN
      DBMS_OUTPUT.PUT_LINE('Atenção: Muitas enchentes registradas!');
    ELSE
      DBMS_OUTPUT.PUT_LINE('Quantidade de enchentes dentro do esperado.');
    END IF;
  END;
END;
/

------------------------------------------------------------

-- Testando consulta avançada com JOINs e agregações
SELECT u.nome,
       COUNT(d.id) AS total_doacoes,
       MAX(d.valor) AS maior_doacao,
       AVG(d.valor) AS media_doacao
FROM USUARIO u
LEFT JOIN DOACAO d ON u.id = d.usuario_id
GROUP BY u.nome
HAVING COUNT(d.id) > 0
ORDER BY total_doacoes DESC;

BEGIN
  DBMS_OUTPUT.PUT_LINE('Teste de saída');
END;
/