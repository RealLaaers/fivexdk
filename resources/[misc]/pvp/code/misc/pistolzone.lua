RegisterCommand('pistolzone', function()
      lib.registerContext({
          id = 'pistolzone',
          title = 'FiveX - Pistol Zone',
          options = {
            {
                title = 'Antal Spillere: 11111',
                icon = 'users',
            },
            {
                title = 'Nuværende Map: NIGGER TIHI',
                icon = 'city',
            },
            {
                title = 'Tilladte våben',
                description = 'Deagle, Pistol, Combat, Heavy, Ceramic, Vintage.',
                icon = 'gun',
            },
              {
                  title = 'Tilgå Zone',
                  description = 'Tilgå Pistol Zone',
                  icon = 'bars',
                  onSelect = function(args)
                      print('neger')
                  end,
              },
          },
      })
      lib.showContext('pistolzone')
  end)