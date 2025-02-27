# Pug Royale.
For any questions please contact me here: here https://discord.gg/jYZuWYjfvq.
For any of my other scripts you can purchase here: https://pug-webstore.tebex.io/category/custom-scripts

# Installation
Download the island from here https://github.com/FranczeK/cayoperico-island. Credits to #FranczeK
Read through the config.lua thoroughly and adjust everything to match your server. (VERY IMPORTANT)
Make sure you have the dependencies installed. (Polyzone, qb-target OR ox_target, qb-inventory OR ox_inventory, qb-menu OR ps-ui OR ox_lib, qb-input OR ps-ui OR ox_lib)
Place the sound files provided in ["pug-battleroyale/soundfiles"] into InteractSound\client\html\sounds
for the vr headset download here and add its hat clothing number to Config.VrHeadSetPropMale and Config.VrHeadSetPropFemale https://www.gta5-mods.com/player/oculus-rift-cv1-eup

--
# OX_INVENTORY USERS: If you are using ox_inventory you will NEED to go ox_inventory/client.lua and around line 1341 you will need to find what looks like this and replace it with this
if weaponType ~= 0 and weaponType ~= `GROUP_UNARMED` then
    if not exports["pug-battleroyale"]:IsInBattleRoyale() then
        Weapon.Disarm(currentWeapon, true)
    end
end
--


--
# in youR dispatch script, search up shots fired or discharge and add this if statement where you can to remove shots fired called wile in paintball. add "if not exports["pug-battleroyale"]:IsInBattleRoyale() then" to your shots fired call.
# if you are ps dispatch fine the "CEventShockingGunshotFired" handler in ps-dispatch/client/cl_eventhandlers and replace it with here here:
AddEventHandler('CEventShockingGunshotFired', function(witnesses, ped, coords)
   	if not exports["pug-battleroyale"]:IsInBattleRoyale() then -- (THIS LINE HERE WAS ADDED)
        local coords = vector3(coords[1][1], coords[1][2], coords[1][3])
        -- Use the timer to prevent the event from being triggered multiple times.
        if Config.Timer['Shooting'] ~= 0 then return end
        -- The ped that shot the gun must be the player.
        if PlayerPedId() ~= ped then return end
        -- This event can be triggered multiple times for a single gunshot, so we only want to run the code once.
        -- If there are no witnesses, then the player is the shooter.
        -- Else if there are witnesses, then the player will also be in that table.
        -- If one of these conditions are met, then we can continue.
        if witnesses and not isPedAWitness(witnesses, ped) then return end
        -- If the player is a whitelisted job, then we don't want to trigger the event.
        -- However, if the player is not whitelisted or Debug mode is true, then we want to trigger the event.
        if Config.AuthorizedJobs.LEO.Check() and not Config.Debug then return end
        -- If the weapon is silenced then we don't want to trigger the event.
        if IsPedCurrentWeaponSilenced(ped) then return end 
        -- If the weapon is blacklisted then we set the timer to the fail time and return.
        if BlacklistedWeapon(ped) then Config.Timer['Shooting'] = Config.Shooting.Fail return end
        -- Check if the Player is in a Hunting Zone and Give that Alert Instead
        if inHuntingZone then exports['ps-dispatch']:Hunting(); Config.Timer['Shooting'] = Config.Shooting.Success return end
        local vehicle = GetVehiclePedIsUsing(ped, true)
        if vehicle ~= 0 then
            if vehicleWhitelist[GetVehicleClass(vehicle)] then
                vehicle = vehicleData(vehicle)
                exports['ps-dispatch']:VehicleShooting(vehicle, ped, coords)
                Config.Timer['Shooting'] = Config.Shooting.Success
            end
        else
            exports['ps-dispatch']:Shooting(ped, coords)
            Config.Timer['Shooting'] = Config.Shooting.Success
        end
   	end
end)
--

--
# Put this in ox_inventory/data/items.lua
-- ROYALE ITEMS
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


# Battle Royale.
For any questions please contact me here: here https://discord.gg/jYZuWYjfvq.
For any of my other scripts you can purchase here: https://pug-webstore.tebex.io/category/custom-scripts

This script is using escrow encryption on only the main client.lua everything else is entirely open including the client/open.lua

PREVIEW HERE: https://youtu.be/aOvNlbYnNrc

CONFIG HERE: https://i.imgur.com/PEj17IN.png
README HERE: https://i.imgur.com/1EyEsNl.png

This completely configurable script consists of:

● Extremely extensive Config you can adjust!
● Players are placed in the games own dimension so they don't interrupt other players who are not playing the Royale in the server.
● 800+ different loot locations around the island. Configurable.
● VR headset option or ped option with a target to join the royal.
● VR headset creates a clone ped at your last position when entering the Royale and deletes when you finish the Royale.
● Loot random spawns as just ammo piles, gun and ammo piles, or just weapon/item piles. Configurable.
● A plane that brings the players in over the island, allowing them to drop where they like with multiple different random entering and exiting paths Configurable.
● UAV Killstreak reward after getting 3 kills.
● A custom ui that tracks players kills, position in the royal with updated player left as well, custom icons, icon that displays when the zone is shrinking or on cooldown.
● The custom ui fits perfectly all screen resolutions and also displays when a player has to reload or pickup loot.
● Random zones that shrink as the game proceeds and when you are outside of them a storm begins slowly killing the player. Configurable.
● A loot system that shoots all the players weapons, ammo, and items out of the player when they die for other players to pickup and loot.
● Loot removal on all players in the Royale being artificially synced when players loot an item from the ground.
● A custom gulag that players get sent to when they die on their first death. If the player wins the 1v1 gulag they get sent back into the match and the loser gets removed.
● A mechanic that makes the player only capable of having two primary weapons. Melee weapons, throwables, and other not primary type weapons do not apply and are configurable to decide on what is considered a primary.
● 6 helicopter spawn locations on the map, but only 3 helicopters spawn at a time. The script uses 3 random cards from 2 different tables to make it seem more random. Configurable.
● 62 vehicle spawn options around the island, but only 31 vehicles spawn at a time. The script uses 31 random cards from 2 different tables to make it seem more random Configurable.
● A mechanic that pickups up ammo and all none primary weapons when walking over them automatically.
● Runs at 0.0 ms resmon when not in a game and 0.03 when in a game.
● This script is completely open source other than the main client.lua.
● 0 known scuff. Was tested over and over with 10+ people to plug every issue that was found.
● Max player count is whatever your server player count is. Configurable.
● Players can choose the zone shrinking down time through the game menu, 6 options to choose from for faster or slower pace games.
● Mechanic to re-pull parachute multiple times after ejecting from the plane.
● A wager amount set to minimum $500 and maximum $25,000. Rearward at the end of the game gives 1st, 2nd, and 3rd a winning cash prized based off the amount of players X the wager X set percentage. Configurable.
● 50 weapon options and 7 different ammo options in the loot table. Configurable.
● 11 different car model options that spawn around the island. You can add as many car options as you like. Configurable.
● Custom sounds that are triggered in the Royale. (Sounds files will provide).
● Unlimited sprint. Configurable.
● The option to spectate players. Configurable.
● 7 unique Royale items that give special advantages
- Vr Headset
- UAV tablet item you can use to display a red dot on on your map that fades in and out for 30 seconds displaying the location of your enemy
- bullet proof heavy armor physical clothing vest that has 100 health and breaks after it receives enough damage
- bullet proof medium armor physical clothing vest that has 50 health and breaks after it receives enough damage
- bullet proof light armor physical clothing vest that has 20 health and breaks after it receives enough damage
- Slurp juice that regenerates health, armor, and gives a short speed boost to the player
- A Super jump item that gives the player a short 30 second super jump ability.

Requirements consist of:
QBCore
qb-menu OR ox_lib (ps-ui or any qb-menu resource name changed will work)
qb-target OR ox_target (any qb-inventory resource name changed will work)
Polyzone