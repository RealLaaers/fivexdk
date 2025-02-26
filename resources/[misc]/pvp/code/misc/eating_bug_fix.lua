AddEventHandler('gameEventTriggered', function(name, args)
  if name == 'CEventNetworkEntityDamage' then
     local killedPedId = tonumber(args[1])
     local bulletHit, boneHit = GetPedLastDamageBone(killedPedId)
     if bulletHit then
        if (boneHit == 31086) then
           if HasEntityBeenDamagedByWeapon(killedPedId, GetHashKey("WEAPON_APPISTOL"), 0) or HasEntityBeenDamagedByWeapon(killedPedId, GetHashKey("WEAPON_PISTOL50"), 0) then
                 ApplyDamageToPed(killedPedId, 9999, true)
                 if not IsEntityDead(killedPedId) then
                    ApplyDamageToPed(killedPedId, 9999, true)
                 end
           end
        end
     end
  end
end)