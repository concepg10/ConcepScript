-- ╔═══════════════════════════════════════════════════════════════╗
-- ║     SERVIDOR - TIENDA VIP PREMIUM                             ║
-- ╚═══════════════════════════════════════════════════════════════╝

-- Crear tabla de VIP Coins si no existe
MySQL.Async.execute([[CREATE TABLE IF NOT EXISTS `player_vipcoins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `coins` int(11) DEFAULT 0,
  `lastUpdated` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;]], {}, function(result)
    print('^2[ConcepScripts]^7 Tabla de VIP Coins verificada ^2✓^7')
end)

-- Obtener coins del jugador
local function GetPlayerCoins(identifier)
    local result = MySQL.Sync.fetchScalar('SELECT coins FROM player_vipcoins WHERE identifier = ?', {identifier})
    return result or 0
end

-- Agregar coins al jugador
local function AddPlayerCoins(identifier, amount)
    local currentCoins = GetPlayerCoins(identifier)
    local newCoins = currentCoins + amount
    MySQL.Async.execute('INSERT INTO player_vipcoins (identifier, coins) VALUES (?, ?) ON DUPLICATE KEY UPDATE coins = ?', 
        {identifier, newCoins, newCoins}, function(result)
        if Config.Debug then
            print('^2[ConcepScripts]^7 Coins agregados: ' .. identifier .. ' +' .. amount .. ' ^2✓^7')
        end
    end)
    return newCoins
end

-- Remover coins del jugador
local function RemovePlayerCoins(identifier, amount)
    local currentCoins = GetPlayerCoins(identifier)
    if currentCoins >= amount then
        local newCoins = currentCoins - amount
        MySQL.Async.execute('UPDATE player_vipcoins SET coins = ? WHERE identifier = ?', 
            {newCoins, identifier}, function(result)
            if Config.Debug then
                print('^2[ConcepScripts]^7 Coins removidos: ' .. identifier .. ' -' .. amount .. ' ^2✓^7')
            end
        end)
        return true
    end
    return false
end

-- Evento: Obtener coins del jugador
RegisterNetEvent('tienda-vip:getPlayerCoins')
AddEventHandler('tienda-vip:getPlayerCoins', function()
    local playerId = source
    local identifier = Framework.ESX.GetPlayerFromId(playerId).getIdentifier()
    local coins = GetPlayerCoins(identifier)
    
    TriggerClientEvent('tienda-vip:updateCoins', playerId, coins)
end)

-- Evento: Comprar item
RegisterNetEvent('tienda-vip:buyItem')
AddEventHandler('tienda-vip:buyItem', function(itemId, price)
    local playerId = source
    local identifier = Framework.ESX.GetPlayerFromId(playerId).getIdentifier()
    local currentCoins = GetPlayerCoins(identifier)
    
    -- Validar si tiene suficientes coins
    if currentCoins < price then
        TriggerClientEvent('tienda-vip:buyError', playerId, 'No tienes suficientes VIP Coins')
        return
    end
    
    -- Validar que el item exista
    local item = nil
    for _, v in ipairs(Config.VipItems) do
        if v.id == itemId then
            item = v
            break
        end
    end
    
    if not item then
        TriggerClientEvent('tienda-vip:buyError', playerId, 'Item no encontrado')
        return
    end
    
    -- Remover coins
    RemovePlayerCoins(identifier, price)
    
    -- Agregar item al inventario (ESX)
    if FrameworkType == 'ESX' then
        local player = Framework.ESX.GetPlayerFromId(playerId)
        player.addInventoryItem(item.name, 1)
    end
    
    -- Notificar compra exitosa
    local newCoins = GetPlayerCoins(identifier)
    TriggerClientEvent('tienda-vip:buySuccess', playerId, item.name, newCoins)
    
    print('^2[ConcepScripts]^7 ' .. identifier .. ' compró: ' .. item.name .. ' (-' .. price .. ' coins) ^2✓^7')
end)

-- Comando para agregar coins (Admin)
RegisterCommand('addcoins', function(source, args, rawCommand)
    if source == 0 then -- Solo consola
        local playerId = tonumber(args[1])
        local amount = tonumber(args[2])
        
        if not playerId or not amount then
            print('^1Uso: addcoins <playerID> <cantidad>^7')
            return
        end
        
        local identifier = Framework.ESX.GetPlayerFromId(playerId).getIdentifier()
        AddPlayerCoins(identifier, amount)
        
        TriggerClientEvent('tienda-vip:updateCoins', playerId, GetPlayerCoins(identifier))
        print('^2Coins agregados al jugador ' .. playerId .. '^7')
    end
end, false)

-- Exportación: Agregar coins
function exports.addVipCoins(playerId, amount)
    local identifier = Framework.ESX.GetPlayerFromId(playerId).getIdentifier()
    return AddPlayerCoins(identifier, amount)
end

-- Exportación: Remover coins
function exports.removeVipCoins(playerId, amount)
    local identifier = Framework.ESX.GetPlayerFromId(playerId).getIdentifier()
    return RemovePlayerCoins(identifier, amount)
end

-- Exportación: Obtener coins
function exports.getVipCoins(playerId)
    local identifier = Framework.ESX.GetPlayerFromId(playerId).getIdentifier()
    return GetPlayerCoins(identifier)
end

print('^2[ConcepScripts]^7 Servidor de tienda VIP cargado ^2✓^7')