

function saveSkinToDB(citizenID, modelHash)
    print(citizenID, modelHash, 'saveSkinToDB')
    local currentClothing, oldClothing, currentHair, oldHair, currentFace, oldFace = getCharacterValuesForSaving()
    local currentPed, oldPed = getPedValuesForSaving()
    local currentTattoos, oldTattoos = getTattooValuesForSaving()
    debugPrint('Saving clothing', json.encode(currentClothing))
    debugPrint('Old clothing', json.encode(oldClothing))
    debugPrint('Saving hair', json.encode(currentHair))
    debugPrint('Old hair', json.encode(oldHair))
    debugPrint('Saving face', json.encode(currentFace))
    debugPrint('Old face', json.encode(oldFace))
    debugPrint('Saving ped', json.encode(currentPed))
    debugPrint('Old ped', json.encode(oldPed))
    local model = 'mp_m_freemode_01'
    if GetEntityModel(PlayerPedId()) == `mp_f_freemode_01` then
      model = 'mp_f_freemode_01'
    end
    TriggerServerEvent('pure-clothing:saveMigration', citizenID, currentClothing, currentHair, currentFace, model, modelHash, currentTattoos)
end