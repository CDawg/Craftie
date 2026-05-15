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
Craftie.Frame:SetFrameStrata("MEDIUM")
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
  Craftie.Notification("[" .. Craftie.Player.Combine .. "]" .. point .. "," .. xOfs .. "," .. yOfs, true)
end)

Craftie.Frame.BotShadow = Craftie.Frame:CreateTexture(nil, "BACKGROUND")
Craftie.Frame.BotShadow:SetSize(Craftie.Frame:GetWidth()-12, 35)
Craftie.Frame.BotShadow:SetPoint("BOTTOMLEFT", 6, -1)
Craftie.Frame.BotShadow:SetHorizTile(true)
Craftie.Frame.BotShadow:SetTexture(Craftie._G.Path .. "images/ShadowOverlay-Bottom.png", "REPEAT")

Craftie.Frame.Icon = Craftie.Frame:CreateTexture(nil, "ARTWORK")
Craftie.Frame.Icon:SetSize(58, 58)
Craftie.Frame.Icon:SetPoint("TOPLEFT", -5, 7)
Craftie.Frame.Icon:SetTexture(Craftie._G.Path .. "images/icon_default.tga")
Craftie.Frame.Icon:SetMask("Interface/Masks/CircleMaskScalable")

Craftie.Frame.Title = Craftie.Frame:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Title:SetFont(Craftie._G.Font.Style, 12, "SLUG")
Craftie.Frame.Title:SetPoint("TOPLEFT", 65, -5)
Craftie.Frame.Title:SetText(Craftie._G.Stamp .. " - " .. Craftie.Game.Name)

Craftie.Frame.Title.Sub = Craftie.Frame:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Title.Sub:SetFont(Craftie._G.Font.Style, 14, "SLUG")
Craftie.Frame.Title.Sub:SetPoint("TOPLEFT", 65, -35)
Craftie.Frame.Title.Sub:SetText("")
Craftie.Frame.Title.Sub:Hide()

Craftie.Frame.Title.Prof = Craftie.Frame:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Title.Prof:SetFont(Craftie._G.Font.Style, 14, "SLUG")
Craftie.Frame.Title.Prof:SetPoint("TOPLEFT", 65, -35)
Craftie.Frame.Title.Prof:SetText("Alchemy")

--determine version and placement
Craftie.Frame.TabBar = CreateFrame("Button", Craftie.Frame.TabBar, Craftie.Frame, "BackdropTemplate")
Craftie.Frame.TabBar:SetWidth(40)
Craftie.Frame.TabBar:SetHeight(330)
Craftie.Frame.TabBar:SetPoint("TOPLEFT", -42, -60)
Craftie.Frame.TabBar:SetBackdrop(Craftie.Backdrop.General)
Craftie.Frame.TabBar:SetBackdropColor(0, 1, 0, 0)
Craftie.Frame.TabBar:SetBackdropBorderColor(1, 1, 1, 0)
Craftie.Frame.TabBar:SetFrameStrata("LOW")
Craftie.Frame.TabBarBack = Craftie.Frame.TabBar:CreateTexture(nil, "BACKGROUND")
Craftie.Frame.TabBarBack:SetWidth(62)
Craftie.Frame.TabBarBack:SetHeight(440)
Craftie.Frame.TabBarBack:SetPoint("TOPLEFT", 0, 10)
Craftie.Frame.TabBarBack:SetTexture(Craftie._G.Path .. "Images/CraftBar_TBC.png")

local TabSidePosY = 23
local TabSideSpacing = 37.4 --distance spacing
Craftie.Frame.TabSide={}
for i,v in pairs(Craftie.Professions) do
  Craftie.Frame.TabSide[i] = CreateFrame("Button", Craftie.Frame.TabSide[i], Craftie.Frame.TabBar, "BackdropTemplate")
  Craftie.Frame.TabSide[i]:SetWidth(40)
  Craftie.Frame.TabSide[i]:SetHeight(40)
  Craftie.Frame.TabSide[i]:SetPoint("TOPLEFT", 2, (-i*TabSideSpacing)+TabSidePosY)
  Craftie.Frame.TabSide[i]:SetBackdrop(Craftie.Backdrop.General)
  Craftie.Frame.TabSide[i]:SetBackdropColor(0, 1, 0, 0)
  Craftie.Frame.TabSide[i]:SetBackdropBorderColor(1, 1, 1, 0)
  Craftie.Frame.TabSide[i].Icon = Craftie.Frame.TabSide[i]:CreateTexture(nil, "ARTWORK")
  Craftie.Frame.TabSide[i].Icon:SetSize(Craftie.Frame.TabSide[i]:GetWidth()-9, Craftie.Frame.TabSide[i]:GetHeight()-9)
  Craftie.Frame.TabSide[i].Icon:SetPoint("TOPLEFT", 7, -5)
  Craftie.Frame.TabSide[i].Icon:SetTexture("Interface/Icons/" .. v[2])
  Craftie.Frame.TabSide[i].Icon:SetDesaturation(0.30)
  Craftie.Frame.TabSide[i].Icon:SetDrawLayer("ARTWORK", -2)
  Craftie.Frame.TabSide[i].Shadow = CreateFrame("Frame", Craftie.Frame.TabSide[i].Shadow, Craftie.Frame.TabSide[i], "BackdropTemplate")
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

  --Craftie.Frame.TabSide[i]:Hide()

  Craftie.Frame.TabSide[i]:SetScript("OnEnter", function(self)
    Craftie.Frame.TabSide[i].Hover:Show()
    --GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:AddLine("|cffffffff" .. v[1] .. "|r")
    GameTooltip:Show()
  end)
  Craftie.Frame.TabSide[i]:SetScript("OnLeave", function()
    Craftie.Frame.TabSide[i].Hover:Hide()
    GameTooltip:Hide()
  end)
  Craftie.Frame.TabSide[i]:SetScript("OnClick", function(self)
    Craftie.ClearFocusAll()
    Craftie.TabSelect(i, true)
    Craftie.Frame.Title.Prof:SetText(v[1])
    Craftie.ProfessionDefault = Craftie.Profession[v[1]]
    C_Timer.After(0.10, function() --give it time to register
      local search_index = Craftie.Frame.Search.Recipes.Text:GetText()
      if (search_index == Craftie.Placeholder_Recipes) then
        search_index = ""
      end
      Craftie.OpenProfessionList(Craftie.ProfessionDefault, search_index, "")
    end)
    Craftie.Page = v[1]
    Craftie.Selected_Players = 1
    Craftie.Selected_Recipes = 1
    Craftie.Frame.ScrollPlayersList.Child:SetVerticalScroll(1)
    Craftie.Frame.ScrollRecipesList.Child:SetVerticalScroll(1)
    Craftie.Frame.Craft:Hide()
    for i=1, Craftie.MAX_REAGENTS do
      Craftie.Frame.Reagent.Main[i]:Hide()
      Craftie.Frame.Reagent.Back[i]:Hide()
    end
  end)
end

Craftie.Frame.Button={}
Craftie.Frame.Button.Frame = Craftie.Frame:CreateTexture(nil, "BORDER")
Craftie.Frame.Button.Frame:SetSize(30, 30)
Craftie.Frame.Button.Frame:SetPoint("TOPRIGHT", -25, 0)
Craftie.Frame.Button.Frame:SetTexture("Interface/DialogFrame/UI-DialogBox-Corner")

--Craftie.Frame.Button.Options= CreateFrame("Button", nil, Craftie.Frame, "BackdropTemplate")
Craftie.Frame.Button.Options= CreateFrame("Button", nil, Craftie.Frame, "UIPanelButtonTemplate")
Craftie.Frame.Button.Options:SetSize(24, 23)
Craftie.Frame.Button.Options:SetPoint("TOPRIGHT", -23, 1)
Craftie.Frame.Button.Options.icon = Craftie.Frame.Button.Options:CreateTexture(nil, "ARTWORK")
Craftie.Frame.Button.Options.icon:SetSize(12, 12)
Craftie.Frame.Button.Options.icon:SetPoint("CENTER", 0, 0)
Craftie.Frame.Button.Options.icon:SetTexture("Interface/Buttons/UI-OptionsButton")
Craftie.Frame.Button.Options:SetScript("OnEnter", function(self)
  --Craftie.TooltipDisplay(self, Craftie._G.Title, Craftie.Addon)
end)
Craftie.Frame.Button.Options:SetScript("OnLeave", function(self)

end)
Craftie.Frame.Button.Options:SetScript("OnClick", function(self)
  Craftie.Frame:Hide()
  --Craftie.FrameOptions:Show()
end)

--Craftie.Frame.Button.Minimap={}
--Craftie.Frame.Button.Minimap.Border={}

Craftie.Frame.Button.Minimap = CreateFrame("Button", nil, Minimap)
Craftie.Frame.Button.Minimap:SetFrameLevel(499)
Craftie.Frame.Button.Minimap:SetFrameStrata("TOOLTIP")
Craftie.Frame.Button.Minimap:SetSize(32, 32)
Craftie.Frame.Button.Minimap:SetMovable(true)
Craftie.Frame.Button.Minimap:SetPoint("TOPRIGHT", -5, 0)
Craftie.Frame.Button.Minimap.Border = Craftie.Frame.Button.Minimap:CreateTexture(nil, "BORDER")
Craftie.Frame.Button.Minimap.Border:SetSize(Craftie.Frame.Button.Minimap:GetWidth()-4, Craftie.Frame.Button.Minimap:GetHeight()-4)
Craftie.Frame.Button.Minimap.Border:SetPoint("CENTER", 0, 0)
Craftie.Frame.Button.Minimap.Border:SetTexture("Interface/COMMON/ringborder")
Craftie.Frame.Button.Minimap.Border:SetDrawLayer("BORDER", 6)
Craftie.Frame.Button.Minimap.BorderBG = Craftie.Frame.Button.Minimap:CreateTexture(nil, "BORDER")
Craftie.Frame.Button.Minimap.BorderBG:SetSize(Craftie.Frame.Button.Minimap:GetWidth()-4, Craftie.Frame.Button.Minimap:GetHeight()-4)
Craftie.Frame.Button.Minimap.BorderBG:SetPoint("CENTER", 0, 0)
Craftie.Frame.Button.Minimap.BorderBG:SetTexture(Craftie._G.Path .. "images/icon_default.tga")
Craftie.Frame.Button.Minimap.Border:SetDrawLayer("BORDER", 4)
Craftie.Frame.Button.Minimap.BorderOn = Craftie.Frame.Button.Minimap:CreateTexture(nil, "ARTWORK")
Craftie.Frame.Button.Minimap.BorderOn:SetSize(Craftie.Frame.Button.Minimap:GetWidth()+24, Craftie.Frame.Button.Minimap:GetHeight()+24)
Craftie.Frame.Button.Minimap.BorderOn:SetPoint("CENTER", 0, 0)
Craftie.Frame.Button.Minimap.BorderOn:SetTexture("Interface/COMMON/portrait-ring-withbg-highlight")
Craftie.Frame.Button.Minimap.BorderOn:SetAlpha(0.6)
Craftie.Frame.Button.Minimap.BorderOn:Hide()

Craftie.Frame.Button.Minimap:RegisterForDrag("LeftButton")
Craftie.Frame.Button.Minimap:SetScript("OnDragStart", function()
    Craftie.Frame.Button.Minimap:StartMoving()
    Craftie.Frame.Button.Minimap:SetScript("OnUpdate", Craftie.UpdateMapButton)
end)
Craftie.Frame.Button.Minimap:SetScript("OnDragStop", function()
    Craftie.Frame.Button.Minimap:StopMovingOrSizing()
    Craftie.Frame.Button.Minimap:SetScript("OnUpdate", nil)
		Craftie.SaveMapButtonPos()
end)

Craftie.Frame.Button.Minimap:SetScript("OnEnter", function(self)
  GameTooltip:SetOwner(self, "ANCHOR_LEFT")
  GameTooltip:AddLine(Craftie._G.Stamp .. "|n" .. Craftie.Game.Name)
  GameTooltip:Show()
	Craftie.Frame.Button.Minimap.BorderOn:Show()
end)
Craftie.Frame.Button.Minimap:SetScript("OnLeave", function(self)
	--Craftie.CloseAllMenus()
  GameTooltip:Hide()
  Craftie.Frame.Button.Minimap.BorderOn:Hide()
end)

Craftie.Frame.Button.Minimap:SetScript("OnClick", function()
  Craftie.OpenCraftie()
end)

Craftie.Frame:SetScript("OnHide", function(self)
  Craftie.WindowOpen = 0
end)
Craftie.Frame:Hide()
