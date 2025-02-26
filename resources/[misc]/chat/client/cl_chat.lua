local isRDR = not TerraingridActivate and true or false
local chatInputActive = false
local chatInputActivating = false
local chatHidden = true
local chatLoaded = false
local chatVisibilityToggle = false
RegisterNetEvent('chatMessage')
RegisterNetEvent('chat:addTemplate')
RegisterNetEvent('chat:addMessage')
RegisterNetEvent('chat:addSuggestion')
RegisterNetEvent('chat:addSuggestions')
RegisterNetEvent('chat:removeSuggestion')
RegisterNetEvent('chat:clear')
RegisterNetEvent('chat:toggleChat')
RegisterNetEvent('__cfx_internal:serverPrint')
RegisterNetEvent('_chat:messageEntered')
AddEventHandler('chatMessage', function(author, color, text)
	local args = { text }
	if author ~= "" then
		table.insert(args, 1, author)
	end
	if(not chatVisibilityToggle)then
		SendNUIMessage({
			type = 'ON_MESSAGE',
			message = {
				color = color,
				multiline = true,
				args = args
			}
		})
	end
end)


local function openChat()
	if chatInputActive or not chatLoaded then
		return
	end
	chatInputActive = true
        chatInputActivating = true
        SetTextChatEnabled(false)
	SendNUIMessage({type = 'ON_OPEN'})
	SetNuiFocus(true)
end

AddEventHandler('__cfx_internal:serverPrint', function(msg)
	if(not chatVisibilityToggle)then
		SendNUIMessage({
			type = 'ON_MESSAGE',
			message = {
				color = { 0, 0, 0 },
				multiline = true,
				args = { msg }
			}
		})
	end
end)

AddEventHandler('chat:addMessage', function(message)
	if(not chatVisibilityToggle)then
		SendNUIMessage({
			type = 'ON_MESSAGE',
			message = message
		})
	end
end)

AddEventHandler('chat:addSuggestion', function(name, help, params)
	SendNUIMessage({
		type = 'ON_SUGGESTION_ADD',
		suggestion = {
			name = name,
			help = help,
			params = params or nil
		}
	})
end)

AddEventHandler('chat:addSuggestions', function(suggestions)
	for _, suggestion in ipairs(suggestions) do
		SendNUIMessage({
			type = 'ON_SUGGESTION_ADD',
			suggestion = suggestion
		})
	end
end)

exports('isVisible', function() return chatVisibilityToggle end)

AddEventHandler('chat:toggleChat',function()
	chatVisibilityToggle = not chatVisibilityToggle
	local state = (chatVisibilityToggle == true) and "disabled." or "enabled."
        ExecuteCommand("clear")
end)

RegisterCommand("togglechat",function()
	TriggerEvent('chat:toggleChat')
end)

AddEventHandler('chat:removeSuggestion', function(name)
	SendNUIMessage({
		type = 'ON_SUGGESTION_REMOVE',
		name = name
	})
end)

AddEventHandler('chat:addTemplate', function(id, html)
	SendNUIMessage({
		type = 'ON_TEMPLATE_ADD',
		template = {
			id = id,
			html = html
		}
	})
end)

AddEventHandler('chat:clear', function(name)
	SendNUIMessage({
		type = 'ON_CLEAR'
	})
end)

RegisterNUICallback('chatResult', function(data, cb)
	chatInputActive = false
	SetNuiFocus(false)
	if not data.canceled then
		local id = PlayerId()
		local r, g, b = 0, 0x99, 255
		if data.message:sub(1, 1) == '/' then
			ExecuteCommand(data.message:sub(2))
		else
			TriggerServerEvent('_chat:messageEntered', GetPlayerName(id), { r, g, b }, data.message)
		end
	end
	cb('ok')
end)

local function refreshCommands()
	if GetRegisteredCommands then
		local registeredCommands = GetRegisteredCommands()
		local suggestions = {}
		for _, command in ipairs(registeredCommands) do
		if IsAceAllowed(('command.%s'):format(command.name)) then
				table.insert(suggestions, {
						name = '/' .. command.name,
						help = ''
				})
			end
		end
		TriggerEvent('chat:addSuggestions', suggestions)
	end
end

local function refreshThemes()
	local themes = {}
	for resIdx = 0, GetNumResources() - 1 do
		local resource = GetResourceByFindIndex(resIdx)
		if GetResourceState(resource) == 'started' then
			local numThemes = GetNumResourceMetadata(resource, 'chat_theme')
			if numThemes > 0 then
				local themeName = GetResourceMetadata(resource, 'chat_theme')
				local themeData = json.decode(GetResourceMetadata(resource, 'chat_theme_extra') or 'null')
				if themeName and themeData then
					themeData.baseUrl = 'nui://' .. resource .. '/'
					themes[themeName] = themeData
				end
			end
		end
	end
	SendNUIMessage({
		type = 'ON_UPDATE_THEMES',
		themes = themes
	})
end

AddEventHandler('onClientResourceStart', function(resName)
	Wait(500)
	refreshCommands()
	refreshThemes()
end)

AddEventHandler('onClientResourceStop', function(resName)
	Wait(500)
	refreshCommands()
	refreshThemes()
end)

RegisterNUICallback('loaded', function(data, cb)
	TriggerServerEvent('chat:init');
	refreshCommands()
	refreshThemes()
	chatLoaded = true
	cb('ok')
end)

RegisterCommand('openchat', function()

    openChat()
end)

RegisterCommand('clear', function()
    TriggerEvent('chat:clear')
end)

RegisterKeyMapping('openchat', 'Open Chat', 'keyboard', 'T')
RegisterKeyMapping('togglechat', 'Toggle Chat', 'keyboard', 'L')

