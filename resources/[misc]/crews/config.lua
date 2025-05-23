CONFIG = {
    LANGUAGE = 'en',
    COMMAND = 'crew',
    MAX_CREW_MEMBERS = 25,
    MAX_INVITE_DISTANCE = false, -- false to disable distance check
    
    ENABLE_BLIPS = true,
    ENABLE_TAGS = true,
    MAX_TAG_DISTANCE = false,

    -- DO NOT ADD RANKS WITH THE NAME "OWNER" AND "MEMBER"! THEY ARE CREATED AUTOMATICALLY.
    RANKS = { -- Add your own ranks here!
        [1] = { -- Order in which are ranks displayed (owner is always first and member last).
            name = 'officer', -- The name must be unique.
            label = 'Officer', -- Rank label shown in menu.
            permissions = { -- Configure permissions per rank.
                invite = true,
                kick = true,
                changeRank = false,
                changeName = false,
                changeTag = false
            }
        },
    }
}

-- Customize the notifications here.
function notify(text, _type)
    if not _type then _type = 'inform' end

    lib.notify({
        title = 'CREWS',
        description = text,
        type = _type,
        duration = 8000
    })
end
