Config = {}

Config.Settings = {
    -- # General Settings #
    ['LeaveCommand'] = 'leave', -- | The command any player will use when they want to leave the gungame.
    ['DoYouUseOxInventory'] = true, -- | If you are using ox_inventory, set this to true or people will not have access to lobby weapons!
    ['DatabaseLocation'] = 'data/kd.json', -- | Don't edit this side.
    ['StemWebAPIKey'] = '53B8A1BAAED1FC2E60CAED0E6AFFB2BD', -- | In this section you must specify your Steam Web API Key or the script will not work properly!
    ['GungameBucket'] = 9102, -- | In this section you can specify which bucket players will go to when they enter Gungame mode.
    ['DefaultBucket'] = 0, -- | In this section, specify the bucket that players will return to when they exit Gungame mode (this is usually 0 on every server)

    -- # NPC Settings #
    ['Model'] = 's_m_y_blackops_01', -- | You can specify the model of the NPC here (https://docs.fivem.net/docs/game-references/ped-models/)
    ['Coords'] = vector3(241.1918, -1378.8950, 32.7417), -- | You can specify NPC coords here.
    ['Heading'] = 142.5724, -- | You can specify NPC heading here.
    ['DrawText'] = 'E - Gungame Menu', -- | You can choose the text that will appear on the NPC here.
    ['InteractionKey'] = 38, -- | You can specify the key they will use to access the lobby here (https://docs.fivem.net/docs/game-references/controls/)

    -- # Menu Texts #
    ['MainText'] = 'FIVEX',
    ['SubText'] = 'GUNGAME',
    ['InfoBoxText'] = 'Information',
    ['InfoText'] = 'Her kan du joine gungame, og konkurrere mod andre folk.',
}