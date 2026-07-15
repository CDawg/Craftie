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

--option to send data to players
function Craftie:BuildPersonalTooltip()
  local tooltip = ""
  if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"] ~= nil) then
    for k,v in pairs(Craftie.Professions) do
      local prof = v[2]
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

function Craftie:UpdatePlayerTooltip(channel)
  if (Craftie.Throttle.Chat.Flag == 1) then
    Craftie:Notification("Craftie:UpdatePlayerTooltip(" .. channel .. ")", Craftie.CHAT.FUNC)
    Craftie.Throttle.Chat.Flag = 0

    if (Craftie.Tooltip[Craftie.Player.Name] ~= nil) then
      if (channel == "GUILD") then
        if (IsInGuild()) then
          Craftie:PacketSend(Craftie.Packet.Prefix.Info, Craftie.Player.Name .. "," .. Craftie.Tooltip[Craftie.Player.Name], channel)
        end
      end

      if (channel == "GROUP") then
        if (IsInRaid()) then
          Craftie:PacketSend(Craftie.Packet.Prefix.Info, Craftie.Player.Name .. "," .. Craftie.Tooltip[Craftie.Player.Name], "RAID")
        elseif (IsInGroup()) then
          Craftie:PacketSend(Craftie.Packet.Prefix.Info, Craftie.Player.Name .. "," .. Craftie.Tooltip[Craftie.Player.Name], "PARTY")
        end
      end

      if (channel == "LOCAL") then
        if (not PlayerIsInCombat()) then
          if (not IsInInstance()) then
            Craftie:PacketSend(Craftie.Packet.Prefix.Info, Craftie.Player.Name .. "," .. Craftie.Tooltip[Craftie.Player.Name], "YELL")
            --if ()
              --Craftie:PacketSend(Craftie.Packet.Prefix.Info, Craftie.Player.Name .. "," .. Craftie.Tooltip[Craftie.Player.Name], "GUILD")
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

TooltipTemplate = "|T" .. Craftie._G.Path .. "Images/" .. Craftie._G.Icon .. ".png:14:14|t" .. Craftie._G.Title
function Craftie:TooltipLayout(data, tooltipframe)
  local color = Craftie.Color.Blue
  local title = ""
  if (data) then
    for k,v in pairs(Craftie.Developers) do
      if (data.name == v) then
        title = "Developer"
      end
    end
    for k,v in pairs(Craftie.Contributors) do
      if (data.name == v) then
        title = Craftie.Color.Lime .. "Contributor"
      end
    end
    tooltipframe:AddLine(TooltipTemplate .. " " .. title)
    if (data.profN1) then
      local mastery = ""
      if (data.profM1 > 0) then
        mastery = " [" .. Craftie.Professions[Craftie:GetKeyFromValue(Craftie.Professions, data.profN1, 2)][5][data.profM1] .. "]"
      end
      tooltipframe:AddDoubleLine(color .. data.profN1 .. mastery, Craftie.Color.White .. data.profL1 .. "/" .. Craftie.PROFMAXLEVEL)
    end
    if (data.profN2) then
      local mastery = ""
      if (data.profM2 > 0) then
        mastery = " [" .. Craftie.Professions[Craftie:GetKeyFromValue(Craftie.Professions, data.profN2, 2)][5][data.profM2] .. "]"
      end
      tooltipframe:AddDoubleLine(color .. data.profN2 .. mastery, Craftie.Color.White .. data.profL2 .. "/" .. Craftie.PROFMAXLEVEL)
    end
    if (data.profN3) then
      local mastery = ""
      if (data.profM3 > 0) then
        mastery = " [" .. Craftie.Professions[Craftie:GetKeyFromValue(Craftie.Professions, data.profN3, 2)][5][data.profM3] .. "]"
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
      data.name = name
    end
    Craftie:TooltipLayout(data, tooltip)
  end)
end

--custom tooltip for Craftie only
---@type GameTooltip
CraftieTooltip = {}
CraftieTooltip = CreateFrame("GameTooltip", "CraftieTooltip", UIParent, "GameTooltipTemplate")
for i = 1, 30 do
  --local header=_G["GameTooltipHeaderText"..1]
  local header = _G["CraftieTooltipTextLeft"..1] --first line
  local left = _G["CraftieTooltipTextLeft"..i]
  local right= _G["CraftieTooltipTextRight"..i]
  local flags= nil

  if (header) then
    header:SetFont(Craftie._G.Font.Style.Alpha, Craftie._G.Font.Size+2, flags)
  end

  if (left) then
    left:SetFont(Craftie._G.Font.Style.Alpha, Craftie._G.Font.Size+1, flags)
  end

  if (right) then
    right:SetFont(Craftie._G.Font.Style.Alpha, Craftie._G.Font.Size+1, flags)
  end
end
CraftieTooltip:SetBackdropBorderColor(0.82, 0.73, 0.64, 1)

Craftie.GuildFrameUsing = 1
Craftie.GuildRosterTooltipHooked = false
Craftie.CommunitiesRosterTooltipHooked = false
Craftie.CommunitiesGuildMemberInfo = nil

function Craftie:GetSavedRosterTooltipData(player)
  if (not player) then
    return nil
  end

  local account = nil
  if (CraftieDB and CraftieDB[Craftie.Player.Realm]) then
    account = CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]
  end
  if ((not account) or (not account["BLOB"])) then
    return nil
  end

  local data = {}
  local tooltipIndex = 0
  for k,v in ipairs(Craftie.Professions) do
    local prof = v[2]
    local professionData = account["BLOB"][prof:upper()]
    if (professionData and professionData[player]) then
      local crafter = Craftie:Split(professionData[player], ",")
      tooltipIndex = tooltipIndex + 1
      data["profN" .. tooltipIndex] = prof
      data["profL" .. tooltipIndex] = crafter[3]
      data["profM" .. tooltipIndex] = tonumber(crafter[5]) or 0

      if (tooltipIndex >= 3) then
        break
      end
    end
  end

  if (tooltipIndex == 0) then
    return nil
  end

  Craftie.PlayerGUIDProf[player] = data
  return data
end

function Craftie:GetRosterTooltipPlayerName(name)
  if (not name) then
    return nil
  end

  return Ambiguate(name, "none")
end

function Craftie:AddRosterTooltipName(tooltip, player, className, classID)
  if (not player) then
    return
  end

  local color = Craftie.Color.White
  if (classID) then
    local _, classFile = GetClassInfo(classID)
    if (classFile) then
      local classColor = RAID_CLASS_COLORS[classFile]
      if (classColor and classColor.colorStr) then
        color = "|C" .. classColor.colorStr
      end
    end
  elseif (className) then
    local classKey = Craftie:GetKeyFromValue(Craftie.Class, className, 2)
    if (classKey) then
      color = Craftie.Class[classKey][4]
    end
  end

  tooltip:AddLine(color .. player)
end

function Craftie:ShowGuildRosterTooltip(player, className, classID, owner)
  local data = Craftie.PlayerGUIDProf[player]
  if ((not data) or (not data.profN1)) then
    data = Craftie:GetSavedRosterTooltipData(player)
  end
  if (not data) then
    CraftieTooltip:Hide()
    return
  end

  data.name = player

  CraftieTooltip:ClearLines()

  if (owner == "COMMUNITIES_DETAIL") then
    CraftieTooltip:SetOwner(CommunitiesFrame.GuildMemberDetailFrame, "ANCHOR_BOTTOMRIGHT", -1 * CommunitiesFrame.GuildMemberDetailFrame:GetWidth() + 10)
  elseif (type(owner) == "table") then
    --CraftieTooltip:SetOwner(owner, "ANCHOR_RIGHT")
    CraftieTooltip:SetOwner(owner, "ANCHOR_BOTTOMRIGHT", -1 * owner:GetWidth())
  elseif (GuildMemberDetailFrame and GuildMemberDetailFrame:IsVisible()) then
    --CraftieTooltip:SetOwner(GuildMemberDetailFrame, "ANCHOR_BOTTOMRIGHT", -1 * GuildMemberDetailFrame:GetWidth())
    CraftieTooltip:SetOwner(GuildMemberDetailFrame, "ANCHOR_TOPRIGHT", -1 * GuildMemberDetailFrame:GetWidth())
  else
    CraftieTooltip:SetOwner(GuildFrame, "ANCHOR_NONE")
  end

  Craftie:AddRosterTooltipName(CraftieTooltip, player, className, classID)
  Craftie:TooltipLayout(data, CraftieTooltip)
  CraftieTooltip:Show()

  if (CraftieTooltip:GetOwner() == GuildFrame) then
    CraftieTooltip:SetPoint("BOTTOMRIGHT", GuildFrame, CraftieTooltip:GetWidth(), 0)
    --print("using classic detail closed")
  elseif (CraftieTooltip:GetOwner() == GuildMemberDetailFrame) then
    --CraftieTooltip:SetPoint("BOTTOMRIGHT", GuildMemberDetailFrame, "BOTTOMRIGHT", 0)
    CraftieTooltip:SetPoint("BOTTOMRIGHT", GuildFrame, CraftieTooltip:GetWidth(), 0)
    --print("using classic detail open")
  end
end

function Craftie:BuildGuildRosterTooltip()
  if (IsInGuild()) then
     --Craftie:UpdateGuildMember()

    --[==[
    if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"] ~= nil) then
      for k,v in pairs(Craftie.Professions) do
        local prof = v[2]
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

    --hooksecurefunc("GuildRoster_SetSelection", function(index)

    if (Craftie.GuildFrameUsing == 2) then
      if (Craftie.CommunitiesRosterTooltipHooked) then
        return
      end
      if ((not CommunitiesFrame) or (not CommunitiesFrame.GuildMemberDetailFrame)) then
        return
      end

      local function OnGuildMemberDetailFrameDisplayed(self, clubId, memberInfo)
        Craftie.CommunitiesGuildMemberInfo = memberInfo
        if (not memberInfo) then
          CraftieTooltip:Hide()
          return
        end

        local player = Craftie:GetRosterTooltipPlayerName(memberInfo.name)
        Craftie:ShowGuildRosterTooltip(player, nil, memberInfo.classID, "COMMUNITIES_DETAIL")
      end

      local function OnGuildMemberDetailFrameEnter(self)
        local memberInfo = Craftie.CommunitiesGuildMemberInfo
        if (not memberInfo) then
          return
        end

        local player = Craftie:GetRosterTooltipPlayerName(memberInfo.name)
        Craftie:ShowGuildRosterTooltip(player, nil, memberInfo.classID, "COMMUNITIES_DETAIL")
      end

      local function OnGuildMemberDetailFrameClosed(self)
        Craftie.CommunitiesGuildMemberInfo = nil
        CraftieTooltip:Hide()
      end

      local function OnCommunitiesMemberListEntryEnter(self)
        local memberInfo = self:GetMemberInfo()
        if (not memberInfo) then
          return
        end

        local player = Craftie:GetRosterTooltipPlayerName(memberInfo.name)
        Craftie:ShowGuildRosterTooltip(player, nil, memberInfo.classID, self)
      end

      local function OnCommunitiesMemberListEntryLeave(self)
        CraftieTooltip:Hide()
      end

      if (CommunitiesFrame.GuildMemberDetailFrame.DisplayMember) then
        hooksecurefunc(CommunitiesFrame.GuildMemberDetailFrame, "DisplayMember", OnGuildMemberDetailFrameDisplayed)
      end
      CommunitiesFrame.GuildMemberDetailFrame:HookScript("OnEnter", OnGuildMemberDetailFrameEnter)
      if (CommunitiesFrame.GuildMemberDetailFrame.CloseButton) then
        CommunitiesFrame.GuildMemberDetailFrame.CloseButton:HookScript("OnClick", OnGuildMemberDetailFrameClosed)
      end
      CommunitiesFrame:HookScript("OnHide", OnGuildMemberDetailFrameClosed)

      if (CommunitiesMemberListEntryMixin) then
        hooksecurefunc(CommunitiesMemberListEntryMixin, "OnEnter", OnCommunitiesMemberListEntryEnter)
        hooksecurefunc(CommunitiesMemberListEntryMixin, "OnLeave", OnCommunitiesMemberListEntryLeave)
      end

      Craftie.CommunitiesRosterTooltipHooked = true
      Craftie:Notification("Craftie:BuildGuildRosterTooltip() communities", Craftie.CHAT.FUNC)
      return
    end

    if (Craftie.GuildRosterTooltipHooked) then
      return
    end

    for i = 1, GUILDMEMBERS_TO_DISPLAY do
      local button = _G["GuildFrameButton"..i]

      if (button) then
        button:HookScript("OnEnter", function(self)
          local index = self.guildIndex
          if (GuildListScrollFrame) then
            index = FauxScrollFrame_GetOffset(GuildListScrollFrame) + self.guildIndex
          end
          local name, rank, rankIndex, level, class = GetGuildRosterInfo(index)
          if (not name) then
            return
          end

          local player = Craftie:GetRosterTooltipPlayerName(name)
          Craftie:ShowGuildRosterTooltip(player, class, nil, "GUILD")
        end)
        button:HookScript("OnLeave", function(self)
          CraftieTooltip:Hide()
        end)
      end
    end
    Craftie.GuildRosterTooltipHooked = true
    Craftie:Notification("Craftie:BuildGuildRosterTooltip()", Craftie.CHAT.FUNC)
  end
end

--inventory/vendor
local function GameTooltip_OnTooltipSetItem(tooltip)
	local name, link = tooltip:GetItem()
	if (not link) then
    return
  end
  for k,v in pairs(Craftie.Reagents) do
    if (name == v[2]) then
      tooltip:AddLine(" ")
      tooltip:AddLine(TooltipTemplate)
      tooltip:AddLine(Craftie.Color.White .. "Reagent")
    end
  end
  if (Craftie.OpenState == 1) then
    tooltip:AddLine(" ")
    tooltip:AddLine(Craftie.Color.Gray .. "Shift+Click to link in chat")
  end
  --[==[
  if ((Craftie.OpenState == 1) and (link_to_chat == 0)) then --only when Craftie is open
    for k,v in pairs(Craftie.Professions) do
      --print(v[1])
      for i,r in pairs(Craftie.Profession[v[2]]) do
        if (name == r[2]) then
          --every crafted item
          tooltip:AddLine(" ")
          tooltip:AddLine(Craftie.Color.Gray .. "Shift+Click to link in chat")
        end
      end
    end
  end
  ]==]--
end

GameTooltip:HookScript("OnTooltipSetItem", GameTooltip_OnTooltipSetItem)
