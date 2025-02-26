local vestUsed = 0

RegisterNetEvent("1t-resources:client:resetVestCount", function()
	vestUsed = 0
end)

function useVest()
	local ped = PlayerPedId()
	local pedId = PlayerId()
	local vest = GetPedArmour(ped)
	local currentGame = exports["fivex_duels"]:getCurrentGame() or false
	if vest == 100 then return lib.notify({title = "Du har allerede fuld vest", type = "info"}) end
	if currentGame then
		if vestUsed >= currentGame.vest then return lib.notify({title = "Du kan ikke tage flere veste på i denne kamp", type = "info"}) end
		vestUsed = vestUsed + 1
	end
	if lib.progressBar({
		duration = 1200,
		label = 'Putting on vest',
		useWhileDead = false,
		canCancel = false,
		anim = {
			dict = 'clothingshirt',
			clip = 'try_shirt_positive_d'
		},
	}) then
		SetPlayerMaxArmour(pedId, 100)
		SetPedArmour(ped, 100)
	else
		return
	end
end

exports('useVest', useVest)

CreateThread(function()
	while true do
		Wait(0)

        local playerPed = PlayerPedId()
        local currentGame = exports['fivex_duels']:getCurrentGame()
        if currentGame then
		if LocalPlayer.state.inDuel == nil or LocalPlayer.state.inDuel == 0 then
			SetPedUsingActionMode(playerPed, false, -1, 0)
		else
			if currentGame then 
				if currentGame.movementType == "Normal" then
					SetPedUsingActionMode(playerPed, false, -1, 0)
				end
			end
		end
    end
    end
end)