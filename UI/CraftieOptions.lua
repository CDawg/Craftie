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

Craftie.Options.CheckboxLibrary = CreateFrame("CheckButton", nil, Craftie.Options.Frame, "ChatConfigCheckButtonTemplate")
Craftie.Options.CheckboxLibrary:SetPoint("TOPLEFT", 10, -60)
Craftie.Options.CheckboxLibrary:SetChecked(true)
Craftie.Options.CheckboxLibrary.Text = Craftie.Options.CheckboxLibrary:CreateFontString(nil, "OVERLAY")
Craftie.Options.CheckboxLibrary.Text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
Craftie.Options.CheckboxLibrary.Text:SetPoint("TOPLEFT", 26, -6)
Craftie.Options.CheckboxLibrary.Text:SetText(Craftie._L.Options.Library[1])
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
  CraftieTooltip:AddLine(Craftie._L.Options.Library[1])
  CraftieTooltip:AddLine(Craftie.Color.White ..  Craftie._L.Options.Library[2])
  CraftieTooltip:Show()
end)
Craftie.Options.CheckboxLibrary:SetScript("OnLeave", function(self)
  CraftieTooltip:Hide()
end)

Craftie.Options.NotificationParent = CreateFrame("Frame", nil, Craftie.Options.Frame, "BackdropTemplate")
Craftie.Options.NotificationParent:SetBackdrop(Craftie.Backdrop.General)
Craftie.Options.NotificationParent:SetBackdropColor(0,0,0,0)
Craftie.Options.NotificationParent:SetBackdropBorderColor(1,1,1,0.4)
Craftie.Options.NotificationParent:SetWidth(300)
Craftie.Options.NotificationParent:SetHeight(100)
Craftie.Options.NotificationParent:SetPoint("TOPLEFT", 10, -120)
Craftie.Options.NotificationTitle = Craftie.Options.NotificationParent:CreateFontString(nil, "OVERLAY")
Craftie.Options.NotificationTitle:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size+2, "SLUG")
Craftie.Options.NotificationTitle:SetPoint("TOPLEFT", 10, 20)
Craftie.Options.NotificationTitle:SetText(Craftie._L.Options.Notifications.header)

Craftie.Options.CheckboxNotif={}

for i,v in pairs(Craftie._L.Options.Notifications) do
  if ((type(i) == "number") and (i <= 3)) then
    Craftie.Options.CheckboxNotif[i] = CreateFrame("CheckButton", nil, Craftie.Options.NotificationParent, "ChatConfigCheckButtonTemplate")
    Craftie.Options.CheckboxNotif[i]:SetPoint("TOPLEFT", 10, -20*i)
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
Craftie.Options.CheckboxLibrary = CreateFrame("CheckButton", nil, Craftie.Options.NotificationParent, "ChatConfigCheckButtonTemplate")
Craftie.Options.CheckboxLibrary:SetPoint("TOPLEFT", 10, -20)
Craftie.Options.CheckboxLibrary:SetChecked(true)
Craftie.Options.CheckboxLibrary.Text = Craftie.Options.CheckboxLibrary:CreateFontString(nil, "OVERLAY")
Craftie.Options.CheckboxLibrary.Text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
Craftie.Options.CheckboxLibrary.Text:SetPoint("TOPLEFT", 26, -6)
Craftie.Options.CheckboxLibrary.Text:SetText(Craftie._L.Options.Library[1][1])
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
  CraftieTooltip:AddLine(Craftie._L.Options.Notifications[i][2])
  CraftieTooltip:Show()
end)
Craftie.Options.CheckboxLibrary:SetScript("OnLeave", function(self)
  CraftieTooltip:Hide()
end)
]==]--

Craftie.Options.DropdownFrame={}
Craftie.Options.DropdownFrame = CreateFrame("Frame", "Craftie.Options.DropdownFrame", Craftie.Options.Frame, "UIDropDownMenuTemplate") --DropdownButtonMixin
Craftie.Options.DropdownFrame:SetPoint("TOPLEFT", 0, -250)
Craftie.Options.DropdownFrame.displayMode = "MENU"
--Craftie.Options.DropdownFrame:SetBackdrop(Craftie.Backdrop.Borderless)
--Craftie.Options.DropdownFrame:SetBackdropBorderColor(1, 1, 1, 0)
Craftie.Options.DropdownFrame.text = Craftie.Options.DropdownFrame:CreateFontString(nil, "ARTWORK")
Craftie.Options.DropdownFrame.text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "OUTLINE | SLUG")
Craftie.Options.DropdownFrame.text:SetPoint("TOPLEFT", Craftie.Options.DropdownFrame, "TOPLEFT", 25, -8)
Craftie.Options.DropdownFrame.text:SetText(Craftie._L.Options.Frame.set[1])
Craftie.Options.DropdownFrame.OnClick = function(self)
  Craftie.Options.DropdownFrame.text:SetText(Craftie._L.Options.Frame.set[self.value])
end
UIDropDownMenu_SetWidth(Craftie.Options.DropdownFrame, 160)
UIDropDownMenu_Initialize(Craftie.Options.DropdownFrame, function(self, level)
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

--share with guild?
-- do not save orders
-- auto delete orders
-- tooltips?
