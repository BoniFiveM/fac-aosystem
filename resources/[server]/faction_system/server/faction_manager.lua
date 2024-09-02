--[[ 

FALA PESSOAL SEJAM BEM VINDOS
    faction_manager.lua

    Este script gerencia as facções dentro do sistema. Ele permite a criação de novas facções 
    e notifica o cliente quando uma facção é criada com sucesso.

    Dependências:
    - MySQL-async: Biblioteca para interagir com o banco de dados MySQL.

    Eventos e Funções:

    1. `faction_system:createFaction`:
        - Cria uma nova facção e a armazena no banco de dados.
        - Parâmetros:
            - `name`: Nome da facção.
            - `color`: Cor associada à facção (em formato hexadecimal).
            - `specialization`: Especialização ou tipo da facção.
        - `leader_id`: ID do jogador que está criando a facção, representado pela variável `src`.
        - Insere os detalhes da facção na tabela `factions` do banco de dados.
        - Após a inserção bem-sucedida, o cliente que criou a facção é notificado com o evento `faction_system:factionCreated`.

    Observações:
    - Certifique-se de que a tabela `factions` no banco de dados possui os campos apropriados, 
      incluindo `name`, `color`, `leader_id`, e `specialization`.
    - O uso de `MySQL.Async.execute` requer a biblioteca MySQL-async para interagir com o banco de dados.
    - A função de callback em `MySQL.Async.execute` verifica se a inserção foi bem-sucedida (se `affectedRows` é maior que 0) e, em seguida, dispara um evento para o cliente.

    Desenvolvido por @MarcosDev001
--]]

local MySQL = require('mysql-async') -- Biblioteca MySQL

-- Criar uma nova facção
RegisterServerEvent('faction_system:createFaction')
AddEventHandler('faction_system:createFaction', function(name, color, specialization)
    local src = source
    MySQL.Async.execute('INSERT INTO factions (name, color, leader_id, specialization) VALUES (@name, @color, @leader_id, @specialization)', {
        ['@name'] = name,
        ['@color'] = color,
        ['@leader_id'] = src,
        ['@specialization'] = specialization
    }, function(affectedRows)
        if affectedRows > 0 then
            TriggerClientEvent('faction_system:factionCreated', src, name)
        end
    end)
end)
