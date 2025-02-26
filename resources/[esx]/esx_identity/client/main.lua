local loadingScreenFinished = false
local ready = false
local guiEnabled = false
local timecycleModifier = "hud_def_blur"
local data = {
    height = "180",
    sex = "m",
    firstname = "elsker",
    lastname = "katte",
    dateofbirth = "01/01/1996"
}

RegisterNetEvent("esx_identity:alreadyRegistered", function()
    TriggerEvent("esx_skin:playerRegistered")
end)

-- RegisterNetEvent("esx_identity:setPlayerData", function(data)
--     SetTimeout(1, function()
--         ESX.SetPlayerData("name", ("%s %s"):format(data.firstName, data.lastName))
--         ESX.SetPlayerData("firstName", data.firstName)
--         ESX.SetPlayerData("lastName", data.lastName)
--         ESX.SetPlayerData("dateofbirth", data.dateOfBirth)
--         ESX.SetPlayerData("sex", data.sex)
--         ESX.SetPlayerData("height", data.height)
--     end)
-- end)

CreateThread(function()
    ESX.TriggerServerCallback("esx_identity:registerIdentity", function(callback)
        Wait(500)
        TriggerEvent("esx_skin:playerRegistered")
    end, data)
end)
    
