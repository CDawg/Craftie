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

Craftie.Nav={}
Craftie.Nav.Tabs = {"Professions", "Updates", "Help", "Logger"}

Craftie.Wrap = CreateFrame("Button", nil, Craftie.Frame, "BackdropTemplate")
Craftie.Wrap:SetSize(Craftie.Frame:GetWidth()-14, Craftie.Frame:GetHeight()-70)
Craftie.Wrap:SetPoint("TOPLEFT", 6, -64)
Craftie.Wrap:SetBackdrop(Craftie.Backdrop.General)
Craftie.Wrap:SetBackdropColor(0, 1, 0, 0)
Craftie.Wrap:SetBackdropBorderColor(1, 1, 1, 0)
--[==[
Craftie.Wrap.BG = Craftie.Wrap:CreateTexture(nil, "BACKGROUND")
Craftie.Wrap.BG:SetAllPoints(Craftie.Wrap)
Craftie.Wrap.BG:SetHorizTile(true)
Craftie.Wrap.BG:SetVertTile(true)
Craftie.Wrap.BG:SetTexture("Interface/FrameGeneral/UI-Background-Marble", "REPEAT", "REPEAT")
]==]--

function Craftie.TabBottomSelect(tab, sound)
  Craftie.Frame.ScrollParentPlayers:Hide()
  Craftie.Frame.ScrollParentRecipes:Hide()
  Craftie.Frame.CraftParent:Hide()
  Craftie.Logger:Hide()
  Craftie.Updates:Hide()
  Craftie.Credit:Hide()
  Craftie.Help:Hide()
  Craftie.Frame.Title.Prof:Hide()
  Craftie.Frame.Title.Sub:Show()

  for k,v in pairs(Craftie.Nav.Tabs) do
    Craftie.TabBottom[k].BG:SetTexture("Interface/FriendsFrame/UI-FriendsFrameTab-InactiveTab")
    Craftie.TabBottom[k].Text:SetTextColor(1, 1, 1, 0.7)
  end

  if (tab == 1) then
    Craftie.TabBarHide = 0
    Craftie.Frame.Title.Sub:Hide()
    Craftie.Frame.Title.Prof:Show()
    Craftie.Frame.CraftParent:Show()
    Craftie.Frame.ScrollParentPlayers:Show()
    Craftie.Frame.ScrollParentRecipes:Show()
  end

  if (tab == 2) then
    Craftie.TabBarHide = Craftie.TabBarHide+1
    Craftie.Updates:Show()
    Craftie.Credit:Show()
  end
  if (tab == 3) then
    Craftie.TabBarHide = Craftie.TabBarHide+1
    Craftie.Help:Show()
  end
  if (tab == 4) then
    Craftie.TabBarHide = Craftie.TabBarHide+1
    Craftie.Logger:Show()
  end

  Craftie.TimerAnim(Craftie.Frame.TabBar, 1) --animate the tab bar
  Craftie.TabBottom[tab].BG:SetTexture("Interface/FriendsFrame/UI-FriendsFrameTab")
  Craftie.TabBottom[tab].Text:SetTextColor(1, 1, 1, 1)
  Craftie.Frame.Title.Sub:SetText(Craftie.Nav.Tabs[tab])

  if (sound) then
    PlaySound(SOUNDKIT.IG_CHARACTER_INFO_TAB)
  end
end

Craftie.TabBottom={}
local bottomTabOffset = 330
for k,v in pairs(Craftie.Nav.Tabs) do
  Craftie.TabBottom[k] = CreateFrame("Button", nil, Craftie.Frame, "BackdropTemplate")
  Craftie.TabBottom[k]:SetSize(74, 32)
  Craftie.TabBottom[k]:SetPoint("BOTTOMRIGHT", -bottomTabOffset+((Craftie.TabBottom[k]:GetWidth()+4)*k), -28)
  Craftie.TabBottom[k]:SetBackdrop(Craftie.Backdrop.General)
  Craftie.TabBottom[k]:SetBackdropColor(0, 1, 0, 0)
  Craftie.TabBottom[k]:SetBackdropBorderColor(1, 1, 1, 0)
  Craftie.TabBottom[k].BG = Craftie.TabBottom[k]:CreateTexture(nil, "ARTWORK")
  Craftie.TabBottom[k].BG:SetSize(Craftie.TabBottom[k]:GetWidth(), 64)
  Craftie.TabBottom[k].BG:SetPoint("CENTER", 0, 0)
  Craftie.TabBottom[k].BG:SetTexture("Interface/FriendsFrame/UI-FriendsFrameTab-InactiveTab")
  --[==[
  Craftie.TabBottom.Hover = Craftie.TabBottom:CreateTexture(nil, "ARTWORK")
  Craftie.TabBottom.Hover:SetSize(Craftie.TabBottom:GetWidth(), 64)
  Craftie.TabBottom.Hover:SetPoint("TOPLEFT", 7, -5)
  Craftie.TabBottom.Hover:SetTexture("Interface/Buttons/ButtonHilight-Square")
  Craftie.TabBottom.Hover:SetBlendMode("ADD")
  Craftie.TabBottom.Hover:SetDrawLayer("ARTWORK", 7)
  --Craftie.TabBottom.Hover:Hide()
  ]==]--

  Craftie.TabBottom[k].Text = Craftie.TabBottom[k]:CreateFontString(nil, "ARTWORK")
  Craftie.TabBottom[k].Text:SetFont(Craftie._G.Font.Style, 10, "OUTLINE")
  Craftie.TabBottom[k].Text:SetPoint("CENTER", 0, 0)
  Craftie.TabBottom[k].Text:SetText(v)
  Craftie.TabBottom[k].Text:SetTextColor(1, 1, 1, 0.7)
  Craftie.TabBottom[k]:SetScript("OnClick", function(self)
    Craftie.TabBottomSelect(k, true)
  end)
  Craftie.TabBottom[k]:SetScript("OnEnter", function(self)
    --Craftie.TooltipDisplay(self, Craftie._G.Title, Craftie.Addon)
  end)
  Craftie.TabBottom[k]:SetScript("OnLeave", function(self)
    --Craftie.TooltipDisplay(self, Craftie._G.Title, Craftie.Addon)
  end)
end
--first tab
Craftie.TabBottom[1].BG:SetTexture("Interface/FriendsFrame/UI-FriendsFrameTab")
--UI-FriendsFrameTab-InactiveTab
