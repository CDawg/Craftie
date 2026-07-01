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

function Craftie:UpdatePlayerTooltip(channel)
  if (Craftie.Throttle.Chat.Flag == 1) then
    Craftie:Notification("Craftie:UpdatePlayerTooltip(" .. channel .. ")", Craftie.CHAT.FUNC)
    Craftie.Throttle.Chat.Flag = 0

    if (Craftie.Tooltip.Data ~= nil) then
      if (channel == "GUILD") then
        if (IsInGuild()) then
          Craftie:SendPacket(Craftie.Packet.Prefix.Info, Craftie.Player.Name .. "," .. Craftie.Tooltip.Data, channel)
        end
      end

      if (channel == "GROUP") then
        if (IsInRaid()) then
          Craftie:SendPacket(Craftie.Packet.Prefix.Info, Craftie.Player.Name .. "," .. Craftie.Tooltip.Data, "RAID")
        elseif (IsInGroup()) then
          Craftie:SendPacket(Craftie.Packet.Prefix.Info, Craftie.Player.Name .. "," .. Craftie.Tooltip.Data, "PARTY")
        end
      end

      if (channel == "LOCAL") then
        if (not IsInInstance()) then
          if (not PlayerIsInCombat()) then
            Craftie:SendPacket(Craftie.Packet.Prefix.Info, Craftie.Player.Name .. "," .. Craftie.Tooltip.Data, "YELL")
          end
        end
      end
    end
    C_Timer.After(Craftie.Throttle.Chat.Timer, function()
      Craftie.Throttle.Chat.Flag = 1 --reset after
    end)
  end
end

--option to send data to players
function Craftie:BuildPersonalTooltip()
  local tooltip = ""
  if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"] ~= nil) then
    for k,v in pairs(Craftie.Professions) do
      local prof = v[1]
      if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"][prof:upper()] ~= nil) then
        if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"][prof:upper()][Craftie.Player.Name] ~= nil) then
          local crafter = Craftie:Split(CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"][prof:upper()][Craftie.Player.Name], ",")
          local profLevel = crafter[3]
          local profMastery = crafter[5]
          --print("Craftie:BuildPersonalTooltip:" .. prof .. ":" .. profLevel .. ":" .. profMastery .. ";")
          tooltip = tooltip .. prof .. ":" .. profLevel .. ":" .. profMastery .. ";"
        end
      end
    end
  end
  --debug
  --tooltip = "Cooking:3;Alchemy:244;Tailoring:375;"
  Craftie.Tooltip.Data = tooltip:sub(1, -2)
  Craftie:Notification("BuildPersonalTooltip("..Craftie.Tooltip.Data..")", Craftie.CHAT.FUNC)
end

GameTooltip:HookScript("OnTooltipSetUnit", function(tooltip)
  local _, unit = tooltip:GetUnit()
  if not unit or not UnitIsPlayer(unit) then
    return
  end

  local name = UnitName(unit)
  local data = Craftie.PlayerGUIDProf[name]

  if (data) then
    tooltip:AddLine(" ")
    tooltip:AddLine("|T" .. Craftie._G.Path .. "Images/" .. Craftie._G.Icon .. ".png:14:14|t " .. Craftie._G.Title)
    if (data.profN1) then
      local mastery = ""
      if (data.profM1 > 0) then
        mastery = " [" .. Craftie.Professions[Craftie:GetKeyFromValue(Craftie.Professions, data.profN1, 1)][4][data.profM1] .. "]"
      end
      tooltip:AddDoubleLine(Craftie.Color.Skyblue .. data.profN1 .. mastery, Craftie.Color.White .. data.profL1 .. "/" .. Craftie.PROFMAXLEVEL)
    end
    if (data.profN2) then
      local mastery = ""
      if (data.profM2 > 0) then
        mastery = " [" .. Craftie.Professions[Craftie:GetKeyFromValue(Craftie.Professions, data.profN2, 1)][4][data.profM2] .. "]"
      end
      tooltip:AddDoubleLine(Craftie.Color.Skyblue .. data.profN2 .. mastery, Craftie.Color.White .. data.profL2 .. "/" .. Craftie.PROFMAXLEVEL)
    end
    if (data.profN3) then
      local mastery = ""
      if (data.profM3 > 0) then
        mastery = " [" .. Craftie.Professions[Craftie:GetKeyFromValue(Craftie.Professions, data.profN3, 1)][4][data.profM3] .. "]"
      end
      tooltip:AddDoubleLine(Craftie.Color.Skyblue .. data.profN3 .. mastery, Craftie.Color.White .. data.profL3 .. "/" .. Craftie.PROFMAXLEVEL)
    end
    tooltip:Show()
  end
end)

--custom tooltip for Craftie only
CraftieTooltip = CreateFrame("GameTooltip", "CraftieTooltip", UIParent, "GameTooltipTemplate")
for i = 1, 30 do
  local left = _G["CraftieTooltipTextLeft"..i]
  local right= _G["CraftieTooltipTextRight"..i]
  local flags= nil

  if left then
    left:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size+1, flags)
  end

  if right then
    right:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size+1, flags)
  end
end
CraftieTooltip:SetBackdropBorderColor(0.82, 0.73, 0.64, 1)

function Craftie:GetActiveGuildFrameUI()
  if (CommunitiesFrame) and (CommunitiesFrame:IsShown()) then
    return "retail"
  elseif (GuildFrame) and (GuildFrame:IsShown()) then
    return "classic"
  end
  return nil
end

function Craftie:BuildGuildRosterTooltip()
  if (IsInGuild()) then
    local _, numMembers = GetNumGuildMembers()

    --[==[
    hooksecurefunc("GuildRoster_SetSelection", function(index)
      if not index then return end

      local name = GetGuildRosterInfo(index)
      if not name then return end

      local player = Ambiguate(name, "none")

      local data = CraftieDB[player]

      if data then
        CraftieGuildFrame.name:SetText(player)
        CraftieGuildFrame.info:SetText(
          ("Alchemy: %d\nBlacksmithing: %d"):format(
              data.alchemy or 0,
              data.blacksmith or 0
          )
        )
      else
        CraftieGuildFrame.name:SetText(player)
        CraftieGuildFrame.info:SetText("No Craftie data")
      end
    end)
    ]==]--

    if (numMembers > 1) then
      for i = 1, numMembers do
        local button = _G["GuildFrameButton"..i]
        button:HookScript("OnEnter", function(self)
          local index = FauxScrollFrame_GetOffset(GuildListScrollFrame) + self.guildIndex
          local name, rank, rankIndex, level, class = GetGuildRosterInfo(index)
          if (not name) then
            return
          end

          local player = Ambiguate(name, "none")

          GameTooltip:ClearLines()
          GameTooltip:SetOwner(GuildFrame, "ANCHOR_NONE")
          if (Craftie:GetActiveGuildFrameUI() == "classic") then
            --GameTooltip:SetPoint("TOPRIGHT", GuildFrame, GameTooltip:GetWidth(), 0)
            GameTooltip:SetOwner(GuildMemberDetailFrame, "ANCHOR_BOTTOMRIGHT", -1 * GuildMemberDetailFrame:GetWidth())
          else
            GameTooltip:SetOwner(CommunitiesFrame.GuildMemberDetailFrame, "ANCHOR_BOTTOMRIGHT", -1 * CommunitiesFrame.GuildMemberDetailFrame:GetWidth() + 10)
          end
          --[==[
          if (GameTooltip:GetOwner() == GuildMemberDetailFrame) then
            GameTooltip:SetPoint("TOPRIGHT", GuildMemberDetailFrame, "BOTTOMRIGHT", 0, -10)
          end
          ]==]--

          local data = Craftie.PlayerGUIDProf[player]
          if (data) then
            local classKey = Craftie:GetKeyFromValue(Craftie.Class, class, 2)
            GameTooltip:AddLine(Craftie.Class[classKey][4] .. player)
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine("|T" .. Craftie._G.Path .. "Images/" .. Craftie._G.Icon .. ".png:14:14|t " .. Craftie._G.Title)
            if (data.profN1) then
              local mastery = ""
              if (data.profM1 > 0) then
                mastery = " [" .. Craftie.Professions[Craftie:GetKeyFromValue(Craftie.Professions, data.profN1, 1)][4][data.profM1] .. "]"
              end
              GameTooltip:AddDoubleLine(Craftie.Color.Skyblue .. data.profN1 .. mastery, Craftie.Color.White .. data.profL1 .. "/" .. Craftie.PROFMAXLEVEL)
            end
            if (data.profN2) then
              local mastery = ""
              if (data.profM2 > 0) then
                mastery = " [" .. Craftie.Professions[Craftie:GetKeyFromValue(Craftie.Professions, data.profN2, 1)][4][data.profM2] .. "]"
              end
              GameTooltip:AddDoubleLine(Craftie.Color.Skyblue .. data.profN2 .. mastery, Craftie.Color.White .. data.profL2 .. "/" .. Craftie.PROFMAXLEVEL)
            end
            if (data.profN3) then
              local mastery = ""
              if (data.profM3 > 0) then
                mastery = " [" .. Craftie.Professions[Craftie:GetKeyFromValue(Craftie.Professions, data.profN3, 1)][4][data.profM3] .. "]"
              end
              GameTooltip:AddDoubleLine(Craftie.Color.Skyblue .. data.profN3 .. mastery, Craftie.Color.White .. data.profL3 .. "/" .. Craftie.PROFMAXLEVEL)
            end
          end
          GameTooltip:Show()
        end)
      end
      Craftie:Notification("Craftie:BuildGuildRosterTooltip()", Craftie.CHAT.FUNC)
    end
  end
end
