
local polyZones = {}
local function notify(msg, nType)
    lib.notify({
      title = msg,
      type = nType
    })
  end

-- CreateThread(function()
--     -- for i = 1, #Config.Peds do
--         -- local model = Config.Peds[i].hash
--         -- RequestModel(model)
--         -- while not HasModelLoaded(model) do
--         --     Wait(0)
--         -- end
--         -- local entity = CreatePed(0, model, vector3(Config.Peds[i].coords.x, Config.Peds[i].coords.y, Config.Peds[i].coords.z - 1), Config.Peds[i].coords.w, false, false)
--         GiveWeaponToPed(entity, GetHashKey(Config.Peds[i].weapon), 0, true, true)
--         SetBlockingOfNonTemporaryEvents(entity, true)
--         FreezeEntityPosition(entity, true)
--         SetEntityInvincible(entity, true)
--         exports.ox_target:addLocalEntity(entity,
--             {
--                 label = Config.Peds[i].label,
--                 name = string.lower(Config.Peds[i].label),
--                 icon = Config.Peds[i].icon,
--                 distance = 5,
--                 canInteract = function(entity)
--                     if type(ESX.PlayerData) == 'table' then return true end
--                 end,
--                 onSelect = function(entity)
--                     if Config.Peds[i].gotoCoords ~= nil then
--                         local ped = PlayerPedId()
--                         TriggerEvent('ox_inventory:disarm', GetPlayerServerId(PlayerId()), true)
--                         SetEntityCoordsNoOffset(ped, Config.Peds[i].gotoCoords.x, Config.Peds[i].gotoCoords.y, Config.Peds[i].gotoCoords.z, false, false, true)
--                         SetEntityHeading(ped, Config.Peds[i].gotoCoords.w)
--                     end
--                     if Config.Peds[i].export ~= nil then
--                         Config.Peds[i].export()
--                     end
--                 end
--             }
--         )
--     -- end
--     -- local rollTimer = 180 --[[Higher the faster]]
--     -- for i = 0, 3 do
--     --     StatSetInt(GetHashKey("mp" .. i .. "_shooting_ability"), rollTimer , true)
--     --     StatSetInt(GetHashKey("sp" .. i .. "_shooting_ability"), rollTimer , true)
--     -- end
-- end)

exports("getAllPolyZones", function()
    return polyZones
end)

-- O Keybind to spawn
RegisterCommand('+spawnFunction', function()
    if LocalPlayer.state.inDuel ~= nil then return notify('Du er i en duel skriv /leaveduel hvis du ønsker at gå til spawn.', 'error') end
    local ped = PlayerPedId()
    ExecuteCommand('leavekoth')
    SetEntityCoordsNoOffset(ped, Config.spawnCoords.x, Config.spawnCoords.y, Config.spawnCoords.z, false, false, true)
    SetEntityHeading(ped, Config.spawnCoords.w)
    ExecuteCommand('leave')
    ExecuteCommand('leaveduel')
end)

RegisterKeyMapping('+spawnFunction', 'Teleport to spawn', 'keyboard', 'o')

RegisterNetEvent('spawnFunction')
AddEventHandler('spawnFunction', function()
    ExecuteCommand('+spawnFunction')
end)

local function zoneCheck()
    while true do
        local msVar = 500
        local ped = PlayerPedId()
        local coord = GetEntityCoords(ped)
        
        local inZone = false
        for k, v in pairs(Config.polyZones) do
            local isInside = polyZones[k]:isPointInside(coord)
            if isInside then
                Config.currentZone = polyZones[k].name
                inZone = true
                msVar = 1
                if not v.canShoot then
                    DisablePlayerFiring(ped, true)
                    DisableControlAction(1, 140, true) -- Disable melee attack light (punch)
                    DisableControlAction(1, 141, true) -- Disable melee attack heavy (punch)
                    DisableControlAction(1, 142, true) -- Disable melee attack alternative (punch)
                end
                if v.runFast then
                    SetPedMoveRateOverride(ped, 1.3)
                end
                Config.canRevive = v.canRevive
                Config.canNoclip = v.canNoclip
                Config.canSpawnVehicle = v.canSpawnVehicle
                SetPlayerInvincible(ped, v.invincible)
                SetEntityInvincible(ped, v.invincible)
                break
            end
        end
        
        if not inZone then
            Config.canRevive = true
            Config.canSpawnVehicle = true
            Config.canNoclip = true
            Config.currentZone = nil
            SetPlayerInvincible(ped, false)
            SetEntityInvincible(ped, false)
        end

        Wait(msVar)
    end 
end

local function vehicleChecker()
    for k, v in pairs(Config.polyZones) do
        polyZones[k]:onPlayerInOut(function(isPointInside, point)
            if v.removeVehicles then
                local ped = PlayerPedId()
                local veh = GetVehiclePedIsIn(ped)
                SetEntityAsMissionEntity(veh, false)
                SetEntityAsNoLongerNeeded(veh)
                DeleteEntity(veh)
            end
        end)
    end
end

CreateThread(function()
    SetCanAttackFriendly(PlayerPedId(), true, false)
    SetEntityInvincible(PlayerPedId(), false)
    NetworkSetFriendlyFireOption(true)
    for k, v in pairs(Config.polyZones) do
        if v.type == "poly" then
            polyZones[k] = PolyZone:Create(v.coords, {
                name = k,
                minZ = v.minZ - 0.5,
                maxZ = v.maxZ,
                useZ = true,
                debugPoly = false
            })
        end
        if v.type == "circle" then
            polyZones[k] = CircleZone:Create(v.coords, v.radius, {
                name=k,
                minZ = v.minZ,
                maxZ = v.maxZ,
                useZ = true,
                debugPoly=false,
            })
        end
    end
    CreateThread(zoneCheck)
    CreateThread(vehicleChecker)
end)



AddEventHandler('ox_inventory:currentWeapon', function(weapon)
    if weapon then
        local ped = PlayerPedId()
        local coord = GetEntityCoords(ped)
        for k, v in pairs(Config.polyZones) do
            if polyZones[k]:isPointInside(coord) then
                if #v.allowedWeapons > 0 then
                    local allowed = false
                    for i = 1, #v.allowedWeapons do
                        if string.lower(weapon.name) == v.allowedWeapons[i] then
                            allowed = true
                            break
                        end
                    end
                    if not allowed then
                        TriggerEvent('ox_inventory:disarm', GetPlayerServerId(PlayerId()), true)
                    end
                end
                break
            end
        end
    end
end)



-- AddEventHandler('ox_inventory:currentWeapon', function(weapon)
--     if weapon then
--         for k, v in pairs(Config.polyZones) do
--             if v.allowedWeapons[1] then
--                 for i = 1, #v.allowedWeapons do
--                     if string.lower(weapon.name) == v.allowedWeapons[i] then
--                         return
--                     end
--                 end
--             end
--         end
--         TriggerEvent('ox_inventory:disarm', GetPlayerServerId(PlayerId()), true)
--     end
-- end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        for k, v in pairs(Config.polyZones) do
            v.polyStuff:destroy()
        end
    end
 end)

--  local function canRevive()
--     return Config.canRevive
--  end

--  exports("canRevive", canRevive)