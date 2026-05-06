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

Craftie.Frame = CreateFrame("Frame", Craftie.Frame, UIParent, "ButtonFrameTemplate")
Craftie.Frame:SetWidth(Craftie._G.Width)
Craftie.Frame:SetHeight(Craftie._G.Height)
--Craftie.Frame:SetPoint("CENTER", 0, -140)
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
  CraftieDB[Craftie.player.realm][Craftie.player.faction][Craftie.player.name]["CONFIG"]["POS_MAIN"] = point .. "," .. xOfs .. "," .. yOfs
  Craftie.Notification("[" .. Craftie.player.combine .. "]" .. point .. "," .. xOfs .. "," .. yOfs, true)
end)

Craftie.Icon = Craftie.Frame:CreateTexture(nil, "ARTWORK")
Craftie.Icon:SetSize(54, 54)
Craftie.Icon:SetPoint("TOPLEFT", -4, 4)
Craftie.Icon:SetTexture(Craftie._G.dir .. "images/icon_default.tga")
--Craftie.Icon:SetTexture(Craftie._G.dir .. "images/Trade_Engraving")

Craftie.Frame.Title = Craftie.Frame:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Title:SetFont(Craftie._G.font, 12, "OUTLINE")
Craftie.Frame.Title:SetPoint("TOPLEFT", 65, -5)
Craftie.Frame.Title:SetText(Craftie.Stamp)

Craftie.Frame.Title.Prof = Craftie.Frame:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Title.Prof:SetFont(Craftie._G.font, 14, "OUTLINE")
Craftie.Frame.Title.Prof:SetPoint("TOPLEFT", 65, -35)
Craftie.Frame.Title.Prof:SetText("Alchemy")

--light background template
--Interface/Glues/COMMON/UIFrameTooltipGluesBackground

local TabSideSpacing = 42 --height distance
for i,v in pairs(Craftie.Professions) do
  Craftie.TabSide.Frame[i] = CreateFrame("Button", Craftie.TabSide.Frame[i], Craftie.Frame, "BackdropTemplate")
  Craftie.TabSide.Frame[i]:SetWidth(40)
  Craftie.TabSide.Frame[i]:SetHeight(40)
  Craftie.TabSide.Frame[i]:SetPoint("TOPLEFT", -40, (-i*TabSideSpacing)-16)
  Craftie.TabSide.Frame[i]:SetBackdrop(Craftie.Backdrop.General)
  Craftie.TabSide.Frame[i]:SetBackdropColor(0, 1, 0, 0)
  Craftie.TabSide.Frame[i]:SetBackdropBorderColor(1, 1, 1, 0)
  Craftie.TabSide.Frame[i].Border = Craftie.TabSide.Frame[i]:CreateTexture(nil, "BORDER")
  Craftie.TabSide.Frame[i].Border:SetSize(60, 60)
  Craftie.TabSide.Frame[i].Border:SetPoint("TOPLEFT", -20, 14)
  Craftie.TabSide.Frame[i].Border:SetTexture("Interface/SPELLBOOK/SpellBook-SkillLineTab")
  Craftie.TabSide.Frame[i].Border:SetRotation(-math.pi)
  Craftie.TabSide.Frame[i].Icon = Craftie.TabSide.Frame[i]:CreateTexture(nil, "ARTWORK")
  Craftie.TabSide.Frame[i].Icon:SetSize(Craftie.TabSide.Frame[i]:GetWidth()-9, Craftie.TabSide.Frame[i]:GetHeight()-9)
  Craftie.TabSide.Frame[i].Icon:SetPoint("TOPLEFT", 7, -5)
  Craftie.TabSide.Frame[i].Icon:SetTexture("Interface/Icons/" .. v[2])
  Craftie.TabSide.Frame[i].Icon:SetDesaturation(0.30)
  Craftie.TabSide.Frame[i].Icon:SetDrawLayer("ARTWORK", -2)
  Craftie.TabSide.Frame[i].Shadow = CreateFrame("Frame", Craftie.TabSide.Frame[i].Shadow, Craftie.TabSide.Frame[i], "BackdropTemplate")
  Craftie.TabSide.Frame[i].Shadow:SetWidth(32)
  Craftie.TabSide.Frame[i].Shadow:SetHeight(32)
  Craftie.TabSide.Frame[i].Shadow:SetPoint("TOPLEFT", 7, -4)
  Craftie.TabSide.Frame[i].Shadow:SetBackdrop(Craftie.Backdrop.General)
  Craftie.TabSide.Frame[i].Shadow:SetBackdropColor(0, 0, 0, 0.6) --shadow strength
  Craftie.TabSide.Frame[i].Shadow:SetBackdropBorderColor(1, 1, 1, 0)
  Craftie.TabSide.Frame[i].Shadow:SetFrameStrata("MEDIUM")
  Craftie.TabSide.Frame[i].Glow = Craftie.TabSide.Frame[i]:CreateTexture(nil, "ARTWORK")
  Craftie.TabSide.Frame[i].Glow:SetSize(Craftie.TabSide.Frame[i]:GetWidth()-8, Craftie.TabSide.Frame[i]:GetHeight()-8)
  Craftie.TabSide.Frame[i].Glow:SetPoint("CENTER", 3, -1)
  Craftie.TabSide.Frame[i].Glow:SetTexture("Interface/ContainerFrame/UI-Icon-QuestBorder")
  Craftie.TabSide.Frame[i].Glow:SetDrawLayer("ARTWORK", 6)
  Craftie.TabSide.Frame[i].Glow:Hide()
  Craftie.TabSide.Frame[i].BorderSelect = Craftie.TabSide.Frame[i]:CreateTexture(nil, "BORDER")
  Craftie.TabSide.Frame[i].BorderSelect:SetSize(Craftie.TabSide.Frame[i]:GetWidth()-3, Craftie.TabSide.Frame[i]:GetHeight())
  Craftie.TabSide.Frame[i].BorderSelect:SetPoint("TOPLEFT", 3, -1)
  Craftie.TabSide.Frame[i].BorderSelect:SetTexture("Interface/GLUES/CharacterSelect/Glues-CharacterSelect-Tab")
  Craftie.TabSide.Frame[i].BorderSelect:SetRotation(math.pi/2)
  Craftie.TabSide.Frame[i].BorderSelect:Hide()
  Craftie.TabSide.Frame[i].Hover = Craftie.TabSide.Frame[i]:CreateTexture(nil, "ARTWORK")
  Craftie.TabSide.Frame[i].Hover:SetSize(Craftie.TabSide.Frame[i]:GetWidth()-9, Craftie.TabSide.Frame[i]:GetHeight()-9)
  Craftie.TabSide.Frame[i].Hover:SetPoint("TOPLEFT", 7, -5)
  Craftie.TabSide.Frame[i].Hover:SetTexture("Interface/Buttons/ButtonHilight-Square")
  Craftie.TabSide.Frame[i].Hover:SetBlendMode("ADD")
  Craftie.TabSide.Frame[i].Hover:SetDrawLayer("ARTWORK", 7)
  Craftie.TabSide.Frame[i].Hover:Hide()

  Craftie.TabSide.Frame[i]:SetScript("OnEnter", function(self)
    Craftie.TabSide.Frame[i].Hover:Show()
    --GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:AddLine("|cffffffff" .. v[1] .. "|r")
    GameTooltip:Show()
  end)
  Craftie.TabSide.Frame[i]:SetScript("OnLeave", function()
    Craftie.TabSide.Frame[i].Hover:Hide()
    GameTooltip:Hide()
  end)
  Craftie.TabSide.Frame[i]:SetScript("OnClick", function(self)
    Craftie.ClearFocusAll()
    Craftie.TabSelect(i, true)
    Craftie.Frame.Title.Prof:SetText(v[1])
    --Craftie.TabSide.Frame[i].Border:SetTexture("Interface/FriendsFrame/UI-FriendsFrameTab")

    Craftie.Profession.Query = Craftie.Profession[v[1]]
    C_Timer.After(0.10, function() --give it time to register
      local search_index = Craftie.Frame.Search.Recipes.Text:GetText()
      if (search_index == Craftie.Placeholder_Recipes) then
        search_index = ""
      end
      Craftie.OpenProfessionList(Craftie.Profession.Query, search_index)
    end)
  end)
end

--[==[
Craftie.Tab = CreateFrame('Button', "$parentTab1", Craftie.Frame, "TabButtonTemplate")
Craftie.Tab:SetID(1)
Craftie.Tab:SetText('Details')
Craftie.Tab:SetPoint("TOPLEFT", Craftie.Frame) --, "TOPLEFT", 100, 20)
PanelTemplates_TabResize(Craftie.Tab, 8) -- Resize based on text
]==]--

--[==[
SCROLL PLAYERS
]==]--
Craftie.Frame.Parent={}
Craftie.Frame.Parent.Scroll={}

Craftie.Frame.Parent.Scroll.Players = CreateFrame("Frame", Craftie.Frame.Parent.Scroll.Players, Craftie.Frame, "InsetFrameTemplate")
Craftie.Frame.Parent.Scroll.Players:SetWidth(210)
Craftie.Frame.Parent.Scroll.Players:SetHeight(Craftie._G.Height-88)
Craftie.Frame.Parent.Scroll.Players:SetPoint("TOPLEFT", 2, -61)

Craftie.Frame.Parent.Scroll.Players.Back = Craftie.Frame.Parent.Scroll.Players:CreateTexture(nil, "BACKGROUND")
Craftie.Frame.Parent.Scroll.Players.Back:SetSize(Craftie.Frame.Parent.Scroll.Players:GetWidth()+88, Craftie.Frame.Parent.Scroll.Players:GetHeight()+62)
Craftie.Frame.Parent.Scroll.Players.Back:SetPoint("TOPLEFT", 0, 0)
--Craftie.Frame.Parent.Scroll.Players.Back:SetTexture("Interface/EncounterJournal/UI-EJ-Classic")
Craftie.Frame.Parent.Scroll.Players.Back:SetTexture("Interface/Garrison/TalentTreeChromie")

Craftie.Frame.Parent.Scroll.Players.ScrollBar = Craftie.Frame.Parent.Scroll.Players:CreateTexture(nil, "BACKGROUND")
Craftie.Frame.Parent.Scroll.Players.ScrollBar:SetSize(14, Craftie.Frame.Parent.Scroll.Players:GetHeight()-8)
Craftie.Frame.Parent.Scroll.Players.ScrollBar:SetPoint("TOPLEFT", Craftie.Frame.Parent.Scroll.Players:GetWidth()-32, -4)
Craftie.Frame.Parent.Scroll.Players.ScrollBar:SetTexture("Interface/COMMON/ThinBorder-Right")

Craftie.Frame.Scroll={}
Craftie.Frame.Scroll.Players = {}
Craftie.Frame.Scroll.Players.List = {}
Craftie.Frame.Scroll.Players_Width = 210
--Craftie.Frame.Scroll.Players_Height= Craftie._G.Height-90
Craftie.Frame.Scroll.Players_Height= Craftie._G.Height-200

Craftie.Frame.Scroll.Players = CreateFrame("Frame", nil, Craftie.Frame.Parent.Scroll.Players)
Craftie.Frame.Scroll.Players:SetWidth(Craftie.Frame.Scroll.Players_Width)
Craftie.Frame.Scroll.Players:SetHeight(Craftie.Frame.Scroll.Players_Height)
Craftie.Frame.Scroll.Players:SetPoint("TOPLEFT", 0, 0) --low, due to the portrait frame
--Craftie.Frame.Scroll.Players:SetFrameStrata("LOW")

Craftie.Frame.Scroll.Players.List = CreateFrame("Frame", Craftie.Frame.Scroll.Players.List, Craftie.Frame.Scroll.Players, "BackdropTemplate")
Craftie.Frame.Scroll.Players.List:SetWidth(Craftie.Frame.Scroll.Players_Width)
Craftie.Frame.Scroll.Players.List:SetHeight(Craftie.Frame.Scroll.Players_Height)
Craftie.Frame.Scroll.Players.List:SetPoint("CENTER", 0, 0)
Craftie.Frame.Scroll.Players.List:SetBackdrop(Craftie.Backdrop.General)
Craftie.Frame.Scroll.Players.List:SetBackdropColor(0, 0, 0, 0.2) --shade
Craftie.Frame.Scroll.Players.List:SetBackdropBorderColor(1, 1, 1, 0)
Craftie.Frame.Scroll.Players.List.Child = CreateFrame("ScrollFrame", nil, Craftie.Frame.Scroll.Players.List, "UIPanelScrollFrameTemplate")
Craftie.Frame.Scroll.Players.List.Child:SetPoint("TOPLEFT", Craftie.Frame.Scroll.Players.List, "TOPLEFT", 3, -30)
Craftie.Frame.Scroll.Players.List.Child:SetPoint("BOTTOMRIGHT", Craftie.Frame.Scroll.Players.List, "BOTTOMRIGHT", 10, 4)
Craftie.Frame.Scroll.Players.ListChildFrame = CreateFrame("Frame", Craftie.Frame.Scroll.Players.ListChildFrame, Craftie.Frame.Scroll.Players.List.Child)
Craftie.Frame.Scroll.Players.ListChildFrame:SetSize(Craftie.Frame.Scroll.Players_Width, Craftie.Frame.Scroll.Players_Height)
Craftie.Frame.Scroll.Players.List.Child:SetScrollChild(Craftie.Frame.Scroll.Players.ListChildFrame)
Craftie.Frame.Scroll.Players.List.Child.ScrollBar:ClearAllPoints()
Craftie.Frame.Scroll.Players.List.Child.ScrollBar:SetPoint("TOPLEFT", Craftie.Frame.Scroll.Players.List.Child, "TOPRIGHT", 0, 10)
Craftie.Frame.Scroll.Players.List.Child.ScrollBar:SetPoint("BOTTOMRIGHT", Craftie.Frame.Scroll.Players.List.Child, "BOTTOMRIGHT", -42, 12)

--[==[
SEARCH PLAYERS
]==]--
Craftie.Frame.Search={}
Craftie.Frame.Search.Player={}
Craftie.Frame.Search.Player.Text={}

Craftie.Frame.Search.Player = CreateFrame("Frame", nil, Craftie.Frame.Parent.Scroll.Players, "BackdropTemplate", 2)
Craftie.Frame.Search.Player:SetWidth(150)
Craftie.Frame.Search.Player:SetHeight(24)
Craftie.Frame.Search.Player:SetPoint("TOPLEFT", 4, -1)
Craftie.Frame.Search.Player:SetBackdrop(Craftie.Backdrop.Opaque)
Craftie.Frame.Search.Player:SetBackdropColor(1, 0, 0, 1)
Craftie.Frame.Search.Player:SetBackdropBorderColor(1, 1, 1, 0.6)
Craftie.Frame.Search.Player:SetFrameStrata("MEDIUM")
Craftie.Frame.Search.Player:SetFrameLevel(Craftie.Framelevel.Foreground)
Craftie.Frame.Search.Player.Text = CreateFrame("EditBox", nil, Craftie.Frame.Search.Player)
Craftie.Frame.Search.Player.Text:SetWidth(Craftie.Frame.Search.Player:GetWidth()-6)
Craftie.Frame.Search.Player.Text:SetHeight(Craftie.Frame.Search.Player:GetHeight())
Craftie.Frame.Search.Player.Text:SetFontObject(GameFontDisable)
Craftie.Frame.Search.Player.Text:SetFont(Craftie._G.font, 11, "OUTLINE")
Craftie.Frame.Search.Player.Text:SetPoint("TOPLEFT", 6, 0)
Craftie.Frame.Search.Player.Text:SetAutoFocus(false)
Craftie.Frame.Search.Player.Text:SetText(Craftie.Placeholder_Players)
Craftie.Frame.Search.Player.Text:SetScript("OnKeyUp", function(self, key)
  if (key == "ENTER") then
    --local search_array = Craftie.Profession.Query
    --local search_index = Craftie.Frame.Search.Player.Text:GetText()
    --Craftie.OpenProfessionList(search_array, search_index)
    Craftie.ClearFocusAll()
    Craftie.Frame.Scroll.Players.List.Child:SetVerticalScroll(1)
  end
end)
Craftie.Frame.Search.Player.Text:SetScript("OnMouseDown", function(self)
    local search_index = Craftie.Frame.Search.Player.Text:GetText()
    if (search_index == Craftie.Placeholder_Players) then
      Craftie.Frame.Search.Player.Text:SetText("")
      Craftie.Frame.Search.Player.Text:SetFontObject(GameFontWhite)
    end
end)
Craftie.Frame.Search.Player.Text:SetScript("OnEditFocusLost", function(self)
  --Craftie.Frame.Search.Player.Text:SetText(Craftie.Placeholder_Players)
end)

Craftie.Frame.Scroll.Players.List.Item = {}
Craftie.Frame.Scroll.Players.List.Text={}
for i=1, Craftie.MAX_PLAYERS do
  Craftie.Frame.Scroll.Players.List.Item[i] = CreateFrame("Button", Craftie.Frame.Scroll.Players.List.Item[i], Craftie.Frame.Scroll.Players.ListChildFrame, "BackdropTemplate", -1)
  Craftie.Frame.Scroll.Players.List.Item[i]:SetWidth(Craftie.Frame.Scroll.Players_Width-26) --scrollbar size
  Craftie.Frame.Scroll.Players.List.Item[i]:SetHeight(20)
  Craftie.Frame.Scroll.Players.List.Item[i]:SetPoint("TOPLEFT", 2, -i*18)
  Craftie.Frame.Scroll.Players.List.Item[i]:SetBackdrop(Craftie.Backdrop.General)
  Craftie.Frame.Scroll.Players.List.Item[i]:SetBackdropBorderColor(1, 1, 1, 0)
  Craftie.Frame.Scroll.Players.List.Item[i]:SetFrameLevel(Craftie.Framelevel.Background)
  Craftie.Frame.Scroll.Players.List.Item[i]:SetBackdropColor(1, 1, 1, 0)

  Craftie.Frame.Scroll.Players.List.Text[i] = Craftie.Frame.Scroll.Players.List.Item[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.Scroll.Players.List.Text[i]:SetFont(Craftie._G.font, Craftie._G.fontSize, "OUTLINE")
  Craftie.Frame.Scroll.Players.List.Text[i]:SetPoint("TOPLEFT", 8, -5)
  --Craftie.Frame.Scroll.Players.List.Text[i]:SetText("Player_" .. i)
  Craftie.Frame.Scroll.Players.List.Text[i]:SetText("")
  if (i == 1) then
    Craftie.Frame.Scroll.Players.List.Text[i]:SetText(Craftie.Selected_ViewAll)
  end
  Craftie.Frame.Scroll.Players.List.Text[i]:SetTextColor(1, 1, 1, 0.8)

  if (i % 2 == 0) then
    Craftie.Frame.Scroll.Players.List.Item[i]:SetBackdropColor(0.6, 0.7, 1, 0.1)
  end
  Craftie.Frame.Scroll.Players.List.Item[i]:SetScript("OnEnter", function(self)
    Craftie.Frame.Scroll.Players.List.Item[i]:SetBackdropColor(1, 1, 1, 0.2)
    --Craftie.Frame.Scroll.Players.List.Text[i]:SetTextColor(1, 1, 0.8, 1)
  end)
  Craftie.Frame.Scroll.Players.List.Item[i]:SetScript("OnLeave", function(self)
    GameTooltip:Hide()
    Craftie.ClearSelectedItem("Players")
  end)
  Craftie.Frame.Scroll.Players.List.Item[i]:SetScript("OnClick", function(self)
    Craftie.SelectCrafter(i, Craftie.Frame.Scroll.Players.List.Text[i]:GetText())
  end)
end


--[==[
SCROLL RECIPES
]==]--
Craftie.Frame.Parent.Scroll.Recipes = CreateFrame("Frame", Craftie.Frame.ScrollMain, Craftie.Frame, "InsetFrameTemplate")
Craftie.Frame.Parent.Scroll.Recipes:SetWidth(300)
Craftie.Frame.Parent.Scroll.Recipes:SetHeight(Craftie._G.Height-88)
Craftie.Frame.Parent.Scroll.Recipes:SetPoint("TOPLEFT", 212, -61)

Craftie.Frame.Parent.Scroll.Recipes.Back = Craftie.Frame.Parent.Scroll.Recipes:CreateTexture(nil, "BACKGROUND")
Craftie.Frame.Parent.Scroll.Recipes.Back:SetSize(Craftie.Frame.Parent.Scroll.Recipes:GetWidth()+166, Craftie.Frame.Parent.Scroll.Recipes:GetHeight()+185)
Craftie.Frame.Parent.Scroll.Recipes.Back:SetPoint("TOPLEFT", 6, -5)
Craftie.Frame.Parent.Scroll.Recipes.Back:SetTexture("Interface/QUESTFRAME/QuestBookBG")

Craftie.Frame.Scroll.Recipes_Width = 300
Craftie.Frame.Scroll.Recipes_Height= Craftie._G.Height-90
Craftie.Frame.Scroll.Recipes = CreateFrame("Frame", nil, Craftie.Frame.Parent.Scroll.Recipes)

Craftie.Frame.Scroll.Recipes:SetWidth(Craftie.Frame.Scroll.Recipes_Width)
Craftie.Frame.Scroll.Recipes:SetHeight(Craftie.Frame.Scroll.Recipes_Height)
Craftie.Frame.Scroll.Recipes:SetPoint("TOPLEFT", 0, 0)

Craftie.Frame.Scroll.Recipes.List = CreateFrame("Frame", Craftie.Frame.Scroll.Recipes.List, Craftie.Frame.Scroll.Recipes, "BackdropTemplate")
Craftie.Frame.Scroll.Recipes.List:SetWidth(Craftie.Frame.Scroll.Recipes_Width)
Craftie.Frame.Scroll.Recipes.List:SetHeight(Craftie.Frame.Scroll.Recipes_Height)
Craftie.Frame.Scroll.Recipes.List:SetPoint("CENTER", 0, 0)
Craftie.Frame.Scroll.Recipes.List:SetBackdrop(Craftie.Backdrop.General)
--Craftie.Frame.Scroll.Recipes.List:SetBackdropColor(0.1, 0.6, 1, 0.1) --slight blue
Craftie.Frame.Scroll.Recipes.List:SetBackdropColor(0.1, 0.6, 1, 0) --slight blue
Craftie.Frame.Scroll.Recipes.List:SetBackdropBorderColor(1, 1, 1, 0)

Craftie.Frame.Scroll.Recipes.List.Child = CreateFrame("ScrollFrame", nil, Craftie.Frame.Scroll.Recipes.List, "UIPanelScrollFrameTemplate") -- "MinimalScrollBar"
--Craftie.Frame.Scroll.Recipes.List.Child = CreateFrame("ScrollFrame", nil, Craftie.Frame.Scroll.Recipes.List, "ScrollFrameTemplate")
--Craftie.Frame.Scroll.Recipes.List.Child:SetPoint("TOPLEFT", Craftie.Frame.Scroll.Recipes.List, "TOPLEFT", 3, -3)
Craftie.Frame.Scroll.Recipes.List.Child:SetPoint("TOPLEFT", Craftie.Frame.Scroll.Recipes.List, "TOPLEFT", 3, -30) --room for search bar
Craftie.Frame.Scroll.Recipes.List.Child:SetPoint("BOTTOMRIGHT", Craftie.Frame.Scroll.Recipes.List, "BOTTOMRIGHT", 10, 4)
Craftie.Frame.Scroll.Recipes.ListChildFrame = CreateFrame("Frame", Craftie.Frame.Scroll.Recipes.ListChildFrame, Craftie.Frame.Scroll.Recipes.List.Child)
Craftie.Frame.Scroll.Recipes.ListChildFrame:SetSize(Craftie.Frame.Scroll.Recipes_Width, Craftie.Frame.Scroll.Recipes_Height)
Craftie.Frame.Scroll.Recipes.List.Child:SetScrollChild(Craftie.Frame.Scroll.Recipes.ListChildFrame)
Craftie.Frame.Scroll.Recipes.List.Child.ScrollBar:ClearAllPoints()
--Craftie.Frame.Scroll.Recipes.List.Child.ScrollBar:SetPoint("TOPLEFT", Craftie.Frame.Scroll.Recipes.List.Child, "TOPRIGHT", 0, -17)
Craftie.Frame.Scroll.Recipes.List.Child.ScrollBar:SetPoint("TOPLEFT", Craftie.Frame.Scroll.Recipes.List.Child, "TOPRIGHT", 0, 10) --room for search bar
Craftie.Frame.Scroll.Recipes.List.Child.ScrollBar:SetPoint("BOTTOMRIGHT", Craftie.Frame.Scroll.Recipes.List.Child, "BOTTOMRIGHT", -42, 12)

Craftie.Frame.Scroll.Recipes.Results = Craftie.Frame.Scroll.Recipes:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Scroll.Recipes.Results:SetFont(Craftie._G.font, Craftie._G.fontSize, "OUTLINE")
Craftie.Frame.Scroll.Recipes.Results:SetPoint("BOTTOMRIGHT", 0, -20)
Craftie.Frame.Scroll.Recipes.Results:SetText("")

Craftie.Frame.Scroll.Recipes.Empty = Craftie.Frame.Scroll.Recipes:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Scroll.Recipes.Empty:SetFont(Craftie._G.font, Craftie._G.fontSize, "OUTLINE")
Craftie.Frame.Scroll.Recipes.Empty:SetPoint("CENTER", -10, 0)
Craftie.Frame.Scroll.Recipes.Empty:SetTextColor(1, 1, 1, 0.6)
Craftie.Frame.Scroll.Recipes.Empty:SetText("")

--[==[
SEARCH PLAYERS
]==]--
Craftie.Frame.Search.Recipes={}
Craftie.Frame.Search.Recipes.Text={}

Craftie.Frame.Search.Recipes = CreateFrame("Frame", nil, Craftie.Frame.Parent.Scroll.Recipes, "BackdropTemplate", 2)
Craftie.Frame.Search.Recipes:SetWidth(150)
Craftie.Frame.Search.Recipes:SetHeight(24)
Craftie.Frame.Search.Recipes:SetPoint("TOPLEFT", 2, -2)
Craftie.Frame.Search.Recipes:SetBackdrop(Craftie.Backdrop.Opaque)
Craftie.Frame.Search.Recipes:SetBackdropColor(1, 0, 0, 1)
Craftie.Frame.Search.Recipes:SetBackdropBorderColor(1, 1, 1, 0.6)
Craftie.Frame.Search.Recipes:SetFrameStrata("MEDIUM")
--Craftie.Frame.Search.Recipes:SetFrameLevel(Craftie.Framelevel.Foreground)
Craftie.Frame.Search.Recipes.Text = CreateFrame("EditBox", nil, Craftie.Frame.Search.Recipes)
Craftie.Frame.Search.Recipes.Text:SetWidth(200)
Craftie.Frame.Search.Recipes.Text:SetHeight(35)
Craftie.Frame.Search.Recipes.Text:SetFontObject(GameFontDisable)
Craftie.Frame.Search.Recipes.Text:SetFont(Craftie._G.font, 11, "OUTLINE")
Craftie.Frame.Search.Recipes.Text:SetPoint("TOPLEFT", 6, 4)
Craftie.Frame.Search.Recipes.Text:SetAutoFocus(false)
Craftie.Frame.Search.Recipes.Text:SetText(Craftie.Placeholder_Recipes)
Craftie.Frame.Search.Recipes.Text:SetScript("OnKeyUp", function(self, key)
  if (key == "ENTER") then
    local search_array = Craftie.Profession.Query
    local search_index = Craftie.Frame.Search.Recipes.Text:GetText()
    Craftie.OpenProfessionList(search_array, search_index)
    Craftie.ClearFocusAll()
    Craftie.Frame.Scroll.Recipes.List.Child:SetVerticalScroll(1)
  end
end)
Craftie.Frame.Search.Recipes.Text:SetScript("OnMouseDown", function(self)
    local search_index = Craftie.Frame.Search.Recipes.Text:GetText()
    if (search_index == Craftie.Placeholder_Recipes) then
      Craftie.Frame.Search.Recipes.Text:SetText("")
      Craftie.Frame.Search.Recipes.Text:SetFontObject(GameFontWhite)
    end
end)
Craftie.Frame.Search.Recipes.Text:SetScript("OnEditFocusLost", function(self)
  --Craftie.Frame.Search.Recipes.Text:SetText(Craftie.Placeholder_Recipes)
end)

Craftie.Frame.Parent.Craft= CreateFrame("Frame", Craftie.Frame.Parent.Craft, Craftie.Frame, "InsetFrameTemplate")
Craftie.Frame.Parent.Craft:SetWidth(300)
Craftie.Frame.Parent.Craft:SetHeight(Craftie._G.Height-88)
Craftie.Frame.Parent.Craft:SetPoint("TOPRIGHT", -8, -61)

--Craftie.Frame.Craft = {}
Craftie.Frame.Craft = CreateFrame("Frame", Craftie.Frame.Craft, Craftie.Frame.Parent.Craft, "BackdropTemplate")
Craftie.Frame.Craft:SetWidth(220)
Craftie.Frame.Craft:SetHeight(35)
Craftie.Frame.Craft:SetPoint("TOPLEFT", 14, -50)
Craftie.Frame.Craft:SetBackdrop(Craftie.Backdrop.General)
Craftie.Frame.Craft:SetBackdropColor(0, 1, 0, 0)
Craftie.Frame.Craft:SetBackdropBorderColor(1, 1, 1, 0)
Craftie.Frame.Craft:SetHyperlinksEnabled(true)
Craftie.Frame.Craft:SetScript("OnHyperlinkClick", function(self, link, text, button)
	SetItemRef(link, text, nil, self)
end)

Craftie.Frame.Craft.Icon = Craftie.Frame.Craft:CreateTexture(nil, "ARTWORK")
Craftie.Frame.Craft.Icon:SetSize(35, 35)
Craftie.Frame.Craft.Icon:SetPoint("TOPLEFT", 0, 0)
Craftie.Frame.Craft.Icon:SetTexture("Interface/Icons/inv_misc_questionmark")
--Craftie.Frame.Craft.Icon:SetTexture("Interface/Icons/Trade_Engraving")
Craftie.Frame.Craft.Icon:Hide()
Craftie.Frame.Craft.Text = Craftie.Frame.Craft:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Craft.Text:SetFont(Craftie._G.font, 12, "OUTLINE")
Craftie.Frame.Craft.Text:SetPoint("TOPLEFT", 40, -10)
Craftie.Frame.Craft.Text:SetText("")
--designed to mask over the entire craft frame
Craftie.Frame.Craft.HLink = Craftie.Frame.Craft:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Craft.HLink:SetFont(Craftie._G.font, 20, "OUTLINE")
Craftie.Frame.Craft.HLink:SetPoint("TOPLEFT", -4, -8)
Craftie.Frame.Craft.HLink:SetText("")
Craftie.Frame.Craft.HLink:SetScript("OnLeave", function(self)
  GameTooltip:Hide()
end)
Craftie.Frame.Craft.ID = Craftie.Frame.Craft:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Craft.ID:SetFont(Craftie._G.font, Craftie._G.fontSize, "OUTLINE")
Craftie.Frame.Craft.ID:SetPoint("CENTER", 10, 0)
Craftie.Frame.Craft.ID:SetText("")
Craftie.Frame.Craft.ID:SetTextColor(1, 1, 1, 0)

Craftie.Frame.Craft.SkillIcon = Craftie.Frame.Craft:CreateTexture(nil, "ARTWORK")
Craftie.Frame.Craft.SkillIcon:SetSize(13, 13)
Craftie.Frame.Craft.SkillIcon:SetPoint("BOTTOMLEFT", 0, -154)
Craftie.Frame.Craft.SkillIcon:SetTexture("Interface/Icons/inv_misc_questionmark")
Craftie.Frame.Craft.SkillIcon:Hide()
Craftie.Frame.Craft.Skill = Craftie.Frame.Craft:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Craft.Skill:SetFont(Craftie._G.font, Craftie._G.fontSize, "OUTLINE")
Craftie.Frame.Craft.Skill:SetPoint("BOTTOMLEFT", 15, -152)
Craftie.Frame.Craft.Skill:SetText("")
Craftie.Frame.Craft.Skill:SetTextColor(1, 1, 1, 0.7)
Craftie.Frame.Craft.Skill:Hide()
Craftie.Frame.Craft.SourceTitle = Craftie.Frame.Craft:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Craft.SourceTitle:SetFont(Craftie._G.font, Craftie._G.fontSize, "OUTLINE")
Craftie.Frame.Craft.SourceTitle:SetPoint("BOTTOMLEFT", 15, -168)
Craftie.Frame.Craft.SourceTitle:SetText("Sources:")
Craftie.Frame.Craft.SourceTitle:SetTextColor(1, 1, 1, 1)
Craftie.Frame.Craft.SourceTitle:Hide()
Craftie.Frame.Craft.Source = Craftie.Frame.Craft:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Craft.Source:SetFont(Craftie._G.font, Craftie._G.fontSize, "OUTLINE")
Craftie.Frame.Craft.Source:SetPoint("BOTTOMLEFT", 65, -168)
Craftie.Frame.Craft.Source:SetText("")
Craftie.Frame.Craft.Source:SetTextColor(1, 1, 1, 0.8)
Craftie.Frame.Craft.Source:Hide()

Craftie.Frame.Craft.Back = Craftie.Frame.Parent.Craft:CreateTexture(nil, "BACKGROUND")
Craftie.Frame.Craft.Back:SetSize(150, 110)
Craftie.Frame.Craft.Back:SetPoint("BOTTOMRIGHT", -150, 0)
Craftie.Frame.Craft.Back:SetTexture("Interface/FrameGeneral/UI-Background-Rock")
Craftie.Frame.Craft.Back = Craftie.Frame.Parent.Craft:CreateTexture(nil, "BACKGROUND")
Craftie.Frame.Craft.Back:SetSize(150, 110)
Craftie.Frame.Craft.Back:SetPoint("BOTTOMRIGHT", -2, 0)
Craftie.Frame.Craft.Back:SetTexture("Interface/FrameGeneral/UI-Background-Rock")
--Craftie.Frame.Craft.Back:SetTexture("Interface/TradeSkillFrame/UI-Tradeskill-BlacksmithBG-Top")
Craftie.Frame.Craft.Divider = Craftie.Frame.Parent.Craft:CreateTexture(nil, "ARTWORK")
Craftie.Frame.Craft.Divider:SetSize(400, 24)
Craftie.Frame.Craft.Divider:SetPoint("BOTTOMRIGHT", 98, 90)
Craftie.Frame.Craft.Divider:SetTexture("Interface/DialogFrame/UI-DialogBox-Divider")

--[==[
Craftie.Frame.Craft.BotLeft = Craftie.Frame.Parent.Craft:CreateTexture(nil, "BACKGROUND")
Craftie.Frame.Craft.BotLeft:SetSize(180, 90)
Craftie.Frame.Craft.BotLeft:SetPoint("BOTTOMRIGHT", -124, -13)
Craftie.Frame.Craft.BotLeft:SetTexture("Interface/PaperDollInfoFrame/UI-Character-Honor-BottomLeft")
Craftie.Frame.Craft.BotLeft:SetDrawLayer("BACKGROUND", 1)
Craftie.Frame.Craft.BotRight= Craftie.Frame.Parent.Craft:CreateTexture(nil, "BORDER")
Craftie.Frame.Craft.BotRight:SetSize(100, 90)
Craftie.Frame.Craft.BotRight:SetPoint("BOTTOMRIGHT", 54, -13)
Craftie.Frame.Craft.BotRight:SetTexture("Interface/PaperDollInfoFrame/UI-Character-Honor-BottomRight")
]==]--

Craftie.Frame.Reagent = {}
Craftie.Frame.Reagent.Main = {}
Craftie.Frame.Reagent.Tooltip = {}
Craftie.Frame.Reagent.Icon = {}
Craftie.Frame.Reagent.Text = {}
Craftie.Frame.Reagent.QuanR = {} --required
Craftie.Frame.Reagent.QuanI = {} --inventory
Craftie.Frame.Reagent.Dash = {}
Craftie.Frame.Reagent.Data = {} --ID
Craftie.Frame.Reagent_Width = 100
Craftie.Frame.Reagent_Height= 35
Craftie.Frame.Reagent_PosX  = 50
Craftie.Frame.Reagent_PosY  = 100
for i=1, Craftie.MAX_REAGENTS do
  Craftie.Frame.Reagent.Main[i] = CreateFrame("Frame", Craftie.Frame.Reagent.Main[i], Craftie.Frame.Parent.Craft, "BackdropTemplate")
  Craftie.Frame.Reagent.Main[i]:SetWidth(Craftie.Frame.Reagent_Width)
  Craftie.Frame.Reagent.Main[i]:SetHeight(Craftie.Frame.Reagent_Height)
  if (i % 2 == 0) then
    Craftie.Frame.Reagent.Main[i]:SetPoint("CENTER", Craftie.Frame.Reagent_Width-20, (-i*18)+Craftie.Frame.Reagent_PosY)
  else
    local p = i+1
    Craftie.Frame.Reagent.Main[i]:SetPoint("CENTER", -55, (-p*18)+Craftie.Frame.Reagent_PosY)
  end

  Craftie.Frame.Reagent.Main[i]:SetBackdrop(Craftie.Backdrop.General)
  Craftie.Frame.Reagent.Main[i]:SetBackdropColor(0, 0, 0, 1)
  Craftie.Frame.Reagent.Main[i]:SetBackdropBorderColor(1, 1, 1, 0.6)
  Craftie.Frame.Reagent.Icon[i] = Craftie.Frame.Reagent.Main[i]:CreateTexture(nil, "ARTWORK")
  Craftie.Frame.Reagent.Icon[i]:SetSize(Craftie.Frame.Reagent_Height-2, Craftie.Frame.Reagent_Height-2)
  Craftie.Frame.Reagent.Icon[i]:SetPoint("CENTER", -65, 0)
  Craftie.Frame.Reagent.Icon[i]:SetTexture("Interface/Icons/inv_misc_questionmark")
  Craftie.Frame.Reagent.Icon[i]:SetAlpha(0.5)
  Craftie.Frame.Reagent.Text[i] = Craftie.Frame.Reagent.Main[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.Reagent.Text[i]:SetFont(Craftie._G.font, 10, "OUTLINE")
  Craftie.Frame.Reagent.Text[i]:SetPoint("TOPLEFT", 2, -6)
  Craftie.Frame.Reagent.Text[i]:SetText(i)
  Craftie.Frame.Reagent.Text[i]:SetWidth(Craftie.Frame.Reagent_Width-10)
  Craftie.Frame.Reagent.Text[i]:SetHeight(Craftie.Frame.Reagent_Height-10)
  Craftie.Frame.Reagent.Text[i]:SetWordWrap(true)
  Craftie.Frame.Reagent.Text[i]:SetTextColor(1, 1, 1, 0.8)
  Craftie.Frame.Reagent.Data[i] = Craftie.Frame.Reagent.Main[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.Reagent.Data[i]:SetFont(Craftie._G.font, 10, "OUTLINE")
  --Craftie.Frame.Reagent.Data[i]:SetPoint("TOPLEFT", 0, 0)
  Craftie.Frame.Reagent.Data[i]:SetText(i)
  Craftie.Frame.Reagent.QuanI[i] = Craftie.Frame.Reagent.Main[i]:CreateFontString(nil, "OVERLAY")
  Craftie.Frame.Reagent.QuanI[i]:SetFont(Craftie._G.font, 11, "OUTLINE")
  Craftie.Frame.Reagent.QuanI[i]:SetPoint("TOPLEFT", -27, -20)
  Craftie.Frame.Reagent.QuanI[i]:SetText("3")
  Craftie.Frame.Reagent.Dash[i] = Craftie.Frame.Reagent.Main[i]:CreateFontString(nil, "OVERLAY")
  Craftie.Frame.Reagent.Dash[i]:SetFont(Craftie._G.font, 12, "OUTLINE")
  Craftie.Frame.Reagent.Dash[i]:SetPoint("TOPLEFT", -19, -20)
  Craftie.Frame.Reagent.Dash[i]:SetText("/")
  Craftie.Frame.Reagent.QuanR[i] = Craftie.Frame.Reagent.Main[i]:CreateFontString(nil, "OVERLAY")
  Craftie.Frame.Reagent.QuanR[i]:SetFont(Craftie._G.font, 11, "OUTLINE")
  Craftie.Frame.Reagent.QuanR[i]:SetPoint("TOPLEFT", -14, -20)
  Craftie.Frame.Reagent.QuanR[i]:SetText("3")
  Craftie.Frame.Reagent.Tooltip[i] = CreateFrame("Frame", Craftie.Frame.Reagent.Tooltip[i], Craftie.Frame.Reagent.Main[i], "BackdropTemplate")
  Craftie.Frame.Reagent.Tooltip[i]:SetWidth(Craftie.Frame.Reagent_Width+30)
  Craftie.Frame.Reagent.Tooltip[i]:SetHeight(Craftie.Frame.Reagent_Height)
  Craftie.Frame.Reagent.Tooltip[i]:SetPoint("TOPLEFT", -30, 0)
  Craftie.Frame.Reagent.Tooltip[i]:SetBackdrop(Craftie.Backdrop.General)
  Craftie.Frame.Reagent.Tooltip[i]:SetBackdropColor(1, 1, 1, 0)
  Craftie.Frame.Reagent.Tooltip[i]:SetBackdropBorderColor(1, 1, 1, 0)

  Craftie.Frame.Reagent.Main[i]:Hide()

  Craftie.Frame.Reagent.Tooltip[i]:SetScript("OnEnter", function(self)
    SetItemTooltip(self, Craftie.Frame.Reagent.Data[i]:GetText(), false)
  end)
  Craftie.Frame.Reagent.Tooltip[i]:SetScript("OnLeave", function(self)
    GameTooltip:Hide()
  end)
end

Craftie.Frame.Scroll.Recipes.List.Item={}
Craftie.Frame.Scroll.Recipes.List.Text={}
for i=1, Craftie.MAX_RECIPES do
  Craftie.Frame.Scroll.Recipes.List.Item[i] = CreateFrame("Button", Craftie.Frame.Scroll.Recipes.List.Item[i], Craftie.Frame.Scroll.Recipes.ListChildFrame, "BackdropTemplate", -1)
  Craftie.Frame.Scroll.Recipes.List.Item[i]:SetWidth(Craftie.Frame.Scroll.Recipes_Width-26) --scrollbar size
  Craftie.Frame.Scroll.Recipes.List.Item[i]:SetHeight(20)
  Craftie.Frame.Scroll.Recipes.List.Item[i]:SetPoint("TOPLEFT", 2, -i*18)
  Craftie.Frame.Scroll.Recipes.List.Item[i]:SetBackdrop(Craftie.Backdrop.General)
  Craftie.Frame.Scroll.Recipes.List.Item[i]:SetBackdropBorderColor(1, 1, 1, 0)
  Craftie.Frame.Scroll.Recipes.List.Item[i]:SetFrameLevel(Craftie.Framelevel.Background)
  Craftie.Frame.Scroll.Recipes.List.Item[i]:SetBackdropColor(1, 1, 1, 0)

  Craftie.Frame.Scroll.Recipes.List.Text[i] = Craftie.Frame.Scroll.Recipes.List.Item[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.Scroll.Recipes.List.Text[i]:SetFont(Craftie._G.font, Craftie._G.fontSize, "OUTLINE")
  Craftie.Frame.Scroll.Recipes.List.Text[i]:SetPoint("TOPLEFT", 8, -5)
  Craftie.Frame.Scroll.Recipes.List.Text[i]:SetText("")
  Craftie.Frame.Scroll.Recipes.List.Text[i]:SetTextColor(1, 1, 1, 0.8)

  if (i % 2 == 0) then
    Craftie.Frame.Scroll.Recipes.List.Item[i]:SetBackdropColor(0.6, 0.7, 1, 0.1)
  end
  Craftie.Frame.Scroll.Recipes.List.Item[i]:SetScript("OnEnter", function(self)
    Craftie.Frame.Scroll.Recipes.List.Item[i]:SetBackdropColor(1, 1, 1, 0.2)
    Craftie.Frame.Scroll.Recipes.List.Text[i]:SetTextColor(1, 1, 0.8, 1)
  end)
  Craftie.Frame.Scroll.Recipes.List.Item[i]:SetScript("OnLeave", function(self)
    GameTooltip:Hide()
    Craftie.ClearSelectedItem("Recipes")
  end)
end


Craftie.Button={}
Craftie.Button.Frame={}

--Store/category-icon-book

--[==[
Craftie.Button.Frame= CreateFrame("Button", nil, Craftie.Frame, "BackdropTemplate")
Craftie.Button.Frame:SetSize(23, 23)
Craftie.Button.Frame:SetPoint("TOPRIGHT", -16, -2)
Craftie.Button.Frame:SetBackdrop(Craftie.Backdrop.General)
Craftie.Button.Frame:SetBackdropColor(0, 0, 0, 1)
Craftie.Button.Frame:SetBackdropBorderColor(1, 1, 1, 0.6)
]==]--
Craftie.Button.Frame = Craftie.Frame:CreateTexture(nil, "BORDER")
Craftie.Button.Frame:SetSize(30, 30)
Craftie.Button.Frame:SetPoint("TOPRIGHT", -23, 0)
Craftie.Button.Frame:SetTexture("Interface/DialogFrame/UI-DialogBox-Corner")

--Craftie.Button.Options= CreateFrame("Button", nil, Craftie.Frame, "BackdropTemplate")
Craftie.Button.Options= CreateFrame("Button", nil, Craftie.Frame, "UIPanelButtonTemplate")
Craftie.Button.Options:SetSize(24, 23)
Craftie.Button.Options:SetPoint("TOPRIGHT", -23, 1)
Craftie.Button.Options.icon = Craftie.Button.Options:CreateTexture(nil, "ARTWORK")
Craftie.Button.Options.icon:SetSize(12, 12)
Craftie.Button.Options.icon:SetPoint("CENTER", 0, 0)
Craftie.Button.Options.icon:SetTexture("Interface/Buttons/UI-OptionsButton")
Craftie.Button.Options:SetScript("OnEnter", function(self)
  --Craftie.TooltipDisplay(self, Craftie._G.title, Craftie.Addon)
end)
Craftie.Button.Options:SetScript("OnLeave", function(self)

end)
Craftie.Button.Options:SetScript("OnClick", function(self)
  Craftie.Frame:Hide()
  --Craftie.FrameOptions:Show()
end)
--UI-SquareButton-Up

Craftie.Button.Minimap={}
--Craftie.Button.Minimap.Border={}

Craftie.Button.Minimap = CreateFrame("Button", nil, Minimap)
Craftie.Button.Minimap:SetFrameLevel(499)
Craftie.Button.Minimap:SetFrameStrata("TOOLTIP")
Craftie.Button.Minimap:SetSize(32, 32)
Craftie.Button.Minimap:SetMovable(true)
Craftie.Button.Minimap:SetPoint("TOPRIGHT", -5, 0)
Craftie.Button.Minimap.Border = Craftie.Button.Minimap:CreateTexture(nil, "BORDER")
Craftie.Button.Minimap.Border:SetSize(Craftie.Button.Minimap:GetWidth()-4, Craftie.Button.Minimap:GetHeight()-4)
Craftie.Button.Minimap.Border:SetPoint("CENTER", 0, 0)
--Craftie.Button.Minimap.Icon:SetTexture("Interface/UNITPOWERBARALT/WowUI_Circular_Frame")
Craftie.Button.Minimap.Border:SetTexture("Interface/COMMON/ringborder")
Craftie.Button.Minimap.Border:SetDrawLayer("BORDER", 6)
Craftie.Button.Minimap.BorderBG = Craftie.Button.Minimap:CreateTexture(nil, "BORDER")
Craftie.Button.Minimap.BorderBG:SetSize(Craftie.Button.Minimap:GetWidth()-4, Craftie.Button.Minimap:GetHeight()-4)
Craftie.Button.Minimap.BorderBG:SetPoint("CENTER", 0, 0)
Craftie.Button.Minimap.BorderBG:SetTexture(Craftie._G.dir .. "images/icon_default.tga")
Craftie.Button.Minimap.Border:SetDrawLayer("BORDER", 4)
Craftie.Button.Minimap.BorderOn = Craftie.Button.Minimap:CreateTexture(nil, "ARTWORK")
Craftie.Button.Minimap.BorderOn:SetSize(Craftie.Button.Minimap:GetWidth()+24, Craftie.Button.Minimap:GetHeight()+24)
Craftie.Button.Minimap.BorderOn:SetPoint("CENTER", 0, 0)
Craftie.Button.Minimap.BorderOn:SetTexture("Interface/COMMON/portrait-ring-withbg-highlight")
Craftie.Button.Minimap.BorderOn:SetAlpha(0.6)
Craftie.Button.Minimap.BorderOn:Hide()

Craftie.Button.Minimap:RegisterForDrag("LeftButton")
Craftie.Button.Minimap:SetScript("OnDragStart", function()
    Craftie.Button.Minimap:StartMoving()
    Craftie.Button.Minimap:SetScript("OnUpdate", Craftie.UpdateMapButton)
end)
Craftie.Button.Minimap:SetScript("OnDragStop", function()
    Craftie.Button.Minimap:StopMovingOrSizing()
    Craftie.Button.Minimap:SetScript("OnUpdate", nil)
		Craftie.SaveMapButtonPos()
end)

Craftie.Button.Minimap:SetScript("OnEnter", function(self)
  GameTooltip:SetOwner(self, "ANCHOR_LEFT")
  GameTooltip:AddLine(Craftie._G.Stamp)
  GameTooltip:Show()
	Craftie.Button.Minimap.BorderOn:Show()
end)
Craftie.Button.Minimap:SetScript("OnLeave", function(self)
	--Craftie.CloseAllMenus()
  GameTooltip:Hide()
  Craftie.Button.Minimap.BorderOn:Hide()
end)

Craftie.Button.Minimap:SetScript("OnClick", function()
  Craftie.Frame:Show()
  PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
end)
