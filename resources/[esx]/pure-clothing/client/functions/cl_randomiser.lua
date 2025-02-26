local hairColourBlacklisted = {60, 57, 13, 11}
local beardBlacklisted = {15, 16, 17, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28}

function randomiseCharacter()
    local tableToSend = {}
    for k,v in pairs(Config.randomiser) do 
        if v and k ~= 'enabled' then
            if k == 'generalFacialColour' then 
                local hairColour = math.random(1, 64)
                for i = 1, #hairColourBlacklisted do 
                    if hairColour == hairColourBlacklisted[i] then 
                        debugPrint('Hair colour is blacklisted, rerolling')
                        hairColour = math.random(1, 64)
                        i = 1
                    end
                end
                debugPrint('Hair colour is not blacklisted, sending', hairColour)
                tableToSend[#tableToSend + 1] = {name = 'colour', value = hairColour}
            else
                local table = clothingTable[k]
                if table.maxValue1 then 
                    local randomValue = math.random(0, table.maxValue1)
                    for i = 1, #beardBlacklisted do 
                        if randomValue == beardBlacklisted[i] then 
                            debugPrint('Beard is blacklisted, rerolling')
                            randomValue = math.random(0, table.maxValue1)
                            i = 1
                        end
                    end
                    debugPrint('Random value is ' .. randomValue.. ' for ' .. k)
                    tableToSend[#tableToSend + 1] = {name = k, value = randomValue}
                else
                    for i, j in pairs(clothingTable[k]) do 
                        if i ~= 'type' then 
                            if k == 'parents' then 
                                local fatherValue = math.random(0, #clothingTable['parents'].father)
                                local motherValue = math.random(0, #clothingTable['parents'].mother)
                                local mixValue = math.random(0, 100)
                                local skinColourValue = math.random(0, 100)
                                tableToSend[#tableToSend + 1] = {name = 'parents', father = fatherValue, mother = motherValue, mix = mixValue, skinColour = skinColourValue}
                            else
                                local name = k .. i
                                local randomValue = math.random(0, 100)
                                tableToSend[#tableToSend + 1] = {name = name, value = randomValue}
                            end
                        end
                    end
                    -- local randomValue = math.random(0, 100)
                    -- debugPrint('Random value is ' .. randomValue)
                end
            end
        end
    end
    debugPrint('Sending table ' .. json.encode(tableToSend))
    sendReactMessage('randomiseCharacter', tableToSend)
end

-- RegisterCommand('randomise', randomiseCharacter)
