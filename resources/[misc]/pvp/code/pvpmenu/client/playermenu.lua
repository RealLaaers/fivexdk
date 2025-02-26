RegisterNetEvent("PlayerMenu")
AddEventHandler("PlayerMenu", function()
    lib.registerContext({
        id = 'PlayerMenu',
        title = 'FiveX - PvP Menu',
        menu  = 'pvpmenu',
        options = {
            {
                title = 'Revive',
                arrow = false,
                -- description = 'Gir dig muligheden for at revive dig selv',
                onSelect = function()
                    ExecuteCommand("revive")
                end,
            },
            {
                title = 'Noclip',
                arrow = false,
                -- description = 'Gir dig muligheden for at flyve.',
                onSelect = function()
                    TriggerEvent("ToggleNoClip")
                end,
            },
            {
                title = 'Goto',
                arrow = false,
                -- description = 'Gir dig muligheden for at TP til andre spillere.',
                event = 'GotoNigger',
            },
            {
                title = 'Lobby Menu',
                arrow = false,
                -- description = 'Tilgå lobby menu!',
                event = 'MainPlayerLobby',
            },
        },
    })

    lib.showContext('PlayerMenu')
end)

RegisterNetEvent("MainPlayerLobby")
AddEventHandler("MainPlayerLobby", function()

    lib.registerContext({
        id = 'MainPlayerLobby',
        title = 'Lobby Menu (BETA)',
        options = {
            {
                title = 'Skift Lobby',
                arrow = true,
                description = '',
                event = 'PlayerLobby',
            },
            {
                title = 'Reset din lobby',
                arrow = false,
                onSelect = function()
                    TriggerServerEvent("ResetLobby")
                    lib.notify({
                        description = 'Din lobby blev resetted.',
                        type = 'inform'
                    })
                end,
            },
        },
    })

    lib.showContext('MainPlayerLobby')

end)

RegisterNetEvent("PlayerLobby")
AddEventHandler("PlayerLobby", function()
    ESX.TriggerServerCallback('GetPlayerRoutingBucket', function(GetPlayerRoutingBucket)
        local text = 'Dit lobby er: '.. GetPlayerRoutingBucket ..''
        local input = lib.inputDialog('Lobby Menu',     
        {
            {type = 'input', label = 'Lobby nummer'},
            {type = 'input', disabled = true, placeholder = text},
        })
        
        if not input then return end 
        local lobbyid = tonumber(input[1])
        if lobbyid == 19567 then
            lib.notify({
                description = 'Den lobby er blacklisted.',
                type = 'inform'
            })
        else
        TriggerServerEvent("PlayerLobby", lobbyid)
        lib.notify({
            description = 'Du gik i lobby: '..lobbyid,
            type = 'inform'
        })
    end
    end)
end)

local pointt = lib.points.new(vec3(5130.3467, -4985.6982, 12.6833), 2000)

local cayo = false
function pointt:onEnter()
  cayo = true
end

function pointt:onExit()
  cayo = false
end

local point = lib.points.new(vec3(-3673.387, -3660.031, 345.665222), 100)

local redzone = false
function point:onEnter()
  redzone = true
end

function point:onExit()
  redzone = false
end

RegisterNetEvent("GotoNigger")
AddEventHandler("GotoNigger", function()
    local input = lib.inputDialog('Teleport til spiller', {'ID'})

    if input == nil then
        lib.notify({
            description = 'Du skal indtaste et ID.',
            type = 'inform'
        })
        return
    end

    local playerId = tonumber(input[1])

    if playerId == nil then
        lib.notify({
            description = 'Ugyldigt ID.',
            type = 'error'
        })
        return
    end

    TriggerServerEvent('GetTargetCoords', playerId)
end)

RegisterNetEvent("ReceiveTargetCoords")
AddEventHandler("ReceiveTargetCoords", function(targetCoords)
    if targetCoords.x == 0.0 and targetCoords.y == 0.0 and targetCoords.z == 0.0 then
        lib.notify({
            description = 'Kunne ikke finde spillerens position.',
            type = 'error'
        })
        return
    end

    local cayoCoords = vec3(5130.3467, -4985.6982, 12.6833)
    local distance = GetDistanceBetweenCoords(cayoCoords.x, cayoCoords.y, cayoCoords.z, targetCoords.x, targetCoords.y, targetCoords.z, true)

    if distance > 2000.0 and not cayo and not redzone then
        SetEntityCoords(PlayerPedId(), targetCoords.x, targetCoords.y, targetCoords.z, false, false, false, true)
    else
        lib.notify({
            title = 'FiveX',
            description = 'Goto er ikke muligt på nuværende tidspunkt.',
            type = 'error',
            style = {
              backgroundColor = '#141517',
              color = '#C1C2C5',
              ['.description'] = {
                color = '#909296'
              }
          },
          icon = 'user',
              iconColor = '#C53030'
          })
    end

    local redZoneCoords = vec3(-3506.7473, 5753.8433, 658.2704)
    local distance2 = GetDistanceBetweenCoords(redZoneCoords.x, redZoneCoords.y, redZoneCoords.z, targetCoords.x, targetCoords.y, targetCoords.z, true)

    if distance2 > 85.0 and not cayo and not redzone then
        SetEntityCoords(PlayerPedId(), targetCoords.x, targetCoords.y, targetCoords.z, false, false, false, true)
    else
        lib.notify({
            title = 'FiveX',
            description = 'Goto er ikke muligt på nuværende tidspunkt.',
            type = 'error',
            style = {
              backgroundColor = '#141517',
              color = '#C1C2C5',
              ['.description'] = {
                color = '#909296'
              }
          },
          icon = 'user',
              iconColor = '#C53030'
          })
    end
end)

RegisterNetEvent("BringNigger")
AddEventHandler("BringNigger", function()
    local input = lib.inputDialog('Teleport til spiller', {'ID'})

    if input == nil then
        lib.notify({
            description = 'Denne spiller er ikke online',
            type = 'inform'
        })
    else
        TriggerServerEvent("BringNigger", input)
    end
end)