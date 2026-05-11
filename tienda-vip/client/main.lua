-- ╔═══════════════════════════════════════════════════════════════╗
-- ║     CLIENTE - TIENDA VIP PREMIUM                              ║
-- ╚═══════════════════════════════════════════════════════════════╝

local ShopOpen = false

-- Registrar comando
RegisterCommand(Config.OpenShopCommand, function()
    if not ShopOpen then
        OpenShop()
    else
        CloseShop()
    end
end)

-- Registrar tecla
RegisterKeyMapping(Config.OpenShopCommand, 'Abrir/Cerrar Tienda VIP', 'keyboard', Config.OpenShopKey)

-- Función para abrir tienda
function OpenShop()
    if ShopOpen then return end
    ShopOpen = true
    
    SetNuiFocus(true, true)
    SendNuiMessage(json.encode({
        type = 'shop:open',
        items = Config.VipItems,
        categories = Config.Categories
    }))
    
    -- Solicitar saldo actual
    TriggerServerEvent('tienda-vip:getPlayerCoins')
    
    if Config.Debug then
        print('^2[ConcepScripts]^7 Tienda VIP abierta ^2✓^7')
    end
end

-- Función para cerrar tienda
function CloseShop()
    if not ShopOpen then return end
    ShopOpen = false
    
    SetNuiFocus(false, false)
    SendNuiMessage(json.encode({
        type = 'shop:close'
    }))
    
    if Config.Debug then
        print('^2[ConcepScripts]^7 Tienda VIP cerrada ^2✓^7')
    end
end

-- Cerrar tienda con ESC
RegisterNUICallback('shop:close', function(data, cb)
    CloseShop()
    cb('ok')
end)

-- Recibir saldo actualizado
RegisterNetEvent('tienda-vip:updateCoins')
AddEventHandler('tienda-vip:updateCoins', function(coins)
    SendNuiMessage(json.encode({
        type = 'shop:updateCoins',
        coins = coins
    }))
end)

-- Comprar item
RegisterNUICallback('shop:buyItem', function(data, cb)
    TriggerServerEvent('tienda-vip:buyItem', data.itemId, data.price)
    cb('ok')
end)

-- Evento de compra exitosa
RegisterNetEvent('tienda-vip:buySuccess')
AddEventHandler('tienda-vip:buySuccess', function(itemName, newCoins)
    SendNuiMessage(json.encode({
        type = 'shop:buySuccess',
        itemName = itemName,
        newCoins = newCoins
    }))
end)

-- Evento de error de compra
RegisterNetEvent('tienda-vip:buyError')
AddEventHandler('tienda-vip:buyError', function(message)
    SendNuiMessage(json.encode({
        type = 'shop:buyError',
        message = message
    }))
end)

-- Exportación para abrir tienda desde otros scripts
function exports.openShop()
    OpenShop()
end

print('^2[ConcepScripts]^7 Cliente de tienda VIP cargado ^2✓^7')