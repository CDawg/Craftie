--[==[
Copyright ©2026 Porthias of Dreamscythe

The contents of this addon, excluding third-party resources, are
copyrighted to Porthios with all rights reserved.
This addon is free to use and the authors hereby grants you the following rights:
1. You may make modifications to this addon for private use only, you
   may not publicize any portion of this addon.
2. Do not modify the name of this addon, including the addon folders.
3. This copyright notice shall be included in all copies or substantial
  portions of the Software.
All rights not explicitly addressed in this license are reserved by
the copyright holders.
]==]--

Craftie.Event = CreateFrame("Frame")
Craftie.Event:RegisterEvent("ADDON_LOADED")
Craftie.Event:RegisterEvent("CHAT_MSG_ADDON")
Craftie.Event:RegisterEvent("CHAT_MSG_CHANNEL")
--Craftie.Event:RegisterEvent("PLAYER_STARTED_MOVING")
--Craftie.Event:RegisterEvent("PLAYER_STOPPED_MOVING")
Craftie.Event:RegisterEvent("GET_ITEM_INFO_RECEIVED")
Craftie.Event:SetScript("OnEvent", function(self, event, prefix, netpacket, _casted, _spellID)
  Craftie.EventManager(self, event, prefix, netpacket, _casted, _spellID)
end)

function Craftie.EventManager(self, event, prefix, netpacket, _casted, _spellID)
  if (event) then
		if ((event == "ADDON_LOADED") and (prefix == Craftie._G.prefix)) then
	    --TOCA.Notification(TOCA.Addon .. " " .. TOCA._L.INIT[6] .. ". Type " .. TOCA._G.CMD .. " for commands.")
	    Craftie.Init()
      print("Craftie.Event " .. prefix .. " | " .. event)
	  end
    --print("Craftie.Event " .. prefix .. " | " .. event)
  end
end