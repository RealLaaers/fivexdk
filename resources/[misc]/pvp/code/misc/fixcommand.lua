RegisterNetEvent('fixcar')
AddEventHandler('fixcar',function()
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		SetVehicleEngineHealth(vehicle, 100)
		SetVehicleEngineOn(vehicle, true, true)
		SetVehicleFixed(vehicle)
	end
end)

RegisterCommand('fix', function()
    TriggerEvent('fixcar')
	FlipCarOver()
end)

function FlipCarOver()
    local ped = PlayerPedId()
    local pedcoords = GetEntityCoords(ped)
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if IsPedInAnyVehicle(PlayerPedId(), false) and IsVehicleOnAllWheels(GetVehiclePedIsIn(PlayerPedId(), false)) == false then
        local carCoords = GetEntityRotation(vehicle, 2)
        SetEntityRotation(vehicle, carCoords[1], 0, carCoords[3], 2, true)
        SetVehicleOnGroundProperly(vehicle)
        --TriggerEvent('angelicxs-flipcar:Notify', Config.Lang['flipped'], Config.LangType['success'])
        ClearPedTasks(ped)
    elseif IsVehicleOnAllWheels(vehicle) ~= false then
        --TriggerEvent('angelicxs-flipcar:Notify', Config.Lang['allset'], Config.LangType['error'])
    end
end