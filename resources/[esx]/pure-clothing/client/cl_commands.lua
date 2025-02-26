if not Config.enableTakeoffCommands then return end

-- Helmets
RegisterCommand('h0', function()
    LoadAnimDict("mp_masks@standard_car@ds@")
    TaskPlayAnim(cache.ped, "mp_masks@standard_car@ds@", "put_on_mask", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(600)
    ClearPedTasks(cache.ped)
    ClearPedProp(cache.ped, 0)
end)

RegisterCommand('h1', function()
    LoadAnimDict("mp_masks@standard_car@ds@")
    TaskPlayAnim(cache.ped, "mp_masks@standard_car@ds@", "put_on_mask", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(600)
    ClearPedTasks(cache.ped)
    if commandClothing['helmets'] then 
        SetPedPropIndex(cache.ped, 0, commandClothing['helmets'].value1, commandClothing['helmets'].value2, 0)
    end
end)

-- Watches
RegisterCommand('w0', function()
    LoadAnimDict("nmt_3_rcm-10")
    TaskPlayAnim(cache.ped, "nmt_3_rcm-10", "cs_nigel_dual-10", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(600)
    ClearPedTasks(cache.ped)
    ClearPedProp(cache.ped, 6)
end)

RegisterCommand('w1', function()
    LoadAnimDict("nmt_3_rcm-10")
    TaskPlayAnim(cache.ped, "nmt_3_rcm-10", "cs_nigel_dual-10", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(600)
    ClearPedTasks(cache.ped)
    if commandClothing['watches'] then 
        SetPedPropIndex(cache.ped, 6, commandClothing['watches'].value1, commandClothing['watches'].value2, 0)
    end
end)

-- Glassess
RegisterCommand('g0', function()
    LoadAnimDict("clothingspecs")
    TaskPlayAnim(cache.ped, "clothingspecs", "take_off", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(600)
    ClearPedTasks(cache.ped)
    ClearPedProp(cache.ped, 1)
end)

RegisterCommand('g1', function()
    LoadAnimDict("clothingspecs")
    TaskPlayAnim(cache.ped, "clothingspecs", "take_off", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(600)
    ClearPedTasks(cache.ped)
    if commandClothing['glasses'] then 
        SetPedPropIndex(cache.ped, 1, commandClothing['glasses'].value1, commandClothing['glasses'].value2, 0)
    end
end)

-- Earrings
RegisterCommand('e0', function()
    LoadAnimDict('mp_cp_stolen_tut')
    TaskPlayAnim(cache.ped, 'mp_cp_stolen_tut', 'b_think', 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(600)
    ClearPedTasks(cache.ped)
    ClearPedProp(cache.ped, 2)
end)

RegisterCommand('e1', function()
    LoadAnimDict('mp_cp_stolen_tut')
    TaskPlayAnim(cache.ped, 'mp_cp_stolen_tut', 'b_think', 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(600)
    ClearPedTasks(cache.ped)
    if commandClothing['earrings'] then 
        SetPedPropIndex(cache.ped, 2, commandClothing['earrings'].value1, commandClothing['earrings'].value2, 0)
    end
end)

-- Masks
RegisterCommand('m0', function()
    LoadAnimDict('mp_masks@on_foot')
    TaskPlayAnim(cache.ped, 'mp_masks@on_foot', 'put_on_mask', 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(600)
    ClearPedTasks(cache.ped)
    SetPedComponentVariation(cache.ped, 1, -1, -1, 0)
end)

RegisterCommand('m1', function()
    LoadAnimDict('mp_masks@on_foot')
    TaskPlayAnim(cache.ped, 'mp_masks@on_foot', 'put_on_mask', 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(600)
    ClearPedTasks(cache.ped)
    if commandClothing['masks'] then 
        SetPedComponentVariation(cache.ped, 1, commandClothing['masks'].value1, commandClothing['masks'].value2, 0)
    end
end)

-- Vest
RegisterCommand('v0', function()
    LoadAnimDict('clothingtie')
    TaskPlayAnim(cache.ped, 'clothingtie', 'try_tie_positive_a', 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(600)
    ClearPedTasks(cache.ped)
    SetPedComponentVariation(cache.ped, 9, 0, 0, 0)
end)

RegisterCommand('v1', function()
    LoadAnimDict('clothingtie')
    TaskPlayAnim(cache.ped, 'clothingtie', 'try_tie_positive_a', 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(600)
    ClearPedTasks(cache.ped)
    if commandClothing['vests'] then 
        SetPedComponentVariation(cache.ped, 9, commandClothing['vests'].value1, commandClothing['vests'].value2, 0)
    end
end)

-- Bags
RegisterCommand('b0', function()
    LoadAnimDict('clothingtie')
    TaskPlayAnim(cache.ped, 'clothingtie', 'try_tie_positive_a', 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(600)
    ClearPedTasks(cache.ped) 
    SetPedComponentVariation(cache.ped, 5, 0, 0, 0)
end)

RegisterCommand('b1', function()
    LoadAnimDict('clothingtie')
    TaskPlayAnim(cache.ped, 'clothingtie', 'try_tie_positive_a', 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(600)
    ClearPedTasks(cache.ped) 
    if commandClothing['bags'] then 
        SetPedComponentVariation(cache.ped, 5, commandClothing['bags'].value1, commandClothing['bags'].value2, 0)
    end
end)

-- Chains
RegisterCommand('c0', function()
    LoadAnimDict('clothingtie')
    TaskPlayAnim(cache.ped, 'clothingtie', 'try_tie_positive_a', 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(600)
    ClearPedTasks(cache.ped) 
    SetPedComponentVariation(cache.ped, 7, 0, 0, 0)
end)

RegisterCommand('c1', function()
    LoadAnimDict('clothingtie')
    TaskPlayAnim(cache.ped, 'clothingtie', 'try_tie_positive_a', 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(600)
    ClearPedTasks(cache.ped)
    if commandClothing['chains'] then 
        SetPedComponentVariation(cache.ped, 7, commandClothing['chains'].value1, commandClothing['chains'].value2, 0)
    end
end)

-- Jacket
RegisterCommand('j0', function()
    LoadAnimDict('nmt_3_rcm-10')
    TaskPlayAnim(cache.ped, 'nmt_3_rcm-10', 'cs_nigel_dual-10', 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(600) 
    ClearPedTasks(cache.ped)
    SetPedComponentVariation(cache.ped, 11, 15, 0, 0)
end)

RegisterCommand('j1', function()
    LoadAnimDict('nmt_3_rcm-10')
    TaskPlayAnim(cache.ped, 'nmt_3_rcm-10', 'cs_nigel_dual-10', 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(600)
    ClearPedTasks(cache.ped)
    if commandClothing['jacket'] then 
        SetPedComponentVariation(cache.ped, 11, commandClothing['jacket'].value1, commandClothing['jacket'].value2, 0)
    end
end)

-- Undershirt
RegisterCommand('u0', function()
    LoadAnimDict('nmt_3_rcm-10')
    TaskPlayAnim(cache.ped, 'nmt_3_rcm-10', 'cs_nigel_dual-10', 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(600) 
    ClearPedTasks(cache.ped)
    SetPedComponentVariation(cache.ped, 3, 15, 0, 0)
end)

RegisterCommand('u1', function()
    LoadAnimDict('nmt_3_rcm-10')
    TaskPlayAnim(cache.ped, 'nmt_3_rcm-10', 'cs_nigel_dual-10', 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(600)
    ClearPedTasks(cache.ped)
    if commandClothing['undershirt'] then 
        SetPedComponentVariation(cache.ped, 3, commandClothing['undershirt'].value1, commandClothing['undershirt'].value2, 0)
    end
end)

-- Shoes
RegisterCommand('s0', function()
    LoadAnimDict('oddjobs@basejump@ig_15')
    TaskPlayAnim(cache.ped, 'oddjobs@basejump@ig_15', 'puton_parachute', 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 ) 
    Wait(600)
    ClearPedTasks(cache.ped)
    SetPedComponentVariation(cache.ped, 6, 5, 0, 0)
end)    

RegisterCommand('s1', function()
    LoadAnimDict('oddjobs@basejump@ig_15')
    TaskPlayAnim(cache.ped, 'oddjobs@basejump@ig_15', 'puton_parachute', 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 ) 
    Wait(600)
    ClearPedTasks(cache.ped)
    if commandClothing['shoes'] then 
        SetPedComponentVariation(cache.ped, 6, commandClothing['shoes'].value1, commandClothing['shoes'].value2, 0)
    end
end)

-- Pants
RegisterCommand('p0', function()
    LoadAnimDict('re@construction')
    TaskPlayAnim(cache.ped, 're@construction', 'out_of_breath', 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 ) 
    Wait(600)
    ClearPedTasks(cache.ped)
    SetPedComponentVariation(cache.ped, 4, 14, 0, 0)
end)

RegisterCommand('p1', function()
    LoadAnimDict('re@construction')
    TaskPlayAnim(cache.ped, 're@construction', 'out_of_breath', 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(600)
    ClearPedTasks(cache.ped)
    if commandClothing['pants'] then 
        SetPedComponentVariation(cache.ped, 4, commandClothing['pants'].value1, commandClothing['pants'].value2, 0)
    end
end)