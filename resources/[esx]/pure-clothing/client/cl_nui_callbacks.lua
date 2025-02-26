RegisterNUICallback('setAppearance', function(data, cb)
    debugPrint('setAppearance', json.encode(data))
    if not clothingTable[data.name] then
        debugPrint('Invalid clothing table name', data.name)
        return 
    end
    if checkBlacklist(data) then return end
    if not checkWhitelist(data) then return end
    setAppearance(data)
    recentlyUsedOutfit = false
end)

RegisterNUICallback('setTexture', function(data, cb)
    -- debugPrint('setTexture', json.encode(data))
    if not clothingTable[data.name] then
        debugPrint('Invalid clothing table name', data.name)
        return 
    end
    local playerPed = cache.ped
    local type = clothingTable[data.name].type
    local id = clothingTable[data.name].id
    data.value = tonumber(data.value1)
    if not checkWhitelist(data) then return end
    if type == 'variation' then
        SetPedComponentVariation(playerPed, id, data.value1, data.value2, 0)
        return 
    elseif type == 'prop' then 
        SetPedPropIndex(playerPed, id, data.value1, data.value2, 0)
        return
    end
end)

RegisterNUICallback('setColour', function(data, cb)
    debugPrint('setColour', json.encode(data))
    if not clothingTable[data.name] then
        debugPrint('Invalid clothing table name', data.name)
        return 
    end
    if colourBlacklist(data) then return end
    local type = clothingTable[data.name].type
    local playerPed = cache.ped
    if type == 'variation' then 
        SetPedHairColor(playerPed, data.colour1, data.colour2)
    else
        local overlayId = clothingTable[data.name].id
        local colourType = clothingTable[data.name].colourType
        if tonumber(data.colour2) then 
            colour2 = tonumber(data.colour2)
        else
            colour2 = 1.0
        end
        SetPedHeadOverlayColor(cache.ped, overlayId, colourType, tonumber(data.colour1), colour2)
    end
end)

RegisterNUICallback('setPed', function(data, cb)
    debugPrint('setPed', json.encode(data))
    if checkBlacklist(data) then return end
    if not checkWhitelist(data) then return end
    setPedNui(data.model)
    deleteAllTattoos()
    TriggerServerEvent('pure-clothing:saveTattoos', {})
    -- notifySystem({
    --     title = _Lang('clothing.peds.title'),
    --     description = string.format(_Lang('clothing.peds.message'), data.model),
    --     type = 'success',
    --     position = Config.libText.notfiyPoistion,
    -- })
end)

RegisterNUICallback('setTattoos', function(data, cb)
    debugPrint('setTattoos', json.encode(data))
    if checkBlacklist(data) then return end
    if not checkWhitelist(data) then return end
    applyTattoos(data.tattoos, data.type)
end)

RegisterNUICallback('setEyeColour', function(data, cb)
    debugPrint('setEyeColour', json.encode(data))
    setEyeColour(data)
end)

RegisterNUICallback('useConfigOutfit', function(data, cb)
    debugPrint('useOutfit', json.encode(data))
    setConfigOutfit(data['outfit'], data['name'])
end)

RegisterNUICallback('useCurrentOutfit', function(data, cb)
    debugPrint('useCurrentOutfit', json.encode(data))
    setCurrentOutfit(data['outfit'], data['name'], data['modelHash'])
end)

RegisterNUICallback('saveOutfit', function(data, cb)
    debugPrint('saveOutfit', json.encode(data))
    saveOutfit(data)
end)

RegisterNUICallback('shareOutfit', function(data, cb)
    debugPrint('shareOutfit', json.encode(data))
    -- shareOutfit(data)
    TriggerServerEvent('pure-clothing:shareOutfit', data)
    notifySystem({
        title = _Lang('nui.popouts.shareOutfitNotfiy.title'),
        description = string.format(_Lang('nui.popouts.shareOutfitNotfiy.message'), data.player),
        type = 'success',
        position = Config.libText.notfiyPoistion,
    })
end)

RegisterNUICallback('updateOutfitName', function(data, cb)
    debugPrint('updateOutfitName', json.encode(data))
    updateOutfitName(data)
end)

RegisterNUICallback('acceptOutfit', function(data, cb)
    debugPrint('acceptOutfit', json.encode(data))
    acceptOutfit(data)
end)

RegisterNUICallback('getNearbyPlayers', function(data, cb)
    local nearbyPlayers = lib.getNearbyPlayers(GetEntityCoords(cache.ped), 10.0, false)
    local playerIds = {}
    debugPrint('Nearby players', json.encode(nearbyPlayers))
    if not nearbyPlayers or json.encode(nearbyPlayers) == '[]' then 
        debugPrint('No nearby players')
        playerIds = nil
        cb(playerIds)
        return
    end
    for i = 1, #nearbyPlayers do 
        debugPrint('Nearby player', NetworkGetNetworkIdFromEntity(nearbyPlayers[i].ped))
        local newSource = GetPlayerServerId(nearbyPlayers[i].id)
        playerIds[#playerIds + 1] = {id = NetworkGetNetworkIdFromEntity(nearbyPlayers[i].ped), name = getPlayerCharacterName(newSource), source = newSource}
    end
    debugPrint('Nearby player ids', json.encode(playerIds))
    cb(playerIds)
end)

RegisterNUICallback('deleteCurrentOutfit', function(data, cb)
    debugPrint('deleteCurrentOutfit', json.encode(data))
    deleteCurrentOutfit(data)
end)

RegisterNUICallback('getPrice', function(data, cb)
    debugPrint('getPrice', json.encode(data))
    if data.type == 'clothing' then 
        local price = generateClothingPayment()
        cb(price)
        return
    elseif data.type == 'createCharacter' then 
        if charactersFirstCharacter then 
            price = 0
        else
            price = Config.priceForMenus.surgeon
        end
        cb(price)
        return
    elseif data.type == 'hair' then 
        local price = Config.priceForMenus.barber
        cb(price)
        return
    elseif data.type == 'tattoo' then 
        local price = Config.priceForMenus.tattoo
        cb(price)
        return
    end
    cb(0)
    return
end)

RegisterNUICallback('saveButton', function(data, cb)
    debugPrint('saveButton', json.encode(data))
    saveAppearance(data)
    closeClothing()
end)

RegisterNUICallback('deleteButton', function(data, cb)
    debugPrint('deleteButton', json.encode(data))
    discardAppearance(data)
    closeClothing()
end)

RegisterNUICallback('clearTattoos', function(data, cb)
    debugPrint('clearTattoos', json.encode(data))
    deleteAllTattoos()
end)

RegisterNUICallback('randomiseCharacter', function(data, cb)
    debugPrint('randomiseCharacter')
    randomiseCharacter()
end)

RegisterNUICallback('handsUp', function(data, cb)
    debugPrint('handsUp')
    handsUpAnim()
end)

RegisterNUICallback('hideFrame', function(data, cb)
    debugPrint('hideFrame', json.encode(data))
    discardAppearance(data)
    closeClothing()
end)

RegisterNUICallback('getConfig', function(_, cb)
    debugPrint('getConfig')
    cb(Config)
end)

RegisterNUICallback('getLanguage', function(_, cb)
    local lang = Config.language
    if not Language[lang] then
        lang = 'en'
    end
    debugPrint('getLanguage', lang)
    debugPrint('getLanguage', json.encode(Language[lang].nui))
    cb(Language[lang].nui)
end)