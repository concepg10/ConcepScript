fx_version 'cerulean'
game 'gta5'

author 'ConcepScripts - Inventario Premium'
description 'Sistema de inventario único y original compatible con ESX, QBCore y QBox'
version '1.0.0'

license 'Creative Commons - Uso Comercial Prohibido sin Licencia'

repository 'https://github.com/concepg10/ConcepScript'

dependencies {
    '/server:5104',
    '/onesync'
}

provides {
    'esx:getInventory',
    'esx:addItem',
    'esx:removeItem'
}

shared_scripts {
    'shared/framework.lua',
    'config.lua'
}

server_scripts {
    'server/main.lua'
}

client_scripts {
    'client/main.lua'
}

ui_page 'web/index.html'

files {
    'web/index.html',
    'web/css/style.css',
    'web/css/animations.css',
    'web/js/config.js',
    'web/js/utils.js',
    'web/js/inventory.js',
    'web/js/ui.js'
}

export 'getInventory'
export 'addItem'
export 'removeItem'
export 'openInventory'
export 'closeInventory'