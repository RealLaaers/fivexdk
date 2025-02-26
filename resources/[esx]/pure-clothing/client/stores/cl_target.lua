if Config.stores.targetingType ~= 'target' then return end

local pedsToSpawn = {
    store = {},
    jobBasedClothing = {},
    personalOutfits = {},
}

local actionTable = {
    ['clothing'] = 'clothing',
    ['tattoo'] = 'tattoo',
    ['barber'] = 'hair',
    ['surgeon'] = 'createCharacter',
    ['personal'] = 'outfits',
}

function spawnPed(model, coords, animation)
    local hashed = nil
    if type(model) == "string" then 
        hashed = joaat(model)
        -- debugPrint('Model is a string, converting to hash', model, hashed)
    end
    lib.requestModel(hashed)
    local ped = CreatePed(0, hashed, coords.x, coords.y, coords.z, coords.w, false, true)
    PlaceObjectOnGroundProperly(ped)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityVisible(ped, true)
    FreezeEntityPosition(ped, true)
    if animation then 
        TaskStartScenarioInPlace(ped, animation, true)
    end
    return ped
end

function setupTargets()
    for k,v in pairs(Config.locations.clothing) do 
        local targetConfig = Config.targets[v.type]
        local action = nil 
        if not actionTable[v.type] then debugPrint('no action for: ' ..v.type) return end
        local tableForTarget = {
            options = {{
                type = 'client',
                action = function()
                    openMenu(actionTable[v.type])
                end,
                icon = targetConfig.icon,
                label = targetConfig.text,
            }},
            distance = targetConfig.distance,
            rotation = v.rotation,
        }
        local name = v.type .. '-' .. k
        if Config.stores.enablePedForTargeting then 
            pedsToSpawn.store[k] = spawnPed(targetConfig.model, v.coords, targetConfig.scenario)
            addTargetToEntity(pedsToSpawn.store[k], tableForTarget)
        else 
            addTargetToCoords(v.coords, v.boxSize, tableForTarget, name)
        end
    end

    if not Config.locations.jobBasedClothing then return end
    for k,v in pairs(Config.locations.jobBasedClothing) do 
        local targetConfig = Config.targets['clothing']
        local tableForTarget = {
            options = {{
                type = 'client',
                action = function()
                    openMenu('clothing')
                end,
                icon = targetConfig.icon,
                label = targetConfig.text,
                canInteract = function()
                    local isAllowed = false
                    if v.jobs then 
                        for i = 1, #v.jobs do 
                            local hasJob = compareJobs(v.jobs[i])
                            if hasJob then 
                                isAllowed = true
                                break
                            end
                        end
                    end
                    return (isAllowed and checkDuty() or false)

                end,
                gang = v.gang
            }},
            distance = targetConfig.distance,
            rotation = v.rotation,
        }
        local name = 'jobBasedClothing-' .. k
        if Config.stores.enablePedForTargeting then 
            pedsToSpawn.jobBasedClothing[k] = spawnPed(targetConfig.model, v.coords, targetConfig.scenario)
            addTargetToEntity(pedsToSpawn.jobBasedClothing[k], tableForTarget)
        else 
            addTargetToCoords(v.coords, v.boxSize, tableForTarget, name)
        end
    end

    if not Config.locations.personalOutfits then return end
    for k,v in pairs(Config.locations.personalOutfits) do 
        local targetConfig = Config.targets['personal']
        local tableForTarget = {
            options = {{
                type = 'client',
                action = function()
                    openMenu('outfits')
                end,
                icon = targetConfig.icon,
                label = targetConfig.text,
                canInteract = function()
                    return checkPlayerOutfitClothing(v)
                end
            }},
            distance = targetConfig.distance,
            rotation = v.rotation,
        }
        local name = 'personalOutfits-' .. k
        if Config.stores.enablePedForTargeting then 
            pedsToSpawn.personalOutfits[k] = spawnPed(targetConfig.model, v.coords, targetConfig.scenario)
            addTargetToEntity(pedsToSpawn.personalOutfits[k], tableForTarget)
        else 
            addTargetToCoords(v.coords, v.boxSize, tableForTarget, name)
        end
    end
end

function deleteTargets()
    if Config.stores.enablePedForTargeting then 
        deletePeds()
    else 
        for k,v in pairs(pedsToSpawn.store) do 
            local name = v.type .. '-' .. k
            removeZone(name)
        end

        for k,v in pairs(pedsToSpawn.jobBasedClothing) do 
            local name = 'jobBasedClothing-' .. k
            removeZone(name)
        end

        for k,v in pairs(pedsToSpawn.personalOutfits) do 
            local name = 'personalOutfits-' .. k
            removeZone(name)
        end
    end
end

function deletePeds()
    for i = 1, #pedsToSpawn.store do 
        DeleteEntity(pedsToSpawn.store[i])
    end

    for i = 1, #pedsToSpawn.jobBasedClothing do 
        DeleteEntity(pedsToSpawn.jobBasedClothing[i])
    end

    for i = 1, #pedsToSpawn.personalOutfits do 
        DeleteEntity(pedsToSpawn.personalOutfits[i])
    end
end

CreateThread(function()
    setupTargets()
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        deleteTargets()
    end
end)