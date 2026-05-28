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
Craftie.Logger.ScrollFrame:SetWidth(Craftie.Logger_w-20)
Craftie.Logger.ScrollFrame:SetHeight(Craftie.Logger_h-32)
Craftie.Logger.ScrollFrame:SetPoint("TOPLEFT", 15, -24)
Craftie.Logger.ScrollFrame:SetBackdrop(Craftie.Backdrop.General)
Craftie.Logger.ScrollFrame:SetBackdropColor(0, 0, 0, 0)
Craftie.Logger.ScrollFrame:SetBackdropBorderColor(1, 1, 1, 0)
Craftie.Logger.ScrollFrame.Child = CreateFrame("ScrollFrame", nil, Craftie.Logger.ScrollFrame, "UIPanelScrollFrameTemplate")
Craftie.Logger.ScrollFrame.Child:SetPoint("TOPLEFT", Craftie.Logger.ScrollFrame, "TOPLEFT", -5, -30)
Craftie.Logger.ScrollFrame.Child:SetPoint("BOTTOMRIGHT", Craftie.Logger.ScrollFrame, "BOTTOMRIGHT", 8, 4)
Craftie.Logger.ScrollFrameChildFrame = CreateFrame("Frame", Craftie.Logger.ScrollFrameChildFrame, Craftie.Logger.ScrollFrame.Child)
Craftie.Logger.ScrollFrameChildFrame:SetSize(Craftie.Logger_w-40, Craftie.Logger_h)
Craftie.Logger.ScrollFrame.Child:SetScrollChild(Craftie.Logger.ScrollFrameChildFrame)
Craftie.Logger.ScrollFrame.Child.ScrollBar:ClearAllPoints()
Craftie.Logger.ScrollFrame.Child.ScrollBar:SetPoint("TOPLEFT", Craftie.Logger.ScrollFrame.Child, "TOPRIGHT", -5, 10)
Craftie.Logger.ScrollFrame.Child.ScrollBar:SetPoint("BOTTOMRIGHT", Craftie.Logger.ScrollFrame.Child, "BOTTOMRIGHT", -36, 14)

Craftie.ScrollBarFrame(Craftie.Logger.ScrollFrame.Child)

Craftie.Logger.ColStamp = CreateFrame("Button", Craftie.Logger.ScrollFrame, Craftie.Logger, "BackdropTemplate")
Craftie.Logger.ColStamp:SetWidth(90)
Craftie.Logger.ColStamp:SetHeight(28)
Craftie.Logger.ColStamp:SetPoint("TOPLEFT", 6, -26)
Craftie.Logger.ColStamp:SetBackdrop(Craftie.Backdrop.General)
Craftie.Logger.ColStamp:SetBackdropColor(0.6, 0.6, 0.5, 0.8)
Craftie.Logger.ColStamp:SetBackdropBorderColor(0.2, 0.2, 0.2, 0.5)
Craftie.Logger.ColStampText = Craftie.Logger.ColStamp:CreateFontString(nil, "ARTWORK")
Craftie.Logger.ColStampText:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
Craftie.Logger.ColStampText:SetPoint("TOPLEFT", 15, -10)
Craftie.Logger.ColStampText:SetText("Date")
Craftie.Logger.ColStamp:SetScript("OnClick", function()
  if (Craftie.SortOrder == 1) then
    Craftie.SortOrder = 0
    Craftie.Logger.ColStampArrUp:Show()
    Craftie.Logger.ColStampArrDn:Hide()
    Craftie.Notification("Craftie.LoggerSort(AtoZ)", true)
  else
    Craftie.SortOrder = 1
    Craftie.Logger.ColStampArrUp:Hide()
    Craftie.Logger.ColStampArrDn:Show()
    Craftie.Notification("Craftie.LoggerSort(ZtoA)", true)
  end
end)
Craftie.Logger.ColStampArr = Craftie.Logger.ColStamp:CreateTexture(nil, "ARTWORK")
Craftie.Logger.ColStampArr:SetSize(12, 20)
Craftie.Logger.ColStampArr:SetPoint("TOPLEFT", 60, -5)
Craftie.Logger.ColStampArr:SetTexture("Interface/MINIMAP/MiniMap-PositionArrows")
Craftie.Logger.ColStampArr:SetAlpha(0.5)
Craftie.Logger.ColStampArrUp = Craftie.Logger.ColStamp:CreateTexture(nil, "OVERLAY")
Craftie.Logger.ColStampArrUp:SetSize(11, 12)
Craftie.Logger.ColStampArrUp:SetPoint("TOPLEFT", 60, -1)
Craftie.Logger.ColStampArrUp:SetTexture("Interface/Buttons/Arrow-Up-Down")
Craftie.Logger.ColStampArrUp:Show()
Craftie.Logger.ColStampArrDn = Craftie.Logger.ColStamp:CreateTexture(nil, "OVERLAY")
Craftie.Logger.ColStampArrDn:SetSize(11, 12)
Craftie.Logger.ColStampArrDn:SetPoint("TOPLEFT", 60, -16)
Craftie.Logger.ColStampArrDn:SetTexture("Interface/Buttons/Arrow-Down-Down")
Craftie.Logger.ColStampArrDn:Hide()

Craftie.Logger.ColData = CreateFrame("Button", Craftie.Logger.ScrollFrame, Craftie.Logger, "BackdropTemplate")
Craftie.Logger.ColData:SetWidth(380)
Craftie.Logger.ColData:SetHeight(28)
Craftie.Logger.ColData:SetPoint("TOPLEFT", 94, -26)
Craftie.Logger.ColData:SetBackdrop(Craftie.Backdrop.General)
Craftie.Logger.ColData:SetBackdropColor(0.6, 0.6, 0.5, 0.8)
Craftie.Logger.ColData:SetBackdropBorderColor(0.2, 0.2, 0.2, 0.5)
Craftie.Logger.ColDataText = Craftie.Logger.ColData:CreateFontString(nil, "ARTWORK")
Craftie.Logger.ColDataText:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
Craftie.Logger.ColDataText:SetPoint("TOPLEFT", 15, -10)
Craftie.Logger.ColDataText:SetText("Log")

Craftie.Logger.Data = CreateFrame("EditBox", nil, Craftie.Logger.ScrollFrameChildFrame)
Craftie.Logger.Data:SetWidth(Craftie.Logger_w-45)
Craftie.Logger.Data:SetHeight(Craftie.Logger_h)
Craftie.Logger.Data:SetFont(Craftie._G.Font.Style, 11, "OUTLINE | SLUG")
Craftie.Logger.Data:SetPoint("TOPLEFT", 2, -4)
Craftie.Logger.Data:SetMultiLine(true)
Craftie.Logger.Data:ClearFocus(self)
Craftie.Logger.Data:SetAutoFocus(false)
Craftie.Logger.Data:SetText("")

--Craftie.Logger:Hide()
--Craftie.Logger.ScrollFrame.Child.ScrollBar.ScrollUpButton:Hide()
function Craftie.SortLogger(reverse)
end