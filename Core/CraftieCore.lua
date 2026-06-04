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

function Craftie:CloseAllPlayerMenus()
  --for i=1, Craftie.MAX_PLAYERS do
    --Craftie.Frame.ScrollPlayersListOpt[i]:Hide()
  --end
  Craftie.Frame.ScrollPlayersListSubMenu:Hide()

  Craftie.Frame.ScrollPlayersList.Child:SetAlpha(1)
  Craftie.Frame.ScrollPlayersList.Child:EnableMouse(true)
  Craftie.Frame.ScrollPlayersList.Child:EnableMouseWheel(true)

  Craftie.Frame.ScrollRecipesList.Child:SetAlpha(1)
  Craftie.Frame.ScrollRecipesList.Child:EnableMouse(true)
  Craftie.Frame.ScrollRecipesList.Child:EnableMouseWheel(true)

  Craftie.EnableScrollFrames = true
end

function Craftie:ClearCraftWindow()
  Craftie.Frame.Craft:Hide()

  for i=1, Craftie.MAX_REAGENTS do
    Craftie.Frame.Reagent.Main[i]:Hide()
    Craftie.Frame.Reagent.Back[i]:Hide()
  end
  Craftie.Frame.Craft.SourceTitle:Hide()
  Craftie.Frame.Craft.SkillText:Hide()
  Craftie.Frame.Craft.SkillIcon:Hide()
  Craftie.Frame.Craft.SourceText:Hide()
  Craftie:Notification("Craftie:ClearCraftWindow()", Craftie.TYPE.FUNC)
end

function Craftie:ClearSearchFocus()
  Craftie.Frame.Search.Recipes.Text:ClearFocus()
  if (Craftie.Frame.Search.Recipes.Text:GetText() == "") then
    Craftie.Frame.Search.Recipes.Text:SetText(Craftie.Placeholder_Recipes)
    Craftie.Frame.Search.Recipes.Text:SetFontObject(GameFontDisable)
  end
  Craftie.Frame.Search.Players.Text:ClearFocus()
  if (Craftie.Frame.Search.Players.Text:GetText() == "") then
    Craftie.Frame.Search.Players.Text:SetText(Craftie.Placeholder_Players)
    Craftie.Frame.Search.Players.Text:SetFontObject(GameFontDisable)
  end
  Craftie:Notification("Craftie:ClearSearchFocus()", Craftie.TYPE.FUNC)
end

function Craftie:DisableAllScrollBars()
  --players
    Craftie.Frame.ScrollPlayersList.Child:SetAlpha(0.4)
    Craftie.Frame.ScrollPlayersList.Child:EnableMouse(false)
    Craftie.Frame.ScrollPlayersList.Child:EnableMouseWheel(false)
    --Craftie.Frame.ScrollPlayersList.Child:SetClipsChildren(true)
  --recipes
    Craftie.Frame.ScrollRecipesList.Child:SetAlpha(0.4)
    Craftie.Frame.ScrollRecipesList.Child:EnableMouse(false)
    Craftie.Frame.ScrollRecipesList.Child:EnableMouseWheel(false)
    --Craftie.Frame.ScrollRecipesList.Child:SetClipsChildren(true)
    Craftie.EnableScrollFrames = false
end

--this also goes to the player selected scroll item
function Craftie:GetCrafterIndex(player)
  C_Timer.After(0.1, function() --give the update time to create cached tables
    for i=1, Craftie.MAX_PLAYERS do
      if (player == Craftie.Frame.ScrollPlayersListName[i]:GetText()) then
        --print(player .. " index = " .. i)
        Craftie:SelectCrafter(i, player)
      end
    end
  end)
end


function Craftie:SelectCrafter(index, name)
  Craftie:ClearSearchFocus()
  Craftie.Selected_Name = ""
  Craftie.Selected_Players = 1 --always one at first

  if (index == 1) then
    if (Craftie.Frame.Search.Recipes.Text:GetText() ~= Craftie.Placeholder_Recipes) then
      Craftie:OpenProfessionList(Craftie.ProfessionDefault, Craftie.Frame.Search.Recipes.Text:GetText(), "") --pull all
    else
      Craftie:OpenProfessionList(Craftie.ProfessionDefault, "", "") --pull all
    end
  else
    if (name ~= nil) then
      --print(name)
      Craftie.Selected_Players = index
      Craftie.Selected_Name = name
      Craftie:Notification("Craftie:SelectCrafter(" .. index .. ", " .. name .. ")", Craftie.TYPE.FUNC)
      if (Craftie.Frame.Search.Recipes.Text:GetText() ~= Craftie.Placeholder_Recipes) then
        Craftie:OpenProfessionList(Craftie.Profession[Craftie.Page], Craftie.Frame.Search.Recipes.Text:GetText(), name)
      else
        Craftie:OpenProfessionList(Craftie.Profession[Craftie.Page], "", name)
      end
    end
  end
  Craftie:SelectScrollItem("Players") --highlight

  PlaySound(SOUNDKIT.IG_QUEST_LOG_OPEN)
end

function Craftie:UpdateCrafterList(search)
  local crafter_list = {}
  local search_list = {}
  Craftie:Notification("Craftie:UpdateCrafterList()", Craftie.TYPE.FUNC)
  Craftie.Frame.ScrollPlayersResults:SetText("")
  Craftie.Frame.ScrollPlayersLoading:Show()
  Craftie.Frame.ScrollPlayersList:SetAlpha(0.3)

  for i=1, Craftie.MAX_PLAYERS do
    --Craftie.Frame.ScrollPlayersListNet[i]:Hide()
    Craftie.Frame.ScrollPlayersListFav[i]:Hide()
    Craftie.Frame.ScrollPlayersListName[i]:SetText("")
  end

  C_Timer.After(0.10, function()
    if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CRAFTERS"] ~= nil) then
      for crafter_name in pairs(CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CRAFTERS"][Craftie.Page:upper()]) do
        table.insert(crafter_list, crafter_name)
      end
    end
    search_list = crafter_list
    if (search ~= nil) then
      --Craftie:SortTableByMatch(crafter_list, search)
      --local matches = Craftie:SearchTable(crafter_list, search)
      search_list = Craftie:SearchTable(crafter_list, search)
      --print("player search " .. search)
      --print("num matches " .. matches)
    end
    for k,v in ipairs(search_list) do
      Craftie.Frame.ScrollPlayersListName[k+1]:SetText(v)
      Craftie.Frame.ScrollPlayersListFav[k+1]:Show()
    end

    local results = "|cfffffb63Crafter(s)"
    Craftie.Frame.ScrollPlayersResults:SetText(#search_list .. " " .. results)
    --[==[
    if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CRAFTERS"] ~= nil) then
      for k,v in pairs(CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CRAFTERS"][Craftie.Page:upper()]) do
        --i = i+1
        Craftie.Frame.ScrollPlayersListName[i]:SetText(k)
        --Craftie.Frame.ScrollPlayersListNet[i]:Show() --online status only works for guildies
        Craftie.Frame.ScrollPlayersListFav[i]:Show()
      end
    end
    ]==]--
  end)
  C_Timer.After(0.3, function()
    Craftie.Frame.ScrollPlayersLoading:Hide()
    Craftie.Frame.ScrollPlayersList:SetAlpha(1)
    --Craftie.Frame.ScrollPlayersList.Child:SetSelected(1)
    --Craftie.Frame.ScrollPlayersList.Child:SetVerticalScroll(20)
  end)

  Craftie.Frame.ScrollPlayersListName[1]:SetText("All " .. Craftie.Page .. " Recipes")
  --[==[
  Craftie.Frame.ScrollPlayersListFav[1]:SetTexture("Interface/LFGFRAME/UI-LFG-ICON-LOCK")
  Craftie.Frame.ScrollPlayersListFav[1]:SetPoint("TOPLEFT", 4, -3)
  Craftie.Frame.ScrollPlayersListFav[1]:Show()
  Craftie.Frame.ScrollPlayersListFav[1]:SetTexCoord(1, 0, 0, 1)
  ]==]--
  Craftie.Frame.ScrollPlayersListFav[1]:Hide()
end

function Craftie:TabSelect(tab, sound)
  local prof_name = Craftie.Professions[tab][1]
  Craftie:CloseAllPlayerMenus()
  Craftie:ClearSearchFocus()
  for i=1, #Craftie.Professions do
    Craftie.Frame.TabSide[i].Glow:Hide()
    Craftie.Frame.TabSide[i].Shadow:Show()
  end
  Craftie.Frame.TabSide[tab].Glow:Show()
  Craftie.Frame.TabSide[tab].Shadow:Hide()
  if (sound) then
    PlaySound(SOUNDKIT.IG_SPELLBOOK_OPEN)
    --PlaySound(SOUNDKIT.ALARM_CLOCK_WARNING_2) --request to craft?
  end
  Craftie.Selected_Name = ""
  Craftie.Page = prof_name
  Craftie.ProfessionDefault = Craftie.Profession[prof_name]

  C_Timer.After(0.1, function() --give it time to register
    local search_index = Craftie.Frame.Search.Recipes.Text:GetText()
    if (search_index == Craftie.Placeholder_Recipes) then
      search_index = ""
    end
    Craftie:OpenProfessionList(Craftie.ProfessionDefault, search_index, "")
    Craftie:UpdateCrafterList()
  end)

  Craftie.Selected_Players = 1
  Craftie:SelectScrollItem("Players")
  Craftie.Frame.ScrollPlayersList.Child:SetVerticalScroll(1) --go to top

  Craftie.Selected_Recipes = 1
  Craftie:SelectScrollItem("Recipes")
  Craftie.Frame.ScrollRecipesList.Child:SetVerticalScroll(1) --go to top

Craftie:Notification("Craftie:TabSelect(" .. tab .. ")", Craftie.TYPE.FUNC)

end

function Craftie:SetItemTooltip(frame, itemID, enchant, anchor)
  if (anchor) then
    GameTooltip:SetOwner(frame, anchor)
  else
    GameTooltip:SetOwner(frame, "ANCHOR_CURSOR_RIGHT")
  end
  if (enchant) then
    GameTooltip:SetHyperlink("enchant:" .. itemID .. ":0:0:0:0:0:0:0")
  else
    GameTooltip:SetHyperlink("item:" .. itemID .. ":0:0:0:0:0:0:0")
  end
  --GameTooltip:AddLine("|nCraftie")
  GameTooltip:Show()
end

function Craftie:SendPacket(prefix, data, channel, target)
  --if (channel == "GUILD") then
    --if (not IsInGuild()) then return end
  --end
  local repack = prefix .. "," .. Craftie._G.Version .. "," .. data
  local packet = Craftie:Split(data, ",")
  if (prefix == Craftie.Packet.Prefix.Data) then
    -- code | senderVer | senderName | senderClass | profNum | profLevel | profData
    repack = prefix .. "," .. Craftie._G.Version .. "," .. packet[1] .. "," .. packet[2] .. "," .. packet[3] .. "," .. packet[4] .. "," .. Craftie:BitCompression(packet[5], false)
  end

  C_ChatInfo.RegisterAddonMessagePrefix(Craftie._G.Prefix)
  if (channel == "WHISPER") then
    --C_ChatInfo.SendAddonMessage(Craftie._G.Prefix, compressPacket, channel, target)
    --C_ChatInfo.RegisterAddonMessagePrefix(Craftie._G.Prefix)
  	C_ChatInfo.SendAddonMessage(Craftie._G.Prefix, repack, channel, target)
  else
    C_ChatInfo.SendAddonMessage(Craftie._G.Prefix, repack, channel)
  end

  Craftie:Notification(repack .. " [" .. #repack .. "] -> " .. target, Craftie.TYPE.SEND)
end

Craftie.Notified = 0
function Craftie:ParsePacket(netpacket)
  local prefix = ""
  local version = 0
  local stable_version = true --determine large version chunks or stability?!?
  if (string.sub(netpacket, 1, 1) == "!") then
    local packet = Craftie:Split(netpacket, ",")

    prefix  = packet[1]
    version = tonumber(packet[2])
    if (version > tonumber(Craftie._G.Version)) then
      if (Craftie.Notified ~= 1) then --dont spam the requester
        Craftie:Notification("You have an outdated version [" .. Craftie._G.Version .. "] of [" .. version .. "]", Craftie.TYPE.ERROR)
      end
      stable_version = false
      Craftie.Notified = 1
    end
    if (version < tonumber(Craftie._G.Version)) then
      if (version < tonumber(Craftie._G.Version) - 0.01) then --version is drastically outdated by 2 minor versions, do not pull data
        Craftie:Notification("Crafter has an outdated version [" .. version .. "] of [" .. Craftie._G.Version .. "]", Craftie.TYPE.ERROR)
        stable_version = false
      else
        Craftie:Notification("Crafter has an outdated version [" .. version .. "] of [" .. Craftie._G.Version .. "]", Craftie.TYPE.WARN)
        stable_version = true
      end
    end

    if (stable_version) then
      Craftie:Notification(netpacket, Craftie.TYPE.ACK)

      --ping another crafter for their data
      if (prefix == Craftie.Packet.Prefix.Ping) then
        local requester = packet[3]
        local profPack = packet[4]
        local profParse = Craftie:Split(profPack, "|")
        local profName = profParse[1]

        if ((requester ~= Craftie.Player.Name) or (Craftie.DEBUG >= 3)) then
          Craftie:Notification("You were pinged by " .. requester .. " for " .. profName, Craftie.TYPE.ACK)
          --get my saved prof data and send it
          local profData = CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CRAFTERS"][profName:upper()][Craftie.Player.Name]
          --print("requester " .. requester)
          Craftie:SendPacket(Craftie.Packet.Prefix.Data, Craftie.Player.Name .. "," .. profData, "WHISPER", requester)
        else
          --rather than a break, just ignore
          Craftie:Notification("Requester == Self. Ignoring", Craftie.TYPE.ACK)
        end
      end

      --handshake, get crafters data and store it
      if (prefix == Craftie.Packet.Prefix.Data) then
        local crafterName = packet[3]
        --local crafterClass = Craftie.Class[tonumber(packet[4])][1]
        local crafterClass = packet[4]
        local profName  = Craftie.Professions[tonumber(packet[5])][1]
        local profNum   = packet[5]
        local profLevel = packet[6]
        local crafterData = Craftie:BitCompression(packet[7], Craftie.TYPE.ACK) --decompress
        Craftie:Notification("Receiving Data:|n" .. crafterName .. "|" .. profName .. "|n" .. crafterData, Craftie.TYPE.ACK)
        --store it
        Craftie.Packet.ACK[crafterName] = 1 --got an ack
        local profString = crafterClass .. "," .. profNum .. "," .. profLevel .. "," .. crafterData
        Craftie:Notification(profString, Craftie.TYPE.SAVE)
        CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CRAFTERS"][profName:upper()][crafterName] = profString
      end

    else
      Craftie:Notification("Malformed Packet [Version Mismatch]: " .. netpacket, Craftie.TYPE.ERROR)
    end
    --Craftie:Notification("Malformed Packet [Bad Prefix]: " .. netpacket, Craftie.TYPE.ERROR)
  end
end

Craftie.Animation = 0
Craftie.TabBarHide = 0
do
	function Craftie:TimerAnim(frame, exptime) --different anim timers, sort by frames
    if (exptime) then
			frame.frame = 0
			frame:SetScript("OnUpdate", function(self, lapse)
				self.frame = self.frame + lapse
				Craftie.Animation = exptime - self.frame
				AnimTime = Craftie.Animation / 60
        --print("Craftie.Animation " .. Craftie.Animation)
        if (Craftie.Animation >= 0.01) then
          if (frame == Craftie.Frame.Craft) then
            Craftie.Frame.Craft.Glow:SetAlpha(Craftie.Animation)
          end
          if (frame == Craftie.Frame.TabBar) then
            if (Craftie.TabBarHide == 0) then
              Craftie.Frame.TabBar:SetPoint("TOPLEFT", -Craftie.TabBar_X*self.frame, -Craftie.TabBar_Y)
            end
            if (Craftie.TabBarHide == 1) then
              Craftie.Frame.TabBar:SetPoint("TOPLEFT", -Craftie.TabBar_X*Craftie.Animation, -Craftie.TabBar_Y)
            end
          end
        end
				if (AnimTime <= 0) then
					frame:SetScript("OnUpdate", nil) --stop
				end
			end)
		end
	end
end

function Craftie:ItemDetails(item)
  local reagent = {}
  local r_next = 0 --reagent integer population
  local b_next = 0
  local loadcache = 0
  Craftie.Frame.Craft:Show()
  Craftie:ClearSearchFocus()
  Craftie:TimerAnim(Craftie.Frame.Craft, 0.65) --animate the craft icon
  --PlaySound(SOUNDKIT.IG_QUEST_LOG_OPEN)
  PlaySound(SOUNDKIT.IG_QUEST_LOG_CLOSE)

  for i=1, Craftie.MAX_REAGENTS do
    reagent[i] = 0
    --Craftie.Frame.Reagent.Main[i]:Hide()
    --Craftie.Frame.Reagent.Back[i]:Hide()
    Craftie.Frame.Reagent.Back[i]:Show() --selection was already made, draw backgrounds

    --[==[
    local back_time = i*0.026
    C_Timer.After(back_time, function()
      b_next = b_next +1
      Craftie.Frame.Reagent.Back[i]:Show()
      --print("b_next " .. b_next)
    end)
    ]==]--

    if (not Craftie:IsEmpty(item[5][i])) then
      local r = 0
      local inv_count= C_Item.GetItemCount(item[5][i][1])
      local inv_req = item[5][i][2]

      --reset
      Craftie.Frame.Reagent.Text[i]:SetTextColor(1, 1, 1, 0.8)
      Craftie.Frame.Reagent.Icon[i]:SetAlpha(0.6)
      Craftie.Frame.Reagent.Main[i]:SetBackdropBorderColor(1, 1, 1, 0)
      Craftie.Frame.Reagent.QuanI[i]:SetTextColor(1, 1, 1, 0.8)
      Craftie.Frame.Reagent.QuanR[i]:SetTextColor(1, 1, 1, 0.8)
      Craftie.Frame.Reagent.IconGlow[i]:Hide()

      r = Craftie:GetKeyFromValue(Craftie.Reagent, item[5][i][1], 1)

      local reagent_time = i*0.028
      C_Timer.After(reagent_time, function()
        r_next = r_next +1
        --print("caching " .. i)
        local name={}
        local link={}
        name[i], link[i] = C_Item.GetItemInfo(item[5][i][1])
        loadcache = 0
        if (Craftie.Reagent[r][2] == Craftie.Preload) then --pull from tooltip for missing reagents
          if (name[i] ~= nil) then --prevent LUA errors on odd reagents that have never been viewed/precached to the client
            Craftie.Reagent[r][2] = name[i]
            Craftie:Notification("Missing Reagent Precache: " .. "[" .. item[5][i][1] .. "] " .. name[i], Craftie.TYPE.WARN)
          end
          loadcache = 1
        end

        Craftie.Frame.Reagent.HLink[i]:SetText(link[i])
        Craftie.Frame.Reagent.Main[r_next]:Show()
        Craftie.Frame.Reagent.Text[i]:SetText(Craftie.Reagent[r][2])
      end)

      --Craftie.Frame.Reagent.Back[i]:Show()
      --Craftie.Frame.Reagent.Text[i]:SetText(Craftie.Reagent[r][2])
      Craftie.Frame.Reagent.Data[i]:SetText(Craftie.Reagent[r][1])

      if (inv_count >= 10) then
        Craftie.Frame.Reagent.QuanI[i]:SetText("..")
      else
        Craftie.Frame.Reagent.QuanI[i]:SetText(inv_count)
      end
      Craftie.Frame.Reagent.QuanR[i]:SetText(inv_req)
      Craftie.Frame.Reagent.Icon[i]:SetTexture(C_Item.GetItemIconByID(Craftie.Reagent[r][1]))
      --Craftie.Frame.Reagent.Main[i]:Show()

      if (loadcache == 1) then
        loadcache = 0
        C_Timer.After(0.2, function()
          Craftie.Frame.Reagent.Text[i]:SetText(Craftie.Reagent[r][2])
          Craftie:Notification("[" .. item[2] .. "] reloading from tooltip data", Craftie.TYPE.FUNC)
          --Craftie.Frame.Reagent.HLink[i]:SetText(link)
        end)
      end
      if (inv_count >= inv_req) then
        Craftie.Frame.Reagent.Main[i]:SetBackdropBorderColor(1, 1, 0.6, 0.9)
        Craftie.Frame.Reagent.Icon[i]:SetAlpha(1)
        Craftie.Frame.Reagent.Text[i]:SetTextColor(1, 1, .85, 1)
        Craftie.Frame.Reagent.QuanI[i]:SetTextColor(1, 1, .6, 1)
        Craftie.Frame.Reagent.QuanR[i]:SetTextColor(1, 1, .6, 1)
        Craftie.Frame.Reagent.IconGlow[i]:Show()
      end
      --print("craftie count " .. Craftie.Reagent[r][2] .. ": " .. item[5][i][2] .. " | " .. inv_count)
    end
  end

  Craftie.Frame.Craft.ID:SetText(item[4])
  Craftie.Frame.Craft.Text:SetText(item[2])

  --[==[
  Craftie.Frame.Craft.Text:SetPoint("TOPLEFT", 45, -12)
  if (#Craftie.Frame.Craft.Text:GetText() >= 30) then
    Craftie.Frame.Craft.Text:SetPoint("TOPLEFT", 45, -6)
  end
  ]==]--

  local item_detail = item[4]
  local is_enchant = false

  if (item_detail == "") then --blank or possibly enchant
    local name, subtext, icon, castTime, minRange, maxRange, spellID, originalIcon = GetSpellInfo(item[1])
    --print("spell? " .. name .. " | " .. icon)
    Craftie.Frame.Craft.ID:SetText(item[1])
    Craftie.Frame.Craft.Icon:SetTexture(icon)
    --print(icon)
    is_enchant = true
  else
    Craftie.Frame.Craft.Icon:SetTexture(C_Item.GetItemIconByID(item_detail))
  end

  C_Timer.After(0.12, function() --give it time to register
    Craftie.Frame.Craft.Text:SetTextColor(1, 1, 1, 1)
    if (is_enchant) then
      local link = GetSpellLink(item[1])
      Craftie.Frame.Craft.HLink:SetText(link)
      Craftie.Frame.Craft.HLink:SetScript("OnEnter", function(self)
        Craftie:SetItemTooltip(Craftie.Frame.Craft.HLink, Craftie.Frame.Craft.ID:GetText(), true)
      end)
    else
      local name, link, quality, level, minlevel, type, subtype = C_Item.GetItemInfo(item_detail)
      Craftie.Frame.Craft.HLink:SetText(link)
      if (quality ~= nil) then
        local r, g, b, qs = C_Item.GetItemQualityColor(quality)
        Craftie.Frame.Craft.Text:SetTextColor(r, g, b, 1)
      end
      Craftie.Frame.Craft.HLink:SetScript("OnEnter", function(self)
        Craftie:SetItemTooltip(Craftie.Frame.Craft.HLink, Craftie.Frame.Craft.ID:GetText(), false)
      end)
    end

    --TBC
    local SkillLevel = item[3]
    if (tonumber(item[3]) > 375) then
      SkillLevel = 375 --wowhead bug
    end
    Craftie.Frame.Craft.SkillText:SetText(Craftie.Page .. " (" .. SkillLevel .. ")")
    Craftie.Frame.Craft.HLink:SetTextColor(1, 1, 1, 0) --hide/alpha
    local source = item[6]
    local sources = source[1]
    if (#source > 1) then
      sources = ""
      for k,v in pairs(source) do
        sources = sources .. v .. ", "
      end
      Craftie.Frame.Craft.SourceText:SetText(string.sub(sources, 1, -3))
    else
      Craftie.Frame.Craft.SourceText:SetText(sources)
    end
  end)

  local prof_list = Craftie:GetKeyFromValue(Craftie.Professions, Craftie.Page, 1)
  local prof_color = Craftie:Split(Craftie.Professions[prof_list][3], ",")
  Craftie.Frame.Craft.SkillIcon:SetTexture("Interface/Icons/" .. Craftie.Professions[prof_list][2])
  Craftie.Frame.Craft.SkillText:SetTextColor(prof_color[1], prof_color[2], prof_color[3], 1)

  Craftie.Frame.Craft.Icon:Show()
  Craftie.Frame.Craft.SkillText:Show()
  Craftie.Frame.Craft.SkillIcon:Show()
  Craftie.Frame.Craft.SourceTitle:Show()
  Craftie.Frame.Craft.SourceText:Show()
end


function Craftie:SelectScrollItem(scrollFrame)
  if (Craftie.EnableScrollFrames) then
    if (scrollFrame == "Players") then
      for i=1, Craftie.MAX_PLAYERS do
        Craftie.Frame.ScrollPlayersListItem[i]:SetBackdropColor(1, 1, 1, 0)
        Craftie.Frame.ScrollPlayersListSelect[i]:Hide()
        Craftie.Frame.ScrollPlayersListSelectSpark[i]:Hide()
        Craftie.Frame.ScrollPlayersListName[i]:SetTextColor(1, 1, 1, 0.8)
      end
      Craftie.Frame.ScrollPlayersListSelect[Craftie.Selected_Players]:Show()
      Craftie.Frame.ScrollPlayersListSelectSpark[Craftie.Selected_Players]:Show()
      Craftie.Frame.ScrollPlayersListName[Craftie.Selected_Players]:SetTextColor(1, 1, 0.8, 1)
    end
    if (scrollFrame == "Recipes") then
      for i=1, Craftie.MAX_RECIPES do
        Craftie.Frame.ScrollRecipesListItem[i]:SetBackdropColor(1, 1, 1, 0)
        Craftie.Frame.ScrollRecipesListSelect[i]:Hide()
        Craftie.Frame.ScrollRecipesListSelectSpark[i]:Hide()
        Craftie.Frame.ScrollRecipesListText[i]:SetTextColor(1, 1, 1, 0.8)
      end
      Craftie.Frame.ScrollRecipesListSelect[Craftie.Selected_Recipes]:Show()
      Craftie.Frame.ScrollRecipesListSelectSpark[Craftie.Selected_Recipes]:Show()
      Craftie.Frame.ScrollRecipesListText[Craftie.Selected_Recipes]:SetTextColor(1, 1, 0.8, 1)
    end
  end
end

--version control when the app initializes
function Craftie:AlphaSortProfessionLib()
  --very important so the order is always sorted alphabetically
  for k,v in pairs(Craftie.Professions) do
    --print(v[1])
    Craftie:SortTableByString(Craftie.Profession[v[1]])
  end
end

Craftie.ProfileBuilt = {} --need to reset when learning a new recipe
function Craftie:ResetCrafterBuild()
  --clear all profession flags
  for k,v in pairs(Craftie.Professions) do
    Craftie.ProfileBuilt[v[1]] = 0
  end
  Craftie:Notification("Craftie:ResetCrafterBuild()", Craftie.TYPE.FUNC)
end

function Craftie:CrafterDataBuild(profName, profLevel)
  local profBuild = Craftie:CopyTable(Craftie.Profession[profName])
  --Craftie:SortTableByString(profBuild) --alpha sort just in case
  local profData={}
  local profString = ""

  for k,v in pairs(Craftie.Professions) do --I only care about the prio list
    if (v[1] == profName) then
      if (Craftie.ProfileBuilt[profName] <= 1) then
        C_Timer.After(0.5, function() --give it time to register the profession recipes
          --print(profName)
          for k,v in pairs(profBuild) do
            if (v[2] ~= nil) then
              profData[Craftie:SanitizeString(v[2])] = "0" --build the empty binary string
              --print(Craftie:SanitizeString(v[2]) .. " = 0")
            end
          end

          local numRecipes = GetNumTradeSkills()
          for i = 1, numRecipes do
            local recipeName, recipeType = GetTradeSkillInfo(i)
            if recipeType ~= "header" then
              if (Craftie:SanitizeString(recipeName) ~= nil) then
                profData[Craftie:SanitizeString(recipeName)] = "1"
                --print(Craftie:SanitizeString(recipeName) .. " = 1")
              end
            end
          end

          --senderName | senderClass | profNum | profLevel | profData
          --print(Craftie:GetKeyFromValue(Craftie.Professions, profName, 1))
          --print(profName .. " | " .. profLevel)
          --profString = Craftie.Player.Name .. "," .. Craftie.Player.ClassID .. "," .. Craftie:GetKeyFromValue(Craftie.Professions, profName, 1) .. "," .. profLevel .. ","
          profString = Craftie.Player.ClassID .. "," .. Craftie:GetKeyFromValue(Craftie.Professions, profName, 1) .. "," .. profLevel .. ","

          local tkeys = {}
          for k in pairs(profData) do
            table.insert(tkeys, k)
            --print(k)
          end

          --alpha sort order
          table.sort(tkeys)
          for a, b in pairs(tkeys) do
            --print(b)
            profString = profString .. profData[b]
          end

          Craftie:Notification(profString, Craftie.TYPE.SAVE)
          CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CRAFTERS"][profName:upper()][Craftie.Player.Name] = profString
        end)
      end
      Craftie.ProfileBuilt[profName] = Craftie.ProfileBuilt[profName] + 1 --we already pulled data, reset on learning new recipe
    end
  end
end

function Craftie:SetProfLevel(level)
  local profMax = 300
  local diff  = 161
  local uimax = 246 --UI Max width
  local calc = 0

  Craftie.Frame.CrafterLevel:Hide()
  Craftie.Frame.CrafterProgBarS:Hide()

  if (level) then
    if (Craftie.Game.Version == 2) then
      profMax = 375
    end
    if (Craftie.Game.Version == 3) then
      profMax = 450
    end
    calc = math.ceil((level * diff) / uimax)
    if (calc >= 1) then
      Craftie.Frame.CrafterLevel:Show()
      --print("level: " .. level .. " | " .. calc .. " [max: " .. uimax .. "]")

      Craftie.Frame.CrafterProgBar:SetSize(calc, 15)
      Craftie.Frame.CrafterProgLevel:SetText(level .. " / " .. profMax)
      local left = 0
      if (calc < 200) then
        left = 4
      end
      if (calc <= 20) then
        left = 5
      end
      Craftie.Frame.CrafterProgBar:SetPoint("TOPLEFT", 0+left, -5)
      if (level < profMax) then
        Craftie.Frame.CrafterProgBarS:SetPoint("TOPLEFT", calc-41+left, 16)
        Craftie.Frame.CrafterProgBarS:Show()
      end
    end
  end
end

function Craftie:CrafterDataParse(profName, player)
  --print(profName)
  local crafterData = {}
  local compareProf = Craftie:CopyTable(Craftie.Profession[profName])
  local crafterProf = {}
  local crafterFiltered= {}
  local class = ""
  local profLevel = ""
  local profString = ""
  local filtered = {}

  --alpha sort table (sanity check)
  Craftie:SortTableByString(compareProf)

  if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CRAFTERS"][profName:upper()][player] ~= nil) then
    --print(CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CRAFTERS"][profName:upper()][player])

    crafterData = Craftie:Split(CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CRAFTERS"][profName:upper()][player], ",")

    class = crafterData[1] --Craftie.Class[tonumber(packet[4])][1]
    profLevel = crafterData[3]
    profString = crafterData[4]

    for key, value in ipairs(compareProf) do
      if (profString:sub(key, key) == "1") then
        if (value ~= nil) then
          table.insert(filtered, value)
        end
      end
    end

    --DEBUG
    --for key = 1, #profString do
      --print("bit:", key, profString:sub(key, key), "Table:", compareProf[key] and compareProf[key][1])
    --end

    crafterProf = Craftie:CopyTable(filtered)
    Craftie:SortTableByString(crafterProf)
    --DEBUG
    --for k,v in pairs(crafterProf) do
      --print(v[2])
    --end

    Craftie:SetProfLevel(tonumber(profLevel))
    --Craftie:Notification("libraryProf " .. #Craftie.Profession[profName], Craftie.TYPE.FUNC)
    Craftie:Notification("CrafterDataParse(): [crafterClass]"  .. class .. " [profLevel]" .. profLevel .. " [profString]" .. profString, Craftie.TYPE.FUNC)
  end
  return crafterProf
end

function Craftie:OpenProfessionList(profArray, search, player)
  local profCache = {}
  Craftie.Frame.ScrollRecipesLoading:Show()
  Craftie.Frame.ScrollRecipesList:SetAlpha(0.4)
  Craftie:SetProfLevel(0)
  if (player ~= "") then
    Craftie:Notification("Using [" .. player .. "] Crafting book", Craftie.TYPE.FUNC)
    profCache = Craftie:CrafterDataParse(Craftie.Page, player)
    --Craftie.Frame.Title.Sub:SetText(player)
  else
    --Craftie:Notification("Using a default Crafting book", Craftie.TYPE.FUNC)
    profCache = Craftie:CopyTable(profArray)
  end

  local total_recipes = #profCache
  --local total_search = 0
  local results = "|cfffffb63Recipe(s)"

  Craftie:ClearCraftWindow()

  Craftie.Frame.ScrollRecipesResults:SetText("")
  Craftie.Frame.ScrollRecipesEmpty:Hide()
  --Craftie.Frame.ScrollRecipesList:SetBackdropColor(0.1, 0.6, 1, 0) --slight blue  
  if (search:len() >= 3) then
    local matches = Craftie:SortTableByMatch(profCache, search)
    if (matches >= 1) then
      total_recipes = matches
    else
      matches = 0
      total_recipes = 0
      local search_text = 'No ' .. Craftie.Page:lower() .. ' recipes|n"' .. search .. '"|n '
      if (Craftie.Selected_Name ~= "") then
        Craftie.Frame.ScrollRecipesEmpty:SetText(search_text .. "from " .. Craftie.Selected_Name)
      else
        Craftie.Frame.ScrollRecipesEmpty:SetText(search_text)
      end
      Craftie.Frame.ScrollRecipesEmpty:Show()
    end
    Craftie.Frame.ScrollRecipesResults:SetText(matches .. " " .. results)
  else
    Craftie:SortTableByString(profCache) --just go back to a alpha sort
    Craftie.Frame.ScrollRecipesResults:SetText(total_recipes .. " " .. results)
  end

  if (total_recipes < 15) then
    for i=1, Craftie.MAX_RECIPES do
      Craftie.Frame.ScrollRecipesListSelect[i]:Hide()
      Craftie.Frame.ScrollRecipesListSelectSpark[i]:Hide()
      Craftie.Frame.ScrollRecipesListText[i]:SetText("")
      Craftie.Frame.ScrollRecipesListItem[i]:SetScript("OnClick", function()
        --do nothing
      end)
    end
  else
    --hide the remainder for high level crafters
    for i=1, Craftie.MAX_RECIPES do
      Craftie.Frame.ScrollRecipesListItem[i]:Hide()
    end
  end

  if (total_recipes == 0) then
    for i=1, Craftie.MAX_RECIPES do
      Craftie.Frame.ScrollRecipesListItem[i]:Hide() --nothing to show, just clear the board
    end
  else
    for i=1, total_recipes do
      Craftie.Frame.ScrollRecipesListText[i]:SetText(profCache[i][2])
      Craftie.Frame.ScrollRecipesListItem[i]:SetScript("OnClick", function()
        if (Craftie.EnableScrollFrames) then
          Craftie:ItemDetails(profCache[i])
          --clear selections
          Craftie.Selected_Recipes = i
          Craftie:SelectScrollItem("Recipes")
        end
      end)
      Craftie.Frame.ScrollRecipesListItem[i]:Show()
    end
  end

  Craftie.Frame.Title.Prof:SetText(Craftie.Page)
  if (player ~= "") then
    local lastChar = player:sub(-1)
    local plural = "s"
    if (lastChar == plural) then
      plural = ""
    end
    Craftie.Frame.Title.Prof:SetText(player .. "'".. plural .. " " .. Craftie.Page .. " Recipes")
  end
  --local prof_list = Craftie:GetKeyFromValue(Craftie.Professions, Craftie.Page, 1)
  --local prof_color = Craftie:Split(Craftie.Professions[prof_list][3], ",")
  --Craftie.Frame.Title.Prof:SetTextColor(prof_color[1], prof_color[2], prof_color[3], 1)
  --Craftie.Frame.Icon:SetTexture("Interface/ICONS/" .. Craftie.Professions[prof_list][2])

  C_Timer.After(0.35, function()
    Craftie.Frame.ScrollRecipesLoading:Hide()
    Craftie.Frame.ScrollRecipesList:SetAlpha(1)
  end)

  Craftie:Notification("Craftie:OpenProfessionList(" .. player .. ")", Craftie.TYPE.FUNC)
end

--add a timer for parsed data
function Craftie:Open(player, profession)
  if (player) then
    Craftie:Notification("Craftie.Open player: " .. player, Craftie.TYPE.FUNC)
    Craftie:Notification("Craftie.Open profession: " .. profession, Craftie.TYPE.FUNC)
    --local prof = profession
    C_Timer.After(0.1, function() --give it time to register
      local page = Craftie:GetKeyFromValue(Craftie.Professions, profession, 1)
      Craftie:Notification("Craftie.Open: Go to " .. profession .. " => " .. player, Craftie.TYPE.FUNC)
      Craftie:TabSelect(page, true)
      Craftie.Frame:Show()
    end)
  else
    Craftie.Frame:Show()
  end
end

SLASH_Craftie1 = "/" .. Craftie._G.Prefix
function SlashCmdList.Craftie(cmd)
  if ((cmd == nil) or (cmd == "")) then
    Craftie:Open()
	end
	local _, _, cmd, args = string.find(cmd, "%s?(%w+)%s?(.*)")
	--if (cmd == Craftie._L.COMMANDS[1][1]) then
	  --Craftie.FrameOptions:Show()
  --end
  if (cmd == "options") then
    Settings.OpenToCategory(Craftie.Settings.Category:GetID())
    Craftie.Frame:Hide()
  end
  if (cmd == "show") then
    Craftie:Open()
  end

  if (cmd == "debug") then
    Craftie.Logger:Show()
  end

  for k,v in pairs(Craftie.Professions) do
    local profcmd = "p" .. k
    if (cmd == profcmd) then
      Craftie:Notification("View ALL recipes [" .. Craftie.Professions[k][1] .. "]", Craftie.TYPE.FUNC) --Craftie.Profession[Craftie.Professions[k][1]])
      Craftie:OpenProfessionList(Craftie.Profession[Craftie.Professions[k][1]], "", "")
    end
  end
end

--caching tooltip data. preload unknown data
Craftie.Reagent = {}
function Craftie:BuildReagentGaps()
  for i=1, Craftie.MAX_ITEMIDS do
    table.insert(Craftie.Reagent, {i, Craftie.Preload})
  end
  for k,v in pairs(Craftie.Reagents) do
    Craftie.Reagent[v[1]] = {v[1], v[2]}
  end
  Craftie:Notification("Craftie:BuildReagentGaps()", Craftie.TYPE.FUNC)
end

--use the classic frame, but updated images. The updated frame has major bugs
function Craftie:ScrollBarFrame(frame)
  local _scrollUp = Craftie._G.Path .. "Images/UI-Craftie-Scroll-Arr.png"
  local _scrollDn = Craftie._G.Path .. "Images/UI-Craftie-Scroll-Dn.png"
  local _scrollSlider = frame.ScrollBar:GetThumbTexture()
  _scrollSlider:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Scroll-Slider.png")
  _scrollSlider:SetSize(10, 40)
  frame.ScrollBar.ScrollUpButton:SetNormalTexture(_scrollUp)
  frame.ScrollBar.ScrollUpButton:SetPushedTexture(_scrollUp)
  frame.ScrollBar.ScrollUpButton:SetHighlightTexture(_scrollUp, "ADD")
  frame.ScrollBar.ScrollUpButton:SetDisabledTexture(_scrollUp, "ADD")
  frame.ScrollBar.ScrollUpButton:SetSize(15, 12)
  frame.ScrollBar.ScrollDownButton:SetNormalTexture(_scrollDn)
  frame.ScrollBar.ScrollDownButton:SetPushedTexture(_scrollDn)
  frame.ScrollBar.ScrollDownButton:SetHighlightTexture(_scrollDn, "ADD")
  frame.ScrollBar.ScrollDownButton:SetDisabledTexture(_scrollDn, "ADD")
  frame.ScrollBar.ScrollDownButton:SetSize(15, 12)
  ScrollBack = frame:CreateTexture(nil, "BORDER")
  ScrollBack:SetSize(40, frame:GetHeight()-42)
  ScrollBack:SetPoint("TOPLEFT", frame:GetWidth()-27, -18)
  ScrollBack:SetVertTile(true)
  ScrollBack:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Scroll-Back.png", "REPEAT")
end


function Craftie:SaveMapButtonPos()
  Craftie:UpdateMapButton()
  C_Timer.After(0.1, function()
    local point, relativeTo, relativePoint, xOfs, yOfs = Craftie.Frame.Button.Minimap:GetPoint()
    CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["CONFIG"]["POS_MINIMAP"] = math.ceil(xOfs) .. "," .. math.ceil(yOfs)
    --print(point .. "," .. math.ceil(xOfs) .. "," .. math.ceil(yOfs))
    Craftie:Notification("Craftie:SaveMapButtonPos() = " .. math.ceil(xOfs) .. "," .. math.ceil(yOfs), Craftie.TYPE.SAVE)
  end)
end

function Craftie:UpdateMapButton()
  local thisIconPos = 0
  local Xpoa, Ypoa = GetCursorPosition()
  local Xmin, Ymin = Minimap:GetLeft(), Minimap:GetBottom()
  Xpoa = Xmin - Xpoa / Minimap:GetEffectiveScale() + 70
  Ypoa = Ypoa / Minimap:GetEffectiveScale() - Ymin - 70
  thisIconPos = math.deg(math.atan2(Ypoa, Xpoa))
  Craftie.Frame.Button.Minimap:ClearAllPoints()
  Craftie.Frame.Button.Minimap:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 60-(80 * cos(thisIconPos)), (80 * sin(thisIconPos))-60)

  --Craftie:Notification("Craftie:UpdateMapButton()", Craftie.TYPE.FUNC)
end
