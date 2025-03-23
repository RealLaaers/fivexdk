local passengerDriveBy = true
local kmh = 3.6
local limit = 0
local inVeh = false
local weap = false
local PlayerId, GetPlayerPed, DoesEntityExist, IsEntityDead, GetEntitySpeed, SetPlayerCanDoDriveBy, Wait, floor =
    PlayerId, GetPlayerPed, DoesEntityExist, IsEntityDead, GetEntitySpeed, SetPlayerCanDoDriveBy, Wait, math.floor

local function CheckDriveByAllowed(speed)
    return floor(speed * kmh) <= limit or not passengerDriveBy
end

local function vehicleThread()
    while inVeh and weap do
        Wait(100)
        local playerPed = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        if DoesEntityExist(vehicle) and not IsEntityDead(vehicle) then
            local speed = GetEntitySpeed(vehicle)
            local vehicleClass = GetVehicleClass(vehicle)

            if vehicleClass ~= 15 and vehicleClass ~= 16 then
                SetPlayerCanDoDriveBy(PlayerId(), CheckDriveByAllowed(speed))
            end
        else
            break
        end

        Wait(1500)
    end
end

lib.onCache("weapon", function(value)
    weap = value
    if inVeh and weap then
        Citizen.CreateThread(vehicleThread)
    else
        SetPlayerCanDoDriveBy(PlayerId(), true)
    end
end)

lib.onCache("vehicle", function(value)
    inVeh = value
    if inVeh and weap then
        Citizen.CreateThread(vehicleThread)
    else
        SetPlayerCanDoDriveBy(PlayerId(), true)
    end
end)


local PlayerData                = {}

Citizen.CreateThread(function()
		Citizen.Wait(0)

	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
            if IsPedInAnyVehicle(PlayerPedId()) then
                SetUserRadioControlEnabled(false)
                if GetPlayerRadioStationName() ~= nil then
                SetVehRadioStation(GetVehiclePedIsIn(PlayerPedId()),"OFF")
                end
        end
    end
end)