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
--[==[
Craftie.Frame.CraftRequestsRefresh = CreateFrame("Button", nil, Craftie.Frame.CraftRequests, "UIPanelButtonTemplate")
Craftie.Frame.CraftRequestsRefresh:SetWidth(24)
Craftie.Frame.CraftRequestsRefresh:SetHeight(24)
Craftie.Frame.CraftRequestsRefresh:SetPoint("TOPRIGHT", -55, 30)
Craftie.Frame.CraftRequestsRefresh:SetFrameStrata("MEDIUM")
Craftie.Frame.CraftRequestsRefresh.icon = Craftie.Frame.CraftRequestsRefresh:CreateTexture(nil, "ARTWORK")
Craftie.Frame.CraftRequestsRefresh.icon:SetSize(12, 12)
Craftie.Frame.CraftRequestsRefresh.icon:SetPoint("CENTER", 0, -1)
Craftie.Frame.CraftRequestsRefresh.icon:SetTexture("Interface/Buttons/UI-RefreshButton")
Craftie.Frame.CraftRequestsRefresh:SetScript("OnEnter", function(self)
  CraftieTooltip:ClearLines()
  CraftieTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT", 20)
  CraftieTooltip:AddLine(Craftie.Color.Silver .. "Refresh")
  CraftieTooltip:Show()
end)
Craftie.Frame.CraftRequestsRefresh:SetScript("OnLeave", function(self)
  CraftieTooltip:Hide()
end)
Craftie.Frame.CraftRequestsRefresh:SetScript("OnClick", function(self)
  Craftie:GetCraftOrders()
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
      --Craftie:GetCraftOrders()
      Craftie:CloseAllPlayerMenus()
    end)
  end)

  --Craftie.Frame.ScrollOrderList.Child:SetAlpha(0.6)
  --Craftie.Frame.ScrollOrderList.Child:EnableMouse(false)
  --Craftie.Frame.ScrollOrderList.Child:EnableMouseWheel(false)
  --Craftie.Frame.ScrollOrderList.Child.ScrollBar:Hide()
end)
