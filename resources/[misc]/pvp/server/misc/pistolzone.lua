-- local activePistolZone = 'pistol1'
-- local zones = {"pistol1", "pistol2", "pistol3"}

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(10 * 60 * 1000)

--         local newZone = zones[math.random(#zones)]
--         while newZone == activePistolZone do
--             newZone = zones[math.random(#zones)]
--         end

--         activePistolZone = newZone
        
--         local players = GetPlayers()
--         for _, playerId in ipairs(players) do
--             if GetPlayerRoutingBucket(playerId) == 917665 then
--                 TriggerClientEvent("pistolzone:updateZone", playerId, activePistolZone)
--             end
--         end
--         TriggerClientEvent('chat:addMessage', -1, {
-- 			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgb(0, 31, 66, 0.7); border-radius: 3px;"></i> Pistol Zone: <br> Pistol Zone rykkes og vil nu være et andet sted!</div>',
-- 			args = { source }
-- 		})
--     end
-- end)

-- AddEventHandler("playerConnecting", function(name, setKickReason, deferrals)
--     local src = source
--     if GetPlayerRoutingBucket(src) == 917665 then
--         TriggerClientEvent("pistolzone:updateZone", src, activePistolZone)
--     end
-- end)

RegisterNetEvent("pistolzone:join", function()
    -- local src = source
    SetPlayerRoutingBucket(source, 917665)
    -- TriggerClientEvent("pistolzone:updateZone", src, activePistolZone)
end)

lib.callback.register('pistolzone:getPlayerCount', function(source)
    local count = 0
    for _, playerId in ipairs(GetPlayers()) do
        if GetPlayerRoutingBucket(tonumber(playerId)) == 917665 then
            count = count + 1
        end
    end
    return count
end)