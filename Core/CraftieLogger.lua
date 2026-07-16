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

local dimensions = {
  W = 800,
  H = 550,
}

Craftie.Logger = CreateFrame("Frame", 'Craftie.Logger', UIParent, "BackdropTemplate")
Craftie.Logger:SetWidth(dimensions.W)
Craftie.Logger:SetHeight(dimensions.H)
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
  local point, relativeTo, relativePoint, xOfs, yOfs = Craftie.Logger:GetPoint()
  Craftie.Save.Player["CONFIG"]["POS_LOGGER"] = point .. "," .. xOfs .. "," .. yOfs
  Craftie:Notification("Logger:[" .. Craftie.Player.Combine .. "]" .. point .. "," .. xOfs .. "," .. yOfs, Craftie.CHAT.SAVE)
end)
Craftie.Logger.Background = CreateFrame("Frame", "Craftie.Logger.Background", Craftie.Logger, "BaseBasicFrameTemplate")
Craftie.Logger.Background:SetWidth(Craftie.Logger:GetWidth())
Craftie.Logger.Background:SetHeight(Craftie.Logger:GetHeight())
Craftie.Logger.Background:SetPoint("CENTER", 0, 0)
Craftie.Logger.Background:SetScript("OnHide", function(self)
  Craftie.Logger:Hide()
end)
Craftie.Logger:SetScript("OnShow", function(self)
  Craftie.Logger.Background:Show()
end)

Craftie.Logger:Hide()

Craftie.Logger.Button={}
Craftie.Logger.Button.Frame = Craftie.Logger.Background:CreateTexture(nil, "OVERLAY")
Craftie.Logger.Button.Frame:SetSize(64, 64)
Craftie.Logger.Button.Frame:SetPoint("TOPRIGHT", -25, 1)
Craftie.Logger.Button.Frame:SetTexture(Craftie._G.Image.Button.Frame)
Craftie.Logger.Button.Frame:SetDrawLayer("OVERLAY", 1)

Craftie.Logger.Button.Coll = CreateFrame("Button", nil, Craftie.Logger.Background)
Craftie.Logger.Button.Coll:SetSize(32, 32)
Craftie.Logger.Button.Coll:SetPoint("TOPRIGHT", -19, 6)
Craftie.Logger.Button.Coll:SetNormalTexture("Interface/Buttons/UI-Panel-CollapseButton-Up")
Craftie.Logger.Button.Coll:SetPushedTexture("Interface/Buttons/UI-Panel-CollapseButton-Down")
Craftie.Logger.Button.Coll:SetScript("OnClick", function(self)
  Craftie.Logger:SetFrameStrata("HIGH")
end)
Craftie.Logger.Button.Coll:SetScript("OnEnter", function(self)
  CraftieTooltip:ClearLines()
  CraftieTooltip:SetOwner(self, "ANCHOR_RIGHT")
  CraftieTooltip:AddLine(Craftie.Color.Silver .. "Bring To Front")
  CraftieTooltip:Show()
end)
Craftie.Logger.Button.Coll:SetScript("OnLeave", function(self)
  CraftieTooltip:Hide()
end)

Craftie.Logger.Button.Exp = CreateFrame("Button", nil, Craftie.Logger.Background)
Craftie.Logger.Button.Exp:SetSize(32, 32)
Craftie.Logger.Button.Exp:SetPoint("TOPRIGHT", -43, 6)
Craftie.Logger.Button.Exp:SetNormalTexture("Interface/Buttons/UI-Panel-ExpandButton-Up")
Craftie.Logger.Button.Exp:SetPushedTexture("Interface/Buttons/UI-Panel-ExpandButton-Down")
Craftie.Logger.Button.Exp:SetScript("OnClick", function(self)
  Craftie.Logger:SetFrameStrata("BACKGROUND")
end)
Craftie.Logger.Button.Exp:SetScript("OnEnter", function(self)
  CraftieTooltip:ClearLines()
  CraftieTooltip:SetOwner(self, "ANCHOR_RIGHT")
  CraftieTooltip:AddLine(Craftie.Color.Silver .. "Send To Back")
  CraftieTooltip:Show()
end)
Craftie.Logger.Button.Exp:SetScript("OnLeave", function(self)
  CraftieTooltip:Hide()
end)

Craftie.Logger.Icon = Craftie.Logger.Background:CreateTexture(nil, "ARTWORK")
Craftie.Logger.Icon:SetSize(160, 80)
Craftie.Logger.Icon:SetPoint("TOPLEFT", -42, 30)
Craftie.Logger.Icon:SetTexture(Craftie._G.Image.Logo.Header)
Craftie.Logger.Icon:SetDrawLayer("OVERLAY", 4)

Craftie.Logger.Title = Craftie.Logger:CreateFontString(nil, "ARTWORK")
Craftie.Logger.Title:SetFont(Craftie._G.Font.Style.Alpha, Craftie._G.Font.Size, Craftie._G.Font.Flags)
Craftie.Logger.Title:SetPoint("TOPRIGHT", -90, -5)
Craftie.Logger.Title:SetText("v" .. Craftie._G.Version .. " [" .. Craftie.Game.Name .. "]")
Craftie.Logger.Title:SetTextColor(0.9, 0.9, 0.8, 1)

Craftie.Logger.Debug = Craftie.Logger:CreateFontString(nil, "ARTWORK")
Craftie.Logger.Debug:SetFont(Craftie._G.Font.Style.Alpha, Craftie._G.Font.Size, Craftie._G.Font.Flags)
Craftie.Logger.Debug:SetPoint("TOPLEFT", 30, -40)
Craftie.Logger.Debug:SetText("DEBUGLEVEL: " .. Craftie.DEBUGLEVEL)
Craftie.Logger.Debug:SetTextColor(0.9, 0.9, 0.8, 1)
--Craftie.Logger.Debug:SetJustifyH("LEFT")

Craftie.Logger.ScrollFrame={}
Craftie.Logger.ScrollFrame = CreateFrame("Frame", "Craftie.Logger.ScrollFrame", Craftie.Logger, "BackdropTemplate")
Craftie.Logger.ScrollFrame:SetWidth(Craftie.Logger:GetWidth()-10)
Craftie.Logger.ScrollFrame:SetHeight(Craftie.Logger:GetHeight()-240)
Craftie.Logger.ScrollFrame:SetPoint("TOPLEFT", 0, -86)
Craftie.Logger.ScrollFrame:SetBackdrop(Craftie.Backdrop.General)
Craftie.Logger.ScrollFrame:SetBackdropColor(1, 0, 0, 0)
Craftie.Logger.ScrollFrame:SetBackdropBorderColor(1, 1, 1, 0)

Craftie.Logger.ScrollFrame.Child = CreateFrame("ScrollFrame", nil, Craftie.Logger.ScrollFrame, "UIPanelScrollFrameTemplate")
Craftie.Logger.ScrollFrame.Child:SetPoint("TOPLEFT", Craftie.Logger.ScrollFrame, "TOPLEFT", 5, -10)
Craftie.Logger.ScrollFrame.Child:SetPoint("BOTTOMRIGHT", Craftie.Logger.ScrollFrame, "BOTTOMRIGHT", 10, 10)
Craftie.Logger.ScrollFrameChildFrame = CreateFrame("Frame", "Craftie.Logger.ScrollFrameChildFrame", Craftie.Logger.ScrollFrame.Child)
Craftie.Logger.ScrollFrameChildFrame:SetSize(Craftie.Logger:GetWidth(), Craftie.Logger:GetHeight())
Craftie.Logger.ScrollFrame.Child:SetScrollChild(Craftie.Logger.ScrollFrameChildFrame)
Craftie.Logger.ScrollFrame.Child.ScrollBar:ClearAllPoints()
Craftie.Logger.ScrollFrame.Child.ScrollBar:SetPoint("TOPLEFT", Craftie.Logger.ScrollFrame.Child, "TOPRIGHT", -32, -5)
Craftie.Logger.ScrollFrame.Child.ScrollBar:SetPoint("BOTTOMRIGHT", Craftie.Logger.ScrollFrame.Child, "BOTTOMRIGHT", -11, 5)

Craftie:ScrollBarFrame(Craftie.Logger.ScrollFrame.Child)

--colName, colWidth, colX, colColor, colSortable
local columns = {
  {"ID",   60,  0,   {1, 1, 0.8, 0.4}, 1},
  {"Date", 100, 60,  {1, 1, 0.7, 0.8}, 1},
  {"Type", 110, 160, {}, 1},
  {"Log",  495, 270, {}, 0},
}
local column = {
  H = 28,
  color = {0.6, 0.6, 0.5, 0.7},
}
Craftie.Logger.Col={}
Craftie.LoggerSort = 1

function Craftie.Logger:ResetAllSorting()
  for k,v in ipairs(columns) do
    if (v[5] == 1) then
      Craftie.Logger.Col[k].Up:Hide()
      Craftie.Logger.Col[k].Dn:Hide()
    end
  end
end

for k,v in ipairs(columns) do
  Craftie.Logger.Col[k] = CreateFrame("Button", nil, Craftie.Logger, "BackdropTemplate")
  Craftie.Logger.Col[k]:SetWidth(v[2]+2)
  Craftie.Logger.Col[k]:SetHeight(column.H)
  Craftie.Logger.Col[k]:SetPoint("TOPLEFT", v[3], -70)
  Craftie.Logger.Col[k]:SetBackdrop(Craftie.Backdrop.General)
  Craftie.Logger.Col[k]:SetBackdropColor(column.color[1], column.color[2], column.color[3], column.color[4])
  Craftie.Logger.Col[k]:SetBackdropBorderColor(0.6, 0.6, 0.5, 0)
  Craftie.Logger.Col[k].Text = Craftie.Logger.Col[k]:CreateFontString(nil, "ARTWORK")
  Craftie.Logger.Col[k].Text:SetFont(Craftie._G.Font.Style.Alpha, Craftie._G.Font.Size, Craftie._G.Font.Flags)
  Craftie.Logger.Col[k].Text:SetPoint("TOPLEFT", 10, -10)
  Craftie.Logger.Col[k].Text:SetText(v[1])
  Craftie.Logger.Col[k].Text:SetJustifyH("LEFT")
  if (v[5] == 1) then --draw only sortable columns
    Craftie.Logger.Col[k].Arr = Craftie.Logger.Col[k]:CreateTexture(nil, "ARTWORK")
    Craftie.Logger.Col[k].Arr:SetSize(14, 26)
    Craftie.Logger.Col[k].Arr:SetPoint("TOPRIGHT", -5, -2)
    Craftie.Logger.Col[k].Arr:SetTexture("Interface/Minimap/MiniMap-PositionArrows")
    Craftie.Logger.Col[k].Arr:SetDrawLayer("OVERLAY", 1)
    Craftie.Logger.Col[k].Arr:SetAlpha(0.4)
    Craftie.Logger.Col[k].Up = Craftie.Logger.Col[k]:CreateTexture(nil, "ARTWORK")
    Craftie.Logger.Col[k].Up:SetSize(13, 13)
    Craftie.Logger.Col[k].Up:SetPoint("TOPRIGHT", -6, 1)
    Craftie.Logger.Col[k].Up:SetTexture("Interface/Buttons/Arrow-Up-Down")
    Craftie.Logger.Col[k].Up:SetDrawLayer("OVERLAY", 4)
    Craftie.Logger.Col[k].Up:Hide()
    Craftie.Logger.Col[k].Dn = Craftie.Logger.Col[k]:CreateTexture(nil, "ARTWORK")
    Craftie.Logger.Col[k].Dn:SetSize(13, 13)
    Craftie.Logger.Col[k].Dn:SetPoint("TOPRIGHT", -6, -17)
    Craftie.Logger.Col[k].Dn:SetTexture("Interface/Buttons/Arrow-Down-Down")
    Craftie.Logger.Col[k].Dn:SetDrawLayer("OVERLAY", 4)
    Craftie.Logger.Col[k].Dn:Hide()
  end
  Craftie.Logger.Col[k]:SetScript("OnEnter", function(self)
    if (v[5] == 1) then
      Craftie.Logger.Col[k]:SetBackdropColor(1, 1, 0.8, 0.8)
    end
  end)
  Craftie.Logger.Col[k]:SetScript("OnLeave", function(self)
    Craftie.Logger.Col[k]:SetBackdropColor(column.color[1], column.color[2], column.color[3], column.color[4])
  end)
  Craftie.Logger.Col[k]:SetScript("OnClick", function(self)
    Craftie.Logger:ResetAllSorting()
    if (k == 1) then
      if (Craftie.LoggerSort == 1) then
        Craftie.Logger:SortNumAsc()
        Craftie.LoggerSort = 0
        Craftie.Logger.Col[k].Up:Show()
      else
        Craftie.Logger:SortNumDesc()
        Craftie.LoggerSort = 1
        Craftie.Logger.Col[k].Dn:Show()
      end
    end
    if (k == 2) then
      if (Craftie.LoggerSort == 1) then
        Craftie.Logger:SortNumAsc()
        Craftie.LoggerSort = 0
        Craftie.Logger.Col[k].Up:Show()
      else
        Craftie.Logger:SortNumDesc()
        Craftie.LoggerSort = 1
        Craftie.Logger.Col[k].Dn:Show()
      end
    end
    if (k == 3) then
      if (Craftie.LoggerSort == 3) then
        Craftie.Logger.SortTypeAsc()
        Craftie.LoggerSort = 4
        Craftie.Logger.Col[k].Up:Show()
      else
        Craftie.Logger.SortTypeDesc()
        Craftie.LoggerSort = 3
        Craftie.Logger.Col[k].Dn:Show()
      end
    end
  end)
end

Craftie.Logger.Col[1].Dn:Show()

Craftie.Logger.Row = {}

function Craftie:Log(type, log)
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
    for k,v in ipairs(columns) do
      detail = "[" .. Craftie.Logger.Row[id][1]:GetText() .. "]|n" ..
      Craftie.Logger.Row[id][2]:GetText() ..
      "|nTYPE: " .. Craftie.Logger.Row[id][3]:GetText() ..
      "|n|nLOG:|n" .. Craftie.Logger.Row[id][4]:GetText()
      Craftie.Logger.Output:SetText(detail)
    end
  end)

  for k,v in ipairs(columns) do
    Craftie.Logger.Row[id][k] = Craftie.Logger.Row[id]:CreateFontString(nil, "ARTWORK")
    Craftie.Logger.Row[id][k]:SetWidth(v[2])
    Craftie.Logger.Row[id][k]:SetHeight(RowHeight)
    Craftie.Logger.Row[id][k]:SetFont(Craftie._G.Font.Style.Alpha, Craftie._G.Font.Size, Craftie._G.Font.Flags)
    Craftie.Logger.Row[id][k]:SetPoint("TOPLEFT", v[3]-5, 0)
    Craftie.Logger.Row[id][k]:SetText(id)
    if (k == 1) then
      Craftie.Logger.Row[id][k]:SetFont(Craftie._G.Font.Style.Numeric, Craftie._G.Font.Size, Craftie._G.Font.Flags)
      Craftie.Logger.Row[id][k]:SetPoint("TOPLEFT", v[3]+5, 0)
    end
    if (k == 2) then
      Craftie.Logger.Row[id][k]:SetFont(Craftie._G.Font.Style.Numeric, Craftie._G.Font.Size-1, Craftie._G.Font.Flags)
      Craftie.Logger.Row[id][k]:SetText(Craftie.Date)
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
      Craftie.Logger.Row[id][k]:SetTextColor(v[4][1], v[4][2], v[4][3], v[4][4])
    end
  end

  if (Craftie.LoggerSort == 0) then
    Craftie.Logger:SortNumAsc()
  end
  if (Craftie.LoggerSort == 1) then
    Craftie.Logger:SortNumDesc()
  end
  --[==[
  if (Craftie.LoggerSort == 3) then
    Craftie.Logger:SortTypeAsc()
  end
  if (Craftie.LoggerSort == 4) then
    Craftie.Logger:SortTypeDesc()
  end
  ]==]--
end

function Craftie.Logger:SortNumAsc()
  for i=1, Craftie.LogKey do
    Craftie.Logger.Row[i]:SetPoint("TOPLEFT", 0, -i*24)
  end
end

function Craftie.Logger:SortNumDesc()
  local id = 0
  for i = Craftie.LogKey, 1, -1 do
    id = id +1
    Craftie.Logger.Row[id]:SetPoint("TOPLEFT", 0, -i*24)
  end
end

function Craftie.Logger.SortTypeAsc()
  local type_arr = {}
  for i=1, Craftie.LogKey do
    local type = Craftie.Logger.Row[i][3]:GetText():sub(11)
    table.insert(type_arr, {i, type}) --remove color codes
  end
  --table.sort(type_arr)
  Craftie:SortTableByString(type_arr)

  local i = 0
  for k,v in ipairs(type_arr) do
    i = i+1
    Craftie.Logger.Row[v[1]]:SetPoint("TOPLEFT", 0, -i*24)
  end
end

function Craftie.Logger.SortTypeDesc()
  local type_arr = {}
  for i=1, Craftie.LogKey do
    local type = Craftie.Logger.Row[i][3]:GetText():sub(11)
    table.insert(type_arr, {i, type}) --remove color codes
  end
  --table.sort(type_arr)
  Craftie:SortTableByString(type_arr)

  local i = #type_arr+1
  for k,v in ipairs(type_arr) do
    i = i-1
    Craftie.Logger.Row[v[1]]:SetPoint("TOPLEFT", 0, -i*24)
  end
end

Craftie.Logger.Header = CreateFrame("Frame", "Craftie.Logger.ScrollFrame", Craftie.Logger, "InsetFrameTemplate4", -4)
Craftie.Logger.Header:SetWidth(Craftie.Logger:GetWidth()-6)
Craftie.Logger.Header:SetHeight(46)
Craftie.Logger.Header:SetPoint("TOPLEFT", 2, -22)

Craftie.Logger.ScrollBorder = CreateFrame("Frame", "Craftie.Logger.ScrollFrame", Craftie.Logger, "InsetFrameTemplate4", -4)
Craftie.Logger.ScrollBorder:SetWidth(Craftie.Logger:GetWidth()-6)
Craftie.Logger.ScrollBorder:SetHeight(Craftie.Logger:GetHeight()-218)
Craftie.Logger.ScrollBorder:SetPoint("TOPLEFT", 2, -68)

Craftie.LoggerOutputFrame = CreateFrame("Frame", "Craftie.LoggerOutputFrame", Craftie.Logger, "InsetFrameTemplate4")
Craftie.LoggerOutputFrame:SetWidth(Craftie.LoggerOutputFrame:GetParent():GetWidth()-6)
Craftie.LoggerOutputFrame:SetHeight(150)
Craftie.LoggerOutputFrame:SetPoint("TOPLEFT", 2, -398)

Craftie.Logger.Output = CreateFrame("EditBox", "Craftie.Logger.Output", Craftie.LoggerOutputFrame)
Craftie.Logger.Output:SetWidth(Craftie.LoggerOutputFrame:GetWidth()-30)
Craftie.Logger.Output:SetHeight(Craftie.LoggerOutputFrame:GetHeight()-10)
Craftie.Logger.Output:SetFont(Craftie._G.Font.Style.Alpha, Craftie._G.Font.Size+1, Craftie._G.Font.Flags)
Craftie.Logger.Output:SetPoint("TOPLEFT", 15, -15)
Craftie.Logger.Output:SetMultiLine(true)
Craftie.Logger.Output:ClearFocus()
Craftie.Logger.Output:SetAutoFocus(false)
Craftie.Logger.Output:SetText("")
--Craftie.Logger.Output:SetEnabled(false)
--Craftie.Logger.Output:RegisterForClicks("AnyUp")
--Craftie.Logger.Output:EnableKeyboard(false)
Craftie.Logger.Output:SetScript("OnKeyUp", nil)
Craftie.Logger.Output:SetScript("OnKeyDown", nil)
Craftie.Logger.Output:SetScript("OnTextChanged", nil)

table.insert(UISpecialFrames, Craftie.Logger:GetName())
