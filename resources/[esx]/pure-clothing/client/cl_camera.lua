local currentCamera = nil
local zoomspeed = 1.0
local fov_min = 10.0
local fov_max = 70.0
local fov = 70.0
local multi = 0.015
local lastValue = 0
local dragMultiplier = 10.0


function enableCamera(firstCharacter)
    if firstCharacter then 
        Wait(500)
    end
    local playerPed = cache.ped
    -- FreezeEntityPosition(playerPed, true)
    local coords = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 2.0, 0.0)
    RenderScriptCams(false, false, 0, true, true)
    if currentCamera then 
        DestroyCam(currentCamera, false)
    end
    if not DoesCamExist(currentCamera) then 
        fov = 50.0
        currentCamera = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetCamActive(currentCamera, true)
        RenderScriptCams(true, true, 500, true, true)
        SetCamCoord(currentCamera, coords.x, coords.y, coords.z + 0.5)
        PointCamAtEntity(currentCamera, playerPed, 0.0, 0.0, 0.0, true)
        SetCamFov(currentCamera, fov)
    end
end

function disableCamera()
    RenderScriptCams(false, true, 500, true, true)
    if currentCamera then 
        DestroyCam(currentCamera, false)
    end
    currentCamera = nil
end

RegisterNUICallback('scrollwheelup', function(data, cb)
    if fov > 30 then
        fov = math.max(fov - zoomspeed, fov_min)
    end
    PointCamAtEntity(currentCamera, cache.ped, 0.0, 0.0, (fov_max - fov) * multi, true)
    SetCamFov(currentCamera, fov)
end)

RegisterNUICallback('scrollwheeldown', function(data, cb)
    fov = math.min(fov + zoomspeed, fov_max) -- ScrollDown
    PointCamAtEntity(currentCamera, cache.ped, 0.0, 0.0, ((fov - fov_max) + fov_min) * multi * -1, true)
    SetCamFov(currentCamera, fov)
end)

RegisterNUICallback('dragging', function(data, cb)
    if data.x > lastValue then 
        SetEntityHeading(cache.ped, GetEntityHeading(cache.ped) + Config.dragMultiplier)
    else
        SetEntityHeading(cache.ped, GetEntityHeading(cache.ped) - Config.dragMultiplier)
    end
    lastValue = data.x
end)
