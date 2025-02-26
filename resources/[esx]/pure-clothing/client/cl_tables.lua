-- Never touch these please!!!!!!
charactersFirstCharacter = false
currentPedModel = 'mp_m_freemode_01'
newPed = nil
cooldown = GetGameTimer()
isInMenu = false
clothingTable = {
    -- Clothing Menu
    ['arms'] = {type = 'variation', id = 3, maxValue1 = 0, maxValue2 = 0, value1 = 0, value2 = 0, menu = 'clothing'},
    ['bags'] = {type = 'variation', id = 5, maxValue1 = 0, maxValue2 = 0, value1 = 0, value2 = 0, menu = 'props'},
    ['bracelets'] = {type = 'prop', id = 7, maxValue1 = 0, maxValue2 = 0, value1 = -1, value2 = 0, menu = 'props'},
    ['chains'] = {type = 'variation', id = 7, maxValue1 = 0, maxValue2 = 0, value1 = 0, value2 = 0, menu = 'props'},
    ['decals'] = {type = 'variation', id = 10, maxValue1 = 0, maxValue2 = 0, value1 = 0, value2 = 0, menu = 'props'},
    ['earrings'] = {type = 'prop', id = 2, maxValue1 = 0, maxValue2 = 0, value1 = -1, value2 = 0, menu = 'props'},
    ['glasses'] = {type = 'prop', id = 1, maxValue1 = 0, maxValue2 = 0, value1 = -1, value2 = 0, menu = 'props'},
    ['helmets'] = {type = 'prop', id = 0, maxValue1 = 0, maxValue2 = 0, value1 = -1, value2 = 0, menu = 'props'},
    ['jacket'] = {type = 'variation', id = 11, maxValue1 = 0, maxValue2 = 0, value1 = 0, value2 = 0, menu = 'clothing'},
    ['masks'] = {type = 'variation', id = 1, maxValue1 = 0, maxValue2 = 0, value1 = 0, value2 = 0, menu = 'clothing'},
    ['pants'] = {type = 'variation', id = 4, maxValue1 = 0, maxValue2 = 0, value1 = 0, value2 = 0, menu = 'clothing'},
    ['shoes'] = {type = 'variation', id = 6, maxValue1 = 0, maxValue2 = 0, value1 = 0, value2 = 0, menu = 'clothing'},
    ['undershirt'] = {type = 'variation', id = 8, maxValue1 = 0, maxValue2 = 0, value1 = 0, value2 = 0, menu = 'clothing'},
    ['vests'] = {type = 'variation', id = 9, maxValue1 = 0, maxValue2 = 0, value1 = 0, value2 = 0, menu = 'clothing'},
    ['watches'] = {type = 'prop', id = 6, maxValue1 = 0, maxValue2 = 0, value1 = -1, value2 = 0, menu = 'props'},
    ['hair'] = {type = 'variation', id = 2, maxValue1 = 0, maxValue2 = 0, value1 = 0, value2 = 0},
    -- Create Character Menu
    ['cheek'] = {
        type = 'faceFeature',
        depth = 8,
        height = 9,
        width = 10,
    },
    ['chin'] = {
        type = 'faceFeature',
        depth = 15,
        length = 16,
        width = 17,
        hole = 18,
    },
    ['eyebrow'] = {
        type = 'faceFeature',
        depth = 6,
        height = 7,
    },
    ['eyes'] = {
        type = 'faceFeature',
        opening = 11,
    },
    ['jaw'] = {
        type = 'faceFeature',
        width = 13,
        shape = 14,
    },
    ['lip'] = {
        type = 'faceFeature',
        thickness = 12,
    },
    ['neck'] = {
        type = 'faceFeature',
        thickness = 19,
    },
    ['nose'] = {
        type = 'faceFeature',
        width = 0,
        peak = 1,
        length = 2,
        curveness = 3,
        tip = 4,
        twist = 5,
    },
    ['parents'] = {
        type = 'parents',
        mother = {21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 35, 36, 37, 38, 39, 40, 41, 45},
        father = {00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 18, 19, 20, 42, 43, 44},
    },
    -- Hair Menu
    ['age'] = {
        type = 'overlay',
        id = 3,
        colourType = 0,
        maxValue1 = 0,
    },
    ['beard'] = {
        type = 'overlay',
        id = 1,
        colourType = 1,
        maxValue1 = 0,
    },
    ['blemishes'] = {
        type = 'overlay',
        id = 0,
        colourType = 0,
        maxValue1 = 0,
    },
    ['blush'] = {
        type = 'overlay',
        id = 5,    
        colourType = 2,
        maxValue1 = 0,
    },
    ['body'] = {
        type = 'overlay',
        id = 11,
        colourType = 0,
        maxValue1 = 0,
    },
    ['chest'] = {
        type = 'overlay',
        id = 10,
        colourType = 1,
        maxValue1 = 0,
    },
    ['eyebrows'] = {
        type = 'overlay',
        id = 2,
        colourType = 1,
        maxValue1 = 0,
    },
    ['lipstick'] = {
        type = 'overlay',
        id = 8,
        colourType = 2,
        maxValue1 = 0,
    },
    ['freckles'] = {
        type = 'overlay',
        id = 9,
        colourType = 0,
        maxValue1 = 0,
    },
    ['makeup'] = {
        type = 'overlay',
        id = 4,
        colourType = 1,
        maxValue1 = 0,
    },
    ['complextion'] = {
        type = 'overlay',
        id = 6,
        colourType = 0,
        maxValue1 = 0,
    },
    ['sundamage'] = {
        type = 'overlay',
        id = 7,
        colourType = 0,
        maxValue1 = 0,
    },
}

tattooCollectionTable = {
    ['AR'] = 'mpairraces_overlays',
    ['BB'] = 'mpbeach_overlays',
    ['BI'] = 'mpbiker_overlays',
    ['BUS'] = 'mpbusiness_overlays',
    ['H27'] = 'mpchristmas2017_overlays',
    ['AW'] = 'mpchristmas2018_overlays',
    ['X2'] = 'mpchristmas2_overlays',
    ['X6'] = 'mpchristmas3_overlays',
    ['GR'] = 'mpgunrunning_overlays',
    ['H3'] = 'mpheist3_overlays',
    ['H4'] = 'mpheist4_overlays',
    ['HP'] = 'mphipster_overlays',
    ['IE'] = 'mpimportexport_overlays',
    ['S2'] = 'mplowrider2_overlays',
    ['S1'] = 'mplowrider_overlays',
    ['L2'] = 'mpluxe2_overlays',
    ['LX'] = 'mpluxe_overlays',
    ['FX'] = 'mpsecurity_overlays',
    ['SM'] = 'mpsmuggler_overlays',
    ['ST'] = 'mpstunt_overlays',
    ['SB'] = 'mpsum2_overlays',
    ['VW'] = 'mpvinewood_overlays',
    ['FM'] = 'multiplayer_overlays'
}

faceFeaturesTable = {
    ['noseWidth'] = {
        id = 0,
        value = 0,
    },
    ['nosePeak'] = {
        id = 1,
        value = 0,
    },
    ['noseLength'] = {
        id = 2,
        value = 0,
    },
    ['noseCurveness'] = {
        id = 3,
        value = 0,
    },
    ['noseTip'] = {
        id = 4,
        value = 0,
    },
    ['noseTwist'] = {
        id = 5,
        value = 0,
    },
    ['eyebrowsDepth'] = {
        id = 6,
        value = 0,
    },
    ['eyebrowsHeight'] = {
        id = 7,
        value = 0,
    },
    ['cheeksDepth'] = {
        id = 8,
        value = 0,
    },
    ['cheeksHeight'] = {
        id = 9,
        value = 0,
    },
    ['cheeksWidth'] = {
        id = 10,
        value = 0,
    },
    ['eyesOpening'] = {
        id = 11,
        value = 0,
    },
    ['lipThickness'] = {
        id = 12,
        value = 0,
    },
    ['jawWidth'] = {
        id = 13,
        value = 0,
    },
    ['jawShape'] = {
        id = 14,
        value = 0,
    },
    ['chinDepth'] = {
        id = 15,
        value = 0,
    },
    ['chinLength'] = {
        id = 16,
        value = 0,
    },
    ['chinShape'] = {
        id = 17,
        value = 0,
    },
    ['chinHole'] = {
        id = 18,
        value = 0,
    },
    ['neckThickness'] = {
        id = 19,
        value = 0,
    },
    ['eyesColour'] = {
        id = 'eyeColour',
        value = 0,
    },
    ['parents'] = {
        id = 'parents',
        father = 0,
        mother = 0,
        mix = 0,
        skinColour = 0,
    }
}

clothingForValuesTable = {
    ['arms'] = {type = 'variation', id = 3, maxValue1 = 0, maxValue2 = 0, value1 = 0, value2 = 0},
    ['jacket'] = {type = 'variation', id = 11, maxValue1 = 0, maxValue2 = 0, value1 = 0, value2 = 0},
    ['masks'] = {type = 'variation', id = 1, maxValue1 = 0, maxValue2 = 0, value1 = 0, value2 = 0},
    ['pants'] = {type = 'variation', id = 4, maxValue1 = 0, maxValue2 = 0, value1 = 0, value2 = 0},
    ['shoes'] = {type = 'variation', id = 6, maxValue1 = 0, maxValue2 = 0, value1 = 0, value2 = 0},
    ['undershirt'] = {type = 'variation', id = 8, maxValue1 = 0, maxValue2 = 0, value1 = 0, value2 = 0},
    ['vests'] = {type = 'variation', id = 9, maxValue1 = 0, maxValue2 = 0, value1 = 0, value2 = 0},
}

propsForvaluesTable = {
    ['chains'] = {type = 'variation', id = 7, maxValue1 = 0, maxValue2 = 0, value1 = 0, value2 = 0},
    ['helmets'] = {type = 'prop', id = 0, maxValue1 = 0, maxValue2 = 0, value1 = -1, value2 = 0},
    ['glasses'] = {type = 'prop', id = 1, maxValue1 = 0, maxValue2 = 0, value1 = -1, value2 = 0},
    ['watches'] = {type = 'prop', id = 6, maxValue1 = 0, maxValue2 = 0, value1 = -1, value2 = 0},
    ['bracelets'] = {type = 'prop', id = 7, maxValue1 = 0, maxValue2 = 0, value1 = -1, value2 = 0},
    ['bags'] = {type = 'variation', id = 5, maxValue1 = 0, maxValue2 = 0, value1 = 0, value2 = 0},
    ['decals'] = {type = 'variation', id = 10, maxValue1 = 0, maxValue2 = 0, value1 = 0, value2 = 0},
    ['earrings'] = {type = 'prop', id = 2, maxValue1 = 0, maxValue2 = 0, value1 = -1, value2 = 0},
}

maxValues = {}
faceFeatureTableValues = {}
hairFeatureTableValues = {}
clothingTableValues = {}
propTableValues = {}
currentAllClothing = {}
commandClothing = {}
currentAllHair = {}
currentAllFace = {}
currentAllTattoos = {
    ['torso'] = {},
    ['head'] = {},
    ['leftarm'] = {},
    ['rightarm'] = {},
    ['leftleg'] = {},
    ['rightleg'] = {},
}
cachedTattoos = {}
tattooTableRecieved = nil
