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

Craftie.Frame.CraftRequests={}
Craftie.Frame.CraftRequests= CreateFrame("Frame", "Craftie.Frame.CraftRequests", Craftie.Frame, "BackdropTemplate")
Craftie.Frame.CraftRequests:SetWidth(dimensions.parent.W)
Craftie.Frame.CraftRequests:SetHeight(dimensions.parent.H)
Craftie.Frame.CraftRequests:SetPoint("TOPLEFT", dimensions.parent.X, dimensions.parent.Y)
Craftie.Frame.CraftRequests:Hide()

Craftie.Frame.CraftRequestsBackTop={}
Craftie.Frame.CraftRequestsBackTop= CreateFrame("Frame", "Craftie.Frame.CraftRequestsBackTop", Craftie.Frame.CraftRequests, "InsetFrameTemplate4")
Craftie.Frame.CraftRequestsBackTop:SetWidth(Craftie.Frame.CraftRequests:GetWidth())
Craftie.Frame.CraftRequestsBackTop:SetHeight(Craftie.Frame.CraftRequests:GetHeight())
Craftie.Frame.CraftRequestsBackTop:SetPoint("TOPRIGHT", 0, 0)
Craftie.Frame.CraftRequestsBackTop:SetFrameStrata("LOW") --bugfix: Blizzard's UI is so broken and hacky
Craftie.Frame.CraftRequestsBackTopArt = Craftie.Frame.CraftRequestsBackTop:CreateTexture(nil, "BACKGROUND")
Craftie.Frame.CraftRequestsBackTopArt:SetWidth(Craftie.Frame.CraftRequestsBackTop:GetWidth())
Craftie.Frame.CraftRequestsBackTopArt:SetHeight(Craftie.Frame.CraftRequestsBackTop:GetHeight())
Craftie.Frame.CraftRequestsBackTopArt:SetPoint("TOPLEFT", 0, 0)
Craftie.Frame.CraftRequestsBackTopArt:SetTexture(Craftie._G.Image.Background.Shadow)
--Craftie.Frame.CraftRequestsBackTopArt:SetVertexColor(.8, .8, .8) --darker
Craftie.Frame.CraftRequestsBackTopArt:SetDesaturation(0.3)

--[==[
Craftie.Frame.CheckboxReqAutoDel= CreateFrame("CheckButton", nil, Craftie.Frame.CraftRequests, "ChatConfigCheckButtonTemplate")
Craftie.Frame.CheckboxReqAutoDel:SetPoint("TOPLEFT", 10, 25)
Craftie.Frame.CheckboxReqAutoDel:SetChecked(true)
Craftie.Frame.CheckboxReqAutoDel.Text = Craftie.Frame.CheckboxReqAutoDel:CreateFontString(nil, "OVERLAY")
Craftie.Frame.CheckboxReqAutoDel.Text:SetFont(Craftie._G.Font.Style.Alpha, Craftie._G.Font.Size, Craftie._G.Font.Flags)
Craftie.Frame.CheckboxReqAutoDel.Text:SetPoint("TOPLEFT", 26, -6)
Craftie.Frame.CheckboxReqAutoDel.Text:SetText("Auto Delete Requests When Logging Off")
Craftie.Frame.CheckboxReqAutoDel:SetScript("OnClick", function(self)
  local isChecked = self:GetChecked()
  if (isChecked) then
    --Craftie.Save.Player.CONFIG["AUTO_DEL_REQS"] = 1
  else
    --Craftie.Save.Player.CONFIG["AUTO_DEL_REQS"] = 0
  end
  --Craftie:UpdateCrafterList()
end)
Craftie.Frame.CheckboxReqAutoDel:SetScript("OnEnter", function(self)
  CraftieTooltip:ClearLines()
  CraftieTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
  CraftieTooltip:AddLine(Craftie._L.Options.Crafters[3][1])
  CraftieTooltip:AddLine(Craftie.Color.White ..  Craftie._L.Options.Crafters[3][2])
  CraftieTooltip:Show()
end)
Craftie.Frame.CheckboxReqAutoDel:SetScript("OnLeave", function(self)
  CraftieTooltip:Hide()
end)
]==]--

Craftie.Frame.CraftRequestsDeleteAll = CreateFrame("Button", nil, Craftie.Frame.CraftRequests, "UIPanelButtonTemplate")
Craftie.Frame.CraftRequestsDeleteAll:SetWidth(24)
Craftie.Frame.CraftRequestsDeleteAll:SetHeight(24)
Craftie.Frame.CraftRequestsDeleteAll:SetPoint("TOPRIGHT", -30, 30)
Craftie.Frame.CraftRequestsDeleteAll:SetFrameStrata("MEDIUM")
Craftie.Frame.CraftRequestsDeleteAll.icon = Craftie.Frame.CraftRequestsDeleteAll:CreateTexture(nil, "ARTWORK")
Craftie.Frame.CraftRequestsDeleteAll.icon:SetSize(12, 12)
Craftie.Frame.CraftRequestsDeleteAll.icon:SetPoint("CENTER", 0, -1)
Craftie.Frame.CraftRequestsDeleteAll.icon:SetTexture(Craftie._G.Image.Button.Delete)
Craftie.Frame.CraftRequestsDeleteAll:SetScript("OnEnter", function(self)
  CraftieTooltip:ClearLines()
  CraftieTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT", 20)
  CraftieTooltip:AddLine("Delete All")
  CraftieTooltip:Show()
end)
Craftie.Frame.CraftRequestsDeleteAll:SetScript("OnLeave", function(self)
  CraftieTooltip:Hide()
end)
Craftie.Frame.CraftRequestsDeleteAll:SetScript("OnClick", function(self)
  Craftie:Dialog("Delete All Requests?")
  CraftieDialog.Yes:Show()
  CraftieDialog.Yes:SetScript("OnClick", function(self)
    self:GetParent():Hide()

    local reqs = Craftie.Save.Player["REQS"]
    if (reqs ~= nil) then
      for k,v in pairs(reqs) do
        reqs[k] = nil
      end
    end
    Craftie:Notification("Deleted All Requests", Craftie.CHAT.FUNC)

    C_Timer.After(0.2, function()
      Craftie:GetCraftRequests()
      Craftie:CloseAllPlayerMenus()
    end)
  end)

  --Craftie.Frame.ScrollRequestList.Child:SetAlpha(0.6)
  --Craftie.Frame.ScrollRequestList.Child:EnableMouse(false)
  --Craftie.Frame.ScrollRequestList.Child:EnableMouseWheel(false)
  --Craftie.Frame.ScrollRequestList.Child.ScrollBar:Hide()
end)


Craftie.Frame.ScrollRequestList = CreateFrame("Frame", "Craftie.Frame.ScrollRequestList", Craftie.Frame.CraftRequests, "BackdropTemplate")
Craftie.Frame.ScrollRequestList:SetWidth(Craftie.Frame.CraftRequests:GetWidth())
Craftie.Frame.ScrollRequestList:SetHeight(Craftie.Frame.CraftRequests:GetHeight()-dimensions.column.H)
Craftie.Frame.ScrollRequestList:SetPoint("TOPLEFT", 0, -dimensions.column.H)

Craftie.Frame.ScrollRequestList.Child = CreateFrame("ScrollFrame", "Craftie.Frame.ScrollRequestList.Child", Craftie.Frame.ScrollRequestList, "UIPanelScrollFrameTemplate")
Craftie.Frame.ScrollRequestList.Child:SetPoint("TOPLEFT", Craftie.Frame.ScrollRequestList, "TOPLEFT", 5, -10)
Craftie.Frame.ScrollRequestList.Child:SetPoint("BOTTOMRIGHT", Craftie.Frame.ScrollRequestList, "BOTTOMRIGHT", 10, 10)
Craftie.Frame.ScrollRequestListChildFrame = CreateFrame("Frame", "Craftie.Frame.ScrollRequestListChildFrame", Craftie.Frame.ScrollRequestList.Child)
Craftie.Frame.ScrollRequestListChildFrame:SetSize(Craftie.Frame.CraftRequests:GetWidth(), Craftie.Frame.CraftRequests:GetHeight())
Craftie.Frame.ScrollRequestList.Child:SetScrollChild(Craftie.Frame.ScrollRequestListChildFrame)
Craftie.Frame.ScrollRequestList.Child.ScrollBar:ClearAllPoints()
Craftie.Frame.ScrollRequestList.Child.ScrollBar:SetPoint("TOPLEFT", Craftie.Frame.ScrollRequestList.Child, "TOPRIGHT", -32, -5)
Craftie.Frame.ScrollRequestList.Child.ScrollBar:SetPoint("BOTTOMRIGHT", Craftie.Frame.ScrollRequestList.Child, "BOTTOMRIGHT", -11, 5)

Craftie:ScrollBarFrame(Craftie.Frame.ScrollRequestList.Child)

Craftie.Frame.ScrollRequestListRow={}
Craftie.Frame.ScrollRequestListBack={}

Craftie.Frame.ScrollRequestListNameButton={}
Craftie.Frame.ScrollRequestListName={}
Craftie.Frame.ScrollRequestListItemButton={}
Craftie.Frame.ScrollRequestListItem={}
Craftie.Frame.ScrollRequestListCount={}
Craftie.Frame.ScrollRequestListDate={}
Craftie.Frame.ScrollRequestListSelect={}
Craftie.Frame.ScrollRequestListDelete={}

local columns = {
  --name, width, xpos
  {"Player",150, 4},
  {"Item",  300, 156},
  {"#",     50,  458},
  {"Date",  120, 510},
  {"",      194, 632}
}
local column_color = {1, 0.9, 0.8, 0.4}

Craftie.Frame.ScrollRequestListCol={}
for k,v in pairs(columns) do
  Craftie.Frame.ScrollRequestListCol[k]= CreateFrame("Button", nil, Craftie.Frame.ScrollRequestList.Child, "BackdropTemplate")
  Craftie.Frame.ScrollRequestListCol[k]:SetWidth(columns[k][2])
  Craftie.Frame.ScrollRequestListCol[k]:SetHeight(dimensions.column.H-1)
  Craftie.Frame.ScrollRequestListCol[k]:SetPoint("TOPLEFT", columns[k][3]-3, dimensions.column.H+6)
  Craftie.Frame.ScrollRequestListCol[k]:SetBackdrop(Craftie.Backdrop.Borderless)
  Craftie.Frame.ScrollRequestListCol[k]:SetBackdropColor(column_color[1], column_color[2], column_color[3], column_color[4])
  Craftie.Frame.ScrollRequestListCol[k].Text = Craftie.Frame.ScrollRequestListCol[k]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.ScrollRequestListCol[k].Text:SetFont(Craftie._G.Font.Style.Alpha, Craftie._G.Font.Size, Craftie._G.Font.Flags)
  Craftie.Frame.ScrollRequestListCol[k].Text:SetPoint("TOPLEFT", 8, -6)
  Craftie.Frame.ScrollRequestListCol[k].Text:SetText(v[1])
end

function Craftie:BuildRowRequest(i)
  Craftie.Frame.ScrollRequestListRow[i] = CreateFrame("Frame", Craftie.Frame.ScrollRequestListRow[i], Craftie.Frame.ScrollRequestListChildFrame, "BackdropTemplate", -1)
  Craftie.Frame.ScrollRequestListRow[i]:SetWidth(Craftie.Frame.CraftRequests:GetWidth()-26)
  Craftie.Frame.ScrollRequestListRow[i]:SetHeight(dimensions.row.H)
  Craftie.Frame.ScrollRequestListRow[i]:SetPoint("TOPLEFT", 2, -i*Craftie.Frame.ScrollRequestListRow[i]:GetHeight()+16)
  Craftie.Frame.ScrollRequestListRow[i]:SetBackdrop(Craftie.Backdrop.Borderless)
  Craftie.Frame.ScrollRequestListRow[i]:SetBackdropBorderColor(1, 1, 1, 0)
  Craftie.Frame.ScrollRequestListRow[i]:SetBackdropColor(0, 0, 0, 0)
  Craftie.Frame.ScrollRequestListRow[i]:SetFrameLevel(Craftie.Framelevel.Background)
  Craftie.Frame.ScrollRequestListRow[i]:SetScript("OnEnter", function(self)
    self:SetBackdropColor(1, 0.9, 0.8, 0.2)
  end)
  Craftie.Frame.ScrollRequestListRow[i]:SetScript("OnLeave", function(self)
    self:SetBackdropColor(0, 0, 0, 0)
  end)

  Craftie.Frame.ScrollRequestListDelete[i] = CreateFrame("Button", nil, Craftie.Frame.ScrollRequestListRow[i], "UIPanelButtonTemplate")
  Craftie.Frame.ScrollRequestListDelete[i]:SetWidth(24)
  Craftie.Frame.ScrollRequestListDelete[i]:SetHeight(24)
  Craftie.Frame.ScrollRequestListDelete[i]:SetPoint("TOPRIGHT", -30, 0)
  --Craftie.Frame.ScrollRequestListDelete[i]:SetFrameStrata("MEDIUM")
  Craftie.Frame.ScrollRequestListDelete[i].icon = Craftie.Frame.ScrollRequestListDelete[i]:CreateTexture(nil, "ARTWORK")
  Craftie.Frame.ScrollRequestListDelete[i].icon:SetSize(12, 12)
  Craftie.Frame.ScrollRequestListDelete[i].icon:SetPoint("CENTER", 0, -1)
  Craftie.Frame.ScrollRequestListDelete[i].icon:SetTexture(Craftie._G.Image.Button.Delete)
  Craftie.Frame.ScrollRequestListDelete[i]:Hide()
  Craftie.Frame.ScrollRequestListDelete[i]:SetScript("OnEnter", function(self)
    local requester = Craftie.Frame.ScrollRequestListName[i]:GetText()
    if ((requester ~= "") and (requester ~= nil)) then
      CraftieTooltip:ClearLines()
      CraftieTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT", 20)
      --CraftieTooltip:AddLine("Delete Request For " .. requester)
      CraftieTooltip:AddLine(Craftie.Color.Silver .. "Delete Request from " .. requester)
      CraftieTooltip:Show()
    end
  end)
  Craftie.Frame.ScrollRequestListDelete[i]:SetScript("OnLeave", function(self)
    CraftieTooltip:Hide()
  end)
  Craftie.Frame.ScrollRequestListDelete[i]:SetScript("OnClick", function(self)
    local requester = Craftie.Frame.ScrollRequestListName[i]:GetText()
    if ((requester ~= "") and (requester ~= nil)) then
      Craftie.Save.Player["REQS"][requester] = nil
    end
    C_Timer.After(0.2, function()
      Craftie:GetCraftRequests()
    end)
  end)

  Craftie.Frame.ScrollRequestListBack[i] = Craftie.Frame.ScrollRequestListRow[i]:CreateTexture(nil, "BACKGROUND")
  Craftie.Frame.ScrollRequestListBack[i]:SetSize(Craftie.Frame.ScrollRequestListRow[i]:GetWidth(), Craftie.Frame.ScrollRequestListRow[i]:GetHeight())
  Craftie.Frame.ScrollRequestListBack[i]:SetPoint("TOPLEFT", 0, 0)
  Craftie.Frame.ScrollRequestListBack[i]:SetTexture(Craftie._G.Image.Row[1])
  Craftie.Frame.ScrollRequestListBack[i]:SetVertexColor(1, 0.8, 0.5)
  Craftie.Frame.ScrollRequestListBack[i]:SetAlpha(0.5)

  Craftie.Frame.ScrollRequestListNameButton[i] = CreateFrame("Button", nil, Craftie.Frame.ScrollRequestListRow[i], "BackdropTemplate", 1)
  Craftie.Frame.ScrollRequestListNameButton[i]:SetSize(columns[1][2], dimensions.row.H)
  Craftie.Frame.ScrollRequestListNameButton[i]:SetPoint("TOPLEFT", 4, 0)
  Craftie.Frame.ScrollRequestListNameButton[i]:SetBackdrop(Craftie.Backdrop.Borderless)
  Craftie.Frame.ScrollRequestListNameButton[i]:SetBackdropColor(0, 1, 0, 0)
  Craftie.Frame.ScrollRequestListName[i] = Craftie.Frame.ScrollRequestListNameButton[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.ScrollRequestListName[i]:SetFont(Craftie._G.Font.Style.Alpha, Craftie._G.Font.Size, Craftie._G.Font.Flags)
  Craftie.Frame.ScrollRequestListName[i]:SetPoint("TOPLEFT", 4, -6)
  Craftie.Frame.ScrollRequestListName[i]:SetText("")
  Craftie.Frame.ScrollRequestListName[i]:SetTextColor(1, 1, 1, 0.8)
  Craftie.Frame.ScrollRequestListNameButton[i]:SetScript("OnEnter", function(self)
    self:GetParent():SetBackdropColor(1, 0.9, 0.8, 0.2)
    local requester = Craftie.Frame.ScrollRequestListName[i]:GetText()
    if ((requester ~= "") and (requester ~= nil)) then
      CraftieTooltip:ClearLines()
      CraftieTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT", 20)
      CraftieTooltip:AddLine(Craftie.Color.White .. requester .. " is requesting ")
      CraftieTooltip:AddLine(Craftie.Frame.ScrollRequestListItem[i]:GetText() .. "x" .. Craftie.Frame.ScrollRequestListCount[i]:GetText())
      CraftieTooltip:AddLine(" ")
      CraftieTooltip:AddDoubleLine(Craftie.Color.Blue .. "Enter + Left Click", Craftie.Color.Silver .. "Whisper this player with a response")
      CraftieTooltip:Show()
    end
  end)
  Craftie.Frame.ScrollRequestListNameButton[i]:SetScript("OnLeave", function(self)
    self:GetParent():SetBackdropColor(0, 0, 0, 0)
    CraftieTooltip:Hide()
  end)
  Craftie.Frame.ScrollRequestListNameButton[i]:SetScript("OnClick", function(self)
    local requester = Craftie.Frame.ScrollRequestListName[i]:GetText()
    if ((requester ~= "") and (requester ~= nil)) then
      ChatEdit_GetActiveWindow()
      ChatEdit_InsertLink("/w " .. requester .. " ")
    end
  end)

  Craftie.Frame.ScrollRequestListItemButton[i] = CreateFrame("Button", nil, Craftie.Frame.ScrollRequestListRow[i], "BackdropTemplate", 1)
  Craftie.Frame.ScrollRequestListItemButton[i]:SetSize(columns[2][2], dimensions.row.H)
  Craftie.Frame.ScrollRequestListItemButton[i]:SetPoint("TOPLEFT", columns[2][3], 0)
  Craftie.Frame.ScrollRequestListItemButton[i]:SetBackdrop(Craftie.Backdrop.Borderless)
  Craftie.Frame.ScrollRequestListItemButton[i]:SetBackdropColor(1, 0, 0, 0)
  Craftie.Frame.ScrollRequestListItem[i] = Craftie.Frame.ScrollRequestListItemButton[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.ScrollRequestListItem[i]:SetFont(Craftie._G.Font.Style.Alpha, Craftie._G.Font.Size, Craftie._G.Font.Flags)
  Craftie.Frame.ScrollRequestListItem[i]:SetPoint("TOPLEFT", 4, -6)
  Craftie.Frame.ScrollRequestListItem[i]:SetText("")
  Craftie.Frame.ScrollRequestListItemButton[i]:SetScript("OnEnter", function(self)
    self:GetParent():SetBackdropColor(1, 0.9, 0.8, 0.2)

    --raw link saved
    local link = Craftie.Frame.ScrollRequestListItem[i]:GetText()
    if ((link ~= "") and (link ~= nil)) then
      CraftieTooltip:ClearAllPoints()
      CraftieTooltip:ClearLines()
      CraftieTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT", 20)
      CraftieTooltip:SetHyperlink(link)
      Craftie:TooltipLinkOpts()
      CraftieTooltip:Show()
    end
  end)
  Craftie.Frame.ScrollRequestListItemButton[i]:SetScript("OnLeave", function(self)
    self:GetParent():SetBackdropColor(0, 0, 0, 0)
    CraftieTooltip:Hide()
  end)
  Craftie.Frame.ScrollRequestListItemButton[i]:SetScript("OnClick", function(self, button)
    local link = Craftie.Frame.ScrollRequestListItem[i]:GetText()
    if (link ~= nil and link ~= "") then
      if (IsShiftKeyDown()) then
        ChatEdit_GetActiveWindow()
        ChatEdit_InsertLink(link)
      end
    end
  end)

  Craftie.Frame.ScrollRequestListCount[i] = Craftie.Frame.ScrollRequestListRow[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.ScrollRequestListCount[i]:SetFont(Craftie._G.Font.Style.Numeric, Craftie._G.Font.Size+2, Craftie._G.Font.Flags)
  Craftie.Frame.ScrollRequestListCount[i]:SetPoint("TOPLEFT", columns[3][3]+4, dimensions.row.Y)
  Craftie.Frame.ScrollRequestListCount[i]:SetText("")
  Craftie.Frame.ScrollRequestListCount[i]:SetTextColor(1, 1, 1, 0.8)

  Craftie.Frame.ScrollRequestListDate[i] = Craftie.Frame.ScrollRequestListRow[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.ScrollRequestListDate[i]:SetFont(Craftie._G.Font.Style.Numeric, Craftie._G.Font.Size, Craftie._G.Font.Flags)
  Craftie.Frame.ScrollRequestListDate[i]:SetPoint("TOPLEFT", columns[4][3]+4, dimensions.row.Y)
  Craftie.Frame.ScrollRequestListDate[i]:SetText("")
  Craftie.Frame.ScrollRequestListDate[i]:SetTextColor(0.7, 0.7, 0.7, 1)

  Craftie.Frame.ScrollRequestListSelect[i] = Craftie.Frame.ScrollRequestListRow[i]:CreateTexture(nil, "OVERLAY")
  Craftie.Frame.ScrollRequestListSelect[i]:SetSize(Craftie.Frame.ScrollRequestListRow[i]:GetWidth(), Craftie.Frame.ScrollRequestListRow[i]:GetHeight())
  Craftie.Frame.ScrollRequestListSelect[i]:SetPoint("CENTER", 0, 0)
  Craftie.Frame.ScrollRequestListSelect[i]:SetTexture(Craftie._G.Image.Row.Select)
  Craftie.Frame.ScrollRequestListSelect[i]:SetBlendMode("ADD")
  Craftie.Frame.ScrollRequestListSelect[i]:SetVertexColor(0.70, 0.70, 0.56)
  Craftie.Frame.ScrollRequestListSelect[i]:SetAlpha(0.5)
  Craftie.Frame.ScrollRequestListSelect[i]:Hide()

  if (i % 2 == 0) then
    Craftie.Frame.ScrollRequestListBack[i]:SetTexture(Craftie._G.Image.Row[2])
  end
  if (i % 4 == 0) then
    Craftie.Frame.ScrollRequestListBack[i]:SetTexture(Craftie._G.Image.Row[3])
  end
end

function Craftie:RowAddRequest(count)
  for i = #Craftie.TOTAL_REQUESTS + 1, count do
    Craftie:BuildRowRequest(i)
    Craftie.TOTAL_REQUESTS[i] = Craftie.Frame.ScrollRequestListRow[i]
  end

  local contentHeight = math.max(Craftie.Frame.CraftRequests:GetHeight(), count * dimensions.row.H + 16)
  Craftie.Frame.ScrollRequestListChildFrame:SetHeight(contentHeight)
  Craftie:Notification("Craftie:RowAddRequest() " .. count, Craftie.CHAT.FUNC)
end

--25 rows off the init
Craftie:RowAddRequest(25)
