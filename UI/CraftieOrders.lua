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

local OrderTooltip = {
  "Request a player to craft this item for you",
  "Queue from other players for you to craft an item"
}

local dimensions={
  parent = {
    W = Craftie.Frame:GetWidth()-26,
    H = Craftie.Frame:GetHeight()-124,
  },
  column = {
    H = 24,
  },
  row = {
    H = 25,
  }
}

Craftie.Frame.CraftOrders={}
Craftie.Frame.CraftOrders= CreateFrame("Frame", "Craftie.Frame.CraftOrders", Craftie.Frame, "BackdropTemplate")
Craftie.Frame.CraftOrders:SetWidth(dimensions.parent.W)
Craftie.Frame.CraftOrders:SetHeight(dimensions.parent.H)
Craftie.Frame.CraftOrders:SetPoint("TOPLEFT", 12, -100)
--Craftie.Frame.CraftOrders:SetFrameStrata("MEDIUM")
Craftie.Frame.CraftOrders:Hide()

Craftie.Frame.CraftOrdersBackTop={}
Craftie.Frame.CraftOrdersBackTop= CreateFrame("Frame", "Craftie.Frame.CraftOrdersBackTop", Craftie.Frame.CraftOrders, "InsetFrameTemplate4")
Craftie.Frame.CraftOrdersBackTop:SetWidth(Craftie.Frame.CraftOrders:GetWidth())
Craftie.Frame.CraftOrdersBackTop:SetHeight(Craftie.Frame.CraftOrders:GetHeight())
Craftie.Frame.CraftOrdersBackTop:SetPoint("TOPRIGHT", 0, 0)
Craftie.Frame.CraftOrdersBackTop:SetFrameStrata("LOW") --Blizzard's UI is so broken and hacky
Craftie.Frame.CraftOrdersBackTopArt = Craftie.Frame.CraftOrdersBackTop:CreateTexture(nil, "BACKGROUND")
Craftie.Frame.CraftOrdersBackTopArt:SetWidth(Craftie.Frame.CraftOrdersBackTop:GetWidth())
Craftie.Frame.CraftOrdersBackTopArt:SetHeight(Craftie.Frame.CraftOrdersBackTop:GetHeight())
Craftie.Frame.CraftOrdersBackTopArt:SetPoint("TOPLEFT", 0, 0)
Craftie.Frame.CraftOrdersBackTopArt:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Background-Shadow.png")
--Craftie.Frame.CraftOrdersBackTopArt:SetVertexColor(.8, .8, .8) --darker
Craftie.Frame.CraftOrdersBackTopArt:SetDesaturation(0.3)


Craftie.Frame.ScrollOrderList = CreateFrame("Frame", "Craftie.Frame.ScrollOrderList", Craftie.Frame.CraftOrders, "BackdropTemplate")
Craftie.Frame.ScrollOrderList:SetWidth(Craftie.Frame.CraftOrders:GetWidth()-10)
Craftie.Frame.ScrollOrderList:SetHeight(Craftie.Frame.CraftOrders:GetHeight()-5)
Craftie.Frame.ScrollOrderList:SetPoint("TOPLEFT", 4, -10)

Craftie.Frame.ScrollOrderList.Child = CreateFrame("ScrollFrame", "Craftie.Frame.ScrollOrderList.Child", Craftie.Frame.ScrollOrderList, "UIPanelScrollFrameTemplate")
Craftie.Frame.ScrollOrderList.Child:SetPoint("TOPLEFT", Craftie.Frame.ScrollOrderList, "TOPLEFT",         -2,-20)
Craftie.Frame.ScrollOrderList.Child:SetPoint("BOTTOMRIGHT", Craftie.Frame.ScrollOrderList, "BOTTOMRIGHT", 14, 10)
Craftie.Frame.ScrollOrderListChildFrame = CreateFrame("Frame", "Craftie.Frame.ScrollOrderListChildFrame", Craftie.Frame.ScrollOrderList.Child)
Craftie.Frame.ScrollOrderListChildFrame:SetSize(Craftie.Frame.CraftOrders:GetWidth(), Craftie.Frame.CraftOrders:GetHeight())
Craftie.Frame.ScrollOrderList.Child:SetScrollChild(Craftie.Frame.ScrollOrderListChildFrame)
Craftie.Frame.ScrollOrderList.Child.ScrollBar:ClearAllPoints()
Craftie.Frame.ScrollOrderList.Child.ScrollBar:SetPoint("TOPLEFT", Craftie.Frame.ScrollOrderList.Child, "TOPRIGHT",          0,-10)
Craftie.Frame.ScrollOrderList.Child.ScrollBar:SetPoint("BOTTOMRIGHT", Craftie.Frame.ScrollOrderList.Child, "BOTTOMRIGHT", -42, 10)

Craftie:ScrollBarFrame(Craftie.Frame.ScrollOrderList.Child)

Craftie.Frame.ScrollOrderListRow={}
Craftie.Frame.ScrollOrderListBack={}
Craftie.Frame.ScrollOrderListName={}
Craftie.Frame.ScrollOrderListItem={}
Craftie.Frame.ScrollOrderListItem={}
Craftie.Frame.ScrollOrderListCount={}
Craftie.Frame.ScrollOrderListSelect={}

local col_width = {
  Player = 108,
  Item   = 138,
  Count  = 30,
  Action = 48
}

Craftie.Frame.ScrollOrderListColPlayer = CreateFrame("Button", nil, Craftie.Frame.ScrollOrderList.Child, "BackdropTemplate")
Craftie.Frame.ScrollOrderListColPlayer:SetWidth(col_width.Player)
Craftie.Frame.ScrollOrderListColPlayer:SetHeight(dimensions.column.H)
Craftie.Frame.ScrollOrderListColPlayer:SetPoint("TOPLEFT", 1, dimensions.column.H+1)
Craftie.Frame.ScrollOrderListColPlayer:SetBackdrop(Craftie.Backdrop.Borderless)
Craftie.Frame.ScrollOrderListColPlayer:SetBackdropColor(0.7, 0.6, 0.5, 0.5)
Craftie.Frame.ScrollOrderListColPlayer.Text = Craftie.Frame.ScrollOrderListColPlayer:CreateFontString(nil, "ARTWORK")
Craftie.Frame.ScrollOrderListColPlayer.Text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
Craftie.Frame.ScrollOrderListColPlayer.Text:SetPoint("TOPLEFT", 8, -6)
Craftie.Frame.ScrollOrderListColPlayer.Text:SetText("Player")

Craftie.Frame.ScrollOrderListColItem = CreateFrame("Button", nil, Craftie.Frame.ScrollOrderList.Child, "BackdropTemplate")
Craftie.Frame.ScrollOrderListColItem:SetWidth(col_width.Item)
Craftie.Frame.ScrollOrderListColItem:SetHeight(dimensions.column.H)
Craftie.Frame.ScrollOrderListColItem:SetPoint("TOPLEFT", col_width.Player, dimensions.column.H+1)
Craftie.Frame.ScrollOrderListColItem:SetBackdrop(Craftie.Backdrop.Borderless)
Craftie.Frame.ScrollOrderListColItem:SetBackdropColor(1, 0.9, 0.8, 0.4)
Craftie.Frame.ScrollOrderListColItem.Text = Craftie.Frame.ScrollOrderListColItem:CreateFontString(nil, "ARTWORK")
Craftie.Frame.ScrollOrderListColItem.Text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
Craftie.Frame.ScrollOrderListColItem.Text:SetPoint("TOPLEFT", 8, -6)
Craftie.Frame.ScrollOrderListColItem.Text:SetText("Item")

Craftie.Frame.ScrollOrderListColCount = CreateFrame("Button", nil, Craftie.Frame.ScrollOrderList.Child, "BackdropTemplate")
Craftie.Frame.ScrollOrderListColCount:SetWidth(col_width.Count)
Craftie.Frame.ScrollOrderListColCount:SetHeight(dimensions.column.H)
Craftie.Frame.ScrollOrderListColCount:SetPoint("TOPLEFT", col_width.Player + col_width.Item, dimensions.column.H+1)
Craftie.Frame.ScrollOrderListColCount:SetBackdrop(Craftie.Backdrop.Borderless)
Craftie.Frame.ScrollOrderListColCount:SetBackdropColor(1, 0.9, 0.8, 0.4)
Craftie.Frame.ScrollOrderListColCount.Text = Craftie.Frame.ScrollOrderListColCount:CreateFontString(nil, "ARTWORK")
Craftie.Frame.ScrollOrderListColCount.Text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
Craftie.Frame.ScrollOrderListColCount.Text:SetPoint("TOPLEFT", 8, -6)
Craftie.Frame.ScrollOrderListColCount.Text:SetText("#")

Craftie.Frame.ScrollOrderListColAction = CreateFrame("Button", nil, Craftie.Frame.ScrollOrderList.Child, "BackdropTemplate")
Craftie.Frame.ScrollOrderListColAction:SetWidth(col_width.Action)
Craftie.Frame.ScrollOrderListColAction:SetHeight(dimensions.column.H)
Craftie.Frame.ScrollOrderListColAction:SetPoint("TOPLEFT", col_width.Player + col_width.Item + col_width.Count, dimensions.column.H+1)
Craftie.Frame.ScrollOrderListColAction:SetBackdrop(Craftie.Backdrop.Borderless)
Craftie.Frame.ScrollOrderListColAction:SetBackdropColor(1, 0.9, 0.8, 0.4)

for i=1, Craftie.MAX_ORDERS do
  Craftie.Frame.ScrollOrderListRow[i] = CreateFrame("Button", Craftie.Frame.ScrollOrderListRow[i], Craftie.Frame.ScrollOrderListChildFrame, "BackdropTemplate", -1)
  Craftie.Frame.ScrollOrderListRow[i]:SetWidth(Craftie.Frame.CraftOrders:GetWidth()-26)
  Craftie.Frame.ScrollOrderListRow[i]:SetHeight(dimensions.row.H)
  Craftie.Frame.ScrollOrderListRow[i]:SetPoint("TOPLEFT", 2, -i*Craftie.Frame.ScrollOrderListRow[i]:GetHeight()+16)
  Craftie.Frame.ScrollOrderListRow[i]:SetBackdrop(Craftie.Backdrop.Borderless)
  Craftie.Frame.ScrollOrderListRow[i]:SetBackdropBorderColor(1, 1, 1, 0)
  Craftie.Frame.ScrollOrderListRow[i]:SetBackdropColor(1, 1, 1, 0)
  Craftie.Frame.ScrollOrderListRow[i]:SetFrameLevel(Craftie.Framelevel.Background)
  Craftie.Frame.ScrollOrderListRow[i]:EnableMouse(true)
  Craftie.Frame.ScrollOrderListRow[i]:SetScript("OnEnter", function(self)
    self:SetBackdropColor(1, 0.9, 0.8, 0.2)

    local requester = Craftie.Frame.ScrollOrderListName[i]:GetText()
    if ((requester ~= "") and (requester ~= nil)) then
      Craftie.Frame.ScrollOrderListName[i]:SetTextColor(1, 1, 0.8, 1)
      CraftieTooltip:ClearLines()
      CraftieTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
      CraftieTooltip:AddLine("|CFFFFFFFF" .. requester .. " is requesting ")
      CraftieTooltip:AddLine(Craftie.Frame.ScrollOrderListItem[i]:GetText() .. "x" .. Craftie.Frame.ScrollOrderListCount[i]:GetText())
      CraftieTooltip:AddLine(" ")
      CraftieTooltip:AddDoubleLine(Craftie.Tooltip.Color[1] .. "Enter + Left Click", "|CFFDEDEDEWhisper this player with a response")
      CraftieTooltip:AddDoubleLine(Craftie.Tooltip.Color[1] .. "Right Click",        "|CFFDEDEDEFor more options")
      CraftieTooltip:Show()
    end
  end)
  Craftie.Frame.ScrollOrderListRow[i]:SetScript("OnLeave", function(self)
    self:SetBackdropColor(1, 1, 1, 0)
    Craftie.Frame.ScrollOrderListName[i]:SetTextColor(1, 1, 1, 0.8)
    CraftieTooltip:Hide()
  end)
  Craftie.Frame.ScrollOrderListRow[i]:SetScript("OnClick", function(self)
    local itemLink = Craftie.Frame.ScrollOrderListItem[i]:GetText()
    if (itemLink and itemLink ~= "") then
      ChatEdit_GetActiveWindow()
      ChatEdit_InsertLink("/w " .. Craftie.Frame.ScrollOrderListName[i]:GetText() .. " " .. itemLink .. "x" .. Craftie.Frame.ScrollOrderListCount[i]:GetText())
    end
  end)

  Craftie.Frame.ScrollOrderListBack[i] = Craftie.Frame.ScrollOrderListRow[i]:CreateTexture(nil, "BACKGROUND")
  Craftie.Frame.ScrollOrderListBack[i]:SetSize(Craftie.Frame.ScrollOrderListRow[i]:GetWidth(), Craftie.Frame.ScrollOrderListRow[i]:GetHeight())
  Craftie.Frame.ScrollOrderListBack[i]:SetPoint("TOPLEFT", 0, 0)
  Craftie.Frame.ScrollOrderListBack[i]:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Background-Row1.png")
  Craftie.Frame.ScrollOrderListBack[i]:SetVertexColor(1, 0.8, 0.5)
  Craftie.Frame.ScrollOrderListBack[i]:SetAlpha(0.5)

  Craftie.Frame.ScrollOrderListName[i] = Craftie.Frame.ScrollOrderListRow[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.ScrollOrderListName[i]:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
  Craftie.Frame.ScrollOrderListName[i]:SetPoint("TOPLEFT", 8, -8)
  Craftie.Frame.ScrollOrderListName[i]:SetText("")
  Craftie.Frame.ScrollOrderListName[i]:SetTextColor(1, 1, 1, 0.8)

  Craftie.Frame.ScrollOrderListItem[i] = Craftie.Frame.ScrollOrderListRow[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.ScrollOrderListItem[i]:SetWidth(130)
  Craftie.Frame.ScrollOrderListItem[i]:SetHeight(30)
  Craftie.Frame.ScrollOrderListItem[i]:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
  Craftie.Frame.ScrollOrderListItem[i]:SetPoint("TOPLEFT", 110, -7)
  Craftie.Frame.ScrollOrderListItem[i]:SetText("")
  Craftie.Frame.ScrollOrderListItem[i]:SetJustifyV("TOP")
  Craftie.Frame.ScrollOrderListItem[i]:SetJustifyH("LEFT")
  Craftie.Frame.ScrollOrderListItem[i]:SetScript("OnEnter", function(self)
    if ((self:GetText() ~= "") and (self:GetText() ~= nil)) then
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:SetHyperlink(self:GetText())
    end
  end)
  Craftie.Frame.ScrollOrderListItem[i]:SetScript("OnLeave", function(self)
    GameTooltip:Hide()
  end)

  Craftie.Frame.ScrollOrderListCount[i] = Craftie.Frame.ScrollOrderListRow[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.ScrollOrderListCount[i]:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
  Craftie.Frame.ScrollOrderListCount[i]:SetPoint("TOPLEFT", 250, -8)
  Craftie.Frame.ScrollOrderListCount[i]:SetText("")
  Craftie.Frame.ScrollOrderListCount[i]:SetTextColor(1, 1, 1, 0.8)

  Craftie.Frame.ScrollOrderListSelect[i] = Craftie.Frame.ScrollOrderListRow[i]:CreateTexture(nil, "OVERLAY")
  Craftie.Frame.ScrollOrderListSelect[i]:SetSize(dimensions.parent.W - 30, dimensions.parent.H - 70)
  Craftie.Frame.ScrollOrderListSelect[i]:SetPoint("CENTER", 0, 0)
  Craftie.Frame.ScrollOrderListSelect[i]:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Row-Select.png")
  Craftie.Frame.ScrollOrderListSelect[i]:SetBlendMode("ADD")
  Craftie.Frame.ScrollOrderListSelect[i]:SetVertexColor(0.70, 0.70, 0.60)
  Craftie.Frame.ScrollOrderListSelect[i]:SetAlpha(0.6)
  Craftie.Frame.ScrollOrderListSelect[i]:Hide()

  if (i % 2 == 0) then
    Craftie.Frame.ScrollOrderListBack[i]:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Background-Row2.png")
  end
  if (i % 4 == 0) then
    Craftie.Frame.ScrollOrderListBack[i]:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Background-Row4.png")
  end
end
