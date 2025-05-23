-- {"age_1":0,"pants_1":18,"ears_2":0,"makeup_3":0,"bodyb_1":0,"age_2":0,"decals_2":0,"glasses_2":0,"sun_1":0,"blush_3":0,"bracelets_2":0,"helmet_2":0,"lipstick_3":0,"complexion_1":0,"chain_1":0,"hair_2":0,"bags_2":0,"makeup_4":0,"decals_1":0,"watches_1":-1,"mask_1":0,"mask_2":0,"helmet_1":-1,"blush_2":0,"eyebrows_1":0,"hair_color_2":0,"moles_2":0,"tshirt_2":0,"eyebrows_4":0,"chain_2":0,"bproof_1":0,"arms":0,"bodyb_2":0,"tshirt_1":15,"watches_2":0,"eyebrows_3":0,"sun_2":0,"bags_1":0,"beard_2":0,"blemishes_1":0,"blush_1":0,"torso_1":21,"makeup_2":0,"hair_color_1":0,"moles_1":0,"shoes_2":0,"bracelets_1":-1,"arms_2":0,"bproof_2":0,"ears_1":-1,"makeup_1":0,"chest_3":0,"eyebrows_2":0,"pants_2":0,"lipstick_4":0,"eye_color":0,"sex":0,"chest_1":0,"glasses_1":0,"lipstick_1":0,"chest_2":0,"hair_1":3,"shoes_1":17,"beard_3":0,"face":0,"beard_4":0,"complexion_2":0,"torso_2":0,"beard_1":0,"skin":3,"lipstick_2":0,"blemishes_2":0}


RegisterNetEvent('pure-scripts:esx_skin:migrate', function(dbTable)
    local playerPed = cache.ped
    local skin = json.decode(dbTable.skin)
    local gender = dbTable.sex
    if gender == 'f' then
        model = 'mp_f_freemode_01'
    else
        model = 'mp_m_freemode_01'
    end
    local hashed = nil
    if type(model) == "string" then 
        hashed = joaat(model)
        debugPrint('Model is a string, converting to hash', model, hashed)
    end
    RequestModel(hashed)
    while not HasModelLoaded(hashed) do
      Wait(0)
    end
    SetPlayerModel(cache.playerId, hashed)
    Wait(50)
    SetModelAsNoLongerNeeded(hashed)
    playerPed = cache.ped
    local Character = {}

    for k, v in pairs(skin) do
        Character[k] = v
    end

    local face_weight = (Character['face_md_weight'] / 100) + 0.0
    local skin_weight = (Character['skin_md_weight'] / 100) + 0.0
    SetPedHeadBlendData(playerPed, Character['mom'], Character['dad'], 0, Character['mom'], Character['dad'], 0,
        face_weight, skin_weight, 0.0, false)

    SetPedFaceFeature(playerPed, 0, (Character['nose_1'] / 10) + 0.0) -- Nose Width
    SetPedFaceFeature(playerPed, 1, (Character['nose_2'] / 10) + 0.0) -- Nose Peak Height
    SetPedFaceFeature(playerPed, 2, (Character['nose_3'] / 10) + 0.0) -- Nose Peak Length
    SetPedFaceFeature(playerPed, 3, (Character['nose_4'] / 10) + 0.0) -- Nose Bone Height
    SetPedFaceFeature(playerPed, 4, (Character['nose_5'] / 10) + 0.0) -- Nose Peak Lowering
    SetPedFaceFeature(playerPed, 5, (Character['nose_6'] / 10) + 0.0) -- Nose Bone Twist
    SetPedFaceFeature(playerPed, 6, (Character['eyebrows_5'] / 10) + 0.0) -- Eyebrow height
    SetPedFaceFeature(playerPed, 7, (Character['eyebrows_6'] / 10) + 0.0) -- Eyebrow depth
    SetPedFaceFeature(playerPed, 8, (Character['cheeks_1'] / 10) + 0.0) -- Cheekbones Height
    SetPedFaceFeature(playerPed, 9, (Character['cheeks_2'] / 10) + 0.0) -- Cheekbones Width
    SetPedFaceFeature(playerPed, 10, (Character['cheeks_3'] / 10) + 0.0) -- Cheeks Width
    SetPedFaceFeature(playerPed, 11, (Character['eye_squint'] / 10) + 0.0) -- Eyes squint
    SetPedFaceFeature(playerPed, 12, (Character['lip_thickness'] / 10) + 0.0) -- Lip Fullness
    SetPedFaceFeature(playerPed, 13, (Character['jaw_1'] / 10) + 0.0) -- Jaw Bone Width
    SetPedFaceFeature(playerPed, 14, (Character['jaw_2'] / 10) + 0.0) -- Jaw Bone Length
    SetPedFaceFeature(playerPed, 15, (Character['chin_1'] / 10) + 0.0) -- Chin Height
    SetPedFaceFeature(playerPed, 16, (Character['chin_2'] / 10) + 0.0) -- Chin Length
    SetPedFaceFeature(playerPed, 17, (Character['chin_3'] / 10) + 0.0) -- Chin Width
    SetPedFaceFeature(playerPed, 18, (Character['chin_4'] / 10) + 0.0) -- Chin Hole Size
    SetPedFaceFeature(playerPed, 19, (Character['neck_thickness'] / 10) + 0.0) -- Neck Thickness

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

    if Character['bodyb_3'] == -1 then
        SetPedHeadOverlay(playerPed, 12, 255, (Character['bodyb_4'] / 10) + 0.0)
    else
        SetPedHeadOverlay(playerPed, 12, Character['bodyb_3'], (Character['bodyb_4'] / 10) + 0.0) -- Blemishes 'added body effect' + opacity
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
    saveSkinToDB(dbTable.identifier, GetEntityModel(cache.ped))
end)