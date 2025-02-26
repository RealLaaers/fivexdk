function openClothing()
    getClothingValues()
    getPropValues()
end

function openCreateCharacter(isFirstCharacter)
    debugPrint('Opening create character', isFirstCharacter)
    if isFirstCharacter then 
        SetPedHeadBlendData(cache.ped, 0, 0, 0, 0, 0, 0, 0, 0, 0, false)
        setDefaultClothing()
        sendReactMessage('firstCharacter', true)
        charactersFirstCharacter = true
        return
    end
    local isPedFreemode = isPedFreemodePed(cache.ped)
    if not isPedFreemode then 
        getClothingValues()
        getPropValues()
        getHairValues()
        return
    end
    getFaceFeaturesValues()
    getClothingValues()
    getPropValues()
    getHairValues()
end

function openHair()
    getHairValues()
end

function openTattoos()
    loadAllTattoosFromDB()
    getClothingValues()
    getPropValues()
    Wait(150)
    loadClothing(cache.ped, Config.removeClothing)
end
