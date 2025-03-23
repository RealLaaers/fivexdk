local anchored = false
local boat = nil

RegisterCommand("anker", function(source, args, rawCommand)
	if boat ~= nil then
    	Anchor()
	end
end, false)

CreateThread(function()
	while true do
		Wait(1000)
		local ped = GetPlayerPed(-1)
        if IsPedInAnyBoat(ped) then
            boat = GetVehiclePedIsIn(ped, true)
        end
		if IsVehicleEngineOn(boat) then
            anchored = false
        end
	end
end)

Anchor = function()
	Citizen.CreateThread(function()
		local ped = GetPlayerPed(-1)
		print('doing magic')
		if not anchored then
			print('Ankering')
			print(GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(boat)))
			print(GetEntityCoords(ped))
			print(GetEntityCoords(boat))
			print(boat)
			if GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(boat)) < 8.0 then
				print('Distance good')
				print(boat)
				SetBoatAnchor(boat, true)
				TaskStartScenarioInPlace(ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
				Citizen.Wait(10000)
				print('Sending notification??')
				TriggerServerEvent('InteractSound_SV:PlayOnOne', 'anchordown', 0.5)
				TriggerEvent('mythic_notify:client:SendAlert', {type = 'success', text = 'Anker sænket.', length = 5000})
				ClearPedTasks(ped)
			end
		else
			print('Anker op')
			if GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(boat)) < 8.0 then
				print('Distance good')
				TaskStartScenarioInPlace(ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
				Wait(10000)
				print('Sending notification??')
				TriggerServerEvent('InteractSound_SV:PlayOnOne', 'anchorup', 0.5)
				TriggerEvent('mythic_notify:client:SendAlert', {type = 'success', text = 'Anker hævet.', length = 5000})
				ClearPedTasks(ped)
				SetBoatAnchor(boat, false)
			end
		end
		anchored = not anchored
	end)
end