function checkDuty()
  if not Config.needToBeOnDutyForClothingRooms then return true end
  return isPlayerOnDuty()
end
  
function checkPlayerOutfitClothing(outfitTable)
  if #outfitTable.citizenIds == 0 then return false end
  for i = 1, #outfitTable.citizenIds do 
    if outfitTable.citizenIds[i] == getPlayerCID() then 
      return true
    end
  end
  return
end

local handsUp = false
local dict = "missminuteman_1ig_2"

CreateThread(function()
  RequestAnimDict(dict)
  while not HasAnimDictLoaded(dict) do
    Wait(100)
  end
end)

CreateThread(function()
  while Config.disableLoosingPropsWhenPunched do 
    Wait(1000)
    SetPedCanLosePropsOnDamage(cache.ped, false, 0)
  end
end)

function handsUpAnim()
  if not handsUp then 
    handsUp = true
    TaskPlayAnim(cache.ped, dict, "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
  else
    handsUp = false
    ClearPedTasks(cache.ped)
  end
end