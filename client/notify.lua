if Config.Framework == 'qb' or Config.Framework == 'qbx' then QBCore = exports['qb-core']:GetCoreObject() end
if Config.Framework == 'esx' then ESX = exports["es_extended"]:getSharedObject() end

---@param duration number # Length of noti
---@param title string # noti title can be empty string for qb
---@param desc string # noti desc
---@param type string # success or error
local function doNotify(duration, title, desc, type)
  if Config.Notification == 'qb' then
    QBCore.Functions.Notify(title .. ": " .. desc, type, duration)
  elseif Config.Notification == 'esx' then
    ESX.ShowNotification(title .. ": " .. desc, type, duration)
  else
    lib.notify({
      title = title,
      description = desc,
      type = type,
      duration = duration,
    })
  end
end
exports('doNotify', doNotify)
