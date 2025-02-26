VentFister = false

RegisterNetEvent("koretojmenu")
AddEventHandler("koretojmenu", function()
    lib.registerContext({
        id = 'koretojmenu',
        title = 'FiveX - Køretøjer',
        menu  = 'pvpmenu',
        options = {
            {
                title = 'Neon',
                arrow = false,
                icon = 'car',
                event = 'pvpmenu:selectcar',
                args = {veh = "neon"}
            },
            {
                title = 'BF-400',
                arrow = false,
                icon = 'motorcycle',
                event = 'pvpmenu:selectcar',
                args = {veh = "bf400"}
            },
            {
                title = 'Hakuchou',
                arrow = false,
                icon = 'motorcycle',
                event = 'pvpmenu:selectcar',
                args = {veh = "hakuchou"}
            },
            {
                title = 'Schafter',
                arrow = false,
                icon = 'car',
                event = 'pvpmenu:selectcar',
                args = {veh = "Schafter3"}
            },
        },
    })

    lib.showContext('koretojmenu')
end)

RegisterNetEvent("tundenlortebil")
AddEventHandler("tundenlortebil", function()
    Wait(500)

    ClearVehicleCustomPrimaryColour(GetVehiclePedIsIn(GetPlayerPed(-1), false))
    ClearVehicleCustomSecondaryColour(GetVehiclePedIsIn(GetPlayerPed(-1), false))
    SetVehicleModKit(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
    SetVehicleWheelType(GetVehiclePedIsIn(GetPlayerPed(-1), false), 7)

    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 11, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 11) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 12, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 12) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 13, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 13) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 14, 16, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 15, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 15) - 2, false)
    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 16, GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), false), 16) - 1, false)

    ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 17, true)
    ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 18, true)
    ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 19, true)
    ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 20, true)
    ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), false), 21, true)

    SetVehicleTyreSmokeColor(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0, 0, 27)
    SetVehicleWindowTint(GetVehiclePedIsIn(GetPlayerPed(-1), false), 1)
    SetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false), "FIVEX")
    SetVehicleNumberPlateTextIndex(GetVehiclePedIsIn(GetPlayerPed(-1), false), 5)
    SetVehicleModColor_1(GetVehiclePedIsIn(GetPlayerPed(-1), false), 4, 27, 27)
    SetVehicleModColor_2(GetVehiclePedIsIn(GetPlayerPed(-1), false), 4, 27)
    SetVehicleColours(GetVehiclePedIsIn(GetPlayerPed(-1), false), math.random(1,100), 12)
    SetVehicleExtraColours(GetVehiclePedIsIn(GetPlayerPed(-1), false), 12, 12)	
end)