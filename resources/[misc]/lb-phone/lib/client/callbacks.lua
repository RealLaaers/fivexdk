local waitingCallbacks = {}

local function GenerateRequestId()
    local requestId = math.random(999999999)

    while waitingCallbacks[requestId] do
        requestId = math.random(999999999)
    end

    return requestId
end

function TriggerCallback(event, cb, ...)
    local requestId = GenerateRequestId()

    waitingCallbacks[requestId] = cb

    SetTimeout(5000, function()
        if waitingCallbacks[requestId] then
            debugprint(("Callback ^1%s^7 timed out after 5s"):format(event))
            waitingCallbacks[requestId](nil)
            waitingCallbacks[requestId] = nil
        end
    end)

    TriggerServerEvent("lb-phone:cb:" .. event, requestId, ...)
end

function AwaitCallback(event, ...)
    local responsePromise = promise.new()

    TriggerCallback(event, function(...)
        responsePromise:resolve(...)
    end, ...)

    return Citizen.Await(responsePromise)
end

RegisterNetEvent("lb-phone:cb:response", function(requestId, ...)
    local cb = waitingCallbacks[requestId]

    if cb then
        cb(...)
        waitingCallbacks[requestId] = nil
    end
end)
