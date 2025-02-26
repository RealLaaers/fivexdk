RegisterNetEvent('pure-clothing:giveOutfitToPlayer', function(outfitTable)
    debugPrint('Recieved outfit', outfitTable.name)
    sendReactMessage('giveOutfit', outfitTable)
    notifySystem({
        title = _Lang('outfits.recievedOutfit.title'),
        description = string.format(_Lang('outfits.recievedOutfit.message'), outfitTable.name),
        type = 'success',
        position = Config.libText.notfiyPoistion,
    })
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        initiateApperance()
    end
end)

RegisterNetEvent('pure-clothing:reloadSkin', function()
    if isInCoolDown() or canUseMenu() or cache.vehicle or IsPedFalling(cache.ped) then 
        notifySystem({
            title = _Lang('commands.reloadskin.cooldown'),
            type = 'error',
            position = Config.libText.notfiyPoistion,
        })
        return
    end

    cooldown = GetGameTimer()

    if initiateApperance() then 
        notifySystem({
            title = _Lang('commands.reloadskin.succeeded'),
            type = 'success',
            position = Config.libText.notfiyPoistion,
        })
    else 
        notifySystem({
            title = _Lang('commands.reloadskin.failed'),
            type = 'error',
            position = Config.libText.notfiyPoistion,
        })
    end
end)

RegisterNetEvent('pure-clothing:openClothing', function()
    openMenu('clothing')
end)

RegisterNetEvent('pure-clothing:openOutfits', function()
    openMenu('outfits')
end)

RegisterNetEvent('pure-clothing:openHair', function()
    openMenu('hair')
end)

RegisterNetEvent('pure-clothing:openTattoos', function()
    openMenu('tattoo')
end)

RegisterNetEvent('pure-clothing:openSurgeon', function()
    openMenu('createCharacter')
end)

RegisterNetEvent('pure-clothing:openOutfitCreationMenu', function()
    openOutfitCreator(source)
end)
