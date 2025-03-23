ESX = exports["es_extended"]:getSharedObject()

local interactedNPCs = {}
local simCardInfo
local kontakter
local cantSell = true
local visDescription

function UsePhoneItem(data)
    if data ~= 'skipAnim' then
        local result = lib.progressCircle({
            duration = 1100,
            label = 'Åbner Mobil...',
            useWhileDead = false,
            canCancel = true,
            disable = {
                move = true,
            },
            anim = {
                dict = 'anim@amb@carmeet@take_photos@male_a@base',
                clip = 'base',
                cancel = true,
            },
            prop = {
                model = `prop_npc_phone_02`,
                pos = vec3(0.0, 0.0, 0.0),
                rot = vec3(0.0, 0.0, 0.0),
                bone = 28422
            },
        })
    end

    lib.callback('fh_drugphone:getSimCardInfo', false, function(simCardInfo)
        local Options = {}

        if simCardInfo then
            if simCardInfo.Stof == 'Default' or nil then
                local drugs = { 'Kokain', 'Heroin', 'Meth', 'Hash' }
                local drugOptions = {}
                for _, drug in ipairs(drugs) do
                    table.insert(drugOptions, { value = drug, label = drug })
                end

                local inputs = lib.inputDialog('Vælg Stoftype', {
                    { type = 'select', label = 'Stoftype', options = drugOptions }
                })

                if inputs then
                    lib.notify({
                        description = 'Du har valgt ' .. inputs[1] .. '!',
                        type = 'success'
                    })
                    TriggerServerEvent('fh_drugphone:setSimCardDrug', inputs[1])
                else
                    lib.notify({
                        description = 'Du skal vælge et stoftype!',
                        type = 'error'
                    })
                    TriggerEvent('srp_animation:EmoteCancel')
                    return
                end
            end

            if simCardInfo then
                kontakter   = simCardInfo.Kontakter
                currentDrug = simCardInfo.Stof

                if not kontakter then
                    kontakter = "Ingen kontakter endnu.."
                end

                Options[#Options + 1] = {
                    title = 'Simkort Status',
                    icon = 'fa-solid fa-address-book',
                    description = simCardInfo and ('Gemte Kontakter: ' .. ESX.Math.GroupDigits(kontakter)) or 'Indsæt et simkort for at se dine kontakter.',
                    progress = simCardInfo.Kontakter / Config.MaxContacts * 100,
                    colorScheme = 'blue',
                    iconColor = 'blue',
                    readOnly = true,
                }

                SimCardData = math.floor(simCardInfo.Kontakter / Config.DivideContacts)

                if SimCardData == 0 then
                    SimCardData = 1
                end

                Multi = math.random(SimCardData, SimCardData + 2)
                if Multi >= Config.MaxContacts / Config.DivideContacts then
                    Multi = Config.MaxContacts / Config.DivideContacts
                end

                if simCardInfo.Kontakter >= Config.MinContacts then
                    Options[#Options + 1] = {
                        title = 'Simkort Data',
                        icon = 'fa-solid fa-server',
                        description = 'Stoftype: ' .. simCardInfo.Stof .. '\nSalgs Variation: ' .. SimCardData .. ' - ' .. SimCardData + 2,
                        iconColor = 'blue',
                        readOnly = true,
                    }
                end

                Options[#Options + 1] = {
                    title = ' ',
                    disabled = true,
                }

                visDescription = "Du har ikke nok kontakter for at modtage opkald!"

                if simCardInfo.Kontakter >= Config.MinContacts then
                    cantSell = false
                    visDescription = 'Tryk for at aktivere opkald'
                end

                if not toggleStatus then
                    Options[#Options + 1] = {
                        title = 'Status: Deaktiveret',
                        icon = 'fa-solid fa-tower-cell',
                        disabled = cantSell,
                        iconColor = 'red',
                        iconAnimation = 'spinPulse',
                        description = visDescription,
                        onSelect = function()
                            toggleStatus = true
                            UsePhoneItem('skipAnim')
                            CallState = true
                            WaitForCall()
                        end,
                    }
                else
                    Options[#Options + 1] = {
                        title = 'Status: Aktiveret',
                        icon = 'fa-solid fa-tower-cell',
                        disabled = canSell,
                        iconColor = 'green',
                        iconAnimation = 'spinPulse',
                        description = 'Tryk for at deaktivere opkald',
                        onSelect = function()
                            toggleStatus = not toggleStatus
                            CallState = false
                            UsePhoneItem('skipAnim')
                        end,
                    }
                end
            else
                TriggerEvent('srp_animation:EmoteCancel')
                lib.notify({
                    description = 'Intet simkort er registreret i telefonen',
                    type = 'error',
                    duration = 10000,
                })
            end

            lib.registerContext({
                id = 'phoneMenu',
                title = 'Krypteret Mobil',
                onExit = function()
                    TriggerEvent('srp_animation:EmoteCancel')
                end,
                options = Options
            })

            if simCardInfo then
                lib.showContext('phoneMenu')
            end
        else
            TriggerEvent('srp_animation:EmoteCancel')
            lib.notify({
                description = 'Intet simkort er registreret i telefonen',
                type = 'error',
                duration = 10000,
            })
        end
    end)
end

exports("UsePhoneItem", UsePhoneItem)

RegisterNetEvent('fh_drugphone:InsertSimcard', function(slot)
    ExecuteCommand("e jreadmessages")
    local result = lib.progressCircle({
        duration = 6200,
        label = 'Sætter SIM i telefon...',
        position = 'middle',
        useWhileDead = false,
        canCancel = false,
    })
    ClearPedTasks(PlayerPedId())
    TriggerServerEvent('transferSimCardMetadata', slot)
end)

RegisterNetEvent('fh_drugphone:RemoveSimcard', function(slot)
    ExecuteCommand("e jreadmessages")
    local result = lib.progressCircle({
        duration = 6200,
        label = 'Fjerner SIM fra telefon...',
        position = 'middle',
        useWhileDead = false,
        canCancel = false,
    })
    ClearPedTasks(PlayerPedId())
    TriggerServerEvent('fh_drugphone:removeSimCard', slot)
end)

local isHandlingCustomer = false
local selectedLocation = nil

local currentNPC

function spawnNPCAtLocation(location)
    local playerPed = PlayerPedId()

    Citizen.CreateThread(function()
        local spawned = false
        while not spawned do
            Citizen.Wait(5000)

            local playerCoords = GetEntityCoords(playerPed)
            local distance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, location.x, location.y, location.z, true)

            if distance <= 75 then
                local modelName = Config.Models[math.random(#Config.Models)]
                local modelHash = GetHashKey(modelName)

                RequestModel(modelHash)
                while not HasModelLoaded(modelHash) do
                    Citizen.Wait(1)
                end

                SpawnPed(modelHash, location, location.w, pedType, function(ped)
                    SetEntityVisible(ped, true)
                    SetEntityAsMissionEntity(ped)
                    TaskStandStill(ped, -1)
                    SetEntityInvincible(ped, true)
                    FreezeEntityPosition(ped, true)

                    SetBlockingOfNonTemporaryEvents(ped, true)
                    SetEntityCanBeDamaged(ped, false)
                    TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_SMOKING', 0, true)

                    currentNPC = ped
                    SetupNPC(modelHash)
                end)

                SetModelAsNoLongerNeeded(modelHash)
                spawned = true
            end
        end
    end)
end

function SetupNPC(model)
    local options = {
        icon = "fa-solid fa-hand-holding-heart",
        label = "Aflever et eller flere produkter",
        onSelect = function(data)
            local npcPosition = vector3(table.unpack(GetEntityCoords(data.entity)))
            local playerPosition = vector3(table.unpack(GetEntityCoords(PlayerPedId())))
            local distance = #(playerPosition - npcPosition)

            if distance < 5 then
                interactWithNPC(data.entity, currentDrug, model, options, vector3(table.unpack(GetEntityCoords(data.entity))))
            end
        end,
        canInteract = function()
            return not fatsvag
        end,
    }

    exports.ox_target:addModel(model, options)
end

function interactWithNPC(npc, currentDrug, model, options, coords)
    if fatsvag then
        return
    end
    
    Options = {}

    Options[#Options + 1] = {
        title = 'Sælg Produktet!',
        icon = 'fa-solid fa-file-contract',
        description = 'Tryk for at sælge dit stof produkt!',
        onSelect = function()
            ESX.TriggerServerCallback('fh_drugphone:interactWithNPC', function(cb)
                if cb[1] then
                    fatsvag = true
                    exports.ox_target:removeModel(model, options)
                    RemoveBlip(NPCSpawn)

                    local playerPed = PlayerPedId()
                    local animDict = "mp_ped_interaction"
                    RequestAnimDict(animDict)
                    while not HasAnimDictLoaded(animDict) do
                        Citizen.Wait(50)
                    end

                    ClearPedTasksImmediately(npc)

                    Wait(1000)

                    local scene = NetworkCreateSynchronisedScene(GetEntityCoords(npc), GetEntityRotation(npc), 2, false, false, 1065353216, 0, 0.8)
                    NetworkAddPedToSynchronisedScene(npc, scene, animDict, 'hugs_guy_a', 1.5, -4.0, 1, 16, 1148846080, 0)
                    NetworkAddPedToSynchronisedScene(playerPed, scene, animDict, 'hugs_guy_b', 1.5, -4.0, 1, 16, 1148846080, 0)
                    NetworkStartSynchronisedScene(scene)

                    lib.notify({
                        description = 'Handling gik igennem!',
                        type = 'success',
                        duration = 10000,
                    })

                    PlayPedAmbientSpeechWithVoiceNative(npc, "GENERIC_THANKS", "MP_M_SHOPKEEP_01_PAKISTANI_MINI_01", "SPEECH_PARAMS_FORCE", 1)

                    Wait(5000)

                    FreezeEntityPosition(npc, false)
                    TaskWanderStandard(npc, 10.0, -1)

                    RemoveAnimDict(animDict)
                    selectedLocation = nil
                    isHandlingCustomer = false
                    fatsvag = nil
                    hasCustomer = not hasCustomer
                else
                    lib.notify({
                        description = 'Du har ikke det aftale antal stoffer med til mig!',
                        type = 'error',
                        duration = 10000,
                    })
                    toggleStatus = not toggleStatus
                    isHandlingCustomer = false
                    hasCustomer = not hasCustomer
                end
            end, currentDrug, coords)
        end,
    }

    lib.registerContext({
        id = 'phoneMenu_drugSell',
        title = 'Indgå Aftale',
        options = Options,
    })

    lib.showContext('phoneMenu_drugSell')
end

WaitForCall = function()
    local callActive = true
    while callActive do 
        Citizen.Wait(1500)

        if CallState == false then
            if isHandlingCustomer then
                BusyspinnerOff()
                isHandlingCustomer = false
            end

            callActive = false
        elseif CallState and not isHandlingCustomer and not hasCustomer then
            isHandlingCustomer = true

            BeginTextCommandBusyspinnerOn("STRING")
            AddTextComponentSubstringPlayerName("Venter på et opkald...")
            EndTextCommandBusyspinnerOn(4)

            local totalTime = 0
            local waitTime = math.random(Config.MinSec * 1000, Config.MaxSec * 1000)

            while totalTime < waitTime do
                Citizen.Wait(1000)
                totalTime = totalTime + 1000
                if CallState == false then
                    BusyspinnerOff()
                    isHandlingCustomer = false
                    callActive = false
                    break
                end
            end

            if CallState then
                if not hasCustomer then
                    hasCustomer = true

                    lib.notify({
                        description = 'En kunde har brug for dit produkt, tag til waypointet og sælg produktet!',
                        type = 'success',
                        duration = 10000,
                    })

                    BusyspinnerOff()

                    ExecuteCommand("e phonecall")
                    Citizen.Wait(1200)

                    selectedLocation = Config.Locations[math.random(#Config.Locations)]
                    spawnNPCAtLocation(selectedLocation)

                    NPCSpawn = AddBlipForCoord(selectedLocation.x, selectedLocation.y, selectedLocation.z)
                    SetBlipSprite(NPCSpawn, 514)
                    SetBlipColour(NPCSpawn, 1)
                    SetBlipDisplay(NPCSpawn, 2)
                    SetBlipScale(NPCSpawn, 1.0)
                    SetBlipAsShortRange(NPCSpawn, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString('Narkotika Handel')
                    EndTextCommandSetBlipName(NPCSpawn)
                    SetBlipRoute(NPCSpawn, true)

                    ClearPedTasks(PlayerPedId())
                    TriggerEvent('srp_animation:EmoteCancel')
                else
                    lib.notify({
                        description = 'Du har allerede en kunde!',
                        type = 'error',
                        duration = 10000,
                    })
                end
            end
        end
    end
end
