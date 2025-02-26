lib.addCommand('reloadskin', {help = _Lang('commands.reloadskin.help')}, function(source)
    TriggerClientEvent('pure-clothing:reloadSkin', source)
end)