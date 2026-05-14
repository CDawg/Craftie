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

Craftie.Frame.ScrollPlayers_Width = 210
Craftie.Frame.ScrollPlayers_Height= Craftie._G.Height-90

Craftie.Frame.ScrollPlayers = CreateFrame("Frame", nil, Craftie.Frame.ScrollParentPlayers)
Craftie.Frame.ScrollPlayers:SetWidth(Craftie.Frame.ScrollPlayers_Width)
Craftie.Frame.ScrollPlayers:SetHeight(Craftie.Frame.ScrollPlayers_Height)
Craftie.Frame.ScrollPlayers:SetPoint("TOPLEFT", 0, 0) --low, due to the portrait frame

Craftie.Frame.ScrollPlayersList = CreateFrame("Frame", Craftie.Frame.ScrollPlayersList, Craftie.Frame.ScrollPlayers, "BackdropTemplate")
Craftie.Frame.ScrollPlayersList:SetWidth(Craftie.Frame.ScrollPlayers_Width+10)
Craftie.Frame.ScrollPlayersList:SetHeight(Craftie.Frame.ScrollPlayers_Height)
Craftie.Frame.ScrollPlayersList:SetPoint("CENTER", 5, 0)
Craftie.Frame.ScrollPlayersList:SetBackdrop(Craftie.Backdrop.General)
Craftie.Frame.ScrollPlayersList:SetBackdropColor(0, 0.4, 1, 0.05) --shade
Craftie.Frame.ScrollPlayersList:SetBackdropBorderColor(1, 1, 1, 0)

Craftie.Frame.ScrollPlayersList.Child = CreateFrame("ScrollFrame", nil, Craftie.Frame.ScrollPlayersList, "UIPanelScrollFrameTemplate")
Craftie.Frame.ScrollPlayersList.Child:SetPoint("TOPLEFT", Craftie.Frame.ScrollPlayersList, "TOPLEFT", 3, -30)
Craftie.Frame.ScrollPlayersList.Child:SetPoint("BOTTOMRIGHT", Craftie.Frame.ScrollPlayersList, "BOTTOMRIGHT", 10, 4)
Craftie.Frame.ScrollPlayersListChildFrame = CreateFrame("Frame", Craftie.Frame.ScrollPlayersListChildFrame, Craftie.Frame.ScrollPlayersList.Child)
Craftie.Frame.ScrollPlayersListChildFrame:SetSize(Craftie.Frame.ScrollPlayers_Width, Craftie.Frame.ScrollPlayers_Height)
Craftie.Frame.ScrollPlayersList.Child:SetScrollChild(Craftie.Frame.ScrollPlayersListChildFrame)
Craftie.Frame.ScrollPlayersList.Child.ScrollBar:ClearAllPoints()
Craftie.Frame.ScrollPlayersList.Child.ScrollBar:SetPoint("TOPLEFT", Craftie.Frame.ScrollPlayersList.Child, "TOPRIGHT", -20, 10)
Craftie.Frame.ScrollPlayersList.Child.ScrollBar:SetPoint("BOTTOMRIGHT", Craftie.Frame.ScrollPlayersList.Child, "BOTTOMRIGHT", -42, 12)

--[==[
SEARCH PLAYERS
]==]--
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
Craftie.Frame.Search.Players.Text = CreateFrame("EditBox", nil, Craftie.Frame.Search.Players)
Craftie.Frame.Search.Players.Text:SetWidth(Craftie.Frame.Search.Players:GetWidth()-52)
Craftie.Frame.Search.Players.Text:SetHeight(Craftie.Frame.Search.Players:GetHeight())
Craftie.Frame.Search.Players.Text:SetFontObject(GameFontDisable)
Craftie.Frame.Search.Players.Text:SetFont(Craftie._G.Font.Style, 11, "OUTLINE")
Craftie.Frame.Search.Players.Text:SetPoint("TOPLEFT", 22, 0)
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
Craftie.Frame.Button.SearchPlayers = CreateFrame("Button", nil, Craftie.Frame.Search.Players, "UIPanelButtonTemplate")
Craftie.Frame.Button.SearchPlayers:SetSize(24, 23)
Craftie.Frame.Button.SearchPlayers:SetPoint("TOPLEFT", Craftie.Frame.Search.Players:GetWidth()-25, 0)
Craftie.Frame.Button.SearchPlayersIcon = Craftie.Frame.Button.SearchPlayers:CreateTexture(nil, "ARTWORK")
Craftie.Frame.Button.SearchPlayersIcon:SetSize(12, 12)
Craftie.Frame.Button.SearchPlayersIcon:SetPoint("CENTER", 0, 0)
Craftie.Frame.Button.SearchPlayersIcon:SetTexture("Interface/Buttons/UI-RefreshButton")
Craftie.Frame.Button.SearchPlayers:SetScript("OnClick", function(self)
  Craftie.Frame.Search.Players.Text:SetText("")
  Craftie.ClearFocusAll()
end)

Craftie.Frame.ScrollPlayersListItem={}
Craftie.Frame.ScrollPlayersListText={}
Craftie.Frame.ScrollPlayersListSelect={}
Craftie.Frame.ScrollPlayersListFav={}
Craftie.Frame.ScrollPlayersListNet={}

Craftie.Frame.ScrollPlayersListOpt={}
Craftie.Frame.ScrollPlayersListOpt.Back={}
Craftie.Frame.ScrollPlayersListOpt.HL={}

for i=1, Craftie.MAX_PLAYERS do
  Craftie.Frame.ScrollPlayersListItem[i] = CreateFrame("Button", Craftie.Frame.ScrollPlayersListItem[i], Craftie.Frame.ScrollPlayersListChildFrame, "BackdropTemplate", -1)
  Craftie.Frame.ScrollPlayersListItem[i]:SetWidth(Craftie.Frame.ScrollPlayers_Width-26) --scrollbar size
  Craftie.Frame.ScrollPlayersListItem[i]:SetHeight(20)
  Craftie.Frame.ScrollPlayersListItem[i]:SetPoint("TOPLEFT", 2, -i*Craftie.Frame.ScrollPlayersListItem[i]:GetHeight())
  Craftie.Frame.ScrollPlayersListItem[i]:SetBackdrop(Craftie.Backdrop.Borderless)
  Craftie.Frame.ScrollPlayersListItem[i]:SetBackdropBorderColor(1, 1, 1, 0)
  Craftie.Frame.ScrollPlayersListItem[i]:SetFrameLevel(Craftie.Framelevel.Background)
  Craftie.Frame.ScrollPlayersListItem[i]:SetBackdropColor(1, 1, 1, 0)
  Craftie.Frame.ScrollPlayersListText[i] = Craftie.Frame.ScrollPlayersListItem[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.ScrollPlayersListText[i]:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
  Craftie.Frame.ScrollPlayersListText[i]:SetPoint("TOPLEFT", 22, -5)
  --Craftie.Frame.ScrollPlayersListText[i]:SetText("Player_" .. i)
  Craftie.Frame.ScrollPlayersListText[i]:SetText("")
  Craftie.Frame.ScrollPlayersListText[i]:SetTextColor(1, 1, 1, 0.8)
  Craftie.Frame.ScrollPlayersListSelect[i] = Craftie.Frame.ScrollPlayersListItem[i]:CreateTexture(nil, "BACKGROUND")
  Craftie.Frame.ScrollPlayersListSelect[i]:SetSize(Craftie.Frame.ScrollPlayers_Width-30, Craftie.Frame.ScrollPlayersListItem[i]:GetHeight())
  Craftie.Frame.ScrollPlayersListSelect[i]:SetPoint("CENTER", 0, 0)
  Craftie.Frame.ScrollPlayersListSelect[i]:SetTexture("Interface/WORLDSTATEFRAME/WORLDSTATEFINALSCORE-HIGHLIGHT")
  --Craftie.Frame.ScrollPlayersListSelect[i]:SetAlpha(0.4)
  Craftie.Frame.ScrollPlayersListSelect[i]:SetBlendMode("ADD")
  Craftie.Frame.ScrollPlayersListSelect[i]:SetVertexColor(0.40, 0.45, 0.50)
  Craftie.Frame.ScrollPlayersListSelect[i]:Hide()
--[==[
  Craftie.Frame.ScrollPlayersListNet[i] = Craftie.Frame.ScrollPlayersListItem[i]:CreateTexture(nil, "ARTWORK")
  Craftie.Frame.ScrollPlayersListNet[i]:SetSize(12, 12)
  Craftie.Frame.ScrollPlayersListNet[i]:SetPoint("TOPLEFT", 16, -5)
  Craftie.Frame.ScrollPlayersListNet[i]:SetTexture("Interface/FriendsFrame/StatusIcon-Offline")
  Craftie.Frame.ScrollPlayersListNet[i]:Hide()
]==]--
  Craftie.Frame.ScrollPlayersListFav[i] = Craftie.Frame.ScrollPlayersListItem[i]:CreateTexture(nil, "ARTWORK")
  Craftie.Frame.ScrollPlayersListFav[i]:SetSize(10, 10)
  Craftie.Frame.ScrollPlayersListFav[i]:SetPoint("TOPLEFT", 6, -5)
  Craftie.Frame.ScrollPlayersListFav[i]:SetTexture("Interface/COMMON/ReputationStar")
  --Craftie.Frame.ScrollPlayersListFav[i]:SetTexCoord(0, 0.5, 0, 0.5) --on
  Craftie.Frame.ScrollPlayersListFav[i]:SetTexCoord(1, 0.5, 0, 0.5)
  Craftie.Frame.ScrollPlayersListFav[i]:Hide()

  Craftie.Frame.ScrollPlayersListOpt[i] = CreateFrame("Button", nil, Craftie.Frame.ScrollPlayersListItem[i], "BackdropTemplate", 1)
  Craftie.Frame.ScrollPlayersListOpt[i]:SetSize(22, 22)
  Craftie.Frame.ScrollPlayersListOpt[i]:SetPoint("TOPLEFT", 162, 0)
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
  Craftie.Frame.ScrollPlayersListOpt.HL[i]:SetTexture("Interface/FriendsFrame/UI-FriendsList-Highlight")
  Craftie.Frame.ScrollPlayersListOpt.HL[i]:SetBlendMode("ADD")
  Craftie.Frame.ScrollPlayersListOpt.HL[i]:Hide()
  Craftie.Frame.ScrollPlayersListOpt[i]:SetScript("OnEnter", function(self)
    if (Craftie.Frame.ScrollPlayersListText[i]:GetText() ~= nil) then
      self:Show()
    end
    Craftie.Frame.ScrollPlayersListOpt.HL[i]:Show()
  end)
  Craftie.Frame.ScrollPlayersListOpt[i]:SetScript("OnLeave", function(self)
    self:Hide()
    Craftie.Frame.ScrollPlayersListOpt.HL[i]:Hide()
  end)

  if (i % 2 == 0) then
    Craftie.Frame.ScrollPlayersListItem[i]:SetBackdropColor(0.6, 0.7, 1, 0.1)
  end
  Craftie.Frame.ScrollPlayersListItem[i]:SetScript("OnEnter", function(self)
    self:SetBackdropColor(1, 1, 1, 0.2)
    if (Craftie.Frame.ScrollPlayersListText[i]:GetText() ~= nil) then
      Craftie.Frame.ScrollPlayersListOpt[i]:Show()
    end
    Craftie.Frame.ScrollPlayersListOpt[1]:Hide()
  end)
  Craftie.Frame.ScrollPlayersListItem[i]:SetScript("OnLeave", function(self)
    Craftie.Frame.ScrollPlayersListOpt[i]:Hide()
    GameTooltip:Hide()
    Craftie.SelectScrollItem("Players")
  end)
  Craftie.Frame.ScrollPlayersListItem[i]:SetScript("OnClick", function(self)
    Craftie.SelectCrafter(i, Craftie.Frame.ScrollPlayersListText[i]:GetText())
  end)
end

function Craftie.SelectCrafter(index, name)
  Craftie.Selected_Players = 1 --always one at first
  if (index == 1) then
    --Craftie.OpenProfessionList(Craftie.ProfessionDefault, "", "") --get whats in the search text?
  else
    if (name ~= nil) then
      --print(name)
      Craftie.Selected_Players = index
      Craftie.Notification("Craftie.SelectCrafter(" .. index .. ", " .. name .. ")", true)
      Craftie.OpenProfessionList(Craftie.Profession[Craftie.Page], "", name) --get whats in the search text?
    end
  end
  Craftie.SelectScrollItem("Players") --highlight
end

function Craftie.UpdateCrafterList()
  local i=1

  for i=1, Craftie.MAX_PLAYERS do
    --Craftie.Frame.ScrollPlayersListNet[i]:Hide()
    Craftie.Frame.ScrollPlayersListFav[i]:Hide()
    Craftie.Frame.ScrollPlayersListText[i]:SetText("")
  end

  Craftie.Notification("Craftie.UpdateCrafterList()", true)
  Craftie.Frame.ScrollPlayersListText[1]:SetText("All " .. Craftie.Page .. " Recipes")
  Craftie.Frame.ScrollPlayersListText[1]:SetPoint("TOPLEFT", 6, -5)

  if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CRAFTERS"] ~= nil) then
    for k,v in pairs(CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CRAFTERS"][Craftie.Page:upper()]) do
      i = i+1
      Craftie.Frame.ScrollPlayersListText[i]:SetText(k)
      --Craftie.Frame.ScrollPlayersListNet[i]:Show()
      Craftie.Frame.ScrollPlayersListFav[i]:Show()
    end
  end
end
