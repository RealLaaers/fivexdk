if Config.framework ~= 'standalone' then return end

-- THESE ARE EXAMPLE EVENTS, CHANGE THEM TO YOUR SERVERS LIKING
RegisterNetEvent("onPlayerLoaded", function()
    PlayerData = QBCore.Functions.GetPlayerData()
    initiateApperance()
end)

RegisterNetEvent("createFirstCharacter", function()
    QBCore.Functions.GetPlayerData(function(newData)
        PlayerData = newData
        openMenu('createCharacter', true)
    end)
end)

RegisterNetEvent("onJobUpdate", function(data)
    PlayerData.job = data
    resestBlips()
end)

RegisterNetEvent("onGangUpdate", function(data)
    PlayerData.gang = data
    resestBlips()
end)

RegisterNetEvent('setPlayerData', function(val)
    PlayerData = val
end)

RegisterNetEvent("onPlayerUnload", function()
    PlayerData = {}
end)

RegisterNetEvent("setDuty", function(duty)
    if PlayerData and PlayerData.job then
        PlayerData.job.onduty = duty
    end
end)

RegisterNetEvent('openOutfitMenu', function()
    openMenu('outfits')
end)

RegisterNetEvent('openCreateCharacterMenu', function()
    openMenu('createCharacter')
end)