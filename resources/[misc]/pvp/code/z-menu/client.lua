
  lib.addRadialItem({
    {
      id = 'revive',
      label = 'Revive',
      icon = 'heart-pulse',
      onSelect = function()
        ExecuteCommand('revive')
      end,
    },
    {
      id = 'noclip',
      label = 'Noclip',
      icon = 'ghost',
      onSelect = function()
          ExecuteCommand("noclip")
      end
    },
    {
      id = 'spawn',
      label = 'Spawn',
      icon = 'house',
      onSelect = function()
        ExecuteCommand('leavekoth')
        ExecuteCommand('leave')
        ExecuteCommand('leaveroyale')
        ExecuteCommand('leaveduel')
        SetEntityCoords(PlayerPedId(), 343.5642, -1421.0951, 76.1741)
        SetEntityHeading(PlayerPedId(), 136.0984)
      end
    },
    {
      id = 'fix',
      label = 'Reparer Køretøj',
      icon = 'car',
      onSelect = function()
        TriggerEvent("fix")
      end
    },
  })

  Citizen.CreateThread(function()
    while true do
      RestorePlayerStamina(PlayerId(), 1.0)
      SetPedCanLosePropsOnDamage(PlayerPedId(), false, 0)
      Citizen.Wait(0)
    end
  end)
  
  local function disableControls()
    StatSetInt('MP0_SHOOTING_ABILITY', 120, true)
    StatSetInt('MP0_STAMINA', 100, true)
    StatSetInt('MP0_LUNG_CAPACITY', 100, true)
    StatSetInt('MP0_STEALTH_ABILITY', 100, true)

    SetPedMoveRateOverride(PlayerId(),2.7)
    SetRunSprintMultiplierForPlayer(PlayerId(),1.69)

    while true do
        Wait(1000)
        DisableControlAction(0, 200, true)

        if IsPedArmed(PlayerPedId(), 6) then
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        end

        Wait(0)
    end
end

AddEventHandler('fix',function()
  local playerPed = GetPlayerPed(-1)
	if IsPedInAnyVehicle(playerPed, false) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		SetVehicleEngineHealth(vehicle, 9999)
		SetVehiclePetrolTankHealth(vehicle, 9999)
		SetVehicleFixed(vehicle)
	end
end)

RegisterCommand("dv", function()
  local playerPed = GetPlayerPed(-1)
	if IsPedInAnyVehicle(playerPed, false) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
    DeleteVehicle(vehicle)
	end
end)

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(1)
      ClearAreaOfVehicles(-1027.1630, -3486.5168, 14.1434, 10.0, false, false, false, false, false);
    end
end)

Citizen.CreateThread(disableControls)