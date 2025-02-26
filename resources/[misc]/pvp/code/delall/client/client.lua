ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

RegisterNetEvent("delall")
AddEventHandler("delall", function ()
    Citizen.Wait(5000) 
    for vehicle in EnumerateVehicles() do            
        if (not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1))) then 
            SetVehicleHasBeenOwnedByPlayer(vehicle, false) 
            SetEntityAsMissionEntity(vehicle, false, false) 
            DeleteVehicle(vehicle)
            ESX.Game.DeleteVehicle(vehicle)

            DeleteEntity(vehicle)
            DeleteVehicle(vehicle) 
                
            ESX.Game.DeleteVehicle(vehicle)
            DeleteEntity(vehicle)
            if (DoesEntityExist(vehicle)) then 
                DeleteVehicle(vehicle) 
                    ESX.Game.DeleteVehicle(vehicle)
                DeleteEntity(vehicle)
                DeleteVehicle(vehicle)
                    ESX.Game.DeleteVehicle(vehicle)
                DeleteEntity(vehicle)
            end
            Citizen.Wait(10)
        end
    end
    TriggerServerEvent("delallmsg")
end)
