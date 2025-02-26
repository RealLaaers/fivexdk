Config.fpsBoosterTypes = {
    [1] = { type = "ulow", name = "Ultra Lav", distance = { world = 90, ped = 60, vehicle = 120 }, alpha = { world = 210, ped = 245, vehicle = 255 } },
    [2] = { type = "low", name = "Lav", distance = { world = 130, ped = 100, vehicle = 160 }, alpha = { world = 210, ped = 250, vehicle = 255 } },
    [3] = { type = "medium", name = "Medium", distance = { world = 200, ped = 150, vehicle = 250 }, alpha = { world = 245, ped = 255, vehicle = 255 } }
}

Config.visualTimecycles = {
    [1] = { name = "Tunnel (FPS Boost)", modifier = "yell_tunnel_nodirect", icon = "💯" },
    [2] = { name = "Cinema (FPS Boost)", modifier = "cinema", icon = "🎥" },
    [3] = { name = "Life (FPS Boost)", modifier = "LifeInvaderLOD" },
    [4] = { name = "Reduce Distance (FPS Boost)", modifier = "ReduceDrawDistanceMission", icon = "⬇" },
    [5] = { name = "Color Saturation", modifier = "rply_saturation", icon = "✨" },
    [6] = { name = "Graphic Changer", modifier = "MP_Powerplay_blend", extraModifier = "reflection_correct_ambient" },
    [7] = { name = "Improved Lights", modifier = "tunnel" }
}

Config.vehicleLightsSetting = {
    defaultlight = {
        day = { name = "Default Lys (Dag)", defaultValue = 2, min = 0, max = 10000 },
        night = { name = "Default Lys (Nat)", defaultValue = 2, min = 0, max = 10000 }
    },
    headlight = {
        day = { name = "Forlygter (Dag)", defaultValue = 10, min = 0, max = 10000 },
        night = { name = "Forlygter (Nat)", defaultValue = 10, min = 0, max = 10000 }
    },
    taillight = {
        day = { name = "Baglygter (Dag)", defaultValue = 25, min = 0, max = 10000 },
        night = { name = "Baglygter (Nat)", defaultValue = 25, min = 0, max = 10000 }
    },
    indicator = {
        day = { name = "Blink lys (Dag)", defaultValue = 10, min = 0, max = 10000 },
        night = { name = "Blink lys (Nat)", defaultValue = 10, min = 0, max = 10000 }
    },
    reversinglight = {
        day = { name = "Baklygter (Dag)", defaultValue = 20, min = 0, max = 10000 },
        night = { name = "Baklygter (Nat)", defaultValue = 3, min = 0, max = 10000 }
    },
    brakelight = {
        day = { name = "Bremselygter (Dag)", defaultValue = 30, min = 0, max = 10000 },
        night = { name = "Bremselygter (Nat)", defaultValue = 30, min = 0, max = 10000 }
    },
    middlebrakelight = {
        day = { name = "Mellem bremselys (Dag)", defaultValue = 30, min = 0, max = 10000 },
        night = { name = "Mellem bremselys (Nat)", defaultValue = 30, min = 0, max = 10000 }
    },
    extralight = {
        day = { name = "Ekstra lys (Dag)", defaultValue = 9, min = 0, max = 10000 },
        night = { name = "Ekstra lys (Nat)", defaultValue = 9, min = 0, max = 10000 }
    }
}

TriggerEvent("chat:addSuggestion", "/"..Config.Command, "helps players to modify their visuals and fps")

RegisterCommand(Config.Command, function()
    if Config.Menu == "ox_lib" and lib then
        lib.showMenu(Config.mainMenu)
    elseif Config.Menu == "menuv" and MenuV then
        MenuV:OpenMenu(Config.mainMenu)
    end
end, false)