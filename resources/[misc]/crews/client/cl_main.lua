crew, invites = nil, nil
crewNames, crewTags = {}, {}
crewBlipsNear, crewBlipsFar, currentTags = {}, {}, {}

myIdentifier = nil

settings = {
    showTags = false
}

----------------------------------------------------------------

-- if CONFIG.COMMAND then
--     RegisterCommand(CONFIG.COMMAND, function()
--         crewMenu.openMainMenu()
--     end)
-- else
--     error('Your CONFIG.COMMAND is not configured properly.')
-- end

RegisterNetEvent('crewmenu')
AddEventHandler('crewmenu', function()
    crewMenu.openMainMenu()
end)

-- local kothZone = {
--     center = vector3(4375.7637, -4453.5078, 5.3313),
--     text = vector3(4375.7637, -4453.5078, 10.3313),
--     radius = 15.6382
-- }

-- local currentControllingCrew = nil
-- local controlTime = 0
-- local controlThreshold = 60

-- local allCrewData = {}

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(2000)
--         local refreshedData = lib.callback.await('crews:refreshData', 5000)
--         if refreshedData then
--             allCrewData = refreshedData
--         end
--     end
-- end)

-- function GetPlayerCrew(playerId)
--     if playerId == PlayerId() then
--         if crew and crew.owner then
--             return crew.owner
--         end
--     end
--     return nil
-- end

-- function GetCrewName(crewId)
--     if crewId then
--         if allCrewData and allCrewData[crewId] and allCrewData[crewId].label then
--             return allCrewData[crewId].label
--         elseif crew and crew.label then
--             return crew.label
--         else
--             return "Ukendt Crew"
--         end
--     end
--     return "Ukendt Crew"
-- end

-- local function CanAccessKOTH()
--     if crew and crew.owner then
--         return true
--     else
--         return false
--     end
-- end

-- local function DrawText3D(x, y, z, text)
--     local onScreen, _x, _y = World3dToScreen2d(x, y, z)
--     if onScreen then
--         SetTextScale(0.35, 0.35)
--         SetTextFont(4)
--         SetTextProportional(1)
--         SetTextColour(255, 255, 255, 215)
--         SetTextEntry("STRING")
--         SetTextCentre(1)
--         AddTextComponentString(text)
--         DrawText(_x, _y)
--     end
-- end

-- local zoneCoords = vector3(4367.8882, -4447.2734, 5.5422)
-- local zoneRadius = 15.0
-- local currentControllingCrew = nil
-- local controlTime = 0
-- local lastControlTime = GetGameTimer()

-- local kothZone = {
--     center = zoneCoords,
--     radius = zoneRadius,
--     text = vector3(4367.8882, -4447.2734, 10.5422) -- placeringen af 3D-teksten
-- }

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(1000)
--         if GetGameTimer() < (teleportCooldown or 0) then
--             currentControllingCrew = nil
--             controlTime = 0
--             goto continueLoop
--         end

--         local playersInZone = {}
--         for _, playerId in ipairs(GetActivePlayers()) do
--             local ped = GetPlayerPed(playerId)
--             local pos = GetEntityCoords(ped)
--             local dist = #(pos - zoneCoords)
--             if dist <= zoneRadius then
--                 local crewId = GetPlayerCrew(playerId)
--                 if crewId then
--                     if not playersInZone[crewId] then
--                         playersInZone[crewId] = 0
--                     end
--                     playersInZone[crewId] = playersInZone[crewId] + 1
--                 end
--             end
--         end

--         local maxCount = 0
--         local leaderCrew = nil
--         local tie = false
--         for crewId, count in pairs(playersInZone) do
--             if count > maxCount then
--                 maxCount = count
--                 leaderCrew = crewId
--                 tie = false
--             elseif count == maxCount and count > 0 then
--                 tie = true
--             end
--         end

--         local newClaimCrew = nil
--         if tie then
--             if currentControllingCrew and playersInZone[currentControllingCrew] == maxCount then
--                 newClaimCrew = currentControllingCrew
--             else
--                 newClaimCrew = nil
--             end
--         else
--             newClaimCrew = leaderCrew
--         end

--         if newClaimCrew ~= currentControllingCrew then
--             currentControllingCrew = newClaimCrew
--             lastControlTime = GetGameTimer()
--             if currentControllingCrew then
--                 TriggerServerEvent('koth:claimed', GetCrewName(currentControllingCrew))
--                 TriggerServerEvent('koth:awardPoints', currentControllingCrew, 1)
--             else
--                 TriggerServerEvent('koth:claimed', 'Ingen')
--             end
--         else
--             controlTime = math.floor((GetGameTimer() - lastControlTime) / 1000)
--         end

--         if currentControllingCrew and controlTime >= controlThreshold then
--             for _, playerId in ipairs(GetActivePlayers()) do
--                 local ped = GetPlayerPed(playerId)
--                 local pos = GetEntityCoords(ped)
--                 local dist = #(pos - zoneCoords)
--                 if dist <= 450 then
--                     SetEntityCoords(ped, 343.5642, -1421.0951, 76.1741)
--                     SetEntityHeading(ped, 136.0984)
--                 end
--             end
--             TriggerServerEvent('koth:finished', GetCrewName(currentControllingCrew))
--             currentControllingCrew = nil
--             controlTime = 0
--             lastControlTime = GetGameTimer()
--             teleportCooldown = GetGameTimer() + 5000
--         end

--         ::continueLoop::
--     end
-- end)

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(0)
--         DrawMarker(1, kothZone.center.x, kothZone.center.y, kothZone.center.z - 1.0,
--             0, 0, 0, 0, 0, 0,
--             kothZone.radius * 2, kothZone.radius * 2, 1.0, 255, 0, 0, 100, false, true, 2, false, nil, nil, false)
--         local controllingCrewName = "Ingen"
--         if currentControllingCrew then
--             controllingCrewName = GetCrewName(currentControllingCrew)
--         end
--         local pos = GetEntityCoords(PlayerPedId())
--         local dist = #(pos - kothZone.center)
--         if dist <= 300 then
--             if controllingCrewName ~= 'Ingen' then
--                 DrawText3D(kothZone.text.x, kothZone.text.y, kothZone.text.z + 1.0,
--                     "Kontrol: " .. controllingCrewName .. " (" .. controlTime .. "s)")
--             else
--                 DrawText3D(kothZone.text.x, kothZone.text.y, kothZone.text.z + 1.0,
--                     "Kontrol: " .. controllingCrewName)
--             end
--         end
--     end
-- end)

----------------------------------------------------------------

RegisterNetEvent('crews:setCrew', function(crewData, newInvites, names, tags)
    crew = crewData
    invites = newInvites
    crewNames = names
    crewTags = tags
end)

RegisterNetEvent('crews:updateCrew', function(data)
    crew = data
end)

RegisterNetEvent('crews:updateInvites', function(data)
    invites = data
end)

RegisterNetEvent('crews:updateNames', function(data)
    crewNames = data
end)

RegisterNetEvent('crews:updateTags', function(data)
    crewTags = data
end)

RegisterNetEvent('crews:removePlayer', function(identifier)
    if crew then
        utils.deleteBlip(identifier)
        utils.deleteTag(identifier)
    end
end)

RegisterNetEvent('crews:playerLeft', function(owner)
    if crew and crew.owner == owner then
        utils.deleteBlip()
        utils.deleteTag()
    end
end)

RegisterNetEvent('crews:notify', function(text, _type)
    notify(text, _type)
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end
    playerSetup()
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end
    utils.deleteBlip()
    utils.deleteTag()
    DisplayPlayerNameTagsOnBlips(false)
end)

----------------------------------------------------------------

RegisterCommand('crewTags', function()
    settings.showTags = not settings.showTags
    notify(_L('toggle_tags', {settings.showTags and _L('tags_enabled') or _L('tags_disabled')}), 'inform')
end)

function startLoop()
    CreateThread(function()
        while myIdentifier ~= nil do
            Wait(1000)
            if crew then
                for identifier,_ in pairs(crew.data) do
                    local players = lib.callback.await('crews:blipUpdate', false)
                    if players then
                        for _, obj in pairs(players) do
                            local blipPlayer = obj.source
                            local playerPed = NetworkDoesEntityExistWithNetworkId(obj.ped) and NetworkGetEntityFromNetworkId(obj.ped) or nil
                            local targetIdentifier, name, coords = obj.identifier, obj.name, obj.coords
                            if not DoesEntityExist(playerPed) then goto continue end
                            if identifier == targetIdentifier then
                                if targetIdentifier ~= myIdentifier then
                                    if CONFIG.ENABLE_BLIPS then
                                        if #(GetEntityCoords(cache.ped) - coords) < 100.0 then
                                            if crewBlipsNear[identifier] == nil then
                                                if crewBlipsFar[identifier] then
                                                    RemoveBlip(crewBlipsFar[identifier])
                                                    crewBlipsFar[identifier] = nil
                                                end
                
                                                local crewBlip = AddBlipForEntity(playerPed)
                                                utils.setBlip(crewBlip)
                                                SetBlipShowCone(crewBlip, true)
                                                crewBlipsNear[identifier] = crewBlip
                                                
                                                local blipId = ('CREW_BLIP_%s'):format(blipPlayer)
                                                DisplayPlayerNameTagsOnBlips(true)
                                                AddTextEntry(blipId, name)
                                                BeginTextCommandSetBlipName(blipId)
                                                EndTextCommandSetBlipName(crewBlip)
                                            end
                                        else
                                            if crewBlipsFar[targetIdentifier] then
                                                if DoesBlipExist(crewBlipsFar[targetIdentifier]) then
                                                    local crewBlip = crewBlipsFar[targetIdentifier]
                                                    SetBlipCoords(crewBlip, coords.xyz)
                                                end
                                            else
                                                if crewBlipsNear[targetIdentifier] then
                                                    RemoveBlip(crewBlipsNear[targetIdentifier])
                                                    crewBlipsNear[targetIdentifier] = nil
                                                end
                
                                                local crewBlip = AddBlipForCoord(coords.xyz)
                                                utils.setBlip(crewBlip)
                                                crewBlipsFar[targetIdentifier] = crewBlip
                                                
                                                DisplayPlayerNameTagsOnBlips(true)
                                                AddTextEntry(('CREW_BLIP_%s'):format(blipPlayer), name)
                                                BeginTextCommandSetBlipName(('CREW_BLIP_%s'):format(blipPlayer))
                                                EndTextCommandSetBlipName(crewBlip)
                                            end
                                        end
                                    end
            
                                    if CONFIG.ENABLE_TAGS then
                                        if settings.showTags then
                                            local currentTag = nil

                                            if CONFIG.MAX_TAG_DISTANCE then
                                                if #(GetEntityCoords(cache.ped) - coords) < CONFIG.MAX_TAG_DISTANCE then
                                                    currentTag = utils.createTag(playerPed, name)
                                                else
                                                    utils.deleteTag(identifier)
                                                end
                                            else
                                                currentTag = utils.createTag(playerPed, name)
                                            end
                                            currentTags[identifier] = currentTag
                                        else
                                            utils.deleteTag(identifier)
                                        end
                                    end
                                end
                            end
                            ::continue::
                        end
                    end
                end
            else
                utils.deleteTag()
                utils.deleteBlip()
            end
        end
    end)
end

AddTextEntry("BLIP_OTHPLYR", 'CREW')

----------------------------------------------------------------

exports('ownsCrew', function()
    if crew and crew.owner == myIdentifier then
        return true
    end

    return false
end)

exports('isInCrew', function()
    if crew and crew.data[myIdentifier] then
        return true
    end

    return false
end)

exports('getCrew', function()
    if crew then
        return crew
    end

    return {}
end)

exports('getCrewOwner', function()
    if crew and crew.owner then
        return crew.owner
    end

    return nil
end)

exports('getCrewName', function()
    if crew and crew.label then
        return crew.label
    end

    return nil
end)

exports('getCrewTag', function()
    if crew and crew.tag then
        return crew.tag
    end

    return nil
end)

exports('getPlayerRank', function()
    if crew and crew.data[myIdentifier] then
        return shared.getRankLabel(crew.data[myIdentifier].Rank)
    end

    return nil
end)