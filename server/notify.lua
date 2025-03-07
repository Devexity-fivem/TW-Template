---@param src number # player source
---@param duration number # Length of noti
---@param title string # noti title can be empty string for qb
---@param desc string # noti desc
---@param type string # success or error
function doNotify(src, duration, title, desc, type)
  if Config.Notification == 'qb' then
    TriggerClientEvent('QBCore:Notify', src, title .. ' ' .. desc, type, duration)
  elseif Config.Notification == 'esx' then
    TriggerClientEvent('esx:showNotification', src, title .. ' ' .. desc, type, duration)
  else
    TriggerClientEvent('ox_lib:notify', src, {
      title = title,
      description = desc,
      type = type,
      duration = duration,
      showDuration = true,
    })
  end
end
exports('doNotify', doNotify)
