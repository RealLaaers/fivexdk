local ESX = exports['es_extended']:getSharedObject()

lib.callback.register('grisen_drugrun:startRun', function(source, drugType)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return nil end
    return drugType
end)

lib.callback.register('grisen_drugrun:getRunLocation', function(source, drugType)
    local location = Config.RunLocations[math.random(1, #Config.RunLocations)]
    return location
end)

lib.callback.register('grisen_drugrun:giveItems', function(source, drugType)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end

    if drugType == 'meth' then
        xPlayer.addInventoryItem('meth_pooch', 5)
    elseif drugType == 'coke' then
        xPlayer.addInventoryItem('coke_pooch', 5)
    elseif drugType == 'heroin' then
        xPlayer.addInventoryItem('heroin_pooch', 5)
    end
end)

lib.callback.register('grisen_drugrun:getNPCLocations', function(source)
    local locations = {}
    local usedLocations = {}
    
    for drugType, npcData in pairs(Config.NPCs) do
        local availableLocations = {}
        for i, loc in ipairs(npcData.locations) do
            if not usedLocations[i] then
                table.insert(availableLocations, loc)
            end
        end
        local chosenLocation = availableLocations[math.random(1, #availableLocations)]
        local index = table.find(npcData.locations, function(v) return v == chosenLocation end)
        usedLocations[index] = true
        locations[drugType] = chosenLocation
    end
    
    return locations
end)

function table.find(t, fn)
    for i, v in ipairs(t) do
        if fn(v) then return i end
    end
    return nil
end

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        for drugType, npcData in pairs(Config.NPCs) do
            npcData.currentCoords = nil
        end
    end
end)