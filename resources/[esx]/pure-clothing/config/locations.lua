Config.locations = {}

Config.locations.clothing = {
    {
        type = 'clothing',
        coords = vector4(1693.32, 4823.48, 41.06, 190),
        boxSize = vector3(4, 4, 4),
        rotation = 45.0,
    },
    {
        type = 'clothing',
        coords = vector4(-712.215881, -155.352982, 36.4151268, 122),
        boxSize = vector3(4, 4, 4),
        rotation = 45.0,
    },
    {
        type = 'clothing',
        coords = vector4(-1192.94495, -772.688965, 16.3255997, 215),
        boxSize = vector3(4, 4, 4),
        rotation = 45.0,
    },
    {
        type = 'clothing',
        coords = vector4(425.236, -806.008, 28.491, 177),
        boxSize = vector3(4, 4, 4),
        rotation = 45.0,
    },
    {
        type = 'clothing',
        coords = vector4(-163.0, -302.95, 38.73, 256),
        boxSize = vector3(4, 4, 4),
        rotation = 45.0,
    },
    {
        type = 'clothing',
        coords = vector4(75.950, -1392.891, 28.376, 5),
        boxSize = vector3(4, 4, 4),
        rotation = 45.0,
    },
    {
        type = 'clothing',
        coords = vector4(-822.194, -1074.134, 10.328, 295),
        boxSize = vector3(4, 4, 4),
        rotation = 45.0,
    },
    {
        type = 'clothing',
        coords = vector4(-1445.86, -240.78, 48.82, 36),
        boxSize = vector3(4, 4, 4),
        rotation = 45.0,
    },
    {
        type = 'clothing',
        coords = vector4(9.22, 6515.74, 30.88, 131),
        boxSize = vector3(4, 4, 4),
        rotation = 45.0,
    },
    {
        type = 'clothing',
        coords = vector4(615.180, 2762.933, 41.088, 170),
        boxSize = vector3(4, 4, 4),
        rotation = 45.0,
    },
    {
        type = 'clothing',
        coords = vector4(1196.785, 2709.558, 37.222, 270),
        boxSize = vector3(4, 4, 4),
        rotation = 45.0,
    },
    {
        type = 'clothing',
        coords = vector4(-3171.453, 1043.857, 19.863, 335),
        boxSize = vector3(4, 4, 4),
        rotation = 45.0,
    },
    {
        type = 'clothing',
        coords = vector4(-1105.959, 2707.211, 18.107, 317),
        boxSize = vector3(4, 4, 4),
        rotation = 45.0,
    },
    {
        type = 'clothing',
        coords = vector4(-1119.24, -1440.6, 4.23, 300),
        boxSize = vector3(4, 4, 4),
        rotation = 45.0,
    },
    {
        type = 'clothing',
        coords = vector4(124.82, -224.36, 53.56, 335),
        boxSize = vector3(4, 4, 4),
        rotation = 45.0,
    },
    {
        type = 'barber',
        coords = vector4(-814.3, -183.8, 36.6, 117),
        boxSize = vector3(4, 4, 4),
        rotation = 45.0,
    },
    {
        type = 'barber',
        coords = vector4(136.8, -1708.4, 28.3, 144),
        boxSize = vector3(4, 4, 4),
        rotation = 45.0,
    },
    {
        type = 'barber',
        coords = vector4(-1282.6, -1116.8, 6.0, 89),
        boxSize = vector3(4, 4, 4),
        rotation = 45.0,
    },
    {
        type = 'barber',
        coords = vector4(1931.5, 3729.7, 31.8, 212),
        boxSize = vector3(4, 4, 4),
        rotation = 45.0,
    },
    {
        type = 'barber',
        coords = vector4(1212.8, -472.9, 65.2, 61),
        boxSize = vector3(4, 4, 4),
        rotation = 45.0,
    },
    {
        type = 'barber',
        coords = vector4(-32.9, -152.3, 56.1, 335),
        boxSize = vector3(4, 4, 4),
        rotation = 45.0,
    },
    {
        type = 'barber',
        coords = vector4(-278.1, 6228.5, 30.7, 50),
        boxSize = vector3(4, 4, 4),
        rotation = 45.0,
    },
    {
        type = 'tattoo',
        coords = vector4(1322.6, -1651.9, 51.2, 42),
        boxSize = vector3(4, 4, 4),
        rotation = 45.0,
    },
    {
        type = 'tattoo',
        coords = vector4(-1154.01, -1425.31, 3.95, 23),
        boxSize = vector3(4, 4, 4),
        rotation = 45.0,
    },
    {
        type = 'tattoo',
        coords = vector4(322.62, 180.34, 102.59, 156),
        boxSize = vector3(4, 4, 4),
        rotation = 45.0,
    },
    {
        type = 'tattoo',
        coords = vector4(-3170.04, 1075.86, 19.83, 253),
        boxSize = vector3(4, 4, 4),
        rotation = 45.0,
    },
    {
        type = 'tattoo',
        coords = vector4(1864.1, 3747.91, 32.03, 17),
        boxSize = vector3(4, 4, 4),
        rotation = 45.0,
    },
    {
        type = 'tattoo',
        coords = vector4(-293.71, 6200.04, 30.49, 195),
        boxSize = vector3(4, 4, 4),
        rotation = 45.0,
    },
    {
        type = 'surgeon',
        coords = vector4(298.78, -572.81, 42.26, 114),
        boxSize = vector3(4, 4, 4),
        rotation = 45.0,
    }
}

Config.locations.jobBasedClothing = {
    -- can have either a job or a gang to determine who is allowed to use the clothing!
    {
        jobs = {'police', 'ambulance'},
        type = 'clothing',
        coords = vector4(454.91, -990.89, 29.69, 193.4),
        boxSize = vector3(4, 4, 4),
    },
    {
        gang = 'ballas',
        type = 'clothing',
        coords = vector4(444.91, -985.89, 29.69, 193.4),
        boxSize = vector3(4, 4, 4),
    },
}

Config.locations.personalOutfits = {
    -- This is how personal outfit places work, so if you want players to have personal outfit places you need to add the coords and their citizen ids, there can be multiple citizen ids here!
    {
        type = 'personal',
        coords = vector4(1665.32, 4823.48, 41.06, 190),
        boxSize = vector3(4, 4, 4),
        citizenIds = {
            'CITIZENIDHERE',
            'MYM15791'
        }
    },
}