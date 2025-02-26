$(() => {
    window.addEventListener('message', (event) => {
        switch (event.data.task) {
            case 'updateHud':
                if (event.data.info) {
                    $('.hud-health-inside').width(`${event.data.info.health}%`);
                    $('.hud-armor-inside').width(`${event.data.info.armor}%`);

                    if (event.data.info.health <= 0) {
                        $('.hud-health-inside').html(``);
                    } else {
                        $('.hud-health-inside').html(`${event.data.info.health}%`);
                    }

                    if (event.data.info.armor <= 0) {
                        $('.hud-armor-inside').html(``);
                    } else {
                        $('.hud-armor-inside').html(`${event.data.info.armor}%`);
                    }
                }
            break;

            case 'addKillfeed':
                var killData = event.data.info
                var killId = $('.killfeed-wrapper .killfeed-newKill').length

                if (killId >= 5) return
                $('.killfeed-wrapper').append(`
                    <div class="killfeed-newKill" id="killfeed-newKill-${killId}">
                        <span class="killfeed-killer" style="${killData.name == killData.killer ? 'color: red;' : 'color: white;'}">${killData.killer}</span>
                        <img src="https://vespura.com/fivem/weapons/images/${killData.weapon.toUpperCase()}.png" class="killfeed-weapon">${killData.headshot ? '<i class="fa-solid fa-crosshairs"></i>': ''}
                        <span class="killfeed-victim" style="${killData.name == killData.victim ? 'color: red;' : 'color: white;'}">${killData.victim}</span>
                    </div>
                `)

                setTimeout(() => {
                    $(`#killfeed-newKill-${killId}`).css({
                        'animation': 'hide 1s ease 0s 1 normal forwards'
                    });

                    setTimeout(() => {
                        $(`#killfeed-newKill-${killId}`).remove()
                    }, 500)
                }, 5000)
            break;

            case 'showPVPHud':
                $('.hud-wrapper').show();
                break;

            case 'hidePVPHud':
                $('.hud-wrapper').hide();
                break;

            case 'showGTAHud':
                $('.gtahud-wrapper').show();
                break;

            case 'hideGTAHud':
                $('.gtahud-wrapper').hide();
                break;
        }
    })
})
