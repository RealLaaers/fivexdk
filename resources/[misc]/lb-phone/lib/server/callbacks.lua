---@param event string
---@param handler fun(source: number, ...) : any
function RegisterCallback(event, handler)
    RegisterNetEvent("lb-phone:cb:" .. event, function(requestId, ...)
        local src = source
        local startTime = os.nanotime()

        TriggerClientEvent("lb-phone:cb:response", src, requestId, handler(src, ...))

        local finishTime = os.nanotime()
        local ms = (finishTime - startTime) / 1e6

        debugprint(("Callback ^5%s^7 took %.4fms"):format(event, ms))
    end)
end

---@param event string
---@param handler fun(source: number, cb: function, ...)
function RegisterLegacyCallback(event, handler)
    RegisterNetEvent("lb-phone:cb:" .. event, function(requestId, ...)
        local src = source
        local startTime = os.nanotime()

        handler(src, function(...)
            TriggerClientEvent("lb-phone:cb:response", src, requestId, ...)

            local finishTime = os.nanotime()
            local ms = (finishTime - startTime) / 1e6

            debugprint(("Callback ^5%s^7 took %.4fms"):format(event, ms))
        end, ...)
    end)
end

---@param event string
---@param callback fun(source: number, phoneNumber: string, ...) : any
---@param defaultReturn any
function BaseCallback(event, callback, defaultReturn)
    RegisterCallback(event, function(source, ...)
        local phoneNumber = GetEquippedPhoneNumber(source)

        if not phoneNumber then
            return defaultReturn
        end

        return callback(source, phoneNumber, ...)
    end)
end
