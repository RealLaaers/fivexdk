npcs = {
    [1] = {
        model = 'u_m_m_streetart_01',
        coords = vec4(345.8690, -1433.4447, 76.1801, 320.9269), --deagle
        weapon = 'WEAPON_COMBATMG'
    },
    [2] = {
        model = 'u_m_m_streetart_01',
        coords = vec4(362.0723, -1388.6591, 75.1742, 144.6969), --duels
        weapon = 'WEAPON_COMBATMG'
    },
    [3] = {
        model = 'u_m_m_streetart_01',
        coords = vec4(364.9033, -1391.0347, 75.1743, 146.7859), --apzone
        weapon = 'WEAPON_COMBATMG'
    },

    [4] = {
        model = 'u_m_m_streetart_01',
        coords = vec4(367.7090, -1393.4219, 75.1742, 146.1500), --gungame
        weapon = 'WEAPON_COMBATMG'
    },
    [5] = {
        model = 'u_m_m_streetart_01',
        coords = vec4(370.4860, -1395.8341, 75.1741, 145.0896), --freemode
        weapon = 'WEAPON_COMBATMG'
    },
    [6] = {
        model = 'u_m_m_streetart_01',
        coords = vec4(373.3584, -1398.2135, 75.1743, 138.1069), --koth
        weapon = 'WEAPON_COMBATMG'
    },
    [7] = {
        model = 'u_m_m_streetart_01',
        coords = vec4(376.2117, -1400.5640, 75.1743, 141.7576), --aimlabs
        weapon = 'WEAPON_COMBATMG'
    },
}

CreateThread(function()
    while true do
        Wait(2000)
        local IsPlayerLoaded = ESX.IsPlayerLoaded()
        if not IsPlayerLoaded then
        else
            Wait(250)
            while not HasModelLoaded(GetHashKey('cs_fbisuit_01')) do
                RequestModel(GetHashKey('cs_fbisuit_01'))
                Wait(200)
            end
           
            Wait(250)
            local ped = CreatePed("PED_TYPE_CIVMALE", GetHashKey('cs_fbisuit_01'), 345.8690, -1433.4447, 76.1801, 320.9269, false, false)
            SetBlockingOfNonTemporaryEvents(ped, true)
            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)
            Wait(250)
            local ped2 = CreatePed("PED_TYPE_CIVMALE", GetHashKey('cs_fbisuit_01'), 362.0723, -1388.6591, 75.1742, 144.6969, false, false)
            SetBlockingOfNonTemporaryEvents(ped2, true)
            FreezeEntityPosition(ped2, true)
            SetEntityInvincible(ped2, true)
            Wait(250)
            local ped3 = CreatePed("PED_TYPE_CIVMALE", GetHashKey('cs_fbisuit_01'), 364.9033, -1391.0347, 75.1743, 146.7859, false, false)
            SetBlockingOfNonTemporaryEvents(ped3, true)
            FreezeEntityPosition(ped3, true)
            SetEntityInvincible(ped3, true)

            Wait(250)
            local ped4 = CreatePed("PED_TYPE_CIVMALE", GetHashKey('cs_fbisuit_01'), 367.7090, -1393.4219, 75.1742, 146.1500, false, false)
            SetBlockingOfNonTemporaryEvents(ped4, true)
            FreezeEntityPosition(ped4, true)
            SetEntityInvincible(ped4, true)
            Wait(250)
            local ped5 = CreatePed("PED_TYPE_CIVMALE", GetHashKey('cs_fbisuit_01'), 370.4860, -1395.8341, 75.1741, 145.0896, false, false)
            SetBlockingOfNonTemporaryEvents(ped5, true)
            FreezeEntityPosition(ped5, true)
            SetEntityInvincible(ped5, true)
            Wait(250)
            local ped6 = CreatePed("PED_TYPE_CIVMALE", GetHashKey('cs_fbisuit_01'), 373.3584, -1398.2135, 75.1743, 138.1069, false, false)
            SetBlockingOfNonTemporaryEvents(ped6, true)
            FreezeEntityPosition(ped6, true)
            SetEntityInvincible(ped6, true)
            Wait(250)
            local ped7 = CreatePed("PED_TYPE_CIVMALE", GetHashKey('cs_fbisuit_01'), 376.2117, -1400.5640, 75.1743, 141.7576, false, false)
            SetBlockingOfNonTemporaryEvents(ped7, true)
            FreezeEntityPosition(ped7, true)
            SetEntityInvincible(ped7, true)
            break
        end
    end
end)

-- VENSTRE LYGTEPÆL
exports.ox_target:addBoxZone({
    coords = vector3(370.4860, -1395.8341, 75.1741),
    size = vec3(0.8, 0.8, 4),
    rotation = 356.21,
    debug = false,
    options = {
        {
            name = "mainnpc",
            icon = "fas fa-city",
            label = "Tilgå Freemode",
            distance = 5.0,
            onSelect = function(data)
                SetEntityCoords(PlayerPedId(), -415.0280, 1161.7389, 325.8594)
                SetEntityHeading(PlayerPedId(), 345.3987)
            end
        },
    }
})

-- MAIN NPC
exports.ox_target:addBoxZone({
    coords = vector3(373.3584, -1398.2135, 75.1743),
    size = vec3(0.8, 0.8, 4),
    rotation = 356.21,
    debug = false,
    options = {
        {
            name = "mainnpc",
            icon = "fas fa-city",
            label = "Tilgå King Of The Hill",
            distance = 5.0,
            onSelect = function(data)
                ExecuteCommand('koth')
            end
        },
    }
})

-- HØJRE FRA MAIN
exports.ox_target:addBoxZone({
    coords = vector3(362.0723, -1388.6591, 75.1742),
    size = vec3(0.8, 0.8, 4),
    rotation = 356.21,
    debug = false,
    options = {
        {
            name = "mainnpc",
            icon = "fas fa-city",
            label = "Tilgå Duels",
            distance = 5.0,
            onSelect = function(data)
                exports['fivex_duels']:toggleUI(true)
            end
        },
    }
})

-- VENSTRE FRA MAIN
exports.ox_target:addBoxZone({
    coords = vector3(345.8690, -1433.4447, 76.1801),
    size = vec3(0.8, 0.8, 4),
    rotation = 356.21,
    debug = false,
    options = {
        {
            name = "mainnpc",
            icon = "fas fa-city",
            label = "Tilgå Deagle Zone",
            distance = 5.0,
            onSelect = function(data)
                SetEntityCoords(PlayerPedId(), -3673.387, -3660.031, 345.665222)
            end
        },
    }
})

--apzone
exports.ox_target:addBoxZone({
    coords = vector3(364.9033, -1391.0347, 76.1743),
    size = vec3(0.8, 0.8, 4),
    rotation = 356.21,
    debug = false,
    options = {
        {
            name = "mainnpc",
            icon = "fas fa-city",
            label = "Tilgå AP Zone",
            distance = 5.0,
            onSelect = function(data)
                SetEntityCoords(PlayerPedId(), -3506.7473, 5753.8433, 658.2704)
            end
        },
    }
})

-- HELT VENSTRE FRA MAIN
exports.ox_target:addBoxZone({
    coords = vector3(367.7090, -1393.4219, 75.1742),
    size = vec3(0.8, 0.8, 4),
    rotation = 356.21,
    debug = false,
    options = {
        {
            name = "secondnpc",
            icon = "fas fa-city",
            label = "Tilgå Gungame",
            distance = 5.0,
            onSelect = function(data)
                ExecuteCommand('gungame')
            end
        },
    }
})

-- HELT HØJRE FRA MAIN
exports.ox_target:addBoxZone({
    coords = vector3(376.2117, -1400.5640, 75.1743),
    size = vec3(0.8, 0.8, 4),
    rotation = 359.75,
    debug = false,
    options = {
        {
            name = "secondndnpc",
            icon = "fas fa-city",
            label = "Tilgå Aimlabs",
            distance = 5.0,
            onSelect = function(data)
                ExecuteCommand('aimlab')
            end
        },
    }
})