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
    X = 12,
    Y = -100
  },
  column = {
    H = 24,
  },
  row = {
    H = 24,
    Y = -6,
  }
}

Craftie.Frame.CraftOrders={}
Craftie.Frame.CraftOrders= CreateFrame("Frame", "Craftie.Frame.CraftOrders", Craftie.Frame, "BackdropTemplate")
Craftie.Frame.CraftOrders:SetWidth(dimensions.parent.W)
Craftie.Frame.CraftOrders:SetHeight(dimensions.parent.H)
Craftie.Frame.CraftOrders:SetPoint("TOPLEFT", dimensions.parent.X, dimensions.parent.Y)
Craftie.Frame.CraftOrders:Hide()

Craftie.Frame.CraftOrdersBackTop={}
Craftie.Frame.CraftOrdersBackTop= CreateFrame("Frame", "Craftie.Frame.CraftOrdersBackTop", Craftie.Frame.CraftOrders, "InsetFrameTemplate4")
Craftie.Frame.CraftOrdersBackTop:SetWidth(Craftie.Frame.CraftOrders:GetWidth())
Craftie.Frame.CraftOrdersBackTop:SetHeight(Craftie.Frame.CraftOrders:GetHeight())
Craftie.Frame.CraftOrdersBackTop:SetPoint("TOPRIGHT", 0, 0)
Craftie.Frame.CraftOrdersBackTop:SetFrameStrata("LOW") --bugfix: Blizzard's UI is so broken and hacky
Craftie.Frame.CraftOrdersBackTopArt = Craftie.Frame.CraftOrdersBackTop:CreateTexture(nil, "BACKGROUND")
Craftie.Frame.CraftOrdersBackTopArt:SetWidth(Craftie.Frame.CraftOrdersBackTop:GetWidth())
Craftie.Frame.CraftOrdersBackTopArt:SetHeight(Craftie.Frame.CraftOrdersBackTop:GetHeight())
Craftie.Frame.CraftOrdersBackTopArt:SetPoint("TOPLEFT", 0, 0)
Craftie.Frame.CraftOrdersBackTopArt:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Background-Shadow.png")
--Craftie.Frame.CraftOrdersBackTopArt:SetVertexColor(.8, .8, .8) --darker
Craftie.Frame.CraftOrdersBackTopArt:SetDesaturation(0.3)

Craftie.Frame.CraftOrdersRefresh = CreateFrame("Button", nil, Craftie.Frame.CraftOrders, "UIPanelButtonTemplate")
Craftie.Frame.CraftOrdersRefresh:SetWidth(24)
Craftie.Frame.CraftOrdersRefresh:SetHeight(24)
Craftie.Frame.CraftOrdersRefresh:SetPoint("TOPRIGHT", -55, 30)
Craftie.Frame.CraftOrdersRefresh:SetFrameStrata("MEDIUM")
Craftie.Frame.CraftOrdersRefresh.icon = Craftie.Frame.CraftOrdersRefresh:CreateTexture(nil, "ARTWORK")
Craftie.Frame.CraftOrdersRefresh.icon:SetSize(12, 12)
Craftie.Frame.CraftOrdersRefresh.icon:SetPoint("CENTER", 0, -1)
Craftie.Frame.CraftOrdersRefresh.icon:SetTexture("Interface/Buttons/UI-RefreshButton")
Craftie.Frame.CraftOrdersRefresh:SetScript("OnEnter", function(self)
  CraftieTooltip:ClearLines()
  CraftieTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
  CraftieTooltip:AddLine(Craftie.Color.Silver .. "Refresh")
  CraftieTooltip:Show()
end)
Craftie.Frame.CraftOrdersRefresh:SetScript("OnLeave", function(self)
  CraftieTooltip:Hide()
end)
Craftie.Frame.CraftOrdersRefresh:SetScript("OnClick", function(self)
  Craftie:GetCraftOrders()
end)

Craftie.Frame.CraftOrdersDeleteAll = CreateFrame("Button", nil, Craftie.Frame.CraftOrders, "UIPanelButtonTemplate")
Craftie.Frame.CraftOrdersDeleteAll:SetWidth(24)
Craftie.Frame.CraftOrdersDeleteAll:SetHeight(24)
Craftie.Frame.CraftOrdersDeleteAll:SetPoint("TOPRIGHT", -30, 30)
Craftie.Frame.CraftOrdersDeleteAll:SetFrameStrata("MEDIUM")
Craftie.Frame.CraftOrdersDeleteAll.icon = Craftie.Frame.CraftOrdersDeleteAll:CreateTexture(nil, "ARTWORK")
Craftie.Frame.CraftOrdersDeleteAll.icon:SetSize(12, 12)
Craftie.Frame.CraftOrdersDeleteAll.icon:SetPoint("CENTER", 0, -1)
Craftie.Frame.CraftOrdersDeleteAll.icon:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Button-Delete.png")
Craftie.Frame.CraftOrdersDeleteAll:SetScript("OnEnter", function(self)
  CraftieTooltip:ClearLines()
  CraftieTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
  CraftieTooltip:AddLine("Delete All")
  CraftieTooltip:Show()
end)
Craftie.Frame.CraftOrdersDeleteAll:SetScript("OnLeave", function(self)
  CraftieTooltip:Hide()
end)
Craftie.Frame.CraftOrdersDeleteAll:SetScript("OnClick", function(self)
  Craftie:Dialog("Delete All Orders?")
  CraftieDialog.Yes:Show()
  CraftieDialog.Yes:SetScript("OnClick", function(self)
    self:GetParent():Hide()

    local orders = Craftie.Save.Player.ORDERS
    if (orders ~= nil) then
      for k,v in pairs(orders) do
        orders[k] = nil
      end
    end
    Craftie:Notification("Deleted All Orders", Craftie.CHAT.FUNC)

    C_Timer.After(0.2, function()
      Craftie:GetCraftOrders()
      Craftie:CloseAllPlayerMenus()
    end)
  end)

  Craftie.Frame.ScrollOrderList.Child:SetAlpha(0.6)
  Craftie.Frame.ScrollOrderList.Child:EnableMouse(false)
  Craftie.Frame.ScrollOrderList.Child:EnableMouseWheel(false)
  Craftie.Frame.ScrollOrderList.Child.ScrollBar:Hide()
end)

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

Craftie.Frame.ScrollOrderListNameButton={}
Craftie.Frame.ScrollOrderListName={}
Craftie.Frame.ScrollOrderListItemButton={}
Craftie.Frame.ScrollOrderListItem={}
Craftie.Frame.ScrollOrderListCount={}
Craftie.Frame.ScrollOrderListDate={}
Craftie.Frame.ScrollOrderListSelect={}
Craftie.Frame.ScrollOrderListDelete={}

local columns = {
  {"Player",150, 4},
  {"Item",  300, 156},
  {"#",     50,  458},
  {"Date",  120, 510},
  {"",      174, 632}
}
--local column_color = {0.7, 0.6, 0.5, 0.5}
local column_color = {1, 0.9, 0.8, 0.4}

Craftie.Frame.ScrollOrderListCol={}
for k,v in pairs(columns) do
  Craftie.Frame.ScrollOrderListCol[k]= CreateFrame("Button", nil, Craftie.Frame.ScrollOrderList.Child, "BackdropTemplate")
  Craftie.Frame.ScrollOrderListCol[k]:SetWidth(columns[k][2])
  Craftie.Frame.ScrollOrderListCol[k]:SetHeight(dimensions.column.H)
  Craftie.Frame.ScrollOrderListCol[k]:SetPoint("TOPLEFT", columns[k][3], dimensions.column.H+1)
  Craftie.Frame.ScrollOrderListCol[k]:SetBackdrop(Craftie.Backdrop.Borderless)
  Craftie.Frame.ScrollOrderListCol[k]:SetBackdropColor(column_color[1], column_color[2], column_color[3], column_color[4])
  Craftie.Frame.ScrollOrderListCol[k].Text = Craftie.Frame.ScrollOrderListCol[k]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.ScrollOrderListCol[k].Text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
  Craftie.Frame.ScrollOrderListCol[k].Text:SetPoint("TOPLEFT", 8, -6)
  Craftie.Frame.ScrollOrderListCol[k].Text:SetText(v[1])
end

for i=1, Craftie.MAX_ORDERS do
  Craftie.Frame.ScrollOrderListRow[i] = CreateFrame("Frame", Craftie.Frame.ScrollOrderListRow[i], Craftie.Frame.ScrollOrderListChildFrame, "BackdropTemplate", -1)
  Craftie.Frame.ScrollOrderListRow[i]:SetWidth(Craftie.Frame.CraftOrders:GetWidth()-26)
  Craftie.Frame.ScrollOrderListRow[i]:SetHeight(dimensions.row.H)
  Craftie.Frame.ScrollOrderListRow[i]:SetPoint("TOPLEFT", 2, -i*Craftie.Frame.ScrollOrderListRow[i]:GetHeight()+16)
  Craftie.Frame.ScrollOrderListRow[i]:SetBackdrop(Craftie.Backdrop.Borderless)
  Craftie.Frame.ScrollOrderListRow[i]:SetBackdropBorderColor(1, 1, 1, 0)
  Craftie.Frame.ScrollOrderListRow[i]:SetBackdropColor(0, 0, 0, 0)
  Craftie.Frame.ScrollOrderListRow[i]:SetFrameLevel(Craftie.Framelevel.Background)
  Craftie.Frame.ScrollOrderListRow[i]:SetScript("OnEnter", function(self)
    self:SetBackdropColor(1, 0.9, 0.8, 0.2)
  end)
  Craftie.Frame.ScrollOrderListRow[i]:SetScript("OnLeave", function(self)
    self:SetBackdropColor(0, 0, 0, 0)
  end)

  Craftie.Frame.ScrollOrderListDelete[i] = CreateFrame("Button", nil, Craftie.Frame.ScrollOrderListRow[i], "UIPanelButtonTemplate")
  Craftie.Frame.ScrollOrderListDelete[i]:SetWidth(24)
  Craftie.Frame.ScrollOrderListDelete[i]:SetHeight(24)
  Craftie.Frame.ScrollOrderListDelete[i]:SetPoint("TOPRIGHT", -30, 0)
  --Craftie.Frame.ScrollOrderListDelete[i]:SetFrameStrata("MEDIUM")
  Craftie.Frame.ScrollOrderListDelete[i].icon = Craftie.Frame.ScrollOrderListDelete[i]:CreateTexture(nil, "ARTWORK")
  Craftie.Frame.ScrollOrderListDelete[i].icon:SetSize(12, 12)
  Craftie.Frame.ScrollOrderListDelete[i].icon:SetPoint("CENTER", 0, -1)
  Craftie.Frame.ScrollOrderListDelete[i].icon:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Button-Delete.png")
  Craftie.Frame.ScrollOrderListDelete[i]:Hide()
  Craftie.Frame.ScrollOrderListDelete[i]:SetScript("OnEnter", function(self)
    local requester = Craftie.Frame.ScrollOrderListName[i]:GetText()
    if ((requester ~= "") and (requester ~= nil)) then
      CraftieTooltip:ClearLines()
      CraftieTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      --CraftieTooltip:AddLine("Delete Order For " .. requester)
      CraftieTooltip:AddLine(Craftie.Color.Silver .. "Delete Order for " .. requester)
      CraftieTooltip:Show()
    end
  end)
  Craftie.Frame.ScrollOrderListDelete[i]:SetScript("OnLeave", function(self)
    CraftieTooltip:Hide()
  end)
  Craftie.Frame.ScrollOrderListDelete[i]:SetScript("OnClick", function(self)
    local requester = Craftie.Frame.ScrollOrderListName[i]:GetText()
    if ((requester ~= "") and (requester ~= nil)) then
      Craftie.Save.Player.ORDERS[requester] = nil
    end
    C_Timer.After(0.2, function()
      Craftie:GetCraftOrders()
    end)
  end)

  Craftie.Frame.ScrollOrderListBack[i] = Craftie.Frame.ScrollOrderListRow[i]:CreateTexture(nil, "BACKGROUND")
  Craftie.Frame.ScrollOrderListBack[i]:SetSize(Craftie.Frame.ScrollOrderListRow[i]:GetWidth(), Craftie.Frame.ScrollOrderListRow[i]:GetHeight())
  Craftie.Frame.ScrollOrderListBack[i]:SetPoint("TOPLEFT", 0, 0)
  Craftie.Frame.ScrollOrderListBack[i]:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Background-Row1.png")
  Craftie.Frame.ScrollOrderListBack[i]:SetVertexColor(1, 0.8, 0.5)
  Craftie.Frame.ScrollOrderListBack[i]:SetAlpha(0.5)

  Craftie.Frame.ScrollOrderListNameButton[i] = CreateFrame("Button", nil, Craftie.Frame.ScrollOrderListRow[i], "BackdropTemplate", 1)
  Craftie.Frame.ScrollOrderListNameButton[i]:SetSize(columns[1][2], dimensions.row.H)
  Craftie.Frame.ScrollOrderListNameButton[i]:SetPoint("TOPLEFT", 4, 0)
  Craftie.Frame.ScrollOrderListNameButton[i]:SetBackdrop(Craftie.Backdrop.Borderless)
  Craftie.Frame.ScrollOrderListNameButton[i]:SetBackdropColor(0, 1, 0, 0)
  Craftie.Frame.ScrollOrderListName[i] = Craftie.Frame.ScrollOrderListNameButton[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.ScrollOrderListName[i]:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
  Craftie.Frame.ScrollOrderListName[i]:SetPoint("TOPLEFT", 4, -6)
  Craftie.Frame.ScrollOrderListName[i]:SetText("")
  Craftie.Frame.ScrollOrderListName[i]:SetTextColor(1, 1, 1, 0.8)
  Craftie.Frame.ScrollOrderListNameButton[i]:SetScript("OnEnter", function(self)
    self:GetParent():SetBackdropColor(1, 0.9, 0.8, 0.2)
    local requester = Craftie.Frame.ScrollOrderListName[i]:GetText()
    if ((requester ~= "") and (requester ~= nil)) then
      CraftieTooltip:ClearLines()
      CraftieTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      CraftieTooltip:AddLine(Craftie.Color.White .. requester .. " is requesting ")
      CraftieTooltip:AddLine(Craftie.Frame.ScrollOrderListItem[i]:GetText() .. "x" .. Craftie.Frame.ScrollOrderListCount[i]:GetText())
      CraftieTooltip:AddLine(" ")
      CraftieTooltip:AddDoubleLine(Craftie.Color.Blue .. "Enter + Left Click", Craftie.Color.Silver .. "Whisper this player with a response")
      CraftieTooltip:Show()
    end
  end)
  Craftie.Frame.ScrollOrderListNameButton[i]:SetScript("OnLeave", function(self)
    self:GetParent():SetBackdropColor(0, 0, 0, 0)
    CraftieTooltip:Hide()
  end)
  Craftie.Frame.ScrollOrderListNameButton[i]:SetScript("OnClick", function(self)
    local requester = Craftie.Frame.ScrollOrderListName[i]:GetText()
    if ((requester ~= "") and (requester ~= nil)) then
      ChatEdit_GetActiveWindow()
      ChatEdit_InsertLink("/w " .. requester .. " ")
    end
  end)

  Craftie.Frame.ScrollOrderListItemButton[i] = CreateFrame("Button", nil, Craftie.Frame.ScrollOrderListRow[i], "BackdropTemplate", 1)
  Craftie.Frame.ScrollOrderListItemButton[i]:SetSize(columns[2][2], dimensions.row.H)
  Craftie.Frame.ScrollOrderListItemButton[i]:SetPoint("TOPLEFT", columns[2][3], 0)
  Craftie.Frame.ScrollOrderListItemButton[i]:SetBackdrop(Craftie.Backdrop.Borderless)
  Craftie.Frame.ScrollOrderListItemButton[i]:SetBackdropColor(1, 0, 0, 0)
  Craftie.Frame.ScrollOrderListItem[i] = Craftie.Frame.ScrollOrderListItemButton[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.ScrollOrderListItem[i]:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
  Craftie.Frame.ScrollOrderListItem[i]:SetPoint("TOPLEFT", 4, -6)
  Craftie.Frame.ScrollOrderListItem[i]:SetText("")
  Craftie.Frame.ScrollOrderListItemButton[i]:SetScript("OnEnter", function(self)
    self:GetParent():SetBackdropColor(1, 0.9, 0.8, 0.2)
    local link = Craftie.Frame.ScrollOrderListItem[i]:GetText()
    if ((link ~= "") and (link ~= nil)) then
      GameTooltip:ClearLines()
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
      GameTooltip:SetHyperlink(link)
    end
  end)
  Craftie.Frame.ScrollOrderListItemButton[i]:SetScript("OnLeave", function(self)
    self:GetParent():SetBackdropColor(0, 0, 0, 0)
    GameTooltip:Hide()
  end)
  Craftie.Frame.ScrollOrderListItemButton[i]:SetScript("OnClick", function(self, button)
    local link = Craftie.Frame.ScrollOrderListItem[i]:GetText()
    if (link ~= nil and link ~= "") then
      if (IsShiftKeyDown()) then
        ChatEdit_GetActiveWindow()
        ChatEdit_InsertLink(link)
      end
    end
  end)

  Craftie.Frame.ScrollOrderListCount[i] = Craftie.Frame.ScrollOrderListRow[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.ScrollOrderListCount[i]:SetFont(Craftie._G.Font.StyleN, Craftie._G.Font.Size+1, "SLUG")
  Craftie.Frame.ScrollOrderListCount[i]:SetPoint("TOPLEFT", columns[3][3]+4, dimensions.row.Y)
  Craftie.Frame.ScrollOrderListCount[i]:SetText("")
  Craftie.Frame.ScrollOrderListCount[i]:SetTextColor(1, 1, 1, 0.8)

  Craftie.Frame.ScrollOrderListDate[i] = Craftie.Frame.ScrollOrderListRow[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.ScrollOrderListDate[i]:SetFont(Craftie._G.Font.StyleN, Craftie._G.Font.Size-1, "SLUG")
  Craftie.Frame.ScrollOrderListDate[i]:SetPoint("TOPLEFT", columns[4][3]+4, dimensions.row.Y)
  Craftie.Frame.ScrollOrderListDate[i]:SetText("")
  Craftie.Frame.ScrollOrderListDate[i]:SetTextColor(1, 1, 1, 0.8)

  Craftie.Frame.ScrollOrderListSelect[i] = Craftie.Frame.ScrollOrderListRow[i]:CreateTexture(nil, "OVERLAY")
  Craftie.Frame.ScrollOrderListSelect[i]:SetSize(Craftie.Frame.ScrollOrderListRow[i]:GetWidth(), Craftie.Frame.ScrollOrderListRow[i]:GetHeight())
  Craftie.Frame.ScrollOrderListSelect[i]:SetPoint("CENTER", 0, 0)
  Craftie.Frame.ScrollOrderListSelect[i]:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Row-Select.png")
  Craftie.Frame.ScrollOrderListSelect[i]:SetBlendMode("ADD")
  Craftie.Frame.ScrollOrderListSelect[i]:SetVertexColor(0.70, 0.70, 0.56)
  Craftie.Frame.ScrollOrderListSelect[i]:SetAlpha(0.5)
  Craftie.Frame.ScrollOrderListSelect[i]:Hide()

  if (i % 2 == 0) then
    Craftie.Frame.ScrollOrderListBack[i]:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Background-Row2.png")
  end
  if (i % 4 == 0) then
    Craftie.Frame.ScrollOrderListBack[i]:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Background-Row4.png")
  end
end
