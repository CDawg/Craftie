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
Craftie.Event:RegisterEvent("CHAT_MSG_GUILD")
--Craftie.Event:RegisterEvent("CHAT_MSG_PING")
Craftie.Event:RegisterEvent("CRAFT_SHOW")
Craftie.Event:RegisterEvent("CRAFT_CLOSE")
Craftie.Event:RegisterEvent("GET_ITEM_INFO_RECEIVED")
Craftie.Event:RegisterEvent("GROUP_ROSTER_UPDATE")
Craftie.Event:RegisterEvent("GUILD_ROSTER_UPDATE")
Craftie.Event:RegisterEvent("GUILD_TRADESKILL_UPDATE")
Craftie.Event:RegisterEvent("PLAYER_LOGIN")
Craftie.Event:RegisterEvent("PLAYER_REGEN_ENABLED")
Craftie.Event:RegisterEvent("PLAYER_REGEN_DISABLED")
Craftie.Event:RegisterEvent("PLAYER_STARTED_MOVING")
Craftie.Event:RegisterEvent("PLAYER_STOPPED_MOVING")
--Craftie.Event:RegisterEvent("NAME_PLATE_UNIT_ADDED")
Craftie.Event:RegisterEvent("SKILL_LINES_CHANGED")
Craftie.Event:RegisterEvent("TRADE_SKILL_CLOSE")
Craftie.Event:RegisterEvent("TRADE_SKILL_DETAILS_UPDATE")
Craftie.Event:RegisterEvent("TRADE_SKILL_LIST_UPDATE")
Craftie.Event:RegisterEvent("TRADE_SKILL_SHOW")
Craftie.Event:RegisterEvent("TRADE_SKILL_UPDATE")
--Craftie.Event:RegisterEvent("WHO_LIST_UPDATE")

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
  Craftie:EventManager(self, event, prefix, netpacket, data1, data2)
end)

function Craftie:EventManager(self, event, prefix, netpacket, data1, data2)
  if (event) then
		if ((event == "ADDON_LOADED") and (prefix == Craftie._G.Prefix)) then
	    Craftie:Init()
      --print("Craftie.Event[1] " .. prefix .. " | " .. event)
      Craftie:Notification("Craftie:EventManager[1] " .. event, Craftie.CHAT.EVENT)
      if (IsInGuild()) then
        local _, numMembers = GetNumGuildMembers()
        Craftie.NumGuildMembers = numMembers
      end
	  end

    if (event == "PLAYER_REGEN_ENABLED") then
      Craftie.IsInCombat = false
    end
    if (event == "PLAYER_REGEN_DISABLED") then
      Craftie.IsInCombat = true
    end

    if ((event == "PLAYER_STARTED_MOVING") or (event == "PLAYER_STOPPED_MOVING")) then
      if (not Craftie.IsInCombat) then
        local inInstance, instanceType = IsInInstance()
        if (not inInstance) then
          Craftie:UpdatePlayerTooltip("LOCAL")
        end
      end
    end

    if (event == "GROUP_ROSTER_UPDATE") then
      Craftie:UpdatePlayerTooltip("GROUP")
      Craftie:Notification(event, Craftie.CHAT.EVENT)
    end

    if (event == "GUILD_ROSTER_UPDATE") then
      if (IsInGuild()) then
        local _, numMembers = GetNumGuildMembers()
        if (Craftie.NumGuildMembers < numMembers) then
          --detect only logging in
          Craftie:UpdatePlayerTooltip("GUILD")
          Craftie:Notification(event, Craftie.CHAT.EVENT)
        end
        --consistent updating
        Craftie.NumGuildMembers = numMembers
      end
    end

    if (event == "SKILL_LINES_CHANGED") then
      --safe method for anti-spam & prof level increase
      Craftie:ResetCrafterBuild()
    end

    if (event == "TRADE_SKILL_SHOW") then
      if (not Craftie.IsInCombat) then
        local profName, profLevel = GetTradeSkillLine()
        if (profName) then
          for k,v in pairs(Craftie.Professions) do
            if (profName == v[1]) then --ignore secondary profs
              Craftie:CrafterBuildData(profName, profLevel) --throttle by recipebook
              if (Craftie.Throttle.Prof.Flag == 1) then
                Craftie.Throttle.Prof.Flag = 0
                C_Timer.After(1, function()
                  Craftie:BuildPersonalTooltip()
                  C_Timer.After(1, function()
                    Craftie:UpdatePlayerTooltip("GUILD")
                  end)
                end)
                C_Timer.After(Craftie.Throttle.Prof.Timer, function()
                  Craftie.Throttle.Prof.Flag = 1
                  Craftie:ResetCrafterBuild()
                end)
              end
            end
          end
        end
      end
    end

    if (event == "CHAT_MSG_ADDON") then
			if (prefix == Craftie._G.Prefix) then
        if (netpacket) then
          Craftie:ParsePacket(netpacket)
        end
      end
    end

    --[==[
    if (prefix == Craftie._G.Prefix) then
      if (event ~= "CHAT_MSG_CHANNEL") then
        Craftie:Notification("Craftie:EventManager[2] " .. event, Craftie.CHAT.EVENT)
      end
    end
    ]==]--

  end
end

Craftie.Chat = {}
Craftie.ChatFilter = {}

function Craftie:BuildChatHooks()
  local prof_parent = ""
  for k,v in pairs(Craftie.Professions) do
    Craftie.Chat[v[1]] = {}
  end

  for k,v in pairs(Craftie.Professions) do
    prof_parent = "[" .. v[1]
    table.insert(Craftie.Chat[v[1]], v[1])
    if (v[4][1] ~= nil) then
      for a,b in pairs(v[4]) do
        --print(" - " .. b)
        table.insert(Craftie.Chat[v[1]], b)
        prof_parent = prof_parent .. " | " .. b
      end
    end
    Craftie:Notification("Craftie:BuildChatHooks: " .. prof_parent .. "]", Craftie.CHAT.FUNC)
  end

  for k,v in pairs(Craftie.Professions) do
    Craftie.ChatFilter[v[1]] = function(self, event, msg, author, ...)
      --local parent = Craftie.Chat.Alchemy[1]
      for a,b in pairs(Craftie.Chat[v[1]]) do
        local pattern= "%[" .. b .. "%]"
        if (msg:find(pattern)) then --register the author data
          local filter = gsub(msg, pattern, "|Haddon:Craftie:" .. author .. ":" .. v[1] .. "|h|T" .. Craftie._G.Path .. "Images/" .. Craftie._G.Icon .. ".png:14:14|t" .. pattern .. "|h|r")
          --local filter = gsub(msg, pattern, "|Haddon:Craftie:" .. author .. ":" .. v[1] .. "|h|T" .. Craftie._G.Path .. "Images/" .. Craftie._G.Icon .. ".png:14:14|t[Craftie" .. pattern .. "]|h|r")
          return false, filter, author, ...
        end
      end
    end
  end

  for k,v in pairs(Craftie.ChannelList) do
    for _,prof in pairs(Craftie.Professions) do
      --segment each primary profession
      ChatFrame_AddMessageEventFilter(v, Craftie.ChatFilter[prof[1]])
    end
  end

  --ChatFrame_AddMessageEventFilter(v, Craftie.ChatFilter[prof[1]])"CHAT_MSG_SYSTEM",

end

local function FilterOnline(self, event, msg, sender)
    -- Check if the message is exactly "!stats"
    if msg == "No player named '%a' is currently playing" then
        -- Send a private reply back to the sender
        --SendChatMessage("My stats are awesome!", "WHISPER", nil, sender)

        -- Return true to prevent the original "!stats" message 
        -- from printing in the user's chat window
        print("found it")
        return true
    end
    -- Return false/nil to let other messages display normally
    return false
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", FilterOnline)
--ChatFrame_RemoveMessageEventFilter

hooksecurefunc("SetItemRef", function(link, text, button)
  -- Check if the clicked link is an item
  local linkType = Craftie:Split(link, ":")
  --print("linkType " .. linkType[1])

  if (linkType[1] == "spell") then
    --print("text " .. text)
    local spellData = Craftie:Split(text, ":")
    --for k,v in pairs(spellData) do
      --print(k .. " | " .. v)
    --end
    if (spellData[4] == Craftie._G.Prefix) then
      --local player = Ambiguate(name, "none")
      local playerData = Craftie:Split(spellData[5], "-") --remove realm data
      local player = playerData[1]
      local profLink   = spellData[6]
      local profSplit = Craftie:Split(profLink, "|") --clean up link
      local prof = profSplit[1]
      --print(player .. " | " .. prof)
      ItemRefTooltip:Hide() --make this an option?
      if ((player ~= Craftie.Player.Name) or (Craftie.DEBUGLEVEL >= 3)) then
        Craftie:SendPacket(Craftie.Packet.Prefix.Ping, Craftie.Player.Name .. "," .. prof, "WHISPER", player)
        Craftie.Packet.ACK[player] = 0
        C_Timer.After(Craftie.Packet.Timeout, function()
           --if the ack doesnt come back from the backet within this timeframe, timeout!
          if (Craftie.Packet.ACK[player] == 0) then
            Craftie:Notification("[" .. player .. "] has outdated data", Craftie.CHAT.WARN)
          end
          Craftie:UpdateCrafterList()
          --print("open book to player " .. player)
          Craftie:GetCrafterIndex(player)
        end)
      end
      --we still need to open the book, but cache the incoming data
      C_Timer.After(0.2, function()
        Craftie:Notification("SetItemRef " .. prof, Craftie.CHAT.FUNC)
        Craftie:Open(player, prof) --need to cache player data loading
      end)
    end
  end
end)

--[==[
--Dont use, too many filters and lags
EventRegistry:RegisterCallback("SetItemRef", function(init, link, text, button, chatFrame)
end)
]==]--
