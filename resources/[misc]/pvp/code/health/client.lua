local firstSpawn = true
local pointt = lib.points.new(vec3(5130.3467, -4985.6982, 12.6833), 2000)

local cayo = false
function pointt:onEnter()
  cayo = true
end

function pointt:onExit()
  cayo = false
end

local function notify(msg, nType)
  lib.notify({
    title = msg,
    type = nType
  })
end

-- AddEventHandler('esx:onPlayerSpawn', function()
--   if firstSpawn then
--     firstSpawn = false
--     ExecuteCommand('clothing')
--   end
-- end)

RegisterNetEvent('healffs', function()
    if not Config.canRevive then return notify('Revive er deaktiveret her.', 'error') end
    if LocalPlayer.state.inDuel ~= nil then return notify('Revive er deaktiveret her.', 'error') end
    if not cayo then
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)

    if not IsEntityDead(ped) then return end

    if IsEntityDead(ped) then
        NetworkResurrectLocalPlayer(pos[1], pos[2], pos[3], heading, false, false)
    end

    SetEntityHealth(ped, 200)
    AddArmourToPed(ped, 100)
    SetPedArmour(ped, 100)
    ClearPedBloodDamage(ped)

    Citizen.Wait(2000)
else
  notify('Revive er deaktiveret her.', 'error')
end
end)

RegisterNetEvent('healffs2', function()
  local ped = PlayerPedId()
  local pos = GetEntityCoords(ped)
  local heading = GetEntityHeading(ped)

  if not IsEntityDead(ped) then return end

  if IsEntityDead(ped) then
      NetworkResurrectLocalPlayer(pos[1], pos[2], pos[3], heading, false, false)
  end

  SetEntityHealth(ped, 200)
  AddArmourToPed(ped, 100)
  SetPedArmour(ped, 100)
  ClearPedBloodDamage(ped)

  Citizen.Wait(2000)
end)

RegisterCommand("r", function()
    TriggerEvent("healffs")
end)

RegisterCommand("revive", function()
    TriggerEvent("healffs")
end)

AddEventHandler('esx:onPlayerDeath', function(data)
  local polyZones = exports["pvp"]:getAllPolyZones()
  if Config.currentZone == "deagle" then
      local currentWeapon = exports["ox_inventory"]:getCurrentWeapon() or exports.ox_inventory:GetSlotWithItem("weapon_pistol50", nil, false)
      Wait(400)
      local ped = PlayerPedId()
      SetEntityCoords(ped, polyZones["deagle_spawn"].center.x, polyZones["deagle_spawn"].center.y, 344.665222)
      SetEntityHeading(ped, math.random(1, 360))
      Wait(50)
      TriggerEvent('healffs2')
      SetPedArmour(ped, 100)
      Wait(700)
      --exports.ox_inventory:useSlot(currentWeapon.slot)
  elseif Config.currentZone == "apzonee" then
      local currentWeapon = exports["ox_inventory"]:getCurrentWeapon() or exports.ox_inventory:GetSlotWithItem("weapon_appistol", nil, false)
      Wait(400)
      local ped = PlayerPedId()
      SetEntityCoords(ped, polyZones["ap_spawn"].center.x, polyZones["ap_spawn"].center.y, 657.2678)
      SetEntityHeading(ped, math.random(1, 360))
      Wait(50)
      TriggerEvent('healffs2')
      SetPedArmour(ped, 100)
      Wait(700)
      --exports.ox_inventory:useSlot(currentWeapon.slot)
  end
end)