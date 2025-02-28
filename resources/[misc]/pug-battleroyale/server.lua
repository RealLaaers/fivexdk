local allplayers = {}
local spectateplayers = {}
local gameStarted = false
local gameHASStarted = false
local cashprize = Config.MinWager
local richplayers = 0
local lives = 1
local dimention = math.random(400,999)
local everyone = 0
local CoolDownTime = Config.CircleCooldownSeconds
local GulagPlayers = {}
local PlayersInGulag = false
local GulagMap = "Set_Dystopian_02"
--Functions
local function moneycheck(players)
	local Player = players
		richplayers = richplayers + 1
		return true
end
local function round(x)
    return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end
function ClearInventoryESX(source)
	if Config.InventoryType == "qs" then
		exports['qs-inventory']:ClearInventory(source)
	else
		local xPlayer = ESX.GetPlayerFromId(source)
		for k, _ in pairs(xPlayer.inventory) do
			if xPlayer.inventory[k].count > 0 then
				xPlayer.setInventoryItem(xPlayer.inventory[k].name, 0)
			end
		end
	end
end
function GetInventoryItemsESX(source)
	if source then
		local src = source
		local Player = ESX.GetPlayerFromId(src)
		return Player.inventory
	end
end
function SvInfo()
    local info = {
		players = allplayers,
	}
	return info
end
--CallBacks
ESX.RegisterServerCallback('Pug:serverCB:GetInventoryItems', function(source, cb)
	if source then
		local src = source
		local Player = ESX.GetPlayerFromId(src)
		cb(Player.inventory)
	end
end)
ESX.RegisterServerCallback('Pug:serverCB:CheckongoingRoyale', function(source, cb)
	local src = source
	if gameHASStarted and everyone >= 1 then
		TriggerClientEvent('Pug:showNotificationBR', src, Translations.error.active_game, 'error')
	elseif gameHASStarted then
		TriggerClientEvent('Pug:showNotificationBR', src, Translations.error.closing_game, 'error')
	end
	cb(gameHASStarted)
end)
ESX.RegisterServerCallback('Pug:serverCB:GetBrInfo', function(source, cb)
	local src = source
	local CoolDown1 = false
	if gameHASStarted then
		if (#spectateplayers) >= 1 then
		else
			CoolDown1 = true
		end
	end
	local Info = {
		Started = gameHASStarted,
		CoolDown = CoolDown1, 
	}
	cb(Info)
end)
--CallBacks
ESX.RegisterServerCallback('Pug:serverCB:GetAllPlayers', function(source, cb)
	cb(allplayers)
end)
ESX.RegisterServerCallback('Pug:ServerCB:ViewBattleRoyale', function(source, cb)
    local src = source
    local Ply = ESX.GetPlayerFromId(src)
	local plyers = (#allplayers)
	local lobby = {}
	local playred = nil
	local playerr = nil
	local playersdisplay = {}
	if (#allplayers) >= 1 then
		for k,v in pairs(allplayers) do
			playerr = ESX.GetPlayerFromId(v)
			if playerr ~= nil then
				playersdisplay[#playersdisplay+1] = 'nigger'
			end
		end
		lobby = {
			life = lives,
			playsrsall = playersdisplay,
			Players = plyers,
			amount = cashprize,
			cooldown = CoolDownTime,
			spec = spectateplayers,
		}
	else
		lobby = {
			life = lives,
			playsrsall = playersdisplay,
			Players = plyers,
			amount = cashprize,
			cooldown = CoolDownTime,
			spec = spectateplayers,
		}
	end
	cb(lobby)
end)
ESX.RegisterServerCallback('Pug:ServerCB:ViewCooldownMenu', function(source, cb)
	time = {
		cooldown = tonumber(CoolDownTime),
		started = gameHASStarted,
	}
	Wait(100)
	print(CoolDownTime)
	cb(time)
end)
ESX.RegisterServerCallback('Pug:SVCB:SpecatateplayersRoyale', function(source, cb)
    local src = source
    local Ply = ESX.GetPlayerFromId(src)
	local info = {}
	if gameStarted then
		if (#spectateplayers) >= 1 then
			for k, v in pairs(spectateplayers) do
				local targetped = GetPlayerPed(v)
				local ped = ESX.GetPlayerFromId(v)
				table.insert(info, {
					coords = GetEntityCoords(targetped),
					name = GetPlayerName(v),
					id = v,
					map = GulagMap,
                })
			end
		else
			cb(false)
			TriggerClientEvent('Pug:showNotificationBR', src, Translations.error.need_players,'error')
		end
	else
		cb(false)
		TriggerClientEvent('Pug:showNotificationBR', src, Translations.error.started_spectate,'error')
	end
	cb(info)
end)
RegisterNetEvent('Pug:Server:AddItemRoyale', function(itemName, amount)
    local src = source
	local Player = ESX.GetPlayerFromId(src)
	if Player ~= nil then
		Player.addInventoryItem(itemName, amount)
	end
end)
RegisterServerEvent('Pug:server:ChangeCoolDownTime',function(time)
	CoolDownTime = tonumber(time)
end)
RegisterServerEvent("Pug:server:AddPlayerToGulag", function()
	local src = source
	table.insert(GulagPlayers, src)
end)
RegisterServerEvent("Pug:server:StarGulagLoop", function()
	while gameHASStarted do
		Wait(Config.GulagCheckTime * 1000)
		if gameHASStarted then
			if everyone >= Config.GulagPlayersMin then
				if (#GulagPlayers) >= 2 then
					if not PlayersInGulag then
						local number = 0
						if Config.FlagModel ~= nil then
							print(GulagMap, "GulagMap")
							print(Config.MapLocation[GulagMap]["FlagSpawn"].x)
							GulagFlag = CreateObjectNoOffset(Config.FlagModel, Config.MapLocation[GulagMap]["FlagSpawn"].x, Config.MapLocation[GulagMap]["FlagSpawn"].y,Config.MapLocation[GulagMap]["FlagSpawn"].z-1, 1, true, 0)
						end
						SetEntityRoutingBucket(GulagFlag,dimention)
						local Weapon = math.random(1, #Config.RandomGulagWeapon)
						print(Weapon, "Weapon")
						for k, v in pairs(GulagPlayers) do
							Wait(100)
							if not PlayersInGulag then
								number = number + 1
								if number <= 2 then
									TriggerClientEvent("Pug:client:PutPlayerInGulag1v1",v,number,os.time(),GulagFlag,Config.RandomGulagWeapon[Weapon])
									if number == 2 then
										PlayersInGulag = true
									end
								end
							end
						end
					end
				end
			else
				Wait(5000)
				if (#GulagPlayers) >= 1 then
					for k, v in pairs(GulagPlayers) do
						TriggerClientEvent("Pug:client:GulagRemoveAllDutooCount",v)
					end
				end
			end
		else
			break
		end
	end
end)
RegisterServerEvent("Pug:server:LostTheGulag", function()
	PlayersInGulag = false
	for k, v in pairs(GulagPlayers) do
		TriggerClientEvent("Pug:client:RemoveFromGulags",v)
	end
end)
RegisterServerEvent("Pug:server:RemoveFrumGulag", function()
	for k, v in pairs(GulagPlayers) do
		if v == source then
			-- table.remove(GulagPlayers, k)
			GulagPlayers[k] = nil
		end
	end
end)
RegisterServerEvent("Pug:server:setBucket", function(tog)
	local src = source
	if tog then
		SetPlayerRoutingBucket(src, tonumber(dimention))
	else
		SetPlayerRoutingBucket(src, 0)
	end
end)
RegisterServerEvent("Pug:server:KillFeed", function(kill, causes)
	local src = source
	local Player = ESX.GetPlayerFromId(src)
	local Killer = ESX.GetPlayerFromId(kill)
	for k, v in pairs(allplayers) do
		if Killer ~= nil and Player ~= nil then
			if not causes == 0 then
				TriggerClientEvent('Pug:showNotificationBR', v, GetPlayerName(kill) ..' '..causes..' '..GetPlayerName(src), 'error')
			else
				TriggerClientEvent('Pug:showNotificationBR', v, GetPlayerName(kill) ..' dræbte '..GetPlayerName(src), 'error')
			end
		else
			if Player ~= nil then
				if not causes == 0 then
					TriggerClientEvent('Pug:showNotificationBR', v, causes..' '..GetPlayerName(src), 'error')
				else
					TriggerClientEvent('Pug:showNotificationBR', v, GetPlayerName(src)..' døde', 'error')
				end
			end
		end
	end
	if Killer ~= nil then
		TriggerClientEvent('Pug:client:UpdateKills',kill)
	end
end)
RegisterServerEvent("Pug:server:RemoveLootForEveryone", function(coords)
	for k, v in pairs(allplayers) do
		if v == source then
		else
			TriggerClientEvent("Pug:client:RemoveLootForEveryone", v, coords)
		end
	end
end)

ESX.RegisterServerCallback('Pug:server:RoyaleSpawnCar', function(source, cb, model)
	for k,v in pairs(Config.CarSpawn) do
		Wait(250)
		local random = math.random(1, (#Config.CarOptions))
		model = Config.CarOptions[random]
		local x, y, z, w = v.x, v.y, v.z, v.w
		local rndomcord = math.random(1,2)
		if rndomcord == 1 then
			x, y, z, w = Config.CarSpawn2[k].x, Config.CarSpawn2[k].y, Config.CarSpawn2[k].z, Config.CarSpawn2[k].w
		end
		local veh = CreateVehicle(model, x, y, z, w, true, false)
		while not DoesEntityExist(veh) do Wait(10) end
		SetEntityRoutingBucket(veh,dimention)
		local netId = NetworkGetNetworkIdFromEntity(veh)
	end
	cb(netId)
end)
ESX.RegisterServerCallback('Pug:server:RoyaleSpawnHeliCopter', function(source, cb, model)
	local count = 0
	for k,v in pairs(Config.HeliSpawns) do
		if count < (#Config.HeliSpawns) then
			count = count + 1
			Wait(250)
			local random = math.random(1, (#Config.HeliOptions))
			model = Config.HeliOptions[random]
			local x, y, z, w = v.x, v.y, v.z, v.w
			local rndomcord = math.random(1,2)
			if rndomcord == 1 then
				x, y, z, w = Config.HeliSpawns2[k].x, Config.HeliSpawns2[k].y, Config.HeliSpawns2[k].z, Config.HeliSpawns2[k].w
			end

			local veh = CreateVehicle(model, x, y, z, w, true, false)
			while not DoesEntityExist(veh) do Wait(10) end
			SetEntityRoutingBucket(veh,dimention)
			local netId = NetworkGetNetworkIdFromEntity(veh)
		end
	end
	cb(netId)
end)
--Events
AddEventHandler('playerDropped', function()
    local src = source
	local changed = false
	for k, v in pairs(allplayers) do
		if v == src then
			changed = true
			everyone = everyone - 1
			-- table.remove(allplayers,k)
			allplayers[k] = nil
			for k, v in pairs(allplayers) do
				if Player ~= nil then
					TriggerClientEvent('Pug:showNotificationBR', v,'En spiller laggede ud, eller leavede.', 'error')
				else
					TriggerClientEvent('Pug:showNotificationBR', v, 'En spiller laggede ud, eller leavede.', 'error')
				end
				TriggerClientEvent("Pug:client:PlayerKilledNotificationRoyale", v)
			end
		end
	end
	Wait(100)
	if changed then
		for k,v in pairs(spectateplayers) do
			if v == src then
				-- table.remove(spectateplayers,k)
				spectateplayers[k] = nil
			end
		end
		Wait(100)
		for k, v in pairs(GulagPlayers) do
			if v == src then
				-- table.remove(GulagPlayers, k)
				GulagPlayers[k] = nil
				for k, v in pairs(GulagPlayers) do
					TriggerClientEvent("Pug:client:RemoveFromGulags",v)
				end
			end
		end
		Wait(100)
		if everyone == 2 then
			local Player = ESX.GetPlayerFromId(src)
			local prize = round(cashprize * 0.85)
			print('3rd place won $', prize)
			if Player ~= nil then
				Player.addMoney(prize)
			end
		elseif everyone == 1 then
			local Player = ESX.GetPlayerFromId(src)
			local prize = round(cashprize * 0.85)
			print('2nd place won $', prize)
			if Player ~= nil then
				Player.addMoney(prize)
			end
		elseif everyone == 0 then
			local Player = ESX.GetPlayerFromId(src)
			local prize = round(cashprize * 0.85)
			print('1st place won $', prize)
			if Player ~= nil then
				Player.addMoney(prize)
			end
			for k,v in pairs(allplayers) do
				for i, j in pairs(spectateplayers) do
					local Ply = ESX.GetPlayerFromId(j)
					if Ply then
						TriggerClientEvent('Pug:showNotificationBR', v, GetPlayerName(j) ..' vandt Battle Royale!')
					end
					TriggerClientEvent('Pug:client:removeFromRoyale',v)
					TriggerClientEvent('Pug:client:removeFromRoyale2',src)
				end
			end
			Wait(500)
			if gameHASStarted then
				TriggerClientEvent("Pug:client:UpdateAllGameCoolDownActive", -1)
			end
			PlayersInGulag = false
			GulagPlayers = {}
			spectateplayers = {}
			allplayers = {}
			gameStarted = false
			richplayers = 0
			lives = 1
			everyone = 0
		end
	end
end)
RegisterServerEvent('Pug:server:RemoveAllFromPlane',function()
	for k, v in pairs(allplayers) do
		TriggerClientEvent('Pug:client:RemoveAllFromPlane', v)
	end 
end)
RegisterServerEvent('Pug:server:EnemyUAVEffectForAll',function()
	local src = source
	for k, v in pairs(allplayers) do
		if v == src then
			TriggerClientEvent('InteractSound_CL:PlayOnOne', v, "uaventeringao", 0.3)
		else
			TriggerClientEvent('InteractSound_CL:PlayOnOne', v, "enemyuav", 0.3)
		end
	end 
	local count = 0
    while count <= 10 do
        Wait(5000)
        count = count + 1
		for k,v in pairs(allplayers) do
			if v == src then
			else
				local Coords = GetEntityCoords(GetPlayerPed(v))
				TriggerClientEvent("Pug:client:AcivateUav",src,Coords,v)
			end
        end
    end
end)
RegisterServerEvent('Pug:server:JoinRoyale',function()
	local src = source
	local Player = ESX.GetPlayerFromId(src)
	if (#allplayers) < Config.MaxPlayers then
		table.insert(allplayers,src)
		table.insert(spectateplayers,src)
		TriggerClientEvent('Pug:client:joinedRoyale',src)
		TriggerClientEvent('Pug:client:joinedRoyale2',src)
		for k, v in pairs(allplayers) do
			TriggerClientEvent('Pug:showNotificationBR', v, GetPlayerName(src) ..' joinede Battle Royale!', 'success')
		end
		if Config.DrawmarkerStartQueueLocation then
			if (#allplayers) <= 1 then
				TriggerEvent("Pug:server:StartRoyaleQueueTime", src)
			end
		end
	else
		TriggerClientEvent('Pug:showNotificationBR', src, 'Royale lobbien er fuld!', 'error')
	end
end)
RegisterNetEvent("Pug:server:StartRoyaleQueueTime", function(ID)
	local QueueTime = math.ceil(Config.QueueTime * 60000)
	while QueueTime > 0 do
		Wait(1000)
		QueueTime = QueueTime - 1000
		TriggerClientEvent("Pug:client:UpdateRoyaleQueueTime",-1, QueueTime)
	end
	TriggerEvent("Pug:server:startroyale", ID)
end)
RegisterServerEvent('Pug:SV:SetlivesOfPlayersRoyale',function(lifeNum)
	lives = lifeNum
	if lives == 0 then lives = 1 end
	for k, v in pairs(allplayers) do
		TriggerClientEvent('Pug:showNotificationBR', v, lives..' liv til hver spiller er blevet sat!')
	end
end)
RegisterServerEvent('Pug:SV:SetRoyaleWagerAmount',function(WageNum)
	cashprize = WageNum
	local prize = cashprize * (#allplayers)
	for k, v in pairs(allplayers) do
		TriggerClientEvent('Pug:showNotificationBR', v, ''..prize..'DKK er blevet sat som prize pool!')
	end
end)
RegisterServerEvent('Pug:server:RoyaleLeave',function()
	local src = source
	local Player = ESX.GetPlayerFromId(src)
	for k, v in pairs(allplayers) do
		if v == src then
			-- table.remove(allplayers,k)
			allplayers[k] = nil
		end
		TriggerClientEvent('Pug:showNotificationBR', v, GetPlayerName(src) ..' leavede Battle Royale!', 'error')
		TriggerClientEvent("Pug:client:PlayerKilledNotificationRoyale", v)
	end
	for k,v in pairs(spectateplayers) do
		if v == src then
			-- table.remove(spectateplayers,k)
			spectateplayers[k] = nil
		end
	end
	TriggerClientEvent('Pug:client:removeFromRoyale',src)
	TriggerClientEvent('Pug:client:removeFromRoyale2',src)
	if (#allplayers) <= 0 then
		if gameHASStarted then
			TriggerClientEvent("Pug:client:UpdateAllGameCoolDownActive", -1)
		end
		PlayersInGulag = false
		GulagPlayers = {}
		spectateplayers = {}
		allplayers = {}
		gameStarted = false
		richplayers = 0
		lives = 1
		everyone = 0
	end
end)
RegisterServerEvent('Pug:server:startroyale',function(ID)
	local src = source or ID
	if ID then
		src = ID
	end
	if (#allplayers) >= Config.MinPlayers then
		dimention = math.random(400,999)
		GulagMap = Config.GulagMap[math.random(1,#Config.GulagMap)]
		local plnspawn = math.random(1, #Config.PlaneSpawns)
		for k, v in pairs(allplayers) do
			local Player = ESX.GetPlayerFromId(v)
			if Player ~= nil then
				moneycheck(Player)
			end
		end
		Wait(100)
		if richplayers >= (#allplayers) then
			gameStarted = true
			gameHASStarted = true
			everyone = (#allplayers)
			for k, v in pairs(allplayers) do
				TriggerClientEvent('Pug:client:BeginRoyaleMatch',v,lives,plnspawn,everyone,os.time(),Config.BeginningTimeInSeconds,CoolDownTime,GulagMap)
				local Players = ESX.GetPlayerFromId(v)
				print(cashprize, "cashprize")
				if Players ~= nil then
					Players.removeMoney(cashprize)
				end
				SetPlayerRoutingBucket(v, tonumber(dimention))
			end
			cashprize = cashprize * (#allplayers)
			Wait(500)
			print(everyone)
			TriggerClientEvent("Pug:client:UpdateAllGameHasStarted", -1)
		end
		if richplayers >= (#allplayers) then
			TriggerEvent("Pug:server:StarGulagLoop")
			TriggerEvent("Pug:server:BeginRoyaleMatchTimer")
			TriggerClientEvent('Pug:client:RoyalePlaneBegin',src, plnspawn)
		end
		richplayers = 0
	else
		TriggerClientEvent('Pug:showNotificationBR', src, 'Der skal minimum være '..Config.MinPlayers..' spillere for at starte.', 'error')
	end
end)
RegisterServerEvent('Pug:SV:NotifyLivesLeftRoyale',function(lifeLeft)
	local src = source
	local Player = ESX.GetPlayerFromId(src)
	for k, v in pairs(allplayers) do
		TriggerClientEvent('Pug:showNotificationBR', v, GetPlayerName(src) ..' har '..lifeLeft..' liv tilbage')
		TriggerClientEvent("Pug:client:PlayerKilledNotificationRoyale", v)
	end
end)
RegisterServerEvent('Pug:client:RemoveRoyalePlayer',function()
	everyone = everyone - 1
	local src = source
	local Player = ESX.GetPlayerFromId(src)
	for k,v in pairs(spectateplayers) do
		if v == src then
			-- table.remove(spectateplayers,k)
			spectateplayers[k] = nil
		end
	end
	TriggerClientEvent('Pug:client:removeFromRoyale',src)
	TriggerClientEvent('Pug:client:removeFromRoyale2',src)
	Wait(100)
	for k,v in pairs(allplayers) do
		TriggerClientEvent('InteractSound_CL:PlayOnOne', v, "terminate", 0.2)
		TriggerClientEvent('Pug:showNotificationBR', v, GetPlayerName(src) ..' er blevet eliminated!')
		TriggerClientEvent('Pug:UpdatePlayersLeft', v, everyone)
		if everyone == 1 or everyone == 0 then
			TriggerClientEvent("Pug:client:RemoveAllRoyaleVehicles",src)
		end
	end
	Wait(500)
	print(everyone)
	if everyone == 3 then
		local prize = round(cashprize * 0.35)
		print('3rd place won $', prize)
		Player.addMoney(prize)
		TriggerClientEvent('Pug:showNotificationBR', src, 'Du kom på '.. (everyone + 1) ..'. plads', 'success', 10000)
	elseif everyone == 2 then
		local prize = round(cashprize * 0.50)
		print('2nd place won $', prize)
		Player.addMoney(prize)
		TriggerClientEvent('Pug:showNotificationBR', src, 'Du kom på '.. (everyone + 1) ..'. plads', 'success', 10000)
	elseif everyone == 1 or everyone == 0 then
		local winner = 'joe'
		local prize = round(cashprize * 0.85)
		for i, j in pairs(spectateplayers) do
			local Ply = ESX.GetPlayerFromId(j)
			if Ply then
				Ply.addMoney(prize)
				ClearInventoryESX(j)
				winner = GetPlayerName(j)
				print(winner ..' 1st place won $', prize)
			end
		end
		for k,v in pairs(allplayers) do
			TriggerClientEvent('Pug:showNotificationBR', v, winner ..' vandt Battle Royale!', 'success', 10000)
			if v == src then
			else
				TriggerClientEvent('Pug:client:removeFromRoyale',v)
				TriggerClientEvent('Pug:client:removeFromRoyale2',v)
				SetPlayerRoutingBucket(v, 0)
			end
		end
		Wait(500)
		if gameHASStarted then
			TriggerClientEvent("Pug:client:UpdateAllGameCoolDownActive", -1)
		end
		PlayersInGulag = false
		GulagPlayers = {}
		spectateplayers = {}
		allplayers = {}
		gameStarted = false
		richplayers = 0
		lives = 1
		everyone = 0
	end
	SetPlayerRoutingBucket(src, 0)
	ClearInventoryESX(src)
	return
end)

ESX.RegisterServerCallback('Pug:Server:getLiveTimeRoyale', function(source, cb)
	local Player = ESX.GetPlayerFromId(source)
	if Player ~= nil then 
		cb(os.time())
	end
end)

ESX.RegisterServerCallback('Pug:GetGulagAvailabilityNumber', function(source, cb)
	local info = {}
	info = {
		allPeople = everyone,
		gulagpeople = (#GulagPlayers),
	}
	Wait(100)
	cb(info)
end)

RegisterServerEvent('Pug:server:BeginRoyaleMatchTimer',function()
	while gameStarted do
		Wait(1000)
		if not gameStarted then gameHASStarted = false TriggerClientEvent("Pug:client:UpdateAllGameHasEnded",-1) break end
		local rndome = math.random(1,#Config.ZoneOptions)
		local Zone = Config.ZoneOptions[rndome]
		local offsetx = math.random(-75.0, 75.0)
		local offsety = math.random(-75.0, 75.0)
		function RandomArea()
			offsetx = math.random(-75.0, 75.0)
			offsety = math.random(-75.0, 75.0)
		end
		Wait(Config.BeginningTimeInSeconds * 1000) -- Wave 1
		if not gameStarted then gameHASStarted = false TriggerClientEvent("Pug:client:UpdateAllGameHasEnded",-1) break end
		for k, v in pairs(allplayers) do 
			TriggerClientEvent("Pug:client:UpdateTimeLeftRoyale",v, os.time(),CoolDownTime)
			TriggerClientEvent("Pug:client:CreateRoyaleZone",v, Zone, 500.0,offsetx,offsety, 4.3)
		end
		Wait(math.ceil(tonumber(CoolDownTime) * 1000)) -- Wave 2
		if not gameStarted then gameHASStarted = false TriggerClientEvent("Pug:client:UpdateAllGameHasEnded",-1) break end
		RandomArea()
		for k, v in pairs(allplayers) do 
			TriggerClientEvent("Pug:client:UpdateTimeLeftRoyale",v, os.time(),Config.CircleTimeInSeconds)
		end
		Wait(Config.CircleTimeInSeconds * 1000) -- Wave 3
		if not gameStarted then gameHASStarted = false TriggerClientEvent("Pug:client:UpdateAllGameHasEnded",-1) break end
		RandomArea()
		for k, v in pairs(allplayers) do 
			TriggerClientEvent("Pug:client:UpdateTimeLeftRoyale",v, os.time(),CoolDownTime)
			TriggerClientEvent("Pug:client:CreateRoyaleZone",v, Zone, 300.0,offsetx,offsety, 2.6)
		end
		Wait(math.ceil(tonumber(CoolDownTime) * 1000)) -- Wave 4
		if not gameStarted then gameHASStarted = false TriggerClientEvent("Pug:client:UpdateAllGameHasEnded",-1) break end
		RandomArea()
		for k, v in pairs(allplayers) do 
			TriggerClientEvent("Pug:client:UpdateTimeLeftRoyale",v, os.time(),Config.CircleTimeInSeconds2)
		end
		Wait(Config.CircleTimeInSeconds2 * 1000) -- Wave 5
		if not gameStarted then gameHASStarted = false TriggerClientEvent("Pug:client:UpdateAllGameHasEnded",-1) break end
		RandomArea()
		for k, v in pairs(allplayers) do 
			TriggerClientEvent("Pug:client:UpdateTimeLeftRoyale",v, os.time(),CoolDownTime)
			TriggerClientEvent("Pug:client:CreateRoyaleZone",v, Zone, 200.0,offsetx,offsety, 1.6)
		end
		Wait(math.ceil(tonumber(CoolDownTime) * 1000)) -- Wave 6
		RandomArea()
		for k, v in pairs(allplayers) do 
			TriggerClientEvent("Pug:client:UpdateTimeLeftRoyale",v, os.time(),Config.CircleTimeInSeconds3)
		end
		Wait(Config.CircleTimeInSeconds3 * 1000) -- Wave 7
		if not gameStarted then gameHASStarted = false TriggerClientEvent("Pug:client:UpdateAllGameHasEnded",-1) break end
		RandomArea()
		for k, v in pairs(allplayers) do 
			TriggerClientEvent("Pug:client:UpdateTimeLeftRoyale",v, os.time(),CoolDownTime)
			TriggerClientEvent("Pug:client:CreateRoyaleZone",v, Zone, 100.0,offsetx,offsety, 1.0)
		end
		Wait(math.ceil(tonumber(CoolDownTime) * 1000)) -- Wave 8
		if not gameStarted then gameHASStarted = false TriggerClientEvent("Pug:client:UpdateAllGameHasEnded",-1) break end
		RandomArea()
		for k, v in pairs(allplayers) do 
			TriggerClientEvent("Pug:client:UpdateTimeLeftRoyale",v, os.time(),Config.CircleTimeInSeconds4)
		end
		Wait(Config.CircleTimeInSeconds4 * 1000) -- Wave 9
		if not gameStarted then gameHASStarted = false TriggerClientEvent("Pug:client:UpdateAllGameHasEnded",-1) break end
		offsetx = math.random(-35.0, 35.0)
		offsety = math.random(-35.0, 35.0)
		for k, v in pairs(allplayers) do 
			TriggerClientEvent("Pug:client:UpdateTimeLeftRoyale",v, os.time(),CoolDownTime)
			TriggerClientEvent("Pug:client:CreateRoyaleZone",v, Zone, 50.0,offsetx,offsety, 0.44)
		end
		Wait(math.ceil(tonumber(CoolDownTime) * 1000)) -- Wave 10
		if not gameStarted then gameHASStarted = false TriggerClientEvent("Pug:client:UpdateAllGameHasEnded",-1) break end
		RandomArea()
		for k, v in pairs(allplayers) do 
			TriggerClientEvent("Pug:client:UpdateTimeLeftRoyale",v, os.time(),Config.CircleTimeInSeconds)
		end
		Wait(Config.CircleTimeInSeconds * 1000) -- Wave 11
		if not gameStarted then gameHASStarted = false TriggerClientEvent("Pug:client:UpdateAllGameHasEnded",-1) break end
		offsetx = math.random(-15.0, 15.0)
		offsety = math.random(-15.0, 15.0)
		for k, v in pairs(allplayers) do 
			TriggerClientEvent("Pug:client:UpdateTimeLeftRoyale",v, os.time(),CoolDownTime)
			TriggerClientEvent("Pug:client:CreateRoyaleZone",v, Zone, 20.0,offsetx,offsety, 0.255)
		end
		Wait(math.ceil(tonumber(CoolDownTime) * 1000)) -- Wave 12
		if not gameStarted then gameHASStarted = false TriggerClientEvent("Pug:client:UpdateAllGameHasEnded",-1) break end
		RandomArea()
		for k, v in pairs(allplayers) do 
			TriggerClientEvent("Pug:client:UpdateTimeLeftRoyale",v, os.time(),Config.CircleTimeInSeconds)
		end
		Wait(Config.CircleTimeInSeconds * 1000) -- Wave 11
		if not gameStarted then gameHASStarted = false TriggerClientEvent("Pug:client:UpdateAllGameHasEnded",-1) break end
		offsetx = math.random(-15.0, 15.0)
		offsety = math.random(-15.0, 15.0)
		for k, v in pairs(allplayers) do 
			TriggerClientEvent("Pug:client:UpdateTimeLeftRoyale",v, os.time(),CoolDownTime)
			TriggerClientEvent("Pug:client:CreateRoyaleZone",v, Zone, 5.0,offsetx,offsety, 0.1)
		end
		Wait(math.ceil(tonumber(CoolDownTime) * 1000)) -- Wave 12
		if not gameStarted then gameHASStarted = false TriggerClientEvent("Pug:client:UpdateAllGameHasEnded",-1) break end
		RandomArea()
		for k, v in pairs(allplayers) do 
			TriggerClientEvent("Pug:client:UpdateTimeLeftRoyale",v, os.time(),Config.CircleTimeInSeconds)
		end
		if not gameStarted then gameHASStarted = false TriggerClientEvent("Pug:client:UpdateAllGameHasEnded",-1) break end
	end
end)