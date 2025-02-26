if Config.framework ~= 'oxcore' then return end

local createdZones = {}

function oxConvertOptions(options, distance)
    for k,v in pairs(options) do 
        v.name = v.label
        v.onSelect = v.action
        v.distance = distance
        v.groups = v.job or v.gang
        v.canInteract = v.canInteract or function() return true end
    end
    return options
end

function addEventToRadial(event, title)
    local table = {
        id = 'pure_clothing_radial',
        label = title,
        icon = 'shirt',
        event = event,
        onSelect = function() 
            TriggerEvent(event)
        end
    }
    lib.addRadialItem(table)
end

function removeEventFromRadial(event)
    lib.removeRadialItem(event)
end

function addTargetToEntity(entity, table)
    exports['ox_target']:addLocalEntity(entity, oxConvertOptions(table.options, table.distance))
end

function addTargetToCoords(coords, boxSize, table, name)
    local rotation = table.rotation or 0.0
    createdZones[name] = exports['ox_target']:addZone({
        coords = coords,
        size = boxSize,
        rotation = rotation,
        debug = Config.Debug,
        options = oxConvertOptions(table.options, table.distance)
    })
end

function removeZone(name)
    exports['ox_target']:removeZome(createdZones[name])
end