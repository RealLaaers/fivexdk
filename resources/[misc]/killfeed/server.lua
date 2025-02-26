ESX = exports["es_extended"]:getSharedObject()

local pedCache = {}
local eventLog = {}
local groups = Config.Groups
local lobbies = Config.Lobbies

-- local function getDiscordRoleColor(source)
--     local playerRoles = exports['Badger_Discord_API']:GetDiscordRoles(source)

--     local roleOrder = {
--         "1294438015032102995"   -- medlem
--     }
--     for _, priorityRole in ipairs(roleOrder) do

--         for _, playerRole in pairs(playerRoles) do

--             if tostring(playerRole) == priorityRole then
--                 return Config.RoleColors[priorityRole]
--             end
--         end
--     end
--     return nil
-- end

local names = {
    human = {
        male = {
            "James", "John", "Robert", "Michael", "William", "David", "Richard", "Joseph", "Thomas", "Charles", "Christopher", "Daniel", "Matthew", "Anthony", "Donald", "Mark", "Paul", "Steven", 
            "Andrew", "Kenneth", "Joshua", "Kevin", "Brian", "George", "Edward", "Ronald", "Timothy", "Jason", "Jeffrey", "Ryan", "Jacob", "Gary", "Nicholas", "Eric", "Jonathan", "Stephen", 
            "Larry", "Justin", "Scott", "Brandon", "Benjamin", "Samuel", "Frank", "Gregory", "Raymond", "Alexander", "Patrick", "Jack", "Dennis", "Jerry", "Tyler", "Aaron", "Henry", "Adam", 
            "Douglas", "Nathan", "Peter", "Zachary", "Kyle","Walter", "Harold", "Jeremy", "Ethan", "Carl", "Keith", "Roger", "Gerald", "Christian", "Terry", "Sean", "Arthur", "Austin", "Noah", 
            "Lawrence", "Jesse", "Joe", "Bryan", "Billy","Jordan", "Albert", "Dylan", "Bruce", "Willie", "Gabriel", "Alan", "Juan", "Logan", "Wayne", "Ralph", "Roy", "Randy", "Vincent", 
            "Russell", "Louis", "Philip", "Bobby", "Johnny", "Bradley", "Leon", "Lucas"
        },
        female = {
            "Mary", "Patricia", "Jennifer", "Linda", "Elizabeth", "Barbara", "Susan", "Jessica", "Sarah", "Karen", "Nancy", "Lisa", "Margaret", "Betty", "Sandra", "Ashley", "Dorothy", "Kimberly", "Emily",
            "Donna", "Michelle", "Carol", "Amanda", "Melissa", "Deborah", "Stephanie", "Rebecca", "Laura", "Sharon", "Cynthia", "Kathleen", "Amy", "Shirley", "Angela", "Helen", "Anna", "Brenda", "Pamela", 
            "Nicole", "Samantha", "Katherine", "Emma", "Ruth", "Christine", "Catherine", "Debra", "Rachel", "Carolyn", "Janet", "Virginia", "Maria", "Heather", "Diane", "Julie", "Joyce", "Victoria", "Kelly", 
            "Christina", "Lauren", "Joan", "Evelyn", "Olivia", "Judith", "Megan", "Cheryl", "Martha", "Andrea", "Frances", "Hannah", "Jacqueline", "Ann", "Gloria", "Jean", "Kathryn", "Alice", "Teresa", "Sara", 
            "Janice", "Doris", "Madison", "Julia", "Grace", "Judy", "Abigail", "Marie", "Denise", "Beverly", "Amber", "Theresa", "Marilyn", "Danielle", "Diana", "Brittany", "Natalie", "Sophia", "Rose", 
            "Isabella", "Alexis", "Kayla", "Charlotte"
        }
    },
    animal = {
        cat = {
            "Luna", "Milo", "Oliver", "Leo", "Loki", "Bella", "Charlie", "Willow", "Lucy", "Simba",
            "Lily", "Nala", "Kitty", "Max", "Jack", "Ollie", "Jasper", "Chadwick", "Taylor", "Tom"
        },
        cormorant = {
            "Pterodactylus", "Greenie", "Chaffie", "Lolly", "Chiffy", "Goldie", "Shortie", "Buzzy", "Reggie", "Eider"
        },
        cow = {
            "Bessie", "Brownie", "Buttercup", "Clarabelle", "Dottie", "Guinness", "Magic", "Nellie", "Penelope", "Penny", 
            "Rosie", "Snowflake", "Sprinkles", "Sugar", "Annabelle", "Bella", "Betty", "Betsie", "Bossy", "Daisy"
        },
        coyote = {
            "Jerry", "Jamul", "Yoda", "Tembi", "Ivory", "Apollo", "Cunawabi", "Billy", "Bobby", "Emma",
            "Iris", "Onyx", "Buddy", "Tilly", "Rex", "Suri", "Tequila", "Tokyo", "Noah", "Nova"
        },
        crow = {
            "Jon Snow", "Ravenclaw", "Darth Vader", "Watchman", "Crow Foot", "Russel Crowe", "Marty McFly", "Tweety", "Chick Jagger", "Chandler Wing",
            "Flappers", "Cheep", "Wing Crosby", "Paulie", "Feather Fawcett", "Luna", "Flight", "Stephen", "Charlotte", "Ruppet"
        },
        dog = {
            "Luna", "Milo", "Oliver", "Bear", "Loki", "Bella", "Charlie", "Cooper", "Lucy", "Max",
            "Lily", "Nala", "Kitty", "Max", "Jack", "Ollie", "Jasper", "Jax", "Penny", "Winston"
        },
        deer = { 
            "Abie", "Bambi", "Beauty", "Blessed", "Bucky", "Buttercup", "Cainy", "Faith", "Freckles", "Gabriella", 
            "Goodeness", "Goodiva", "Goody", "Gracie", "Hope", "Hurricane", "Isabella", "Ivan", "Stormy", "Wendy"
        },
        dolphin = {
            "Star", "Chirp", "Clicker", "Fin", "Cuddly", "Happy", "Lazy", "Bubbles", "Kisser", "Jumper", 
            "Jumpy", "Trickster", "Hops", "Hopster", "Agape", "Flipper", "Snorky", "Alpha", "Beta", "Snowflake"
        },
        fish = {
            "Magikarp", "Sushi", "Nemo", "Delta", "Bait", "Neptune", "Atlantis", "Captain Jack", "Pacific", "Speedy",
            "Bob", "Fin", "Flounder", "Walleye", "Finn", "Oswald", "Ollie", "Flash", "Rex", "Salty"
        },
        hawk = {
            "Dudley", "Icarus", "Ristretto", "Maloney", "Chicory", "Timor", "Marlon", "Skyler", "Griffin", "Adelaide", 
            "Lucy", "Cob", "Molly", "Mischief", "Zippo", "Tasha", "Dusty", "Sal", "Lou", "Tattoo"
        },
        hen = {
            "Albert Eggstein", "Big Bird", "Big Red", "Peri-Peri", "Eggs Benny", "Marshmallow", "Fluffy", "Molly", "Miss Daisy", "Snowball",
            "Bradley Coop-er", "Hen Solo", "Cluck Vader", "Princess Lay-a", "Jaba", "Hilary Fluff", "Meggatron", "Fowler", "Beaker", "Henny Penny"
        },
        humpback = {
            "Alpha", "Gamma", "Gunther", "Bruce", "Sergeant", "Gatsby", "Orlando", "Razor", "Lord", "Draco",
            "Zero", "Ralph", "King", "Zoro", "Silver", "Dragon", "Indigo", "Carlos", "Jackson", "Thaddeus"
        },
        killerwhale = {
            "Luna", "Springer", "Tilikum", "Ikaiki", "Ulises", "Tahlequah", "Granny", "Keiko", "Old Tom", "Lolita", 
            "Moby Dhick", "Willy", "Namu", "Roxanne", "Tilly", "Winter", "Samson", "Iceberg", "Papa Whale", "Ariel"
        },
        mtlion = { 
            "King", "Slim", "Fluffy", "Pudge", "Blimpy", "Butterball", "Achilles", "Chunk", "Chubbles", "Big Foot", 
            "Giant", "Thumbelina", "Tundra", "Quarterback", "Chubby", "Fatma", "President", "Lord", "Fridge", "Speck"
        },
        panther = {
            "Darth", "Alfie", "Hunter", "Zara", "Salem", "Amy", "Halloween", "Phantom", "Annie", "Mr. Black", 
            "Maya", "Damian", "Andy", "Freda", "Dante", "Kuro", "Hades", "Inky", "Mystery", "Yuka"
        },
        pig = {
            "Ace", "Aero", "Alexander", "Amy Swinehouse", "Anastacia", "Apollo", "Arabella", "Archie", "Arlo", "Atlas",
            "Babe", "Bacon", "Bartholomew", "Bella", "Benjamina", "Bloedworst", "Boerewors", "Bratwurst", "Bristle", "Buddy"
        },
        pigeon = {
            "Fred", "Chirpie", "Candy", "Florence", "Polly", "Sunny", "Auzzie", "Chip", "Jazzy", "Jonas", 
            "Frankie", "Cherry", "Orlando", "Plato", "Odin", "Peachy", "Roxy", "Isabelle", "Wilbur", "Stella"
        },
        rabbit = {
            "Thumper", "Oreo", "Bun", "Bunn", "Coco", "Cocoa", "Daisy", "Bunny", "Cinnabun", "Snowball",
            "Buggs", "Marshmallow", "Midnight", "Thunderbunny", "Peppy Hare", "Oswald", "Jupiter", "Mars", "Neptune", "Artemis"
        },
        rat = {
            "Piper", "Reggie", "Flint", "Churro", "Wasabi", "Sushi", "Cheddar", "Benny", "Einstein", "Pascale", 
            "Hugs", "Scarlet", "Dove", "Bella", "Hazel", "Chutney", "Mina", "Autumn", "Pip", "Fawn"
        },
        rhesus = {
            "Chucky", "George", "Bing", "Charlie", "Congo", "Leo", "Cedric", "Bear", "Milo", "Monty", 
            "Jared", "Hunky", "Caesar", "Max", "Albert", "Steve", "Chester", "Hector", "Banana", "Bubbles"
        },
        seagull = {
            "Aqua", "Prickles", "Spring", "Jerry", "Munchkin", "Sue", "Gail", "Ivory", "Pickle", "Apricot", 
            "Sasha", "Cupcake", "Josh", "Maddie", "Peachy", "Quirky", "Katie", "Bill", "Vanilla", "Tiny", "Nimble"
        },
        shark = {
            "Fuzzy", "Sugar", "Hairless", "Greyskin", "Sandy", "Tommy", "Ashleigh", "Umber", "Lawrence", "Fishy", 
            "Hutch", "Werner", "Macy", "Peri", "Starsky", "Anakin", "Marge", "Cindy", "Jimbo", "Pamela"
        },
        stingray = {
            "Stripe", "Manta Ray", "Manta", "Batfish", "Ray", "Shark Ray", "Devilfish", "Sting Ray", "Parting",  "Parsnip", 
            "Whipray", "Skat", "Skate", "Ramp", "Stingaree", "Gail", "Spring", "Wasabi", "Sushi", "Flint"
        }
    }
}

local animalTypes = {
    [1462895032] = "cat", -- a_c_cat_01
    [1457690978] = "cormorant", -- a_c_cormorant
    [-50684386] = "cow", -- a_c_cow
    [1682622302] = "coyote", -- a_c_coyote
    [402729631] = "crow", -- a_c_crow
    [351016938] = "dog", -- a_c_chop
    [-1788665315] = "dog", -- a_c_rottweiler
    [1318032802] = "dog", -- a_c_husky
    [882848737] = "dog", -- a_c_retriever
    [1126154828] = "dog", -- a_c_shepherd
    [-1384627013] = "dog", -- a_c_westy
    [1125994524] = "dog", -- a_c_poodle
    [1832265812] = "dog", -- a_c_pug
    [-664053099] = "deer", -- a_c_deer
    [-1950698411] = "dolphin", -- a_c_dolphin
    [802685111] = "fish", -- a_c_fish
    [-1430839454] = "hawk", -- a_c_chickenhawk
    [1794449327] = "hen", -- a_c_hen
    [1193010354] = "humpback", -- a_c_humpback
    [-1920284487] = "killerwhale", -- a_c_killerwhale
    [307287994] = "mtlion", -- a_c_mtlion
    [-417505688] = "panther", -- a_c_panther
    [-832573324] = "pig", -- a_c_boar
    [-1323586730] = "pig", -- a_c_pig
    [111281960] = "pigeon", -- a_c_pigeon
    [-541762431] = "rabbit", -- a_c_rabbit_01
    [-1011537562] = "rat", -- a_c_rat
    [-1026527405] = "rhesus", -- a_c_rhesus
    [-745300483] = "seagull", -- a_c_seagull
    [1015224100] = "shark", -- a_c_sharkhammer
    [113504370] = "shark", -- a_c_sharktiger
    [-1589092019] = "stingray" -- a_c_stingray
}

local animalSuffixes = {
    ['cat'] = " the Cat",
    ['cormorant'] = " the Cormorant",
    ['cow'] = " the Cow",
    ['coyote'] = " the Coyote",
    ['crow'] = " the Crow",
    ['dog'] = " the Dog",
    ['deer'] = " the Deer",
    ['dolphin'] = " the Dolphin",
    ['fish'] = " the Fish",
    ['hawk'] = " the Hawk",
    ['hen'] = " the Hen",
    ['humpback'] = " the Humpback",
    ['killerwhale'] = " the Killerwhale",
    ['mtlion'] = " the Mountain Lion",
    ['panther'] = " the Panther",
    ['pig'] = " the Pig",
    ['pigeon'] = " the Pigeon",
    ['rabbit'] = " the Rabbit",
    ['rat'] = " the Rat",
    ['rhesus'] = " the Rhesus",
    ['seagull'] = " the Seagull",
    ['shark'] = " the Shark",
    ['stingray'] = " the Stingray"
}


-- Functions --
-- If you want to display character or nick names etc. you could integrate it here.
local function GetPlayerNameByServerId(playerId)
    return GetPlayerName(playerId)
end

local function GetAnimalType(ped)
    local model = GetEntityModel(ped)
    return animalTypes[model]
end

local function GetRandomName(ped, pedType, gender)
    if pedType == "animal" then
        local animalType = GetAnimalType(ped)
        local index = math.random(1, #names.animal[animalType])
        local name = names.animal[animalType][index]

        if Config.AddAnimalSuffix then
		    name = name..animalSuffixes[animalType]
        end

        if Config.AddAnimalPrefix then
            name = Config.AnimalPrefix..name
        end

        return name
    end

    if Config.UseEasterEggs then
        local easterEgg = math.random(1, 1000)
        if easterEgg == 69 then
            local index = math.random(1, #Config.EasterEggs)
            local name = Config.EasterEggs[index]

            if Config.AddAIPrefix then
                name = Config.AIPrefix..name
            end

            return name
        end
    end

    local index = math.random(1, #names[pedType][gender])
    local name = names[pedType][gender][index]
    
    if Config.AddAIPrefix then
        name = Config.AIPrefix..name
    end

    return name
end

local function AsyncRemoveCachedName(id)
    CreateThread(function()
        Wait(10000)
        pedCache[id] = nil
    end)
end

-- Exports --
-- Groupes
local function CreateGroup(name, attributes)
    if name then
        groups[name] = { members = {} }
        if attributes then
            for attribute, value in pairs(attributes) do
                groups[name][attribute] = value
            end
        end
        return groups[name]
    end
    return nil
end

local function DeleteGroup(name)
    groups[name] = nil
    return true
end

local function DoesGroupExist(name)
    if groups[name] then
        return true
    end
    return false
end

local function AddPlayerToGroup(playerId, name)
    if groups[name] then
        groups[name].members[playerId] = true
        return true
    end
    return false
end

local function RemovePlayerFromGroup(playerId, group)
    if playerId and groups[group] then
        groups[group].members[playerId] = nil
        return true
    end
    return false
end

local function GetPlayerGroup(playerId)
    for group, data in pairs(groups) do
        if data.members[playerId] then
            return group
        end
    end
    return nil
end

local function IsPlayerInGroup(playerId, group)
    if playerId and groups[group] then
        if groups[group].members[playerId] then
            return true
        end
    end
    return false
end

local function SetGroupAttribute(name, attribute, value)
    groups[name][attribute] = value
end

local function GetGroupAttribute(name, attribute)
    return groups[name][attribute]
end
 
-- Lobbies
local function CreateLobby(name, attributes)
    if name then
        lobbies[name] = { members = {} }
        if attributes then
            for attribute, value in pairs(attributes) do
                lobbies[name][attribute] = value
            end
        end
        return lobbies[name]
    end
    return nil
end

local function DeleteLobby(name)
    lobbies[name] = nil
    return true
end

local function DoesLobbyExist(name)
    if lobbies[name] then
        return true
    end
    return false
end

local function AddPlayerToLobby(playerId, name)
    if lobbies[name] then
        lobbies[name].members[playerId] = true
        return true
    end
    return false
end

local function RemovePlayerFromLobby(playerId, name)
    if playerId and name then
        lobbies[name].members[playerId] = nil
        return true
    end
    return false
end

local function GetPlayerLobby(playerId)
    for name, data in pairs(lobbies) do
        if data.members[playerId] then
            return name
        end
    end
    return nil
end

local function SetLobbyAttribute(name, attribute, value)
    lobbies[name][attribute] = value
end

local function GetLobbyAttribute(name, attribute)
    return lobbies[name][attribute]
end

local function AddGroupToLobby(lobby, group)
    if lobbies[lobby] and groups[group] then
        for playerId, _boolean in pairs(groups[group].members) do
            lobbies[lobby].members[playerId] = true
        end
        return true
    end
    return false
end

local function RemoveGroupFromLobby(lobby, group)
    if lobbies[lobby] and groups[group] then
        for playerId, _boolean in pairs(lobbies[lobby].members) do
            if IsPlayerInGroup(playerId, group) then
                lobbies[lobby].members[playerId] = nil
            end
        end
        return true
    end
    return false
end

-- Declare Exports --
-- Groups
exports("CreateGroup", CreateGroup)
exports("DeleteGroup", DeleteGroup)
exports("DoesGroupExist", DoesGroupExist)
exports("AddPlayerToGroup", AddPlayerToGroup)
exports("RemovePlayerFromGroup", RemovePlayerFromGroup)
exports("GetPlayerGroup", GetPlayerGroup)
exports("IsPlayerInGroup", IsPlayerInGroup)
exports("SetGroupAttribute", SetGroupAttribute)
exports("GetGroupAttribute", GetGroupAttribute)

-- Lobbies
exports("CreateLobby", CreateLobby)
exports("DeleteLobby", DeleteLobby)
exports("DoesLobbyExist", DoesLobbyExist)
exports("AddPlayerToLobby", AddPlayerToLobby)
exports("RemovePlayerFromLobby", RemovePlayerFromLobby)
exports("GetPlayerLobby", GetPlayerLobby)
exports("SetLobbyAttribute", SetLobbyAttribute)
exports("GetLobbyAttribute", GetLobbyAttribute)
exports("AddGroupToLobby", AddGroupToLobby)
exports("RemoveGroupFromLobby", RemoveGroupFromLobby)


-- Event --
RegisterNetEvent('killfeed:sendToKillFeed')
AddEventHandler('killfeed:sendToKillFeed', function(killer, victim, image, noScoped, headshot, driveBy, showDist)
    local killerEntity = nil
    local victimEntity = nil

    if killer.netId ~= 0 then
        if not pedCache[killer.netId] then
            if killer.type == "player" then
                killer.name = GetPlayerNameByServerId(killer.sourceId)
                -- local roleColor = getDiscordRoleColor(killer.sourceId)
                -- killer.hasRole = roleColor ~= nil
                -- killer.roleColor = roleColor
                if Config.UseGroups then
                    local playerGroup = GetPlayerGroup(killer.sourceId)
                    if playerGroup then
                        killer.group = {}
                        killer.group.tag = GetGroupAttribute(playerGroup, "tag")
                        killer.group.tagColour = GetGroupAttribute(playerGroup, "tagColour")
                        killer.group.colour = GetGroupAttribute(playerGroup, "colour")
                    end
                end
            elseif killer.type == "npc" then
                killerEntity = NetworkGetEntityFromNetworkId(killer.netId)
                if Config.UseRandomAINames then
                    killer.name = GetRandomName(killerEntity, killer.pedType, killer.gender)
                else
                    killer.name = killerEntity
                end
                pedCache[killer.netId] = killer.name
            end
        else
            killer.name = pedCache[killer.netId]
            if killer.type == "player" and Config.UseGroups then
                local playerGroup = GetPlayerGroup(killer.sourceId)
                if playerGroup then
                    killer.group = {}
                    killer.group.tag = GetGroupAttribute(playerGroup, "tag")
                    killer.group.tagColour = GetGroupAttribute(playerGroup, "tagColour")
                    killer.group.colour = GetGroupAttribute(playerGroup, "colour")
                end
            end
        end

        if showDist then
            if killerEntity == nil then
                killerEntity = NetworkGetEntityFromNetworkId(killer.netId)
            end
            victimEntity = NetworkGetEntityFromNetworkId(victim.netId)
            showDist = #(GetEntityCoords(killerEntity) - GetEntityCoords(victimEntity))
            if Config.KillDistanceUnit == "feet" then
                showDist = math.floor((showDist * 3.2808399) + 0.5).." ft"
            else
                showDist = math.floor(showDist + 0.5).." m"
            end
        end
    else
        killer.name = nil
    end

    if not pedCache[victim.netId] then
        if victim.type == "player" then
            victim.name = GetPlayerNameByServerId(victim.sourceId)
            -- local roleColor = getDiscordRoleColor(victim.sourceId)
            -- victim.hasRole = roleColor ~= nil
            -- victim.roleColor = roleColor
            if Config.UseGroups then
                local playerGroup = GetPlayerGroup(victim.sourceId)
                if playerGroup then
                    victim.group = {}
                    victim.group.tag = GetGroupAttribute(playerGroup, "tag")
                    victim.group.tagColour = GetGroupAttribute(playerGroup, "tagColour")
                    victim.group.colour = GetGroupAttribute(playerGroup, "colour")
                end
            end
        elseif victim.type == "npc" then
            victimEntity = NetworkGetEntityFromNetworkId(victim.netId)
            if Config.UseRandomAINames then
                victim.name = GetRandomName(victimEntity, victim.pedType, victim.gender)
            else
                victim.name = victimEntity
            end
            pedCache[victim.netId] = victim.name
            AsyncRemoveCachedName(victim.netId)
        end
    else
        victim.name = pedCache[victim.netId]
        if victim.type == "player" and Config.UseGroups then
            local playerGroup = GetPlayerGroup(victim.sourceId)
            if playerGroup then
                victim.group = {}
                victim.group.tag = GetGroupAttribute(playerGroup, "tag")
                victim.group.tagColour = GetGroupAttribute(playerGroup, "tagColour")
                victim.group.colour = GetGroupAttribute(playerGroup, "colour")
            end
        end
    end

    local players = {}
    if Config.UseLobbies then
        local lobby = GetPlayerLobby(killer.sourceId)
        if lobby then
            for playerId, _state in pairs(lobbies[lobby].members) do
                players[#players+1] = playerId
            end
        else
            print("^1Error: Player with id: ", killer.sourceId, " had no assigned lobby!^0")
            return
        end
    else
        local playerList = GetPlayers()
        for index, playerId in pairs(playerList) do
            players[index] = tonumber(playerId)
        end
    end

    if Config.Proximity or Config.UsePermissions then
        local receivers = {}

        if Config.Proximity then
            if victimEntity == nil then
                victimEntity = NetworkGetEntityFromNetworkId(victim.netId)
            end
            local vCoords = GetEntityCoords(victimEntity)

            for _index, playerId in pairs(players) do
                local dist = #(vCoords - GetEntityCoords(GetPlayerPed(playerId)))
                if dist < Config.ProximityRange then
                    receivers[playerId] = playerId
                end
            end

            if killer.type == "player" and not receivers[killer.sourceId] then
                receivers[killer.sourceId] = killer.sourceId
            end
        end

        if Config.UsePermissions then
            for _index, playerId in pairs(players) do
                if IsPlayerAceAllowed(playerId, 'killfeed.display') then
                    receivers[playerId] = playerId
                elseif receivers[playerId] then
                    receivers[playerId] = nil
                end
            end
        end

        for _index, playerId in pairs(receivers) do
            TriggerClientEvent('killfeed:recivePlayerKillFeed', playerId, killer, victim, image, noScoped, headshot, driveBy, showDist)
        end
    elseif Config.UseLobbies then
        for _index, playerId in pairs(players) do
            TriggerClientEvent('killfeed:recivePlayerKillFeed', playerId, killer, victim, image, noScoped, headshot, driveBy, showDist)
        end
    else
        TriggerClientEvent('killfeed:recivePlayerKillFeed', -1, killer, victim, image, noScoped, headshot, driveBy, showDist)
    end

    -- Crew-integration: Udløs crew-events for kills og deaths
    if killer.type == "player" then
        TriggerEvent('crews:addKillForPlayer', killer.sourceId)
    end
    if victim.type == "player" then
        TriggerEvent('crews:addDeathForPlayer', victim.sourceId)
    end
end)

if Config.DisplayJoinLeave then
    -- Joining
    AddEventHandler('playerJoining', function()
        TriggerClientEvent('killfeed:joinLeave', -1, "join_"..source, GetPlayerNameByServerId(source), 'Joined')
    end)

    -- Disconnected
    AddEventHandler('playerDropped', function(reason)
        TriggerClientEvent('killfeed:joinLeave', -1, "leave_"..source, GetPlayerNameByServerId(source), reason)
    end)
end
