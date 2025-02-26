function toggleNuiFrame(shouldShow)
  SetNuiFocus(shouldShow, shouldShow)
  sendReactMessage('setVisible', shouldShow)
end

RegisterCommand('clothing', function(source, args, rawCommand)
  exports['pure-clothing']:openMenu('createCharacter')
end)

function openMenu(menu, firstCharacter, onSubmit, onCancel)
  if canUseMenu() then return end
  if isInMenu then return end
  isInMenu = true
  TriggerEvent('pure-clothing:openedMenu', firstCharacter)
  getAllOufits()
  getAllValues()
  toggleNuiFrame(true)
  if not firstCharacter then 
    currentPedModel = lib.callback.await('pure-clothing:getPedModel', false)
  end
  sendReactMessage('setPage', menu)
  sendReactMessage('setCurrentPed', currentPedModel)
  TaskStandStill(cache.ped, -1)
  FreezeEntityPosition(cache.ped, true)
  Wait(250)
  FreezeEntityPosition(cache.ped, false)
  enableCamera(firstCharacter)

  local isPedFreemode = isPedFreemodePed(cache.ped)
  if Config.nui.whenPedDisableUneededMenus then 
    sendReactMessage('updatePedStuff', isPedFreemode)
  end

  cachePed()

  if menu == 'outfits' then 
    openClothing()
    return
  end

  if menu == 'createCharacter' then 
    openCreateCharacter(firstCharacter)
    if firstCharacter and Config.setPedInOwnWorld then 
      TriggerServerEvent('pure-clothing:setPedInOwnWorld', true)
    end
    return
  end

  if menu == 'clothing' then 
    openClothing()
    return
  end

  if menu == 'hair' then 
    openHair()
    return
  end

  if menu == 'tattoo' then 
    openTattoos()
    return
  end
end
exports('openMenu', openMenu)

RegisterNetEvent('pure-clothing:openMenu', function(menu, firstCharacter)
  openMenu(menu, firstCharacter)
end)

function closeClothing()
  toggleNuiFrame(false)
  isInMenu = false
  TriggerEvent('pure-clothing:exitedMenu')
  debugPrint('Hide NUI frame')
  disableCamera()
  ClearPedTasksImmediately(cache.ped)
  if Config.setPedInOwnWorld then
    TriggerServerEvent('pure-clothing:setPedInOwnWorld', false)
  end
end
