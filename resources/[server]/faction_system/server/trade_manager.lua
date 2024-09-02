--[[ 

FALA PESSOAL SEJAM BEM VINDOS
    trade_manager.lua

    Este script gerencia as ofertas de comércio entre facções e jogadores. 
    Ele permite criar novas ofertas de comércio e realizar a compra de recursos.

    Dependências:
    - MySQL-async: Biblioteca para interagir com o banco de dados MySQL.

    Eventos e Funções:

    1. `faction_system:createTrade`:
        - Permite a criação de uma nova oferta de comércio.
        - Parâmetros:
            - `factionId`: ID da facção que está criando a oferta.
            - `resourceName`: Nome do recurso que está sendo oferecido.
            - `quantity`: Quantidade do recurso disponível para venda.
            - `price`: Preço por unidade do recurso.
        - Insere os detalhes da oferta na tabela `trades` do banco de dados.

    2. `faction_system:buyResource`:
        - Permite a compra de um recurso de uma oferta de comércio existente.
        - Parâmetros:
            - `tradeId`: ID da oferta de comércio de onde o recurso será comprado.
            - `quantity`: Quantidade do recurso que está sendo comprada.
        - Verifica se a oferta existe e se a quantidade disponível é suficiente.
        - Calcula o preço total com base na quantidade e no preço unitário do recurso.
        - Atualiza a quantidade disponível da oferta de comércio no banco de dados.
        - Adiciona o valor total da transação à receita da facção que criou a oferta.
        - Notifica o comprador sobre a compra do recurso com o evento `faction_system:resourceBought`.

    Observações:
    - Certifique-se de que a tabela `trades` no banco de dados possui os campos `faction_id`, `resource_name`, `quantity`, e `price`.
    - Certifique-se de que a tabela `income` no banco de dados possui os campos `faction_id` e `amount`.
    - O sistema de armazenamento de recursos para jogadores não está incluído neste script e deve ser implementado separadamente.

    Desenvolvido por @MarcosDev001
--]]

-- Criar uma nova oferta de comércio
RegisterServerEvent('faction_system:createTrade')
AddEventHandler('faction_system:createTrade', function(factionId, resourceName, quantity, price)
    MySQL.Async.execute('INSERT INTO trades (faction_id, resource_name, quantity, price) VALUES (@faction_id, @resource_name, @quantity, @price)', {
        ['@faction_id'] = factionId,
        ['@resource_name'] = resourceName,
        ['@quantity'] = quantity,
        ['@price'] = price
    })
end)

-- Comprar um recurso
RegisterServerEvent('faction_system:buyResource')
AddEventHandler('faction_system:buyResource', function(tradeId, quantity)
    local src = source
    local trade = MySQL.Sync.fetchAll('SELECT * FROM trades WHERE id = @id', {['@id'] = tradeId})[1]

    if trade and trade.quantity >= quantity then
        local totalPrice = trade.price * quantity
        -- Reduzir a quantidade de recursos
        MySQL.Async.execute('UPDATE trades SET quantity = quantity - @quantity WHERE id = @id', {
            ['@quantity'] = quantity,
            ['@id'] = tradeId
        })
        -- Adicionar o custo à facção
        MySQL.Async.execute('INSERT INTO income (faction_id, amount) VALUES (@faction_id, @amount)', {
            ['@faction_id'] = trade.faction_id,
            ['@amount'] = totalPrice
        })
        -- Adicionar o recurso ao comprador
        -- (Supondo que você tenha um sistema para armazenar recursos dos jogadores)
        TriggerClientEvent('faction_system:resourceBought', src, trade.resource_name, quantity)
    end
end)
