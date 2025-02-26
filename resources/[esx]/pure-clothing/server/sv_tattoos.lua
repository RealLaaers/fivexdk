tattoosMale = {}
tattoosFemale = {}

function loadTattoos()
    tattoosMale = json.decode(LoadResourceFile(GetCurrentResourceName(), './tattoos/allTattoos.json'))
    tattoosFemale = json.decode(LoadResourceFile(GetCurrentResourceName(), './tattoos/allTattoos.json'))
    local maleTattoos = json.decode(LoadResourceFile(GetCurrentResourceName(), './tattoos/MaleOnly/male.json'))
    local femaleTattoos = json.decode(LoadResourceFile(GetCurrentResourceName(), './tattoos/FemaleOnly/female.json'))
    -- print('tattoos', json.encode(tattoosCopy[1].left_leg))

    for k,v in pairs(maleTattoos[1]) do
        for i = 1, #maleTattoos[1][k] do 
            table.insert(tattoosMale[1][k], maleTattoos[1][k][i])
        end
    end

    for k,v in pairs(femaleTattoos[1]) do
      for i = 1, #femaleTattoos[1][k] do 
          table.insert(tattoosFemale[1][k], femaleTattoos[1][k][i])
      end
    end
    debugPrint('Loaded Male and Female Tattoos and Combined them into set tables')
end

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    loadTattoos()
end)