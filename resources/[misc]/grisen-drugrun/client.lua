local ESX = exports['es_extended']:getSharedObject()
local isDrugRunActive = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        
        for _, npcData in pairs(Config.NPCs) do
            local npcCoords = npcData.currentCoords
            if npcCoords and #(coords - npcCoords) < 5.0 then
                ESX.ShowHelpNotification('Tryk ~INPUT_CONTEXT~ for at starte et drugrun')
                if IsControlJustReleased(0, 38) then
                    lib.callback('grisen_drugrun:startRun', false, function(drugType)
                        if drugType then
                            StartDrugRun(drugType)
                        end
                    end, npcData.type)
                end
            end
        end
    end
end)

function StartDrugRun(drugType)
    if isDrugRunActive then return end
    isDrugRunActive = true

    lib.callback('grisen_drugrun:getRunLocation', false, function(location)
        local boxCoords = location.coords
        local box = CreateObject(GetHashKey('prop_boxpile_01a'), boxCoords.x, boxCoords.y, boxCoords.z - 1.0, true, true, true)
        PlaceObjectOnGroundProperly(box)
        FreezeEntityPosition(box, true)

        local guards = {}
        for i = 1, 6 do
            local guardCoords = vector3(boxCoords.x + math.random(-5, 5), boxCoords.y + math.random(-5, 5), boxCoords.z)
            local guard = CreatePed(4, GetHashKey('g_m_y_mexgoon_01'), guardCoords.x, guardCoords.y, guardCoords.z, 0.0, true, true)
            GiveWeaponToPed(guard, GetHashKey('WEAPON_ASSAULTRIFLE'), 9999, false, true)
            SetPedAsEnemy(guard, true)
            TaskCombatPed(guard, PlayerPedId(), 0, 16)
            table.insert(guards, guard)
        end

        while true do
            Citizen.Wait(0)
            local playerCoords = GetEntityCoords(PlayerPedId())
            if #(playerCoords - boxCoords) < 2.0 then
                ESX.ShowHelpNotification('Tryk ~INPUT_CONTEXT~ for at samle kassen op')
                if IsControlJustReleased(0, 38) then
                    local allDead = true
                    for _, guard in ipairs(guards) do
                        if not IsEntityDead(guard) then
                            allDead = false
                            break
                        end
                    end
                    if allDead then
                        DeleteObject(box)
                        for _, guard in ipairs(guards) do
                            DeleteEntity(guard)
                        end
                        lib.callback('grisen_drugrun:giveItems', false, function()
                            isDrugRunActive = false
                        end, drugType)
                        break
                    else
                        ESX.ShowNotification('Dræb alle vagter først!')
                    end
                end
            end
        end
    end, drugType)
end

Citizen.CreateThread(function()
    lib.callback.await('grisen_drugrun:getNPCLocations', nil, function(locations)
        for drugType, coords in pairs(locations) do
            Config.NPCs[drugType].currentCoords = coords
            RequestModel(GetHashKey('a_m_m_soucent_01'))
            while not HasModelLoaded(GetHashKey('a_m_m_soucent_01')) do
                Citizen.Wait(100)
            end
            local npc = CreatePed(4, GetHashKey('a_m_m_soucent_01'), coords.x, coords.y, coords.z, 0.0, false, true)
            FreezeEntityPosition(npc, true)
            SetEntityInvincible(npc, true)
            SetBlockingOfNonTemporaryEvents(npc, true)
            Config.NPCs[drugType].ped = npc
        end
    end)
end)