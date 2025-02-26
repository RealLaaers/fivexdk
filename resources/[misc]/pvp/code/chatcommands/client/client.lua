ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('rpchat:sendProximityMessageB')
AddEventHandler('rpchat:sendProximityMessageB', function(playerId, title, message, color)
	local source = PlayerId()
	local target = GetPlayerFromServerId(playerId)

	if target ~= -1 then
        local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
        local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)

        if targetPed == source or #(sourceCoords - targetCoords) < 20 then
            TriggerServerEvent("fuckmylife2", title, message, playerId)
        end
    end
end)

RegisterCommand('gungame', function()
    TriggerServerEvent('fivex-gungame:server:openMenu')
end)

RegisterNetEvent('rpchat:nogger')
AddEventHandler('rpchat:nogger', function(playerId, title, message, color)
	local source = PlayerId()
	local target = GetPlayerFromServerId(playerId)

    TriggerServerEvent("fuckmylife4", title, message, playerId)
end)

RegisterNetEvent('rpchat:nogger2')
AddEventHandler('rpchat:nogger2', function(playerId, title, message, color)
	local source = PlayerId()
	local target = GetPlayerFromServerId(playerId)

    TriggerServerEvent("fuckmylife5", title, message, playerId)
end)

RegisterNetEvent('sendMessageAdmin')
AddEventHandler('sendMessageAdmin', function(id, name, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)
    ESX.TriggerServerCallback('esx_chatforadmin:GetGroup', function(Group)
        UserGroup = Group
        if pid == myId then
            TriggerServerEvent("fuckmylife", name, message)
        elseif UserGroup ~= 'user' and pid ~= myId then
            TriggerServerEvent("fuckmylife", name, message)
        end
    end)
end)
Citizen.CreateThread( function()
    while true do Wait(10)
      SetPedConfigFlag(PlayerPedId(), 35, false)
    end
  end)

RegisterCommand("goto", function()
    TriggerEvent('GotoNigger')
end)