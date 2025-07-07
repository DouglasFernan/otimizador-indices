CREATE TABLE tarefas (
    id SERIAL PRIMARY KEY,
    descricao TEXT NOT NULL,
    status VARCHAR(20) NOT NULL,
    data_criacao TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabela para o Cenário 2: Índice em Expressão
-- Armazena usuários com usernames únicos.
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL
);

\echo 'Tabelas "tarefas" e "usuarios" criadas com sucesso!'