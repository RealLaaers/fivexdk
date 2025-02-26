local blips = {}

function createBlip(config)
    local blip = AddBlipForCoord(config.coords.x, config.coords.y, config.coords.z)
    SetBlipSprite(blip, config.sprite)
    SetBlipColour(blip, config.color)
    SetBlipScale(blip, config.scale)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(config.name)
    EndTextCommandSetBlipName(blip)
    return blip
end

function canSeeBlip(config, clothingConfig)
    if not clothingConfig.jobs and not clothingConfig.gang then return (config.enabled and true or false) end
    if clothingConfig.gang and clothingConfig.gang == getGangName() then return true end
    if clothingConfig.jobs and not clothingConfig.gang then 
        for i = 1, #clothingConfig.jobs do 
            if clothingConfig.jobs[i] == getJobName() then 
                return (config.enabled and true or false)
            end
        end
    end

    return false
end

function createBlips()
    for k,v in pairs(Config.locations.clothing) do 
        local config = Config.blips[Config.locations.clothing[k].type]
        config.coords = Config.locations.clothing[k].coords
        if canSeeBlip(config, Config.locations.clothing[k]) then 
            local blip = createBlip(config)
            blips[#blips + 1] = blip
        end
    end
    for k,v in pairs(Config.locations.jobBasedClothing) do 
        local config = Config.blips[Config.locations.jobBasedClothing[k].type]
        config.coords = Config.locations.jobBasedClothing[k].coords
        if canSeeBlip(config, Config.locations.jobBasedClothing[k]) then 
            local blip = createBlip(config)
            blips[#blips + 1] = blip
        end
    end
end

function resestBlips()
    for i = 1, #blips do
        RemoveBlip(blips[i])
    end
    blips = {}
    createBlips()
end