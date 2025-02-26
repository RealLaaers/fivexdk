RegisterNetEvent("ClothingMenu")
AddEventHandler("ClothingMenu", function()
    lib.registerContext({
        id = 'ClothingMenu',
        title = 'FiveX - PvP Menu',
        options = {
            {
                title = 'Clothing Menu',
                arrow = true,
                -- description = 'Få dig nyt tøj.',
                onSelect = function()
                    exports.clothing:OpenClothingMenu('', true)
                end,
            },
            {
                title = 'Tattoo Menu',
                arrow = true,
                -- description = 'Nye tattoos?!',
                onSelect = function()
                    exports.clothing:OpenTattoMenu()
                end,
            },
            {
                title = 'Skift køn',
                arrow = true,
                -- description = 'Her kan du skifte dit køn!',
                event = 'Skiftkon',
            },
            {
                title = 'Tilbage',
                arrow = false,
                icon  = 'backward',
                menu  = 'pvpmenu'
            },
        },
    })

    lib.showContext('ClothingMenu')
end)

RegisterNetEvent("Skiftkon")
AddEventHandler("Skiftkon", function()
    lib.registerContext({
        id = 'Skiftkon',
        title = 'FiveX - PvP Menu',
        options = {
            {
                title = 'Kvinde',
                onSelect = function()
                    TriggerEvent('skinchanger:loadSkin', {
                        sex          = 1,
                        torso_1      = 5,
                        torso_2      = 5,
                        pants_1      = 0,
                        pants_2      = 0,
                        bproof_1     = -1,
                        bproof_2     = 0,
                        bags_1       = -1,
                        bags_2       = 0,
                        arms         = 0,
                        mask_1       = -1,
                        mask_2       = 0,
                        tshirt_1     = 0,
                        shoes_1      = 0,
                        shoes_2      = 0,
                        helmet_1     = -1,
                        helmet_2     = 0,
                    })
                end,
            },
            {
                title = 'Mand',
                onSelect = function()
                    TriggerEvent('skinchanger:loadSkin', {
                        sex          = 0,
                        torso_1      = 5,
                        torso_2      = 5,
                        pants_1      = 0,
                        pants_2      = 0,
                        bproof_1     = -1,
                        bproof_2     = 0,
                        bags_1       = -1,
                        bags_2       = 0,
                        arms         = 0,
                        mask_1       = -1,
                        mask_2       = 0,
                        tshirt_1     = 0,
                        shoes_1      = 0,
                        shoes_2      = 0,
                        helmet_1     = -1,
                        helmet_2     = 0,
                    })
                end,
            },
            {
                title = 'Tilbage',
                arrow = false,
                icon  = 'backward',
                menu  = 'ClothingMenu'
            },
        },
    })

    lib.showContext('Skiftkon')
end)