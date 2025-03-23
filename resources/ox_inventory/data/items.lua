return {
	['testburger'] = {
		label = 'Test Burger',
		weight = 220,
		degrade = 60,
		client = {
			image = 'burger_chicken.png',
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			export = 'ox_inventory_examples.testburger'
		},
		server = {
			export = 'ox_inventory_examples.testburger',
			test = 'what an amazingly delicious burger, amirite?'
		},
		buttons = {
			{
				label = 'Lick it',
				action = function(slot)
					print('You licked the burger')
				end
			},
			{
				label = 'Squeeze it',
				action = function(slot)
					print('You squeezed the burger :(')
				end
			},
			{
				label = 'What do you call a vegan burger?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('A misteak.')
				end
			},
			{
				label = 'What do frogs like to eat with their hamburgers?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('French flies.')
				end
			},
			{
				label = 'Why were the burger and fries running?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('Because they\'re fast food.')
				end
			}
		},
		consume = 0.3
	},

	['bandage'] = {
		label = 'Bandage',
		weight = 115,
		client = {
			anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
			prop = { model = `prop_rolled_sock_02`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
			disable = { move = true, car = true, combat = true },
			usetime = 2500,
		}
	},

	['black_money'] = {
		label = 'Dirty Money',
	},

	["weapon_pistol_royale"] = {
		["label"] = "Beretta M9",
		["weight"] = 1000,
	},
	
	["weapon_combatpistol_royale"] = {
		["label"] = "Combat Pistol",
		["weight"] = 1000,
	},
	
	["weapon_heavypistol_royale"] = {
		["label"] = "Heavy Pistol",
		["weight"] = 1000,
	},
	
	["weapon_appistol_royale"] = {
		["label"] = "AP Pistol",
		["weight"] = 1000,
	},
	
	["weapon_snspistol_royale"] = {
		["label"] = "SNS Pistol",
		["weight"] = 1000,
	},
	
	["weapon_pistol50_royale"] = {
		["label"] = "Desert Eagle",
		["weight"] = 1000,
	},
	
	["weapon_vintagepistol_royale"] = {
		["label"] = "Vintage Pistol",
		["weight"] = 1000,
	},
	
	["weapon_carbinerifle_royale"] = {
		["label"] = "Carbine Rifle",
		["weight"] = 1000,
	},
	
	["weapon_compactrifle_royale"] = {
		["label"] = "Draco",
		["weight"] = 1000,
	},
	
	["weapon_carbinerifle_mk2_royale"] = {
		["label"] = "Carbine Rifle MK2",
		["weight"] = 1000,
	},
	
	["weapon_assaultrifle_royale"] = {
		["label"] = "AK-47",
		["weight"] = 1000,
	},
	
	["weapon_assaultrifle_mk2_royale"] = {
		["label"] = "AK-47 MK2",
		["weight"] = 1000,
	},
	
	["weapon_specialcarbine_royale"] = {
		["label"] = "Scar-H",
		["weight"] = 1000,
	},
	
	["weapon_specialcarbine_mk2_royale"] = {
		["label"] = "Specialcarbine MK2",
		["weight"] = 1000,
	},
	
	["weapon_bullpuprifle_royale"] = {
		["label"] = "Bullpup Rifle",
		["weight"] = 1000,
	},
	
	["weapon_bullpuprifle_mk2_royale"] = {
		["label"] = "Puprifle MK2",
		["weight"] = 1000,
	},
	
	["weapon_advancedrifle_royale"] = {
		["label"] = "Advanced Rifle",
		["weight"] = 1000,
	},
	
	["weapon_militaryrifle_royale"] = {
		["label"] = "Militaryrifle",
		["weight"] = 1000,
	},
	
	["weapon_microsmg_royale"] = {
		["label"] = "Micro SMG",
		["weight"] = 1000,
	},
	
	["weapon_assaultsmg_royale"] = {
		["label"] = "Assault SMG",
		["weight"] = 1000,
	},
	
	["weapon_smg_royale"] = {
		["label"] = "SMG",
		["weight"] = 1000,
	},
	
	["weapon_combatpdw_royale"] = {
		["label"] = "Combat PDW",
		["weight"] = 1000,
	},
	
	["weapon_smg_mk2_royale"] = {
		["label"] = "PD MP5 2",
		["weight"] = 1000,
	},
	
	["weapon_gusenberg_royale"] = {
		["label"] = "Thompson SMG",
		["weight"] = 1000,
	},
	
	["weapon_mg_royale"] = {
		["label"] = "MG",
		["weight"] = 1000,
	},
	
	["weapon_combatmg_royale"] = {
		["label"] = "Combat MG",
		["weight"] = 1000,
	},
	
	["weapon_sniperrifle_royale"] = {
		["label"] = "Sniper Rifle",
		["weight"] = 1000,
	},
	
	["weapon_marksmanrifle_royale"] = {
		["label"] = "Marksman Rifle",
		["weight"] = 1000,
	},
	
	["weapon_heavysniper_royale"] = {
		["label"] = "Heavy Sniper",
		["weight"] = 1000,
	},
	
	["weapon_sawnoffshotgun_royale"] = {
		["label"] = "Sawn-off Shotgun",
		["weight"] = 1000,
	},
	
	["weapon_assaultshotgun_royale"] = {
		["label"] = "Assault Shotgun",
		["weight"] = 1000,
	},
	
	["weapon_bullpupshotgun_royale"] = {
		["label"] = "Bullpup Shotgun",
		["weight"] = 1000,
	},
	
	["weapon_pumpshotgun_royale"] = {
		["label"] = "Pump Shotgun",
		["weight"] = 1000,
	},
	
	["weapon_musket_royale"] = {
		["label"] = "Musket",
		["weight"] = 1000,
	},
	
	["weapon_heavyshotgun_royale"] = {
		["label"] = "Heavy Shotgun",
		["weight"] = 1000,
	},
	
	["weapon_rpg_royale"] = {
		["label"] = "RPG",
		["weight"] = 1000,
	},
	
	["weapon_molotov_royale"] = {
		["label"] = "Molotov",
		["weight"] = 1000,
	},
	
	["weapon_stickybomb_royale"] = {
		["label"] = "C4",
		["weight"] = 1000,
	},
	
	["weapon_grenadelauncher_royale"] = {
		["label"] = "Grenade Launcher",
		["weight"] = 1000,
	},
	
	["weapon_pipebomb_royale"] = {
		["label"] = "Pipe Bomb",
		["weight"] = 1000,
	},
	
	["rifle_ammo_royale"] = {
		["label"] = "Rifle ammo",
		["weight"] = 1000,
	},
	
	["smg_ammo_royale"] = {
		["label"] = "SMG ammo",
		["weight"] = 1000,
	},
	
	["pistol_ammo_royale"] = {
		["label"] = "Pistol ammo",
		["weight"] = 1000,
	},
	
	["shotgun_ammo_royale"] = {
		["label"] = "Shotgun ammo",
		["weight"] = 1000,
	},
	
	["mg_ammo_royale"] = {
		["label"] = "MG ammo",
		["weight"] = 1000,
	},
	
	["snp_ammo_royale"] = {
		["label"] = "Sniper ammo",
		["weight"] = 1000,
	},
	
	["armorroyale_royale"] = {
		["label"] = "Armor",
		["weight"] = 1000,
	},
	
	["healthroyale_royale"] = {
		["label"] = "Health Kit",
		["weight"] = 1000,
	},
	
	["weapon_machete_royale"] = {
		["label"] = "Machete",
		["weight"] = 1000,
	},
	
	["weapon_bat_royale"] = {
		["label"] = "Bat",
		["weight"] = 1000,
	},
	
	["weapon_bottle_royale"] = {
		["label"] = "Broken Bottle",
		["weight"] = 1000,
	},
	
	["weapon_crowbar_royale"] = {
		["label"] = "Crowbar",
		["weight"] = 1000,
	},
	
	["weapon_dagger_royale"] = {
		["label"] = "Dagger",
		["weight"] = 1000,
	},
	
	["weapon_hammer_royale"] = {
		["label"] = "Hammer",
		["weight"] = 1000,
	},
	
	["uav_royale"] = {
		["label"] = "UAV",
		["weight"] = 1000,
	},
	
	["armor1_royale"] = {
		["label"] = "Light armor",
		["weight"] = 1000,
	},
	
	["armor2_royale"] = {
		["label"] = "Medium armor",
		["weight"] = 1000,
	},
	
	["armor3_royale"] = {
		["label"] = "Heavy armor",
		["weight"] = 1000,
	},
	
	["bandage_royale"] = {
		["label"] = "Bandage",
		["weight"] = 1000,
	},
	
	["jump_royale"] = {
		["label"] = "Super Jump",
		["weight"] = 1000,
	},
	
	["juice_royale"] = {
		["label"] = "Juice",
		["weight"] = 1000,
	},
	
	["pug-vr"] = {
		["label"] = "Vr Headset",
		["weight"] = 2000,
	},

	['burger'] = {
		label = 'Burger',
		weight = 220,
		client = {
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			notification = 'You ate a delicious burger'
		},
	},

	['sprunk'] = {
		label = 'Sprunk',
		weight = 350,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_can_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your thirst with a sprunk'
		}
	},

	['metaldetector'] = {
		label = 'Metal Detector',
		weight = 100,
		stack = false,
		close = true,
		usetime = 2500,
		description = 'A metal detector to find hidden treasures',
		client = {
			image = 'card_id.png',
		}
	},

	['parachute'] = {
		label = 'Parachute',
		weight = 8000,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 1500
		}
	},

	['garbage'] = {
		label = 'Garbage',
	},

	['paperbag'] = {
		label = 'Paper Bag',
		weight = 1,
		stack = false,
		close = false,
		consume = 0
	},

	['identification'] = {
		label = 'Identification',
		client = {
			image = 'card_id.png'
		}
	},

	['panties'] = {
		label = 'Knickers',
		weight = 10,
		consume = 0,
		client = {
			status = { thirst = -100000, stress = -25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_panties_02`, pos = vec3(0.03, 0.0, 0.02), rot = vec3(0.0, -13.5, -1.5) },
			usetime = 2500,
		}
	},

	['lockpick'] = {
		label = 'Lockpick',
		weight = 160,
	},

	['phone'] = {
		label = 'Phone',
		weight = 190,
		stack = false,
		consume = 0,
		client = {
			add = function(total)
				if total > 0 then
					pcall(function() return exports.npwd:setPhoneDisabled(false) end)
				end
			end,

			remove = function(total)
				if total < 1 then
					pcall(function() return exports.npwd:setPhoneDisabled(true) end)
				end
			end
		}
	},

	['money'] = {
		label = 'Money',
	},

	['mustard'] = {
		label = 'Mustard',
		weight = 500,
		client = {
			status = { hunger = 25000, thirst = 25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_food_mustard`, pos = vec3(0.01, 0.0, -0.07), rot = vec3(1.0, 1.0, -1.5) },
			usetime = 2500,
			notification = 'You.. drank mustard'
		}
	},

	['water'] = {
		label = 'Water',
		weight = 500,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
			usetime = 2500,
			cancel = true,
			notification = 'You drank some refreshing water'
		}
	},

	['radio'] = {
		label = 'Radio',
		weight = 300,
		stack = false,
		close = true,
		allowArmed = true
	},

	['vest'] = {
		label = 'Bulletproof Vest',
		weight = 5,
		stack = true,
		client = {export = 'pvp.useVest'}
		-- client = {
		-- 	anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
		-- 	usetime = 1200,
			
		-- },
	},

	['clothing'] = {
		label = 'Clothing',
		consume = 0,
	},

	['mastercard'] = {
		label = 'Fleeca Card',
		stack = false,
		weight = 10,
		client = {
			image = 'card_bank.png'
		}
	},

	['scrapmetal'] = {
		label = 'Scrap Metal',
		weight = 80,
	},

	['alive_chicken'] = {
		label = 'Living chicken',
		weight = 1,
		stack = true,
		close = true,
	},

	['blowpipe'] = {
		label = 'Blowtorch',
		weight = 2,
		stack = true,
		close = true,
	},

	['bread'] = {
		label = 'Bread',
		weight = 1,
		stack = true,
		close = true,
	},

	['cannabis'] = {
		label = 'Cannabis',
		weight = 3,
		stack = true,
		close = true,
	},

	['carokit'] = {
		label = 'Body Kit',
		weight = 3,
		stack = true,
		close = true,
	},

	['carotool'] = {
		label = 'Tools',
		weight = 2,
		stack = true,
		close = true,
	},

	['clothe'] = {
		label = 'Cloth',
		weight = 1,
		stack = true,
		close = true,
	},

	['copper'] = {
		label = 'Copper',
		weight = 1,
		stack = true,
		close = true,
	},

	['cutted_wood'] = {
		label = 'Cut wood',
		weight = 1,
		stack = true,
		close = true,
	},

	['diamond'] = {
		label = 'Diamond',
		weight = 1,
		stack = true,
		close = true,
	},

	['essence'] = {
		label = 'Gas',
		weight = 1,
		stack = true,
		close = true,
	},

	['fabric'] = {
		label = 'Fabric',
		weight = 1,
		stack = true,
		close = true,
	},

	['fish'] = {
		label = 'Fish',
		weight = 1,
		stack = true,
		close = true,
	},

	['fixkit'] = {
		label = 'Repair Kit',
		weight = 3,
		stack = true,
		close = true,
	},

	['fixtool'] = {
		label = 'Repair Tools',
		weight = 2,
		stack = true,
		close = true,
	},

	['gazbottle'] = {
		label = 'Gas Bottle',
		weight = 2,
		stack = true,
		close = true,
	},

	['gold'] = {
		label = 'Gold',
		weight = 1,
		stack = true,
		close = true,
	},

	['iron'] = {
		label = 'Iron',
		weight = 1,
		stack = true,
		close = true,
	},

	['marijuana'] = {
		label = 'Marijuana',
		weight = 2,
		stack = true,
		close = true,
	},

	['medikit'] = {
		label = 'Medikit',
		weight = 2,
		stack = true,
		close = true,
	},

	['packaged_chicken'] = {
		label = 'Chicken fillet',
		weight = 1,
		stack = true,
		close = true,
	},

	['packaged_plank'] = {
		label = 'Packaged wood',
		weight = 1,
		stack = true,
		close = true,
	},

	['petrol'] = {
		label = 'Oil',
		weight = 1,
		stack = true,
		close = true,
	},

	['petrol_raffin'] = {
		label = 'Processed oil',
		weight = 1,
		stack = true,
		close = true,
	},

	['slaughtered_chicken'] = {
		label = 'Slaughtered chicken',
		weight = 1,
		stack = true,
		close = true,
	},

	['stone'] = {
		label = 'Stone',
		weight = 1,
		stack = true,
		close = true,
	},

	['washed_stone'] = {
		label = 'Washed stone',
		weight = 1,
		stack = true,
		close = true,
	},

	['wood'] = {
		label = 'Wood',
		weight = 1,
		stack = true,
		close = true,
	},

	['wool'] = {
		label = 'Wool',
		weight = 1,
		stack = true,
		close = true,
	},
}