Config = {}


-- Config.RoleColors = {
--     ["1294438015032102995"] = { -- member
--         r = 255,
--         g = 255,
--         b = 255
--     }
-- }

Config.ShowTime = 5000 -- Time in milliseconds on how long the line should show in the killfeed before disappearing
Config.MaxLines = 5 -- The maximum number of lines the killfeed can show at any given time

Config.DisplayHeadshots = true -- Whether or not to show the headshot icon when someone was headshotted
Config.DisplayNoScopes = true -- Whether or not to show the noscope icon when someone was not no-scoped
Config.DisplayDriveByIcons = false -- Whether or not to show the driveby icons, sadly it only works 90% ish of the time

-- These are the default victim/killer colours (rgb)
Config.KillerColour = {
    Player = { r = 255, g = 255, b = 255 },
    NPC = { r = 255, g = 255, b = 255 },
}
Config.VictimColour = {
    Player = { r = 255, g = 255, b = 255 },
    NPC = { r = 219, g = 66, b = 66 },
}

Config.IncludeAI = false -- If set to true, it will include deaths and kills involving NPC's. If this is set to false and a player gets killed by an NPC it just shows the death without a killer.
Config.AddAIPrefix = false
Config.AIPrefix = "NPC "
Config.UseRandomAINames = false -- If this is set to false it will use the entity id. (example: 184578)

Config.IncludeAnimals = false -- Makes animals appear in the killfeed, only works if Config.IncludeAI is set to true
Config.AddAnimalPrefix = false
Config.AnimalPrefix = "[Animal] "
Config.AddAnimalSuffix = true -- example: Nilo the Dog, "the Dog" beeing the suffix

Config.Proximity = true -- Whether or not to use proximity checks (aka only show kills close by).
Config.ProximityRange = 200.0 -- The max distance in meters the player can be from the victim and it displaying the kill. 424 meters is the max extent of the default client scope/culling in onesync

Config.ShowKillDistance = 2 -- 0/false = don't show at all, 1 = show for weapons with the showDist option set to true (by default only snipers), 2 = show distance on every kill
Config.KillDistanceUnit = "meters" -- "meters" or "feet"
Config.KillDistanceColour = { r = 255, g = 255, b = 255 }

-- Whether or not to use ace permissions. When setting the permissions you should set the 'killfeed.display' ace to allow. If the Config.Proximity is set to true, then this will allow those with permissions to see all kills while regular players only see kills within the proximity range.
-- Example: `add_ace admin "killfeed.display" allow` in server.cfg or permissions.cfg or `ExecuteCommand('add_ace admin killfeed.display allow')` in a script that can change permissions (both without the ``)
Config.UsePermissions = false

-- Easter eggs names, they can only appear on NPCs such as when you kill an animal or pedestrian.
Config.UseEasterEggs = false
Config.EasterEggs = { "blattersturm", "nihonium", "Disquse", "gottfriedleibniz", "PichotM", "LWSS", "Hellslicer", "TomGrobbe", "NCG", "Mads" } -- These are some of the top contributors to the fivem project on github (+ 2 others), you can replace them with your own if you desire.

-- Whether or not to add a command for the client to toggle the killfeed on/off
Config.ToggleCommand = true

Config.UseGroups = false
Config.Groups = {

}

-- Read the documentation on how to utilize lobbies
Config.UseLobbies = false
Config.Lobbies = {

}
