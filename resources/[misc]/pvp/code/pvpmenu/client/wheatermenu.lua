RegisterNetEvent("wheatermenu")
AddEventHandler("wheatermenu", function()
    lib.registerContext({
        id = 'wheatermenu',
        title = 'FiveX - Vejrmenu',
        menu  = 'justeringer',
        options = {
            {
                title = 'Clear - Normalt',
                arrow = true,
                icon = 'cloud',
                event = 'wheatermenulolniggerniggerfuckdigbissefuckingniggerjeghadernegerlolhahahahahahhaha',
                args = {wheater = "CLEAR"}
            },
            {
                title = 'Halloween',
                arrow = true,
                icon = 'cloud',
                event = 'wheatermenulolniggerniggerfuckdigbissefuckingniggerjeghadernegerlolhahahahahahhaha',
                args = {wheater = "HALLOWEEN"}
            },
            {
                title = 'Extra Sunny',
                arrow = true,
                icon = 'cloud',
                event = 'wheatermenulolniggerniggerfuckdigbissefuckingniggerjeghadernegerlolhahahahahahhaha',
                args = {wheater = "EXTRASUNNY"}
            },
            {
                title = 'Neutral',
                arrow = true,
                icon = 'cloud',
                event = 'wheatermenulolniggerniggerfuckdigbissefuckingniggerjeghadernegerlolhahahahahahhaha',
                args = {wheater = "NEUTRAL"}
            },
            {
                title = 'Smog',
                arrow = true,
                icon = 'cloud',
                event = 'wheatermenulolniggerniggerfuckdigbissefuckingniggerjeghadernegerlolhahahahahahhaha',
                args = {wheater = "SMOG"}
            },
            {
                title = 'Foggy',
                arrow = true,
                icon = 'cloud',
                event = 'wheatermenulolniggerniggerfuckdigbissefuckingniggerjeghadernegerlolhahahahahahhaha',
                args = {wheater = "FOGGY"}
            },
            {
                title = 'Overcast',
                arrow = true,
                icon = 'cloud',
                event = 'wheatermenulolniggerniggerfuckdigbissefuckingniggerjeghadernegerlolhahahahahahhaha',
                args = {wheater = "OVERCAST"}
            },
            {
                title = 'Clouds',
                arrow = true,
                icon = 'cloud',
                event = 'wheatermenulolniggerniggerfuckdigbissefuckingniggerjeghadernegerlolhahahahahahhaha',
                args = {wheater = "CLOUDS"}
            },
            {
                title = 'Clearing',
                arrow = true,
                icon = 'cloud',
                event = 'wheatermenulolniggerniggerfuckdigbissefuckingniggerjeghadernegerlolhahahahahahhaha',
                args = {wheater = "CLEARING"}
            },
            {
                title = 'Rain',
                arrow = true,
                icon = 'cloud',
                event = 'wheatermenulolniggerniggerfuckdigbissefuckingniggerjeghadernegerlolhahahahahahhaha',
                args = {wheater = "RAIN"}
            },
            {
                title = 'Thunder',
                arrow = true,
                icon = 'cloud',
                event = 'wheatermenulolniggerniggerfuckdigbissefuckingniggerjeghadernegerlolhahahahahahhaha',
                args = {wheater = "THUNDER"}
            },
            {
                title = 'Snow',
                arrow = true,
                icon = 'cloud',
                event = 'wheatermenulolniggerniggerfuckdigbissefuckingniggerjeghadernegerlolhahahahahahhaha',
                args = {wheater = "SNOW"}
            },
            {
                title = 'Blizzard',
                arrow = true,
                icon = 'cloud',
                event = 'wheatermenulolniggerniggerfuckdigbissefuckingniggerjeghadernegerlolhahahahahahhaha',
                args = {wheater = "BLIZZARD"}
            },
            {
                title = 'Light Snow',
                arrow = true,
                icon = 'cloud',
                event = 'wheatermenulolniggerniggerfuckdigbissefuckingniggerjeghadernegerlolhahahahahahhaha',
                args = {wheater = "SNOWLIGHT"}
            },
            {
                title = 'Heavy Snow (XMAS)',
                arrow = true,
                icon = 'cloud',
                event = 'wheatermenulolniggerniggerfuckdigbissefuckingniggerjeghadernegerlolhahahahahahhaha',
                args = {wheater = "XMAS"}
            },
        },
    })

    lib.showContext('wheatermenu')
end)

AddEventHandler('wheatermenulolniggerniggerfuckdigbissefuckingniggerjeghadernegerlolhahahahahahhaha', function(args)
    ClearOverrideWeather()
    ClearWeatherTypePersist()
    SetWeatherTypePersist(args.wheater)
    SetWeatherTypeNow(args.wheater)
    SetWeatherTypeNowPersist(args.wheater)
end)