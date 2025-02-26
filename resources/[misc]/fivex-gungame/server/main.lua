--------------------------------------------------------------------

local Gungame_Players = {}
local Gungame_Map = "Elgin Ave."
local Temp_Map = nil
local Gungame_Votes = {}
local Gungame_Kills = {}

--------------------------------------------------------------------

local function findMap(mapName)
    for _, map in ipairs(Config.Maps) do
        if map.name == mapName then
            return map
        end
    end
    return nil
end

local function findMapWithID(mapId)
    for _, map in ipairs(Config.Maps) do
        if map.id == mapId then
            return map.name
        end
    end
    return nil
end

local function findHighestVote(maps)
    local Votes = 0
    local Map = nil
    
    for _, map in ipairs(maps) do
        if map.votes > Votes then
            Votes = map.VoteCount
            Map = map
        end
    end
    
    return Map, Votes
end


GetPlayerInfo = function(source)
    local src = source
    local src_name = GetPlayerName(src)
    local cfg = json.decode(LoadResourceFile(GetCurrentResourceName(), Config.Settings['DatabaseLocation']))
    return {
        name = cfg[src_name].ply_name,
        win = cfg[src_name].win,
        kill = cfg[src_name].kill,
        death = cfg[src_name].death,
        photo = cfg[src_name].photo,
        id = src,
    }
end

--------------------------------------------------------------------

RegisterServerEvent('fivex-gungame:server:checkData', function()
    local src = source
    local src_name = GetPlayerName(src)
    local hex = tonumber(string.gsub(GetPlayerIdentifier(src, 0), 'steam:', ''), 16)
    local cfg = json.decode(LoadResourceFile(GetCurrentResourceName(), Config.Settings['DatabaseLocation'])) 
    PerformHttpRequest('http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. Config.Settings['StemWebAPIKey'] .. '&steamids=' .. hex, function(error, result, header)
        local result = json.decode(result)
        local photo = result.response.players[1].avatarfull
        if cfg[src_name] == nil then
            cfg[src_name] = {}
            cfg[src_name].ply_name = src_name
            cfg[src_name].kill = 0
            cfg[src_name].death = 0
            cfg[src_name].win = 0
            cfg[src_name].photo = photo
            SaveResourceFile(GetCurrentResourceName(), Config.Settings['DatabaseLocation'], json.encode(cfg, { indent = true }), -1)
        end
    end)
end)

--------------------------------------------------------------------
local porno = {}
RegisterServerEvent('fivex-gungame:server:joinGungame', function(bucket, gametype)
    local src = source
    local map = findMap(Gungame_Map)
    if #(Gungame_Players) < map.max_player then

        if (porno[src]) then
            return
        end

        porno[src] = true
        SetPlayerRoutingBucket(src, bucket)
        table.insert(Gungame_Players, src)
        Gungame_Kills[src] = {name = GetPlayerName(src), Level = 1, Kill = 0}
        local Kill_Data = {
            activeweapon = Config.GungameWeapons[Gungame_Kills[src].Level].Name, 
            nextweapon = Config.GungameWeapons[Gungame_Kills[src].Level+1].Name,
            killsleft = Config.GungameWeapons[Gungame_Kills[src].Level].Kill,
            weaponsleft = #(Config.GungameWeapons),
            weapon_system_name = Config.GungameWeapons[Gungame_Kills[src].Level].Weapon,
        }
        TriggerClientEvent('fivex-gungame:client:joinGungame', src, Gungame_Map, Kill_Data, gametype)
    end
end)

AddEventHandler("playerDropped", function()
    local src = source
    for k,v in pairs(Gungame_Players) do
        if v == src then 
            table.remove(Gungame_Players, k)
        end 
    end 
end)

RegisterServerEvent('fivex-gungame:server:leaveLobby', function()
    local src = source
    for k,v in pairs(Gungame_Players) do
        if v == src then 
            table.remove(Gungame_Players, k)
            porno[v] = nil
            SetPlayerRoutingBucket(src, Config.Settings['DefaultBucket'])         
        end 
    end 
end)

--------------------------------------------------------------------

RegisterServerEvent('fivex-gungame:server:playerDeath', function()
    local src = source
    local src_name = GetPlayerName(src)
    local cfg = json.decode(LoadResourceFile(GetCurrentResourceName(), Config.Settings['DatabaseLocation'])) 
    cfg[src_name].death = cfg[src_name].death + 1
    SaveResourceFile(GetCurrentResourceName(), Config.Settings['DatabaseLocation'], json.encode(cfg, { indent = true }), -1)
    TriggerClientEvent("fivex-gungame:client:Revive", src)
end)

RegisterServerEvent('fivex-gungame:server:killPlayer', function(killerServerId)
    local src = killerServerId
    Gungame_Kills[src].Kill = Gungame_Kills[src].Kill + 1
    local Kill_Data = {
        killsleft = (Config.GungameWeapons[Gungame_Kills[src].Level].Kill-Gungame_Kills[src].Kill),
    }
    TriggerClientEvent('fivex-gungame:client:updateHud', src, "KillUpdate", Kill_Data)
    if Gungame_Kills[src].Kill >= Config.GungameWeapons[Gungame_Kills[src].Level].Kill and Gungame_Kills[src].Level ~= #(Config.GungameWeapons) then
        local src_name = GetPlayerName(src)
        local cfg = json.decode(LoadResourceFile(GetCurrentResourceName(), Config.Settings['DatabaseLocation'])) 
        cfg[src_name].kill = cfg[src_name].kill + Gungame_Kills[src].Kill
        SaveResourceFile(GetCurrentResourceName(), Config.Settings['DatabaseLocation'], json.encode(cfg, { indent = true }), -1)
        Gungame_Kills[src].Level = Gungame_Kills[src].Level + 1
        Gungame_Kills[src].Kill = 0
        local Level_Data = nil
        if Gungame_Kills[src].Level == #(Config.GungameWeapons) then
            Level_Data = {
                activeweapon = Config.GungameWeapons[Gungame_Kills[src].Level].Name, 
                nextweapon = "Win",
                killsleft = Config.GungameWeapons[Gungame_Kills[src].Level].Kill,
                weaponsleft = (#(Config.GungameWeapons)-Gungame_Kills[src].Level),
                weapon_system_name = Config.GungameWeapons[Gungame_Kills[src].Level].Weapon,
            }
        else
            Level_Data = {
                activeweapon = Config.GungameWeapons[Gungame_Kills[src].Level].Name, 
                nextweapon = Config.GungameWeapons[Gungame_Kills[src].Level+1].Name,
                killsleft = Config.GungameWeapons[Gungame_Kills[src].Level].Kill,
                weaponsleft = (#(Config.GungameWeapons)-Gungame_Kills[src].Level),
                weapon_system_name = Config.GungameWeapons[Gungame_Kills[src].Level].Weapon,
            }
        end
        TriggerClientEvent('fivex-gungame:client:updateHud', src, "LevelUpdate", Level_Data)
    end
    if Gungame_Kills[src].Level == #(Config.GungameWeapons) and Gungame_Kills[src].Kill == 1 then
        TriggerClientEvent('fivex-gungame:client:finishGame', -1, src, GetPlayerName(src))
        TriggerClientEvent('fivex-gungame:finishGame', -1)
        TriggerClientEvent('fivex-gungame:winnerPrize', src)
        local src_name = GetPlayerName(src)
        local cfg = json.decode(LoadResourceFile(GetCurrentResourceName(), Config.Settings['DatabaseLocation'])) 
        cfg[src_name].win = cfg[src_name].win + 1
        SaveResourceFile(GetCurrentResourceName(), Config.Settings['DatabaseLocation'], json.encode(cfg, { indent = true }), -1)
    end
end)

--------------------------------------------------------------------

RegisterServerEvent('fivex-gungame:server:updateVote', function(votedMap)
    Gungame_Votes[votedMap].VoteCount = Gungame_Votes[votedMap].VoteCount+1
    TriggerClientEvent('fivex-gungame:client:updateVote', -1, Gungame_Votes)
end)

RegisterServerEvent('fivex-gungame:server:startVote', function()
    TriggerClientEvent('fivex-gungame:client:AvailableStatus', -1, "notavailable")
    for _, map in ipairs(Config.Maps) do
        Gungame_Votes[map.id] = {}
        Gungame_Votes[map.id] = {VoteCount = 0}
    end
    local counter = 30
    while counter > 0 do
        Wait(1000)
        counter = counter - 1
    end
    local maxVote = 0
    local maxVoteGungame = ""
    for gungame, data in pairs(Gungame_Votes) do
        if data.VoteCount > maxVote then
            maxVote = data.VoteCount
            maxVoteGungame = gungame
            Gungame_Map = findMapWithID(maxVoteGungame)
        end
    end
    for k,v in pairs(Gungame_Players) do
        table.remove(Gungame_Players, k)
    end 
    porno = {}
    Gungame_Players = {}
    Gungame_Votes = {}
    Gungame_Kills = {}
    Wait(300)
    TriggerClientEvent('fivex-gungame:client:newGameRoot', -1)
    Wait(3000)
    TriggerClientEvent('fivex-gungame:client:AvailableStatus', -1, "available")
end)

--------------------------------------------------------------------

RegisterServerEvent("fivex-gungame:server:FetchLeaderboard", function()
    local cfg = json.decode(LoadResourceFile(GetCurrentResourceName(), Config.Settings['DatabaseLocation']))
    TriggerClientEvent("fivex-gungame:client:GetLeaderboardData", source, cfg)
end)

--------------------------------------------------------------------

RegisterServerEvent('fivex-gungame:server:openMenu', function()
    local src = source
    local info = GetPlayerInfo(src)
    local gungame_data = {
        map = Gungame_Map,
        players = #(Gungame_Players),
    }
    TriggerClientEvent('fivex-gungame:client:openMenu', src, info, gungame_data)
end)

--------------------------------------------------------------------