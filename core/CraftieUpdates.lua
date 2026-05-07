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

Craftie.Updates_w = Craftie.Frame:GetWidth()-30
Craftie.Updates_h = Craftie.Frame:GetHeight()-30

Craftie.Updates = CreateFrame("Frame", nil, Craftie.Frame)
Craftie.Updates:SetWidth(Craftie.Updates_w)
Craftie.Updates:SetHeight(Craftie.Updates_h)
Craftie.Updates:SetPoint("TOPLEFT", 10, -62)
Craftie.UpdatesScrollFrame={}
Craftie.UpdatesScrollFrame = CreateFrame("Frame", Craftie.UpdatesScrollFrame, Craftie.Updates, "BackdropTemplate")
Craftie.UpdatesScrollFrame:SetWidth(Craftie.Updates_w+10)
Craftie.UpdatesScrollFrame:SetHeight(Craftie.Updates_h-60)
Craftie.UpdatesScrollFrame:SetPoint("TOPLEFT", 0, 0)
Craftie.UpdatesScrollFrame:SetBackdrop(Craftie.Backdrop.General)
Craftie.UpdatesScrollFrame:SetBackdropColor(0, 0, 0, 0.3)
Craftie.UpdatesScrollFrame:SetBackdropBorderColor(1, 1, 1, 0)
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
Craftie.Updates.Data:SetFont(Craftie._G.font, 10, "OUTLINE")
Craftie.Updates.Data:SetPoint("TOPLEFT", 4, -4)
Craftie.Updates.Data:SetMultiLine(true)
Craftie.Updates.Data:ClearFocus(self)
Craftie.Updates.Data:SetAutoFocus(false)
Craftie.Updates.Data:SetText("")
Craftie.Updates:Hide()
