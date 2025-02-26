fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author ''
description ''
version '1.0.6'

shared_script 'config.lua'
shared_script '@ox_lib/init.lua'
client_script 'client.lua'
server_script 'server.lua'

escrow_ignore {
	'config.lua',
	'client.lua',
	'server.lua'
}

dependencies {
	'/server:5181',
	'/gameBuild:2060'
}

ui_page('html/index.html')

files {
	'html/index.html',
	'html/script.js',
	'html/style.css',
	'html/images/*',
	'html/Rajdhani.ttf'
}

escrow_ignore {
    'config.lua',
}


shared_script 'SGconfigs.lua'