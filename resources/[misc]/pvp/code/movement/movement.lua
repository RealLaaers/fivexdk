-- for i = 0, 1 do
--     StatSetInt(GetHashKey("mp" .. i .. "_shooting_ability"), 90, true)
--     StatSetInt(GetHashKey("sp" .. i .. "_shooting_ability"), 90, true)
--   end
  
  local actionMode = false
  local usingActionMode = false
  
  local rzIconColor = 'red'
  local rpIconColor = 'green'
  
  Citizen.CreateThread(function()
      local savedMovement = GetResourceKvpString('fivex_movement')
      if savedMovement then
          if savedMovement == 'PVP' then
              actionMode = true
              usingActionMode = true
              rzIconColor = 'green'
              rpIconColor = 'red'
          elseif savedMovement == 'RP' then
              actionMode = false
              usingActionMode = false
              rzIconColor = 'red'
              rpIconColor = 'green'
          end
      end
  end)

  RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    actionMode = true
    usingActionMode = true
    SetResourceKvp('fivex_movement', 'PVP')
end)

  RegisterCommand('movement', function()
    if LocalPlayer.state.inDuel ~= nil then return notify('Movement er deaktiveret her.', 'error') end
      lib.registerContext({
          id = 'movement_menu',
          title = 'FiveX - Movement',
          menu  = 'justeringer',
          options = {
              {
                  title = 'PVP Movement',
                  description = 'Klik for at anvende PVP Movement.',
                  icon = 'circle-check',
                  iconColor = rzIconColor,
                  onSelect = function(args)
                      actionMode = true
                      usingActionMode = true
                      rzIconColor = 'green'
                      rpIconColor = 'red'
                      SetResourceKvp('fivex_movement', 'PVP')
                      for i = 0, 3 do
                        StatSetInt(GetHashKey("mp" .. i .. "_shooting_ability"), 100, true)
                        StatSetInt(GetHashKey("sp" .. i .. "_shooting_ability"), 100, true)
                      end
                  end,
              },
              {
                  title = 'RP Movement',
                  description = 'Klik for at anvende RP Movement.',
                  icon = 'circle-check',
                  iconColor = rpIconColor,
                  onSelect = function(args)
                      actionMode = false
                      usingActionMode = false
                      rzIconColor = 'red'
                      rpIconColor = 'green'
                      SetResourceKvp('fivex_movement', 'RP')
                      SetPedUsingActionMode(PlayerPedId(), false, -1, 'DEFAULT_ACTION')
                      for i = 0, 3 do
                        StatSetInt(GetHashKey("mp" .. i .. "_shooting_ability"), 60, true)
                        StatSetInt(GetHashKey("sp" .. i .. "_shooting_ability"), 60, true)
                      end
                  end,
              },
          },
      })
      lib.showContext('movement_menu')
  end)

  CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        if DoesEntityExist(playerPed) then
        if not actionMode and IsPedUsingActionMode(PlayerPedId()) then
            SetPedUsingActionMode(playerPed, false, -1, 'DEFAULT_ACTION')
        end
        end
        Wait(100)
    end
  end)