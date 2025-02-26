function closeMenu() {
    $("body").fadeOut(300);
    $('#vote').css('display', 'none');
    $('#main').css('display', 'none');
    $("#group-1").css('display', 'none');
    $("#hudBox").css('display', 'none');
    $.post('https://fivex-gungame/closeMenu');
}

let waitTime = 30
let canVote = true

function startTimer() {
    let total = waitTime

    let interval = setInterval(() => {
        if (total < 1) {
            clearInterval(interval) 
            $("body").fadeOut(300);
            $('#vote').css('display', 'none');
            closeMenu()
            return
        }
        total--
        $("#voteSubTitle").text("SELECT NEXT MAP IN " + total + " SECONDS")
    }, 1000)
}

document.addEventListener('DOMContentLoaded', function () {

    window.addEventListener("message", (event) => {
        if (event.data.type === "openMainMenu") {
            let textaga = JSON.parse(event.data.texts)
            $('#vote').css('display', 'none');
            $('#main').css('display', 'flex');
            $.post('https://fivex-gungame/FetchLeaderboard');
            $('#titleTextthug').text(`${textaga.MainText}`);
            $('#titleSubTextthug').text(`${textaga.SubText}`);
            $('#infoTitlethug').text(textaga.InfoBoxText);
            $('#infoTextthug').text(textaga.InfoText);
            $('#profileTextthug').text(event.data.player_name);
            $('#profileSubTextthug').text("ID - "+event.data.player_id)
            $('#killcount').text(event.data.player_kill);
            $('#deathcount').text(event.data.player_death);
            $('#wincount').text(event.data.player_win);
            $("#profileImg").css({"background-image": "url("+event.data.player_photo+")"})
            $('#mapName').text(event.data.gungame_map);
            $('#mapSubName').text(event.data.gungame_map_desc);
            $('#mapInfoSubText').text(event.data.gungame_map_info);
            $("#mapBg").attr("src",event.data.gungame_map_img);
            $('#mapButton').css('display', 'flex');
            $('#mapOnlineBox').css('display', 'flex');
            $("#mapOnlineSay").html('<h2 class="mapOnlineSay" id="mapOnlineSay">'+event.data.gungame_players+'<span>/'+event.data.gungame_map_max_player+'</span></h2>')
            $("#mapStatus").css({"background": "rgb(103, 255, 100)"})
            $("#mapStatus").css({"box-shadow": "0px 0px 2.1302vw 0px rgba(103, 255, 100, 0.4)"})
            $("body").fadeIn(300);
        } else if (event.data.type === "openMainMenuNotAvailable") {
            let textaga = JSON.parse(event.data.texts)
            $('#vote').css('display', 'none');
            $('#main').css('display', 'flex');
            $('#mapButton').css('display', 'none');
            $('#mapOnlineBox').css('display', 'none');
            $("#mapStatus").css({"background": "rgb(247, 47, 47)"})
            $("#mapStatus").css({"box-shadow": "0px 0px 2.1302vw 0px rgb(255 100 100 / 40%)"})
            $('#titleTextthug').text(`${textaga.MainText}`);
            $('#titleSubTextthug').text(`${textaga.SubText}`);
            $('#infoTitlethug').text(textaga.InfoBoxText);
            $('#infoTextthug').text(textaga.InfoText);
            $('#profileTextthug').text(event.data.player_name);
            $('#profileSubTextthug').text("ID - "+event.data.player_id)
            $('#killcount').text(event.data.player_kill);
            $('#deathcount').text(event.data.player_death);
            $('#wincount').text(event.data.player_win);
            $('#mapName').text("Map Voting...");
            $('#mapSubName').text("You can't join in during voting!");
            $('#mapInfoSubText').text("Gungame round is over and players vote on new map...");
            $("#mapBg").attr("src","./img/voting.png");
            $("body").fadeIn(300);
        } else if (event.data.type === "updateLeader") {
          let data = event.data.data

          $(".playerList").html("");

          var playerArray = Object.entries(data).map(([key, value]) => ({ key, ...value }));
          playerArray.sort((a, b) => b.win - a.win);
  
          for (var i = 0; i < playerArray.length; i++) {
              var player = playerArray[i];
              var rank = i + 1;
              
              $(".playerList").append(`
              <div class="playerBox">
              <div class="playerProfileBox">
                <div
                  class="playerProfileImg"
                  style="
                    background-image: url(${player.photo});
                  "
                ></div>
                <div class="playerProfileTextBox">
                  <h2 class="playerProfileText">${player.ply_name}</h2>
                  <p class="playerProfileSubText">Ranked #${rank}</p>
                </div>
              </div>
              <div class="playerInfoBox">
                <div class="playerInfo">
                  <p class="playerInfoTitle">WIN</p>
                  <div class="playerInfoTextBox">
                    <h2 class="playerInfoText">${player.win}</h2>
                  </div>
                </div>
                <div class="playerInfo">
                  <p class="playerInfoTitle">Kills;</p>
                  <div class="playerInfoTextBox">
                    <svg
                      width=".7vw"
                      height=".7vw"
                      viewBox="0 0 17 17"
                      fill="none"
                      xmlns="http://www.w3.org/2000/svg"
                    >
                      <g id="game-icons:laser-gun" clip-path="url(#clip0_8_43)">
                        <path
                          id="Vector"
                          d="M7.48914 0.55545C7.38899 0.55545 7.29294 0.595234 7.22213 0.666048C7.15131 0.736863 7.11153 0.832908 7.11153 0.933055V2.52214C4.43274 2.97158 2.39148 5.30099 2.39148 8.10753C2.39148 10.9141 4.43274 13.2435 7.11153 13.6929V15.282C7.11153 15.3822 7.15131 15.4782 7.22213 15.549C7.29294 15.6198 7.38899 15.6596 7.48914 15.6596H8.62195C8.7221 15.6596 8.81814 15.6198 8.88895 15.549C8.95977 15.4782 8.99955 15.3822 8.99955 15.282V13.6929C11.6783 13.2435 13.7196 10.9141 13.7196 8.10753C13.7196 5.30099 11.6783 2.97158 8.99955 2.52214V0.933055C8.99955 0.832908 8.95977 0.736863 8.88895 0.666048C8.81814 0.595234 8.7221 0.55545 8.62195 0.55545H7.48914ZM7.11153 5.43677V6.31391C7.11153 6.41406 7.15131 6.51011 7.22213 6.58092C7.29294 6.65173 7.38899 6.69152 7.48914 6.69152H8.62195C8.7221 6.69152 8.81814 6.65173 8.88895 6.58092C8.95977 6.51011 8.99955 6.41406 8.99955 6.31391V5.43677C10.0995 5.82558 10.8876 6.8745 10.8876 8.10753C10.8876 9.34057 10.0995 10.3895 8.99955 10.7783V9.90115C8.99955 9.80101 8.95977 9.70496 8.88895 9.63415C8.81814 9.56333 8.7221 9.52355 8.62195 9.52355H7.48914C7.38899 9.52355 7.29294 9.56333 7.22213 9.63415C7.15131 9.70496 7.11153 9.80101 7.11153 9.90115V10.7783C6.0116 10.3895 5.22351 9.34057 5.22351 8.10753C5.22351 6.8745 6.0116 5.82555 7.11153 5.43677Z"
                          fill="white"
                        />
                      </g>
                      <defs>
                        <clipPath id="clip0_8_43">
                          <rect
                            width="16.1111"
                            height="16.1111"
                            fill="white"
                            transform="translate(0 0.0519714)"
                          />
                        </clipPath>
                      </defs>
                    </svg>
                    <h2 class="playerInfoText">${player.kill}</h2>
                  </div>
                </div>
                <div class="playerInfo">
                  <p class="playerInfoTitle">Deaths;</p>
                  <div class="playerInfoTextBox">
                    <svg
                      width="0.7vw"
                      height="0.7vw"
                      viewBox="0 0 16 16"
                      fill="none"
                      xmlns="http://www.w3.org/2000/svg"
                    >
                      <g id="material-symbols:skull">
                        <path
                          id="Vector"
                          d="M7.00004 10.5H9.00004L8.00004 8.50001L7.00004 10.5ZM5.66671 8.66668C6.03338 8.66668 6.34738 8.53623 6.60871 8.27534C6.87004 8.01445 7.00049 7.70045 7.00004 7.33334C6.9996 6.96623 6.86915 6.65245 6.60871 6.39201C6.34827 6.13157 6.03427 6.0009 5.66671 6.00001C5.29915 5.99912 4.98538 6.12979 4.72538 6.39201C4.46538 6.65423 4.33471 6.96801 4.33338 7.33334C4.33204 7.69868 4.46271 8.01268 4.72538 8.27534C4.98804 8.53801 5.30182 8.66845 5.66671 8.66668ZM10.3334 8.66668C10.7 8.66668 11.014 8.53623 11.2754 8.27534C11.5367 8.01445 11.6672 7.70045 11.6667 7.33334C11.6663 6.96623 11.5358 6.65245 11.2754 6.39201C11.0149 6.13157 10.7009 6.0009 10.3334 6.00001C9.96582 5.99912 9.65204 6.12979 9.39204 6.39201C9.13204 6.65423 9.00138 6.96801 9.00004 7.33334C8.99871 7.69868 9.12938 8.01268 9.39204 8.27534C9.65471 8.53801 9.96849 8.66845 10.3334 8.66668ZM4.00004 14.6667V11.8333C3.56671 11.6445 3.18604 11.3918 2.85804 11.0753C2.53004 10.7589 2.25227 10.4005 2.02471 10C1.79715 9.59957 1.62493 9.17179 1.50804 8.71668C1.39115 8.26157 1.33293 7.80045 1.33338 7.33334C1.33338 5.57779 1.9556 4.1389 3.20004 3.01668C4.44449 1.89445 6.04449 1.33334 8.00004 1.33334C9.9556 1.33334 11.5556 1.89445 12.8 3.01668C14.0445 4.1389 14.6667 5.57779 14.6667 7.33334C14.6667 7.80001 14.6085 8.26112 14.492 8.71668C14.3756 9.17223 14.2034 9.60001 13.9754 10C13.7474 10.4 13.4696 10.7585 13.142 11.0753C12.8145 11.3922 12.4338 11.6449 12 11.8333V14.6667H10V13.3333H8.66671V14.6667H7.33338V13.3333H6.00004V14.6667H4.00004Z"
                          fill="white"
                        />
                      </g>
                    </svg>

                    <h2 class="playerInfoText">${player.death}</h2>
                  </div>
                </div>
              </div>
            </div>
            `)  
          }
        } else if (event.data.type === "showHud") {
            $("body").fadeIn(300);
            $('#main').css('display', 'none');
            $('#vote').css('display', 'none');
            $('#activeWeapon').text(event.data.activeweapon);
            $('#nextWeapon').text(event.data.nextweapon);
            $('#killsLeft').text(event.data.killsleft);
            $("#weaponsLeft").text(event.data.weaponsleft);
            $("#hudBox").fadeIn(300);
        } else if (event.data.type === "hideHud") {
            $("#hudBox").fadeOut(300);
            $("body").fadeOut(300);
        } else if (event.data.type === "updateKillsLeft") {
            $('#killsLeft').text(event.data.killsleft);
        } else if (event.data.type === "updateLevel") {
            $('#activeWeapon').text(event.data.activeweapon);
            $('#nextWeapon').text(event.data.nextweapon);
            $('#killsLeft').text(event.data.killsleft);
            $("#weaponsLeft").text(event.data.weaponsleft);
        } else if (event.data.type === "levelNotify") {
            $('#notifyNewWeapon').text(event.data.activeweapon);
            $('#notifyBox').css('display', 'flex');
        } else if (event.data.type === "notifyHide") {
            $("#notifyBox").fadeOut(300);
        } else if (event.data.type === "showVoteScreen") {
            startTimer()
            $("body").fadeIn(300);
            $("#voteSubTitle").text("SELECT NEXT MAP IN 30 SECONDS")
            $('#main').css('display', 'none');
            $("#vote").fadeIn(300);
            $(".voteMapList").html("");
            canVote = true
            event.data.voteMaps.forEach(mapaga => {
                var voteMapBox = document.createElement('div');
                voteMapBox.classList.add('voteMapBox');
    
                voteMapBox.innerHTML = `
                <div class="mapTopSide">
                <div class="mapNameBox">
                  <div class="mapNameIcon">
                    <svg
                      width="1.4063vw"
                      height="1.4063vw"
                      viewBox="0 0 27 27"
                      fill="none"
                      xmlns="http://www.w3.org/2000/svg"
                    >
                      <g id="material-symbols:map">
                        <path
                          id="Vector"
                          d="M16.9692 23.363L10.5754 21.1252L5.62013 23.0433C5.26492 23.1854 4.93635 23.1456 4.63442 22.924C4.33248 22.7023 4.18152 22.4047 4.18152 22.031V7.11203C4.18152 6.88114 4.2483 6.67689 4.38186 6.49929C4.51542 6.32168 4.69729 6.18847 4.92747 6.09967L10.5754 4.18152L16.9692 6.41936L21.9244 4.50121C22.2796 4.35913 22.6082 4.39926 22.9101 4.62163C23.2121 4.84399 23.363 5.1413 23.363 5.51357V20.4325C23.363 20.6634 23.2966 20.8677 23.1638 21.0453C23.0309 21.2229 22.8487 21.3561 22.6171 21.4449L16.9692 23.363ZM15.9036 20.7522V8.28423L11.641 6.79234V19.2603L15.9036 20.7522Z"
                          fill="white"
                        />
                      </g>
                    </svg>
                  </div>
                  <div class="mapNameTextBox">
                    <h2 class="mapName">${mapaga.name}</h2>
                  </div>
                </div>
              </div>
              <div class="mapInfoBox">
                <h2 class="mapInfoText">Map Information</h2>
                <p class="mapInfoSubText">
                  ${mapaga.information}
                </p>
              </div>
              <div class="mapButton" data-id="${mapaga.id}">
                <svg
                  viewBox="0 0 27 27"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <g id="ion:log-in">
                    <path
                      id="Vector"
                      d="M20.6719 4.21875H12.2344C11.4514 4.21959 10.7008 4.53099 10.1471 5.08463C9.59349 5.63826 9.28209 6.38891 9.28125 7.17188V12.6562H17.3691L14.5911 9.87768C14.4395 9.71815 14.3563 9.50574 14.3591 9.28572C14.3619 9.06571 14.4506 8.85549 14.6062 8.6999C14.7617 8.54431 14.972 8.45566 15.192 8.45284C15.412 8.45003 15.6244 8.53327 15.7839 8.68482L20.0027 12.9036C20.1608 13.0618 20.2496 13.2763 20.2496 13.5C20.2496 13.7237 20.1608 13.9382 20.0027 14.0964L15.7839 18.3152C15.6244 18.4667 15.412 18.55 15.192 18.5472C14.972 18.5443 14.7617 18.4557 14.6062 18.3001C14.4506 18.1445 14.3619 17.9343 14.3591 17.7143C14.3563 17.4943 14.4395 17.2818 14.5911 17.1223L17.3691 14.3438H9.28125V19.8281C9.28125 21.5183 11.0631 22.7812 12.6562 22.7812H20.6719C21.4548 22.7804 22.2055 22.469 22.7591 21.9154C23.3128 21.3617 23.6242 20.6111 23.625 19.8281V7.17188C23.6242 6.38891 23.3128 5.63826 22.7591 5.08463C22.2055 4.53099 21.4548 4.21959 20.6719 4.21875ZM4.21875 12.6562C3.99497 12.6562 3.78036 12.7451 3.62213 12.9034C3.4639 13.0616 3.375 13.2762 3.375 13.5C3.375 13.7238 3.4639 13.9384 3.62213 14.0966C3.78036 14.2549 3.99497 14.3438 4.21875 14.3438H9.28125V12.6562H4.21875Z"
                    />
                  </g>
                </svg>
                Vote
              </div>
              <div class="mapVoteBox">
                <div class="mapOnlineTitle">
                  <svg
                    width="2.3958vw"
                    height="1.9271vw"
                    viewBox="0 0 46 37"
                    fill="none"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <g id="fa-solid:vote-yea" clip-path="url(#clip0_18_595)">
                      <path
                        id="Vector"
                        d="M43.7 23H39.1V27.6H40.71C41.0909 27.6 41.4 27.8588 41.4 28.175V29.325C41.4 29.6413 41.0909 29.9 40.71 29.9H5.29C4.90906 29.9 4.6 29.6413 4.6 29.325V28.175C4.6 27.8588 4.90906 27.6 5.29 27.6H6.9V23H2.3C1.02781 23 0 24.0278 0 25.3V32.2C0 33.4722 1.02781 34.5 2.3 34.5H43.7C44.9722 34.5 46 33.4722 46 32.2V25.3C46 24.0278 44.9722 23 43.7 23ZM36.8 27.6V4.62157C36.8 3.335 35.7578 2.3 34.4784 2.3H11.5287C10.2422 2.3 9.2 3.34219 9.2 4.62157V27.6H36.8ZM15.18 14.5188L17.0128 12.7003C17.3147 12.3984 17.8034 12.3984 18.1053 12.7075L21.0737 15.6975L27.9162 8.9125C28.2181 8.61063 28.7069 8.61063 29.0087 8.91969L30.8272 10.7525C31.1291 11.0544 31.1291 11.5431 30.82 11.845L21.5984 20.9875C21.2966 21.2894 20.8078 21.2894 20.5059 20.9803L15.18 15.6113C14.8709 15.3094 14.8781 14.8206 15.18 14.5188Z"
                        fill="#67FF64"
                      />
                    </g>
                    <defs>
                      <clipPath id="clip0_18_595">
                        <rect width="46" height="36.8" fill="white" />
                      </clipPath>
                    </defs>
                  </svg>
    
                  Vote
                </div>
                <h2 class="mapOnlineSay" id="${mapaga.id}votecount">0</h2>
              </div>
              <img src="${mapaga.imageUrl}" alt="" class="mapBg" />
                `;
    
                document.querySelector('.voteMapList').appendChild(voteMapBox);
    
    
                voteMapBox.querySelector('.mapButton').addEventListener('click', function () {
                    var mapId = this.getAttribute('data-id');
                    if (canVote == true) {
                      canVote = false
                      $.post('https://fivex-gungame/updateVote', JSON.stringify({
                          map: mapId,
                      }));
                    }
                });

            });
        } else if (event.data.type === "updateVoteScreen") {
            $('#'+event.data.mapid+'votecount').text(event.data.votecount);
        } else if (event.data.type === "hideVoteScreen") {
            $("#vote").fadeOut(300);
            canVote = true
        } else if (event.data.type === "closeMainMenu") {
            closeMenu()
        } else if (event.data.type === "WinnerShow") {
            $("#hudBox").fadeOut(300);
            $("#winnername").text(event.data.winner.toUpperCase())
            $("#group-1").fadeIn(300);
        } else if (event.data.type === "WinnerHide") {
            $("#group-1").fadeOut(300);
        }
    });

    document.querySelector('#mapButton').addEventListener('click', function () {
        $.post('https://fivex-gungame/joinGungame');
    });

    document.onkeydown = function (data) {
        if (data.which == 27) {
            setTimeout(function () {
                closeMenu()
            }, 250)
        }
    }
})