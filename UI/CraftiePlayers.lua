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

Craftie.Frame.ScrollPlayers_Width = 208
Craftie.Frame.ScrollPlayers_Height= Craftie._G.Height-134

Craftie.Frame.ScrollPlayersParent = CreateFrame("Frame", "Craftie.Frame.ScrollPlayersParent", Craftie.Frame, "InsetFrameTemplate")
Craftie.Frame.ScrollPlayersParent:SetWidth(Craftie.Frame.ScrollPlayers_Width)
Craftie.Frame.ScrollPlayersParent:SetHeight(Craftie._G.Height-88)
Craftie.Frame.ScrollPlayersParent:SetPoint("TOPLEFT", 4, -62)
Craftie.Frame.ScrollPlayersParent:SetFrameStrata("MEDIUM")

--Craftie.Frame.ScrollPlayersParent.Back = Craftie.Frame.ScrollPlayersParent:CreateTexture(nil, "BACKGROUND")
--Craftie.Frame.ScrollPlayersParent.Back:SetSize(Craftie.Frame.ScrollPlayersParent:GetWidth()-20, Craftie.Frame.ScrollPlayersParent:GetHeight())
--Craftie.Frame.ScrollPlayersParent.Back:SetPoint("TOPLEFT", 0, 0)
--Craftie.Frame.ScrollPlayersParent.Back:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Background-Players.png")

Craftie.Frame.ScrollPlayersList = CreateFrame("Frame", "Craftie.Frame.ScrollPlayersList", Craftie.Frame.ScrollPlayersParent, "BackdropTemplate")
Craftie.Frame.ScrollPlayersList:SetWidth(Craftie.Frame.ScrollPlayers_Width-10)
Craftie.Frame.ScrollPlayersList:SetHeight(Craftie.Frame.ScrollPlayers_Height+20)
Craftie.Frame.ScrollPlayersList:SetPoint("CENTER", 2, 6)

Craftie.Frame.ScrollPlayersList.Child = CreateFrame("ScrollFrame", Craftie.Frame.ScrollPlayersList.Child, Craftie.Frame.ScrollPlayersList, "UIPanelScrollFrameTemplate")
Craftie.Frame.ScrollPlayersList.Child:SetPoint("TOPLEFT", Craftie.Frame.ScrollPlayersList, "TOPLEFT",         -2,-20)
Craftie.Frame.ScrollPlayersList.Child:SetPoint("BOTTOMRIGHT", Craftie.Frame.ScrollPlayersList, "BOTTOMRIGHT", 14, 10)
Craftie.Frame.ScrollPlayersListChildFrame = CreateFrame("Frame", "Craftie.Frame.ScrollPlayersListChildFrame", Craftie.Frame.ScrollPlayersList.Child)
Craftie.Frame.ScrollPlayersListChildFrame:SetSize(Craftie.Frame.ScrollPlayers_Width, Craftie.Frame.ScrollPlayers_Height)
Craftie.Frame.ScrollPlayersList.Child:SetScrollChild(Craftie.Frame.ScrollPlayersListChildFrame)
Craftie.Frame.ScrollPlayersList.Child.ScrollBar:ClearAllPoints()
Craftie.Frame.ScrollPlayersList.Child.ScrollBar:SetPoint("TOPLEFT", Craftie.Frame.ScrollPlayersList.Child, "TOPRIGHT",          0,-10)
Craftie.Frame.ScrollPlayersList.Child.ScrollBar:SetPoint("BOTTOMRIGHT", Craftie.Frame.ScrollPlayersList.Child, "BOTTOMRIGHT", -42, 10)

Craftie:ScrollBarFrame(Craftie.Frame.ScrollPlayersList.Child)

Craftie.Frame.ScrollPlayersResultsFrame = CreateFrame("Frame", "Craftie.Frame.ScrollPlayersResultsFrame", Craftie.Frame.ScrollPlayersParent, "BackdropTemplate", 25)
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
Craftie.Frame.ScrollPlayersResults:SetFont(Craftie._G.Font.StyleN, Craftie._G.Font.Size+2, "SLUG")
Craftie.Frame.ScrollPlayersResults:SetPoint("TOPLEFT", 8, -4)
Craftie.Frame.ScrollPlayersResults:SetText("")

Craftie.Frame.ScrollPlayersLoading = Craftie.Frame.ScrollPlayersParent:CreateFontString(nil, "OVERLAY")
Craftie.Frame.ScrollPlayersLoading:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size+2, "OUTLINE | SLUG")
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
Craftie.Frame.Search.Players = CreateFrame("Frame", "Craftie.Frame.Search.Players", Craftie.Frame.ScrollPlayersParent, "BackdropTemplate", 2)
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
Craftie.Frame.Search.Players.Text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "OUTLINE | SLUG")
Craftie.Frame.Search.Players.Text:SetPoint("TOPLEFT", 22, -1)
Craftie.Frame.Search.Players.Text:SetAutoFocus(false)
Craftie.Frame.Search.Players.Text:SetText(Craftie.Placeholder_Players)
Craftie.Frame.Search.Players.Text:SetScript("OnKeyUp", function(self, key)
  if (key == "ENTER") then
    Craftie:ClearSearchFocus()
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
Craftie.Frame.Button.SearchPlayersClear = CreateFrame("Button", nil, Craftie.Frame.Search.Players, "BackdropTemplate")
Craftie.Frame.Button.SearchPlayersClear:SetSize(24, 23)
Craftie.Frame.Button.SearchPlayersClear:SetPoint("TOPLEFT", Craftie.Frame.Search.Players:GetWidth()-24, -1)
Craftie.Frame.Button.SearchPlayersClearIcon = Craftie.Frame.Button.SearchPlayersClear:CreateTexture(nil, "ARTWORK")
Craftie.Frame.Button.SearchPlayersClearIcon:SetSize(18, 18)
Craftie.Frame.Button.SearchPlayersClearIcon:SetPoint("CENTER", 0, 0)
Craftie.Frame.Button.SearchPlayersClearIcon:SetTexture(Craftie._G.Path ..  "Images/UI-Craftie-Button-Search-Clear.png")
Craftie.Frame.Button.SearchPlayersClearIcon:SetAlpha(0.4)
Craftie.Frame.Button.SearchPlayersClear:SetScript("OnClick", function(self)
  if (Craftie.EnableScrollFrames) then
    Craftie.Frame.Search.Players.Text:SetText("")
    local pageNum = Craftie:GetKeyFromValue(Craftie.Professions, Craftie.Page, 1)
    Craftie:TabSelect(pageNum) --just reset the list
  end
end)
Craftie.Frame.Button.SearchPlayersClear:SetScript("OnEnter", function(self)
  Craftie.Frame.Button.SearchPlayersClearIcon:SetAlpha(0.8)
end)
Craftie.Frame.Button.SearchPlayersClear:SetScript("OnLeave", function(self)
  Craftie.Frame.Button.SearchPlayersClearIcon:SetAlpha(0.4)
end)
Craftie.Frame.Search.Players.Text:SetScript("OnKeyUp", function(self, key)
  if (key == "ENTER") then
    --local search_array = Craftie.ProfessionDefault --what player is selected?
    local search_index = self:GetText()
    if (search_index ~= "") then
      print(search_index)
      Craftie:UpdateCrafterList(search_index)
    end
  end
end)

Craftie.Frame.ScrollPlayersListItem={}
Craftie.Frame.ScrollPlayersListBack={}
Craftie.Frame.ScrollPlayersListName={}
Craftie.Frame.ScrollPlayersListClass={}
Craftie.Frame.ScrollPlayersListProfLevel={}
Craftie.Frame.ScrollPlayersListProfMastery={}
Craftie.Frame.ScrollPlayersListUpdate={}
Craftie.Frame.ScrollPlayersListSelect={}
Craftie.Frame.ScrollPlayersListSelectSpark={}
Craftie.Frame.ScrollPlayersListFav={}
Craftie.Frame.ScrollPlayersListNet={}

--[==[
Craftie.Frame.ScrollPlayersListOpt={}
Craftie.Frame.ScrollPlayersListOpt.Back={}
Craftie.Frame.ScrollPlayersListOpt.HL={}
]==]--
Craftie.Frame.ScrollPlayersListSubMenu={}

for i=1, Craftie.MAX_PLAYERS do
  Craftie.Frame.ScrollPlayersListItem[i] = CreateFrame("Button", Craftie.Frame.ScrollPlayersListItem[i], Craftie.Frame.ScrollPlayersListChildFrame, "BackdropTemplate", -1)
  Craftie.Frame.ScrollPlayersListItem[i]:SetWidth(Craftie.Frame.ScrollPlayers_Width-26) --scrollbar size
  Craftie.Frame.ScrollPlayersListItem[i]:SetHeight(20)
  Craftie.Frame.ScrollPlayersListItem[i]:SetPoint("TOPLEFT", 2, -i*Craftie.Frame.ScrollPlayersListItem[i]:GetHeight())
  Craftie.Frame.ScrollPlayersListItem[i]:SetBackdrop(Craftie.Backdrop.Borderless)
  Craftie.Frame.ScrollPlayersListItem[i]:SetBackdropBorderColor(1, 1, 1, 0)
  Craftie.Frame.ScrollPlayersListItem[i]:SetFrameLevel(Craftie.Framelevel.Background)
  Craftie.Frame.ScrollPlayersListItem[i]:RegisterForClicks("AnyUp")

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
  Craftie.Frame.ScrollPlayersListClass[i] = Craftie.Frame.ScrollPlayersListItem[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.ScrollPlayersListClass[i]:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
  Craftie.Frame.ScrollPlayersListClass[i]:SetText("")
  Craftie.Frame.ScrollPlayersListClass[i]:Hide()
  Craftie.Frame.ScrollPlayersListProfLevel[i] = Craftie.Frame.ScrollPlayersListItem[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.ScrollPlayersListProfLevel[i]:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
  Craftie.Frame.ScrollPlayersListProfLevel[i]:SetText("")
  Craftie.Frame.ScrollPlayersListProfLevel[i]:Hide()
  Craftie.Frame.ScrollPlayersListProfMastery[i] = Craftie.Frame.ScrollPlayersListItem[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.ScrollPlayersListProfMastery[i]:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
  Craftie.Frame.ScrollPlayersListProfMastery[i]:SetText("")
  Craftie.Frame.ScrollPlayersListProfMastery[i]:Hide()
  Craftie.Frame.ScrollPlayersListUpdate[i] = Craftie.Frame.ScrollPlayersListItem[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.ScrollPlayersListUpdate[i]:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
  Craftie.Frame.ScrollPlayersListUpdate[i]:SetText("")
  Craftie.Frame.ScrollPlayersListUpdate[i]:Hide()
  Craftie.Frame.ScrollPlayersListSelect[i] = Craftie.Frame.ScrollPlayersListItem[i]:CreateTexture(nil, "BACKGROUND")
  Craftie.Frame.ScrollPlayersListSelect[i]:SetSize(Craftie.Frame.ScrollPlayersListItem[i]:GetWidth()-4, Craftie.Frame.ScrollPlayersListItem[i]:GetHeight())
  Craftie.Frame.ScrollPlayersListSelect[i]:SetPoint("CENTER", 0, 0)
  Craftie.Frame.ScrollPlayersListSelect[i]:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Row-Select-HL.png")
  Craftie.Frame.ScrollPlayersListSelect[i]:SetBlendMode("ADD")
  Craftie.Frame.ScrollPlayersListSelect[i]:SetVertexColor(0.60, 0.80, 0.94)
  Craftie.Frame.ScrollPlayersListSelect[i]:SetAlpha(0.5)
  Craftie.Frame.ScrollPlayersListSelect[i]:Hide()
  Craftie.Frame.ScrollPlayersListSelectSpark[i] = Craftie.Frame.ScrollPlayersListItem[i]:CreateTexture(nil, "OVERLAY")
  Craftie.Frame.ScrollPlayersListSelectSpark[i]:SetSize(64, 80)
  Craftie.Frame.ScrollPlayersListSelectSpark[i]:SetPoint("TOPLEFT", -30, 18)
  Craftie.Frame.ScrollPlayersListSelectSpark[i]:SetTexture("Interface/COMMON/StreamSpark")
  Craftie.Frame.ScrollPlayersListSelectSpark[i]:SetVertexColor(0.80, 0.90, 1)
  Craftie.Frame.ScrollPlayersListSelectSpark[i]:Hide()

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

  --[==[
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
  ]==]--

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
    if ((i > 1) and (Craftie.EnableScrollFrames)) then
      local class = 1
      local color = ""
      local name = nil
      local profLevel = 1
      local profMastery = 0
      local update = ""
      name = Craftie.Frame.ScrollPlayersListName[i]:GetText()
      if (name) then
        class = tonumber(Craftie.Frame.ScrollPlayersListClass[i]:GetText())
        profLevel = tonumber(Craftie.Frame.ScrollPlayersListProfLevel[i]:GetText())
        profMastery = tonumber(Craftie.Frame.ScrollPlayersListProfMastery[i]:GetText())
        update = Craftie.Frame.ScrollPlayersListUpdate[i]:GetText()
        if (class) then
          color = Craftie.Class[class][4]
        end

        if (Craftie.EnableScrollFrames) then
          CraftieTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
          CraftieTooltip:ClearLines()
          CraftieTooltip:AddLine(color .. name .. "|r")
          CraftieTooltip:AddLine(" ")
          CraftieTooltip:AddDoubleLine(Craftie.Page, profLevel .. "/" .. Craftie.PROFMAXLEVEL)
          if (tonumber(profMastery)) then
            if (profMastery > 0) then
              local mastery = Craftie.Professions[Craftie:GetKeyFromValue(Craftie.Professions, Craftie.Page, 1)][4][profMastery]
              CraftieTooltip:AddLine("|CFFDEDEDE" .. mastery)
            end
          end
          CraftieTooltip:AddLine(" ")
          CraftieTooltip:AddLine("|CFF8F8F8FLast Update:|n" .. update:gsub("_", " "))
          CraftieTooltip:AddLine(" ")
          CraftieTooltip:AddLine("|CFFEFEFEFRight Click for more options")
          CraftieTooltip:Show()
        end
      end
    end

    if (Craftie.EnableScrollFrames) then
      if (i == 1) then
        CraftieTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
        CraftieTooltip:AddLine("All ".. Craftie.Page .." Recipes")
        CraftieTooltip:AddLine("|CFFB5B5B5Showing all phases for " .. Craftie.Game.Name)
        CraftieTooltip:Show()
      end
    end
  end)
  Craftie.Frame.ScrollPlayersListItem[i]:SetScript("OnLeave", function(self)
    if (Craftie.EnableScrollFrames) then
      self:SetBackdropColor(0.8, 0.85, 1, 0)
      CraftieTooltip:Hide()
      Craftie:SelectScrollItem("Players")
    end
  end)
  --show the options
  Craftie.Frame.ScrollPlayersListItem[i]:SetScript("OnClick", function(self, button)
    Craftie:CloseAllPlayerMenus()
    if (Craftie.EnableScrollFrames) then
      if (Craftie.Frame.ScrollPlayersListName[i]:GetText() ~= nil) then
        Craftie:SelectCrafter(i, Craftie.Frame.ScrollPlayersListName[i]:GetText())
        if (i > 1) then
          --Craftie.Frame.ScrollPlayersListOpt[i]:Show()
          if (button == "RightButton") then
            Craftie:CloseAllPlayerMenus()
            --CraftieTooltip:Hide()
            Craftie:DisableAllScrollBars()
            local crafter = Craftie.Frame.ScrollPlayersListName[i]:GetText()
            if (crafter ~= nil) then
              Craftie.Frame.ScrollPlayersListSubMenu:Show()
              local point, relativeTo, relativePoint, xOfs, yOfs = Craftie.Frame.ScrollPlayersListItem[i]:GetPoint()
              --Craftie.Frame.ScrollPlayersListSubMenu[i]:SetPoint("TOPLEFT", xOfs, yOfs)
              Craftie.Frame.ScrollPlayersListSubMenu:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs-8)
              Craftie:Notification("Sub Menu: [" .. crafter .. "][" .. Craftie.Page .. "]", Craftie.CHAT.FUNC)

              Craftie.Frame.ScrollPlayersListSubMenuName:SetText(Craftie.Frame.ScrollPlayersListName[i]:GetText())
              local class = tonumber(Craftie.Frame.ScrollPlayersListClass[i]:GetText())
              local r = Craftie.Class[class][3][1]
              local g = Craftie.Class[class][3][2]
              local b = Craftie.Class[class][3][3]
              Craftie.Frame.ScrollPlayersListSubMenuName:SetTextColor(r, g, b, 1)

              --delete
              --CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CRAFTERS"][Craftie.Page:upper()][crafter] = nil
            end
          end
        end
      end
    end
  end)

  --[==[
  Craftie.Frame.ScrollPlayersListOpt[i]:SetScript("OnClick", function(self)
    self:Hide()
    --open the sub menu
    --temporarily disable the scrolling
    Craftie:CloseAllPlayerMenus()
    Craftie:DisableAllScrollBars()

    local crafter = Craftie.Frame.ScrollPlayersListName[i]:GetText()
    if (crafter ~= nil) then
      Craftie.Frame.ScrollPlayersListSubMenu:Show()
      local point, relativeTo, relativePoint, xOfs, yOfs = Craftie.Frame.ScrollPlayersListItem[i]:GetPoint()
      --Craftie.Frame.ScrollPlayersListSubMenu[i]:SetPoint("TOPLEFT", xOfs, yOfs)
      Craftie.Frame.ScrollPlayersListSubMenu:SetPoint(point, relativeTo, relativePoint, xOfs+150, yOfs)
      Craftie:Notification("Sub Menu: [" .. crafter .. "][" .. Craftie.Page .. "]", Craftie.CHAT.FUNC)
      --CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CRAFTERS"][Craftie.Page:upper()][crafter] = nil
    end
  end)
  ]==]--
end

local SubMenuHighLight = {1, 1, 0, 0.7}
Craftie.Frame.ScrollPlayersListSubMenu = CreateFrame("Frame", "Craftie.Frame.ScrollPlayersListSubMenu", Craftie.Frame.ScrollPlayers, "BackdropTemplate")
Craftie.Frame.ScrollPlayersListSubMenu:SetWidth(170)
Craftie.Frame.ScrollPlayersListSubMenu:SetHeight(150)
Craftie.Frame.ScrollPlayersListSubMenu:SetPoint("TOPLEFT", 0, 0) --this is controlled by the playerlist right click
Craftie.Frame.ScrollPlayersListSubMenu:SetBackdrop(Craftie.Backdrop.General)
Craftie.Frame.ScrollPlayersListSubMenu:SetBackdropColor(0, 0, 0, 0.8) --shade
Craftie.Frame.ScrollPlayersListSubMenu:SetBackdropBorderColor(1, 1, 1, 0.5)
Craftie.Frame.ScrollPlayersListSubMenu:SetFrameLevel(300)
Craftie.Frame.ScrollPlayersListSubMenu:SetFrameStrata("HIGH")
Craftie.Frame.ScrollPlayersListSubMenu:SetToplevel(true)
Craftie.Frame.ScrollPlayersListSubMenu:Hide()
Craftie.Frame.ScrollPlayersListSubMenuName = Craftie.Frame.ScrollPlayersListSubMenu:CreateFontString(nil, "ARTWORK")
Craftie.Frame.ScrollPlayersListSubMenuName:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size+1, "SLUG")
Craftie.Frame.ScrollPlayersListSubMenuName:SetPoint("TOPLEFT", 6, -6)
Craftie.Frame.ScrollPlayersListSubMenuName:SetText("")

Craftie.Frame.ScrollPlayersListSubMenuFav={}
Craftie.Frame.ScrollPlayersListSubMenuFav = CreateFrame("Button", nil, Craftie.Frame.ScrollPlayersListSubMenu, "BackdropTemplate")
Craftie.Frame.ScrollPlayersListSubMenuFav:SetWidth(Craftie.Frame.ScrollPlayersListSubMenu:GetWidth()-2)
Craftie.Frame.ScrollPlayersListSubMenuFav:SetHeight(20)
Craftie.Frame.ScrollPlayersListSubMenuFav:SetPoint("TOPLEFT", 1, -40)
Craftie.Frame.ScrollPlayersListSubMenuFav:SetBackdrop(Craftie.Backdrop.Borderless)
Craftie.Frame.ScrollPlayersListSubMenuFav:SetBackdropColor(0, 0, 0, 0)
--Craftie.Frame.ScrollPlayersListSubMenuFav:SetBackdropBorderColor(0.6, 0.6, 0.4, 0.5)
--Craftie.Frame.ScrollPlayersListSubMenu:SetFrameLevel(Craftie.Framelevel.Background)
Craftie.Frame.ScrollPlayersListSubMenuFav.Text = Craftie.Frame.ScrollPlayersListSubMenuFav:CreateFontString(nil, "ARTWORK")
Craftie.Frame.ScrollPlayersListSubMenuFav.Text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size-1, "SLUG")
Craftie.Frame.ScrollPlayersListSubMenuFav.Text:SetPoint("TOPLEFT", 8, -4)
Craftie.Frame.ScrollPlayersListSubMenuFav.Text:SetText("Add To Favorites")
Craftie.Frame.ScrollPlayersListSubMenuFav.Icon = Craftie.Frame.ScrollPlayersListSubMenuFav:CreateTexture(nil, "ARTWORK")
Craftie.Frame.ScrollPlayersListSubMenuFav.Icon:SetSize(23, 23)
Craftie.Frame.ScrollPlayersListSubMenuFav.Icon:SetPoint("TOPRIGHT", -6, 0)
Craftie.Frame.ScrollPlayersListSubMenuFav.Icon:SetTexture("Interface/COMMON/FavoritesIcon")
Craftie.Frame.ScrollPlayersListSubMenuFav.Icon:SetDesaturation(1)
--Craftie.Frame.ScrollPlayersListSubMenuFavIcon:SetAlpha(0.5)
Craftie.Frame.ScrollPlayersListSubMenuFav:SetScript("OnEnter", function(self)
  self:SetBackdropColor(SubMenuHighLight[1], SubMenuHighLight[2], SubMenuHighLight[3], SubMenuHighLight[4])
  self.Icon:SetDesaturation(0)
end)
Craftie.Frame.ScrollPlayersListSubMenuFav:SetScript("OnLeave", function(self)
  self:SetBackdropColor(0, 0, 0, 0)
  self.Icon:SetDesaturation(1)
end)
Craftie.Frame.ScrollPlayersListSubMenuFav:SetScript("OnClick", function(self)
  Craftie:CloseAllPlayerMenus()
end)

Craftie.Frame.ScrollPlayersListSubMenuParty={}
Craftie.Frame.ScrollPlayersListSubMenuParty = CreateFrame("Button", nil, Craftie.Frame.ScrollPlayersListSubMenu, "BackdropTemplate")
Craftie.Frame.ScrollPlayersListSubMenuParty:SetWidth(Craftie.Frame.ScrollPlayersListSubMenu:GetWidth()-2)
Craftie.Frame.ScrollPlayersListSubMenuParty:SetHeight(20)
Craftie.Frame.ScrollPlayersListSubMenuParty:SetPoint("TOPLEFT", 1, -60)
Craftie.Frame.ScrollPlayersListSubMenuParty:SetBackdrop(Craftie.Backdrop.Borderless)
Craftie.Frame.ScrollPlayersListSubMenuParty:SetBackdropColor(0, 0, 0, 0)
--Craftie.Frame.ScrollPlayersListSubMenuParty:SetBackdropBorderColor(0.6, 0.6, 0.4, 0.5)
--Craftie.Frame.ScrollPlayersListSubMenu:SetFrameLevel(Craftie.Framelevel.Background)
Craftie.Frame.ScrollPlayersListSubMenuParty.Text = Craftie.Frame.ScrollPlayersListSubMenuParty:CreateFontString(nil, "ARTWORK")
Craftie.Frame.ScrollPlayersListSubMenuParty.Text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size-1, "SLUG")
Craftie.Frame.ScrollPlayersListSubMenuParty.Text:SetPoint("TOPLEFT", 8, -4)
Craftie.Frame.ScrollPlayersListSubMenuParty.Text:SetText("Party Up")
Craftie.Frame.ScrollPlayersListSubMenuParty.Icon = Craftie.Frame.ScrollPlayersListSubMenuParty:CreateTexture(nil, "ARTWORK")
Craftie.Frame.ScrollPlayersListSubMenuParty.Icon:SetSize(21, 21)
Craftie.Frame.ScrollPlayersListSubMenuParty.Icon:SetPoint("TOPRIGHT", -8, 2)
Craftie.Frame.ScrollPlayersListSubMenuParty.Icon:SetTexture("Interface/FriendsFrame/UI-Toast-FriendRequestIcon")
Craftie.Frame.ScrollPlayersListSubMenuParty.Icon:SetDesaturation(1)
Craftie.Frame.ScrollPlayersListSubMenuParty:SetScript("OnEnter", function(self)
  self:SetBackdropColor(SubMenuHighLight[1], SubMenuHighLight[2], SubMenuHighLight[3], SubMenuHighLight[4])
  self.Icon:SetDesaturation(0)
end)
Craftie.Frame.ScrollPlayersListSubMenuParty:SetScript("OnLeave", function(self)
  self:SetBackdropColor(0, 0, 0, 0)
  self.Icon:SetDesaturation(1)
end)
Craftie.Frame.ScrollPlayersListSubMenuParty:SetScript("OnClick", function(self)
  Craftie:CloseAllPlayerMenus()
end)

Craftie.Frame.ScrollPlayersListSubMenuDelete={}
Craftie.Frame.ScrollPlayersListSubMenuDelete = CreateFrame("Button", nil, Craftie.Frame.ScrollPlayersListSubMenu, "BackdropTemplate")
Craftie.Frame.ScrollPlayersListSubMenuDelete:SetWidth(Craftie.Frame.ScrollPlayersListSubMenu:GetWidth()-2)
Craftie.Frame.ScrollPlayersListSubMenuDelete:SetHeight(20)
Craftie.Frame.ScrollPlayersListSubMenuDelete:SetPoint("TOPLEFT", 1, -100)
Craftie.Frame.ScrollPlayersListSubMenuDelete:SetBackdrop(Craftie.Backdrop.Borderless)
Craftie.Frame.ScrollPlayersListSubMenuDelete:SetBackdropColor(0, 0, 0, 0)
--Craftie.Frame.ScrollPlayersListSubMenuDelete:SetBackdropBorderColor(0.6, 0.6, 0.4, 0.5)
--Craftie.Frame.ScrollPlayersListSubMenu:SetFrameLevel(Craftie.Framelevel.Background)
Craftie.Frame.ScrollPlayersListSubMenuDelete.Text = Craftie.Frame.ScrollPlayersListSubMenuDelete:CreateFontString(nil, "ARTWORK")
Craftie.Frame.ScrollPlayersListSubMenuDelete.Text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size-1, "SLUG")
Craftie.Frame.ScrollPlayersListSubMenuDelete.Text:SetPoint("TOPLEFT", 8, -4)
Craftie.Frame.ScrollPlayersListSubMenuDelete.Text:SetText("Delete Crafter")
Craftie.Frame.ScrollPlayersListSubMenuDelete.Icon = Craftie.Frame.ScrollPlayersListSubMenuDelete:CreateTexture(nil, "ARTWORK")
Craftie.Frame.ScrollPlayersListSubMenuDelete.Icon:SetSize(16, 16)
Craftie.Frame.ScrollPlayersListSubMenuDelete.Icon:SetPoint("TOPRIGHT", -11, -2)
Craftie.Frame.ScrollPlayersListSubMenuDelete.Icon:SetTexture("Interface/RAIDFRAME/ReadyCheck-NotReady")
Craftie.Frame.ScrollPlayersListSubMenuDelete.Icon:SetDesaturation(1)
Craftie.Frame.ScrollPlayersListSubMenuDelete:SetScript("OnEnter", function(self)
  self:SetBackdropColor(SubMenuHighLight[1], SubMenuHighLight[2], SubMenuHighLight[3], SubMenuHighLight[4])
  self.Icon:SetDesaturation(0)
end)
Craftie.Frame.ScrollPlayersListSubMenuDelete:SetScript("OnLeave", function(self)
  self:SetBackdropColor(0, 0, 0, 0)
  self.Icon:SetDesaturation(1)
end)
Craftie.Frame.ScrollPlayersListSubMenuDelete:SetScript("OnClick", function(self)
  Craftie:CloseAllPlayerMenus()
end)
