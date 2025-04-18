local coreObject = GetFrameworkObject()

---@param duration number # length of progress
---@param label string # progress text
---@param anim? table # {dict, clip}
local function doProgress(duration, label, anim)
  if not anim then anim = {} end

  if Config.Progress == 'qb' then
    coreObject.Functions.Progressbar(label, label, duration, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
      },
      {
        animDict = anim[1],
        anim = anim[2],
      }, {}, {}, function()
        return true
      end, function()
        return false
      end)
  elseif Config.Progress == 'ox-normal' then
    if lib.progressBar({
          duration = duration,
          label = label,
          useWhileDead = false,
          canCancel = true,
          disable = {
            move = true,
          },
          anim = {
            dict = anim[1],
            cip = anim[2],
          }
        })
    then
      return true
    else
      return false
    end
  elseif Config.Progress == 'esx' then
    coreObject.Progressbar(label, duration, {
      FreezePlayer = true,
      animation = {
        type = "anim",
        dict = anim[1],
        lib = anim[2]
      },
      onFinish = function()
        return true
      end,
      onCancel = function()
        return false
      end
    })
  else
    if lib.progressCircle({
      duration = duration,
      label = label,
      position = Config.OxCirclePosition,
      useWhileDead = false,
      canCancel = true,
      disable = {
        move = true,
      },
      anim = {
        dict = anim[1],
        clip = anim[2],
      }
    })
    then
      return true
    else
      return false
    end
  end
end
exports('doProgress', doProgress)
