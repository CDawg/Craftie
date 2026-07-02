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

    if (Craftie.Tooltip[Craftie.Player.Name] ~= nil) then
      if (channel == "GUILD") then
        if (IsInGuild()) then
          Craftie:SendPacket(Craftie.Packet.Prefix.Info, Craftie.Player.Name .. "," .. Craftie.Tooltip[Craftie.Player.Name], channel)
        end
      end

      if (channel == "GROUP") then
        if (IsInRaid()) then
          Craftie:SendPacket(Craftie.Packet.Prefix.Info, Craftie.Player.Name .. "," .. Craftie.Tooltip[Craftie.Player.Name], "RAID")
        elseif (IsInGroup()) then
          Craftie:SendPacket(Craftie.Packet.Prefix.Info, Craftie.Player.Name .. "," .. Craftie.Tooltip[Craftie.Player.Name], "PARTY")
        end
      end

      if (channel == "LOCAL") then
        if (not PlayerIsInCombat()) then
          if (not IsInInstance()) then
            Craftie:SendPacket(Craftie.Packet.Prefix.Info, Craftie.Player.Name .. "," .. Craftie.Tooltip[Craftie.Player.Name], "YELL")
            --if ()
              --Craftie:SendPacket(Craftie.Packet.Prefix.Info, Craftie.Player.Name .. "," .. Craftie.Tooltip[Craftie.Player.Name], "GUILD")
            --end
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
  Craftie.Tooltip[Craftie.Player.Name] = tooltip:sub(1, -2)
  Craftie:Notification("BuildPersonalTooltip("..Craftie.Tooltip[Craftie.Player.Name]..")", Craftie.CHAT.FUNC)
end

function Craftie:TooltipLayout(data, tooltipframe)
  local color = Craftie.Color.Blue
  if (data) then
    tooltipframe:AddLine("|T" .. Craftie._G.Path .. "Images/" .. Craftie._G.Icon .. ".png:14:14|t " .. Craftie._G.Title)
    if (data.profN1) then
      local mastery = ""
      if (data.profM1 > 0) then
        mastery = " [" .. Craftie.Professions[Craftie:GetKeyFromValue(Craftie.Professions, data.profN1, 1)][4][data.profM1] .. "]"
      end
      tooltipframe:AddDoubleLine(color .. data.profN1 .. mastery, Craftie.Color.White .. data.profL1 .. "/" .. Craftie.PROFMAXLEVEL)
    end
    if (data.profN2) then
      local mastery = ""
      if (data.profM2 > 0) then
        mastery = " [" .. Craftie.Professions[Craftie:GetKeyFromValue(Craftie.Professions, data.profN2, 1)][4][data.profM2] .. "]"
      end
      tooltipframe:AddDoubleLine(color .. data.profN2 .. mastery, Craftie.Color.White .. data.profL2 .. "/" .. Craftie.PROFMAXLEVEL)
    end
    if (data.profN3) then
      local mastery = ""
      if (data.profM3 > 0) then
        mastery = " [" .. Craftie.Professions[Craftie:GetKeyFromValue(Craftie.Professions, data.profN3, 1)][4][data.profM3] .. "]"
      end
      tooltipframe:AddDoubleLine(color .. data.profN3 .. mastery, Craftie.Color.White .. data.profL3 .. "/" .. Craftie.PROFMAXLEVEL)
    end
    tooltipframe:Show()
  end
end

function Craftie:BuildTooltipHooks()
  GameTooltip:HookScript("OnTooltipSetUnit", function(tooltip)
    local _, unit = tooltip:GetUnit()
    if ((not unit) or (not UnitIsPlayer(unit))) then
      return
    end
    local name = UnitName(unit)
    local data = Craftie.PlayerGUIDProf[name]

    if (data) then
      tooltip:AddLine(" ")
    end
    Craftie:TooltipLayout(data, tooltip)
  end)
end

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

--TODO get offline member tooltip data
Craftie.GuildFrameUsing = 1
function Craftie:BuildGuildRosterTooltip()
  if (IsInGuild()) then
     --Craftie:UpdateGuildMember()
    local totalMembers, numMembers = GetNumGuildMembers()

    --[==[
    if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"] ~= nil) then
      for k,v in pairs(Craftie.Professions) do
        local prof = v[1]
        if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"][prof:upper()] ~= nil) then

          for i=1, numMembers do
            local name, _, _, level, _, zone, _, _, online = GetGuildRosterInfo(i)
            local player = Ambiguate(name, "none")
            local tooltip = ""
            print(player)
            if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"][prof:upper()][player] ~= nil) then
              local crafter = Craftie:Split(CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"][prof:upper()][player], ",")
              local profLevel = crafter[3]
              local profMastery = crafter[5]
              --print("Craftie:BuildPersonalTooltip:" .. prof .. ":" .. profLevel .. ":" .. profMastery .. ";")
              tooltip = tooltip .. prof .. ":" .. profLevel .. ":" .. profMastery .. ";"
            end
            Craftie.Tooltip[player] = tooltip:sub(1, -2)
          end
        end
      end
    end
    ]==]--

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

    for i = 1, GUILDMEMBERS_TO_DISPLAY do
    --for i = 1, numMembers do
      local button = _G["GuildFrameButton"..i]
      --if (Craftie.GuildFrameUsing == 2) then
        --button = _G["CommunitiesFrameGuildListButton"..i]
      --end

      if (button) then
        button:HookScript("OnEnter", function(self)
          local index = FauxScrollFrame_GetOffset(GuildListScrollFrame) + self.guildIndex
          local name, rank, rankIndex, level, class = GetGuildRosterInfo(index)
          if (not name) then
            return
          end
          local player = Ambiguate(name, "none")

          --GameTooltip:ClearLines() --dont interfer with other addons
          if (Craftie.GuildFrameUsing == 2) then
            CraftieTooltip:SetOwner(CommunitiesFrame.GuildMemberDetailFrame, "ANCHOR_BOTTOMRIGHT", -1 * CommunitiesFrame.GuildMemberDetailFrame:GetWidth() + 10)
            print("Retail tooltip initialized")
          else --classic
            CraftieTooltip:SetOwner(GuildFrame, "ANCHOR_NONE")
            --CraftieTooltip:SetPoint("TOPRIGHT", GuildFrame, CraftieTooltip:GetWidth(), 0)
            CraftieTooltip:SetOwner(GuildMemberDetailFrame, "ANCHOR_BOTTOMRIGHT", -1 * GuildMemberDetailFrame:GetWidth(), 80)
            --print("Classic tooltip initialized")
          end

          if (CraftieTooltip:GetOwner() == GuildMemberDetailFrame) then
            CraftieTooltip:SetPoint("TOPRIGHT", GuildMemberDetailFrame, "BOTTOMRIGHT", 0, -10)
          end

          local data = Craftie.PlayerGUIDProf[player]
          if (data) then
            local classKey = Craftie:GetKeyFromValue(Craftie.Class, class, 2)
            CraftieTooltip:AddLine(Craftie.Class[classKey][4] .. player)
          end
          Craftie:TooltipLayout(data, CraftieTooltip)
          CraftieTooltip:Show()
        end)
        button:HookScript("OnLeave", function(self)
          CraftieTooltip:Hide()
        end)
      end
    end
    Craftie:Notification("Craftie:BuildGuildRosterTooltip()", Craftie.CHAT.FUNC)
  end
end
