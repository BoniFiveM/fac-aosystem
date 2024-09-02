--[[ 

FALA PESSOAL SEJAM BEM VINDOS
    conflict_manager.lua

    Este script gerencia os conflitos entre facções no jogo. Ele inclui a funcionalidade para 
    iniciar e concluir conflitos, bem como atualizar o banco de dados com os resultados desses 
    conflitos.

    Eventos e suas funções:

    1. `faction_system:startConflict`:
        - Inicia um novo conflito entre duas facções por um território específico.
        - Armazena informações sobre o conflito no banco de dados, incluindo IDs das facções 
          atacante e defensora, ID do território e a hora de início do conflito.
        - Parâmetros:
            - `territoryId`: ID do território onde o conflito está ocorrendo.
            - `attackerFactionId`: ID da facção atacante.
            - `defenderFactionId`: ID da facção defensora.
        - A hora de início do conflito é registrada no formato `YYYY-MM-DD HH:MM:SS`.

    2. `faction_system:endConflict`:
        - Conclui um conflito registrado, atualizando o banco de dados com o vencedor e a hora de término.
        - Atualiza o proprietário do território com a facção vencedora.
        - Parâmetros:
            - `conflictId`: ID do conflito que está sendo concluído.
            - `winnerFactionId`: ID da facção vencedora.
        - A hora de término do conflito e o ID da facção vencedora são registrados no banco de dados.
        - O proprietário do território é atualizado com a facção vencedora.

    Observações:
    - Certifique-se de que a estrutura do banco de dados inclui as tabelas `conflicts` e `territories` 
      com os campos apropriados para armazenar informações de conflitos e territórios.
    - O uso de `MySQL.Async.execute` e `MySQL.Sync.fetchAll` requer a biblioteca MySQL-async para 
      interação com o banco de dados.

    Desenvolvido por @MarcosDev001
--]]

-- Iniciar um conflito
RegisterServerEvent('faction_system:startConflict')
AddEventHandler('faction_system:startConflict', function(territoryId, attackerFactionId, defenderFactionId)
    local src = source
    local startTime = os.date('%Y-%m-%d %H:%M:%S')
    
    MySQL.Async.execute('INSERT INTO conflicts (attacker_faction_id, defender_faction_id, territory_id, start_time) VALUES (@attacker_faction_id, @defender_faction_id, @territory_id, @start_time)', {
        ['@attacker_faction_id'] = attackerFactionId,
        ['@defender_faction_id'] = defenderFactionId,
        ['@territory_id'] = territoryId,
        ['@start_time'] = startTime
    })
end)

-- Concluir um conflito
RegisterServerEvent('faction_system:endConflict')
AddEventHandler('faction_system:endConflict', function(conflictId, winnerFactionId)
    local endTime = os.date('%Y-%m-%d %H:%M:%S')
    MySQL.Async.execute('UPDATE conflicts SET end_time = @end_time, winner_faction_id = @winner_faction_id WHERE id = @conflictId', {
        ['@end_time'] = endTime,
        ['@winner_faction_id'] = winnerFactionId,
        ['@conflictId'] = conflictId
    })

    -- Atualizar o proprietário do território
    local conflict = MySQL.Sync.fetchAll('SELECT territory_id FROM conflicts WHERE id = @conflictId', {['@conflictId'] = conflictId})[1]
    MySQL.Async.execute('UPDATE territories SET owner_faction_id = @winner_faction_id WHERE id = @territory_id', {
        ['@winner_faction_id'] = winnerFactionId,
        ['@territory_id'] = conflict.territory_id
    })
end)
