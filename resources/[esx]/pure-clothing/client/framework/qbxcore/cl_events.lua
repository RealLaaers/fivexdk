if Config.framework ~= 'qbox' then return end

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    PlayerData = QBX.PlayerData
    initiateApperance()
end)

RegisterNetEvent("qb-clothes:client:CreateFirstCharacter", function()
    openMenu('createCharacter', true)
end)

RegisterNetEvent("QBCore:Client:OnJobUpdate", function(data)
    PlayerData.job = data
    resestBlips()
end)

RegisterNetEvent("QBCore:Client:OnGangUpdate", function(data)
    PlayerData.gang = data
    resestBlips()
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
end)

RegisterNetEvent("QBCore:Client:OnPlayerUnload", function()
    PlayerData = {}
end)

RegisterNetEvent("QBCore:Client:SetDuty", function(duty)
    if PlayerData and PlayerData.job then
        PlayerData.job.onduty = duty
    end
end)

RegisterNetEvent('qb-clothing:client:openOutfitMenu', function()
    openMenu('outfits')
end)

RegisterNetEvent('qb-clothing:client:openMenu', function()
    openMenu('createCharacter')
end)