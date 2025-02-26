--- Set your locale here
local lang = 'en'

--- Edit or add your own locales here
local strings = {
    ['en'] = {
        ['nui.duel.create'] = '+ Opret',
        ['nui.duel.inlobby'] = 'I Lobby',
        ['nui.duel.ranking'] = 'Ranking',
        ['nui.duel.matches'] = 'Kampe',
        ['nui.duel.createduel'] = 'Opret Duel',
        ['nui.duel.duelmode.label'] = 'Vælg Duel Mode',
        ['nui.duel.duelmode.placeholder'] = 'Vælg duel mode',
        ['nui.duel.movementType.label'] = 'Vælg Movement type',
        ['nui.duel.movementType.placeholder'] = 'Vælg Movement type',
        ['nui.duel.roundcount.label'] = 'Vælg antal runder',
        ['nui.duel.roundcount.placeholder'] = 'Antal runder',
        ['nui.duel.vest.label'] = 'Veste pr. runde',
        ['nui.duel.vest.placeholder'] = 'Antal veste pr. runde',
        ['nui.duel.weapon.label'] = 'Vælg våben',
        ['nui.duel.weapon.placeholder'] = 'Vælg våben til duellen',
        ['nui.duel.weapon.notfound'] = 'Intet våben fundet',
        ['nui.duel.map.text'] = 'Vælg en arena',
        ['nui.duel.password.label'] = 'Duel kode',
        ['nui.duel.password.description'] = 'Indtast en kode for at gøre duellen privat, lad være tom for at gøre den åben',
        ['nui.duel.create.submit'] = 'Opret Duel',
        ['nui.duel.rounds'] = 'RUNDER',
        ['nui.duel.vest'] = 'RUNDER',
        ['nui.duel.open'] = 'ÅBEN',
        ['nui.duel.private'] = 'PRIVAT',
        ['nui.duel.host'] = 'Host:',
        ['nui.duel.empty'] = 'Ingen nuværende dueller',
        ['nui.duel.playerlobby'] = 'Lobby',
        ['nui.duel.team1'] = 'Hold 1',
        ['nui.duel.team2'] = 'Hold 2',
        ['nui.duel.start'] = 'Start',
        ['nui.duel.leave'] = 'Forlad',
        ['nui.duel.join'] = 'Tilslut',
        ['nui.duel.noplayers'] = 'Ingen spillere i dette team',
        ['nui.lb.top'] = 'Top',
        ['nui.lb.name'] = 'Spiller',
        ['nui.lb.kd'] = 'K/D',
        ['nui.lb.wl'] = 'W/L',
        ['nui.prompt.message'] = 'Loader duel...',
        ['nui.match.round'] = 'Runde',
        ['nui.duel.mustweapon'] = 'Du skal vælge et våben',
        ['nui.duel.mustround'] = 'Du skal vælge antal runder',
        ['nui.duel.badvest'] = 'Du skal vælge antal veste',
        ['nui.duel.badround'] = 'Du kan ikke vælge mere end',
        ['nui.duel.badvest'] = 'Du kan ikke vælge mere end',
        ['nui.password.title'] = 'Indsæt kode',

        ['game.notready'] = 'Duels er ikke klar endnu',
        ['game.invalidmap'] = 'Ugyldigt map er valgt',
        ['game.lobbyhostleft'] = 'Du er blevet kicket fra lobbien fordi hosten forlod',
        ['game.nextround.win'] = 'Hold %s vandt runden!',
        ['game.nextround.draw'] = 'Ingen vandt runden (draw)',
        ['game.nextround.disconnect'] = 'En spiller forlod, kampen er afbrudt',
        ['game.nextround.finishdraw'] = 'Time Out! Ingen vandt runden (DRAW)',
        ['game.finishmatch.win'] = 'Hold %s vandt kampen!',
        ['game.finishmatch.timeout'] = 'Time Out! Hold %s vandt kampen!',
        ['game.finishmatch.draw'] = 'Ingen vandt kampen (DRAW)',
    },
    ['es'] = {
        ['nui.duel.create'] = '+ Crear',
        ['nui.duel.inlobby'] = 'En Sala',
        ['nui.duel.ranking'] = 'Ranking',
        ['nui.duel.matches'] = 'Salas',
        ['nui.duel.createduel'] = 'Crear Sala',
        ['nui.duel.duelmode.label'] = 'Modo de duelo',
        ['nui.duel.duelmode.placeholder'] = 'Selecciona el modo de duelo deseado',
        ['nui.duel.roundcount.label'] = 'Número de rondas',
        ['nui.duel.roundcount.placeholder'] = 'Introduce el número de rondas a jugar',
        ['nui.duel.weapon.label'] = 'Arma',
        ['nui.duel.weapon.placeholder'] = 'Selecciona el arma para el duelo',
        ['nui.duel.weapon.notfound'] = 'Arma no encontrada',
        ['nui.duel.map.text'] = 'Selecciona el mapa',
        ['nui.duel.password.label'] = 'Contraseña para la Sala',
        ['nui.duel.password.description'] = 'Introduce una contraseña para hacer la sala privada, deja en blanco para que sea abierta',
        ['nui.duel.create.submit'] = 'Crear Sala',
        ['nui.duel.rounds'] = 'RONDAS',
        ['nui.duel.open'] = 'ABIERTA',
        ['nui.duel.private'] = 'PRIVADA',
        ['nui.duel.host'] = 'Host:',
        ['nui.duel.empty'] = 'No hay salas, aún',
        ['nui.duel.playerlobby'] = 'Sala',
        ['nui.duel.team1'] = 'Equipo 1',
        ['nui.duel.team2'] = 'Equipo 2',
        ['nui.duel.start'] = 'Comenzar',
        ['nui.duel.leave'] = 'Salir',
        ['nui.duel.join'] = 'Entrar',
        ['nui.duel.noplayers'] = 'Este equipo no tiene jugadores',
        ['nui.lb.top'] = 'Top',
        ['nui.lb.name'] = 'Jugador',
        ['nui.lb.kd'] = 'K/D',
        ['nui.lb.wl'] = 'W/L',
        ['nui.prompt.message'] = 'Cargando duelo...',
        ['nui.match.round'] = 'Ronda',
        ['nui.duel.mustweapon'] = 'Debes seleccionar un arma',
        ['nui.duel.mustround'] = 'Debes introducir el número de rondas',
        ['nui.duel.badround'] = 'No puedes introducir mas de',
        ['nui.password.title'] = 'Introduce la contraseña',

        ['game.notready'] = 'Los duelos no están listos aún',
        ['game.invalidmap'] = 'Has seleccionado un mapa inválido',
        ['game.lobbyhostleft'] = 'Has sido expulsado de la sala porque el host se ha ido',
        ['game.nextround.win'] = 'El equipo %s ha ganado la ronda',
        ['game.nextround.draw'] = 'Nadie ha ganado la ronda (EMPATE)',
        ['game.nextround.disconnect'] = 'Un jugador se ha desconectado, la partida ha sido cancelada',
        ['game.nextround.finishdraw'] = '¡Tiempo Agotado! Nadie ha ganado la ronda (EMPATE)',
        ['game.finishmatch.win'] = 'El equipo %s ha ganado la partida',
        ['game.finishmatch.timeout'] = '¡Tiempo Agotado! El equipo %s ha ganado la partida!',
        ['game.finishmatch.draw'] = 'Nadie ha ganado la partida (EMPATE)',
    },
}

--- Check to know if used locale exists
if not strings[lang] then
    print(('[fivex_duels] [WARN] Locale %s not found, using en instead'):format(lang))
end

-- Dont touch this
function L(name, ...)
    if not strings[lang][name] then
        print(('[fivex_duels] [ERROR] Missing translation %s for locale %s'):format(name, lang))
        return 'Missing translation'
    end
    return strings[lang][name]:format(...)
end

-- Dont touch this
function GetLocales()
    return strings[lang]
end
