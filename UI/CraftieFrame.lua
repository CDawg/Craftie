--[==[
Copyright ©2026 Porthias of Dreamscythe

The contents of this addon, excluding third-party resources, are
copyrighted to Porthias with all rights reserved.
This addon is free to use and the authors hereby grants you the following rights:
1. You may make modifications to this addon for private use only, you
   may not publicize any portion of this addon.
2. Do not modify the name of this addon, including the addon folders.
3. This copyright notice shall be included in all copies or substantial
  portions of the Software.
All rights not explicitly addressed in this license are reserved by
the copyright holders.
]==]--

Craftie.Frame:SetWidth(Craftie._G.Width)
Craftie.Frame:SetHeight(Craftie._G.Height)
Craftie.Frame:SetPoint("CENTER", 0, 0)
--Craftie.Frame:SetFrameStrata("MEDIUM")
Craftie.Frame:SetFrameStrata("LOW")

--Craftie.Frame.TopLeftCorner:Hide()
--Craftie.Frame.TopRightCorner:Hide()

Craftie.Frame:SetMovable(true)
Craftie.Frame:EnableMouse(true)
Craftie.Frame:RegisterForDrag("LeftButton")
Craftie.Frame:SetScript("OnDragStart", function()
  Craftie.Frame:StartMoving()
end)
Craftie.Frame:SetScript("OnDragStop", function()
  Craftie.Frame:StopMovingOrSizing()
  local point, relativeTo, relativePoint, xOfs, yOfs = Craftie.Frame:GetPoint()
  CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["CONFIG"]["POS_MAIN"] = point .. "," .. xOfs .. "," .. yOfs
  Craftie:Notification("Main:[" .. Craftie.Player.Combine .. "]" .. point .. "," .. xOfs .. "," .. yOfs, Craftie.CHAT.SAVE)
end)
Craftie.Frame.Back = Craftie.Frame:CreateTexture(nil, "BACKGROUND", nil, 0)
--Craftie.Frame.Back:SetAllPoints()
Craftie.Frame.Back:SetPoint("TOPLEFT", 0, 0)
Craftie.Frame.Back:SetWidth(Craftie.Frame:GetWidth()-4)
Craftie.Frame.Back:SetHeight(Craftie.Frame:GetHeight()-4)
Craftie.Frame.Back:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Background-Light.png")
Craftie.Frame.Back:SetVertexColor(1, 0.94, 0.86)

Craftie.Frame.BotShadow = Craftie.Frame:CreateTexture(nil, "BACKGROUND", nil, 1)
Craftie.Frame.BotShadow:SetSize(Craftie.Frame:GetWidth()-6, 24)
Craftie.Frame.BotShadow:SetPoint("BOTTOMLEFT", 2, -1)
Craftie.Frame.BotShadow:SetHorizTile(true)
Craftie.Frame.BotShadow:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Shadow-Overlay.png", "REPEAT")
Craftie.Frame.BotShadow:SetAlpha(0.5)

Craftie.Frame.Icon = Craftie.Frame:CreateTexture(nil, "OVERLAY")
Craftie.Frame.Icon:SetSize(160, 80)
Craftie.Frame.Icon:SetPoint("TOPLEFT", -42, 30)
Craftie.Frame.Icon:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Logo-Header.png")
Craftie.Frame.Icon:SetDrawLayer("OVERLAY", 4)

Craftie.Frame.Title = Craftie.Frame:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Title:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size+1, "SLUG")
Craftie.Frame.Title:SetPoint("TOPRIGHT", -70, -5)
Craftie.Frame.Title:SetText("v" .. Craftie._G.Version .. " [" .. Craftie.Game.Name .. "]")
Craftie.Frame.Title:SetTextColor(0.9, 0.9, 0.8, 0.5)

Craftie.Frame.Title.Sub = Craftie.Frame:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Title.Sub:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size+3, "SLUG")
Craftie.Frame.Title.Sub:SetPoint("TOPLEFT", 40, -35)
Craftie.Frame.Title.Sub:SetText("")
Craftie.Frame.Title.Sub:SetTextColor(0.9, 0.9, 0.8, 1)
Craftie.Frame.Title.Sub:Hide()

Craftie.Frame.Title.Prof = Craftie.Frame:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Title.Prof:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size+3, "SLUG")
Craftie.Frame.Title.Prof:SetPoint("TOPLEFT", 40, -35)
Craftie.Frame.Title.Prof:SetText(Craftie.Professions[1][1])
Craftie.Frame.Title.Prof:SetTextColor(0.9, 0.9, 0.8, 1)

--determine version and placement
Craftie.Frame.TabBar = CreateFrame("Button", Craftie.Frame.TabBar, Craftie.Frame, "BackdropTemplate")
Craftie.Frame.TabBar:SetWidth(40)
Craftie.Frame.TabBar:SetHeight(330)
Craftie.Frame.TabBar:SetPoint("TOPLEFT", -Craftie.TabBar_X, -Craftie.TabBar_Y)
--Craftie.Frame.TabBar:SetBackdrop(Craftie.Backdrop.General)
--Craftie.Frame.TabBar:SetBackdropColor(0, 1, 0, 0)
--Craftie.Frame.TabBar:SetBackdropBorderColor(1, 1, 1, 0)
Craftie.Frame.TabBar:SetFrameStrata("BACKGROUND")
Craftie.Frame.TabBarBack = Craftie.Frame.TabBar:CreateTexture(nil, "BACKGROUND")
Craftie.Frame.TabBarBack:SetWidth(62)
Craftie.Frame.TabBarBack:SetHeight(400)
Craftie.Frame.TabBarBack:SetPoint("TOPLEFT", 0, 10)
Craftie.Frame.TabBarBack:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-ProfBar" .. Craftie.Game.Version .. ".png")

local TabSidePosY = 23
local TabSideSpacing = 37.4 --distance spacing
Craftie.Frame.TabSide={}
for i,v in pairs(Craftie.Professions) do
  Craftie.Frame.TabSide[i] = CreateFrame("Button", Craftie.Frame.TabSide[i], Craftie.Frame.TabBar, "BackdropTemplate")
  Craftie.Frame.TabSide[i]:SetWidth(40)
  Craftie.Frame.TabSide[i]:SetHeight(40)
  Craftie.Frame.TabSide[i]:SetPoint("TOPLEFT", 2, (-i*TabSideSpacing)+TabSidePosY)
  --Craftie.Frame.TabSide[i]:SetBackdrop(Craftie.Backdrop.General)
  --Craftie.Frame.TabSide[i]:SetBackdropColor(0, 1, 0, 0)
  --Craftie.Frame.TabSide[i]:SetBackdropBorderColor(1, 1, 1, 0)
  Craftie.Frame.TabSide[i].Icon = Craftie.Frame.TabSide[i]:CreateTexture(nil, "ARTWORK")
  Craftie.Frame.TabSide[i].Icon:SetSize(Craftie.Frame.TabSide[i]:GetWidth()-9, Craftie.Frame.TabSide[i]:GetHeight()-9)
  Craftie.Frame.TabSide[i].Icon:SetPoint("TOPLEFT", 7, -5)
  Craftie.Frame.TabSide[i].Icon:SetTexture("Interface/Icons/" .. v[2])
  Craftie.Frame.TabSide[i].Icon:SetDesaturation(0.40)
  Craftie.Frame.TabSide[i].Icon:SetDrawLayer("ARTWORK", -2)
  Craftie.Frame.TabSide[i].Shadow = CreateFrame("Frame", nil, Craftie.Frame.TabSide[i], "BackdropTemplate")
  Craftie.Frame.TabSide[i].Shadow:SetWidth(32)
  Craftie.Frame.TabSide[i].Shadow:SetHeight(32)
  Craftie.Frame.TabSide[i].Shadow:SetPoint("TOPLEFT", 7, -4)
  Craftie.Frame.TabSide[i].Shadow:SetBackdrop(Craftie.Backdrop.General)
  Craftie.Frame.TabSide[i].Shadow:SetBackdropColor(0, 0, 0, 0.6) --shadow strength
  Craftie.Frame.TabSide[i].Shadow:SetBackdropBorderColor(1, 1, 1, 0)
  --Craftie.Frame.TabSide[i].Shadow:SetFrameStrata("MEDIUM")
  Craftie.Frame.TabSide[i].Glow = Craftie.Frame.TabSide[i]:CreateTexture(nil, "ARTWORK")
  Craftie.Frame.TabSide[i].Glow:SetSize(Craftie.Frame.TabSide[i]:GetWidth()-8, Craftie.Frame.TabSide[i]:GetHeight()-8)
  Craftie.Frame.TabSide[i].Glow:SetPoint("CENTER", 3, -1)
  Craftie.Frame.TabSide[i].Glow:SetTexture("Interface/ContainerFrame/UI-Icon-QuestBorder")
  Craftie.Frame.TabSide[i].Glow:SetDrawLayer("ARTWORK", 6)
  Craftie.Frame.TabSide[i].Glow:Hide()
  Craftie.Frame.TabSide[i].Hover = Craftie.Frame.TabSide[i]:CreateTexture(nil, "ARTWORK")
  Craftie.Frame.TabSide[i].Hover:SetSize(Craftie.Frame.TabSide[i]:GetWidth()-9, Craftie.Frame.TabSide[i]:GetHeight()-9)
  Craftie.Frame.TabSide[i].Hover:SetPoint("TOPLEFT", 7, -5)
  Craftie.Frame.TabSide[i].Hover:SetTexture("Interface/Buttons/ButtonHilight-Square")
  Craftie.Frame.TabSide[i].Hover:SetBlendMode("ADD")
  Craftie.Frame.TabSide[i].Hover:SetDrawLayer("OVERLAY", 7)
  Craftie.Frame.TabSide[i].Hover:Hide()

  Craftie.Frame.TabSide[i]:SetScript("OnEnter", function(self)
    Craftie.Frame.TabSide[i].Hover:Show()
    CraftieTooltip:ClearLines()
    CraftieTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
    CraftieTooltip:AddLine("|cffffffff" .. v[1] .. "|r")
    CraftieTooltip:Show()
  end)
  Craftie.Frame.TabSide[i]:SetScript("OnLeave", function()
    Craftie.Frame.TabSide[i].Hover:Hide()
    CraftieTooltip:Hide()
  end)
  Craftie.Frame.TabSide[i]:SetScript("OnClick", function(self)
    Craftie:TabSelect(i, true)
  end)
end

Craftie.Frame.CrafterLevel = CreateFrame("Frame", "Craftie.Frame.CrafterLevel", Craftie.Frame, "BackdropTemplate")
Craftie.Frame.CrafterLevel:SetWidth(250)
Craftie.Frame.CrafterLevel:SetHeight(20)
Craftie.Frame.CrafterLevel:SetPoint("TOPLEFT", 400, -30)
Craftie.Frame.CrafterLevel:SetBackdrop(Craftie.Backdrop.General)
Craftie.Frame.CrafterLevel:SetBackdropColor(0, 1, 0, 0)
Craftie.Frame.CrafterLevel:SetBackdropBorderColor(1, 1, 1, 0)
--Craftie.Frame.CrafterLevel:Hide() --this bugs out the mask on the prog bar. Draw first then hide later

Craftie.Frame.CrafterProgBar = Craftie.Frame.CrafterLevel:CreateTexture(nil, "ARTWORK")
Craftie.Frame.CrafterProgBar:SetSize(246, 15)
Craftie.Frame.CrafterProgBar:SetPoint("TOPLEFT", 0, -5)
Craftie.Frame.CrafterProgBar:SetTexture("Interface/Buttons/GREENGRAD64")
Craftie.Frame.CrafterProgBar:SetMask(Craftie._G.Path .. "Images/ProgBarMask.png")
Craftie.Frame.CrafterProgBarS = Craftie.Frame.CrafterLevel:CreateTexture(nil, "OVERLAY")
Craftie.Frame.CrafterProgBarS:SetSize(80, 80)
Craftie.Frame.CrafterProgBarS:SetPoint("TOPLEFT", 5, 10)
Craftie.Frame.CrafterProgBarS:SetTexture("Interface/COMMON/StreamSpark")
Craftie.Frame.CrafterProgBorder = Craftie.Frame.CrafterLevel:CreateTexture(nil, "OVERLAY")
Craftie.Frame.CrafterProgBorder:SetSize(250, 34)
Craftie.Frame.CrafterProgBorder:SetPoint("TOPLEFT", 0, 5)
Craftie.Frame.CrafterProgBorder:SetTexture("Interface/PaperDollInfoFrame/UI-Character-Skills-BarBorder")

Craftie.Frame.CrafterProgLevel = Craftie.Frame.CrafterLevel:CreateFontString(nil, "ARTWORK")
Craftie.Frame.CrafterProgLevel:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "OUTLINE | SLUG")
Craftie.Frame.CrafterProgLevel:SetPoint("CENTER", 4, -2)
Craftie.Frame.CrafterProgLevel:SetJustifyH("LEFT")
Craftie.Frame.CrafterProgLevel:SetText("")

Craftie.Frame.Button={}
Craftie.Frame.Button.Frame = Craftie.Frame:CreateTexture(nil, "OVERLAY")
Craftie.Frame.Button.Frame:SetSize(64, 64)
Craftie.Frame.Button.Frame:SetPoint("TOPRIGHT", -1, 1)
Craftie.Frame.Button.Frame:SetTexture(Craftie._G.Path .. "Images/UIFrameMetal-RightDouble.png")
Craftie.Frame.Button.Frame:SetDrawLayer("OVERLAY", 1)

Craftie.Frame.Button.Options = CreateFrame("Button", nil, Craftie.Frame, "UIPanelButtonTemplate")
Craftie.Frame.Button.Options:SetSize(24, 24)
Craftie.Frame.Button.Options:SetPoint("TOPRIGHT", -24, 2)
Craftie.Frame.Button.Options.icon = Craftie.Frame.Button.Options:CreateTexture(nil, "ARTWORK")
Craftie.Frame.Button.Options.icon:SetSize(12, 12)
Craftie.Frame.Button.Options.icon:SetPoint("CENTER", 0, -1)
Craftie.Frame.Button.Options.icon:SetTexture("Interface/Buttons/UI-OptionsButton")
Craftie.Frame.Button.Options:SetScript("OnClick", function(self)
  Settings.OpenToCategory(Craftie.Settings.Category:GetID())
  Craftie.Frame:Hide()
end)
--Craftie.Frame.Button.Options:SetNormalTexture("Interface\\Buttons\\UI-SquareButton-Up")
--Craftie.Frame.Button.Options:SetPushedTexture("Interface\\Buttons\\UI-SquareButton-Down")
--Craftie.Frame.Button.Options:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")

Craftie.Frame.Button.Minimap = CreateFrame("Button", nil, Minimap)
Craftie.Frame.Button.Minimap:SetFrameLevel(499)
Craftie.Frame.Button.Minimap:SetFrameStrata("TOOLTIP")
Craftie.Frame.Button.Minimap:SetSize(26, 26)
Craftie.Frame.Button.Minimap:SetMovable(true)
Craftie.Frame.Button.Minimap:SetPoint("TOPRIGHT", -5, 0)
Craftie.Frame.Button.Minimap:RegisterForClicks("AnyUp")
Craftie.Frame.Button.Minimap.Icon = Craftie.Frame.Button.Minimap:CreateTexture(nil, "BORDER")
Craftie.Frame.Button.Minimap.Icon:SetSize(Craftie.Frame.Button.Minimap:GetWidth(), Craftie.Frame.Button.Minimap:GetHeight())
Craftie.Frame.Button.Minimap.Icon:SetPoint("CENTER", 0, 0)
Craftie.Frame.Button.Minimap.Icon:SetTexture(Craftie._G.Path .. "Images/" .. Craftie._G.Icon .. ".png")
Craftie.Frame.Button.Minimap.IconGlow = Craftie.Frame.Button.Minimap:CreateTexture(nil, "ARTWORK")
Craftie.Frame.Button.Minimap.IconGlow:SetSize(Craftie.Frame.Button.Minimap:GetWidth(), Craftie.Frame.Button.Minimap:GetHeight())
Craftie.Frame.Button.Minimap.IconGlow:SetPoint("CENTER", 0, 0)
Craftie.Frame.Button.Minimap.IconGlow:SetTexture(Craftie._G.Path .. "Images/" .. Craftie._G.Icon .. "-Glow.png")
Craftie.Frame.Button.Minimap.IconGlow:SetAlpha(0.6)
Craftie.Frame.Button.Minimap.IconGlow:Hide()

Craftie.Frame.Button.Minimap:RegisterForDrag("LeftButton")
Craftie.Frame.Button.Minimap:SetScript("OnDragStart", function()
    Craftie.Frame.Button.Minimap:StartMoving()
    Craftie.Frame.Button.Minimap:SetScript("OnUpdate", Craftie.UpdateMapButton)
end)
Craftie.Frame.Button.Minimap:SetScript("OnDragStop", function()
    Craftie.Frame.Button.Minimap:StopMovingOrSizing()
    Craftie.Frame.Button.Minimap:SetScript("OnUpdate", nil)
		Craftie:SaveMapButtonPos()
end)

Craftie.Frame.Button.Minimap:SetScript("OnEnter", function(self)
  GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
  --GameTooltip:AddLine(Craftie._G.Stamp .. "|n|CFFFFFFFF" .. Craftie.Game.Name .. "|r")
  GameTooltip:AddDoubleLine(Craftie._G.Title, "|CFFABABABv" .. Craftie._G.Version)
  GameTooltip:AddDoubleLine(" ", "|CFFABABAB" .. Craftie.Game.Name)
  GameTooltip:AddLine(" ")
  GameTooltip:AddDoubleLine("|CFF4BABFALeft Click","|CFFFFFFFFOpen Craftie")
  GameTooltip:AddDoubleLine("|CFF4BABFARight Click", "|CFFFFFFFFCraftie Options")
  GameTooltip:Show()
	Craftie.Frame.Button.Minimap.IconGlow:Show()
end)
Craftie.Frame.Button.Minimap:SetScript("OnLeave", function(self)
	--Craftie.CloseAllMenus()
  GameTooltip:Hide()
  Craftie.Frame.Button.Minimap.IconGlow:Hide()
end)

Craftie.Frame.Button.Minimap:SetScript("OnClick", function(self, button)
  if (button == "LeftButton") then
    if (Craftie.OpenState == 1) then
      Craftie.Frame:Hide()
    else
      Craftie:Open()
    end
  end
  if (button == "RightButton") then
    Settings.OpenToCategory(Craftie.Settings.Category:GetID())
    Craftie.Frame:Hide()
  end
end)

Craftie.Settings={}
Craftie.Frame.Settings = CreateFrame("Frame", "CraftieSettingsFrame", UIParent)
Craftie.Settings.Category = Settings.RegisterCanvasLayoutCategory(Craftie.Frame.Settings, Craftie._G.Title)
Settings.RegisterAddOnCategory(Craftie.Settings.Category)

Craftie.Settings.Title = Craftie.Frame.Settings:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
Craftie.Settings.Title:SetPoint("TOPLEFT", 16, -16)
Craftie.Settings.Title:SetText(Craftie._G.Title)

CraftieDialog={}
CraftieDialog = CreateFrame("Frame", "CraftieDialog", Craftie.Frame, "TranslucentFrameTemplate")
CraftieDialog:SetWidth(350)
CraftieDialog:SetHeight(120)
CraftieDialog:SetPoint("CENTER", 0, 0)
CraftieDialog.Text = CraftieDialog:CreateFontString(nil, "ARTWORK")
CraftieDialog.Text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
CraftieDialog.Text:SetPoint("CENTER", 0, 14)
CraftieDialog.Text:SetText("Dialog here")
CraftieDialog:SetFrameStrata("DIALOG")
CraftieDialog:Hide()

CraftieDialog.Cancel = CreateFrame("Button", nil, CraftieDialog, "UIPanelButtonTemplate")
CraftieDialog.Cancel:SetSize(100, 24)
CraftieDialog.Cancel:SetPoint("CENTER", -64, -20)
CraftieDialog.Cancel:SetText("Cancel")
CraftieDialog.Cancel:SetScript("OnClick", function(self)
  self:GetParent():Hide()
  Craftie:CloseAllPlayerMenus()
end)

CraftieDialog.Yes = CreateFrame("Button", nil, CraftieDialog, "UIPanelButtonTemplate")
CraftieDialog.Yes:SetSize(100, 24)
CraftieDialog.Yes:SetPoint("CENTER", 64, -20)
CraftieDialog.Yes:SetText("Yes")
CraftieDialog.Yes:Hide()
