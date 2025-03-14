lib.callback.register('deaglezone:getPlayerCount', function(source)
    local count = 0
    for _, playerId in ipairs(GetPlayers()) do
        if GetPlayerRoutingBucket(tonumber(playerId)) == 19061 then
            count = count + 1
        end
    end
    return count
end)

lib.callback.register('apzone:getPlayerCount', function(source)
    local count = 0
    for _, playerId in ipairs(GetPlayers()) do
        if GetPlayerRoutingBucket(tonumber(playerId)) == 19059 then
            count = count + 1
        end
    end
    return count
end)