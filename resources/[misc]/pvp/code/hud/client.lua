local gtahud = false
local minimap

local pointt = lib.points.new(vec3(5130.3467, -4985.6982, 12.6833), 2000)

local cayo = false
function pointt:onEnter()
    cayo = true
    gtahud = true
    pvpIconColor = 'red'
    gtaIconColor = 'green'
    SendNUIMessage({
        task = 'showGTAHud'
    })
    SendNUIMessage({
        task = 'hidePVPHud'
    })
    DisplayRadar(true)
    if not minimap then
        minimap = RequestScaleformMovie("minimap")
        while not HasScaleformMovieLoaded(minimap) do
            Citizen.Wait(0)
        end
    end
end

function pointt:onExit()
    cayo = false
    gtahud = false
    pvpIconColor = 'green'
    gtaIconColor = 'red'
    SendNUIMessage({
        task = 'showPVPHud'
    })
    SendNUIMessage({
        task = 'hideGTAHud'
    })
    DisplayRadar(false)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    DisplayRadar(false)
end)

Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()

        if gtahud then
                SetRadarBigmapEnabled(false, false)
            Citizen.Wait(1000)
        else
            SendNUIMessage({
                task = 'updateHud',
                info = {
                    health = GetEntityHealth(playerPed) - 100,
                    armor = GetPedArmour(playerPed)
                }
            })
            Citizen.Wait(350)

            minimap = RequestScaleformMovie("minimap")
            while not HasScaleformMovieLoaded(minimap) do
                Citizen.Wait(0)
            end

            SetRadarBigmapEnabled(true, false)
            Citizen.Wait(0)
            SetRadarBigmapEnabled(false, false)
            BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
            ScaleformMovieMethodAddParamInt(3)
            EndScaleformMovieMethod()

            Citizen.Wait(350)
        end

        Citizen.Wait(350)
    end
end)

local gtaIconColor = 'red'
local pvpIconColor = 'green'

RegisterCommand('hud', function()
    lib.registerContext({
        id = 'hud_menu',
        title = 'FiveX - Hud',
        menu  = 'justeringer',
        options = {
            {
                title = 'PVP Hud',
                description = 'Klik for at bruge PVP hud.',
                icon = 'circle-check',
                iconColor = pvpIconColor,
                onSelect = function(args)
                    gtahud = false
                    pvpIconColor = 'green'
                    gtaIconColor = 'red'
                    SendNUIMessage({
                        task = 'showPVPHud'
                    })
                    SendNUIMessage({
                        task = 'hideGTAHud'
                    })
                    DisplayRadar(false)
                end,
            },
            {
                title = 'GTA Hud',
                description = 'Klik for at bruge GTA hud.',
                icon = 'circle-check',
                iconColor = gtaIconColor,
                onSelect = function(args)
                    gtahud = true
                    pvpIconColor = 'red'
                    gtaIconColor = 'green'
                    SendNUIMessage({
                        task = 'showGTAHud'
                    })
                    SendNUIMessage({
                        task = 'hidePVPHud'
                    })
                    DisplayRadar(true)
                    if not minimap then
                        minimap = RequestScaleformMovie("minimap")
                        while not HasScaleformMovieLoaded(minimap) do
                            Citizen.Wait(0)
                        end
                    end
                end,
            },
        },
    })
    lib.showContext('hud_menu')
end)
