lib.callback.register('pure-clothing:getTattooTable', function(source, gender)
    return (gender and tattoosMale[1]) or tattoosFemale[1]
end)

lib.callback.register('pure-clothing:getPedModel', function(source)
    local citizenID = getPlayerUniqueId(source)
    if not citizenID then 
        debugPrint('No citizen ID')
        return
    end
    local result =  MySQL.single.await('SELECT model FROM clothing_skins WHERE citizenid = ?', {citizenID})
    if not result then 
        debugPrint('No result')
        return
    end
    debugPrint('Ped model', result['model'])
    return result['model']
end)

lib.callback.register('pure-clothing:getOutfits', function(source, ped)
    local citizenID = getPlayerUniqueId(source)
    if not citizenID then 
        debugPrint('No citizen ID')
        return
    end
    local result =  MySQL.query.await('SELECT * FROM clothing_outfits WHERE citizenid = ? AND modelHash = ?', {citizenID, ped})
    if not result then 
        debugPrint('No result')
        return
    end
    debugPrint('Outfits', #result)
    local outfitsToReturn = {}
    for k,v in pairs(result) do 
        local outfit = {
            name = v['name'],
            modelHash = v['modelHash'],
            uniqueOutfitid = v['uniqueOutfitid'],
            outfit = json.decode(v['outfit'])
        }
        table.insert(outfitsToReturn, outfit)
    end
    return outfitsToReturn
end)

lib.callback.register('pure-clothing:removeMoney', function(source, amount, type)
    debugPrint('Removing money', amount)
    if removeMoney(source, amount, type) then 
        debugPrint('Removed money')
        notifySystem(source, {
            title = _Lang('payments.successful.title'),
            description = _Lang('payments.successful.message'),
            type = 'success',
            position = Config.libText.notfiyPoistion,
        })
        return true
    end 
    debugPrint('Failed to remove money')
    notifySystem(source, {
        title = _Lang('payments.failure.title'),
        description = _Lang('payments.failure.message'),
        type = 'success',
        position = Config.libText.notfiyPoistion,
    })
    return
end)

lib.callback.register('pure-clothing:getClothing', function(source)
    local citizenID = getPlayerUniqueId(source)
    if not citizenID then 
        debugPrint('No citizen ID')
        return
    end
    local result =  MySQL.single.await('SELECT clothing FROM clothing_skins WHERE citizenid = ?', {citizenID})
    if not result then 
        debugPrint('No result')
        return
    end
    debugPrint('Clothing', json.encode(result['clothing']))
    return json.decode(result['clothing'])
end)

lib.callback.register('pure-clothing:getHair', function(source)
    local citizenID = getPlayerUniqueId(source)
    if not citizenID then 
        debugPrint('No citizen ID')
        return
    end
    local result =  MySQL.single.await('SELECT hair FROM clothing_skins WHERE citizenid = ?', {citizenID})
    if not result then 
        debugPrint('No result')
        return
    end
    debugPrint('Hair', json.encode(result['hair']))
    return json.decode(result['hair'])
end)

lib.callback.register('pure-clothing:getCharacter', function(source)
    local citizenID = getPlayerUniqueId(source)
    if not citizenID then 
        debugPrint('No citizen ID')
        return
    end
    local result =  MySQL.single.await('SELECT `faceFeatures`, `clothing`, `hair`, `tattoos`, `model` FROM clothing_skins WHERE citizenid = ?', {citizenID})
    if not result then 
        debugPrint('No result')
        return
    end
    debugPrint('Model', result['model'])
    return json.decode(result['faceFeatures']), json.decode(result['clothing']), json.decode(result['hair']), json.decode(result['tattoos']), result['model']
end)

lib.callback.register('pure-clothing:getTattoos', function(source)
    local citizenID = getPlayerUniqueId(source)
    if not citizenID then 
        debugPrint('No citizen ID')
        return
    end
    local result =  MySQL.single.await('SELECT tattoos FROM clothing_skins WHERE citizenid = ?', {citizenID})
    if not result then 
        debugPrint('No result')
        return
    end
    debugPrint('Tattoos', json.encode(result))
    return json.decode(result['tattoos'])
end)

lib.callback.register('pure-clothing:deleteOutfit', function(source, uniqueOutfitid)
    local citizenID = getPlayerUniqueId(source)
    if not uniqueOutfitid then 
        debugPrint('No unique outfit ID')
        return
    end
    if not citizenID then 
        debugPrint('No citizen ID')
        return
    end
    MySQL.update.await('DELETE FROM clothing_outfits WHERE uniqueOutfitid = ? AND citizenid = ?', {uniqueOutfitid, citizenID})
    return true
end)

lib.callback.register('pure-clothing:getPlayerCharacterName', function(source, newSource)
    local name = getPlayerFullname(newSource)
    return name
end)

lib.callback.register('pure-clothing:getJobBasedOutfits', function(source, job, rank)
    local outfits = generateJobOutfits(source, job, rank)
    return outfits
end)

lib.callback.register('pure-clothing:getJobOutfits', function(source)
    local citizenID = getPlayerUniqueId(source)
    if not citizenID then 
        debugPrint('No citizen ID')
        return
    end
    local model = GetEntityModel(GetPlayerPed(source))
    local result =  MySQL.query.await('SELECT * FROM clothing_job_outfits WHERE citizenid = ? AND modelHash = ?', {citizenID, model})
    if not result then 
        debugPrint('No result')
        return
    end
    debugPrint('Outfits', #result)
    return result
end)