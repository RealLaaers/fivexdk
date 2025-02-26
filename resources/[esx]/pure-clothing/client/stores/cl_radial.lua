local radialEvents = {
    clothing = {'pure-clothing:openClothing', _Lang('showTextUI.clothing')},
    outfits = {'pure-clothing:openOutfits', _Lang('showTextUI.personal')},
    personal = {'pure-clothing:openOutfits', _Lang('showTextUI.personal')},
    barber = {'pure-clothing:openHair', _Lang('showTextUI.barber')},
    tattoo = {'pure-clothing:openTattoos', _Lang('showTextUI.tattoo')},
    surgeon = {'pure-clothing:openSurgeon', _Lang('showTextUI.surgeon')},
}

local addedToRadial = false

function addToRadial()
    if Config.stores.targetingType ~= 'radial' then return end
    if not currentStore then 
        removeFromRadial()
        return
    end

    debugPrint('Adding to radial menu', currentStore.name, json.encode(radialEvents[currentStore.name]))
    if radialEvents[currentStore.name] then 
        local event, title = radialEvents[currentStore.name][1], radialEvents[currentStore.name][2]
        debugPrint(event, title)
        addedToRadial = true
        addEventToRadial(event, title)
    end
end

function removeFromRadial()
    if Config.stores.targetingType ~= 'radial' then return end
    if not addedToRadial then return end
    addedToRadial = false
    removeEventFromRadial('pure_clothing_radial')
end

AddEventHandler('onResourceStop', function(resource)
    if Config.stores.targetingType ~= 'radial' then return end
    if resource == GetCurrentResourceName() then
        if GetResourceState(Config.stores.radialMenu) == 'started' then
            removeEventFromRadial('pure_clothing_radial') 
        end
    end
end)