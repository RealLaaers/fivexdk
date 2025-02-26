function saveAppearance(data)
    local page = data.currentPage
    debugPrint('saveButton', page)
    if page == 'clothing' or page == 'outfits' then 
        saveClothing(data.payment)
    elseif page == 'createCharacter' then
        saveCharacter(data.payment, charactersFirstCharacter)
        charactersFirstCharacter = false
    elseif page == 'hair' then
        saveHair(data.payment)
    elseif page == 'tattoo' then
        saveTattoos(data.payment)
    end
    openCreateCharacterMenu = false
    -- notifySystem({
    --     title = _Lang('saved.title'),
    --     description = _Lang('saved.message'),
    --     type = 'success',
    --     position = Config.libText.notfiyPoistion,
    -- })
end


function saveClothing(paymentType)
    local currentClothing, oldClothing = getClothingValuesForSaving()
    debugPrint('Saving clothing', json.encode(currentClothing))
    debugPrint('Old clothing', json.encode(oldClothing))
    local price = generateClothingPayment()
    local result = lib.callback.await('pure-clothing:removeMoney', false, price, paymentType)
    if result then 
        debugPrint('Paid for clothing', json.encode(currentClothing))
        TriggerServerEvent('pure-clothing:saveClothing', currentClothing)
    end
end

function saveCharacter(paymentType, isFirstCharacter, noPayment)
    TriggerEvent('pure-clothing:savedCharacter', isFirstCharacter)
    if isFirstCharacter then 
        debugPrint('Saving first character')
        local currentClothing, currentHair, currentFace = getFirstCharacterValuesForSaving()
        debugPrint('Saving clothing', json.encode(currentClothing))
        debugPrint('Saving hair', json.encode(currentHair))
        debugPrint('Saving face', json.encode(currentFace))
        local modelHash = GetEntityModel(cache.ped)
        if not modelHash then 
            print('NO MODEL???')
        end
        local currentTattoos, oldTattoos = getTattooValuesForSaving()
        if not newPed then 
            newPed = currentPedModel
        end
        TriggerServerEvent('pure-clothing:saveFirstCharacter', currentClothing, currentHair, currentFace, newPed, modelHash, currentTattoos)
        if onCancelFunc and Config.framework == 'esx' then 
            onCancelFunc()
        end
    else
        local currentClothing, oldClothing, currentHair, oldHair, currentFace, oldFace = getCharacterValuesForSaving()
        local currentPed, oldPed = getPedValuesForSaving()
        local currentTattoos, oldTattoos = getTattooValuesForSaving()
        debugPrint('Saving clothing', json.encode(currentClothing))
        debugPrint('Old clothing', json.encode(oldClothing))
        debugPrint('Saving hair', json.encode(currentHair))
        debugPrint('Old hair', json.encode(oldHair))
        debugPrint('Saving face', json.encode(currentFace))
        debugPrint('Old face', json.encode(oldFace))
        debugPrint('Saving ped', json.encode(currentPed))
        debugPrint('Old ped', json.encode(oldPed))
        local price = Config.priceForMenus.surgeon
        if noPayment then 
            TriggerServerEvent('pure-clothing:saveCharacter', currentClothing, currentHair, currentFace, currentPed, GetEntityModel(cache.ped), currentTattoos)
            return 
        end
        local result = lib.callback.await('pure-clothing:removeMoney', false, price, paymentType)
        debugPrint('Saving tattoos', json.encode(currentTattoos))
        if result then 
            debugPrint('Paid for character', json.encode(currentClothing))
            TriggerServerEvent('pure-clothing:saveCharacter', currentClothing, currentHair, currentFace, currentPed, GetEntityModel(cache.ped), currentTattoos)
        end
    end
end

function saveHair(paymentType)
    local currentHair, oldHair = getHairValuesForSaving()
    debugPrint('Saving hair', json.encode(currentHair))
    debugPrint('Old hair', json.encode(oldHair))
    local price = Config.priceForMenus.barber
    local result = lib.callback.await('pure-clothing:removeMoney', false, price, paymentType)
    if result then 
        debugPrint('Paid for hair', json.encode(currentClothing))
        TriggerServerEvent('pure-clothing:saveHair', currentHair)    
    end
end

function saveTattoos(paymentType)
    local currentTattoos, oldTattoos = getTattooValuesForSaving()
    debugPrint('Saving tattoos', json.encode(currentTattoos))
    debugPrint('Old tattoos', json.encode(oldTattoos))
    discardClothing()
    local price = Config.priceForMenus.tattoo
    local result = lib.callback.await('pure-clothing:removeMoney', false, price, paymentType)
    if result then 
        debugPrint('Paid for tattoos', json.encode(currentTattoos))
        TriggerServerEvent('pure-clothing:saveTattoos', currentTattoos)
    end
end
