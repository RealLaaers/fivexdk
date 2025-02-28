print'Pug BattleRoyale 2.2.3'
local GameStated = false
local QueueTime = nil
local JoinedRoyale = false
local CoollDownActive = false
local vr = false
local hat = 0
local that = 0

-- Notification function
function BattleRoyaleNotify(msg, type, length)
    ESX.ShowNotification(msg)
end

-- Show DrawText function
function DrawTextOptiopnForSpectate(text)
    if GetResourceState('cd_drawtextui') == 'started' then
        TriggerEvent('cd_drawtextui:ShowUI', 'show', text)
    else
        --ESX.TextUI('[E] Jump', "error")
        lib.showTextUI('[E] - Hop')
    end
end

-- Hide DrawText function
function HideTextOptiopnForSpectate()
    if GetResourceState('cd_drawtextui') == 'started' then
        TriggerEvent('cd_drawtextui:HideUI')
    else
        --ESX.HideUI()
        lib.hideTextUI()
    end
end

local function LoadModel(model)
    if HasModelLoaded(model) then return end
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
end
local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end
local function RemoveVrAnimation()
    loadAnimDict('veh@common@fp_helmet@')
    TaskPlayAnim(PlayerPedId(), 'veh@common@fp_helmet@' ,'take_off_helmet_stand' ,8.0, -8.0, -1, 48, 0, false, false, false)
end
local function EquipVrAnimation()
    loadAnimDict('veh@common@fp_helmet@')
    TaskPlayAnim(PlayerPedId(), 'veh@common@fp_helmet@' ,'put_on_helmet' ,8.0, -8.0, -1, 48, 0, false, false, false)
end
function RoyalMatchHasBegun() -- You can add whatever you like as well for when players have started in the match
    TriggerEvent("Pug:Anticheat:FixRemovedGun")
end
function RoyalMatchHasEnded() -- You can add whatever you like as well for when players have Ended in the match
    TriggerEvent("Pug:Anticheat:FixRemovedGun")
end
CreateThread(function()
    if not Config.UseVrHeadSet then
        RoyalePed = Config.RoyalePed
        LoadModel(RoyalePed)
        RoyalePedMan = CreatePed(2, RoyalePed, Config.RoyalePedLoc, false, false)
        SetPedFleeAttributes(RoyalePedMan, 0, 0)
        SetPedDiesWhenInjured(RoyalePedMan, false)
        SetPedKeepTask(RoyalePedMan, true)
        SetBlockingOfNonTemporaryEvents(RoyalePedMan, true)
        SetEntityInvincible(RoyalePedMan, true)
        FreezeEntityPosition(RoyalePedMan, true)
        blip = AddBlipForCoord(Config.RoyalePedLoc.x, Config.RoyalePedLoc.y, Config.RoyalePedLoc.z)
        SetBlipSprite(blip, 197)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.75)
        SetBlipColour(blip, 3)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Battle Royale")
        EndTextCommandSetBlipName(blip)
        if not Config.DrawmarkerStartQueueLocation then
            if Config.Target == "ox_target" then
                exports.ox_target:addLocalEntity(RoyalePedMan, {
                    {
                        name = 'BattleRoyalePed',
                        event = 'Pug:client:ViewBattleRoyale',
                        icon = 'fas fa-clipboard',
                        label = "View Royale Lobby",
                    }
                })
            else
                exports[Config.Target]:AddTargetEntity(RoyalePedMan, {
                    options = {
                        {
                            event = 'Pug:client:ViewBattleRoyale',
                            icon = "fas fa-clipboard",
                            label = "View Royale Lobby",
                        },
                    },
                    distance = 2.5
                })
            end
        end
    end
end)

local function Armorjoint()
    if not UseArmor then
        UseArmor = true
    else
        return
    end

    local count = 20
    while count > 0 do
        Wait(350)
        count = count - 1
        SetPedArmour(PlayerPedId(), GetPedArmour(PlayerPedId()) + 5)
        if GetPedArmour(PlayerPedId()) == 100 then
            count = 0
        end
    end
    UseArmor = false
end
local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end
local function EquipArmorAnim()
    loadAnimDict("clothingshirt")        
    TaskPlayAnim(PlayerPedId(), "clothingshirt", "try_shirt_positive_d", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
end
local function AdrenEffect()
    local startStamina = 8
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.29)
    while startStamina > 0 do 
        Wait(1000)
        if math.random(5, 100) < 10 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(5, 100) < 51 then
            RestorePlayerStamina(PlayerId(), 0.9)
        end
    end
    startStamina = 0
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end
RegisterNetEvent("Pug:client:RoyaleHealBoost", function()
    local healing = false
    if not healing then
        healing = true
    else
        return
    end
    
    local count = 60
    while count > 0 do
        Wait(500)
        count = count - 1
        SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 25) 
    end
    healing = false
end)
RegisterNetEvent("Pug:Royale:ReloadSkin")
AddEventHandler("Pug:Royale:ReloadSkin", function()
	for k, v in pairs(GetGamePool('CObject')) do
		if IsEntityAttachedToEntity(PlayerPedId(), v) then
			SetEntityAsMissionEntity(v, true, true)
			DeleteObject(v)
			DeleteEntity(v)
		end
	end
	TriggerEvent("Pug:ReloadGuns:sling")
end)
RegisterNetEvent('Pug:client:GiveArmor', function()
    EquipArmorAnim()
    Armorjoint()
    TriggerServerEvent("hospital:server:SetArmor", GetPedArmour(PlayerPedId()))
    ClearPedTasks(PlayerPedId())
end)
RegisterNetEvent('Pug:client:GiveHealth', function()
    if Config.UseOxLibProgressBar then
        if lib.progressCircle({
            duration = 2000,
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
            },
        }) then 
            ClearPedBloodDamage(PlayerPedId())
            HealOxy()
        else 
            BattleRoyaleNotify("Canceled", "error")
        end
    else
        ESX.Progressbar("Healing...", 2000, {FreezePlayer = true, onFinish = function()
            ClearPedBloodDamage(PlayerPedId())
            HealOxy()
        end, onCancel = function()
            BattleRoyaleNotify("Canceled", "error")
        end})
    end
end)
RegisterNetEvent("Pug:client:UseRoyaleItem", function(item)
    if ClosedRoyaleInfo().ingame then
        if item.name == 'rifle_ammo_royale' then AddAmmoToPedByType(PlayerPedId(), GetHashKey('AMMO_RIFLE'), 10) TaskReloadWeapon(PlayerPedId(),false) elseif item.name == 'smg_ammo_royale' then AddAmmoToPedByType(PlayerPedId(), GetHashKey('AMMO_SMG'), 10) TaskReloadWeapon(PlayerPedId(),false) 
        elseif item.name == 'pistol_ammo_royale' then AddAmmoToPedByType(PlayerPedId(), GetHashKey('AMMO_PISTOL'), 4) TaskReloadWeapon(PlayerPedId(),false) elseif item.name == 'shotgun_ammo_royale' then AddAmmoToPedByType(PlayerPedId(), GetHashKey('AMMO_SHOTGUN'), 2) TaskReloadWeapon(PlayerPedId(),false) 
        elseif item.name == 'mg_ammo_royale' then AddAmmoToPedByType(PlayerPedId(), GetHashKey('AMMO_MG'), 10) TaskReloadWeapon(PlayerPedId(),false) elseif item.name == 'snp_ammo_royale' then AddAmmoToPedByType(PlayerPedId(), GetHashKey('AMMO_SNIPER'), 1) TaskReloadWeapon(PlayerPedId(),false) 
        elseif item.name == 'armorroyale_royale' then TriggerEvent("Pug:client:GiveArmor") elseif item.name == 'uav_royale' then TriggerEvent("Pug:client:UseUAV") elseif item.name == 'healthroyale_royale' then TriggerEvent("Pug:Royale:UseHealthJuice") 
        elseif item.name == 'armor1_royale' then TriggerEvent("Pug:client:WearArmorItem",1) elseif item.name == 'juice_royale' then TriggerEvent("Pug:client:UseRoyaleJuice",1) elseif item.name == 'jump_royale' then TriggerEvent("Pug:client:UseJumpShoes",1) elseif item.name == 'armor2_royale' then TriggerEvent("Pug:client:WearArmorItem",2) elseif item.name == 'armor3_royale' then TriggerEvent("Pug:client:WearArmorItem",3) 
        else
            for k, v in pairs(Config.RoyaleLoot) do
                if item.name == v.name then
                    GiveWeaponToPed(PlayerPedId(), GetHashKey(k), 1, false, false)
                    if not IsPedArmed(PlayerPedId(),7) then
                        SetCurrentPedWeapon(PlayerPedId(), GetHashKey(k), true)
                    end
                end
            end
        end
    else
        BattleRoyaleNotify(Translations.error.in_game, "error")
    end
end)
-- JUICE 
local healing = false
RegisterNetEvent('Pug:client:UseRoyaleJuice',function()
    if ClosedRoyaleInfo().ingame then
        local cup = GetHashKey("prop_food_bs_juice01")
        RequestModel(cup)
        while not HasModelLoaded(cup) do
            Wait(1)
        end
        local coords = GetEntityCoords(PlayerPedId())
        cupObject = CreateObject(cup, coords.x, coords.y, coords.z, 1, 1, 0)
        local bone1 = GetPedBoneIndex(PlayerPedId(), 28422)
        AttachEntityToEntity(cupObject, PlayerPedId(), bone1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
        if Config.UseOxLibProgressBar then
            if lib.progressCircle({
                duration = 4000,
                position = 'bottom',
                useWhileDead = false,
                canCancel = true,
                disable = {
                    car = true,
                },
            }) then 
                TriggerEvent("Pug:Royale:ReloadSkin")
                TriggerEvent("Pug:Royale:UseHealthJuice")
                Armorjoint()
                AdrenEffect()
            else 
                ClearPedTasks(PlayerPedId())
                BattleRoyaleNotify("Canceled", "error")
            end
        else
            ESX.Progressbar("Slurping...", 4000, {FreezePlayer = true, onFinish = function()
                TriggerEvent("Pug:Royale:ReloadSkin")
                TriggerEvent("Pug:Royale:UseHealthJuice")
                Armorjoint()
                AdrenEffect()
            end, onCancel = function()
                ClearPedTasks(PlayerPedId())
                BattleRoyaleNotify("Canceled", "error")
            end})
        end
    else
        BattleRoyaleNotify(Translations.error.in_game, "error")
    end
end)
RegisterNetEvent('Pug:Royale:UseHealthJuice', function()
    if not healing then
        healing = true
    else
        return
    end
    TriggerEvent("Pug:Client:StopBleeding")
    local count = 7
    while count > 0 do
        Wait(2000)
        count = count - 1
        SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 10) 
    end
    healing = false
end)
-- JUMP SHOES 
local SuperJump = false
RegisterNetEvent('Pug:client:UseJumpShoes',function()
    if ClosedRoyaleInfo().ingame then
        loadAnimDict("random@domestic")
        TaskPlayAnim(PlayerPedId(), 'random@domestic' ,'pickup_low' ,8.0, -8.0, 10000, 16, 0, false, false, false)
        SuperJump = true
        Wait(500)
        TriggerEvent("Pug:client:UseJumpShoesBreakEvent")
        ClearPedTasks(PlayerPedId())
        BattleRoyaleNotify(Translations.success.super_jump, "success")
        TriggerEvent("Pug:client:RoyaleHealBoost")
        while SuperJump do
            Wait(0)
            if SuperJump then
                SetSuperJumpThisFrame(PlayerId())
            else
                break
            end
        end
    else
        BattleRoyaleNotify(Translations.error.in_game, "error")
    end
end)
RegisterNetEvent('Pug:client:UseJumpShoesBreakEvent',function()
    Wait(60000)
    SuperJump = false
end)
-- UAV 
RegisterNetEvent('Pug:client:UseUAV',function()
    if ClosedRoyaleInfo().ingame then
        loadAnimDict("amb@code_human_in_bus_passenger_idles@female@tablet@idle_a")
        TaskPlayAnim(PlayerPedId(), 'amb@code_human_in_bus_passenger_idles@female@tablet@idle_a' ,'idle_a' ,8.0, -8.0, 10000, 16, 0, false, false, false)
        local Tablet = CreateObject(GetHashKey("prop_cs_tablet"), GetEntityCoords(PlayerPedId()))
        local bone = GetPedBoneIndex(PlayerPedId(), 28422)
        AttachEntityToEntity(Tablet, PlayerPedId(), bone, -0.05, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
        Wait(2000)
        TriggerServerEvent("Pug:server:EnemyUAVEffectForAll")
        Wait(1000)
        ClearPedTasks(PlayerPedId())
        TriggerEvent("Pug:Royale:ReloadSkin")
    else
        BattleRoyaleNotify(Translations.error.in_game, "error")
    end
end)
RegisterNetEvent('Pug:client:AcivateUav',function(coords,id)
    local uavblip = {}
    local alpha = 250
    uavblip[id] = AddBlipForRadius(coords.x,coords.y,coords.z, 7.0)
    SetBlipSprite(uavblip[id],9)
    SetBlipColour(uavblip[id],49)
    SetBlipAlpha(uavblip[id],alpha)
    SetBlipAsShortRange(uavblip[id], false)

    while alpha ~= 0 do
        Wait(100)
        alpha = alpha - 5
        SetBlipAlpha(uavblip[id], alpha)
        if alpha == 0 then
            RemoveBlip(uavblip[id])
            uavblip[id] = nil
            return
        end
    end
end)
RegisterNetEvent('Pug-VrHeadSet:toggle', function()
    local player = PlayerPedId()
	local ped = GetPlayerPed(-1)
    if IsPedModel(PlayerPedId(), 'mp_f_freemode_01') then
        if not vr then
            hat = GetPedPropIndex(PlayerPedId(),0) -- hat?
            that = GetPedPropTextureIndex(PlayerPedId(), 0)
            vr = true
            EquipVrAnimation()
            Wait(1500)
            StopAnimTask(PlayerPedId(), "veh@common@fp_helmet@", "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
            SetPedPropIndex(ped, 0, Config.VrHeadSetPropFemale, 0, 0)
            TaskStartScenarioInPlace(player, "PROP_HUMAN_PARKING_METER", 0, true)
        elseif vr then
            ClearPedTasks(player)
            vr = false
            RemoveVrAnimation()
            Wait(800)
            StopAnimTask(PlayerPedId(), "veh@common@fp_helmet@", "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
            if hat == -1 then
                ClearPedProp(PlayerPedId(), 0)
            else
                SetPedPropIndex(PlayerPedId(), 0, hat, that, 0)
            end
        end
    else
        if not vr then
            hat = GetPedPropIndex(PlayerPedId(),0) -- hat?
            that = GetPedPropTextureIndex(PlayerPedId(), 0)
            vr = true
            EquipVrAnimation()
            Wait(1500)
            StopAnimTask(PlayerPedId(), "veh@common@fp_helmet@", "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
            SetPedPropIndex(ped, 0, Config.VrHeadSetPropMale, 0, 0)
            TaskStartScenarioInPlace(player, "PROP_HUMAN_PARKING_METER", 0, true)
        elseif vr then
            ClearPedTasks(player)
            vr = false
            RemoveVrAnimation()
            Wait(800)
            StopAnimTask(PlayerPedId(), "veh@common@fp_helmet@", "take_off_helmet_stand", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
            if hat == -1 then
                ClearPedProp(PlayerPedId(), 0)
            else
                SetPedPropIndex(PlayerPedId(), 0, hat, that, 0)
            end
        end
    end
end)

local IslandPropsToRemove = {
	-1574151574,
	1215477734,
	-1697935936,
    -1439869581,
}

CreateThread(function()
    while true do
		for i=1, #IslandPropsToRemove do
			local coords = GetEntityCoords(PlayerPedId(), false)
			local Gates = GetClosestObjectOfType(coords.x, coords.y, coords.z, 100.0, IslandPropsToRemove[i], 0, 0, 0)
            if IslandPropsToRemove ~= 0 then
				SetEntityAsMissionEntity(Gates, 1, 1)
				DeleteObject(Gates)
				SetEntityAsNoLongerNeeded(Gates)
			end
		end
	   Wait(2500)
    end
end)

local function DrawText3Ds(x, y, z, text)
    local coords = vector3(x, y, z)
    local onScreen, worldX, worldY = World3dToScreen2d(coords.x, coords.y, coords.z)
    local camCoords = GetGameplayCamCoord()
    local scale = 300 / (GetGameplayCamFov() * #(camCoords - coords))
    if onScreen then
        SetTextScale(1.0, 0.5 * scale)
        SetTextFont(4)
        SetTextColour(255, 255, 255, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextProportional(1)
        SetTextOutline()
        SetTextCentre(1)
        BeginTextCommandDisplayText("STRING")
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandDisplayText(worldX, worldY)
    end
end

local DrawTextOption = "~g~Join~w~ Battle Royale"
if Config.DrawmarkerStartQueueLocation then
    RegisterNetEvent('Pug:client:removeFromRoyale2',function()
        JoinedRoyale = false
    end)
    RegisterNetEvent('Pug:client:joinedRoyale2',function()
        JoinedRoyale = true
    end)
    CreateThread(function()
        while true do
            Wait(1)
            local PlyCoords = GetEntityCoords(PlayerPedId())
            if #(PlyCoords - Config.RoyaleStartLoc) <= 20 then
                if CoollDownActive then
                    DrawTextOption = "~b~On Cool Down~b~"
                elseif QueueTime then
                    DrawTextOption = "~g~[E] ~w~Join Battle Royale~w~ | ~b~".. QueueTime
                elseif GameStated then
                    DrawTextOption = "~r~OnGoing Game~r~"
                else
                    DrawTextOption = "~g~Join~w~ Battle Royale"
                end
                DrawText3Ds(Config.RoyaleStartLoc.x, Config.RoyaleStartLoc.y, Config.RoyaleStartLoc.z, DrawTextOption)
                DrawMarker(Config.MarkerStartRoyaleLocation.Type, Config.RoyaleStartLoc.x, Config.RoyaleStartLoc.y, Config.RoyaleStartLoc.z-1, 0.1, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerStartRoyaleLocation.Scale.x, Config.MarkerStartRoyaleLocation.Scale.y, Config.MarkerStartRoyaleLocation.Scale.z, Config.MarkerStartRoyaleLocation.Color.r, Config.MarkerStartRoyaleLocation.Color.g, Config.MarkerStartRoyaleLocation.Color.b, Config.MarkerStartRoyaleLocation.Color.a, false, true, 2, false, false, false, false)
                if IsControlJustPressed(0, 38) then
                    if not GameStated then
                        if not CoollDownActive then
                            if not JoinedRoyale then
                                ESX.TriggerServerCallback('Pug:serverCB:CheckongoingRoyale', function(gamestatus)
                                    if gamestatus then
                                    else
                                        JoinedRoyale = true
                                        TriggerServerEvent('Pug:server:JoinRoyale')
                                    end
                                end)
                            else
                                BattleRoyaleNotify("you have already joined", "error")
                            end
                        else
                            BattleRoyaleNotify(Translations.error.active_game, "error")
                        end
                    else
                        BattleRoyaleNotify(Translations.error.closing_game, "error")
                    end
                end
            else
                Wait(1000)
            end
        end
    end)
end
function SecondsToClock(seconds)
    local seconds = tonumber(seconds)
    if seconds <= 0 then
        return "00:00:00";
    else
        hours = string.format("%02.f", math.floor(seconds/3600));
        mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
        secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
        return mins..":"..secs
    end
end
RegisterNetEvent("Pug:client:UpdateRoyaleQueueTime", function(Verible)
    local Seconds = math.ceil(Verible / 1000)
    local FinalTime = SecondsToClock(Seconds)
    QueueTime = FinalTime
end)
RegisterNetEvent("Pug:client:UpdateAllGameHasStarted", function()
    QueueTime = nil
    GameStated = true
    CoollDownActive = false
end)

RegisterNetEvent("Pug:client:UpdateAllGameHasEnded", function()
    GameStated = false
    QueueTime = nil
    CoollDownActive = false
end)

RegisterNetEvent("Pug:client:UpdateAllGameCoolDownActive", function()
    CoollDownActive = true
end)

RegisterNetEvent("Pug:showNotificationBR", function(msg, type, length)
    BattleRoyaleNotify(msg, type, length)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
	Wait(500)
    ESX.TriggerServerCallback('Pug:serverCB:GetBrInfo', function(Info)
        if Info then
            GameStated = Info.Started
            CoollDownActive = Info.CoolDown
        end
    end)
end)

function CheckingIfDeadFunction() -- NEVER CHANGE THIS UNLESS I HAVE DIRECTED YOU TO.
    return IsPedFatallyInjured(PlayerPedId()) 
    -- IF YOU HAVE AN ISSUE WITH YOUR DEATH NOT REGISTERING, HASH OUT THE LINE ABOVE THIS AND THEN UNHASH THE LINE BELOW THIS
    -- return LocalPlayer.state.isDead
end

RegisterNetEvent("Pug:client:BattleRoyaleReviveEvent", function()
    TriggerEvent('healffs2')
    -- TriggerEvent('ak47_qb_ambulancejob:revive')
    -- TriggerEvent('ak47_qb_ambulancejob:skellyfix')
    -- TriggerEvent('hospital:client:Revive')
    -- TriggerEvent('esx_ambulancejob:revive')
    -- TriggerEvent('wasabi_ambulance:revive')
    -- TriggerEvent('visn_are:resetHealthBuffer')
end)