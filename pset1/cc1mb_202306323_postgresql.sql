-- Deleta o banco de dados UVV, caso exista.
DROP DATABASE IF EXISTS uvv;

-- Deleta o usuário, caso exista.
DROP USER IF EXISTS emanueljose;

-- Cria o usuário administrador do banco de dados.
CREATE USER emanueljose
    WITH 
        CREATEDB
        CREATEROLE
        ENCRYPTED PASSWORD 'eacd998fc55a8c0fb38f7a74192de36d';

-- Cria o banco de dados UVV.
CREATE DATABASE uvv
    WITH
        OWNER             = emanueljose
        TEMPLATE          = template0
        ENCODING          = 'UTF8'
        LC_COLLATE        = 'pt_BR.UTF-8'
        LC_CTYPE          = 'pt_BR.UTF-8'
        ALLOW_CONNECTIONS = true;

-- Comenta o banco de dados UVV.
COMMENT ON DATABASE uvv IS 'Esse banco de dados é responsável por armazenar dados dos projetos UVV.';

-- Conecta ao banco de dados UVV com o usuário e senha criados para administração do banco.
\c postgres://emanueljose:eacd998fc55a8c0fb38f7a74192de36d@localhost/uvv

-- Cria o schema lojas com permissão para o usuário administrador.
CREATE SCHEMA lojas AUTHORIZATION emanueljose;

-- Comenta o schema lojas.
COMMENT ON SCHEMA lojas IS 'Esse esquema é responsável por armazenar os dados das Lojas UVV.';

-- Altera o SEARCH_PATH da conexão atual.
SET SEARCH_PATH TO lojas, "$user", public;

-- Altera o SEARCH_PATH padrão do usuário emanueljose para o schema lojas.
ALTER USER emanueljose
SET        SEARCH_PATH TO lojas, "$user", public;

-- Cria a tabela de produtos.
CREATE TABLE produtos (
                produto_id                  NUMERIC(38)     NOT NULL,
                nome                        VARCHAR(255)    NOT NULL,
                preco_unitario              NUMERIC(10,2)           ,
                detalhes                    BYTEA                   ,
                imagem                      BYTEA                   ,
                imagem_mime_type            VARCHAR(512)            ,
                imagem_arquivo              VARCHAR(512)            ,
                imagem_charset              VARCHAR(512)            ,
                imagem_ultima_atualizacao   DATE                    
);

-- Cria a chave primária (PK) da tabela produtos contendo a coluna produto_id.
ALTER TABLE     produtos
ADD CONSTRAINT  pk_produtos
PRIMARY KEY     (produto_id);

/* Cria uma restrição de checagem para a coluna produto_id.
Verificando se o seu valor é maior que zero. */
ALTER TABLE     produtos
ADD CONSTRAINT  cc_produtos_produto_id
CHECK           (produto_id > 0);

/* Cria uma restrição de checagem para a coluna preco_unitario.
Verificando se o valor maior ou igual a 0. */
ALTER TABLE     produtos
ADD CONSTRAINT  cc_produtos_preco_unitario
CHECK           (preco_unitario >= 0);

/* Cria uma restrição de checagem para as colunas relacionadas a imagem.
Verificando se existir imagem, todas as outras colunas relacionadas devem estar preenchidas. */
-- imagem_mime_type
ALTER TABLE     produtos
ADD CONSTRAINT  cc_produtos_imagem_mime_type
CHECK           ((imagem IS NULL     AND imagem_mime_type IS NULL    ) OR
                 (imagem IS NOT NULL AND imagem_mime_type IS NOT NULL));

-- imagem_arquivo
ALTER TABLE     produtos
ADD CONSTRAINT  cc_produtos_imagem_arquivo
CHECK           ((imagem IS NULL     AND imagem_arquivo IS NULL    ) OR
                 (imagem IS NOT NULL AND imagem_arquivo IS NOT NULL));

-- imagem_charset
ALTER TABLE     produtos
ADD CONSTRAINT  cc_produtos_imagem_charset
CHECK           ((imagem IS NULL     AND imagem_charset IS NULL    ) OR
                 (imagem IS NOT NULL AND imagem_charset IS NOT NULL));

-- imagem_ultima_atualizacao
ALTER TABLE     produtos
ADD CONSTRAINT  cc_produtos_imagem_ultima_atualizacao
CHECK           ((imagem IS NULL     AND imagem_ultima_atualizacao IS NULL    ) OR
                 (imagem IS NOT NULL AND imagem_ultima_atualizacao IS NOT NULL));

-- Comenta a tabela produtos.
COMMENT ON TABLE  produtos                            IS 'Essa tabela é responsável por armazenar os dados dos produtos das Lojas UVV.';

-- Comenta as colunas da tabela produtos.
COMMENT ON COLUMN produtos.produto_id                 IS 'ID do Pedido. Essa coluna é a chave primária que identifica o pedido.';
COMMENT ON COLUMN produtos.preco_unitario             IS 'Preço unitário do produto. Essa coluna não pode ter valor menor que zero.';
COMMENT ON COLUMN produtos.detalhes                   IS 'Detalhes do produto.';
COMMENT ON COLUMN produtos.imagem                     IS 'Imagem do produto.';
COMMENT ON COLUMN produtos.imagem_mime_type           IS 'Tipo de dado armazenado na coluna imagem.';
COMMENT ON COLUMN produtos.imagem_arquivo             IS 'Nome do arquivo da imagem do produto. Essa coluna não pode ser nula caso a coluna imagem esteja preenchida.';
COMMENT ON COLUMN produtos.imagem_charset             IS 'Codificação de caracteres utilizada no arquivo da imagem do produto. Essa coluna não pode ser nula caso a coluna imagem esteja preenchida.';
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao  IS 'Data da última atualização da imagem do produto. Essa coluna não pode ser nula caso a coluna imagem esteja preenchida.';

-- Cria a tabela de lojas.
CREATE TABLE lojas (
                loja_id                     NUMERIC(38)     NOT NULL,
                nome                        VARCHAR(255)    NOT NULL,
                endereco_web                VARCHAR(100)            ,
                endereco_fisico             VARCHAR(512)            ,
                latitude                    NUMERIC                 ,
                longitude                   NUMERIC                 ,
                logo                        BYTEA                   ,
                logo_mime_type              VARCHAR(512)            ,
                logo_arquivo                VARCHAR(512)            ,
                logo_charset                VARCHAR(512)            ,
                logo_ultima_atualizacao     DATE
);

-- Cria a chave primária (PK) da tabela lojas contendo a coluna loja_id.
ALTER TABLE     lojas
ADD CONSTRAINT  pk_lojas
PRIMARY KEY     (loja_id);

/* Cria uma restrição de checagem para a coluna loja_id.
Verificando se o seu valor é maior que zero. */
ALTER TABLE     lojas
ADD CONSTRAINT  cc_lojas_loja_id
CHECK           (loja_id > 0);

/* Cria uma restrição de checagem para as colunas endereco_web e endereco_fisico.
Verificando se pelo menos uma das colunas está preenchida. */
ALTER TABLE     lojas
ADD CONSTRAINT  cc_lojas_endereco_web_fisico
CHECK           (endereco_web IS NOT NULL OR endereco_fisico IS NOT NULL);

/* Cria uma restrição de checagem para as colunas relacionadas a logo.
Verificando se existir logo, todas as outras colunas relacionadas devem estar preenchidas. */
-- logo_mime_type
ALTER TABLE     lojas
ADD CONSTRAINT  cc_lojas_logo_mime_type
CHECK           ((logo IS NULL     AND logo_mime_type IS NULL    ) OR
                 (logo IS NOT NULL AND logo_mime_type IS NOT NULL));

-- logo_arquivo
ALTER TABLE     lojas
ADD CONSTRAINT  cc_lojas_logo_arquivo
CHECK           ((logo IS NULL     AND logo_arquivo IS NULL    ) OR
                 (logo IS NOT NULL AND logo_arquivo IS NOT NULL));

-- logo_charset
ALTER TABLE     lojas
ADD CONSTRAINT  cc_lojas_logo_charset
CHECK           ((logo IS NULL     AND logo_charset IS NULL    ) OR
                 (logo IS NOT NULL AND logo_charset IS NOT NULL));

-- logo_ultima_atualizacao
ALTER TABLE     lojas
ADD CONSTRAINT  cc_lojas_logo_ultima_atualizacao
CHECK           ((logo IS NULL     AND logo_ultima_atualizacao IS NULL    ) OR
                 (logo IS NOT NULL AND logo_ultima_atualizacao IS NOT NULL));

-- Comenta a tabela lojas.
COMMENT ON TABLE  lojas                               IS 'Essa tabela é responsável por armazenar os dados das lojas da rede de Lojas UVV.';

-- Comenta as colunas da tabela lojas.
COMMENT ON COLUMN lojas.loja_id                       IS 'ID da Loja. Essa coluna é a chave primária que identifica a loja.';
COMMENT ON COLUMN lojas.nome                          IS 'Nome da Loja. Essa coluna não pode ser nula.';
COMMENT ON COLUMN lojas.endereco_web                  IS 'URL do Site. Essa coluna não pode ser nula se o endereço físico não estiver preenchido.';
COMMENT ON COLUMN lojas.endereco_fisico               IS 'Endereço físico da loja. Essa coluna não pode ser nula se o endereço web não estiver preenchido.';
COMMENT ON COLUMN lojas.latitude                      IS 'Latitude da localidade.';
COMMENT ON COLUMN lojas.longitude                     IS 'Longitude da localidade.';
COMMENT ON COLUMN lojas.logo                          IS 'Logotipo da loja.';
COMMENT ON COLUMN lojas.logo_mime_type                IS 'Tipo de dado armazenado na coluna logo. Essa coluna não pode ser nula caso a coluna logo esteja preenchida.';
COMMENT ON COLUMN lojas.logo_arquivo                  IS 'Nome do arquivo da logotipo da loja. Essa coluna não pode ser nula caso a coluna logo esteja preenchida.';
COMMENT ON COLUMN lojas.logo_charset                  IS 'Codificação de caracteres utilizada no arquivo da logotipo da loja. Essa coluna não pode ser nula caso a coluna logo esteja preenchida.';
COMMENT ON COLUMN lojas.logo_ultima_atualizacao       IS 'Data da última atualização de logotipo. Essa coluna não pode ser nula caso a coluna logo esteja preenchida.';

-- Cria a tabela de estoques.
CREATE TABLE estoques (
                estoque_id                  NUMERIC(38)     NOT NULL,
                loja_id                     NUMERIC(38)     NOT NULL,
                produto_id                  NUMERIC(38)     NOT NULL,
                quantidade                  NUMERIC(38)     NOT NULL
);

-- Cria a chave primária (PK) da tabela estoques contendo a coluna estoque_id.
ALTER TABLE     estoques
ADD CONSTRAINT  pk_estoques
PRIMARY KEY     (estoque_id);

/* Cria uma restrição de checagem para a coluna estoque_id.
Verificando se o seu valor é maior que zero. */
ALTER TABLE     estoques
ADD CONSTRAINT  cc_estoques_estoque_id
CHECK           (estoque_id > 0);

/* Cria uma restrição de checagem para a coluna loja_id.
Verificando se o seu valor é maior que zero. */
ALTER TABLE     estoques
ADD CONSTRAINT  cc_estoques_loja_id
CHECK           (loja_id > 0);

/* Cria uma restrição de checagem para a coluna produto_id.
Verificando se o seu valor é maior que zero. */
ALTER TABLE     estoques
ADD CONSTRAINT  cc_estoques_produto_id
CHECK           (produto_id > 0);

/* Cria uma restrição de checagem para a coluna quantidade.
Verificando se o valor maior ou igual a 0. */
ALTER TABLE     estoques
ADD CONSTRAINT  cc_estoques_quantidade
CHECK           (quantidade >= 0);

-- Comenta a tabela estoques.
COMMENT ON TABLE  estoques                            IS 'Essa tabela é responsável por armazenar os dados dos estoque das Lojas UVV.';

-- Comenta as colunas da tabela estoques.
COMMENT ON COLUMN estoques.estoque_id                 IS 'ID do Estoque. Essa coluna é a chave primária que identifica o estoque.';
COMMENT ON COLUMN estoques.loja_id                    IS 'Loja responsável pelo estoque. Essa coluna é uma chave externa da tabela lojas e não pode ser nula.';
COMMENT ON COLUMN estoques.produto_id                 IS 'ID do Produto. Essa coluna é uma chave externa da tabela produtos e não pode ser nula.';
COMMENT ON COLUMN estoques.quantidade                 IS 'Quantidade em estoque. Essa coluna não pode ser nula e seu valor precisa ser maior ou igual a zero.';

-- Cria a tabela de clientes.
CREATE TABLE clientes (
                cliente_id                  NUMERIC(38)     NOT NULL,
                email                       VARCHAR(255)    NOT NULL,
                nome                        VARCHAR(255)    NOT NULL,
                telefone1                   VARCHAR(20)             ,
                telefone2                   VARCHAR(20)             ,
                telefone3                   VARCHAR(20)
);

-- Cria a chave primária (PK) da tabela clientes contendo a coluna cliente_id.
ALTER TABLE     clientes
ADD CONSTRAINT  pk_clientes
PRIMARY KEY     (cliente_id);

/* Cria uma restrição de checagem para a coluna cliente_id.
Verificando se o seu valor é maior que zero. */
ALTER TABLE     clientes
ADD CONSTRAINT  cc_clientes_cliente_id
CHECK           (cliente_id > 0);

/* Cria uma restrição de checagem para a coluna email.
Verificando se o e-mail inserido é valido conforme os padrões da RFC 5322. 
O padrão REGEX foi retirado da seguinte fonte: https://www.regular-expressions.info/email.html*/
ALTER TABLE     clientes
ADD CONSTRAINT  cc_clientes_email
CHECK           (email ~ '[a-z0-9!#$%&''*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&''*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?');

-- Comenta a tabela clientes.
COMMENT ON TABLE  clientes                            IS 'Essa tabela é responsável por armazenar os dados dos clientes das Lojas UVV.';

-- Comenta as colunas da tabela clientes.
COMMENT ON COLUMN clientes.cliente_id                 IS 'ID do Cliente. Essa coluna é a chave primária que identifica o cliente.';
COMMENT ON COLUMN clientes.email                      IS 'E-mail do cliente. Essa coluna não pode ser nula e precisa atender ao formato de um e-mail.';
COMMENT ON COLUMN clientes.nome                       IS 'Nome do cliente. Essa coluna não pode ser nula.';
COMMENT ON COLUMN clientes.telefone1                  IS 'Telefone principal do cliente.';
COMMENT ON COLUMN clientes.telefone2                  IS 'Telefone secundário do cliente.';
COMMENT ON COLUMN clientes.telefone3                  IS 'Telefone terciário do cliente.';

-- Cria a tabela de envios.
CREATE TABLE envios (
                envio_id                    NUMERIC(38)     NOT NULL,
                loja_id                     NUMERIC(38)     NOT NULL,
                cliente_id                  NUMERIC(38)     NOT NULL,
                endereco_entrega            VARCHAR(512)    NOT NULL,
                status                      VARCHAR(15)     NOT NULL
);

-- Cria a chave primária (PK) da tabela envios contendo a coluna envio_id.
ALTER TABLE     envios
ADD CONSTRAINT  pk_envios
PRIMARY KEY     (envio_id);

/* Cria uma restrição de checagem para a coluna envio_id.
Verificando se o seu valor é maior que zero. */
ALTER TABLE     envios
ADD CONSTRAINT  cc_envios_envio_id
CHECK           (envio_id > 0);

/* Cria uma restrição de checagem para a coluna loja_id.
Verificando se o seu valor é maior que zero. */
ALTER TABLE     envios
ADD CONSTRAINT  cc_envios_loja_id
CHECK           (loja_id > 0);

/* Cria uma restrição de checagem para a coluna cliente_id.
Verificando se o seu valor é maior que zero. */
ALTER TABLE     envios
ADD CONSTRAINT  cc_envios_cliente_id
CHECK           (cliente_id > 0);

/* Cria uma restrição de checagem para a coluna status.
Verificando se ela está dentre os valores permitidos. */
ALTER TABLE     envios
ADD CONSTRAINT  cc_envios_status
CHECK           (status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));

-- Comenta a tabela envios.
COMMENT ON TABLE  envios                              IS 'Essa tabela é responsável por armazenar os dados dos envios realizados pelas Lojas UVV.';

-- Comenta as colunas da tabela envios.
COMMENT ON COLUMN envios.envio_id                     IS 'ID do Envio. Essa coluna é a chave primária que identifica o envio.';
COMMENT ON COLUMN envios.loja_id                      IS 'Loja responsável pelo envio. Essa coluna é uma chave externa da tabela lojas e não pode ser nula.';
COMMENT ON COLUMN envios.cliente_id                   IS 'Cliente destinatário do envio. Essa coluna é uma chave externa da tabela clientes e não pode ser nula.';
COMMENT ON COLUMN envios.endereco_entrega             IS 'Endereço de entrega do envio. Essa coluna não pode ser nula.';
COMMENT ON COLUMN envios.status                       IS 'Situação do pedido. Essa coluna não pode ser nula e deve ser um desses valores: CRIADO, ENVIADO, TRANSITO e ENTREGUE.';

-- Cria a tabela de pedidos.
CREATE TABLE pedidos (
                pedido_id                   NUMERIC(38)     NOT NULL,
                data_hora                   TIMESTAMP       NOT NULL,
                cliente_id                  NUMERIC(38)     NOT NULL,
                status                      VARCHAR(15)     NOT NULL,
                loja_id                     NUMERIC(38)     NOT NULL
);

-- Cria a chave primária (PK) da tabela pedidos contendo a coluna pedido_id.
ALTER TABLE     pedidos
ADD CONSTRAINT  pk_pedidos
PRIMARY KEY     (pedido_id);

/* Cria uma restrição de checagem para a coluna pedido_id.
Verificando se o seu valor é maior que zero. */
ALTER TABLE     pedidos
ADD CONSTRAINT  cc_pedidos_pedido_id
CHECK           (pedido_id > 0);

/* Cria uma restrição de checagem para a coluna cliente_id.
Verificando se o seu valor é maior que zero. */
ALTER TABLE     pedidos
ADD CONSTRAINT  cc_pedidos_cliente_id
CHECK           (cliente_id > 0);

/* Cria uma restrição de checagem para a coluna loja_id.
Verificando se o seu valor é maior que zero. */
ALTER TABLE     pedidos
ADD CONSTRAINT  cc_pedidos_loja_id
CHECK           (loja_id > 0);

/* Cria uma restrição de checagem para a coluna status.
Verificando se ela está dentre os valores permitidos. */
ALTER TABLE     pedidos
ADD CONSTRAINT  cc_pedidos_status
CHECK           (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

-- Comenta a tabela pedidos.
COMMENT ON TABLE  pedidos                             IS 'Essa tabela é responsável por armazenar os pedidos das Lojas UVV.';

-- Comenta as colunas da tabela pedidos.
COMMENT ON COLUMN pedidos.pedido_id                   IS 'ID do Pedido. Essa coluna é a chave primária que identifica o pedido.';
COMMENT ON COLUMN pedidos.data_hora                   IS 'Data e hora de inclusão do pedido. Essa coluna não pode ser nula.';
COMMENT ON COLUMN pedidos.cliente_id                  IS 'Cliente responsável pelo pedido. Essa coluna é uma chave externa da tabela clientes e não pode ser nula.';
COMMENT ON COLUMN pedidos.status                      IS 'Situação do pedido. Essa coluna não pode ser nula e deve ser um desses valores: CANCELADO, COMPLETO, ABERTO, PAGO, REEMBOLSADO E ENVIADO.';
COMMENT ON COLUMN pedidos.loja_id                     IS 'Loja responsável pelo pedido. Essa coluna é uma chave externa da tabela lojas e não pode ser nula.';

-- Cria a tabela de itens do pedido.
CREATE TABLE pedidos_itens (
                pedido_id                   NUMERIC(38)     NOT NULL,
                produto_id                  NUMERIC(38)     NOT NULL,
                numero_da_linha             NUMERIC(38)     NOT NULL,
                preco_unitario              NUMERIC(10,2)   NOT NULL,
                quantidade                  NUMERIC(38)     NOT NULL,
                envio_id                    NUMERIC(38)
);

-- Cria a chave primária (PK) da tabela pedidos_itens contendo as colunas pedido_id e produto_id.
ALTER TABLE     pedidos_itens
ADD CONSTRAINT  pk_pedidos_itens
PRIMARY KEY     (pedido_id, produto_id);

/* Cria uma restrição de checagem para a coluna pedido_id.
Verificando se o seu valor é maior que zero. */
ALTER TABLE     pedidos_itens
ADD CONSTRAINT  cc_pedidos_itens_pedido_id
CHECK           (pedido_id > 0);

/* Cria uma restrição de checagem para a coluna produto_id.
Verificando se o seu valor é maior que zero. */
ALTER TABLE     pedidos_itens
ADD CONSTRAINT  cc_pedidos_itens_produto_id
CHECK           (produto_id > 0);

/* Cria uma restrição UNIQUE para as colunas pedido_id e numero_da_linha.
Para que os valores de número da linha sejam únicos dentro de cada pedido. */
ALTER TABLE     pedidos_itens
ADD CONSTRAINT  uq_pedidos_numero_da_linha
UNIQUE          (pedido_id, numero_da_linha);

/* Cria uma restrição de checagem para a coluna envio_id.
Verificando se o seu valor é maior que zero. */
ALTER TABLE     pedidos_itens
ADD CONSTRAINT  cc_pedidos_itens_envio_id
CHECK           (envio_id > 0);

/* Cria uma restrição de checagem para a coluna preco_unitario.
Verificando se o valor maior ou igual a 0. */
ALTER TABLE     pedidos_itens
ADD CONSTRAINT  cc_pedidos_itens_preco_unitario
CHECK           (preco_unitario >= 0);

/* Cria uma restrição de checagem para a coluna quantidade.
Verificando se o valor maior que 0. */
ALTER TABLE     pedidos_itens
ADD CONSTRAINT  cc_pedidos_itens_quantidade
CHECK           (quantidade > 0);

-- Comenta a tabela pedidos_itens.
COMMENT ON TABLE  pedidos_itens                       IS 'Essa tabela é responsável por armazenar os itens dos pedidos das Lojas UVV.';

-- Comenta as colunas da tabela pedidos_itens.
COMMENT ON COLUMN pedidos_itens.pedido_id             IS 'ID do Pedido. Essa coluna faz parte da chave primária que identifica os itens do pedido.';
COMMENT ON COLUMN pedidos_itens.produto_id            IS 'ID do Produto. Essa coluna faz parte da chave primária que identifica os itens do pedido.';
COMMENT ON COLUMN pedidos_itens.numero_da_linha       IS 'Número da linha do item. Essa coluna não pode ser nula.';
COMMENT ON COLUMN pedidos_itens.preco_unitario        IS 'Preço unitário do item. Essa coluna não pode ser nula e seu valor não pode ser menor que zero.';
COMMENT ON COLUMN pedidos_itens.quantidade            IS 'Quantidade do item. Essa coluna não pode ser nula e seu valor precisa ser maior que zero.';
COMMENT ON COLUMN pedidos_itens.envio_id              IS 'ID do Envio. Essa coluna é uma chave externa da tabela envios.';

-- Cria o relacionamento entre as tabelas produtos e estoques.
ALTER TABLE     estoques 
ADD CONSTRAINT  fk_produtos_estoques
FOREIGN KEY     (produto_id)
REFERENCES      produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Cria o relacionamento entre as tabelas produtos e pedidos_itens.
ALTER TABLE     pedidos_itens 
ADD CONSTRAINT  fk_produtos_pedidos_itens
FOREIGN KEY     (produto_id)
REFERENCES      produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Cria o relacionamento entre as tabelas lojas e pedidos.
ALTER TABLE     pedidos 
ADD CONSTRAINT  fk_lojas_pedidos
FOREIGN KEY     (loja_id)
REFERENCES      lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Cria o relacionamento entre as tabelas lojas e envios.
ALTER TABLE     envios 
ADD CONSTRAINT  fk_lojas_envios
FOREIGN KEY     (loja_id)
REFERENCES      lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Cria o relacionamento entre as tabelas lojas e estoques.
ALTER TABLE     estoques
ADD CONSTRAINT  fk_lojas_estoques
FOREIGN KEY     (loja_id)
REFERENCES      lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Cria o relacionamento entre as tabelas clientes e pedidos.
ALTER TABLE     pedidos
ADD CONSTRAINT  fk_clientes_pedidos
FOREIGN KEY     (cliente_id)
REFERENCES      clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Cria o relacionamento entre as tabelas clientes e envios.
ALTER TABLE     envios
ADD CONSTRAINT  fk_clientes_envios
FOREIGN KEY     (cliente_id)
REFERENCES      clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Cria o relacionamento entre as tabelas envios e pedidos_itens.
ALTER TABLE     pedidos_itens
ADD CONSTRAINT  fk_envios_pedidos_itens
FOREIGN KEY     (envio_id)
REFERENCES      envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Cria o relacionamento entre as tabelas pedidos e pedidos_itens.
ALTER TABLE     pedidos_itens
ADD CONSTRAINT  fk_pedidos_pedidos_itens
FOREIGN KEY     (pedido_id)
REFERENCES      pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
