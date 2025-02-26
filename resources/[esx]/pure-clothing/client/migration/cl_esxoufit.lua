RegisterNetEvent('pure-scripts:esx_skin:loadOutfit', function(outfit)
    local playerPed = cache.ped
    local Character = {}

    for i = 1, #outfit do 
        local skin = outfit[i].skin
        for k, v in pairs(skin) do
            Character[k] = v
        end
    
        SetPedHairColor(playerPed, Character['hair_color_1'], Character['hair_color_2']) -- Hair Color
        SetPedHeadOverlay(playerPed, 3, Character['age_1'], (Character['age_2'] / 10) + 0.0) -- Age + opacity
        SetPedHeadOverlay(playerPed, 0, Character['blemishes_1'], (Character['blemishes_2'] / 10) + 0.0) -- Blemishes + opacity
        SetPedHeadOverlay(playerPed, 1, Character['beard_1'], (Character['beard_2'] / 10) + 0.0) -- Beard + opacity
        SetPedEyeColor(playerPed, Character['eye_color']) -- Eyes color
        SetPedHeadOverlay(playerPed, 2, Character['eyebrows_1'], (Character['eyebrows_2'] / 10) + 0.0) -- Eyebrows + opacity
        SetPedHeadOverlay(playerPed, 4, Character['makeup_1'], (Character['makeup_2'] / 10) + 0.0) -- Makeup + opacity
        SetPedHeadOverlay(playerPed, 8, Character['lipstick_1'], (Character['lipstick_2'] / 10) + 0.0) -- Lipstick + opacity
        SetPedComponentVariation(playerPed, 2, Character['hair_1'], Character['hair_2'], 2) -- Hair
        SetPedHeadOverlayColor(playerPed, 1, 1, Character['beard_3'], Character['beard_4']) -- Beard Color
        SetPedHeadOverlayColor(playerPed, 2, 1, Character['eyebrows_3'], Character['eyebrows_4']) -- Eyebrows Color
        SetPedHeadOverlayColor(playerPed, 4, 2, Character['makeup_3'], Character['makeup_4']) -- Makeup Color
        SetPedHeadOverlayColor(playerPed, 8, 1, Character['lipstick_3'], Character['lipstick_4']) -- Lipstick Color
        SetPedHeadOverlay(playerPed, 5, Character['blush_1'], (Character['blush_2'] / 10) + 0.0) -- Blush + opacity
        SetPedHeadOverlayColor(playerPed, 5, 2, Character['blush_3']) -- Blush Color
        SetPedHeadOverlay(playerPed, 6, Character['complexion_1'], (Character['complexion_2'] / 10) + 0.0) -- Complexion + opacity
        SetPedHeadOverlay(playerPed, 7, Character['sun_1'], (Character['sun_2'] / 10) + 0.0) -- Sun Damage + opacity
        SetPedHeadOverlay(playerPed, 9, Character['moles_1'], (Character['moles_2'] / 10) + 0.0) -- Moles/Freckles + opacity
        SetPedHeadOverlay(playerPed, 10, Character['chest_1'], (Character['chest_2'] / 10) + 0.0) -- Chest Hair + opacity
        SetPedHeadOverlayColor(playerPed, 10, 1, Character['chest_3']) -- Torso Color
    
        if Character['bodyb_1'] == -1 then
            SetPedHeadOverlay(playerPed, 11, 255, (Character['bodyb_2'] / 10) + 0.0) -- Body Blemishes + opacity
        else
            SetPedHeadOverlay(playerPed, 11, Character['bodyb_1'], (Character['bodyb_2'] / 10) + 0.0)
        end
    
        if Character['ears_1'] == -1 then
            ClearPedProp(playerPed, 2)
        else
            SetPedPropIndex(playerPed, 2, Character['ears_1'], Character['ears_2'], 2) -- Ears Accessories
        end
    
        SetPedComponentVariation(playerPed, 8, Character['tshirt_1'], Character['tshirt_2'], 2) -- Tshirt
        SetPedComponentVariation(playerPed, 11, Character['torso_1'], Character['torso_2'], 2) -- torso parts
        SetPedComponentVariation(playerPed, 3, Character['arms'], Character['arms_2'], 2) -- Arms
        SetPedComponentVariation(playerPed, 10, Character['decals_1'], Character['decals_2'], 2) -- decals
        SetPedComponentVariation(playerPed, 4, Character['pants_1'], Character['pants_2'], 2) -- pants
        SetPedComponentVariation(playerPed, 6, Character['shoes_1'], Character['shoes_2'], 2) -- shoes
        SetPedComponentVariation(playerPed, 1, Character['mask_1'], Character['mask_2'], 2) -- mask
        SetPedComponentVariation(playerPed, 9, Character['bproof_1'], Character['bproof_2'], 2) -- bulletproof
        SetPedComponentVariation(playerPed, 7, Character['chain_1'], Character['chain_2'], 2) -- chain
        SetPedComponentVariation(playerPed, 5, Character['bags_1'], Character['bags_2'], 2) -- Bag
    
        if Character['helmet_1'] == -1 then
            ClearPedProp(playerPed, 0)
        else
            SetPedPropIndex(playerPed, 0, Character['helmet_1'], Character['helmet_2'], 2) -- Helmet
        end
    
        if Character['glasses_1'] == -1 then
            ClearPedProp(playerPed, 1)
        else
            SetPedPropIndex(playerPed, 1, Character['glasses_1'], Character['glasses_2'], 2) -- Glasses
        end
    
        if Character['watches_1'] == -1 then
            ClearPedProp(playerPed, 6)
        else
            SetPedPropIndex(playerPed, 6, Character['watches_1'], Character['watches_2'], 2) -- Watches
        end
    
        if Character['bracelets_1'] == -1 then
            ClearPedProp(playerPed, 7)
        else
            SetPedPropIndex(playerPed, 7, Character['bracelets_1'], Character['bracelets_2'], 2) -- Bracelets
        end
    
        saveOutfit(outfit[i].label)
    end
end)