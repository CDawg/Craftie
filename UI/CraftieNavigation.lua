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

local TabOffset = 430

Craftie.TabBottom={}
for k,v in pairs(Craftie._L.Navigation) do
  Craftie.TabBottom[k] = CreateFrame("Button", nil, Craftie.Frame, "BackdropTemplate")
  Craftie.TabBottom[k]:SetSize(80, 38)
  Craftie.TabBottom[k]:SetPoint("BOTTOMRIGHT", -TabOffset+((Craftie.TabBottom[k]:GetWidth()+4)*k), -34)
  Craftie.TabBottom[k]:SetBackdrop(Craftie.Backdrop.General)
  Craftie.TabBottom[k]:SetBackdropColor(0, 1, 0, 0)
  Craftie.TabBottom[k]:SetBackdropBorderColor(1, 1, 1, 0)
  Craftie.TabBottom[k].BG = Craftie.TabBottom[k]:CreateTexture(nil, "BACKGROUND")
  Craftie.TabBottom[k].BG:SetSize(Craftie.TabBottom[k]:GetWidth(), 44)
  Craftie.TabBottom[k].BG:SetPoint("CENTER", 0, -4)
  Craftie.TabBottom[k].BG:SetTexture(Craftie._G.Image.Tab.Inactive)
  Craftie.TabBottom[k].Highlight = Craftie.TabBottom[k]:CreateTexture(nil, "BORDER")
  Craftie.TabBottom[k].Highlight:SetSize(Craftie.TabBottom[k]:GetWidth()-4, 18)
  Craftie.TabBottom[k].Highlight:SetPoint("CENTER", 0, -2)
  Craftie.TabBottom[k].Highlight:SetTexture("Interface/PaperDollInfoFrame/UI-Character-Tab-Highlight")
  Craftie.TabBottom[k].Highlight:SetBlendMode("ADD")
  Craftie.TabBottom[k].Highlight:SetAlpha(0.3)

  Craftie.TabBottom[k].Highlight:Hide()

  Craftie.TabBottom[k].Text = Craftie.TabBottom[k]:CreateFontString(nil, "ARTWORK")
  Craftie.TabBottom[k].Text:SetFont(Craftie._G.Font.Style.Alpha, Craftie._G.Font.Size-1, Craftie._G.Font.Flags)
  Craftie.TabBottom[k].Text:SetPoint("CENTER", 0, 0)
  Craftie.TabBottom[k].Text:SetWidth(76)
  Craftie.TabBottom[k].Text:SetText(v)
  Craftie.TabBottom[k].Text:SetTextColor(1, 1, 1, 0.7)
  Craftie.TabBottom[k]:SetScript("OnClick", function(self)
    Craftie:TabSelectBottom(k, true)
  end)
  Craftie.TabBottom[k]:SetScript("OnEnter", function(self)
    Craftie.TabBottom[k].Highlight:Show()
  end)
  Craftie.TabBottom[k]:SetScript("OnLeave", function(self)
    Craftie.TabBottom[k].Highlight:Hide()
  end)
end

--tab 3 = orders
--blizzard's UI is broken, have to draw AFTER and use tab as the parent
Craftie.TabBottomOrderAlert = Craftie.TabBottom[3]:CreateTexture(nil, "OVERLAY", nil, 7)
Craftie.TabBottomOrderAlert:SetSize(50, 50)
Craftie.TabBottomOrderAlert:SetPoint("CENTER", 20, 0)
Craftie.TabBottomOrderAlert:SetTexture("Interface/UNITPOWERBARALT/PandarenTraining_Circular_Flash")
Craftie.TabBottomOrderAlert:SetBlendMode("ADD")
Craftie.TabBottomOrderAlert:SetDrawLayer("OVERLAY", 7)
Craftie.TabBottomOrderAlert:Hide()

function Craftie:TabSelectBottom(tab, sound)
  Craftie.Frame.ScrollPlayersParent:Hide()
  Craftie.Frame.ScrollRecipesParent:Hide()
  Craftie.Frame.CraftParent:Hide()
  Craftie.Frame.CraftOrders:Hide()
  Craftie.Updates:Hide()
  Craftie.Credit:Hide()
  Craftie.Help:Hide()
  Craftie.Frame.Title:Hide()
  Craftie.Frame.Mastery:SetText("")
  --Craftie.Frame.TitleNavigation:Show()
  Craftie.Frame.CrafterProgBarFrame:Hide()
  --Craftie.Frame.CrafterProgBar:Hide()

  for k,v in pairs(Craftie._L.Navigation) do
    Craftie.TabBottom[k].BG:SetTexture(Craftie._G.Image.Tab.Inactive)
    Craftie.TabBottom[k].Text:SetTextColor(1, 1, 1, 0.7)
    Craftie.TabBottom[k].Text:SetPoint("CENTER", 0, 0)
  end

  if (tab == 1) then --professions
    Craftie.TabBarHide = 0
    --Craftie.Frame.TitleNavigation:Hide()
    Craftie.Frame.Title:Show()
    Craftie.Frame.CraftParent:Show()
    Craftie.Frame.ScrollPlayersParent:Show()
    Craftie.Frame.ScrollRecipesParent:Show()
    Craftie:TabSelectSide(Craftie:GetKeyFromValue(Craftie.Professions, Craftie.Page, 2))
  end
  if (tab == 2) then
    Craftie.TabBarHide = Craftie.TabBarHide+1
  end
  if (tab == 3) then
    Craftie.TabBarHide = Craftie.TabBarHide+1
    Craftie.Frame.CraftOrders:Show()
  end
  if (tab == 4) then
    Craftie.TabBarHide = Craftie.TabBarHide+1
    Craftie.Updates:Show()
    Craftie.Credit:Show()
  end
  if (tab == 5) then
    Craftie.TabBarHide = Craftie.TabBarHide+1
    Craftie.Help:Show()
  end
  if (tab == 6) then
    Craftie.TabBarHide = Craftie.TabBarHide+1
    --Craftie.Logger:Show()
  end

  if (sound) then
    PlaySound(SOUNDKIT.IG_CHARACTER_INFO_TAB)
    Craftie:TimerAnim(Craftie.Frame.TabBar, 1)
  end

  Craftie.TabBottom[tab].BG:SetTexture(Craftie._G.Image.Tab.Active)
  Craftie.TabBottom[tab].Text:SetTextColor(1, 1, 0.4, 1)
  Craftie.TabBottom[tab].Text:SetPoint("CENTER", 0, -2)
end

--first tab
Craftie.TabBottom[1].BG:SetTexture("Interface/FriendsFrame/UI-FriendsFrameTab")
