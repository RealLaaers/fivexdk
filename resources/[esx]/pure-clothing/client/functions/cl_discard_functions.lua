function discardAppearance(data)
    debugPrint('discardAppearance', json.encode(data))
    if data.currentPage == 'clothing' or data.currentPage == 'outfits' then 
        discardClothing()
    elseif data.currentPage == 'createCharacter' then
        discardCharacter()
    elseif data.currentPage == 'hair' then
        discardHair()
    elseif data.currentPage == 'tattoo' then
        discardTattoos()
    end
    openCreateCharacterMenu = false
    notifySystem({
        title = _Lang('cancelled.title'),
        description = _Lang('cancelled.message'),
        type = 'error',
        position = Config.libText.notfiyPoistion,
    })
end

function discardClothing()
    local currentClothing, oldClothing = getClothingValuesForSaving()
    debugPrint('Old clothing', json.encode(oldClothing))
    debugPrint('Current clothing', json.encode(currentClothing))
    loadClothing(cache.ped, oldClothing)
    getClothingValues()
    getPropValues()
end

function discardCharacter()
    local currentClothing, oldClothing, currentHair, oldHair, currentFace, oldFace = getCharacterValuesForSaving()
    local currentPed, oldPed = getPedValuesForSaving()
    if currentPed ~= oldPed then 
        setPed(oldPed)
    end
    local isPedFreemode = isPedFreemodePed(cache.ped)
    if isPedFreemode then 
        loadCharacter(cache.ped, oldFace)
        getFaceFeaturesValues()
    end
    loadClothing(cache.ped, oldClothing)
    loadHair(cache.ped, oldHair)
    getClothingValues()
    getPropValues()
    getHairValues()
    charactersFirstCharacter = false
    newPed = nil
    if onCancelFunc and Config.framework == 'esx' then 
        onCancelFunc()
    end
end

function discardHair()
    local currentHair, oldHair = getHairValuesForSaving()
    loadHair(cache.ped, oldHair)
    getHairValues()
end

function discardTattoos()
    loadAllTattoosFromDB()
    discardClothing()
end