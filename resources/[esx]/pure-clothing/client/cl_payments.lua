function generateClothingPayment()
    local currentClothing, oldClothing = getClothingValuesForSaving()
    if recentlyUsedOutfit then 
        return tonumber(Config.outfitUseCost)
    end
    local price = 0
    if Config.payPerItemOfClothing then 
        for k,v in pairs(currentClothing) do 
            local old = oldClothing[k]
            if old then 
                if old.name == v.name then 
                    debugPrint('Old name', old.name, 'New name', v.name)
                    if old.value1 ~= v.value1 then 
                        debugPrint('Old value1', old.value1, 'New value1', v.value1)
                        if not Config.pricePerClothing[v.name] then 
                            debugPrint('No price for clothing', v.name)
                            return
                        end
                        price = price + Config.pricePerClothing[v.name]
                    end
                end
            end
        end
        debugPrint('Price', price)
    else 
        price = Config.priceForMenus.clothing
    end
    return price
end