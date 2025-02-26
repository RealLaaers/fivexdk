if Config.framework ~= 'qbcore' then return end

function addEventToRadial(event, title)
    local table = {
        id = 'pure_clothing_radial',
        title = title,
        icon = 'shirt',
        type = 'client',
        event = event,
        shouldClose = true,
    }
    exports[Config.stores.radialMenu]:AddOption(table, 'pure_clothing_radial')
end

function removeEventFromRadial(event)
    exports[Config.stores.radialMenu]:RemoveOption(event)
end

function addTargetToEntity(entity, table)
    exports['qb-target']:AddTargetEntity(entity, table)
end

function addTargetToCoords(coords, boxSize, table, name)
    exports['qb-target']:AddBoxZone(name, coords, boxSize.x, boxSize.y, {
        name = name,
        debugPoly = Config.Debug,
        minZ = coords.z - 2,
        maxZ = coords.z + 2,
        heading = coords.w
    }, table)
end

function removeZone(name)
    exports['qb-target']:RemoveBoxZone(name)
end