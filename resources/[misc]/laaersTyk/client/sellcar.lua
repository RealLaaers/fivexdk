
-- Function to open the sell car confirmation menu
function OpenSellCarConfirmationMenu(plate)
    local input = lib.inputDialog("Sælg køretøj", {
        { type = 'number', label = 'Køretøjets pris', description = 'Indtast aftalte beløb!', required = true }
    })
    --print(plate)
    local sellingPrice = tonumber(input[1])

    if sellingPrice then
        local nearestPlayer, distance = ESX.Game.GetClosestPlayer()
        if nearestPlayer ~= nil then
            local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()
            --print(closestPlayer .. " ".. closestPlayerDistance)
            TriggerServerEvent('sellcar:confirmSale', plate, sellingPrice, GetPlayerServerId(closestPlayer))

        else
            --print('No player nearby')
        end
        lib.hideContext()
    else
        --print('Invalid selling price')
    end
end
-- Event handler to receive the confirmation dialog
RegisterNetEvent("sellcar:confirmDialog")
AddEventHandler("sellcar:confirmDialog", function(sellerName, vehiclePlate, sellingPrice, sellerId)
   -- local dialogTitle = "Bekræftelse"
    local dialogTitle = "Du er ved at købe " .. vehiclePlate .. " af " .. sellerName .. " - "..sellerId

    local input = lib.inputDialog(dialogTitle, {
        {type = 'description', label = dialogContent},
        {type = 'checkbox', label = 'Bekræft tilbud på '..sellingPrice..' ,- DKK'}

    })

    if input then TriggerServerEvent("sellcar:saleConfirmationResult", sellerId, vehiclePlate, sellingPrice, input[1]) end
end)
-- Event handler to request the player's cars from the server
RegisterNetEvent('sellcar:requestPlayerCars')
AddEventHandler('sellcar:requestPlayerCars', function()
    TriggerServerEvent('sellcar:requestPlayerCars')
end)

-- Event handler to receive the player's cars and display the sell car menu
RegisterNetEvent('sellcar:receivePlayerCars')
AddEventHandler('sellcar:receivePlayerCars', function(cars)
    local menu = {
        id = 'sellcar_menu',
        icon = "money-bill",
        title = 'Køretøjer som kan sælges',
        options = {}
    }

    for _, car in ipairs(cars) do
        local vehicleModel = car.vehicle.model
        local vehicleName = GetVehicleDisplayName(vehicleModel)
        local vehicleType = car.type

        -- Set the icon based on the vehicle type
        local icon = vehicleType == "lease" and "car-burst" or vehicleType

        local option = {
            icon = icon,
            title = vehicleName .. ' (' .. car.plate .. ')',
            description = 'Klik for at sælge dette køretøj',
            onSelect = function()
                OpenSellCarConfirmationMenu(car.plate)
            end
        }

        table.insert(menu.options, option)
    end

    lib.registerContext(menu)
    lib.showContext('sellcar_menu')
end)

-- Event handler to receive the sell car confirmation dialog


-- Event handler to receive the sell car confirmation result
RegisterNetEvent("sellcar:confirmSaleResult")
AddEventHandler("sellcar:confirmSaleResult", function(result)
    if result then
        -- Sale confirmed
        --print('Sale confirmed')
    else
        -- Sale declined
        --print('Sale declined')
    end
end)

-- Command to open the sell car menu
RegisterCommand('sellcar', function()
    TriggerEvent('sellcar:requestPlayerCars')
end)

-- Function to get the display name of a vehicle model
function GetVehicleDisplayName(model)
    local hash = tonumber(model)
    if hash ~= nil then
        return GetDisplayNameFromVehicleModel(hash)
    end
    return 'Unknown Vehicle'
end