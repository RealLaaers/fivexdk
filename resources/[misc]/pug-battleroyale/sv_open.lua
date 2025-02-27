for k, v in pairs(Config.RoyaleLoot) do
	ESX.RegisterUsableItem(v.name, function(source, item)
		local src = source
		local Player = ESX.GetPlayerFromId(src)
		Player.removeInventoryItem(v.name, 1)
		local data = {
			name = v.name
		}
		TriggerClientEvent('Pug:client:UseRoyaleItem', src, data)
	end)
end
ESX.RegisterUsableItem("pug-vr", function(source, item)
	local ItemName = item
	if Config.InventoryType == "qs" then
		ItemName = item.name
	end
    if Config.HasPaintball then
        TriggerClientEvent('Pug:client:ViewBattleGameMenus', source, ItemName)
    else
        TriggerClientEvent('Pug:client:ViewBattleRoyale', source, ItemName)
    end
end)
RegisterServerEvent('Pug:server:BothVRGamesMenus', function()
    if Config.HasPaintball then
        TriggerClientEvent('Pug:client:ViewBattleGameMenus', source)
    else
        TriggerClientEvent('Pug:client:ViewBattleRoyale', source)
    end
end)
RegisterServerEvent('Pug:server:SaveRoyaleItems', function()
    local src = source
    local Player = ESX.GetPlayerFromId(src)
	local CitizenId = ESX.GetIdentifier(src)
	local PlayerItems
	if Config.InventoryType == "ak47" then
		local Identify = Player.getIdentifier()
		PlayerItems = exports["ak47_inventory"]:getInventoryItems(Identify)
	elseif Config.InventoryType == "qs" then
		if Player then
			local Identify = Player.getIdentifier()
			PlayerItems = exports['qs-inventory']:GetInventory(src)
		end
	else
		PlayerItems = Player.inventory
	end
	local Result = MySQL.query.await('SELECT * FROM pug_paintball WHERE citizenid = ?', {CitizenId})
	if Result[1] then
		if Config.Debug then
			print(Result[1].gameitems, 'data table')
		end
		if Result[1].gameitems == "nothing" then
			MySQL.update('UPDATE pug_paintball SET gameitems = ? WHERE citizenid = ?', { json.encode(PlayerItems), CitizenId })
		end
	else
		if Config.Debug then
			print('data table not found')
		end
		MySQL.insert.await('INSERT INTO pug_paintball (citizenid, gameitems, kills, deaths, wins) VALUES (?,?,?,?,?)', {
			CitizenId, json.encode(PlayerItems), 0, 0, 0
		})
	end
	Wait(200)
	ClearInventoryESX(src)
	if Config.Debug then
		print('clearing ' .. src)
	end
end)
RegisterServerEvent('Pug:server:GiveRoyaleItems', function()
    local src = source
    local Player = ESX.GetPlayerFromId(src)
	local CitizenId = ESX.GetIdentifier(src)
	local Result = MySQL.query.await('SELECT * FROM pug_paintball WHERE citizenid = ?', {CitizenId})
	if Result[1] then
		Wait(1000)
		if Config.Debug then
			print(Result[1].gameitems, 'data table2')
		end
		if Result[1].gameitems == "nothing" then
		else
            for k, v in pairs(json.decode(Result[1].gameitems)) do
				if tostring(string.lower(Config.InventoryType)) == "ox" then 
                    local ox_inventory = exports.ox_inventory
                    if Config.Debug then
                        print(v.count, "count")
                    end
                    ox_inventory:AddItem(src, v.name, v.count, v.metadata, v.slot)
                else
                    Player.addInventoryItem(v.name, v.amount, false, v.info)
                end
            end
			Wait(500)
			MySQL.update('UPDATE pug_paintball SET gameitems = ? WHERE citizenid = ?', { "nothing", CitizenId })
		end
	end
end)


CreateThread(function()
	while GetResourceState("es_extended") ~= 'started' and GetResourceState("qb-core") ~= 'started' do Wait(1000) end
	MySQL.query([[
		CREATE TABLE IF NOT EXISTS `pug_paintball` (
			`id` int(11) NOT NULL AUTO_INCREMENT,
			`citizenid` varchar(50) DEFAULT NULL,
			`gameitems` text DEFAULT NULL,
			`kills` int(11) DEFAULT NULL,
			`deaths` int(11) DEFAULT NULL,
			`wins` int(11) DEFAULT NULL,
			PRIMARY KEY (`id`)
		) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;
	]])
end)