Config = {
    -- [[ Frameworks Supported ]] --
    --[[
        qbcore - https://github.com/qbcore-framework
        esx - https://github.com/esx-framework/esx_core
        qbox - https://github.com/Qbox-project/qbx-core
        oxcore -
        standalone - 
    --]]
    framework = 'esx', -- Framework from above

    language = 'en', -- Language of the script

    debug = false, -- This just enables debug prints, if having issues with your script, enable this and then check the console and react out to me in the discord

    -- below is all of the settings for the UI of the clothing menu, if there is something you would like to change and it is not here let me know in the discord
    nui = {
        position = 'right', -- either left or right
        -- below is the different clothing menus, by setting them to false, this will make them disappear from the set menu DO NOT TOUCH THE NAMEING SUCH AS tattoo, hair etc
        menus = {
            createCharacter = {
                faceStructure =  true,
                faceFeatures =  true, 
                clothing =  true,
                props =  true,
                outfits =  true,
                peds = true,
                tattoos =  true,
                outfits = true,
            },
            clothing = {
                clothing = true,
                props = true,
                outfits = true, 
            },
            tattoo = true, -- enables or disables tattoos
            hair = true, -- enables or disables the barbers
            outfits = true, -- enables or disables the outfits
        },

        -- below is the categories in which you can fine tune your clothing menu to disable/enable the different components you want
        sections = {
            faceStructure = {
                parents = true,
                nose = true,
                eyebrow = true,
                cheek = true,
                eyes = true,
                lip = true,
                jaw = true,
                chin = true,
                neck = true,
            },
            hair = {
                hair = true, 
                beard = true,
                eyebrows = true,
                makeup = true,
                blemishes = true,
                age = true,
                blush = true,
                chest = true,
                lipstick = true,
                freckles = true,
                complextion = true,
                sundamage = true,
            },
            peds = {
                malePeds = false,
                femalePeds = false,
                gangMalePeds = false,
                gangFemalePeds = false,
                animalPeds = false,
                customPeds = false,
            },
            clothing = {
                undershirt = true,
                jacket = true,
                arms = true, 
                pants = true,
                shoes = true,
                masks = true,
                vests = true,
            },
            props = {
                chains = true,
                helmets = true,
                glasses = true,
                watches = true,
                bracelets = true,
                bags = true,
                decals = true,
                earrings = true,
            },
            tattoos = {
                headTattoos = true,
                chestTattoos = true,
                leftarmTattoos = true,
                rightarmTattoos = true,
                leftlegTattoos = true,
                rightlegTattoos = true,
            },
        },

        whenPedDisableUneededMenus = true, -- when they are a ped it will not show menus in which do not apply to them such as beard, eyebrows, certain props etc (features they cannot change)
    },

    randomiser = {
        enabled = true, -- if you want the randomiser to be enabled
        -- all the settings for the randomiser simply change the values to true or false depending on what you want to be randomised
        parents = true, 
        nose = true,
        eyebrow = true,
        cheek = true,
        eyes = true,
        lip = true,
        jaw = true,
        chin = true,
        neck = true,
        hair = true,
        beard = true,
        eyebrows = true,
        makeup = false,
        blemishes = false,
        age = false,
        blush = false,
        chest = false,
        lipstick = false,
        freckles = false,
        complextion = false,
        sundamage = false,
        generalFacialColour = true,
    },

    libText = {
        notfiyPoistion = 'center-left',
        textUIPosition = 'left-center',
    },

    payPerItemOfClothing = false, -- if you want them to pay per item of clothing, if false you pay just for the menu price below

    pricePerClothing = {
        undershirt = 0,
        jacket = 0,
        arms = 0,
        pants = 0,
        shoes = 0,
        masks = 0,
        vests = 0,
        chains = 0,
        helmets = 0,
        glasses = 0,
        watches = 0,
        bracelets = 0,
        bags = 0,
        decals = 0,
        earrings = 0,
    },

    priceForMenus = {
        clothing = 0,
        tattoo = 0,
        barber = 0,
        surgeon = 0,
        personal = 0,
    },

    removeClothing = {
        {name = 'undershirt', value1 = 15, value2 = 0, type = 'variation'},
        {name = 'jacket', value1 = 15, value2 = 0, type = 'variation'},
        {name = 'arms', value1 = 15, value2 = 0, type = 'variation'},
        {name = 'pants', value1 = 14, value2 = 0, type = 'variation'},
        {name = 'shoes', value1 = 5, value2 = 0, type = 'variation'},
        {name = 'masks', value1 = 0, value2 = 0, type = 'variation'},
        {name = 'vests', value1 = 0, value2 = 0, type = 'variation'},
        {name = 'chains', value1 = 0, value2 = 0, type = 'variation'},
        {name = 'helmets', value1 = -1, value2 = 0, type = 'prop'},
        {name = 'glasses', value1 = -1, value2 = 0, type = 'prop'},
        {name = 'watches', value1 = -1, value2 = 0, type = 'prop'},
        {name = 'bracelets', value1 = -1, value2 = 0, type = 'prop'},
        {name = 'bags', value1 = 0, value2 = 0, type = 'variation'},
        {name = 'decals', value1 = 0, value2 = 0, type = 'variation'},
        {name = 'earrings', value1 = -1, value2 = 0, type = 'prop'},
    },
    
    stores = {
        targetingType = 'interactionKey', -- there is 3 types here, 
        --[[ 
            interactionKey is where it is press E,
            target is where you use 3rd eye  
            radial is where you use a radial menu, 
        --]]
        radialMenu = 'ox_lib', -- resource name of the radial menu you are using from list below
        --[[ 
            qb-radialmenu,
            ox_lib,
            qbx-radialmenu,

            if you want to use your own radial menu, set this to the name of the resource and add the files depending to your framework
        --]]
        enablePedForTargeting = true, -- if you want a ped to spawn when you have the 3rd eye target enabled
    },

    blips = {
        ['clothing'] = {
            enabled = true,
            sprite = 73,
            color = 53,
            scale = 0.8,
            name = '[Service] Tøjbutik',
        },
        ['barber'] = {
            enabled = true,
            sprite = 71,
            color = 53,
            scale = 0.8,
            name = '[Service] Frisør',
        },
        ['tattoo'] = {
            enabled = true,
            sprite = 75,
            color = 53,
            scale = 0.8,
            name = '[Service] Tattovør',
        },
        ['surgeon'] = {
            enabled = true,
            sprite = 403,
            color = 53,
            scale = 0.8,
            name = '[Service] Plastikoperation',
        },
    },

    targets = {
        ['clothing'] = {
            model = 'u_f_m_casinoshop_01',
            scenario = 'WORLD_HUMAN_GUARD_STAND',
            icon = 'fas fa-tshirt',
            text = 'Clothing Store',
            distance = 3.0,
        },
        ['barber'] = {
            model = 's_m_m_hairdress_01',
            scenario = 'WORLD_HUMAN_GUARD_STAND',
            icon = 'fas fa-cut',
            text = 'Barber',
            distance = 3.0,
        },
        ['tattoo'] = {
            model = 's_m_y_ammucity_01',
            scenario = 'WORLD_HUMAN_GUARD_STAND',
            icon = 'fas fa-paint-brush',
            text = 'Tattoo',
            distance = 3.0,
        },
        ['surgeon'] = {
            model = 's_m_m_doctor_01',
            scenario = 'WORLD_HUMAN_GUARD_STAND',
            icon = 'fas fa-user-md',
            text = 'Surgeon',
            distance = 3.0,
        },
        ['personal'] = {
            model = 's_m_y_ammucity_01',
            scenario = 'WORLD_HUMAN_GUARD_STAND',
            icon = 'fas fa-tshirt',
            text = 'Player Outfits',
            distance = 3.0,
        }
    },

    setPedInOwnWorld = true, -- if you want the ped to be in their own world so they can see themselves in the menu with no one else around them - this is for create character

    defaultRoutingBucket = 0, -- if you have other routing buckets change this to the one you want them to be in when they are not in the menu (main one)

    genderBasedOnFramework = false, -- this is based on either the gender of the ped or the gender assigned to them on createCharacter

    coolDownTime = 5, -- time in seconds for the cooldown of commands such as reload skin

    saveDeletePopup = false, -- if you want a popup to show when they save or delete an outfit otherwise when you just click the icon it will automatically save or delete it

    defaultPayment = 'bank', -- if you want the default payment to be cash or bank, this is useful if you have the saveDeletePopup disabled

    dragMultiplier = 5, -- this is the multiplier for the drag of the ped when they are in the menu, if you want them to move faster or slower change this

    needToBeOnDutyForClothingRooms = false, -- if you want them to be on duty to use the clothing rooms

    outfitUseCost = 0, -- this is the price you can make them pay if they have just used an outfit (as soon as they change the clothes it then makes it go back to the normal pricing system)

    enableTakeoffCommands = true, -- if you want to enable the takeoff commands such as v0, v1, h0, h1, etc, feel free to edit all of these functions as it is escrow ignored

    disableLoosingPropsWhenPunched = true, -- if you want to disable the loosing of props when they are punched

    jobOutfits = {
        jobsAndRanks = {
            {name = 'police', rank = 4}, -- this is the label of your job and the grade in which you want your player to be able to access this menu
        }
    }
}
