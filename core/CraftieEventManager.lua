--[==[
Copyright ©2026 Porthias of Dreamscythe

The contents of this addon, excluding third-party resources, are
copyrighted to Porthias with all rights reserved.
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
--Craftie.Event:RegisterEvent("CHAT_MSG_PING")
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

--channels used for linking and filtering
Craftie.ChannelList = {
"CHAT_MSG_CHANNEL",
"CHAT_MSG_PARTY",
"CHAT_MSG_SAY",
"CHAT_MSG_SYSTEM",
"CHAT_MSG_YELL",
"CHAT_MSG_WHISPER",
"CHAT_MSG_RAID",
"CHAT_MSG_GUILD",
"CHAT_MSG_OFFICER",
}
for k,v in pairs(Craftie.ChannelList) do
  Craftie.Event:RegisterEvent(v)
end

Craftie.Event:SetScript("OnEvent", function(self, event, prefix, netpacket, data1, data2)
  Craftie.EventManager(self, event, prefix, netpacket, data1, data2)
end)

function Craftie.EventManager(self, event, prefix, netpacket, data1, data2)
  if (event) then
		if ((event == "ADDON_LOADED") and (prefix == Craftie._G.prefix)) then
	    Craftie.Init()
      print("Craftie.Event[1] " .. prefix .. " | " .. event)
	  end

    --print("event|n" .. event)

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
        print("Craftie.Event[3] " .. prefix .. " | " .. event .. " | " .. netpacket .. " | " .. data1 .. " | " .. data2)
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

function Craftie.ChatFilter(self, event, msg, author, ...)
  --if msg:find("LINE TEST 1") then
    --return true
  --end
  --local pattern = "[Craftie[(%a+)]]"
  local pattern = "%[Craftie%[(%a+)%]%]"
  if msg:find(pattern) then
    return false, gsub(msg, pattern, "|cffF58E27|Haddon:Craftie:" .. author .. "|h[Blacksmithing]|h|r"), author, ...
  end
end

EventRegistry:RegisterCallback("SetItemRef", function(_, link, text, button, chatFrame)
    local linkType, addonName, linkData = strsplit(":", link)
    if ((linkType == "addon") and (addonName == "Craftie")) then
      print("Link clicked:", linkData)
      --GameTooltip:AddLine("Craftie")
      --GameTooltip:Show()
      Craftie.Frame:Show()
    end
end)

for k,v in pairs(Craftie.ChannelList) do
  ChatFrame_AddMessageEventFilter(v, Craftie.ChatFilter)
end
