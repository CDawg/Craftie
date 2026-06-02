--[==[
Copyright ©2020 Porthias of Myzrael or Porthios of Myzrael

The contents of this addon, excluding third-party resources, are
copyrighted to Porthios with all rights reserved.
This addon is free to use and the authors hereby grants you the following rights:
1. You may make modifications to this addon for private use only, you
   may not publicize any portion of this addon.
2. Do not modify the name of this addon, including the addon folders.
3. This copyright notice shall be included in all copies or substantial
  portions of the Software.
All rights not explicitly addressed in this license are reserved by
the copyright holders.
]==]--

Craftie.Frame.ScrollPlayers_Width = 210
Craftie.Frame.ScrollPlayers_Height= Craftie._G.Height-134

Craftie.Frame.ScrollPlayersParent = CreateFrame("Frame", Craftie.Frame.ScrollPlayersParent, Craftie.Frame, "InsetFrameTemplate")
Craftie.Frame.ScrollPlayersParent:SetWidth(Craftie.Frame.ScrollPlayers_Width)
Craftie.Frame.ScrollPlayersParent:SetHeight(Craftie._G.Height-88)
Craftie.Frame.ScrollPlayersParent:SetPoint("TOPLEFT", 2, -61)

--Craftie.Frame.ScrollPlayersParent.Back = Craftie.Frame.ScrollPlayersParent:CreateTexture(nil, "BACKGROUND")
--Craftie.Frame.ScrollPlayersParent.Back:SetSize(Craftie.Frame.ScrollPlayersParent:GetWidth()-20, Craftie.Frame.ScrollPlayersParent:GetHeight())
--Craftie.Frame.ScrollPlayersParent.Back:SetPoint("TOPLEFT", 0, 0)
--Craftie.Frame.ScrollPlayersParent.Back:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Background-Players.png")

Craftie.Frame.ScrollPlayersList = CreateFrame("Frame", Craftie.Frame.ScrollPlayersList, Craftie.Frame.ScrollPlayersParent, "BackdropTemplate")
Craftie.Frame.ScrollPlayersList:SetWidth(Craftie.Frame.ScrollPlayers_Width-10)
Craftie.Frame.ScrollPlayersList:SetHeight(Craftie.Frame.ScrollPlayers_Height+20)
Craftie.Frame.ScrollPlayersList:SetPoint("CENTER", 2, 6)

Craftie.Frame.ScrollPlayersList.Child = CreateFrame("ScrollFrame", Craftie.Frame.ScrollPlayersList.Child, Craftie.Frame.ScrollPlayersList, "UIPanelScrollFrameTemplate")
Craftie.Frame.ScrollPlayersList.Child:SetPoint("TOPLEFT", Craftie.Frame.ScrollPlayersList, "TOPLEFT",         -2,-20)
Craftie.Frame.ScrollPlayersList.Child:SetPoint("BOTTOMRIGHT", Craftie.Frame.ScrollPlayersList, "BOTTOMRIGHT", 14, 10)
Craftie.Frame.ScrollPlayersListChildFrame = CreateFrame("Frame", Craftie.Frame.ScrollPlayersListChildFrame, Craftie.Frame.ScrollPlayersList.Child)
Craftie.Frame.ScrollPlayersListChildFrame:SetSize(Craftie.Frame.ScrollPlayers_Width, Craftie.Frame.ScrollPlayers_Height)
Craftie.Frame.ScrollPlayersList.Child:SetScrollChild(Craftie.Frame.ScrollPlayersListChildFrame)
Craftie.Frame.ScrollPlayersList.Child.ScrollBar:ClearAllPoints()
Craftie.Frame.ScrollPlayersList.Child.ScrollBar:SetPoint("TOPLEFT", Craftie.Frame.ScrollPlayersList.Child, "TOPRIGHT",          0,-10)
Craftie.Frame.ScrollPlayersList.Child.ScrollBar:SetPoint("BOTTOMRIGHT", Craftie.Frame.ScrollPlayersList.Child, "BOTTOMRIGHT", -42, 10)

Craftie.ScrollBarFrame(Craftie.Frame.ScrollPlayersList.Child)

Craftie.Frame.ScrollPlayersResultsFrame = CreateFrame("Frame", Craftie.Frame.ScrollPlayersResultsFrame, Craftie.Frame.ScrollPlayersParent, "BackdropTemplate", 25)
Craftie.Frame.ScrollPlayersResultsFrame:SetWidth(Craftie.Frame.ScrollPlayers_Width-7)
Craftie.Frame.ScrollPlayersResultsFrame:SetHeight(25)
Craftie.Frame.ScrollPlayersResultsFrame:SetPoint("BOTTOMLEFT", 4, 0)
Craftie.Frame.ScrollPlayersResultsFrame:SetFrameLevel(50)
Craftie.Frame.ScrollPlayersResultsBack = Craftie.Frame.ScrollPlayersResultsFrame:CreateTexture(nil, "ARTWORK")
Craftie.Frame.ScrollPlayersResultsBack:SetSize(Craftie.Frame.ScrollPlayersResultsFrame:GetWidth()-1, 32)
Craftie.Frame.ScrollPlayersResultsBack:SetPoint("TOPLEFT", 1, 10)
Craftie.Frame.ScrollPlayersResultsBack:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Dialog-32.png")
Craftie.Frame.ScrollPlayersResultsBack:SetAlpha(0.8)
Craftie.Frame.ScrollPlayersResults = Craftie.Frame.ScrollPlayersResultsFrame:CreateFontString(nil, "ARTWORK")
Craftie.Frame.ScrollPlayersResults:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
Craftie.Frame.ScrollPlayersResults:SetPoint("TOPLEFT", 8, -4)
Craftie.Frame.ScrollPlayersResults:SetText("")

Craftie.Frame.ScrollPlayersLoading = Craftie.Frame.ScrollPlayersParent:CreateFontString(nil, "OVERLAY")
Craftie.Frame.ScrollPlayersLoading:SetFont(Craftie._G.Font.Style, 13, "OUTLINE | SLUG")
Craftie.Frame.ScrollPlayersLoading:SetPoint("CENTER", -2, 40)
Craftie.Frame.ScrollPlayersLoading:SetTextColor(0.9, 0.9, 1, 0.8)
Craftie.Frame.ScrollPlayersLoading:SetText("Loading...")

Craftie.Frame.ScrollPlayersEmpty = Craftie.Frame.ScrollPlayersParent:CreateFontString(nil, "OVERLAY")
Craftie.Frame.ScrollPlayersEmpty:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "OUTLINE | SLUG")
Craftie.Frame.ScrollPlayersEmpty:SetPoint("CENTER", -10, 0)
Craftie.Frame.ScrollPlayersEmpty:SetTextColor(1, 1, 1, 0.8)
Craftie.Frame.ScrollPlayersEmpty:SetText("")
Craftie.Frame.ScrollPlayersEmpty:Hide()

--[==[
SEARCH PLAYERS
]==]--
Craftie.Frame.Search.Players={}
Craftie.Frame.Search.Players = CreateFrame("Frame", nil, Craftie.Frame.ScrollPlayersParent, "BackdropTemplate", 2)
Craftie.Frame.Search.Players:SetWidth(Craftie.Frame.ScrollPlayers_Width-6)
Craftie.Frame.Search.Players:SetHeight(24)
Craftie.Frame.Search.Players:SetPoint("TOPLEFT", 5, -1)
Craftie.Frame.ScrollPlayersResultsFrame:SetFrameLevel(50)

Craftie.Frame.Search.Players.Back = Craftie.Frame.Search.Players:CreateTexture(nil, "BORDER")
Craftie.Frame.Search.Players.Back:SetSize(Craftie.Frame.Search.Players:GetWidth()-1, 28)
Craftie.Frame.Search.Players.Back:SetPoint("TOPLEFT", 0, -2)
Craftie.Frame.Search.Players.Back:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Dialog-32.png")
Craftie.Frame.Search.Players.Back:SetRotation(-math.pi)
--Craftie.Frame.Search.Players.Back:SetAlpha(0.8)

Craftie.Frame.Search.Players.Icon = Craftie.Frame.Search.Players:CreateTexture(nil, "OVERLAY")
Craftie.Frame.Search.Players.Icon:SetSize(18, 18)
Craftie.Frame.Search.Players.Icon:SetPoint("TOPLEFT", 4, -5)
Craftie.Frame.Search.Players.Icon:SetTexture("Interface/COMMON/UI-Searchbox-Icon")
Craftie.Frame.Search.Players.Icon:SetAlpha(0.3)
Craftie.Frame.Search.Players.Text = CreateFrame("EditBox", nil, Craftie.Frame.Search.Players)
Craftie.Frame.Search.Players.Text:SetWidth(Craftie.Frame.Search.Players:GetWidth()-52)
Craftie.Frame.Search.Players.Text:SetHeight(Craftie.Frame.Search.Players:GetHeight())
Craftie.Frame.Search.Players.Text:SetFontObject(GameFontDisable)
Craftie.Frame.Search.Players.Text:SetFont(Craftie._G.Font.Style, 11, "OUTLINE | SLUG")
Craftie.Frame.Search.Players.Text:SetPoint("TOPLEFT", 22, -1)
Craftie.Frame.Search.Players.Text:SetAutoFocus(false)
Craftie.Frame.Search.Players.Text:SetText(Craftie.Placeholder_Players)
Craftie.Frame.Search.Players.Text:SetScript("OnKeyUp", function(self, key)
  if (key == "ENTER") then
    Craftie.ClearFocusAll()
    Craftie.Frame.ScrollPlayersList.Child:SetVerticalScroll(1)
  end
end)
Craftie.Frame.Search.Players.Text:SetScript("OnMouseDown", function(self)
    local search_index = Craftie.Frame.Search.Players.Text:GetText()
    if (search_index == Craftie.Placeholder_Players) then
      Craftie.Frame.Search.Players.Text:SetText("")
      Craftie.Frame.Search.Players.Text:SetFontObject(GameFontWhite)
    end
end)
Craftie.Frame.Search.Players.Text:SetScript("OnEditFocusLost", function(self)
  --Craftie.Frame.Search.Players.Text:SetText(Craftie.Placeholder_Players)
end)
--Craftie.Frame.Button.SearchPlayers = CreateFrame("Button", nil, Craftie.Frame.Search.Players, "UIPanelButtonTemplate")
Craftie.Frame.Button.SearchPlayers = CreateFrame("Button", nil, Craftie.Frame.Search.Players, "BackdropTemplate")
Craftie.Frame.Button.SearchPlayers:SetSize(24, 23)
Craftie.Frame.Button.SearchPlayers:SetPoint("TOPLEFT", Craftie.Frame.Search.Players:GetWidth()-24, -1)
Craftie.Frame.Button.SearchPlayersIcon = Craftie.Frame.Button.SearchPlayers:CreateTexture(nil, "ARTWORK")
Craftie.Frame.Button.SearchPlayersIcon:SetSize(18, 18)
Craftie.Frame.Button.SearchPlayersIcon:SetPoint("CENTER", 0, 0)
Craftie.Frame.Button.SearchPlayersIcon:SetTexture(Craftie._G.Path ..  "Images/UI-Craftie-Button-Search-Clear.png")
Craftie.Frame.Button.SearchPlayersIcon:SetAlpha(0.4)
Craftie.Frame.Button.SearchPlayers:SetScript("OnClick", function(self)
  if (Craftie.EnableScrollFrames) then
    Craftie.Frame.Search.Players.Text:SetText("")
    --Craftie.CloseAllPlayerMenus()
    --Craftie.ClearFocusAll()
    local pageNum = Craftie.GetKeyFromValue(Craftie.Professions, Craftie.Page, 1)
    Craftie.TabSelect(pageNum) --just reset the list
  end
end)
Craftie.Frame.Button.SearchPlayers:SetScript("OnEnter", function(self)
  Craftie.Frame.Button.SearchPlayersIcon:SetAlpha(0.8)
end)
Craftie.Frame.Button.SearchPlayers:SetScript("OnLeave", function(self)
  Craftie.Frame.Button.SearchPlayersIcon:SetAlpha(0.4)
end)
Craftie.Frame.Search.Players.Text:SetScript("OnKeyUp", function(self, key)
  if (key == "ENTER") then
    --local search_array = Craftie.ProfessionDefault --what player is selected?
    local search_index = self:GetText()
    if (search_index ~= "") then
      print(search_index)
      Craftie.UpdateCrafterList(search_index)
    end
    --if (Craftie.Selected_Name ~= "") then
      --Craftie.OpenProfessionList(search_array, search_index, Craftie.Selected_Name)
    --else
      --Craftie.OpenProfessionList(search_array, search_index, "")
    --end
    --Craftie.Frame.ScrollRecipesList.Child:SetVerticalScroll(1)
  end
end)

Craftie.Frame.ScrollPlayersListItem={}
Craftie.Frame.ScrollPlayersListBack={}
Craftie.Frame.ScrollPlayersListName={}
Craftie.Frame.ScrollPlayersListSelect={}
Craftie.Frame.ScrollPlayersListFav={}
Craftie.Frame.ScrollPlayersListNet={}

Craftie.Frame.ScrollPlayersListOpt={}
Craftie.Frame.ScrollPlayersListOpt.Back={}
Craftie.Frame.ScrollPlayersListOpt.HL={}
Craftie.Frame.ScrollPlayersListOpt.Menu={}

for i=1, Craftie.MAX_PLAYERS do
  Craftie.Frame.ScrollPlayersListItem[i] = CreateFrame("Button", Craftie.Frame.ScrollPlayersListItem[i], Craftie.Frame.ScrollPlayersListChildFrame, "BackdropTemplate", -1)
  Craftie.Frame.ScrollPlayersListItem[i]:SetWidth(Craftie.Frame.ScrollPlayers_Width-26) --scrollbar size
  Craftie.Frame.ScrollPlayersListItem[i]:SetHeight(20)
  Craftie.Frame.ScrollPlayersListItem[i]:SetPoint("TOPLEFT", 2, -i*Craftie.Frame.ScrollPlayersListItem[i]:GetHeight())
  Craftie.Frame.ScrollPlayersListItem[i]:SetBackdrop(Craftie.Backdrop.Borderless)
  Craftie.Frame.ScrollPlayersListItem[i]:SetBackdropBorderColor(1, 1, 1, 0)
  Craftie.Frame.ScrollPlayersListItem[i]:SetFrameLevel(Craftie.Framelevel.Background)

  Craftie.Frame.ScrollPlayersListBack[i] = Craftie.Frame.ScrollPlayersListItem[i]:CreateTexture(nil, "BACKGROUND")
  Craftie.Frame.ScrollPlayersListBack[i]:SetSize(Craftie.Frame.ScrollPlayersListItem[i]:GetWidth(), 20)
  Craftie.Frame.ScrollPlayersListBack[i]:SetPoint("TOPLEFT", 0, 0)
  Craftie.Frame.ScrollPlayersListBack[i]:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Background-Row1.png")
  Craftie.Frame.ScrollPlayersListBack[i]:SetAlpha(0.5)

  Craftie.Frame.ScrollPlayersListName[i] = Craftie.Frame.ScrollPlayersListItem[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.ScrollPlayersListName[i]:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
  Craftie.Frame.ScrollPlayersListName[i]:SetPoint("TOPLEFT", 20, -5)
  --Craftie.Frame.ScrollPlayersListName[i]:SetText("Player_" .. i)
  Craftie.Frame.ScrollPlayersListName[i]:SetText("")
  Craftie.Frame.ScrollPlayersListName[i]:SetTextColor(1, 1, 1, 0.8)
  Craftie.Frame.ScrollPlayersListSelect[i] = Craftie.Frame.ScrollPlayersListItem[i]:CreateTexture(nil, "BACKGROUND")
  Craftie.Frame.ScrollPlayersListSelect[i]:SetSize(Craftie.Frame.ScrollPlayersListItem[i]:GetWidth()-4, Craftie.Frame.ScrollPlayersListItem[i]:GetHeight())
  Craftie.Frame.ScrollPlayersListSelect[i]:SetPoint("CENTER", 0, 0)
  Craftie.Frame.ScrollPlayersListSelect[i]:SetTexture("Interface/WORLDSTATEFRAME/WORLDSTATEFINALSCORE-HIGHLIGHT")
  Craftie.Frame.ScrollPlayersListSelect[i]:SetBlendMode("ADD")
  Craftie.Frame.ScrollPlayersListSelect[i]:SetVertexColor(0.50, 0.75, 1)
  Craftie.Frame.ScrollPlayersListSelect[i]:SetAlpha(0.6)
  Craftie.Frame.ScrollPlayersListSelect[i]:Hide()

  Craftie.Frame.ScrollPlayersListNet[i] = Craftie.Frame.ScrollPlayersListItem[i]:CreateTexture(nil, "ARTWORK")
  Craftie.Frame.ScrollPlayersListNet[i]:SetSize(8, 8)
  Craftie.Frame.ScrollPlayersListNet[i]:SetPoint("TOPLEFT", 18, -6)
  Craftie.Frame.ScrollPlayersListNet[i]:SetTexture("Interface/FriendsFrame/StatusIcon-Offline")
  Craftie.Frame.ScrollPlayersListNet[i]:Hide()

  Craftie.Frame.ScrollPlayersListFav[i] = Craftie.Frame.ScrollPlayersListItem[i]:CreateTexture(nil, "ARTWORK")
  Craftie.Frame.ScrollPlayersListFav[i]:SetSize(14, 14)
  Craftie.Frame.ScrollPlayersListFav[i]:SetPoint("TOPLEFT", 5, -2)
  Craftie.Frame.ScrollPlayersListFav[i]:SetTexture("Interface/COMMON/ReputationStar")
  --Craftie.Frame.ScrollPlayersListFav[i]:SetTexCoord(0, 0.5, 0, 0.5) --on
  Craftie.Frame.ScrollPlayersListFav[i]:SetTexCoord(1, 0.5, 0, 0.5)
  Craftie.Frame.ScrollPlayersListFav[i]:Hide()

  Craftie.Frame.ScrollPlayersListOpt[i] = CreateFrame("Button", nil, Craftie.Frame.ScrollPlayersListItem[i], "BackdropTemplate", 1)
  Craftie.Frame.ScrollPlayersListOpt[i]:SetSize(22, 22)
  Craftie.Frame.ScrollPlayersListOpt[i]:SetPoint("TOPLEFT", 154, 0)
  Craftie.Frame.ScrollPlayersListOpt[i]:Hide()
  Craftie.Frame.ScrollPlayersListOpt.Back[i] = Craftie.Frame.ScrollPlayersListOpt[i]:CreateTexture(nil, "ARTWORK")
  Craftie.Frame.ScrollPlayersListOpt.Back[i]:SetSize(20, 20)
  Craftie.Frame.ScrollPlayersListOpt.Back[i]:SetPoint("CENTER", 0, 0)
  Craftie.Frame.ScrollPlayersListOpt.Back[i]:SetTexture("Interface/FriendsFrame/UI-FriendsList-Small-Up")
  Craftie.Frame.ScrollPlayersListOpt.Back[i]:SetDesaturation(1)
  Craftie.Frame.ScrollPlayersListOpt.Back[i]:SetVertexColor(0.80, 0.90, 1)
  Craftie.Frame.ScrollPlayersListOpt.HL[i] = Craftie.Frame.ScrollPlayersListOpt[i]:CreateTexture(nil, "ARTWORK")
  Craftie.Frame.ScrollPlayersListOpt.HL[i]:SetSize(22, 22)
  Craftie.Frame.ScrollPlayersListOpt.HL[i]:SetPoint("CENTER", 0, 0)
  Craftie.Frame.ScrollPlayersListOpt.HL[i]:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Button-HL-Blue.png")
  Craftie.Frame.ScrollPlayersListOpt.HL[i]:SetBlendMode("ADD")
  Craftie.Frame.ScrollPlayersListOpt.HL[i]:Hide()
  Craftie.Frame.ScrollPlayersListOpt[i]:SetScript("OnEnter", function(self)
    if (Craftie.EnableScrollFrames) then
      if (Craftie.Frame.ScrollPlayersListName[i]:GetText() ~= nil) then
        self:Show()
      end
      Craftie.Frame.ScrollPlayersListOpt.HL[i]:Show()
    end
  end)
  Craftie.Frame.ScrollPlayersListOpt[i]:SetScript("OnLeave", function(self)
    Craftie.Frame.ScrollPlayersListOpt.HL[i]:Hide()
  end)

  if (i % 2 == 0) then
    Craftie.Frame.ScrollPlayersListBack[i]:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Background-Row2.png")
  end
  if (i % 4 == 0) then
    Craftie.Frame.ScrollPlayersListBack[i]:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Background-Row4.png")
  end
  Craftie.Frame.ScrollPlayersListItem[i]:SetScript("OnEnter", function(self)
    if (Craftie.EnableScrollFrames) then
      self:SetBackdropColor(0.8, 0.85, 1, 0.2)
    end
  end)
  Craftie.Frame.ScrollPlayersListItem[i]:SetScript("OnLeave", function(self)
    if (Craftie.EnableScrollFrames) then
      self:SetBackdropColor(0.8, 0.85, 1, 0)
      GameTooltip:Hide()
      Craftie.SelectScrollItem("Players")
    end
  end)
  --show the options
  Craftie.Frame.ScrollPlayersListItem[i]:SetScript("OnClick", function(self)
    Craftie.CloseAllPlayerMenus()
    if (Craftie.EnableScrollFrames) then
      if (Craftie.Frame.ScrollPlayersListName[i]:GetText() ~= nil) then
        Craftie.SelectCrafter(i, Craftie.Frame.ScrollPlayersListName[i]:GetText())
        if (i > 1) then
          Craftie.Frame.ScrollPlayersListOpt[i]:Show()
        end
      end
    end
  end)

  Craftie.Frame.ScrollPlayersListOpt[i]:SetScript("OnClick", function(self)
    self:Hide()
    --open the sub menu
    --temporarily disable the scrolling
    Craftie.CloseAllPlayerMenus()
    Craftie.ScrollBarDisable()

    local crafter = Craftie.Frame.ScrollPlayersListName[i]:GetText()
    if (crafter ~= nil) then
      Craftie.Frame.ScrollPlayersListOpt.Menu:Show()
      local point, relativeTo, relativePoint, xOfs, yOfs = Craftie.Frame.ScrollPlayersListItem[i]:GetPoint()
      --Craftie.Frame.ScrollPlayersListOpt.Menu[i]:SetPoint("TOPLEFT", xOfs, yOfs)
      Craftie.Frame.ScrollPlayersListOpt.Menu:SetPoint(point, relativeTo, relativePoint, xOfs+150, yOfs)
      Craftie.Notification("Sub Menu: [" .. crafter .. "][" .. Craftie.Page .. "]", Craftie.TYPE.FUNC)
      --CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CRAFTERS"][Craftie.Page:upper()][crafter] = nil
    end
  end)
end

Craftie.Frame.ScrollPlayersListOpt.Menu = CreateFrame("Frame", Craftie.Frame.ScrollPlayersListOpt.Menu, Craftie.Frame.ScrollPlayers, "BackdropTemplate")
Craftie.Frame.ScrollPlayersListOpt.Menu:SetWidth(150)
Craftie.Frame.ScrollPlayersListOpt.Menu:SetHeight(150)
Craftie.Frame.ScrollPlayersListOpt.Menu:SetPoint("TOPLEFT", 0, 0)
Craftie.Frame.ScrollPlayersListOpt.Menu:SetBackdrop(Craftie.Backdrop.General)
Craftie.Frame.ScrollPlayersListOpt.Menu:SetBackdropColor(0, 0, 0, 1) --shade
Craftie.Frame.ScrollPlayersListOpt.Menu:SetBackdropBorderColor(1, 1, 1, 0.5)
Craftie.Frame.ScrollPlayersListOpt.Menu:SetFrameLevel(300)
Craftie.Frame.ScrollPlayersListOpt.Menu:SetFrameStrata("HIGH")
Craftie.Frame.ScrollPlayersListOpt.Menu:SetToplevel(true)
Craftie.Frame.ScrollPlayersListOpt.Menu:Hide()


function Craftie.ScrollBarDisable()
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

--this also goes to the player scroll item
function Craftie.GetCrafterIndex(player)
  C_Timer.After(0.1, function() --give the update time to create cached tables
    for i=1, Craftie.MAX_PLAYERS do
      if (player == Craftie.Frame.ScrollPlayersListName[i]:GetText()) then
        --print(player .. " index = " .. i)
        Craftie.SelectCrafter(i, player)
      end
    end
  end)
end

function Craftie.SelectCrafter(index, name)
  Craftie.ClearFocusAll()
  Craftie.Selected_Name = ""
  Craftie.Selected_Players = 1 --always one at first

  if (index == 1) then
    if (Craftie.Frame.Search.Recipes.Text:GetText() ~= Craftie.Placeholder_Recipes) then
      Craftie.OpenProfessionList(Craftie.ProfessionDefault, Craftie.Frame.Search.Recipes.Text:GetText(), "") --pull all
    else
      Craftie.OpenProfessionList(Craftie.ProfessionDefault, "", "") --pull all
    end
  else
    if (name ~= nil) then
      --print(name)
      Craftie.Selected_Players = index
      Craftie.Selected_Name = name
      Craftie.Notification("Craftie.SelectCrafter(" .. index .. ", " .. name .. ")", Craftie.TYPE.FUNC)
      if (Craftie.Frame.Search.Recipes.Text:GetText() ~= Craftie.Placeholder_Recipes) then
        Craftie.OpenProfessionList(Craftie.Profession[Craftie.Page], Craftie.Frame.Search.Recipes.Text:GetText(), name)
      else
        Craftie.OpenProfessionList(Craftie.Profession[Craftie.Page], "", name)
      end
    end
  end
  Craftie.SelectScrollItem("Players") --highlight

  PlaySound(SOUNDKIT.IG_QUEST_LOG_OPEN)
end

function Craftie.UpdateCrafterList(search)
  local crafter_list = {}
  local search_list = {}
  Craftie.Notification("Craftie.UpdateCrafterList()", Craftie.TYPE.FUNC)
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
      --Craftie.SortTableByMatch(crafter_list, search)
      --local matches = Craftie.SearchTable(crafter_list, search)
      search_list = Craftie.SearchTable(crafter_list, search)
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
