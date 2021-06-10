Config = {}
Config.Locale = 'en'
Config.reportCooldown = 60 --seconds
Config.warnMax = 3  --how many warn player can get before getting kicked?

Config.TeleportLocations = {
	['pd'] = {x = 425.0901, y = -979.5033},          -- Edare PD
	['police'] = {x = 425.0901, y = -979.5033},      -- Edare PD
	
	['md'] = {x = 281.6176, y = -566.8483},          -- Bimarestan Markazi
	['medic'] = {x = 281.6176, y = -566.8483},       -- Bimarestan Markazi
	
	['fbi'] = {x = 93.66594, y = -742.7736},         -- FBI
	
	['parking'] = {x = 233.2088, y = -763.3187},     -- Parking Markazi
	
	['bankmarkazi'] = {x = 235.2659, y = 216.8835},  -- Bank Markazi
	['bank'] = {x = 235.2659, y = 216.8835},         -- Bank Markazi
	
	['mechanic'] = {x = -369.8506, y = -130.9187},   -- Mechanic
	
	['carshop'] = {x = -36.8967, y = -1105.635},     -- Carshop
	
	['dadgostari'] = {x = 243.0989, y = -1071.429},  -- Dadgostari
	['doj'] = {x = 243.0989, y = -1071.429},         -- Dadgostari
	['jod'] = {x = 243.0989, y = -1071.429},         -- Dadgostari
	
	['mine'] = {x = -596.9539, y = 2092.497},        -- Mining Job Location
	['mining'] = {x = -596.9539, y = 2092.497},        -- Mining Job Location
	
	['sheriff'] = {x = 1849.833, y = 3672.607},      -- Edare Sheriff
	['sd'] = {x = 1849.833, y = 3672.607},           -- Edare Sheriff
	
	['istsheriff'] = {x = 1284.541, y = 592.1275},   -- Ist Bazresi Sheriff
	['istsd'] = {x = 1284.541, y = 592.1275},        -- Ist Bazresi Sheriff
	['ist'] = {x = 1284.541, y = 592.1275},          -- Ist Bazresi Sheriff
	['istbazresi'] = {x = 1284.541, y = 592.1275},   -- Ist Bazresi Sheriff
	['bazresi'] = {x = 1284.541, y = 592.1275},      -- Ist Bazresi Sheriff
	
	['prison'] = {x = 739.2527, y = 131.1956},       -- Zendan Markazi
	['zendan'] = {x = 739.2527, y = 131.1956},       -- Zendan Markazi
	
	['jobcenter'] = {x = -257.5253, y = -979.5165},  -- Job Center
	['job'] = {x = -257.5253, y = -979.5165},        -- Job Center
	['jc'] = {x = -257.5253, y = -979.5165},         -- Job Center
	
	['paintball'] = {x = 192.1582, y = -921.0329},   -- PaintBall
	['pb'] = {x = 192.1582, y = -921.0329},   -- PaintBall
}

Config.CleanSkin = {
	['tshirt_1'] = 0,  ['tshirt_2'] = 0,
	['torso_1'] = 0,   ['torso_2'] = 0,
	['decals_1'] = 0,   ['decals_2'] = 0,
	['arms'] = 0,
	['pants_1'] = 0,   ['pants_2'] = 0,
	['shoes_1'] = 0,   ['shoes_2'] = 0,
	['helmet_1'] = -1,  ['helmet_2'] = 0,
	['mask_1'] = 0,  ['mask_2'] = 0,
	['chain_1'] = 0,    ['chain_2'] = 0,
	['ears_1'] = 0,     ['ears_2'] = 0,
	['bags_1'] = 0,     ['bags_2'] = 0,
	['hair_1'] = 0,     ['hair_2'] = 0,
	['bproof_1'] = 0,  ['bproof_2'] = 0
}

Config.Admin = {
    [10] = {
        male = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 287,   ['torso_2'] = 2,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 3,
            ['pants_1'] = 114,   ['pants_2'] = 2,
            ['shoes_1'] = 78,   ['shoes_2'] = 2,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['mask_1'] = 135,  ['mask_2'] = 2,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 0,     ['ears_2'] = 0,
            ['bags_1'] = 0,     ['bags_2'] = 0,
            ['hair_1'] = 0,     ['hair_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
        },
        female = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 300,   ['torso_2'] = 2,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 8,
            ['pants_1'] = 121,   ['pants_2'] = 2,
            ['shoes_1'] = 82,   ['shoes_2'] = 2,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['mask_1'] = 153,  ['mask_2'] = 2,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 0,     ['ears_2'] = 0,
            ['bags_1'] = 0,     ['bags_2'] = 0,
            ['hair_1'] = 0,     ['hair_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
        }
    },
    [9] = {
        male = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 287,   ['torso_2'] = 3,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 3,
            ['pants_1'] = 114,   ['pants_2'] = 3,
            ['shoes_1'] = 78,   ['shoes_2'] = 3,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['mask_1'] = 135,  ['mask_2'] = 3,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 0,     ['ears_2'] = 0,
            ['bags_1'] = 0,     ['bags_2'] = 0,
            ['hair_1'] = 0,     ['hair_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
        },
        female = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 300,   ['torso_2'] = 3,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 8,
            ['pants_1'] = 121,   ['pants_2'] = 3,
            ['shoes_1'] = 82,   ['shoes_2'] = 3,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['mask_1'] = 153,  ['mask_2'] = 3,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 0,     ['ears_2'] = 0,
            ['bags_1'] = 0,     ['bags_2'] = 0,
            ['hair_1'] = 0,     ['hair_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
        } 
    },
    [8] = {
        male = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 287,   ['torso_2'] = 4,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 3,
            ['pants_1'] = 114,   ['pants_2'] = 4,
            ['shoes_1'] = 78,   ['shoes_2'] = 4,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['mask_1'] = 135,  ['mask_2'] = 4,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 0,     ['ears_2'] = 0,
            ['bags_1'] = 0,     ['bags_2'] = 0,
            ['hair_1'] = 0,     ['hair_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
        },
        female = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 300,   ['torso_2'] = 9,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 8,
            ['pants_1'] = 121,   ['pants_2'] = 9,
            ['shoes_1'] = 82,   ['shoes_2'] = 9,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['mask_1'] = 153,  ['mask_2'] = 9,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 0,     ['ears_2'] = 0,
            ['bags_1'] = 0,     ['bags_2'] = 0,
            ['hair_1'] = 0,     ['hair_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
        } 
    },
    [7] = {
        male = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 287,   ['torso_2'] = 9,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 3,
            ['pants_1'] = 114,   ['pants_2'] = 9,
            ['shoes_1'] = 78,   ['shoes_2'] = 9,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['mask_1'] = 135,  ['mask_2'] = 9,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 0,     ['ears_2'] = 0,
            ['bags_1'] = 0,     ['bags_2'] = 0,
            ['hair_1'] = 0,     ['hair_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
        },
        female = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 300,   ['torso_2'] = 9,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 8,
            ['pants_1'] = 121,   ['pants_2'] = 9,
            ['shoes_1'] = 82,   ['shoes_2'] = 9,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['mask_1'] = 153,  ['mask_2'] = 9,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 0,     ['ears_2'] = 0,
            ['bags_1'] = 0,     ['bags_2'] = 0,
            ['hair_1'] = 0,     ['hair_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
        } 
    },
    [6] = {
        male = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 287,   ['torso_2'] = 5,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 3,
            ['pants_1'] = 114,   ['pants_2'] = 5,
            ['shoes_1'] = 78,   ['shoes_2'] = 5,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['mask_1'] = 135,  ['mask_2'] = 5,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 0,     ['ears_2'] = 0,
            ['bags_1'] = 0,     ['bags_2'] = 0,
            ['hair_1'] = 0,     ['hair_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
        },
        female = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 300,   ['torso_2'] = 5,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 8,
            ['pants_1'] = 121,   ['pants_2'] = 5,
            ['shoes_1'] = 82,   ['shoes_2'] = 5,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['mask_1'] = 153,  ['mask_2'] = 5,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 0,     ['ears_2'] = 0,
            ['bags_1'] = 0,     ['bags_2'] = 0,
            ['hair_1'] = 0,     ['hair_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0			
        } 
    },
    [5] = {
        male = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 287,   ['torso_2'] = 5,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 3,
            ['pants_1'] = 114,   ['pants_2'] = 5,
            ['shoes_1'] = 78,   ['shoes_2'] = 5,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['mask_1'] = 135,  ['mask_2'] = 5,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 0,     ['ears_2'] = 0,
            ['bags_1'] = 0,     ['bags_2'] = 0,
            ['hair_1'] = 0,     ['hair_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
        },
        female = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 300,   ['torso_2'] = 5,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 8,
            ['pants_1'] = 121,   ['pants_2'] = 5,
            ['shoes_1'] = 82,   ['shoes_2'] = 5,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['mask_1'] = 153,  ['mask_2'] = 5,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 0,     ['ears_2'] = 0,
            ['bags_1'] = 0,     ['bags_2'] = 0,
            ['hair_1'] = 0,     ['hair_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0			
        } 
    },
    [4] = {
        male = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 287,   ['torso_2'] = 5,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 3,
            ['pants_1'] = 114,   ['pants_2'] = 5,
            ['shoes_1'] = 78,   ['shoes_2'] = 5,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['mask_1'] = 135,  ['mask_2'] = 5,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 0,     ['ears_2'] = 0,
            ['bags_1'] = 0,     ['bags_2'] = 0,
            ['hair_1'] = 0,     ['hair_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
        },
        female = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 300,   ['torso_2'] = 5,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 8,
            ['pants_1'] = 121,   ['pants_2'] = 5,
            ['shoes_1'] = 82,   ['shoes_2'] = 5,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['mask_1'] = 153,  ['mask_2'] = 5,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 0,     ['ears_2'] = 0,
            ['bags_1'] = 0,     ['bags_2'] = 0,
            ['hair_1'] = 0,     ['hair_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0			
        } 
    },
    [3] = {
        male = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 287,   ['torso_2'] = 5,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 3,
            ['pants_1'] = 114,   ['pants_2'] = 5,
            ['shoes_1'] = 78,   ['shoes_2'] = 5,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['mask_1'] = 135,  ['mask_2'] = 5,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 0,     ['ears_2'] = 0,
            ['bags_1'] = 0,     ['bags_2'] = 0,
            ['hair_1'] = 0,     ['hair_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
        },
        female = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 300,   ['torso_2'] = 5,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 8,
            ['pants_1'] = 121,   ['pants_2'] = 5,
            ['shoes_1'] = 82,   ['shoes_2'] = 5,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['mask_1'] = 153,  ['mask_2'] = 5,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 0,     ['ears_2'] = 0,
            ['bags_1'] = 0,     ['bags_2'] = 0,
            ['hair_1'] = 0,     ['hair_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0			
        } 
    },
    [2] = {
        male = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 287,   ['torso_2'] = 5,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 3,
            ['pants_1'] = 114,   ['pants_2'] = 5,
            ['shoes_1'] = 78,   ['shoes_2'] = 5,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['mask_1'] = 135,  ['mask_2'] = 5,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 0,     ['ears_2'] = 0,
            ['bags_1'] = 0,     ['bags_2'] = 0,
            ['hair_1'] = 0,     ['hair_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
        },
        female = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 300,   ['torso_2'] = 5,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 8,
            ['pants_1'] = 121,   ['pants_2'] = 5,
            ['shoes_1'] = 82,   ['shoes_2'] = 5,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['mask_1'] = 153,  ['mask_2'] = 5,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 0,     ['ears_2'] = 0,
            ['bags_1'] = 0,     ['bags_2'] = 0,
            ['hair_1'] = 0,     ['hair_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0			
        } 
    },
    [1] = {
        male = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 287,   ['torso_2'] = 5,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 3,
            ['pants_1'] = 114,   ['pants_2'] = 5,
            ['shoes_1'] = 78,   ['shoes_2'] = 5,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['mask_1'] = 135,  ['mask_2'] = 5,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 0,     ['ears_2'] = 0,
            ['bags_1'] = 0,     ['bags_2'] = 0,
            ['hair_1'] = 0,     ['hair_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0
        },
        female = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 300,   ['torso_2'] = 5,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 8,
            ['pants_1'] = 121,   ['pants_2'] = 5,
            ['shoes_1'] = 82,   ['shoes_2'] = 5,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['mask_1'] = 153,  ['mask_2'] = 5,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 0,     ['ears_2'] = 0,
            ['bags_1'] = 0,     ['bags_2'] = 0,
            ['hair_1'] = 0,     ['hair_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0			
        } 
    }
}