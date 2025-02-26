if Config.stores.targetingType == 'target' then return end

currentStore = nil

local zones = {
    store = {},
    jobBasedClothing = {},
    personalOutfits = {},
}

function getZoneFromID(id, zone)
    for i = 1, #zone do 
        if zone[i].id == id then 
            return i
        end
    end
end

function removeZones()
    for i = 1, #zones.store do 
        zones.store[i]:remove()
    end

    for i = 1, #zones.jobBasedClothing do 
        zones.jobBasedClothing[i]:remove()
    end

    if not zones.personalOutfits then return end
    for i = 1, #zones.personalOutfits do 
        zones.personalOutfits[i]:remove()
    end
end

function setupZones()
    for k,v in pairs(Config.locations.clothing) do 
        zones.store[#zones.store + 1] = initiateZone(v, onStoreEnter, onZoneExit)
    end

    if not Config.locations.jobBasedClothing then return end
    for k,v in pairs(Config.locations.jobBasedClothing) do 
        zones.jobBasedClothing[#zones.jobBasedClothing + 1] = initiateZone(v, onJobBasedClothingEnter, onZoneExit)
    end

    if not Config.locations.personalOutfits then return end
    for k,v in pairs(Config.locations.personalOutfits) do 
        zones.personalOutfits[#zones.personalOutfits + 1] = initiateZone(v, onPersonalClothingEnter, onZoneExit)
    end
end

function initiateZone(table, onEnter, onExit)
    return lib.zones.box({
        coords = table.coords,
        rotation = table.rotation,
        size = table.boxSize,
        debug = Config.debug,
        onEnter = onEnter,
        onExit = onExit,
    })
end

local sleep = 2000
function loopZones()
    Wait(sleep)
    sleep = 1000
    while true do 
        if currentStore then 
            sleep = 5
            if IsControlJustReleased(0, 38) then 
                lib.hideTextUI()
                if currentStore.name == 'clothing' then
                    openMenu('clothing')
                elseif currentStore.name == 'outfits' or currentStore.name == 'personal' then 
                    openMenu('outfits')
                elseif currentStore.name == 'barber' then 
                    openMenu('hair')
                elseif currentStore.name == 'tattoo' then 
                    openMenu('tattoo')
                elseif currentStore.name == 'surgeon' then
                    openMenu('createCharacter')
                end
            end
        end
        Wait(sleep)
    end
end

function onStoreEnter(data)
    local index = getZoneFromID(data.id, zones.store)
    local store = Config.locations.clothing[index]

    currentStore = {
        name = store.type,
        id = data.id,
    }
    local prefix = Config.stores.targetingType == 'radial' and '' or '[E] - '
    local text = ''
    if Config.payPerItemOfClothing then 
        text = prefix .. _Lang('showTextUI.'.. store.type)
    else 
        text = prefix .. _Lang('showTextUI.'.. store.type)
    end
    lib.showTextUI(text, {position = Config.libText.textUIPosition})
    addToRadial()
end

function onJobBasedClothingEnter(data)
    local index = getZoneFromID(data.id, zones.jobBasedClothing)
    local store = Config.locations.jobBasedClothing[index]
    if not store.jobs and not store.gang then debugPrint('no job or gang!!!') return end
    local hasGang = compareGangs(store.gang)
    local isAllowed = false
    if store.jobs then 
        for i = 1, #store.jobs do 
            local hasJob = compareJobs(store.jobs[i])
            if hasJob then 
                isAllowed = true
                break
            end
        end
    end
    if isAllowed and checkDuty() or hasGang then 
        currentStore = {
            name = store.type,
            id = data.id,
        }
        local prefix = Config.stores.targetingType == 'radial' and '' or '[E] '
        local text = prefix .. _Lang('showTextUI.'.. store.type)
        lib.showTextUI(text, {position = Config.libText.textUIPosition})
        addToRadial()
    end
end

function onPersonalClothingEnter(data)
    local index = getZoneFromID(data.id, zones.personalOutfits)
    local store = Config.locations.personalOutfits[index]
    if not checkPlayerOutfitClothing(store) then return debugPrint('not in table') end
    currentStore = {
        name = store.type,
        id = data.id,
    }
    local prefix = Config.stores.targetingType == 'radial' and '' or '[E] '
    local text = prefix .. _Lang('showTextUI.'.. store.type)
    lib.showTextUI(text, {position = Config.libText.textUIPosition})
    addToRadial()
end

function onZoneExit()
    currentStore = nil
    removeFromRadial()
    lib.hideTextUI()
end

CreateThread(function()
    setupZones()
    Wait(100)
    if Config.stores.targetingType == 'interactionKey' then 
        loopZones()
    end
end)

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        removeZones()
    end
end)