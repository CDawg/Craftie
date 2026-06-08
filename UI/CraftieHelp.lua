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

--Help / Contact
Craftie.Contact = {
  "|n|cffffdf96Curseforge|r|nhttps://www.curseforge.com/wow/addons/craftie/",
  "|n|cffffdf96Discord (.porthios)|r|nhttps://discordapp.com/users/238146303324979200",
}

Craftie.Help_w = Craftie.Frame:GetWidth()-12
Craftie.Help_h = Craftie.Frame:GetHeight()-88

Craftie.Help = CreateFrame("Frame", "Craftie.Help", Craftie.Frame)
Craftie.Help:SetWidth(Craftie.Help_w)
Craftie.Help:SetHeight(Craftie.Help_h)
Craftie.Help:SetPoint("TOPLEFT", 4, -62)
--Craftie.Help:SetFrameStrata("MEDIUM")

Craftie.HelpScrollFrame={}
Craftie.HelpScrollFrame = CreateFrame("Frame", "Craftie.HelpScrollFrame", Craftie.Help, "InsetFrameTemplate3")
Craftie.HelpScrollFrame:SetWidth(Craftie.Help:GetWidth())
Craftie.HelpScrollFrame:SetHeight(Craftie.Help:GetHeight())
Craftie.HelpScrollFrame:SetPoint("TOPLEFT", 0, 0)

Craftie.HelpScrollFrame.Child = CreateFrame("ScrollFrame", nil, Craftie.HelpScrollFrame, "UIPanelScrollFrameTemplate")
Craftie.HelpScrollFrame.Child:SetPoint("TOPLEFT", Craftie.HelpScrollFrame, "TOPLEFT", 5, -10)
Craftie.HelpScrollFrame.Child:SetPoint("BOTTOMRIGHT", Craftie.HelpScrollFrame, "BOTTOMRIGHT", 10, 10)
Craftie.HelpScrollFrameChildFrame = CreateFrame("Frame", "Craftie.HelpScrollFrameChildFrame", Craftie.HelpScrollFrame.Child)
Craftie.HelpScrollFrameChildFrame:SetSize(Craftie.Help:GetWidth(), Craftie.Help:GetHeight())
Craftie.HelpScrollFrame.Child:SetScrollChild(Craftie.HelpScrollFrameChildFrame)
Craftie.HelpScrollFrame.Child.ScrollBar:ClearAllPoints()
Craftie.HelpScrollFrame.Child.ScrollBar:SetPoint("TOPLEFT", Craftie.HelpScrollFrame.Child, "TOPRIGHT", 0, -5)
Craftie.HelpScrollFrame.Child.ScrollBar:SetPoint("BOTTOMRIGHT", Craftie.HelpScrollFrame.Child, "BOTTOMRIGHT", -42, 5)

Craftie:ScrollBarFrame(Craftie.HelpScrollFrame.Child)

Craftie.Help.Data = CreateFrame("EditBox", nil, Craftie.HelpScrollFrameChildFrame)
Craftie.Help.Data:SetWidth(Craftie.Help:GetWidth()-20)
Craftie.Help.Data:SetHeight(Craftie.Help:GetHeight())
--Craftie.Help.Data:SetFontObject(GameFontWhite)
Craftie.Help.Data:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size-1, "OUTLINE")
Craftie.Help.Data:SetPoint("TOPLEFT", 4, -4)
Craftie.Help.Data:SetMultiLine(true)
Craftie.Help.Data:ClearFocus()
Craftie.Help.Data:SetAutoFocus(false)
Craftie.Help.Data:SetText("")
Craftie.Help:Hide()
