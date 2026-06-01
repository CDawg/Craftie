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

Craftie.Logger_w = 800
Craftie.Logger_h = 600

Craftie.Logger = CreateFrame("Frame", Craftie.Logger, UIParent, "BackdropTemplate")
Craftie.Logger:SetWidth(Craftie.Logger_w)
Craftie.Logger:SetHeight(Craftie.Logger_h)
Craftie.Logger:SetPoint("CENTER", 0, 0)
Craftie.Logger:SetFrameStrata("BACKGROUND")
Craftie.Logger:SetBackdrop(Craftie.Backdrop.General)
Craftie.Logger:SetBackdropColor(0, 0, 0, 1)
Craftie.Logger:SetBackdropBorderColor(0, 0, 0, 0)
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
Craftie.Logger.Background = CreateFrame("Frame", nil, Craftie.Logger, "BaseBasicFrameTemplate")
Craftie.Logger.Background:SetWidth(Craftie.Logger:GetWidth())
Craftie.Logger.Background:SetHeight(Craftie.Logger:GetHeight())
Craftie.Logger.Background:SetPoint("CENTER", 0, 0)
Craftie.Logger.Background:SetScript("OnHide", function(self)
  Craftie.Logger:Hide()
end)
Craftie.Logger:SetScript("OnShow", function(self)
  Craftie.Logger.Background:Show()
end)

Craftie.Logger.Title = Craftie.Logger:CreateFontString(nil, "ARTWORK")
Craftie.Logger.Title:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
Craftie.Logger.Title:SetPoint("TOPLEFT", 8, -6)
Craftie.Logger.Title:SetText(Craftie._G.Title .. " Debug Logger")

Craftie.Logger.ScrollFrame={}
Craftie.Logger.ScrollFrame = CreateFrame("Frame", Craftie.Logger.ScrollFrame, Craftie.Logger, "BackdropTemplate")
Craftie.Logger.ScrollFrame:SetWidth(Craftie.Logger_w-20)
Craftie.Logger.ScrollFrame:SetHeight(Craftie.Logger_h-250)
Craftie.Logger.ScrollFrame:SetPoint("TOPLEFT", 15, -50)
Craftie.Logger.ScrollFrame:SetBackdrop(Craftie.Backdrop.General)
Craftie.Logger.ScrollFrame:SetBackdropColor(1, 0, 0, 0)
Craftie.Logger.ScrollFrame:SetBackdropBorderColor(1, 1, 1, 0)

Craftie.Logger.ScrollFrame.Child = CreateFrame("ScrollFrame", nil, Craftie.Logger.ScrollFrame, "UIPanelScrollFrameTemplate")
Craftie.Logger.ScrollFrame.Child:SetPoint("TOPLEFT", Craftie.Logger.ScrollFrame, "TOPLEFT", -5, -10)
Craftie.Logger.ScrollFrame.Child:SetPoint("BOTTOMRIGHT", Craftie.Logger.ScrollFrame, "BOTTOMRIGHT", 8, 5)
Craftie.Logger.ScrollFrameChildFrame = CreateFrame("Frame", Craftie.Logger.ScrollFrameChildFrame, Craftie.Logger.ScrollFrame.Child)
Craftie.Logger.ScrollFrameChildFrame:SetSize(Craftie.Logger_w, Craftie.Logger_h)
Craftie.Logger.ScrollFrame.Child:SetScrollChild(Craftie.Logger.ScrollFrameChildFrame)
Craftie.Logger.ScrollFrame.Child.ScrollBar:ClearAllPoints()
Craftie.Logger.ScrollFrame.Child.ScrollBar:SetPoint("TOPLEFT", Craftie.Logger.ScrollFrame.Child, "TOPRIGHT", -5, -5)
Craftie.Logger.ScrollFrame.Child.ScrollBar:SetPoint("BOTTOMRIGHT", Craftie.Logger.ScrollFrame.Child, "BOTTOMRIGHT", -36, 10)

Craftie.ScrollBarFrame(Craftie.Logger.ScrollFrame.Child)

Craftie.Logger.ColStamp = CreateFrame("Button", Craftie.Logger.ScrollFrame, Craftie.Logger, "BackdropTemplate")
Craftie.Logger.ColStamp:SetWidth(84)
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
    Craftie.Notification("--", true)
  else
    Craftie.SortOrder = 1
    Craftie.Logger.ColStampArrUp:Hide()
    Craftie.Logger.ColStampArrDn:Show()
    Craftie.Notification("--", true)
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
Craftie.Logger.ColData:SetPoint("TOPLEFT", 90, -26)
Craftie.Logger.ColData:SetBackdrop(Craftie.Backdrop.General)
Craftie.Logger.ColData:SetBackdropColor(0.6, 0.6, 0.5, 0.8)
Craftie.Logger.ColData:SetBackdropBorderColor(0.2, 0.2, 0.2, 0.5)
Craftie.Logger.ColDataText = Craftie.Logger.ColData:CreateFontString(nil, "ARTWORK")
Craftie.Logger.ColDataText:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
Craftie.Logger.ColDataText:SetPoint("TOPLEFT", 15, -10)
Craftie.Logger.ColDataText:SetText("Log")


Craftie.Logger.Row = {}
function Craftie.Log(row, type, data)
  local row_height = 24 --default
  if (type == nil) then
    type = "FUNC"
  end

  Craftie.Logger.Row[row] = CreateFrame("Button", Craftie.Logger.Row[row], Craftie.Logger.ScrollFrameChildFrame, "BackdropTemplate", -1)
  Craftie.Logger.Row[row]:SetWidth(Craftie.Logger:GetWidth()-40)
  Craftie.Logger.Row[row]:SetHeight(row_height)
  Craftie.Logger.Row[row]:SetPoint("TOPLEFT", 0, -row*Craftie.Logger.Row[row]:GetHeight())
  Craftie.Logger.Row[row]:SetPoint(Craftie.Logger.Row[row]:GetPoint())
  Craftie.Logger.Row[row]:SetBackdrop(Craftie.Backdrop.Borderless)
  Craftie.Logger.Row[row]:SetBackdropColor(0, 0, 0, 0)
  if (row % 2 == 0) then
    Craftie.Logger.Row[row]:SetBackdropColor(1, 1, 0.8, 0.1)
  end
  Craftie.Logger.Row[row]:SetBackdropBorderColor(0, 0, 0, 0)
  Craftie.Logger.Row[row]:SetFrameLevel(Craftie.Framelevel.Background)
  Craftie.Logger.Row[row]:SetScript("OnEnter", function(self)
    Craftie.Logger.Row[row]:SetBackdropColor(1, 1, 0.8, 0.2)
  end)
  Craftie.Logger.Row[row]:SetScript("OnLeave", function(self)
    Craftie.Logger.Row[row]:SetBackdropColor(0, 0, 0, 0)
    if (row % 2 == 0) then
      Craftie.Logger.Row[row]:SetBackdropColor(1, 1, 0.8, 0.1)
    end
  end)
  Craftie.Logger.Row[row]:SetScript("OnClick", function(self)
    print(Craftie.Logger.Row[row].Data:GetText())
  end)

  Craftie.Logger.Row[row].Num = Craftie.Logger.Row[row]:CreateFontString(nil, "ARTWORK")
  Craftie.Logger.Row[row].Num:SetWidth(60)
  Craftie.Logger.Row[row].Num:SetHeight(row_height)
  Craftie.Logger.Row[row].Num:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
  Craftie.Logger.Row[row].Num:SetPoint("TOPLEFT", 0, 0)
  Craftie.Logger.Row[row].Num:SetText(row)
  Craftie.Logger.Row[row].Num:SetTextColor(1, 1, 0.8, 0.5)

  Craftie.Logger.Row[row].Timestamp = Craftie.Logger.Row[row]:CreateFontString(nil, "ARTWORK")
  Craftie.Logger.Row[row].Timestamp:SetWidth(100)
  Craftie.Logger.Row[row].Timestamp:SetHeight(row_height)
  Craftie.Logger.Row[row].Timestamp:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
  Craftie.Logger.Row[row].Timestamp:SetPoint("TOPLEFT", 70, 0)
  Craftie.Logger.Row[row].Timestamp:SetText(date("%y%m%d%H%M%S"))
  Craftie.Logger.Row[row].Timestamp:SetTextColor(1, 1, 0.8, 0.8)

  Craftie.Logger.Row[row].Type = Craftie.Logger.Row[row]:CreateFontString(nil, "ARTWORK")
  Craftie.Logger.Row[row].Type:SetWidth(110)
  Craftie.Logger.Row[row].Type:SetHeight(row_height)
  Craftie.Logger.Row[row].Type:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
  Craftie.Logger.Row[row].Type:SetPoint("TOPLEFT", 150, 0)
  Craftie.Logger.Row[row].Type:SetText(type)

  Craftie.Logger.Row[row].Data = Craftie.Logger.Row[row]:CreateFontString(nil, "ARTWORK")
  Craftie.Logger.Row[row].Data:SetWidth(450)
  Craftie.Logger.Row[row].Data:SetHeight(row_height)
  Craftie.Logger.Row[row].Data:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
  Craftie.Logger.Row[row].Data:SetPoint("TOPLEFT", 260, 0)
  Craftie.Logger.Row[row].Data:SetText(data)
  Craftie.Logger.Row[row].Data:SetWordWrap(true)
  Craftie.Logger.Row[row].Data:SetJustifyH("LEFT")
  --Craftie.Logger.Row[row].Type:SetTextColor(1, 1, 1, 0.8)
end

--[==[
Craftie.Logger.Data = CreateFrame("EditBox", nil, Craftie.Logger.ScrollFrameChildFrame)
Craftie.Logger.Data:SetWidth(Craftie.Logger_w-45)
Craftie.Logger.Data:SetHeight(Craftie.Logger_h)
Craftie.Logger.Data:SetFont(Craftie._G.Font.Style, 11, "OUTLINE | SLUG")
Craftie.Logger.Data:SetPoint("TOPLEFT", 2, -4)
Craftie.Logger.Data:SetMultiLine(true)
Craftie.Logger.Data:ClearFocus(self)
Craftie.Logger.Data:SetAutoFocus(false)
Craftie.Logger.Data:SetText("")
]==]--

--Craftie.Logger:Hide()
