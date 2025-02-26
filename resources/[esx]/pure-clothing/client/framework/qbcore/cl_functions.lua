if Config.framework ~= 'qbcore' then return end

QBCore = exports['qb-core']:GetCoreObject()
PlayerData = QBCore.Functions.GetPlayerData()

function updatePlayerData()
    PlayerData = QBCore.Functions.GetPlayerData()
end

function getGender()
    if not PlayerData.charinfo then return 'male' end
    if PlayerData.charinfo.gender == 1 then
        return 'female'
    end
    return 'male'
end

function getJobName()
    if not PlayerData.job then return false end
    return PlayerData.job.name
end

function getJobGrade()
    if not PlayerData.job then return false end
    return PlayerData.job.grade.level
end

function compareJobs(job)
    if not PlayerData.job then return false end
    if PlayerData.job.name == job then 
        return true
    end
    return false
end

function getGangName()
    return PlayerData.gang.name
end

function compareGangs(gang)
    if not PlayerData.gang then return false end
    if PlayerData.gang.name == gang then 
        return true
    end
    return false
end

function canUseMenu()
    updatePlayerData()
    return PlayerData.metadata['isdead'] or PlayerData.metadata['inlaststand'] or PlayerData.metadata['ishandcuffed']
end

function getPlayerCharacterName(newSource)
    local name = lib.callback.await('pure-clothing:getPlayerCharacterName', false, newSource)
    return name
end

function isPlayerOnDuty()
    return PlayerData.job.onduty
end

function getPlayerCID()
    return PlayerData.citizenid
end

function cachePed()
    return false
end