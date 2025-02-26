local Group 

ESX = exports['es_extended']:getSharedObject()

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

RegisterCommand('report', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
    local playerName = GetPlayerName(source)
    local playerHex = GetPlayerIdentifier(source)
    local playerIp = GetPlayerEndpoint(source)
    local ids = ExtractIdentifiers(xPlayer.source);
	local discord = ids.discord;  
	Group = xPlayer.getGroup()
	TriggerClientEvent("sendMessageAdmin2", -1, source,  playerName, table.concat(args, " "))
    sendToDisc("REPORT", "Steam Name - **"..xPlayer.getName().."\n\n**Steam Hex - "..playerHex.."\n\nPlayer IP: "..playerIp.." \n\n Discord - <@".. discord:gsub('discord:', '').. "> \n\nReport: "..table.concat(args, " "))
end, false)


RegisterCommand('rr', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
    local playerName = GetPlayerName(source)
    local target = args[1]
    local smessage = ""
    local playerHex = GetPlayerIdentifier(source)
    local playerIp = GetPlayerEndpoint(source)
    local ids = ExtractIdentifiers(xPlayer.source);
	local discord = ids.discord;  
    for k,v in pairs(args) do
        if k > 1 then
            smessage = smessage .. v .." "
        end
    end
	Group = xPlayer.getGroup()
	if Group ~= 'user' then
		TriggerClientEvent("sendRelyMessage", target, source, target, playerName, smessage)
        TriggerClientEvent("sendRelyMessage", source, source, target, playerName, smessage)
        ReplyReport("REPORT REPLY", "**ADMIN INFORMATION** \n\nSteam Name - **"..xPlayer.getName().."\n\n**Steam Hex - "..playerHex.."\n\nPlayer IP: "..playerIp.." \n\n Discord - <@".. discord:gsub('discord:', '').. "> \n\nReply: "..smessage.. " \n\nTarget ID - "..target)
	end	
end, false)

-- RegisterNetEvent("fuckmylife")
-- AddEventHandler("fuckmylife", function(name, message)
--     local xPlayer = ESX.GetPlayerFromId(source)
-- 	Group = xPlayer.getGroup()
--     if Group ~= 'user' then
--         TriggerClientEvent('chat:addMessage', source, {
--             template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(141, 41, 41, 0.6); border-radius: 3px;"><i class="fas fa-bullhorn"></i> Admin Chat ({0}):<br> {1}</div>',
--             args = { name, message }
--         })
-- 	end	
-- end)



RegisterNetEvent("sendtoownplayer2")
AddEventHandler("sendtoownplayer2", function(name, message)
    local xPlayer = ESX.GetPlayerFromId(source)
	Group = xPlayer.getGroup()
    TriggerClientEvent('chat:addMessage', source, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(141, 41, 41, 0.6); border-radius: 3px;"><i class="fas fa-bullhorn"></i> Report ID - {0} ({1}):<br> {2}</div>',
            args = { source, name, message }
        })
end)

RegisterNetEvent("fuckmylife3")
AddEventHandler("fuckmylife3", function(id, name, message)
    local xPlayer = ESX.GetPlayerFromId(source)
	Group = xPlayer.getGroup()
    if Group ~= 'user' then
        TriggerClientEvent('chat:addMessage', source, {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(141, 41, 41, 0.6); border-radius: 3px;"><i class="fas fa-bullhorn"></i> Report ID - {0} ({1}):<br> {2}</div>',
            args = { id, name, message }
        })
	end	
end)


RegisterNetEvent("sendtoownplayer")
AddEventHandler("sendtoownplayer", function(name, message)
    local xPlayer = ESX.GetPlayerFromId(source)
	Group = xPlayer.getGroup()
    if Group ~= 'user' then
        TriggerClientEvent('chat:addMessage', source, {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(141, 41, 41, 0.6); border-radius: 3px;"><i class="fas fa-bullhorn"></i> Svar sendt til spiller ({0}):<br> {1}</div>',
            args = { name, message }
        })
	end	
end)


RegisterNetEvent("sendreplytoplayer")
AddEventHandler("sendreplytoplayer", function(target,name, message)
    local xPlayer = ESX.GetPlayerFromId(target)
	Group = xPlayer.getGroup()
    TriggerClientEvent('chat:addMessage', target, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(141, 41, 41, 0.6); border-radius: 3px;"><i class="fas fa-bullhorn"></i> Svar fra Admin ({0}):<br> {1}</div>',
        args = { name, message }
    })
end)

RegisterCommand('a', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerName = GetPlayerName(source)
    Group = xPlayer.getGroup()
    sendadminchat(16753920, playerName, 'ID: ' .. source .. ' skrev ' .. table.concat(args, " ") .. ' i admin chatten', "ø er en kvinde")
    if Group ~= 'user' then
        TriggerClientEvent("sendMessageAdmin", -1, source, playerName, table.concat(args, " "))
    end
end, false)

function sendadminchat(color, name, message, footer)
	local embed = {
		  {
			  ["color"] = color,
			  ["title"] = "**".. name .."**",
			  ["description"] = message,
			  ["footer"] = {
				  ["text"] = footer.. " ".. os.date("%x %X %p"),
			  },
		  }
	  }
	
    PerformHttpRequest('https://discord.com/api/webhooks/1241822959245463563/JfF1pvqAPxhuOiluM7Se5BFN8Qx0OrmOC1J0_vZWprIXGXQxsIx4dPueuTjYlz5RiKRt', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end



function sendToDisc(title, msg)
    local embed = {}
    embed = {
        {
            ["color"] = 13055799,
            ["title"] = "**".. title .."**",
            ["description"] = msg,
            ["footer"] = {
                ["text"] = "Made by FiveX",
            },
        }
    }
    PerformHttpRequest("https://discord.com/api/webhooks/1340807012287647765/t6NMmhJWzf540UdTl6zoFnIPjAiWwWwgCAGh4PFo0pZAxkc14HBxBVKdhszisCCQIoaz",
        function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end

function ReplyReport(title, msg)
    local embed = {}
    embed = {
        {
            ["color"] = 13055799,
            ["title"] = "**".. title .."**",
            ["description"] = msg,
            ["footer"] = {
                ["text"] = "Made by FiveX",
            },
        }
    }
    PerformHttpRequest("https://discord.com/api/webhooks/1340807059364642937/UY8fNfjD9s6dUG4yKc6vaujCVy7j4repQxXxgmEG_TVKxk4CR3SpX4z7B4F2PYvfe8Nt",
        function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end


function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    --Loop over all identifiers
    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        --Convert it to a nice table.
        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end