--[[ 

FALA PESSOAL SEJAM BEM VINDOS
    mission_manager.lua

    Este script gerencia a criação e a conclusão de missões dentro do sistema de facções. 
    Ele fornece funcionalidades para criar novas missões e completar missões existentes, 
    além de atualizar o status das missões e recompensar facções.

    Dependências:
    - MySQL-async: Biblioteca para interagir com o banco de dados MySQL.

    Eventos e Funções:

    1. `faction_system:createMission`:
        - Cria uma nova missão e a armazena no banco de dados.
        - Parâmetros:
            - `name`: Nome da missão.
            - `description`: Descrição da missão.
            - `reward`: Recompensa associada à missão (valor monetário ou similar).
            - `factionId`: ID da facção que recebe a missão.
        - Insere os detalhes da missão na tabela `missions` do banco de dados.
        - Após a inserção bem-sucedida, o cliente que criou a missão é notificado com o evento `faction_system:missionCreated`.

    2. `faction_system:completeMission`:
        - Marca uma missão como completa e atualiza o banco de dados.
        - Parâmetros:
            - `missionId`: ID da missão que está sendo completada.
        - Verifica se a missão existe e está ativa.
        - Atualiza o status da missão para "completed" na tabela `missions`.
        - Adiciona a recompensa da missão à receita da facção correspondente na tabela `income`.
        - Notifica o cliente que completou a missão com o evento `faction_system:missionCompleted`.

    Observações:
    - Certifique-se de que a tabela `missions` no banco de dados possui os campos `name`, `description`, `reward`, `faction_id`, e `status`.
    - Certifique-se de que a tabela `income` no banco de dados possui os campos `faction_id` e `amount`.
    - O uso de `MySQL.Async.execute` e `MySQL.Sync.fetchAll` requer a biblioteca MySQL-async para interagir com o banco de dados.

    Desenvolvido por @MarcosDev001
--]]

-- Criar uma nova missão
RegisterServerEvent('faction_system:createMission')
AddEventHandler('faction_system:createMission', function(name, description, reward, factionId)
    local src = source
    MySQL.Async.execute('INSERT INTO missions (name, description, reward, faction_id) VALUES (@name, @description, @reward, @faction_id)', {
        ['@name'] = name,
        ['@description'] = description,
        ['@reward'] = reward,
        ['@faction_id'] = factionId
    }, function(affectedRows)
        if affectedRows > 0 then
            TriggerClientEvent('faction_system:missionCreated', src, name)
        end
    end)
end)

-- Completar uma missão
RegisterServerEvent('faction_system:completeMission')
AddEventHandler('faction_system:completeMission', function(missionId)
    local src = source
    local mission = MySQL.Sync.fetchAll('SELECT * FROM missions WHERE id = @id', {['@id'] = missionId})[1]

    if mission and mission.status == 'active' then
        MySQL.Async.execute('UPDATE missions SET status = "completed" WHERE id = @id', {
            ['@id'] = missionId
        }, function(affectedRows)
            if affectedRows > 0 then
                MySQL.Async.execute('UPDATE income SET amount = amount + @reward WHERE faction_id = @faction_id', {
                    ['@reward'] = mission.reward,
                    ['@faction_id'] = mission.faction_id
                })
                TriggerClientEvent('faction_system:missionCompleted', src, missionId)
            end
        end)
    end
end)
