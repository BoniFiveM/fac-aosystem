--[[ 
 FALA PESSOAL SEJAM BEM VINDOS
    interaction.lua

    Este script define comandos que os jogadores podem usar para interagir com o sistema de facções 
    no jogo. Os comandos registrados permitem que os jogadores reivindiquem territórios e comprem 
    recursos. Quando um comando é executado, ele aciona um evento no servidor para processar a 
    solicitação.

    Comandos definidos:
    1. `claimTerritory`: Permite que um jogador reivindique um território específico.
    2. `buyResource`: Permite que um jogador compre uma quantidade específica de um recurso.

    Funcionamento:
    1. `RegisterCommand`: Registra um novo comando que pode ser usado no jogo.
    2. `source`: Representa o ID do jogador que executou o comando.
    3. `args`: É uma tabela que contém os argumentos fornecidos pelo jogador com o comando.
    4. `TriggerServerEvent`: Envia um evento para o servidor para processar a ação solicitada.

    Detalhes dos Comandos:
    - `claimTerritory`:
        - Argumento: `territoryId` (ID do território que o jogador deseja reivindicar).
        - O comando chama o evento `faction_system:claimTerritory` no servidor, passando o ID do território 
          e a facção do jogador (obtida pela função `GetPlayerFaction(source)`).

    - `buyResource`:
        - Argumentos: `tradeId` (ID do recurso que o jogador deseja comprar) e `quantity` (quantidade do 
          recurso a ser comprada).
        - O comando chama o evento `faction_system:buyResource` no servidor, passando o ID do recurso e a 
          quantidade desejada.
             Desenvolvido por @MarcosDev001

--]]

-- Comando para reivindicar um território
RegisterCommand('claimTerritory', function(source, args, rawCommand)
    local territoryId = tonumber(args[1]) -- Obtém o ID do território a partir dos argumentos
    TriggerServerEvent('faction_system:claimTerritory', territoryId, GetPlayerFaction(source)) -- Aciona o evento no servidor
end, false)

-- Comando para comprar um recurso
RegisterCommand('buyResource', function(source, args, rawCommand)
    local tradeId = tonumber(args[1]) -- Obtém o ID do recurso a partir dos argumentos
    local quantity = tonumber(args[2]) -- Obtém a quantidade do recurso a partir dos argumentos
    TriggerServerEvent('faction_system:buyResource', tradeId, quantity) -- Aciona o evento no servidor
end, false)
