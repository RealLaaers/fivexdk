local Wait = nil
local LoadedArmor = false

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(1000)
        local ArmorStatus = GetPedArmour(PlayerPedId())

        if ESX.IsPlayerLoaded() then
            if ArmorStatus >= 1 and not LoadedArmor then
                LoadedArmor = true
                TriggerServerEvent('fh_ilegaljobs:VestLog', ArmorStatus)
            elseif not LoadedArmor then
                LoadedArmor = true
            end 
        end
    end
end)

RegisterCommand('removevest', function()
    local ped = PlayerPedId()
    local ArmorStatus = GetPedArmour(ped)

    if ArmorStatus >= 1 and LoadedArmor then
        if Wait == nil then
            Wait = true
            print(1)
            if lib.progressBar({
                duration = 1200,
                label = 'Fjerner Skudsikkervest',
                useWhileDead = false,
                canCancel = false,
                disable = {
                    car = true,
                },
                anim = {
                    dict = 'clothingtie',
                    clip = 'try_tie_negative_a'
                },
            }) then
                
                ESX.TriggerServerCallback('fh_ilegaljobs:GiveItem', function(cb)
                    if cb then
                        SetPedArmour(ped, 0)
                    end
                end, 'vest', ArmorStatus)

            end
            Citizen.Wait(500)
            Wait = nil
        end
    else
        lib.notify({
            title = 'Skudsikker Vest',
            description = 'Du har ingen skudsikker vest på',
            type = 'error'
        })

    end
end)





exports('bandage', function(data, slot)
    local playerPed = PlayerPedId()
    local maxHealth = GetEntityMaxHealth(playerPed)
    local health = GetEntityHealth(playerPed)
 
    -- Does the ped need to heal?
    if health < maxHealth then
        -- Use the bandage
        exports.ox_inventory:useItem(data, function(data)
            -- The item has been used, so trigger the effects
            if data then
                SetEntityHealth(playerPed, math.min(maxHealth, math.floor(health + maxHealth / 16)))
                lib.notify({description = 'You feel better already'})
            end
        end)
    else
        -- Don't use the item
        lib.notify({type = 'error', description = 'You don\'t need a bandage right now'})
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()

        if IsControlPressed(0, 36) then
            DisableControlAction(0, 140, true)
            DisableControlAction(0, 141, true)
            DisableControlAction(0, 142, true)
            DisableControlAction(0, 24, true)

            if IsPedPerformingStealthKill(playerPed) then
                ClearPedTasksImmediately(playerPed)
            end
        end
    end
end)