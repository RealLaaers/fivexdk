RegisterNetEvent('pure-scripts:bp_character:migrate', function(skinTable)
    local citizenIDtoApply = skinTable.playerid 
    local skin = json.decode(skinTable.playerskin)
    local model = skin.model_hash
    if not model then
        return
    end
    print('Migrating', citizenIDtoApply, model)
    if (model == -1667301416 or model == 1885233650) then
        RequestModel(model)
        while not HasModelLoaded(model) do
            RequestModel(model)
            Wait(50)
        end
        SetPlayerModel(cache.ped, model)
        Wait(250)
        SetPedHeadBlendData(cache.ped, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, true)
        SetPedComponentVariation(cache.ped, 0, 0, 0, 2)

        local weightFace = skin.face / 100 + 0.0
        local weightSkin = skin.skin / 100 + 0.0
        local ped = cache.ped
        SetPedHeadBlendData(ped, skin.mom, skin.dad, 0, skin.mom, skin.dad, 0, weightFace, weightSkin, 0.0, false)


        SetPedFaceFeature(ped, 0,  (skin.nose_1 / 100)         + 0.0)  
        SetPedFaceFeature(ped, 1,  (skin.nose_2 / 100)         + 0.0)  
        SetPedFaceFeature(ped, 2,  (skin.nose_3 / 100)         + 0.0) 
        SetPedFaceFeature(ped, 3,  (skin.nose_4 / 100)         + 0.0)  
        SetPedFaceFeature(ped, 4,  (skin.nose_5 / 100)         + 0.0)  
        SetPedFaceFeature(ped, 5,  (skin.nose_6 / 100)         + 0.0)  
        SetPedFaceFeature(ped, 6,  (skin.eyebrows_5 / 100)     + 0.0)  
        SetPedFaceFeature(ped, 8,  (skin.cheeks_1 / 100)       + 0.0) 
        SetPedFaceFeature(ped, 9,  (skin.cheeks_2 / 100)       + 0.0)  
        SetPedFaceFeature(ped, 10, (skin.cheeks_3 / 100)       + 0.0)  
        SetPedFaceFeature(ped, 11, (skin.eye_open / 100)     + 0.0)  
        -- SetPedFaceFeature(ped, 12, (skin.lip_thickness / 100)  + 0.0) 
        SetPedFaceFeature(ped, 13, (skin.jaw_1 / 100)          + 0.0)  
        SetPedFaceFeature(ped, 14, (skin.jaw_2 / 100)          + 0.0)  
        SetPedFaceFeature(ped, 15, (skin.chin_height / 100)         + 0.0)  
        SetPedFaceFeature(ped, 16, (skin.chin_lenght / 100)         + 0.0)  
        SetPedFaceFeature(ped, 17, (skin.chin_width / 100)         + 0.0)  
        SetPedFaceFeature(ped, 18, (skin.chin_hole / 100)         + 0.0)  
        SetPedFaceFeature(ped, 19, (skin.neck_thick / 100) + 0.0) 


        SetPedComponentVariation(ped, 2, skin.hair_1, skin.hair_2, 2)                  -- Hair Style
        SetPedHairColor(ped, skin.hair_color_1, skin.hair_color_2)                     -- Hair Color
        SetPedHeadOverlay(ped, 2, skin.eyebrows_1, skin.eyebrows_2 / 100 + 0.0)        -- Eyebrow Style + Opacity
        SetPedHeadOverlayColor(ped, 2, 1, skin.eyebrows_3, skin.eyebrows_4)            -- Eyebrow Color
        SetPedHeadOverlay(ped, 1, skin.beard_1, skin.beard_2 / 10 + 0.0)              -- Beard Style + Opacity
        SetPedHeadOverlayColor(ped, 1, 1, skin.beard_3, skin.beard_4)                  -- Beard Color

        SetPedHeadOverlay(ped, 0, skin.blemishes_1, skin.blemishes_2 / 10 + 0.0)      -- Skin blemishes + Opacity
    

        SetPedHeadOverlay(ped, 11, skin.bodyb_1, skin.bodyb_2 / 10 + 0.0)             -- Body Blemishes + Opacity

        SetPedHeadOverlay(ped, 3, skin.age_1, skin.age_2 / 10 + 0.0)                  -- Age + opacity
        -- SetPedHeadOverlay(ped, 6, skin.complexion_1, skin.complexion_2 / 100 + 0.0)    -- Complexion + Opacity
        SetPedHeadOverlay(ped, 9, skin.moles_1, skin.moles_2 / 10 + 0.0)              -- Moles/Freckles + Opacity
        SetPedHeadOverlay(ped, 7, skin.sun_1, skin.sun_2 / 10 + 0.0)                  -- Sun Damage + Opacity
        SetPedEyeColor(ped, skin.eye_color)                                            -- Eyes Color
        SetPedHeadOverlay(ped, 4, skin.makeup_1, skin.makeup_2 / 10 + 0.0)            -- Makeup + Opacity
        SetPedHeadOverlayColor(ped, 4, 0, skin.makeup_3, skin.makeup_4)                -- Makeup Color
        SetPedHeadOverlay(ped, 5, skin.blush_1, skin.blush_2 / 10 + 0.0)              -- Blush + Opacity
        SetPedHeadOverlayColor(ped, 5, 2,	skin.blush_3)                                -- Blush Color
        SetPedHeadOverlay(ped, 8, skin.lipstick_1, skin.lipstick_2 / 10 + 0.0)        -- Lipstick + Opacity
        SetPedHeadOverlayColor(ped, 8, 2, skin.lipstick_3, skin.lipstick_4)            -- Lipstick Color
        SetPedHeadOverlay(ped, 10, skin.chest_1, skin.chest_2 / 10 + 0.0)             -- Chest Hair + Opacity
        SetPedHeadOverlayColor(ped, 10, 1, skin.chest_3, skin.chest_4)                 -- Chest Hair Color

        -- Clothing and Accessories
        SetPedComponentVariation(ped, 8,  skin.tshirt_1, skin.tshirt_2, 2)        -- Undershirts
        SetPedComponentVariation(ped, 11, skin.torso_1,  skin.torso_2,  2)        -- Jackets
        SetPedComponentVariation(ped, 3,  skin.arms,     skin.arms_2,   2)        -- Torsos
        SetPedComponentVariation(ped, 10, skin.decals_1, skin.decals_2, 2)        -- Decals
        SetPedComponentVariation(ped, 4,  skin.pants_1,  skin.pants_2,  2)        -- Legs
        SetPedComponentVariation(ped, 6,  skin.shoes_1,  skin.shoes_2,  2)        -- Shoes
        SetPedComponentVariation(ped, 1,  skin.mask_1,   skin.mask_2,   2)        -- Masks
        SetPedComponentVariation(ped, 9,  skin.bproof_1, skin.bproof_2, 2)        -- Vests
        SetPedComponentVariation(ped, 7,  skin.chain_1,  skin.chain_2,  2)    -- Necklaces/Chains/Ties/Suspenders
        SetPedComponentVariation(ped, 5,  skin.bag_1,   skin.bag_2,   2) 		-- Bags	
        if skin.helmet_1 == -1 then
            ClearPedProp(ped, 0)
        else
            SetPedPropIndex(ped, 0, skin.helmet_1, skin.helmet_2, 2)          -- Hats
        end

        if skin.glasses_1 == -1 then
            ClearPedProp(ped, 1)
        else
            SetPedPropIndex(ped, 1, skin.glasses_1, skin.glasses_2, 2)        -- Glasses
        end

        if skin.watches_1 == -1 then
            ClearPedProp(ped, 6)
        else
            SetPedPropIndex(ped, 6, skin.watches_1, skin.watches_2, 2)      -- Left Hand Accessory
        end

        if skin.bracelets_1 == -1 or skin.bracelets_1 == 0 then
            ClearPedProp(ped,	7)
        else
            SetPedPropIndex(ped, 7, skin.bracelets_1, skin.bracelets_2, 2)    -- Right Hand Accessory
        end

        if skin.ears_1 == -1 or skin.ears_1 == 0 then
            ClearPedProp(ped, 2)
        else
            SetPedPropIndex (ped, 2, skin.ears_1, skin.ears_2, 2)             -- Ear Accessory
        end
    else

        local ped = cache.ped
        RequestModel(model)
        while not HasModelLoaded(model) do
            RequestModel(model)
            Wait(0)
        end

        SetPlayerModel(cache.ped, model)
        Wait(500)
        SetPedDefaultComponentVariation(cache.ped)
        -- SetPedHeadBlendData(cache.ped, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, true)
        SetPedComponentVariation(cache.ped, 0, 0, 0, 2)
        SetPedComponentVariation(cache.ped, 8,  skin.tshirt_1, skin.tshirt_2, 2)        -- Undershirts
        SetPedComponentVariation(cache.ped, 11, skin.torso_1,  skin.torso_2,  2)        -- Jackets
        SetPedComponentVariation(cache.ped, 3,  skin.arms,     skin.arms_2,   2)        -- Torsos
        SetPedComponentVariation(cache.ped, 10, skin.decals_1, skin.decals_2, 2)        -- Decals
        SetPedComponentVariation(cache.ped, 4,  skin.pants_1,  skin.pants_2,  2)        -- Legs
        SetPedComponentVariation(cache.ped, 6,  skin.shoes_1,  skin.shoes_2,  2)        -- Shoes
        SetPedComponentVariation(cache.ped, 1,  skin.mask_1,   skin.mask_2,   2)        -- Masks
        SetPedComponentVariation(cache.ped, 9,  skin.bproof_1, skin.bproof_2, 2)        -- Vests
        SetPedComponentVariation(cache.ped, 7,  skin.chain_1,  skin.chain_2,  2)    -- Necklaces/Chains/Ties/Suspenders
    end

    saveSkinToDB(citizenIDtoApply, model)
end)