ESX = exports['es_extended']:getSharedObject()

RegisterCommand("clear", function()
    TriggerClientEvent('chat:clear')
end)

RegisterCommand('clearall', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'user' then return end
    if xPlayer.getGroup() ~= 'admin' or xPlayer.getGroup() ~= 'mod' then

        TriggerClientEvent('chat:clear', -1)

    end
end, false)

RegisterNetEvent("fuckmylife")
AddEventHandler("fuckmylife", function(name, message)
    TriggerClientEvent('chat:addMessage', source, {
        template = '<div style="padding: 0.5vw; margin: 0.05vw; background-color: rgba(28, 126, 214, 0.6); border-radius: 3px;" class="testing animated zoomIn delay-2s"><i class="fas fa-bullhorn"></i> Staff Chat - {0}:<br> {1}</div>',
        args = { name, message }
    })
end)

RegisterNetEvent("fuckmylife2")
AddEventHandler("fuckmylife2", function(name, message, source2)
    TriggerClientEvent('chat:addMessage', source, {
        template = '<div style="padding: 0.5vw; margin: 0.05vw; background-color: rgba(28, 126, 214, 0.6); border-radius: 3px;" class="testing animated zoomIn delay-2s"><i class="fas fa-globe"></i> OOL - {0} - ID: {2}:<br> {1}</div>',
        args = { name, message, source2 }
    })
end)

RegisterNetEvent("fuckmylife4")
AddEventHandler("fuckmylife4", function(name, message, source2)
    TriggerClientEvent('chat:addMessage', source, {
        template = '<div style="padding: 0.5vw; margin: 0.05vw; background-color: rgba(28, 126, 214, 0.6); border-radius: 3px;" class="testing animated zoomIn delay-2s"><i class="fas fa-globe"></i> Reklame - {0} - ID: {2}:<br> {1}</div>',
        args = { name, message, source2 }
    })
end)

RegisterNetEvent("fuckmylife5")
AddEventHandler("fuckmylife5", function(name, message, source2)
    TriggerClientEvent('chat:addMessage', source, {
        template = '<div style="padding: 0.5vw; margin: 0.05vw; background-color: rgba(28, 126, 214, 0.6); border-radius: 3px;" class="testing animated zoomIn delay-2s"><i class="fas fa-globe"></i> Tweet - {0} - ID: {2}:<br> {1}</div>',
        args = { name, message, source2 }
    })
end)

-- Citizen.CreateThread(function()
--     while true do
--         TriggerClientEvent('chat:addMessage', -1, {
--             template = '<div style="padding: 0.5vw; margin: 0.05vw; background-color: rgba(28, 126, 214, 0.6); border-radius: 3px;" class="testing animated zoomIn delay-2s"><i class="fas fa-discord"></i> Husk at joine vores discord: discord.gg/tMDRthSdVD <br></div>',
--             args = { fal, msg}
--         })
--         Citizen.Wait(600000)
--     end
-- end)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
			
		}
	else
		return nil
	end
end

ESX.RegisterServerCallback('esx_chatforadmin:GetGroup', function(source, cb)
    local player = ESX.GetPlayerFromId(source)

    if player ~= nil then
        Group = player.getGroup()
        if Group ~= nil then
            cb(Group)
        else
            cb("user")
        end
    else
        cb("user")
    end
end)