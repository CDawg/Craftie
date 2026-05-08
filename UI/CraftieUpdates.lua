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

--updates/credits
Craftie.CREDIT = {
  "Zzaps",
  "|nAnd a few nameless heroes on Dreamscythe|n",
  "Written by |cff006aa6Porthias|r (a.k.a. Port)",
}

Craftie.Updates_w = Craftie.Frame:GetWidth()/2
Craftie.Updates_h = Craftie.Frame:GetHeight()-60

Craftie.Updates = CreateFrame("Frame", nil, Craftie.Frame)
Craftie.Updates:SetWidth(Craftie.Updates_w)
Craftie.Updates:SetHeight(Craftie.Updates_h)
Craftie.Updates:SetPoint("TOPLEFT", 10, -92)

Craftie.DividerHorz(Craftie.Updates, -6, 8, Craftie.Frame:GetWidth()-32)

Craftie.DividerVert(Craftie.Updates, 400, -15, 312)

Craftie.UpdatesScrollFrame = CreateFrame("Frame", Craftie.UpdatesScrollFrame, Craftie.Updates, "BackdropTemplate")
Craftie.UpdatesScrollFrame:SetWidth(Craftie.Updates_w+10)
Craftie.UpdatesScrollFrame:SetHeight(Craftie.Updates_h-60)
Craftie.UpdatesScrollFrame:SetPoint("TOPLEFT", 0, 0)
Craftie.UpdatesScrollFrame:SetBackdrop(Craftie.Backdrop.General)
Craftie.UpdatesScrollFrame:SetBackdropColor(0, 0, 0, 0.3)
Craftie.UpdatesScrollFrame:SetBackdropBorderColor(1, 1, 1, 0.1)
Craftie.UpdatesScrollFrame.Child = CreateFrame("ScrollFrame", nil, Craftie.UpdatesScrollFrame, "UIPanelScrollFrameTemplate")
Craftie.UpdatesScrollFrame.Child:SetPoint("TOPLEFT", Craftie.UpdatesScrollFrame, "TOPLEFT", 3, -3)
Craftie.UpdatesScrollFrame.Child:SetPoint("BOTTOMRIGHT", Craftie.UpdatesScrollFrame, "BOTTOMRIGHT", 10, 4)
Craftie.UpdatesScrollFrameChildFrame = CreateFrame("Frame", Craftie.UpdatesScrollFrameChildFrame, Craftie.UpdatesScrollFrame.Child)
Craftie.UpdatesScrollFrameChildFrame:SetSize(Craftie.Updates_w-40, Craftie.Updates_h)
Craftie.UpdatesScrollFrame.Child:SetScrollChild(Craftie.UpdatesScrollFrameChildFrame)
Craftie.UpdatesScrollFrame.Child.ScrollBar:ClearAllPoints()
Craftie.UpdatesScrollFrame.Child.ScrollBar:SetPoint("TOPLEFT", Craftie.UpdatesScrollFrame.Child, "TOPRIGHT", 0, -17)
Craftie.UpdatesScrollFrame.Child.ScrollBar:SetPoint("BOTTOMRIGHT", Craftie.UpdatesScrollFrame.Child, "BOTTOMRIGHT", -42, 14)
Craftie.Updates.Data = CreateFrame("EditBox", nil, Craftie.UpdatesScrollFrameChildFrame)
Craftie.Updates.Data:SetWidth(Craftie.Updates_w-20)
Craftie.Updates.Data:SetHeight(Craftie.Updates_h)
--Craftie.Updates.Data:SetFontObject(GameFontWhite)
Craftie.Updates.Data:SetFont(Craftie._G.Font.Style, 10, "OUTLINE")
Craftie.Updates.Data:SetPoint("TOPLEFT", 4, -4)
Craftie.Updates.Data:SetMultiLine(true)
Craftie.Updates.Data:ClearFocus(self)
Craftie.Updates.Data:SetAutoFocus(false)
Craftie.Updates:Hide()

--Craftie.Update = Craftie.ArrayToString(TOCA._L.INTRO[1]) .. "|n" .. TOCA.CHANGELOG:gsub("###", ""):gsub("*", "|cfffab734>|r") .. "|n|n|n"
local updates = Craftie.CHANGELOG:gsub("### ", "v"):gsub("*", "|cfffab734 >|r") .. "|n|n|n"
Craftie.Updates.Data:SetText(updates)


Craftie.Credit_w = Craftie.Frame:GetWidth()/2
Craftie.Credit_h = Craftie.Frame:GetHeight()-30

Craftie.Credit = CreateFrame("Frame", nil, Craftie.Frame)
Craftie.Credit:SetWidth(Craftie.Credit_w)
Craftie.Credit:SetHeight(Craftie.Credit_h)
Craftie.Credit:SetPoint("TOPLEFT", 10, -62)
Craftie.CreditScrollFrame={}
Craftie.CreditScrollFrame = CreateFrame("Frame", Craftie.CreditScrollFrame, Craftie.Credit, "BackdropTemplate")
Craftie.CreditScrollFrame:SetWidth(Craftie.Credit_w+10)
Craftie.CreditScrollFrame:SetHeight(Craftie.Credit_h-60)
Craftie.CreditScrollFrame:SetPoint("TOPLEFT", 0, 0)
Craftie.CreditScrollFrame:SetBackdrop(Craftie.Backdrop.General)
Craftie.CreditScrollFrame:SetBackdropColor(0, 0, 0, 0.3)
Craftie.CreditScrollFrame:SetBackdropBorderColor(1, 1, 1, 0)
Craftie.CreditScrollFrame.Child = CreateFrame("ScrollFrame", nil, Craftie.CreditScrollFrame, "UIPanelScrollFrameTemplate")
Craftie.CreditScrollFrame.Child:SetPoint("TOPLEFT", Craftie.CreditScrollFrame, "TOPLEFT", 3, -3)
Craftie.CreditScrollFrame.Child:SetPoint("BOTTOMRIGHT", Craftie.CreditScrollFrame, "BOTTOMRIGHT", 10, 4)
Craftie.CreditScrollFrameChildFrame = CreateFrame("Frame", Craftie.CreditScrollFrameChildFrame, Craftie.CreditScrollFrame.Child)
Craftie.CreditScrollFrameChildFrame:SetSize(Craftie.Credit_w-40, Craftie.Credit_h)
Craftie.CreditScrollFrame.Child:SetScrollChild(Craftie.CreditScrollFrameChildFrame)
Craftie.CreditScrollFrame.Child.ScrollBar:ClearAllPoints()
Craftie.CreditScrollFrame.Child.ScrollBar:SetPoint("TOPLEFT", Craftie.CreditScrollFrame.Child, "TOPRIGHT", 0, -17)
Craftie.CreditScrollFrame.Child.ScrollBar:SetPoint("BOTTOMRIGHT", Craftie.CreditScrollFrame.Child, "BOTTOMRIGHT", -42, 14)
Craftie.Credit.Data = CreateFrame("EditBox", nil, Craftie.CreditScrollFrameChildFrame)
Craftie.Credit.Data:SetWidth(Craftie.Credit_w-20)
Craftie.Credit.Data:SetHeight(Craftie.Credit_h)
--Craftie.Credit.Data:SetFontObject(GameFontWhite)
Craftie.Credit.Data:SetFont(Craftie._G.Font.Style, 10, "OUTLINE")
Craftie.Credit.Data:SetPoint("TOPLEFT", 4, -4)
Craftie.Credit.Data:SetMultiLine(true)
Craftie.Credit.Data:ClearFocus(self)
Craftie.Credit.Data:SetAutoFocus(false)
Craftie.Credit.Data:SetText("")
Craftie.Credit:Hide()

--local credits = Craftie.ArrayToString()