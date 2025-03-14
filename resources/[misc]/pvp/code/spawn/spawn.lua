npcs = {
    [1] = {
        model = 'u_m_m_streetart_01',
        coords = vec4(345.8690, -1433.4447, 75.1801, 320.9269), --deagle
        weapon = 'WEAPON_COMBATMG'
    },
    [2] = {
        model = 'u_m_m_streetart_01',
        coords = vec4(343.7380, -1431.6570, 75.1800, 320.5341), --duels
        weapon = 'WEAPON_COMBATMG'
    },
    [3] = {
        model = 'u_m_m_streetart_01',
        coords = vec4(334.4312, -1423.8473, 75.1773, 318.4997), --apzone
        weapon = 'WEAPON_COMBATMG'
    },

    [4] = {
        model = 'u_m_m_streetart_01',
        coords = vec4(341.2874, -1429.6003, 75.1802, 321.2586), --gungame
        weapon = 'WEAPON_COMBATMG'
    },
    [5] = {
        model = 'u_m_m_streetart_01',
        coords = vec4(336.7388, -1425.7313, 75.1784, 322.8246), --freemode
        weapon = 'WEAPON_COMBATMG'
    },
    [6] = {
        model = 'u_m_m_streetart_01',
        coords = vec4(332.1890, -1421.9659, 75.1762, 319.6414), --koth
        weapon = 'WEAPON_COMBATMG'
    },
    [7] = {
        model = 'u_m_m_streetart_01',
        coords = vec4(338.9183, -1427.5496, 75.1782, 320.5831), --aimlabs
        weapon = 'WEAPON_COMBATMG'
    },
    [8] = {
        model = 'u_m_m_streetart_01',
        coords = vec4(338.9183, -1427.5496, 75.1782, 320.5831), --pistol zone
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
            local ped = CreatePed("PED_TYPE_CIVMALE", GetHashKey('cs_fbisuit_01'), 345.8690, -1433.4447, 75.1801, 320.9269, false, false)
            SetBlockingOfNonTemporaryEvents(ped, true)
            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)
            Wait(250)
            local ped2 = CreatePed("PED_TYPE_CIVMALE", GetHashKey('cs_fbisuit_01'), 343.7380, -1431.6570, 75.1800, 320.5341, false, false)
            SetBlockingOfNonTemporaryEvents(ped2, true)
            FreezeEntityPosition(ped2, true)
            SetEntityInvincible(ped2, true)
            Wait(250)
            local ped3 = CreatePed("PED_TYPE_CIVMALE", GetHashKey('cs_fbisuit_01'), 341.2874, -1429.6003, 75.1802, 321.2586, false, false)
            SetBlockingOfNonTemporaryEvents(ped3, true)
            FreezeEntityPosition(ped3, true)
            SetEntityInvincible(ped3, true)

            Wait(250)
            local ped4 = CreatePed("PED_TYPE_CIVMALE", GetHashKey('cs_fbisuit_01'), 338.9183, -1427.5496, 75.1782, 320.5831, false, false)
            SetBlockingOfNonTemporaryEvents(ped4, true)
            FreezeEntityPosition(ped4, true)
            SetEntityInvincible(ped4, true)
            Wait(250)
            local ped5 = CreatePed("PED_TYPE_CIVMALE", GetHashKey('cs_fbisuit_01'), 336.7388, -1425.7313, 75.1784, 322.8246, false, false)
            SetBlockingOfNonTemporaryEvents(ped5, true)
            FreezeEntityPosition(ped5, true)
            SetEntityInvincible(ped5, true)
            Wait(250)
            local ped6 = CreatePed("PED_TYPE_CIVMALE", GetHashKey('cs_fbisuit_01'), 334.4312, -1423.8473, 75.1773, 318.4997, false, false)
            SetBlockingOfNonTemporaryEvents(ped6, true)
            FreezeEntityPosition(ped6, true)
            SetEntityInvincible(ped6, true)
            Wait(250)
            local ped7 = CreatePed("PED_TYPE_CIVMALE", GetHashKey('cs_fbisuit_01'), 332.1890, -1421.9659, 75.1762, 319.6414, false, false)
            SetBlockingOfNonTemporaryEvents(ped7, true)
            FreezeEntityPosition(ped7, true)
            SetEntityInvincible(ped7, true)
            Wait(250)
            local ped8 = CreatePed("PED_TYPE_CIVMALE", GetHashKey('cs_fbisuit_01'), 348.1687, -1435.2625, 75.1771, 319.9769, false, false)
            SetBlockingOfNonTemporaryEvents(ped8, true)
            FreezeEntityPosition(ped8, true)
            SetEntityInvincible(ped8, true)
            break
        end
    end
end)

exports.ox_target:addBoxZone({
    coords = vector3(348.1687, -1435.2625, 75.1771),
    size = vec3(0.8, 0.8, 4),
    rotation = 356.21,
    debug = false,
    options = {
        {
            name = "mainnpc",
            icon = "fas fa-bars",
            label = "Tilgå Pistol Zone",
            distance = 5.0,
            onSelect = function(data)
                ExecuteCommand('pistolzone')
            end
        },
    }
})

-- VENSTRE LYGTEPÆL
exports.ox_target:addBoxZone({
    coords = vector3(336.7388, -1425.7313, 75.1784),
    size = vec3(0.8, 0.8, 4),
    rotation = 356.21,
    debug = false,
    options = {
        {
            name = "mainnpc",
            icon = "fas fa-bars",
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
    coords = vector3(332.1890, -1421.9659, 75.1762),
    size = vec3(0.8, 0.8, 4),
    rotation = 356.21,
    debug = false,
    options = {
        {
            name = "mainnpc",
            icon = "fas fa-bars",
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
    coords = vector3(343.7380, -1431.6570, 75.1800),
    size = vec3(0.8, 0.8, 4),
    rotation = 356.21,
    debug = false,
    options = {
        {
            name = "mainnpc",
            icon = "fas fa-bars",
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
    coords = vector3(345.8690, -1433.4447, 75.1801),
    size = vec3(0.8, 0.8, 4),
    rotation = 356.21,
    debug = false,
    options = {
        {
            name = "mainnpc",
            icon = "fas fa-bars",
            label = "Tilgå Deagle Zone",
            distance = 5.0,
            onSelect = function(data)
                lib.callback('deaglezone:getPlayerCount', false, function(count)
                    local playerCount = count or 0
                lib.registerContext({
                    id = 'deaglezone',
                    title = 'FiveX - Deagle Zone',
                    options = {
                        {
                            title = 'Tilgå Deagle Zone',
                            description = 'Antal Spillere: '..playerCount,
                            onSelect = function(args)
                                TriggerServerEvent("PlayerLobby", 19061)
                                SetEntityCoords(PlayerPedId(), -3673.387, -3660.031, 345.665222)
                            end,
                        },
                        {
                            title = 'FIVEX | DEAGLE ZONE'
                        },
                    },
                })
                lib.showContext('deaglezone')
            end)
            end
        },
    }
})

--apzone
exports.ox_target:addBoxZone({
    coords = vector3(334.4312, -1423.8473, 75.1773),
    size = vec3(0.8, 0.8, 4),
    rotation = 356.21,
    debug = false,
    options = {
        {
            name = "mainnpc",
            icon = "fas fa-bars",
            label = "Tilgå AP Zone",
            distance = 5.0,
            onSelect = function(data)
                lib.callback('apzone:getPlayerCount', false, function(count)
                    local playerCount = count or 0
                lib.registerContext({
                    id = 'apzone',
                    title = 'FiveX - AP Zone',
                    options = {
                        {
                            title = 'Tilgå AP Zone',
                            description = 'Antal Spillere: '..playerCount,
                            onSelect = function(args)
                                TriggerServerEvent("PlayerLobby", 19059)
                                SetEntityCoords(PlayerPedId(), -3506.7473, 5753.8433, 658.2704)
                            end,
                        },
                        {
                            title = 'FIVEX | AP ZONE'
                        },
                    },
                })
                lib.showContext('apzone')
            end)
            end
        },
    }
})

-- HELT VENSTRE FRA MAIN
exports.ox_target:addBoxZone({
    coords = vector3(341.2874, -1429.6003, 75.1802),
    size = vec3(0.8, 0.8, 4),
    rotation = 356.21,
    debug = false,
    options = {
        {
            name = "secondnpc",
            icon = "fas fa-bars",
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
    coords = vector3(338.9183, -1427.5496, 75.1782),
    size = vec3(0.8, 0.8, 4),
    rotation = 359.75,
    debug = false,
    options = {
        {
            name = "secondndnpc",
            icon = "fas fa-bars",
            label = "Tilgå Aimlabs",
            distance = 5.0,
            onSelect = function(data)
                ExecuteCommand('aimlab')
            end
        },
    }
})