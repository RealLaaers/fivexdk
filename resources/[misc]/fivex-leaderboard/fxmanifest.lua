

fx_version 'bodacious'
game 'gta5'

Author 'Ayazwai#3900'
version '1.0.0'
scriptname 'fivex-leaderboard'

shared_script '@es_extended/imports.lua'

client_scripts {
    'config.lua',
    'mission.lua',
    'client.lua'
}

server_scripts {
    'config.lua',
    '@mysql-async/lib/MySQL.lua',
    'server.lua',
}

ui_page "html/index.html"

files {
    'html/*.html',
    'html/*.js',
    'html/*.css',
    'html/img/*.png',
    'html/img/flags-svg/*.svg',
    'html/fonts/*.ttf',
    'html/fonts/*.otf',
    'html/fonts/*.woff',
    'html/fonts/*.TTF',
}

lua54 'yes'

