if Config.framework ~= 'standalone' then return end

function updatePlayerData()
    -- update the player data such as job info etc
end

function getGender()
    -- return the gender either return male or female
end

function getJobName()
    -- return the job nmae
end

function getJobGrade()
    -- return the job grade level
end

function compareJobs(job)
    -- compares the job name with the playerdata job
end

function getGangName()
    -- return the gang name
end

function compareGangs(gang)
    -- comapres the gang name with the playerdata gang
end

function canUseMenu()
    updatePlayerData()
    -- return a true or false such as if they are dead it will return true and they cannot use the menu
end

function getPlayerCharacterName(newSource)
    local name = lib.callback.await('pure-clothing:getPlayerCharacterName', false, newSource)
    return name
end

function isPlayerOnDuty()
    -- return if they or on or off duty
end

function getPlayerCID()
    -- return their unique id such as a citizen id
end

function cachePed()
    -- ignore
    return false
end