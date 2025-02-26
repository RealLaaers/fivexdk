fx_version "cerulean"

description "Clothing Menu"
author "purescripts.net"
version '1.0.0'

lua54 'yes'

games {
  "gta5",
  "rdr3"
}

ui_page 'web/build/index.html'

client_scripts {
  'client/**/*',
}

server_scripts {
  "@oxmysql/lib/MySQL.lua",
  'server/**/*',
}

shared_scripts {
  '@ox_lib/init.lua',
  -- '@qbx_core/import.lua', -- UNCOMMENT THESE IF YOU USE QBOX
  -- '@qbx_core/shared/locale.lua',
  'config/config.lua',
  'config/outfits.lua',
  'config/locations.lua',
  'config/blacklist.lua',
  'config/whitelist.lua',
  'locales/**/*',
}

files {
	'web/build/index.html',
	'web/build/**/*',
  'config/themes.json'
}

escrow_ignore {
  'client/**/*',
  'config/**/*',
  'locales/**/*',
  'peds/**/*',
  'server/**/*',
  'sql/**/*',
  'tattoos/**/*',
  'web/**/*',

}

depeedencies {
  -- 'assetpacks',
  'oxmysql',
  'ox_lib'
}

exports {
  'initiateApperance',
  'initiateApperanceWithPed',
  'setPed',
  'openMenu',
}

-- modules { -- UNCOMMENT THESE IF YOU USE QBOX
--   'qbx_core:playerdata',
--   'qbx_core:utils',
-- }

-- dependency '/assetpacks'