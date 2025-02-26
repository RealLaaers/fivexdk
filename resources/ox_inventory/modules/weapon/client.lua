if not lib then return end

local Weapon = {}
local Items = require 'modules.items.client'
local Utils = require 'modules.utils.client'

-- generic group animation data
local anims = {}
anims[`GROUP_MELEE`] = { 'melee@holster', 'unholster', 200, 'melee@holster', 'holster', 600 }
anims[`GROUP_PISTOL`] = { 'rcmjosh4', 'josh_leadout_cop2', 250, 'rcmjosh4', 'josh_leadout_cop2', 250 }
anims[`GROUP_STUNGUN`] = anims[`GROUP_PISTOL`]

local stashWeapons = {
	["WEAPON_BAT"] = true,
    ["WEAPON_GOLFCLUB"] = true,
    ["WEAPON_CROWBAR"] = true,
    ["WEAPON_WRENCH"] = true,
    ["WEAPON_HATCHET"] = true,
    ["WEAPON_BATTLEAXE"] = true,
    ["WEAPON_MACHETE"] = true,
    ["WEAPON_POOLCUE"] = true,
    ["WEAPON_MICROSMG"] = true,
	["WEAPON_MINISMG"] = true,
    ["WEAPON_SMG"] = true,
    ["WEAPON_DBSHOTGUN"] = true,
    ["WEAPON_MACHINEPISTOL"] = true,
    ["WEAPON_GUSENBERG"] = true,
    ["WEAPON_COMPACTRIFLE"] = true,
    ["WEAPON_ASSAULTRIFLE"] = true,
    ["WEAPON_CARBINERIFLE"] = true,
    ["WEAPON_CARBINERIFLE_MK2"] = true,
    ["WEAPON_COMBATPDW"] = true,
    ["WEAPON_PUMPSHOTGUN"] = true,
    ["WEAPON_COMBATSHOTGUN"] = true,
    ["WEAPON_BATS"] = true,
}

local function vehicleIsCycle(vehicle)
	local class = GetVehicleClass(vehicle)
	return class == 8 or class == 13
end

function Weapon.Equip(item, data, noWeaponAnim)
	local playerPed = cache.ped
	local coords = GetEntityCoords(playerPed, true)
    local sleep

	if client.weaponanims then
		if cache.vehicle and vehicleIsCycle(cache.vehicle) then
			goto skipAnim
		end

		local animDict, anim = "", ""
		if stashWeapons[item.name] then
			animDict = 'anim@heists@ornate_bank@grab_cash'
			anim = "intro"
			sleep = 700
		elseif data.hash == `WEAPON_SWITCHBLADE` then
			animDict = 'anim@melee@switchblade@holster'
			anim = "unholster"
			sleep = 200
		else
			animDict = "rcmjosh4"
			anim = "josh_leadout_cop2"
			sleep = 250
		end

		if animDict ~= "" and anim ~= "" and sleep ~= 0 then
			Utils.PlayAnimAdvanced(sleep, animDict, anim, coords.x, coords.y, coords.z, 0, 0, GetEntityHeading(playerPed), 8.0, 3.0, sleep*2, 50, 0.0)
		end
	end

	::skipAnim::

	item.hash = data.hash
	item.ammo = data.ammoname
	item.melee = GetWeaponDamageType(data.hash) == 2 and 0
	item.timer = 0
	item.throwable = data.throwable
	item.group = GetWeapontypeGroup(item.hash)

	GiveWeaponToPed(playerPed, data.hash, 0, false, true)

	if item.metadata.tint then SetPedWeaponTintIndex(playerPed, data.hash, item.metadata.tint) end

	if item.metadata.components then
		for i = 1, #item.metadata.components do
			local components = Items[item.metadata.components[i]].client.component
			for v=1, #components do
				local component = components[v]
				if DoesWeaponTakeWeaponComponent(data.hash, component) then
					if not HasPedGotWeaponComponent(playerPed, data.hash, component) then
						GiveWeaponComponentToPed(playerPed, data.hash, component)
					end
				end
			end
		end
	end

	if item.metadata.specialAmmo then
		local clipComponentKey = ('%s_CLIP'):format(data.model:gsub('WEAPON_', 'COMPONENT_'))
		local specialClip = ('%s_%s'):format(clipComponentKey, item.metadata.specialAmmo:upper())

		if DoesWeaponTakeWeaponComponent(data.hash, specialClip) then
			GiveWeaponComponentToPed(playerPed, data.hash, specialClip)
		end
	end

	local ammo = item.metadata.ammo or item.throwable and 1 or 0

	SetCurrentPedWeapon(playerPed, data.hash, true)
	SetPedCurrentWeaponVisible(playerPed, true, false, false, false)
	SetWeaponsNoAutoswap(true)
	SetPedAmmo(playerPed, data.hash, ammo)
	SetTimeout(0, function() RefillAmmoInstantly(playerPed) end)

	if item.group == `GROUP_PETROLCAN` or item.group == `GROUP_FIREEXTINGUISHER` then
		item.metadata.ammo = item.metadata.durability
		SetPedInfiniteAmmo(playerPed, true, data.hash)
	end

	TriggerEvent('ox_inventory:currentWeapon', item)

	if client.weaponnotify then
		Utils.ItemNotify({ item, 'ui_equipped' })
	end

	return item, sleep
end

function Weapon.Disarm(currentWeapon, noAnim)
	if currentWeapon?.timer then
		currentWeapon.timer = nil

        TriggerServerEvent('ox_inventory:updateWeapon')
		SetPedAmmo(cache.ped, currentWeapon.hash, 0)

		if client.weaponanims then
			if cache.vehicle and vehicleIsCycle(cache.vehicle) then
				goto skipAnim
			end

			ClearPedSecondaryTask(cache.ped)

			local animDict, anim, sleep = "", "", 0
			if stashWeapons[currentWeapon.name] then
				animDict = 'anim@heists@ornate_bank@grab_cash'
				anim = "intro"
				sleep = 700
			elseif currentWeapon.hash == `WEAPON_SWITCHBLADE` then
				animDict = 'anim@melee@switchblade@holster'
				anim = "holster"
				sleep = 600
			else
				animDict = "rcmjosh4"
				anim = "josh_leadout_cop2"
				sleep = 250
			end

			if animDict ~= "" and anim ~= "" and sleep ~= 0 and not noAnim then 
				local coords = GetEntityCoords(cache.ped, true)
				Utils.PlayAnimAdvanced(sleep, animDict, anim, coords.x, coords.y, coords.z, 0, 0, GetEntityHeading(cache.ped), 8.0, 3.0, sleep*2, 50, 0.0)
			end
		end

		::skipAnim::

		if client.weaponnotify then
			Utils.ItemNotify({ currentWeapon, 'ui_holstered' })
		end

		TriggerEvent('ox_inventory:currentWeapon')
	end

	Utils.WeaponWheel()
	RemoveAllPedWeapons(cache.ped, true)
end

function Weapon.ClearAll(currentWeapon)
	Weapon.Disarm(currentWeapon)

	if client.parachute then
		local chute = `GADGET_PARACHUTE`
		GiveWeaponToPed(cache.ped, chute, 0, true, false)
		SetPedGadget(cache.ped, chute, true)
	end
end

Utils.Disarm = Weapon.Disarm
Utils.ClearWeapons = Weapon.ClearAll

return Weapon
