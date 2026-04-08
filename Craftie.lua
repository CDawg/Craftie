--[==[
Copyright ©2026 Porthias of Dreamscythe

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


Craftie._G.Width = 600
Craftie._G.Height= 400

Craftie.Frame={}
Craftie.Frame = CreateFrame("Frame", Craftie.Frame, UIParent, "ButtonFrameTemplate")
Craftie.Frame:SetWidth(Craftie._G.Width)
Craftie.Frame:SetHeight(Craftie._G.Height)
--Craftie.Frame:SetPoint("CENTER", 0, -140)
Craftie.Frame:SetPoint("CENTER", 0, 0)
Craftie.Frame:SetMovable(true)
Craftie.Frame:EnableMouse(true)
Craftie.Frame:RegisterForDrag("LeftButton")
Craftie.Frame:SetScript("OnDragStart", function()
  Craftie.Frame:StartMoving()
end)
Craftie.Frame:SetScript("OnDragStop", function()
  Craftie.Frame:StopMovingOrSizing()
  local point, relativeTo, relativePoint, xOfs, yOfs = Craftie.Frame:GetPoint()
  -- CraftieDB[Craftie.player.combine]["CONFIG"]["MAINPOS"] = point .. "," .. xOfs .. "," .. yOfs
  Craftie.Notification("[" .. Craftie.player.combine .. "]" .. point .. "," .. xOfs .. "," .. yOfs, true)
end)

Craftie.Frame.Scroll = {}

Craftie.Frame.Scroll.Recipes = {}
Craftie.Frame.Scroll.Recipes.List = {}
Craftie.Frame.Scroll.Recipes_Width = Craftie._G.Width-18
Craftie.Frame.Scroll.Recipes_Height= Craftie._G.Height-90

Craftie.Frame.Scroll.Recipes = CreateFrame("Frame", nil, Craftie.Frame)
Craftie.Frame.Scroll.Recipes:SetWidth(Craftie.Frame.Scroll.Recipes_Width)
Craftie.Frame.Scroll.Recipes:SetHeight(Craftie.Frame.Scroll.Recipes_Height)
Craftie.Frame.Scroll.Recipes:SetPoint("TOPLEFT", 8, -62) --low, due to the portrait frame
Craftie.Frame.Scroll.Recipes:SetFrameStrata("DIALOG")
Craftie.Frame.Scroll.Recipes.List = CreateFrame("Frame", Craftie.Frame.Scroll.Recipes.List, Craftie.Frame.Scroll.Recipes, "BackdropTemplate")
Craftie.Frame.Scroll.Recipes.List:SetWidth(Craftie.Frame.Scroll.Recipes_Width)
Craftie.Frame.Scroll.Recipes.List:SetHeight(Craftie.Frame.Scroll.Recipes_Height)
Craftie.Frame.Scroll.Recipes.List:SetPoint("CENTER", 0, 0)
Craftie.Frame.Scroll.Recipes.List:SetBackdrop(Craftie.Backdrop.General)
Craftie.Frame.Scroll.Recipes.List:SetBackdropColor(0, 0, 0, 0)
Craftie.Frame.Scroll.Recipes.List:SetBackdropBorderColor(1, 1, 1, 0)
Craftie.Frame.Scroll.Recipes.List.Child = CreateFrame("ScrollFrame", nil, Craftie.Frame.Scroll.Recipes.List, "UIPanelScrollFrameTemplate")
Craftie.Frame.Scroll.Recipes.List.Child:SetPoint("TOPLEFT", Craftie.Frame.Scroll.Recipes.List, "TOPLEFT", 3, -3)
Craftie.Frame.Scroll.Recipes.List.Child:SetPoint("BOTTOMRIGHT", Craftie.Frame.Scroll.Recipes.List, "BOTTOMRIGHT", 10, 4)
Craftie.Frame.Scroll.Recipes.ListChildFrame = CreateFrame("Frame", Craftie.Frame.Scroll.Recipes.ListChildFrame, Craftie.Frame.Scroll.Recipes.List.Child)
Craftie.Frame.Scroll.Recipes.ListChildFrame:SetSize(Craftie.Frame.Scroll.Recipes_Width, Craftie.Frame.Scroll.Recipes_Height)
Craftie.Frame.Scroll.Recipes.List.Child:SetScrollChild(Craftie.Frame.Scroll.Recipes.ListChildFrame)
Craftie.Frame.Scroll.Recipes.List.Child.ScrollBar:ClearAllPoints()
Craftie.Frame.Scroll.Recipes.List.Child.ScrollBar:SetPoint("TOPLEFT", Craftie.Frame.Scroll.Recipes.List.Child, "TOPRIGHT", 0, -17)
Craftie.Frame.Scroll.Recipes.List.Child.ScrollBar:SetPoint("BOTTOMRIGHT", Craftie.Frame.Scroll.Recipes.List.Child, "BOTTOMRIGHT", -42, 14)

Craftie.Frame.Scroll.Recipes.List.Item = {}
for i=1, 24 do
  Craftie.Frame.Scroll.Recipes.List.Item[i] = CreateFrame("Frame", Craftie.Frame.Scroll.Recipes.List.Item[i], Craftie.Frame.Scroll.Recipes.ListChildFrame, "BackdropTemplate", -1)
  Craftie.Frame.Scroll.Recipes.List.Item[i]:SetWidth(Craftie.Frame.Scroll.Recipes_Width-26) --scrollbar size
  Craftie.Frame.Scroll.Recipes.List.Item[i]:SetHeight(20)
  Craftie.Frame.Scroll.Recipes.List.Item[i]:SetPoint("TOPLEFT", 2, -i*18)
  Craftie.Frame.Scroll.Recipes.List.Item[i]:SetBackdrop(
    {
		  bgFile  = "Interface/Tooltips/UI-Tooltip-Background",
		  edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
		  edgeSize= 8,
		  insets  = {left=0, right=0, top=1, bottom=1},
		}
  )
  Craftie.Frame.Scroll.Recipes.List.Item[i]:SetBackdropColor(1, 1, 1, 0.1)
  if (i % 2 == 0) then
    Craftie.Frame.Scroll.Recipes.List.Item[i]:SetBackdropColor(1, 1, 1, 0.2)
  end
  Craftie.Frame.Scroll.Recipes.List.Item[i]:SetBackdropBorderColor(1, 1, 1, 0)
  Craftie.Frame.Scroll.Recipes.List.Item[i]:SetFrameLevel(Craftie.Framelevel.Background)

  Craftie.Frame.Scroll.Recipes.List.Item[i]:SetScript("OnEnter", function(self)
    Craftie.Frame.Scroll.Recipes.List.Item[i]:SetBackdropBorderColor(1, 1, 1, 0.6)
  end)
  Craftie.Frame.Scroll.Recipes.List.Item[i]:SetScript("OnLeave", function(self)
    Craftie.Frame.Scroll.Recipes.List.Item[i]:SetBackdropBorderColor(1, 1, 1, 0)
  end)
end

--[==[
for i=1, 4 do
  TOCA.SlotGrid.VerticalTimerX = TOCA.SlotGrid.VerticalTimerX+TOCA.Slot_w
  TOCA.SlotGrid.VerticalTimer[i]= TOCA.FrameMain:CreateFontString(nil, "ARTWORK")
  TOCA.SlotGrid.VerticalTimer[i]:SetFont(TOCA._G.font, 12, "OUTLINE")
  TOCA.SlotGrid.VerticalTimer[i]:SetPoint("TOPLEFT", TOCA.SlotGrid.VerticalTimerX-TOCA.Slot_w+5, -28)
  TOCA.SlotGrid.VerticalTimer[i]:SetText("")
  TOCA.SlotGrid.VerticalTimer[i]:Hide()
]==]--

--[==[
Craftie.Frame.Scroll.Recipes.text = CreateFrame("EditBox", nil, Craftie.Frame.Scroll.Recipes.ListChildFrame)
Craftie.Frame.Scroll.Recipes.text:SetWidth(Craftie.Frame.Scroll.Recipes_Width-20)
Craftie.Frame.Scroll.Recipes.text:SetHeight(Craftie.Frame.Scroll.Recipes_Height)
Craftie.Frame.Scroll.Recipes.text:SetFontObject(GameFontWhite)
Craftie.Frame.Scroll.Recipes.text:SetPoint("TOPLEFT", 4, -4)
Craftie.Frame.Scroll.Recipes.text:SetMultiLine(true)
Craftie.Frame.Scroll.Recipes.text:ClearFocus(self)
Craftie.Frame.Scroll.Recipes.text:SetAutoFocus(false)
Craftie.Frame.Scroll.Recipes.text:SetText(arrayToString(texthere))
]==]--

--[==[
--Craftie.Frame.Background = CreateFrame("Frame", Craftie.Frame.Background, Craftie.Frame, "BasicFrameTemplateWithInset", -6)
Craftie.Frame.Background = CreateFrame("Frame", Craftie.Frame.Background, Craftie.Frame, "EtherealFrameTemplate", -6)
Craftie.Frame.Background:SetWidth(Craftie._G.Width)
Craftie.Frame.Background:SetHeight(Craftie._G.Height)
Craftie.Frame.Background:SetPoint("CENTER", 0, 0)
--Craftie.Frame.Background:SetBackdrop(Craftie.Backdrop.General)
--Craftie.Frame.Background:SetBackdrop(BACKDROP_DARK_DIALOG_32_32)
--Craftie.Frame.Background:SetBackdropColor(0, 0, 0, 1)
--Craftie.Frame.Background:SetBackdropBorderColor(1, 1, 1, 0.6)
Craftie.Frame.Background:SetFrameLevel(Craftie.Framelevel.Background)

--Craftie.KeyBindsSetOnLoad = 1
]==]--
