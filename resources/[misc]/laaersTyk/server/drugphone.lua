ESX = exports["es_extended"]:getSharedObject()
local ox_inventory = exports.ox_inventory

local drugPrices = {
    mushroom = { price = 313, minQty = 4, maxQty = 13 },
    skunk_packed = { price = math.random(256, 341), minQty = 4, maxQty = 18 },
    weed_packaged = { price = math.random(313, 425), minQty = 4, maxQty = 18 },
    bananakush_joint = { price = math.random(335, 428), minQty = 4, maxQty = 18 },
    bluedream_joint = { price = math.random(358, 442), minQty = 4, maxQty = 18 },
    purplehaze_joint = { price = math.random(470, 582), minQty = 4, maxQty = 18 },
    coke_pooch = { price = math.random(650, 789), minQty = 4, maxQty = 18 },
    coke_packaged = { price = math.random(5267, 6333), minQty = 2, maxQty = 6 },
    opium_pooch = { price = math.random(700, 845), minQty = 4, maxQty = 18 },
    opium_packaged = { price = math.random(5156, 6568), minQty = 2, maxQty = 6 },
    meth_pooch = { price = math.random(699, 845), minQty = 4, maxQty = 18 },
    meth_packaged = { price = math.random(5180, 6523), minQty = 2, maxQty = 6 },
    kq_meth_low = { price = math.random(478, 630), minQty = 4, maxQty = 18 },
    kq_meth_mid = { price = math.random(531, 670), minQty = 4, maxQty = 18 },
    kq_meth_high = { price = math.random(683, 760), minQty = 4, maxQty = 18 },
}


lib.callback.register('fh_drugphone:getSimCardInfo', function(source)
    local inventory = exports.ox_inventory:GetInventoryItems(source)
    local simCardInfo = nil

    for _, item in pairs(inventory) do
        if item.name == "drugphone" then
            if item.metadata.Simkort then
                if not item.metadata.Amount then
                    item.metadata.Amount = 0
                end
                if not item.metadata.USBData then
                    item.metadata.USBData = 0
                end
                if not item.metadata.Kontakter then
                    item.metadata.Kontakter = 0
                end

                simCardInfo = item.metadata
                break
            end
        end
    end

    return simCardInfo
end)

RegisterNetEvent('lb-drugphone', function(coords)
    local xPlayer = ESX.GetPlayerFromId(source)
    exports["lb-phone"]:SendMessage("Ukendt", exports["lb-phone"]:GetEquippedPhoneNumber(xPlayer.source), "Jeg har brug for dit produkt, kom til min gps hurtigt!")
    exports["lb-phone"]:SendCoords("Ukendt", exports["lb-phone"]:GetEquippedPhoneNumber(xPlayer.source), coords)
end)

RegisterNetEvent('fh_drugphone:setSimCardDrug', function(selectedDrug)
    local inventory = exports.ox_inventory:GetInventoryItems(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    for _, item in pairs(inventory) do
        if item.name == "drugphone" then
            if item.metadata and item.metadata.Simkort == true then
                item.metadata.Stof = selectedDrug
                if not item.metadata.Stof then
                    item.metadata.Stof = 0
                end
                exports.ox_inventory:SetMetadata(source, item.slot, item.metadata)
            end
        end
    end
    for k, v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v or "Intet"
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            license = v or "Intet"
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = v or "Intet"
        end
    end
    sendToDiscord('https://discord.com/api/webhooks/1296464600807506012/Yzl5eeRzD25aopfKpyJ6zgIzfTsxxKfmsTqpNKTNGTV8_XfRvzlp-BLBY_-rKsHonZfM', 15418782, 'Drugphone - Nyt Tilføjet Drug til Simkort', '**Spiller**: ' .. xPlayer.getName() .. '\n**Licens**: ' .. license .. '\n**Discord**: ' .. discord .. '\n\n**Drug type:** ' .. selectedDrug, 'Resident Drugphone | ')
end)

RegisterNetEvent('fh_drugphone:addKundeToSimCard', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local inventory = exports.ox_inventory:GetInventoryItems(source)

    for _, item in pairs(inventory) do
        if item.name == "drugphone" then
            if item.metadata and item.metadata.Simkort == true then
                item.metadata.Kontakter = (item.metadata.Kontakter or 0) + 1

                TriggerClientEvent('ox_lib:notify', source, {
                    description = 'Vedkommende kunne lide dit produkt! Du modtog en kontakt på din burnerphone!',
                    type = 'success',
                    position = "center-left",
                    duration = 10000,
                })
                for k, v in ipairs(GetPlayerIdentifiers(source)) do
                    if string.sub(v, 1, string.len("steam:")) == "steam:" then
                        steamid = v or "Intet"
                    elseif string.sub(v, 1, string.len("license:")) == "license:" then
                        license = v or "Intet"
                    elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                        discord = v or "Intet"
                    end
                end

                exports.ox_inventory:SetMetadata(source, item.slot, item.metadata)
                sendToDiscord('https://discord.com/api/webhooks/1296464822854226001/7lkYb7fQ2nV3WKA_-SZpD3AiJRZK6ILsN_iy56bqE9k7xonFfLQPjKVVtT5xJy-BtG3A', 3447003, 'Drugphone - Ny Kunde På Simkort', '**Spiller**: ' .. xPlayer.getName() .. '\n**Licens**: ' .. license .. '\n**Discord**: ' .. discord .. '\n**Type Stof:** ' .. item.metadata.Stof .. '\n**Sidste antal kontakter:**' .. item.metadata.Kontakter, 'Resident Drugphone | ')
                break
            end
        end
    end
end)

RegisterNetEvent('fh_drugphone:removeSimCard', function(drugphoneSlot)
    local _source = source
    local inventory = exports.ox_inventory:GetInventoryItems(_source)

    for _, item in pairs(inventory) do
        if item.slot == drugphoneSlot and item.name == "drugphone" then
            if item.metadata and item.metadata.Simkort == true then
                local contactCount = item.metadata.Kontakter or 0

                local newSimCardMetadata = {
                    Kontakter = contactCount,
                    Stof = item.metadata.Stof,
                    description = 'Gemte kontakter: ' .. contactCount
                }

                exports.ox_inventory:AddItem(_source, 'simcard', 1, newSimCardMetadata)

                TriggerClientEvent('ox_lib:notify', _source, {
                    title = 'DrugPhone - Notifikationer',
                    description = 'SIM-kort fjernet fra DrugPhone. Overført ' .. contactCount .. ' kontakter til det nye simkort.',
                    type = 'inform',
                    duration = 10000,
                })

                item.metadata.Simkort = false
                item.metadata.Kontakter = 0
                item.metadata.description = "Brugt telefon, uden simkort..."
                item.metadata.Stof = 'Default'

                exports.ox_inventory:SetMetadata(_source, drugphoneSlot, item.metadata)
            else
                TriggerClientEvent('ox_lib:notify', _source, {
                    description = 'Ingen SIM-kort fundet i denne telefon.',
                    type = 'error',
                    duration = 10000,
                })
            end
            break
        end
    end
end)

RegisterNetEvent('transferSimCardMetadata', function(drugphoneSlot)
    local _source = source

    local inventory = exports.ox_inventory:GetInventoryItems(_source)

    local simCardMetadata = nil
    local simCardSlot = nil

    for _, item in pairs(inventory) do
        if item.name == "simcard" then
            simCardMetadata = item.metadata
            simCardSlot = item.slot
            break
        end
    end

    if simCardSlot then
        local drugphoneItem = exports.ox_inventory:GetSlot(_source, drugphoneSlot)

        if drugphoneItem and drugphoneItem.name == "drugphone" then
            if drugphoneItem.metadata and drugphoneItem.metadata.Simkort == true then
                TriggerClientEvent('ox_lib:notify', _source, {
                    title = 'DrugPhone - Notifikationer',
                    description = 'Der er allerede et simkort i denne telefon. Fjern det hvis du skal have et nyt i.',
                    type = 'error'
                })
            else
                local updatedMetadata = drugphoneItem.metadata or {}
                updatedMetadata.Simkort = true
                if not updatedMetadata.Stof then
                    updatedMetadata.Stof = 'Default'
                end

                for key, value in pairs(simCardMetadata) do
                    updatedMetadata[key] = value
                end

                exports.ox_inventory:SetMetadata(_source, drugphoneSlot, updatedMetadata)

                exports.ox_inventory:RemoveItem(_source, "simcard", 1, nil, simCardSlot)
            end
        end
    else
        TriggerClientEvent('ox_lib:notify', _source, {
            title = 'DrugPhone - Notifikationer',
            description = 'Du har ikke et simkort eller også er der noget som driller!',
            type = 'error'
        })
    end
end)

ESX.RegisterServerCallback('fh_drugphone:interactWithNPC', function(source, cb, drugType, npccoords)
    local xPlayer = ESX.GetPlayerFromId(source)
    local inventory = exports.ox_inventory:GetInventoryItems(source)
    local simCardInfo = nil
    local noDrugCount = 0

    local steamid, license, discord = 'Ukendt', 'Ukendt', 'Ukendt'

    for k, v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = v
        end
    end

    local distance = #(GetEntityCoords(GetPlayerPed(source)) - npccoords)
    if distance > 5 then
        sendToDiscord('https://discord.com/api/webhooks/1309511239629672589/7NjkOlZeuC9ykUaWzVx-5nrfXGgCPeH26UhOpEv6n3oAz3mhx1yphmNCxtB6ED2Odu6A', 5793266, 'Drugphone - Bug', '**Spiller**: ' .. xPlayer.getName() .. '\n**Licens**: ' .. license .. ' \n**Discord**: ' .. discord .. '\n\nSpilleren har forsøgt at sælge stoffer med en distance på ' .. distance, 'Resident Drugphone | ')
        return
    end

    for _, item in pairs(inventory) do
        if item.name == "drugphone" and item.metadata.Simkort then
            simCardInfo = item.metadata
            break
        end
    end

    SimCardCustomers = tonumber(simCardInfo.Kontakter or 0)

    local drugTypeMap = {
        Kokain = { 'coke_packaged', 'coke_pooch' },
        Heroin = { 'opium_packaged', 'opium_pooch' },
        Meth = { 'meth_packaged', 'meth_pooch', 'kq_meth_mid','kq_meth_low','kq_meth_high',  },
        Hash = { 'weed_packaged', 'weed_pooch', 'bananakush_joint', 'bluedream_joint', 'purplehaze_joint' },
    }

    if drugType and drugTypeMap[drugType] then
        for _, drugTypeName in ipairs(drugTypeMap[drugType]) do
            SimCardData = math.floor(SimCardCustomers / Config.DivideContacts)
            
            if SimCardData == 0 then
                SimCardData = 1
            end
            
            Multi = math.random(SimCardData, SimCardData + 2)
            if Multi >= Config.MaxContacts / Config.DivideContacts then
                Multi = Config.MaxContacts / Config.DivideContacts
                return
            end
            
            if exports.ox_inventory:Search(source, 'count', drugTypeName) >= Multi then
                local drugInfo = drugPrices[drugTypeName]
                if drugInfo then

                    if Chance(25) then
                        TriggerEvent('fh_drugphone:addKundeToSimCard', source)
                    end
        
                    cb({ true, drugTypeName })
                    Wait(4000)

                    local price = drugInfo.price
                    exports.ox_inventory:RemoveItem(source, drugTypeName, Multi)

                    -- if exports.srp_zones:isGang(ESX.GetPlayerFromId(source).job.name) then
                    --     exports.ox_inventory:AddItem(source, 'black_money', price * Multi * 1.25)
                    -- else
                    exports.ox_inventory:AddItem(source, 'black_money', price * Multi)
                    -- end

                    sendToDiscord('https://discord.com/api/webhooks/1296464960330661960/rTsP5SuPiKJxt-pwI0iOTsU9V3z-jd_81O6BF52qpfei6qdMvUBDpzRDQKDNpWpL5zT_', 5793266, 'Drugphone - Salg', '**Spiller**: ' .. xPlayer.getName() .. '\n**Licens**: ' .. license .. ' \n**Discord**: ' .. discord .. '\n\n**Drug:** ' .. drugTypeName .. '\n**Pris:** ' .. ESX.Math.GroupDigits(price * Multi) .. ' DKK\n**Antal:** ' .. Multi .. '\n**Kontakter:** ' .. SimCardCustomers, 'Drugphone | ')

                    break
                else
                    cb({ nil, drugTypeName })
                end
            else
                noDrugCount = noDrugCount + 1
                if drugType == 'Hash' then
                    if noDrugCount == 5 then
                        noDrugCount = 1
                        cb({ nil, drugTypeName })
                    end
                else
                    if noDrugCount == 2 then
                        noDrugCount = 1
                        cb({ nil, drugTypeName })
                    end
                end
            end
        end
    end
end)

function sendToDiscord(webhook, color, name, message, footer)
    local embed = {
        {
            ["color"] = color,
            ["title"] = "**" .. name .. "**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = footer .. " " .. os.date("%x %X %p"),
            },
        }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ username = name, embeds = embed }), { ['Content-Type'] = 'application/json' })
end

Chance = function(number)
    math.randomseed(GetGameTimer() + math.random(1, 99999))
    local random = math.random(1, 100)

    if random <= number then
        return true
    else
        return false
    end
end
