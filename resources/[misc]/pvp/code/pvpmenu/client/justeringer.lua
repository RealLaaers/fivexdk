RegisterNetEvent("justeringer")
AddEventHandler("justeringer", function()
    lib.registerContext({
        id = 'justeringer',
        title = 'FiveX - Indstillinger',
        menu  = 'pvpmenu',
        options = {
            {
                title = 'Movement',
                arrow = false,
                onSelect = function()
                    ExecuteCommand("movement")
                end,
            },
            {
                title = 'Hud',
                arrow = false,
                onSelect = function()
                    ExecuteCommand("hud")
                end,
            },
            {
                title = 'Recoil',
                arrow = false,
                onSelect = function()
                    ExecuteCommand('recoil')
                end,
            },
            {
                title = 'Tid',
                arrow = false,
                event = 'clockmenu',
            },
            {
                title = 'Vejr',
                arrow = false,
                event = 'wheatermenu',
            },
            {
                title = 'FPS',
                arrow = false,
                onSelect = function()
                    ExecuteCommand('fps')
                end,
            },
            {
                title = 'Crew Tags',
                arrow = false,
                onSelect = function()
                    TriggerEvent('crewtagsmanagement')
                end,
            },
            -- {
            --     title = 'Tilbage',
            --     arrow = false,
            --     icon  = 'backward',
            --     menu  = 'pvpmenu'
            -- },
        },
    })

    lib.showContext('justeringer')
end)

RegisterCommand('settings', function()
    TriggerEvent('justeringer')
end)

RegisterKeyMapping('settings', 'Settings Menu', 'keyboard', 'm')