if GetResourceState('es_extended') ~= 'started' then return end
bridge = {}

local inDuel = false
local allowedWeapon = nil
local ox_inventory = GetResourceState('ox_inventory') == 'started' and exports.ox_inventory or nil

---Called when the UI is toggled
---@param toggled boolean true is opened false if closed
function bridge.toggledUI(toggled)
    -- any logic u want (set state or whatevet)
end

---Called when the match starts
---@param team string team1|team2
---@param weaponName string weapon name
function bridge.matchStarted(team, weaponName)
    inDuel = true
    allowedWeapon = weaponName
end

---Called when the match ends
---@param team string team1|team2
function bridge.finishedMatch(team)
    inDuel = false
    allowedWeapon = nil
end

---Used to send a notification
---@param text string message
---@param _type string type of notification (info, success, error...)
function bridge.notify(text, _type)
    lib.notify({
        title = 'Duels',
        description = text,
        type = _type
    })
end

--- By default the script does not have any option to open the ui, so i added a command as example.
RegisterCommand('duel', function()
    exports['fivex_duels']:toggleUI(true)
end, false)

AddEventHandler('ox_inventory:currentWeapon', function(weapon)
    if weapon then
        local ped = PlayerPedId()
        local coord = GetEntityCoords(ped)
        if inDuel then
            if allowedWeapon then
                if weapon.name ~= allowedWeapon then
                    TriggerEvent('ox_inventory:disarm', GetPlayerServerId(PlayerId()), true)
                    lib.notify({title = 'Dette våben er ikke tilladt i denne Duel.', type = 'error'})
                end
            end
        end
    end
end)