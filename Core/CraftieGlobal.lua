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
  Author   = "Porthias",
  Width  = 820,
  Height = 460,
  Prefix   = "CRAHH",
  Suffix   = "TBC Anniversary", --default
  Update   = 20260608,
}

Craftie._G.Version = C_AddOns.GetAddOnMetadata("Craftie", "version")

Craftie.Game={}
Craftie.Game.Version = tonumber(string.sub(__Gversion, 1, 1))
if (Craftie.Game.Version == 1) then
  Craftie._G.Suffix = "Classic"
end

Craftie._G.Font={}
Craftie._G.Font.Style= "Interface/Addons/Craftie/Fonts/FRIZQT__.ttf"
Craftie._G.Font.Size = 11
Craftie._G.Font.Color = "|cffF58E27"

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
    edgeSize= 12,
    insets  = {left=2, right=2, top=2, bottom=2},
  },
  Button = {
    bgFile  = "Interface/Buttons/GoldGradiant",
    edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
    edgeSize= 10,
    insets  = {left=2, right=2, top=2, bottom=2},
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
Craftie.MAX_PLAYERS = 100 --per profession (be careful increasing this!)

Craftie.Profession.Query = Craftie.Profession.Alchemy --default

Craftie.Placeholder_Players = "Search Crafters..."
Craftie.Placeholder_Recipes = "Search Recipes..."
Craftie.Selected_Players = 1
Craftie.Selected_Recipes = 1
Craftie.Selected_ViewAll = "View All Recipes" --default
Craftie.Preload = "|cFF27CCF5Loading Data...|r"
Craftie.Page = "Alchemy" --default

-- Global Frames
Craftie.Frame={}

function Craftie.TabSelect(tab, sound)
  for i=1, #Craftie.Professions do
    Craftie.Frame.TabSide[i].Glow:Hide()
    Craftie.Frame.TabSide[i].Shadow:Show()
  end
  Craftie.Frame.TabSide[tab].Glow:Show()
  Craftie.Frame.TabSide[tab].Shadow:Hide()
  if (sound) then
    PlaySound(SOUNDKIT.IG_SPELLBOOK_OPEN)
  end
end

function Craftie.ClearFocusAll()
  Craftie.Frame.Search.Recipes.Text:ClearFocus()
  if (Craftie.Frame.Search.Recipes.Text:GetText() == "") then
    Craftie.Frame.Search.Recipes.Text:SetText(Craftie.Placeholder_Recipes)
    Craftie.Frame.Search.Recipes.Text:SetFontObject(GameFontDisable)
  end
  Craftie.Frame.SearchPlayerText:ClearFocus()
  if (Craftie.Frame.SearchPlayerText:GetText() == "") then
    Craftie.Frame.SearchPlayerText:SetText(Craftie.Placeholder_Players)
    Craftie.Frame.SearchPlayerText:SetFontObject(GameFontDisable)
  end
  PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
end

function SetItemTooltip(frame, itemID, enchant)
  --GameTooltip:SetOwner(frame, "ANCHOR_CURSOR")
  GameTooltip:SetOwner(frame, "ANCHOR_CURSOR_RIGHT")
  if (enchant) then
    GameTooltip:SetHyperlink("enchant:" .. itemID .. ":0:0:0:0:0:0:0")
  else
    GameTooltip:SetHyperlink("item:" .. itemID .. ":0:0:0:0:0:0:0")
  end
  --GameTooltip:AddLine("|nCraftie")
  GameTooltip:Show()
end

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
Craftie.Seed = "Portheus,3,3,131,11111111111111111111111111111111110111111111010010001110111011111100010010101010010110110011001000000111010100010010110101010111111111010001001010101010110111110110101001011101001010101010101010010100101001001111001110010100100100101010100100001000100100011100001001010101000101101010010010010101010111011101010101010101010111111111010001001010101010110111110110101001011111101001011111011101111011011011111111101100101111100101001001111111111111101111111110101111111111111111111111110"
--Craftie.Seed = "Portheus,3,3,375,111111111111111111011111111111111101111111111111111111111111111110001111111111111111111110111111111111111111111101111111111111011111111101101110111111111111111111101111111011111111111111111111110111111111011111111111111111111111111111111111111111111111111111111110111111111111111111111110111111111111111111111111111111111111111111111111111111111111111111111101100011111111111111111111111111111111111111111111111111111111"

Craftie.Get = {}
Craftie.Notified = 0
function Craftie.ParsePacket(netpacket)
  Craftie.Get = {} -- clear everytime
  local stable_version = true --determine large version chunks or stability?!?
  if (string.sub(netpacket, 1, 1) == "!") then
    local packet = Craftie.Split(netpacket, ",")

    Craftie.Get.Prefix  = packet[1]
    Craftie.Get.Version = tonumber(packet[2])

    if (Craftie.Get.Version > tonumber(Craftie._G.Version)) then
      if (Craftie.Notified ~= 1) then --dont spam the requester
        Craftie.Notification("|cFFFF0000ERROR:|r You have an outdated version [" .. Craftie._G.Version .. "] of [" .. Craftie.Get.Version .. "]")
      end
      stable_version = false
      Craftie.Notified = 1
    end
    if (Craftie.Get.Version < tonumber(Craftie._G.Version)) then
      if (Craftie.Get.Version < tonumber(Craftie._G.Version) - 0.01) then --version is drastically outdated by 2 minor versions, do not pull data
        Craftie.Notification("|cFFFF0000ERROR:|r Crafter has an outdated version [" .. Craftie.Get.Version .. "] of [" .. Craftie._G.Version .. "]")
        stable_version = false
      else
        Craftie.Notification("|cFFFFC300WARNING:|r Crafter has an outdated version [" .. Craftie.Get.Version .. "] of [" .. Craftie._G.Version .. "]")
        stable_version = true
      end
    end

    if (stable_version) then
      Craftie.Notification("|CFFD177F7Parsing Packet: |r" .. netpacket, true)

      --get crafters data
      if (Craftie.Get.Prefix == Craftie.Packet.Prefix.Data) then
        Craftie.Get.CrafterN = packet[3]
        Craftie.Get.CrafterC = Craftie.Class[tonumber(packet[4])][1]
        Craftie.Get.ProfNum  = Craftie.Professions[tonumber(packet[5])][1]
        Craftie.Get.ProfLevel= packet[6]
        Craftie.Get.ProfData = Craftie.BitCompression(packet[7], true)
        --Craftie.Notification("Prof Name: " .. Craftie.Get.ProfNum, true)
        --Craftie.Notification("Crafter Name: " .. Craftie.Get.CrafterN, true)
        --Craftie.Notification("Crafter Class: " .. Craftie.Get.CrafterC, true)
        --Craftie.Notification("Prof Level: " .. Craftie.Get.ProfLevel, true)
        Craftie.Notification("Prof Data: " .. Craftie.Get.ProfData, true)

        --DEBUG
        local hperc = (#netpacket / #Craftie.Get.ProfData)*100
        local lperc = hperc -100

        --this is ONLY local seed data testing
        local seed = Craftie.Split(Craftie.Seed, ",")
        --Craftie.Notification("|nSeed Data: " .. seed[4], true)
        if (seed[5] == Craftie.Get.ProfData) then
          Craftie.Notification("|cFF00E033SUCCESS:|r Match!", true)
        else
          Craftie.Notification("|cFFFF0000ERROR:|r Mismatch!", true)
        end

        Craftie.Notification("[" .. #netpacket .. " / " .. #Craftie.Get.ProfData .. "][" .. math.floor(lperc) .. "%]", true)
      end

      --get ping request
      if (Craftie.Get.Prefix == Craftie.Packet.Prefix.Ping) then
        --ping request, send book data, send built data from saved DB first?
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
              Craftie.Frame.TabBar:SetPoint("TOPLEFT", -42*self.frame, -60)
            end
            if (Craftie.TabBarHide == 1) then
              Craftie.Frame.TabBar:SetPoint("TOPLEFT", -42*Craftie.Animation, -60)
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
  Craftie.Frame.Craft:Show()
  Craftie.ClearFocusAll()
  Craftie.TimerAnim(Craftie.Frame.Craft, 0.65) --animate the craft icon

  for i=1, Craftie.MAX_REAGENTS do
    reagent[i] = 0
    Craftie.Frame.Reagent.Main[i]:Hide()
    Craftie.Frame.Reagent.Back[i]:Show() --selection was laready made, draw backgrounds
    if (not Craftie.IsEmpty(item[5][i])) then
      local r = 0
      local inv_count= C_Item.GetItemCount(item[5][i][1])
      local inv_req = item[5][i][2]

      --reset
      Craftie.Frame.Reagent.Text[i]:SetTextColor(1, 1, 1, 0.8)
      Craftie.Frame.Reagent.Icon[i]:SetAlpha(0.6)
      Craftie.Frame.Reagent.Main[i]:SetBackdropBorderColor(1, 1, 1, 0)
      --Craftie.Frame.Reagent.QuanI[i]:SetTextColor(1, 1, 1, 0.7)
      --Craftie.Frame.Reagent.QuanR[i]:SetTextColor(1, 1, 1, 0.7)
      Craftie.Frame.Reagent.IconGlow[i]:Hide()

      r = Craftie.GetKeyFromValue(Craftie.Reagent, item[5][i][1], 1)
      --C_Timer.After(0.12, function()
      local name, link, quality, level, minlevel, type, subtype = GetItemInfo(item[5][i][1])
      local loadcache = 0
      if (Craftie.Reagent[r][2] == Craftie.Preload) then --pull from tooltip for missing reagents
        if (name ~= nil) then --prevent LUA errors on odd reagents that have never been viewed/precached to the client
          Craftie.Reagent[r][2] = name
        end
        loadcache = 1
      end
      Craftie.Frame.Reagent.Text[i]:SetText(Craftie.Reagent[r][2])
      Craftie.Frame.Reagent.Data[i]:SetText(Craftie.Reagent[r][1])
      Craftie.Frame.Reagent.QuanI[i]:SetText(inv_count)
      Craftie.Frame.Reagent.QuanR[i]:SetText(inv_req)
      Craftie.Frame.Reagent.Icon[i]:SetTexture(C_Item.GetItemIconByID(Craftie.Reagent[r][1]))
      Craftie.Frame.Reagent.Main[i]:Show()
      --end)
      if (loadcache == 1) then
        loadcache = 0
        C_Timer.After(0.6, function()
          Craftie.Frame.Reagent.Text[i]:SetText(Craftie.Reagent[r][2])
          Craftie.Notification("[" .. item[2] .. "] reloading from tooltip data", true)
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
  --local get_tooltip = C_Item.GetItemByID(item[4])

  if (item_detail == "") then --blank or possibly enchant
    local name, subtext, icon, castTime, minRange, maxRange, spellID, originalIcon = GetSpellInfo(item[1])
    --print("spell? " .. name .. " | " .. icon)
    Craftie.Frame.Craft.ID:SetText(item[1])
    Craftie.Frame.Craft.Icon:SetTexture(icon)
    is_enchant = true
  else
    Craftie.Frame.Craft.Icon:SetTexture(C_Item.GetItemIconByID(item_detail))
  end

  C_Timer.After(0.12, function() --give it time to register
    Craftie.Frame.Craft.Text:SetTextColor(1, 1, 1, 1)
    if (is_enchant) then
      Craftie.Frame.Craft.HLink:SetText("ENCHANT DATA TEXT HERE")
      --print(is_enchant)
      Craftie.Frame.Craft.HLink:SetScript("OnEnter", function(self)
        SetItemTooltip(Craftie.Frame.Craft.HLink, Craftie.Frame.Craft.ID:GetText(), true)
      end)
    else
      local name, link, quality, level, minlevel, type, subtype = GetItemInfo(item_detail)
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
    Craftie.Frame.Craft.Skill:SetText(Craftie.Frame.Title.Prof:GetText() .. " (" .. SkillLevel .. ")")
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

Craftie.Frame.Scroll={}
Craftie.Frame.ScrollPlayersListItem={}
function Craftie.SelectScrollItem(scrollFrame)
  if (scrollFrame == "Players") then
    for i=1, Craftie.MAX_PLAYERS do
      Craftie.Frame.ScrollPlayersListItem[i]:SetBackdropColor(1, 1, 1, 0)
      Craftie.Frame.ScrollPlayersListItem[Craftie.Selected_Players]:SetBackdropColor(0.6, 0.7, 1, 0.5)
      Craftie.Frame.ScrollPlayersListText[i]:SetTextColor(1, 1, 1, 0.8)
      Craftie.Frame.ScrollPlayersListText[Craftie.Selected_Players]:SetTextColor(1, 1, 0.8, 1)
      if (i % 2 == 0) then
        Craftie.Frame.ScrollPlayersListItem[i]:SetBackdropColor(0.8, 0.9, 1, 0.1)
      end
    end
  end
  if (scrollFrame == "Recipes") then
    for i=1, Craftie.MAX_RECIPES do
      Craftie.Frame.ScrollRecipesList.Item[i]:SetBackdropColor(1, 1, 1, 0)
      Craftie.Frame.ScrollRecipesList.Item[Craftie.Selected_Recipes]:SetBackdropColor(0.6, 0.7, 1, 0.5)
      Craftie.Frame.ScrollRecipesList.Text[i]:SetTextColor(1, 1, 1, 0.8)
      Craftie.Frame.ScrollRecipesList.Text[Craftie.Selected_Recipes]:SetTextColor(1, 1, 0.8, 1)
      if (i % 2 == 0) then
        Craftie.Frame.ScrollRecipesList.Item[i]:SetBackdropColor(0.8, 0.9, 1, 0.1)
      end
    end
  end
end


function Craftie.SelectCrafter(index, name)
  if (index == 1) then
    --clear player selection?
  else
    if (not Craftie.IsEmpty(name)) then
      print(name)
      Craftie.Selected_Players = index
      Craftie.SelectScrollItem("Players")
    end
  end
end

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

function Craftie.AlphaSortProfessionLib()
  --very important so the order is always sorted
  for k,v in pairs(Craftie.Professions) do
    --print(v[1])
    Craftie.SortTableByString(Craftie.Profession[v[1]])
  end
end

Craftie.ProfileBuilt = {} --need to reset when learning a new recipe
function Craftie.BuildProfProfile(profName)
  local profArray = Craftie.Profession[profName]
  local profData={}
  local profString = ""

  for k,v in pairs(Craftie.Professions) do --I only care about the prio list
    if (v[1] == profName) then

      if (Craftie.ProfileBuilt[profName] ~= 1) then
        C_Timer.After(0.3, function()
          --print(profName)
          for k,v in pairs(profArray) do
            profData[v[2]] = 0
            --Craftie.Notification(v[2], true)
            --print(v[2])
          end

          local numRecipes = GetNumTradeSkills()
          for i = 1, numRecipes do
            local recipeName, recipeType = GetTradeSkillInfo(i)
            if recipeType ~= "header" then
              if (recipeName ~= nil) then
                profData[recipeName] = 1
              end
            end
          end

          --alpha sort order
          local tkeys = {}
          for k in pairs(profData) do
            table.insert(tkeys, k)
          end
          table.sort(tkeys)
          for _, k in ipairs(tkeys) do
            --profString = profString .. k .. ", " .. profData[k] .. ", "
            profString = profString .. profData[k]
          end
          Craftie.Notification(profString, true)
        end)
      end
      Craftie.ProfileBuilt[profName] = 1 --we already pulled data, reset on learning new recipe
    end
  end
end


function Craftie.OpenProfessionList(profArray, search) --need to add player
  local total_recipes = #profArray
  --local total_search = 0
  local results = "|cfffffb63Recipe(s)"
  Craftie.Frame.ScrollRecipes.Results:SetText("")
  Craftie.Frame.ScrollRecipes.Empty:SetText("")
  --Craftie.Frame.ScrollRecipesList:SetBackdropColor(0.1, 0.6, 1, 0) --slight blue  
  if (search:len() >= 3) then
    local matches = Craftie.SortTableByMatch(profArray, search)
    if (matches >= 1) then
      total_recipes = matches
    else
      matches = 0
      total_recipes = 0
      Craftie.Frame.ScrollRecipes.Empty:SetText('No Recipes|n"' .. search .. '"')
    end
    Craftie.Frame.ScrollRecipes.Results:SetText(matches .. " " .. results)
  else
    Craftie.SortTableByString(profArray) --just go back to a alpha sort
    Craftie.Frame.ScrollRecipes.Results:SetText(total_recipes .. " " .. results)
  end

  for i=1, Craftie.MAX_RECIPES do
    Craftie.Frame.ScrollRecipesList.Item[i]:Hide()
  end

  for i=1, total_recipes do
    Craftie.Frame.ScrollRecipesList.Text[i]:SetText(profArray[i][2])
    Craftie.Frame.ScrollRecipesList.Item[i]:SetScript("OnClick", function()
      Craftie.ItemDetails(profArray[i])

      --print(profArray[i][2])
      Craftie.Selected_Recipes = i
      Craftie.SelectScrollItem("Recipes")
      --example
      --Craftie.SendPacket(Craftie.Packet.Prefix.Data, Craftie.Seed, "WHISPER", "Addondev")
    end)
    Craftie.Frame.ScrollRecipesList.Item[i]:Show()
  end
  Craftie.Profession.Query = profArray

  local prof_list = Craftie.GetKeyFromValue(Craftie.Professions, Craftie.Page, 1)
  local prof_color = Craftie.Split(Craftie.Professions[prof_list][3], ",")
  --Craftie.Frame.ScrollRecipesList:SetBackdropColor(prof_color[1], prof_color[2], prof_color[3], 0.14)
  Craftie.Frame.Title.Prof:SetTextColor(prof_color[1], prof_color[2], prof_color[3], 1)
  --Craftie.Frame.Icon:SetTexture(Craftie._G.Path .. "images/icon_default.tga")
  Craftie.Frame.Icon:SetTexture("Interface/ICONS/" .. Craftie.Professions[prof_list][2])
end

--[==[
function Craftie.BuildProfProfile()
  --local numRecipes = GetNumTradeSkills()
  local profCount = 0
  if (Craftie.ProfileBuilt == 0) then
    for k,v in pairs(Craftie.Professions) do
      --print(v[1])
      for i = 1, GetNumSkillLines() do
        local profName, isHeader, isExp, profLevel = GetSkillLineInfo(i)
        if (not isHeader) then
          if (v[1] == profName) then
            profCount = profCount+2
            print(profName .. " | " .. profLevel)
            print(profCount)
            C_Timer.After(profCount, function()
              print(profName .. " do something")

              CastSpellByName(profName)
              local numRecipes = GetNumTradeSkills()
              for recipe = 1, numRecipes do
                local recipeName, recipeType = GetTradeSkillInfo(recipe)
                if recipeType ~= "header" then
                  print(recipe, recipeName)
                end
              end
              C_Timer.After(1, function()
                print("close " .. profName)
                CloseTradeSkill()
              end)

            end)
          --print("Match: " .. profName .. " | " .. profLevel)
          end
        end
      end
    end
    Craftie.ProfileBuilt = 1
  end
end
]==]--

Craftie.WindowOpen = 0
function Craftie.OpenCraftie()
  --PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
  if (Craftie.WindowOpen == 0) then
    Craftie.Frame:Show()
    Craftie.WindowOpen = 1
    --Craftie.BuildProfProfile()
  else
    Craftie.Frame:Hide()
    Craftie.WindowOpen = 0
  end
end

SLASH_Craftie1 = "/" .. Craftie._G.Prefix
function SlashCmdList.Craftie(cmd)
  if ((cmd == nil) or (cmd == "")) then

    --print(Craftie._G.Font.Color .. Craftie._G.Prefix .. "|r v" .. Craftie._G.Version)
    Craftie.OpenCraftie()
    --Craftie.Notification
		--for int,list in pairs(Craftie._L.COMMANDS) do
			--print("|cffffff00".. list[1] .. "|r : " .. list[2] .. "|n")
		--end
	end
	local _, _, cmd, args = string.find(cmd, "%s?(%w+)%s?(.*)")
	--if (cmd == Craftie._L.COMMANDS[1][1]) then
	  --Craftie.FrameOptions:Show()
  --end
  if (cmd == "show") then
    Craftie.OpenCraftie()
  end

  for k,v in pairs(Craftie.Professions) do
    local profcmd = "p" .. k
    if (cmd == profcmd) then
      Craftie.Notification("View ALL recipes [" .. Craftie.Professions[k][1] .. "]", true) --Craftie.Profession[Craftie.Professions[k][1]])
      Craftie.OpenProfessionList(Craftie.Profession[Craftie.Professions[k][1]], "")
    end
  end
end

--caching tooltip data. preload unknown data
Craftie.Reagent = {}
function Craftie.BuildReagentGaps()
  for i=1, 55000 do
    table.insert(Craftie.Reagent, {i, Craftie.Preload})
  end
  for k,v in pairs(Craftie.Reagents) do
    Craftie.Reagent[v[1]] = {v[1], v[2]}
  end
end

function Craftie.SaveMapButtonPos()
	--Craftie.UpdateMapButton()
  local point, relativeTo, relativePoint, xOfs, yOfs = Craftie.Frame.Button.Minimap:GetPoint()
	CraftieDB[Craftie.player.realm][Craftie.player.faction][Craftie.player.name]["CONFIG"]["POS_MINIMAP"] = math.ceil(xOfs) .. "," .. math.ceil(yOfs)
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
  ScrollBar.Midd = parentFrame:CreateTexture(nil, "BACKGROUND")
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
