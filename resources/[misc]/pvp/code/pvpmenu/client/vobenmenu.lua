
lib.registerContext({
    id = 'vobenmenu',
    title = 'FiveX - PvP Menu',
    menu  = 'pvpmenu',
    options = {
        {
            title = 'Håndpistoler',
            arrow = false,
            icon = 'gun',
            menu = 'pistollist',
        },
        {
            title = 'Automatvåben',
            arrow = false,
            icon = 'person-rifle',
            menu = 'smglist',
        },
        {
            title = 'Shotguns',
            arrow = false,
            icon = 'person-rifle',
            menu = 'shotguns',
        },
        {
            title = 'Andet',
            arrow = false,
            icon = 'bars',
            menu = 'attachments',
        },
        {
            title = 'Clear Inventory',
            arrow = false,
            icon = 'trash',
            onSelect = function()
                TriggerServerEvent('clearinv')
            end,
        },
    },
})

AddEventHandler('pvpmenu:select:pistol', function(args)
	TriggerServerEvent("nigger:SpawnShit", args.item, args.count)
    lib.showContext('pistollist')
end)

AddEventHandler('pvpmenu:select:smglist', function(args)
	TriggerServerEvent("nigger:SpawnShit", args.item, args.count)
    lib.showContext('smglist')
end)

AddEventHandler('pvpmenu:select:rifle', function(args)
	TriggerServerEvent("nigger:SpawnShit", args.item, args.count)
    lib.showContext('smglist')
end)

AddEventHandler('pvpmenu:select:shotguns', function(args)
	TriggerServerEvent("nigger:SpawnShit", args.item, args.count)
    lib.showContext('shotguns')
end)

AddEventHandler('pvpmenu:select:attachments', function(args)
	TriggerServerEvent("nigger:SpawnShit", args.item, args.count)
    lib.showContext('attachments')
end)

lib.registerContext({
    id = 'shotguns',
    title = 'FiveX - PvP Menu',
    options = {
        {
            title = 'Combat Shotgun',
            arrow = false,
            icon = 'person-rifle',
            event = 'pvpmenu:select:shotguns',
            args = {item = "weapon_combatshotgun", count = "1"}
        },
        {
            title = 'Pump Shotgun',
            arrow = false,
            icon = 'person-rifle',
            event = 'pvpmenu:select:shotguns',
            args = {item = "weapon_pumpshotgun", count = "1"}
        },
        {
            title = 'Sawed-Off Shotgun',
            arrow = false,
            icon = 'person-rifle',
            event = 'pvpmenu:select:shotguns',
            args = {item = "weapon_sawnoffshotgun", count = "1"}
        },
        {
            title = 'Tilbage',
            arrow = false,
            icon  = 'backward',
            menu  = 'vobenmenu'
        },
    },
})


lib.registerContext({
    id = 'pistollist',
    title = 'FiveX - PvP Menu',
    options = {
        {
            title = 'Pistol 50.',
            arrow = false,
            icon = 'gun',
            event = 'pvpmenu:select:pistol',
            args = {item = "weapon_pistol50", count = "1"},
        },
        {
            title = 'Pistol.',
            arrow = false,
            icon = 'gun',
            event = 'pvpmenu:select:pistol',
            args = {item = "weapon_pistol", count = "1"}
        },
        {
            title = 'Combat Pistol.',
            arrow = false,
            icon = 'gun',
            event = 'pvpmenu:select:pistol',
            args = {item = "weapon_combatpistol", count = "1"}
        },
        {
            title = 'Heavy Pistol.',
            arrow = false,
            icon = 'gun',
            event = 'pvpmenu:select:pistol',
            args = {item = "weapon_heavypistol", count = "1"}
        },
        {
            title = 'Ceramic Pistol.',
            arrow = false,
            icon = 'gun',
            event = 'pvpmenu:select:pistol',
            args = {item = "weapon_ceramicpistol", count = "1"}
        },
        {
            title = 'Revolver.',
            arrow = false,
            icon = 'gun',
            event = 'pvpmenu:select:pistol',
            args = {item = "weapon_revolver", count = "1"}
        },
        {
            title = 'Navy Revolver.',
            arrow = false,
            icon = 'gun',
            event = 'pvpmenu:select:pistol',
            args = {item = "weapon_navyrevolver", count = "1"}
        },
        {
            title = 'AP Pistol.',
            arrow = false,
            icon = 'gun',
            event = 'pvpmenu:select:pistol',
            args = {item = "weapon_appistol", count = "1"}
        },
        {
            title = 'Vintage Pistol.',
            arrow = false,
            icon = 'gun',
            event = 'pvpmenu:select:pistol',
            args = {item = "weapon_vintagepistol", count = "1"}
        },
        {
            title = 'Tilbage',
            arrow = false,
            icon  = 'backward',
            menu  = 'vobenmenu'
        },
    },
})


lib.registerContext({
    id = 'smglist',
    title = 'FiveX - PvP Menu',
    options = {
        {
            title = 'Scorpion',
            arrow = false,
            icon = 'person-rifle',
            event = 'pvpmenu:select:smglist',
            args = {item = "weapon_minismg", count = "1"}
        },
        {
            title = 'TEC-9',
            arrow = false,
            icon = 'person-rifle',
            event = 'pvpmenu:select:smglist',
            args = {item = "weapon_machinepistol", count = "1"}
        },
        {
            title = 'Mico-SMG',
            arrow = false,
            icon = 'person-rifle',
            event = 'pvpmenu:select:smglist',
            args = {item = "weapon_microsmg", count = "1"}
        },
        {
            title = 'AK-47',
            arrow = false,
            icon = 'person-rifle',
            event = 'pvpmenu:select:rifle',
            args = {item = "weapon_assaultrifle", count = "1"}
        },
        {
            title = 'Mini AK-47',
            arrow = false,
            icon = 'person-rifle',
            event = 'pvpmenu:select:rifle',
            args = {item = "weapon_compactrifle", count = "1"}
        },
        {
            title = 'Gusenberg',
            arrow = false,
            icon = 'person-rifle',
            event = 'pvpmenu:select:rifle',
            args = {item = "weapon_gusenberg", count = "1"}
        },
        {
            title = 'Cabine Rifle',
            arrow = false,
            icon = 'person-rifle',
            event = 'pvpmenu:select:shotguns',
            args = {item = "weapon_carbinerifle", count = "1"}
        },
        {
            title = 'Tilbage',
            arrow = false,
            icon  = 'backward',
            menu  = 'vobenmenu'
        },
    },
})

lib.registerContext({
    id = 'attachments',
    title = 'FiveX - PvP Menu',
    options = {
        {
            title = 'Skud 1000x',
            arrow = false,
            icon = 'person-rifle',
            event = 'pvpmenu:select:attachments',
            args = {item = "ammo", count = "1000"}
        },
        {
            title = 'Skudsikkervest 500x',
            arrow = false,
            icon = 'person-rifle',
            event = 'pvpmenu:select:attachments',
            args = {item = "vest", count = "500"}
        },
        {
            title = 'Udvidet Magasin 10x',
            arrow = false,
            icon = 'person-rifle',
            event = 'pvpmenu:select:attachments',
            args = {item = "clip", count = "10"}
        },
        {
            title = 'Radio',
            arrow = false,
            icon = 'person-rifle',
            event = 'pvpmenu:select:attachments',
            args = {item = "radio", count = "1"}
        },
        {
            title = 'Lyddæmper 10x',
            arrow = false,
            icon = 'person-rifle',
            event = 'pvpmenu:select:attachments',
            args = {item = "silencer", count = "10"}
        },
        {
            title = 'Scope 10x',
            arrow = false,
            icon = 'person-rifle',
            event = 'pvpmenu:select:attachments',
            args = {item = "scope", count = "10"}
        },
        {
            title = 'Flashlight 10x',
            arrow = false,
            icon = 'person-rifle',
            event = 'pvpmenu:select:attachments',
            args = {item = "flashlight", count = "10"}
        },
        {
            title = 'Få alt ovenstående',
            arrow = false,
            icon = 'person-rifle',
            onSelect = function()
                TriggerServerEvent("nigger:SpawnAllshjit")
                lib.showContext('attachments')
            end,
        },
        {
            title = 'Tilbage',
            arrow = false,
            icon  = 'backward',
            menu  = 'vobenmenu'
        },
    },
})
