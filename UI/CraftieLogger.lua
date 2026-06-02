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
Craftie.Logger_h = 550

Craftie.Logger = CreateFrame("Frame", Craftie.Logger, UIParent, "BackdropTemplate")
Craftie.Logger:SetWidth(Craftie.Logger_w)
Craftie.Logger:SetHeight(Craftie.Logger_h)
Craftie.Logger:SetPoint("CENTER", 0, 20)
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
Craftie.Logger.Title:SetText(Craftie._G.Title .. " Logger")

Craftie.Logger.ScrollFrame={}
Craftie.Logger.ScrollFrame = CreateFrame("Frame", Craftie.Logger.ScrollFrame, Craftie.Logger, "BackdropTemplate")
Craftie.Logger.ScrollFrame:SetWidth(Craftie.Logger:GetWidth()-20)
Craftie.Logger.ScrollFrame:SetHeight(Craftie.Logger:GetHeight()-200)
Craftie.Logger.ScrollFrame:SetPoint("TOPLEFT", 15, -50)
Craftie.Logger.ScrollFrame:SetBackdrop(Craftie.Backdrop.General)
Craftie.Logger.ScrollFrame:SetBackdropColor(1, 0, 0, 0)
Craftie.Logger.ScrollFrame:SetBackdropBorderColor(1, 1, 1, 0)

Craftie.Logger.ScrollFrame.Child = CreateFrame("ScrollFrame", nil, Craftie.Logger.ScrollFrame, "UIPanelScrollFrameTemplate")
Craftie.Logger.ScrollFrame.Child:SetPoint("TOPLEFT", Craftie.Logger.ScrollFrame, "TOPLEFT", -5, -10)
Craftie.Logger.ScrollFrame.Child:SetPoint("BOTTOMRIGHT", Craftie.Logger.ScrollFrame, "BOTTOMRIGHT", 8, 5)
Craftie.Logger.ScrollFrameChildFrame = CreateFrame("Frame", Craftie.Logger.ScrollFrameChildFrame, Craftie.Logger.ScrollFrame.Child)
Craftie.Logger.ScrollFrameChildFrame:SetSize(Craftie.Logger:GetWidth(), Craftie.Logger:GetHeight())
Craftie.Logger.ScrollFrame.Child:SetScrollChild(Craftie.Logger.ScrollFrameChildFrame)
Craftie.Logger.ScrollFrame.Child.ScrollBar:ClearAllPoints()
Craftie.Logger.ScrollFrame.Child.ScrollBar:SetPoint("TOPLEFT", Craftie.Logger.ScrollFrame.Child, "TOPRIGHT", -5, -5)
Craftie.Logger.ScrollFrame.Child.ScrollBar:SetPoint("BOTTOMRIGHT", Craftie.Logger.ScrollFrame.Child, "BOTTOMRIGHT", -36, 10)

Craftie.ScrollBarFrame(Craftie.Logger.ScrollFrame.Child)

local ColHeight = 28
--colName, colWidth, colX, colColor, 
Craftie.Logger.Cols = {
  {"ID",   60,  0,   {1, 1, 0.8, 0.4}},
  {"Date", 100, 60,  {1, 1, 0.7, 0.8}},
  {"Type", 110, 160, {}},
  {"Log",  500, 270, {}},
}
Craftie.Logger.Col={}

for k,v in ipairs(Craftie.Logger.Cols) do
  Craftie.Logger.Col[k] = CreateFrame("Button", Craftie.Logger.ScrollFrame, Craftie.Logger, "BackdropTemplate")
  Craftie.Logger.Col[k]:SetWidth(v[2])
  Craftie.Logger.Col[k]:SetHeight(ColHeight)
  --Craftie.Logger.Col[k]:SetPoint("TOPLEFT", 0, -ColHeight)
  Craftie.Logger.Col[k]:SetPoint("TOPLEFT", v[3], -ColHeight)
  Craftie.Logger.Col[k]:SetBackdrop(Craftie.Backdrop.General)
  Craftie.Logger.Col[k]:SetBackdropColor(0.6, 0.6, 0.5, 0.7)
  Craftie.Logger.Col[k]:SetBackdropBorderColor(0.2, 0.2, 0.2, 0)
  Craftie.Logger.Col[k].Text = Craftie.Logger.Col[k]:CreateFontString(nil, "ARTWORK")
  Craftie.Logger.Col[k].Text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
  Craftie.Logger.Col[k].Text:SetPoint("TOPLEFT", 15, -10)
  Craftie.Logger.Col[k].Text:SetText(v[1])
end

Craftie.Logger.Row = {}
function Craftie.Log(type, log)
  Craftie.LogKey = Craftie.LogKey +1
  local id = Craftie.LogKey
  local RowHeight = 24 --default
  if (type == nil) then
    type = "FUNC"
  end

  Craftie.Logger.Row[id] = CreateFrame("Button", Craftie.Logger.Row[id], Craftie.Logger.ScrollFrameChildFrame, "BackdropTemplate", -1)
  Craftie.Logger.Row[id]:SetWidth(Craftie.Logger:GetWidth()-40)
  Craftie.Logger.Row[id]:SetHeight(RowHeight)
  Craftie.Logger.Row[id]:SetPoint("TOPLEFT", 0, -id*Craftie.Logger.Row[id]:GetHeight())
  Craftie.Logger.Row[id]:SetBackdrop(Craftie.Backdrop.Borderless)
  Craftie.Logger.Row[id]:SetBackdropColor(0, 0, 0, 0)
  if (id % 2 == 0) then
    Craftie.Logger.Row[id]:SetBackdropColor(1, 1, 0.8, 0.1)
  end
  Craftie.Logger.Row[id]:SetBackdropBorderColor(0, 0, 0, 0)
  Craftie.Logger.Row[id]:SetFrameLevel(Craftie.Framelevel.Background)
  Craftie.Logger.Row[id]:SetScript("OnEnter", function(self)
    Craftie.Logger.Row[id]:SetBackdropColor(1, 1, 0.8, 0.2)
  end)
  Craftie.Logger.Row[id]:SetScript("OnLeave", function(self)
    Craftie.Logger.Row[id]:SetBackdropColor(0, 0, 0, 0)
    if (id % 2 == 0) then
      Craftie.Logger.Row[id]:SetBackdropColor(1, 1, 0.8, 0.1)
    end
  end)
  Craftie.Logger.Row[id]:SetScript("OnClick", function(self)
    local detail = ""
    for k,v in ipairs(Craftie.Logger.Cols) do
      detail = "[" .. Craftie.Logger.Row[id][1]:GetText() .. "]|n" ..
      Craftie.Logger.Row[id][2]:GetText() ..
      "|nTYPE: " .. Craftie.Logger.Row[id][3]:GetText() ..
      "|n|nLOG:|n" .. Craftie.Logger.Row[id][4]:GetText()
      Craftie.Logger.Text:SetText(detail)
    end
  end)

  for k,v in ipairs(Craftie.Logger.Cols) do
    Craftie.Logger.Row[id][k] = Craftie.Logger.Row[id]:CreateFontString(nil, "ARTWORK")
    Craftie.Logger.Row[id][k]:SetWidth(v[2])
    Craftie.Logger.Row[id][k]:SetHeight(RowHeight)
    Craftie.Logger.Row[id][k]:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
    Craftie.Logger.Row[id][k]:SetPoint("TOPLEFT", v[3], 0)
    if (k > 1) then
      Craftie.Logger.Row[id][k]:SetPoint("TOPLEFT", v[3]-5, 0)
    end
    Craftie.Logger.Row[id][k]:SetText(id)
    if (k == 2) then
      Craftie.Logger.Row[id][k]:SetText(date("%y%m%d%H%M%S"))
    end
    if (k == 3) then
      Craftie.Logger.Row[id][k]:SetText(tostring(type))
    end
    if (k == 4) then
      Craftie.Logger.Row[id][k]:SetText(log)
    end
    Craftie.Logger.Row[id][k]:SetWordWrap(true)
    Craftie.Logger.Row[id][k]:SetJustifyH("LEFT")
    if (v[4][1]) then
      --Craftie.Logger.Row[id][k]:SetTextColor({v[4]})
      Craftie.Logger.Row[id][k]:SetTextColor(v[4][1], v[4][2], v[4][3], v[4][4])
    end
  end
end

Craftie.Logger.DetailsFrame = CreateFrame("Frame", Craftie.Logger.DetailsFrame, Craftie.Logger, "InsetFrameTemplate4")
Craftie.Logger.DetailsFrame:SetWidth(Craftie.Logger.DetailsFrame:GetParent():GetWidth()-6)
Craftie.Logger.DetailsFrame:SetHeight(152)
Craftie.Logger.DetailsFrame:SetPoint("TOPLEFT", 2, -396)

Craftie.Logger.Text = CreateFrame("EditBox", nil, Craftie.Logger.DetailsFrame)
Craftie.Logger.Text:SetWidth(Craftie.Logger.DetailsFrame:GetWidth()-30)
Craftie.Logger.Text:SetHeight(Craftie.Logger.DetailsFrame:GetHeight()-10)
Craftie.Logger.Text:SetFont(Craftie._G.Font.Style, 12, "OUTLINE | SLUG")
Craftie.Logger.Text:SetPoint("TOPLEFT", 15, -15)
Craftie.Logger.Text:SetMultiLine(true)
Craftie.Logger.Text:ClearFocus(self)
Craftie.Logger.Text:SetAutoFocus(false)
Craftie.Logger.Text:SetText("")

--Craftie.Logger:Hide()
