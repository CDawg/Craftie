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

Craftie.CREDIT = {
  "Zzaps",
  "|nAnd a few nameless heroes on Dreamscythe|n",
  "Written by |cff006aa6Porthias|r (a.k.a. Port)",
}
Craftie.CONTACT = {
  "|n|cffffdf96Curseforge|r|nhttps://www.curseforge.com/wow/addons/craftie/",
  "|n|cffffdf96Discord (.porthios)|r|nhttps://discordapp.com/users/238146303324979200",
}

Craftie.INTRO = { --localize this?
  {
    "|cfffa7634 Totem Caddy Devs are looking for language translators! Please click the contact tab to get more details if you would like to contribute to Totem Caddy!|r",
    "",
    "|cfffab734First time using Totem Caddy?|r",
    "Select the Help tab for more info|n|n",
    "UPDATES",
  },
}

Craftie.HELP={}
Craftie.HELP.Tabs = {"Professions", "Updates", "Help", "Contact", "Credit"}

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

function Craftie.TabBottomSelect(tab)
  for k,v in pairs(Craftie.HELP.Tabs) do
    Craftie.TabBottom[k].BG:SetTexture("Interface/FriendsFrame/UI-FriendsFrameTab-InactiveTab")
  end
  Craftie.Frame.Parent.Scroll.Players:Hide()
  Craftie.Frame.Parent.Scroll.Recipes:Hide()
  Craftie.Frame.Parent.Craft:Hide()
  if (tab == 1) then
    --Craftie.BotLeft:Hide()
    --Craftie.BotMidd:Hide()
    Craftie.Frame.Parent.Craft:Show()
    Craftie.Frame.Parent.Scroll.Players:Show()
    Craftie.Frame.Parent.Scroll.Recipes:Show()
  end
  Craftie.TabBottom[tab].BG:SetTexture("Interface/FriendsFrame/UI-FriendsFrameTab")
  PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
end

Craftie.TabBottom={}
for k,v in pairs(Craftie.HELP.Tabs) do
  Craftie.TabBottom[k] = CreateFrame("Button", nil, Craftie.Frame, "BackdropTemplate")
  Craftie.TabBottom[k]:SetSize(74, 32)
  Craftie.TabBottom[k]:SetPoint("BOTTOMRIGHT", -400+((Craftie.TabBottom[k]:GetWidth()+4)*k), -28)
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
  Craftie.TabBottom[k].Text:SetFont(Craftie._G.font, 10, "OUTLINE")
  Craftie.TabBottom[k].Text:SetPoint("CENTER", 0, 0)
  Craftie.TabBottom[k].Text:SetText(v)
  Craftie.TabBottom[k].Text:SetTextColor(1, 1, 1, 1)
  Craftie.TabBottom[k]:SetScript("OnClick", function(self)
    Craftie.TabBottomSelect(k)
  end)
  Craftie.TabBottom[k]:SetScript("OnEnter", function(self)
    --Craftie.TooltipDisplay(self, Craftie._G.title, Craftie.Addon)
  end)
  Craftie.TabBottom[k]:SetScript("OnLeave", function(self)
    --Craftie.TooltipDisplay(self, Craftie._G.title, Craftie.Addon)
  end)
end
--first tab
Craftie.TabBottom[1].BG:SetTexture("Interface/FriendsFrame/UI-FriendsFrameTab")
--UI-FriendsFrameTab-InactiveTab
