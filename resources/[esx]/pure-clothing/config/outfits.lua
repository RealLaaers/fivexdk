Config.outfits = {
    ['police'] = {
        ['male'] = {
            {
                name = 'Cadet',
                outfit = {
                    ['arms'] = {0,0}, -- Item, Texture
                    ['jacket'] = {25, 0},
                    ['masks'] = {15, 0},
                    ['pants'] = {12, 0},
                    ['shoes'] = {10, 0},
                    ['undershirt'] = {15, 0},
                    ['vests'] = {22, 0}
                },
                grades = {0, 1, 2, 3},
                -- minJobGrade = 4, -- if you want to use this you need to comment/delete grades
            },
            {
                name = 'Officer',
                outfit = {
                    ['arms'] = {0,0}, -- Item, Texture
                    ['jacket'] = {20, 0},
                    ['masks'] = {10, 0},
                    ['pants'] = {10, 0},
                    ['shoes'] = {5, 0},
                    ['undershirt'] = {19, 0},
                    ['vests'] = {20, 0}
                },
                minJobGrade = 1,
            }
        },
        ['female'] = {

        },
    },

}