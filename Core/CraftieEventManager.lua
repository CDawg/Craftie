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
Craftie.Event:RegisterEvent("TRADE_SKILL_UPDATE")

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
		if ((event == "ADDON_LOADED") and (prefix == Craftie._G.Prefix)) then
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

    if (event == "SKILL_LINES_CHANGED") then
      --safe method for anti-spam & prof level increase
      Craftie.ResetCrafterBuild()
      Craftie.Notification("SKILL_LINES_CHANGED", true)
    end

    if (event == "TRADE_SKILL_SHOW") then
      local profName, profLevel = GetTradeSkillLine()
      if (profName) then
        Craftie.CrafterDataBuild(profName, profLevel)
        C_Timer.After(1, function()
          Craftie.CrafterDataBuild(profName, profLevel)
        end)
      end
    end

    if (event == "CHAT_MSG_ADDON") then
			if (prefix == Craftie._G.Prefix) then
        if (netpacket) then
          Craftie.ParsePacket(netpacket)
        end
      end
    end

    --[==[
    if (prefix ~= nil) then
      print("Craftie.Event[2] " .. prefix .. " | " .. event)
      if (prefix == Craftie._G.Prefix) then
        print("Craftie.Event[2] " .. prefix .. " | " .. event)
        print("parse packet?")
      end
    end
    ]==]--
  end
end

Craftie.ChatProfessions = {} --version control?
function Craftie.BuildChatHooks()
  local i=0
  for k,v in pairs(Craftie.Professions) do
    i=i+1
    table.insert(Craftie.ChatProfessions, i, {v[1], v[1]})
    --print(i .. " | " .. v[1] .. " | " ..  v[1])
    for a,b in pairs(v[4]) do
      i=i+1
      if (v[4][1] ~= nil) then
        --print(i .. " | " .. v[1] .. " | " ..  b)
        table.insert(Craftie.ChatProfessions, i, {v[1], b})
      end
    end
  end
  --for k,v in pairs(Craftie.ChatProfessions) do
    --print(v[2])
  --end
end

function Craftie.ChatFilter(self, event, msg, author, ...)
  for k,v in pairs(Craftie.ChatProfessions) do
    local pattern = "%[" .. v[2] .. "%]"
    if (msg:find(pattern)) then --register the author data
      local icon_key = Craftie.GetKeyFromValue(Craftie.Professions, v[1], 1)
      return false, gsub(msg, pattern, "|Haddon:Craftie:" .. author .. ":" .. v[1] .. "|h|T" .. Craftie._G.Path .. "Images/" .. Craftie._G.Icon .. ":14:14|t" .. pattern .. "|h|r"), author, ...
    end
  end
end

for k,v in pairs(Craftie.ChannelList) do
  ChatFrame_AddMessageEventFilter(v, Craftie.ChatFilter)
end

hooksecurefunc("SetItemRef", function(link, text, button)
  -- Check if the clicked link is an item
  local linkType = Craftie.Split(link, ":")
  --print("linkType " .. linkType[1])

  if (linkType[1] == "spell") then
    --print("text " .. text)
    local spellData = Craftie.Split(text, ":")
    --for k,v in pairs(spellData) do
      --print(k .. " | " .. v)
    --end
    if (spellData[4] == "Craftie") then
      local playerData = Craftie.Split(spellData[5], "-") --remove realm data
      local player = playerData[1]
      local prof   = spellData[6]
      print(player .. " | " .. prof)
      --[==[
      Craftie.Open(player, prof)
      ItemRefTooltip:Hide() --make this an option in settings
      ]==]--
      ItemRefTooltip:Hide() --make this an option
      Craftie.SendPacket(Craftie.Packet.Prefix.Ping, Craftie.Player.Name .. "," .. prof, "WHISPER", player)
    end
  end

  --may be an option later when posting patterns, but this is gets too spammy with NON crafters.
  --[==[
  if (linkType[1] == "enchant") then
    --print("text " .. text)
    local spellData = Craftie.Split(text, ":")
    for k,v in pairs(spellData) do
      print(k .. " | " .. v)
    end
    if (spellData[3] == "Craftie") then
      local playerData = Craftie.Split(spellData[4], "-") --remove realm data
      local player = playerData[1]
      local prof   = spellData[5]
      print(player .. " | " .. prof)
      Craftie.Open(player, prof)
      ItemRefTooltip:Hide() --make this an option"
    end
  end
  ]==]--
end)

--[==[
--WAY TOO BUGGY
EventRegistry:RegisterCallback("SetItemRef", function(init, link, text, button, chatFrame)
end)
]==]--
