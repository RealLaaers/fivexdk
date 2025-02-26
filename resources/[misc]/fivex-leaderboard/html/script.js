$('body, .pop-up, .load-bar, .player-profile, .banner-input').hide();

/////////////////////////////////////////////////////////////////////////////////////////
// VARIABLES'S //
/////////////////////////////////////////////////////////////////////////////////////////

let cooldown = false;
let myData;
let boardData;
let ranks;

/////////////////////////////////////////////////////////////////////////////////////////
// PROG BAR'S //
/////////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////////////
// LISTENER AND SECOND BUILD FUNCTION'S //
/////////////////////////////////////////////////////////////////////////////////////////

window.addEventListener('message', function (event) {
    let e = event.data;
    switch (e.type) {
        case "OPEN_BOARD":
            $('body').fadeIn(1000);
            break;       
        case "CLOSE_BOARD":
            $('body').fadeOut(500);
            $('.pop-up, .load-bar, .player-profile, .banner-input').hide()
            break;
        case "SET_FIRST_MY_DATA":
            myData = e.object;
            setTimeout(() => {
                buildMyProfile();
            }, 500);
            break;
        case "SET_LEADERBOARD_DATA":
            boardData = e.object;
            setTimeout(() => {
                buildBoard();
            }, 500);
            break;
        default: break;
    }
});

/////////////////////////////////////////////////////////////////////////////////////////
// UI CONTROL'S //
/////////////////////////////////////////////////////////////////////////////////////////


$(document).on('click', '#banner-accept', function(){
    if (!cooldown) {
        cooldown = true;
        let bannerLink = $('#banner-link').val();
        if (bannerLink != "" && bannerLink != null && bannerLink.length > 5) {
           $.post('http://fivex-leaderboard/changeBanner', JSON.stringify({link: bannerLink}));
            $('.banner-input').fadeOut(250);
            setTimeout(() => {
                $('.load-bar').fadeIn(250);
                $('#myp-banner').attr('src', bannerLink);
                $('#myp-others-banner').attr('src', bannerLink);
                setTimeout(() => {
                    $('.pop-up').fadeOut(250);
                }, 500);
            }, 250);
            cooldown = false;
        }else {
            cooldown = false;
        }
    }
    
});

$(document).on('click', '#close-profile', function(){
    if (!cooldown) {
        cooldown = true;
        $('.player-profile').fadeOut(250);
        setTimeout(() => {
            $('.pop-up').hide();
        }, 250);
        cooldown = false;
    }
});

$(document).on('click', '#close-input', function(){
    if (!cooldown) {
        cooldown = true;
        $('.banner-input').fadeOut(250);
        setTimeout(() => {
            $('.pop-up').hide();
        }, 250);
        cooldown = false;
    }
});

$(document).on('click', '.player-lines', function(){
    if (!cooldown) {
        cooldown = true;
        $('.other-profile').html('');
        let identifier = $(this).data('identifier');
        let playerInformation = getIdentifierObject(identifier);
        $.each(playerInformation, function (k, v) { 
            let otherProfile = `
                <i id="close-profile" class="fa-solid fa-xmark"></i>
                <div class="myp-profiles">
                    <img id="myp-others-banner" src="${v.banner ? v.banner : "https://cdn.discordapp.com/attachments/671389525309784105/1074208947663282176/Banner_4.png"}">
                    <div class="mypp-information">
                        <div class="myp-pp">
                            <img src="${v.avatar}">
                        </div>
                        <div class="myp-names">
                            <div class="myp-name">
                                <span>${v.name}</span>
                            </div>
                            <div class="myp-hex">
                                <span>${v.identifier}</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="stats">
                    <div class="stat-div">
                        <div class="stat">
                            <div class="stat-icon">
                                <i class="fa-solid fa-skull"></i>
                            </div>
                            <div class="stat-text">
                                <span>Kills</span>
                            </div>
                            <div class="stat-count">
                                <span>${v.kills}</span>
                            </div>
                        </div>
                        <div class="stat">
                            <div class="stat-icon">
                                <i class="fa-solid fa-tombstone"></i>
                            </div>
                            <div class="stat-text">
                                <span>Death</span>
                            </div>
                            <div class="stat-count">
                                <span>${v.death}</span>
                            </div>
                        </div>
                    </div>
                    <div class="stat-div">
                        <div class="stat">
                            <div class="stat-icon">
                                <i class="fa-solid fa-gun"></i>
                            </div>
                            <div class="stat-text">
                                <span>KDA</span>
                            </div>
                            <div class="stat-count">
                                <span>${isNaN(v.kills / v.death) ? "0.0" : v.death == 0 ? v.kills : v.kills / v.death}</span>
                            </div>
                        </div>
                        <div class="stat">
                            <div class="stat-icon">
                                <i class="fa-solid fa-crown"></i>
                            </div>
                            <div class="stat-text">
                                <span>Rank</span>
                            </div>
                            <div class="stat-count">
                                <span id="rank-text">${v.rank}</span>
                            </div>
                        </div>
                    </div>
                    <div class="stat-div">
                        <div class="stat-country">
                            <div class="stat-country-icon">
                                <i class="fa-solid fa-flag"></i>
                            </div>
                            <div class="stat-country-text">
                                <span>Country</span>
                            </div>
                            <div class="stat-country-count">
                                <img class="country" src="img/flags-svg/${v.country.toLowerCase()}.svg">
                            </div>
                        </div>
                    </div>
                </div>
            `;
            $('.other-profile').append(otherProfile);
        });
        $('.pop-up').show();
        $('.load-bar').fadeIn(500);
        setTimeout(() => {
            $('.load-bar').fadeOut(500);
            setTimeout(() => {
                $('.other-profile').fadeIn(500);
            }, 500);
        }, 500);
        cooldown = false;
    }
});

window.onload = loaded

/////////////////////////////////////////////////////////////////////////////////////////
// MAIN BUILD UI FUNCTION'S //
/////////////////////////////////////////////////////////////////////////////////////////

function loaded() {
    $.post('http://fivex-leaderboard/nuiloaded', JSON.stringify({}));
}

function buildMyProfile() {
    $('.my-profile').html('');
    $.each(myData, function (k, v) { 
        let myProfile = `
            <div class="myp-profiles">
                <img id="myp-banner" src="${v.banner ? v.banner : "https://cdn.discordapp.com/attachments/671389525309784105/1074208947663282176/Banner_4.png"}">
                <div class="mypp-information">
                    <div class="myp-pp">
                        <img src="${v.avatar}">
                    </div>
                    <div class="myp-names">
                        <div class="myp-name">
                            <span>${v.name}</span>
                        </div>
                        <div class="myp-hex">
                            <span>${v.identifier}</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="stats">
                <div class="stat-div">
                    <div class="stat">
                        <div class="stat-icon">
                            <i class="fa-solid fa-skull"></i>
                        </div>
                        <div class="stat-text">
                            <span>Kill</span>
                        </div>
                        <div class="stat-count">
                            <span>${v.kills}</span>
                        </div>
                    </div>
                    <div class="stat">
                        <div class="stat-icon">
                            <i class="fa-solid fa-tombstone"></i>
                        </div>
                        <div class="stat-text">
                            <span>Death</span>
                        </div>
                        <div class="stat-count">
                            <span>${v.death}</span>
                        </div>
                    </div>
                </div>
                <div class="stat-div">
                    <div class="stat">
                        <div class="stat-icon">
                            <i class="fa-solid fa-gun"></i>
                        </div>
                        <div class="stat-text">
                            <span>KDA</span>
                        </div>
                        <div class="stat-count">
                            <span>${isNaN(v.kills / v.death) ? "0.0" : v.death == 0 ? v.kills : v.kills / v.death}</span>
                        </div>
                    </div>
                    <div class="stat">
                        <div class="stat-icon">
                            <i class="fa-solid fa-crown"></i>
                        </div>
                        <div class="stat-text">
                            <span>Rank</span>
                        </div>
                        <div class="stat-count">
                            <span id="rank-text">${v.rank}</span>
                        </div>
                    </div>
                </div>
                    <div class="stat-div">
                        <div class="stat-country">
                            <div class="stat-country-icon">
                                <i class="fa-solid fa-flag"></i>
                            </div>
                            <div class="stat-country-text">
                                <span>Country</span>
                            </div>
                            <div class="stat-country-count">
                                <img class="country" src="img/flags-svg/${v.country.toLowerCase()}.svg">
                            </div>
                        </div>
                    </div>
            </div>
        `
        $('.my-profile').append(myProfile);
    });
}

function buildBoard() {
    let rank = 1;
    $('.player-leaderboard').html('')
    $.each(boardData, function (k, v) { 
        let lines = `
        <div class="player-lines" data-identifier="${v.identifier}">
            <div class="player-rank">
                <span>#${rank}</span>
            </div>
            <div class="player-name">
                <span>${v.name}</span>
            </div>
            <div class="player-kill">
                <span>${v.kills}</span>
            </div>
            <div class="player-death">
                <span>${v.death}</span>
            </div>
        </div>
        `;
        $('.player-leaderboard').append(lines);
        rank = rank + 1;
    });
}



function getIdentifierObject(hex) {
    let object = {}
    $.each(boardData, function (k, v) { 
        if (hex == v.identifier) {
            object = {
                0: {
                    identifier: v.identifier,
                    name: v.name,
                    country: v.country,
                    kills: v.kills,
                    death: v.death,
                    avatar: v.avatar,
                    banner: v.banner,
                    points: v.points,
                    coins: v.coins,
                    rank: v.rank,
                }
            }
            return false;
        }
    });
    return object
}

$(".back-button").click(function () {
    $('body').fadeOut(500);
    $('.pop-up, .load-bar, .player-profile, .banner-input').hide()
    $.post('http://fivex-leaderboard/fivex-leaderboard:closeUI')
  })