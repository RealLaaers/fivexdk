local function SendNotification(source, type, text)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, {
        type = type,
        text = text,
        length = 5000,
    })
end

-- Event handler to confirm the sale and transfer the vehicle
RegisterServerEvent("sellcar:confirmSale")
AddEventHandler("sellcar:confirmSale", function(vehiclePlate, sellingPrice, targetPlayer)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local sellerName = GetPlayerName(_source)
    --print(targetPlayer)
    -- Open a confirmation dialog for the target player to accept or reject the sale
    TriggerClientEvent("sellcar:confirmDialog", targetPlayer, sellerName, vehiclePlate, sellingPrice, _source)
end)

RegisterServerEvent("sellcar:saleConfirmationResult")
AddEventHandler("sellcar:saleConfirmationResult", function(sellerId, vehiclePlate, sellingPrice, accepted)
    local sellerSource = tonumber(sellerId)
    local buyerSource = source

    -- Check if the buyer has the required amount of money
    local xPlayer = ESX.GetPlayerFromId(buyerSource)
    if xPlayer.getAccount("bank").money >= sellingPrice then
        -- Check if the vehicle is leased
        MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
            ['@plate'] = vehiclePlate
        }, function(result)
            if result[1].vinscratch == 1 then
                SendNotification(sellerSource, "error", "Køretøjet er stjålet!")
                SendNotification(buyerSource, "error", "Køretøjet er stjålet!")
                return
            end
            if result[1].isleasing == 1 then
                -- Handle transaction failure for leased vehicle
                SendNotification(buyerSource, "error", "Køretøjet er leased i denne periode, og kan derfor ikke sælges.")
                SendNotification(sellerSource, "error", "Køretøjet er leased i denne periode, og kan derfor ikke sælges.")
            else
                -- Update the owner of the vehicle
                MySQL.Async.execute('UPDATE owned_vehicles SET owner = @buyer WHERE plate = @plate', {
                    ['@buyer'] = xPlayer.identifier,
                    ['@plate'] = vehiclePlate
                }, function(rowsChanged)
                    if rowsChanged > 0 then
                        -- Subtract the selling price from the buyer's money
                        xPlayer.removeAccountMoney("bank", sellingPrice)

                        -- Add the selling price to the seller's money
                        local sellerPlayer = ESX.GetPlayerFromId(sellerSource)
                        sellerPlayer.addAccountMoney("bank", sellingPrice)

                        -- Trigger events or perform actions for successful transaction
                        SendNotification(buyerSource, "success", "Køretøjet blev med success solgt.")
                        SendNotification(sellerSource, "success", "Køretøjet blev med success solgt.")

                        -- Create the webhook message
                        local carInfo = {
                            sellerSource = sellerSource,
                            buyerSource = buyerSource,
                            source = source,
                            plate = vehiclePlate,
                            type = result[1].type,
                            price = sellingPrice
                        }
                        SendWebhookMessage(carInfo)
                    else
                        -- Handle error when updating the owner fails
                        -- Trigger events or perform actions for unsuccessful transaction
                        SendNotification(sellerSource, "inform", "Der skete en fejl, kontakt en udvikler.")
                    end
                end)
            end
        end)
    else
        -- Handle insufficient funds
        -- Trigger events or perform actions for unsuccessful transaction
        SendNotification(buyerSource, "error", "Køber har ikke nok penge på sig.")
        SendNotification(sellerSource, "error", "Køber har ikke nok penge på sig.")
    end
end)

RegisterServerEvent('sellcar:requestPlayerCars')
AddEventHandler('sellcar:requestPlayerCars', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local identifier = xPlayer.identifier
    local playerCars = {}

    -- Fetch the player's cars from the database
    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @identifier',
        { ['@identifier'] = identifier },
        function(result)
            for _, row in ipairs(result) do
                local car = {
                    plate = row.plate,
                    vehicle = json.decode(row.vehicle),
                    type = row.type,
                    job = row.job,
                    stored = row.stored
                    -- Add any other properties you want to include
                }
                table.insert(playerCars, car)
            end

            -- Trigger the event to send the player's cars to the client
            TriggerClientEvent('sellcar:receivePlayerCars', src, playerCars)
        end
    )
end)

function SendWebhookMessage(carInfo)
    local webhookUrl = 'https://discord.com/api/webhooks/1349041701775474800/mgEYceKwwdMVou-a_qDONfW79lCGt4T9wbjg-1oQSBsbWPgdaLvueAZxxsJI7KS6ZQw0' -- Erstat med den faktiske webhook URL

    local seller = ESX.GetPlayerFromId(carInfo.sellerSource)
    local buyer = ESX.GetPlayerFromId(carInfo.buyerSource)

    local sellerIdentifiers = ""
    for _, identifier in ipairs(seller.getIdentifier()) do
        sellerIdentifiers = sellerIdentifiers .. "\n" .. identifier
    end

    local buyerIdentifiers = ""
    for _, identifier in ipairs(buyer.getIdentifier()) do
        buyerIdentifiers = buyerIdentifiers .. "\n" .. identifier
    end

    local sellerVehicleTrunk = {}
    local sellerVehicleGlovebox = {}

    local response = MySQL.query.await('SELECT `trunk`, `glovebox` FROM `owned_vehicles` WHERE `plate` = ?', {
        '8QR428DX'
    })
    for k, v in pairs(response) do
        table.insert(sellerVehicleTrunk, {
            name = v.trunk.name,
            count = v.trunk.count
        })
        table.insert(sellerVehicleGlovebox, {
            name = v.glovebox.name,
            count = v.glovebox.count
        })
    end

    local message = {
        username = "Privat Bil Salg",
        content = "En bil er blevet solgt!",
        embeds = {{
            title = "Information",
            fields = {
                { name = "Sælger ID", value = tostring(carInfo.sellerSource) },
                { name = "Sælger Navn", value = seller.getName() },
                { name = "Sælger Identifikatorer", value = seller.identifier },
                { name = "Køber ID", value = tostring(carInfo.buyerSource) },
                { name = "Køber Navn", value = buyer.getName() },
                { name = "Køber Identifikatorer", value = buyer.identifier },
                { name = "Nummerplade", value = carInfo.plate },
                { name = "Type", value = carInfo.type },
                { name = "Pris", value = tostring(carInfo.price) },
                { name = "Køretøjets Bagagerum", value = sellerVehicleTrunk},
                { name = "Køretøjets Handskerum", value = sellerVehicleGlovebox}
            },
            color = 65280 -- Rød farve (du kan tilpasse den)
        }}
    }

    PerformHttpRequest(webhookUrl, function(statusCode, response, headers)
        if statusCode ~= 200 then
            --print("Fejl ved afsendelse af webhook-besked.")
            --print("Svar: " .. tostring(response))
        end
    end, 'POST', json.encode(message), { ['Content-Type'] = 'application/json' })
end