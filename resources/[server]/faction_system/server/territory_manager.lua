--[[ 

FALA PESSOAL SEJAM BEM VINDOS
    territory_manager.lua

    Este script gerencia as ações relacionadas aos territórios no sistema de facções. 
    Ele permite reivindicar territórios e atualizar a pontuação de defesa dos territórios.

    Dependências:
    - MySQL-async: Biblioteca para interagir com o banco de dados MySQL.

    Eventos e Funções:

    1. `faction_system:claimTerritory`:
        - Permite a uma facção reivindicar um território.
        - Parâmetros:
            - `territoryId`: ID do território a ser reivindicado.
            - `factionId`: ID da facção que está reivindicando o território.
        - Verifica se o território existe e se a facção que está tentando reivindicar não é a atual dona.
        - Atualiza o `owner_faction_id` do território para a facção que está reivindicando e define a pontuação de defesa inicial para 100.
        - Notifica o cliente que o território foi reivindicado com o evento `faction_system:territoryClaimed`.

    2. `updateDefenseScore`:
        - Atualiza a pontuação de defesa de um território.
        - Parâmetros:
            - `territoryId`: ID do território cuja pontuação de defesa será atualizada.
            - `scoreChange`: Valor a ser adicionado ou subtraído da pontuação de defesa atual.
        - Usa a função `GREATEST` para garantir que a pontuação de defesa nunca seja menor que 0.

    Observações:
    - Certifique-se de que a tabela `territories` no banco de dados possui os campos `owner_faction_id` e `defense_score`.
    - A função `updateDefenseScore` pode ser chamada em diferentes situações para ajustar a defesa do território conforme necessário.

    Desenvolvido por @MarcosDev001
--]]

-- Reivindicar um território
RegisterServerEvent('faction_system:claimTerritory')
AddEventHandler('faction_system:claimTerritory', function(territoryId, factionId)
    local src = source
    local territory = MySQL.Sync.fetchAll('SELECT * FROM territories WHERE id = @id', {['@id'] = territoryId})[1]

    if territory and territory.owner_faction_id ~= factionId then
        MySQL.Async.execute('UPDATE territories SET owner_faction_id = @factionId, defense_score = 100 WHERE id = @territoryId', {
            ['@factionId'] = factionId,
            ['@territoryId'] = territoryId
        }, function(affectedRows)
            if affectedRows > 0 then
                TriggerClientEvent('faction_system:territoryClaimed', src, territoryId)
            end
        end)
    end
end)

-- Atualizar pontuação de defesa
function updateDefenseScore(territoryId, scoreChange)
    MySQL.Async.execute('UPDATE territories SET defense_score = GREATEST(defense_score + @scoreChange, 0) WHERE id = @territoryId', {
        ['@scoreChange'] = scoreChange,
        ['@territoryId'] = territoryId
    })
end
