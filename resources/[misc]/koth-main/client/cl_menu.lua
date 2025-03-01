local co = false
local NotSpam = false
AddEventHandler('playerSpawned', function()
    if not co then
        -- TriggerEvent("KOTH_HUD:removeHUD",1)
        -- startCamera()
        -- showMainMenu()
        ClearPedBloodDamage(PlayerPedId())
        co = true
        TriggerEvent("core:ResetDeathStatus",true)
        TriggerServerEvent("GetUserBDD")
    else
        TriggerEvent("KOTH:ReturnBase")
        TriggerEvent("core:ResetDeathStatus", true)

        ClearPedBloodDamage(PlayerPedId())
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == "koth-main" then
        Wait(1500)
        -- showMainMenu()
        -- startCamera()
        TriggerEvent("playerSpawned")
    end
end)

RegisterNetEvent("KOTH:TeleportPlayer")
AddEventHandler("KOTH:TeleportPlayer", function(x, y, z, heading, win)
    local ped = PlayerPedId()
    SetEntityCoords(ped, x, y, z)
    SetEntityHeading(ped, heading)
    ExecuteCommand('leavekoth')
    TriggerServerEvent('koth:win', win)
end)
  
function showMainMenu()
    --local data = {type = "show", one = "Opfor Team", two = "Independent", three = "Blufor Team"}
    --SendNUIMessage(data)
    --SetNuiFocus(true, true)
end


RegisterNetEvent("KOTH-TeamFull")
AddEventHandler("KOTH-TeamFull", function(team)
    -- local send = {
    --     type = "teamfull",
    --     fullteam = team
    -- }
    local teamtext = ""
    if team == 1 then
        teamtext = 'Rød'
    elseif team == 2 then
        teamtext = 'Blå'
    elseif team == 3 then
        teamtext = 'Grøn'
    end
    lib.notify({
        title = teamtext..' er fyldt, prøv et andet.',
        type = 'error'
    })
    NotSpam = false
    --SendNUIMessage(send)
end)

local savedOutfit = nil

function SaveOutfit()
    local ped = PlayerPedId()
    savedOutfit = { components = {}, props = {} }
    for i = 0, 11 do
        savedOutfit.components[i] = {
            drawable = GetPedDrawableVariation(ped, i),
            texture = GetPedTextureVariation(ped, i),
            palette = GetPedPaletteVariation(ped, i)
        }
    end
    for i = 0, 2 do
        savedOutfit.props[i] = {
            propIndex = GetPedPropIndex(ped, i),
            propTexture = GetPedPropTextureIndex(ped, i)
        }
    end
end

function LoadOutfit()
    if savedOutfit then
        local ped = PlayerPedId()
        for i, comp in pairs(savedOutfit.components) do
            SetPedComponentVariation(ped, i, comp.drawable, comp.texture, comp.palette)
        end
        for i, prop in pairs(savedOutfit.props) do
            if prop.propIndex > -1 then
                SetPedPropIndex(ped, i, prop.propIndex, prop.propTexture, true)
            else
                ClearPedProp(ped, i)
            end
        end
        savedOutfit = nil
    end
end

local teamUniforms = {
    [1] = { -- Rød hold
        components = {
            { componentId = 11, drawable = 208, texture = 1, palette = 0 }, -- Shirt
            { componentId = 4,  drawable = 33, texture = 0, palette = 0 }, -- Bukser
            { componentId = 6,  drawable = 25, texture = 0, palette = 0 } -- Sko
            -- { componentId = 9,  drawable = 23, texture = 4, palette = 0 }  -- Vest (rød: texture 4)
        }
    },
    [2] = { -- Blå hold
        components = {
            { componentId = 11, drawable = 208, texture = 0, palette = 0 }, -- Shirt
            { componentId = 4,  drawable = 33, texture = 0, palette = 0 }, -- Bukser
            { componentId = 6,  drawable = 25, texture = 0, palette = 0 } -- Sko
            -- { componentId = 9,  drawable = 23, texture = 5, palette = 0 }  -- Vest (blå: texture 5)
        }
    },
    [3] = { -- Grøn hold
        components = {
            { componentId = 11, drawable = 208, texture = 2, palette = 0 }, -- Shirt
            { componentId = 4,  drawable = 33, texture = 0, palette = 0 }, -- Bukser
            { componentId = 6,  drawable = 25, texture = 0, palette = 0 } -- Sko
            -- { componentId = 9,  drawable = 23, texture = 0, palette = 0 }  -- Vest (grøn: texture 0)
        }
    }
}

function SetTeamUniform(team)
    local ped = PlayerPedId()
    local uniform = teamUniforms[team]
    if uniform and uniform.components then
        for _, comp in ipairs(uniform.components) do
            SetPedComponentVariation(ped, comp.componentId, comp.drawable, comp.texture, comp.palette)
        end
    end
end

RegisterNetEvent("KOTH:ApplyTeamUniform")
AddEventHandler("KOTH:ApplyTeamUniform", function(team)
    if not savedOutfit then
        SaveOutfit()
    end
    SetTeamUniform(team)
end)

RegisterNetEvent("KOTH:Leave")
AddEventHandler("KOTH:Leave", function()
    LoadOutfit()
    exports['pma-voice']:setRadioChannel(0)
end)

local NotSpam = false

RegisterCommand('koth', function()
    local bucket = lib.callback.await("KOTH:CheckBucket", 100)
    if bucket then
        lib.notify({
            title = 'Du kan ikke åbne menuen nu.',
            type = 'error'
        })
        return
    end

    lib.callback('koth:getPlayerCount', false, function(count)
        local playerCount = count or 0
    local teamCounts = lib.callback.await("KOTH:GetTeamCounts", 1000)
    local teamPoints = lib.callback.await("KOTH:GetTeamPoints", 1000)

    local redCount   = (teamCounts and teamCounts.red)   or 0
    local blueCount  = (teamCounts and teamCounts.blue)  or 0
    local greenCount = (teamCounts and teamCounts.green) or 0

    local redPoints   = (teamPoints and teamPoints.red)   or 0
    local bluePoints  = (teamPoints and teamPoints.blue)  or 0
    local greenPoints = (teamPoints and teamPoints.green) or 0

    local totalCount = redCount + blueCount + greenCount

    local leadingTeam, leadingPoints = "Rød", redPoints
    if bluePoints >= redPoints and bluePoints >= greenPoints then
        leadingTeam, leadingPoints = "Blå", bluePoints
    elseif greenPoints >= redPoints and greenPoints >= bluePoints then
        leadingTeam, leadingPoints = "Grøn", greenPoints
    end

    lib.registerContext({
        id = 'choose_team',
        title = 'KOTH - Vælg Hold',
        options = {
          {
            title = 'Antal Spillere: ' .. playerCount
          },
          {
            title = 'Førende: ' .. leadingTeam .. ' (' .. leadingPoints .. ' pts - mangler: '..(100-leadingPoints)..' pts)'
          },
          {
            title = 'Tilladte våben:',
            description = 'Deagle, Navy Revolver & Scorpion'
          },
          {
            title = 'Rød - ' .. redCount .. ' spillere (' .. redPoints .. ' pts)',
            icon = 'bars',
            iconColor = 'red',
            onSelect = function()
                if not NotSpam then
                    NotSpam = true
                    TriggerServerEvent("Koth-SelectTeam", 1)
                    exports['pma-voice']:setRadioChannel(1)
                    lib.hideContext()
                    SetTimeout(2000, function()
                        NotSpam = false
                    end)
                end
            end,
          },
          {
            title = 'Blå - ' .. blueCount .. ' spillere (' .. bluePoints .. ' pts)',
            icon = 'bars',
            iconColor = 'blue',
            onSelect = function()
                if not NotSpam then
                    NotSpam = true
                    TriggerServerEvent("Koth-SelectTeam", 2)
                    exports['pma-voice']:setRadioChannel(2)
                    lib.hideContext()
                    SetTimeout(2000, function()
                        NotSpam = false
                    end)
                end
            end,
          },
          {
            title = 'Grøn - ' .. greenCount .. ' spillere (' .. greenPoints .. ' pts)',
            icon = 'bars',
            iconColor = 'green',
            onSelect = function()
                if not NotSpam then
                    NotSpam = true
                    TriggerServerEvent("Koth-SelectTeam", 3)
                    exports['pma-voice']:setRadioChannel(3)
                    lib.hideContext()
                    SetTimeout(2000, function()
                        NotSpam = false
                    end)
                end
            end,
          }
        }
    })

    lib.showContext('choose_team')
end)
end)

function hideMainMenu()
    local data = {type = "hide"}
    SendNUIMessage(data)
    SetNuiFocus(false, false)

end

RegisterNUICallback('selectTeam', function(data, cb)
    local selectedTeam = data.selectedTeam

    if not NotSpam then
        TriggerServerEvent("Koth-SelectTeam", selectedTeam)
        NotSpam = true
    end
    
    cb({ok = true})
end)