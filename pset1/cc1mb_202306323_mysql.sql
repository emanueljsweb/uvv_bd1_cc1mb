-- Deleta o banco de dados UVV, caso exista.
DROP DATABASE IF EXISTS uvv;

-- Deleta o usuário, caso exista.
DROP USER IF EXISTS 'emanueljose'@'localhost';

-- Cria o usuário administrador do banco de dados.
CREATE USER 'emanueljose'@'localhost' IDENTIFIED BY 'Psetuvv@2023';

-- Permite que o usuário crie novos bancos de dados e novos usuários.
GRANT CREATE USER ON *.* TO 'emanueljose'@'localhost';
GRANT CREATE ON *.* TO 'emanueljose'@'localhost';

-- Cria o banco de dados UVV.
CREATE DATABASE uvv;

-- Define a codificação que será utilizada nesse banco de dados.
ALTER DATABASE  uvv
CHARSET =       UTF8 
COLLATE =       utf8_general_ci;

-- Comenta o banco de dados UVV.
ALTER DATABASE  uvv
COMMENT         'Esse banco de dados é responsável por armazenar os dados das Lojas UVV.';

-- Conecta-se ao banco de dados UVV.
USE uvv;

-- Cria a tabela de produtos.
CREATE TABLE produtos (
                produto_id                  NUMERIC(38)     NOT NULL,
                nome                        VARCHAR(255)    NOT NULL,
                preco_unitario              NUMERIC(10,2)           ,
                detalhes                    BLOB                    ,
                imagem                      BLOB                    ,
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
ALTER TABLE     produtos
COMMENT         'Essa tabela é responsável por armazenar os dados dos produtos das Lojas UVV.';

-- Comenta as colunas da tabela produtos.
ALTER TABLE     produtos 
MODIFY COLUMN   produto_id NUMERIC(38) 
COMMENT         'ID do Pedido. Essa coluna é a chave primária que identifica o pedido.';

ALTER TABLE     produtos
MODIFY COLUMN   preco_unitario NUMERIC(10, 2) 
COMMENT         'Preço unitário do produto. Essa coluna não pode ter valor menor que zero.';

ALTER TABLE     produtos 
MODIFY COLUMN   detalhes BLOB 
COMMENT         'Detalhes do produto.';

ALTER TABLE     produtos 
MODIFY COLUMN   imagem BLOB 
COMMENT         'Imagem do produto.';

ALTER TABLE     produtos 
MODIFY COLUMN   imagem_mime_type VARCHAR(512) 
COMMENT         'Tipo de dado armazenado na coluna imagem. Essa coluna não pode ser nula caso a coluna imagem esteja preenchida.';

ALTER TABLE     produtos 
MODIFY COLUMN   imagem_arquivo VARCHAR(512) 
COMMENT         'Nome do arquivo da imagem do produto. Essa coluna não pode ser nula caso a coluna imagem esteja preenchida.';

ALTER TABLE     produtos 
MODIFY COLUMN   imagem_charset VARCHAR(512) 
COMMENT         'Codificação de caracteres utilizada no arquivo da imagem do produto. Essa coluna não pode ser nula caso a coluna imagem esteja preenchida.';

ALTER TABLE     produtos 
MODIFY COLUMN   imagem_ultima_atualizacao DATE 
COMMENT         'Data da última atualização da imagem do produto. Essa coluna não pode ser nula caso a coluna imagem esteja preenchida.';

-- Cria a tabela de lojas.
CREATE TABLE lojas (
                loja_id                     NUMERIC(38)     NOT NULL,
                nome                        VARCHAR(255)    NOT NULL,
                endereco_web                VARCHAR(100)            ,
                endereco_fisico             VARCHAR(512)            ,
                latitude                    NUMERIC                 ,
                longitude                   NUMERIC                 ,
                logo                        BLOB                    ,
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
ALTER TABLE     lojas
COMMENT         'Essa tabela é responsável por armazenar os dados das lojas da rede de Lojas UVV.';

-- Comenta as colunas da tabela lojas.
ALTER TABLE     lojas 
MODIFY COLUMN   loja_id NUMERIC(38) 
COMMENT         'ID da Loja. Essa coluna é a chave primária que identifica a loja.';

ALTER TABLE     lojas 
MODIFY COLUMN   nome VARCHAR(255) 
COMMENT         'Nome da Loja. Essa coluna não pode ser nula.';

ALTER TABLE     lojas 
MODIFY COLUMN   endereco_web VARCHAR(100) 
COMMENT         'URL do Site. Essa coluna não pode ser nula se o endereço físico não estiver preenchido.';

ALTER TABLE     lojas 
MODIFY COLUMN   endereco_fisico VARCHAR(512) 
COMMENT         'Endereço físico da loja. Essa coluna não pode ser nula se o endereço web não estiver preenchido.';

ALTER TABLE     lojas 
MODIFY COLUMN   latitude NUMERIC 
COMMENT         'Latitude da localidade.';

ALTER TABLE     lojas 
MODIFY COLUMN   longitude NUMERIC 
COMMENT         'Longitude da localidade.';

ALTER TABLE     lojas 
MODIFY COLUMN   logo BLOB 
COMMENT         'Logotipo da loja.';

ALTER TABLE     lojas 
MODIFY COLUMN   logo_mime_type VARCHAR(512) 
COMMENT         'Tipo de dado armazenado na coluna logo. Essa coluna não pode ser nula caso a coluna logo esteja preenchida.';

ALTER TABLE     lojas 
MODIFY COLUMN   logo_arquivo VARCHAR(512) 
COMMENT         'Nome do arquivo da logotipo da loja. Essa coluna não pode ser nula caso a coluna logo esteja preenchida.';

ALTER TABLE     lojas 
MODIFY COLUMN   logo_charset VARCHAR(512) 
COMMENT         'Codificação de caracteres utilizada no arquivo da logotipo da loja. Essa coluna não pode ser nula caso a coluna logo esteja preenchida.';

ALTER TABLE     lojas 
MODIFY COLUMN   logo_ultima_atualizacao DATE 
COMMENT         'Data da última atualização de logotipo. Essa coluna não pode ser nula caso a coluna logo esteja preenchida.';

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
ALTER TABLE     estoques
COMMENT         'Essa tabela é responsável por armazenar os dados dos estoque das Lojas UVV.';

-- Comenta as colunas da tabela estoques.
ALTER TABLE     estoques
MODIFY COLUMN   estoque_id NUMERIC(38) 
COMMENT         'ID do Estoque. Essa coluna é a chave primária que identifica o estoque.';

ALTER TABLE     estoques 
MODIFY COLUMN   loja_id NUMERIC(38)
COMMENT         'Loja responsável pelo estoque. Essa coluna é uma chave externa da tabela lojas e não pode ser nula.';

ALTER TABLE     estoques
MODIFY COLUMN   produto_id NUMERIC(38)
COMMENT         'ID do Produto. Essa coluna é uma chave externa da tabela produtos e não pode ser nula.';

ALTER TABLE     estoques
MODIFY COLUMN   quantidade NUMERIC(38)
COMMENT         'Quantidade em estoque. Essa coluna não pode ser nula e seu valor precisa ser maior ou igual a zero.';

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
CHECK           (email RLIKE '[a-z0-9!#$%&''*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&''*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?');

-- Comenta a tabela clientes.
ALTER TABLE     clientes
COMMENT         'Essa tabela é responsável por armazenar os dados dos clientes das Lojas UVV.';

-- Comenta as colunas da tabela clientes.
ALTER TABLE     clientes
MODIFY COLUMN   cliente_id NUMERIC(38)
COMMENT         'ID do Cliente. Essa coluna é a chave primária que identifica o cliente.';

ALTER TABLE     clientes
MODIFY COLUMN   email VARCHAR(255) 
COMMENT         'E-mail do cliente. Essa coluna não pode ser nula e precisa atender ao formato de um e-mail.';

ALTER TABLE     clientes 
MODIFY COLUMN   nome VARCHAR(255) 
COMMENT         'Nome do cliente. Essa coluna não pode ser nula.';

ALTER TABLE     clientes 
MODIFY COLUMN   telefone1 VARCHAR(20) 
COMMENT         'Telefone principal do cliente.';

ALTER TABLE     clientes 
MODIFY COLUMN   telefone2 VARCHAR(20) 
COMMENT         'Telefone secundário do cliente.';

ALTER TABLE     clientes 
MODIFY COLUMN   telefone3 VARCHAR(20) 
COMMENT         'Telefone terciário do cliente.';

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
ALTER TABLE     envios
COMMENT         'Essa tabela é responsável por armazenar os dados dos envios realizados pelas Lojas UVV.';

-- Comenta as colunas da tabela envios.
ALTER TABLE     envios
MODIFY COLUMN   envio_id NUMERIC(38) 
COMMENT         'ID do Envio. Essa coluna é a chave primária que identifica o envio.';

ALTER TABLE     envios 
MODIFY COLUMN   loja_id NUMERIC(38) 
COMMENT         'Loja responsável pelo envio. Essa coluna é uma chave externa da tabela lojas e não pode ser nula.';

ALTER TABLE     envios 
MODIFY COLUMN   cliente_id NUMERIC(38) 
COMMENT         'Cliente destinatário do envio. Essa coluna é uma chave externa da tabela clientes e não pode ser nula.';

ALTER TABLE     envios 
MODIFY COLUMN   endereco_entrega VARCHAR(512) 
COMMENT         'Endereço de entrega do envio. Essa coluna não pode ser nula.';

ALTER TABLE     envios 
MODIFY COLUMN   status VARCHAR(15) 
COMMENT         'Situação do pedido. Essa coluna não pode ser nula e deve ser um desses valores: CRIADO, ENVIADO, TRANSITO e ENTREGUE.';

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
ALTER TABLE     pedidos 
COMMENT         'Essa tabela é responsável por armazenar os pedidos das Lojas UVV.';

-- Comenta as colunas da tabela pedidos.

ALTER TABLE     pedidos 
MODIFY COLUMN   pedido_id NUMERIC(38) 
COMMENT         'ID do Pedido. Essa coluna é a chave primária que identifica o pedido.';

ALTER TABLE     pedidos 
MODIFY COLUMN   data_hora TIMESTAMP 
COMMENT         'Data e hora de inclusão do pedido. Essa coluna não pode ser nula.';

ALTER TABLE     pedidos 
MODIFY COLUMN   cliente_id NUMERIC(38) 
COMMENT         'Cliente responsável pelo pedido. Essa coluna é uma chave externa da tabela clientes e não pode ser nula.';

ALTER TABLE     pedidos 
MODIFY COLUMN   status VARCHAR(15) 
COMMENT         'Situação do pedido. Essa coluna não pode ser nula e deve ser um desses valores: CANCELADO, COMPLETO, ABERTO, PAGO, REEMBOLSADO E ENVIADO.';

ALTER TABLE     pedidos 
MODIFY COLUMN   loja_id NUMERIC(38) 
COMMENT         'Loja responsável pelo pedido. Essa coluna é uma chave externa da tabela lojas e não pode ser nula.';

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
ALTER TABLE     pedidos_itens
COMMENT         'Essa tabela é responsável por armazenar os itens dos pedidos das Lojas UVV.';

-- Comenta as colunas da tabela pedidos_itens.
ALTER TABLE     pedidos_itens
MODIFY COLUMN   pedido_id NUMERIC(38) 
COMMENT         'ID do Pedido. Essa coluna faz parte da chave primária que identifica os itens do pedido.';

ALTER TABLE     pedidos_itens
MODIFY COLUMN   produto_id NUMERIC(38)
COMMENT         'ID do Produto. Essa coluna faz parte da chave primária que identifica os itens do pedido.';

ALTER TABLE     pedidos_itens
MODIFY COLUMN   numero_da_linha NUMERIC(38) 
COMMENT         'Número da linha do item. Essa coluna não pode ser nula.';

ALTER TABLE     pedidos_itens 
MODIFY COLUMN   preco_unitario NUMERIC(10, 2) 
COMMENT         'Preço unitário do item. Essa coluna não pode ser nula e seu valor não pode ser menor que zero.';

ALTER TABLE     pedidos_itens 
MODIFY COLUMN   quantidade NUMERIC(38) 
COMMENT         'Quantidade do item. Essa coluna não pode ser nula.';

ALTER TABLE     pedidos_itens 
MODIFY COLUMN   envio_id NUMERIC(38) 
COMMENT         'ID do Envio. Essa coluna é uma chave externa da tabela envios.';

-- Cria o relacionamento entre as tabelas produtos e estoques.
ALTER TABLE     estoques 
ADD CONSTRAINT  fk_produtos_estoques
FOREIGN KEY     (produto_id)
REFERENCES      produtos(produto_id);

-- Cria o relacionamento entre as tabelas produtos e pedidos_itens.
ALTER TABLE     pedidos_itens 
ADD CONSTRAINT  fk_produtos_pedidos_itens
FOREIGN KEY     (produto_id)
REFERENCES      produtos(produto_id);

-- Cria o relacionamento entre as tabelas lojas e pedidos.
ALTER TABLE     pedidos 
ADD CONSTRAINT  fk_lojas_pedidos
FOREIGN KEY     (loja_id)
REFERENCES      lojas (loja_id);

-- Cria o relacionamento entre as tabelas lojas e envios.
ALTER TABLE     envios 
ADD CONSTRAINT  fk_lojas_envios
FOREIGN KEY     (loja_id)
REFERENCES      lojas(loja_id);

-- Cria o relacionamento entre as tabelas lojas e estoques.
ALTER TABLE     estoques
ADD CONSTRAINT  fk_lojas_estoques
FOREIGN KEY     (loja_id)
REFERENCES      lojas(loja_id);

-- Cria o relacionamento entre as tabelas clientes e pedidos.
ALTER TABLE     pedidos
ADD CONSTRAINT  fk_clientes_pedidos
FOREIGN KEY     (cliente_id)
REFERENCES      clientes(cliente_id);

-- Cria o relacionamento entre as tabelas clientes e envios.
ALTER TABLE     envios
ADD CONSTRAINT  fk_clientes_envios
FOREIGN KEY     (cliente_id)
REFERENCES      clientes(cliente_id);

-- Cria o relacionamento entre as tabelas envios e pedidos_itens.
ALTER TABLE     pedidos_itens
ADD CONSTRAINT  fk_envios_pedidos_itens
FOREIGN KEY     (envio_id)
REFERENCES      envios(envio_id);

-- Cria o relacionamento entre as tabelas pedidos e pedidos_itens.
ALTER TABLE     pedidos_itens
ADD CONSTRAINT  fk_pedidos_pedidos_itens
FOREIGN KEY     (pedido_id)
REFERENCES      pedidos(pedido_id);