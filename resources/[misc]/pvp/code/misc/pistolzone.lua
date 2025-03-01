RegisterCommand('pistolzone', function()
      lib.registerContext({
          id = 'pistolzone',
          title = 'FiveX - Pistol Zone',
          options = {
            {
                title = 'Antal Spillere: 11111',
            },
            {
                title = 'Nuværende Map: NIGGER TIHI',
            },
            {
                title = 'Tilladte våben',
                metadata = {
                    {label = 'Desert Eagle'},
                    {label = 'Pistol 9mm'},
                    {label = 'Combat Pistol'},
                    {label = 'Heavy Pistol'},
                    {label = 'Ceramic Pistol'},
                    {label = 'Vintage Pistol'}
                  },
            },
              {
                  title = 'Tilgå Pistol Zone',
                  description = 'Tilgå Pistol Zone',
                  onSelect = function(args)
                      print('neger')
                  end,
              },
          },
      })
      lib.showContext('pistolzone')
  end)