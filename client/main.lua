local coreObject = nil

function GetFrameworkObject()
  if not coreObject then
    if Config.Framework == 'qb' then coreObject = exports['qb-core']:GetCoreObject() end
    if Config.Framework == 'esx' then coreObject = exports["es_extended"]:getSharedObject() end
  end

  return coreObject
end

AddEventHandler('onResourceStart', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then return end

  if Config.Framework == 'qb' or Config.Framework == 'qbx' then coreObject = exports['qb-core']:GetCoreObject() end
  if Config.Framework == 'esx' then coreObject = exports["es_extended"]:getSharedObject() end
end)
