
fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'
author 'Resident'
description 'Resident Kriminelle aktiver'
version '1.0.0'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'server/drugphone.lua',
	'server/sellcar.lua',
	'server/vest.lua',
	'server/robatm.lua',
    'config.lua',
}

client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'client/drugphone.lua',
	'client/driveby.lua',
	'client/utils.lua',
	'client/sellcar.lua',
	'client/vest.lua',
	'client/robatm.lua',
	'client/anchor.lua'
}


escrow_ignore {
    'config.lua',
}

shared_scripts {
	'@ox_lib/init.lua',
	'@es_extended/imports.lua',
}

dependencies {
	'es_extended'
}

dependency '/assetpacks'
