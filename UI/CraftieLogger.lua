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

Craftie.Logger_w = 500
Craftie.Logger_h = 600

--Craftie.Logger = CreateFrame("Frame", "Craftie.Logger", UIParent, "UIPanelDialogTemplate")
--Craftie.Logger = CreateFrame("Frame", "Craftie.Logger", UIParent, "ButtonFrameTemplate")
Craftie.Logger = CreateFrame("Frame", "Craftie.Logger", UIParent, "BasicFrameTemplateWithInset")
Craftie.Logger:SetWidth(Craftie.Logger_w)
Craftie.Logger:SetHeight(Craftie.Logger_h)
Craftie.Logger:SetPoint("CENTER", 0, 0)
Craftie.Logger:SetMovable(true)
Craftie.Logger:EnableMouse(true)
Craftie.Logger:RegisterForDrag("LeftButton")
Craftie.Logger:SetScript("OnDragStart", function()
  Craftie.Logger:StartMoving()
end)
Craftie.Logger:SetScript("OnDragStop", function()
  Craftie.Logger:StopMovingOrSizing()
  --local point, relativeTo, relativePoint, xOfs, yOfs = Craftie.Logger:GetPoint()
end)
Craftie.Logger:SetFrameStrata("LOW")
Craftie.Logger.Title = Craftie.Logger:CreateFontString(nil, "ARTWORK")
Craftie.Logger.Title:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
Craftie.Logger.Title:SetPoint("TOPLEFT", 8, -6)
Craftie.Logger.Title:SetText(Craftie._G.Title .. " Debug Logger")

Craftie.Logger.ScrollFrame={}
Craftie.Logger.ScrollFrame = CreateFrame("Frame", Craftie.Logger.ScrollFrame, Craftie.Logger, "BackdropTemplate")
Craftie.Logger.ScrollFrame:SetWidth(Craftie.Logger_w-10)
Craftie.Logger.ScrollFrame:SetHeight(Craftie.Logger_h-32)
Craftie.Logger.ScrollFrame:SetPoint("TOPLEFT", 5, -24)
Craftie.Logger.ScrollFrame:SetBackdrop(Craftie.Backdrop.General)
Craftie.Logger.ScrollFrame:SetBackdropColor(0, 0, 0, 0)
Craftie.Logger.ScrollFrame:SetBackdropBorderColor(1, 1, 1, 0)
Craftie.Logger.ScrollFrame.Child = CreateFrame("ScrollFrame", nil, Craftie.Logger.ScrollFrame, "UIPanelScrollFrameTemplate")
Craftie.Logger.ScrollFrame.Child:SetPoint("TOPLEFT", Craftie.Logger.ScrollFrame, "TOPLEFT", 3, -30)
Craftie.Logger.ScrollFrame.Child:SetPoint("BOTTOMRIGHT", Craftie.Logger.ScrollFrame, "BOTTOMRIGHT", 10, 4)
Craftie.Logger.ScrollFrameChildFrame = CreateFrame("Frame", Craftie.Logger.ScrollFrameChildFrame, Craftie.Logger.ScrollFrame.Child)
Craftie.Logger.ScrollFrameChildFrame:SetSize(Craftie.Logger_w-40, Craftie.Logger_h)
Craftie.Logger.ScrollFrame.Child:SetScrollChild(Craftie.Logger.ScrollFrameChildFrame)
Craftie.Logger.ScrollFrame.Child.ScrollBar:ClearAllPoints()
Craftie.Logger.ScrollFrame.Child.ScrollBar:SetPoint("TOPLEFT", Craftie.Logger.ScrollFrame.Child, "TOPRIGHT", 0, 10)
Craftie.Logger.ScrollFrame.Child.ScrollBar:SetPoint("BOTTOMRIGHT", Craftie.Logger.ScrollFrame.Child, "BOTTOMRIGHT", -42, 14)

Craftie.Logger.Data = CreateFrame("EditBox", nil, Craftie.Logger.ScrollFrameChildFrame)
Craftie.Logger.Data:SetWidth(Craftie.Logger_w-45)
Craftie.Logger.Data:SetHeight(Craftie.Logger_h)
Craftie.Logger.Data:SetFont(Craftie._G.Font.Style, 10, "OUTLINE")
Craftie.Logger.Data:SetPoint("TOPLEFT", 4, -4)
Craftie.Logger.Data:SetMultiLine(true)
Craftie.Logger.Data:ClearFocus(self)
Craftie.Logger.Data:SetAutoFocus(false)
Craftie.Logger.Data:SetText("")

Craftie.ScrollBarBack(Craftie.Logger.ScrollFrame)
--Craftie.Logger:Hide()
--Craftie.Logger.ScrollFrame.Child.ScrollBar.ScrollUpButton:Hide()
