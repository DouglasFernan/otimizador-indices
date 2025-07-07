-- CENÁRIO 1: ÍNDICE PARCIAL (TABELA TAREFAS)

\echo 'CENÁRIO 1 - PASSO 1: TESTE SEM NENHUM ÍNDICE (PRINT #1)'
EXPLAIN ANALYZE SELECT * FROM tarefas WHERE status = 'pendente';


\echo 'CENÁRIO 1 - PASSO 2: TESTE COM ÍNDICE COMPLETO "INGÊNUO" (PRINT #2)'
CREATE INDEX idx_tarefas_status_completo ON tarefas(status);
EXPLAIN ANALYZE SELECT * FROM tarefas WHERE status = 'pendente';
DROP INDEX idx_tarefas_status_completo;


\echo 'CENÁRIO 1 - PASSO 3: TESTE COM ÍNDICE PARCIAL "INTELIGENTE" (PRINT #3)'
CREATE INDEX idx_tarefas_status_pendente ON tarefas(status) WHERE status = 'pendente';
EXPLAIN ANALYZE SELECT * FROM tarefas WHERE status = 'pendente';


-- CENÁRIO 2: ÍNDICE EM EXPRESSÃO (TABELA USUARIOS)

\echo 'CENÁRIO 2 - PASSO 1: GARANTINDO UM INÍCIO LIMPO'
DROP INDEX IF EXISTS idx_usuarios_username_lower;


\echo 'CENÁRIO 2 - PASSO 2: TESTE SEM ÍNDICE DE EXPRESSÃO (PRINT #4)'
-- ATENÇÃO: Substitua 'user_...' por um username que exista na sua tabela.
-- Você pode pegar um com: SELECT username FROM usuarios LIMIT 1;
-- Esta consulta deve resultar em um "Seq Scan" muito lento.
EXPLAIN ANALYZE SELECT * FROM usuarios WHERE LOWER(username) = LOWER('user_1016963c1b29ab20638e21b8a1e718df');


\echo 'CENÁRIO 2 - PASSO 3: TESTE COM ÍNDICE DE EXPRESSÃO (PRINT #5)'
CREATE INDEX idx_usuarios_username_lower ON usuarios (LOWER(username));
-- A mesma consulta agora deve ser quase instantânea.
EXPLAIN ANALYZE SELECT * FROM usuarios WHERE LOWER(username) = LOWER('user_1016963c1b29ab20638e21b8a1e718df');

\echo 'Todos os testes de performance foram executados.'