if Config.framework ~= 'qbcore' then return end

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    PlayerData = QBCore.Functions.GetPlayerData()
    initiateApperance()
end)

RegisterNetEvent("qb-clothes:client:CreateFirstCharacter", function()
    QBCore.Functions.GetPlayerData(function(newData)
        PlayerData = newData
        openMenu('createCharacter', true)
    end)
end)

RegisterNetEvent("QBCore:Client:OnJobUpdate", function(data)
    PlayerData.job = data
    resestBlips()
end)

RegisterNetEvent("QBCore:Client:OnGangUpdate", function(data)
    PlayerData.gang = data
    resestBlips()
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
end)

RegisterNetEvent("QBCore:Client:OnPlayerUnload", function()
    PlayerData = {}
end)

RegisterNetEvent("QBCore:Client:SetDuty", function(duty)
    if PlayerData and PlayerData.job then
        PlayerData.job.onduty = duty
    end
end)

RegisterNetEvent('qb-clothing:client:openOutfitMenu', function()
    openMenu('outfits')
end)

RegisterNetEvent('qb-clothing:client:loadOutfit', function(oData)
    local ped = cache.ped

    local data = oData.outfitData

    local function typeof(var)
        local _type = type(var);
        if(_type ~= "table" and _type ~= "userdata") then
            return _type;
        end
        local _meta = getmetatable(var);
        if(_meta ~= nil and _meta._NAME ~= nil) then
            return _meta._NAME;
        else
            return _type;
        end
    end

    if typeof(data) ~= "table" then data = json.decode(data) end

    debugPrint("Loading outfit: ", json.encode(data))

    -- Pants
    if data["pants"] ~= nil then
        SetPedComponentVariation(ped, 4, data["pants"].item, data["pants"].texture, 0)
    end

    -- Arms
    if data["arms"] ~= nil then
        SetPedComponentVariation(ped, 3, data["arms"].item, data["arms"].texture, 0)
    end

    -- T-Shirt
    if data["t-shirt"] ~= nil then
        SetPedComponentVariation(ped, 8, data["t-shirt"].item, data["t-shirt"].texture, 0)
    end

    -- Vest
    if data["vest"] ~= nil then
        SetPedComponentVariation(ped, 9, data["vest"].item, data["vest"].texture, 0)
    end

    -- Torso 2
    if data["torso2"] ~= nil then
        SetPedComponentVariation(ped, 11, data["torso2"].item, data["torso2"].texture, 0)
    end

    -- Shoes
    if data["shoes"] ~= nil then
        SetPedComponentVariation(ped, 6, data["shoes"].item, data["shoes"].texture, 0)
    end

    -- Bag
    if data["bag"] ~= nil then
        SetPedComponentVariation(ped, 5, data["bag"].item, data["bag"].texture, 0)
    end

    -- Badge
    if data["decals"] ~= nil then
        SetPedComponentVariation(ped, 10, data["decals"].item, data["decals"].texture, 0)
    end

    -- Accessory
    if data["accessory"] ~= nil then
        if QBCore.Functions.GetPlayerData().metadata["tracker"] then
            SetPedComponentVariation(ped, 7, 13, 0, 0)
        else
            SetPedComponentVariation(ped, 7, data["accessory"].item, data["accessory"].texture, 0)
        end
    else
        if QBCore.Functions.GetPlayerData().metadata["tracker"] then
            SetPedComponentVariation(ped, 7, 13, 0, 0)
        else
            SetPedComponentVariation(ped, 7, -1, 0, 2)
        end
    end

    -- Mask
    if data["mask"] ~= nil then
        SetPedComponentVariation(ped, 1, data["mask"].item, data["mask"].texture, 0)
    end

    -- Bag
    if data["bag"] ~= nil then
        SetPedComponentVariation(ped, 5, data["bag"].item, data["bag"].texture, 0)
    end

    -- Hat
    if data["hat"] ~= nil then
        if data["hat"].item ~= -1 and data["hat"].item ~= 0 then
            SetPedPropIndex(ped, 0, data["hat"].item, data["hat"].texture, true)
        else
            ClearPedProp(ped, 0)
        end
    end

    -- Glass
    if data["glass"] ~= nil then
        if data["glass"].item ~= -1 and data["glass"].item ~= 0 then
            SetPedPropIndex(ped, 1, data["glass"].item, data["glass"].texture, true)
        else
            ClearPedProp(ped, 1)
        end
    end

    -- Ear
    if data["ear"] ~= nil then
        if data["ear"].item ~= -1 and data["ear"].item ~= 0 then
            SetPedPropIndex(ped, 2, data["ear"].item, data["ear"].texture, true)
        else
            ClearPedProp(ped, 2)
        end
    end
end)

RegisterNetEvent('qb-clothing:client:openMenu', function()
    openMenu('createCharacter')
end)