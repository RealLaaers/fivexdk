if Config.framework ~= 'esx' then return end

local firstSpawn = true
onCancelFunc = nil
onCancelFunc = nil
openCreateCharacterMenu = false

RegisterNetEvent("esx:onPlayerLogout", function()
    PlayerData = nil
end)

RegisterNetEvent("esx:setJob", function(job)
	PlayerData.job = job
    resestBlips()
end)

RegisterNetEvent("esx:playerLoaded", function(xPlayer)
    PlayerData = xPlayer
    if openCreateCharacterMenu then return end
    initiateApperance()
end)

AddEventHandler("esx_skin:resetFirstSpawn", function()
    firstSpawn = true
end)

AddEventHandler("esx_skin:playerRegistered", function()
    if firstSpawn then
        --openMenu('createCharacter', true)
    end
    -- Used if they do not have a multicharacter in the esx script
end)

RegisterNetEvent('skinchanger:getSkin', function(cb)
    if not PlayerData then return end
    local characterResult, clothingResult, hairResult, tattoosResult, model = lib.callback.await('pure-clothing:getCharacter', false)
    local skin = {}
    if model == 'mp_f_freemode_01' then 
        skin.sex = 1
    else
        skin.sex = 0
    end
    cb(skin)
end)

RegisterNetEvent("skinchanger:loadSkin", function(skin, cb)
    if not skin.model then initiateApperance() end -- default clothing
    if PlayerData and PlayerData.loadout then
        TriggerEvent("esx:restoreLoadout")
    end
    cachePed()
	if cb ~= nil then
		cb()
	end
end)

-- RegisterNetEvent("skinchanger:loadClothes", function(_, clothes)
--     local playerPed = cache.ped
--     Character = {}

--     if clothes ~= nil then

--         for k,v in pairs(clothes) do
--           if
--             k ~= 'sex'          and
--             k ~= 'face'         and
--             k ~= 'skin'         and
--             k ~= 'age_1'        and
--             k ~= 'age_2'        and
--             k ~= 'beard_1'      and
--             k ~= 'beard_2'      and
--             k ~= 'beard_3'      and
--             k ~= 'beard_4'      and
--             k ~= 'hair_1'       and
--             k ~= 'hair_2'       and
--             k ~= 'hair_color_1' and
--             k ~= 'hair_color_2' and
--             k ~= 'eyebrows_1'   and
--             k ~= 'eyebrows_2'   and
--             k ~= 'eyebrows_3'   and
--             k ~= 'eyebrows_4'   and
--             k ~= 'makeup_1'     and
--             k ~= 'makeup_2'     and
--             k ~= 'makeup_3'     and
--             k ~= 'makeup_4'     and
--             k ~= 'lipstick_1'   and
--             k ~= 'lipstick_2'   and
--             k ~= 'lipstick_3'   and
--             k ~= 'lipstick_4'
--           then
--             Character[k] = v
--           end
--         end
    
--       end

--     SetPedComponentVariation(playerPed, 8, Character['tshirt_1'], Character['tshirt_2'], 2) -- Tshirt
--     SetPedComponentVariation(playerPed, 11, Character['torso_1'], Character['torso_2'], 2) -- torso parts
--     SetPedComponentVariation(playerPed, 3, Character['arms'], Character['arms_2'], 2) -- Arms
--     if Character['decals_1'] then 
--         SetPedComponentVariation(playerPed, 10, Character['decals_1'], Character['decals_2'], 2) -- decals
--     end
--     if Character['pants_1'] then 
--         SetPedComponentVariation(playerPed, 4, Character['pants_1'], Character['pants_2'], 2) -- pants
--     end
--     if Character['shoes_1'] then 
--         SetPedComponentVariation(playerPed, 6, Character['shoes_1'], Character['shoes_2'], 2) -- shoes
--     end
--     if Character['mask_1'] then 
--         SetPedComponentVariation(playerPed, 1, Character['mask_1'], Character['mask_2'], 2) -- mask
--     end
--     if Character['bproof_1'] then 
--         SetPedComponentVariation(playerPed, 9, Character['bproof_1'], Character['bproof_2'], 2) -- bulletproof
--     end
--     if Character['chain_1'] then 
--         SetPedComponentVariation(playerPed, 7, Character['chain_1'], Character['chain_2'], 2) -- chain
--     end
--     if Character['bags_1'] then 
--         SetPedComponentVariation(playerPed, 5, Character['bags_1'], Character['bags_2'], 2) -- Bag
--     end

--     if Character['helmet_1'] == -1 then
--         ClearPedProp(playerPed, 0)
--     else
--         if Character['helmet_1'] then 
--             SetPedPropIndex(playerPed, 0, Character['helmet_1'], Character['helmet_2'], 2) -- Helmet
--         end
--     end

--     if Character['glasses_1'] == -1 then
--         ClearPedProp(playerPed, 1)
--     else
--         if Character['glasses_1'] then 
--             SetPedPropIndex(playerPed, 1, Character['glasses_1'], Character['glasses_2'], 2) -- Glasses
--         end
--     end

--     if Character['watches_1'] == -1 then
--         ClearPedProp(playerPed, 6)
--     else
--         if Character['watches_1'] then 
--             SetPedPropIndex(playerPed, 6, Character['watches_1'], Character['watches_2'], 2) -- Watches
--         end
--     end

--     if Character['bracelets_1'] == -1 then
--         ClearPedProp(playerPed, 7)
--     else
--         if Character['bracelets_1'] then 
--             SetPedPropIndex(playerPed, 7, Character['bracelets_1'], Character['bracelets_2'], 2) -- Bracelets
--         end
--     end
-- end)

RegisterNetEvent("esx_skin:openSaveableMenu", function(onSubmit, onCancel)
    openCreateCharacterMenu = true
    openMenu('createCharacter', true)
    onSubmitFunc = onSubmit
    onCancelFunc = onCancel
end)