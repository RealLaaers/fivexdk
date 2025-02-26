function getPedGender(ped)
    if Config.genderBasedOnFramework then 
        return getGender()
    end

    local pedModel = GetEntityModel(ped)
    local gender = nil
    if pedModel == `mp_m_freemode_01` then 
        gender = 'male'
    elseif pedModel == `mp_f_freemode_01` then 
        gender = 'female'
    else 
        gender = 'male'
        -- the IsPedMale function is broken, so we have to do this
    end
    return gender
end

function isPedFreemodePed(ped)
    local pedModel = GetEntityModel(ped)
    debugPrint('Checking if ped is freemode', pedModel, ped)
    return pedModel == `mp_m_freemode_01` or pedModel == `mp_f_freemode_01`
end