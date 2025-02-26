fx_version 'adamant'

game 'gta5'
lua54 'yes'

shared_scripts {
	'@ox_lib/init.lua',
	'config.lua',
	'@es_extended/imports.lua',
}

server_scripts {
	'server/misc/*.lua',
	'@oxmysql/lib/MySQL.lua',
	'code/delall/server/*.lua',
	'code/pedmenu/server/*.lua',
	'code/vest/server/*.lua',
	'code/chatcommands/server/*.lua',
	'code/pvpmenu/*.lua',
}

client_scripts {
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'code/zones/*.lua',
	'code/misc/*.lua',
	'code/hud/*.lua',
	'code/movement/*.lua',
	'code/delall/client/*.lua',
	'code/text/*.lua',
	'code/spawn/*.lua',
	'code/vest/client/*.lua',
	'code/greenzone/*.lua',
	'code/recoil/*.lua',
	'code/fixminimap/*.lua',
	'code/crouch/*.lua',
	'code/pvpmenu/client/*.lua',
	'code/chatcommands/client/*.lua',
	'code/recoil/*.lua',
	'code/driveby/*.lua',
	'code/npcremover/*.lua',
	'code/fixminimap/*.lua',
	'code/health/*.lua',
	'code/z-menu/*.lua',
}

files {
	'data/*.meta',
}

escrow_ignore {
    'config.lua',
}

data_file 'WEAPONINFO_FILE_PATCH' 'data/weapons.meta'

ui_page 'html/index.html'

files {
    'html/*.html',
    'html/assets/css/*.css',
    'html/assets/font/*.ttf',
    'html/assets/img/*',
    'html/fonts/*.ttf',
    'html/js/*.js',
    'html/app.js'
}
