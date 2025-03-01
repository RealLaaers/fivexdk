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
                    TriggerServerEvent('putinpistolbucket')
                    spawnPlayerInPistolZone()
                  end,
              },
          },
      })
      lib.showContext('pistolzone')
  end)

local activePistolZone = 'pistol1'

RegisterNetEvent("pistolzone:updateZone")
AddEventHandler("pistolzone:updateZone", function(newZone)
    local inPistolZone = false
    for _, zoneName in ipairs({"pistol1", "pistol2"}) do
        if IsPlayerInZone(zoneName) then
            inPistolZone = true
            break
        end
    end

    activePistolZone = newZone
    print("Pistolzone opdateret til: " .. activePistolZone)

    if inPistolZone then
        spawnPlayerInPistolZone()
    end
end)

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

function IsPlayerInZone(zoneName)
    local zone = Config.polyZones[zoneName]
    if not zone then
        return false
    end
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local point = { x = playerCoords.x, y = playerCoords.y }
    return isPointInPolygon(point, zone.coords)
end

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

function spawnPlayerInPistolZone()
    local zone = Config.polyZones[activePistolZone]
    if zone then
        local spawnPoint = getRandomPointInZone(zone)
        RequestCollisionAtCoord(spawnPoint.x, spawnPoint.y, spawnPoint.z)

        local groundFound, groundZ = GetGroundZFor_3dCoord(spawnPoint.x, spawnPoint.y, spawnPoint.z, 0)
        local attempts = 0
        while not groundFound and attempts < 50 do
            Citizen.Wait(100)
            groundFound, groundZ = GetGroundZFor_3dCoord(spawnPoint.x, spawnPoint.y, spawnPoint.z, 0)
            attempts = attempts + 1
        end

        if groundFound then
            spawnPoint = vector3(spawnPoint.x, spawnPoint.y, groundZ)
        else
            print("Groundpoint ikke fundet, benytter standard Z fra zone config")
        end

        SetEntityCoords(PlayerPedId(), spawnPoint.x, spawnPoint.y, spawnPoint.z, false, false, false, true)
    else
        print("Pistolzone ikke fundet i config!")
    end
end

AddEventHandler('baseevents:onPlayerDied', function()
    ESX.TriggerServerCallback('GetPlayerRoutingBucket', function(GetPlayerRoutingBucket)
        if GetPlayerRoutingBucket == 917665 then
    spawnPlayerInPistolZone()
    end)
end)
