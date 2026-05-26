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

Craftie.DEBUG = true

Craftie._G = {
  Author = "Porthias",
  Width  = 820,
  Height = 460,
  Prefix = "Craftie",
  Update = 20260608,
  Icon   = "icon_default_simple",
}

Craftie._G.Version = C_AddOns.GetAddOnMetadata("Craftie", "version")

Craftie._G.Font={}
Craftie._G.Font.Style= "Interface/Addons/Craftie/Fonts/FRIZQT__.ttf"
Craftie._G.Font.Size = 11
Craftie._G.Font.Color = "|cffFF9524"

Craftie._G.Path = "Interface/Addons/Craftie/"
Craftie._G.Title = Craftie._G.Font.Color .. Craftie._G.Prefix .. "|r"
Craftie._G.Stamp = Craftie._G.Title .. " v" .. Craftie._G.Version

Craftie.Framelevel = {
  Background= 0,
  Foreground= 1,
  Menu      = 2,
  Buttons   = 3,
  Cover     = 4,
}

Craftie.Backdrop = {
  General = {
    bgFile  = "Interface/Tooltips/UI-Tooltip-Background",
    edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
    edgeSize= 12,
    insets  = {left=2, right=2, top=2, bottom=2},
  },
  Opaque = {
    bgFile  = "Interface/Tooltips/CHATBUBBLE-BACKGROUND",
    edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
    edgeSize= 12,
    insets  = {left=2, right=2, top=2, bottom=2},
  },
  Borderless = {
    bgFile  = "Interface/Tooltips/UI-Tooltip-Background",
    edgeFile= "",
    edgeSize= 2,
    insets  = {left=2, right=2, top=0, bottom=0},
  },
  Slider = {
    Template = "UISliderTemplateWithLabels",
  }
}

function Craftie.Notification(msg, debug)
  if ((debug) and (Craftie.DEBUG)) then
    print(Craftie._G.Title .. " DEBUG: " .. msg)
  end
  if (not debug) then
    print(Craftie._G.Title .. " " .. msg)
  end
  if (Craftie.Frame ~= nil) then
    local history = Craftie.Logger.Data:GetText()
    --chrono top
    Craftie.Logger.Data:SetText("|cFFFFFC99[" .. date("%Y%m%d %H:%M:%S") .. "]|r|n" .. msg .. "|n|n" .. history)
    --Craftie.Logger.Data:SetText("|cFFFFFC99[" .. date("%Y%m%d%H%M%S") .. "]|r|n" .. msg .. "|n|n" .. history)
    --Craftie.Logger.Data:SetText(history .. "|n|n ----- " .. date("%Y%m%d [%H%M%S]") .. " -----|n" .. msg)
  end
end

Craftie.MAX_REAGENTS = 6
Craftie.MAX_RECIPES = 600
Craftie.MAX_PLAYERS = 300 --per profession
Craftie.MAX_ITEMIDS = 60000 -- some items go up to 58k

Craftie.ProfessionDefault = Craftie.CopyTable(Craftie.Profession.Alchemy)
Craftie.ProfessionSearch = Craftie.CopyTable(Craftie.Profession.Alchemy)

Craftie.Placeholder_Players = "Search Crafters..."
Craftie.Placeholder_Recipes = "Search Recipes..."
Craftie.Selected_Players = 1
Craftie.Selected_Recipes = 1
Craftie.Selected_ViewAll = "All Alchemy Recipes" --default
Craftie.Selected_Name = ""
Craftie.Preload = "|cFF27CCF5Loading Data...|r"
Craftie.Page = "Alchemy" --default

-- Global Frames
Craftie.Frame={}
Craftie.Frame = CreateFrame("Frame", 'Craftie.Frame', UIParent, "ButtonFrameTemplate")
Craftie.Frame.Search={}

Craftie.EnableScrollFrames = true

Craftie.TabBar_X = 42
Craftie.TabBar_Y = 50

function Craftie.CloseAllPlayerMenus()
  for i=1, Craftie.MAX_PLAYERS do
    Craftie.Frame.ScrollPlayersListOpt.Menu[i]:Hide()
    Craftie.Frame.ScrollPlayersListOpt[i]:Hide()
  end
  Craftie.Frame.ScrollPlayersList.Child:SetAlpha(1)
  Craftie.Frame.ScrollPlayersList.Child:EnableMouse(true)
  Craftie.Frame.ScrollPlayersList.Child:EnableMouseWheel(true)

  Craftie.Frame.ScrollRecipesList.Child:SetAlpha(1)
  Craftie.Frame.ScrollRecipesList.Child:EnableMouse(true)
  Craftie.Frame.ScrollRecipesList.Child:EnableMouseWheel(true)

  Craftie.EnableScrollFrames = true
end

function Craftie.TabSelect(tab, sound)
  local prof_name = Craftie.Professions[tab][1]
  Craftie.CloseAllPlayerMenus()
  Craftie.ClearFocusAll()
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

  C_Timer.After(0.10, function() --give it time to register
    local search_index = Craftie.Frame.Search.Recipes.Text:GetText()
    if (search_index == Craftie.Placeholder_Recipes) then
      search_index = ""
    end
    Craftie.OpenProfessionList(Craftie.ProfessionDefault, search_index, "")
    Craftie.UpdateCrafterList()
  end)

  Craftie.Selected_Players = 1
  Craftie.SelectScrollItem("Players")
  Craftie.Frame.ScrollPlayersList.Child:SetVerticalScroll(1) --go to top

  Craftie.Selected_Recipes = 1
  Craftie.SelectScrollItem("Recipes")
  Craftie.Frame.ScrollRecipesList.Child:SetVerticalScroll(1) --go to top

  Craftie.Frame.Craft:Hide()

  for i=1, Craftie.MAX_REAGENTS do
    Craftie.Frame.Reagent.Main[i]:Hide()
    Craftie.Frame.Reagent.Back[i]:Hide()
  end

end

function Craftie.ClearFocusAll()
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
  --Craftie.Notification("Craftie.ClearFocusAll()", true)
end

function SetItemTooltip(frame, itemID, enchant, anchor)

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

--sendpacket builds the string, then compresses before submitting
function Craftie.SendPacket(prefix, data, channel, target)
  --if (channel == "GUILD") then
    --if (not IsInGuild()) then return end
  --end
  local repack = prefix .. "," .. Craftie._G.Version .. "," .. data
  local packet = Craftie.Split(data, ",")
  if (prefix == Craftie.Packet.Prefix.Data) then
    -- code | senderVer | senderName | senderClass | profNum | profLevel | profData
    repack = prefix .. "," .. Craftie._G.Version .. "," .. packet[1] .. "," .. packet[2] .. "," .. packet[3] .. "," .. packet[4] .. "," .. Craftie.BitCompression(packet[5], false)
  end

  C_ChatInfo.RegisterAddonMessagePrefix(Craftie._G.Prefix)
  if (channel == "WHISPER") then
    --C_ChatInfo.SendAddonMessage(Craftie._G.Prefix, compressPacket, channel, target)
    --C_ChatInfo.RegisterAddonMessagePrefix(Craftie._G.Prefix)
  	C_ChatInfo.SendAddonMessage(Craftie._G.Prefix, repack, channel, target)
    --Craftie.Notification("Send Whisper " .. target, true)
  else
    C_ChatInfo.SendAddonMessage(Craftie._G.Prefix, repack, channel)
    --Craftie.Notification("Send " .. channel, true)
  end

  Craftie.Notification("|CFF89DE49Sending Packet:|r " .. repack .. " [" .. #repack .. "]", true)
end

--Seed examples
--sendpacket examples
--Craftie.Seed = "Portheus,3,1,32,10001010010000010101000101110101100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
--Craftie.Seed = "Portheus,3,1,62,100000000000010000000000000000111100000000000000000001000000000000000000010101010101101110111111111100000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000100000000000000000011000000000000000000000000000000000000000000000010000000000011100000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000010111111111111010111111111110000000"
--Craftie.Seed = "Portheus,3,3,131,11111111111111111111111111111111110111111111010010001110111011111100010010101010010110110011001000000111010100010010110101010111111111010001001010101010110111110110101001011101001010101010101010010100101001001111001110010100100100101010100100001000100100011100001001010101000101101010010010010101010111011101010101010101010111111111010001001010101010110111110110101001011111101001011111011101111011011011111111101100101111100101001001111111111111101111111110101111111111111111111111110"
--Craftie.Seed = "Portheus,3,3,375,111111111111111111011111111111111101111111111111111111111111111110001111111111111111111110111111111111111111111101111111111111011111111101101110111111111111111111101111111011111111111111111111110111111111011111111111111111111111111111111111111111111111111111111110111111111111111111111110111111111111111111111111111111111111111111111111111111111111111111111101100011111111111111111111111111111111111111111111111111111111"

Craftie.Notified = 0
function Craftie.ParsePacket(netpacket)
  local prefix = ""
  local version = 0
  local stable_version = true --determine large version chunks or stability?!?
  if (string.sub(netpacket, 1, 1) == "!") then
    local packet = Craftie.Split(netpacket, ",")

    prefix  = packet[1]
    version = tonumber(packet[2])

    if (version > tonumber(Craftie._G.Version)) then
      if (Craftie.Notified ~= 1) then --dont spam the requester
        Craftie.Notification("|cFFFF0000ERROR:|r You have an outdated version [" .. Craftie._G.Version .. "] of [" .. version .. "]")
      end
      stable_version = false
      Craftie.Notified = 1
    end
    if (version < tonumber(Craftie._G.Version)) then
      if (version < tonumber(Craftie._G.Version) - 0.01) then --version is drastically outdated by 2 minor versions, do not pull data
        Craftie.Notification("|cFFFF0000ERROR:|r Crafter has an outdated version [" .. version .. "] of [" .. Craftie._G.Version .. "]")
        stable_version = false
      else
        Craftie.Notification("|cFFFFC300WARNING:|r Crafter has an outdated version [" .. version .. "] of [" .. Craftie._G.Version .. "]")
        stable_version = true
      end
    end

    if (stable_version) then
      Craftie.Notification("|CFFD177F7Parsing Packet: |r" .. netpacket, true)

      --ping another crafter for their data
      if (prefix == Craftie.Packet.Prefix.Ping) then
        local requester = packet[3]
        local profPack = packet[4]
        local profParse = Craftie.Split(profPack, "|")
        local profName = profParse[1]

        if ((requester ~= Craftie.Player.Name) or (Craftie.DEBUG)) then
          Craftie.Notification("You were pinged by " .. requester .. " for " .. profName, true)
          --get my saved prof data and send it
          local profData = CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CRAFTERS"][profName:upper()][Craftie.Player.Name]
          --print("requester " .. requester)
          Craftie.SendPacket(Craftie.Packet.Prefix.Data, Craftie.Player.Name .. "," .. profData, "WHISPER", requester)
        else
          --rather than a break, just ignore
          Craftie.Notification("Requester == Self. Ignoring", true)
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
        local crafterData = Craftie.BitCompression(packet[7], true) --decompress
        Craftie.Notification("Receiving Data:|n" .. crafterName .. "|" .. profName .. "|n" .. crafterData, true)
        --store it
        Craftie.Packet.ACK[crafterName] = 1 --got an ack
        local profString = crafterClass .. "," .. profNum .. "," .. profLevel .. "," .. crafterData
        Craftie.Notification("Storing Data:|n" .. profString, true)
        CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CRAFTERS"][profName:upper()][crafterName] = profString
        --Craftie.Open(player, prof) --need to cache player data loading
      end

    else
      Craftie.Notification("|cFFFF0000ERROR:|r Malformed Packet: " .. netpacket, true)
    end
  end
end

--function Craftie.ParsePlayer(netpacket)
  --local decompress = Craftie.LowCompression(netpacket, true)
--end

Craftie.Animation = 0
Craftie.TabBarHide = 0
do
	function Craftie.TimerAnim(frame, exptime) --different anim timers, sort by frames
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

function Craftie.ItemDetails(item)
  local reagent = {}
  local r_next = 0 --reagent integer population
  local b_next = 0
  local loadcache = 0
  Craftie.Frame.Craft:Show()
  Craftie.ClearFocusAll()
  Craftie.TimerAnim(Craftie.Frame.Craft, 0.65) --animate the craft icon
  --PlaySound(SOUNDKIT.IG_QUEST_LOG_OPEN)
  PlaySound(SOUNDKIT.IG_QUEST_LOG_CLOSE)

  for i=1, Craftie.MAX_REAGENTS do
    reagent[i] = 0
    Craftie.Frame.Reagent.Main[i]:Hide()
    --Craftie.Frame.Reagent.Back[i]:Show() --selection was already made, draw backgrounds
    Craftie.Frame.Reagent.Back[i]:Hide()

    local back_time = i*0.026
    C_Timer.After(back_time, function()
      b_next = b_next +1
      Craftie.Frame.Reagent.Back[i]:Show()
      --print("b_next " .. b_next)
    end)

    if (not Craftie.IsEmpty(item[5][i])) then
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

      r = Craftie.GetKeyFromValue(Craftie.Reagent, item[5][i][1], 1)

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
          end
          loadcache = 1
        end

        Craftie.Frame.Reagent.HLink[i]:SetText(link[i])
        Craftie.Frame.Reagent.Main[r_next]:Show()
      end)

      --Craftie.Frame.Reagent.Back[i]:Show()

      Craftie.Frame.Reagent.Text[i]:SetText(Craftie.Reagent[r][2])
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
          Craftie.Notification("[" .. item[2] .. "] reloading from tooltip data", true)
          --Craftie.Frame.Reagent.HLink[i]:SetText(link)
        end)
      end
      if (inv_count >= inv_req) then
        Craftie.Frame.Reagent.Main[i]:SetBackdropBorderColor(1, 1, 0.6, 0.9)
        Craftie.Frame.Reagent.Icon[i]:SetAlpha(1)
        Craftie.Frame.Reagent.Text[i]:SetTextColor(1, 1, 1, 1)
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
      --Craftie.Frame.Craft.HLink:SetText("ENCHANT DATA TEXT HERE")
      Craftie.Frame.Craft.HLink:SetText(link)
      Craftie.Frame.Craft.HLink:SetScript("OnEnter", function(self)
        SetItemTooltip(Craftie.Frame.Craft.HLink, Craftie.Frame.Craft.ID:GetText(), true)
      end)
    else
      local name, link, quality, level, minlevel, type, subtype = C_Item.GetItemInfo(item_detail)
      Craftie.Frame.Craft.HLink:SetText(link)
      if (quality ~= nil) then
        local r, g, b, qs = C_Item.GetItemQualityColor(quality)
        Craftie.Frame.Craft.Text:SetTextColor(r, g, b, 1)
      end
      Craftie.Frame.Craft.HLink:SetScript("OnEnter", function(self)
        SetItemTooltip(Craftie.Frame.Craft.HLink, Craftie.Frame.Craft.ID:GetText(), false)
      end)
    end

    --TBC
    local SkillLevel = item[3]
    if (tonumber(item[3]) > 375) then
      SkillLevel = 375 --wowhead bug
    end
    Craftie.Frame.Craft.Skill:SetText(Craftie.Page .. " (" .. SkillLevel .. ")")
    Craftie.Frame.Craft.HLink:SetTextColor(1, 1, 1, 0) --hide/alpha
    local source = item[6]
    local sources = source[1]
    if (#source > 1) then
      sources = ""
      for k,v in pairs(source) do
        sources = sources .. v .. ", "
      end
      Craftie.Frame.Craft.Source:SetText(string.sub(sources, 1, -3))
    else
      Craftie.Frame.Craft.Source:SetText(sources)
    end
  end)

  local prof_list = Craftie.GetKeyFromValue(Craftie.Professions, Craftie.Page, 1)
  local prof_color = Craftie.Split(Craftie.Professions[prof_list][3], ",")
  Craftie.Frame.Craft.SkillIcon:SetTexture("Interface/Icons/" .. Craftie.Professions[prof_list][2])
  Craftie.Frame.Craft.Skill:SetTextColor(prof_color[1], prof_color[2], prof_color[3], 1)
  --Craftie.Frame.Craft.Skill:Hide()
  --Craftie.Frame.Craft.SkillIcon:Hide()
  --Craftie.Frame.Craft.Icon:Hide()
  Craftie.Frame.Craft.Icon:Show()
  Craftie.Frame.Craft.Skill:Show()
  Craftie.Frame.Craft.SkillIcon:Show()
  Craftie.Frame.Craft.SourceTitle:Show()
  Craftie.Frame.Craft.Source:Show()
end


function Craftie.SelectScrollItem(scrollFrame)
  if (Craftie.EnableScrollFrames) then
    if (scrollFrame == "Players") then
      for i=1, Craftie.MAX_PLAYERS do
        Craftie.Frame.ScrollPlayersListItem[i]:SetBackdropColor(1, 1, 1, 0)
        Craftie.Frame.ScrollPlayersListSelect[i]:Hide()
        Craftie.Frame.ScrollPlayersListText[i]:SetTextColor(1, 1, 1, 0.8)
      end
      Craftie.Frame.ScrollPlayersListSelect[Craftie.Selected_Players]:Show()
      Craftie.Frame.ScrollPlayersListText[Craftie.Selected_Players]:SetTextColor(1, 1, 0.8, 1)
    end
    if (scrollFrame == "Recipes") then
      for i=1, Craftie.MAX_RECIPES do
        Craftie.Frame.ScrollRecipesListItem[i]:SetBackdropColor(1, 1, 1, 0)
        Craftie.Frame.ScrollRecipesListSelect[i]:Hide()
        Craftie.Frame.ScrollRecipesListText[i]:SetTextColor(1, 1, 1, 0.8)
      end
      Craftie.Frame.ScrollRecipesListSelect[Craftie.Selected_Recipes]:Show()
      Craftie.Frame.ScrollRecipesListText[Craftie.Selected_Recipes]:SetTextColor(1, 1, 0.8, 1)
    end
  end
end

--[==[ --doesnt work in Classic
function Craftie.GetRecipeIDByName(recipeName)
  for i = 1, GetNumTradeSkills() do
    local name, skillType = GetTradeSkillInfo(i)
    if skillType ~= "header" and name == recipeName then
      local recipeLink = GetTradeSkillRecipeLink(i)
      if recipeLink then
        local spellID = string.match(recipeLink, "Hspell:(%d+)")
        return tonumber(spellID)
      end
    end
  end
  return nil
end
]==]--

function Craftie.AlphaSortProfessionLib()
  --very important so the order is always sorted alphabetically
  for k,v in pairs(Craftie.Professions) do
    --print(v[1])
    Craftie.SortTableByString(Craftie.Profession[v[1]])
  end
end

Craftie.ProfileBuilt = {} --need to reset when learning a new recipe
function Craftie.ResetCrafterBuild()
  --clear all profession flags
  for k,v in pairs(Craftie.Professions) do
    Craftie.ProfileBuilt[v[1]] = 0
  end
  Craftie.Notification("Craftie.ResetCrafterBuild() flags", true)
end

function Craftie.CrafterDataBuild(profName, profLevel)
  local profBuild = Craftie.CopyTable(Craftie.Profession[profName])
  --Craftie.SortTableByString(profBuild) --alpha sort just in case
  local profData={}
  local profString = ""

  for k,v in pairs(Craftie.Professions) do --I only care about the prio list
    if (v[1] == profName) then
      if (Craftie.ProfileBuilt[profName] <= 1) then
        C_Timer.After(0.5, function() --give it time to register the profession recipes
          --print(profName)
          for k,v in pairs(profBuild) do
            if (v[2] ~= nil) then
              profData[_sanitize(v[2])] = "0" --build the empty binary string
              --print(_sanitize(v[2]) .. " = 0")
            end
          end

          local numRecipes = GetNumTradeSkills()
          for i = 1, numRecipes do
            local recipeName, recipeType = GetTradeSkillInfo(i)
            if recipeType ~= "header" then
              if (_sanitize(recipeName) ~= nil) then
                profData[_sanitize(recipeName)] = "1"
                --print(_sanitize(recipeName) .. " = 1")
              end
            end
          end

          --senderName | senderClass | profNum | profLevel | profData
          --print(Craftie.GetKeyFromValue(Craftie.Professions, profName, 1))
          --print(profName .. " | " .. profLevel)
          --profString = Craftie.Player.Name .. "," .. Craftie.Player.ClassID .. "," .. Craftie.GetKeyFromValue(Craftie.Professions, profName, 1) .. "," .. profLevel .. ","
          profString = Craftie.Player.ClassID .. "," .. Craftie.GetKeyFromValue(Craftie.Professions, profName, 1) .. "," .. profLevel .. ","

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

          Craftie.Notification(profString, true)
          CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CRAFTERS"][profName:upper()][Craftie.Player.Name] = profString
        end)
      end
      Craftie.ProfileBuilt[profName] = Craftie.ProfileBuilt[profName] + 1 --we already pulled data, reset on learning new recipe
    end
  end
end

function Craftie.SetProfLevel(level)
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

function Craftie.CrafterDataParse(profName, player)
  --print(profName)
  local crafterData = {}
  local compareProf = Craftie.CopyTable(Craftie.Profession[profName])
  local crafterProf = {}
  local crafterFiltered= {}
  local class = ""
  local profLevel = ""
  local profString = ""
  local filtered = {}

  --alpha sort table (sanity check)
  Craftie.SortTableByString(compareProf)

  if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CRAFTERS"][profName:upper()][player] ~= nil) then
    --print(CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CRAFTERS"][profName:upper()][player])

    crafterData = Craftie.Split(CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CRAFTERS"][profName:upper()][player], ",")

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

    crafterProf = Craftie.CopyTable(filtered)
    Craftie.SortTableByString(crafterProf)
    --for k,v in pairs(crafterProf) do
      --print(v[2])
    --end

    Craftie.Notification("class " .. class, true) --not sure if this is relevant
    Craftie.Notification("profLevel " .. profLevel, true)
    Craftie.SetProfLevel(tonumber(profLevel))
    --Craftie.Notification("compareProf " .. #compareProf, true)
    Craftie.Notification("crafterProf " .. #crafterProf, true)
    Craftie.Notification("libraryProf " .. #Craftie.Profession[profName], true)
    Craftie.Notification("profString " .. profString, true)
  end
  return crafterProf
end

function Craftie.OpenProfessionList(profArray, search, player)
  local profCache = {}
  Craftie.Frame.ScrollRecipes.Loading:Show()
  Craftie.Frame.ScrollRecipesList:SetAlpha(0.4)
  Craftie.SetProfLevel(0)
  if (player ~= "") then
    Craftie.Notification("Using " .. player .. "Crafting book", true)
    profCache = Craftie.CrafterDataParse(Craftie.Page, player)
    --Craftie.Frame.Title.Sub:SetText(player)
  else
    Craftie.Notification("Using a default Crafting book", true)
    profCache = Craftie.CopyTable(profArray)
  end

  local total_recipes = #profCache
  --local total_search = 0
  local results = "|cfffffb63Recipe(s)"
  Craftie.Frame.ScrollRecipes.Results:SetText("")
  Craftie.Frame.ScrollRecipes.Empty:SetText("")
  --Craftie.Frame.ScrollRecipesList:SetBackdropColor(0.1, 0.6, 1, 0) --slight blue  
  if (search:len() >= 3) then
    local matches = Craftie.SortTableByMatch(profCache, search)
    if (matches >= 1) then
      total_recipes = matches
    else
      matches = 0
      total_recipes = 0
      local search_text = 'No ' .. Craftie.Page:lower() .. ' recipes|n"' .. search .. '"|n '
      if (Craftie.Selected_Name ~= "") then
        Craftie.Frame.ScrollRecipes.Empty:SetText(search_text .. "from " .. Craftie.Selected_Name)
      else
        Craftie.Frame.ScrollRecipes.Empty:SetText(search_text)
      end
    end
    Craftie.Frame.ScrollRecipes.Results:SetText(matches .. " " .. results)
  else
    Craftie.SortTableByString(profCache) --just go back to a alpha sort
    Craftie.Frame.ScrollRecipes.Results:SetText(total_recipes .. " " .. results)
  end

  if (total_recipes >= 15) then
    for i=1, Craftie.MAX_RECIPES do
      Craftie.Frame.ScrollRecipesListItem[i]:Hide() --hide the remainder for high level crafters
    end
  else
    for i=1, Craftie.MAX_RECIPES do
      Craftie.Frame.ScrollRecipesListSelect[i]:Hide()
      Craftie.Frame.ScrollRecipesListText[i]:SetText("")
      Craftie.Frame.ScrollRecipesListItem[i]:SetScript("OnClick", function()
      end)
    end
  end

  for i=1, total_recipes do
    Craftie.Frame.ScrollRecipesListText[i]:SetText(profCache[i][2])
    Craftie.Frame.ScrollRecipesListItem[i]:SetScript("OnClick", function()
      if (Craftie.EnableScrollFrames) then
        Craftie.ItemDetails(profCache[i])
        --clear selections
        Craftie.Selected_Recipes = i
        Craftie.SelectScrollItem("Recipes")
      end
    end)
    Craftie.Frame.ScrollRecipesListItem[i]:Show()
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
  local prof_list = Craftie.GetKeyFromValue(Craftie.Professions, Craftie.Page, 1)
  local prof_color = Craftie.Split(Craftie.Professions[prof_list][3], ",")
  Craftie.Frame.Title.Prof:SetTextColor(prof_color[1], prof_color[2], prof_color[3], 1)
  --Craftie.Frame.Icon:SetTexture("Interface/ICONS/" .. Craftie.Professions[prof_list][2])

  C_Timer.After(0.35, function()
    Craftie.Frame.ScrollRecipes.Loading:Hide()
    Craftie.Frame.ScrollRecipesList:SetAlpha(1)
  end)

  Craftie.Notification("Craftie.OpenProfessionList(" .. player .. ")", true)
end

--add a timer for parsed data
function Craftie.Open(player, profession)
  if (player) then
    print("Craftie.Open player: " .. player)
    print("Craftie.Open profession: " .. profession)
    --local prof = profession
    C_Timer.After(0.1, function() --give it time to register
      local page = Craftie.GetKeyFromValue(Craftie.Professions, profession, 1)
      Craftie.TabSelect(page, true)
      Craftie.Frame:Show()
    end)
  else
    Craftie.Frame:Show()
  end
end

SLASH_Craftie1 = "/" .. Craftie._G.Prefix
function SlashCmdList.Craftie(cmd)
  if ((cmd == nil) or (cmd == "")) then
    print("list of commands")
	end
	local _, _, cmd, args = string.find(cmd, "%s?(%w+)%s?(.*)")
	--if (cmd == Craftie._L.COMMANDS[1][1]) then
	  --Craftie.FrameOptions:Show()
  --end
  if (cmd == "show") then
    Craftie.Open()
  end

  for k,v in pairs(Craftie.Professions) do
    local profcmd = "p" .. k
    if (cmd == profcmd) then
      Craftie.Notification("View ALL recipes [" .. Craftie.Professions[k][1] .. "]", true) --Craftie.Profession[Craftie.Professions[k][1]])
      Craftie.OpenProfessionList(Craftie.Profession[Craftie.Professions[k][1]], "", "")
    end
  end
end

--caching tooltip data. preload unknown data
Craftie.Reagent = {}
function Craftie.BuildReagentGaps()
  for i=1, Craftie.MAX_ITEMIDS do
    table.insert(Craftie.Reagent, {i, Craftie.Preload})
  end
  for k,v in pairs(Craftie.Reagents) do
    Craftie.Reagent[v[1]] = {v[1], v[2]}
  end
end

function Craftie.SaveMapButtonPos()
	--Craftie.UpdateMapButton()
  local point, relativeTo, relativePoint, xOfs, yOfs = Craftie.Frame.Button.Minimap:GetPoint()
	CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["CONFIG"]["POS_MINIMAP"] = math.ceil(xOfs) .. "," .. math.ceil(yOfs)
  --print(point .. "," .. math.ceil(xOfs) .. "," .. math.ceil(yOfs))
  Craftie.UpdateMapButton()
end

function Craftie.UpdateMapButton()
  local thisIconPos = 0
  local Xpoa, Ypoa = GetCursorPosition()
  local Xmin, Ymin = Minimap:GetLeft(), Minimap:GetBottom()
  Xpoa = Xmin - Xpoa / Minimap:GetEffectiveScale() + 70
  Ypoa = Ypoa / Minimap:GetEffectiveScale() - Ymin - 70
  thisIconPos = math.deg(math.atan2(Ypoa, Xpoa))
  Craftie.Frame.Button.Minimap:ClearAllPoints()
  Craftie.Frame.Button.Minimap:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 60-(80 * cos(thisIconPos)), (80 * sin(thisIconPos))-60)
end

function Craftie.DividerHorz(parentFrame, x, y, w)
  local DividerFrame = {}
  DividerFrame.Midd = parentFrame:CreateTexture(nil, "ARTWORK")
  DividerFrame.Midd:SetSize(w, 12)
  DividerFrame.Midd:SetPoint("TOPLEFT", x+16, y)
  DividerFrame.Midd:SetHorizTile(true)
  DividerFrame.Midd:SetTexture(Craftie._G.Path .. "images/FrameDividerMidd.png", "REPEAT")
  DividerFrame.Left = parentFrame:CreateTexture(nil, "ARTWORK")
  DividerFrame.Left:SetSize(16, 12)
  DividerFrame.Left:SetPoint("TOPLEFT", x, y)
  DividerFrame.Left:SetTexture(Craftie._G.Path .. "images/FrameDividerEnd.png")
  DividerFrame.Right = parentFrame:CreateTexture(nil, "ARTWORK")
  DividerFrame.Right:SetSize(16, 12)
  DividerFrame.Right:SetPoint("TOPLEFT", w, y)
  DividerFrame.Right:SetTexture(Craftie._G.Path .. "images/FrameDividerEnd.png")
  DividerFrame.Right:SetTexCoord(1, 0, 1, 1, 0, 0, 0, 1) --mirror
  --DividerFrame.Right:SetTexCoord(0, 1, 1, 1, 0, 0, 1, 0) -- Flips vertically
  --DividerFrame.Right:SetRotation(-math.pi)
end

function Craftie.DividerVert(parentFrame, x, y, h)
  local DividerFrame = {}
  DividerFrame.Midd = parentFrame:CreateTexture(nil, "ARTWORK")
  DividerFrame.Midd:SetSize(12, h)
  DividerFrame.Midd:SetPoint("TOPLEFT", x+16, y)
  DividerFrame.Midd:SetVertTile(true)
  DividerFrame.Midd:SetTexture(Craftie._G.Path .. "images/FrameDividerMiddVert.png", "REPEAT")
  DividerFrame.Top = parentFrame:CreateTexture(nil, "ARTWORK")
  DividerFrame.Top:SetSize(12, 16)
  DividerFrame.Top:SetPoint("TOPLEFT", x+16, y+16)
  DividerFrame.Top:SetTexture(Craftie._G.Path .. "images/FrameDividerEndVert.png")
  DividerFrame.Bot = parentFrame:CreateTexture(nil, "ARTWORK")
  DividerFrame.Bot:SetSize(12, 16)
  DividerFrame.Bot:SetPoint("TOPLEFT", x+16, -h-15)
  DividerFrame.Bot:SetTexture(Craftie._G.Path .. "images/FrameDividerEndVert.png")
  DividerFrame.Bot:SetTexCoord(1, 0, 1, 1, 0, 0, 0, 1)
  DividerFrame.Bot:SetRotation(-math.pi)
end

function Craftie.ScrollBarBack(parentFrame)
  local ScrollBar={}
  ScrollBar.Midd = parentFrame:CreateTexture(nil, "BORDER")
  ScrollBar.Midd:SetSize(28, parentFrame:GetHeight())
  ScrollBar.Midd:SetPoint("TOPLEFT", parentFrame:GetWidth()-25, 0)
  ScrollBar.Midd:SetVertTile(true)
  ScrollBar.Midd:SetTexture(Craftie._G.Path .. "Images/FrameScrollBarEnd.png", "REPEAT")
  ScrollBar.Top = parentFrame:CreateTexture(nil, "BORDER")
  ScrollBar.Top:SetSize(28, 130)
  ScrollBar.Top:SetPoint("TOPLEFT", parentFrame:GetWidth()-25, 0)
  ScrollBar.Top:SetTexture(Craftie._G.Path .. "Images/FrameScrollBarEnd.png")
  ScrollBar.Bot = parentFrame:CreateTexture(nil, "BORDER")
  ScrollBar.Bot:SetSize(28, 130)
  ScrollBar.Bot:SetPoint("TOPLEFT", parentFrame:GetWidth()-25, -parentFrame:GetHeight()+128)
  ScrollBar.Bot:SetTexture(Craftie._G.Path .. "Images/FrameScrollBarEnd.png")
  ScrollBar.Bot:SetTexCoord(1, 0, 1, 1, 0, 0, 0, 1)
  ScrollBar.Bot:SetRotation(-math.pi)
end
