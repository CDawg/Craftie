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

Craftie.Options={}
Craftie.Options.Frame = CreateFrame("Frame", "Craftie.Options.Frame", UIParent)
Craftie.Options.Category = Settings.RegisterCanvasLayoutCategory(Craftie.Options.Frame, Craftie._G.Title)
Settings.RegisterAddOnCategory(Craftie.Options.Category)

Craftie.Options.Title = Craftie.Options.Frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
Craftie.Options.Title:SetPoint("TOPLEFT", 10, -16)
Craftie.Options.Title:SetText(Craftie._G.Title)

Craftie.Options.Player = Craftie.Options.Frame:CreateFontString(nil, "OVERLAY", "GameFontWhite")
Craftie.Options.Player:SetPoint("TOPLEFT", 70, -19)
Craftie.Options.Player:SetText("[" .. Craftie.Player.Name .. "]")

local dimensions = {
  W = 310,
}

--[==[
PLAYER LISTING
]==]--
Craftie.Options.DefaultParent = CreateFrame("Frame", nil, Craftie.Options.Frame, "BackdropTemplate")
Craftie.Options.DefaultParent:SetBackdrop(Craftie.Backdrop.General)
Craftie.Options.DefaultParent:SetBackdropColor(0,0,0,0)
Craftie.Options.DefaultParent:SetBackdropBorderColor(1,1,1,0.4)
Craftie.Options.DefaultParent:SetWidth(dimensions.W)
Craftie.Options.DefaultParent:SetHeight(100)
Craftie.Options.DefaultParent:SetPoint("TOPLEFT", 0, -120)
Craftie.Options.DefaultTitle = Craftie.Options.DefaultParent:CreateFontString(nil, "OVERLAY")
Craftie.Options.DefaultTitle:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size+2, "SLUG")
Craftie.Options.DefaultTitle:SetPoint("TOPLEFT", 10, 15)
Craftie.Options.DefaultTitle:SetText(Craftie._L.Options.Defaults.Title)

Craftie.Options.CheckboxLibrary = CreateFrame("CheckButton", nil, Craftie.Options.DefaultParent, "ChatConfigCheckButtonTemplate")
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
    print("Feature enabled!")
  else
    print("Feature disabled!")
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
Craftie.Options.DropdownPlayerlist = CreateFrame("Frame", nil, Craftie.Options.DefaultParent, "UIDropDownMenuTemplate") --DropdownButtonMixin
Craftie.Options.DropdownPlayerlist:SetPoint("TOPLEFT", -8, -60)
Craftie.Options.DropdownPlayerlist.displayMode = "MENU"
Craftie.Options.DropdownPlayerlist.Title = Craftie.Options.DropdownPlayerlist:CreateFontString(nil, "ARTWORK")
Craftie.Options.DropdownPlayerlist.Title:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "OUTLINE | SLUG")
Craftie.Options.DropdownPlayerlist.Title:SetPoint("TOPLEFT", 20, 15)
Craftie.Options.DropdownPlayerlist.Title:SetText(Craftie._L.Options.Defaults[2][1])
Craftie.Options.DropdownPlayerlist.text = Craftie.Options.DropdownPlayerlist:CreateFontString(nil, "ARTWORK")
Craftie.Options.DropdownPlayerlist.text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "OUTLINE | SLUG")
Craftie.Options.DropdownPlayerlist.text:SetPoint("TOPLEFT", Craftie.Options.DropdownPlayerlist, "TOPLEFT", 25, -8)
Craftie.Options.DropdownPlayerlist.text:SetText(Craftie._L.MenuSelPlayers[1])
Craftie.Options.DropdownPlayerlist.OnClick = function(self)
  Craftie.Options.DropdownPlayerlist.text:SetText(Craftie._L.MenuSelPlayers[self.value])
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
Craftie.Options.NotificationParent = CreateFrame("Frame", nil, Craftie.Options.Frame, "BackdropTemplate")
Craftie.Options.NotificationParent:SetBackdrop(Craftie.Backdrop.General)
Craftie.Options.NotificationParent:SetBackdropColor(0,0,0,0)
Craftie.Options.NotificationParent:SetBackdropBorderColor(1,1,1,0.4)
Craftie.Options.NotificationParent:SetWidth(dimensions.W)
Craftie.Options.NotificationParent:SetHeight(100)
Craftie.Options.NotificationParent:SetPoint("TOPLEFT", dimensions.W+10, -120)
Craftie.Options.NotificationTitle = Craftie.Options.NotificationParent:CreateFontString(nil, "OVERLAY")
Craftie.Options.NotificationTitle:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size+2, "SLUG")
Craftie.Options.NotificationTitle:SetPoint("TOPLEFT", 10, 15)
Craftie.Options.NotificationTitle:SetText(Craftie._L.Options.Notifications.Title)

Craftie.Options.CheckboxNotif={}

for i,v in pairs(Craftie._L.Options.Notifications) do
  if ((type(i) == "number") and (i <= 3)) then
    Craftie.Options.CheckboxNotif[i] = CreateFrame("CheckButton", nil, Craftie.Options.NotificationParent, "ChatConfigCheckButtonTemplate")
    Craftie.Options.CheckboxNotif[i]:SetPoint("TOPLEFT", 10, (-20*i)+10)
    Craftie.Options.CheckboxNotif[i]:SetChecked(true)
    Craftie.Options.CheckboxNotif[i].Text = Craftie.Options.CheckboxNotif[i]:CreateFontString(nil, "OVERLAY")
    Craftie.Options.CheckboxNotif[i].Text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
    Craftie.Options.CheckboxNotif[i].Text:SetPoint("TOPLEFT", 26, -6)
    Craftie.Options.CheckboxNotif[i].Text:SetText(Craftie._L.Options.Notifications[i][1])
    Craftie.Options.CheckboxNotif[i]:SetScript("OnClick", function(self)
      local isChecked = self:GetChecked()
      if (isChecked) then
        print("Feature enabled!")
      else
        print("Feature disabled!")
      end
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
Craftie.Options.RecipesParent = CreateFrame("Frame", nil, Craftie.Options.Frame, "BackdropTemplate")
Craftie.Options.RecipesParent:SetBackdrop(Craftie.Backdrop.General)
Craftie.Options.RecipesParent:SetBackdropColor(0,0,0,0)
Craftie.Options.RecipesParent:SetBackdropBorderColor(1,1,1,0.4)
Craftie.Options.RecipesParent:SetWidth(dimensions.W)
Craftie.Options.RecipesParent:SetHeight(100)
Craftie.Options.RecipesParent:SetPoint("TOPLEFT", 0, -260)
Craftie.Options.DefaultTitle = Craftie.Options.RecipesParent:CreateFontString(nil, "OVERLAY")
Craftie.Options.DefaultTitle:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size+2, "SLUG")
Craftie.Options.DefaultTitle:SetPoint("TOPLEFT", 10, 15)
Craftie.Options.DefaultTitle:SetText(Craftie._L.Options.Recipes.Title)

Craftie.Options.CheckboxCrafterThreshold = CreateFrame("CheckButton", nil, Craftie.Options.RecipesParent, "ChatConfigCheckButtonTemplate")
Craftie.Options.CheckboxCrafterThreshold:SetPoint("TOPLEFT", 10, -10)
Craftie.Options.CheckboxCrafterThreshold:SetChecked(true)
Craftie.Options.CheckboxCrafterThreshold.Text = Craftie.Options.CheckboxCrafterThreshold:CreateFontString(nil, "OVERLAY")
Craftie.Options.CheckboxCrafterThreshold.Text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
Craftie.Options.CheckboxCrafterThreshold.Text:SetPoint("TOPLEFT", 26, -6)
Craftie.Options.CheckboxCrafterThreshold.Text:SetText(Craftie._L.Options.Recipes[1][1])
Craftie.Options.CheckboxCrafterThreshold:SetScript("OnClick", function(self)
  local isChecked = self:GetChecked()
  if (isChecked) then
    print("Feature enabled!")
  else
    print("Feature disabled!")
  end
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

Craftie.Options.CheckboxCrafterOpen = CreateFrame("CheckButton", nil, Craftie.Options.RecipesParent, "ChatConfigCheckButtonTemplate")
Craftie.Options.CheckboxCrafterOpen:SetPoint("TOPLEFT", 10, -30)
Craftie.Options.CheckboxCrafterOpen:SetChecked(true)
Craftie.Options.CheckboxCrafterOpen.Text = Craftie.Options.CheckboxCrafterOpen:CreateFontString(nil, "OVERLAY")
Craftie.Options.CheckboxCrafterOpen.Text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
Craftie.Options.CheckboxCrafterOpen.Text:SetPoint("TOPLEFT", 26, -6)
Craftie.Options.CheckboxCrafterOpen.Text:SetText(Craftie._L.Options.Recipes[2][1])
Craftie.Options.CheckboxCrafterOpen:SetScript("OnClick", function(self)
  local isChecked = self:GetChecked()
  if (isChecked) then
    print("Feature enabled!")
  else
    print("Feature disabled!")
  end
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
Craftie.Options.FrameParent = CreateFrame("Frame", nil, Craftie.Options.Frame, "BackdropTemplate")
Craftie.Options.FrameParent:SetBackdrop(Craftie.Backdrop.General)
Craftie.Options.FrameParent:SetBackdropColor(0,0,0,0)
Craftie.Options.FrameParent:SetBackdropBorderColor(1,1,1,0.4)
Craftie.Options.FrameParent:SetWidth(dimensions.W)
Craftie.Options.FrameParent:SetHeight(100)
Craftie.Options.FrameParent:SetPoint("TOPLEFT", dimensions.W+10, -260)
Craftie.Options.DefaultTitle = Craftie.Options.FrameParent:CreateFontString(nil, "OVERLAY")
Craftie.Options.DefaultTitle:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size+2, "SLUG")
Craftie.Options.DefaultTitle:SetPoint("TOPLEFT", 10, 15)
Craftie.Options.DefaultTitle:SetText(Craftie._L.Options.Frame.Title)

Craftie.Options.DropdownFrame={}
Craftie.Options.DropdownFrame = CreateFrame("Frame", nil, Craftie.Options.FrameParent, "UIDropDownMenuTemplate") --DropdownButtonMixin
Craftie.Options.DropdownFrame:SetPoint("TOPLEFT", -8, -30)
Craftie.Options.DropdownFrame.displayMode = "MENU"
Craftie.Options.DropdownFrame.Title = Craftie.Options.DropdownFrame:CreateFontString(nil, "ARTWORK")
Craftie.Options.DropdownFrame.Title:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "OUTLINE | SLUG")
Craftie.Options.DropdownFrame.Title:SetPoint("TOPLEFT", 20, 15)
Craftie.Options.DropdownFrame.Title:SetText(Craftie._L.Options.Frame[1][1])
Craftie.Options.DropdownFrame.text = Craftie.Options.DropdownFrame:CreateFontString(nil, "ARTWORK")
Craftie.Options.DropdownFrame.text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "OUTLINE | SLUG")
Craftie.Options.DropdownFrame.text:SetPoint("TOPLEFT", Craftie.Options.DropdownFrame, "TOPLEFT", 25, -8)
Craftie.Options.DropdownFrame.text:SetText(Craftie._L.Options.Frame[2][1])
Craftie.Options.DropdownFrame.OnClick = function(self)
  Craftie.Options.DropdownFrame.text:SetText(Craftie._L.Options.Frame[2][self.value])
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

--TODO Options
--share with guild?
-- do not save orders
-- auto delete orders
-- tooltips?
