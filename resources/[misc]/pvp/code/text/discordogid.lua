Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        local playerId = GetPlayerServerId(PlayerId())

        SendNUIMessage({
            type = "updateid",
            playerid = playerId
        })
    end
end)
