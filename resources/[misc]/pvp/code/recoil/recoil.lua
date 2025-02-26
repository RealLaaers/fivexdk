local residentIconColor = 'red'
local pvpIconColor = 'green'
local danishIconColor = 'red'
local syndicateIconColor = 'red'
local recoil = 'pvp'

RegisterCommand('recoil', function()
	lib.registerContext({
		id = 'recoil_menu',
		title = 'FiveX - Recoil',
		menu  = 'justeringer',
		options = {
			{
				title = 'PVP Recoil',
				description = 'Klik for at anvende PVP Recoil.',
				icon = 'circle-check',
				iconColor = pvpIconColor,
				onSelect = function(args)
					pvpIconColor = 'green'
					residentIconColor = 'red'
					danishIconColor = 'red'
					syndicateIconColor = 'red'
					recoil = 'pvp'
				end,
			},
			{
				title = 'Resident Recoil',
				description = 'Klik for at anvende Resident recoil.',
				icon = 'circle-check',
				iconColor = residentIconColor,
				onSelect = function(args)
					pvpIconColor = 'red'
					residentIconColor = 'green'
					danishIconColor = 'red'
					syndicateIconColor = 'red'
					recoil = 'resident'
				end,
			},
			{
				title = 'DanishRP Recoil',
				description = 'Klik for at anvende DanishRP recoil.',
				icon = 'circle-check',
				iconColor = danishIconColor,
				onSelect = function(args)
					residentIconColor = 'red'
					pvpIconColor = 'red'
					danishIconColor = 'green'
					syndicateIconColor = 'red'
					recoil = 'danishrp'
				end,
			},
			{
				title = 'Syndicate Recoil (UNDER UDVIKLING)',
				description = 'Klik for at anvende Syndicate recoil.',
				icon = 'circle-check',
				iconColor = syndicateIconColor,
				onSelect = function(args)
					residentIconColor = 'red'
					pvpIconColor = 'red'
					danishIconColor = 'red'
					syndicateIconColor = 'green'
					recoil = 'syndicate'
				end,
			},
		},
	})
	lib.showContext('recoil_menu')
end)

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)

		local ped = PlayerPedId()
		local hasWeapon, weapon = GetCurrentPedWeapon(ped)

        if hasWeapon then
			if IsPedArmed(ped, 6) then
				DisableControlAction(1, 140, true)
				DisableControlAction(1, 141, true)
				DisableControlAction(1, 142, true)
			end
			
			DisplayAmmoThisFrame(false)
			if recoil == 'resident' then
			
			if weapon == GetHashKey("WEAPON_SNSPISTOL") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.02)
				end
			end
			
			if weapon == GetHashKey("WEAPON_SNSPISTOL_MK2") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)
				end
			end
			
			if weapon == GetHashKey("WEAPON_PISTOL") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)
				end
			end

			if weapon == GetHashKey("WEAPON_CERAMICPISTOL") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)
				end
			end
			
			if weapon == GetHashKey("WEAPON_PISTOL_MK2") then
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.03)
				end
			end
			
			if weapon == GetHashKey("WEAPON_APPISTOL") then
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.00000000000)
				end
			end
			
			if weapon == GetHashKey("WEAPON_COMBATPISTOL") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)
				end
			end
			
			if weapon == GetHashKey("WEAPON_PISTOL50") then
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)
				end
			end
			
			if weapon == GetHashKey("WEAPON_HEAVYPISTOL") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
				end
			end
			
			if weapon == GetHashKey("WEAPON_VINTAGEPISTOL") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)
				end
			end
			
			if weapon == GetHashKey("WEAPON_NAVYREVOLVER") then	
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.04)
				end
			end

			if weapon == GetHashKey("WEAPON_REVOLVER") then	
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.06)
				end
			end
			
			if weapon == GetHashKey("WEAPON_MICROSMG") then	
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.035)
				end
			end
			
			if weapon == GetHashKey("WEAPON_COMBATPDW") then			
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.045)
				end
			end
			
			if weapon == GetHashKey("WEAPON_SMG") then
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.045)
				end
			end
			
			if weapon == GetHashKey("WEAPON_MACHINEPISTOL") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.035)
				end
			end
			
			if weapon == GetHashKey("WEAPON_MINISMG") then
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.035)
				end
			end
			
			if weapon == GetHashKey("WEAPON_ASSAULTRIFLE") then			
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.055)
				end
			end
			
			if weapon == GetHashKey("WEAPON_CARBINERIFLE") then	
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.055)
				end
			end
			
			if weapon == GetHashKey("WEAPON_GUSENBERG") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.03)
				end
			end
			
			if weapon == GetHashKey("WEAPON_SPECIALCARBINE") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.06)
				end
			end
			
			if weapon == GetHashKey("WEAPON_COMPACTRIFLE") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
				end
			end
			
			if weapon == GetHashKey("WEAPON_PUMPSHOTGUN") then
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.07)
				end
			end
			
			if weapon == GetHashKey("WEAPON_PUMPSHOTGUN_MK2") then
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.085)
				end
			end
			
			if weapon == GetHashKey("WEAPON_SAWNOFFSHOTGUN") then
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.06)
				end
			end
			
		elseif recoil == 'pvp' then
			if weapon == GetHashKey("WEAPON_SNSPISTOL") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.02)
				end
			end
			
			if weapon == GetHashKey("WEAPON_SNSPISTOL_MK2") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)
				end
			end
			
			if weapon == GetHashKey("WEAPON_PISTOL") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)
				end
			end

			if weapon == GetHashKey("WEAPON_CERAMICPISTOL") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)
				end
			end

			if weapon == GetHashKey("WEAPON_APPISTOL") then
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.000)
				end
			end
			
			if weapon == GetHashKey("WEAPON_PISTOL_MK2") then
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.03)
				end
			end
			
			if weapon == GetHashKey("WEAPON_COMBATPISTOL") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)
				end
			end
			
			if weapon == GetHashKey("WEAPON_PISTOL50") then
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.037)
				end
			end
			
			if weapon == GetHashKey("WEAPON_HEAVYPISTOL") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
				end
			end
			
			if weapon == GetHashKey("WEAPON_VINTAGEPISTOL") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)
				end
			end
			
			if weapon == GetHashKey("WEAPON_NAVYREVOLVER") then	
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.06)
				end
			end

			if weapon == GetHashKey("WEAPON_REVOLVER") then	
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.06)
				end
			end
			
			if weapon == GetHashKey("WEAPON_MICROSMG") then	
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.028)
				end
			end
			
			if weapon == GetHashKey("WEAPON_COMBATPDW") then			
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.045)
				end
			end
			
			if weapon == GetHashKey("WEAPON_SMG") then
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.045)
				end
			end
			
			if weapon == GetHashKey("WEAPON_MACHINEPISTOL") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)
				end
			end
			
			if weapon == GetHashKey("WEAPON_MINISMG") then
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.035)
				end
			end
			
			if weapon == GetHashKey("WEAPON_ASSAULTRIFLE") then			
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.055)
				end
			end
			
			if weapon == GetHashKey("WEAPON_CARBINERIFLE") then	
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.055)
				end
			end
			
			if weapon == GetHashKey("WEAPON_GUSENBERG") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.03)
				end
			end
			
			if weapon == GetHashKey("WEAPON_SPECIALCARBINE") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.06)
				end
			end
			
			if weapon == GetHashKey("WEAPON_COMPACTRIFLE") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
				end
			end
			
			if weapon == GetHashKey("WEAPON_PUMPSHOTGUN") then
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.07)
				end
			end
			
			if weapon == GetHashKey("WEAPON_PUMPSHOTGUN_MK2") then
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.085)
				end
			end
			
			if weapon == GetHashKey("WEAPON_SAWNOFFSHOTGUN") then
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.06)
				end
			end
		elseif recoil == 'danishrp' then
			if weapon == GetHashKey("WEAPON_SNSPISTOL") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.02)
				end
			end
			
			if weapon == GetHashKey("WEAPON_SNSPISTOL_MK2") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)
				end
			end
			
			if weapon == GetHashKey("WEAPON_PISTOL") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)
				end
			end

			if weapon == GetHashKey("WEAPON_CERAMICPISTOL") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)
				end
			end
			
			if weapon == GetHashKey("WEAPON_PISTOL_MK2") then
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.03)
				end
			end
			
			if weapon == GetHashKey("WEAPON_APPISTOL") then
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.00000)
				end
			end
			
			if weapon == GetHashKey("WEAPON_COMBATPISTOL") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)
				end
			end
			
			if weapon == GetHashKey("WEAPON_PISTOL50") then
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
				end
			end
			
			if weapon == GetHashKey("WEAPON_HEAVYPISTOL") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
				end
			end
			
			if weapon == GetHashKey("WEAPON_VINTAGEPISTOL") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)
				end
			end
			
			if weapon == GetHashKey("WEAPON_MARKSMANPISTOL") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.03)
				end
			end
			
			if weapon == GetHashKey("WEAPON_NAVYREVOLVER") then	
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.06)
				end
			end

			if weapon == GetHashKey("WEAPON_REVOLVER") then	
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.06)
				end
			end
			
			if weapon == GetHashKey("WEAPON_REVOLVER_MK2") then	
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.055)
				end
			end
			
			if weapon == GetHashKey("WEAPON_DOUBLEACTION") then	
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)
				end
			end
			
			if weapon == GetHashKey("WEAPON_MICROSMG") then	
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.035)
				end
			end
			
			if weapon == GetHashKey("WEAPON_COMBATPDW") then			
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.045)
				end
			end
			
			if weapon == GetHashKey("WEAPON_SMG") then
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.045)
				end
			end
			
			if weapon == GetHashKey("WEAPON_SMG_MK2") then	
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.055)
				end
			end
			
			if weapon == GetHashKey("WEAPON_ASSAULTSMG") then	
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.050)
				end
			end
			
			if weapon == GetHashKey("WEAPON_MACHINEPISTOL") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.035)
				end
			end
			
			if weapon == GetHashKey("WEAPON_MINISMG") then
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.035)
				end
			end
			
			if weapon == GetHashKey("WEAPON_MG") then
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.07)
				end
			end
			
			if weapon == GetHashKey("WEAPON_COMBATMG") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
				end
			end
			
			if weapon == GetHashKey("WEAPON_COMBATMG_MK2") then			
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.085)
				end
			end
			
			if weapon == GetHashKey("WEAPON_ASSAULTRIFLE") then			
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.055)
				end
			end
			
			if weapon == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") then			
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.075)
				end
			end
			
			if weapon == GetHashKey("WEAPON_CARBINERIFLE") then	
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.055)
				end
			end
			
			if weapon == GetHashKey("WEAPON_ADVANCEDRIFLE") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.06)
				end
			end
			
			if weapon == GetHashKey("WEAPON_GUSENBERG") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.03)
				end
			end
			
			if weapon == GetHashKey("WEAPON_SPECIALCARBINE") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.06)
				end
			end
			
			if weapon == GetHashKey("WEAPON_BULLPUPRIFLE") then			
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
				end
			end
			
			if weapon == GetHashKey("WEAPON_COMPACTRIFLE") then		
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
				end
			end
			
			if weapon == GetHashKey("WEAPON_PUMPSHOTGUN") then
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.07)
				end
			end
			
			if weapon == GetHashKey("WEAPON_COMBATSHOTGUN") then
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.07)
				end
			end
			
			if weapon == GetHashKey("WEAPON_SAWNOFFSHOTGUN") then
				if IsPedShooting(ped) then
					ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.06)
				end
			end
		elseif recoil == 'syndicate' then
		end
        end

		if not hasWeapon then
			Citizen.Wait(500)
		end
	end
end)
