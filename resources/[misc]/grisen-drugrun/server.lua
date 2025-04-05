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
    for drugType, npcData in pairs(Config.NPCs) do
        local chosenLocation = npcData.locations[math.random(1, #npcData.locations)]
        locations[drugType] = chosenLocation
    end
    return locations
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        for drugType, npcData in pairs(Config.NPCs) do
            npcData.currentCoords = nil
        end
    end
end)