local activePistolZone = 'pistol1'
local zones = {"pistol1", "pistol2", "pistol3"}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10 * 5 * 1000)

        local newZone = zones[math.random(#zones)]
        while newZone == activePistolZone do
            newZone = zones[math.random(#zones)]
        end

        activePistolZone = newZone
        print("Ny aktive pistolzone: " .. activePistolZone)
        
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

RegisterNetEvent("pistolzone:join", function()
    local src = source
    SetPlayerRoutingBucket(src, 917665)
    TriggerClientEvent("pistolzone:updateZone", src, activePistolZone)
end)