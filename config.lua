Config = {}

Config.Debug = true

Config.Framework = 'qb'            -- qb , qbx, esx
Config.Notification = 'ox'         -- ox , qb, esx
Config.Inventory = 'ox'            -- ox , qb
Config.Progress = 'ox-circle'      -- ox-normal , ox-circle , qb, esx
Config.OxCirclePosition = 'bottom' -- only matters if Config.Progress = 'ox-circle'


-- Nice debug function so you dont need to check if Config.Debug is true on every print
function dbug(...)
    if Config.Debug then print('^3[DEBUG]^7', ...) end
end

function SetupBridge()
    if GetResourceState('qbx_core') == 'started' then
        Config.Framework = 'qbx'
    elseif GetResourceState('qb_core') == 'started' then
        Config.Framework = 'qb'
    elseif GetResourceState('es_extended') == 'started' then
        Config.Framework = 'qb'
    end

    dbug('Framework found: ' .. Config.Framework)
    dbug('Notifications: ' .. Config.Notification)
    dbug('Inventory: ' .. Config.Inventory)
    dbug('Progress: ' .. Config.Progress)
end

AddEventHandler('onResourceStart', function(resource)
   if resource ~= GetCurrentResourceName() then return end
    Wait(10000)
    SetupBridge()
end)