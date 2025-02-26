if Config.framework ~= 'standalone' then return end


function removeMoney(source, amount, type)
    -- remove money and return if it is successful or not
end

function getPlayerUniqueId(source)
    -- return thier unique id such as a citizen id
end

function getPlayerFullname(newSource)
    -- return thier full name in the format Firstname Lastname
end

RegisterCommand('setped', function(source, args, rawCommand)
    -- set the players ped, need a permission check here otherwise everyone will be using it
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
end)

RegisterCommand('outfitmenu', function(source)
    -- local job = 
    -- local rank = 
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