if Config.framework ~= 'esx' then return end

ESX = exports['es_extended']:getSharedObject()


function removeMoney(source, amount, type)
    if type == 'cash' then type = 'money' end
    local Player = ESX.GetPlayerFromId(source)
    if Player.getAccount(type).money >= amount then
        Player.removeAccountMoney(type, amount)
        return true
    end
    return false
end

function getPlayerUniqueId(source)
    local Player = ESX.GetPlayerFromId(source)
    if not Player then return false end
    return Player.identifier
end

function getPlayerFullname(newSource)
    local Player = QBCore.Functions.GetPlayer(newSource)
    return Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
end

ESX.RegisterCommand('migrateskins', 'admin', function(xPlayer, args, showError)
    local resourceName = args.resource
    if not resourceName then return end
    if resourceName == 'esx' then 
        esxMigration(xPlayer.source)
    elseif resourceName == 'illenium' then 
        print(xPlayer.source, 'illeniumAppearanceMigration')
        illeniumAppearanceMigration(xPlayer.source)
    else
        print('Unknown resource name - check documentation')
    end
end, false, {help = _Lang('commands.migrateskins.help'), validate = true, arguments = {
	{name = 'resource', help = 'Check docs for supported resources', type = 'string'}
}})

ESX.RegisterCommand('setped', 'admin', function(xPlayer, args, showError)
    local playerSource = args.playerId
    local ped = args.ped
    print(playerSource, ped, json.encode(args))
    if not playerSource then 
        notifySystem(xPlayer.source, {
            title = _Lang('commands.setped.title'),
            description = _Lang('commands.setped.playerNotOnline'),
            type = 'error',
            position = Config.libText.notfiyPoistion,
        })
    end
    if not playerSource or not ped then return end
    TriggerClientEvent('pure-clothing:setPed', playerSource, ped, true)
    notifySystem(xPlayer.source, {
        title = _Lang('commands.setped.title'),
        description = string.format(_Lang('commands.setped.succeeded'), ped),
        type = 'success',
        position = Config.libText.notfiyPoistion,
    })
    notifySystem(playerSource, {
        title = _Lang('commands.setped.title'),
        description = string.format(_Lang('commands.setped.mysuccess'), ped),
        type = 'success',
        position = Config.libText.notfiyPoistion,
    })
end, false, {help = _Lang('commands.setped.help'), validate = true, arguments = {
	{name = 'playerId', help = _Lang('commands.setped.playerSource'), type = 'playerId'},
    {name = 'ped', help = _Lang('commands.setped.pedModel'), type = 'string'}
}})

ESX.RegisterCommand('loadmyoutfits', 'user', function(xPlayer, args, showError)
    loadOutfits(xPlayer.source)
end, false, {help = _Lang('commands.loadmyoutfits.help')})

ESX.RegisterCommand('outfitmenu', 'user', function(xPlayer, args, showError)
    for i = 1, #Config.jobOutfits.jobsAndRanks do 
        local jobName = Config.jobOutfits.jobsAndRanks[i].name
        local jobRank = Config.jobOutfits.jobsAndRanks[i].rank
        if jobName == xPlayer.job.label and jobRank == xPlayer.job.grade then 
            TriggerClientEvent('pure-clothing:openOutfitCreationMenu', xPlayer.source)
            return
        end
    end
end, false, {help = _Lang('newUpdateLang.outfitCommand.help')})