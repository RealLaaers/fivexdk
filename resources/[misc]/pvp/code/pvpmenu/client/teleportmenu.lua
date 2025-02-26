arena1v1 = {
    {label = "1v1 Arena #1", value = "-3157.4883 -2905.7012 295.1186"},
    {label = "1v1 Arena #2", value = "-3207.0637 -2905.9277 295.1186"},
    {label = "1v1 Arena #3", value = "-3254.0073 -2905.4126 295.1185"},
    {label = "1v1 Arena #4", value = "-3298.3442 -2905.5242 295.1185"},
    {label = "1v1 Arena #5", value = "-3344.2161 -2905.5601 295.1185"},
}

arena2v2 = {
    {label = "2v2 Arena #1", value = "-3099.2637 -3114.0728 294.4144"},
    {label = "2v2 Arena #2", value = "-3177.4546 -3113.3547 294.4141"},
    {label = "2v2 Arena #3", value = "-3252.6477 -3113.6250 294.4144"},
    {label = "2v2 Arena #4", value = "-3332.0684 -3113.6423 294.4144"},
    {label = "2v2 Arena #5", value = "-3407.2236 -3113.8413 294.4139"},
}

stables = {
    {label = "Stables #1", value = "1496.2095 1154.5515 114.0368"},
}

rampsliste = {
    {label = "New ramp #1", value = "-3462.2290 -2279.6636 158.0511"},
    {label = "New ramp #2", value = "-3462.2090 -2345.6982 158.0510"},
    {label = "New ramp #3", value = "-3460.2395 -2411.5535 158.0509"},
    {label = "New ramp #4", value = "-3460.7271 -2477.4321 158.0573"},
    {label = "New ramp #5", value = "-3460.5667 -2544.1140 158.0545"},
}

steder = {
    {label = "Spawn", value = "343.5642 -1421.0951 76.1741"},
    {label = "Midy by tag", value = "102.8390 -869.6198 137.9539"},
    {label = "Vinewood Bank", value = "229.1999 214.0836 105.5449"},
    {label = "Sandy Shores", value = "1816.4718 3654.9141 34.1542"},
}

airport = {
    {label = "AP Hanger", value = "-1079.7357 -3368.5059 14.1472"},
    {label = "AP Bleachers", value = "-987.6711 -3389.2659 14.7720"},
    {label = "AP Box", value = "-953.3285 -3548.3096 14.1278"},
    {label = "AP Mid", value = "-1006.5573 -3475.4749 14.0175"},
    {label = "AP Gas", value = "-1094.0786 -3485.2441 14.5786"},
    {label = "AP Lonely", value = "-961.3617 -3280.9314 14.3124"},
}

ramps = {
    {label = "Ramps #1", value = "3878.1128 -1916.7925 41.6563"},
    {label = "Ramps #2", value = "3851.8022 -2024.5048 41.9900"},
    {label = "Ramps #3", value = "3751.5959 -2008.5005 41.6563"},
    {label = "Ramps #4", value = "3748.6167 -2118.6665 41.6568"},
    {label = "Ramps #5", value = "3815.0552 -2104.8291 41.6586"},
    {label = "Ramps #6", value = "3880.9656 -2190.2673 41.6563"},
    {label = "Ramps #7", value = "-958.6534 -779.4011 17.8361"},
}

function chicken(input)

    local x, y, z = string.match(input, "([^%s]+)%s+([^%s]+)%s+([^%s]+)")

    x, y, z = tonumber(x), tonumber(y), tonumber(z)

    -- print(x)
    -- print(y)
    -- print(z)

    if x and y and z then
        SetEntityCoords(PlayerPedId(), x, y, z, true, true, false, false)
    else
        lib.notify({
            title = 'FiveX',
            description = 'Fejl',
            type = 'error'
        })
    end
end

RegisterNetEvent("arenalist")
AddEventHandler("arenalist", function()
    local input = lib.inputDialog('Vælg TP Lokation', {
        {type = 'select', label = '', options = arena1v1, required = true},
    })

    if not input then return end

    chicken(input[1])
end)

RegisterNetEvent("arenalist2")
AddEventHandler("arenalist2", function()
    local input = lib.inputDialog('Vælg TP Lokation', {
        {type = 'select', label = '', options = arena2v2, required = true},
    })

    if not input then return end

    chicken(input[1])
end)

RegisterNetEvent("stables")
AddEventHandler("stables", function()
    local input = lib.inputDialog('Vælg TP Lokation', {
        {type = 'select', label = '', options = stables, required = true},
    })

    if not input then return end

    chicken(input[1])
end)

RegisterNetEvent("rampsliste")
AddEventHandler("rampsliste", function()
    local input = lib.inputDialog('Vælg TP Lokation', {
        {type = 'select', label = '', options = rampsliste, required = true},
    })

    if not input then return end

    chicken(input[1])
end)

RegisterNetEvent("steder")
AddEventHandler("steder", function()
    local input = lib.inputDialog('Vælg TP Lokation', {
        {type = 'select', label = '', options = steder, required = true},
    })

    if not input then return end

    chicken(input[1])
end)

RegisterNetEvent("airport")
AddEventHandler("airport", function()
    local input = lib.inputDialog('Vælg TP Lokation', {
        {type = 'select', label = '', options = airport, required = true},
    })

    if not input then return end

    chicken(input[1])
end)

RegisterNetEvent("ramps")
AddEventHandler("ramps", function()
    local input = lib.inputDialog('Vælg TP Lokation', {
        {type = 'select', label = '', options = ramps, required = true},
    })

    if not input then return end

    chicken(input[1])
end)



RegisterNetEvent("teleportmenu")
AddEventHandler("teleportmenu", function()
    lib.registerContext({
        id = 'teleportmenu',
        title = 'FiveX - PvP Menu',
        options = {
            -- {
            --     title = '1V1 ARENAS',
            --     arrow = true,
            --     event = 'arenalist',
            --     icon = 'chart-area',
            --     description = 'Liste over 1v1 arenas.',
            -- },
            -- {
            --     title = '2V2 ARENAS',
            --     arrow = true,
            --     event = 'arenalist2',
            --     icon = 'chart-area',
            --     description = 'Liste over 2v2 arenas.',
            -- },
            {
                title = 'Stables',
                arrow = true,
                event = 'stables',
                icon = 'horse-head',
                -- description = 'Liste over stables.',
            },
            -- {
            --     title = 'NEW RAMP',
            --     arrow = true,
            --     event = 'rampsliste',
            --     description = 'Liste over nogle nye ramper.',
            -- },
            -- {
            --     title = 'RAMPS',
            --     arrow = true,
            --     event = 'ramps',
            --     description = 'Liste over nogle ramps.',
            -- },
            {
                title = 'AIRPORT',
                arrow = true,
                event = 'airport',
                icon = 'plane-departure',
                -- description = 'Liste over ramper.',
            },
            {
                title = 'STEDER',
                arrow = true,
                event = 'steder',
                icon = 'globe',
                -- description = 'Liste over nogle steder på mapet',
            },
            {
                title = 'Tilbage',
                arrow = false,
                icon  = 'backward',
                menu  = 'pvpmenu'
            },
        },
    })

    lib.showContext('teleportmenu')
end)
