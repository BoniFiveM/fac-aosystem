--[[ 

FALA PESSOAL SEJAM BEM VINDOS
    ui_manager.lua

    Este script é responsável por atualizar a interface do usuário (UI) com diferentes 
    listas de dados do sistema de facções. O código usa eventos de rede para receber dados 
    do servidor e atualiza a UI conforme esses dados.

    Funcionamento:
    1. `RegisterNetEvent`: Registra um novo evento de rede que pode ser ouvido pelo cliente.
    2. `AddEventHandler`: Associa uma função de callback a um evento de rede específico. 
       Quando o evento é disparado, a função é chamada com os dados fornecidos.
    3. Cada evento de rede é responsável por atualizar uma parte específica da UI.

    Eventos e suas funções:
    - `faction_system:factionList`:
        - Recebe uma lista de facções e deve atualizar a UI com essas informações.
        
    - `faction_system:territoryList`:
        - Recebe uma lista de territórios e deve atualizar a UI com essas informações.
        
    - `faction_system:missionList`:
        - Recebe uma lista de missões e deve atualizar a UI com essas informações.
        
    - `faction_system:tradeList`:
        - Recebe uma lista de ofertas de comércio e deve atualizar a UI com essas informações.
        
    - `faction_system:eventList`:
        - Recebe uma lista de eventos e deve atualizar a UI com essas informações.

    Observações:
    - Cada função de callback deve ser implementada para realizar a atualização específica 
      da UI com base nos dados recebidos.
    - Certifique-se de que a interface do usuário está corretamente configurada para refletir 
      essas atualizações.

    Desenvolvido por @MarcosDev001
--]]

-- Atualizar a UI com a lista de facções
RegisterNetEvent('faction_system:factionList')
AddEventHandler('faction_system:factionList', function(factions)
    -- Código para atualizar a UI com a lista de facções
end)

-- Atualizar a UI com a lista de territórios
RegisterNetEvent('faction_system:territoryList')
AddEventHandler('faction_system:territoryList', function(territories)
    -- Código para atualizar a UI com a lista de territórios
end)

-- Atualizar a UI com a lista de missões
RegisterNetEvent('faction_system:missionList')
AddEventHandler('faction_system:missionList', function(missions)
    -- Código para atualizar a UI com a lista de missões
end)

-- Atualizar a UI com a lista de ofertas de comércio
RegisterNetEvent('faction_system:tradeList')
AddEventHandler('faction_system:tradeList', function(trades)
    -- Código para atualizar a UI com a lista de ofertas de comércio
end)

-- Atualizar a UI com a lista de eventos
RegisterNetEvent('faction_system:eventList')
AddEventHandler('faction_system:eventList', function(events)
    -- Código para atualizar a UI com a lista de eventos
end)
