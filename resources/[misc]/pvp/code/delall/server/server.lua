

RegisterNetEvent("delall_car")
AddEventHandler("delall_car", function(name, message)
    TriggerClientEvent("delall", -1)
end)


RegisterNetEvent("delallmsg")
AddEventHandler("delallmsg", function(name, message)
end)