--------------------------------------------------------------------

local menu_open = false
local vote_open = false
local in_gungame = false
local join_available = true
local last_weapon = nil
local last_map = nil

local Temporary_Data = {
    ["OldCoords"] = vector3(0.0, 0.0, 0.0),
    ["OldHeading"] = 0.0,
    ["OldHealth"] = 0,
    ["OldArmor"] = 0,
}

--------------------------------------------------------------------

local Settings = {
    LeaveCommand = Config.Settings['LeaveCommand'],
    NPC_Model = Config.Settings['Model'],
    NPC_Coords = Config.Settings['Coords'],
    NPC_Heading = Config.Settings['Heading'],
    NPC_DrawText = Config.Settings['DrawText'],
    NPC_InteractionKey = Config.Settings['InteractionKey'],
    DoYouUseOxInventory = Config.Settings['DoYouUseOxInventory'],
    GungameBucket = Config.Settings['GungameBucket'],
}

local SetTexts = {
    MainText = Config.Settings['MainText'],
    SubText = Config.Settings['SubText'],
    InfoBoxText = Config.Settings['InfoBoxText'],
    InfoText = Config.Settings['InfoText']
}

--------------------------------------------------------------------

local function findMap(mapName)
    for _, map in ipairs(Config.Maps) do
        if map.name == mapName then
            return map
        end
    end
    return nil
end

local function selectRandomSpawn(mapData)
    if not mapData or not mapData.coordinates then
        return nil
    end

    local coordinates = mapData.coordinates


    if #coordinates == 0 then
        return nil
    end

    local randomIndex = math.random(1, #coordinates)
    local randomSpawn = coordinates[randomIndex]

    return randomSpawn
end

Citizen.CreateThread(function()
    DoScreenFadeIn(500)
    TriggerServerEvent('fivex-gungame:server:checkData')
end)

AddEventHandler('gameEventTriggered', function(event, data)
    if event == "CEventNetworkEntityDamage" then
        local victim, attacker, victimDied = data[1], data[2], data[4]
        if in_gungame then
            if not IsEntityAPed(victim) then return end
            if victimDied and NetworkGetPlayerIndexFromPed(victim) == PlayerId() and IsEntityDead(PlayerPedId()) then
                local victimId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(victim))
                if attacker ~= -1 then 
                    if attacker == PlayerPedId() then return end
                    local killerServerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(attacker))
                    if in_gungame then
                        Wait(2500)
                        TriggerServerEvent('fivex-gungame:server:killPlayer', killerServerId)
                        TriggerServerEvent('fivex-gungame:server:playerDeath')
                    end
                else
                    if in_gungame then
                        Wait(2500)
                        TriggerServerEvent('fivex-gungame:server:playerDeath')
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('fivex-gungame:client:Revive', function()
    local ply = PlayerId()
    local ply_ped = PlayerPedId()
    local map = findMap(last_map)
    local coordinates = Config.Coordinates[map.id]
    local randomSpawn = selectRandomSpawn({coordinates = coordinates})
    if not coordinates then
        print("[ERROR:] The coordinates of the selected map were not found!")
        return
    end
    if not randomSpawn then
        print("[ERROR:] The spawn point of the selected map was not found!")
        return
    end
    DoScreenFadeOut(500)
    Wait(200)
    TriggerEvent('fivex-gungame:reviveEvent')
    SetEntityCoords(ply_ped, randomSpawn.x, randomSpawn.y, randomSpawn.z)
    SetEntityHealth(ply_ped, 200)
    SetPedArmour(ply_ped, 200)
    RemoveWeaponFromPed(ply_ped, GetHashKey(GetCurrentPedWeapon(ply_ped)))
    GiveWeaponToPed(ply_ped, GetHashKey(last_weapon), 999, false, true)
    SetPedInfiniteAmmo(ply_ped, true, GetHashKey(last_weapon))
    SetCurrentPedWeapon(ply_ped, GetHashKey(last_weapon), true)
    Wait(200)
    DoScreenFadeIn(500)
end)

--------------------------------------------------------------------

Citizen.CreateThread(function()
    Wait(1000)
    RequestModel(GetHashKey(Settings.NPC_Model))
    while not HasModelLoaded(GetHashKey(Settings.NPC_Model)) do
        Wait(1)
    end
    local npc = CreatePed(1, GetHashKey(Settings.NPC_Model), Settings.NPC_Coords.x, Settings.NPC_Coords.y, Settings.NPC_Coords.z, Settings.NPC_Heading, false, true)
    SetEntityInvincible(npc, true)
    FreezeEntityPosition(npc, true)
    SetPedCombatAttributes(npc, 46, true)               
    SetPedFleeAttributes(npc, 0, 0)               
    SetBlockingOfNonTemporaryEvents(npc, true)
    SetEntityAsMissionEntity(npc, true, true)
end)

local sleep = 1000
Citizen.CreateThread(function()
    while true do
        local ply_coords = GetEntityCoords(PlayerPedId())
        if #(Settings.NPC_Coords - ply_coords) < 4 then 
            sleep = 0
            if IsControlJustReleased(0, Settings.NPC_InteractionKey) then 
                TriggerEvent('fivex-gungame:client:sendServer')
            end
            DrawText3D(Settings.NPC_Coords.x, Settings.NPC_Coords.y, Settings.NPC_Coords.z + 1.95, Settings.NPC_DrawText)
        end
        Wait(sleep)
    end
end)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x,y,z)
    if onScreen then
        local factor = #text / 370
        SetTextScale(0.27, 0.27)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextDropshadow(0)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 250
        DrawRect(_x,_y +0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    end
end

RegisterCommand(Settings.LeaveCommand, function()
    if in_gungame then
        local ply_ped = PlayerPedId()
        TriggerEvent('five-x:disable:noclip:revive', true, 'gungame')
        TriggerServerEvent('fivex-gungame:server:leaveLobby')
        SetEntityCoords(ply_ped, Temporary_Data.OldCoords.x, Temporary_Data.OldCoords.y, Temporary_Data.OldCoords.z -1.0)
        SetEntityHeading(ply_ped, Temporary_Data.OldHeading)
        SetEntityHealth(ply_ped, Temporary_Data.OldHealth)
        SetPedArmour(ply_ped, Temporary_Data.OldArmor)
        RemoveWeaponFromPed(ply_ped, GetHashKey(GetCurrentPedWeapon(ply_ped)))
        RemoveWeaponFromPed(ply_ped, GetHashKey(last_weapon))
        SetCurrentPedWeapon(ply_ped, GetHashKey("WEAPON_UNARMED"), true)
        if Settings.DoYouUseOxInventory then
            exports.ox_inventory:weaponWheel(false)
        end
        last_weapon = nil
        Temporary_Data.OldCoords = vector3(0.0, 0.0, 0.0)
        Temporary_Data.OldHeading = 0.0
        Temporary_Data.OldHealth = 0
        Temporary_Data.OldArmor = 0
        menu_open = false
        vote_open = false
        in_gungame = false
        last_weapon = nil
        last_map = nil
        TriggerEvent('fivex-gungame:leave-after')
        SendNUIMessage({type = "closeMainMenu"})
        TriggerEvent('fivex-gungame:reviveEvent')
        DoScreenFadeIn(500)
    end
end)

--------------------------------------------------------------------

RegisterNetEvent('fivex-gungame:client:sendServer', function()
    TriggerServerEvent('fivex-gungame:server:openMenu')
end)

local jsonTexts = json.encode(SetTexts)

RegisterNetEvent('fivex-gungame:client:openMenu', function(ply_data, gungame_data)
    local ply = PlayerId()
    local map = findMap(gungame_data.map)
    if not menu_open then
        menu_open = true 
        if join_available then
            SendNUIMessage({
                type = "openMainMenu",
                player_name = ply_data.name,
                player_id = ply_data.id,
                player_win = ply_data.win,
                player_kill = ply_data.kill,
                player_death = ply_data.death,
                player_photo = ply_data.photo,
                gungame_map = map.name,
                gungame_map_info = map.information,
                gungame_map_img = map.imageUrl,
                gungame_map_max_player = map.max_player,
                gungame_players = gungame_data.players,
                texts = jsonTexts,
            })
            SetNuiFocus(true, true)
        else
            SendNUIMessage({
                type = "openMainMenuNotAvailable",
                player_name = ply_data.name,
                player_id = ply_data.id,
                player_win = ply_data.win,
                player_kill = ply_data.kill,
                player_death = ply_data.death,
                player_photo = ply_data.photo,
                gungame_players = gungame_data.players,
                texts = jsonTexts,
            })
            SetNuiFocus(true, true)
        end
    end
end)

RegisterNUICallback('closeMenu', function() 
    menu_open = false 
    SetNuiFocus(false, false)
end)

--------------------------------------------------------------------

RegisterNUICallback('joinGungame', function()
    if join_available then
        TriggerServerEvent('fivex-gungame:server:joinGungame', Settings.GungameBucket, "joinGame")
    end
end)

RegisterNetEvent('fivex-gungame:client:joinGungame', function(Gungame_Map, Kill_Data, Game_Type)
    TriggerEvent('five-x:disable:noclip:revive', false, 'gungame')
    local ply = PlayerId()
    local ply_ped = PlayerPedId()
    local map = findMap(Gungame_Map)
    last_map = map.name
    local coordinates = Config.Coordinates[map.id]
    local randomSpawn = selectRandomSpawn({coordinates = coordinates})
    if not coordinates then
        print("[ERROR:] The coordinates of the selected map were not found!")
        return
    end
    if not randomSpawn then
        print("[ERROR:] The spawn point of the selected map was not found!")
        return
    end
    if Game_Type == "joinGame" then
        Temporary_Data.OldCoords = GetEntityCoords(ply_ped) 
        Temporary_Data.OldHeading = GetEntityHeading(ply_ped)
        Temporary_Data.OldHealth = GetEntityHealth(ply_ped) 
        Temporary_Data.OldArmor = GetPedArmour(ply_ped)
    end
    SendNUIMessage({type = "closeMainMenu"})
    DoScreenFadeOut(500)
    Wait(1000)
    SetEntityCoords(ply_ped, randomSpawn.x, randomSpawn.y, randomSpawn.z)
    SetEntityHealth(ply_ped, 200)
    SetPedArmour(ply_ped, 200)
    if Settings.DoYouUseOxInventory then
        exports.ox_inventory:weaponWheel(true)
    end
    TriggerEvent('fivex-gungame:join-after')
    in_gungame = true
    RemoveWeaponFromPed(ply_ped, GetHashKey(GetCurrentPedWeapon(ply_ped)))
    GiveWeaponToPed(ply_ped, GetHashKey(Kill_Data.weapon_system_name), 999, false, true)
    SetPedInfiniteAmmo(ply_ped, true, GetHashKey(Kill_Data.weapon_system_name))
    SetCurrentPedWeapon(ply_ped, GetHashKey(Kill_Data.weapon_system_name), true)
    last_weapon = Kill_Data.weapon_system_name
    SendNUIMessage({
        type = "showHud",
        activeweapon = Kill_Data.activeweapon,
        nextweapon = Kill_Data.nextweapon,
        killsleft = Kill_Data.killsleft,
        weaponsleft = Kill_Data.weaponsleft,
    })
    Wait(800)
    DoScreenFadeIn(500)
end)

--------------------------------------------------------------------

RegisterNetEvent('fivex-gungame:client:updateHud', function(updateType, updateData)
    local ply_ped = PlayerPedId()
    if updateType == "KillUpdate" then
        SendNUIMessage({
            type = "updateKillsLeft",
            killsleft = updateData.killsleft,
        })
    elseif updateType == "LevelUpdate" then
        SendNUIMessage({
            type = "updateLevel",
            activeweapon = updateData.activeweapon,
            nextweapon = updateData.nextweapon,
            killsleft = updateData.killsleft,
            weaponsleft = updateData.weaponsleft,
        })
        SendNUIMessage({
            type = "levelNotify",
            activeweapon = updateData.activeweapon,
        })
        PlaySound(PlayerId(), 'LOSER', 'HUD_AWARDS', 0, 0, 1)
        RemoveWeaponFromPed(ply_ped, GetHashKey(last_weapon))
        last_weapon = nil
        GiveWeaponToPed(ply_ped, GetHashKey(updateData.weapon_system_name), 999, false, true)
        SetPedInfiniteAmmo(ply_ped, true, GetHashKey(updateData.weapon_system_name))
        SetCurrentPedWeapon(ply_ped, GetHashKey(updateData.weapon_system_name), true)
        last_weapon = updateData.weapon_system_name
        Wait(3000)
        SendNUIMessage({type = "notifyHide"})
    end
end)

--------------------------------------------------------------------

RegisterNetEvent('fivex-gungame:client:startVote', function()
    if in_gungame then
        vote_open = true
        TriggerServerEvent('fivex-gungame:server:startVote')
        SendNUIMessage({
            type = "showVoteScreen",
            voteMaps = Config.Maps,
        })
        SetNuiFocus(true, true)
    end
end)

RegisterNUICallback('updateVote', function(data)
    TriggerServerEvent('fivex-gungame:server:updateVote', data.map)
end)

RegisterNetEvent('fivex-gungame:client:updateVote', function(voteData)
    if in_gungame and vote_open then
        for name, vote in pairs(voteData) do
            SendNUIMessage({
                type = "updateVoteScreen",
                mapid = name,
                votecount = vote.VoteCount,
            })
        end
    end
end)

RegisterNetEvent('fivex-gungame:client:AvailableStatus', function(status)
    if status == "available" then
        join_available = true
    elseif status == "notavailable" then
        join_available = false
        if menu_open and not vote_open then
            SendNUIMessage({type = "closeMainMenu"})
        end
    end
end)

RegisterNetEvent('fivex-gungame:client:newGameRoot', function()
    vote_open = false
    if in_gungame then
        TriggerServerEvent('fivex-gungame:server:joinGungame', Settings.GungameBucket, "newGame")
    end
end)

--------------------------------------------------------------------

RegisterNetEvent('fivex-gungame:client:finishGame', function(winner, winnerName)
    if in_gungame then
        RemoveAllPedWeapons(PlayerPedId(), true)
        PlaySound(PlayerId(), 'LOSER', 'HUD_AWARDS', 0, 0, 1)
        SendNUIMessage({type = "WinnerShow", winner = winnerName})
        Wait(4000)
        SendNUIMessage({type = "WinnerHide"})
        DoScreenFadeOut(700)
        Wait(2000)
        TriggerEvent('fivex-gungame:client:startVote')
    end
end)

--------------------------------------------------------------------

RegisterNUICallback('FetchLeaderboard', function()
    TriggerServerEvent("fivex-gungame:server:FetchLeaderboard")  
end)

RegisterNetEvent("fivex-gungame:client:GetLeaderboardData", function(data)
    SendNUIMessage({
        type = "updateLeader",
        data = data
    })
end)

--------------------------------------------------------------------

Citizen.CreateThread(function()
    local blips = {}
    local currentPlayer = PlayerId()
    while true do
        local sleep = 2000
        if in_gungame then 
            sleep = 0
            local players = GetActivePlayers()
            for _, player in ipairs(GetActivePlayers()) do
                if player ~= currentPlayer and NetworkIsPlayerActive(player) then
                    local playerPed = GetPlayerPed(player)
                    local playerName = GetPlayerName(player)
                    RemoveBlip(blips[player])
                    local new_blip = AddBlipForEntity(playerPed)
                    SetBlipNameToPlayerName(new_blip, "Player")
                    SetBlipAsShortRange(new_blip, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString("Player")
                    EndTextCommandSetBlipName(new_blip)
                    SetBlipColour(new_blip, 0)
                    SetBlipCategory(new_blip, 0)
                    SetBlipScale(new_blip, 0.6)
                    blips[player] = new_blip
                end
            end
        end
        Wait(sleep)
    end
end)

--------------------------------------------------------------------

function InGungame()
    return in_gungame
end

--------------------------------------------------------------------