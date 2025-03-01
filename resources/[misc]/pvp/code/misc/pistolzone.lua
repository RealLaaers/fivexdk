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
                title = 'Tilladte Våben:',
                description = 'Deagle, Pistol, Combat, Heavy, Ceramic, Vintage.',
            },
              {
                  title = 'Tilgå Pistol Zone',
                  description = 'Klik for at tilgå Pistol Zone.',
                  onSelect = function(args)
                      print('neger')
                  end,
              },
          },
      })
      lib.showContext('pistolzone')
  end)