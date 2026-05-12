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

--Craftie.Frame.ScrollParentPlayers = CreateFrame("Frame", Craftie.Frame.ScrollParentPlayers, Craftie.Frame, "InsetFrameTemplate")
Craftie.Frame.ScrollParentPlayers = CreateFrame("Frame", Craftie.Frame.ScrollParentPlayers, Craftie.Frame, "BackdropTemplate")
Craftie.Frame.ScrollParentPlayers:SetWidth(210)
Craftie.Frame.ScrollParentPlayers:SetHeight(Craftie._G.Height-88)
Craftie.Frame.ScrollParentPlayers:SetPoint("TOPLEFT", 2, -61)

--[==[
Craftie.Frame.ScrollParentPlayers.Back = Craftie.Frame.ScrollParentPlayers:CreateTexture(nil, "BACKGROUND")
Craftie.Frame.ScrollParentPlayers.Back:SetSize(185, Craftie._G.Height-95)
Craftie.Frame.ScrollParentPlayers.Back:SetPoint("TOPLEFT", 4, -5)
Craftie.Frame.ScrollParentPlayers.Back:SetTexture(Craftie._G.Path .. "images/stationary_players")
]==]--

Craftie.ScrollBarBack(Craftie.Frame.ScrollParentPlayers)

Craftie.FrameScrollPlayers_Width = 210
Craftie.FrameScrollPlayers_Height= Craftie._G.Height-90
--Craftie.FrameScrollPlayers_Height= Craftie._G.Height-200

Craftie.Frame.ScrollPlayers = CreateFrame("Frame", nil, Craftie.Frame.ScrollParentPlayers)
Craftie.Frame.ScrollPlayers:SetWidth(Craftie.FrameScrollPlayers_Width)
Craftie.Frame.ScrollPlayers:SetHeight(Craftie.FrameScrollPlayers_Height)
Craftie.Frame.ScrollPlayers:SetPoint("TOPLEFT", 0, 0) --low, due to the portrait frame
--Craftie.Frame.ScrollPlayers:SetFrameStrata("LOW")

--Craftie.Frame.ScrollPlayersList={}
Craftie.Frame.ScrollPlayersList = CreateFrame("Frame", Craftie.Frame.ScrollPlayersList, Craftie.Frame.ScrollPlayers, "BackdropTemplate")
Craftie.Frame.ScrollPlayersList:SetWidth(Craftie.FrameScrollPlayers_Width)
Craftie.Frame.ScrollPlayersList:SetHeight(Craftie.FrameScrollPlayers_Height)
Craftie.Frame.ScrollPlayersList:SetPoint("CENTER", 0, 0)
Craftie.Frame.ScrollPlayersList:SetBackdrop(Craftie.Backdrop.General)
Craftie.Frame.ScrollPlayersList:SetBackdropColor(0, 0.4, 1, 0.05) --shade
Craftie.Frame.ScrollPlayersList:SetBackdropBorderColor(1, 1, 1, 0)

Craftie.Frame.ScrollPlayersList.Child = CreateFrame("ScrollFrame", nil, Craftie.Frame.ScrollPlayersList, "UIPanelScrollFrameTemplate")
Craftie.Frame.ScrollPlayersList.Child:SetPoint("TOPLEFT", Craftie.Frame.ScrollPlayersList, "TOPLEFT", 3, -30)
Craftie.Frame.ScrollPlayersList.Child:SetPoint("BOTTOMRIGHT", Craftie.Frame.ScrollPlayersList, "BOTTOMRIGHT", 10, 4)
Craftie.Frame.ScrollPlayersListChildFrame = CreateFrame("Frame", Craftie.Frame.ScrollPlayersListChildFrame, Craftie.Frame.ScrollPlayersList.Child)
Craftie.Frame.ScrollPlayersListChildFrame:SetSize(Craftie.FrameScrollPlayers_Width, Craftie.FrameScrollPlayers_Height)
Craftie.Frame.ScrollPlayersList.Child:SetScrollChild(Craftie.Frame.ScrollPlayersListChildFrame)
Craftie.Frame.ScrollPlayersList.Child.ScrollBar:ClearAllPoints()
Craftie.Frame.ScrollPlayersList.Child.ScrollBar:SetPoint("TOPLEFT", Craftie.Frame.ScrollPlayersList.Child, "TOPRIGHT", 0, 10)
Craftie.Frame.ScrollPlayersList.Child.ScrollBar:SetPoint("BOTTOMRIGHT", Craftie.Frame.ScrollPlayersList.Child, "BOTTOMRIGHT", -42, 12)

--COMMON/UI-Searchbox-Icon
--[==[
SEARCH PLAYERS
]==]--
Craftie.Frame.Search={}
Craftie.Frame.Search.Players={}
Craftie.Frame.Search.Players = CreateFrame("Frame", nil, Craftie.Frame.ScrollParentPlayers, "BackdropTemplate", 2)
Craftie.Frame.Search.Players:SetWidth(170)
Craftie.Frame.Search.Players:SetHeight(24)
Craftie.Frame.Search.Players:SetPoint("TOPLEFT", 4, -2)
Craftie.Frame.Search.Players:SetBackdrop(Craftie.Backdrop.Opaque)
Craftie.Frame.Search.Players:SetBackdropColor(1, 0, 0, 1)
Craftie.Frame.Search.Players:SetBackdropBorderColor(1, 1, 1, 0.6)
Craftie.Frame.Search.Players:SetFrameStrata("MEDIUM")
Craftie.Frame.Search.Players.Icon = Craftie.Frame.Search.Players:CreateTexture(nil, "ARTWORK")
Craftie.Frame.Search.Players.Icon:SetSize(18, 18)
Craftie.Frame.Search.Players.Icon:SetPoint("TOPLEFT", 4, -5)
Craftie.Frame.Search.Players.Icon:SetTexture("Interface/COMMON/UI-Searchbox-Icon")
Craftie.Frame.Search.Players.Icon:SetAlpha(0.5)
Craftie.Frame.SearchPlayerText = CreateFrame("EditBox", nil, Craftie.Frame.Search.Players)
Craftie.Frame.SearchPlayerText:SetWidth(Craftie.Frame.Search.Players:GetWidth()-52)
Craftie.Frame.SearchPlayerText:SetHeight(Craftie.Frame.Search.Players:GetHeight())
Craftie.Frame.SearchPlayerText:SetFontObject(GameFontDisable)
Craftie.Frame.SearchPlayerText:SetFont(Craftie._G.Font.Style, 11, "OUTLINE")
Craftie.Frame.SearchPlayerText:SetPoint("TOPLEFT", 22, 0)
Craftie.Frame.SearchPlayerText:SetAutoFocus(false)
Craftie.Frame.SearchPlayerText:SetText(Craftie.Placeholder_Players)
Craftie.Frame.SearchPlayerText:SetScript("OnKeyUp", function(self, key)
  if (key == "ENTER") then
    Craftie.ClearFocusAll()
    Craftie.Frame.ScrollPlayersList.Child:SetVerticalScroll(1)
  end
end)
Craftie.Frame.SearchPlayerText:SetScript("OnMouseDown", function(self)
    local search_index = Craftie.Frame.SearchPlayerText:GetText()
    if (search_index == Craftie.Placeholder_Players) then
      Craftie.Frame.SearchPlayerText:SetText("")
      Craftie.Frame.SearchPlayerText:SetFontObject(GameFontWhite)
    end
end)
Craftie.Frame.SearchPlayerText:SetScript("OnEditFocusLost", function(self)
  --Craftie.Frame.SearchPlayerText:SetText(Craftie.Placeholder_Players)
end)
Craftie.Frame.Button.SearchPlayers = CreateFrame("Button", nil, Craftie.Frame.Search.Players, "UIPanelButtonTemplate")
Craftie.Frame.Button.SearchPlayers:SetSize(24, 23)
Craftie.Frame.Button.SearchPlayers:SetPoint("TOPLEFT", Craftie.Frame.Search.Players:GetWidth()-25, 0)
Craftie.Frame.Button.SearchPlayersIcon = Craftie.Frame.Button.SearchPlayers:CreateTexture(nil, "ARTWORK")
Craftie.Frame.Button.SearchPlayersIcon:SetSize(12, 12)
Craftie.Frame.Button.SearchPlayersIcon:SetPoint("CENTER", 0, 0)
Craftie.Frame.Button.SearchPlayersIcon:SetTexture("Interface/Buttons/UI-RefreshButton")
Craftie.Frame.Button.SearchPlayers:SetScript("OnClick", function(self)
  Craftie.Frame.SearchPlayerText:SetText("")
  Craftie.ClearFocusAll()
end)

Craftie.Frame.ScrollPlayersListItem={}
Craftie.Frame.ScrollPlayersListText={}

for i=1, Craftie.MAX_PLAYERS do
  Craftie.Frame.ScrollPlayersListItem[i] = CreateFrame("Button", Craftie.Frame.ScrollPlayersListItem[i], Craftie.Frame.ScrollPlayersListChildFrame, "BackdropTemplate", -1)
  Craftie.Frame.ScrollPlayersListItem[i]:SetWidth(Craftie.FrameScrollPlayers_Width-26) --scrollbar size
  Craftie.Frame.ScrollPlayersListItem[i]:SetHeight(20)
  Craftie.Frame.ScrollPlayersListItem[i]:SetPoint("TOPLEFT", 2, -i*18)
  Craftie.Frame.ScrollPlayersListItem[i]:SetBackdrop(Craftie.Backdrop.General)
  Craftie.Frame.ScrollPlayersListItem[i]:SetBackdropBorderColor(1, 1, 1, 0)
  Craftie.Frame.ScrollPlayersListItem[i]:SetFrameLevel(Craftie.Framelevel.Background)
  Craftie.Frame.ScrollPlayersListItem[i]:SetBackdropColor(1, 1, 1, 0)

  Craftie.Frame.ScrollPlayersListText[i] = Craftie.Frame.ScrollPlayersListItem[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.ScrollPlayersListText[i]:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
  Craftie.Frame.ScrollPlayersListText[i]:SetPoint("TOPLEFT", 8, -5)
  --Craftie.Frame.ScrollPlayersListText[i]:SetText("Player_" .. i)
  Craftie.Frame.ScrollPlayersListText[i]:SetText("")
  if (i == 1) then
    Craftie.Frame.ScrollPlayersListText[i]:SetText(Craftie.Selected_ViewAll)
  end
  Craftie.Frame.ScrollPlayersListText[i]:SetTextColor(1, 1, 1, 0.8)

  if (i % 2 == 0) then
    Craftie.Frame.ScrollPlayersListItem[i]:SetBackdropColor(0.6, 0.7, 1, 0.1)
  end
  Craftie.Frame.ScrollPlayersListItem[i]:SetScript("OnEnter", function(self)
    self:SetBackdropColor(1, 1, 1, 0.2)
    --Craftie.Frame.ScrollPlayersListText[i]:SetTextColor(1, 1, 0.8, 1)
  end)
  Craftie.Frame.ScrollPlayersListItem[i]:SetScript("OnLeave", function(self)
    GameTooltip:Hide()
    Craftie.SelectScrollItem("Players")
  end)
  Craftie.Frame.ScrollPlayersListItem[i]:SetScript("OnClick", function(self)
    Craftie.SelectCrafter(i, Craftie.Frame.ScrollPlayersListText[i]:GetText())
  end)
end
