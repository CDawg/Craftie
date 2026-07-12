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

--each cell
local dimensions = {
  Parent = {
    W = 676,
    H = 520,
  },
  Cell = {
    W = 310,
  }
}

Craftie.Options={}
Craftie.Options.Frame = CreateFrame("Frame", "Craftie.Options.Frame", UIParent)
Craftie.Options.Category = Settings.RegisterCanvasLayoutCategory(Craftie.Options.Frame, Craftie._G.Title)
Craftie.Options.Frame:SetSize(dimensions.Parent.W, dimensions.Parent.H)
Craftie.Options.Frame:SetPoint("TOPLEFT", 0, 0)
Craftie.Options.Frame:Hide()
Settings.RegisterAddOnCategory(Craftie.Options.Category)

Craftie.Options.Title = Craftie.Options.Frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
Craftie.Options.Title:SetPoint("TOPLEFT", 10, -16)
Craftie.Options.Title:SetText(Craftie._G.Title)

Craftie.Options.Player = Craftie.Options.Frame:CreateFontString(nil, "OVERLAY", "GameFontWhite")
Craftie.Options.Player:SetPoint("TOPLEFT", 70, -19)
Craftie.Options.Player:SetText("[" .. Craftie.Player.Name .. "]")

Craftie.OptionsScrollFrame={}
Craftie.OptionsScrollFrame = CreateFrame("Frame", "Craftie.OptionsScrollFrame", Craftie.Options.Frame, "BackdropTemplate")
Craftie.OptionsScrollFrame:SetWidth(dimensions.Parent.W)
Craftie.OptionsScrollFrame:SetHeight(dimensions.Parent.H)
Craftie.OptionsScrollFrame:SetPoint("TOPLEFT", -10, -70)
Craftie.OptionsScrollFrame:SetBackdrop(Craftie.Backdrop.General)
Craftie.OptionsScrollFrame:SetBackdropColor(0,0,0,0)
Craftie.OptionsScrollFrame:SetBackdropBorderColor(1,1,1,0)

Craftie.OptionsScrollFrame.Child = CreateFrame("ScrollFrame", nil, Craftie.OptionsScrollFrame, "UIPanelScrollFrameTemplate")
Craftie.OptionsScrollFrame.Child:SetPoint("TOPLEFT", Craftie.OptionsScrollFrame, "TOPLEFT", 5, -10)
Craftie.OptionsScrollFrame.Child:SetPoint("BOTTOMRIGHT", Craftie.OptionsScrollFrame, "BOTTOMRIGHT", 10, 10)
Craftie.OptionsScrollFrameChildFrame = CreateFrame("Frame", "Craftie.OptionsScrollFrameChildFrame", Craftie.OptionsScrollFrame.Child)
Craftie.OptionsScrollFrameChildFrame:SetSize(Craftie.OptionsScrollFrame:GetWidth(), Craftie.OptionsScrollFrame:GetHeight())
Craftie.OptionsScrollFrame.Child:SetScrollChild(Craftie.OptionsScrollFrameChildFrame)
Craftie.OptionsScrollFrame.Child.ScrollBar:ClearAllPoints()
Craftie.OptionsScrollFrame.Child.ScrollBar:SetPoint("TOPLEFT", Craftie.OptionsScrollFrame.Child, "TOPRIGHT", -32, -5)
Craftie.OptionsScrollFrame.Child.ScrollBar:SetPoint("BOTTOMRIGHT", Craftie.OptionsScrollFrame.Child, "BOTTOMRIGHT", -11, 5)
Craftie:ScrollBarFrame(Craftie.OptionsScrollFrame.Child)

--[==[
PLAYER LISTING
]==]--
Craftie.Options.DefaultCell = CreateFrame("Frame", nil, Craftie.OptionsScrollFrameChildFrame, "BackdropTemplate")
Craftie.Options.DefaultCell:SetBackdrop(Craftie.Backdrop.General)
Craftie.Options.DefaultCell:SetBackdropColor(0,0,0,0)
Craftie.Options.DefaultCell:SetBackdropBorderColor(1,1,1,0.4)
Craftie.Options.DefaultCell:SetWidth(dimensions.Cell.W)
Craftie.Options.DefaultCell:SetHeight(100)
Craftie.Options.DefaultCell:SetPoint("TOPLEFT", 0, 0)
Craftie.Options.DefaultTitle = Craftie.Options.DefaultCell:CreateFontString(nil, "OVERLAY")
Craftie.Options.DefaultTitle:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size+2, "SLUG")
Craftie.Options.DefaultTitle:SetPoint("TOPLEFT", 10, 15)
Craftie.Options.DefaultTitle:SetText(Craftie._L.Options.Defaults.Title)

Craftie.Options.CheckboxLibrary = CreateFrame("CheckButton", nil, Craftie.Options.DefaultCell, "ChatConfigCheckButtonTemplate")
Craftie.Options.CheckboxLibrary:SetPoint("TOPLEFT", 10, -10)
Craftie.Options.CheckboxLibrary:SetChecked(true)
Craftie.Options.CheckboxLibrary.Text = Craftie.Options.CheckboxLibrary:CreateFontString(nil, "OVERLAY")
Craftie.Options.CheckboxLibrary.Text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
Craftie.Options.CheckboxLibrary.Text:SetPoint("TOPLEFT", 26, -6)
Craftie.Options.CheckboxLibrary.Text:SetText(Craftie._L.Options.Defaults[1][1])
Craftie.Options.CheckboxLibrary.Text:SetTextColor(0.6,0.6,0.6,1)
Craftie.Options.CheckboxLibrary:Disable()
Craftie.Options.CheckboxLibrary:SetScript("OnClick", function(self)
  local isChecked = self:GetChecked()
  if (isChecked) then
    print("TODO: Feature enabled!")
  else
    print("TODO: Feature disabled!")
  end
end)
Craftie.Options.CheckboxLibrary:SetScript("OnEnter", function(self)
  CraftieTooltip:ClearLines()
  CraftieTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
  CraftieTooltip:AddLine(Craftie._L.Options.Defaults[1][1])
  CraftieTooltip:AddLine(Craftie.Color.White ..  Craftie._L.Options.Defaults[1][2])
  CraftieTooltip:Show()
end)
Craftie.Options.CheckboxLibrary:SetScript("OnLeave", function(self)
  CraftieTooltip:Hide()
end)

Craftie.Options.DropdownPlayerlist={}
Craftie.Options.DropdownPlayerlist = CreateFrame("Frame", nil, Craftie.Options.DefaultCell, "UIDropDownMenuTemplate") --DropdownButtonMixin
Craftie.Options.DropdownPlayerlist:SetPoint("TOPLEFT", -8, -60)
Craftie.Options.DropdownPlayerlist.displayMode = "MENU"
Craftie.Options.DropdownPlayerlist.Title = Craftie.Options.DropdownPlayerlist:CreateFontString(nil, "ARTWORK")
Craftie.Options.DropdownPlayerlist.Title:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, Craftie._G.Font.Flags)
Craftie.Options.DropdownPlayerlist.Title:SetPoint("TOPLEFT", 20, 15)
Craftie.Options.DropdownPlayerlist.Title:SetText(Craftie._L.Options.Defaults[2][1])
Craftie.Options.DropdownPlayerlist.text = Craftie.Options.DropdownPlayerlist:CreateFontString(nil, "ARTWORK")
Craftie.Options.DropdownPlayerlist.text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, Craftie._G.Font.Flags)
Craftie.Options.DropdownPlayerlist.text:SetPoint("TOPLEFT", Craftie.Options.DropdownPlayerlist, "TOPLEFT", 25, -8)
Craftie.Options.DropdownPlayerlist.text:SetText(Craftie._L.MenuSelPlayers[1])
Craftie.Options.DropdownPlayerlist.OnClick = function(self)
  Craftie.Options.DropdownPlayerlist.text:SetText(Craftie._L.MenuSelPlayers[self.value])
  --print(self.value)
  Craftie.Save.Player.CONFIG["PLAYER_LIST"] = self.value
  Craftie.PlayerListFilter = 1
  Craftie:Notification("PLAYER_LIST " .. Craftie.Save.Player.CONFIG["PLAYER_LIST"], Craftie.CHAT.SAVE)
end
UIDropDownMenu_SetWidth(Craftie.Options.DropdownPlayerlist, 160)
UIDropDownMenu_Initialize(Craftie.Options.DropdownPlayerlist, function(self, level)
  local info = UIDropDownMenu_CreateInfo()
  for k,v in pairs(Craftie._L.MenuSelPlayers) do
    --info.notCheckable = 1
    info.padding = 2
    info.text = v
    info.value= k
    info.justifyH = "LEFT"
    info.disabled = false
    info.func = self.OnClick
    UIDropDownMenu_AddButton(info, level)
  end
end)
Craftie.Options.DropdownPlayerlist:SetScript("OnEnter", function(self)
  CraftieTooltip:ClearLines()
  CraftieTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
  CraftieTooltip:AddLine(Craftie._L.Options.Defaults[2][1])
  CraftieTooltip:AddLine(Craftie.Color.White .. Craftie._L.Options.Defaults[2][2])
  CraftieTooltip:Show()
end)
Craftie.Options.DropdownPlayerlist:SetScript("OnLeave", function(self)
  CraftieTooltip:Hide()
end)

--[==[
NOTIFICATIONS
]==]--
Craftie.Options.NotificationCell = CreateFrame("Frame", nil, Craftie.OptionsScrollFrameChildFrame, "BackdropTemplate")
Craftie.Options.NotificationCell:SetBackdrop(Craftie.Backdrop.General)
Craftie.Options.NotificationCell:SetBackdropColor(0,0,0,0)
Craftie.Options.NotificationCell:SetBackdropBorderColor(1,1,1,0.4)
Craftie.Options.NotificationCell:SetWidth(dimensions.Cell.W)
Craftie.Options.NotificationCell:SetHeight(100)
Craftie.Options.NotificationCell:SetPoint("TOPLEFT", dimensions.Cell.W+10, 0)
Craftie.Options.NotificationTitle = Craftie.Options.NotificationCell:CreateFontString(nil, "OVERLAY")
Craftie.Options.NotificationTitle:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size+2, "SLUG")
Craftie.Options.NotificationTitle:SetPoint("TOPLEFT", 10, 15)
Craftie.Options.NotificationTitle:SetText(Craftie._L.Options.Notifications.Title)

Craftie.Options.CheckboxNotif={}
for i,v in pairs(Craftie._L.Options.Notifications) do
  if ((type(i) == "number") and (i <= 3)) then
    Craftie.Options.CheckboxNotif[i] = CreateFrame("CheckButton", nil, Craftie.Options.NotificationCell, "ChatConfigCheckButtonTemplate")
    Craftie.Options.CheckboxNotif[i]:SetPoint("TOPLEFT", 10, (-20*i)+10)
    Craftie.Options.CheckboxNotif[i]:SetChecked(true)
    Craftie.Options.CheckboxNotif[i].Text = Craftie.Options.CheckboxNotif[i]:CreateFontString(nil, "OVERLAY")
    Craftie.Options.CheckboxNotif[i].Text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
    Craftie.Options.CheckboxNotif[i].Text:SetPoint("TOPLEFT", 26, -6)
    Craftie.Options.CheckboxNotif[i].Text:SetText(Craftie._L.Options.Notifications[i][1])
    Craftie.Options.CheckboxNotif[i]:SetScript("OnClick", function(self)
      local isChecked = self:GetChecked()
      if (isChecked) then
        Craftie.Save.Player.CONFIG["ORDERNOTIF" .. i] = 1
      else
        Craftie.Save.Player.CONFIG["ORDERNOTIF" .. i] = 0
      end
      Craftie:Notification("ORDERNOTIF" .. i .. " " .. Craftie.Save.Player.CONFIG["ORDERNOTIF" .. i], Craftie.CHAT.SAVE)
    end)
    Craftie.Options.CheckboxNotif[i]:SetScript("OnEnter", function(self)
      CraftieTooltip:ClearLines()
      CraftieTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
      CraftieTooltip:AddLine(Craftie._L.Options.Notifications[i][2])
      CraftieTooltip:Show()
    end)
    Craftie.Options.CheckboxNotif[i]:SetScript("OnLeave", function(self)
      CraftieTooltip:Hide()
    end)
  end
end

--[==[
RECIPES LISTING
]==]--
Craftie.Options.RecipesCell = CreateFrame("Frame", nil, Craftie.OptionsScrollFrameChildFrame, "BackdropTemplate")
Craftie.Options.RecipesCell:SetBackdrop(Craftie.Backdrop.General)
Craftie.Options.RecipesCell:SetBackdropColor(0,0,0,0)
Craftie.Options.RecipesCell:SetBackdropBorderColor(1,1,1,0.4)
Craftie.Options.RecipesCell:SetWidth(dimensions.Cell.W)
Craftie.Options.RecipesCell:SetHeight(100)
Craftie.Options.RecipesCell:SetPoint("TOPLEFT", 0, -140)
Craftie.Options.DefaultTitle = Craftie.Options.RecipesCell:CreateFontString(nil, "OVERLAY")
Craftie.Options.DefaultTitle:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size+2, "SLUG")
Craftie.Options.DefaultTitle:SetPoint("TOPLEFT", 10, 15)
Craftie.Options.DefaultTitle:SetText(Craftie._L.Options.Recipes.Title)

Craftie.Options.CheckboxCrafterThreshold = CreateFrame("CheckButton", nil, Craftie.Options.RecipesCell, "ChatConfigCheckButtonTemplate")
Craftie.Options.CheckboxCrafterThreshold:SetPoint("TOPLEFT", 10, -10)
Craftie.Options.CheckboxCrafterThreshold:SetChecked(true)
Craftie.Options.CheckboxCrafterThreshold.Text = Craftie.Options.CheckboxCrafterThreshold:CreateFontString(nil, "OVERLAY")
Craftie.Options.CheckboxCrafterThreshold.Text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
Craftie.Options.CheckboxCrafterThreshold.Text:SetPoint("TOPLEFT", 26, -6)
Craftie.Options.CheckboxCrafterThreshold.Text:SetText(Craftie._L.Options.Recipes[1][1])
Craftie.Options.CheckboxCrafterThreshold:SetScript("OnClick", function(self)
  local isChecked = self:GetChecked()
  if (isChecked) then
    Craftie.Save.Player.CONFIG["LEVEL_COLOR"] = 1
  else
    Craftie.Save.Player.CONFIG["LEVEL_COLOR"] = 0
  end
  Craftie:Notification("LEVEL_COLOR " .. Craftie.Save.Player.CONFIG["LEVEL_COLOR"], Craftie.CHAT.SAVE)
end)
Craftie.Options.CheckboxCrafterThreshold:SetScript("OnEnter", function(self)
  CraftieTooltip:ClearLines()
  CraftieTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
  CraftieTooltip:AddLine(Craftie._L.Options.Recipes[1][1])
  CraftieTooltip:AddLine(Craftie.Color.White ..  Craftie._L.Options.Recipes[1][2])
  CraftieTooltip:Show()
end)
Craftie.Options.CheckboxCrafterThreshold:SetScript("OnLeave", function(self)
  CraftieTooltip:Hide()
end)

Craftie.Options.CheckboxCrafterOpen = CreateFrame("CheckButton", nil, Craftie.Options.RecipesCell, "ChatConfigCheckButtonTemplate")
Craftie.Options.CheckboxCrafterOpen:SetPoint("TOPLEFT", 10, -30)
Craftie.Options.CheckboxCrafterOpen:SetChecked(true)
Craftie.Options.CheckboxCrafterOpen.Text = Craftie.Options.CheckboxCrafterOpen:CreateFontString(nil, "OVERLAY")
Craftie.Options.CheckboxCrafterOpen.Text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
Craftie.Options.CheckboxCrafterOpen.Text:SetPoint("TOPLEFT", 26, -6)
Craftie.Options.CheckboxCrafterOpen.Text:SetText(Craftie._L.Options.Recipes[2][1])
Craftie.Options.CheckboxCrafterOpen:SetScript("OnClick", function(self)
  local isChecked = self:GetChecked()
  if (isChecked) then
    Craftie.Save.Player.CONFIG["AUTO_OPEN"] = 1
  else
    Craftie.Save.Player.CONFIG["AUTO_OPEN"] = 0
  end
  Craftie:Notification("AUTO_OPEN " .. Craftie.Save.Player.CONFIG["AUTO_OPEN"], Craftie.CHAT.SAVE)
end)
Craftie.Options.CheckboxCrafterOpen:SetScript("OnEnter", function(self)
  CraftieTooltip:ClearLines()
  CraftieTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
  CraftieTooltip:AddLine(Craftie._L.Options.Recipes[2][1])
  CraftieTooltip:AddLine(Craftie.Color.White ..  Craftie._L.Options.Recipes[2][2])
  CraftieTooltip:Show()
end)
Craftie.Options.CheckboxCrafterOpen:SetScript("OnLeave", function(self)
  CraftieTooltip:Hide()
end)

--[==[
FRAME
]==]--
Craftie.Options.FrameCell = CreateFrame("Frame", nil, Craftie.OptionsScrollFrameChildFrame, "BackdropTemplate")
Craftie.Options.FrameCell:SetBackdrop(Craftie.Backdrop.General)
Craftie.Options.FrameCell:SetBackdropColor(0,0,0,0)
Craftie.Options.FrameCell:SetBackdropBorderColor(1,1,1,0.4)
Craftie.Options.FrameCell:SetWidth(dimensions.Cell.W)
Craftie.Options.FrameCell:SetHeight(100)
Craftie.Options.FrameCell:SetPoint("TOPLEFT", dimensions.Cell.W+10, -140)
Craftie.Options.DefaultTitle = Craftie.Options.FrameCell:CreateFontString(nil, "OVERLAY")
Craftie.Options.DefaultTitle:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size+2, "SLUG")
Craftie.Options.DefaultTitle:SetPoint("TOPLEFT", 10, 15)
Craftie.Options.DefaultTitle:SetText(Craftie._L.Options.Frame.Title)

Craftie.Options.DropdownFrame={}
Craftie.Options.DropdownFrame = CreateFrame("Frame", nil, Craftie.Options.FrameCell, "UIDropDownMenuTemplate") --DropdownButtonMixin
Craftie.Options.DropdownFrame:SetPoint("TOPLEFT", -8, -30)
Craftie.Options.DropdownFrame.displayMode = "MENU"
Craftie.Options.DropdownFrame.Title = Craftie.Options.DropdownFrame:CreateFontString(nil, "ARTWORK")
Craftie.Options.DropdownFrame.Title:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, Craftie._G.Font.Flags)
Craftie.Options.DropdownFrame.Title:SetPoint("TOPLEFT", 20, 15)
Craftie.Options.DropdownFrame.Title:SetText(Craftie._L.Options.Frame[1][1])
Craftie.Options.DropdownFrame.text = Craftie.Options.DropdownFrame:CreateFontString(nil, "ARTWORK")
Craftie.Options.DropdownFrame.text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, Craftie._G.Font.Flags)
Craftie.Options.DropdownFrame.text:SetPoint("TOPLEFT", Craftie.Options.DropdownFrame, "TOPLEFT", 25, -8)
Craftie.Options.DropdownFrame.text:SetText(Craftie._L.Options.Frame[2][1])
Craftie.Options.DropdownFrame.OnClick = function(self)
  Craftie.Options.DropdownFrame.text:SetText(Craftie._L.Options.Frame[2][self.value])
  for k,v in pairs(Craftie.FrameStrata) do
    if (self.value == k) then
      Craftie.Frame:SetFrameStrata(v)
      Craftie.Save.Player.CONFIG["FRAME_LEVEL"] = self.value
      Craftie:Notification("FRAME_LEVEL " .. Craftie.Save.Player.CONFIG["FRAME_LEVEL"], Craftie.CHAT.SAVE)
    end
  end
end
UIDropDownMenu_SetWidth(Craftie.Options.DropdownFrame, 160)
UIDropDownMenu_Initialize(Craftie.Options.DropdownFrame, function(self, level)
  local info = UIDropDownMenu_CreateInfo()
  for k,v in pairs(Craftie._L.Options.Frame[2]) do
    --info.notCheckable = 1
    info.padding = 2
    info.text = v
    info.value= k
    info.justifyH = "LEFT"
    info.disabled = false
    info.func = self.OnClick
    UIDropDownMenu_AddButton(info, level)
  end
end)
Craftie.Options.DropdownFrame:SetScript("OnEnter", function(self)
  CraftieTooltip:ClearLines()
  CraftieTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
  CraftieTooltip:AddLine(Craftie._L.Options.Frame[1][1])
  CraftieTooltip:AddLine(Craftie.Color.White .. Craftie._L.Options.Frame[1][2])
  CraftieTooltip:Show()
end)
Craftie.Options.DropdownFrame:SetScript("OnLeave", function(self)
  CraftieTooltip:Hide()
end)

--[==[
Craftie.Options.DropdownFont={}
Craftie.Options.DropdownFont = CreateFrame("Frame", nil, Craftie.Options.FrameCell, "UIDropDownMenuTemplate")
Craftie.Options.DropdownFont:SetPoint("TOPLEFT", -8, -70)
Craftie.Options.DropdownFont.displayMode = "MENU"
Craftie.Options.DropdownFont.Title = Craftie.Options.DropdownFont:CreateFontString(nil, "ARTWORK")
Craftie.Options.DropdownFont.Title:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, Craftie._G.Font.Flags)
Craftie.Options.DropdownFont.Title:SetPoint("TOPLEFT", 20, 15)
Craftie.Options.DropdownFont.Title:SetText(Craftie._L.Options.Font[1][1])
Craftie.Options.DropdownFont.text = Craftie.Options.DropdownFont:CreateFontString(nil, "ARTWORK")
Craftie.Options.DropdownFont.text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, Craftie._G.Font.Flags)
Craftie.Options.DropdownFont.text:SetPoint("TOPLEFT", Craftie.Options.DropdownFont, "TOPLEFT", 25, -8)
Craftie.Options.DropdownFont.text:SetText(Craftie._L.Options.Font[2][1])
Craftie.Options.DropdownFont.OnClick = function(self)
  Craftie.Options.DropdownFont.text:SetText(Craftie._L.Options.Font[2][self.value])
  for k,v in pairs(Craftie.FrameFont) do
    if (self.value == k) then
      --Craftie.Save.Player.CONFIG["FRAME_FONT"] = self.value
      Craftie:Notification("FRAME_FONT " .. Craftie.Save.Player.CONFIG["FRAME_FONT"], Craftie.CHAT.SAVE)
    end
  end
end
UIDropDownMenu_SetWidth(Craftie.Options.DropdownFont, 160)
UIDropDownMenu_Initialize(Craftie.Options.DropdownFont, function(self, level)
  local info = UIDropDownMenu_CreateInfo()
  for k,v in pairs(Craftie._L.Options.Font[2]) do
    --info.notCheckable = 1
    info.padding = 2
    info.text = v
    info.value= k
    info.justifyH = "LEFT"
    info.disabled = false
    info.func = self.OnClick
    UIDropDownMenu_AddButton(info, level)
  end
end)
Craftie.Options.DropdownFont:SetScript("OnEnter", function(self)
  CraftieTooltip:ClearLines()
  CraftieTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
  CraftieTooltip:AddLine(Craftie._L.Options.Font[1][1])
  CraftieTooltip:AddLine(Craftie.Color.White .. Craftie._L.Options.Font[1][2])
  CraftieTooltip:Show()
end)
Craftie.Options.DropdownFont:SetScript("OnLeave", function(self)
  CraftieTooltip:Hide()
end)
]==]--

--TODO Options
--share with guild?
-- do not save orders
-- auto delete orders
-- tooltips?
