-- Variabel til den aktive pistolzone og til bucket
local activePistolZone = 'pistol1'
local zones = {"pistol1", "pistol2"}

-- Timer der opdaterer zonen hver 10. minut for spillere i bucket 917665
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10 * 60 * 1000) -- 10 minutter
        activePistolZone = zones[math.random(#zones)]
        print("Ny aktive pistolzone: " .. activePistolZone)
        
        local players = GetPlayers()
        for _, playerId in ipairs(players) do
            if GetPlayerRoutingBucket(playerId) == 917665 then
                TriggerClientEvent("pistolzone:updateZone", playerId, activePistolZone)
            end
        end
    end
end)

-- Når en spiller forbinder, sendes den nuværende zone hvis de er i bucket 917665
AddEventHandler("playerConnecting", function(name, setKickReason, deferrals)
    local src = source
    if GetPlayerRoutingBucket(src) == 917665 then
        TriggerClientEvent("pistolzone:updateZone", src, activePistolZone)
    end
end)

-- Server-event til at "join" pistolzonen: sæt spilleren i bucket 917665 og send zone-update
RegisterNetEvent("pistolzone:join", function()
    local src = source
    SetPlayerRoutingBucket(src, 917665)
    print("Spiller " .. src .. " sat i bucket 917665 for pistolzonen")
    TriggerClientEvent("pistolzone:updateZone", src, activePistolZone)
end)