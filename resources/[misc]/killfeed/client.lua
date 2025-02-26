-- Variables
local showKillfeed = true
local deathOverwrite = false
local ignoreNextDeath = false
local recentDeaths = {}
local damageIndex = {
    fatal = 6,
    weapon = 7
}

local weapons = {


    -- Handguns --
    [453432689] = { image = "pistol", canDriveBy = true },                             -- WEAPON_PISTOL            - Pistol
    [-1075685676] = { image = "pistol_mk2", canDriveBy = true },                       -- WEAPON_PISTOL_MK2        - Pistol Mk II
    [1593441988] = { image = "combat_pistol", canDriveBy = true },                     -- WEAPON_COMBATPISTOL      - Combat Pistol
    [-1716589765] = { image = "pistol_50", canDriveBy = true },                        -- WEAPON_PISTOL50          - Pistol 50
    [-771403250] = { image = "heavy_pistol", canDriveBy = true },                      -- WEAPON_HEAVYPISTOL       - Heavy Pistol
    [137902532] = { image = "vintage_pistol", canDriveBy = true },                     -- WEAPON_VINTAGEPISTOL     - Vintage Pistol
    [727643628] = { image = "ceramic", canDriveBy = true },                            -- WEAPON_CERAMICPISTOL     - Ceramic Pistol
    [-1045183535] = { image = "revolver", canDriveBy = true },                         -- WEAPON_REVOLVER          - Revolver
    [-1853920116] = { image = "navy_revolver", canDriveBy = true },                    -- WEAPON_NAVYREVOLVER      - Navy Revolver
    [465894841] = { image = "wm29_pistol", canDriveBy = true },                        -- WEAPON_PISTOLXM3         - WM 29 Pistol

    -- Submachine Guns --
    [324215364] = { image = "micro_smg", canDriveBy = true },       -- WEAPON_MICROSMG      - Micro SMG
    [-619010992] = { image = "machine_pistol", canDriveBy = true }, -- WEAPON_MACHINEPISTOL - Machine Pistol
    [-1121678507] = { image = "mini_smg", canDriveBy = true },      -- WEAPON_MINISMG       - Mini SMG
    [736523883] = { image = "smg" },                                -- WEAPON_SMG           - SMG
    [1627465347] = { image = "gusenberg" },                         -- WEAPON_GUSENBERG     - Gusenberg

    -- Assault Rifles --
    [-1074790547] = { image = "assault_rifle" },        -- WEAPON_ASSAULTRIFLE          - Assault Rifle
    [-2084633992] = { image = "carbine_rifle" },        -- WEAPON_CARBINERIFLE          - Carbine Rifle
    [1649403952] = { image = "compact_rifle" },         -- WEAPON_COMPACTRIFLE          - Compact Rifle

    -- Shotguns --
    [487013001] = { image = "pump_shotgun" },           -- WEAPON_PUMPSHOTGUN       - Pump Shotgun
    [2017895192] = { image = "sawnoff_shotgun" },       -- WEAPON_SAWNOFFSHOTGUN    - Sawnoff Shotgun
    [-1466123874] = { image = "musket" },               -- WEAPON_MUSKET            - Musket
    [-275439685] = { image = "double_barrel_shotgun" }, -- WEAPON_DBSHOTGUN         - Double Barrel Shotgun
    [94989220] = { image = "combat_shotgun" },          -- WEAPON_COMBATSHOTGUN     - Combat Shotgun

    -- Other Weapons --
    ['default'] = { image = "unknown", canHeadshot = false, ignoreDeath = false },  -- If the weapon was not spesifed in the list it will fall back on this one
    [-100946242] = { image = "animal" },                                            -- WEAPON_ANIMAL
    [148160082] = { image = "cougar" },                                             -- WEAPON_COUGAR                - Mt. Lion and Panthers
    [539292904] = { image = "explosion", canHeadshot = false },                     -- WEAPON_EXPLOSION             - Explosion
    [-842959696] = { image = "fall", canHeadshot = false, canSelf = false },        -- WEAPON_FALL                  - Fall damage
    [-544306709] = { image = "fire", canHeadshot = false, canSelf = false },        -- WEAPON_FIRE                  - Fire
    [-1553120962] = { image = "vehicle", canHeadshot = false },                     -- WEAPON_RUN_OVER_BY_CAR       - Run over by a vehicle
    [133987706] = { image = "rammed", canHeadshot = false },                        -- WEAPON_RAMMED_BY_CAR         - This is while the victim is also in a vehicle
    [-1833087301] = { image = "electric", canHeadshot = false },                    -- WEAPON_ELECTRIC_FENCE        - Electrocuted
    [-10959621] = { image = "drowning", canHeadshot = false, canSelf = false },     -- WEAPON_DROWNING              - Drowned
    [1936677264] = { image = "drowning", canHeadshot = false, canSelf = false },    -- WEAPON_DROWNING_IN_VEHICLE   - Drowned, but in a vehicle
    [-868994466] = { image = "unknown", canHeadshot = false, canSelf = false },     -- WEAPON_HIT_BY_WATER_CANNON   - Water cannon from firetrucks/RCV's

}


-- Functions --
local function SendToKillFeed(id, killer, victim, image, border, background, noScoped, headshot, driveBy, dist)
    SendNUIMessage({
        action = "addKillToFeed",
        data = {
            id = id,
            killer = killer,
            victim = victim,
            image = image,
            border = border,
            background = background,
            noScoped = noScoped,
            headshot = headshot,
            driveBy = driveBy,
            dist = dist
        }
    })
end

local function GetPedSubType(ped)
    if GetPedType(ped) == 28 then
        return "animal"
    end
    return "human"
end

local function GetNearbyVehicles(coords)
    local handle, entity = FindFirstVehicle()
    local success = nil
    local vehicles = {}
    repeat
        local pos = GetEntityCoords(entity)
        local distance = #(coords - pos)
        if distance < 15.0 then
            vehicles[#vehicles+1] = entity
        end
        success, entity = FindNextVehicle(handle)
    until not success
    EndFindVehicle(handle)
    return vehicles
end

local function HandleDeath(killerPed, victimPed, weaponHash, isMelee)
    local weapon = weapons[weaponHash]
    local headshot = false
    local noScoped = false
    local driveBy = false
    local showDist = false

    if not Config.IncludeAI then
        if not IsPedAPlayer(victimPed) then
            return
        elseif not IsPedAPlayer(killerPed) then
            killerPed = -1
            weaponHash = 'default'
        end
    elseif not Config.IncludeAnimals then
        if GetPedSubType(victimPed) == "animal" then
            return
        elseif GetPedSubType(killerPed) == "animal" then
            killerPed = -1
            weaponHash = 'default'
        end
    end

    if not DoesEntityExist(killerPed) or (killerPed == victimPed and weapon.canSelf == false) then
        killerPed = -1
    end

    -- If they were rammed by a car (WEAPON_RAMMED_BY_CAR)
    if weaponHash == 133987706 and (killerPed == victimPed or GetVehiclePedIsIn(killerPed, false) == GetVehiclePedIsIn(victimPed, false)) then
        local victimVeh = GetVehiclePedIsIn(victimPed, false)
        local vehicles = GetNearbyVehicles(GetEntityCoords(victimPed))

        for _index, vehicle in pairs(vehicles) do
            if victimVeh ~= vehicle then
                if HasEntityBeenDamagedByEntity(victimVeh, vehicle, true) then
                    local driver = GetPedInVehicleSeat(vehicle, -1)
                    if driver ~= 0 then
                        killerPed = driver
                        break
                    end
                end
            end
        end
    end

    if Config.DisplayDriveByIcons and weapon.canDriveBy and IsPedShooting(killerPed) then
        local vehicle = GetVehiclePedIsIn(killerPed, false)
        if vehicle ~= 0 then
            if GetVehicleClass(vehicle) == 8 then
                driveBy = 'bike'
            else
                driveBy = 'driveby_vehicle'
            end
        end
    end

    if Config.DisplayHeadshots and weapon.canHeadshot ~= false and not isMelee then
        local found, bone = GetPedLastDamageBone(victimPed)
        if found and (bone == 31086 or bone == 39317) then
            headshot = true
        end
    end

    if (Config.ShowKillDistance == 1 and weapon.showDist) or Config.ShowKillDistance == 2 then
        showDist = true
    end

    local killer = {}
    if killerPed == -1 then
        killer.netId = 0
    else
        killer.netId = PedToNet(killerPed)
        if IsPedAPlayer(killerPed) then
            killer.type = "player"
            killer.sourceId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(killerPed))

            if Config.DisplayNoScopes and weapon.canNoScope and not IsFirstPersonAimCamActive() then
                noScoped = true
            end
        else
            killer.type = "npc"
            killer.gender = IsPedMale(killerPed) and "male" or "female"
            killer.pedType = GetPedSubType(killerPed)
        end
    end

    local victim = {}
    victim.netId = PedToNet(victimPed)
    if IsPedAPlayer(victimPed) then
        victim.type = "player"
        victim.sourceId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(victimPed))
    else
        victim.type = "npc"
        victim.gender = IsPedMale(victimPed) and "male" or "female"
        victim.pedType = GetPedSubType(victimPed)
    end

    TriggerServerEvent('killfeed:sendToKillFeed', killer, victim, weapon.image, noScoped, headshot, driveBy, showDist)
end

local function OnEntityDamage(args)
    local fatal = args[damageIndex.fatal]
    if fatal == 0 then
        return
    end

    local victim = args[1]
    local killer = args[2]
    local playerPed = PlayerPedId()

    if not IsEntityAPed(victim) then
        return
    end

    if recentDeaths[victim] then
        return
    end

    -- If we are the killer, or the killer is an NPC and we have network cotrol over the victim, then we should collect the data
    if playerPed == killer or (not IsPedAPlayer(killer) and NetworkHasControlOfEntity(victim)) then
        local weaponHash = args[damageIndex.weapon]
        if victim == playerPed then
            if ignoreNextDeath then
                ignoreNextDeath = false
                return
            elseif deathOverwrite then
                weaponHash = deathOverwrite
                deathOverwrite = false
            end
        end

        if not weapons[weaponHash] then
            weaponHash = 'default'
        end

        if weapons[weaponHash].ignoreDeath then
            return
        end

        local isMelee = (args[12] == 1 and true) or false
        recentDeaths[victim] = true
        HandleDeath(killer, victim, weaponHash, isMelee)
        Wait(1000)
        recentDeaths[victim] = nil
    end
end

-- Exports
local function OverwriteNextDeath(weapon)
    if weapons[weapon] then
        deathOverwrite = weapon
        return true
    elseif weapon == false then
        deathOverwrite = false
        return true
    end
    return false
end
exports("OverwriteNextDeath", OverwriteNextDeath)

local function IgnoreNextDeath(state)
    ignoreNextDeath = state
end
exports("IgnoreNextDeath", IgnoreNextDeath)


-- Events --
AddEventHandler('gameEventTriggered', function(event, args)
	if event == "CEventNetworkEntityDamage" then
        OnEntityDamage(args)
    end
end)

RegisterNetEvent('killfeed:recivePlayerKillFeed')
AddEventHandler('killfeed:recivePlayerKillFeed', function(killer, victim, image, noScoped, headshot, driveBy, dist)
    if not showKillfeed then return end
    local border = 'black-border'
    if killer.netId == PedToNet(PlayerPedId()) then
        border = 'red-border'
    end

    local background = 'black-background'
    if victim.netId == PedToNet(PlayerPedId()) then
        background = 'red-background'
    end

    SendToKillFeed("killed_"..victim.netId, killer, victim, image, border, background, noScoped, headshot, driveBy, dist)
end)

RegisterNetEvent('killfeed:addMessage')
AddEventHandler('killfeed:addMessage', function(id, message)
    SendNUIMessage({
        action = "addMessageToFeed",
        data = {
            id = id,
            message = message
        }
    })
end)


-- Commands --
if Config.ToggleCommand then
    RegisterCommand('killfeed', function()
        showKillfeed = not showKillfeed
        SendNUIMessage({ action = "toggleKillfeed", data = { state = showKillfeed } })
        if showKillfeed then
            lib.notify({
                title = 'Killfeed',
                description = 'Killfeed was enabled!',
                position = 'top',
                type = 'success'
            })
        else
            lib.notify({
                title = 'Killfeed',
                description = 'Killfeed was disabled!',
                position = 'top',
                type = 'error'
            })
        end
    end, false)
end


-- Initialize --
CreateThread(function()
    Wait(2500)

    -- Outputs are diffrent for the CEventNetworkEntityDamage game event when on game build 1604
    if GetGameBuildNumber() < 2060 then
        damageIndex.fatal = 4
        damageIndex.weapon = 5
    end

    SendNUIMessage({
        action = "setConfig",
        data = {
            showTime = Config.ShowTime,
            maxLines = Config.MaxLines,
            killerColourP = Config.KillerColour.Player,
            victimColourP = Config.VictimColour.Player,
            killerColourN = Config.KillerColour.NPC,
            victimColourN = Config.VictimColour.NPC,
            killDistColour = Config.KillDistanceColour
        }
    })
end)
