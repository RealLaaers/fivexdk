local co = false
local NotSpam = false
AddEventHandler('playerSpawned', function()
    if not co then
        -- TriggerEvent("KOTH_HUD:removeHUD",1)
        -- startCamera()
        -- showMainMenu()
        ClearPedBloodDamage(PlayerPedId())
        co = true
        TriggerEvent("core:ResetDeathStatus",true)
        TriggerServerEvent("GetUserBDD")
    else
        TriggerEvent("KOTH:ReturnBase")
        TriggerEvent("core:ResetDeathStatus", true)

        ClearPedBloodDamage(PlayerPedId())
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == "koth-main" then
        Wait(1500)
        -- showMainMenu()
        -- startCamera()
        TriggerEvent("playerSpawned")
    end
end)

RegisterNetEvent("KOTH:TeleportPlayer")
AddEventHandler("KOTH:TeleportPlayer", function(x, y, z, heading, win)
    local ped = PlayerPedId()
    SetEntityCoords(ped, x, y, z)
    SetEntityHeading(ped, heading)
    ExecuteCommand('leavekoth')
    TriggerServerEvent('koth:win', win)
end)
  
function showMainMenu()
    --local data = {type = "show", one = "Opfor Team", two = "Independent", three = "Blufor Team"}
    --SendNUIMessage(data)
    --SetNuiFocus(true, true)
end


RegisterNetEvent("KOTH-TeamFull")
AddEventHandler("KOTH-TeamFull", function(team)
    -- local send = {
    --     type = "teamfull",
    --     fullteam = team
    -- }
    local teamtext = ""
    if team == 1 then
        teamtext = 'Rød'
    elseif team == 2 then
        teamtext = 'Blå'
    elseif team == 3 then
        teamtext = 'Grøn'
    end
    lib.notify({
        title = teamtext..' er fyldt, prøv et andet.',
        type = 'error'
    })
    NotSpam = false
    --SendNUIMessage(send)
end)

-- Uden for /koth-kommanden definerer vi en variabel til at forhindre spam
local NotSpam = false

RegisterCommand('koth', function()
    -- Tjek om du er i bucket
    local bucket = lib.callback.await("KOTH:CheckBucket", 100)
    if bucket then
        lib.notify({
            title = 'Du kan ikke åbne menuen nu.',
            type = 'error'
        })
        return
    end

    -- Hent hold-antal og point fra serveren
    local teamCounts = lib.callback.await("KOTH:GetTeamCounts", 1000)
    local teamPoints = lib.callback.await("KOTH:GetTeamPoints", 1000)

    -- Hvis vi ikke fik data, sæt dem til 0
    local redCount   = (teamCounts and teamCounts.red)   or 0
    local blueCount  = (teamCounts and teamCounts.blue)  or 0
    local greenCount = (teamCounts and teamCounts.green) or 0

    local redPoints   = (teamPoints and teamPoints.red)   or 0
    local bluePoints  = (teamPoints and teamPoints.blue)  or 0
    local greenPoints = (teamPoints and teamPoints.green) or 0

    -- Udregn total spillerantal
    local totalCount = redCount + blueCount + greenCount

    -- Find førende hold
    local leadingTeam, leadingPoints = "Rød", redPoints
    if bluePoints >= redPoints and bluePoints >= greenPoints then
        leadingTeam, leadingPoints = "Blå", bluePoints
    elseif greenPoints >= redPoints and greenPoints >= bluePoints then
        leadingTeam, leadingPoints = "Grøn", greenPoints
    end

    -- Opret selve menuen
    lib.registerContext({
        id = 'choose_team',
        title = 'KOTH - Vælg Hold',
        options = {
          {
            title = 'Antal Spillere: ' .. totalCount
          },
          {
            title = 'Førende: ' .. leadingTeam .. ' (' .. leadingPoints .. ' pts - mangler: '..(100-leadingPoints)..' pts)'
          },
          {
            title = 'Tilladte våben:',
            description = 'Deagle, Navy Revolver & Scorpion'
          },
          {
            title = 'Rød - ' .. redCount .. ' spillere (' .. redPoints .. ' pts)',
            icon = 'bars',
            iconColor = 'red',
            onSelect = function()
                if not NotSpam then
                    NotSpam = true
                    TriggerServerEvent("Koth-SelectTeam", 1)
                    exports['pma-voice']:setRadioChannel(1)
                    lib.hideContext()
                    SetTimeout(2000, function()
                        NotSpam = false
                    end)
                end
            end,
          },
          {
            title = 'Blå - ' .. blueCount .. ' spillere (' .. bluePoints .. ' pts)',
            icon = 'bars',
            iconColor = 'blue',
            onSelect = function()
                if not NotSpam then
                    NotSpam = true
                    TriggerServerEvent("Koth-SelectTeam", 2)
                    exports['pma-voice']:setRadioChannel(2)
                    lib.hideContext()
                    SetTimeout(2000, function()
                        NotSpam = false
                    end)
                end
            end,
          },
          {
            title = 'Grøn - ' .. greenCount .. ' spillere (' .. greenPoints .. ' pts)',
            icon = 'bars',
            iconColor = 'green',
            onSelect = function()
                if not NotSpam then
                    NotSpam = true
                    TriggerServerEvent("Koth-SelectTeam", 3)
                    exports['pma-voice']:setRadioChannel(3)
                    lib.hideContext()
                    SetTimeout(2000, function()
                        NotSpam = false
                    end)
                end
            end,
          }
        }
    })

    -- Vis menuen
    lib.showContext('choose_team')
end)

function hideMainMenu()
    local data = {type = "hide"}
    SendNUIMessage(data)
    SetNuiFocus(false, false)

end

RegisterNUICallback('selectTeam', function(data, cb)
    local selectedTeam = data.selectedTeam

    if not NotSpam then
        TriggerServerEvent("Koth-SelectTeam", selectedTeam)
        NotSpam = true
    end
    
    cb({ok = true})
end)