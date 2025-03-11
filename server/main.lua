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

Citizen.CreateThread(function()                -- Version Check
  local resourceName = GetCurrentResourceName()

  function splitVersion(version)
    local major, minor, patch = version:match("^(%d+)%.(%d+)%.(%d+)$")
    return tonumber(major), tonumber(minor), tonumber(patch)
  end

  function isVersionNewer(current, new)
    local currentMajor, currentMinor, currentPatch = splitVersion(current)
    local newMajor, newMinor, newPatch = splitVersion(new)

    if not currentMajor or not newMajor then
      return false, "Invalid version format"
    end

    if newMajor > currentMajor then
      return true
    elseif newMajor == currentMajor then
      if newMinor > currentMinor then
        return true
      elseif newMinor == currentMinor then
        if newPatch > currentPatch then
          return true
        end
      end
    end

    return false
  end

  function checkVersion(err, responseText, headers)
    if err ~= 200 then
      print("^2tw_bridge ^0| ^2Error: Failed to fetch version. HTTP Error Code: " .. tostring(err))
      return
    end

    if not responseText or responseText == "" then
      print("^2tw_bridge ^0| ^2Error: Empty response received from the repository!")
      return
    end

    local curVersion = LoadResourceFile(resourceName, "version")

    if not curVersion then
      print("^2tw_bridge ^0| ^2Error: 'version' file is missing in the resource root!")
      return
    end

    curVersion = curVersion:match("^%s*(.-)%s*$")
    responseText = responseText:match("^%s*(.-)%s*$")

    print("^2tw_bridge ^0| Local version: " .. tostring(curVersion))
    print("^2tw_bridge ^0| Remote version: " .. tostring(responseText))

    local isOutdated, errorMsg = isVersionNewer(curVersion, responseText)

    if errorMsg then
      print("^2tw_bridge ^0| ^2Error: " .. errorMsg)
      return
    end

    if isOutdated then
      print("^2tw_bridge ^0| ^1" ..
        resourceName .. " is outdated! New version: " .. responseText .. ", Current: " .. curVersion)
    else
      print("^2tw_bridge ^0| " .. resourceName .. " is up to date!")
    end
  end

  PerformHttpRequest("https://raw.githubusercontent.com/TwisleOfficial/tw_bridge/refs/heads/main/version", checkVersion,
    "GET")
end)
