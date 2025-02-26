function applyTattoos(newTattooTable, type)
    if not currentAllTattoos then 
        debugPrint('currentTattoos is nil, this shouldnt be the case, contact blaze!')
        return
    end
    if json.encode(newTattooTable) == '[]' then 
        -- ClearPedDecorations(playerPed)
        -- return 
        newTattooTable = newTattooTable or {}
    end
    if not tattooTableRecieved then 
        debugPrint('Tattoo table is nil')
        return 
    end
    ClearPedDecorations(cache.ped)
    currentAllTattoos[type] = newTattooTable
    for k,v in pairs(currentAllTattoos) do
        for i = 1, #currentAllTattoos[k] do
            local tattoo = currentAllTattoos[k][i]
            loadTattoo(cache.ped, tattoo)
        end
    end
end

function loadTattoo(ped, tattoo)
    -- debugPrint('loadTattoo', json.encode(tattoo))
    local collection = findCollectionFromTattoo(tattoo.name)

    if not collection then 
        debugPrint('Invalid tattoo collection - Contact Blaze', tattoo)
        print('OVERRIDING DEBUG PLEASE CONTACT BLAZE IMMEDIATELY - GET THE TATTOO THAT YOU SELECTED AND SEND IT TO ME')
        return 
    end
    local gender = getPedGender(cache.ped)
    if gender == 'ped' then debugPrint('Trying to set a ped tattoo, this shouldnt be the case?') end
    local hashToApply = (gender == 'male' and GetHashKey(tattoo.hashNameMale)) or GetHashKey(tattoo.hashNameFemale)
    AddPedDecorationFromHashes(ped, GetHashKey(collection), hashToApply)
end

function deleteAllTattoos()
    ClearPedDecorations(cache.ped)
    currentAllTattoos = {
        ['torso'] = {},
        ['head'] = {},
        ['leftarm'] = {},
        ['rightarm'] = {},
        ['leftleg'] = {},
        ['rightleg'] = {},
    }
    TriggerServerEvent('pure-clothing:saveTattoos', {})
    sendReactMessage('setTattoos', currentAllTattoos)
end

function loadAllTattoosFromDB()
    cachedTattoos = lib.callback.await('pure-clothing:getTattoos', false)
    if not cachedTattoos or json.encode(cachedTattoos) == '[]' then 
        debugPrint('No tattoos found')
        deleteAllTattoos()
        return 
    end
    for k,v in pairs(cachedTattoos) do 
        debugPrint(k, json.encode(v))
        for i = 1, #v do
            local tattoo = v[i]
            loadTattoo(cache.ped, tattoo)
        end
    end
    debugPrint('Tattoos found', json.encode(cachedTattoos))
    sendReactMessage('setTattoos', cachedTattoos)
end