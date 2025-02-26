fx_version 'bodacious'
game 'gta5'
shared_script '@es_extended/imports.lua'

server_script "server/sv_queue_config.lua"
server_script "connectqueue.lua"

server_script "shared/sh_queue.lua"
client_script "shared/sh_queue.lua"