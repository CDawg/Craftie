--[==[
Copyright ©2026 Porthias of Dreamscythe

The contents of this addon, excluding third-party resources, are
copyrighted to Porthias with all rights reserved.
This addon is free to use and the authors hereby grants you the following rights:
1. You may make modifications to this addon for private use only, you
   may not publicize any portion of this addon.
2. Do not modify the name of this addon, including the addon folders.
3. This copyright notice shall be included in all copies or substantial
  portions of the Software.
All rights not explicitly addressed in this license are reserved by
the copyright holders.
]==]--

Craftie.Logger_w = Craftie.Frame:GetWidth()-30
Craftie.Logger_h = Craftie.Frame:GetHeight()-30

Craftie.Logger = CreateFrame("Frame", nil, Craftie.Frame)
Craftie.Logger:SetWidth(Craftie.Logger_w)
Craftie.Logger:SetHeight(Craftie.Logger_h)
Craftie.Logger:SetPoint("TOPLEFT", 10, -62)
Craftie.LoggerScrollFrame={}
Craftie.LoggerScrollFrame = CreateFrame("Frame", Craftie.LoggerScrollFrame, Craftie.Logger, "BackdropTemplate")
Craftie.LoggerScrollFrame:SetWidth(Craftie.Logger_w+10)
Craftie.LoggerScrollFrame:SetHeight(Craftie.Logger_h-60)
Craftie.LoggerScrollFrame:SetPoint("TOPLEFT", 0, 0)
Craftie.LoggerScrollFrame:SetBackdrop(Craftie.Backdrop.General)
Craftie.LoggerScrollFrame:SetBackdropColor(0, 0, 0, 0.3)
Craftie.LoggerScrollFrame:SetBackdropBorderColor(1, 1, 1, 0)
Craftie.LoggerScrollFrame.Child = CreateFrame("ScrollFrame", nil, Craftie.LoggerScrollFrame, "UIPanelScrollFrameTemplate")
Craftie.LoggerScrollFrame.Child:SetPoint("TOPLEFT", Craftie.LoggerScrollFrame, "TOPLEFT", 3, -3)
Craftie.LoggerScrollFrame.Child:SetPoint("BOTTOMRIGHT", Craftie.LoggerScrollFrame, "BOTTOMRIGHT", 10, 4)
Craftie.LoggerScrollFrameChildFrame = CreateFrame("Frame", Craftie.LoggerScrollFrameChildFrame, Craftie.LoggerScrollFrame.Child)
Craftie.LoggerScrollFrameChildFrame:SetSize(Craftie.Logger_w-40, Craftie.Logger_h)
Craftie.LoggerScrollFrame.Child:SetScrollChild(Craftie.LoggerScrollFrameChildFrame)
Craftie.LoggerScrollFrame.Child.ScrollBar:ClearAllPoints()
Craftie.LoggerScrollFrame.Child.ScrollBar:SetPoint("TOPLEFT", Craftie.LoggerScrollFrame.Child, "TOPRIGHT", 0, -17)
Craftie.LoggerScrollFrame.Child.ScrollBar:SetPoint("BOTTOMRIGHT", Craftie.LoggerScrollFrame.Child, "BOTTOMRIGHT", -42, 14)
Craftie.Logger.Data = CreateFrame("EditBox", nil, Craftie.LoggerScrollFrameChildFrame)
Craftie.Logger.Data:SetWidth(Craftie.Logger_w-20)
Craftie.Logger.Data:SetHeight(Craftie.Logger_h)
--Craftie.Logger.Data:SetFontObject(GameFontWhite)
Craftie.Logger.Data:SetFont(Craftie._G.Font.Style, 10, "OUTLINE")
Craftie.Logger.Data:SetPoint("TOPLEFT", 4, -4)
Craftie.Logger.Data:SetMultiLine(true)
Craftie.Logger.Data:ClearFocus(self)
Craftie.Logger.Data:SetAutoFocus(false)
Craftie.Logger.Data:SetText("")
Craftie.Logger:Hide()
Craftie.ScrollBarBack(Craftie.LoggerScrollFrame)
