function checkWhitelist(data)
    if not data.name then 
        if data.model then 
            return modelWhitelist(data)
        end
        if data.tattoos then 
            for i = 1, #data.tattoos do 
                if not tattooWhitelist(data.tattoos[i].name, data.type) then return end
            end
            return true
        end
    end
    if clothingForValuesTable[data.name] or propsForvaluesTable[data.name] then 
        return clothingWhitelist(data)
    elseif clothingTable[data.name].type == 'overlay' or data.name == 'hair' then 
        return hairWhitelist(data)
    end
    return true
end

function clothingWhitelist(data)
    local name = data.name
    if not Config.whitelist.clothing[name] then return true end
    for i = 1, #Config.whitelist.clothing[name] do 
        if data.value == Config.whitelist.clothing[name][i].value then 
            local config = Config.whitelist.clothing[name][i]
            if config.jobs then 
                for i = 1, #config.jobs do 
                    if compareJobs(config.jobs[i]) then 
                        return true
                    end
                end
            end
            if config.citizenids then 
                for i = 1, #config.citizenids do 
                    if config.citizenids[i] == getPlayerCID() then 
                        return true
                    end
                end
            end
            notifySystem({
                title = _Lang('showTextUI.whitelist.title'),
                description = string.format(_Lang('showTextUI.whitelist.message'), data.value),
                type = 'error',
                position = Config.libText.notfiyPoistion,
            })
            return
        end
    end
    return true
end

function hairWhitelist(data)
    local name = data.name
    if not Config.whitelist.hair[name] then return true end
    for i = 1, #Config.whitelist.hair[name] do 
        if data.value == Config.whitelist.hair[name][i].number then 
            local config = Config.whitelist.hair[name][i]
            if config.jobs then 
                for i = 1, #config.jobs do 
                    if compareJobs(config.jobs[i]) then 
                        return true
                    end
                end
            end
            if config.citizenids then 
                for i = 1, #config.citizenids do 
                    if config.citizenids[i] == getPlayerCID() then 
                        return true
                    end
                end
            end
            notifySystem({
                title = _Lang('showTextUI.whitelist.title'),
                description = string.format(_Lang('showTextUI.whitelist.message'), data.value),
                type = 'error',
                position = Config.libText.notfiyPoistion,
            })
            return
        end
    end
    return true
end

function tattooWhitelist(name, type)
    if not Config.whitelist.tattoos[type] then return true end
    for i = 1, #Config.whitelist.tattoos[type] do 
        if Config.whitelist.tattoos[type][i].name == name then 
            local config = Config.whitelist.tattoos[type][i]
            if config.jobs then 
                for i = 1, #config.jobs do 
                    if compareJobs(config.jobs[i]) then 
                        return true
                    end
                end
            end
            if config.citizenids then 
                for i = 1, #config.citizenids do 
                    if config.citizenids[i] == getPlayerCID() then 
                        return true
                    end
                end
            end
            notifySystem({
                title = _Lang('showTextUI.whitelist.title'),
                description = string.format(_Lang('showTextUI.whitelist.message'), name),
                type = 'error',
                position = Config.libText.notfiyPoistion,
            })
            return
        end
    end
    return true
end

function modelWhitelist(data)
    if not Config.whitelist.peds then return true end
    if not Config.whitelist.peds then return true end
    for i = 1, #Config.whitelist.peds do 
        if data.model == Config.whitelist.peds[i].model then 
            local config = Config.whitelist.peds[i]
            if config.jobs then 
                for i = 1, #config.jobs do 
                    if compareJobs(config.jobs[i]) then 
                        return true
                    end
                end
            end
            if config.citizenids then 
                for i = 1, #config.citizenids do 
                    if config.citizenids[i] == getPlayerCID() then 
                        return true
                    end
                end
            end
            notifySystem({
                title = _Lang('showTextUI.whitelist.title'),
                description = string.format(_Lang('showTextUI.whitelist.message'), data.model),
                type = 'error',
                position = Config.libText.notfiyPoistion,
            })
            return
        end
    end
    return true
end