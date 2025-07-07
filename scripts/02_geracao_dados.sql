-- Populando a tabela 'tarefas' com 20 milhões de linhas.
-- A lógica do CASE garante a distribuição de 98% para 'concluidas' e 2% para 'pendente'.
\echo 'Iniciando a inserção de 20 milhões de registros na tabela "tarefas"...'
INSERT INTO tarefas (descricao, status)
SELECT
    'Tarefa de teste gerada para o usuário ' || s.id,
    CASE
        WHEN random() < 0.02 THEN 'pendente'
        ELSE 'concluidas'
    END
FROM generate_series(1, 20000000) AS s(id);
\echo 'Inserção na tabela "tarefas" concluída.'


-- Populando a tabela 'usuarios' com 5 milhões de linhas.
-- O md5(random()::text) gera usernames aleatórios.
-- ON CONFLICT DO NOTHING ignora erros caso um username duplicado seja gerado.
\echo 'Iniciando a inserção de 5 milhões de registros na tabela "usuarios"...'
INSERT INTO usuarios (username, email)
SELECT
    'user_' || md5(random()::text),
    md5(random()::text) || '@example.com'
FROM generate_series(1, 5000000)
ON CONFLICT (username) DO NOTHING;
\echo 'Inserção na tabela "usuarios" concluída.'
\echo 'Geração de massa de dados finalizada com sucesso!'