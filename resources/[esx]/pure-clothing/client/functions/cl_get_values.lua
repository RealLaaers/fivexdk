function getMaxValues()
    maxValues = {}
    local playerPed = cache.ped
    for k,v in pairs(clothingTable) do 
        if v.type == 'variation' then 
            v.maxValue1 = GetNumberOfPedDrawableVariations(playerPed, v.id) - 1
            v.maxValue2 = GetNumberOfPedTextureVariations(playerPed, v.id, GetPedDrawableVariation(cache.ped, v.id))
            maxValues[#maxValues + 1] = {name = k, maxValue1 = v.maxValue1, maxValue2 = v.maxValue2, type = v.type, number = v.id, value1 = v.value1, value2 = v.value2}
        end

        if v.type == 'prop' then 
            v.maxValue1 = GetNumberOfPedPropDrawableVariations(playerPed, v.id) - 1
            v.maxValue2 = GetNumberOfPedPropTextureVariations(playerPed, v.id, GetPedPropIndex(cache.ped, v.id))
            maxValues[#maxValues + 1] = {name = k, maxValue1 = v.maxValue1, maxValue2 = v.maxValue2, type = v.type, number = v.id, value1 = v.value1, value2 = v.value2}
        end

        if v.type == 'overlay' then 
            v.maxValue1 = GetNumHeadOverlayValues(v.id) - 1
            maxValues[#maxValues + 1] = {name = k, maxValue1 = v.maxValue1, type = v.type, number = v.id, value1 = v.value1}
        end
    end
    sendReactMessage('setMaxValues', maxValues)
    debugPrint(json.encode(maxValues))
end

function getTattoos()
    local pedGender = getPedGender(cache.ped)
    lib.callback('pure-clothing:getTattooTable', false, function(tattooTable)
        debugPrint('Recieved tattoo table', #tattooTable['torso'], ' <- torso tattoos available')
        tattooTableRecieved = tattooTable
        sendReactMessage('updateTattoos', tattooTable)
    end, pedGender)
end

function findCollectionFromTattoo(name)
    for k, v in pairs(tattooCollectionTable) do 
        if string.find(name, k) then 
            return v
        end
    end
    return
end

function getOutfitsBasedOnJobAndRank()
    local gender = 'male'
    local job = getJobName()
    local rank = getJobGrade()
    if not job or not rank then 
        debugPrint('No job or rank')
        sendReactMessage('updateConfigOutfits', {})
        return
    end
    -- Get the outfits based on the job and rank from the framework!
    local outfits = {}
    local dbOutfits = lib.callback.await('pure-clothing:getJobBasedOutfits', false, job, rank)
    -- if not Config.outfits[job] or not Config.outfits[job][gender] then 
    --     debugPrint('no job based outfits')
    --     sendReactMessage('updateConfigOutfits', {})
    --     return
    -- end
    if Config.outfits[job] and Config.outfits[job][gender] then
        for k,v in pairs(Config.outfits[job][gender]) do 
            if v.minJobGrade then 
                v.id = k
                if rank >= v.minJobGrade then 
                    v.uniqueOutfitid = 'job-' .. v.id
                    table.insert(outfits, v)
                end
            else
                for i = 1, #v.grades do 
                    v.id = k
                    if v.grades[i] == rank then 
                        v.uniqueOutfitid = 'job-' .. v.id
                        table.insert(outfits, v)
                    end
                end
            end
        end
    end
    for i = 1, #dbOutfits do 
        local outfitTable = {
            uniqueOutfitid = 'jobDyn-' .. dbOutfits[i].uniqueOutfitid,
            name = dbOutfits[i].name,
            outfit = {},
        }
        local outTable = dbOutfits[i].outfit
        local newTable = {}
        for i = 1, #outTable do 
            -- print('DB Outfit', outTable[i].name)
            newTable[outTable[i].name] = {outTable[i].value1, outTable[i].value2}
        end
        outfitTable.outfit = newTable
        outfits[#outfits + 1] = outfitTable
    end
    sendReactMessage('updateConfigOutfits', outfits)
    debugPrint('Outfits', json.encode(outfits))
end

function getOutfitsFromDB()
    local outfitTable = lib.callback.await('pure-clothing:getOutfits', false, GetEntityModel(cache.ped))
    outfitTable = outfitTable or {}
    debugPrint('Recieved outfits for player, amount of outfits: ', #outfitTable)
    sendReactMessage('updatePlayerOutfits', outfitTable)
end

function getAllValues()
    getMaxValues()
    getTattoos()
    debugPrint('All Max values sent to NUI')
end

function getAllOufits()
    getOutfitsFromDB()
    getOutfitsBasedOnJobAndRank()
    debugPrint('All outfits sent to NUI')
end

function getFaceFeaturesValues()
    faceFeatureTableValues = {}
    for k,v in pairs(faceFeaturesTable) do 
        if v.id == 'eyeColour' then 
            v.value = GetPedEyeColor(cache.ped)
            faceFeatureTableValues[#faceFeatureTableValues + 1] = {name = k, value = v.value}
        elseif v.id == 'parents' then 
            local motherValue, fatherValue, shapeThird, motherValue2, fatherValue2, skinThird, shapeMix, skinMix, thirdMix = Citizen.InvokeNative(0x2746BD9D88C5C5D0, cache.ped, Citizen.PointerValueIntInitialized(0), Citizen.PointerValueIntInitialized(0), Citizen.PointerValueIntInitialized(0), Citizen.PointerValueIntInitialized(0), Citizen.PointerValueIntInitialized(0), Citizen.PointerValueIntInitialized(0), Citizen.PointerValueFloatInitialized(0), Citizen.PointerValueFloatInitialized(0), Citizen.PointerValueFloatInitialized(0))
            -- convert skin mix and shapemix to 0-100
            shapeMix = math.floor(shapeMix * 100)
            skinMix = math.floor(skinMix * 100)
            local parentsTable = clothingTable['parents']
            for i = 1, #parentsTable.mother do 
                if parentsTable.mother[i] == motherValue then 
                    motherValue = i
                    break
                end
            end
            for i = 1, #parentsTable.father do 
                if parentsTable.father[i] == fatherValue then 
                    fatherValue = i
                    break
                end
            end
            faceFeatureTableValues[#faceFeatureTableValues + 1] = {name = 'parents', motherValue = motherValue, fatherValue = fatherValue, similarityValue = shapeMix, skinColour = skinMix}
        else
            local value = GetPedFaceFeature(cache.ped, v.id)
            value = math.floor((value + 1.0) * 50.0)
            faceFeatureTableValues[#faceFeatureTableValues + 1] = {name = k, value = value}
        end
    end
    debugPrint('Face features', json.encode(faceFeatureTableValues))
    sendReactMessage('updateFaceFeatures', faceFeatureTableValues)
end

function getHairValues()
    hairFeatureTableValues = {}
    for k,v in pairs(clothingTable) do 
        if v.type == 'overlay' then 
            local retval, newValue, colourType, firstColor, secondColor, opacity = GetPedHeadOverlayData(cache.ped, v.id)
            -- convert opacity to 0-100
            newOpacity = math.floor(opacity * 100)
            if v.colourType == 0 then 
                hairFeatureTableValues[#hairFeatureTableValues + 1] = {name = k, value = newValue, opacity = newOpacity}
            else
                hairFeatureTableValues[#hairFeatureTableValues + 1] = {name = k, value = newValue, colour1 = firstColor, opacity = newOpacity}
            end
        end
    end
    hairFeatureTableValues[#hairFeatureTableValues + 1] = {name = 'hair', value = GetPedDrawableVariation(cache.ped, 2), colour1 = GetPedHairColor(cache.ped), colour2 = GetPedHairHighlightColor(cache.ped), value2 = GetPedTextureVariation(cache.ped, 2)}
    debugPrint('Hair features', json.encode(hairFeatureTableValues))
    sendReactMessage('updateHairFeatures', hairFeatureTableValues)
end

function getClothingValues()
    clothingTableValues = {}
    for k,v in pairs(clothingForValuesTable) do 
        if v.type == 'variation' then 
            clothingTableValues[#clothingTableValues + 1] = {name = k, value1 = GetPedDrawableVariation(cache.ped, v.id), value2 = GetPedTextureVariation(cache.ped, v.id)}
        end
    end
    debugPrint('Clothing features', json.encode(clothingTableValues))
    sendReactMessage('updateClothingFeatures', clothingTableValues)
end

function getPropValues()
    propTableValues = {}
    for k,v in pairs(propsForvaluesTable) do 
        if v.type == 'prop' then 
            propTableValues[#propTableValues + 1] = {name = k, value1 = GetPedPropIndex(cache.ped, v.id), value2 = GetPedPropTextureIndex(cache.ped, v.id)}
        elseif v.type == 'variation' then 
            propTableValues[#propTableValues + 1] = {name = k, value1 = GetPedDrawableVariation(cache.ped, v.id), value2 = GetPedTextureVariation(cache.ped, v.id)}
        end
    end
    debugPrint('Prop features', json.encode(propTableValues))
    sendReactMessage('updatePropFeatures', propTableValues)
end

function getClothingValuesForSaving()
    currentAllClothing = {}
    commandClothing = {}
    for k,v in pairs(clothingForValuesTable) do 
        if v.type == 'variation' then 
            currentAllClothing[#currentAllClothing + 1] = {name = k, value1 = GetPedDrawableVariation(cache.ped, v.id), value2 = GetPedTextureVariation(cache.ped, v.id)}
            commandClothing[k] = {value1 = GetPedDrawableVariation(cache.ped, v.id), value2 = GetPedTextureVariation(cache.ped, v.id)}
        end
    end
    for k,v in pairs(propsForvaluesTable) do 
        if v.type == 'prop' then 
            currentAllClothing[#currentAllClothing + 1] = {name = k, value1 = GetPedPropIndex(cache.ped, v.id), value2 = GetPedPropTextureIndex(cache.ped, v.id)}
            commandClothing[k] = {value1 = GetPedPropIndex(cache.ped, v.id), value2 = GetPedPropTextureIndex(cache.ped, v.id)}
        elseif v.type == 'variation' then 
            currentAllClothing[#currentAllClothing + 1] = {name = k, value1 = GetPedDrawableVariation(cache.ped, v.id), value2 = GetPedTextureVariation(cache.ped, v.id)}
            commandClothing[k] = {value1 = GetPedDrawableVariation(cache.ped, v.id), value2 = GetPedTextureVariation(cache.ped, v.id)}
        end
    end
    for k,v in pairs(propTableValues) do 
        clothingTableValues[#clothingTableValues + 1] = v
    end
    return currentAllClothing, clothingTableValues
end

function getHairValuesForSaving()
    currentAllHair = {}
    for k,v in pairs(clothingTable) do 
        if v.type == 'overlay' then 
            local retval, newValue, colourType, firstColor, secondColor, opacity = GetPedHeadOverlayData(cache.ped, v.id)
            -- convert opacity to 0-100
            newOpacity = math.floor(opacity * 100)
            if v.colourType == 0 then 
                currentAllHair[#currentAllHair + 1] = {name = k, value = newValue, opacity = newOpacity}
            else
                currentAllHair[#currentAllHair + 1] = {name = k, value = newValue, colour1 = firstColor, opacity = newOpacity}
            end
        end
    end
    currentAllHair[#currentAllHair + 1] = {name = 'hair', value = GetPedDrawableVariation(cache.ped, 2), colour1 = GetPedHairColor(cache.ped), colour2 = GetPedHairHighlightColor(cache.ped), value2 = GetPedTextureVariation(cache.ped, 2)}
    return currentAllHair, hairFeatureTableValues
end

function getFaceFeaturesValuesForSaving()
    currentAllFace = {}
    for k,v in pairs(faceFeaturesTable) do 
        if v.id == 'eyeColour' then 
            v.value = GetPedEyeColor(cache.ped)
            currentAllFace[#currentAllFace + 1] = {name = k, value = v.value}
        elseif v.id == 'parents' then 
            local motherValue, fatherValue, shapeThird, motherValue2, fatherValue2, skinThird, shapeMix, skinMix, thirdMix = Citizen.InvokeNative(0x2746BD9D88C5C5D0, cache.ped, Citizen.PointerValueIntInitialized(0), Citizen.PointerValueIntInitialized(0), Citizen.PointerValueIntInitialized(0), Citizen.PointerValueIntInitialized(0), Citizen.PointerValueIntInitialized(0), Citizen.PointerValueIntInitialized(0), Citizen.PointerValueFloatInitialized(0), Citizen.PointerValueFloatInitialized(0), Citizen.PointerValueFloatInitialized(0))
            -- convert skin mix and shapemix to 0-100
            shapeMix = math.floor(shapeMix * 100)
            skinMix = math.floor(skinMix * 100)
            local parentsTable = clothingTable['parents']
            for i = 1, #parentsTable.mother do 
                if parentsTable.mother[i] == motherValue then 
                    motherValue = i
                    break
                end
            end
            for i = 1, #parentsTable.father do 
                if parentsTable.father[i] == fatherValue then 
                    fatherValue = i
                    break
                end
            end
            currentAllFace[#currentAllFace + 1] = {name = 'parents', motherValue = motherValue, fatherValue = fatherValue, similarityValue = shapeMix, skinColour = skinMix}
        else
            local value = GetPedFaceFeature(cache.ped, v.id)
            value = math.floor((value + 1.0) * 50.0)
            currentAllFace[#currentAllFace + 1] = {name = k, value = value}
        end
    end
    return currentAllFace, faceFeatureTableValues
end

function getCharacterValuesForSaving()
    local curClothing, oldClothing = getClothingValuesForSaving()
    local curHair, oldHair = getHairValuesForSaving()
    local curFace, oldFace = getFaceFeaturesValuesForSaving()
    return curClothing, oldClothing, curHair, oldHair, curFace, oldFace
end

function getFirstCharacterValuesForSaving()
    local curClothing, oldClothing = getClothingValuesForSaving()
    local curHair, oldHair = getHairValuesForSaving()
    local curFace, oldFace = getFaceFeaturesValuesForSaving()
    return curClothing, curHair, curFace
end

function getTattooValuesForSaving()
    return currentAllTattoos, cachedTattoos
end

function getPedValuesForSaving()
    debugPrint('Getting ped values for saving', newPed, currentPedModel)
    if not newPed or not currentPedModel then 
        debugPrint('No ped values to save')
        return currentPedModel, currentPedModel
    end
    return newPed, currentPedModel
end