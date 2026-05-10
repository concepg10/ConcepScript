-- ╔═══════════════════════════════════════════════════════════════╗
-- ║     CONFIGURACIÓN - INVENTARIO PREMIUM CONCEPSCRIPTS          ║
-- ╚═══════════════════════════════════════════════════════════════╝

Config = {}

-- ▶ FRAMEWORK (Detección automática)
Config.Framework = 'esx' -- 'esx', 'qbcore', 'qbox'

-- ▶ LÍMITES DEL INVENTARIO
Config.MaxSlots = 50          -- Máximo de slots disponibles
Config.MaxWeight = 150        -- Peso máximo en kg
Config.WeightUnit = 'kg'      -- Unidad de peso: 'kg', 'lb'

-- ▶ CONTROLES
Config.OpenInventoryKey = 'I'          -- Tecla para abrir inventario
Config.CloseInventoryKey = 'ESC'       -- Tecla para cerrar inventario
Config.DropItemKey = 'DELETE'          -- Tecla para dropear item

-- ▶ ANIMACIONES
Config.Animations = {
    enabled = true,
    speed = 300,              -- Velocidad en ms
    dropAnimation = 'mini_drop'
}

-- ▶ NOTIFICACIONES
Config.Notifications = {
    enabled = true,
    position = 'top-right',    -- 'top-left', 'top-right', 'bottom-left', 'bottom-right'
    duration = 3000            -- Duración en ms
}

-- ▶ CONTENEDORES DISPONIBLES
Config.Containers = {
    player = {
        label = '🎒 Inventario Personal',
        icon = '🎒',
        slots = 50,
        weight = 150
    },
    trunk = {
        label = '🚗 Maletero del Vehículo',
        icon = '🚗',
        slots = 40,
        weight = 500
    },
    stash = {
        label = '🏠 Almacenamiento de Casa',
        icon = '🏠',
        slots = 100,
        weight = 1000
    },
    shop = {
        label = '🏪 Tienda',
        icon = '🏪',
        slots = 30,
        weight = 300
    }
}

-- ▶ ITEMS POR DEFECTO
Config.DefaultItems = {
    {
        name = 'water',
        label = 'Agua',
        weight = 0.5,
        stackable = true,
        icon = '💧',
        type = 'consumible',
        description = 'Botella de agua potable'
    },
    {
        name = 'bread',
        label = 'Pan',
        weight = 0.3,
        stackable = true,
        icon = '🍞',
        type = 'consumible',
        description = 'Delicioso pan fresco'
    },
    {
        name = 'money',
        label = 'Dinero en Efectivo',
        weight = 0.1,
        stackable = true,
        icon = '💵',
        type = 'currency',
        description = 'Dinero en efectivo'
    },
    {
        name = 'gold_bar',
        label = 'Barra de Oro',
        weight = 1.0,
        stackable = true,
        icon = '🏆',
        type = 'valuable',
        description = 'Barra de oro puro de alto valor'
    },
    {
        name = 'phone',
        label = 'Teléfono',
        weight = 0.2,
        stackable = false,
        icon = '📱',
        type = 'electronic',
        description = 'Teléfono celular'
    }
}

-- ▶ COLORES Y RARIDADES
Config.Rarities = {
    common = {
        color = '#95a5a6',
        label = 'Común',
        icon = '⭐'
    },
    uncommon = {
        color = '#2ecc71',
        label = 'Poco Común',
        icon = '⭐⭐'
    },
    rare = {
        color = '#3498db',
        label = 'Raro',
        icon = '⭐⭐⭐'
    },
    epic = {
        color = '#9b59b6',
        label = 'Épico',
        icon = '⭐⭐⭐⭐'
    },
    legendary = {
        color = '#f39c12',
        label = 'Legendario',
        icon = '⭐⭐⭐⭐⭐'
    }
}

-- ▶ LOGGING Y DEBUG
Config.Debug = false         -- Mostrar mensajes de debug en consola
Config.LogToConsole = true   -- Registrar acciones en consola
Config.LogToFile = true      -- Guardar logs en archivo

print('^2[ConcepScripts]^7 Configuración del inventario cargada correctamente ^2✓^7')