local activePistolZone = 'pistol1'
local zones = {"pistol1", "pistol2"}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10 * 5 * 1000)
        activePistolZone = zones[math.random(#zones)]
        print("Ny aktiv pistolzone: " .. activePistolZone)
        
        local players = GetPlayers()
        for _, playerId in ipairs(players) do
            if GetPlayerRoutingBucket(playerId) == 917665 then
                TriggerClientEvent("pistolzone:updateZone", playerId, activePistolZone)
            end
        end
    end
end)

AddEventHandler("playerConnecting", function(name, setKickReason, deferrals)
    local src = source
    if GetPlayerRoutingBucket(src) == 917665 then
        TriggerClientEvent("pistolzone:updateZone", src, activePistolZone)
    end
end)

RegisterNetEvent('putinpistolbucket')
AddEventHandler('putinpistolbucket', function()
    SetPlayerRoutingBucket(source, 917665)
end)