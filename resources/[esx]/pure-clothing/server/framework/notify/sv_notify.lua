

function notifySystem(source, table)
    if not table then return end
    if not source then return end

    lib.notify(source, table)
end