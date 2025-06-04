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