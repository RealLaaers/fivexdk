fx_version "adamant"
game "gta5"

ui_page 'hud.html'

dependency 'koth-ui'
lua54 'yes'
shared_script '@ox_lib/init.lua'

client_scripts {
    "client/index.lua",
    "client/cl_sounds.lua"
}

server_scripts {
    "server.lua"
}

files {
    'hud.html',
    'style.css',
    'script.js',
    "hud/equiped/*.png",
    "hud/*.png",
    'client/sounds/*.ogg'
}

export 'SendUIMessage'
