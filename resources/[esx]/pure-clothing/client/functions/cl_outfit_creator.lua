function openOutfitCreator(source)
    local job = getJobName()
    local rank = getJobGrade()
    if not job or not rank then return end
    local currentOutfits = lib.callback.await('pure-clothing:getJobOutfits', false)
    -- print(json.encode(currentOutfits))
    local options = {
        {
          title = _Lang('newUpdateLang.outfitCreatorMenu.title'),
          description = _Lang('newUpdateLang.outfitCreatorMenu.button.description'),
          onSelect = function()
              local input = lib.inputDialog(_Lang('newUpdateLang.outfitCreatorMenu.dialog.title'), {_Lang('newUpdateLang.outfitCreatorMenu.dialog.name'), _Lang('newUpdateLang.outfitCreatorMenu.dialog.minRank')})
              if not input then return end
              local name, minRank = input[1], input[2]
              if not name or not minRank then return end
              createOutfit(name, minRank)
          end,
        },
        {
          title = _Lang('newUpdateLang.outfitCreatorMenu.delete.title'),
          description = _Lang('newUpdateLang.outfitCreatorMenu.delete.description'),
        },
    }
    for i = 1, #currentOutfits do 
        options[#options + 1] = {
            title = currentOutfits[i].name,
            description = 'Delete this outfit from the database',
            onSelect = function()
                deleteJobOutfit(currentOutfits[i])
            end,
        }
    end    
    registerMenu(options)
end

function registerMenu(newOptions)
    lib.registerContext({
        id = 'some_menu',
        title = _Lang('newUpdateLang.outfitCreatorMenu.title'),
        options = newOptions,
    })
    lib.showContext('some_menu')
end

function createOutfit(name, minRank)
    local currentClothing, oldClothing = getClothingValuesForSaving()
    local currentJob = getJobName()
    local rank = getJobGrade()
    local jobTable = {
        name = currentJob,
        minRank = minRank,
        rank = rank
    }
    local outfitTable = {
        name = name,
        modelHash = GetEntityModel(cache.ped),
        outfit = currentClothing
    }
    TriggerServerEvent('pure-clothing:registerJobOutfit', outfitTable, jobTable)
end

function deleteJobOutfit(outfitTable)
    local name = outfitTable.name
    TriggerServerEvent('pure-clothing:deleteJobOutfit', outfitTable.id, name)
end

-- CreateThread(function()
--     registerMenu()
-- end)