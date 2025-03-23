local armorEquippedState = {}

ESX.RegisterServerCallback('fh_ilegaljobs:GiveItem', function(source, cb, item, durability)
    local xPlayer = ESX.GetPlayerFromId(source)
    local ped = GetPlayerPed(source)
    local armour = GetPedArmour(ped)

    if item == 'vest' and armorEquippedState[source].hasEquipped then
      local additem = exports.ox_inventory:AddItem(source, 'vest', 1, { durability = armour })
      if additem then
        armorEquippedState[source] = { hasEquipped = false }
        cb(true)
      else
        cb(false)
      end

      for k, v in ipairs(GetPlayerIdentifiers(source)) do
          if string.sub(v, 1, string.len("steam:")) == "steam:" then
              steamid = v
            elseif string.sub(v, 1, string.len("license:")) == "license:" then
              license = v
            elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
              discord  = v    
          end
      end

      sendToDiscord('https://discord.com/api/webhooks/1296465089762955375/K1E10UYsMkGIQQZ3kzc5RpIKmYjOUsr2jIqZ6G5ZoSWTRAbWa6zuH2iD-2F0RUQOuJyY', 16013590, 'Skudsikker Vest Af', '**Spiller**: '..xPlayer.getName()..'\n**Licens**: '..license..'\n**Steam**: '..steamid..'\n**Discord**: '..discord..'\n\n**Vest Data:** 1x Skudsikker Vest **('..durability..'%)**', 'Resident Vest | ') 
    else
      local data = {
        ['Player'] = source, -- You need to set source here
        ['Log'] = 'cheatersexploiting', -- Log name
        ['Title'] = 'Skudsikkervest - Exploited', -- Title
        ['Message'] = 'Denne person har lige prøvet at exploit dette script! Personen prøvede at give sig: '..item, -- Message
        ['Color'] = 'blue', -- Set your color here check Config.Colors for available colors
      }

      TriggerEvent('Boost-Logs:SendLog', data)
    end
end)

RegisterServerEvent('fh_ilegaljobs:VestLog')
AddEventHandler('fh_ilegaljobs:VestLog', function(durability)
    local xPlayer = ESX.GetPlayerFromId(source)

    armorEquippedState[source] = { hasEquipped = true }

    for k, v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
          elseif string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
          elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord  = v    
        end
    end

    sendToDiscord('https://discord.com/api/webhooks/1296591967194710036/16pH6Y4USVkFLHm94euln_3pLfCsby3b5YX7JakJuTuDjuqALgkR4zScORdpiUsHH7n3', 3389516, 'Skudsikker Vest På', '**Spiller**: '..xPlayer.getName()..'\n**Licens**: '..license..'\n**Steam**: '..steamid..'\n**Discord**: '..discord..'\n\n**Vest Data:** 1x Skudsikker Vest **('..durability..'%)**', 'Resident Vest | ') 
end)


RegisterServerEvent('fh_ilegaljobs:BandageLog')
AddEventHandler('fh_ilegaljobs:BandageLog', function(durability)
    local xPlayer = ESX.GetPlayerFromId(source)
    exports.ox_inventory:RemoveItem(source, 'bandage', 1)

    -- for k, v in ipairs(GetPlayerIdentifiers(source)) do
    --     if string.sub(v, 1, string.len("steam:")) == "steam:" then
    --         steamid = v
    --       elseif string.sub(v, 1, string.len("license:")) == "license:" then
    --         license = v
    --       elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
    --         discord  = v    
    --     end
    -- end

    -- sendToDiscord('https://discord.com/api/webhooks/1264321165615431720/L0wzJTyQTcbMrHkhyT5OU89UQdBd_9SwoBxmlSXO2B5cSXwUlEEWMgw2N-EA3UYigKep', 3389516, 'Skudsikker Vest På', '**Spiller**: '..xPlayer.getName()..'\n**Licens**: '..license..'\n**Steam**: '..steamid..'\n**Discord**: '..discord..'\n\n**Vest Data:** 1x Skudsikker Vest **('..durability..'%)**', 'JF Bandebuy | ') 
end)
