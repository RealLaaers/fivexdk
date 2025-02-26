fx_version 'adamant'
game 'gta5'
lua54 'yes'

shared_scripts {
	'shared/settings.lua',
	'shared/maps.lua',
	'shared/weapons.lua',
}

client_scripts {
	'client/main.lua',
	'client/no_escrow.lua',
}

server_scripts {
	'server/main.lua',
}

ui_page 'ui/index.html'

files {
	'ui/index.html',
	'ui/*.css',
	'ui/*.js',
	'ui/img/*.png',
    'ui/img/*.svg',
	'ui/font/*.ttf',
	'data/kd.json',
}

export 'InGungame'

escrow_ignore {
	'shared/settings.lua',
	'shared/maps.lua',
	'shared/weapons.lua',
	'client/no_escrow.lua',
	'client/main.lua',
	'server/main.lua',
}
dependency '/assetpacks'