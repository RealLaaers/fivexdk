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
                    spawnPlayerInPistolZone()
                  end,
              },
          },
      })
      lib.showContext('pistolzone')
  end)

  -- Standard aktiv zone (opdateres af serveren)
local activePistolZone = 'pistol1'

-- Modtag event fra serveren om opdatering af zone
RegisterNetEvent("pistolzone:updateZone")
AddEventHandler("pistolzone:updateZone", function(newZone)
    activePistolZone = newZone
    print("Pistolzone opdateret til: " .. activePistolZone)
end)

-- Funktion til at tjekke om et punkt er indenfor en polygon (ray-casting)
function isPointInPolygon(point, poly)
    local inside = false
    local j = #poly
    for i = 1, #poly do
        if ((poly[i].y > point.y) ~= (poly[j].y > point.y)) and
           (point.x < (poly[j].x - poly[i].x) * (point.y - poly[i].y) / (poly[j].y - poly[i].y) + poly[i].x) then
            inside = not inside
        end
        j = i
    end
    return inside
end

-- Funktion til at generere et tilfældigt punkt indenfor en given zone
function getRandomPointInZone(zone)
    local coords = zone.coords
    local minX, minY = coords[1].x, coords[1].y
    local maxX, maxY = coords[1].x, coords[1].y

    for i = 2, #coords do
        minX = math.min(minX, coords[i].x)
        minY = math.min(minY, coords[i].y)
        maxX = math.max(maxX, coords[i].x)
        maxY = math.max(maxY, coords[i].y)
    end

    local point = {}
    local attempts = 0
    repeat
        point = { x = math.random() * (maxX - minX) + minX, y = math.random() * (maxY - minY) + minY }
        attempts = attempts + 1
    until isPointInPolygon(point, coords) or attempts > 100

    if not isPointInPolygon(point, coords) then
        point = { x = coords[1].x, y = coords[1].y }
    end

    local z = math.random() * (zone.maxZ - zone.minZ) + zone.minZ
    return vector3(point.x, point.y, z)
end

-- Spawn-funktion, der bruger den aktive pistolzone (som serveren opdaterer)
function spawnPlayerInPistolZone()
    local zone = Config.polyZones[activePistolZone]
    if zone then
        local spawnPoint = getRandomPointInZone(zone)
        SetEntityCoords(PlayerPedId(), spawnPoint.x, spawnPoint.y, spawnPoint.z, false, false, false, true)
    else
        print("Pistolzone ikke fundet i config!")
    end
end

-- Eksempel: Når spilleren vælger 'Tilgå Pistol Zone' i menuen
RegisterCommand('enterpistolzone', function()
    spawnPlayerInPistolZone()
end, false)

-- Eksempel: Gen-spawn når spilleren dør
AddEventHandler('baseevents:onPlayerDied', function()
    spawnPlayerInPistolZone()
end)
