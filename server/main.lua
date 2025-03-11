local coreObject = nil

---@param orgin string # orgin where this is being called
---@param playerId number # center of check
---@param faildDist number # how bad they failed the check
local function sendConsoleAlert(orgin, playerId, faildDist)
  print(
    '\n^8[CHEATING-ALERT]^7 ' .. orgin .. ' Distance Check Failed!',
    '\n^8[CHEATING-ALERT]^7 Player Name: ' .. GetPlayerName(playerId),
    '\n^8[CHEATING-ALERT]^7 ' .. GetPlayerIdentifierByType(playerId, 'license'),
    '\n^8[CHEATING-ALERT]^7 Over Vaild Distance By ' .. faildDist .. ' units!'
  )
end
exports('sendConsoleAlert', sendConsoleAlert)

---@param playerId number # Player Id To Check
---@param coords vector3 # center of check
---@param radius number # radius of check
local function distanceCheck(playerId, coords, radius)
  local dist = #(GetEntityCoords(GetPlayerPed(playerId)) - coords)

  if dist > radius then
    return false
  else
    return true
  end
end
exports('distanceCheck', distanceCheck)

function GetFrameworkObject()
  if not coreObject then
    if Config.Framework == 'qb' then coreObject = exports['qb-core']:GetCoreObject() end
    if Config.Framework == 'esx' then coreObject = exports["es_extended"]:getSharedObject() end
  end

  return coreObject
end

AddEventHandler('onResourceStart', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then return end

  if Config.Framework == 'qb' then coreObject = exports['qb-core']:GetCoreObject() end
  if Config.Framework == 'esx' then coreObject = exports["es_extended"]:getSharedObject() end
end)