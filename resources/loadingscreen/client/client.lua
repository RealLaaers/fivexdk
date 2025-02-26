local ClientLoadESX = false

AddEventHandler("playerSpawned", function ()
    if not ClientLoadESX then
        ShutdownLoadingScreenNui()

        SetEntityCoords(PlayerPedId(), 343.5642, -1421.0951, 76.1741)
        SetEntityHeading(PlayerPedId(), 136.0984)
        
        ClientLoadESX = true
        if Config.Fade then
          DoScreenFadeOut(0)
          Wait(3000)
            DoScreenFadeIn(2500)
        end
    end
end)
