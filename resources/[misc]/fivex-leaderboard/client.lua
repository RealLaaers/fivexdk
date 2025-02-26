kdspam = false

Citizen.CreateThread(function()
	ESX = exports["es_extended"]:getSharedObject()
	while ESX.GetPlayerData().name == nil do
		Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

local nuiload = false

-----------------------------------------------------------------------------------------
-- EVENT'S --
-----------------------------------------------------------------------------------------

-- AddEventHandler('onResourceStart', function(resourceName)
-- 	if (GetCurrentResourceName() == resourceName) then
--         TriggerServerEvent('fivex-leaderboard:playerLoaded')
--         SetRanks()
-- 	end
-- end)

-- AddEventHandler("playerSpawned",function()
--     TriggerServerEvent('fivex-leaderboard:playerLoaded')
--     SetRanks()
-- end)

if not Config.RefreshNow then
    CreateThread(function()
        while true do
            TriggerServerEvent('fivex-leaderboard:getLeaderBoard')
            Wait(Config.RefreshTime * 60 * 1000)
        end
    end)
end

CreateThread(function()
    while true do
        if NetworkIsPlayerActive(PlayerId()) then
            TriggerServerEvent('fivex-leaderboard:playerLoaded')
            break
        end
        Wait(1)
    end
end)

RegisterNetEvent('fivex-leaderboard:set:myStats', function(result)
    while true do
        if nuiload then
            SendNUIMessage({
                type   = "SET_FIRST_MY_DATA",
                object = result 
            })
            break
        end
        Wait(1)
    end
end)

RegisterNetEvent('fivex-leaderboard:send:leaderboard', function(result)
    while true do
        if nuiload then
            SendNUIMessage({
                type   = "SET_LEADERBOARD_DATA",
                object = result 
            })
            break
        end
        Wait(1)
    end
end)

AddEventHandler('gameEventTriggered', function(name, data)
    if name == "CEventNetworkEntityDamage" then
        victim = tonumber(data[1])
        attacker = tonumber(data[2])
        victimDied = tonumber(data[6]) == 1 and true or false 
        weaponHash = tonumber(data[7])
        isMeleeDamage = tonumber(data[10]) ~= 0 and true or false 
        vehicleDamageTypeFlag = tonumber(data[11]) 
        local FoundLastDamagedBone, LastDamagedBone = GetPedLastDamageBone(victim)
        local bonehash = -1 
        if FoundLastDamagedBone then
            bonehash = tonumber(LastDamagedBone)
        end
        local PPed = PlayerPedId()
        local distance = IsEntityAPed(attacker) and #(GetEntityCoords(attacker) - GetEntityCoords(victim)) or -1
        local isplayer = IsPedAPlayer(attacker)
        local attackerid = isplayer and GetPlayerServerId(NetworkGetPlayerIndexFromPed(attacker)) or tostring(attacker==-1 and " " or attacker)
        local deadid = isplayer and GetPlayerServerId(NetworkGetPlayerIndexFromPed(victim)) or tostring(victim==-1 and " " or victim)
        local victimName = GetPlayerName(PlayerId())

        if victim == attacker or victim ~= PPed or not IsPedAPlayer(victim) or not IsPedAPlayer(attacker) then return end

		if victim == PPed then 
            if victimDied then
                if IsEntityAPed(attacker) then
                    TriggerServerEvent('fivex-leaderboard:playerDeath', attackerid, deadid)
                end
            end 
        end
    end

end)

-----------------------------------------------------------------------------------------
-- NUI CALLBACK'S --
-----------------------------------------------------------------------------------------

RegisterNUICallback('nuiloaded', function()
	nuiload = true
end)

RegisterNUICallback('changeBanner', function(data)
    TriggerServerEvent('fivex-leaderboard:changeBanner', data.link)
end)

RegisterNUICallback('close', function(data)
	SetNuiFocus(false, false)
	SendNUIMessage({
		type = "CLOSE_BOARD"
	})
end)

-----------------------------------------------------------------------------------------
-- FUNCTION'S --
-----------------------------------------------------------------------------------------

RegisterCommand('leaderboard', function()
    TriggerEvent('fivex-leaderboard:openUI')
end)

RegisterNetEvent("fivex-leaderboard:openUI")
AddEventHandler("fivex-leaderboard:openUI", function()
	if not IsPauseMenuActive() then
		if nuiload then
            if Config.RefreshNow then
                TriggerServerEvent('fivex-leaderboard:getLeaderBoard')
            end
            SetNuiFocus(true, true)
            TriggerServerEvent('fivex-leaderboard:getInfo')
			SendNUIMessage({
				type = "OPEN_BOARD"
			})
		end
	end
end)

RegisterNUICallback('fivex-leaderboard:closeUI', function()
    SetNuiFocus(false, false)
    TriggerEvent('ssa-base:client:back-main-menu')
end)


-- RegisterCommand('denemetry', function()
--     ESX.TriggerServerCallback('fivex-leaderboard:server:getSC', function(sc)
--         print(sc)
--     end)
-- end)

RegisterCommand('resetstats', function()
    if not kdspam then
        kdspam = true
        TriggerServerEvent('fivex-leaderboard:server:kdres')
        Wait(10000)
        kdspam = false
    end 
end)