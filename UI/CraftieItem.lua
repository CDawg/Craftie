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

Craftie.Frame.CraftParent={}
Craftie.Frame.CraftParent= CreateFrame("Frame", "Craftie.Frame.CraftParent", Craftie.Frame, "BackdropTemplate")
Craftie.Frame.CraftParent:SetWidth(312)
Craftie.Frame.CraftParent:SetHeight(372)
Craftie.Frame.CraftParent:SetPoint("TOPRIGHT", -14, -100)
Craftie.Frame.CraftParent:SetFrameStrata("MEDIUM")

Craftie.Frame.CraftBackTop={}
Craftie.Frame.CraftBackTop= CreateFrame("Frame", "Craftie.Frame.CraftBackTop", Craftie.Frame.CraftParent, "InsetFrameTemplate4")
Craftie.Frame.CraftBackTop:SetWidth(Craftie.Frame.CraftParent:GetWidth())
--Craftie.Frame.CraftBackTop:SetHeight(190)
Craftie.Frame.CraftBackTop:SetHeight(250)
Craftie.Frame.CraftBackTop:SetPoint("TOPRIGHT", 0, 0)
Craftie.Frame.CraftBackTop:SetFrameStrata("LOW") --Blizzard's UI is so broken and hacky
Craftie.Frame.CraftBackTopArt = Craftie.Frame.CraftBackTop:CreateTexture(nil, "BACKGROUND")
Craftie.Frame.CraftBackTopArt:SetWidth(Craftie.Frame.CraftBackTop:GetWidth())
Craftie.Frame.CraftBackTopArt:SetHeight(Craftie.Frame.CraftBackTop:GetHeight())
Craftie.Frame.CraftBackTopArt:SetPoint("TOPLEFT", 0, 0)
Craftie.Frame.CraftBackTopArt:SetTexture(Craftie._G.Path .. "Images/professionbackgroundartalchemy.png")
Craftie.Frame.CraftBackTopArt:SetVertexColor(.8, .8, .8) --darker
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
Craftie.Frame.Item.Back:SetSize(310, 50)
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

Craftie.Frame.ItemBackMid={}
--Craftie.Frame.ItemBackMid= CreateFrame("Frame", "Craftie.Frame.ItemBackMid", Craftie.Frame.CraftParent, "InsetFrameTemplate3")
Craftie.Frame.ItemBackMid= CreateFrame("Frame", "Craftie.Frame.ItemBackMid", Craftie.Frame.CraftParent, "BackdropTemplate")
Craftie.Frame.ItemBackMid:SetWidth(300)
Craftie.Frame.ItemBackMid:SetHeight(50)
Craftie.Frame.ItemBackMid:SetPoint("TOPRIGHT", 0, -194)
--Craftie.Frame.ItemBackMid:SetFrameStrata("MEDIUM")

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

Craftie.Frame.Reagent = {}
Craftie.Frame.Reagent.Main = {}
Craftie.Frame.Reagent.Back = {}
Craftie.Frame.Reagent.Tooltip = {}
Craftie.Frame.Reagent.Icon = {}
Craftie.Frame.Reagent.IconBorder={}
Craftie.Frame.Reagent.IconGlow={}
Craftie.Frame.Reagent.Text = {}
Craftie.Frame.Reagent.HLink = {}
Craftie.Frame.Reagent.QuanR = {} --required
Craftie.Frame.Reagent.QuanI = {} --inventory
Craftie.Frame.Reagent.Dash = {}
Craftie.Frame.Reagent.Data = {} --ID

Craftie.Frame.Reagent_Width = 146
Craftie.Frame.Reagent_Height= 38
Craftie.Frame.Reagent_PosX  = 50
Craftie.Frame.Reagent_PosY  = 130
for i=1, Craftie.MAX_REAGENTS do
  Craftie.Frame.Reagent.Main[i] = CreateFrame("Frame", Craftie.Frame.Reagent.Main[i], Craftie.Frame.CraftParent, "BackdropTemplate", 5)
  local currentLevel = Craftie.Frame.Reagent.Main[i]:GetFrameLevel()
  Craftie.Frame.Reagent.Main[i]:SetFrameStrata("MEDIUM")
  Craftie.Frame.Reagent.Main[i]:SetWidth(Craftie.Frame.Reagent_Width)
  Craftie.Frame.Reagent.Main[i]:SetHeight(Craftie.Frame.Reagent_Height)
  if (i % 2 == 0) then --right row
    Craftie.Frame.Reagent.Main[i]:SetPoint("CENTER", Craftie.Frame.Reagent_Width-74, (-i*18)+Craftie.Frame.Reagent_PosY)
  else
    local p = i+1
    Craftie.Frame.Reagent.Main[i]:SetPoint("CENTER", -74, (-p*18)+Craftie.Frame.Reagent_PosY)
  end

  Craftie.Frame.Reagent.Main[i]:SetBackdrop(Craftie.Backdrop.General)
  --Craftie.Frame.Reagent.Main[i]:SetBackdrop(Craftie.Backdrop.Borderless)
  Craftie.Frame.Reagent.Main[i]:SetBackdropColor(0, 0, 0, 0)
  Craftie.Frame.Reagent.Main[i]:SetBackdropBorderColor(0, 0, 0, 0)
  --Craftie.Frame.Reagent.Main[i]:SetFrameStrata("HIGH")

  --Craftie.Frame.Reagent.Back[i] = Craftie.Frame.Reagent.Main[i]:CreateTexture(nil, "BACKGROUND")
  Craftie.Frame.Reagent.Back[i] = Craftie.Frame.CraftParent:CreateTexture(nil, "BORDER") --always showing
  Craftie.Frame.Reagent.Back[i]:SetSize(Craftie.Frame.Reagent_Width+12, Craftie.Frame.Reagent_Height+5)
  --Craftie.Frame.Reagent.Back[i]:SetPoint("CENTER", 0, 1)
  Craftie.Frame.Reagent.Back[i]:SetPoint(Craftie.Frame.Reagent.Main[i]:GetPoint())
  Craftie.Frame.Reagent.Back[i]:SetTexture(Craftie._G.Path  .. "Images/UI-Craftie-Reagent-Toast.png")
  Craftie.Frame.Reagent.Back[i]:Hide()
  Craftie.Frame.Reagent.Icon[i] = Craftie.Frame.Reagent.Main[i]:CreateTexture(nil, "ARTWORK")
  Craftie.Frame.Reagent.Icon[i]:SetSize(Craftie.Frame.Reagent_Height-10, Craftie.Frame.Reagent_Height-10)
  Craftie.Frame.Reagent.Icon[i]:SetPoint("TOPLEFT", 3, -5)
  Craftie.Frame.Reagent.Icon[i]:SetTexture("Interface/Icons/inv_misc_questionmark")
  --Craftie.Frame.Reagent.Icon[i]:SetAlpha(0.5)
  Craftie.Frame.Reagent.IconBorder[i] = Craftie.Frame.Reagent.Main[i]:CreateTexture(nil, "OVERLAY")
  Craftie.Frame.Reagent.IconBorder[i]:SetSize(Craftie.Frame.Reagent_Height, Craftie.Frame.Reagent_Height)
  Craftie.Frame.Reagent.IconBorder[i]:SetPoint("TOPLEFT", -2, 0)
  Craftie.Frame.Reagent.IconBorder[i]:SetTexture("Interface/SPELLBOOK/RotationIconFrame")
  --Craftie.Frame.Reagent.IconBorder[i]:SetVertexColor(0.70, 0.70, 0.70)
  Craftie.Frame.Reagent.IconBorder[i]:SetDesaturated(true)
  Craftie.Frame.Reagent.IconGlow[i] = Craftie.Frame.Reagent.Main[i]:CreateTexture(nil, "OVERLAY")
  Craftie.Frame.Reagent.IconGlow[i]:SetSize(Craftie.Frame.Reagent_Height+13, Craftie.Frame.Reagent_Height+13)
  Craftie.Frame.Reagent.IconGlow[i]:SetPoint("TOPLEFT", -8, 6)
  Craftie.Frame.Reagent.IconGlow[i]:SetTexture("Interface/BUTTONS/CheckButtonGlow")
  Craftie.Frame.Reagent.Text[i] = Craftie.Frame.Reagent.Main[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.Reagent.Text[i]:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size-1, "SLUG")
  Craftie.Frame.Reagent.Text[i]:SetPoint("CENTER", 8, 3)
  Craftie.Frame.Reagent.Text[i]:SetText(i)
  Craftie.Frame.Reagent.Text[i]:SetWidth(Craftie.Frame.Reagent_Width-50)
  Craftie.Frame.Reagent.Text[i]:SetHeight(Craftie.Frame.Reagent_Height-10)
  Craftie.Frame.Reagent.Text[i]:SetWordWrap(true)
  Craftie.Frame.Reagent.Text[i]:SetTextColor(1, 1, 1, 0.8)

  Craftie.Frame.Reagent.Data[i] = Craftie.Frame.Reagent.Main[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.Reagent.Data[i]:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size-1, "SLUG")
  --Craftie.Frame.Reagent.Data[i]:SetPoint("TOPLEFT", 0, 0)
  Craftie.Frame.Reagent.Data[i]:SetText(i)

  local ReagentQPosX = 7
  Craftie.Frame.Reagent.QuanI[i] = Craftie.Frame.Reagent.Main[i]:CreateFontString(nil, "OVERLAY")
  Craftie.Frame.Reagent.QuanI[i]:SetFont(Craftie._G.Font.StyleN, Craftie._G.Font.Size, "OUTLINE | SLUG")
  --Craftie.Frame.Reagent.QuanI[i]:SetPoint("TOPLEFT", -27, -20)
  Craftie.Frame.Reagent.QuanI[i]:SetPoint("TOPLEFT", ReagentQPosX, -22)
  Craftie.Frame.Reagent.QuanI[i]:SetText("3")
  Craftie.Frame.Reagent.QuanI[i]:SetTextColor(1, 1, 1, 0.8)
  Craftie.Frame.Reagent.Dash[i] = Craftie.Frame.Reagent.Main[i]:CreateFontString(nil, "OVERLAY")
  Craftie.Frame.Reagent.Dash[i]:SetFont(Craftie._G.Font.StyleN, Craftie._G.Font.Size+1, "OUTLINE | SLUG")
  --Craftie.Frame.Reagent.Dash[i]:SetPoint("TOPLEFT", -19, -20)
  Craftie.Frame.Reagent.Dash[i]:SetPoint("TOPLEFT", ReagentQPosX+8, -22)
  Craftie.Frame.Reagent.Dash[i]:SetText("/")
  Craftie.Frame.Reagent.Dash[i]:SetTextColor(1, 1, 1, 0.8)
  Craftie.Frame.Reagent.QuanR[i] = Craftie.Frame.Reagent.Main[i]:CreateFontString(nil, "OVERLAY")
  Craftie.Frame.Reagent.QuanR[i]:SetFont(Craftie._G.Font.StyleN, Craftie._G.Font.Size, "OUTLINE | SLUG")
  --Craftie.Frame.Reagent.QuanR[i]:SetPoint("TOPLEFT", -14, -20)
  Craftie.Frame.Reagent.QuanR[i]:SetPoint("TOPLEFT", ReagentQPosX+13, -22)
  Craftie.Frame.Reagent.QuanR[i]:SetText("3")
  Craftie.Frame.Reagent.QuanR[i]:SetTextColor(1, 1, 1, 0.8)
  Craftie.Frame.Reagent.Main[i]:Hide()

  Craftie.Frame.Reagent.HLink[i] = CreateFrame("EditBox", nil, Craftie.Frame.Reagent.Main[i])
  Craftie.Frame.Reagent.HLink[i]:SetWidth(Craftie.Frame.Reagent.Main[i]:GetWidth())
  Craftie.Frame.Reagent.HLink[i]:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size+3, "OUTLINE")
  Craftie.Frame.Reagent.HLink[i]:SetPoint("CENTER", 12, 0)
  Craftie.Frame.Reagent.HLink[i]:SetMultiLine(true)
  Craftie.Frame.Reagent.HLink[i]:ClearFocus()
  Craftie.Frame.Reagent.HLink[i]:SetAutoFocus(false)
  Craftie.Frame.Reagent.HLink[i]:SetText("")
  Craftie.Frame.Reagent.HLink[i]:SetTextColor(1, 1, 1, 0) --hide
  Craftie.Frame.Reagent.HLink[i]:SetEnabled(false) --dont interact with text
  --Craftie.Frame.Reagent.HLink[i]:EnableMouse(false)
  Craftie.Frame.Reagent.HLink[i]:SetHyperlinksEnabled(true)
  Craftie.Frame.Reagent.HLink[i]:SetScript("OnHyperlinkClick", function(self, link, text, button)
    if (Craftie.EnableScrollFrames) then
      SetItemRef(link, text, button, self)
      ItemRefTooltip:Hide()
    end
  end)
  Craftie.Frame.Reagent.HLink[i]:SetScript("OnHyperlinkEnter", function(self)
    if (Craftie.EnableScrollFrames) then
      Craftie:SetItemTooltip(self, Craftie.Frame.Reagent.HLink[i]:GetText(), true)
    end
  end)
  Craftie.Frame.Reagent.HLink[i]:SetScript("OnHyperlinkLeave", function(self)
    GameTooltip:Hide()
  end)

end

Craftie.Frame.ItemBackBot={}
--Craftie.Frame.ItemBackBot= CreateFrame("Frame", "Craftie.Frame.ItemBackBot", Craftie.Frame.CraftParent, "InsetFrameTemplate4")
Craftie.Frame.ItemBackBot= CreateFrame("Frame", "Craftie.Frame.ItemBackBot", Craftie.Frame.CraftParent, "BackdropTemplate")
Craftie.Frame.ItemBackBot:SetWidth(Craftie.Frame.CraftParent:GetWidth())
Craftie.Frame.ItemBackBot:SetHeight(102)
Craftie.Frame.ItemBackBot:SetPoint("TOPRIGHT", 0, -270)
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
Craftie.Frame.ItemRequestParent:SetWidth(300)
Craftie.Frame.ItemRequestParent:SetHeight(125)
--Craftie.Frame.ItemRequestParent:SetBackdrop(Craftie.Backdrop.General)
--Craftie.Frame.ItemRequestParent:SetBackdropColor(0, 1, 0, 1)
Craftie.Frame.ItemRequestParent:SetPoint("TOPRIGHT", 0, -268)
--Craftie.Frame.ItemRequestParent:SetFrameLevel(50)

Craftie.Frame.ItemBackBot.Request = CreateFrame("Button", nil, Craftie.Frame.ItemRequestParent, "UIPanelButtonTemplate")
Craftie.Frame.ItemBackBot.Request:SetSize(100, 24)
Craftie.Frame.ItemBackBot.Request:SetPoint("TOPLEFT", 20, -20)
Craftie.Frame.ItemBackBot.Request:SetText("Request")
Craftie.Frame.ItemBackBot.Request:SetScript("OnClick", function(self)
  --print(Craftie.Selected_Name .. " | " .. Craftie.Frame.Item.Text:GetText())
  local name, link = C_Item.GetItemInfo(Craftie.Frame.Item.ID:GetText())
  C_ChatInfo.SendChatMessage("[" .. Craftie._G.Prefix .. "] Requesting: " .. link .. "x1 to be crafted.", "WHISPER", nil, Craftie.Selected_Name)
  --Craftie:SendPacket(Craftie.Packet.Prefix.Net, Craftie.Player.Name .. "," .. "1", "WHISPER", Craftie.Selected_Name)
end)
