if Config.framework ~= 'esx' then return end

ESX = exports['es_extended']:getSharedObject()
PlayerData = nil

function updatePlayerData()
    PlayerData = ESX.GetPlayerData()
end

function getGender()
    updatePlayerData()
    if not PlayerData.sex then return 'male' end
    if PlayerData.sex == 'f' then
        return 'female'
    end
    return 'male'
end

function getJobName()
    if not PlayerData.job then return false end
    return PlayerData.job.label
end

function getJobGrade()
    if not PlayerData.job then return false end
    return PlayerData.job.grade
end

function compareJobs(job)
    if not PlayerData.job then 
        updatePlayerData()
        Wait(250)
    end
    if not PlayerData.job then return false end
    if PlayerData.job.label == job then 
        return true
    end
    return false
end

function getGangName()
    if not PlayerData.job then 
        updatePlayerData()
        Wait(250)
    end
    if not PlayerData.gang then return PlayerData.job.label end
    return PlayerData.gang.name
end

function compareGangs(gang)
    if not PlayerData.gang then return false end
    if PlayerData.gang.name == gang then 
        return true
    end
    return false
end

function isPlayerOnDuty()
    return PlayerData.job.onduty
end

function canUseMenu()
    updatePlayerData()
    return PlayerData.dead or IsPedCuffed(PlayerData.ped)
end

function getPlayerCharacterName(newSource)
    local name = lib.callback.await('pure-clothing:getPlayerCharacterName', false, newSource)
    return name
end

function getPlayerCID()
    return PlayerData.identifier
end

function cachePed()
    ESX.SetPlayerData('ped', cache.ped)
end