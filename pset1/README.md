# PSET1 - Banco de Dados das Lojas UVV

Para esse projeto, iremos replicar e implantar o projeto lógico que simula o banco de dados de uma pequena rede de loja, as "Lojas UVV". Esse banco de dados foi disponibilizado pela Oracle para um treinamento em SQL e foi modificado pelo professor para se adequar as necessidades do nosso curso.

## Quais ferramentas foram utilizadas?

- **SQL Power Architect:** O Power Architect foi utilizado para a modelagem do projeto lógico do banco de dados e para gerar a parte inicial do Script SQL de implantação do projeto.
- **PostgreSQL:** Conhecido como o banco de dados _open source_ mais avançado do mundo, ele foi a escolha para implantarmos o banco de dados das Lojas UVV.

## Como implementar esse banco de dados em sua máquina local?

Para implementar esse banco de dados em sua máquina local é bem simples!

### Pré-requisitos
- PostgreSQL 15.1 ou superior;
- Baixar o [Script Global de implementação](../pset1/cc1mb_202306323_postgresql.sql).

### Implementação
1. Baixe o arquivo contendo o Script Global de implementação no PostgreSQL.
2. No terminal da sua máquina, acesse o diretório que armazena o script.
3. Utilize o comando `psql -U postgres < cc1mb_202306323_postgresql.sql` para conectar-se ao banco de dados e executar o script de implementação.
4. Digite a senha para o usuário postgres.

Pronto! Seguindo esse passo a passo, o banco de dados estará implementado no PostgreSQL.

## Como me conectar ao usuário administrador do banco de dados "uvv"?

Para conectar-se ao usuário administrador do banco de dados "uvv", basta utilizar os dados abaixo:

- **Usuário:** emanueljose
- **Senha (md5 hash):** eacd998fc55a8c0fb38f7a74192de36d

Ou, utilize o comando a seguir em seu terminal (caso esteja se conectando na máquina local): `psql postgres://emanueljose:eacd998fc55a8c0fb38f7a74192de36d@localhost/uvv`

## Como esse diretório está dividido?

No diretório "pset1", temos todos os arquivos que fazem parte das entregas que devem ser realizadas nesse PSET.
- **cc1mb_202306323_postgresql.architect:** Esse é o arquivo do projeto lógico replicado no formato do SQL Power Architect.
- **cc1mb_202306323_postgresql.pdf:** Esse é o arquivo do projeto lógico replicado no formato PDF.
- **cc1mb_202306323_postgresql.sql:** Esse é o arquivo do Script Global que implementa o banco de dados no PostgreSQL.
