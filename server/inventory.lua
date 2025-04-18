local coreObject = GetFrameworkObject()

---@param src number # player source
---@param item string # item name
---@param amount number # amount to take from player
local function removeItem(src, item, amount)
  if Config.Inventory == 'ox' then
    exports.ox_inventory:RemoveItem(src, item, amount)
  elseif Config.Inventory == 'qb' then
    exports['qb-inventory']:RemoveItem(src, item, amount)
  elseif Config.Inventory == 'esx' then
    local plr = coreObject.GetPlayerFromId(src)
    if not plr then return false end
    plr.removeInventoryItem(item, amount)
  end
end
exports('removeItem', removeItem)

---@param src number # player source
---@param item string # item name
---@param amount number # amount to take from player
local function addItem(src, item, amount)
  if Config.Inventory == 'ox' then
    if exports.ox_inventory:CanCarryItem(src, item, amount) then
      exports.ox_inventory:AddItem(src, item, amount)
    else
      doNotify(src, 5000, 'Inventory: ', 'You cant carry that!', 'error')
    end
  elseif Config.Inventory == 'qb' then
    if exports['qb-inventory']:CanAddItem(src, item, amount) then
      exports['qb-inventory']:AddItem(src, item, amount)
    else
      doNotify(src, 5000, 'Inventory: ', 'You cant carry that!', 'error')
    end
  elseif Config.Inventory == 'esx' then
    local plr = coreObject.GetPlayerFromId(src)
    if not plr then return false end
    if plr.canCarryItem(item, amount) then
      plr.addInventoryItem(item, amount)
    else
      doNotify(src, 5000, 'Inventory: ', 'You cant carry that!', 'error')
    end
  end
end
exports('addItem', addItem)
