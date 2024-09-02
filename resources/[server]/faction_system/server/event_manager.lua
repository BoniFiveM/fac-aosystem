--[[ 

FALA PESSOAL SEJAM BEM VINDOS
    event_manager.lua

    Este script gerencia os eventos dentro do sistema de facções. Ele fornece funcionalidades 
    para criar novos eventos, atualizar o status de eventos existentes e obter uma lista de 
    eventos ativos.

    Eventos e Funções:

    1. `faction_system:createEvent`:
        - Cria um novo evento e o armazena no banco de dados.
        - Parâmetros:
            - `name`: Nome do evento.
            - `description`: Descrição do evento.
            - `startTime`: Hora de início do evento no formato `YYYY-MM-DD HH:MM:SS`.
            - `endTime`: Hora de término do evento no formato `YYYY-MM-DD HH:MM:SS`.
        - Insere os detalhes do evento na tabela `events` do banco de dados.

    2. `faction_system:updateEventStatus`:
        - Atualiza o status de um evento específico para indicar se está ativo ou não.
        - Parâmetros:
            - `eventId`: ID do evento a ser atualizado.
            - `isActive`: Valor booleano (`TRUE` ou `FALSE`) que indica se o evento está ativo.
        - Atualiza o campo `is_active` na tabela `events` com o novo status.

    3. `getActiveEvents`:
        - Função que retorna uma lista de todos os eventos que estão atualmente ativos.
        - Utiliza `MySQL.Sync.fetchAll` para consultar o banco de dados e retornar eventos com 
          `is_active = TRUE`.

    Observações:
    - Certifique-se de que a tabela `events` no banco de dados possui os campos apropriados, 
      incluindo `name`, `description`, `start_time`, `end_time`, e `is_active`.
    - O uso de `MySQL.Async.execute` e `MySQL.Sync.fetchAll` requer a biblioteca MySQL-async 
      para interagir com o banco de dados.

    Desenvolvido por @MarcosDev001
--]]

-- Criar um novo evento
RegisterServerEvent('faction_system:createEvent')
AddEventHandler('faction_system:createEvent', function(name, description, startTime, endTime)
    MySQL.Async.execute('INSERT INTO events (name, description, start_time, end_time) VALUES (@name, @description, @start_time, @end_time)', {
        ['@name'] = name,
        ['@description'] = description,
        ['@start_time'] = startTime,
        ['@end_time'] = endTime
    })
end)

-- Atualizar status do evento
RegisterServerEvent('faction_system:updateEventStatus')
AddEventHandler('faction_system:updateEventStatus', function(eventId, isActive)
    MySQL.Async.execute('UPDATE events SET is_active = @is_active WHERE id = @eventId', {
        ['@is_active'] = isActive,
        ['@eventId'] = eventId
    })
end)

-- Obter eventos ativos
function getActiveEvents()
    return MySQL.Sync.fetchAll('SELECT * FROM events WHERE is_active = TRUE')
end
