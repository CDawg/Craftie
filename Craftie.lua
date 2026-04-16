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

--function OnEvent(self, event)
--	print("Craftie.Event " .. event)
--end

Craftie._G.Width = 800
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

Craftie.Icon = Craftie.Frame:CreateTexture(nil, "ARTWORK")
Craftie.Icon:SetSize(54, 54)
Craftie.Icon:SetPoint("TOPLEFT", -4, 4)
Craftie.Icon:SetTexture(Craftie._G.dir .. "images/icon_default.tga")

Craftie.Frame.Scroll = {}

Craftie.Frame.Scroll.Recipes = {}
Craftie.Frame.Scroll.Recipes.List = {}
Craftie.Frame.Scroll.Recipes_Width = 300
Craftie.Frame.Scroll.Recipes_Height= 310

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

--for i=1, 40 do
Craftie.Frame.Scroll.Text={}

function Craftie.GetItemInfo(item)
  
end

--Craftie.Profession.Query = {}
Craftie.Profession.Query = Craftie.Profession.Enchanting

local max_reagents = 6

Craftie.Frame.Reagent = {}
Craftie.Frame.Reagent.Back = {}
Craftie.Frame.Reagent.Icon = {}
Craftie.Frame.Reagent.Text = {}
Craftie.Frame.Reagent.Data = {}
Craftie.Frame.Reagent_Width = 100
Craftie.Frame.Reagent_Height= 35
for i=1, max_reagents do
  Craftie.Frame.Reagent.Back[i] = CreateFrame("Frame", Craftie.Frame, Craftie.Frame, "BackdropTemplate")
  Craftie.Frame.Reagent.Back[i]:SetWidth(Craftie.Frame.Reagent_Width)
  Craftie.Frame.Reagent.Back[i]:SetHeight(Craftie.Frame.Reagent_Height)
  if (i % 2 == 0) then
    Craftie.Frame.Reagent.Back[i]:SetPoint("CENTER", Craftie.Frame.Reagent_Width+35, (-i*18)-20)
  else
    local p = i+1
    Craftie.Frame.Reagent.Back[i]:SetPoint("CENTER", 0, (-p*18)-20)
  end
  Craftie.Frame.Reagent.Back[i]:SetBackdrop(Craftie.Backdrop.General)
  Craftie.Frame.Reagent.Back[i]:SetBackdropColor(0, 0, 0, 1)
  Craftie.Frame.Reagent.Back[i]:SetBackdropBorderColor(1, 1, 1, 0.6)
  Craftie.Frame.Reagent.Icon[i] = Craftie.Frame.Reagent.Back[i]:CreateTexture(nil, "ARTWORK")
  Craftie.Frame.Reagent.Icon[i]:SetSize(Craftie.Frame.Reagent_Height-2, Craftie.Frame.Reagent_Height-2)
  Craftie.Frame.Reagent.Icon[i]:SetPoint("CENTER", -65, 0)
  Craftie.Frame.Reagent.Icon[i]:SetTexture("Interface/Icons/inv_misc_questionmark")
  Craftie.Frame.Reagent.Text[i] =  Craftie.Frame.Reagent.Back[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.Reagent.Text[i]:SetFont(Craftie._G.font, 10, "OUTLINE")
  Craftie.Frame.Reagent.Text[i]:SetPoint("TOPLEFT", 2, -6)
  Craftie.Frame.Reagent.Text[i]:SetText(i)
  Craftie.Frame.Reagent.Text[i]:SetWidth(Craftie.Frame.Reagent_Width-10)
  Craftie.Frame.Reagent.Text[i]:SetWordWrap(true)
  Craftie.Frame.Reagent.Text[i]:SetTextColor(1, 1, 1, 0.8)
  Craftie.Frame.Reagent.Back[i]:Hide()
end

function Craftie.ReagentList(item)
  local reagent = {}
  for i=1, max_reagents do
    reagent[i] = 0
     Craftie.Frame.Reagent.Back[i]:Hide()
    if (not isempty(item[6][i])) then
      --Craftie.Frame.Reagent.Text[i]:SetText(item[6][i][1])
      local r = 0
      r = getKeyFromValue(Craftie.Reagent, item[6][i][1], 1)
      --print(Craftie.Reagent[r][2])
      Craftie.Frame.Reagent.Text[i]:SetText(Craftie.Reagent[r][2])
      Craftie.Frame.Reagent.Icon[i]:SetTexture(C_Item.GetItemIconByID(Craftie.Reagent[r][1]))
      --print(C_Item.GetItemIconByID(Craftie.Reagent[r][3]))
      Craftie.Frame.Reagent.Back[i]:Show()
    end
    --if (reagent[i] > 1) then
      --print("reagent " .. reagent[i])
    --end
  end
end

for i=1, getn(Craftie.Profession.Query) do
  Craftie.Frame.Scroll.Recipes.List.Item[i] = CreateFrame("Button", Craftie.Frame.Scroll.Recipes.List.Item[i], Craftie.Frame.Scroll.Recipes.ListChildFrame, "BackdropTemplate", -1)
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
  Craftie.Frame.Scroll.Recipes.List.Item[i]:SetBackdropBorderColor(1, 1, 1, 0)
  Craftie.Frame.Scroll.Recipes.List.Item[i]:SetFrameLevel(Craftie.Framelevel.Background)
  Craftie.Frame.Scroll.Recipes.List.Item[i]:SetBackdropColor(1, 1, 1, 0)

  Craftie.Frame.Scroll.Text[i] = Craftie.Frame.Scroll.Recipes.List.Item[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.Scroll.Text[i]:SetFont(Craftie._G.font, 12, "OUTLINE")
  Craftie.Frame.Scroll.Text[i]:SetPoint("TOPLEFT", 8, -4)
  Craftie.Frame.Scroll.Text[i]:SetText(Craftie.Profession.Query[i][2])
  Craftie.Frame.Scroll.Text[i]:SetTextColor(1, 1, 1, 0.8)

  if (i % 2 == 0) then
    Craftie.Frame.Scroll.Recipes.List.Item[i]:SetBackdropColor(0.6, 0.7, 1, 0.1)
  end
  Craftie.Frame.Scroll.Recipes.List.Item[i]:SetScript("OnEnter", function(self)
    --GameTooltip:SetOwner(Craftie.Frame, "BOTTOMRIGHT")
    --GameTooltip:AddLine("HelloWorld!")
    --GameTooltip:Show()
    Craftie.Frame.Scroll.Recipes.List.Item[i]:SetBackdropColor(0.6, 0.7, 1, 0.15)
    Craftie.Frame.Scroll.Text[i]:SetTextColor(1, 1, 0.8, 1)
  end)
  Craftie.Frame.Scroll.Recipes.List.Item[i]:SetScript("OnLeave", function(self)
    GameTooltip:Hide()
    Craftie.Frame.Scroll.Recipes.List.Item[i]:SetBackdropColor(1, 1, 1, 0)
    Craftie.Frame.Scroll.Text[i]:SetTextColor(1, 1, 1, 0.8)
      if (i % 2 == 0) then
        Craftie.Frame.Scroll.Recipes.List.Item[i]:SetBackdropColor(0.8, 0.9, 1, 0.1)
      end
  end)

  Craftie.Frame.Scroll.Recipes.List.Item[i]:SetScript("OnClick", function()

  --[==[
  -- this works!
  --print(ClassicGetProfessions())
  --profession window must be open in order to extract trade info??
  local name, type;
  for i=1,GetNumTradeSkills() do
   name, type, _, _, _, _ = GetTradeSkillInfo(i)
    if (name and type ~= "header") then
       --DEFAULT_CHAT_FRAME:AddMessage("Found: "..name)
       print(name .. " | " .. type)
    end
  end
  ]==]--

  -- /script i=1;x='a'; while x do x,_,_,y,_,_,z=GetSkillLineInfo(i); if(x) then print(x..': '..y..'/'..z);i=i+1;end;end;

  --[==[
  local skillDB = C_TradeSkillUI.GetAllProfessionTradeSkillLines()
  for skillIndex, skillID in pairs(skillDB) do
      local profDB = C_TradeSkillUI.GetProfessionInfoBySkillLineID(skillID)
      XTest_ProfessionInfo[skillID] = {}
      for profKey,profData in pairs(profDB) do
          print(profKey,profData)
          XTest_ProfessionInfo[skillID][profKey] = profData
      end
  end
  ]==]--

  --C_TradeSkillUI.OpenTradeSkill(3)

  --print("craftie " .. Craftie.Profession.Query[i][1])
  Craftie.ReagentList(Craftie.Profession.Query[i])
 
  --Craftie.SendPacket(lualzw.compress("3,1001110010010101"), "WHISPER", false)
  --Craftie.SendPacket("3[86]1110010010101", "WHISPER", false)
  --Craftie.SendPacket("WHISPER", false)
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
