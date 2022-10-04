name 'native-hunting'
description 'Simple hunting script independent from frameworks'
version 'v1.0.0'
fx_version 'cerulean'
game 'gta5'

client_scripts {
	'config.lua',
	'client/functions.lua',
	'client/events.lua',
	'client/frameworkEvents.lua',
	'client/main.lua'
}

files {
    'html/**/*'
}

ui_page 'html/dist/index.html'

server_scripts {
	'config.lua',
	'server/functions.lua',
	'server/events.lua',
	'server/main.lua'
}