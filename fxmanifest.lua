fx_version 'cerulean'
game 'gta5'
author 'Ali Exacute#2588'
description 'ESX Admin commands'
version '1.1.0'

shared_scripts {
    '@es_extended/locale.lua',
    'locales/en.lua',
    'config.lua'
}

client_script 'client/*.lua'

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
    'locales/en.lua',
	'server.lua'
}

dependency "es_extended"
