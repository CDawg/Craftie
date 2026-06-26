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
local CraftieNavTabs = {"Professions", "Orders", "Updates", "Help"}

Craftie.TabBottom={}
local bottomTabOffset = 345
for k,v in pairs(CraftieNavTabs) do
  Craftie.TabBottom[k] = CreateFrame("Button", nil, Craftie.Frame, "BackdropTemplate")
  Craftie.TabBottom[k]:SetSize(80, 38)
  Craftie.TabBottom[k]:SetPoint("BOTTOMRIGHT", -bottomTabOffset+((Craftie.TabBottom[k]:GetWidth()+4)*k), -34)
  Craftie.TabBottom[k]:SetBackdrop(Craftie.Backdrop.General)
  Craftie.TabBottom[k]:SetBackdropColor(0, 1, 0, 0)
  Craftie.TabBottom[k]:SetBackdropBorderColor(1, 1, 1, 0)
  Craftie.TabBottom[k].BG = Craftie.TabBottom[k]:CreateTexture(nil, "BACKGROUND")
  Craftie.TabBottom[k].BG:SetSize(Craftie.TabBottom[k]:GetWidth(), 44)
  Craftie.TabBottom[k].BG:SetPoint("CENTER", 0, -4)
  Craftie.TabBottom[k].BG:SetTexture(Craftie._G.Path .. "Images/UI-CraftieBottomTab-Inactive.png")
  Craftie.TabBottom[k].Highlight = Craftie.TabBottom[k]:CreateTexture(nil, "BORDER")
  Craftie.TabBottom[k].Highlight:SetSize(Craftie.TabBottom[k]:GetWidth()-4, 18)
  Craftie.TabBottom[k].Highlight:SetPoint("CENTER", 0, -2)
  Craftie.TabBottom[k].Highlight:SetTexture("Interface/PaperDollInfoFrame/UI-Character-Tab-Highlight")
  Craftie.TabBottom[k].Highlight:SetBlendMode("ADD")
  Craftie.TabBottom[k].Highlight:SetAlpha(0.3)

  Craftie.TabBottom[k].Highlight:Hide()

  Craftie.TabBottom[k].Text = Craftie.TabBottom[k]:CreateFontString(nil, "ARTWORK")
  Craftie.TabBottom[k].Text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size-1, "OUTLINE")
  Craftie.TabBottom[k].Text:SetPoint("CENTER", 0, 0)
  Craftie.TabBottom[k].Text:SetText(v)
  Craftie.TabBottom[k].Text:SetTextColor(1, 1, 1, 0.7)
  Craftie.TabBottom[k]:SetScript("OnClick", function(self)
    Craftie:TabSelectBottom(k, true)
  end)
  Craftie.TabBottom[k]:SetScript("OnEnter", function(self)
    Craftie.TabBottom[k].Highlight:Show()
    --Craftie.TooltipDisplay(self, Craftie._G.Title, Craftie.Addon)
  end)
  Craftie.TabBottom[k]:SetScript("OnLeave", function(self)
    Craftie.TabBottom[k].Highlight:Hide()
    --Craftie.TooltipDisplay(self, Craftie._G.Title, Craftie.Addon)
  end)
end

function Craftie:TabSelectBottom(tab, sound)
  Craftie.Frame.ScrollPlayersParent:Hide()
  Craftie.Frame.ScrollRecipesParent:Hide()
  Craftie.Frame.CraftParent:Hide()
  Craftie.Updates:Hide()
  Craftie.Credit:Hide()
  Craftie.Help:Hide()
  Craftie.Frame.Title.Prof:Hide()
  Craftie.Frame.Title.Sub:Show()
  Craftie.Frame.ItemerLevel:Hide()
  Craftie.Frame.ItemerProgBarS:Hide()

  for k,v in pairs(CraftieNavTabs) do
    Craftie.TabBottom[k].BG:SetTexture(Craftie._G.Path .. "Images/UI-CraftieBottomTab-Inactive.png")
    Craftie.TabBottom[k].Text:SetTextColor(1, 1, 1, 0.7)
  end

  if (tab == 1) then --professions
    Craftie.TabBarHide = 0
    Craftie.Frame.Title.Sub:Hide()
    Craftie.Frame.Title.Prof:Show()
    Craftie.Frame.CraftParent:Show()
    Craftie.Frame.ScrollPlayersParent:Show()
    Craftie.Frame.ScrollRecipesParent:Show()
    Craftie:TabSelectSide(Craftie:GetKeyFromValue(Craftie.Professions, Craftie.Page, 1))
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
    --Craftie.Logger:Show()
  end

  if (sound) then
    PlaySound(SOUNDKIT.IG_CHARACTER_INFO_TAB)
    Craftie:TimerAnim(Craftie.Frame.TabBar, 1) --animate the tab bar after Init()
  end

  Craftie.TabBottom[tab].BG:SetTexture(Craftie._G.Path .. "Images/UI-CraftieBottomTab-Active.png")
  Craftie.TabBottom[tab].Text:SetTextColor(1, 1, 1, 1)
  Craftie.Frame.Title.Sub:SetText(CraftieNavTabs[tab])
end

--first tab
Craftie.TabBottom[1].BG:SetTexture("Interface/FriendsFrame/UI-FriendsFrameTab")
--UI-FriendsFrameTab-InactiveTab
