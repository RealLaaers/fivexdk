function initiateApperanceWithPed(ped, appearance)
    if not appearance then 
        debugPrint('No appearance table')
        return
    end
    debugPrint('Appearance table', json.encode(appearance))
    local isPedFreemode = isPedFreemodePed(ped)
    if not isPedFreemode then
        if appearance.clothing then loadClothing(ped, appearance.clothing) end
        if appearance.hair then loadHair(ped, appearance.hair) end
        return
    end
    if appearance.faceFeatures then loadCharacter(ped, appearance.faceFeatures) end
    if appearance.clothing then loadClothing(ped, appearance.clothing) end
    if appearance.hair then loadHair(ped, appearance.hair) end
    -- need a better way to do tattoos laoding
    ClearPedDecorations(ped)
    if not appearance.tattoos then return end
    for k,v in pairs(appearance.tattoos) do 
        for i = 1, #v do
            local tattoo = v[i]
            loadTattoo(ped, tattoo)
        end
    end
    return
end

exports('initiateApperanceWithPed', initiateApperanceWithPed)

RegisterNetEvent('pure-clothing:initiateApperanceWithPed', function(ped, appearance)
    initiateApperanceWithPed(ped, appearance)
end)

function initiateApperance()
    updatePlayerData()
    Wait(250)
    resestBlips()
    local characterResult, clothingResult, hairResult, tattoosResult, model = lib.callback.await('pure-clothing:getCharacter', false)
    if not characterResult then 
        -- print('NO CHARACTER TABLE WTF BLAZE')
        -- if Config.framework == 'esx' then return end
        debugPrint('No character table - havent used migration')
        -- openMenu('createCharacter', true)
        Wait(500)
        local model = 'mp_m_freemode_01'
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
        print('sigma')
        openMenu('createCharacter', true)
        return
    end
    debugPrint('Character table', json.encode(characterResult))
    setPed(model)
    Wait(100)
    local isPedFreemode = isPedFreemodePed(cache.ped)
    if not isPedFreemode then
        loadClothing(cache.ped, clothingResult)
        loadHair(cache.ped, hairResult)
        return true
    end 
    loadCharacter(cache.ped, characterResult)
    loadClothing(cache.ped, clothingResult)
    loadHair(cache.ped, hairResult)
    loadAllTattoosFromDB()
    getClothingValuesForSaving()
    return true
end

exports('initiateApperance', initiateApperance)

RegisterNetEvent('pure-clothing:initiateApperance', function()
    initiateApperance()
end)

function loadClothing(ped, data)
    if not data then return end
    if not ped then ped = cache.ped end
    for i = 1, #data do 
        local clotTble = clothingTable[data[i].name]
        local type = clotTble.type
        local id = clotTble.id
        if type == 'variation' then
            SetPedComponentVariation(ped, tonumber(id), tonumber(data[i].value1), tonumber(data[i].value2), 0)
        elseif type == 'prop' then
            if data[i].value1 == -1 then
                ClearPedProp(ped, id)
            else
                SetPedPropIndex(ped, id, data[i].value1, data[i].value2, 0)
            end
        end
    end
end

function loadHair(ped, data)
    if not data then return end
    for i = 1, #data do 
        local clotTble = clothingTable[data[i].name]
        local type = clotTble.type
        local id = clotTble.id
        if type == 'variation' then
            SetPedComponentVariation(ped, id, data[i].value, 0.0, 0)
            SetPedHairColor(ped, data[i].colour1, data[i].colour2)
        elseif type == 'overlay' then
            local opacity = data[i].opacity / 100 -- converts the 0-100 to 0.0 <-> 1.0
            if data[i].value == 255 then 
                data[i].value = -1
            end
            SetPedHeadOverlay(ped, id, data[i].value, opacity)
            local overlayId = id
            local colourType = clotTble.colourType
            SetPedHeadOverlayColor(ped, overlayId, colourType, tonumber(data[i].colour1), 1.0)
        end
    end
end

function loadCharacter(ped, data)
    if not data then return end
    debugPrint('Loading character', ped, json.encode(data))
    for i = 1, #data do 
        -- debugPrint('Loading character', data[i].name)
        local clotTble = faceFeaturesTable[data[i].name]
        if not clotTble then 
            debugPrint('Invalid face feature table name', data[i].name)
            return 
        end
        local id = clotTble.id
        if id == 'eyeColour' then 
            SetPedEyeColor(ped, data[i].value)
        elseif id == 'parents' then 
            local motherTable = clothingTable['parents'].mother
            local fatherTable = clothingTable['parents'].father
            local mother = motherTable[data[i].motherValue]
            local father = fatherTable[data[i].fatherValue]
            local mix = data[i].similarityValue / 100 -- converts the 0-100 to 0.0 <-> 1.0
            local skin = data[i].skinColour / 100 -- converts the 0-100 to 0.0 <-> 1.0
            setParents(ped, mother, father, mix, skin)
        else
            local scale = (data[i].value / 50) - 1 -- converts the 0-100 to -1.0 <-> 1.0
            SetPedFaceFeature(ped, id, scale)
        end
    end
end

function loadDefaultPed()
    local model = 'mp_m_freemode_01'
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
    SetPedDefaultComponentVariation(cache.ped)
    return
end

exports('loadDefaultPed', loadDefaultPed)