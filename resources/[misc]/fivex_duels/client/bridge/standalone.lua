if bridge ~= nil then return end
bridge = {}

---Called when the UI is toggled
---@param toggled boolean true is opened false if closed
function bridge.toggledUI(toggled)
    -- any logic u want (set state or whatevet)
end

---Called when the match starts
---@param team string team1|team2
---@param weaponName string weapon name
function bridge.matchStarted(team, weaponName)
    -- any logic u want (put clothing or whatever)
end

---Called when the match ends
---@param team string team1|team2
function bridge.finishedMatch(team)
    -- any logic u want (remove clothing or whatever)
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

--[[
---If you want to use custom loading prompt (not needed in standalone)
function bridge.showLoadingPrompt(msg)
    SendNUIMessage({
        action = 'toggleLoadingPrompt',
        data = {
            state = true
        }
    })
end
--]]

--[[
---If you want to use custom loading prompt (a must if you using custom) (not needed in standalone)
function bridge.hideLoadingPrompt()
    SendNUIMessage({
        action = 'toggleLoadingPrompt',
        data = {
            state = false
        }
    })
end
--]]

--- By default the script does not have any option to open the ui, so i added a command as example.
RegisterCommand('duel', function()
    exports['fivex_duels']:toggleUI(true)
end, false)
