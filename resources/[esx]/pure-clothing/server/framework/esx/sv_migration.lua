if Config.framework ~= 'esx' then return end

usedOutfits = {}

function esxMigration(source)
    local allSkins = MySQL.Sync.fetchAll('SELECT * FROM users')
    local count = 0
    for i = 1, #allSkins do 
        Wait(150)
        count = count + 1
        TriggerClientEvent('pure-scripts:esx_skin:migrate', source, allSkins[i])
    end
    notifySystem(source, {
        title = _Lang('commands.migrateskins.title'),
        description = string.format(_Lang('commands.migrateskins.succeeded'), count),
        type = 'success',
        position = Config.libText.notfiyPoistion,
    })
end


function illeniumAppearanceMigration(source)
    local response = MySQL.query.await('SELECT identifier, skin FROM users')
    local count = 0
    if response then
        for i = 1, #response do
            local row = response[i]
            Wait(350)
            count = count + 1
            TriggerClientEvent('pure-scripts:illenium:migrate', source, json.decode(row.skin), row.identifier)
        end
    end
    notifySystem(source, {
        title = _Lang('commands.migrateskins.title'),
        description = string.format(_Lang('commands.migrateskins.succeeded'), count),
        type = 'success',
        position = Config.libText.notfiyPoistion,
    })
end

function loadOutfits(source)
    local identifier = getPlayerUniqueId(source)
    if usedOutfits[identifier] then notifySystem(source, {
        title = _Lang('commands.loadmyoutfits.title'),
        description = _Lang('commands.loadmyoutfits.alreadyLoaded'),
        type = 'error',
        position = Config.libText.notfiyPoistion,
    }) return end
    local allOutfits = MySQL.Sync.fetchAll('SELECT data FROM datastore_data WHERE owner = ? AND name = "dressing"', {identifier})
    for i = 1, #allOutfits do 
        local decoded = json.decode(allOutfits[i]['data'])
        Wait(150)
        TriggerClientEvent('pure-scripts:esx_skin:loadOutfit', source, decoded['dressing'])
    end
    usedOutfits[identifier] = true
end