Config = {}

Config.MinATMReward = 40000
Config.MaxATMReward = 55000

Config.MinTankReward = 50000
Config.MaxTankReward = 65000

Config.ATMProps = {
    `prop_atm_01`,
    `prop_atm_02`,
    `prop_atm_03`,
    `prop_fleeca_atm`
}

-- top -399.2390, 1213.4858, 325.8941, 270.6457
-- bunden -1025.4124, -3574.2959, 1.2639, 270.6463



Config.Minutes = function(minutes) return minutes * 60 end
Config.Hours = function(hours) return hours * (60 * 60) end
Config.Days = function(days) return days * (24 * (60 * 60)) end

Config.ATMGAME = {
    [1] = {
        name = "Legion Square",
        jobs = {'police'},
        y_min = vector3(-1025.4124, -3574.2959, 1.2639), -- bunden
        y_max = vector3(-399.2390, 1213.4858, 325.8941), -- top
        min_cops = 2,
        min_reward = 10000,
        max_reward = 25000,
        coldown = Config.Hours(0),
        minigames = {
            totalNumbers = 20,
            seconds = 40,
            timesToChangeNumbers = 5,
            amountOfGames = 2,
            incrementByAmount = 0,
        }
    },
    [2] = {
        name = "Sandy Shores",
        jobs = {'police'},
        y_min = vector3(-399.2390, 1213.4858, 325.8941), 
        y_max = vector3(530.1495, 5523.7100, 770.8278),
        min_cops = 2,
        min_reward = 10000,
        max_reward = 25000,
        coldown = Config.Hours(0),
        minigames = {
            totalNumbers = 20,
            seconds = 40,
            timesToChangeNumbers = 5,
            amountOfGames = 3,
            incrementByAmount = 0,
        }
    },
    [3] = {
        name = "Paleto",
        jobs = {'police'},
        y_min = vector3(530.1495, 5523.7100, 770.8278), 
        y_max = vector3(26.0999, 7634.9502, 14.6369),
        min_cops = 2,
        min_reward = 10000,
        max_reward = 25000,
        coldown = Config.Hours(0),
        minigames = {
            totalNumbers = 20,
            seconds = 40,
            timesToChangeNumbers = 5,
            amountOfGames = 4,
            incrementByAmount = 0,
        }
    },
}

Config.TankGame = {
    [1] = {
        name = "Legion Square",
        jobs = {'police'},
        y_min = vector3(-1025.4124, -3574.2959, 1.2639), -- bunden
        y_max = vector3(-399.2390, 1213.4858, 325.8941), -- top
        min_cops = 4,
        min_reward = 50000,
        max_reward = 65000,
        coldown = Config.Hours(1),
        minigames = {
            totalNumbers = 25,
            seconds = 60,
            timesToChangeNumbers = 5,
            amountOfGames = 2,
            incrementByAmount = 0,
        }
    },
    [2] = {
        name = "Sandy Shores",
        jobs = {'police'},
        y_min = vector3(-399.2390, 1213.4858, 325.8941), 
        y_max = vector3(530.1495, 5523.7100, 770.8278),
        min_cops = 4,
        min_reward = 50000,
        max_reward = 65000,
        coldown = Config.Hours(1),
        minigames = {
            totalNumbers = 25,
            seconds = 60,
            timesToChangeNumbers = 5,
            amountOfGames = 3,
            incrementByAmount = 0,
        }
    },
    [3] = {
        name = "Paleto",
        jobs = {'police'},
        y_min = vector3(530.1495, 5523.7100, 770.8278), 
        y_max = vector3(26.0999, 7634.9502, 14.6369),
        min_cops = 4,
        min_reward = 50000,
        max_reward = 65000,
        coldown = Config.Hours(1),
        minigames = {
            totalNumbers = 25,
            seconds = 60,
            timesToChangeNumbers = 5,
            amountOfGames = 4,
            incrementByAmount = 0,
        }
    },
    -- totalNumbers = 25,
    -- seconds = 60,
    -- timesToChangeNumbers = 5,
    -- amountOfGames = 1,
    -- incrementByAmount = 5,
}

Config.TimeToRobTank = 15

Config.SafeLocations = {
    vec3(28.1588, -1338.7192, 28.8068),   -- Innocence Blvd
    vec3(-3048.2958, 585.4102, 7.2009),   -- Inseno Road
    vec3(-3250.5161, 1004.4418, 12.1558), -- Barbareno Road
    vec3(1734.9835, 6421.3173, 34.3080),  -- Great Ocean Highway
    vec3(1708.1695, 4920.8208, 41.3514),  -- Grape Seed Main Street
    vec3(1959.0202, 3749.3291, 31.6847),  -- Alhambra Drive
    vec3(546.5106, 2662.3266, 41.5089),   -- Route 68
    vec3(2672.3398, 3286.8269, 54.6214),  -- Senora Freeway
    vec3(2548.7395, 384.8841, 107.9211),  -- Palomino Freeway
    vec3(378.2658, 333.8557, 102.9076),   -- Clinton Avenue
    vec3(-1829.5384, 798.4634, 137.5601), -- North Rockford Drive
    vec3(-43.8009, -1748.0804, 28.7776),  -- Grove Street
    vec3(-710.1920, -904.1401, 18.5740),  -- Ginger Street
    vec3(1159.0540, -314.1202, 68.5665)   -- Mirror Park Blvd
}


Config.MinContacts = 20
Config.MaxContacts = 3000
Config.DivideContacts = 30

Config.MinSec = 20
Config.MaxSec = 40

Config.Amounts = {
    MaxAtOnce = 200000
}

Config.NPC = {
    Coords = vector4(94.9724, -1562.4291, 29.6075, 10.1191),
}

Config.Lager = {
    KeyPrice = 500000,
    Amount = 100000000,
    Entrance = vector4(1141.1602, -1622.4794, 35.4203, 2.9946),
    Exit = vector4(1138.1173, -3199.1936, -39.6657, 0.4),
}

Config.Data = {
    Procent = {
        { amount = 100000000, percent = 0.80 },
        { amount = 50000000, percent = 0.75 },
        { amount = 10000000, percent = 0.73 },
        { amount = 5000000, percent = 0.70 },
        { amount = 1000000, percent = 0.65 },
        { amount = 0, percent = 0.60 },
    },
    Time = {
        { kontakter = 2000, time = 30 },
        { kontakter = 1000, time = 40 },
        { kontakter = 500, time = 50 },
        { kontakter = 100, time = 60 }    
    },
}


Config.Models = {
    'a_m_m_afriamer_01',
    'u_m_m_aldinapoli',
    's_m_y_ammucity_01',
    's_m_m_ammucountry',
    'u_m_y_antonb',
    'csb_anton',
    'g_m_m_armboss_01',
    'g_m_m_armgoon_01',
    'g_m_y_armgoon_02',
    'g_m_m_armlieut_01',
    'ig_ashley',
    'cs_ashley',
    's_m_y_autopsy_01',
    's_m_m_autoshop_01',
    's_m_m_autoshop_02',
    'ig_money',
    'csb_money',
    'g_m_y_azteca_01',
    'u_m_y_babyd',
    'g_m_y_ballaeast_01',
    'g_m_y_ballaorig_01',
    'g_f_y_ballas_01',
    'ig_ballasog',
    'csb_ballasog',
    'g_m_y_ballasout_01',
    's_m_y_barman_01',
    's_f_y_bartender_01',
    'u_m_y_baygor',
    's_f_y_baywatch_01',
    's_m_y_baywatch_01',
    'a_f_m_beach_01',
    'a_f_y_beach_01',
    'a_m_m_beach_01',
    'a_m_o_beach_01',
    'a_m_y_beach_01',
    'a_m_m_beach_02',
    'a_m_y_beach_02',
    'a_m_y_beach_03',
    'a_m_y_beachvesp_01',
    'a_m_y_beachvesp_02',
    'ig_benny',
    'ig_beverly',
    'cs_beverly',
    'a_f_m_bevhills_01',
    'a_f_y_bevhills_01',
    'a_m_m_bevhills_01',
    'a_m_y_bevhills_01',
    'a_f_m_bevhills_02',
    'a_f_y_bevhills_02',
    'a_m_m_bevhills_02',
    'a_m_y_bevhills_02',
    'a_f_y_bevhills_03',
    'a_f_y_bevhills_04',
    'u_m_m_bikehire_01',
    'u_f_y_bikerchic',
    'a_m_y_breakdance_01',
    'u_m_y_burgerdrug_01',
    'csb_burgerdrug',
    's_m_y_busboy_01',
    'u_m_m_rivalpap',
    'a_m_y_roadcyc_01',
    's_m_y_robber_01',
    'ig_roccopelosi',
    'csb_roccopelosi',
    'a_f_y_runner_01',
    'a_m_y_runner_01',
    'a_m_y_runner_02',
    'a_f_y_rurmeth_01',
    'a_m_m_rurmeth_01',
    'ig_russiandrunk',
    'cs_russiandrunk',
    'a_f_m_salton_01',
    'a_f_o_salton_01',
    'a_m_m_salton_01',
    'a_m_o_salton_01',
    'a_m_y_salton_01',
    'a_m_m_salton_02',
    'a_m_m_salton_03',
    'a_m_m_salton_04',
    'g_m_y_salvaboss_01',
    'g_m_y_salvagoon_01',
    'g_m_y_salvagoon_02',
    'g_m_y_salvagoon_03',
    'a_m_y_vinewood_04',
}

Config.Locations = {
    vec4(130.2, -1274.99, 28.24, 0.0),
    vec4(162.11, -1268.32, 28.24, 160.62),
    vec4(161.79, -1286.42, 28.23, 110.34),
    vec4(339.17, -1263.60, 30.96, 74.82),
    vec4(306.83, -1246.18, 28.57, 08.58),
    vec4(343.40, -1190.28, 28.31, 164.21),
    vec4(109.19, -1804.54, 25.50, 179.38),
    vec4(524.42, -1831.14, 27.28, 249.49),
    vec4(959.98, -2373.81, 29.50, 0.0),
    vec4(1062.27, -2408.46, 28.97, 92.5),
    vec4(1140.85, -2332.80, 30.34, 166),
    vec4(1126.36, -2096.35, 30.08, 278.05),
    vec4(990.39, -1791.78, 30.63, 181.86),
    vec4(1010.55, -1778.92, 30.42, 83.75),
    vec4(977.90, -1708.98, 29.09, 87.52),
    vec4(990.39, -1660.08, 28.44, 0.0),
    vec4(980.86, -1383.56, 30.54, 29.47),
    vec4(935.19, -1520.58, 30.06, 0.0),
    vec4(925.84, -1483.28, 29.11, 50.98),
    vec4(886.78, -1516.57, 29.18, 223.01),
    vec4(886.59, -1584.52, 29.95, 261.39),
    vec4(536.46, -1650.18, 28.26, 259.47),
    vec4(491.19, -1705.30, 28.35, 325.47),
    vec4(353.25, -1850.11, 26.71, 217.45),
    vec4(201.78, -2002.96, 17.86, 234),
    vec4(-592.01, -1767.25, 22.18, 235.15),
    vec4(-1110.98, -1046.5, 1.153, 214.28),
    vec4(1064.63, -2407.89, 28.98, 106.59),
    vec4(1078.87, -2443.25, 28.44, 89.69),
    vec4(953.97, -2529.31, 27.30, 171.31),
    vec4(402.26, -2188.63, 4.917, 243.06),
    vec4(-353.99, -1490.89, 29.26, 142.04),
    vec4(-312.45, -1342.49, 30.32, 42.24),
    vec4(-342.67, -899.03, 30.07, 210.86),
    vec4(-317.44, -772.25, 32.96, 28.59),
    vec4(-241.84, -785.30, 29.45, 71.82),
    vec4(-203.62, -758.88, 29.45, 196.89),
    vec4(-222.69, -641.03, 32.39, 142),
    vec4(66.48, -266.27, 47.18, 214.91),
    vec4(117.78, -265.57, 45.33, 114.95),
    vec4(133.96, -258.22, 45.33, 118.89),
    vec4(169.79, -279.18, 49.27, 297.43),
    vec4(475.16, -105.43, 62.15, 190.25),
    vec4(741.29, 140.41, 79.76, 188.99),
    vec4(777.54, 210.96, 82.64, 158.28),
    vec4(955.28, -194.77, 72.20, 229.43),
    vec4(960.85, -210.85, 72.21, 37.49),
    vec4(974.39, -192.00, 72.20, 37.49),
    vec4(966.46, -203.89, 75.25, 249.08),
    vec4(955.76, -195.02, 78.29, 143.23),
    vec4(791.53, -102.66, 81.03, 335.53),
    vec4(820.06, -124.38, 79.22, 296.63),
    vec4(501.94, -612.38, 23.75, 280.33),
    vec4(460.75, -698.17, 26.42, 41.48),
    vec4(367.92, -776.74, 28.26, 95.15),
    vec4(378.51, -900.16, 28.41, 197.58),
    vec4(-3.72, -1086.34, 25.67, 65.54),
    vec4(-17.60, -1037.06, 27.90, 0.0),
    vec4(45.53, -1011.18, 28.52, 109.67),
    vec4(2.23, -1024.41, 27.96, 103.56),
    vec4(-771.69, -1028.13, 13.13, 254.41),
    vec4(-661.76, -710.01, 25.89, 193.05),
    vec4(-617.15, -683.27, 35.23, 222.4),
    vec4(-584.07, -698.28, 30.23, 176.97),
    vec4(-577.70, -676.53, 35.28, 125.32),
    vec4(-592.16, -751.90, 35.28, 4.41),
    vec4(-594.46, -748.81, 28.48, 225.83),
    vec4(-574.89, -800.02, 29.68, 40.03),
    vec4(-590.54, -797.30, 25.04, 223.14),
    vec4(-1000.58, -945.72, 1.15, 160.51),
    vec4(-1055.29, -971.06, 1.00, 198.95),
    vec4(-1072.79, -988.20, 1.15, 249.84),
    vec4(-1044.78, -1168.74, 1.15, 302.46),
    vec4(-1083.22, -1140.00, 1.15, 250.54),
    vec4(-1122.34, -1237.42, 2.17, 295.03),
    vec4(-1112.39, -1258.41, 5.65, 65.14)
}


Config.DrugsSearch = {
    'mushroom',
    'weed_pooch',
    'weed_packaged',
    'coke_pooch',
    'coke_packaged',
    'opium_pooch',
    'opium_packaged',
    'meth_pooch',
    'kq_meth_low',
    'kq_meth_mid',
    'kq_meth_high',
    'meth_packaged',
    'bananakush_joint',
    'bluedream_joint',
    'purplehaze_joint',
}

Config.Money = "black_money"
Config.Animations = {
    Decline = {
        dict = 'anim@heists@ornate_bank@chat_manager',
        anim = 'fail',
        blendInSpeed = 2.0,
        blendOtSpeed = -8,
        time = -1,
        flag = 0,
        extra = 0
    },

    Calling = {
        dict = 'cellphone@',
        anim = 'cellphone_call_listen_base',
        prop = `prop_npc_phone`,
        blendInSpeed = 2.0,
        blendOtSpeed = -8,
        time = -1,
        flag = 0,
        extra = 0
    },

    Selling = {
        dict = 'mp_common',
        anim = 'givetake2_a',
        pedObject = `prop_paper_bag_small`,
        npcObject = `prop_anim_cash_pile_01`,
        blendInSpeed = 2.0,
        blendOtSpeed = 2.0,
        time = -1,
        flag = 0,
        extra = 0
    }
}
Config.SpecialDrugs = {
    ['AIRP'] = { "coke_pooch", "coke_packaged" },
    ['LOSPUER'] = { "coke_pooch", "coke_packaged" },
    ['STAD'] = { "coke_pooch", "coke_packaged" },
    ['BURTON'] = { "coke_pooch", "coke_packaged" },
    ['DELBE'] = { "coke_pooch", "coke_packaged" },
    ['DELPE'] = { "coke_pooch", "coke_packaged" },
    ['MORN'] = { "coke_pooch", "coke_packaged" },
    ['RICHM'] = { "coke_pooch", "coke_packaged" },
    ['ROCKF'] = { "purplehaze_joint", "coke_packaged" },
    ['GOLF'] = { "coke_pooch", "coke_packaged" },
    ['MOVIE'] = { "coke_pooch", "coke_packaged" },
    ['PBLUFF'] = { "purplehaze_joint", "coke_packaged" },
    ['WVINE'] = { "coke_pooch", "coke_packaged" },
    ['CHIL'] = { "coke_pooch", "coke_packaged" },
    ['SANDAND'] = { "coke_pooch", "coke_packaged" },
    ['BANNING'] = { "opium_pooch", "opium_packaged" },
    ['ELYSIAN'] = { "opium_pooch", "opium_packaged" },
    ['TERMINA'] = { "opium_pooch", "opium_packaged" },
    ['CHAMH'] = { "opium_pooch", "opium_packaged" },
    ['DAVIS'] = { "purplehaze_joint", "opium_packaged" },
    ['RANCHO'] = { "opium_pooch", "opium_packaged" },
    ['PALHIGH'] = { "opium_pooch", "opium_packaged" },
    ['CYPRE'] = { "opium_pooch", "opium_packaged" },
    ['LMESA'] = { "coke_pooch", "coke_packaged" },
    ['EBURO'] = { "opium_pooch", "opium_packaged" },
    ['STRAW'] = { "opium_pooch", "opium_packaged" },
    ['PBOX'] = { "opium_pooch", "opium_packaged" },
    ['TEXTI'] = { "opium_pooch", "opium_packaged" },
    ['SKID'] = { "opium_pooch", "opium_packaged" },
    ['DOWNT'] = { "opium_pooch", "opium_packaged" },
    ['KOREAT'] = { "opium_pooch", "opium_packaged" },
    ['LEGSQU'] = { "opium_pooch", "opium_packaged" },
    ['DELSOL'] = { "purplehaze_joint", "opium_packaged" },
    ['VCANA'] = { "opium_pooch", "opium_packaged" },
    ['BEACH'] = { "coke_pooch", "coke_packaged" },
    ['VESP'] = { "coke_pooch", "coke_packaged" },
    ['HORS'] = { "meth_pooch", "meth_packaged" },
    ['EAST_V'] = { "meth_pooch", "meth_packaged" },
    ['MIRR'] = { "meth_pooch", "meth_packaged" },
    ['DTVINE'] = { "meth_pooch", "meth_packaged" },
    ['ALTA'] = { "meth_pooch", "meth_packaged" },
    ['HAWICK'] = { "meth_pooch", "meth_packaged" },
    ['VINE'] = { "meth_pooch", "meth_packaged" },
    ['MURRI'] = { "meth_pooch", "meth_packaged" },
    ['ALAMO'] = { "bluedream_joint", "meth_packaged" },
    ['ARMYB'] = { "bananakush_joint", "meth_packaged" },
    ['BANHAMC'] = { "weed_packaged", "meth_packaged" },
    ['BHAMCA'] = { "purplehaze_joint", "meth_packaged" },
    ['BRADP'] = { "bluedream_joint", "meth_packaged" },
    ['BRADT'] = { "bananakush_joint", "meth_packaged" },
    ['CALAFB'] = { "weed_packaged", "meth_packaged" },
    ['CANNY'] = { "purplehaze_joint", "meth_packaged" },
    ['CCREAK'] = { "bluedream_joint", "meth_packaged" },
    ['CHU'] = { "bananakush_joint", "meth_packaged" },
    ['CMSW'] = { "weed_packaged", "coke_packaged" },
    ['ELGORL'] = { "purplehaze_joint", "meth_packaged" },
    ['GALFISH'] = { "bluedream_joint", "coke_packaged" },
    ['GRAPES'] = { "bananakush_joint", "meth_packaged" },
    ['GREATC'] = { "weed_packaged", "meth_packaged" },
    ['HARMO'] = { "purplehaze_joint", "meth_packaged" },
    ['HUMLAB'] = { "bluedream_joint", "opium_packaged" },
    ['JAIL'] = { "bananakush_joint", "meth_packaged" },
    ['LAGO'] = { "weed_packaged", "meth_packaged" },
    ['MTCHIL'] = { "purplehaze_joint", "meth_packaged" },
    ['MTGORDO'] = { "bluedream_joint", "opium_packaged" },
    ['MTJOSE'] = { "bananakush_joint", "meth_packaged" },
    ['NCHU'] = { "weed_packaged", "opium_packaged" },
    ['NOOSE'] = { "purplehaze_joint", "coke_packaged" },
    ['PALCOV'] = { "bluedream_joint", "coke_packaged" },
    ['PALETO'] = { "bananakush_joint", "opium_packaged" },
    ['PALFOR'] = { "weed_packaged", "opium_packaged" },
    ['PALMPOW'] = { "purplehaze_joint", "coke_packaged" },
    ['PROCOB'] = { "bluedream_joint", "meth_packaged" },
    ['RGLEN'] = { "bananakush_joint", "coke_packaged" },
    ['RTRAK'] = { "weed_packaged", "coke_packaged" },
    ['SANCHIA'] = { "purplehaze_joint", "meth_packaged" },
    ['SANDY'] = { "bluedream_joint", "opium_packaged" },
    ['SLAB'] = { "bananakush_joint", "coke_packaged" },
    ['TATAMO'] = { "weed_packaged", "opium_packaged" },
    ['TONGVAH'] = { "purplehaze_joint", "meth_packaged" },
    ['TONGVAV'] = { "bluedream_joint", "meth_packaged" },
    ['WINDF'] = { "bananakush_joint", "opium_packaged" },
    ['ZANCUDO'] = { "weed_packaged", "meth_packaged" },
    ['ZQ_UAR'] = { "purplehaze_joint", "opium_packaged" },
    ['OCEANA'] = { "bluedream_joint", "meth_packaged" },
}