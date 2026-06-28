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

  Craftie.EnableScrollFrames = true
end

function Craftie:ClearCraftFrame()
  Craftie.Frame.Item:Hide()
  Craftie.Frame.ItemCountEditBox:SetNumber(1)
  --GameTooltip:Hide()
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
  Craftie.Frame.ItemRequestParent:Show()
  --print("CraftRequestFrame: " .. crafter)
end

function Craftie:ClearSearchFocus(crafters)
  Craftie.Frame.Search.Recipes.Text:ClearFocus()
  Craftie.Frame.Search.Recipes.Text:SetText(Craftie.Placeholder_Recipes)
  Craftie.Frame.Search.Recipes.Text:SetFontObject(GameFontDisable)

  if (crafters) then
    Craftie.Frame.Search.Players.Text:ClearFocus()
    Craftie.Frame.Search.Players.Text:SetText(Craftie.Placeholder_Players)
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
  C_Timer.After(0.1, function() --give the update time to create cached tables
    for i=1, Craftie.MAX_CRAFTERS do
      if (player == Craftie.Frame.ScrollPlayersListName[i]:GetText()) then
        --print(player .. " index = " .. i)
        Craftie:SelectCrafter(i, player)
      end
    end
  end)
end

function Craftie:SelectCrafter(index, name)
  Craftie.Selected_Name = ""
  Craftie.Selected_Player_Index = 1 --always one at first
  Craftie.Selected_Recipe_Index = 1
  --Craftie:SelectScrollItem("Recipes")

  if (index == 1) then
    if (Craftie.Frame.Search.Recipes.Text:GetText() ~= Craftie.Placeholder_Recipes) then
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

Craftie.PlayerOnline = {}
function Craftie:GetOnlineCrafters()
  local count = 0
  for k,v in pairs(Craftie.Professions) do
    if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"][v[1]:upper()] ~= nil) then
      for p in pairs(CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"][v[1]:upper()]) do
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
      Craftie:SendPacket(Craftie.Packet.Prefix.Net, Craftie.Player.Name .. "," .. "1", "WHISPER", k)
    end)
  end
  Craftie:Notification("Craftie:GetOnlineCrafters()", Craftie.CHAT.FUNC)
end

--on tab load
function Craftie:UpdateCrafterList(search)
  local crafter_list = {}
  local search_list = {}
  local fav_list = {}
  local rem_list = {}
  local fav_exist = 0

  Craftie:Notification("Craftie:UpdateCrafterList()", Craftie.CHAT.FUNC)
  Craftie.Frame.ScrollPlayersResults:SetText("")
  Craftie.Frame.ScrollPlayersLoading:Show()
  Craftie.Frame.ScrollPlayersList:SetAlpha(0.3)

  for i=1, Craftie.MAX_CRAFTERS do
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
    if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"] ~= nil) then
      for crafter_name in pairs(CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"][Craftie.Page:upper()]) do
        table.insert(crafter_list, crafter_name)
      end
    end

    search_list = crafter_list

    if (search ~= nil) then
      -- search is going on, redefine the table
      search_list = Craftie:SearchTable(crafter_list, search)
      fav_exist = 0
    else
      --not searching
      if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["FAVS"] ~= nil) then
        if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["FAVS"][Craftie.Page:upper()] ~= nil) then
          --search_list={}
          for k,v in pairs(search_list) do
            if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["FAVS"][Craftie.Page:upper()][v] == 1) then
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

    local results = Craftie.Color.Yellow .. "Crafter(s)"
    Craftie.Frame.ScrollPlayersResults:SetText(#search_list .. " " .. results)

    for n=1, #search_list do
      local i=n+1 --skip the 1st index
      local crafter = Craftie:Split(CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"][Craftie.Page:upper()][search_list[n]], ",")

      --[==[
      --Craftie.Frame.ScrollPlayersListNet[i]:Show()
      if (Craftie.PlayerOnline[search_list[n]] == 1) then
        Craftie.Frame.ScrollPlayersListNet[i]:SetTexture("Interface/FriendsFrame/StatusIcon-Online")
      end
      ]==]--

      Craftie.Frame.ScrollPlayersListName[i]:SetText(search_list[n]) --avoid the 1st row
      Craftie.Frame.ScrollPlayersListFav[i]:Show()

      Craftie.Frame.ScrollPlayersListFav[i]:SetTexCoord(1, 0.5, 0, 0.5)
      if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["FAVS"] ~= nil) then
        if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["FAVS"][Craftie.Page:upper()] ~= nil) then
          if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["FAVS"][Craftie.Page:upper()][search_list[n]] == 1) then
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
  end)

  C_Timer.After(0.1, function()
    Craftie.Frame.ScrollPlayersLoading:Hide()
    Craftie.Frame.ScrollPlayersList:SetAlpha(1)
    --Craftie.Frame.ScrollPlayersList.Child:SetSelected(1)
    --Craftie.Frame.ScrollPlayersList.Child:SetVerticalScroll(20)
  end)

  --if (Craftie.DEBUGLEVEL > 3) then
    --Craftie.Frame.ScrollPlayersListName[1]:SetText("All " .. Craftie.Page .. " Recipes")
    Craftie.Frame.ScrollPlayersListName[1]:SetText(Craftie.Page .. " Library")
    --Craftie.Frame.ScrollPlayersListFav[1]:SetTexture("Interface/WorldMap/UI-World-Icon")
    Craftie.Frame.ScrollPlayersListFav[1]:SetPoint("TOPLEFT", 4, -3)
    Craftie.Frame.ScrollPlayersListFav[1]:SetTexture("Interface/ICONS/" .. Craftie.Professions[Craftie.Tab][2])
    Craftie.Frame.ScrollPlayersListFav[1]:SetTexCoord(0, 1, 0, 1)
    --Craftie.Frame.ScrollPlayersListFav[1]:SetAlpha(0.7)
    Craftie.Frame.ScrollPlayersListFav[1]:SetDesaturation(0.6)
    Craftie.Frame.ScrollPlayersListFav[1]:Show()
    Craftie.Frame.ScrollPlayersListNet[1]:Hide()
  --else
    --Craftie.Frame.ScrollPlayersListCont[1]:Hide()
  --end
end

function Craftie:TabSelectSide(tab, sound)
  if (Craftie.Tab ~= tab) then
    local prof_name = Craftie.Professions[tab][1]
    Craftie:CloseAllPlayerMenus()
    Craftie:ClearSearchFocus(true)
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

    Craftie.Tab = tab
    Craftie.Selected_Name = ""
    Craftie.Page = prof_name
    Craftie.ProfessionDefault = Craftie.Profession[prof_name]
    Craftie.Frame.CraftBackTopArt:SetTexture(Craftie._G.Path .. "Images/professionbackgroundart" .. prof_name:lower() .. ".png")

    C_Timer.After(0.1, function() --give it time to register
      Craftie:OpenProfessionList(Craftie.ProfessionDefault, "", "")
      Craftie:UpdateCrafterList()
      Craftie.Frame.DropdownRecipes.text:SetText(Craftie.MenuSelRecipes[1])
      Craftie.MenuSelRecipes[2] = nil
    end)

    Craftie.Selected_Player_Index = 1
    Craftie:SelectScrollItem("Players")
    Craftie.Frame.ScrollPlayersList.Child:SetVerticalScroll(1) --go to top

    Craftie.Selected_Recipe_Index = 1
    Craftie:SelectScrollItem("Recipes")
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

function Craftie:SendPacket(prefix, data, channel, target)
  local repack = prefix .. "," .. Craftie._G.Version .. "," .. data
  local packet = Craftie:Split(data, ",")

  C_ChatInfo.RegisterAddonMessagePrefix(Craftie._G.Prefix)
  if (prefix == Craftie.Packet.Prefix.Data) then
    -- senderPrefix, senderVer, senderName, senderClass, profNum, profLevel, profData, profMastery
    repack = prefix .. "," .. Craftie._G.Version .. "," .. packet[1] .. "," .. packet[2] .. "," .. packet[3] .. "," .. packet[4] .. "," .. Craftie:BitCompression(packet[5], false) .. "," .. packet[6]
  end

  if (channel == "WHISPER") then
  	C_ChatInfo.SendAddonMessage(Craftie._G.Prefix, repack, channel, target)
    Craftie:Notification(repack .. " [" .. #repack .. "] -> " .. target, Craftie.CHAT.SEND)
  else
    C_ChatInfo.SendAddonMessage(Craftie._G.Prefix, repack, channel)
    Craftie:Notification(repack .. " [" .. #repack .. "] -> " .. channel, Craftie.CHAT.SEND)
  end

  --Craftie:Notification("Prefix: " .. prefix, Craftie.CHAT.FUNC)
end

Craftie.Notified = 0
function Craftie:VersionControl(version)
  --control if someone is behind a major version, only warn for minor version differences
  local stable_version = true

  --minor version difference
  if (version > tonumber(Craftie._G.Version)) then
    if (Craftie.Notified ~= 1) then --dont spam the requester
      Craftie:Notification("You have an outdated version [" .. Craftie._G.Version .. "] of [" .. version .. "]", Craftie.CHAT.ERROR)
    end
    stable_version = false
    Craftie.Notified = 1
  end

  --major version difference
  if (version < tonumber(Craftie._G.Version)) then
    if (version < tonumber(Craftie._G.Version) - 0.01) then --version is drastically outdated by 2 minor versions, do not pull data
      Craftie:Notification("Crafter has an outdated version [" .. version .. "] of [" .. Craftie._G.Version .. "]", Craftie.CHAT.ERROR)
      stable_version = false
    else
      Craftie:Notification("Crafter has an outdated version [" .. version .. "] of [" .. Craftie._G.Version .. "]", Craftie.CHAT.WARN)
      stable_version = true
    end
  end
  return stable_version
end

function Craftie:ParsePacket(netpacket)
  local prefix = ""
  local version = 0

  if (string.sub(netpacket, 1, 1) == "!") then
    local packet = Craftie:Split(netpacket, ",")

    prefix  = packet[1]
    version = tonumber(packet[2])

    Craftie:Notification(netpacket, Craftie.CHAT.ACK)

    --ping another crafter for their data
    if (prefix == Craftie.Packet.Prefix.Ping) then
      local requester = packet[3]
      local profPack = packet[4]
      local profParse = Craftie:Split(profPack, "|")
      local profName = profParse[1]
      local profData = ""

      if ((requester ~= Craftie.Player.Name) or (Craftie.DEBUGLEVEL >= 3)) then
        Craftie:Notification("You were pinged by " .. requester .. " for " .. profName, Craftie.CHAT.ACK)
        --get my saved prof data and send it
        if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"][profName:upper()] ~= nil) then
          if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"][profName:upper()][Craftie.Player.Name] ~= nil) then
            profData = CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"][profName:upper()][Craftie.Player.Name]
            if (profData ~= "") then
              Craftie:SendPacket(Craftie.Packet.Prefix.Data, Craftie.Player.Name .. "," .. profData, "WHISPER", requester)
            end
          end
        else
          Craftie:Notification("You were pinged by " .. requester .. " for " .. profName .. " and you have outdated data!", Craftie.CHAT.WARN)
        end
      else
        --rather than a break, just ignore
        Craftie:Notification("Requester == Self. Ignoring", Craftie.CHAT.ACK)
      end
    end

    --handshake, get the other crafters data and store it
    --similar to Craftie:CrafterBuildData
    if (Craftie:VersionControl(version)) then
      if (prefix == Craftie.Packet.Prefix.Data) then
        local crafterName = packet[3]
        local crafterClass = packet[4]
        local profName  = Craftie.Professions[tonumber(packet[5])][1]
        local profNum   = packet[5]
        local profLevel = packet[6]
        local crafterData = Craftie:BitCompression(packet[7], Craftie.CHAT.ACK) --decompress
        local profMastery = packet[8]
        Craftie:Notification("Receiving Data:|n" .. crafterName .. "|" .. profName .. "|n" .. crafterData .. "," .. profMastery, Craftie.CHAT.ACK)
        --store it
        Craftie.Packet.ACK[crafterName] = 1 --got an ack
        Craftie.PlayerOnline[crafterName] = 1
        local profString = crafterClass .. "," .. profNum .. "," .. profLevel .. "," .. crafterData .. "," .. profMastery .. "," .. Craftie.Date
        Craftie:Notification(profString, Craftie.CHAT.SAVE)
        CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"][profName:upper()][crafterName] = profString
      end
    end

    --receiving tooltip info from players locally
    if (prefix == Craftie.Packet.Prefix.Info) then
      --print(netpacket)
      if (packet[4] ~= nil) then
        local crafter = packet[3]
        local craftData = Craftie:Split(packet[4], ";")
        --local tooltip={}
        local a={}
        local b={}
        local c={}
        Craftie.PlayerGUIDProf[crafter]={}
        if (craftData[1] ~= "") then
          a = Craftie:Split(craftData[1], ":")
          --table.insert(tooltip, {prof1=p[1], prof1L=p[2]})
          Craftie.PlayerGUIDProf[crafter]={profN1=a[1], profL1=a[2], profM1=tonumber(a[3])}
        end
        if (craftData[2] ~= "") then
          b = Craftie:Split(craftData[2], ":")
          --table.insert(tooltip, {prof2=p[1], prof2L=p[2]})
          Craftie.PlayerGUIDProf[crafter]={profN1=a[1], profL1=a[2], profM1=tonumber(a[3]), profN2=b[1], profL2=b[2], profM2=tonumber(b[3])}
        end
        if (craftData[3] ~= "") then
          c = Craftie:Split(craftData[3], ":")
          --table.insert(tooltip, {prof3=p[1], prof3L=p[2]})
          Craftie.PlayerGUIDProf[crafter]={profN1=a[1], profL1=a[2], profM1=tonumber(a[3]), profN2=b[1], profL2=b[2], profM2=tonumber(b[3]), profN3=c[1], profL3=c[2], profM3=tonumber(b[3])}
        end
        --Craftie.PlayerGUIDProf[crafter] = tooltip
      end
    end

    --online
    if (prefix == Craftie.Packet.Prefix.Net) then
      --print(packet[3] .. " | " .. packet[4])
      if ((packet[3] ~= nil) and (packet[4] ~= nil)) then
        Craftie.PlayerOnline[packet[3]] = 1
        Craftie:Notification("Online Ping Status: " .. packet[3], Craftie.CHAT.ACK)
      end
    end

    if (prefix == Craftie.Packet.Prefix.Order) then
      --print(packet[3] .. " | " .. packet[4])
      if ((packet[3] ~= nil) and (packet[5] ~= nil)) then
        if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["ORDER"] == nil) then
          CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["ORDER"] = {}
        end
        C_Timer.After(0.1, function()
          CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["ORDER"][packet[3]] = packet[4] .. "," .. packet[5] .. "," .. packet[6] .. "," .. Craftie.Date
        end)
        C_Timer.After(0.2, function()
          Craftie:Notification("Order From: " .. packet[3] .. "," .. packet[5], Craftie.CHAT.FUNC)
          Craftie:GetCraftOrders()
        end)
      end
    end

  else
    Craftie:Notification("Malformed Packet [Version Mismatch]: " .. netpacket, Craftie.CHAT.ERROR)
  end
  --Craftie:Notification("Malformed Packet [Bad Prefix]: " .. netpacket, Craftie.CHAT.ERROR)
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
            Craftie:Notification("Missing Reagent Precache: " .. "[" .. item[5][i][1] .. "] " .. name[i], Craftie.CHAT.WARN)
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

  local prof_list = Craftie:GetKeyFromValue(Craftie.Professions, Craftie.Page, 1)
  local prof_color = Craftie:Split(Craftie.Professions[prof_list][3], ",")
  Craftie.Frame.Item.SkillIcon:SetTexture("Interface/Icons/" .. Craftie.Professions[prof_list][2])
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

function Craftie:SelectScrollItem(scrollFrame)
  if (Craftie.EnableScrollFrames) then
    if (scrollFrame == "Players") then
      for i=1, Craftie.MAX_CRAFTERS do
        Craftie.Frame.ScrollPlayersListCont[i]:SetBackdropColor(1, 1, 1, 0)
        Craftie.Frame.ScrollPlayersListSelect[i]:Hide()
        Craftie.Frame.ScrollPlayersListName[i]:SetTextColor(1, 1, 1, 0.8)
      end
      Craftie.Frame.ScrollPlayersListSelect[Craftie.Selected_Player_Index]:Show()
      Craftie.Frame.ScrollPlayersListName[Craftie.Selected_Player_Index]:SetTextColor(1, 1, 0.8, 1)
    end
    if (scrollFrame == "Recipes") then
      for i=1, Craftie.MAX_RECIPES do
        Craftie.Frame.ScrollRecipesListRow[i]:SetBackdropColor(1, 1, 1, 0)
        Craftie.Frame.ScrollRecipesListSelect[i]:Hide()
        --Craftie.Frame.ScrollRecipesListSelectSpark[i]:Hide()
        Craftie.Frame.ScrollRecipesListName[i]:SetTextColor(1, 1, 1, 0.8)
      end
      Craftie.Frame.ScrollRecipesListSelect[Craftie.Selected_Recipe_Index]:Show()
      --Craftie.Frame.ScrollRecipesListSelectSpark[Craftie.Selected_Recipe_Index]:Show()
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
    Craftie:SortTableByString(Craftie.Profession[v[1]])
  end
end

Craftie.ProfileBuilt = {} --need to reset when learning a new recipe
function Craftie:ResetCrafterBuild()
  --clear all profession flags
  for k,v in pairs(Craftie.Professions) do
    Craftie.ProfileBuilt[v[1]] = 0
  end
  Craftie:Notification("Craftie:ResetCrafterBuild()", Craftie.CHAT.FUNC)
end

--Craftie.Throttle.Prof.Flag
--build personal string, store it, and use for packets and notifications
function Craftie:CrafterBuildData(profName, profLevel)
  local profBuild = Craftie:CopyTable(Craftie.Profession[profName])
  --Craftie:SortTableByString(profBuild) --alpha sort just in case
  local profData={}
  local profString = ""
  local profMastery = 0

  for k,v in pairs(Craftie.Professions) do --use only the prio list, no fishing, first-aid, etc...
    if (profName == v[1]) then
      if (Craftie.ProfileBuilt[profName] == 0) then
        --Craftie:Notification("Craftie:CrafterBuildData", Craftie.CHAT.FUNC)
        C_Timer.After(0.5, function() --give it time to register the profession recipes
          --print(profName)
          for k,v in pairs(profBuild) do
            if (v[2] ~= nil) then
              profData[Craftie:SanitizeString(v[2], true)] = "0" --build the empty binary string
            end
          end

          local mastery = Craftie:GetProfessionMastery(profName)
          if (mastery) then
            profMastery = table.concat(mastery, ", ")
          else
            profMastery = 0
          end
          --print("profMastery: " .. profMastery)

          local numRecipes = GetNumTradeSkills()
          for i = 1, numRecipes do
            local recipeName, recipeType = GetTradeSkillInfo(i)
            if recipeType ~= "header" then
              if (Craftie:SanitizeString(recipeName, true) ~= nil) then
                profData[Craftie:SanitizeString(recipeName, true)] = "1"
                --print(Craftie:SanitizeString(recipeName, true) .. " = 1")
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

          profString = profString .. "," .. profMastery .. "," .. Craftie.Date

          Craftie:Notification("Craftie:CrafterBuildData(" .. profString .. ")", Craftie.CHAT.SAVE)
          CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"][profName:upper()][Craftie.Player.Name] = profString
        end)
      end
      Craftie.ProfileBuilt[profName] = 1 --we already pulled and stored data, reset only on learning a new recipe
    end
  end
  --Craftie:Notification("Craftie:CrafterBuildData", Craftie.CHAT.FUNC)
end

function Craftie:SetProfLevel(level)
  local diff  = 161
  local uimax = 246 --UI Max width
  local calc = 0

  Craftie.Frame.ItemerLevel:Hide()
  Craftie.Frame.ItemerProgBarS:Hide()

  if (level) then
    calc = math.ceil((level * diff) / uimax)
    if (calc >= 1) then
      Craftie.Frame.ItemerLevel:Show()
      --print("level: " .. level .. " | " .. calc .. " [max: " .. uimax .. "]")

      Craftie.Frame.ItemerProgBar:SetSize(calc, 15)
      Craftie.Frame.ItemerProgLevel:SetText(level .. " / " .. Craftie.PROFMAXLEVEL)
      local left = 0
      if (calc < 200) then left = 4 end
      if (calc <= 20) then left = 5 end
      Craftie.Frame.ItemerProgBar:SetPoint("TOPLEFT", 0+left, -5)
      if (level < Craftie.PROFMAXLEVEL) then
        Craftie.Frame.ItemerProgBarS:SetPoint("TOPLEFT", calc-41+left, 16)
        Craftie.Frame.ItemerProgBarS:Show()
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

    local indexer = ""
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
      profMastery=0
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
  Craftie:SetProfLevel(0)
  if (player ~= "") then
    Craftie:Notification("Using [" .. player .. "] Crafting book", Craftie.CHAT.FUNC)
    profCache = Craftie:CrafterDataParse(Craftie.Page, player)
    Craftie.MenuSelRecipes[2] = player
  else
    profCache = Craftie:CopyTable(profArray)
    for i=1, Craftie.MAX_CRAFTERS do
      if (i > 1) then
        Craftie.Frame.ScrollPlayersListCont[i]:Show()
        Craftie.Frame.ScrollPlayersListRow[i]:SetPoint("TOPLEFT", 2, -i*Craftie.Frame.ScrollPlayersListRow[i]:GetHeight()+16)
      end
    end
  end

  if (search ~= "") then
    if (Craftie.Frame.DropdownRecipes.text:GetText() == Craftie.MenuSelRecipes[1]) then
      for i=1, Craftie.MAX_CRAFTERS do
        if (i > 1) then
          Craftie.Frame.ScrollPlayersListCont[i]:Hide()
        end
      end

      print("search everyone within " .. Craftie.Page)
      if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CACHE"][Craftie.Page:upper()] ~= nil) then
        --print("found " .. Craftie.Page)
        for k,v in pairs(CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CACHE"][Craftie.Page:upper()]) do
          local pattern = string.find(string.lower(CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CACHE"][Craftie.Page:upper()][k]), search, 1, true)
          if (pattern) then
            search_all_count = search_all_count +1
            --print(k .. " - " .. pattern)
            for i=1, Craftie.MAX_CRAFTERS do
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
    print("search_all_count " .. search_all_count)
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
      Craftie.Frame.ScrollRecipesListName[i]:SetText("")
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
      Craftie.Frame.ScrollRecipesListName[i]:SetText(profCache[i][2])
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
          Craftie:SelectScrollItem("Recipes")
        end
      end)
      Craftie.Frame.ScrollRecipesListRow[i]:Show()
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

  Craftie:Notification("Craftie:OpenProfessionList(" .. player .. " " .. search .. ")", Craftie.CHAT.FUNC)
end

function Craftie:GetCraftOrders()
  local order_index = 0
  for i=1, Craftie.MAX_ORDERS do
    Craftie.Frame.ScrollOrderListNameButton[i]:Hide()
    Craftie.Frame.ScrollOrderListItemButton[i]:Hide()
  end

  if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["ORDER"] ~= nil) then
    for name,v in pairs(CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["ORDER"]) do
      order_index = order_index +1
      local order = Craftie:Split(v, ",")
      --local class = order[1]
      --print("order_index " .. order_index)
      --print(name .. " | " .. order[1] .. " | " .. order[2])
      Craftie.Frame.ScrollOrderListName[order_index]:SetText(name)
      Craftie.Frame.ScrollOrderListItem[order_index]:SetText(order[2])
      Craftie.Frame.ScrollOrderListCount[order_index]:SetText(order[3])
      Craftie.Frame.ScrollOrderListDate[order_index]:SetText(order[4])
      Craftie.Frame.ScrollOrderListNameButton[order_index]:Show()
      Craftie.Frame.ScrollOrderListItemButton[order_index]:Show()
      --Craftie.myFontString:GetStringWidth()
      Craftie.Frame.ScrollOrderListItemButton[order_index]:SetWidth(20+Craftie.Frame.ScrollOrderListName[order_index]:GetStringWidth()*2)

      local class = tonumber(order[1])
      local r = Craftie.Class[class][3][1]
      local g = Craftie.Class[class][3][2]
      local b = Craftie.Class[class][3][3]
      Craftie.Frame.ScrollOrderListName[order_index]:SetTextColor(r, g, b, 1)
    end
  end
  if (order_index >= 1) then
    Craftie.TabBottom[2].Text:SetText("Orders " .. Craftie.Color.Gold .. "[" .. order_index .. "]")
  end
  Craftie:Notification("Craftie:GetCraftOrders()", Craftie.CHAT.FUNC)
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
      local page = Craftie:GetKeyFromValue(Craftie.Professions, profession, 1)
      Craftie:Notification("Craftie:Open: Go to " .. profession .. " => " .. player, Craftie.CHAT.FUNC)
      Craftie:TabSelectSide(page, true)
      Craftie.Frame:Show()
    end)
  else
    Craftie.Frame:Show()
    Craftie:Notification("Craftie:Opened", Craftie.CHAT.FUNC)
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
  Craftie:Notification("Craftie:BuildReagentGaps()", Craftie.CHAT.FUNC)
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


Craftie.Tooltip.Data = nil
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

      if (channel == "WORLD") then
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

  if data then
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
  local right = _G["CraftieTooltipTextRight"..i]
  local flags = nil

  if left then
    left:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size+1, flags)
  end

  if right then
    right:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size+1, flags)
  end
end
CraftieTooltip:SetBackdropBorderColor(0.82, 0.73, 0.64, 1)
