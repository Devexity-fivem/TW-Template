local coreObject = GetFrameworkObject()

---@param duration number # Length of noti
---@param title string # noti title can be empty string for qb
---@param desc string # noti desc
---@param type string # success or error
local function doNotify(duration, title, desc, type)
  if Config.Notification == 'qb' then
    coreObject.Functions.Notify(title .. ": " .. desc, type, duration)
  elseif Config.Notification == 'esx' then
    coreObject.ShowNotification(title .. ": " .. desc, type, duration)
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
