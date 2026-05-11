fx_version 'cerulean'
game 'gta5'

author 'ConcepScripts - Tienda VIP Premium'
description 'Sistema de tienda VIP exclusiva con ofertas y VIP Coins'
version '1.0.0'

license 'Creative Commons - Uso Comercial Permitido'

repository 'https://github.com/concepg10/ConcepScript'

dependencies {
    '/server:5104',
    '/onesync'
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
    'web/js/shop.js',
    'web/js/utils.js'
}

export 'addVipCoins'
export 'removeVipCoins'
export 'getVipCoins'
export 'openShop'