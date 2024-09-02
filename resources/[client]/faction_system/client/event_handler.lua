--[[ 

FALA PESSOAL SEJAM BEM VINDOS

    event_handler.lua

    Este script é responsável por atualizar e processar eventos de forma periódica no jogo. 
    O código utiliza uma thread para realizar atualizações regulares, consultando o servidor 
    para obter informações sobre eventos e, em seguida, processa esses eventos conforme 
    necessário.

    Funcionamento:
    1. Uma nova thread é criada para operar de forma assíncrona.
    2. A thread entra em um loop infinito para garantir que as atualizações sejam realizadas 
       continuamente.
    3. A cada 60 segundos (60000 milissegundos), a thread chama a função fictícia 
       `GetEventsFromServer()` para obter a lista de eventos do servidor.
    4. Para cada evento recebido, o script verifica se o evento está ativo (`event.is_active`).
    5. Se o evento estiver ativo, o código para exibir ou processar o evento deve ser executado 
       (esse trecho está indicado como um local para implementação futura).

    Observações:
    - A função `GetEventsFromServer()` deve ser substituída por uma implementação real que 
      recupere eventos do servidor.
    - O trecho onde está indicado o código para exibir eventos ativos precisa ser implementado 
      conforme os requisitos específicos do sistema ou do jogo.


           Desenvolvido por @MarcosDev001
--]]

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000) -- Atualizar a cada minuto
        local events = GetEventsFromServer() -- Função fictícia para obter eventos do servidor

        for _, event in ipairs(events) do
            if event.is_active then
                -- Código para exibir eventos ativos
            end
        end
    end
end)
