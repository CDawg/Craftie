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

Craftie.LogKey = 0
Craftie.SortOrder = 0

---@class GetNumSpellTabs
---@class GetSpellBookItemName
---@enum BOOKTYPE_SPELL
---@class GetSpellTabInfo
---@class TradeSkillFrame

---@class Notification
function Craftie:Notification(msg, type)
  local logstring= ""
  local debugLevel = type[1]
  local debugColor = type[2]

  if (Craftie.DEBUGLEVEL > Craftie:KeyCount(Craftie.CHAT)) then
    Craftie.DEBUGLEVEL = Craftie:KeyCount(Craftie.CHAT) --just set to max range
  end
  if (Craftie.DEBUGLEVEL <= 0) then
    Craftie.DEBUGLEVEL = 1 --prevent errors, but always show chat [info]
  end
  if (debugLevel <= Craftie.DEBUGLEVEL) then
    --we dont need to view the type everytime
    if (debugColor == Craftie.CHAT.INFO[2]) then
      print(Craftie._G.Title .. " " .. msg)
    else
      print(Craftie._G.Title .. " " .. debugColor .. " " .. msg)
    end
  end
  --log everything, regardless of debug mode
  if (Craftie.Frame ~= nil) then
    Craftie:Log(debugColor, msg)
  end
end

--Also reenable the scrollbars
---@class CloseAllPlayerMenus
function Craftie:CloseAllPlayerMenus()
  CraftieTooltip:Hide()
  GameTooltip:Hide()
  Craftie.Frame.ScrollPlayersListSubMenu:Hide()

  Craftie.Frame.ScrollPlayersList.Child:SetAlpha(1)
  Craftie.Frame.ScrollPlayersList.Child:EnableMouse(true)
  Craftie.Frame.ScrollPlayersList.Child:EnableMouseWheel(true)
  Craftie.Frame.ScrollPlayersList.Child.ScrollBar:Show()

  Craftie.Frame.ScrollRecipesList.Child:SetAlpha(1)
  Craftie.Frame.ScrollRecipesList.Child:EnableMouse(true)
  Craftie.Frame.ScrollRecipesList.Child:EnableMouseWheel(true)
  Craftie.Frame.ScrollRecipesList.Child.ScrollBar:Show()

  Craftie.Frame.ScrollOrderList.Child:SetAlpha(1)
  Craftie.Frame.ScrollOrderList.Child:EnableMouse(true)
  Craftie.Frame.ScrollOrderList.Child:EnableMouseWheel(true)
  Craftie.Frame.ScrollOrderList.Child.ScrollBar:Show()

  Craftie.EnableScrollFrames = true
end

function Craftie:ClearCraftFrame()
  Craftie.Frame.Item:Hide()
  Craftie.Frame.ItemCountEditBox:SetNumber(1)
  Craftie.Frame.Mastery:SetText("")

  for i=1, Craftie.MAX_REAGENTS do
    Craftie.Frame.Reagent.Main[i]:Hide()
  end
  Craftie.Frame.Item.SourceTitle:Hide()
  Craftie.Frame.Item.SkillText:Hide()
  Craftie.Frame.Item.SkillIcon:Hide()
  Craftie.Frame.Item.SourceText:Hide()

  Craftie.Frame.ItemRequestParent:Hide()

  Craftie:Notification("Craftie:ClearCraftFrame()", Craftie.CHAT.FUNC)
end

function Craftie:CraftRequestFrame(crafter)
  if ((crafter ~= Craftie.Player.Name) or (Craftie.DEBUGLEVEL > 3)) then
    Craftie.Frame.ItemRequestParent:Show()
  end
end

function Craftie:ClearSearchFocus(crafters)
  Craftie.Frame.Search.Recipes.Text:ClearFocus()
  Craftie.Frame.Search.Recipes.Text:SetText(Craftie._L.Placeholder_Recipes)
  Craftie.Frame.Search.Recipes.Text:SetFontObject(GameFontDisable)

  if (crafters) then
    Craftie.Frame.Search.Players.Text:ClearFocus()
    Craftie.Frame.Search.Players.Text:SetText(Craftie._L.Placeholder_Players)
    Craftie.Frame.Search.Players.Text:SetFontObject(GameFontDisable)
  end

  Craftie:Notification("Craftie:ClearSearchFocus()", Craftie.CHAT.FUNC)
end

function Craftie:DisableAllScrollBars()
  C_Timer.After(0.01, function()
  --players
    Craftie.Frame.ScrollPlayersList.Child:SetAlpha(0.4)
    Craftie.Frame.ScrollPlayersList.Child:EnableMouse(false)
    Craftie.Frame.ScrollPlayersList.Child:EnableMouseWheel(false)
    Craftie.Frame.ScrollPlayersList.Child.ScrollBar:Hide()

  --recipes
    Craftie.Frame.ScrollRecipesList.Child:SetAlpha(0.4)
    Craftie.Frame.ScrollRecipesList.Child:EnableMouse(false)
    Craftie.Frame.ScrollRecipesList.Child:EnableMouseWheel(false)
    Craftie.Frame.ScrollRecipesList.Child.ScrollBar:Hide()
  end)

  Craftie.EnableScrollFrames = false
end

--this also goes to the player selected scroll item
function Craftie:GetCrafterIndex(player)
  C_Timer.After(0.2, function() --give the update time to create cached tables
    for i=1, #Craftie.TOTAL_CRAFTERS do
      if (player == Craftie.Frame.ScrollPlayersListName[i]:GetText()) then
        Craftie:SelectCrafter(i, player)
        Craftie:Notification("Craftie:GetCrafterIndex() [" .. i .. "] " .. player, Craftie.CHAT.FUNC)
      end
    end
  end)
end

function Craftie:SelectCrafter(index, name)
  Craftie.Selected_Name = ""
  Craftie.Selected_Player_Index = 1 --always one at first
  Craftie.Selected_Recipe_Index = 1

  if (index == 1) then
    if (Craftie.Frame.Search.Recipes.Text:GetText() ~= Craftie._L.Placeholder_Recipes) then
      Craftie:OpenProfessionList(Craftie.ProfessionDefault, Craftie.Frame.Search.Recipes.Text:GetText(), "") --pull all
    else
      Craftie:OpenProfessionList(Craftie.ProfessionDefault, "", "") --pull all
    end
    Craftie.MenuSelRecipes[2] = nil
    Craftie.Frame.DropdownRecipes.text:SetText(Craftie.MenuSelRecipes[1])
  else
    if (name ~= nil) then
      --print(name)
      Craftie.Selected_Player_Index = index
      Craftie.Selected_Name = name
      Craftie.Frame.DropdownRecipes.text:SetText(name)
      Craftie:Notification("Craftie:SelectCrafter(" .. index .. ", " .. name .. ")", Craftie.CHAT.FUNC)
      if (Craftie.Frame.Search.Recipes.Text:GetText() ~= Craftie._L.Placeholder_Recipes) then
        Craftie:OpenProfessionList(Craftie.Profession[Craftie.Page], Craftie.Frame.Search.Recipes.Text:GetText(), name)
      else
        Craftie:OpenProfessionList(Craftie.Profession[Craftie.Page], "", name)
      end
    end
  end
  Craftie:SelectScrollItem("Players", false) --highlight
  Craftie.Frame.ScrollRecipesList.Child:SetVerticalScroll(1)
  PlaySound(SOUNDKIT.IG_QUEST_LOG_OPEN)
end

Craftie.PlayerOnline = {}
function Craftie:GetOnlineCrafters() --guild only?
  local count = 0
  for k,v in pairs(Craftie.Professions) do
    if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"][v[2]:upper()] ~= nil) then
      for p in pairs(CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"][v[2]:upper()]) do
        --print(p)
        Craftie.PlayerOnline[p] = 0
      end
    end
  end
  --local load_time = i*0.120
  for k,v in pairs(Craftie.PlayerOnline) do
    count = count+1
    C_Timer.After(count*0.060, function()
      --print("player: " .. k)
      --update the listnet
      Craftie:PacketSend(Craftie.Packet.Prefix.Net, Craftie.Player.Name .. "," .. "1", "WHISPER", k)
    end)
  end
  Craftie:Notification("Craftie:GetOnlineCrafters()", Craftie.CHAT.FUNC)
end

function Craftie:BuildGuildPlayerList()
  local guild_players = {}

  if (not IsInGuild()) then
    return guild_players
  end

  if (C_GuildInfo and C_GuildInfo.GuildRoster) then
    C_GuildInfo.GuildRoster()
  end

  local totalMembers = GetNumGuildMembers()
  for i = 1, totalMembers do
    local name = GetGuildRosterInfo(i)
    if (name) then
      guild_players[Ambiguate(name, "none")] = true
    end
  end

  return guild_players
end

--on tab load
function Craftie:UpdateCrafterList(search)
  local crafter_list = {}
  local search_list = {}
  local fav_list = {}
  local rem_list = {}
  local fav_exist = 0
  Craftie.PlayerGuild = {}

  Craftie.Frame.ScrollPlayersResults:SetText("")
  Craftie.Frame.ScrollPlayersLoading:Show()
  Craftie.Frame.ScrollPlayersList:SetAlpha(0.3)

  for i=1, #Craftie.TOTAL_CRAFTERS do
    --Craftie.Frame.ScrollPlayersListNet[i]:Hide()
    --Craftie.Frame.ScrollPlayersListNet[i]:SetTexture("Interface/FriendsFrame/StatusIcon-Offline")
    Craftie.Frame.ScrollPlayersListFav[i]:Hide()
    Craftie.Frame.ScrollPlayersListName[i]:SetText("")
    Craftie.Frame.ScrollPlayersListClass[i]:SetText("")
    Craftie.Frame.ScrollPlayersListProfLevel[i]:SetText("")
    Craftie.Frame.ScrollPlayersListProfMastery[i]:SetText("")
    Craftie.Frame.ScrollPlayersListUpdate[i]:SetText("-")
    Craftie.Frame.ScrollPlayersListCont[i]:Show()
  end

  --for i=1, Craftie.MAX_RECIPES do
    --Craftie.Frame.ScrollRecipesListRow[i]:Hide()
  --end

  C_Timer.After(0.1, function()
    if (IsInGuild()) then
      Craftie.PlayerGuild = Craftie:BuildGuildPlayerList()
    end
    local guild_players = nil
    if (Craftie.PlayerListFilter == 2) then
      guild_players = Craftie:BuildGuildPlayerList()
    end

    local profession_crafters = nil
    if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"] ~= nil) then
      profession_crafters = CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"][Craftie.Page:upper()]
    end

    if (profession_crafters ~= nil) then
      for crafter_name in pairs(profession_crafters) do
        if ((not guild_players) or guild_players[crafter_name]) then
          table.insert(crafter_list, crafter_name)
        end
      end
    end

    search_list = crafter_list

    if (search ~= nil) then
      -- search is going on, redefine the table
      search_list = Craftie:SearchTable(crafter_list, search)
      fav_exist = 0
    else
      --not searching
      if (Craftie.Save.Player["FAVS"] ~= nil) then
        if (Craftie.Save.Player["FAVS"][Craftie.Page:upper()] ~= nil) then
          --search_list={}
          for k,v in pairs(search_list) do
            if (Craftie.Save.Player["FAVS"][Craftie.Page:upper()][v] == 1) then
              fav_exist = 1
              table.insert(fav_list, v)
              --print("fav - " .. v)
            else
              --print("rem - " .. v)
              table.insert(rem_list, v)
            end
          end
        end
      end
    end

    if (fav_exist == 1) then
      search_list = {}
      table.sort(fav_list)
      for _, value in ipairs(fav_list) do --favorite list on top
        table.insert(search_list, value)
      end
      table.sort(rem_list)
      for _, value in ipairs(rem_list) do --remaining
        table.insert(search_list, value)
      end
    else
      table.sort(search_list)
    end

    Craftie:CrafterRowAdd(#search_list + 1)

    local results = Craftie.Color.Yellow .. "Crafter(s)"
    if (Craftie.PlayerListFilter == 2) then
      results = Craftie.Color.Yellow .. "Guild Crafter(s)"
    end
    Craftie.Frame.ScrollPlayersResults:SetText(#search_list .. " " .. results)

    if (profession_crafters ~= nil) then
      for n=1, #search_list do
        local i=n+1 --skip the 1st index
        local crafter = Craftie:Split(profession_crafters[search_list[n]], ",")

        --reserve the first row for library (n) skip 1 line
        Craftie.Frame.ScrollPlayersListName[i]:SetText(search_list[n])

        Craftie.Frame.ScrollPlayersListName[i]:SetTextColor(1, 1, 1, 0.8)
        if (IsInGuild()) then
          if (Craftie.Save.Player.CONFIG["GUILD_GREEN"] ~= 0) then
            if ((Craftie.PlayerGuild) and Craftie.PlayerGuild[search_list[n]]) then
              Craftie.Frame.ScrollPlayersListName[i]:SetTextColor(Craftie.Color.Guild[1], Craftie.Color.Guild[2], Craftie.Color.Guild[3], 1)
            end
          end
        end
        Craftie.Frame.ScrollPlayersListFav[i]:Show()

        Craftie.Frame.ScrollPlayersListFav[i]:SetTexCoord(1, 0.5, 0, 0.5)
        if (Craftie.Save.Player["FAVS"] ~= nil) then
          if (Craftie.Save.Player["FAVS"][Craftie.Page:upper()] ~= nil) then
            if (Craftie.Save.Player["FAVS"][Craftie.Page:upper()][search_list[n]] == 1) then
              Craftie.Frame.ScrollPlayersListFav[i]:SetTexCoord(0, 0.5, 0, 0.5)
            end
          end
        end

        Craftie.Frame.ScrollPlayersListClass[i]:SetText(tonumber(crafter[1]))
        Craftie.Frame.ScrollPlayersListProfLevel[i]:SetText(crafter[3])
        if (crafter[5]) then
          Craftie.Frame.ScrollPlayersListProfMastery[i]:SetText(crafter[5])
        end
        if (crafter[6]) then
          Craftie.Frame.ScrollPlayersListUpdate[i]:SetText(crafter[6])
        end
      end
    end
  end)

  C_Timer.After(0.1, function()
    Craftie.Frame.ScrollPlayersLoading:Hide()
    Craftie.Frame.ScrollPlayersList:SetAlpha(1)
    --Craftie.Frame.ScrollPlayersList.Child:SetSelected(1)
    --Craftie.Frame.ScrollPlayersList.Child:SetVerticalScroll(20)
  end)

  --[==[
  LIBRARY
  ]==]--
  --if (Craftie.DEBUGLEVEL > 3) then
    Craftie.Frame.ScrollPlayersListName[1]:SetText(Craftie.Page .. " " .. Craftie._L.Player_PageNameListing)
    --Craftie.Frame.ScrollPlayersListFav[1]:SetTexture("Interface/WorldMap/UI-World-Icon")
    Craftie.Frame.ScrollPlayersListFav[1]:SetPoint("TOPLEFT", 4, -3)
    Craftie.Frame.ScrollPlayersListFav[1]:SetTexture("Interface/ICONS/" .. Craftie.Professions[Craftie.Tab][3])
    Craftie.Frame.ScrollPlayersListFav[1]:SetTexCoord(0, 1, 0, 1)
    --Craftie.Frame.ScrollPlayersListFav[1]:SetAlpha(0.7)
    Craftie.Frame.ScrollPlayersListFav[1]:SetDesaturation(0.6)
    Craftie.Frame.ScrollPlayersListFav[1]:Show()
    Craftie.Frame.ScrollPlayersListNet[1]:Hide()
  --else
    --Craftie.Frame.ScrollPlayersListCont[1]:Hide()
  --end

  Craftie:Notification("Craftie:UpdateCrafterList()", Craftie.CHAT.FUNC)
end

function Craftie:AlertIcon(tab)
  if (tab ~= 0) then
    Craftie.TabGlow[tab]:Play()
    Craftie.TipGlow[tab]:Play()
    Craftie.Frame.TabSide[tab].Glow:Show()
    Craftie.Frame.TabSide[tab].Tip:Show()
  end
  Craftie.IconGlow:Play()
  Craftie.Frame.Button.Minimap.Glow:Show()
  C_Timer.After(1, function() --give it time to load when logging in
    Craftie.Frame.Button.Minimap.Glow:SetSize(Craftie.Frame.Button.Minimap:GetWidth()+120, Craftie.Frame.Button.Minimap:GetHeight()+120)
    if (Craftie.Alert.NewProf == 0) then
      PlaySoundFile(Craftie._G.Path .. "Sounds/Notification1.ogg")
    end
  Craftie.Alert.NewProf = 1
  end)
  C_Timer.After(2, function()
    Craftie.Frame.Button.Minimap.Glow:SetSize(Craftie.Frame.Button.Minimap:GetWidth()+10, Craftie.Frame.Button.Minimap:GetHeight()+10)
  end)
  Craftie:Notification("Craftie:AlertIcon(tab) = " .. tab, Craftie.CHAT.FUNC)
end

Craftie.MyProfessions = {}
Craftie.MyProfessionEntry={}
function Craftie:GetProfessionEntry()
  --local new_prof = false
  if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"] ~= nil) then
    for i = 1, GetNumSpellTabs() do
      local offset, numSlots = select(3, GetSpellTabInfo(i))
      for j = offset+1, offset+numSlots do
        local spellName, spellSubName, spellID = GetSpellBookItemName(j, BOOKTYPE_SPELL)
        for k,v in pairs(Craftie.Professions) do
          if (spellName == v[2]) then
            table.insert(Craftie.MyProfessions, v[2])
          end
        end
      end
    end

    --we know a profession, but have not opened recipe book
    for k,prof in pairs(Craftie.MyProfessions) do
      if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"][prof:upper()][Craftie.Player.Name] == nil) then
        local tab = Craftie:GetKeyFromValue(Craftie.Professions, prof, 2)
        Craftie:Notification(Craftie._L.Notification.Detected[1] .. Craftie.Color.Blue .. " [" .. prof .. "]|r " .. Craftie.Player.Name .. "|n" .. Craftie._L.Notification.Detected[2] .. Craftie.Color.Theme .. " Craftie|r " .. Craftie._L.Notification.Detected[3], Craftie.CHAT.INFO)
        if (prof == "Alchemy") then
          Craftie.Tab = -1 --hack so that players will select alchemy as the first default loaded tab
        end
        --print("|cffffd000|Htrade:2550:300:PlayerGUID:RecipeData|h[Cooking]|h|r")
        table.insert(Craftie.MyProfessionEntry, prof)
        C_Timer.After(1, function() --new professions override existing orders
          Craftie:AlertIcon(tab)
        end)
        --new_prof = true
        --return prof
      end
    end
  end
  --[==[
  if (new_prof) then
    Craftie.Frame.Button.Minimap.Glow:SetSize(Craftie.Frame.Button.Minimap:GetWidth()+400, Craftie.Frame.Button.Minimap:GetHeight()+400)
    C_Timer.After(1, function()
      Craftie.Frame.Button.Minimap.Glow:SetSize(Craftie.Frame.Button.Minimap:GetWidth()+10, Craftie.Frame.Button.Minimap:GetHeight()+10)
    end)
    new_prof = false
  end
  ]==]--
  Craftie:Notification("Craftie:GetProfessionEntry(" .. #Craftie.MyProfessions .. ")", Craftie.CHAT.FUNC)
end

---@class TradeSkillFrame
function Craftie:TabSelectSide(tab, sound)
  if (Craftie.Tab ~= tab) then
    local prof_name = Craftie.Professions[tab][2]
    Craftie:CloseAllPlayerMenus()
    Craftie:ClearSearchFocus(true)
    for i=1, #Craftie.Professions do
      Craftie.Frame.TabSide[i].Select:Hide()
      Craftie.Frame.TabSide[i].Icon:SetAlpha(0.5)
    end
    Craftie.Frame.TabSide[tab].Select:Show()
    Craftie.Frame.TabSide[tab].Icon:SetAlpha(1)

    if (sound) then
      PlaySound(SOUNDKIT.IG_SPELLBOOK_OPEN)
      --PlaySound(SOUNDKIT.ALARM_CLOCK_WARNING_2) --request to craft?
    end

    Craftie.Tab = tab
    Craftie.Selected_Name = ""
    Craftie.Page = prof_name
    Craftie.TabGlow[tab]:Stop()
    Craftie.Frame.TabSide[tab].Glow:Hide()
    Craftie.TipGlow[tab]:Stop()
    Craftie.Frame.TabSide[tab].Tip:Hide()
    Craftie.ProfessionDefault = Craftie.Profession[prof_name]
    Craftie.Frame.CraftBackTopArt:SetTexture(Craftie._G.Path .. "Images/Backgrounds/professionbackgroundart" .. prof_name:lower() .. ".png")

    --we have no build yet
    for k,v in pairs(Craftie.MyProfessionEntry) do
      if (prof_name == v) then
        CastSpellByName(v)
        C_Timer.After(2, function()
          Craftie:UpdateCrafterList()
          Craftie.MyProfessionEntry[k] = nil
        end)
        C_Timer.After(0.03, function()
          if ((TradeSkillFrame) and (TradeSkillFrame:IsShown())) then
            HideUIPanel(TradeSkillFrame)
            Craftie:Notification("Awesome! " .. Craftie.Color.Blue .. "[" .. v .. "]|r profile built for " .. Craftie.Player.Name .. "|nNow you can link " .. v .. " in any chat", Craftie.CHAT.INFO)
          end
        end)
      end
    end

    C_Timer.After(0.1, function() --give it time to register
      Craftie:OpenProfessionList(Craftie.ProfessionDefault, "", "")
      Craftie:UpdateCrafterList()
      Craftie.Frame.DropdownRecipes.text:SetText(Craftie.MenuSelRecipes[1])
      Craftie.MenuSelRecipes[2] = nil
    end)

    Craftie.Selected_Player_Index = 1
    Craftie:SelectScrollItem("Players", false)
    Craftie.Frame.ScrollPlayersList.Child:SetVerticalScroll(1) --go to top

    Craftie.Selected_Recipe_Index = 1
    Craftie:SelectScrollItem("Recipes", false)
    Craftie.Frame.ScrollRecipesList.Child:SetVerticalScroll(1) --go to top

  Craftie:Notification("Craftie:TabSelectSide(" .. tab .. ")", Craftie.CHAT.FUNC)
  end
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
          if (frame == Craftie.Frame.Item) then
            Craftie.Frame.Item.Glow:SetAlpha(Craftie.Animation)
          end
          if (frame == Craftie.Frame.TabBar) then
            if (Craftie.TabBarHide == 0) then
              Craftie.Frame.TabBar:SetPoint("TOPLEFT", -Craftie.TabBar.X*self.frame, -Craftie.TabBar.Y)
            end
            if (Craftie.TabBarHide == 1) then
              Craftie.Frame.TabBar:SetPoint("TOPLEFT", -Craftie.TabBar.X*Craftie.Animation, -Craftie.TabBar.Y)
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

  Craftie.Frame.Item:Show()
  --Craftie.Frame.ItemCountEditBox:SetNumber(1)

  Craftie:TimerAnim(Craftie.Frame.Item, 0.65) --animate the craft icon
  --PlaySound(SOUNDKIT.IG_QUEST_LOG_OPEN)
  PlaySound(SOUNDKIT.IG_QUEST_LOG_CLOSE)

  for i=1, Craftie.MAX_REAGENTS do
    Craftie.Frame.Reagent.Main[i]:Hide()

    if (not Craftie:IsEmpty(item[5][i])) then
      local r = 0
      local inv_count= C_Item.GetItemCount(item[5][i][1])
      local inv_req = item[5][i][2]

      --reset
      Craftie.Frame.Reagent.Text[i]:SetTextColor(1, 1, 1, 0.8)
      Craftie.Frame.Reagent.Icon[i]:SetAlpha(0.6)
      Craftie.Frame.Reagent.Border[i]:SetBackdropBorderColor(0.5, 0.5, 0.48, 1)
      Craftie.Frame.Reagent.Border[i]:SetBackdropColor(0, 0, 0, 0.1)
      Craftie.Frame.Reagent.BorderGlow[i]:Hide()
      Craftie.Frame.Reagent.Quan[i]:SetTextColor(1, 1, 1, 0.8)
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
            Craftie:Notification("Missing Reagent Precache: " .. "[" .. item[5][i][1] .. "] " .. name[i], Craftie.CHAT.CACHE)
          end
          loadcache = 1
        end

        Craftie.Frame.Reagent.Main[r_next]:Show()
        Craftie.Frame.Reagent.Text[i]:SetText(Craftie.Reagent[r][2])
      end)

      --Craftie.Frame.Reagent.Text[i]:SetText(Craftie.Reagent[r][2])
      Craftie.Frame.Reagent.Data[i]:SetText(Craftie.Reagent[r][1])

      if (inv_count >= 99) then
        Craftie.Frame.Reagent.Quan[i]:SetText(".. /" .. inv_req)
      else
        Craftie.Frame.Reagent.Quan[i]:SetText(inv_count .. " /" .. inv_req)
      end

      Craftie.Frame.Reagent.Icon[i]:SetTexture(C_Item.GetItemIconByID(Craftie.Reagent[r][1]))
      --Craftie.Frame.Reagent.Main[i]:Show()

      if (loadcache == 1) then
        loadcache = 0
        C_Timer.After(0.2, function()
          Craftie.Frame.Reagent.Text[i]:SetText(Craftie.Reagent[r][2])
          Craftie:Notification("[" .. item[2] .. "] reloading from tooltip data", Craftie.CHAT.FUNC)
        end)
      end
      if (inv_count >= inv_req) then
        Craftie.Frame.Reagent.Border[i]:SetBackdropBorderColor(1, 1, 0.6, 0.9)
        Craftie.Frame.Reagent.Border[i]:SetBackdropColor(1, 1, 0, 0.1)
        Craftie.Frame.Reagent.BorderGlow[i]:Show()
        Craftie.Frame.Reagent.Icon[i]:SetAlpha(1)
        Craftie.Frame.Reagent.Text[i]:SetTextColor(1, 1, .85, 1)
        Craftie.Frame.Reagent.Quan[i]:SetTextColor(1, 1, .6, 1)
        Craftie.Frame.Reagent.IconGlow[i]:Show()
      end
      --print("craftie count " .. Craftie.Reagent[r][2] .. ": " .. item[5][i][2] .. " | " .. inv_count)
    end
  end

  Craftie.Frame.Item.ID:SetText(item[4])
  Craftie.Frame.Item.Text:SetText(item[2])

  local item_detail = item[4]
  local is_enchant = false

  if (item_detail == "") then --blank or possibly enchant
    local name, subtext, icon, castTime, minRange, maxRange, spellID, originalIcon = GetSpellInfo(item[1])
    --print("spell? " .. name .. " | " .. icon)
    Craftie.Frame.Item.ID:SetText(item[1])
    Craftie.Frame.Item.Icon:SetTexture(icon)
    --print(icon)
    is_enchant = true
    Craftie:Notification("is_enchant = true", Craftie.CHAT.FUNC)
  else
    Craftie.Frame.Item.Icon:SetTexture(C_Item.GetItemIconByID(item_detail))
  end

  C_Timer.After(0.12, function() --give it time to register
    Craftie.Frame.Item.Text:SetTextColor(1, 1, 1, 1)
    if (is_enchant) then
      local link = GetSpellLink(item[1])
      Craftie.Frame.Item.HLink:SetText(link)
      Craftie.Frame.Item.HLink:SetScript("OnEnter", function(self)
        Craftie:SetItemTooltip(Craftie.Frame.Item.HLink, Craftie.Frame.Item.ID:GetText(), true)
      end)
    else
      local name, link, quality, level, minlevel, type, subtype = C_Item.GetItemInfo(item_detail)
      Craftie.Frame.Item.HLink:SetText(link)
      if (quality ~= nil) then
        local r, g, b, qs = C_Item.GetItemQualityColor(quality)
        Craftie.Frame.Item.Text:SetTextColor(r, g, b, 1)
      end
      Craftie.Frame.Item.HLink:SetScript("OnEnter", function(self)
        Craftie:SetItemTooltip(Craftie.Frame.Item.HLink, Craftie.Frame.Item.ID:GetText(), false)
      end)
    end

    --wowhead bug
    local SkillLevel = item[3]
    if (tonumber(item[3]) > Craftie.PROFMAXLEVEL) then
      SkillLevel = Craftie.PROFMAXLEVEL
    end
    Craftie.Frame.Item.SkillText:SetText(Craftie.Page .. " (" .. SkillLevel .. ")")
    Craftie.Frame.Item.HLink:SetTextColor(1, 1, 1, 0) --hide/alpha
    local source = item[6]
    local sources = source[1]
    if (#source > 1) then
      sources = ""
      for k,v in pairs(source) do
        sources = sources .. v .. ", "
      end
      Craftie.Frame.Item.SourceText:SetText(string.sub(sources, 1, -3))
    else
      Craftie.Frame.Item.SourceText:SetText(sources)
    end
  end)

  local prof_list = Craftie:GetKeyFromValue(Craftie.Professions, Craftie.Page, 2)
  local prof_color = Craftie:Split(Craftie.Professions[prof_list][4], ",")
  Craftie.Frame.Item.SkillIcon:SetTexture("Interface/Icons/" .. Craftie.Professions[prof_list][3])
  Craftie.Frame.Item.SkillText:SetTextColor(prof_color[1], prof_color[2], prof_color[3], 1)

  Craftie.Frame.Item.Icon:Show()
  Craftie.Frame.Item.SkillText:Show()
  Craftie.Frame.Item.SkillIcon:Show()
  Craftie.Frame.Item.SourceTitle:Show()
  Craftie.Frame.Item.SourceText:Show()

  if (Craftie.Selected_Name ~= "") then
    Craftie:CraftRequestFrame(Craftie.Selected_Name)
  end
end

function Craftie:RecipeLevelColor(i, itemLevel, thresholds)
  if (Craftie.Save.Player.CONFIG["LEVEL_COLOR"] ~= 0) then
    local gray  = {0.8, 0.8, 0.8, 1}
    local green = {0, 0.60, 0, 1}
    local yellow= {0.9, 0.9, 0, 1}
    local orange= {1, 0.50, 0.25, 1}
    if (Craftie.CrafterProfLevel >= 1) then
      Craftie.Frame.ScrollRecipesListName[i]:SetTextColor(0.8, 0.8, 0.8, 1)

      if (thresholds ~= nil) then
        if (Craftie.CrafterProfLevel < thresholds[1]) then
          Craftie.Frame.ScrollRecipesListName[i]:SetTextColor(orange[1], orange[2], orange[3], orange[4]) --orange
        elseif (Craftie.CrafterProfLevel < thresholds[2]) then
          Craftie.Frame.ScrollRecipesListName[i]:SetTextColor(yellow[1], yellow[2], yellow[3], yellow[4]) --yellow
        elseif (Craftie.CrafterProfLevel < thresholds[3]) then
          Craftie.Frame.ScrollRecipesListName[i]:SetTextColor(green[1], green[2], green[3], green[4]) --green
        end
      elseif (Craftie.CrafterProfLevel <= itemLevel) then
        Craftie.Frame.ScrollRecipesListName[i]:SetTextColor(orange[1], orange[2], orange[3], orange[4]) --orange
      elseif (Craftie.CrafterProfLevel <= itemLevel+10) then
        Craftie.Frame.ScrollRecipesListName[i]:SetTextColor(yellow[1], yellow[2], yellow[3], yellow[4]) --yellow
      elseif (Craftie.CrafterProfLevel <= itemLevel+25) then
        Craftie.Frame.ScrollRecipesListName[i]:SetTextColor(green[1], green[2], green[3], green[4]) --green
      end
    end
  end
end

function Craftie:SelectScrollItem(scrollFrame, playerCrafterLevel)
  if (Craftie.EnableScrollFrames) then
    if (scrollFrame == "Players") then
      for i=1, #Craftie.TOTAL_CRAFTERS do
        Craftie.Frame.ScrollPlayersListCont[i]:SetBackdropColor(1, 1, 1, 0)
        Craftie.Frame.ScrollPlayersListSelect[i]:Hide()

        local name = Craftie.Frame.ScrollPlayersListName[i]:GetText()
        if ((IsInGuild()) and (Craftie.PlayerGuild[name]) and (Craftie.Save.Player.CONFIG["GUILD_GREEN"] ~= 0)) then
          Craftie.Frame.ScrollPlayersListName[i]:SetTextColor(Craftie.Color.Guild[1], Craftie.Color.Guild[2], Craftie.Color.Guild[3], 1)
        else
          Craftie.Frame.ScrollPlayersListName[i]:SetTextColor(1, 1, 1, 0.8)
        end
      end
      --selected
      Craftie.Frame.ScrollPlayersListSelect[Craftie.Selected_Player_Index]:Show()
      Craftie.Frame.ScrollPlayersListName[Craftie.Selected_Player_Index]:SetTextColor(1, 1, 0.8, 1)
    end
    if (scrollFrame == "Recipes") then
      for i=1, Craftie.MAX_RECIPES do
        Craftie.Frame.ScrollRecipesListRow[i]:SetBackdropColor(1, 1, 1, 0)
        Craftie.Frame.ScrollRecipesListSelect[i]:Hide()
        --Craftie.Frame.ScrollRecipesListSelectSpark[i]:Hide()
        Craftie.Frame.ScrollRecipesListName[i]:SetTextColor(1, 1, 1, 0.8)
        if (playerCrafterLevel) then
        local itemLevel = tonumber(Craftie.Frame.ScrollRecipesListLevel[i]:GetText())
          if (itemLevel) then
            Craftie:RecipeLevelColor(i, itemLevel, Craftie.Frame.ScrollRecipesListRow[i].SkillThresholds)
          end
        end
      end
      Craftie.Frame.ScrollRecipesListSelect[Craftie.Selected_Recipe_Index]:Show()
      Craftie.Frame.ScrollRecipesListName[Craftie.Selected_Recipe_Index]:SetTextColor(1, 1, 0.8, 1)
    end
  end
  --Craftie:Notification("Craftie:SelectScrollItem(" .. scrollFrame .. ")", Craftie.CHAT.FUNC)
end

--version control when the app initializes
function Craftie:AlphaSortProfessionLib()
  --very important so the order is always sorted alphabetically
  for k,v in pairs(Craftie.Professions) do
    --print(v[1])
    Craftie:SortTableByString(Craftie.Profession[v[2]])
  end
end

Craftie.ProfileBuilt = {} --need to reset when learning a new recipe
function Craftie:CrafterBuildReset()
  --clear all profession flags
  for k,v in pairs(Craftie.Professions) do
    Craftie.ProfileBuilt[v[2]] = 0
  end
  Craftie:Notification(Craftie.Color.Lime .. "Craftie:CrafterBuildReset()", Craftie.CHAT.FUNC)
end

--Craftie.Throttle.Prof.Flag
--build personal string, store it, and use for packets and notifications
function Craftie:CrafterBuildData(profName, profLevel, useCraftAPI)
  local profBuild = Craftie:CopyTable(Craftie.Profession[profName])
  --Craftie:SortTableByString(profBuild) --alpha sort just in case
  local profData={}
  local profString = ""
  local profMastery = 0

  for k,v in pairs(Craftie.Professions) do --use only the prio list, no fishing, first-aid, etc...
    if (profName == v[2]) then
      local professionID = v[1]
      if (Craftie.ProfileBuilt[profName] == 0) then
        --Craftie:Notification("Craftie:CrafterBuildData", Craftie.CHAT.FUNC)
        Craftie.ProfileBuilt[profName] = -1 --build scheduled/in progress
        C_Timer.After(0.5, function() --give it time to register the profession recipes
          --print(profName)
          for k,v in pairs(profBuild) do
            if (v[2] ~= nil) then
              profData[Craftie:SanitizeString(v[2], true)] = "0" --build the empty binary string
            end
          end

          local mastery = Craftie:GetProfessionMastery(profName)
          if (mastery) then
            profMastery = tonumber(table.concat(mastery, ", "))
          else
            profMastery = 0
          end
          --print("profMastery: " .. profMastery)

          local numRecipes = useCraftAPI and GetNumCrafts() or GetNumTradeSkills()
          for i = 1, numRecipes do
            local recipeName, recipeType
            if (useCraftAPI) then
              recipeName, _, recipeType = GetCraftInfo(i)
            else
              recipeName, recipeType = GetTradeSkillInfo(i)
            end
            --if (recipeType == "header") then
              --print(recipeName)
            --end
            if (recipeType ~= "header") then
              local recipeKey = Craftie:SanitizeString(recipeName, true)
              -- Only set keys from the canonical profession library. Adding
              -- an unknown trade-skill row changes the packet's bit count and
              -- shifts recipe ownership for every receiver.
              if (recipeKey ~= nil and profData[recipeKey] ~= nil) then
                profData[recipeKey] = "1"
                --print(Craftie:SanitizeString(recipeName, true) .. " = 1")
              end
            end
          end

          --senderName | senderClass | profNum | profLevel | profData
          --print(Craftie:GetKeyFromValue(Craftie.Professions, profName, 1))
          --print(profName .. " | " .. profLevel)
          --profString = Craftie.Player.Name .. "," .. Craftie.Player.ClassID .. "," .. Craftie:GetKeyFromValue(Craftie.Professions, profName, 1) .. "," .. profLevel .. ","
          profString = Craftie.Player.ClassID .. "," .. professionID .. "," .. profLevel .. ","

          local tkeys = {}
          for k in pairs(profData) do
            table.insert(tkeys, k)
            --print(k)
          end

          --alpha sort order
          table.sort(tkeys)
          for _, b in ipairs(tkeys) do
            --print(b)
            profString = profString .. profData[b]
          end

          profString = profString .. "," .. profMastery .. "," .. Craftie.Date

          Craftie:Notification("Craftie:CrafterBuildData(" .. profString .. ")", Craftie.CHAT.SAVE)
          CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"][profName:upper()][Craftie.Player.Name] = profString
          Craftie.ProfileBuilt[profName] = 1

          --share to guild members
          C_Timer.After(3, function()
            if (IsInGuild()) then
              C_GuildInfo.GuildRoster()
              local gcount = 0
              local totalMembers, onlineMembers = GetNumGuildMembers()
              for i = 1, totalMembers do
                local gmember, _, _, level, _, zone, _, _, online = GetGuildRosterInfo(i)
                if (online) then
                  local member = Craftie:Split(gmember, "-")
                  gcount = gcount + 1
                  C_Timer.After(gcount * 0.1, function()
                    --print(member[1])
                    if (member[1] ~= Craftie.Player.Name) then
                      Craftie:PacketSend(Craftie.Packet.Prefix.Data, Craftie.Player.Name .. "," .. profString, "WHISPER", member[1])
                    end
                  end)
                end
              end
            end
          end)

        end)
      end
    end
  end
  --Craftie:Notification("Craftie:CrafterBuildData", Craftie.CHAT.FUNC)
end

Craftie.CrafterProfLevel = 1 --globalizing to add to professionlist
function Craftie:SetProfLevel(level)
  local diff  = 161
  local uimax = 246 --UI Max width
  local calc = 0

  Craftie.Frame.CrafterLevel:Hide()
  Craftie.Frame.CrafterProgBarS:Hide()
  Craftie.CrafterProfLevel = level

  if (level) then
    calc = math.ceil((level * diff) / uimax)
    if (calc >= 1) then
      Craftie.Frame.CrafterLevel:Show()
      --print("level: " .. level .. " | " .. calc .. " [max: " .. uimax .. "]")

      Craftie.Frame.CrafterProgBar:SetSize(calc, 15)
      Craftie.Frame.CrafterProgLevel:SetText(level .. " / " .. Craftie.PROFMAXLEVEL)
      local left = 0
      if (calc < 200) then left = 4 end
      if (calc <= 20) then left = 5 end
      Craftie.Frame.CrafterProgBar:SetPoint("TOPLEFT", 0+left, -5)
      if (level < Craftie.PROFMAXLEVEL) then
        Craftie.Frame.CrafterProgBarS:SetPoint("TOPLEFT", calc-41+left, 16)
        Craftie.Frame.CrafterProgBarS:Show()
      end
    end
  end
end

--on selection entry
function Craftie:CrafterDataParse(profName, player)
  --print(profName)
  local crafterData = {}
  local compareProf = Craftie:CopyTable(Craftie.Profession[profName])
  local crafterProf = {}
  local crafterFiltered= {}
  local class = ""
  local profNum = ""
  local profLevel = ""
  local profString = ""
  local profMastery = 0
  local update = ""
  local filtered = {}

  --alpha sort table (sanity check)
  Craftie:SortTableByString(compareProf)

  if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"][profName:upper()][player] ~= nil) then
    --print(CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"][profName:upper()][player])

    crafterData = Craftie:Split(CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"][profName:upper()][player], ",")

    class = crafterData[1] --Craftie.Class[tonumber(packet[4])][1]
    profNum = crafterData[2]
    profLevel = crafterData[3]
    profString = crafterData[4]
    profMastery = crafterData[5]
    update = crafterData[6]

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

    local indexer = "" --nil causes issues
    for k,v in pairs(crafterProf) do
      --print(v[2])
      if (v[2]) then
        indexer = indexer .. Craftie:SanitizeString(v[2], false) .. ";"
      end
    end
    if (indexer ~= "") then
      CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CACHE"][profName:upper()][player] = indexer
      Craftie:Notification("Craftie:CrafterDataParse() cache indexer string built", Craftie.CHAT.FUNC)
    end

    Craftie:SetProfLevel(tonumber(profLevel))
    --Craftie:Notification("libraryProf " .. #Craftie.Profession[profName], Craftie.CHAT.FUNC)
    if (update == nil) then
      update=""
    end

    if (profMastery == nil) then
      profMastery = 0
    else
      C_Timer.After(0.1, function() --give it time to register the profession recipes
        local k = Craftie:GetKeyFromValue(Craftie.Professions, profName, 2)
        Craftie.Frame.Mastery:SetText(Craftie.Professions[k][5][tonumber(profMastery)])
      end)
    end
    Craftie:Notification("Craftie:CrafterDataParse():" .. player .. ","  .. class .. "," .. profNum .. "," .. profLevel .. "," .. profString .. "," .. profMastery .. "," .. update, Craftie.CHAT.PARSE)
  end
  return crafterProf
end

function Craftie:OpenProfessionList(profArray, search, player)
  local profCache = {}
  local search_all_count = 0
  local index = 1
  Craftie.Frame.ScrollRecipesLoading:Show()
  Craftie.Frame.ScrollRecipesList:SetAlpha(0.4)
  Craftie:SelectScrollItem("Recipes", false)
  Craftie:SetProfLevel(0)
  if (player ~= "") then
    Craftie:Notification(Craftie.Color.Yellow .. "Opening|r [" .. player .. "] Crafting book", Craftie.CHAT.FUNC)
    profCache = Craftie:CrafterDataParse(Craftie.Page, player)
    Craftie.MenuSelRecipes[2] = player
  else
    profCache = Craftie:CopyTable(profArray)
    for i=1, #Craftie.TOTAL_CRAFTERS do
      if (i > 1) then
        Craftie.Frame.ScrollPlayersListCont[i]:Show()
        Craftie.Frame.ScrollPlayersListRow[i]:SetPoint("TOPLEFT", 2, -i*Craftie.Frame.ScrollPlayersListRow[i]:GetHeight()+16)
      end
    end
  end

  if (search ~= "") then
    if (Craftie.Frame.DropdownRecipes.text:GetText() == Craftie.MenuSelRecipes[1]) then
      for i=1, #Craftie.TOTAL_CRAFTERS do
        if (i > 1) then
          Craftie.Frame.ScrollPlayersListCont[i]:Hide()
        end
      end

      --print("search everyone within " .. Craftie.Page)
      if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CACHE"][Craftie.Page:upper()] ~= nil) then
        --print("found " .. Craftie.Page)
        for k,v in pairs(CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CACHE"][Craftie.Page:upper()]) do
          local pattern = string.find(string.lower(CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CACHE"][Craftie.Page:upper()][k]), search, 1, true)
          if (pattern) then
            search_all_count = search_all_count +1
            --print(k .. " - " .. pattern)
            for i=1, #Craftie.TOTAL_CRAFTERS do
              if (k == Craftie.Frame.ScrollPlayersListName[i]:GetText()) then
                index = index +1
                Craftie.Frame.ScrollPlayersListCont[i]:Show() --show only containers
                Craftie.Frame.ScrollPlayersListRow[i]:SetPoint("TOPLEFT", 2, -index*Craftie.Frame.ScrollPlayersListRow[i]:GetHeight()+16)
              end
            end
          end
        end
      end
    end
    Craftie:Notification("Craftie:OpenProfessionList() search_all_count " .. search_all_count, Craftie.CHAT.FUNC)
  end

  local total_recipes = #profCache
  --local total_search = 0
  local results = " / " .. #Craftie.Profession[Craftie.Page] .. Craftie.Color.Yellow .. " Recipe(s)"

  Craftie:ClearCraftFrame() --also hide request frame

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
        if (Craftie.Frame.DropdownRecipes.text:GetText() == Craftie.MenuSelRecipes[1]) then
          Craftie.Frame.ScrollRecipesEmpty:SetText(search_text)
        else
          Craftie.Frame.ScrollRecipesEmpty:SetText(search_text .. "from " .. Craftie.Selected_Name)
        end
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
      --Craftie.Frame.ScrollRecipesListSelectSpark[i]:Hide()
      Craftie.Frame.ScrollRecipesListID[i]:SetText("")
      Craftie.Frame.ScrollRecipesListName[i]:SetText("")
      Craftie.Frame.ScrollRecipesListLevel[i]:SetText("")
      Craftie.Frame.ScrollRecipesListRow[i].SkillThresholds = nil
      --Craftie.Frame.ScrollRecipesListHLink[i]:SetText("")
      Craftie.Frame.ScrollRecipesListRow[i]:SetScript("OnClick", function()
        --do nothing
      end)
    end
  else
    --hide the remainder for high level crafters
    for i=1, Craftie.MAX_RECIPES do
      Craftie.Frame.ScrollRecipesListRow[i]:Hide()
    end
  end

  if (total_recipes == 0) then
    for i=1, Craftie.MAX_RECIPES do
      Craftie.Frame.ScrollRecipesListRow[i]:Hide() --nothing to show, just clear the board
    end
  else
    for i=1, total_recipes do
      Craftie.Frame.ScrollRecipesListID[i]:SetText(profCache[i][4])
      Craftie.Frame.ScrollRecipesListName[i]:SetText(profCache[i][2])
      Craftie.Frame.ScrollRecipesListLevel[i]:SetText(profCache[i][3])
      Craftie.Frame.ScrollRecipesListVersion[i]:SetText(profCache[i][7])
      Craftie.Frame.ScrollRecipesListRow[i].SkillThresholds = profCache[i][8]
      if (player ~= "") then
        local itemLevel = profCache[i][3]
        Craftie.Frame.ScrollRecipesListName[i]:SetTextColor(0.8, 0.8, 0.8, 1)
        Craftie:RecipeLevelColor(i, itemLevel, profCache[i][8])
      end
      --Craftie.Frame.ScrollRecipesListHLink[i]:SetText("")
      Craftie.Frame.ScrollRecipesListRow[i]:SetScript("OnClick", function()
        if (Craftie.EnableScrollFrames) then
          if (IsShiftKeyDown()) then
            local name, link = C_Item.GetItemInfo(profCache[i][4])
            if (link == nil) then
              link = GetSpellLink(profCache[i][1]) --enchant
            end
            if ((link ~= nil) and (link ~= "")) then
              ChatEdit_InsertLink(link)
            end
          end
          Craftie:ItemDetails(profCache[i])
          --clear selections
          Craftie.Selected_Recipe_Index = i
          Craftie:SelectScrollItem("Recipes", true)
        end
      end)
      Craftie.Frame.ScrollRecipesListRow[i]:Show()
    end
  end

  Craftie.Frame.Title:SetText(Craftie.Page)
  if (player ~= "") then
    local lastChar = player:sub(-1)
    local plural = "s"
    if (lastChar == plural) then
      plural = ""
    end
    Craftie.Frame.Title:SetText(player .. "'".. plural .. " " .. Craftie.Page .. " Recipes")
  end

  --local prof_list = Craftie:GetKeyFromValue(Craftie.Professions, Craftie.Page, 1)
  --local prof_color = Craftie:Split(Craftie.Professions[prof_list][3], ",")
  --Craftie.Frame.Title:SetTextColor(prof_color[1], prof_color[2], prof_color[3], 1)
  --Craftie.Frame.Icon:SetTexture("Interface/ICONS/" .. Craftie.Professions[prof_list][2])

  C_Timer.After(0.35, function()
    Craftie.Frame.ScrollRecipesLoading:Hide()
    Craftie.Frame.ScrollRecipesList:SetAlpha(1)
  end)

  Craftie:Notification("Craftie:OpenProfessionList(" .. player .. " " .. search .. ")", Craftie.CHAT.FUNC)
end

function Craftie:GetCraftOrders()
  local order_index = 0
  local order_count = 0
  if (Craftie.Save.Player["ORDERS"] ~= nil) then
    for _ in pairs(Craftie.Save.Player["ORDERS"]) do
      order_count = order_count + 1
    end
  end
  Craftie:OrderRowAdd(math.max(order_count, 5))

  Craftie.Frame.CraftOrdersDeleteAll:Disable()
  for i=1, #Craftie.TOTAL_ORDERS do
    Craftie.Frame.ScrollOrderListName[i]:SetText("")
    Craftie.Frame.ScrollOrderListItem[i]:SetText("")
    Craftie.Frame.ScrollOrderListCount[i]:SetText("")
    Craftie.Frame.ScrollOrderListDate[i]:SetText("")
    Craftie.Frame.ScrollOrderListDelete[i]:Hide()
  end
  Craftie.Frame.ScrollOrderListItemButton[6]:Show()
  Craftie.Frame.ScrollOrderListItem[6]:SetText("Loading...")

  Craftie.Frame.CraftOrders:SetAlpha(0.8)
  C_Timer.After(0.3, function()
    for i=1, #Craftie.TOTAL_ORDERS do
      Craftie.Frame.ScrollOrderListNameButton[i]:Hide()
      Craftie.Frame.ScrollOrderListItemButton[i]:Hide()
    end

    if (Craftie.Save.Player["ORDERS"] ~= nil) then
      for name,v in pairs(Craftie.Save.Player["ORDERS"]) do
        order_index = order_index +1
        local order = Craftie:Split(v, ",")
        Craftie.Frame.ScrollOrderListName[order_index]:SetText(name)
        Craftie.Frame.ScrollOrderListItem[order_index]:SetText(order[2])
        Craftie.Frame.ScrollOrderListCount[order_index]:SetText(order[3])
        Craftie.Frame.ScrollOrderListDate[order_index]:SetText(order[4]:gsub("_", " "))
        Craftie.Frame.ScrollOrderListNameButton[order_index]:Show()
        Craftie.Frame.ScrollOrderListItemButton[order_index]:Show()
        Craftie.Frame.ScrollOrderListDelete[order_index]:Show()
        --bugfix: resize the hidden frame for UI interactivity
        Craftie.Frame.ScrollOrderListNameButton[order_index]:SetWidth(Craftie.Frame.ScrollOrderListName[order_index]:GetStringWidth()+30)
        Craftie.Frame.ScrollOrderListItemButton[order_index]:SetWidth(Craftie.Frame.ScrollOrderListItem[order_index]:GetStringWidth()+20)

        local class = tonumber(order[1])
        local r = Craftie.Class[class][3][1]
        local g = Craftie.Class[class][3][2]
        local b = Craftie.Class[class][3][3]
        Craftie.Frame.ScrollOrderListName[order_index]:SetTextColor(r, g, b, 1)
      end
    end

    Craftie.Frame.Button.Minimap.Glow:Hide()
    local color = Craftie.Color.Silver
    if (order_index >= 1) then
      Craftie.Frame.CraftOrdersDeleteAll:Enable()
      Craftie.TabBottomOrderAlert:Show()
      Craftie.IconGlow:Play()
      Craftie.Frame.Button.Minimap.Glow:Show()
      C_Timer.After(1, function()
        --print("clear order anim")
        Craftie.TabBottomOrderAlert:Hide()
      end)
      color = Craftie.Color.Yellow
    end
    Craftie.TabBottom[2].Text:SetText(Craftie._L.Navigation[2] .. " " .. color .. "[" .. order_index .. "]")
    Craftie.Frame.CraftOrders:SetAlpha(1)
  end)
  Craftie:Notification(Craftie.Color.Yellow .. "Craftie:GetCraftOrders()", Craftie.CHAT.FUNC)
end

--add a timer for parsed data
function Craftie:Open(player, profession)
  Craftie:GetCraftOrders()
  if (player) then
    --Craftie:Notification("Craftie:Open player: " .. player, Craftie.CHAT.FUNC)
    --Craftie:Notification("Craftie:Open profession: " .. profession, Craftie.CHAT.FUNC)
    --local prof = profession
    Craftie:TabSelectBottom(1, true)
    C_Timer.After(0.1, function() --give it time to register
      local page = Craftie:GetKeyFromValue(Craftie.Professions, profession, 2)
      Craftie:Notification("Craftie:Open: Go to " .. profession .. " => " .. player, Craftie.CHAT.FUNC)
      Craftie:TabSelectSide(page, true)
      Craftie.Frame:Show()
    end)
  else
    Craftie.Frame:Show()
    Craftie.IconGlow:Stop()
    Craftie.Frame.Button.Minimap.Glow:Hide()
    Craftie:Notification("Craftie:Opened", Craftie.CHAT.FUNC)
  end
end

--caching tooltip data. preload unknown data
Craftie.Reagent = {}
function Craftie:BuildReagentCaching()
  for i=1, Craftie.MAX_ITEMIDS do
    table.insert(Craftie.Reagent, {i, Craftie.Preload})
  end
  for k,v in pairs(Craftie.Reagents) do
    Craftie.Reagent[v[1]] = {v[1], v[2]}
  end
  Craftie:Notification("Craftie:BuildReagentCaching()", Craftie.CHAT.FUNC)
end

--use the classic frame, but updated images. The updated frame has major bugs
function Craftie:ScrollBarFrame(frame)
  local _scrollUp = Craftie._G.Path .. "Images/UI-Craftie-Scroll-Arr.png"
  local _scrollDn = Craftie._G.Path .. "Images/UI-Craftie-Scroll-Dn.png"
  local _scrollSlider = frame.ScrollBar:GetThumbTexture()
  _scrollSlider:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Scroll-Slider.png")
  _scrollSlider:SetSize(12, 48)
  frame.ScrollBar.ScrollUpButton:SetNormalTexture(_scrollUp)
  frame.ScrollBar.ScrollUpButton:SetPushedTexture(_scrollUp)
  frame.ScrollBar.ScrollUpButton:SetHighlightTexture(_scrollUp, "ADD")
  frame.ScrollBar.ScrollUpButton:SetDisabledTexture(_scrollUp, "ADD")
  frame.ScrollBar.ScrollUpButton:SetSize(16, 12)
  frame.ScrollBar.ScrollDownButton:SetNormalTexture(_scrollDn)
  frame.ScrollBar.ScrollDownButton:SetPushedTexture(_scrollDn)
  frame.ScrollBar.ScrollDownButton:SetHighlightTexture(_scrollDn, "ADD")
  frame.ScrollBar.ScrollDownButton:SetDisabledTexture(_scrollDn, "ADD")
  frame.ScrollBar.ScrollDownButton:SetSize(16, 12)
  ScrollBack = frame:CreateTexture(nil, "BORDER")
  ScrollBack:SetSize(26, frame:GetHeight()-45)
  ScrollBack:SetPoint("TOPLEFT", frame:GetWidth()-30, -22)
  --ScrollBack:SetVertTile(true)
  ScrollBack:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Scroll-Back.png", "REPEAT")
  ScrollTop = frame:CreateTexture(nil, "BORDER")
  ScrollTop:SetSize(26, 32)
  ScrollTop:SetPoint("TOPLEFT", frame:GetWidth()-30, -13)
  ScrollTop:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Scroll-Top.png")
  ScrollBot = frame:CreateTexture(nil, "BORDER")
  ScrollBot:SetSize(26, 32)
  ScrollBot:SetPoint("TOPLEFT", frame:GetWidth()-30, -ScrollBack:GetHeight()+1)
  ScrollBot:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Scroll-Bot.png")
end

function Craftie:SaveMapButtonPos()
  Craftie:UpdateMapButton()
  C_Timer.After(0.1, function()
    local point, relativeTo, relativePoint, xOfs, yOfs = Craftie.Frame.Button.Minimap:GetPoint()
    Craftie.Save.Player["CONFIG"]["POS_MINIMAP"] = math.ceil(xOfs) .. "," .. math.ceil(yOfs)
    --print(point .. "," .. math.ceil(xOfs) .. "," .. math.ceil(yOfs))
    Craftie:Notification("Craftie:SaveMapButtonPos() = " .. math.ceil(xOfs) .. "," .. math.ceil(yOfs), Craftie.CHAT.SAVE)
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

  --Craftie:Notification("Craftie:UpdateMapButton()", Craftie.CHAT.FUNC)
end

function Craftie:Dialog(text, func)
  Craftie.EnableScrollFrames = false
  CraftieDialog.Yes:Hide()
  CraftieDialog:Show()
  CraftieDialog.Text:SetText(text)
end

--TODO figure out a way to locally build the languages and store for the account
function Craftie:ProfessionLocaleConversion(prof)
  local count = 0
  for k,v in pairs(Craftie.Profession[prof]) do
    count = count+1
    C_Timer.After(count*0.120, function()
      --add english version first to cover errors or gaps
      --local name, _ = C_Item.GetItemInfo(v[4])
      local name = Craftie:GetSafeItemData(v[4])
      Craftie.Profession[prof][k][2] = name
      Craftie:Notification(v[2] .. " => " .. name, Craftie.CHAT.FUNC)
    end)
  end
end

function Craftie:GetSafeItemData(itemIdentifier)
  local itemName = C_Item.GetItemInfo(itemIdentifier)
  if (not itemName) then
    print("Item not cached yet, waiting for server...")
    --force the server to send info to client
    C_Item.RequestLoadItemDataByID(itemIdentifier)
  else
    --ready to use
    return C_Item.GetItemInfo(itemIdentifier)
  end
end
