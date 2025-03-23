local cooldown = {
    atm = 0,
    robbery = 0,
}

local function formatCooldown(cooldown)
    local seconds = cooldown % 60
    local minutes = math.floor(cooldown / 60) % 60
    local hours = math.floor(cooldown / (60 * 60))

    local parts = {}

    if hours > 0 then
        table.insert(parts, hours .. (hours == 1 and " time" or " timer"))
    end
    if minutes > 0 then
        table.insert(parts, minutes .. (minutes == 1 and " minut" or " minutter"))
    end
    if seconds > 0 then
        table.insert(parts, seconds .. (seconds == 1 and " sekund" or " sekunder"))
    end

    return table.concat(parts, " & ")
end

SpawnPed = function(hash, coords, heading, pedType, cb)
    local start = GetGameTimer()
    RequestModel(hash)
    while not HasModelLoaded(hash) and GetGameTimer() - start < 30000 do
        Wait(0);
    end

    if not HasModelLoaded(hash) then
        return
    end

    local ped = CreatePed(pedType, hash, coords.x, coords.y, coords.z , heading, true, true)
    SetEntityVisible(ped, true)
    SetEntityAsMissionEntity(ped)
    TaskStandStill(ped, -1)
    SetEntityInvincible(ped, true)
    
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityCanBeDamaged(ped, false)

    SetEntityInvincible(ped, true)
    start = GetGameTimer()
    while not DoesEntityExist(ped) and GetGameTimer() - start < 30000 do
        Wait(0);
    end

    if not DoesEntityExist(ped) then
        return
    end

    Citizen.Wait(500)
    FreezeEntityPosition(ped, true)
    SetEntityAsMissionEntity(ped, true, true)
    SetModelAsNoLongerNeeded(hash)

    if cb then
        cb(ped)
    end
end

function IsPlayerNearNPC(npc)
    local playerCoords = GetEntityCoords(PlayerPedId())
    local npcCoords = GetEntityCoords(npc)
    local distance = #(playerCoords - npcCoords)

    return distance < 3.0 
end

Chance = function(number)
    math.randomseed(GetGameTimer() + math.random(1, 99999))
    local random = math.random(1, 100)

    if random <= number then
        return true
    else
        return false
    end
end

function AddCooldown(cooldownType, zoneResult)
    cooldown[cooldownType] = zoneResult.coldown
    CreateThread(function()
        while cooldown do
            Wait(1000)
            cooldown[cooldownType] = cooldown[cooldownType] - 1
            if cooldown[cooldownType] <= 0 then cooldown[cooldownType] = 0 break end
        end
    end)
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

RegisterNetEvent('showDrugNoti')
AddEventHandler('showDrugNoti', function(coords, street, msg)
    if not ESX.PlayerData or not ESX.PlayerData.job or ESX.PlayerData.job.name ~= "police" then
        return
    end

    lib.notify({
        id = 'drug_notification',
        title = 'Narkotikaopkald (' .. street .. ')',
        description = msg,
        position = 'top-left',
        duration = 2500,
        style = {
            backgroundColor = '#141517',
            color = '#C1C2C5',
            ['.description'] = {
                color = '#909296'
            }
        },
        icon = 'tablets',
        iconColor = '#C53030'
    })

    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)

    SetBlipSprite(blip, 51)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.6)
    SetBlipColour(blip, 6)
    SetBlipAlpha(blip, 255)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("[* Aktivt Opkald] Narkotika")
    EndTextCommandSetBlipName(blip)

    Citizen.Wait(120000)

    RemoveBlip(blip)
end)

local function getPlayerZone(coords, game)
    for _, zone in ipairs(game) do
        if coords.y > zone.y_min.y and coords.y < zone.y_max.y then
            return zone
        end
    end

    return false
end

hackAtm = function(entity, coords)
    local start = lib.alertDialog({centered = true, header = "Hack pengeautomaten", content = "Er du sikker på at du ville hacke pengeautomaten?", cancel = true, labels = {cancel = "Nej", confirm = "Ja"}})

    if start ~= "confirm" then
        lib.notify({
            description = 'Helt fair, bangebuks!',
            type = 'error'
        })
        return
    end

    local data = exports['cd_dispatch']:GetPlayerInfo()
    local zoneResult = getPlayerZone(data.coords, Config.ATMGAME)
    local scully_emotemenu = exports.scully_emotemenu

    print(zoneResult.name, data.street, data.coords)

    if zoneResult == nil then
        lib.notify({
            description = 'Du er ikke indenfor rækkevidden (reportere gerne dette til dev)',
            type = 'error'
        })
        return
    end

    ESX.TriggerServerCallback('zf_robberies:RobATM', function(success)
        if not success then
            lib.notify({
                description = 'Du kan ikke hacke denne pengeautomat lige nu, prøv en anden!',
                type = 'error'
            })
            return
        end

        if cooldown and cooldown.atm > 0 then
            lib.notify({
                description = 'Du har desværre en nødkøling på ' .. formatCooldown(cooldown.atm),
                type = 'error'
            })
            return
        end

        ExecuteCommand("e texting")
        if lib.progressBar({duration = 2000, label = 'Begynder at hacke...', useWhileDead = false, canCancel = false}) then
            TriggerServerEvent('cd_dispatch:AddNotification', {
                job_table = zoneResult.jobs,
                coords = data.coords,
                title = '[P10] Pengeautomat adfærd',
                message = 'Mistænklig adfærd ved ' .. data.street .. ' pengeautomat',
                flash = 0,
                unique_id = data.unique_id,
                sound = 1,
                blip = {
                    sprite = 108, 
                    scale = 0.8, 
                    colour = 75,
                    flashes = false, 
                    text = '[P10] Pengeautomat adfærd',
                    time = 5,
                    radius = 0,
                }
            })
            
            local result = exports['pure-minigames']:numberCounter(zoneResult.minigames)
            if result then
                AddCooldown('atm', zoneResult)

                local atmPos = GetEntityCoords(entity)
                local particleName = "scr_indep_fireworks_money"
                local particlePos = vector3(atmPos.x, atmPos.y, atmPos.z + 0.5)

                UseParticleFxAssetNextCall(particleName)
                StartParticleFxNonLoopedAtCoord(particleName, particlePos.x, particlePos.y, particlePos.z, 0.0, 0.0, 0.0, false, false, false, false)

                for i = 1, 20 do
                    local moneyBill = CreateObject(GetHashKey("prop_anim_cash_note"), atmPos.x, atmPos.y, atmPos.z, true, true, true)
                    PlaceObjectOnGroundProperly(moneyBill)
                    SetEntityAsMissionEntity(moneyBill, true, true)
                    SetEntityDynamic(moneyBill, true)
                    SetEntityVelocity(moneyBill, math.random(-1, 1), math.random(-1, 1), math.random(3, 5))
                    Wait(100)
                end
                ExecuteCommand("e pickup")
                Citizen.Wait(1050)
                TriggerServerEvent("zf_robberies:interactwithATM", zoneResult, atmPos)

                scully_emotemenu:cancelEmote()
            else
                local rand = math.random(0, 1)
                TriggerServerEvent("zf_robberies:Failed", rand)
                if rand == 0 then
                    lib.notify({
                        description = 'Du fejlede hacking og beholder hacking sæt denne gang!',
                        type = 'error'
                    })
                else
                    lib.notify({
                        description = 'Du fejlede hacking og du mistede din hacking sæt!',
                        type = 'error'
                    })
                end

                scully_emotemenu:cancelEmote()
            end
        end
    end, coords, zoneResult.min_cops, zoneResult.jobs)
end

startRob = function(coords)
    local start = lib.alertDialog({centered = true, header = "Tankrøveri", content = "Er du sikker på at du ville starte et tankrøveri?", cancel = true, labels = {cancel = "Nej", confirm = "Ja"}})

    if start ~= "confirm" then
        lib.notify({
            description = 'Helt fair, bangebuks!',
            type = 'error'
        })
        return
    end

    local data = exports['cd_dispatch']:GetPlayerInfo()
    local zoneResult = getPlayerZone(data.coords, Config.TankGame)
    local scully_emotemenu = exports.scully_emotemenu

    print(zoneResult.name, data.street, data.coords)

    if zoneResult == nil then
        lib.notify({
            description = 'Du er ikke indenfor rækkevidden (reportere gerne dette til dev)',
            type = 'error'
        })
        return
    end
    
    ESX.TriggerServerCallback('zf_robberies:RobTank', function(success)
        if not success then
            lib.notify({
                description = 'Du kan ikke røve denne tank lige nu, prøv en anden!',
                type = 'error'
            })
            return
        end

        if cooldown and cooldown.robbery > 0 then
            lib.notify({
                description = 'Du har desværre en nødkøling på ' .. formatCooldown(cooldown.robbery),
                type = 'error'
            })
            return
        end

        if lib.progressBar({duration = 15000, label = 'Tilgår...', useWhileDead = false, canCancel = false, disable = {car = true}, anim = {scenario = 'CODE_HUMAN_MEDIC_KNEEL'}}) then
            TriggerServerEvent('cd_dispatch:AddNotification', {
                job_table = zoneResult.jobs,
                coords = data.coords,
                title = '[P10] Tankrøveri',
                message = 'En person er i gang med at røve en tank ved ' .. data.street,
                flash = 0,
                unique_id = data.unique_id,
                sound = 1,
                blip = {
                    sprite = 108, 
                    scale = 0.8, 
                    colour = 75,
                    flashes = false, 
                    text = '[P10] Tankrøveri',
                    time = 5,
                    radius = 0,
                }
            })

            ExecuteCommand("e phone")
            local result = exports['pure-minigames']:numberCounter(zoneResult.minigames)
            if result then
                AddCooldown('robbery', zoneResult)

                scully_emotemenu:cancelEmote()

                local remainingTime = Config.TimeToRobTank
                local endTime = GetGameTimer() + (remainingTime * 1000)
                while GetGameTimer() < endTime do
                    local timeLeft = endTime - GetGameTimer()
                    local minutes = math.floor(timeLeft / 60000)
                    local seconds = math.floor((timeLeft % 60000) / 1000)

                    lib.showTextUI(string.format("Tid tilbage: %02d:%02d", minutes, seconds))

                    Wait(1000)
                end
                exports.ox_target:addSphereZone({
                    name = "neger",
                    coords = vector3(coords.x, coords.y, coords.z),
                    radius = 2.5,
                    debug = Config.Debug,
                    options = {
                        {
                            icon = "fa-solid fa-sack-dollar",
                            label = "Tag penge",
                            distance = 1.5,
                            onSelect = function()
                                lib.hideTextUI()
                                ExecuteCommand("e pickup")
                                exports.ox_target:removeZone("neger")

                                scully_emotemenu:cancelEmote()

                                TriggerServerEvent("zf_robberies:RobTank", coords)
                            end,
                        },
                    },
                })
            else
                lib.notify({
                    description = 'Du fejlede og kan derfor ikke røve denne bank mere!',
                    type = 'error'
                })
                
                scully_emotemenu:cancelEmote()
            end
        end
    end, coords, zoneResult.min_cops, zoneResult.jobs)
end