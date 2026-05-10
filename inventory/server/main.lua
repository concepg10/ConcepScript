-- ╔═══════════════════════════════════════════════════════════════╗
-- ║     SERVIDOR - INVENTARIO PREMIUM CONCEPSCRIPTS               ║
-- ╚═══════════════════════════════════════════════════════════════╝

local PlayerInventories = {}

-- Función para obtener el inventario del jugador
local function GetPlayerInventory(playerId)
    local identifier = Framework.ESX.GetPlayerFromId(playerId).getIdentifier()
    if not PlayerInventories[identifier] then
        PlayerInventories[identifier] = {
            player = {},
            trunk = {},
            stash = {},
            shop = {}
        }
    end
    return PlayerInventories[identifier]
end

-- Evento para obtener items
RegisterNetEvent('inventory:getItems')
AddEventHandler('inventory:getItems', function(container)
    local playerId = source
    local inventory = GetPlayerInventory(playerId)
    
    TriggerClientEvent('inventory:updateItems', playerId, inventory[container or 'player'])
end)

-- Evento para obtener inventario
RegisterNetEvent('inventory:fetchInventory')
AddEventHandler('inventory:fetchInventory', function(container)
    local playerId = source
    local inventory = GetPlayerInventory(playerId)
    
    if Config.Debug then
        print('^2[ConcepScripts]^7 Inventario solicitado: ' .. container .. ' ^2✓^7')
    end
end)

-- Evento para mover item
RegisterNetEvent('inventory:moveItem')
AddEventHandler('inventory:moveItem', function(data)
    local playerId = source
    local inventory = GetPlayerInventory(playerId)
    
    -- Validar si el item existe
    if inventory[data.from][data.item] then
        -- Mover item
        if not inventory[data.to][data.item] then
            inventory[data.to][data.item] = 0
        end
        
        inventory[data.to][data.item] = inventory[data.to][data.item] + data.quantity
        inventory[data.from][data.item] = inventory[data.from][data.item] - data.quantity
        
        if inventory[data.from][data.item] <= 0 then
            inventory[data.from][data.item] = nil
        end
        
        TriggerClientEvent('inventory:updateItems', playerId, inventory[data.to])
        
        if Config.Debug then
            print('^2[ConcepScripts]^7 Item movido: ' .. data.item .. ' (' .. data.quantity .. ') ^2✓^7')
        end
    end
end)

-- Evento para usar item
RegisterNetEvent('inventory:useItem')
AddEventHandler('inventory:useItem', function(item)
    local playerId = source
    print('^3[ConcepScripts]^7 Item usado: ' .. item .. ' por jugador ' .. playerId)
    -- Aquí puedes agregar lógica personalizada para usar items
end)

-- Evento para dropear item
RegisterNetEvent('inventory:dropItem')
AddEventHandler('inventory:dropItem', function(data)
    local playerId = source
    local inventory = GetPlayerInventory(playerId)
    
    if inventory.player[data.item] and inventory.player[data.item] >= data.quantity then
        inventory.player[data.item] = inventory.player[data.item] - data.quantity
        
        if inventory.player[data.item] <= 0 then
            inventory.player[data.item] = nil
        end
        
        print('^3[ConcepScripts]^7 Item dropeado: ' .. data.item .. ' (' .. data.quantity .. ') ^2✓^7')
        TriggerClientEvent('inventory:updateItems', playerId, inventory.player)
    end
end)

-- Exportaciones del servidor
function exports.addItem(playerId, item, quantity)
    local inventory = GetPlayerInventory(playerId)
    if not inventory.player[item] then
        inventory.player[item] = 0
    end
    inventory.player[item] = inventory.player[item] + quantity
    print('^2[ConcepScripts]^7 Item agregado: ' .. item .. ' (' .. quantity .. ') al jugador ' .. playerId .. ' ^2✓^7')
end

function exports.removeItem(playerId, item, quantity)
    local inventory = GetPlayerInventory(playerId)
    if inventory.player[item] and inventory.player[item] >= quantity then
        inventory.player[item] = inventory.player[item] - quantity
        if inventory.player[item] <= 0 then
            inventory.player[item] = nil
        end
        print('^2[ConcepScripts]^7 Item removido: ' .. item .. ' (' .. quantity .. ') del jugador ' .. playerId .. ' ^2✓^7')
        return true
    end
    return false
end

print('^2[ConcepScripts]^7 Servidor del inventario cargado ^2✓^7')