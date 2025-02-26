local duel = false
local gungame = false

local point = lib.points.new(vec3(-3673.387, -3660.031, 345.665222), 100)

local redzone = false
function point:onEnter()
  redzone = true
end

function point:onExit()
  redzone = false
end

local pointt = lib.points.new(vec3(5130.3467, -4985.6982, 12.6833), 2000)

local cayo = false
function pointt:onEnter()
  cayo = true
end

function pointt:onExit()
  cayo = false
end

local pointtt = lib.points.new(vec3(353.9257, -1409.8763, 76.1742), 50)

local spawn = false
function pointtt:onEnter()
    spawn = true
end

function pointtt:onExit()
    spawn = false
end

local function notify(msg, nType)
    lib.notify({
      title = msg,
      type = nType
    })
  end

RegisterCommand("newpvpmenu", function()
    lib.registerContext({
        id = 'pvpmenu',
        title = 'FiveX - PvP Menu',
        options = {
            {
                title = 'Spiller',
                icon = 'user',
                description = '',
                event = 'PlayerMenu',
            },
            {
                title = 'Køretøj',
                icon = 'car',
                description = '',
                event = 'koretojmenu',
            },
            {
                title = 'Items',
                icon = 'gun',
                description = '',
                arrow = false,
                menu = 'vobenmenu',
            },
            {
                title = 'Teleport',
                icon = 'bars',
                description = '',
                event = 'teleportmenu',
            },
            {
                title = 'Indstillinger',
                icon = 'gear',
                description = '',
                event = 'justeringer',
            },
            {
                title = 'Crew',
                icon = 'users',
                description = '',
                event = 'creww',
            },
        },
    })

lib.showContext('pvpmenu')
end)

AddEventHandler('pvpmenu:selectcar', function(args)
    if not Config.canSpawnVehicle then return notify('Køretøjer er deaktiveret her.', 'error') end
    if LocalPlayer.state.inDuel ~= nil then return notify('Køretøjer er deaktiveret her.', 'error') end
    if not cayo and not gungame then
    local KanJegSeSpiller = IsEntityVisible(PlayerPedId())

    if KanJegSeSpiller == false then return end
    if VentFister == true then 
        lib.notify({
            description = 'Vent venligst.',
            type = 'inform'
        })
        return 
    end

    VentFister = true
    TriggerServerEvent("BitchNigger:SpawnCar", args.veh)

    Citizen.Wait(5000)
    VentFister = false
else
    lib.notify({
        title = 'FiveX',
        description = 'Dette er ikke muligt på nuværende tidspunkt.',
        type = 'error',
        style = {
          backgroundColor = '#141517',
          color = '#C1C2C5',
          ['.description'] = {
            color = '#909296'
          }
      },
      icon = 'car',
          iconColor = '#C53030'
      })
end
end)

RegisterNetEvent('five-x:disable:noclip:revive')
AddEventHandler('five-x:disable:noclip:revive', function(status, script)
    if script == 'duel' then
    if status then
        duel = false
    else
        duel = true
    end
    end
    if script == 'gungame' then
        if status then
            gungame = false
        else
            gungame = true
        end
    end
end)

RegisterCommand('revive', function()
    if not Config.canRevive then return notify('Revive er deaktiveret her.', 'error') end
    if LocalPlayer.state.inDuel ~= nil then return notify('Revive er deaktiveret her.', 'error') end
    if not cayo and not gungame then
        TriggerEvent('esx_ambulancejob:revive')
    else
        lib.notify({
            title = 'FiveX',
            description = 'Revive er ikke muligt på nuværende tidspunkt.',
            type = 'error',
            style = {
              backgroundColor = '#141517',
              color = '#C1C2C5',
              ['.description'] = {
                color = '#909296'
              }
          },
          icon = 'heart',
              iconColor = '#C53030'
          })
    end
  end)
  
  RegisterCommand('r', function()
    if not Config.canRevive then return notify('Revive er deaktiveret her.', 'error') end
    if LocalPlayer.state.inDuel ~= nil then return notify('Revive er deaktiveret her.', 'error') end
    if not cayo and not gungame then
        TriggerEvent('esx_ambulancejob:revive')
    else
        lib.notify({
            title = 'FiveX',
            description = 'Revive er ikke muligt på nuværende tidspunkt.',
            type = 'error',
            style = {
              backgroundColor = '#141517',
              color = '#C1C2C5',
              ['.description'] = {
                color = '#909296'
              }
          },
          icon = 'heart',
              iconColor = '#C53030'
          })
    end
  end)

RegisterCommand('noclip', function()
    if not Config.canNoclip then return notify('Noclip er deaktiveret her.', 'error') end
    if LocalPlayer.state.inDuel ~= nil then return notify('Noclip er deaktiveret her.', 'error') end
    if not cayo and not gungame then
        TriggerEvent('fivex:noclip')
    else
        lib.notify({
            id = 'noclip_error',
            title = 'FiveX',
            description = 'Du kan ikke aktivere noclip på nuværende tidspunkt!',
            style = {
                backgroundColor = '#141517',
                color = '#C1C2C5',
                ['.description'] = {
                  color = '#909296'
                }
            },
            icon = 'ghost',
            iconColor = '#C53030'
        })
    end
end)