-- Variabel til at holde den aktive pistolzone
local activePistolZone = 'pistol1'
local zones = {"pistol1", "pistol2"}

-- Timer der opdaterer zonen hver 10. minut (10*60*1000 ms)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10 * 60 * 1000)
        activePistolZone = zones[math.random(#zones)]
        print("Ny aktive pistolzone: " .. activePistolZone)
        -- Send til alle klienter
        TriggerClientEvent("pistolzone:updateZone", -1, activePistolZone)
    end
end)

-- Når en klient forbinder, sendes den nuværende zone til den klient
AddEventHandler("playerConnecting", function(name, setKickReason, deferrals)
    local src = source
    TriggerClientEvent("pistolzone:updateZone", src, activePistolZone)
end)
