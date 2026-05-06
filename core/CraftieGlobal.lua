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
  author   = "Porthias",
  CMD      = "/craftie",
  Width  = 820,
  Height = 460,
  font     = "Interface/Addons/Craftie/fonts/FRIZQT__.TTF",
  fontSize = 11,
  dir      = "Interface/Addons/Craftie/",
  prefix   = "CRAHH",
  suffix   = "TBC Anniversary",
  color    = "|cffF58E27",
  date     = date("%Y%m%d"),
  update   = 20260608,
}
Craftie._G.title = Craftie._G.color .. Craftie._G.prefix .. "|r"

--Craftie._G.version = C_AddOns.GetAddOnMetadata(Craftie._G.prefix, "version")
Craftie._G.version = C_AddOns.GetAddOnMetadata("Craftie", "version")

Craftie.Game={}
Craftie.Game.version = tonumber(string.sub(__Gversion, 1, 1))
if (Craftie.Game.version == 1) then
  Craftie._G.suffix = "Classic"
end

Craftie.Stamp = Craftie._G.color .. Craftie._G.prefix .. "|r v" .. Craftie._G.version

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
    print(Craftie._G.title .. " DEBUG: " .. msg)
  end
  if (not debug) then
    print(Craftie._G.title .. " " .. msg)
  end
end

Craftie.MAX_REAGENTS = 6
Craftie.MAX_RECIPES = 600
Craftie.MAX_PLAYERS = 100 --per profession (be careful increasing this!)

Craftie.Professions = {
  {"Alchemy",        "Trade_Alchemy",        "0.72, 0.80, 0.19", {"Elixir Master", "Potion Master", "Transmute Master"}},
  {"Blacksmithing",  "Trade_BlackSmithing",  "0.60, 0.54, 0.48", {"Armorsmith", "Weaponsmith", "Swordsmith", "Hammersmith", "Axesmith"}},
  {"Cooking",        "INV_Misc_Food_15",     "0.88, 0.44, 0.13"},
  {"Enchanting",     "Trade_Engraving",      "0.73, 0.33, 0.83"},
  {"Engineering",    "Trade_Engineering",    "0.91, 0.75, 0.25", {"Gnomish", "Goblin"}},
  {"Leatherworking", "Trade_LeatherWorking", "0.76, 0.63, 0.42", {"Dragonscale", "Elemental", "Tribal"}},
  {"Tailoring",      "Trade_Tailoring",      "0.91, 0.69, 0.88", {"Mooncloth", "Shadoweave", "Spellfire"}},
  {"Jewelcrafting",  "INV_Misc_Gem_02",      "1.00, 0.25, 0.25"},
}

Craftie.Profession.Query = Craftie.Profession.Alchemy --default

Craftie.Placeholder_Players = "Search Crafters..."
Craftie.Placeholder_Recipes = "Search Recipes..."
Craftie.Selected_Players = 1
Craftie.Selected_Recipes = 1
Craftie.Selected_ViewAll = "View All Recipes" --default
Craftie.Preload = "Loading Data..."

-- Global Frames
Craftie.Frame={}

--Craftie.Frame.Parent={}
--Craftie.Frame.Parent.Scroll={}
--[==[
Craftie.Frame = {}
Craftie.Frame.Parent={}
Craftie.Frame.Parent.Scroll={}
Craftie.Frame.Parent.Scroll.Players={}

Craftie.Frame.Scroll = {}

Craftie.Frame.Scroll.Recipes = {}
Craftie.Frame.Scroll.Recipes.List = {}
Craftie.Frame.Scroll.Recipes.List.Item = {}
Craftie.Frame.Scroll.Recipes.List.Text={}
Craftie.Frame.Scroll.Recipes.Results={}

Craftie.Frame.Search = {}

Craftie.Frame.Parent.Craft= {}
]==]--

Craftie.TabSide={}
Craftie.TabSide.Frame={}

function Craftie.TabSelect(tab, sound)
  for i=1, #Craftie.Professions do
    Craftie.TabSide.Frame[i].BorderSelect:Hide()
    Craftie.TabSide.Frame[i].Glow:Hide()
    Craftie.TabSide.Frame[i].Shadow:Show()
  end
  Craftie.TabSide.Frame[tab].BorderSelect:Show()
  Craftie.TabSide.Frame[tab].Glow:Show()
  Craftie.TabSide.Frame[tab].Shadow:Hide()
  if (sound) then
    PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
  end
end

function Craftie.ClearFocusAll()
  Craftie.Frame.Search.Recipes.Text:ClearFocus()
  if (Craftie.Frame.Search.Recipes.Text:GetText() == "") then
    Craftie.Frame.Search.Recipes.Text:SetText(Craftie.Placeholder_Recipes)
    Craftie.Frame.Search.Recipes.Text:SetFontObject(GameFontDisable)
  end
  Craftie.Frame.Search.Player.Text:ClearFocus()
  if (Craftie.Frame.Search.Player.Text:GetText() == "") then
    Craftie.Frame.Search.Player.Text:SetText(Craftie.Placeholder_Players)
    Craftie.Frame.Search.Player.Text:SetFontObject(GameFontDisable)
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

function Craftie.GetProfessionsPlayer()
	local pass = false
	local skills = {}
	local skillnum = 0
	local header1 = string.lower( TRADE_SKILLS )
	local header2 = string.lower( SECONDARY_SKILLS )
	for k = 1, GetNumSkillLines( ) do
		local name, header = GetSkillLineInfo( k )
		if header ~= nil then
			name = string.lower( name )
			if string.match( header1, name ) or string.match( header2, name ) then
				pass = true
				if string.match( header2, name ) and skillnum < 2 then
					skillnum = 2
				end
			else
				pass = false
			end
		else
			if (pass) then
				skillnum = skillnum + 1
				skills[skillnum] = k
			end
		end
	end
	return skills[1], skills[2], skills[3], skills[4], skills[5]
end

function Craftie.SendPacket(prefix, data, channel, target)
  --if (channel == "GUILD") then
    --if (not IsInGuild()) then return end
  --end
  local repack = prefix .. "," .. Craftie._G.version .. "," .. data
  local packet = Craftie.Split(data, ",")
  if (prefix == Craftie.Packet.Prefix.Data) then
    -- code | sender | profNum | profLevel | profData
    repack = prefix .. "," .. Craftie._G.version .. "," .. packet[1] .. "," .. packet[2] .. "," .. packet[3] .. "," .. Craftie.BitCompression(packet[4], false)
  end

  C_ChatInfo.RegisterAddonMessagePrefix(Craftie._G.prefix)
  if (channel == "WHISPER") then
    --C_ChatInfo.SendAddonMessage(Craftie._G.prefix, compressPacket, channel, target)
    --C_ChatInfo.RegisterAddonMessagePrefix(Craftie._G.prefix)
  	C_ChatInfo.SendAddonMessage(Craftie._G.prefix, repack, channel, target)
    --Craftie.Notification("Send Whisper " .. target, true)
  else
    C_ChatInfo.SendAddonMessage(Craftie._G.prefix, repack, channel)
    --Craftie.Notification("Send " .. channel, true)
  end

  --local hperc = (#repack / #data)*100
  --local lperc = hperc -100

  --Craftie.Notification("Sending Packet: " .. repack .. " [" .. #repack .. " / " .. #data .. "][" .. math.ceil(lperc) .. "%]", true)
  Craftie.Notification("Sending Packet: " .. repack .. " [" .. #repack .. "]", true)
end

--Seed examples
--sendpacket examples
--Craftie.Seed = "Portheus,1,32,10001010010000010101000101110101100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
--Craftie.Seed = "Portheus,1,62,100000000000010000000000000000111100000000000000000001000000000000000000010101010101101110111111111100000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000100000000000000000011000000000000000000000000000000000000000000000010000000000011100000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000010111111111111010111111111110000000"
Craftie.Seed = "Portheus,3,131,11111111111111111111111111111111110111111111010010001110111011111100010010101010010110110011001000000111010100010010110101010111111111010001001010101010110111110110101001011101001010101010101010010100101001001111001110010100100100101010100100001000100100011100001001010101000101101010010010010101010111011101010101010101010111111111010001001010101010110111110110101001011111101001011111011101111011011011111111101100101111100101001001111111111111101111111110101111111111111111111111110"
--Craftie.Seed = "Portheus,3,375,111111111111111111011111111111111101111111111111111111111111111110001111111111111111111110111111111111111111111101111111111111011111111101101110111111111111111111101111111011111111111111111111110111111111011111111111111111111111111111111111111111111111111111111110111111111111111111111110111111111111111111111111111111111111111111111111111111111111111111111101100011111111111111111111111111111111111111111111111111111111"

Craftie.Get = {}
Craftie.Notified = 0
function Craftie.ParsePacket(netpacket)
  Craftie.Get = {} -- clear everytime
  local stable_version = true --determine large version chunks or stability?!?
  if (string.sub(netpacket, 1, 1) == "!") then
    local packet = Craftie.Split(netpacket, ",")
    --Craftie.Notification("Parsing Packet: " .. netpacket, true)

    Craftie.Get.Prefix  = packet[1]
    Craftie.Get.Version = tonumber(packet[2])

    if (Craftie.Get.Version > tonumber(Craftie._G.version)) then
      if (Craftie.Notified ~= 1) then --dont spam the requester
        Craftie.Notification("|cFFFF0000ERROR:|r You have an outdated version [" .. Craftie._G.version .. "] of [" .. Craftie.Get.Version .. "]")
      end
      stable_version = false
      Craftie.Notified = 1
    end
    if (Craftie.Get.Version < tonumber(Craftie._G.version)) then
      if (Craftie.Get.Version < tonumber(Craftie._G.version) - 0.01) then --version is drastically outdated by 2 minor versions, do not pull data
        Craftie.Notification("|cFFFF0000ERROR:|r Crafter has an outdated version [" .. Craftie.Get.Version .. "] of [" .. Craftie._G.version .. "]")
        stable_version = false
      else
        Craftie.Notification("|cFFFFC300WARNING:|r Crafter has an outdated version [" .. Craftie.Get.Version .. "] of [" .. Craftie._G.version .. "]")
        stable_version = true
      end
    end

    if (stable_version) then
      Craftie.Notification("Parsing Packet: " .. netpacket, true)

      --get crafters book
      if (Craftie.Get.Prefix == Craftie.Packet.Prefix.Data) then
        Craftie.Get.Crafter = packet[3]
        Craftie.Get.ProfNum  = tonumber(packet[4])
        Craftie.Get.ProfLevel= packet[5]
        Craftie.Get.ProfData = Craftie.BitCompression(packet[6], true)
        Craftie.Notification("Prof Name: " .. Craftie.Professions[Craftie.Get.ProfNum][1], true)
        Craftie.Notification("Prof Crafter: " .. Craftie.Get.Crafter, true)
        Craftie.Notification("Prof Level: " .. Craftie.Get.ProfLevel, true)
        Craftie.Notification("Prof Data: " .. Craftie.Get.ProfData, true)

        --DEBUG
        local hperc = (#netpacket / #Craftie.Get.ProfData)*100
        local lperc = hperc -100

        --this is ONLY local seed data testing
        local seed = Craftie.Split(Craftie.Seed, ",")
        --Craftie.Notification("|nSeed Data: " .. seed[4], true)
        if (seed[4] == Craftie.Get.ProfData) then
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

function Craftie.ItemDetails(item)
  local reagent = {}
  Craftie.Frame.Craft:Show()
  Craftie.ClearFocusAll()

  for i=1, Craftie.MAX_REAGENTS do
    reagent[i] = 0
     Craftie.Frame.Reagent.Main[i]:Hide()
    if (not Craftie.IsEmpty(item[5][i])) then
      local r = 0
      local inv_count= C_Item.GetItemCount(item[5][i][1])
      local inv_req = item[5][i][2]

      --reset
      Craftie.Frame.Reagent.Text[i]:SetTextColor(1, 1, 1, 0.8)
      Craftie.Frame.Reagent.Icon[i]:SetAlpha(0.5)
      Craftie.Frame.Reagent.Main[i]:SetBackdropBorderColor(1, 1, 1, 0.6)

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
      end
      --print("craftie count " .. Craftie.Reagent[r][2] .. ": " .. item[5][i][2] .. " | " .. inv_count)
    end
  end

--[==[
  GameTooltip:HookScript("OnEnter", function(self)
    for i=1, self:NumLines() do
      print(_G["GameTooltipTextLeft"..i]:GetText())
    end
  end)
]==]--

--ChatFrame_OnHyperlinkShow(chatFrame, link, text, button)

  Craftie.Frame.Craft.ID:SetText(item[4])
  Craftie.Frame.Craft.Text:SetText(item[2])

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

    local prof_list = Craftie.GetKeyFromValue(Craftie.Professions, Craftie.Frame.Title.Prof:GetText(), 1)
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


function Craftie.ClearSelectedItem(scrollFrame)
  if (scrollFrame == "Players") then
    for i=1, Craftie.MAX_PLAYERS do
      Craftie.Frame.Scroll.Players.List.Item[i]:SetBackdropColor(1, 1, 1, 0)
      Craftie.Frame.Scroll.Players.List.Item[Craftie.Selected_Players]:SetBackdropColor(0.6, 0.7, 1, 0.5)
      Craftie.Frame.Scroll.Players.List.Text[Craftie.Selected_Players]:SetTextColor(1, 1, 0.8, 1)
      Craftie.Frame.Scroll.Players.List.Text[i]:SetTextColor(1, 1, 1, 0.8)
      if (i % 2 == 0) then
        Craftie.Frame.Scroll.Players.List.Item[i]:SetBackdropColor(0.8, 0.9, 1, 0.1)
      end
    end
  end
  if (scrollFrame == "Recipes") then
    for i=1, Craftie.MAX_RECIPES do
      Craftie.Frame.Scroll.Recipes.List.Item[i]:SetBackdropColor(1, 1, 1, 0)
      Craftie.Frame.Scroll.Recipes.List.Item[Craftie.Selected_Recipes]:SetBackdropColor(0.6, 0.7, 1, 0.5)
      Craftie.Frame.Scroll.Recipes.List.Text[Craftie.Selected_Recipes]:SetTextColor(1, 1, 0.8, 1)
      Craftie.Frame.Scroll.Recipes.List.Text[i]:SetTextColor(1, 1, 1, 0.8)
      if (i % 2 == 0) then
        Craftie.Frame.Scroll.Recipes.List.Item[i]:SetBackdropColor(0.8, 0.9, 1, 0.1)
      end
    end
  end
end

function Craftie.OpenProfessionList(prof, search) --need to add player
  --print("prof count " .. #prof)
  local total_recipes = #prof
  local total_search = 0
  Craftie.Frame.Scroll.Recipes.Results:SetText("")
  Craftie.Frame.Scroll.Recipes.Empty:SetText("")
  --Craftie.Frame.Scroll.Recipes.List:SetBackdropColor(0.1, 0.6, 1, 0) --slight blue  
  if (search:len() >= 3) then
    local matches = Craftie.SortTableByMatch(prof, search)
    if (matches >= 1) then
      total_recipes = matches
    else
      matches = 0
      total_recipes = 0
      Craftie.Frame.Scroll.Recipes.Empty:SetText('No Recipes|n"' .. search .. '"')
    end
    Craftie.Frame.Scroll.Recipes.Results:SetText(matches .. " |cfffffb63Result(s)")
  else
    Craftie.SortTableByString(prof)
    Craftie.Frame.Scroll.Recipes.Results:SetText(total_recipes .. " |cfffffb63Result(s)")
  end
  for i=1, Craftie.MAX_RECIPES do
    Craftie.Frame.Scroll.Recipes.List.Item[i]:Hide()
  end

  for i=1, total_recipes do
    Craftie.Frame.Scroll.Recipes.List.Text[i]:SetText(prof[i][2])
    Craftie.Frame.Scroll.Recipes.List.Item[i]:SetScript("OnClick", function()
      Craftie.ItemDetails(prof[i])

      --print(prof[i][2])
      Craftie.Selected_Recipes = i
      Craftie.ClearSelectedItem("Recipes")
      --example
      Craftie.SendPacket(Craftie.Packet.Prefix.Data, Craftie.Seed, "WHISPER", "Addondev")
    end)
    Craftie.Frame.Scroll.Recipes.List.Item[i]:Show()
  end
  Craftie.Profession.Query = prof

  local prof_list = Craftie.GetKeyFromValue(Craftie.Professions, Craftie.Frame.Title.Prof:GetText(), 1)
  local prof_color = Craftie.Split(Craftie.Professions[prof_list][3], ",")
  Craftie.Frame.Scroll.Recipes.List:SetBackdropColor(prof_color[1], prof_color[2], prof_color[3], 0.14)
  Craftie.Frame.Title.Prof:SetTextColor(prof_color[1], prof_color[2], prof_color[3], 1)
end

function Craftie.ListCrafters() --build or list from prof?

end

function Craftie.SelectCrafter(index, name)
  if (index == 1) then
    --clear player selection?
  else
    if (not Craftie.IsEmpty(name)) then
      print(name)
      Craftie.Selected_Players = index
      Craftie.ClearSelectedItem("Players")
    end
  end
end

SLASH_Craftie1 = Craftie._G.CMD
function SlashCmdList.Craftie(cmd)
  if ((cmd == nil) or (cmd == "")) then

    --print(Craftie._G.color .. Craftie._G.prefix .. "|r v" .. Craftie._G.version)
    Craftie.Frame:Show()
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
    Craftie.Frame:Show()
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
