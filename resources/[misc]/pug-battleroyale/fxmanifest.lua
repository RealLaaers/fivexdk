lua54 'yes'
fx_version 'cerulean'
game 'gta5'

author 'Pug'
description 'Discord: Pug#8008'
version '2.2.3'

client_script {
    'client.lua',
    'open.lua',
}

server_script {
    '@oxmysql/lib/MySQL.lua',
	'server.lua',
    'sv_open.lua',
}

shared_script {
    'config.lua',
    'locales/en.lua',
    '@ox_lib/init.lua'
}

escrow_ignore {
    'config.lua',
    'open.lua',
    'server.lua',
    'sv_open.lua',
    'locales/en.lua',
}

ui_page('html/index.html')

files({
	'html/index.html',
	'html/script.js',
	'html/style.css',
	'html/images/*',
	'html/Rajdhani.ttf'
})

dependency '/assetpacks'
dependency '/assetpacks'