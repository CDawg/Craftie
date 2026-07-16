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
Craftie.Frame:SetMovable(true)
Craftie.Frame:EnableMouse(true)
Craftie.Frame:RegisterForDrag("LeftButton")
Craftie.Frame:SetScript("OnDragStart", function()
  Craftie.Frame:StartMoving()
end)
Craftie.Frame:SetScript("OnDragStop", function()
  Craftie.Frame:StopMovingOrSizing()
  local point, relativeTo, relativePoint, xOfs, yOfs = Craftie.Frame:GetPoint()
  Craftie.Save.Player["CONFIG"]["POS_MAIN"] = point .. "," .. xOfs .. "," .. yOfs
  Craftie:Notification("CONFIG->POS_MAIN: " .. point .. "," .. xOfs .. "," .. yOfs, Craftie.CHAT.SAVE)
end)
Craftie.Frame:SetFrameStrata("LOW")
Craftie.Frame.Back = Craftie.Frame:CreateTexture(nil, "BACKGROUND", nil, 0)
--Craftie.Frame.Back:SetAllPoints()
Craftie.Frame.Back:SetPoint("TOPLEFT", 0, 0)
Craftie.Frame.Back:SetWidth(Craftie.Frame:GetWidth()-4)
Craftie.Frame.Back:SetHeight(Craftie.Frame:GetHeight()-4)
Craftie.Frame.Back:SetTexture(Craftie._G.Image.Background.Light)
Craftie.Frame.Back:SetVertexColor(1, 0.94, 0.86)

Craftie.Frame.BotShadow = Craftie.Frame:CreateTexture(nil, "BACKGROUND", nil, 1)
Craftie.Frame.BotShadow:SetSize(Craftie.Frame:GetWidth()-6, 24)
Craftie.Frame.BotShadow:SetPoint("BOTTOMLEFT", 2, -1)
Craftie.Frame.BotShadow:SetHorizTile(true)
Craftie.Frame.BotShadow:SetTexture(Craftie._G.Image.Background.Bottom, "REPEAT")
Craftie.Frame.BotShadow:SetAlpha(0.5)

Craftie.Frame.Icon = Craftie.Frame:CreateTexture(nil, "OVERLAY")
Craftie.Frame.Icon:SetSize(160, 80)
Craftie.Frame.Icon:SetPoint("TOPLEFT", -42, 30)
Craftie.Frame.Icon:SetTexture(Craftie._G.Image.Logo.Header)
Craftie.Frame.Icon:SetDrawLayer("OVERLAY", 4)

Craftie.Frame.Header = Craftie.Frame:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Header:SetFont(Craftie._G.Font.Style.Alpha, Craftie._G.Font.Size+1, Craftie._G.Font.Flags)
Craftie.Frame.Header:SetPoint("TOPRIGHT", -70, -5)
Craftie.Frame.Header:SetText("v" .. Craftie._G.Version .. " [" .. Craftie.Game.Name .. "]")
Craftie.Frame.Header:SetTextColor(0.9, 0.9, 0.8, 0.5)

Craftie.Frame.Title = Craftie.Frame:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Title:SetFont(Craftie._G.Font.Style.Alpha, Craftie._G.Font.Size+3, Craftie._G.Font.Flags)
Craftie.Frame.Title:SetPoint("TOPLEFT", 40, -35)
Craftie.Frame.Title:SetText(Craftie:TranslateLocaleProfession(Craftie.Professions[1][2]))
Craftie.Frame.Title:SetTextColor(0.9, 0.9, 0.8, 1)

Craftie.Frame.CrafterProgBarFrame = CreateFrame("Frame", nil, Craftie.Frame, "BackdropTemplate")
Craftie.Frame.CrafterProgBarFrame:SetWidth(500)
Craftie.Frame.CrafterProgBarFrame:SetHeight(100)
Craftie.Frame.CrafterProgBarFrame:SetPoint("TOPLEFT", 36, -50)
Craftie.Frame.CrafterProgBarFrame:Hide()
Craftie.Frame.CrafterProgBar = CreateFrame("StatusBar", nil, Craftie.Frame.CrafterProgBarFrame)
Craftie.Frame.CrafterProgBar:SetSize(240, 16)
Craftie.Frame.CrafterProgBar:SetPoint("TOPLEFT", 0, 0)
Craftie.Frame.CrafterProgBar.bg = Craftie.Frame.CrafterProgBar:CreateTexture(nil, "OVERLAY")
Craftie.Frame.CrafterProgBar.bg:SetPoint("TOPLEFT", -1, 1)
Craftie.Frame.CrafterProgBar.bg:SetSize(Craftie.Frame.CrafterProgBar:GetWidth()+2, Craftie.Frame.CrafterProgBar:GetHeight()+2)
Craftie.Frame.CrafterProgBar.bg:SetTexture(Craftie._G.Image.ProgressBar.Back)
Craftie.Frame.CrafterProgBar:SetStatusBarTexture(Craftie._G.Image.ProgressBar.Bar)
Craftie.Frame.CrafterProgBar:SetStatusBarColor(0, 0.70, 0)
Craftie.Frame.CrafterProgBar.Text = Craftie.Frame.CrafterProgBar:CreateFontString(nil, "ARTWORK")
Craftie.Frame.CrafterProgBar.Text:SetFont(Craftie._G.Font.Style.Alpha, Craftie._G.Font.Size, Craftie._G.Font.Flags)
Craftie.Frame.CrafterProgBar.Text:SetPoint("CENTER", 0, 0)
Craftie.Frame.CrafterProgBar.Text:SetText("")

Mixin(Craftie.Frame.CrafterProgBar, SmoothStatusBarMixin)

-- Define the range and current progress
--Craftie.Frame.CrafterProgBar:SetMinMaxValues(0, 100)
Craftie.Frame.CrafterProgBar:SetMinMaxValues(0, Craftie.PROFMAXLEVEL)
Craftie.Frame.CrafterProgBar:SetValue(1)

--[==[
Craftie.Frame.CrafterProgLevel = Craftie.Frame.CrafterProgBarFrame:CreateFontString(nil, "ARTWORK")
Craftie.Frame.CrafterProgLevel:SetFont(Craftie._G.Font.Style.Alpha, Craftie._G.Font.Size, "OUTLINE")
Craftie.Frame.CrafterProgLevel:SetPoint("CENTER", 4, -2)
Craftie.Frame.CrafterProgLevel:SetJustifyH("LEFT")
Craftie.Frame.CrafterProgLevel:SetText("")
]==]--

Craftie.Frame.Mastery = Craftie.Frame:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Mastery:SetFont(Craftie._G.Font.Style.Alpha, Craftie._G.Font.Size, Craftie._G.Font.Flags)
Craftie.Frame.Mastery:SetPoint("TOPLEFT", 40, -73)
Craftie.Frame.Mastery:SetText("")
Craftie.Frame.Mastery:SetTextColor(0.9, 0.9, 0.8, 1)

Craftie.Frame.Button={}
Craftie.Frame.Button.Frame = Craftie.Frame:CreateTexture(nil, "OVERLAY")
Craftie.Frame.Button.Frame:SetSize(64, 64)
Craftie.Frame.Button.Frame:SetPoint("TOPRIGHT", -1, 1)
Craftie.Frame.Button.Frame:SetTexture(Craftie._G.Image.Button.Frame)
Craftie.Frame.Button.Frame:SetDrawLayer("OVERLAY", 1)

Craftie.Frame.Button.Options = CreateFrame("Button", nil, Craftie.Frame, "UIPanelButtonTemplate")
Craftie.Frame.Button.Options:SetSize(24, 24)
Craftie.Frame.Button.Options:SetPoint("TOPRIGHT", -24, 2)
Craftie.Frame.Button.Options.icon = Craftie.Frame.Button.Options:CreateTexture(nil, "ARTWORK")
Craftie.Frame.Button.Options.icon:SetSize(12, 12)
Craftie.Frame.Button.Options.icon:SetPoint("CENTER", 0, -1)
Craftie.Frame.Button.Options.icon:SetTexture("Interface/Buttons/UI-OptionsButton")
Craftie.Frame.Button.Options:SetScript("OnClick", function(self)
  Settings.OpenToCategory(Craftie.Options.Category:GetID())
  Craftie.Frame:Hide()
end)
Craftie.Frame.Button.Options:SetScript("OnEnter", function(self)
  CraftieTooltip:ClearLines()
  CraftieTooltip:SetOwner(self, "ANCHOR_RIGHT")
  CraftieTooltip:AddLine(Craftie.Color.Silver .. "Options")
  CraftieTooltip:Show()
end)
Craftie.Frame.Button.Options:SetScript("OnLeave", function(self)
  CraftieTooltip:Hide()
end)

--determine version and placement
Craftie.Frame.TabBar = CreateFrame("Button", nil, Craftie.Frame, "BackdropTemplate")
Craftie.Frame.TabBar:SetWidth(40)
Craftie.Frame.TabBar:SetHeight(330)
Craftie.Frame.TabBar:SetPoint("TOPLEFT", -Craftie.TabBar.X, -Craftie.TabBar.Y)
--Craftie.Frame.TabBar:SetBackdrop(Craftie.Backdrop.General)
--Craftie.Frame.TabBar:SetBackdropColor(0, 1, 0, 0)
--Craftie.Frame.TabBar:SetBackdropBorderColor(1, 1, 1, 0)
Craftie.Frame.TabBar:SetFrameStrata("BACKGROUND")
Craftie.Frame.TabBar:SetFrameLevel(0)
Craftie.Frame.TabBarBack = Craftie.Frame.TabBar:CreateTexture(nil, "BACKGROUND")
Craftie.Frame.TabBarBack:SetWidth(62)
Craftie.Frame.TabBarBack:SetHeight(400)
Craftie.Frame.TabBarBack:SetPoint("TOPLEFT", 0, 10)
Craftie.Frame.TabBarBack:SetTexture(Craftie._G.Image.TabBar .. Craftie.Game.Version .. ".png")

local tabbar_frame = {
  layer = "BACKGROUND",
  level = -1,
}
local TabSidePosY = Craftie.TabBar.Y-43
local TabSideSpacing = 40 --distance spacing
Craftie.TabGlow={}
Craftie.TipGlow={}
Craftie.Frame.TabSide={}
for i,v in pairs(Craftie.Professions) do
  Craftie.Frame.TabSide[i] = CreateFrame("Button", Craftie.Frame.TabSide[i], Craftie.Frame.TabBar, "BackdropTemplate")
  Craftie.Frame.TabSide[i]:SetWidth(40)
  Craftie.Frame.TabSide[i]:SetHeight(40)
  Craftie.Frame.TabSide[i]:SetPoint("TOPLEFT", 2, (-i*TabSideSpacing)+TabSidePosY)
  --Craftie.Frame.TabSide[i]:SetBackdrop(Craftie.Backdrop.General)
  --Craftie.Frame.TabSide[i]:SetBackdropColor(0, 1, 0, 0)
  --Craftie.Frame.TabSide[i]:SetBackdropBorderColor(1, 1, 1, 0)
  Craftie.Frame.TabSide[i].Icon = Craftie.Frame.TabSide[i]:CreateTexture(nil, tabbar_frame.layer)
  Craftie.Frame.TabSide[i].Icon:SetSize(Craftie.Frame.TabSide[i]:GetWidth()-9, Craftie.Frame.TabSide[i]:GetHeight()-9)
  Craftie.Frame.TabSide[i].Icon:SetPoint("TOPLEFT", 7, -5)
  Craftie.Frame.TabSide[i].Icon:SetTexture("Interface/Icons/" .. v[3])
  Craftie.Frame.TabSide[i].Icon:SetDesaturation(0.40)
  Craftie.Frame.TabSide[i].Icon:SetDrawLayer(tabbar_frame.layer, tabbar_frame.level-2)
  Craftie.Frame.TabSide[i].Select = Craftie.Frame.TabSide[i]:CreateTexture(nil, tabbar_frame.layer)
  Craftie.Frame.TabSide[i].Select:SetSize(Craftie.Frame.TabSide[i]:GetWidth()-8, Craftie.Frame.TabSide[i]:GetHeight()-8)
  Craftie.Frame.TabSide[i].Select:SetPoint("CENTER", 3, -1)
  Craftie.Frame.TabSide[i].Select:SetTexture("Interface/ContainerFrame/UI-Icon-QuestBorder")
  Craftie.Frame.TabSide[i].Select:SetDrawLayer(tabbar_frame.layer, tabbar_frame.level)
  Craftie.Frame.TabSide[i].Select:SetAlpha(0.8)
  Craftie.Frame.TabSide[i].Select:Hide()
  Craftie.Frame.TabSide[i].Glow = Craftie.Frame.TabSide[i]:CreateTexture(nil, tabbar_frame.layer)
  Craftie.Frame.TabSide[i].Glow:SetSize(Craftie.Frame.TabSide[i]:GetWidth()-4, Craftie.Frame.TabSide[i]:GetHeight()-4)
  Craftie.Frame.TabSide[i].Glow:SetPoint("CENTER", 3, -1)
  Craftie.Frame.TabSide[i].Glow:SetTexture("Interface/ContainerFrame/UI-Icon-QuestBorder")
  Craftie.Frame.TabSide[i].Glow:SetDrawLayer(tabbar_frame.layer, tabbar_frame.level)
  Craftie.Frame.TabSide[i].Glow:Hide()
  Craftie.Frame.TabSide[i].Tip = Craftie.Frame.TabSide[i]:CreateTexture(nil, tabbar_frame.layer)
  Craftie.Frame.TabSide[i].Tip:SetSize(Craftie.Frame.TabSide[i]:GetWidth()+26, Craftie.Frame.TabSide[i]:GetHeight()-18)
  Craftie.Frame.TabSide[i].Tip:SetPoint("CENTER", -18, 15)
  Craftie.Frame.TabSide[i].Tip:SetTexture(Craftie._G.Image.Button.Arrow)
  Craftie.Frame.TabSide[i].Tip:SetDrawLayer(tabbar_frame.layer, tabbar_frame.level)
  Craftie.Frame.TabSide[i].Tip:SetRotation(math.pi/2)
  Craftie.Frame.TabSide[i].Tip:Hide()
  Craftie.Frame.TabSide[i].Hover = Craftie.Frame.TabSide[i]:CreateTexture(nil, tabbar_frame.layer)
  Craftie.Frame.TabSide[i].Hover:SetSize(Craftie.Frame.TabSide[i]:GetWidth()-9, Craftie.Frame.TabSide[i]:GetHeight()-9)
  Craftie.Frame.TabSide[i].Hover:SetPoint("TOPLEFT", 7, -5)
  Craftie.Frame.TabSide[i].Hover:SetTexture("Interface/Buttons/ButtonHilight-Square")
  Craftie.Frame.TabSide[i].Hover:SetBlendMode("ADD")
  Craftie.Frame.TabSide[i].Hover:SetDrawLayer("OVERLAY", tabbar_frame.level)
  Craftie.Frame.TabSide[i].Hover:Hide()

  Craftie.TabGlow[i] = Craftie.Frame.TabSide[i].Glow:CreateAnimationGroup()
  Craftie.TabGlow[i]:SetLooping("BOUNCE")
  local fadeIn = Craftie.TabGlow[i]:CreateAnimation("Alpha")
  fadeIn:SetOrder(1)
  fadeIn:SetDuration(0.5)
  fadeIn:SetFromAlpha(0)
  fadeIn:SetToAlpha(1)
  local fadeOut = Craftie.TabGlow[i]:CreateAnimation("Alpha")
  fadeOut:SetOrder(2)
  fadeOut:SetDuration(0.5)
  fadeOut:SetFromAlpha(1)
  fadeOut:SetToAlpha(0)
  Craftie.TipGlow[i] = Craftie.Frame.TabSide[i].Tip:CreateAnimationGroup()
  Craftie.TipGlow[i]:SetLooping("BOUNCE")
  local fadeIn = Craftie.TipGlow[i]:CreateAnimation("Alpha")
  fadeIn:SetOrder(1)
  fadeIn:SetDuration(0.7)
  fadeIn:SetFromAlpha(0)
  fadeIn:SetToAlpha(1)
  local fadeOut = Craftie.TipGlow[i]:CreateAnimation("Alpha")
  fadeOut:SetOrder(2)
  fadeOut:SetDuration(0.7)
  fadeOut:SetFromAlpha(1)
  fadeOut:SetToAlpha(0)

  Craftie.Frame.TabSide[i]:SetScript("OnEnter", function(self)
    local prof = Craftie:TranslateLocaleProfession(v[2])
    Craftie.Frame.TabSide[i].Hover:Show()
    CraftieTooltip:ClearLines()
    CraftieTooltip:SetOwner(self, "ANCHOR_RIGHT")
    CraftieTooltip:AddLine(Craftie.Color.White .. prof .. "|r")
    for a,build in pairs(Craftie.MyProfessionEntry) do
      if (build == prof) then
        CraftieTooltip:AddLine(Craftie.Color.Silver .. "Detected " .. Craftie.Color.Blue .. "[" .. prof .. "]|r as one of your professions")
        CraftieTooltip:AddLine(Craftie.Color.Silver .. "Click to build your profile")
      end
    end
    CraftieTooltip:Show()
  end)
  Craftie.Frame.TabSide[i]:SetScript("OnLeave", function()
    Craftie.Frame.TabSide[i].Hover:Hide()
    CraftieTooltip:Hide()
  end)
  Craftie.Frame.TabSide[i]:SetScript("OnClick", function(self)
    Craftie:TabSelectSide(i, true)
  end)
end

Craftie.Frame.Button.Minimap = CreateFrame("Button", nil, Minimap)
Craftie.Frame.Button.Minimap:SetFrameLevel(499)
Craftie.Frame.Button.Minimap:SetFrameStrata("TOOLTIP")
Craftie.Frame.Button.Minimap:SetSize(26, 26)
Craftie.Frame.Button.Minimap:SetMovable(true)
Craftie.Frame.Button.Minimap:SetPoint("TOPRIGHT", -122, -95) --starting pos
Craftie.Frame.Button.Minimap:RegisterForClicks("AnyUp")
Craftie.Frame.Button.Minimap.Icon = Craftie.Frame.Button.Minimap:CreateTexture(nil, "BORDER")
Craftie.Frame.Button.Minimap.Icon:SetSize(Craftie.Frame.Button.Minimap:GetWidth(), Craftie.Frame.Button.Minimap:GetHeight())
Craftie.Frame.Button.Minimap.Icon:SetPoint("CENTER", 0, 0)
Craftie.Frame.Button.Minimap.Icon:SetTexture(Craftie._G.Path .. Craftie._G.Icon .. ".png")
Craftie.Frame.Button.Minimap.IconHighlight = Craftie.Frame.Button.Minimap:CreateTexture(nil, "ARTWORK")
Craftie.Frame.Button.Minimap.IconHighlight:SetSize(Craftie.Frame.Button.Minimap:GetWidth(), Craftie.Frame.Button.Minimap:GetHeight())
Craftie.Frame.Button.Minimap.IconHighlight:SetPoint("CENTER", 0, 0)
Craftie.Frame.Button.Minimap.IconHighlight:SetTexture(Craftie._G.Path .. Craftie._G.Icon .. "-Glow.png")
Craftie.Frame.Button.Minimap.IconHighlight:SetAlpha(0.6)
Craftie.Frame.Button.Minimap.IconHighlight:Hide()
Craftie.Frame.Button.Minimap.Glow = Craftie.Frame.Button.Minimap:CreateTexture(nil, "BORDER")
Craftie.Frame.Button.Minimap.Glow:SetSize(Craftie.Frame.Button.Minimap:GetWidth()+20, Craftie.Frame.Button.Minimap:GetHeight()+20)
Craftie.Frame.Button.Minimap.Glow:SetPoint("CENTER", 0, 0)
Craftie.Frame.Button.Minimap.Glow:SetTexture("Interface/UNITPOWERBARALT/PandarenTraining_Circular_Flash")
Craftie.Frame.Button.Minimap.Glow:SetBlendMode("ADD")
Craftie.Frame.Button.Minimap.Glow:Hide()

Craftie.IconGlow = Craftie.Frame.Button.Minimap.Glow:CreateAnimationGroup()
Craftie.IconGlow:SetLooping("BOUNCE")
local fadeIn = Craftie.IconGlow:CreateAnimation("Alpha")
fadeIn:SetOrder(1)
fadeIn:SetDuration(0.6)
fadeIn:SetFromAlpha(0)
fadeIn:SetToAlpha(1)
local fadeOut = Craftie.IconGlow:CreateAnimation("Alpha")
fadeOut:SetOrder(2)
fadeOut:SetDuration(0.6)
fadeOut:SetFromAlpha(1)
fadeOut:SetToAlpha(0)
--Craftie.IconGlow:Play()

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
  CraftieTooltip:ClearAllPoints()
  CraftieTooltip:ClearLines()
  CraftieTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
  CraftieTooltip:AddDoubleLine(Craftie._G.Title, Craftie.Color.Gray .. "v" .. Craftie._G.Version)
  CraftieTooltip:AddDoubleLine(" ", Craftie.Color.Gray .. Craftie.Game.Name)
  CraftieTooltip:AddLine(" ")
  for i,tooltip in ipairs(Craftie._L.MMTooltip) do
    if (i == 3) then
      CraftieTooltip:AddLine(" ")
    end
    CraftieTooltip:AddDoubleLine(Craftie.Color.Blue .. tooltip[1], Craftie.Color.White .. tooltip[2])
  end
  CraftieTooltip:Show()
	Craftie.Frame.Button.Minimap.IconHighlight:Show()
end)
Craftie.Frame.Button.Minimap:SetScript("OnLeave", function(self)
  CraftieTooltip:Hide()
  Craftie.Frame.Button.Minimap.IconHighlight:Hide()
end)
Craftie.Frame.Button.Minimap:SetScript("OnClick", function(self, button)
  if (button == "LeftButton") then
    if (Craftie.OpenState == 1) then
      Craftie.Frame:Hide()
    else
      Craftie:Open()
    end
    if (IsShiftKeyDown()) then
      Settings.OpenToCategory(Craftie.Options.Category:GetID())
      Craftie.Frame:Hide()
      CraftieTooltip:Hide()
    end
  end
  if (button == "RightButton") then
    Craftie:Open()
    C_Timer.After(0.40, function()
      Craftie:TabSelectBottom(2, true)
    end)
  end
end)

CraftieDialog={}
CraftieDialog = CreateFrame("Frame", "CraftieDialog", Craftie.Frame, "TranslucentFrameTemplate")
CraftieDialog:SetWidth(350)
CraftieDialog:SetHeight(120)
CraftieDialog:SetPoint("CENTER", 0, 0)
CraftieDialog.Text = CraftieDialog:CreateFontString(nil, "ARTWORK")
CraftieDialog.Text:SetFont(Craftie._G.Font.Style.Alpha, Craftie._G.Font.Size, Craftie._G.Font.Flags)
CraftieDialog.Text:SetPoint("CENTER", 0, 14)
CraftieDialog.Text:SetText("Dialog here")
CraftieDialog:SetFrameStrata("DIALOG")
CraftieDialog:SetFrameLevel(7000)
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

Craftie.Frame:Hide()

--[==[
local f = CreateFrame("Frame", "MyGlowingBox", UIParent)
f:SetSize(40, 40)
f:SetPoint("CENTER", UIParent, "CENTER")

-- 2. Create the texture (e.g., a simple white square we will colorize)
local tex = f:CreateTexture(nil, "BACKGROUND")
tex:SetAllPoints()
tex:SetTexture("Interface\\Icons\\inv_mushroom_11")

-- 3. Create the glowing overlay
local overlay = f:CreateTexture(nil, "OVERLAY")
overlay:SetAllPoints()
overlay:SetTexture("Interface\\Buttons\\UI-ActionButton-Border")
overlay:SetBlendMode("ADD")
overlay:SetAlpha(0)

-- 4. Create the Animation Group for a blinking/pulsing glow
local ag = overlay:CreateAnimationGroup()
ag:SetLooping("BOUNCE")

local fadeIn = ag:CreateAnimation("Alpha")
fadeIn:SetOrder(1)
fadeIn:SetDuration(0.5)
fadeIn:SetFromAlpha(0)
fadeIn:SetToAlpha(1)

local fadeOut = ag:CreateAnimation("Alpha")
fadeOut:SetOrder(2)
fadeOut:SetDuration(0.5)
fadeOut:SetFromAlpha(1)
fadeOut:SetToAlpha(0)
ag:Play()
]==]--
