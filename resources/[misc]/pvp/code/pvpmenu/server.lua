ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent('nigger:SpawnShit')
AddEventHandler('nigger:SpawnShit', function(item, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem(item, count)
end)

RegisterServerEvent('nigger:SpawnAllshjit')
AddEventHandler('nigger:SpawnAllshjit', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem("ammo", 1000)
    xPlayer.addInventoryItem("vest", 500)
    xPlayer.addInventoryItem("clip", 10)
    xPlayer.addInventoryItem("radio", 1)
    xPlayer.addInventoryItem("scope", 10)
    xPlayer.addInventoryItem("silencer", 10)
    xPlayer.addInventoryItem("flashlight", 10)
end)

RegisterNetEvent('clearinv')
AddEventHandler('clearinv', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    exports.ox_inventory:ClearInventory(source, false)
end)

-- Online Menu --

RegisterNetEvent('GotoNigger')
AddEventHandler('GotoNigger', function(input)
    local xPlayer = ESX.GetPlayerFromId(source)
    local PlayerGoto = ESX.GetPlayerFromId(input[1])

    if PlayerGoto == nil then
        TriggerClientEvent('ox_lib:notify', xPlayer.source, {title = 'Relentless Arena', description = 'Denne gamer er ikke online, ellers skete der en fejl idk.', position = 'center-left', type = 'inform'})
    else
        --local targetCoords = PlayerGoto.getCoords()
        local ped = GetPlayerPed(input[1])
        local targetCoords = GetEntityCoords(ped)

        xPlayer.setCoords(targetCoords)
    end
end)

RegisterNetEvent('GetTargetCoords')
AddEventHandler('GetTargetCoords', function(playerId)
    local playerPed = GetPlayerPed(playerId)
    local targetCoords = GetEntityCoords(playerPed)

    TriggerClientEvent('ReceiveTargetCoords', source, targetCoords)
end)


RegisterNetEvent('BringNigger')
AddEventHandler('BringNigger', function(input)
    local Gamer = ESX.GetPlayerFromId(source)
    local PlayerBring = ESX.GetPlayerFromId(input[1])

    if PlayerBring == nil then 
        TriggerClientEvent('ox_lib:notify', Gamer.source, {title = 'Relentless Arena', description = 'Denne gamer er ikke online, ellers skete der en fejl idk.', position = 'center-left', type = 'inform'})
    else
        local targetCoords = Gamer.getCoords()

        PlayerBring.setCoords(targetCoords)
    end
end)

-- Køretøj Shit --

RegisterNetEvent('BitchNigger:SpawnCar')
AddEventHandler('BitchNigger:SpawnCar', function(veh)

    local vehicle = GetHashKey(veh)
    local playerCoords = GetEntityCoords(GetPlayerPed(source))
    local playerHeading = GetEntityHeading(GetPlayerPed(source))

    local car = CreateVehicle(vehicle, playerCoords[1], playerCoords[2], playerCoords[3], playerHeading, true, false)
    TaskWarpPedIntoVehicle(GetPlayerPed(source), car, -1)
    TriggerClientEvent("tundenlortebil", source)
end)

RegisterNetEvent('PlayerLobby')
AddEventHandler('PlayerLobby', function(LobbeyID)
    SetPlayerRoutingBucket(source, LobbeyID)
end)

RegisterNetEvent('ResetLobby')
AddEventHandler('ResetLobby', function()
    SetPlayerRoutingBucket(source, 0)
end)

ESX.RegisterServerCallback('GetPlayerRoutingBucket', function(source, cb)
    cb(GetPlayerRoutingBucket(source))
end)