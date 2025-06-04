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
