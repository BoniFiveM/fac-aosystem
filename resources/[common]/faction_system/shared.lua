--[[ 

FALA PESSOAL SEJAM BEM VINDOS
    shared.lua

    Este script contém definições e funções compartilhadas utilizadas em diferentes 
    partes do sistema de facções. O código inclui definições de cores e uma função para 
    verificar a localização dos jogadores em relação aos territórios.

    Definições e Funções:

    1. `FACTION_COLOR`:
        - Um dicionário que associa nomes de facções a códigos de cores hexadecimais. 
          Essas cores podem ser usadas para identificar visualmente facções em interfaces 
          ou mapas.

    2. `isPlayerInTerritory`:
        - Uma função que verifica se um jogador está localizado dentro de um território 
          especificado.
        - Parâmetros:
            - `playerCoords`: Um objeto contendo as coordenadas do jogador (`x` e `y`).
            - `territory`: Um objeto representando o território com coordenadas limites (`x1`, `x2`, `y1`, `y2`).
        - Retorna `true` se as coordenadas do jogador estiverem dentro dos limites do território; 
          caso contrário, retorna `false`.

    Desenvolvido por @MarcosDev001
--]]

-- Definições de cores para facções
FACTION_COLOR = {
    ["red"] = "#FF0000",    -- Cor vermelha
    ["blue"] = "#0000FF",   -- Cor azul
    ["green"] = "#00FF00"   -- Cor verde
}

-- Função para verificar se um jogador está dentro de um território
function isPlayerInTerritory(playerCoords, territory)
    return playerCoords.x >= territory.x1 and playerCoords.x <= territory.x2 and
           playerCoords.y >= territory.y1 and playerCoords.y <= territory.y2
end
