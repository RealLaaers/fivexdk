if Config.framework ~= 'qbox' then return end

function migrateBP(source)
    local allSkins = MySQL.Sync.fetchAll('SELECT * FROM charskin')
    local count = 0
    for i = 1, #allSkins do 
        Wait(150)
        count = count + 1
        TriggerClientEvent('pure-scripts:bp_character:migrate', source, allSkins[i])
    end
    notifySystem(source, {
        title = _Lang('commands.migrateskins.title'),
        description = string.format(_Lang('commands.migrateskins.succeeded'), count),
        type = 'success',
        position = Config.libText.notfiyPoistion,
    })
end

function migrateQBClothing(source)
    local allSkins = MySQL.Sync.fetchAll('SELECT * FROM playerskins WHERE active = 1')
    local count = 0
    for i = 1, #allSkins do 
        Wait(150)
        count = count + 1
        TriggerClientEvent('pure-scripts:qb-clothing:migrate', source, allSkins[i])
    end
    notifySystem(source, {
        title = _Lang('commands.migrateskins.title'),
        description = string.format(_Lang('commands.migrateskins.succeeded'), count),
        type = 'success',
        position = Config.libText.notfiyPoistion,
    })
end