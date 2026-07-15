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
Craftie.Event:RegisterEvent("LEARNED_SPELL_IN_SKILL_LINE")
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

    --used for caching and building language locales
    if (event == "GET_ITEM_INFO_RECEIVED") then
      --Craftie:Notification(event, Craftie.CHAT.EVENT)
      local itemName, itemLink = C_Item.GetItemInfo(prefix)
      if (itemName ~= nil) then
        Craftie:Notification("Successfully cached: " .. itemName, Craftie.CHAT.EVENT)
      end
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
      Craftie:CrafterBuildReset()
    end

    if (event == "LEARNED_SPELL_IN_SKILL_LINE") then
      --check if we learned a new proffession
      Craftie:GetProfessionEntry()
    end

    if ((event == "TRADE_SKILL_SHOW") or (event == "CRAFT_SHOW")) then
      if (not Craftie.IsInCombat) then
        local isEnchanting = false
        local profName, profLevel = GetTradeSkillLine()
        if ((not profName) or (profName == "UNKNOWN")) and GetCraftDisplaySkillLine then
          profName, profLevel = GetCraftDisplaySkillLine()
          isEnchanting = true
        elseif ((not profName) or (profName == "UNKNOWN")) and GetCraftSkillLine then
          profName = GetCraftSkillLine(1)
          isEnchanting = true
        end

        if (profName and profName ~= "UNKNOWN") then
          profLevel = profLevel or 0
          for k,v in pairs(Craftie.Professions) do
            if (profName == v[2]) then --ignore non prio profs like fishing, etc.
              Craftie:CrafterBuildData(profName, profLevel, isEnchanting) --throttle by recipebook
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
                  Craftie:CrafterBuildReset()
                end)
              end
              break
            end
          end
        end
        Craftie:Notification("Craftie:EventManager[3] " .. event, Craftie.CHAT.EVENT)
      end
    end

    if (event == "CHAT_MSG_ADDON") then
			if (prefix == Craftie._G.Prefix) then
        if (netpacket) then
          Craftie:PacketParse(netpacket)
        end
      end
    end

    --debugging
    --Craftie:Notification("Craftie:EventManager[4] " .. event, Craftie.CHAT.EVENT)
  end
end
