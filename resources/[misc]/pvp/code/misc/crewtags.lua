  local jaIconColor = 'green'
  local nejIconColor = 'red'
RegisterNetEvent('crewtagsmanagement')
AddEventHandler('crewtagsmanagement', function()
lib.registerContext({
          id = 'crewtags',
          title = 'FiveX - Crew Tags',
          options = {
              {
                  title = 'Aktiver Crew Tags',
                  description = 'Klik for at aktivere crew tags.',
                  icon = 'circle-check',
                  iconColor = jaIconColor,
                  onSelect = function(args)
                    jaIconColor = 'green'
                    nejIconColor = 'red'
                    ExecuteCommand('crewTags')
                  end,
              },
              {
                  title = 'Deaktiver Crew Tags',
                  description = 'Klik for at deaktivere crew tags.',
                  icon = 'circle-check',
                  iconColor = nejIconColor,
                  onSelect = function(args)
                    jaIconColor = 'red'
                    nejIconColor = 'green'
                      ExecuteCommand('crewTags')
                  end,
              },
              {
                title = 'Tilbage',
                arrow = false,
                icon  = 'backward',
                menu  = 'justeringer'
            },
          },
      })
      lib.showContext('crewtags')
end)