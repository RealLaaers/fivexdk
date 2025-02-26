RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')

RegisterNetEvent('playerJoining')

AddEventHandler('_chat:messageEntered', function(author, color, message)
    -- local messageContent = "**[ID]** - "..source.."\n**[Player Name]** - "..GetPlayerName(source).."\n**[SteamHex]** - steam:"..GetIDFromSource('steam', source).."\n**[Message]** - "..message
    -- local webhookchat = 'https://discord.com/api/webhooks/1241822566763724820/9Doo_6psXyjcmmPtYhwFUKm7D5Rx7s6dZUGD6A8iRF3gdvYDvxdd7GQLBeHqnTJBF612'
    if not message or not author then
        return
    end

    TriggerEvent('chatMessage', source, author, message)

    if not WasEventCanceled() then
        TriggerClientEvent('chatMessage', -1, author,  { 255, 255, 255 }, message)
    end

	--sendToDiscord(webhookchat, Config.SystemAvatar, 'Chat Log\n', messageContent, 65535)

   -- print(author .. '^7: ' .. message .. '^7')
end)

AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = GetPlayerName(source)

    TriggerEvent('chatMessage', source, name, '/' .. command)

    if not WasEventCanceled() then
        TriggerClientEvent('chatMessage', -1, name, { 255, 255, 255 }, '/' .. command) 
    end

    CancelEvent()
end)

-- Citizen.CreateThread(function()
--     while true do
--         ExecuteCommand('dybhosting')
--         Citizen.Wait(1800000)
--     end
-- end)

-- RegisterCommand('dybhosting', function(source, args, rawCommand)
--     TriggerClientEvent('chat:addMessage', -1, {
--         template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgb(0, 0, 0, 0.534); border-radius: 3px;"><i class="fab fa-discord"></i> Sponsorat: <br> XPVP er sponsoreret af Dybhosting.com, mere information i #dybhosting</div>',
--         args = { fal, msg }
--     })
-- end, false)


-- command suggestions for clients
local function refreshCommands(player)
    if GetRegisteredCommands then
        local registeredCommands = GetRegisteredCommands()

        local suggestions = {}

        for _, command in ipairs(registeredCommands) do
            if IsPlayerAceAllowed(player, ('command.%s'):format(command.name)) then
                table.insert(suggestions, {
                    name = '/' .. command.name,
                    help = ''
                })
            end
        end

        TriggerClientEvent('chat:addSuggestions', player, suggestions)
    end
end

AddEventHandler('chat:init', function()
    refreshCommands(source)
end)

RegisterCommand('clear', function(source, args, rawCommand)
    TriggerClientEvent('chat:client:ClearChat', source)
end, false)

AddEventHandler('onServerResourceStart', function(resName)
    Wait(500)

    for _, player in ipairs(GetPlayers()) do
        refreshCommands(player)
    end
end)

ESX = exports["es_extended"]:getSharedObject()

roleList = Config.roleList;
allowedColors = Config.allowedColors;
allowedRed = Config.allowedRed;
allowedEmoji = Config.allowedEmoji;
sendBlockMessages = Config.sendBlockMessages;
emojis = Config.emojis;


-- CODE --
-- function sendMsg(firstline, msg, to) 
-- 	-- TriggerClientEvent('chat:addMessage', -1, {
-- 	-- 	template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.7); border-radius: 3px;"><i class="fas fa-globe"></i> {0}:<br> {1}</div>',
-- 	-- 	args = { firstline , msg}
-- 	-- })
-- end 


--- Code ---

function sleep (a) 
    local sec = tonumber(os.clock() + a); 
    while (os.clock() < sec) do 
    end 
end
local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end
function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end
function get_index (tab, val)
	local counter = 1
    for index, value in ipairs(tab) do
        if value == val then
            return counter
        end
		counter = counter + 1
    end

    return nil
end

roleTracker = {}
roleAccess = {}
chatcolorTracker = {}
availColors = Config.ColorPatterns


function setContains(set, key)
    return set[key] ~= nil
end
function msg(src, mesg) 
	TriggerClientEvent('chatMessage', src, prefix .. mesg)
end
function msgRaw(src, mesg)
	TriggerClientEvent('chatMessage', src, mesg)
end
prefix = '^9[^5DiscordChatRoles^9] ^3'

chatNotEnabled = {}
RegisterNetEvent('DiscordChatRoles:DisableChat')
AddEventHandler('DiscordChatRoles:DisableChat', function(src)
	chatNotEnabled[src] = true;
end)
RegisterNetEvent('DiscordChatRoles:EnableChat')
AddEventHandler('DiscordChatRoles:EnableChat', function(src)
	chatNotEnabled[src] = nil;
end)

AddEventHandler('chatMessage', function(source, name, msg)
	local args = stringsplit(msg)
	CancelEvent()
	local src = source 
	local steamhex = GetPlayerIdentifier(source)
	if not string.find(args[1], "/") and setContains(roleTracker, GetPlayerIdentifiers(source)[1]) and 
		not has_value(inStaffChat, GetPlayerIdentifiers(source)[1]) and not (chatNotEnabled[src] ~= nil) then 
			local ids = "["..source.."] "
		local roleStr = ids.. roleList[roleTracker[GetPlayerIdentifiers(source)[1]]][2]
		local colors = {'^0', '^2', '^3', '^4', '^5', '^6', '^7', '^8', '^9'}
		local staffColors = {'^1', '^8'}
		local hasColors = false
		local hasRed = false
		local roleNum = roleTracker[GetPlayerIdentifiers(source)[1]]
		for i = 1, #colors do
			local checkFor = "%" .. tostring(colors[i])
			if string.match(msg, checkFor) ~= nil then
				hasColors = true
			end
		end
		for i = 1, #staffColors do
			if string.find(msg, "%" .. staffColors[i]) ~= nil then
				hasRed = true
			end
		end
		local hasEmoji = false;
		for label, val in pairs(emojis) do 
			if string.find(msg, label) ~= nil then 
				hasEmoji = true;
				msg = msg:gsub(label, val);
			end
		end
		local dontSend = false
		if hasColors then
			-- Check if they have required role
			if not has_value(allowedColors, tonumber(roleNum)) then
				dontSend = true
				TriggerClientEvent('chatMessage', source, "^7[^1DiscordChatRoles^7] ^1You cannot use colored chat since you are not a donator...")
			end
		end
		if hasRed then
			-- Check if they have required role
			if not has_value(allowedRed, tonumber(roleNum)) then
				dontSend = true
				TriggerClientEvent('chatMessage', source, "^7[^1DiscordChatRoles^7] ^1You cannot use the color RED in chat since you are not staff...")
			end
		end
		local theirColor = chatcolorTracker[source];
		local finalMessage = msg;
		if theirColor ~= nil then 
			finalMessage = ''
			local indCount = 1;
			for j = 1, #msg do 
				if indCount > #theirColor then 
					indCount = 1;
				end
				local char = msg:sub(j, j);
				finalMessage = finalMessage .. theirColor[indCount] .. char;
				indCount = indCount + 1;
			end
		end
		if not dontSend then
			--TriggerClientEvent('chatMessage', -1, roleStr .. name .. "^7: " .. finalMessage)
			if sendBlockMessages then 
				-- sendMsg(roleStr .. name .. "^7", finalMessage, -1); 
			--	TriggerEvent('DiscordBot:ToDiscord', 'https://discord.com/api/webhooks/1241822566763724820/9Doo_6psXyjcmmPtYhwFUKm7D5Rx7s6dZUGD6A8iRF3gdvYDvxdd7GQLBeHqnTJBF612', GetPlayerName(source) .. ' [ID: ' .. source .. '](' ..steamhex.. ')', '```'..finalMessage..'```', AvatarURL, false, Source, TTS) --Sending the message to discord
			else 
				TriggerClientEvent('chatMessage', -1, roleStr .. name .. "^7 " .. finalMessage);
			end 
		end
	end
	if not string.find(args[1], "/") and not has_value(inStaffChat, GetPlayerIdentifiers(source)[1]) and 
		not setContains(roleTracker, GetPlayerIdentifiers(source)[1]) and not (chatNotEnabled[src] ~= nil) then
		CancelEvent()
		roleTracker[GetPlayerIdentifiers(source)[1]] = 1
		for k, v in ipairs(GetPlayerIdentifiers(src)) do
			if string.sub(v, 1, string.len("discord:")) == "discord:" then
				identifierDiscord = v
			end
		end
		local roleStr = roleList[1][2]
		local roleNum = 1
		local hasAccess = {}
		table.insert(hasAccess, roleNum)
		roleTracker[GetPlayerIdentifiers(source)[1]] = roleNum
		local colors = {'^0', '^2', '^3', '^4', '^5', '^6', '^7', '^8', '^9'}
		local staffColors = {'^1', '^8'}
		local hasColors = false
		local hasRed = false
		for i = 1, #colors do
			local checkFor = "%" .. tostring(colors[i])
			if string.match(msg, checkFor) ~= nil then
				hasColors = true
			end
		end
		for i = 1, #staffColors do
			if string.find(msg, "%" .. staffColors[i]) ~= nil then
				hasRed = true
			end
		end
		local hasEmoji = false;
		for label, val in pairs(emojis) do 
			if string.find(msg, label) ~= nil then 
				hasEmoji = true;
				msg = msg:gsub(label, val);
			end
		end
		local dontSend = false
		if hasColors then
			-- Check if they have required role
			if not has_value(allowedColors, tonumber(roleNum)) then
				dontSend = true
				TriggerClientEvent('chatMessage', source, "^7[^1DiscordChatRoles^7] ^1You cannot use colored chat since you are not a donator...")
			end
		end
		if hasRed then
			-- Check if they have required role
			if not has_value(allowedRed, tonumber(roleNum)) then
				dontSend = true
				TriggerClientEvent('chatMessage', source, "^7[^1DiscordChatRoles^7] ^1You cannot use the color RED in chat since you are not staff...")
			end
		end
		if hasEmoji then 
			if not has_value(allowedEmoji, tonumber(roleNum)) then 
				dontSend = true;
				TriggerClientEvent('chatMessage', source, "^7[^1DiscordChatRoles^7] ^1You cannot use emojis :(")
			end
		end
		local theirColor = chatcolorTracker[source];
		local finalMessage = msg;
		
		if theirColor ~= nil then 
			finalMessage = ''
			local indCount = 1;
			for j = 1, #msg do 
				if indCount > #theirColor then 
					indCount = 1;
				end
				local char = msg:sub(j, j);
				finalMessage = finalMessage .. theirColor[indCount] .. char;
				indCount = indCount + 1;
			end
		end
		if not dontSend then
			local ids = "["..source.."] "
			local roleStr = ids.. roleList[roleTracker[GetPlayerIdentifiers(source)[1]]][2]
			--TriggerClientEvent('chatMessage', -1, roleStr .. name .. "^7: " .. finalMessage)
			if (sendBlockMessages) then 
				-- sendMsg(roleStr .. name .. "^7", finalMessage, -1);  
			else
				TriggerClientEvent('chatMessage', -1, roleStr .. name .. "^7: " .. finalMessage);
			end 
		end
	elseif has_value(inStaffChat, GetPlayerIdentifiers(source)[1]) and not string.find(args[1], "/") and not (chatNotEnabled[src] ~= nil) then
		-- Run client event for all and check perms
		CancelEvent()
		msg = "^7[^1StaffChat^7] ^5(^1" .. name .. "^5) ^9" .. msg
		TriggerClientEvent('Permissions:CheckPermsClient', -1, msg)
		--print("It gets here 1")
	end
end)

AddEventHandler("chatMessage", function(source, args, raw)
	CancelEvent()
	end)

	

RegisterNetEvent('Print:PrintDebug')
AddEventHandler('Print:PrintDebug', function(msg)
--	print(msg)
	TriggerClientEvent('chatMessage', source, "^7[^1Badger's Scripts^7] ^1DEBUG ^7" .. msg)
end)
inStaffChat = {}
RegisterNetEvent("DiscordChatRoles:CheckPerms")
AddEventHandler("DiscordChatRoles:CheckPerms", function(msg)
	-- Check if they have permissions
	--print("It gets to start")
	local src = source
	if IsPlayerAceAllowed(src, "StaffChat.Toggle") then
		TriggerClientEvent('chatMessage', src, msg)
		--print("It gets to end")
	else
		-- Doesn't have perms
	end
end)





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



-----------------------------
--------- Functions ---------
-----------------------------
function sendToDiscord(webhookchat, avatar, title, message, color)
	local connect = {
		{
		  	["color"] = color,
		  	["title"] = "**".. title .."**\n",
			["description"] = message,
			["footer"] = {
				["text"] = "\nXPVP - CHAT LOGS",
			},
		  }
	  }
	PerformHttpRequest(webhookchat, function(err, text, headers) end, 'POST', json.encode({username = "FIVEX - CHAT LOGS", embeds = connect, avatar_url = avatar}), { ['Content-Type'] = 'application/json' })
end

function GetIDFromSource(Type, ID)
	if ID and GetPlayerIdentifiers(ID) then
		local IDs = GetPlayerIdentifiers(ID)
		for _, CurrentID in pairs(IDs) do
			local ID = stringsplit(CurrentID, ':')
			if (ID[1]:lower() == string.lower(Type)) then
				return ID[2]:lower()
			end
		end
	end
    return nil
end