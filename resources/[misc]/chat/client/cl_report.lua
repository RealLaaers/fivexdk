ESX = exports["es_extended"]:getSharedObject()



RegisterNetEvent('sendMessageAdmin2')
AddEventHandler('sendMessageAdmin2', function(id, name, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)
	ESX.TriggerServerCallback('esx_chatforadmin:GetGroup', function(Group)
		UserGroup = Group
		if pid == myId then
			TriggerServerEvent("sendtoownplayer2", name, message)
		elseif UserGroup ~= 'user' and pid ~= myId then
			TriggerServerEvent("fuckmylife3", id, name, message)
		end
  end)
end)


RegisterNetEvent('sendRelyMessage')
AddEventHandler('sendRelyMessage', function(id, target, name, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)
		UserGroup = Group
		if pid == myId then
			TriggerServerEvent("sendtoownplayer", name, message)
		elseif pid ~= myId then
			TriggerServerEvent("sendreplytoplayer", target, name, message)
		end
end)


-- RegisterNetEvent('sendMessageAdmin')
-- AddEventHandler('sendMessageAdmin', function(id, name, message)
--     local myId = PlayerId()
--     local pid = GetPlayerFromServerId(id)
-- 	ESX.TriggerServerCallback('esx_chatforadmin:GetGroup', function(Group)
-- 		UserGroup = Group
-- 		if pid == myId then
-- 			TriggerServerEvent("fuckmylife", name, message)
-- 		elseif UserGroup ~= 'user' and pid ~= myId then
-- 			TriggerServerEvent("fuckmylife", name, message)
-- 		end
--   end)
-- end)