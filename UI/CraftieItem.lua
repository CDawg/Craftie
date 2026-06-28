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

Craftie.Frame.CraftParent={}
Craftie.Frame.CraftParent= CreateFrame("Frame", "Craftie.Frame.CraftParent", Craftie.Frame, "BackdropTemplate")
Craftie.Frame.CraftParent:SetWidth(dimensions.parent.W)
Craftie.Frame.CraftParent:SetHeight(dimensions.parent.H)
Craftie.Frame.CraftParent:SetPoint("TOPRIGHT", -14, -100)
--Craftie.Frame.CraftParent:SetFrameStrata("MEDIUM")

Craftie.Frame.CraftBackTop={}
Craftie.Frame.CraftBackTop= CreateFrame("Frame", "Craftie.Frame.CraftBackTop", Craftie.Frame.CraftParent, "InsetFrameTemplate4")
Craftie.Frame.CraftBackTop:SetWidth(Craftie.Frame.CraftParent:GetWidth())
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
Craftie.Frame.Reagent.BorderGlow = {}
Craftie.Frame.Reagent.Tooltip = {}
Craftie.Frame.Reagent.Icon = {}
Craftie.Frame.Reagent.IconBorder={}
Craftie.Frame.Reagent.IconGlow={}
Craftie.Frame.Reagent.Text = {}
Craftie.Frame.Reagent.Quan = {}
Craftie.Frame.Reagent.Data = {} --ID

for i=1, Craftie.MAX_REAGENTS do
  --Craftie.Frame.Reagent.Main[i] = CreateFrame("Frame", Craftie.Frame.Reagent.Main[i], Craftie.Frame.CraftParent, "BackdropTemplate", 5)
  Craftie.Frame.Reagent.Main[i] = CreateFrame("Button", Craftie.Frame.Reagent.Main[i], Craftie.Frame.CraftParent)
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

  Craftie.Frame.Reagent.Border[i] = CreateFrame("Frame", nil, Craftie.Frame.Reagent.Main[i], "BackdropTemplate", 1)
  Craftie.Frame.Reagent.Border[i]:SetWidth(dimensions.reagent.W-28)
  Craftie.Frame.Reagent.Border[i]:SetHeight(dimensions.reagent.H+1)
  Craftie.Frame.Reagent.Border[i]:SetBackdrop(Craftie.Backdrop.General)
  Craftie.Frame.Reagent.Border[i]:SetBackdropColor(0, 0, 0, 0.1)
  Craftie.Frame.Reagent.Border[i]:SetBackdropBorderColor(0.5, 0.5, 0.48, 1)
  Craftie.Frame.Reagent.Border[i]:SetPoint("TOPLEFT", 28, 0)
  --Craftie.Frame.Reagent.Border[i]:SetFrameStrata("LOW")
  Craftie.Frame.Reagent.BorderGlow[i] = Craftie.Frame.Reagent.Border[i]:CreateTexture(nil, "OVERLAY")
  Craftie.Frame.Reagent.BorderGlow[i]:SetSize(Craftie.Frame.Reagent.Border[i]:GetWidth()-4, Craftie.Frame.Reagent.Border[i]:GetHeight()-4)
  Craftie.Frame.Reagent.BorderGlow[i]:SetPoint("TOPLEFT", 2, -2)
  Craftie.Frame.Reagent.BorderGlow[i]:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Reagent-Border-Glow.png")
  Craftie.Frame.Reagent.BorderGlow[i]:SetAlpha(0.6)
  Craftie.Frame.Reagent.BorderGlow[i]:Hide()
  Craftie.Frame.Reagent.Icon[i] = Craftie.Frame.Reagent.Main[i]:CreateTexture(nil, "ARTWORK")
  Craftie.Frame.Reagent.Icon[i]:SetSize(dimensions.reagent.H-2, dimensions.reagent.H-2)
  Craftie.Frame.Reagent.Icon[i]:SetPoint("TOPLEFT", -7, -2)
  Craftie.Frame.Reagent.Icon[i]:SetTexture("Interface/Icons/inv_misc_questionmark")
  Craftie.Frame.Reagent.IconGlow[i] = Craftie.Frame.Reagent.Main[i]:CreateTexture(nil, "OVERLAY")
  Craftie.Frame.Reagent.IconGlow[i]:SetSize(Craftie.Frame.Reagent.Icon[i]:GetWidth(), Craftie.Frame.Reagent.Icon[i]:GetHeight())
  Craftie.Frame.Reagent.IconGlow[i]:SetPoint("TOPLEFT", -7, -2)
  Craftie.Frame.Reagent.IconGlow[i]:SetTexture("Interface/ContainerFrame/UI-Icon-QuestBorder")
  Craftie.Frame.Reagent.IconGlow[i]:SetAlpha(0.6)

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
--Craftie.Frame.ItemBackMid= CreateFrame("Frame", "Craftie.Frame.ItemBackMid", Craftie.Frame.CraftParent, "InsetFrameTemplate3")
Craftie.Frame.ItemBackMid= CreateFrame("Frame", "Craftie.Frame.ItemBackMid", Craftie.Frame.CraftParent, "BackdropTemplate")
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
Craftie.Frame.ItemBackBot= CreateFrame("Frame", "Craftie.Frame.ItemBackBot", Craftie.Frame.CraftParent, "BackdropTemplate")
Craftie.Frame.ItemBackBot:SetWidth(Craftie.Frame.CraftParent:GetWidth())
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
Craftie.Frame.ItemRequestParent = CreateFrame("Frame", "Craftie.Frame.ItemRequestParent", Craftie.Frame.CraftParent, "BackdropTemplate", 5)
Craftie.Frame.ItemRequestParent:SetWidth(Craftie.Frame.ItemBackBot:GetWidth())
Craftie.Frame.ItemRequestParent:SetHeight(Craftie.Frame.ItemBackBot:GetHeight())
Craftie.Frame.ItemRequestParent:SetPoint("TOPRIGHT", 0, -268)
--Craftie.Frame.ItemRequestParent:SetFrameLevel(50)

local MIN_VALUE = 1
local MAX_VALUE = 999
local STEP = 1

Craftie.Frame.ItemCountParent = CreateFrame("Frame", "MyNumberBoxFrame", Craftie.Frame.ItemRequestParent, "BackdropTemplate")
Craftie.Frame.ItemCountParent:SetSize(80, 20)
Craftie.Frame.ItemCountParent:SetPoint("TOPLEFT", 10, -6)

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

Craftie.Req_Lock = 0
Craftie.Frame.ItemReqButton = CreateFrame("Button", nil, Craftie.Frame.ItemRequestParent, "UIPanelButtonTemplate")
Craftie.Frame.ItemReqButton:SetSize(90, 24)
Craftie.Frame.ItemReqButton:SetPoint("TOPLEFT", 10, -30)
Craftie.Frame.ItemReqButton:SetText("Request")
Craftie.Frame.ItemReqButton:SetScript("OnClick", function(self)
  if (Craftie.Req_Lock == 1) then
    Craftie:Notification("Please wait " .. Craftie.REQ_TIMER .. " seconds before sending another request.", Craftie.CHAT.WARN)
  else
    Craftie.Req_Lock = 1
    --Craftie.Frame.ItemReqButton:Hide()
    Craftie.Frame.ItemReqButton:Disable()
    local name, link = C_Item.GetItemInfo(Craftie.Frame.Item.ID:GetText())
    C_ChatInfo.SendChatMessage("[" .. Craftie._G.Prefix .. "] Requesting: " .. link .. "x" .. Craftie.Frame.ItemCountEditBox:GetNumber() .. " to be crafted.", "WHISPER", nil, Craftie.Selected_Name)
    Craftie:SendPacket(Craftie.Packet.Prefix.Order, Craftie.Player.Name .. "," .. Craftie.Player.ClassID .. "," .. link .. "," .. Craftie.Frame.ItemCountEditBox:GetNumber() .. "," .. Craftie.Date, "WHISPER", Craftie.Selected_Name)
    Craftie.Frame.Item.ReqMessage:SetText("Request sent to " .. Craftie.Selected_Name .. " for|n" .. link .. "x" .. Craftie.Frame.ItemCountEditBox:GetNumber())
    C_Timer.After(Craftie.REQ_TIMER, function()
      Craftie.Req_Lock = 0
      Craftie.Frame.ItemReqButton:Enable()
      Craftie.Frame.Item.ReqMessage:SetText("")
    end)
    --print(Craftie.Selected_Name .. " | " .. Craftie.Frame.Item.Text:GetText())
  end
end)
Craftie.Frame.Item.ReqMessage = Craftie.Frame.ItemRequestParent:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Item.ReqMessage:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
Craftie.Frame.Item.ReqMessage:SetPoint("TOPLEFT", 12, -65)
Craftie.Frame.Item.ReqMessage:SetText("")
Craftie.Frame.Item.ReqMessage:SetTextColor(1, 1, 0.92, 0.8)
Craftie.Frame.Item.ReqMessage:SetJustifyH("LEFT")
