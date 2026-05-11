-- ╔═══════════════════════════════════════════════════════════════╗
-- ║     CONFIGURACIÓN - TIENDA VIP PREMIUM                      ║
-- ╚═══════════════════════════════════════════════════════════════╝

Config = {}

-- ▶ FRAMEWORK
Config.Framework = 'esx' -- 'esx', 'qbcore', 'qbox'

-- ▶ CONTROLES
Config.OpenShopKey = 'F9'          -- Tecla para abrir tienda
Config.CloseShopKey = 'ESC'        -- Tecla para cerrar

-- ▶ COMANDO
Config.OpenShopCommand = 'tiendavip'  -- Comando para abrir tienda

-- ▶ NOTIFICACIONES
Config.Notifications = {
    enabled = true,
    position = 'top-right',
    duration = 3000
}

-- ▶ DEBUG
Config.Debug = false

-- ▶ ==================================
-- ▶ ITEMS DE LA TIENDA VIP
-- ▶ ==================================
-- ▶ AQUI AGREGAS TUS ITEMS PERSONALIZADOS
-- ▶ FORMATO:
-- price = precio actual (lo que cuesta)
-- originalPrice = precio original (si es diferente = OFERTA)
-- ▶ ==================================

Config.VipItems = {
    -- EJEMPLO 1: Item SIN oferta
    {
        id = 1,
        name = "Panties x1",
        icon = "👕",
        price = 5,
        originalPrice = 5,  -- Sin oferta
        description = "Pack de 1 pantalón exclusivo VIP",
        category = "ropa"
    },

    -- EJEMPLO 2: Item CON oferta
    {
        id = 2,
        name = "Energy Drink x3",
        icon = "🥤",
        price = 18,
        originalPrice = 25,  -- OFERTA: -28%
        description = "Pack de 3 bebidas energéticas premium",
        category = "items"
    },

    -- EJEMPLO 3: Item CON oferta
    {
        id = 3,
        name = "Energy Drink x10",
        icon = "🥤",
        price = 50,
        originalPrice = 75,  -- OFERTA: -33%
        description = "Pack de 10 bebidas energéticas",
        category = "items"
    },

    -- EJEMPLO 4: Item SIN oferta
    {
        id = 4,
        name = "Energy Drink x30",
        icon = "🥤",
        price = 150,
        originalPrice = 150,
        description = "Mega pack de 30 bebidas energéticas",
        category = "items"
    },

    -- EJEMPLO 5: Item CON oferta
    {
        id = 5,
        name = "Dinero x5000",
        icon = "💰",
        price = 200,
        originalPrice = 250,  -- OFERTA: -20%
        description = "Pack de 5000$ en efectivo",
        category = "money"
    },

    -- EJEMPLO 6: Item premium
    {
        id = 6,
        name = "Dinero x15000",
        icon = "💰",
        price = 999,
        originalPrice = 999,
        description = "Mega pack de 15000$ en efectivo",
        category = "money"
    },

    -- AGREG MÁS ITEMS AQUÍ
    -- Copia el formato de arriba y personaliza
}

-- ▶ CATEGORÍAS
Config.Categories = {
    {name = "Todos", icon = "⭐", value = "all"},
    {name = "Ropa", icon = "👕", value = "ropa"},
    {name = "Items", icon = "🎁", value = "items"},
    {name = "Dinero", icon = "💰", value = "money"}
}

print('^2[ConcepScripts]^7 Configuración de tienda VIP cargada ^2✓^7')