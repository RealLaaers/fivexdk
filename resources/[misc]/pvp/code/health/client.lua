local firstSpawn = true
local pointt = lib.points.new(vec3(5130.3467, -4985.6982, 12.6833), 2000)

local cayo = false
function pointt:onEnter()
  cayo = true
end

function pointt:onExit()
  cayo = false
end

local point = lib.points.new(vec3(1530.6582, 1709.7032, 109.9309), 125)
local zone1 = false
function point:onEnter()
    zone1 = true
end

function point:onExit()
    zone1 = false
end

local point2 = lib.points.new(vec3(-1629.3918, 209.7738, 60.6413), 125)
local zone2 = false
function point2:onEnter()
    zone2 = true
end

function point2:onExit()
    zone2 = false
end

local point3 = lib.points.new(vec3(1078.0343, 2299.7446, 45.5086), 125)
local zone3 = false
function point3:onEnter()
    zone3 = true
end

function point3:onExit()
    zone3 = false
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
    if not cayo and not zone1 and not zone2 and not zone3 then
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
  elseif Config.currentZone == 'pistol1' then
    local ped = PlayerPedId()
    Wait(400)
    TriggerEvent('respawnpistolzone')
    Wait(50)
    TriggerEvent('healffs2')
    SetPedArmour(ped, 100)
    Wait(700)
elseif Config.currentZone == 'zone1' or Config.currentZone == 'zone2' or Config.currentZone == 'zone3' then
  local ped = PlayerPedId()
  Wait(400)
  TriggerEvent('core:ResetDeathStatus', false)
  TriggerEvent("KOTH:ReturnBase")
  Wait(50)
  TriggerEvent('healffs2')
  SetPedArmour(ped, 100)
  Wait(700)
end
end)