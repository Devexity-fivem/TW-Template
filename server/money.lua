local coreObject = GetFrameworkObject()

---@param src number # player source
---@param amount number # amount to take from player
local function takeMoney(src, amount, reason)
  if Config.Framework == 'qbx' then
    if exports.qbx_core:GetMoney(src, 'cash') >= amount then
      exports.qbx_core:RemoveMoney(src, 'cash', amount, reason)
      return true
    elseif exports.qbx_core:GetMoney(src, 'bank') >= amount then
      exports.qbx_core:RemoveMoney(src, 'bank', amount, reason)
      return true
    else
      return false
    end
  elseif Config.Framework == 'qb' then
    local plr = coreObject.Functions.GetPlayer(src)
    if not plr then return false end
    if plr.Functions.GetMoney('cash') >= amount then -- Changed > to >=
      plr.Functions.RemoveMoney('cash', amount)
      return true
    elseif plr.Functions.GetMoney('bank') >= amount then
      plr.Functions.RemoveMoney('bank', amount)
      return true
    else
      return false
    end
  elseif Config.Framework == 'esx' then
    local plr = coreObject.GetPlayerFromId(src)
    if not plr then return false end
    if plr.getMoney() >= amount then
      plr.removeMoney(amount)
      return true
    else
      return false
    end
  end
end
exports('takeMoney', takeMoney)

---@param src number # player source
---@param amount number # amount to take from player
---@param account string # bank or cash
---@param reason string # reason for change
local function addMoney(src, amount, account, reason)
  if Config.Framework == 'qbx' then
    exports.qbx_core:AddMoney(src, account, amount, reason)
  elseif Config.Framework == 'qb' then
    local plr = coreObject.Functions.GetPlayer(src)
    if not plr then return false end
    plr.Functions.AddMoney(account, amount)
  elseif Config.Framework == 'esx' then
    local plr = coreObject.GetPlayerFromId(src)
    if not plr then return false end
    plr.addMoney(amount)
  end
end
exports('addMoney', addMoney)
