let timeRealod;
let FeedCleaner
let interval;
let inv = [];
let name;
let count = 0;
let tempEvent = []

function GetName(str) {
    return str.slice(0, 20)
}

window.addEventListener('message', (event) => {
    let data = event.data;
    let hud = document.querySelector('#hud');

    if (data.showHud) {
        hud.style.display = 'flex';  // eller den ønskede styling for at vise hudden
    }

    if (data.hideHud) {
        hud.style.display = 'none';
    }

    // Resten af din eksisterende kode, fx opdatering af teams osv.
    if (data.teams) {
        data.teams.map(t => {
            if (t.color == 'red') {
                document.getElementById('redplayers').innerHTML = t.players;
                document.getElementById('redpoint').innerHTML = t.point;
                document.getElementById('redtarget').innerHTML = t.target;
            }
            if (t.color == 'blue') {
                document.getElementById('blueplayers').innerHTML = t.players;
                document.getElementById('bluepoint').innerHTML = t.point;
                document.getElementById('bluetarget').innerHTML = t.target;
            }
            if (t.color == 'green') {
                document.getElementById('greenplayers').innerHTML = t.players;
                document.getElementById('greenpoint').innerHTML = t.point;
                document.getElementById('greentarget').innerHTML = t.target;
            }
        });
    }


    // function newRightNotification(money, exp, reason) {
    //     rightNotifications.push([reason, money, exp])
    //     if (rightNotifications.length === 1) {
    //         displayNextRightNotification();
    //     };
    // };

    // function newRightNotifications(reason) {
    //     rightNotificationss.push([reason])
    //     if (rightNotificationss.length === 1) {
    //         displayNextRightNotifications();
    //     };
    // };

    // if (data.type == 'right') {
    //     newRightNotification(data.notif_money, data.notif_exp, data.notif_reason);
    // };
    // if (data.type == 'center') {
    //     newRightNotifications(data.notif_reasons);
    // };

    if (data.killer, data.killed, data.weaponkill, data.ca, data.cv) {
        newEvent(data.killer, data.killed, data.weaponkill, data.ca, data.cv);
        if (data.headshot) newEvent(data.killer, data.killed, data.weaponkill, data.ca, data.cv, data.headshot);
    };

    function newEvent(killer, victim, weapon, colora, colorv, headshot) {

        if (count <= 3) {
            createEvent(killer, victim, weapon, colora, colorv, headshot);
        }
        else {
            !headshot ? tempEvent.push({killer, victim, weapon, colora, colorv}) : tempEvent.push({killer, victim, weapon, colora, colorv, headshot});
            tempEvent.map(ev => {
                setTimeout(() => {
                    console.log(ev.killer)
                    !ev.headshot ? createEvent(ev.killer, ev.victim, ev.weapon, ev.colora, ev.colorv) : createEvent(ev.killer, ev.victim, ev.weapon, ev.colora, ev.colorv, ev.headshot)
                }, 10000);
            });
        };
        // console.log(JSON.stringify("New" + tempEvent))
    };

    function closeEvent() {
        tempEvent.shift();
        // console.log(JSON.stringify("Close" + tempEvent))
        document.getElementById("event-" + count).remove();
        count--
    };
});
clearTimeout(interval);
clearTimeout(timeRealod);
clearTimeout(FeedCleaner)
