if Config.framework ~= 'qbcore' then return end

QBCore = exports['qb-core']:GetCoreObject()

function removeMoney(source, amount, type)
    local Player = QBCore.Functions.GetPlayer(source)
    return Player.Functions.RemoveMoney(type, amount)
end

function getPlayerUniqueId(source)
    local Player = QBCore.Functions.GetPlayer(source)
    return Player.PlayerData.citizenid
end

function getPlayerFullname(newSource)
    local Player = QBCore.Functions.GetPlayer(newSource)
    return Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
end

QBCore.Commands.Add('migrateskins', 'Migrate Skins', { { name = 'Resource Name', help = 'Check docs for supported resources' }}, true, function(source, args)
    local resourceName = args[1]
    if resourceName == 'qb-clothing' then
        migrateQBClothing(source)
    elseif resourceName == 'illenium' then 
        illeniumAppearanceMigration(source)
    elseif resourceName == 'bp_character' then 
        -- MigrateBPCharacter(source)
        migrateBP(source)
    else
        print('Unknown resource name - check documentation')
    end
end, 'god')

QBCore.Commands.Add('setped', 'Set the players Ped', {{ name = 'source', help = 'id above their head' }, { name = 'ped name', help = 'ped name, not model (mp_m_freemode_01)' }}, true, function(source, args)
    local playerSource = tonumber(args[1])
    local ped = tostring(args[2])
    if not playerSource or not ped then return end
    TriggerClientEvent('pure-clothing:setPed', playerSource, ped, true)
    notifySystem(source, {
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
end, 'god')

-- QBCore.Commands.Add('outfitmenu', {name = 'outfit menu', help = _Lang('newUpdateLang.outfitCommand.help')}, false, function(source, args)
--     local Player = QBCore.Functions.GetPlayer(source)
--     local job = Player.PlayerData.job.name
--     local rank = Player.PlayerData.job.grade
--     if not job or not rank then return end
--     print(job, rank)
-- end, 'god')

QBCore.Commands.Add('outfitmenu', '', {}, false, function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    local job = Player.PlayerData.job.name
    local rank = Player.PlayerData.job.grade
    if not job or not rank then return end
    for i = 1, #Config.jobOutfits.jobsAndRanks do 
        local jobName = Config.jobOutfits.jobsAndRanks[i].name
        local jobRank = Config.jobOutfits.jobsAndRanks[i].rank
        if jobName == job and jobRank == rank.level then 
            TriggerClientEvent('pure-clothing:openOutfitCreationMenu', source)
            return
        end
    end
end)
