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
    W = 324,
    H = 372,
  },
  reagent = {
    X = 50,
    Y = 130,
    W = 146,
    H = 38,
    D = 20 --distance
  }
}

Craftie.Frame.CraftParent={} --parent used for navigation
Craftie.Frame.CraftParent= CreateFrame("Frame", "Craftie.Frame.CraftParent", Craftie.Frame, "BackdropTemplate")
Craftie.Frame.CraftParent:SetWidth(dimensions.parent.W)
Craftie.Frame.CraftParent:SetHeight(dimensions.parent.H)
Craftie.Frame.CraftParent:SetPoint("TOPRIGHT", -14, -100)

Craftie.Frame.CraftRequest={}
Craftie.Frame.CraftRequest= CreateFrame("Frame", "Craftie.Frame.CraftRequest", Craftie.Frame.CraftParent, "BackdropTemplate")
Craftie.Frame.CraftRequest:SetWidth(Craftie.Frame.CraftParent:GetWidth())
Craftie.Frame.CraftRequest:SetHeight(Craftie.Frame.CraftParent:GetHeight())
Craftie.Frame.CraftRequest:SetPoint("TOPLEFT", 0, 0)
--Craftie.Frame.CraftRequest:SetFrameStrata("MEDIUM")

Craftie.Frame.CraftBackTop={}
Craftie.Frame.CraftBackTop= CreateFrame("Frame", "Craftie.Frame.CraftBackTop", Craftie.Frame.CraftRequest, "InsetFrameTemplate4")
Craftie.Frame.CraftBackTop:SetWidth(Craftie.Frame.CraftRequest:GetWidth())
--Craftie.Frame.CraftBackTop:SetHeight(190)
Craftie.Frame.CraftBackTop:SetHeight(260)
Craftie.Frame.CraftBackTop:SetPoint("TOPRIGHT", 0, 0)
Craftie.Frame.CraftBackTop:SetFrameStrata("LOW") --Blizzard's UI is so broken and hacky
Craftie.Frame.CraftBackTopArt = Craftie.Frame.CraftBackTop:CreateTexture(nil, "BACKGROUND")
Craftie.Frame.CraftBackTopArt:SetWidth(Craftie.Frame.CraftBackTop:GetWidth())
Craftie.Frame.CraftBackTopArt:SetHeight(Craftie.Frame.CraftBackTop:GetHeight())
Craftie.Frame.CraftBackTopArt:SetPoint("TOPLEFT", 0, 0)
Craftie.Frame.CraftBackTopArt:SetTexture(Craftie._G.Path .. "Images/professionbackgroundartalchemy.png")
--Craftie.Frame.CraftBackTopArt:SetVertexColor(.8, .8, .8) --darker
Craftie.Frame.CraftBackTopArt:SetDesaturation(0.3)

Craftie.Frame.Item = {}
Craftie.Frame.Item = CreateFrame("Frame", "Craftie.Frame.Item", Craftie.Frame.CraftBackTop, "BackdropTemplate", 5)
Craftie.Frame.Item:SetWidth(220)
Craftie.Frame.Item:SetHeight(35)
Craftie.Frame.Item:SetPoint("TOPLEFT", 14, -20)
Craftie.Frame.Item:SetBackdrop(Craftie.Backdrop.General)
Craftie.Frame.Item:SetBackdropColor(0, 1, 0, 0)
Craftie.Frame.Item:SetBackdropBorderColor(1, 1, 1, 0)
Craftie.Frame.Item:SetHyperlinksEnabled(true)
Craftie.Frame.Item:SetScript("OnHyperlinkClick", function(self, link, text, button)
  if (Craftie.EnableScrollFrames) then
    SetItemRef(link, text, button, self)
    ItemRefTooltip:Hide()
  end
end)
Craftie.Frame.Item:Hide()

--[==[
CRAFT MAIN ITEM
]==]--
Craftie.Frame.Item.Back = Craftie.Frame.Item:CreateTexture(nil, "BACKGROUND")
Craftie.Frame.Item.Back:SetSize(332, 50)
Craftie.Frame.Item.Back:SetPoint("TOPLEFT", -4, 6)
Craftie.Frame.Item.Back:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Craft-Toast.png")

Craftie.Frame.Item.Icon = Craftie.Frame.Item:CreateTexture(nil, "ARTWORK")
Craftie.Frame.Item.Icon:SetSize(35, 35)
Craftie.Frame.Item.Icon:SetPoint("TOPLEFT", 0, 0)
Craftie.Frame.Item.Icon:SetTexture("Interface/Icons/inv_misc_questionmark")
Craftie.Frame.Item.Icon:SetMask("Interface/Masks/CircleMaskScalable")
Craftie.Frame.Item.Icon:Hide()
Craftie.Frame.Item.Border = Craftie.Frame.Item:CreateTexture(nil, "OVERLAY")
Craftie.Frame.Item.Border:SetSize(75, 75)
Craftie.Frame.Item.Border:SetPoint("CENTER", -92, 0)
Craftie.Frame.Item.Border:SetTexture("Interface/UNITPOWERBARALT/WowUI_Circular_Frame")
Craftie.Frame.Item.Border:SetVertexColor(0.48, 0.48, 0.48)
Craftie.Frame.Item.Glow = Craftie.Frame.Item:CreateTexture(nil, "BORDER")
Craftie.Frame.Item.Glow:SetSize(75, 75)
Craftie.Frame.Item.Glow:SetPoint("CENTER", -92, 0)
Craftie.Frame.Item.Glow:SetTexture("Interface/UNITPOWERBARALT/PandarenTraining_Circular_Flash")
Craftie.Frame.Item.Glow:SetBlendMode("ADD")

Craftie.Frame.Item.Text = Craftie.Frame.Item:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Item.Text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size+1, "SLUG")
Craftie.Frame.Item.Text:SetPoint("TOPLEFT", 45, -6)
--Craftie.Frame.Item.Text:SetPoint("TOPLEFT", 45, -12)
Craftie.Frame.Item.Text:SetWidth(200)
Craftie.Frame.Item.Text:SetJustifyV("TOP")
Craftie.Frame.Item.Text:SetJustifyH("LEFT")
Craftie.Frame.Item.Text:SetWordWrap(true)
Craftie.Frame.Item.Text:SetText("")
--designed to mask over the entire craft frame
Craftie.Frame.Item.HLink = Craftie.Frame.Item:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Item.HLink:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size+9, "SLUG")
Craftie.Frame.Item.HLink:SetPoint("TOPLEFT", -4, -8)
Craftie.Frame.Item.HLink:SetText("")
Craftie.Frame.Item.HLink:SetScript("OnLeave", function(self)
  GameTooltip:Hide()
end)
Craftie.Frame.Item.ID = Craftie.Frame.Item:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Item.ID:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
Craftie.Frame.Item.ID:SetPoint("CENTER", 10, 0)
Craftie.Frame.Item.ID:SetText("")
Craftie.Frame.Item.ID:SetTextColor(1, 1, 1, 0)

--[==[
CRAFT REAGENTS
]==]--
Craftie.Frame.Reagent = {}
Craftie.Frame.Reagent.Main = {}
Craftie.Frame.Reagent.Border = {}
Craftie.Frame.Reagent.Tooltip = {}
Craftie.Frame.Reagent.Icon = {}
Craftie.Frame.Reagent.IconBorder={}
Craftie.Frame.Reagent.IconGlow={}
Craftie.Frame.Reagent.Text = {}
Craftie.Frame.Reagent.Quan = {}
Craftie.Frame.Reagent.Data = {} --ID

for i=1, Craftie.MAX_REAGENTS do
  --Craftie.Frame.Reagent.Main[i] = CreateFrame("Frame", Craftie.Frame.Reagent.Main[i], Craftie.Frame.CraftRequest, "BackdropTemplate", 5)
  Craftie.Frame.Reagent.Main[i] = CreateFrame("Button", Craftie.Frame.Reagent.Main[i], Craftie.Frame.CraftRequest)
  local currentLevel = Craftie.Frame.Reagent.Main[i]:GetFrameLevel()
  Craftie.Frame.Reagent.Main[i]:SetFrameStrata("MEDIUM")
  Craftie.Frame.Reagent.Main[i]:SetWidth(dimensions.reagent.W)
  Craftie.Frame.Reagent.Main[i]:SetHeight(dimensions.reagent.H)
  if (i % 2 == 0) then --right col
    Craftie.Frame.Reagent.Main[i]:SetPoint("CENTER", dimensions.reagent.W-64, (-i*dimensions.reagent.D)+dimensions.reagent.Y)
  else
    local p = i+1 --left col
    Craftie.Frame.Reagent.Main[i]:SetPoint("CENTER", -74, (-p*dimensions.reagent.D)+dimensions.reagent.Y)
  end
  --Craftie.Frame.Reagent.Main[i]:EnableMouse(true)
  Craftie.Frame.Reagent.Main[i]:SetScript("OnEnter", function(self)
    if (Craftie.EnableScrollFrames) then
      local itemID = Craftie.Frame.Reagent.Data[i]:GetText()
      if (not Craftie:IsEmpty(itemID)) then
        Craftie:SetItemTooltip(self, itemID, false, "ANCHOR_CURSOR_RIGHT")
      end
    end
  end)
  Craftie.Frame.Reagent.Main[i]:SetScript("OnLeave", function(self)
    GameTooltip:Hide()
  end)
  Craftie.Frame.Reagent.Main[i]:SetScript("OnClick", function(self)
    if (IsShiftKeyDown()) then
      local itemID = Craftie.Frame.Reagent.Data[i]:GetText()
      local name, link = C_Item.GetItemInfo(itemID)
      if ((link ~= nil) and (link ~= "")) then
        ChatEdit_InsertLink(link)
      end
    end
  end)
  --Craftie.Frame.Reagent.Main[i]:SetFrameStrata("HIGH")

  Craftie.Frame.Reagent.Border[i] = CreateFrame("Frame", nil, Craftie.Frame.Reagent.Main[i], "InsetFrameTemplate3", -5)
  Craftie.Frame.Reagent.Border[i]:SetWidth(dimensions.reagent.W-28)
  Craftie.Frame.Reagent.Border[i]:SetHeight(dimensions.reagent.H)
  --Craftie.Frame.Reagent.Border[i]:SetPoint(Craftie.Frame.Reagent.Main[i]:GetPoint())
  Craftie.Frame.Reagent.Border[i]:SetPoint("TOPLEFT", 28, 0)
  Craftie.Frame.Reagent.Border[i]:SetFrameStrata("LOW")
  Craftie.Frame.Reagent.Border[i]:Hide()
  Craftie.Frame.Reagent.Icon[i] = Craftie.Frame.Reagent.Main[i]:CreateTexture(nil, "ARTWORK")
  Craftie.Frame.Reagent.Icon[i]:SetSize(36, 36)
  Craftie.Frame.Reagent.Icon[i]:SetPoint("TOPLEFT", -7, -2)
  Craftie.Frame.Reagent.Icon[i]:SetTexture("Interface/Icons/inv_misc_questionmark")
  Craftie.Frame.Reagent.IconGlow[i] = Craftie.Frame.Reagent.Main[i]:CreateTexture(nil, "OVERLAY")
  Craftie.Frame.Reagent.IconGlow[i]:SetSize(64, 64)
  Craftie.Frame.Reagent.IconGlow[i]:SetPoint("TOPLEFT", -22, 13)
  Craftie.Frame.Reagent.IconGlow[i]:SetTexture("Interface/BUTTONS/CheckButtonGlow")

  Craftie.Frame.Reagent.Text[i] = Craftie.Frame.Reagent.Main[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.Reagent.Text[i]:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
  Craftie.Frame.Reagent.Text[i]:SetPoint("CENTER", 8, 0)
  Craftie.Frame.Reagent.Text[i]:SetText(i)
  Craftie.Frame.Reagent.Text[i]:SetWidth(dimensions.reagent.W-50)
  Craftie.Frame.Reagent.Text[i]:SetHeight(dimensions.reagent.H-10)
  Craftie.Frame.Reagent.Text[i]:SetWordWrap(true)
  Craftie.Frame.Reagent.Text[i]:SetTextColor(1, 1, 1, 0.8)

  Craftie.Frame.Reagent.Data[i] = Craftie.Frame.Reagent.Main[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.Reagent.Data[i]:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size-1, "SLUG")
  --Craftie.Frame.Reagent.Data[i]:SetPoint("TOPLEFT", 0, 0)
  Craftie.Frame.Reagent.Data[i]:SetText(i)

  Craftie.Frame.Reagent.Quan[i] = Craftie.Frame.Reagent.Main[i]:CreateFontString(nil, "OVERLAY")
  Craftie.Frame.Reagent.Quan[i]:SetWidth(Craftie.Frame.Reagent.Icon[i]:GetWidth())
  Craftie.Frame.Reagent.Quan[i]:SetFont(Craftie._G.Font.StyleN, Craftie._G.Font.Size+2, "OUTLINE | SLUG")
  Craftie.Frame.Reagent.Quan[i]:SetPoint("CENTER", -64, -12)
  Craftie.Frame.Reagent.Quan[i]:SetText("")
  Craftie.Frame.Reagent.Quan[i]:SetTextColor(1, 1, 1, 0.8)
  Craftie.Frame.Reagent.Quan[i]:SetJustifyH("RIGHT")

  Craftie.Frame.Reagent.Main[i]:Hide()
end

--[==[
CRAFT SOURCE
]==]--
Craftie.Frame.ItemBackMid={}
--Craftie.Frame.ItemBackMid= CreateFrame("Frame", "Craftie.Frame.ItemBackMid", Craftie.Frame.CraftRequest, "InsetFrameTemplate3")
Craftie.Frame.ItemBackMid= CreateFrame("Frame", "Craftie.Frame.ItemBackMid", Craftie.Frame.CraftRequest, "BackdropTemplate")
Craftie.Frame.ItemBackMid:SetWidth(300)
Craftie.Frame.ItemBackMid:SetHeight(50)
Craftie.Frame.ItemBackMid:SetPoint("TOPRIGHT", -20, -200)

Craftie.Frame.Item.SkillIcon = Craftie.Frame.ItemBackMid:CreateTexture(nil, "ARTWORK")
Craftie.Frame.Item.SkillIcon:SetSize(13, 13)
Craftie.Frame.Item.SkillIcon:SetPoint("TOPLEFT", 10, -10)
Craftie.Frame.Item.SkillIcon:SetTexture("Interface/Icons/inv_misc_questionmark")
Craftie.Frame.Item.SkillIcon:Hide()
Craftie.Frame.Item.SkillText = Craftie.Frame.ItemBackMid:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Item.SkillText:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
Craftie.Frame.Item.SkillText:SetPoint("TOPLEFT", 25, -10)
Craftie.Frame.Item.SkillText:SetText("")
Craftie.Frame.Item.SkillText:SetTextColor(1, 1, 1, 0.7)
Craftie.Frame.Item.SkillText:Hide()
Craftie.Frame.Item.SourceTitle = Craftie.Frame.ItemBackMid:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Item.SourceTitle:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
Craftie.Frame.Item.SourceTitle:SetPoint("TOPLEFT", 25, -28)
Craftie.Frame.Item.SourceTitle:SetText("Sources:")
Craftie.Frame.Item.SourceTitle:SetTextColor(1, 1, 1, 1)
Craftie.Frame.Item.SourceTitle:Hide()
Craftie.Frame.Item.SourceText = Craftie.Frame.ItemBackMid:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Item.SourceText:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
Craftie.Frame.Item.SourceText:SetPoint("TOPLEFT", 75, -28)
Craftie.Frame.Item.SourceText:SetText("")
Craftie.Frame.Item.SourceText:SetTextColor(1, 1, 1, 0.8)
Craftie.Frame.Item.SourceText:Hide()

--[==[
CRAFT REQUEST
]==]--
Craftie.Frame.ItemBackBot={}
Craftie.Frame.ItemBackBot= CreateFrame("Frame", "Craftie.Frame.ItemBackBot", Craftie.Frame.CraftRequest, "BackdropTemplate")
Craftie.Frame.ItemBackBot:SetWidth(Craftie.Frame.CraftRequest:GetWidth())
Craftie.Frame.ItemBackBot:SetHeight(106)
Craftie.Frame.ItemBackBot:SetPoint("TOPRIGHT", 0, -268)
Craftie.Frame.ItemBackBot:SetBackdrop(Craftie.Backdrop.General)
Craftie.Frame.ItemBackBot:SetBackdropColor(0, 1, 0, 0)
Craftie.Frame.ItemBackBot:SetBackdropBorderColor(0.5, 0.5, 0.48, 1)
--[==[
Craftie.Frame.ItemBackBotArt = Craftie.Frame.ItemBackBot:CreateTexture(nil, "BACKGROUND")
Craftie.Frame.ItemBackBotArt:SetWidth(Craftie.Frame.ItemBackBot:GetWidth())
Craftie.Frame.ItemBackBotArt:SetHeight(Craftie.Frame.ItemBackBot:GetHeight())
Craftie.Frame.ItemBackBotArt:SetPoint("TOPLEFT", 0, 0)
Craftie.Frame.ItemBackBotArt:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Background-Shadow.png")
Craftie.Frame.ItemBackBotArt:SetVertexColor(.8, .8, .8) --darker
Craftie.Frame.ItemBackBotArt:SetDesaturation(0.3)
]==]--
Craftie.Frame.ItemRequestParent = CreateFrame("Frame", "Craftie.Frame.ItemRequestParent", Craftie.Frame.CraftRequest, "BackdropTemplate", 5)
Craftie.Frame.ItemRequestParent:SetWidth(Craftie.Frame.ItemBackBot:GetWidth())
Craftie.Frame.ItemRequestParent:SetHeight(Craftie.Frame.ItemBackBot:GetHeight())
Craftie.Frame.ItemRequestParent:SetPoint("TOPRIGHT", 0, -268)
--Craftie.Frame.ItemRequestParent:SetFrameLevel(50)

local MIN_VALUE = 1
local MAX_VALUE = 999
local STEP = 1

Craftie.Frame.ItemCountParent = CreateFrame("Frame", "MyNumberBoxFrame", Craftie.Frame.ItemRequestParent, "BackdropTemplate")
Craftie.Frame.ItemCountParent:SetSize(80, 20)
Craftie.Frame.ItemCountParent:SetPoint("TOPLEFT", 10, -20)

Craftie.Frame.ItemCountEditBox = CreateFrame("EditBox", nil, Craftie.Frame.ItemCountParent, "InputBoxTemplate")
Craftie.Frame.ItemCountEditBox:SetSize(30, 20)
Craftie.Frame.ItemCountEditBox:SetPoint("CENTER", 0, 0)
Craftie.Frame.ItemCountEditBox:SetAutoFocus(false)
Craftie.Frame.ItemCountEditBox:SetNumber(MIN_VALUE)

-- Restrict to numeric input and enforce limits
Craftie.Frame.ItemCountEditBox:SetScript("OnTextChanged", function(self)
  local num = self:GetNumber() -- Automatically extracts number
  if num > MAX_VALUE then
    self:SetNumber(MAX_VALUE)
  elseif num < MIN_VALUE and self:GetText() ~= "" then
    self:SetNumber(MIN_VALUE)
  end
end)

local ButtonDecrease = CreateFrame("Button", nil, Craftie.Frame.ItemCountParent, "BackdropTemplate")
ButtonDecrease:SetSize(25, 25)
ButtonDecrease:SetPoint("TOPLEFT", -2, 2)
ButtonDecrease:SetText("-")
ButtonDecrease:SetScript("OnClick", function()
  local current = Craftie.Frame.ItemCountEditBox:GetNumber()
  if current - STEP >= MIN_VALUE then
    Craftie.Frame.ItemCountEditBox:SetNumber(current - STEP)
  end
end)
ButtonDecrease:SetNormalTexture("Interface/Buttons/UI-SpellbookIcon-PrevPage-Up")
ButtonDecrease:SetPushedTexture("Interface/Buttons/UI-SpellbookIcon-PrevPage-Down")
ButtonDecrease:SetHighlightTexture("Interface/Buttons/UI-Common-MouseHilight", "ADD")

local ButtonIncrease = CreateFrame("Button", nil, Craftie.Frame.ItemCountParent, "BackdropTemplate")
ButtonIncrease:SetSize(25, 25)
ButtonIncrease:SetPoint("TOPRIGHT", -2, 2)
ButtonIncrease:SetScript("OnClick", function()
  local current = Craftie.Frame.ItemCountEditBox:GetNumber()
  if current + STEP <= MAX_VALUE then
    Craftie.Frame.ItemCountEditBox:SetNumber(current + STEP)
  end
end)
ButtonIncrease:SetNormalTexture("Interface/Buttons/UI-SpellbookIcon-NextPage-Up")
ButtonIncrease:SetPushedTexture("Interface/Buttons/UI-SpellbookIcon-NextPage-Down")
ButtonIncrease:SetHighlightTexture("Interface/Buttons/UI-Common-MouseHilight", "ADD")

Craftie.Frame.ItemBackBot.Request = CreateFrame("Button", nil, Craftie.Frame.ItemRequestParent, "UIPanelButtonTemplate")
Craftie.Frame.ItemBackBot.Request:SetSize(90, 24)
Craftie.Frame.ItemBackBot.Request:SetPoint("TOPLEFT", 10, -50)
Craftie.Frame.ItemBackBot.Request:SetText("Request")
Craftie.Frame.ItemBackBot.Request:SetScript("OnClick", function(self)
  --print(Craftie.Selected_Name .. " | " .. Craftie.Frame.Item.Text:GetText())
  local name, link = C_Item.GetItemInfo(Craftie.Frame.Item.ID:GetText())
  C_ChatInfo.SendChatMessage("[" .. Craftie._G.Prefix .. "] Requesting: " .. link .. "x" .. Craftie.Frame.ItemCountEditBox:GetNumber() .. " to be crafted.", "WHISPER", nil, Craftie.Selected_Name)
  Craftie:SendPacket(Craftie.Packet.Prefix.Order, Craftie.Player.Name .. "," .. link .. "," .. Craftie.Frame.ItemCountEditBox:GetNumber(), "WHISPER", Craftie.Selected_Name)
end)

--[==[
CRAFT ORDERS
]==]--
local MAX_ORDERS = 100
local OrderTabs = {
  "Request",
  "Orders [0]"
}
local OrderTooltip = {
  "Request a player to craft this item for you",
  "Queue from other players for you to craft an item"
}
Craftie.TabOrders={}
local TabOffset = 265

local function ClearOrderTabs()
  for k,v in pairs(OrderTabs) do
    Craftie.TabOrders[k].BG:SetTexture(Craftie._G.Path .. "Images/UI-CraftieTab-Inactive.png")
  end
end

Craftie.Frame.CraftOrder={}
Craftie.Frame.CraftOrder= CreateFrame("Frame", "Craftie.Frame.CraftOrder", Craftie.Frame.CraftParent, "BackdropTemplate")
Craftie.Frame.CraftOrder:SetWidth(dimensions.parent.W)
Craftie.Frame.CraftOrder:SetHeight(dimensions.parent.H)
Craftie.Frame.CraftOrder:SetPoint("TOPLEFT", 0, 0)
--Craftie.Frame.CraftOrder:SetFrameStrata("MEDIUM")
Craftie.Frame.CraftOrder:Hide()

Craftie.Frame.CraftOrderBackTop={}
Craftie.Frame.CraftOrderBackTop= CreateFrame("Frame", "Craftie.Frame.CraftOrderBackTop", Craftie.Frame.CraftOrder, "InsetFrameTemplate4")
Craftie.Frame.CraftOrderBackTop:SetWidth(Craftie.Frame.CraftOrder:GetWidth())
Craftie.Frame.CraftOrderBackTop:SetHeight(Craftie.Frame.CraftOrder:GetHeight())
Craftie.Frame.CraftOrderBackTop:SetPoint("TOPRIGHT", 0, 0)
Craftie.Frame.CraftOrderBackTop:SetFrameStrata("LOW") --Blizzard's UI is so broken and hacky
Craftie.Frame.CraftOrderBackTopArt = Craftie.Frame.CraftOrderBackTop:CreateTexture(nil, "BACKGROUND")
Craftie.Frame.CraftOrderBackTopArt:SetWidth(Craftie.Frame.CraftOrderBackTop:GetWidth())
Craftie.Frame.CraftOrderBackTopArt:SetHeight(Craftie.Frame.CraftOrderBackTop:GetHeight())
Craftie.Frame.CraftOrderBackTopArt:SetPoint("TOPLEFT", 0, 0)
Craftie.Frame.CraftOrderBackTopArt:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Background-Shadow.png")
--Craftie.Frame.CraftOrderBackTopArt:SetVertexColor(.8, .8, .8) --darker
Craftie.Frame.CraftOrderBackTopArt:SetDesaturation(0.3)

for k,v in pairs(OrderTabs) do
  --print("tab " .. k)
  Craftie.TabOrders[k] = CreateFrame("Button", nil, Craftie.Frame.CraftParent, "BackdropTemplate")
  Craftie.TabOrders[k]:SetSize(80, 38)
  Craftie.TabOrders[k]:SetPoint("TOPLEFT", (Craftie.TabOrders[k]:GetWidth()*k)-(Craftie.TabOrders[k]:GetWidth()-12), 41)
  Craftie.TabOrders[k]:SetBackdrop(Craftie.Backdrop.General)
  Craftie.TabOrders[k]:SetBackdropColor(0, 1, 0, 0)
  Craftie.TabOrders[k]:SetBackdropBorderColor(1, 1, 1, 0)
  Craftie.TabOrders[k]:SetFrameStrata("MEDIUM")
  Craftie.TabOrders[k].BG = Craftie.TabOrders[k]:CreateTexture(nil, "BACKGROUND")
  Craftie.TabOrders[k].BG:SetSize(Craftie.TabOrders[k]:GetWidth(), 44)
  Craftie.TabOrders[k].BG:SetPoint("CENTER", 0, -4)
  Craftie.TabOrders[k].BG:SetTexture(Craftie._G.Path .. "Images/UI-CraftieTab-Inactive.png")
  Craftie.TabOrders[k].Highlight = Craftie.TabOrders[k]:CreateTexture(nil, "BORDER")
  Craftie.TabOrders[k].Highlight:SetSize(Craftie.TabOrders[k]:GetWidth()-4, 18)
  Craftie.TabOrders[k].Highlight:SetPoint("CENTER", 0, -6)
  Craftie.TabOrders[k].Highlight:SetTexture("Interface/PaperDollInfoFrame/UI-Character-Tab-Highlight")
  Craftie.TabOrders[k].Highlight:SetBlendMode("ADD")
  Craftie.TabOrders[k].Highlight:SetAlpha(0.3)
  Craftie.TabOrders[k].Highlight:Hide()
  Craftie.TabOrders[k].Text = Craftie.TabOrders[k]:CreateFontString(nil, "ARTWORK")
  Craftie.TabOrders[k].Text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size-1, "OUTLINE")
  Craftie.TabOrders[k].Text:SetPoint("CENTER", 0, -5)
  Craftie.TabOrders[k].Text:SetText(v)
  Craftie.TabOrders[k].Text:SetTextColor(1, 1, 1, 0.7)
  Craftie.TabOrders[k]:SetScript("OnClick", function(self)
    ClearOrderTabs()
    Craftie.Frame.CraftRequest:Hide()
    Craftie.Frame.CraftOrder:Hide()
    if (k == 1) then
      Craftie.Frame.CraftRequest:Show()
    end
    if (k == 2) then
      Craftie.Frame.CraftOrder:Show()
    end
    Craftie.TabOrders[k].BG:SetTexture(Craftie._G.Path .. "Images/UI-CraftieTab-Active.png")
    PlaySound(SOUNDKIT.IG_QUEST_LOG_OPEN)
  end)
  Craftie.TabOrders[k]:SetScript("OnEnter", function(self)
    Craftie.TabOrders[k].Highlight:Show()
    --Craftie.TooltipDisplay(self, Craftie._G.Title, Craftie.Addon)
    CraftieTooltip:ClearLines()
    CraftieTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
    CraftieTooltip:AddLine("|CFFDEDEDE" .. OrderTooltip[k])
    CraftieTooltip:Show()
  end)
  Craftie.TabOrders[k]:SetScript("OnLeave", function(self)
    Craftie.TabOrders[k].Highlight:Hide()
    CraftieTooltip:Hide()
    --Craftie.TooltipDisplay(self, Craftie._G.Title, Craftie.Addon)
  end)
end
Craftie.TabOrders[1].BG:SetTexture(Craftie._G.Path .. "Images/UI-CraftieTab-Active.png")

Craftie.Frame.ScrollOrderList = CreateFrame("Frame", "Craftie.Frame.ScrollOrderList", Craftie.Frame.CraftOrder, "BackdropTemplate")
Craftie.Frame.ScrollOrderList:SetWidth(Craftie.Frame.CraftOrder:GetWidth()-10)
Craftie.Frame.ScrollOrderList:SetHeight(Craftie.Frame.CraftOrder:GetHeight()-4)
Craftie.Frame.ScrollOrderList:SetPoint("TOPLEFT", 4, -8)

Craftie.Frame.ScrollOrderList.Child = CreateFrame("ScrollFrame", "Craftie.Frame.ScrollOrderList.Child", Craftie.Frame.ScrollOrderList, "UIPanelScrollFrameTemplate")
Craftie.Frame.ScrollOrderList.Child:SetPoint("TOPLEFT", Craftie.Frame.ScrollOrderList, "TOPLEFT",         -2,-20)
Craftie.Frame.ScrollOrderList.Child:SetPoint("BOTTOMRIGHT", Craftie.Frame.ScrollOrderList, "BOTTOMRIGHT", 14, 10)
Craftie.Frame.ScrollOrderListChildFrame = CreateFrame("Frame", "Craftie.Frame.ScrollOrderListChildFrame", Craftie.Frame.ScrollOrderList.Child)
Craftie.Frame.ScrollOrderListChildFrame:SetSize(Craftie.Frame.CraftOrder:GetWidth(), Craftie.Frame.CraftOrder:GetHeight())
Craftie.Frame.ScrollOrderList.Child:SetScrollChild(Craftie.Frame.ScrollOrderListChildFrame)
Craftie.Frame.ScrollOrderList.Child.ScrollBar:ClearAllPoints()
Craftie.Frame.ScrollOrderList.Child.ScrollBar:SetPoint("TOPLEFT", Craftie.Frame.ScrollOrderList.Child, "TOPRIGHT",          0,-10)
Craftie.Frame.ScrollOrderList.Child.ScrollBar:SetPoint("BOTTOMRIGHT", Craftie.Frame.ScrollOrderList.Child, "BOTTOMRIGHT", -42, 10)

Craftie:ScrollBarFrame(Craftie.Frame.ScrollOrderList.Child)

Craftie.Frame.ScrollOrderListItem={}
Craftie.Frame.ScrollOrderListBack={}
Craftie.Frame.ScrollOrderListName={}
Craftie.Frame.ScrollOrderListCraft={}
Craftie.Frame.ScrollOrderListSelect={}

for i=1, MAX_ORDERS do
  Craftie.Frame.ScrollOrderListItem[i] = CreateFrame("Frame", Craftie.Frame.ScrollOrderListItem[i], Craftie.Frame.ScrollOrderListChildFrame, "BackdropTemplate", -1)
  Craftie.Frame.ScrollOrderListItem[i]:SetWidth(Craftie.Frame.CraftOrder:GetWidth()-26) --scrollbar size
  Craftie.Frame.ScrollOrderListItem[i]:SetHeight(20)
  Craftie.Frame.ScrollOrderListItem[i]:SetPoint("TOPLEFT", 2, -i*Craftie.Frame.ScrollOrderListItem[i]:GetHeight()+16)
  Craftie.Frame.ScrollOrderListItem[i]:SetBackdropBorderColor(1, 1, 1, 0)
  Craftie.Frame.ScrollOrderListItem[i]:SetFrameLevel(Craftie.Framelevel.Background)
  Craftie.Frame.ScrollOrderListItem[i]:SetBackdropColor(1, 1, 1, 0)
  Craftie.Frame.ScrollOrderListItem[i]:SetScript("OnEnter", function(self)
    self:SetBackdropColor(1, 0.9, 0.8, 0.2)
    Craftie.Frame.ScrollOrderListName[i]:SetTextColor(1, 1, 0.8, 1)
  end)
  Craftie.Frame.ScrollOrderListItem[i]:SetScript("OnLeave", function(self)
    self:SetBackdropColor(1, 1, 1, 0)
    Craftie.Frame.ScrollOrderListName[i]:SetTextColor(1, 1, 1, 0.8)
  end)

  Craftie.Frame.ScrollOrderListBack[i] = Craftie.Frame.ScrollOrderListItem[i]:CreateTexture(nil, "BACKGROUND")
  Craftie.Frame.ScrollOrderListBack[i]:SetSize(Craftie.Frame.ScrollOrderListItem[i]:GetWidth(), Craftie.Frame.ScrollOrderListItem[i]:GetHeight())
  Craftie.Frame.ScrollOrderListBack[i]:SetPoint("TOPLEFT", 0, 0)
  Craftie.Frame.ScrollOrderListBack[i]:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Background-Row1.png")
  Craftie.Frame.ScrollOrderListBack[i]:SetVertexColor(1, 0.8, 0.5)
  Craftie.Frame.ScrollOrderListBack[i]:SetAlpha(0.5)

  Craftie.Frame.ScrollOrderListName[i] = Craftie.Frame.ScrollOrderListItem[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.ScrollOrderListName[i]:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
  Craftie.Frame.ScrollOrderListName[i]:SetPoint("TOPLEFT", 12, -5)
  Craftie.Frame.ScrollOrderListName[i]:SetText("Player " .. i)
  Craftie.Frame.ScrollOrderListName[i]:SetTextColor(1, 1, 1, 0.8)

  Craftie.Frame.ScrollOrderListCraft[i] = Craftie.Frame.ScrollOrderListItem[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.ScrollOrderListCraft[i]:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
  Craftie.Frame.ScrollOrderListCraft[i]:SetPoint("TOPLEFT", 120, -5)
  Craftie.Frame.ScrollOrderListCraft[i]:SetText("Item " .. i)
  Craftie.Frame.ScrollOrderListCraft[i]:SetTextColor(1, 1, 1, 0.8)

  Craftie.Frame.ScrollOrderListSelect[i] = Craftie.Frame.ScrollOrderListItem[i]:CreateTexture(nil, "OVERLAY")
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
