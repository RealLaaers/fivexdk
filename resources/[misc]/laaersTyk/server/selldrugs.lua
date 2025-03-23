ESX = exports["es_extended"]:getSharedObject()
local ox_inventory = exports.ox_inventory

local policePlayers = {} 

RegisterServerEvent('callPolice')
AddEventHandler('callPolice', function(zone, street)
    local src = source
    local currentTime = os.time()
    local coords = GetEntityCoords(GetPlayerPed(src))

    TriggerClientEvent('showDrugNoti', -1, coords, street, "En person prøvede at sælge narkotika tæt på "..street.."!")
end)

Chance = function(number)
    math.randomseed(GetGameTimer() + math.random(1, 99999))
    local random = math.random(1, 100)

    if random <= number then
        return true
    else
        return false
    end
end

RegisterServerEvent('sellDrug')
AddEventHandler('sellDrug', function(zone)
    local drugPrices = {
        mushroom = { price = 150, minQty = 4, maxQty = 10 },
        weed_pooch = { price = math.random(100, 200), minQty = 4, maxQty = 10 },
        weed_packaged = { price = 210, minQty = 4, maxQty = 10 },
        bananakush_joint = { price = math.random(195, 230), minQty = 4, maxQty = 10 },
        bluedream_joint = { price = math.random(125, 250), minQty = 4, maxQty = 10 },
        purplehaze_joint = { price = math.random(135, 280), minQty = 4, maxQty = 10 }, 
        coke_pooch = { price = math.random(175, 300), minQty = 1, maxQty = 10 },
        coke_packaged = { price = math.random(2750, 3850), minQty = 1, maxQty = 2 },
        opium_pooch = { price = math.random(175, 300), minQty = 1, maxQty = 10 },
        opium_packaged = { price = math.random(2050, 3350), minQty = 1, maxQty = 2 },
        meth_pooch = { price = math.random(275, 350), minQty = 1, maxQty = 10 },
        meth_packaged = { price = math.random(3750, 4850), minQty = 1, maxQty = 2 },
    }

    local drugToSell = nil
    for _, drug in ipairs(Config.DrugsSearch) do
        local searchResult = exports.ox_inventory:Search(source, 'count', drug)
        if searchResult > 0 then
            drugToSell = drug
            break
        end
    end

    if drugToSell then
        local drugInfo = drugPrices[drugToSell]
        local price = drugInfo.price
        local quantity = math.random(drugInfo.minQty, drugInfo.maxQty)

        if exports.ox_inventory:Search(source, 'count', drugToSell) < drugInfo.minQty then 
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Du har ikke nok til at sælge!' }) 
            return 
        end

        local totalPrice = price * quantity

        local isInSpecialDrugs = false
        if Config.SpecialDrugs[zone] then
            for _, specialDrug in ipairs(Config.SpecialDrugs[zone]) do
                if specialDrug == drugToSell then
                    isInSpecialDrugs = true
                    break
                end
            end
        end

        TriggerEvent('sv_logs:drug:quickSell', source, drugToSell, quantity, totalPrice)
        if Chance(8) then
            TriggerEvent('addKundeToSimCard', source)
        end
        if isInSpecialDrugs then
            local bonusAmount = totalPrice * 0.08

            totalPrice = totalPrice + bonusAmount
            if exports.ox_inventory:GetItem(source, drugToSell, nil, true) <= quantity then TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Du har ikke nok til at sælge!' }) return end
            exports.ox_inventory:RemoveItem(source, drugToSell, quantity)
            exports.ox_inventory:AddItem(source, "black_money", totalPrice + bonusAmount)

            TriggerEvent('srp_zones:checkZoneGivEkstra', source, totalPrice, zone, quantity)

            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Bonus på ' .. bonusAmount .. ' for at sælge i område hvor stoffet er populært.' })
        else
            if exports.ox_inventory:GetItem(source, drugToSell, nil, true) <= quantity then TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Du har ikke nok til at sælge!' }) return end
            exports.ox_inventory:RemoveItem(source, drugToSell, quantity)
            exports.ox_inventory:AddItem(source, "black_money", totalPrice)

            TriggerEvent('srp_zones:checkZoneGivEkstra', source, totalPrice, zone, quantity)
        end
    else
        print("Neger prøver at bugge" .. source)
    end
end)