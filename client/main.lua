if Config.Framework == 'qb' or Config.Framework == 'qbx' then QBCore = exports['qb-core']:GetCoreObject() end
if Config.Framework == 'esx' then ESX = exports["es_extended"]:getSharedObject() end


Citizen.CreateThread(function() -- Start Thread (Non Loop)

end)

-- Citizen.CreateThread(function() -- Start Thread (Loop) (Uncomment if going to use it)
--     while true do
--         Wait(10)
--     end
-- end)

RegisterNetEvent('nameOFscript:client:nameOFwhathappens', function ()
  -- Templete netevent
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end

    -- code here
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end

    -- code here
end)