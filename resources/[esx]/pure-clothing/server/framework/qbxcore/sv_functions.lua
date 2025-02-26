if Config.framework ~= 'qbox' then return end

function removeMoney(source, amount, type)
    local player = exports.qbx_core:Getplayer(src)
    return player.Functions.RemoveMoney(type, amount)
end

function getplayerUniqueId(source)
    local player = exports.qbx_core:Getplayer(src)
    return player.playerData.citizenid
end

function getplayerFullname(newSource)
    local player = exports.qbx_core:Getplayer(src)
    return player.playerData.charinfo.firstname .. ' ' .. player.playerData.charinfo.lastname
end

QBCore.Commands.Add('migrateskins', 'Migrate Skins', { { name = 'Resource Name', help = 'Check docs for supported resources' }}, true, function(source, args)
    local resourceName = args[1]
    if resourceName == 'fivem-appearance-esx' then
        -- MigrateFivemAppearance(source)
        print('Not implemented yet - fivem-appearance')
    elseif resourceName == 'fivem-appearance-qb' then
        -- MigrateFivemAppearance(source)
        print('Not implemented yet - fivem-appearance')
    elseif resourceName == 'qb-clothing' then
        -- CreateThread(function()
        --     MigrateQBClothing(source)
        -- end)
        print('Not implemented yet - qb-clothing')
    elseif resourceName == 'illenium-appearance' then 
        -- MigrateIlleniumAppearance(source)
        print('Not implemented yet - illenium-appearance')
    elseif resourceName == 'bp_character' then 
        -- MigrateBPCharacter(source)
        migrateBP(source)
        print('Not implemented yet - bp_character')
    else
        print('Unknown resource name')
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

QBCore.Commands.Add('outfitmenu', '', {}, false, function(source)
    local player = exports.qbx_core:Getplayer(src)
    local job = player.playerData.job.name
    local rank = player.playerData.job.grade
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