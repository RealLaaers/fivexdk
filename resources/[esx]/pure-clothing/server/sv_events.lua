RegisterNetEvent('pure-clothing:saveClothing', function(appearanceTable)
    local citizenID = getPlayerUniqueId(source)
    if not appearanceTable then 
        debugPrint('No appearance table')
        return
    end
    if not citizenID then 
        debugPrint('No citizen ID')
        return
    end
    MySQL.update.await('UPDATE clothing_skins SET clothing = ? WHERE citizenid = ?', {json.encode(appearanceTable), citizenID})
end)

RegisterNetEvent('pure-clothing:saveHair', function(appearanceTable)
    local citizenID = getPlayerUniqueId(source)
    if not appearanceTable then 
        debugPrint('No appearance table')
        return
    end
    if not citizenID then 
        debugPrint('No citizen ID')
        return
    end
    MySQL.update.await('UPDATE clothing_skins SET hair = ? WHERE citizenid = ?', {json.encode(appearanceTable), citizenID})
end)

RegisterNetEvent('pure-clothing:saveCharacter', function(clothingTable, hairTable, characterTable, model, modelHash, tattoos)
    local citizenID = getPlayerUniqueId(source)
    if not clothingTable then 
        debugPrint('No clothing table')
        return
    end
    if not hairTable then 
        debugPrint('No hair table')
        return
    end
    if not characterTable then 
        debugPrint('No character table')
        return
    end
    if not citizenID then 
        debugPrint('No citizen ID')
        return
    end
    debugPrint('Saving character', citizenID)
    MySQL.update.await('UPDATE clothing_skins SET clothing = ?, hair = ?, faceFeatures = ?, tattoos = ?, model = ?, modelHash = ? WHERE citizenid = ?', {json.encode(clothingTable), json.encode(hairTable), json.encode(characterTable), json.encode(tattoos), model, modelHash, citizenID})
end)

RegisterNetEvent('pure-clothing:saveTattoos', function(tattooTable)
    local citizenID = getPlayerUniqueId(source)
    if not tattooTable then 
        debugPrint('No tattoo table')
        return
    end
    if not citizenID then 
        debugPrint('No citizen ID')
        return
    end
    MySQL.update.await('UPDATE clothing_skins SET tattoos = ? WHERE citizenid = ?', {json.encode(tattooTable), citizenID})
end)

RegisterNetEvent('pure-clothing:setPedInOwnWorld', function(shouldSet)
    if shouldSet then 
        SetPlayerRoutingBucket(source, source)
        return 
    end
    SetPlayerRoutingBucket(source, Config.defaultRoutingBucket)
end)

RegisterNetEvent('pure-clothing:saveOutfit', function(outfitTable)
    local citizenID = getPlayerUniqueId(source)
    if not outfitTable then 
        debugPrint('No outfit table')
        return
    end
    if not citizenID then 
        debugPrint('No citizen ID')
        return
    end
    local id = MySQL.insert.await('INSERT INTO `clothing_outfits` (citizenid, modelHash, name, outfit) VALUES (?, ?, ?, ?)', {
        citizenID, outfitTable.modelHash, outfitTable.name, json.encode(outfitTable.outfit)
    })
    local uniqueOutfitid = citizenID .. '-' .. id
    MySQL.update.await('UPDATE clothing_outfits SET uniqueOutfitid = ? WHERE id = ?', {uniqueOutfitid, id})
end)

RegisterNetEvent('pure-clothing:saveFirstCharacter', function(currentClothing, currentHair, currentFace, model, modelHash, currentTattoos)
    local citizenID = getPlayerUniqueId(source)
    if not currentClothing then 
        debugPrint('No clothing table')
        return
    end
    if not currentHair then 
        debugPrint('No hair table')
        return
    end
    if not currentFace then 
        debugPrint('No character table')
        return
    end
    if not citizenID then 
        debugPrint('No citizen ID')
        return
    end
    MySQL.insert.await('INSERT INTO `clothing_skins` (citizenid, faceFeatures, hair, clothing, tattoos, model, modelHash) VALUES (?, ?, ?, ?, ?, ?, ?)', {
        citizenID, json.encode(currentFace), json.encode(currentHair), json.encode(currentClothing), json.encode(currentTattoos), model, modelHash
    })
end)

RegisterNetEvent('pure-clothing:saveMigration', function(citizenID, currentClothing, currentHair, currentFace, model, modelHash, currentTattoos)
    if not currentClothing then 
        debugPrint('No clothing table')
        return
    end
    if not currentHair then 
        debugPrint('No hair table')
        return
    end
    if not currentFace then 
        debugPrint('No character table')
        return
    end
    if not citizenID then 
        debugPrint('No citizen ID')
        return
    end
    MySQL.insert.await('INSERT INTO `clothing_skins` (citizenid, faceFeatures, hair, clothing, tattoos, model, modelHash) VALUES (?, ?, ?, ?, ?, ?, ?)', {
        citizenID, json.encode(currentFace), json.encode(currentHair), json.encode(currentClothing), json.encode(currentTattoos), model, modelHash
    })
end)

RegisterNetEvent('pure-clothing:shareOutfit', function(dataTable)
    debugPrint(json.encode(dataTable))
    TriggerClientEvent('pure-clothing:giveOutfitToPlayer', dataTable.player, dataTable.outfit)
end)

RegisterNetEvent('pure-clothing:updateOutfitName', function(name, uniqueOutfitid)
    local citizenID = getPlayerUniqueId(source)
    if not citizenID then 
        debugPrint('No citizen ID')
        return
    end
    MySQL.update.await('UPDATE clothing_outfits SET name = ? WHERE uniqueOutfitid = ? AND citizenid = ?', {name, uniqueOutfitid, citizenID})
end)

RegisterNetEvent('pure-clothing:registerJobOutfit', function(clothingTable, jobTable)
    local source = source
    local citizenID = getPlayerUniqueId(source)
    if not clothingTable then 
        debugPrint('No clothing table')
        return
    end
    if not jobTable then 
        debugPrint('No job table')
        return
    end
    if not citizenID then 
        debugPrint('No citizen ID')
        return
    end
    MySQL.insert.await('INSERT INTO `clothing_job_outfits` (citizenid, modelHash, name, outfit, jobName, minRank) VALUES (?, ?, ?, ?, ?, ?)', {
        citizenID, clothingTable.modelHash, clothingTable.name, json.encode(clothingTable.outfit), jobTable.name, jobTable.minRank
    })
    notifySystem(source, {
        title = _Lang('newUpdateLang.registerOutfit.title'),
        description = string.format(_Lang('newUpdateLang.registerOutfit.message'), clothingTable.name),
        type = 'success',
        position = Config.libText.notfiyPoistion,
    })
end)

RegisterNetEvent('pure-clothing:deleteJobOutfit', function(id, name)
    local source = source
    local citizenID = getPlayerUniqueId(source)
    if not id then 
        debugPrint('No outfit id')
        return
    end
    if not citizenID then 
        debugPrint('No citizen ID')
        return
    end
    print(id, citizenID)
    MySQL.update.await('DELETE FROM clothing_job_outfits WHERE id = ? AND citizenid = ?', {id, citizenID})
    notifySystem(source, {
        title = _Lang('outfits.deleteOutfit.title'),
        description = string.format(_Lang('outfits.deleteOutfit.message'), id),
        type = 'success',
        position = Config.libText.notfiyPoistion,
    })
end)