---------------------------------
-- Indstillinger / variabler
---------------------------------
local KOTH = { TeamID = 0 }      -- Sørg for, at vi har en tabel til KOTH-data
local cayo = false               -- Om spilleren er på Cayo (bruges i zone-check)
local staffService = false       -- Om du er staff og vil se alle i 180m
local bucketAllowed = false      -- Om spilleren er i routing bucket 19567

---------------------------------
-- Team-farver
---------------------------------
local teams = {
    [1] = 28,  -- Rød
    [2] = 40,  -- Blå
    [3] = 18   -- Grøn
}

---------------------------------
-- Callback til at tjekke bucket
-- (Kører hvert sekund for at holde bucketAllowed opdateret)
---------------------------------
Citizen.CreateThread(function()
    while true do
        local result = lib.callback.await("KOTH:CheckBucket", 100)
        bucketAllowed = result
        Citizen.Wait(1000)
    end
end)

---------------------------------
-- /checkbucket (test-kommando)
---------------------------------
RegisterCommand('checkbucket', function()
    local result = lib.callback.await("KOTH:CheckBucket", 100)
    print("Er jeg i bucket 19567?", result)
end)

---------------------------------
-- Net event: Opdater hold-info
-- (Serveren kalder "UpdateInfoClient" med et table, der fx indeholder:
--  InfoTeam[1] = {members = {...}}, InfoTeam[2] = {...}, osv.)
---------------------------------
InfoTeam = {}

RegisterNetEvent("UpdateInfoClient")
AddEventHandler("UpdateInfoClient", function(team)
    -- Debug print for at se, om data kommer ind
    -- print("Fik opdateret InfoTeam:", json.encode(team))
    InfoTeam = team
end)

---------------------------------
-- Net event: Spilleren joiner hold (server -> client)
-- Sætter KOTH.TeamID baseret på farve
---------------------------------
RegisterNetEvent("Koth-Team")
AddEventHandler("Koth-Team", function(teamColor)
    if teamColor == "Rouge" then
        KOTH.TeamID = 1
    elseif teamColor == "Bleu" then
        KOTH.TeamID = 2
    elseif teamColor == "Vert" then
        KOTH.TeamID = 3
    else
        KOTH.TeamID = 0  -- Ingen hold
    end
end)

---------------------------------
-- Køretøjs-blip opsætning
---------------------------------
local vehList = {
    blips = {
        ['car'] = 225,
        ['motor'] = 348,
        ['boat'] = 427,
        ['heli'] = 422,
        ['plane'] = 423,
        ['cycle'] = 559,
        ['tank'] = 421,
        ['dune'] = 561,
        ['truck'] = 67,
        ['sport'] = 596,
        ['techLight'] = 426,
        ['apc'] = 558,
        ['techFull'] = 601,
        ['attack'] = 576,
        ['vtol'] = 589
    },
    models = {
        [GetHashKey('rhino')] = 'tank',
        [GetHashKey('dune3')] = 'dune',
        [GetHashKey('barracks')] = 'truck',
        [GetHashKey('dukes2')] = 'sport',
        [GetHashKey('technical')] = 'techLight',
        [GetHashKey('apc')] = 'apc',
        [GetHashKey('barrage')] = 'techFull',
        [GetHashKey('tampa3')] = 'sport',
        [GetHashKey('hunter')] = 'attack',
        [GetHashKey('avenger')] = 'vtol',
        [GetHashKey('OSPREY')] = 'vtol'
    }
}

function table.contains(tbl, element)
    for k,_ in pairs(tbl) do
        if k == element then
            return true
        end
    end
    return false
end

function checkVehType(class, model)
    if table.contains(vehList.models, model) then
        return vehList.blips[vehList.models[model]]
    elseif class >= 1 and class <= 21 and class ~= 8 and class ~= 14 and class ~= 15 and class ~= 16 and class ~= 13 then
        return vehList.blips['car']
    elseif class == 8 then
        return vehList.blips['motor']
    elseif class == 14 then
        return vehList.blips['boat']
    elseif class == 15 then
        return vehList.blips['heli']
    elseif class == 16 then
        return vehList.blips['plane']
    elseif class == 13 then
        return vehList.blips['cycle']
    else
        return nil
    end
end

---------------------------------
-- Nametags & blips
---------------------------------
local playerBlips = {}
local playerTags  = {}
local gamerTags   = {}  -- brugt i staffService-delen

function updatePlayerNames()
    -- Kør funktionen igen med SetTimeout (nærmest en "loop" i baggrunden)
    SetTimeout(0, updatePlayerNames)
    
    -- 1) Tjek om vi er i bucket 19567 OG på øen (cayo)
    if not (bucketAllowed) then
        -- Fjern evt. eksisterende blips og tags, hvis vi ikke må se dem
        for _, blip in pairs(playerBlips) do
            RemoveBlip(blip)
        end
        playerBlips = {}
        for _, tag in pairs(playerTags) do
            SetMpGamerTagVisibility(tag, 0, false)
        end
        playerTags = {}
        return
    end

    -- 2) Tjek om KOTH.TeamID er sat til noget gyldigt (1,2,3)
    if KOTH.TeamID == 0 or KOTH.TeamID == -1 then
        return 
    end

    -- Deaktiver dispatch
    for z = 1, 12 do
        EnableDispatchService(z, false)
    end
    
    local localCoords = GetEntityCoords(PlayerPedId())
    local memberList = {}

    -- 3) Hent liste over hvem vi skal vise
    if staffService then
        -- Hvis staff, viser du oftest alle i området (GetActivePlayers)
        memberList = GetActivePlayers()
    else
        -- Hvis du er på et hold, hentes InfoTeam[KOTH.TeamID].members
        if InfoTeam[KOTH.TeamID] then
            memberList = InfoTeam[KOTH.TeamID].members or {}
        end
    end

    -- 4) Staff-service viser "frit" alle nametags i 180 meters radius
    if staffService then
        for _, v in pairs(memberList) do
            local otherPed = (type(v) == "number") and GetPlayerPed(v) or nil
            local otherId  = (type(v) == "number") and v or nil
            
            if otherPed and otherPed ~= PlayerPedId() then
                local dist = #(localCoords - GetEntityCoords(otherPed))
                if dist < 180.0 then
                    -- Opret gamerTag hvis det ikke allerede findes
                    if not gamerTags[otherId] then
                        gamerTags[otherId] = CreateFakeMpGamerTag(
                            otherPed, 
                            "["..GetPlayerServerId(otherId).."] "..GetPlayerName(otherId).."("..GetEntityHealth(otherPed)..")", 
                            false, false, "", 0
                        )
                    end
                    -- Opdater navnet + talende status
                    SetMpGamerTagHealthBarColour(gamerTags[otherId], 0)
                    SetMpGamerTagName(gamerTags[otherId], 
                        "["..GetPlayerServerId(otherId).."] "..GetPlayerName(otherId).."("..GetEntityHealth(otherPed)..")"
                    )
                    if NetworkIsPlayerTalking(otherId) then
                        SetMpGamerTagVisibility(gamerTags[otherId], 16, true)
                    else
                        SetMpGamerTagVisibility(gamerTags[otherId], 16, false)
                    end
                else
                    -- Er spilleren udenfor 180m? Fjern tag
                    if gamerTags[otherId] then
                        RemoveMpGamerTag(gamerTags[otherId])
                        gamerTags[otherId] = nil
                    end
                end
            end
        end
    else
        -- 5) Hvis IKKE staffService: Vis kun nametags for medlemmer af dit hold
        for _, playerID in pairs(memberList) do
            local serverID = playerID.id
            local player   = GetPlayerFromServerId(serverID)
            if player and player ~= -1 then
                local ped1   = GetPlayerPed(player)
                local blip   = GetBlipFromEntity(ped1)

                -- Opret selve "gamerTag" (headId)
                local headId = CreateFakeMpGamerTag(
                    ped1, 
                    "["..GetPlayerServerId(player).."] - "..GetPlayerName(player).."", 
                    false, false, '', false
                )
                -- Justér alpha og visibility
                SetMpGamerTagAlpha(headId, 0, 255)
                SetMpGamerTagAlpha(headId, 4, 255)
                SetMpGamerTagVisibility(headId, 0, true)
                SetMpGamerTagVisibility(headId, 4, NetworkIsPlayerTalking(player))
                
                -- Hvis spilleren taler, sæt farve til 211 (gul)
                if NetworkIsPlayerTalking(player) then
                    SetMpGamerTagColour(headId, 0, 211)
                    SetMpGamerTagColour(headId, 4, 211)
                else
                    -- Ellers brug holdets farve
                    SetMpGamerTagColour(headId, 0, teams[KOTH.TeamID])
                    SetMpGamerTagColour(headId, 4, teams[KOTH.TeamID])
                end

                -- Gem tag i vores playerTags-liste
                playerTags[serverID] = headId

                -- 6) Håndter blip
                if not DoesBlipExist(blip) then
                    blip = AddBlipForEntity(ped1)
                    playerBlips[serverID] = blip
                    SetBlipSprite(blip, 1)
                    ShowHeadingIndicatorOnBlip(blip, true)
                else
                    -- Tjek om spilleren er i køretøj, død mv.
                    local veh       = GetVehiclePedIsIn(ped1, false)
                    local blipSprite = GetBlipSprite(blip)

                    if IsEntityDead(ped1) then
                        if blipSprite ~= 274 then
                            SetBlipSprite(blip, 274)
                            ShowHeadingIndicatorOnBlip(blip, true)
                            HideNumberOnBlip(blip)
                        end
                    elseif veh then
                        local vehClass = GetVehicleClass(veh)
                        local vehModel = GetEntityModel(veh)
                        local blipSNum = checkVehType(vehClass, vehModel)
                        if blipSNum then
                            if blipSprite ~= blipSNum then
                                SetBlipSprite(blip, blipSNum)
                                ShowHeadingIndicatorOnBlip(blip, true)
                            end
                        else
                            if blipSprite ~= 1 then
                                SetBlipSprite(blip, 1)
                                ShowHeadingIndicatorOnBlip(blip, true)
                                HideNumberOnBlip(blip)
                            end
                        end

                        local passengers = GetVehicleNumberOfPassengers(veh)
                        if passengers then
                            if not IsVehicleSeatFree(veh, -1) then
                                passengers = passengers + 1
                            end
                            if IsPedInVehicle(ped1, veh, false) then
                                ShowNumberOnBlip(blip, passengers)
                            else
                                HideNumberOnBlip(blip)
                            end
                        else
                            HideNumberOnBlip(blip)
                        end
                    else
                        HideNumberOnBlip(blip)
                        if blipSprite ~= 1 then
                            SetBlipSprite(blip, 1)
                            ShowHeadingIndicatorOnBlip(blip, true)
                            HideNumberOnBlip(blip)
                        end
                    end

                    SetBlipRotation(blip, math.ceil(GetEntityHeading(veh)))
                    SetBlipNameToPlayerName(blip, player)
                    SetBlipScale(blip, 0.8)
                    SetBlipAlpha(blip, 255)
                end
            end
        end
    end
end

---------------------------------
-- Start "loop" for updatePlayerNames
---------------------------------
SetTimeout(0, updatePlayerNames)

---------------------------------
-- Ryd blips/gamertags ved resource stop
---------------------------------
AddEventHandler('onResourceStop', function(name)
    if name == GetCurrentResourceName() then
        TriggerEvent("KOTH:ClearAllBlips")
    end
end)

---------------------------------
-- ClearAllBlips-event
---------------------------------
RegisterNetEvent("KOTH:ClearAllBlips")
AddEventHandler("KOTH:ClearAllBlips", function()
    for _,blip in pairs(playerBlips) do
        RemoveBlip(blip)
    end
    playerBlips = {}

    for _,tag in pairs(playerTags) do
        SetMpGamerTagVisibility(tag, 0, false)
    end
    playerTags = {}
end)

---------------------------------
-- ClearPlayerBlip-event
---------------------------------
RegisterNetEvent("KOTH:ClearPlayerBlip")
AddEventHandler("KOTH:ClearPlayerBlip", function(serverID)
    if playerBlips[serverID] then
        RemoveBlip(playerBlips[serverID])
        playerBlips[serverID] = nil
    end

    if playerTags[serverID] then
        SetMpGamerTagVisibility(playerTags[serverID], 0, false)
        playerTags[serverID] = nil
    end
end)

---------------------------------
-- Ryd gamerTags hver 15. sekund
-- (for at undgå spøgelses-tags)
---------------------------------
Citizen.CreateThread(function()
    while true do
        Wait(15000)
        for _, v in pairs(gamerTags) do
            RemoveMpGamerTag(v)
        end
        gamerTags = {}
    end
end)

---------------------------------
-- Eksempel: Deaktivér blind fire
---------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local ped = PlayerPedId()
        if IsPedInCover(ped, 1) and not IsPedAimingFromCover(ped, 1) then 
            DisableControlAction(2, 24, true) 
            DisableControlAction(2, 142, true)
            DisableControlAction(2, 257, true)
        end        
    end
end)

---------------------------------
-- Eksempel: Skru ned for weapon damage
---------------------------------
Citizen.CreateThread(function()
    while true do
        N_0x4757f00bc6323cfe(-1553120962, 0.0) 
        Wait(0)
    end
end)
