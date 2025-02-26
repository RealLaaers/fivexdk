local currentResourceName = GetCurrentResourceName()

function debugPrint(...)
    if not Config.debug then return end
    local args <const> = { ... }
  
    local appendStr = ''
    for _, v in ipairs(args) do
      appendStr = appendStr .. ' ' .. tostring(v)
    end
    local msgTemplate = '^3[%s] ^4[SERVER] ^0%s'
    local finalMsg = msgTemplate:format(currentResourceName, appendStr)
    print(finalMsg)
end