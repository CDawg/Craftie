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

--help/contact
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

Craftie.Help_w = Craftie.Frame:GetWidth()-30
Craftie.Help_h = Craftie.Frame:GetHeight()-30

Craftie.Help = CreateFrame("Frame", nil, Craftie.Frame)
Craftie.Help:SetWidth(Craftie.Help_w)
Craftie.Help:SetHeight(Craftie.Help_h)
Craftie.Help:SetPoint("TOPLEFT", 10, -62)
Craftie.HelpScrollFrame={}
Craftie.HelpScrollFrame = CreateFrame("Frame", Craftie.HelpScrollFrame, Craftie.Help, "BackdropTemplate")
Craftie.HelpScrollFrame:SetWidth(Craftie.Help_w+10)
Craftie.HelpScrollFrame:SetHeight(Craftie.Help_h-60)
Craftie.HelpScrollFrame:SetPoint("TOPLEFT", 0, 0)
Craftie.HelpScrollFrame:SetBackdrop(Craftie.Backdrop.General)
Craftie.HelpScrollFrame:SetBackdropColor(0, 0, 0, 0.3)
Craftie.HelpScrollFrame:SetBackdropBorderColor(1, 1, 1, 0)
Craftie.HelpScrollFrame.Child = CreateFrame("ScrollFrame", nil, Craftie.HelpScrollFrame, "UIPanelScrollFrameTemplate")
Craftie.HelpScrollFrame.Child:SetPoint("TOPLEFT", Craftie.HelpScrollFrame, "TOPLEFT", 3, -3)
Craftie.HelpScrollFrame.Child:SetPoint("BOTTOMRIGHT", Craftie.HelpScrollFrame, "BOTTOMRIGHT", 10, 4)
Craftie.HelpScrollFrameChildFrame = CreateFrame("Frame", Craftie.HelpScrollFrameChildFrame, Craftie.HelpScrollFrame.Child)
Craftie.HelpScrollFrameChildFrame:SetSize(Craftie.Help_w-40, Craftie.Help_h)
Craftie.HelpScrollFrame.Child:SetScrollChild(Craftie.HelpScrollFrameChildFrame)
Craftie.HelpScrollFrame.Child.ScrollBar:ClearAllPoints()
Craftie.HelpScrollFrame.Child.ScrollBar:SetPoint("TOPLEFT", Craftie.HelpScrollFrame.Child, "TOPRIGHT", 0, -17)
Craftie.HelpScrollFrame.Child.ScrollBar:SetPoint("BOTTOMRIGHT", Craftie.HelpScrollFrame.Child, "BOTTOMRIGHT", -42, 14)

Craftie.Help.Data = CreateFrame("EditBox", nil, Craftie.HelpScrollFrameChildFrame)
Craftie.Help.Data:SetWidth(Craftie.Help_w-20)
Craftie.Help.Data:SetHeight(Craftie.Help_h)
--Craftie.Help.Data:SetFontObject(GameFontWhite)
Craftie.Help.Data:SetFont(Craftie._G.Font.Style, 10, "OUTLINE")
Craftie.Help.Data:SetPoint("TOPLEFT", 4, -4)
Craftie.Help.Data:SetMultiLine(true)
Craftie.Help.Data:ClearFocus(self)
Craftie.Help.Data:SetAutoFocus(false)
Craftie.Help.Data:SetText("")
Craftie.Help:Hide()
