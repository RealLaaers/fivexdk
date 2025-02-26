ESX = exports["es_extended"]:getSharedObject()

local webapikey = false
local playerTime = {}

-----------------------------------------------------------------------------------------
-- EVENT'S --
-----------------------------------------------------------------------------------------

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        local webapi = GetConvar('steam_webApiKey', '53B8A1BAAED1FC2E60CAED0E6AFFB2BD')
        if webapi == "none" or webapi == "" then
            webapikey = false
        else
            webapikey = true
        end
    end
end)

RegisterNetEvent('fivex-leaderboard:playerDeath', function(attacker, deader)
    local aPlayer = GetIdentifier(attacker)
    local dPlayer = GetIdentifier(deader)
    addKill(aPlayer)
    addDeath(dPlayer)
end)

RegisterNetEvent('fivex-leaderboard:playerLoaded', function()
    local src = source
    local xPlayer = GetIdentifier(src)
    checkData(xPlayer, src)
    sendLeaderboard(src)

    local loginedTime = os.time()
    if playerTime[src] == nil then
        playerTime[src] = loginedTime
    end
end)

RegisterNetEvent('fivex-leaderboard:changeBanner', function(link)
    local src = source
    local identifier = GetIdentifier(src)
    ChangeBanner(identifier, link)
end)

RegisterNetEvent('fivex-leaderboard:getInfo', function()
    local src = source
    local xPlayer = GetIdentifier(src)
    checkData(xPlayer, src)
end)

RegisterNetEvent('fivex-leaderboard:getLeaderBoard', function()
    local src = source
    sendLeaderboard(src)
end)


-----------------------------------------------------------------------------------------
-- CALLBACK'S --
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- COMMAND'S --
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- FUNCTİON'S --
-----------------------------------------------------------------------------------------

function checkData(identifier, source)
    MySQL.Async.fetchAll('SELECT * FROM leaderboard WHERE identifier = @identifier', {
        ["@identifier"] = identifier
    }, function(result)
        if result[1] ~= nil then
            MySQL.Async.execute('UPDATE leaderboard SET avatar = @avatar, name = @name WHERE identifier = @identifier', {
                ['@identifier'] = identifier,
                ['@avatar'] = getavatar(avatarHex(source)),
                ['@name'] = GetPlayerName(source)
            }, function(changed)
                MySQL.Async.fetchAll('SELECT * FROM leaderboard WHERE identifier = @identifier', {
                    ["@identifier"] = identifier
                }, function(result)
                    TriggerClientEvent('fivex-leaderboard:set:myStats', source, result)
                end)
            end)
        else
            MySQL.Async.insert('INSERT INTO leaderboard (identifier, name, country, avatar) VALUES (@identifier, @name, @country, @avatar)', {
                ["@identifier"] = identifier,
                ["@name"]       = GetPlayerName(source),
                ["@country"]    = GetCountry(source),
                ["@avatar"]     = getavatar(avatarHex(source))
            })
        end
    end)
end

exports("checkData", checkData)

function sendLeaderboard(source)
    MySQL.Async.fetchAll('SELECT * FROM leaderboard ORDER BY `kills` DESC', {}, function(result)
        TriggerClientEvent('fivex-leaderboard:send:leaderboard', source, result)
    end)
end

function GetCountry(source)
    local p = promise.new()
    for k,v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("ip:")) == "ip:" then
			ip   = string.gsub(v,"ip:","")
			http = "https://ipwho.is/".. ip
			PerformHttpRequest(http, function (errorCode, resultData, resultHeaders)
				bilgi = json.decode(resultData)
				p:resolve(bilgi.country_code)
			end)
			return Citizen.Await(p)
        end
    end
end

function addKill(identifier)
    MySQL.Async.execute("UPDATE leaderboard SET kills = kills + @kills WHERE identifier = @identifier", {
        ["@identifier"] = identifier,
        ["@kills"] = 1
    })
    MySQL.Async.execute("UPDATE leaderboard SET points = (points + 3) WHERE identifier = @identifier", {
        ["@identifier"] = identifier
    })

    MySQL.Async.fetchAll('SELECT * FROM leaderboard WHERE identifier = @identifier', {
        ["@identifier"] = identifier
    }, function(result)            
    points = tonumber(result[1].points)
    if points < 600 then
        rank = "Bronze I"
    end
    if points >= 600 then
        rank = "Bronze II"
    end
    if points >= 1500 then
        rank = "Bronze III"
    end
    if points >= 2000 then
        rank = "Silver I"
    end
    if points >= 5000 then
        rank = "Silver II"
    end
    if points >= 9000 then
        rank = "Silver III"
    end
    if points >= 12000 then
        rank = "Gold I"
    end
    if points >= 17000 then
        rank = "Gold II"
    end
    if points >= 23000 then
        rank = "Gold III"
    end
    if points >= 30000 then
        rank = "Platinum I"
    end
    if points >= 40000 then
        rank = "Platinum II"
    end
    if points >= 55000 then
        rank = "Platinum III"
    end
    if points >= 65000 then
        rank = "Diamond I"
    end
    if points >= 80000 then
        rank = "Diamond II"
    end
    if points >= 100000 then
        rank = "Diamond III"
    end
    if points >= 150000 then
        rank = "Master"
    end
    if result[1].rank ~= rank then MySQL.Async.execute('UPDATE leaderboard SET rank = @rank WHERE identifier = @identifier',{['@identifier'] = identifier, ['@rank'] = rank}) end
    end)
end

function addDeath(identifier)
    MySQL.Async.execute("UPDATE leaderboard SET death = death + @death WHERE identifier = @identifier", {
        ["@identifier"] = identifier,
        ["@death"] = 1
    })
    MySQL.Async.execute("UPDATE leaderboard SET  points = (points - 1) WHERE identifier = @identifier", {
        ["@identifier"] = identifier
    })

    MySQL.Async.fetchAll('SELECT * FROM leaderboard WHERE identifier = @identifier', {
        ["@identifier"] = identifier
    }, function(result)            
    points = tonumber(result[1].points)
    if points < 600 then
        rank = "Bronze I"
    end
    if points >= 600 then
        rank = "Bronze II"
    end
    if points >= 1500 then
        rank = "Bronze III"
    end
    if points >= 2000 then
        rank = "Silver I"
    end
    if points >= 5000 then
        rank = "Silver II"
    end
    if points >= 9000 then
        rank = "Silver III"
    end
    if points >= 12000 then
        rank = "Gold I"
    end
    if points >= 17000 then
        rank = "Gold II"
    end
    if points >= 23000 then
        rank = "Gold III"
    end
    if points >= 30000 then
        rank = "Platinum I"
    end
    if points >= 40000 then
        rank = "Platinum II"
    end
    if points >= 55000 then
        rank = "Platinum III"
    end
    if points >= 65000 then
        rank = "Diamond I"
    end
    if points >= 80000 then
        rank = "Diamond II"
    end
    if points >= 100000 then
        rank = "Diamond III"
    end
    if points >= 150000 then
        rank = "Master"
    end
    if result[1].rank ~= rank then MySQL.Async.execute('UPDATE leaderboard SET rank = @rank WHERE identifier = @identifier',{['@identifier'] = identifier, ['@rank'] = rank}) end
    end)
end

function ChangeBanner(identifier, link)
    MySQL.Async.execute("UPDATE leaderboard SET banner = @banner WHERE identifier = @identifier", {
        ["@identifier"] = identifier,
        ["@banner"]     = link
    })
end

function GetIdentifier(source)
    if not webapi then
        return GetPlayerIdentifiers(source)[1]
    end
end

function avatarHex(source)
    if webapikey then
        for k,v in ipairs(GetPlayerIdentifiers(source)) do
            if string.match(v, 'steam:') then
                local identifier = string.gsub(v, 'steam:', '')
                return identifier
            end
        end
    else
        print('Steamwebapi key not set!')
        return false
    end
end

function getavatar(identifier)
    if string.len(identifier) >= 21 then return "https://cdn.discordapp.com/attachments/1299062119299285126/1340499201166934097/CompressJPEG.png?ex=67b3e62a&is=67b294aa&hm=5507a7f3df06a7cbc484aedf95f942b6ba27010c3042856715f9b4650beeab47&" end
    local sid  = tonumber(identifier:gsub("steam:",""), 16)
    local link = "http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=53B8A1BAAED1FC2E60CAED0E6AFFB2BD&steamids="..sid
    local p = promise:new()
    PerformHttpRequest(link, function(errorCode, resultData, resultHeaders)
        a = json.decode(resultData)
        if not a then
            print('Steam api is temporarily unavailable, or too busy to respond')
            p:resolve("https://cdn.discordapp.com/attachments/1299062119299285126/1340499201166934097/CompressJPEG.png?ex=67b3e62a&is=67b294aa&hm=5507a7f3df06a7cbc484aedf95f942b6ba27010c3042856715f9b4650beeab47&")
        else
            for k,v in pairs(a["response"].players) do
                p:resolve(v.avatarfull)
            end
        end
    end)
    return Citizen.Await(p)
end

-----------------------------------------------------------------------------------------
-- CRON'S --
-----------------------------------------------------------------------------------------

ESX.RegisterServerCallback('fivex-leaderboard:server:getSC', function(source, cb)
    local src = source
    MySQL.Async.fetchAll('SELECT * FROM leaderboard WHERE identifier = @identifier', {
        ["@identifier"] = GetIdentifier(src)
    }, function(result)    
        cb(result[1].coins)
    end)
end)

ESX.RegisterServerCallback('fivex-leaderboard:server:getRank', function(source, cb)
    local src = source
    MySQL.Async.fetchAll('SELECT * FROM leaderboard WHERE identifier = @identifier', {
        ["@identifier"] = GetIdentifier(src)
    }, function(result)    
        cb(result[1].rank)
    end)
end)

RegisterServerEvent('fivex-leaderboard:server:addSC')
AddEventHandler('fivex-leaderboard:server:addSC', function(value)
    MySQL.Async.execute("UPDATE leaderboard SET coins = coins + @coins WHERE identifier = @identifier", {
        ["@identifier"] = GetIdentifier(source),
        ["@coins"] = value
    })
end)

RegisterServerEvent('fivex-leaderboard:server:removeSC')
AddEventHandler('fivex-leaderboard:server:removeSC', function(value)
    MySQL.Async.execute("UPDATE leaderboard SET coins = coins - @coins WHERE identifier = @identifier", {
        ["@identifier"] = GetIdentifier(source),
        ["@coins"] = value
    })
end)

RegisterServerEvent('fivex-leaderboard:server:kdres')
AddEventHandler('fivex-leaderboard:server:kdres', function()
    local identifieraga = GetIdentifier(source)
     MySQL.Async.execute('UPDATE leaderboard SET rank = @rank WHERE identifier = @identifier',{['@identifier'] = identifieraga, ['@rank'] = "Bronze I"}) 
     MySQL.Async.execute('UPDATE leaderboard SET kills = @kills WHERE identifier = @identifier',{['@identifier'] = identifieraga, ['@kills'] = 0}) 
     MySQL.Async.execute('UPDATE leaderboard SET death = @death WHERE identifier = @identifier',{['@identifier'] = identifieraga, ['@death'] = 0}) 
     MySQL.Async.execute('UPDATE leaderboard SET points = @points WHERE identifier = @identifier',{['@identifier'] = identifieraga, ['@points'] = 0}) 
     MySQL.Async.execute('UPDATE leaderboard SET coins = @coins WHERE identifier = @identifier',{['@identifier'] = identifieraga, ['@coins'] = 0}) 
end)