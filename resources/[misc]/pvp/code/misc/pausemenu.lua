function AddTextEntry(k, v)
    Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), k, v)
 end
 
 local fivem_title = "FiveX - discord.gg/fivexdk"
 local map_category = "Map"
 
 local statistics_category = "Stats"
 local settings_category = "Settings"
 
 local fivem_key_config_submenu = "FiveM Keys"
 
 Citizen.CreateThread(function()
    AddTextEntry('FE_THDR_GTAO', fivem_title)
    AddTextEntry('PM_SCR_MAP', map_category)
    AddTextEntry('PM_SCR_STA', statistics_category)
    AddTextEntry('PM_SCR_SET', settings_category)
    AddTextEntry('PM_PANE_CFX', fivem_key_config_submenu)
 end)
 