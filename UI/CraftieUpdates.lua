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

Craftie.Credits = [==[
Zzaps
And a few nameless heroes on Dreamscythe
Written by |cff006aa6Porthias|r (a.k.a. Port)
]==]

Craftie.Updates_w = Craftie.Frame:GetWidth()/2+20
Craftie.Updates_h = Craftie.Frame:GetHeight()-88

Craftie.Updates = CreateFrame("Frame", nil, Craftie.Frame, "InsetFrameTemplate")
Craftie.Updates:SetWidth(Craftie.Updates_w)
Craftie.Updates:SetHeight(Craftie.Updates_h)
Craftie.Updates:SetPoint("TOPLEFT", 4, -62)

Craftie.ScrollFrameUpdates = CreateFrame("Frame", Craftie.ScrollFrameUpdates, Craftie.Updates, "BackdropTemplate")
Craftie.ScrollFrameUpdates:SetWidth(Craftie.Updates:GetWidth())
Craftie.ScrollFrameUpdates:SetHeight(Craftie.Updates:GetHeight()-25) --room for title
Craftie.ScrollFrameUpdates:SetPoint("TOPLEFT", 0, -22)
Craftie.ScrollFrameUpdates:SetBackdrop(Craftie.Backdrop.General)
Craftie.ScrollFrameUpdates:SetBackdropColor(0, 1, 0, 0.05)
Craftie.ScrollFrameUpdates:SetBackdropBorderColor(1, 1, 1, 0)
Craftie.ScrollFrameUpdates.Child = CreateFrame("ScrollFrame", nil, Craftie.ScrollFrameUpdates, "UIPanelScrollFrameTemplate")
Craftie.ScrollFrameUpdates.Child:SetPoint("TOPLEFT", Craftie.ScrollFrameUpdates, "TOPLEFT", 5, -10) --room for title
Craftie.ScrollFrameUpdates.Child:SetPoint("BOTTOMRIGHT", Craftie.ScrollFrameUpdates, "BOTTOMRIGHT", 10, 5)
Craftie.ScrollFrameUpdatesChildFrame = CreateFrame("Frame", Craftie.ScrollFrameUpdatesChildFrame, Craftie.ScrollFrameUpdates.Child)
Craftie.ScrollFrameUpdatesChildFrame:SetSize(Craftie.Updates:GetWidth(), Craftie.Updates:GetHeight())
Craftie.ScrollFrameUpdates.Child:SetScrollChild(Craftie.ScrollFrameUpdatesChildFrame)
Craftie.ScrollFrameUpdates.Child.ScrollBar:ClearAllPoints()
Craftie.ScrollFrameUpdates.Child.ScrollBar:SetPoint("TOPLEFT", Craftie.ScrollFrameUpdates.Child, "TOPRIGHT", 0, -5)
Craftie.ScrollFrameUpdates.Child.ScrollBar:SetPoint("BOTTOMRIGHT", Craftie.ScrollFrameUpdates.Child, "BOTTOMRIGHT", -42, 5)

Craftie.ScrollBarFrame(Craftie.ScrollFrameUpdates.Child)

Craftie.Updates.Data = CreateFrame("EditBox", nil, Craftie.ScrollFrameUpdatesChildFrame)
Craftie.Updates.Data:SetWidth(Craftie.Updates:GetWidth()-20) --scrollbar
Craftie.Updates.Data:SetHeight(Craftie.Updates:GetHeight())
--Craftie.Updates.Data:SetFontObject(GameFontWhite)
Craftie.Updates.Data:SetFont(Craftie._G.Font.Style, 11, "OUTLINE")
Craftie.Updates.Data:SetPoint("TOPLEFT", 4, -4)
Craftie.Updates.Data:SetMultiLine(true)
Craftie.Updates.Data:ClearFocus(self)
Craftie.Updates.Data:SetAutoFocus(false)
Craftie.Updates:Hide()

local updates = Craftie.CHANGELOG:gsub("### ", "v"):gsub("*", "|cfffab734 >|r") .. "|n|n|n"
Craftie.Updates.Data:SetText(updates)


Craftie.Credit_w = Craftie.Frame:GetWidth()/2-35
Craftie.Credit_h = Craftie.Frame:GetHeight()-88

Craftie.Credit = CreateFrame("Frame", nil, Craftie.Frame, "InsetFrameTemplate")
Craftie.Credit:SetWidth(Craftie.Credit_w)
Craftie.Credit:SetHeight(Craftie.Credit_h)
Craftie.Credit:SetPoint("TOPLEFT", 435, -62)

Craftie.ScrollFrameCredits = CreateFrame("Frame", Craftie.ScrollFrameCredits, Craftie.Credit, "BackdropTemplate")
Craftie.ScrollFrameCredits:SetWidth(Craftie.Credit:GetWidth())
Craftie.ScrollFrameCredits:SetHeight(Craftie.Credit:GetHeight()-25) --room for title
Craftie.ScrollFrameCredits:SetPoint("TOPLEFT", 0, -22)
Craftie.ScrollFrameCredits:SetBackdrop(Craftie.Backdrop.General)
Craftie.ScrollFrameCredits:SetBackdropColor(1, 0, 0, 0.1)
Craftie.ScrollFrameCredits:SetBackdropBorderColor(1, 1, 1, 0)
Craftie.ScrollFrameCredits.Child = CreateFrame("ScrollFrame", nil, Craftie.ScrollFrameCredits, "UIPanelScrollFrameTemplate")
Craftie.ScrollFrameCredits.Child:SetPoint("TOPLEFT", Craftie.ScrollFrameCredits, "TOPLEFT", 5, -10)
Craftie.ScrollFrameCredits.Child:SetPoint("BOTTOMRIGHT", Craftie.ScrollFrameCredits, "BOTTOMRIGHT", 10, 5)
Craftie.ScrollFrameCreditsChildFrame = CreateFrame("Frame", Craftie.ScrollFrameCreditsChildFrame, Craftie.ScrollFrameCredits.Child)
Craftie.ScrollFrameCreditsChildFrame:SetSize(Craftie.Credit:GetWidth(), Craftie.Credit:GetHeight())
Craftie.ScrollFrameCredits.Child:SetScrollChild(Craftie.ScrollFrameCreditsChildFrame)
Craftie.ScrollFrameCredits.Child.ScrollBar:ClearAllPoints()
Craftie.ScrollFrameCredits.Child.ScrollBar:SetPoint("TOPLEFT", Craftie.ScrollFrameCredits.Child, "TOPRIGHT", 0, -5)
Craftie.ScrollFrameCredits.Child.ScrollBar:SetPoint("BOTTOMRIGHT", Craftie.ScrollFrameCredits.Child, "BOTTOMRIGHT", -42, 5)

Craftie.ScrollBarFrame(Craftie.ScrollFrameCredits.Child)

Craftie.Credit.Data = CreateFrame("EditBox", nil, Craftie.ScrollFrameCreditsChildFrame)
Craftie.Credit.Data:SetWidth(Craftie.Credit:GetWidth()-20)
Craftie.Credit.Data:SetHeight(Craftie.Credit:GetHeight())
--Craftie.Credit.Data:SetFontObject(GameFontWhite)
Craftie.Credit.Data:SetFont(Craftie._G.Font.Style, 12, "OUTLINE")
Craftie.Credit.Data:SetPoint("TOPLEFT", 4, -4)
Craftie.Credit.Data:SetMultiLine(true)
Craftie.Credit.Data:ClearFocus(self)
Craftie.Credit.Data:SetAutoFocus(false)
Craftie.Credit.Data:SetText(Craftie.Credits)
Craftie.Credit:Hide()
