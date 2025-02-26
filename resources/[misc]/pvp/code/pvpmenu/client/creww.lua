RegisterNetEvent("creww")
AddEventHandler("creww", function()
    lib.registerContext({
        id = 'creww',
        title = 'FiveX - Crews',
        menu  = 'pvpmenu',
        options = {
            {
                title = 'Crew Menu',
                arrow = false,
                onSelect = function()
                    TriggerEvent('crewmenu')
                end,
            },
            {
                title = 'Crew Leaderboard',
                arrow = false,
                onSelect = function()
                    ExecuteCommand("crewleaderboard")
                end,
            },
        },
    })

    lib.showContext('creww')
end)

RegisterCommand('crew', function()
    TriggerEvent('creww')
end)