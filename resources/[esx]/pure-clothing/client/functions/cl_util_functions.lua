function sendReactMessage(action, data)
  SendNUIMessage({
    action = action,
    data = data
  })
end

local currentResourceName = GetCurrentResourceName()

function debugPrint(...)
  if not Config.debug then return end
  local args <const> = { ... }

  local appendStr = ''
  for _, v in ipairs(args) do
    appendStr = appendStr .. ' ' .. tostring(v)
  end
  local msgTemplate = '^3[%s] ^2[CLIENT] ^0%s'
  local finalMsg = msgTemplate:format(currentResourceName, appendStr)
  print(finalMsg)
end

function isInCoolDown()
  debugPrint('Checking cooldown', (GetGameTimer() - cooldown) < Config.coolDownTime * 1000)
  return (GetGameTimer() - cooldown) < Config.coolDownTime * 1000
end

function LoadAnimDict(dict)
  while (not HasAnimDictLoaded(dict)) do
      RequestAnimDict(dict)
      Wait(5)
  end
end