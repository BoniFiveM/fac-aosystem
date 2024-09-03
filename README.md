# SISTEMA DE FACÇÕES PARA FIVEM

Bem-vindo ao Sistema de Facções para FiveM! Este sistema é projetado para adicionar uma camada de gerenciamento de facções, territórios, missões, comércio, conflitos e eventos ao seu servidor FiveM. A seguir, você encontrará uma explicação completa sobre como configurar e usar o sistema.

## FUNCIONALIDADES

O sistema oferece as seguintes funcionalidades:

- **Facções**: Permite criar e gerenciar facções, definir especializações, e limitar o número de membros.
- **Territórios**: Possibilita reivindicar e administrar territórios, incluindo a definição de pontuação de defesa e recursos especiais.
- **Missões**: Crie e complete missões, e receba recompensas.
- **Conflitos**: Gerencie conflitos entre facções.
- **Comércio**: Crie ofertas de comércio e compre recursos.
- **Eventos**: Organize e gerencie eventos no jogo.
- **Administração**: Utilize comandos administrativos para gerenciar o sistema.

## CONFIGURAÇÃO

### ARQUIVO DE CONFIGURAÇÃO

O arquivo de configuração é `config.lua`. Aqui estão as opções disponíveis e suas descrições:

```lua
-- Configurações Gerais
Config = {}

-- Configurações de Facções
Config.FactionCreationCost = 5000  -- Custo para criar uma facção
Config.MaxFactionMembers = 50     -- Número máximo de membros em uma facção

-- Configurações de Territórios
Config.TerritoryIncomeRate = 100  -- Quantia de renda gerada por território por hora
Config.TerritoryClaimRadius = 100 -- Raio em metros para reclamar um território

-- Configurações de Missões
Config.MissionReward = 1000        -- Recompensa por completar uma missão
Config.MissionTimeout = 3600       -- Tempo máximo (em segundos) para completar uma missão

-- Configurações de Conflitos
Config.ConflictAlertRadius = 500  -- Raio em metros para alertar sobre conflitos
Config.ConflictTimeout = 1800     -- Tempo máximo (em segundos) para a duração de um conflito

-- Configurações de Comércio
Config.TradeCooldown = 600        -- Tempo de espera (em segundos) entre negociações

-- Configurações de Eventos
Config.EventDuration = 7200       -- Duração dos eventos (em segundos)
Config.EventReward = 2000          -- Recompensa por participar de um evento

-- Configurações de Administração
Config.AdminCommandPrefix = "/admin" -- Prefixo para comandos administrativos
