# PSET1 - Banco de Dados das Lojas UVV

Para esse projeto, iremos replicar e implantar o projeto lógico que simula o banco de dados de uma pequena rede de loja, as "Lojas UVV". Esse banco de dados foi disponibilizado pela Oracle para um treinamento em SQL e foi modificado pelo professor para se adequar as necessidades do nosso curso.

## Quais ferramentas foram utilizadas?

- **SQL Power Architect:** O Power Architect foi utilizado para a modelagem do projeto lógico do banco de dados e para gerar a parte inicial do Script SQL de implantação do projeto.
- **PostgreSQL:** Conhecido como o banco de dados _open source_ mais avançado do mundo, ele foi a escolha para implantarmos o banco de dados das Lojas UVV.
- **MariaDB Community Server:** Como desafio opcional nesse PSET, criei uma implementação do banco de dados das Lojas UVV para o MariaDB.

## Conheça o Projeto Lógico do Banco de Dados
![Projeto Lógico do Banco de Dados da rede de Lojas UVV](/assets/projeto-logico.jpg)

## Como implementar esse banco de dados utilizando o PostgreSQL?

Para implementar esse banco de dados em sua máquina local é bem simples!

### Pré-requisitos
- [PostgreSQL](https://postgresql.com/) 15.1 ou superior;
- Baixar o [Script Global de implementação](../pset1/cc1mb_202306323_postgresql.sql).

### Implementação
1. Baixe o arquivo contendo o Script Global de implementação no PostgreSQL.
2. No terminal da sua máquina, acesse o diretório no qual o script está armazenado utilizando o comando `cd`.
3. Utilize o comando `psql -U postgres < cc1mb_202306323_postgresql.sql` para conectar-se ao banco de dados e executar o script de implementação.
4. Digite a senha para o usuário postgres.

Pronto! Seguindo esse passo a passo, o banco de dados estará implementado no PostgreSQL.

## Como implementar esse banco de dados utilizando o MariaDB/MySQL?

Para implementar esse banco de dados em sua máquina local é bem simples!

### Pré-requisitos
- [MariaDB Community Server](https://mariadb.com/) 10.6 ou superior;
- Baixar o [Script Global de implementação](../pset1/cc1mb_202306323_mysql.sql).

### Implementação
1. Baixe o arquivo contendo o Script Global de implementação no MariaDB.
2. Copie o caminho do arquivo salvo em seu computador.
3. Acesse a linha de comando do MariaDB utilizando o usuário root através do comando `mysql -u root -pSuaSenha` (substitua `SuaSenha` pela senha configurada em seu ambiente).
4. Utilize o comando `source CaminhoDoArquivo;` para executar o script de implementação (substitua `CaminhoDoArquivo` pelo caminho copiado por você no passo 2).

Pronto! Seguindo esse passo a passo, o banco de dados estará implementado no MariaDB/MySQL.

## Como me conectar ao usuário administrador do banco de dados "uvv"?

Para conectar-se ao usuário administrador do banco de dados "uvv", basta utilizar os dados abaixo:

### Caso esteja utilizando o PostgreSQL

- **Usuário:** emanueljose
- **Senha (md5 hash):** eacd998fc55a8c0fb38f7a74192de36d

Você também pode utilizar o comando a seguir para se conectar diretamente no terminal (caso esteja se conectando na máquina local): `psql postgres://emanueljose:eacd998fc55a8c0fb38f7a74192de36d@localhost/uvv`

### Caso esteja usando o MariaDB/MySQL

- **Usuário:** emanueljose@localhost
- **Senha:** Psetuvv@2023

## Como esse diretório está dividido?

No diretório "pset1", temos todos os arquivos que fazem parte das entregas que devem ser realizadas nesse PSET.
- [**cc1mb_202306323_postgresql.architect:**](cc1mb_202306323_postgresql.architect) Esse é o arquivo do projeto lógico replicado no formato do SQL Power Architect.
- [**cc1mb_202306323_postgresql.pdf:**](cc1mb_202306323_postgresql.pdf) Esse é o arquivo do projeto lógico replicado no formato PDF.
- [**cc1mb_202306323_postgresql.sql:**](cc1mb_202306323_postgresql.sql) Esse é o arquivo do Script Global que implementa o banco de dados no PostgreSQL.
- [**cc1mb_202306323_mysql.sql:**](cc1mb_202306323_mysql.sql) Esse é o arquivo do Script Global que implementa o banco de dados no MariaDB/MySQL.
