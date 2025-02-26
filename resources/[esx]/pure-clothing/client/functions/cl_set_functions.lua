function setAppearance(data)
    local clotTble = clothingTable[data.name]
    local type = clotTble.type
    local id = clotTble.id
    if type == 'variation' then
        setVariation(id, data)
    elseif type == 'prop' then 
        if data.value == -1 then
            local playerPed = cache.ped
            ClearPedProp(playerPed, id)
        else
            setProp(id, data)
        end
    elseif type == 'faceFeature' then 
        local scale = (data.value / 50) - 1 -- converts the 0-100 to -1.0 <-> 1.0
        local index = clotTble[data.type]
        setFaceFeature(index, scale)
    elseif type == 'parents' then 
        local mother = clotTble.mother[data.mother]
        local father = clotTble.father[data.father]
        local mix = data.mix / 100 -- converts the 0-100 to 0.0 <-> 1.0
        local skin = data.skinColour / 100 -- converts the 0-100 to 0.0 <-> 1.0
        debugPrint('mother', mother, 'father', father, 'mix', mix, 'skin', skin)
        setParents(cache.ped, mother, father, mix, skin)
    elseif type == 'overlay' then
        -- debugPrint('overlay', json.encode(data))
        local opacity = data.opacity / 100 -- converts the 0-100 to 0.0 <-> 1.0
        setOverlay(id, data.value, opacity)
    end
end

function setVariation(id, data)
    local playerPed = cache.ped
    SetPedComponentVariation(playerPed, id, data.value, 0, 0)
    local newTexture = GetNumberOfPedTextureVariations(playerPed, id, data.value)
    sendReactMessage('updateTexture', {name = data.name, value = newTexture})
end

function setProp(id, data)
    local playerPed = cache.ped
    SetPedPropIndex(playerPed, id, data.value, 0, 0)
    local newTexture = GetNumberOfPedPropTextureVariations(playerPed, id, data.value)
    sendReactMessage('updateTexture', {name = data.name, value = newTexture})
end

function setFaceFeature(index, scale)
    local playerPed = cache.ped
    SetPedFaceFeature(playerPed, index, scale)
end

function setParents(ped, mother, father, mix, skin)
    debugPrint('Setting parents', ped, mother, father, mix, skin)
    SetPedHeadBlendData(
        ped,
        mother,
        father,
        0,
        mother,
        father,
        0,
        mix,
        skin,
        0,
        false
    )
end

function setOverlay(overlayId, value, opacity)
    local playerPed = cache.ped
    SetPedHeadOverlay(playerPed, overlayId, value, opacity)
end

function setPed(model, setPedCommand)
    debugPrint('Setting ped', model)
    local hashed = nil
    if type(model) == "string" then 
        hashed = joaat(model)
        debugPrint('Model is a string, converting to hash', model, hashed)
    end
    RequestModel(hashed)
    while not HasModelLoaded(hashed) do
      Wait(0)
    end
    SetPlayerModel(cache.playerId, hashed)
    Wait(200)
    SetModelAsNoLongerNeeded(hashed)
    Wait(250)
    local isPedFreemode = isPedFreemodePed(cache.ped)

    SetPedDefaultComponentVariation(cache.ped)
    if isPedFreemode then 
        debugPrint('Setting ped to freemode')
        SetPedHeadBlendData(cache.ped, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    end
    sendReactMessage('setCurrentPed', model)

    newPed = model

    getAllValues()
    if Config.nui.whenPedDisableUneededMenus then 
        sendReactMessage('updatePedStuff', isPedFreemode)
    end

    if setPedCommand then 
        saveCharacter('bank', false, true)
    end
    cachePed()
end

exports('setPed', setPed)

RegisterNetEvent('pure-clothing:setPed', setPed)

function setPedNui(model)
    debugPrint('Setting ped', model)
    local hashed = nil
    if type(model) == "string" then 
        hashed = joaat(model)
        debugPrint('Model is a string, converting to hash', model, hashed)
    end
    RequestModel(hashed)
    while not HasModelLoaded(hashed) do
      Wait(0)
    end
    SetPlayerModel(cache.playerId, hashed)
    Wait(200)
    SetModelAsNoLongerNeeded(hashed)
    Wait(250)
    local isPedFreemode = isPedFreemodePed(cache.ped)

    SetPedDefaultComponentVariation(cache.ped)
    if isPedFreemode then 
        debugPrint('Setting ped to freemode')
        SetPedHeadBlendData(cache.ped, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    end
    sendReactMessage('setCurrentPed', model)

    newPed = model

    getAllValues()
    if Config.nui.whenPedDisableUneededMenus then 
        sendReactMessage('updatePedStuff', isPedFreemode)
    end
    setDefaultClothing()
    sendReactMessage('firstCharacter', isPedFreemode)
    cachePed()
end


function setEyeColour(data)
    if data then 
        SetPedEyeColor(cache.ped, data)
    end
end

function setDefaultClothing()
    for k,v in pairs(clothingTable) do 
        if v.type == 'variation' then 
            setVariation(v.id, {value = v.value1, name = k})
        elseif v.type == 'prop' then
            setProp(v.id, {value = v.value1, name = k})
        elseif v.type == 'overlay' then
            setOverlay(v.id, v.value1, v.value2)
        end
    end
end
