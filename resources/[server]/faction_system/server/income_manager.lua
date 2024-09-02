--[[ 

FALA PESSOAL SEJAM BEM VINDOS
    income_manager.lua

    Este script gerencia o cálculo e registro dos rendimentos das facções com base nos 
    territórios que elas controlam. Ele executa um ciclo contínuo para calcular e registrar 
    os rendimentos periodicamente.

    Dependências:
    - MySQL-async: Biblioteca para interagir com o banco de dados MySQL.
    - `Config.IncomeInterval`: Intervalo de tempo, definido na configuração, para calcular 
      e registrar rendimentos (em milissegundos).

    Funcionamento:

    1. O script cria uma thread que executa continuamente.
    2. A cada `Config.IncomeInterval` milissegundos, o script realiza as seguintes ações:
        - Obtém todos os territórios do banco de dados usando `MySQL.Sync.fetchAll`.
        - Para cada território, calcula o rendimento como 10% da receita (`territory.revenue`).
        - Registra o rendimento na tabela `income` do banco de dados, associando o rendimento à facção que possui o território.

    Observações:
    - Certifique-se de que a tabela `territories` no banco de dados possui os campos `revenue` e `owner_faction_id`.
    - Certifique-se de que a tabela `income` no banco de dados possui os campos `faction_id` e `amount`.
    - O valor de `Config.IncomeInterval` deve ser configurado adequadamente para determinar a frequência com que os rendimentos são atualizados.

    Desenvolvido por @MarcosDev001
--]]

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.IncomeInterval) -- Intervalo de rendimentos
        local territories = MySQL.Sync.fetchAll('SELECT * FROM territories')
        for _, territory in ipairs(territories) do
            local income = territory.revenue * 0.1 -- 10% de rendimento
            MySQL.Async.execute('INSERT INTO income (faction_id, amount) VALUES (@faction_id, @amount)', {
                ['@faction_id'] = territory.owner_faction_id,
                ['@amount'] = income
            })
        end
    end
end)
