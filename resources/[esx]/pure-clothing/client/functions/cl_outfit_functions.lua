function saveOutfit(name)
    debugPrint('Saving outfit', name)
    local currentClothing, oldClothing = getClothingValuesForSaving()
    local outfitTable = {
        name = name,
        modelHash = GetEntityModel(cache.ped),
        outfit = currentClothing
    }
    debugPrint('Outfit table', json.encode(outfitTable))
    TriggerServerEvent('pure-clothing:saveOutfit', outfitTable)
    Wait(250)
    getOutfitsFromDB()
    notifySystem({
        title = _Lang('outfits.savedOutfit.title'),
        description = string.format(_Lang('outfits.savedOutfit.message'), name),
        type = 'success',
        position = Config.libText.notfiyPoistion,
    })
end

function setConfigOutfit(data, name)
    for k,v in pairs(data) do 
        local clotTble = clothingTable[k]
        local type = clotTble.type
        local id = clotTble.id
        -- local data = {
        --     value = v[1],
        -- }
        if type == 'variation' then
            local newTexture = GetNumberOfPedTextureVariations(cache.ped, id, v[1])
            sendReactMessage('updateTexture', {name = k, value = newTexture})
            SetPedComponentVariation(cache.ped, id, v[1], v[2], 0)
        elseif type == 'prop' then 
            if v[1] == -1 then
                local playerPed = cache.ped
                ClearPedProp(playerPed, id)
            else 
                local newTexture = GetNumberOfPedPropTextureVariations(cache.ped, id, v[1])
                sendReactMessage('updateTexture', {name = k, value = newTexture})
                SetPedPropIndex(cache.ped, id, v[1], v[2], 0)
                SetPedPropIndex(cache.ped, id, v[1], v[2], 0)
            end
        end
    end
    notifySystem({
        title = _Lang('outfits.usedOutfit.title'),
        description = string.format(_Lang('outfits.usedOutfit.message'), name),
        type = 'success',
        position = Config.libText.notfiyPoistion,
    })
    getOutfitClothingValuesForReact()
    getOutfitPropValuesForReact()
end

function setCurrentOutfit(data, name, modelHash)
    if tonumber(modelHash) ~= tonumber(GetEntityModel(cache.ped)) then
        debugPrint('Model hash does not match', modelHash, GetEntityModel(cache.ped))
        return
    end
    for i = 1, #data do 
        local clotTble = clothingTable[data[i].name]
        local type = clotTble.type
        local id = clotTble.id
        debugPrint('Setting outfit', type, id, data[i].value1, data[i].value2, data[i].name)
        if type == 'variation' then
            local newTexture = GetNumberOfPedTextureVariations(cache.ped, id, data[i].value1)
            sendReactMessage('updateTexture', {name = data[i].name, value = newTexture})
            SetPedComponentVariation(cache.ped, id, data[i].value1, data[i].value2, 0)
        elseif type == 'prop' then
            if data[i].value1 == -1 then
                ClearPedProp(cache.ped, id)
            else
                local newTexture = GetNumberOfPedPropTextureVariations(cache.ped, id, data[i].value1)
                sendReactMessage('updateTexture', {name = data[i].name, value = newTexture})
                SetPedPropIndex(cache.ped, id, data[i].value1, data[i].value2, 0)
            end
        end
    end
    notifySystem({
        title = _Lang('outfits.usedOutfit.title'),
        description = string.format(_Lang('outfits.usedOutfit.message'), name),
        type = 'success',
        position = Config.libText.notfiyPoistion,
    })
    getOutfitClothingValuesForReact()
    getOutfitPropValuesForReact()
end

function deleteCurrentOutfit(data)
    debugPrint('Deleting outfit', data.uniqueOutfitid)
    -- TriggerServerEvent('pure-clothing:deleteOutfit', data.uniqueOutfitid)
    local success = lib.callback.await('pure-clothing:deleteOutfit', false, data.uniqueOutfitid)
    Wait(50)
    getOutfitsFromDB()
    notifySystem({
        title = _Lang('outfits.deleteOutfit.title'),
        description = string.format(_Lang('outfits.deleteOutfit.message'), data.name),
        type = 'success',
        position = Config.libText.notfiyPoistion,
    })
end

function acceptOutfit(data)
    local outfitTable = {
        name = data.name,
        modelHash = data.modelHash,
        outfit = data.outfit
    }
    debugPrint('Outfit table', json.encode(outfitTable))
    TriggerServerEvent('pure-clothing:saveOutfit', outfitTable)
    Wait(250)
    getOutfitsFromDB()
    notifySystem({
        title = _Lang('outfits.acceptOutfit.title'),
        description = string.format(_Lang('outfits.acceptOutfit.message'), data.name),
        type = 'success',
        position = Config.libText.notfiyPoistion,
    })
end

function getOutfitClothingValuesForReact()
    clothingReactValues = {}
    for k,v in pairs(clothingForValuesTable) do 
        if v.type == 'variation' then 
            clothingReactValues[#clothingReactValues + 1] = {name = k, value1 = GetPedDrawableVariation(cache.ped, v.id), value2 = GetPedTextureVariation(cache.ped, v.id)}
        end
    end
    debugPrint('Clothing features', json.encode(clothingReactValues))
    sendReactMessage('updateClothingFeatures', clothingReactValues)
    recentlyUsedOutfit = true
end

function getOutfitPropValuesForReact()
    propReactValues = {}
    for k,v in pairs(propsForvaluesTable) do 
        if v.type == 'prop' then 
            propReactValues[#propReactValues + 1] = {name = k, value1 = GetPedPropIndex(cache.ped, v.id), value2 = GetPedPropTextureIndex(cache.ped, v.id)}
        elseif v.type == 'variation' then 
            propReactValues[#propReactValues + 1] = {name = k, value1 = GetPedDrawableVariation(cache.ped, v.id), value2 = GetPedTextureVariation(cache.ped, v.id)}
        end
    end
    debugPrint('Prop features', json.encode(propReactValues))
    sendReactMessage('updatePropFeatures', propReactValues)
end

function updateOutfitName(data)
    local newName = data.name
    local uniqueOutfitid = data.uniqueOutfitid
    debugPrint('Updating outfit name', newName, uniqueOutfitid)
    TriggerServerEvent('pure-clothing:updateOutfitName', newName, uniqueOutfitid)
    notifySystem({
        title = _Lang('outfits.updateOutfitName.title'),
        description = string.format(_Lang('outfits.updateOutfitName.message'), data.name),
        type = 'success',
        position = Config.libText.notfiyPoistion,
    })
end