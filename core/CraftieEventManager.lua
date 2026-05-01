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
Craftie.Event:RegisterEvent("CHAT_MSG_ADDON_LOGGED")
Craftie.Event:RegisterEvent("CHAT_MSG_CHANNEL")
Craftie.Event:RegisterEvent("CHAT_MSG_CHANNEL_LIST")
Craftie.Event:RegisterEvent("CHAT_MSG_FILTERED")
Craftie.Event:RegisterEvent("CHAT_MSG_GUILD")
Craftie.Event:RegisterEvent("CHAT_MSG_PARTY")
Craftie.Event:RegisterEvent("CHAT_MSG_PING")
Craftie.Event:RegisterEvent("CHAT_MSG_RAID")
Craftie.Event:RegisterEvent("CHAT_MSG_SAY")
Craftie.Event:RegisterEvent("CHAT_MSG_SYSTEM")
Craftie.Event:RegisterEvent("CHAT_MSG_WHISPER")
Craftie.Event:RegisterEvent("CRAFT_SHOW")
Craftie.Event:RegisterEvent("CRAFT_CLOSE")
Craftie.Event:RegisterEvent("GET_ITEM_INFO_RECEIVED")
Craftie.Event:RegisterEvent("GROUP_ROSTER_UPDATE")
Craftie.Event:RegisterEvent("PLAYER_LOGIN")
Craftie.Event:RegisterEvent("SKILL_LINES_CHANGED")
Craftie.Event:RegisterEvent("TRADE_SKILL_CLOSE")
Craftie.Event:RegisterEvent("TRADE_SKILL_DETAILS_UPDATE")
Craftie.Event:RegisterEvent("TRADE_SKILL_LIST_UPDATE")
Craftie.Event:RegisterEvent("TRADE_SKILL_SHOW")

Craftie.Event:SetScript("OnEvent", function(self, event, prefix, netpacket, _casted, _spellID)
  Craftie.EventManager(self, event, prefix, netpacket, _casted, _spellID)
end)

--C_ChatInfo.RegisterAddonMessagePrefix(prefix)

function Craftie.EventManager(self, event, prefix, netpacket, _casted, _spellID)
  if (event) then
		if ((event == "ADDON_LOADED") and (prefix == Craftie._G.prefix)) then
	    Craftie.Init()
      print("Craftie.Event[1] " .. prefix .. " | " .. event)
	  end

    --combat prevent here?

    --if (prefix) then
      --C_ChatInfo.RegisterAddonMessagePrefix(prefix)
      --print("Craftie.Event[2] " .. prefix .. " | " .. event)
    --end

    --local result = C_ChatInfo.RegisterAddonMessagePrefix(prefix)
    --print("result... " .. result)

    --[==[
    if (event == "GET_ITEM_INFO_RECEIVED") then
      if (prefix) then
        print("Craftie.Event[2] " .. prefix .. " | " .. event)
      end
    end
    ]==]--

    if (event == "CHAT_MSG_ADDON") then
			if (prefix == Craftie._G.prefix) then
        if (netpacket) then
          Craftie.ParsePacket(netpacket)
        end
        --[==[
        print("Craftie.Event[3] " .. prefix .. " | " .. event .. " | " .. netpacket .. " | " .. _casted .. " | " .. _spellID)
        if (netpacket) then
          print("compressed " .. #netpacket)
          local decompress = Craftie.LowCompression(netpacket, true)
          print(decompress)
          if (Craftie.Seed == decompress) then
            print("Match!")
          end
        end
        ]==]--
      end
    end

    --[==[
    if (prefix ~= nil) then
      print("Craftie.Event[2] " .. prefix .. " | " .. event)
      if (prefix == Craftie._G.prefix) then
        print("Craftie.Event[2] " .. prefix .. " | " .. event)
        print("parse packet?")
      end
    end
    ]==]--
  end
end
