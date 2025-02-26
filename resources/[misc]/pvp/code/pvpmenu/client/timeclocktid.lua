freezetime = false
freezetimeText = "false"

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(100)

        if not freezetime then
            freezetimeText = "Tiden er ikke frosset"
        else
            freezetimeText = "Tiden er frosset"
        end

        if freezetime then
            local timer = GetClockHours()
            local min = GetClockMinutes()
    
            NetworkOverrideClockTime(timer, min, 00)
        end
    end
end)

RegisterNetEvent("clockmenu")
AddEventHandler("clockmenu", function()
    lib.registerContext({
        id = 'clockmenu',
        title = 'FiveX - Tidmenu',
        menu  = 'justeringer',
        options = {
            {
                title = 'Frøs tid!',
                description = "".. freezetimeText .."",
                icon = 'circle-info',
                onSelect = function()
                    if freezetime then
                        freezetime = false
                    else 
                        freezetime = true
                    end
                    print(freezetime)
                end,
            },
            {
                title = '01:00',
                arrow = false,
                onSelect = function()
                    NetworkOverrideClockTime(01, 00, 00)
                    lib.showContext('clockmenu')
                end,
            },
            {
                title = '02:00',
                arrow = false,
                onSelect = function()
                    NetworkOverrideClockTime(02, 00, 00)
                    lib.showContext('clockmenu')
                end,
            },
            {
                title = '03:00',
                arrow = false,
                onSelect = function()
                    NetworkOverrideClockTime(03, 00, 00)
                    lib.showContext('clockmenu')
                end,
            },
            {
                title = '04:00',
                arrow = false,
                onSelect = function()
                    NetworkOverrideClockTime(04, 00, 00)
                    lib.showContext('clockmenu')
                end,
            },
            {
                title = '05:00',
                arrow = false,
                onSelect = function()
                    NetworkOverrideClockTime(05, 00, 00)
                    lib.showContext('clockmenu')
                end,
            },
            {
                title = '06:00',
                arrow = false,
                onSelect = function()
                    NetworkOverrideClockTime(06, 00, 00)
                    lib.showContext('clockmenu')
                end,
            },            {
                title = '07:00',
                arrow = false,
                onSelect = function()
                    NetworkOverrideClockTime(07, 00, 00)
                    lib.showContext('clockmenu')
                end,
            },
            {
                title = '08:00',
                arrow = false,
                onSelect = function()
                    NetworkOverrideClockTime(08, 00, 00)
                    lib.showContext('clockmenu')
                end,
            },
            {
                title = '09:00',
                arrow = false,
                onSelect = function()
                    NetworkOverrideClockTime(09, 00, 00)
                    lib.showContext('clockmenu')
                end,
            },
            {
                title = '10:00',
                arrow = false,
                onSelect = function()
                    NetworkOverrideClockTime(10, 00, 00)
                    lib.showContext('clockmenu')
                end,
            },
            {
                title = '11:00',
                arrow = false,
                onSelect = function()
                    NetworkOverrideClockTime(11, 00, 00)
                    lib.showContext('clockmenu')
                end,
            },
            {
                title = '12:00',
                arrow = false,
                onSelect = function()
                    NetworkOverrideClockTime(12, 00, 00)
                    lib.showContext('clockmenu')
                end,
            },
            {
                title = '13:00',
                arrow = false,
                onSelect = function()
                    NetworkOverrideClockTime(13, 00, 00)
                    lib.showContext('clockmenu')
                end,
            },
            {
                title = '14:00',
                arrow = false,
                onSelect = function()
                    NetworkOverrideClockTime(14, 00, 00)
                    lib.showContext('clockmenu')
                end,
            },
            {
                title = '15:00',
                arrow = false,
                onSelect = function()
                    NetworkOverrideClockTime(15, 00, 00)
                    lib.showContext('clockmenu')
                end,
            },
            {
                title = '16:00',
                arrow = false,
                onSelect = function()
                    NetworkOverrideClockTime(16, 00, 00)
                    lib.showContext('clockmenu')
                end,
            },
            {
                title = '17:00',
                arrow = false,
                onSelect = function()
                    NetworkOverrideClockTime(17, 00, 00)
                    lib.showContext('clockmenu')
                end,
            },
            {
                title = '18:00',
                arrow = false,
                onSelect = function()
                    NetworkOverrideClockTime(18, 00, 00)
                    lib.showContext('clockmenu')
                end,
            },
            {
                title = '19:00',
                arrow = false,
                onSelect = function()
                    NetworkOverrideClockTime(19, 00, 00)
                    lib.showContext('clockmenu')
                end,
            },
            {
                title = '20:00',
                arrow = false,
                onSelect = function()
                    NetworkOverrideClockTime(20, 00, 00)
                    lib.showContext('clockmenu')
                end,
            },
            {
                title = '21:00',
                arrow = false,
                onSelect = function()
                    NetworkOverrideClockTime(21, 00, 00)
                    lib.showContext('clockmenu')
                end,
            },
            {
                title = '22:00',
                arrow = false,
                onSelect = function()
                    NetworkOverrideClockTime(22, 00, 00)
                    lib.showContext('clockmenu')
                end,
            },
            {
                title = '23:00',
                arrow = false,
                onSelect = function()
                    NetworkOverrideClockTime(23, 00, 00)
                    lib.showContext('clockmenu')
                end,
            },
            {
                title = '24:00',
                arrow = false,
                onSelect = function()
                    NetworkOverrideClockTime(23, 59, 59)
                    lib.showContext('clockmenu')
                end,
            },
        },
    })

    lib.showContext('clockmenu')
end)