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
	'client/main.lua',
	'HuntingRifle/cl_weaponNames.lua'
}

server_scripts {
	'config.lua',
	'server/functions.lua',
	'server/events.lua',
	'server/main.lua'
}

files {
	'HuntingRifle/meta/weaponcomponents.meta',
	'HuntingRifle/meta/weaponarchetypes.meta',
	'HuntingRifle/meta/weaponanimations.meta',
	'HuntingRifle/meta/pedpersonality.meta',
	'HuntingRifle/meta/weapons.meta',
}

data_file 'WEAPONCOMPONENTSINFO_FILE' '**/weaponcomponents.meta'
data_file 'WEAPON_METADATA_FILE' '**/weaponarchetypes.meta'
data_file 'WEAPON_ANIMATIONS_FILE' '**/weaponanimations.meta'
data_file 'PED_PERSONALITY_FILE' '**/pedpersonality.meta'
data_file 'WEAPONINFO_FILE' '**/weapons.meta'
