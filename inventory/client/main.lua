-- ╔═══════════════════════════════════════════════════════════════╗
-- ║     CLIENTE - INVENTARIO PREMIUM CONCEPSCRIPTS                ║
-- ╚═══════════════════════════════════════════════════════════════╝

local InventoryOpen = false
local CurrentInventory = {}
local CurrentContainer = 'player'

-- Esperar a que el framework esté listo
TriggerEvent('esx:playerLoaded')

-- Abrir inventario con tecla
RegisterCommand('inventario', function()
    if not InventoryOpen then
        OpenInventory()
    else
        CloseInventory()
    end
end)

RegisterKeyMapping('inventario', 'Abrir/Cerrar Inventario', 'keyboard', Config.OpenInventoryKey)

-- Función para abrir el inventario
function OpenInventory(container)
    container = container or 'player'
    CurrentContainer = container
    
    if InventoryOpen then return end
    
    InventoryOpen = true
    
    -- Solicitar datos del servidor
    TriggerServerEvent('inventory:fetchInventory', container)
    
    -- Mostrar la UI
    SetNuiFocus(true, true)
    SendNuiMessage(json.encode({
        type = 'inventory:open',
        container = container,
        config = Config
    }))
    
    if Config.Debug then
        print('^2[ConcepScripts]^7 Inventario abierto: ' .. container .. ' ^2✓^7')
    end
end

-- Función para cerrar el inventario
function CloseInventory()
    if not InventoryOpen then return end
    
    InventoryOpen = false
    SetNuiFocus(false, false)
    
    SendNuiMessage(json.encode({
        type = 'inventory:close'
    }))
    
    if Config.Debug then
        print('^2[ConcepScripts]^7 Inventario cerrado ^2✓^7')
    end
end

-- Callback cuando se reciben los datos del inventario
RegisterNUICallback('inventory:ready', function(data, cb)
    TriggerServerEvent('inventory:getItems', CurrentContainer)
    cb('ok')
end)

-- Recibir items del servidor
RegisterNetEvent('inventory:updateItems')
AddEventHandler('inventory:updateItems', function(items)
    CurrentInventory = items
    SendNuiMessage(json.encode({
        type = 'inventory:updateItems',
        items = items
    }))
end)

-- Cerrar inventario con ESC
RegisterNUICallback('inventory:close', function(data, cb)
    CloseInventory()
    cb('ok')
end)

-- Mover item
RegisterNUICallback('inventory:moveItem', function(data, cb)
    TriggerServerEvent('inventory:moveItem', {
        from = data.from,
        to = data.to,
        item = data.item,
        quantity = data.quantity
    })
    cb('ok')
end)

-- Usar item
RegisterNUICallback('inventory:useItem', function(data, cb)
    TriggerServerEvent('inventory:useItem', data.item)
    cb('ok')
end)

-- Dropear item
RegisterNUICallback('inventory:dropItem', function(data, cb)
    TriggerServerEvent('inventory:dropItem', {
        item = data.item,
        quantity = data.quantity
    })
    cb('ok')
end)

-- Exportaciones
function exports.openInventory(container)
    OpenInventory(container or 'player')
end

function exports.closeInventory()
    CloseInventory()
end

function exports.getInventory()
    return CurrentInventory
end

print('^2[ConcepScripts]^7 Cliente del inventario cargado ^2✓^7')