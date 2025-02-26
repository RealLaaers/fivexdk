RegisterNetEvent('fivex-gungame:join-after', function()
    -- # If you have an event that you want to be triggered when a player join gungame, you can write it here.
end)

RegisterNetEvent('fivex-gungame:leave-after', function()
    TriggerEvent('healffs2')
    -- If you have an event that you want to be triggered when a player leave gungame, you can write it here.
end)

RegisterNetEvent('fivex-gungame:winnerPrize', function()
    -- # In this section you can specify an event for the prize that the Gungame round winner will receive.
end)

RegisterNetEvent('fivex-gungame:finishGame', function()
    -- # In this section, you can specify if there is an event that you want to happen for all players when a round ends.
end)

RegisterNetEvent('fivex-gungame:reviveEvent', function()
    TriggerEvent('healffs2')
    -- # Customize this part according to your revive event, otherwise dead players will not respawn.
end)