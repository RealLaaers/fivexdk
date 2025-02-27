var royaleActive = false;
let weaponWheelVisible = false;
let weapons = [];
let currentSelection = 0;

// Initialize event listeners
$(document).ready(function () {
    // Listen for NUI messages from Lua
    window.addEventListener("message", function (event) {
        const data = event.data;

        switch (data.action) {
            case "openWeaponWheel":
                openWeaponWheel(data.weapons); // Pass the weapons data
                break;
            case "closeWeaponWheel":
                closeWeaponWheel();
                break;
            case "Update":
                UpdateUI(data.type, data);
                break;
            case "Draw":
                DrawText(data.type, data);
                break;
            case "empty":
                DrawReload(data.type, data);
                break;
        }
    });

    $(document).on('keyup', function (event) {
        if (event.code === "KeyG" && weaponWheelVisible) {
            closeWeaponWheel();
            selectWeapon();
        }
    });

    // Highlight weapon by mouse movement
    $(document).on("mousemove", function (event) {
        if (weaponWheelVisible && weapons.length > 0) {
            highlightWeaponByMouse(event.clientX, event.clientY);
        }
    });

});

// Open the weapon wheel
function openWeaponWheel(weaponData) {
    weapons = weaponData || [];
    weaponWheelVisible = true;
    populateWeaponWheel();
    $("#custom-weapon-wheel").fadeIn(200);
}

// Close the weapon wheel
function closeWeaponWheel() {
    weaponWheelVisible = false;
    $("#custom-weapon-wheel").fadeOut(200);
    $.post(`https://${GetParentResourceName()}/closeWeaponWheel`);
}

// Populate the weapon wheel with weapons
function populateWeaponWheel() {
    const weaponList = $("#weapon-list");
    weaponList.empty();

    const radius = 250; // Distance from the center
    const centerX = 300; // Center X of the wheel
    const centerY = 300; // Center Y of the wheel
    const angleIncrement = (Math.PI * 2) / (weapons.length + 1); // Adjusted for avoiding the bottom middle

    weapons.forEach((weapon, index) => {
        // Adjust the angle to avoid the bottom middle
        const angle = (angleIncrement * index) - (Math.PI / 2); // Start at the top

        // Calculate positions
        const x = centerX + radius * Math.cos(angle) - 40; // Adjust for item size
        const y = centerY + radius * Math.sin(angle) - 40;

        const listItem = $("<li>")
            .text(weapon.label)
            .data("hash", weapon.hash)
            .css({
                top: `${y}px`,
                left: `${x}px`,
            })
            .addClass(index === currentSelection ? "selected" : "");

        weaponList.append(listItem);
    });

    updateWeaponDisplay();
}




// Update the weapon name in the center
function updateWeaponDisplay() {
    const selectedWeapon = weapons[currentSelection];
    $("#weapon-display").text(selectedWeapon ? selectedWeapon.label : "Select a Weapon");
}

// Highlight the weapon based on mouse position
function highlightWeaponByMouse(mouseX, mouseY) {
    const centerX = window.innerWidth / 2;
    const centerY = window.innerHeight / 2;

    // Calculate the angle from the center of the wheel
    const angle = Math.atan2(mouseY - centerY, mouseX - centerX) + Math.PI; // Normalize to 0 - 2π range

    // Map the angle to the corresponding weapon index
    const angleIncrement = (2 * Math.PI) / weapons.length;
    const index = Math.floor(angle / angleIncrement) % weapons.length;

    // Only update if the index has changed
    if (index !== currentSelection) {
        currentSelection = index;
        highlightWeapon(index);
        updateWeaponDisplay();
    }
}


// Highlight a weapon
function highlightWeapon(index) {
    $("#weapon-list li").removeClass("selected");
    $("#weapon-list li").eq(index).addClass("selected");
}

// Select the currently highlighted weapon
function selectWeapon() {
    const selectedWeapon = weapons[currentSelection];
    if (selectedWeapon) {
        $.post(`https://${GetParentResourceName()}/SelectWeapon`, JSON.stringify({ weapon: selectedWeapon.hash }));
    }
}

function DrawReload(type, data) {
    if (type == "reload") {
        if (data.active) {
			$(".blackbg2").show()
			// $(".drawtext").show()
			$("#royale-text2").html(data.data.txt);
			$("#royale-char2").html(data.data.char);
        } else {
            royaleActive = false;
            // $(".drawtext").fadeOut(300);
            $(".blackbg2").fadeOut(100);
        }
    }
}

function DrawText(type, data) {
    if (type == "text") {
        if (data.active) {
			$(".blackbg").show()
			// $(".drawtext").show()
			$("#royale-text").html(data.data.txt);
			$("#royale-char").html(data.data.char);
        } else {
            royaleActive = false;
            // $(".drawtext").fadeOut(300);
            $(".blackbg").fadeOut(100);
        }
    }
}

function UpdateUI(type, data) {
    if (type == "royale") {
        if (data.active) {
            if (data.data.shrink) {
                royaleActive = true;
                $(".background").show()
                // $(".background2").show()
                $(".royale").show()
                $("#royale-position").html(data.data.ppllft + '/' + data.data.players + ' ALIVE' );
                $("#royale-points").html(data.data.myills);
                $("#royale-time").html('\u2614' + ' ' + data.data.time);
                $("#royale-skull").html("\u2620");
            } else {
                $(".background").show()
                // $(".background2").show()
                $(".royale").show()
                $("#royale-position").html(data.data.ppllft + '/' + data.data.players + ' ALIVE' );
                $("#royale-points").html(data.data.myills);
                $("#royale-time").html('\u2600 ' + ' ' + data.data.time);
                $("#royale-skull").html("\u2620");
            }
        } else {
			if (data.data.shrink == "gulag") {
                $(".background").fadeOut(300);
                // $(".background2").show()
                $(".royale").show()
                $("#royale-position").html(' ');
                $("#royale-points").html(' ');
                $("#royale-time").html(data.data.time);
                $("#royale-skull").html(" ");
			} else {
				royaleActive = false;
				$(".royale").fadeOut(300);
				$(".background").fadeOut(300);
			}
        }
    }
}