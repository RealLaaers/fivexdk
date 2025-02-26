local AllCreatedZones = {}

for k,v in pairs(AllZones) do
	local TempZone = nil
	local TempTable = {}
	for k2,v2 in ipairs(v.Zones) do
		TempZone = PolyZone:Create(v2.Coords, {
			name = k .. "_" .. k2,
			minZ = v2.minZ,
			maxZ = v2.maxZ,
			debugPoly = v.Debug,
			debugGrid = v.Debug,
		})
		table.insert(TempTable,TempZone)
	end
	if #TempTable > 1 then
		TempZone = ComboZone:Create(TempTable, {name= k .. "_combo"})
		
		TempZone:onPlayerInOut(function(isPointInside, point, zone)
		  EnteredZone(isPointInside,k)
		end, CheckLoopTime)
	else
		TempZone:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point, zone)
		  EnteredZone(isPointInside,k)
		end, CheckLoopTime)
	end
end

local IsLoopStarted = false
local WhatIsLastLoop = ""

function EnteredZone(isPointInside,Name)
	local InZone,Name = InZone,Name
	if isPointInside and WhatIsLastLoop ~= Name then
		CreateThread(function()
			WhatIsLastLoop = Name
			IsLoopStarted = true
			while WhatIsLastLoop == Name do
				DisablePlayerFiring(PlayerPedId(),true)  -- Disables firing all together
				SetPlayerCanDoDriveBy(PlayerPedId(), false)
				DisableControlAction(0, 140, true) -- R
				DisableControlAction(0, 24, true) -- left MOUSE BUTTON shoot
				ResetEntityAlpha(PlayerPedId())
        		SetCanAttackFriendly(PlayerPedId(),false,false)
        		NetworkSetFriendlyFireOption(false)
				Wait(5)
			end
			IsLoopStarted = false
		end)
	else
		WhatIsLastLoop = ""
	end
end

CreateThread(function()
	while true do
		Wait(3)
        if IsLoopStarted then
			DisablePlayerFiring(PlayerPedId(),true)  -- Disables firing all together
			SetPlayerCanDoDriveBy(PlayerPedId(), false)
			SetPlayerInvincible(PlayerId(), 1)
			DisableControlAction(0, 24, true) -- left MOUSE BUTTON shoot
			DisableControlAction(0, 140, true) -- R
			ResetEntityAlpha(PlayerPedId())
        	SetCanAttackFriendly(PlayerPedId(),false,false)
        	NetworkSetFriendlyFireOption(false)
		end
		-- if WhatIsLastLoop == 'SPAWN' then
		-- 	SetRunSprintMultiplierForPlayer(PlayerId(), 1.49)
		-- end
	end
end)

-- Exports
InSafeZone = function()
    return IsLoopStarted
end

exports("InSafeZone", InSafeZone)

SafeZoneName = function()
    return WhatIsLastLoop
end

exports("SafeZoneName", SafeZoneName)

CanAttackInSafeZone = function()
    return IsPlayerCanAttackInSafeZone
end

exports("CanAttackInSafeZone", CanAttackInSafeZone)