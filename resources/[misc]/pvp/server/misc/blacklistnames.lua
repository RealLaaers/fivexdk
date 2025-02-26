local unauthNames = {
    "<meta", "http-equiv='refresh'", "S8R_NETwork_Clear", "<img src=", "window.location.href", ".php"
}

local x = {}

AddEventHandler("playerConnecting", function(playerName, setKickReason)
    playerName = (string.gsub(string.gsub(string.gsub(playerName,  "-", ""), ",", ""), " ", ""):lower())
    for k, v in pairs(unauthNames) do
      local g, f = playerName:find(string.lower(v))
      if g or f  then
        setKickReason('Kom igen din lorte unge. - Nice try idiot.')
        table.insert (x, v)
        local blresult = table.concat(x, " ")
          CancelEvent()
          for key in pairs (x) do
            x [key] = nil
        end
      end
    end
  end)