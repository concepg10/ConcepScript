-- ╔═══════════════════════════════════════════════════════════════╗
-- ║     DETECCIÓN DE FRAMEWORK - SOPORTE MULTI-FRAMEWORK        ║
-- ╚═══════════════════════════════════════════════════════════════╝

Framework = {}
FrameworkType = nil

-- Detectar ESX
if GetResourceState('es_extended') == 'started' then
    Framework.ESX = exports['es_extended']:getSharedObject()
    FrameworkType = 'ESX'
    print('^2[ConcepScripts]^7 Framework detectado: ^3ESX^7 ^2✓^7')
end

-- Detectar QBCore
if GetResourceState('qb-core') == 'started' then
    Framework.QBCore = exports['qb-core']:GetCoreObject()
    FrameworkType = 'QBCore'
    print('^2[ConcepScripts]^7 Framework detectado: ^3QBCore^7 ^2✓^7')
end

-- Detectar QBox
if GetResourceState('qbx_core') == 'started' then
    Framework.QBox = exports['qbx_core']:GetCoreObject()
    FrameworkType = 'QBox'
    print('^2[ConcepScripts]^7 Framework detectado: ^3QBox^7 ^2✓^7')
end

if not FrameworkType then
    print('^1[ConcepScripts]^7 ⚠️  No se detectó framework compatible')
end

print('^2[ConcepScripts]^7 Framework compartido cargado ^2✓^7')