function checkBlacklist(data)
    if not data.name then 
        if data.model then 
            return modelBlacklist(data.model)
        end
        if data.tattoos then 
            for i = 1, #data.tattoos do 
                if tattooBlacklist(data.type, data.tattoos[i].name) then 
                    return true
                end
            end
            return
        end
    end
    if clothingForValuesTable[data.name] or propsForvaluesTable[data.name] then 
        return clothingBlacklist(data.name, data.value)
    elseif clothingTable[data.name].type == 'overlay' or data.name == 'hair' then 
        return hairBlacklist(data.name, data.value)
    end
end

function modelBlacklist(model)
    if not Config.blacklist.peds then return end
    for i = 1, #Config.blacklist.peds do 
        if Config.blacklist.peds[i] == model then 
            notifySystem({
                title = _Lang('showTextUI.blacklist.title'),
                description = string.format(_Lang('showTextUI.blacklist.message'), model),
                type = 'error',
                position = Config.libText.notfiyPoistion,
            })
            return true
        end
    end
    return 
end

function tattooBlacklist(type, name)
    if not Config.blacklist.tattoos[type] then return end
    for i = 1, #Config.blacklist.tattoos[type] do 
        if Config.blacklist.tattoos[type][i] == name then 
            notifySystem({
                title = _Lang('showTextUI.blacklist.title'),
                description = string.format(_Lang('showTextUI.blacklist.message'), name),
                type = 'error',
                position = Config.libText.notfiyPoistion,
            })
            return true
        end
    end
    return 
end

function clothingBlacklist(name, value)
    if not Config.blacklist.clothing[name] then return end
    for i = 1, #Config.blacklist.clothing[name] do 
        if Config.blacklist.clothing[name][i] == value then 
            notifySystem({
                title = _Lang('showTextUI.blacklist.title'),
                description = string.format(_Lang('showTextUI.blacklist.message'), value),
                type = 'error',
                position = Config.libText.notfiyPoistion,
            })
            -- sendReactMessage('updateBaseValue1', {name = name, value = value - 1})
            return true
        end
    end
    return
end

function hairBlacklist(name, value)
    if not Config.blacklist.hair[name] then return end
    for i = 1, #Config.blacklist.hair[name].values do 
        if Config.blacklist.hair[name].values[i] == value then 
            notifySystem({
                title = _Lang('showTextUI.blacklist.title'),
                description = string.format(_Lang('showTextUI.blacklist.message'), value),
                type = 'error',
                position = Config.libText.notfiyPoistion,
            })
            return true
        end
    end
    return
end

function colourBlacklist(data)
    if not Config.blacklist.hair[data.name] then return end
    for i = 1, #Config.blacklist.hair[data.name].colour1 do 
        if Config.blacklist.hair[data.name].colour1[i] == data.colour1 then 
            notifySystem({
                title = _Lang('showTextUI.blacklist.title'),
                description = string.format(_Lang('showTextUI.blacklist.message'), data.colour1),
                type = 'error',
                position = Config.libText.notfiyPoistion,
            })
            return true
        end
    end
    return
end