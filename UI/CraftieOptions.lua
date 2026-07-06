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

Craftie.Settings={}
Craftie.Frame.Settings = CreateFrame("Frame", "CraftieSettingsFrame", UIParent)
Craftie.Settings.Category = Settings.RegisterCanvasLayoutCategory(Craftie.Frame.Settings, Craftie._G.Title)
Settings.RegisterAddOnCategory(Craftie.Settings.Category)

Craftie.Settings.Title = Craftie.Frame.Settings:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
Craftie.Settings.Title:SetPoint("TOPLEFT", 16, -16)
Craftie.Settings.Title:SetText(Craftie._G.Title)

Craftie.Settings.CheckboxLibrary = CreateFrame("CheckButton", nil, Craftie.Frame.Settings, "ChatConfigCheckButtonTemplate")
Craftie.Settings.CheckboxLibrary:SetPoint("TOPLEFT", 10, -60)
Craftie.Settings.CheckboxLibrary:SetChecked(true)
Craftie.Settings.CheckboxLibrary.Text = Craftie.Settings.CheckboxLibrary:CreateFontString(nil, "OVERLAY")
Craftie.Settings.CheckboxLibrary.Text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
Craftie.Settings.CheckboxLibrary.Text:SetPoint("TOPLEFT", 26, -6)
Craftie.Settings.CheckboxLibrary.Text:SetText(Craftie._L.Options.Library[1])
Craftie.Settings.CheckboxLibrary.Text:SetTextColor(0.6,0.6,0.6,1)
Craftie.Settings.CheckboxLibrary:Disable()
Craftie.Settings.CheckboxLibrary:SetScript("OnClick", function(self)
  local isChecked = self:GetChecked()
  if (isChecked) then
    print("Feature enabled!")
  else
    print("Feature disabled!")
  end
end)
Craftie.Settings.CheckboxLibrary:SetScript("OnEnter", function(self)
  CraftieTooltip:ClearLines()
  CraftieTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
  CraftieTooltip:AddLine(Craftie._L.Options.Library[1])
  CraftieTooltip:AddLine(Craftie.Color.White ..  Craftie._L.Options.Library[2])
  CraftieTooltip:Show()
end)
Craftie.Settings.CheckboxLibrary:SetScript("OnLeave", function(self)
  CraftieTooltip:Hide()
end)

Craftie.Settings.NotificationParent = CreateFrame("Frame", nil, Craftie.Frame.Settings, "BackdropTemplate")
Craftie.Settings.NotificationParent:SetBackdrop(Craftie.Backdrop.General)
Craftie.Settings.NotificationParent:SetBackdropColor(0,0,0,0)
Craftie.Settings.NotificationParent:SetBackdropBorderColor(1,1,1,0.4)
Craftie.Settings.NotificationParent:SetWidth(300)
Craftie.Settings.NotificationParent:SetHeight(100)
Craftie.Settings.NotificationParent:SetPoint("TOPLEFT", 10, -120)
Craftie.Settings.NotificationTitle = Craftie.Settings.NotificationParent:CreateFontString(nil, "OVERLAY")
Craftie.Settings.NotificationTitle:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size+2, "SLUG")
Craftie.Settings.NotificationTitle:SetPoint("TOPLEFT", 10, 20)
Craftie.Settings.NotificationTitle:SetText(Craftie._L.Options.Notifications.header)

Craftie.Settings.CheckboxNotif={}

for i,v in pairs(Craftie._L.Options.Notifications) do
  if ((type(i) == "number") and (i <= 3)) then
    Craftie.Settings.CheckboxNotif[i] = CreateFrame("CheckButton", nil, Craftie.Settings.NotificationParent, "ChatConfigCheckButtonTemplate")
    Craftie.Settings.CheckboxNotif[i]:SetPoint("TOPLEFT", 10, -20*i)
    Craftie.Settings.CheckboxNotif[i]:SetChecked(true)
    Craftie.Settings.CheckboxNotif[i].Text = Craftie.Settings.CheckboxNotif[i]:CreateFontString(nil, "OVERLAY")
    Craftie.Settings.CheckboxNotif[i].Text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
    Craftie.Settings.CheckboxNotif[i].Text:SetPoint("TOPLEFT", 26, -6)
    Craftie.Settings.CheckboxNotif[i].Text:SetText(Craftie._L.Options.Notifications[i][1])
    Craftie.Settings.CheckboxNotif[i]:SetScript("OnClick", function(self)
      local isChecked = self:GetChecked()
      if (isChecked) then
        print("Feature enabled!")
      else
        print("Feature disabled!")
      end
    end)
    Craftie.Settings.CheckboxNotif[i]:SetScript("OnEnter", function(self)
      CraftieTooltip:ClearLines()
      CraftieTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
      CraftieTooltip:AddLine(Craftie._L.Options.Notifications[i][2])
      CraftieTooltip:Show()
    end)
    Craftie.Settings.CheckboxNotif[i]:SetScript("OnLeave", function(self)
      CraftieTooltip:Hide()
    end)
  end
end
--[==[
Craftie.Settings.CheckboxLibrary = CreateFrame("CheckButton", nil, Craftie.Settings.NotificationParent, "ChatConfigCheckButtonTemplate")
Craftie.Settings.CheckboxLibrary:SetPoint("TOPLEFT", 10, -20)
Craftie.Settings.CheckboxLibrary:SetChecked(true)
Craftie.Settings.CheckboxLibrary.Text = Craftie.Settings.CheckboxLibrary:CreateFontString(nil, "OVERLAY")
Craftie.Settings.CheckboxLibrary.Text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
Craftie.Settings.CheckboxLibrary.Text:SetPoint("TOPLEFT", 26, -6)
Craftie.Settings.CheckboxLibrary.Text:SetText(Craftie._L.Options.Library[1][1])
Craftie.Settings.CheckboxLibrary:SetScript("OnClick", function(self)
  local isChecked = self:GetChecked()
  if (isChecked) then
    print("Feature enabled!")
  else
    print("Feature disabled!")
  end
end)
Craftie.Settings.CheckboxLibrary:SetScript("OnEnter", function(self)
  CraftieTooltip:ClearLines()
  CraftieTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
  CraftieTooltip:AddLine(Craftie._L.Options.Notifications[i][2])
  CraftieTooltip:Show()
end)
Craftie.Settings.CheckboxLibrary:SetScript("OnLeave", function(self)
  CraftieTooltip:Hide()
end)
]==]--

Craftie.Settings.DropdownFrame={}
Craftie.Settings.DropdownFrame = CreateFrame("Frame", "Craftie.Settings.DropdownFrame", Craftie.Frame.Settings, "UIDropDownMenuTemplate") --DropdownButtonMixin
Craftie.Settings.DropdownFrame:SetPoint("TOPLEFT", 0, -250)
Craftie.Settings.DropdownFrame.displayMode = "MENU"
--Craftie.Settings.DropdownFrame:SetBackdrop(Craftie.Backdrop.Borderless)
--Craftie.Settings.DropdownFrame:SetBackdropBorderColor(1, 1, 1, 0)
Craftie.Settings.DropdownFrame.text = Craftie.Settings.DropdownFrame:CreateFontString(nil, "ARTWORK")
Craftie.Settings.DropdownFrame.text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "OUTLINE | SLUG")
Craftie.Settings.DropdownFrame.text:SetPoint("TOPLEFT", Craftie.Settings.DropdownFrame, "TOPLEFT", 25, -8)
Craftie.Settings.DropdownFrame.text:SetText(Craftie._L.Options.Frame.set[1])
Craftie.Settings.DropdownFrame.OnClick = function(self)
  Craftie.Settings.DropdownFrame.text:SetText(Craftie._L.Options.Frame.set[self.value])
end
UIDropDownMenu_SetWidth(Craftie.Settings.DropdownFrame, 160)
UIDropDownMenu_Initialize(Craftie.Settings.DropdownFrame, function(self, level)
  local info = UIDropDownMenu_CreateInfo()
  for k,v in pairs(Craftie._L.Options.Frame.set) do
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
