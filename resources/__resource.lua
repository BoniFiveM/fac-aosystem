 
-- Declaração dos arquivos de scripts do servidor
server_script 'faction_manager.lua'
server_script 'territory_manager.lua'
server_script 'income_manager.lua'
server_script 'mission_manager.lua'
server_script 'conflict_manager.lua'
server_script 'trade_manager.lua'
server_script 'event_manager.lua'
server_script 'admin_manager.lua'
server_script 'config.lua'
server_script 'database.lua'

-- Declaração dos arquivos de scripts do cliente
client_script 'ui_manager.lua'
client_script 'interaction.lua'
client_script 'map_renderer.lua'
client_script 'mission_handler.lua'
client_script 'event_handler.lua'
client_script 'config.lua'

-- Declaração dos arquivos compartilhados
shared_script 'shared.lua'

-- Declaração dos arquivos de tradução
shared_script 'locales/en.lua'
shared_script 'locales/pt.lua'
