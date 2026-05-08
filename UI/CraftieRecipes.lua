
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

Craftie.Frame.ScrollParentRecipes = CreateFrame("Frame", Craftie.Frame.ScrollMain, Craftie.Frame, "InsetFrameTemplate")
Craftie.Frame.ScrollParentRecipes:SetWidth(300)
Craftie.Frame.ScrollParentRecipes:SetHeight(Craftie._G.Height-88)
Craftie.Frame.ScrollParentRecipes:SetPoint("TOPLEFT", 212, -61)

Craftie.Frame.ScrollParentRecipes.Back = Craftie.Frame.ScrollParentRecipes:CreateTexture(nil, "BACKGROUND")
Craftie.Frame.ScrollParentRecipes.Back:SetSize(Craftie.Frame.ScrollParentRecipes:GetWidth()+166, Craftie.Frame.ScrollParentRecipes:GetHeight()+185)
Craftie.Frame.ScrollParentRecipes.Back:SetPoint("TOPLEFT", 6, -5)
Craftie.Frame.ScrollParentRecipes.Back:SetTexture("Interface/QUESTFRAME/QuestBookBG")

Craftie.Frame.ScrollRecipes_Width = 300
Craftie.Frame.ScrollRecipes_Height= Craftie._G.Height-90
Craftie.Frame.ScrollRecipes = CreateFrame("Frame", nil, Craftie.Frame.ScrollParentRecipes)

Craftie.Frame.ScrollRecipes:SetWidth(Craftie.Frame.ScrollRecipes_Width)
Craftie.Frame.ScrollRecipes:SetHeight(Craftie.Frame.ScrollRecipes_Height)
Craftie.Frame.ScrollRecipes:SetPoint("TOPLEFT", 0, 0)

Craftie.Frame.ScrollRecipesList = CreateFrame("Frame", Craftie.Frame.ScrollRecipesList, Craftie.Frame.ScrollRecipes, "BackdropTemplate")
Craftie.Frame.ScrollRecipesList:SetWidth(Craftie.Frame.ScrollRecipes_Width)
Craftie.Frame.ScrollRecipesList:SetHeight(Craftie.Frame.ScrollRecipes_Height)
Craftie.Frame.ScrollRecipesList:SetPoint("CENTER", 0, 0)
Craftie.Frame.ScrollRecipesList:SetBackdrop(Craftie.Backdrop.General)
--Craftie.Frame.ScrollRecipesList:SetBackdropColor(0.1, 0.6, 1, 0.1) --slight blue
Craftie.Frame.ScrollRecipesList:SetBackdropColor(0.1, 0.6, 1, 0) --slight blue
Craftie.Frame.ScrollRecipesList:SetBackdropBorderColor(1, 1, 1, 0)

Craftie.Frame.ScrollRecipesList.Child = CreateFrame("ScrollFrame", nil, Craftie.Frame.ScrollRecipesList, "UIPanelScrollFrameTemplate") -- "MinimalScrollBar"
--Craftie.Frame.ScrollRecipesList.Child = CreateFrame("ScrollFrame", nil, Craftie.Frame.ScrollRecipesList, "ScrollFrameTemplate")
--Craftie.Frame.ScrollRecipesList.Child:SetPoint("TOPLEFT", Craftie.Frame.ScrollRecipesList, "TOPLEFT", 3, -3)
Craftie.Frame.ScrollRecipesList.Child:SetPoint("TOPLEFT", Craftie.Frame.ScrollRecipesList, "TOPLEFT", 3, -30) --room for search bar
Craftie.Frame.ScrollRecipesList.Child:SetPoint("BOTTOMRIGHT", Craftie.Frame.ScrollRecipesList, "BOTTOMRIGHT", 10, 4)
Craftie.Frame.ScrollRecipesListChildFrame = CreateFrame("Frame", Craftie.Frame.ScrollRecipesListChildFrame, Craftie.Frame.ScrollRecipesList.Child)
Craftie.Frame.ScrollRecipesListChildFrame:SetSize(Craftie.Frame.ScrollRecipes_Width, Craftie.Frame.ScrollRecipes_Height)
Craftie.Frame.ScrollRecipesList.Child:SetScrollChild(Craftie.Frame.ScrollRecipesListChildFrame)
Craftie.Frame.ScrollRecipesList.Child.ScrollBar:ClearAllPoints()
--Craftie.Frame.ScrollRecipesList.Child.ScrollBar:SetPoint("TOPLEFT", Craftie.Frame.ScrollRecipesList.Child, "TOPRIGHT", 0, -17)
Craftie.Frame.ScrollRecipesList.Child.ScrollBar:SetPoint("TOPLEFT", Craftie.Frame.ScrollRecipesList.Child, "TOPRIGHT", 0, 10) --room for search bar
Craftie.Frame.ScrollRecipesList.Child.ScrollBar:SetPoint("BOTTOMRIGHT", Craftie.Frame.ScrollRecipesList.Child, "BOTTOMRIGHT", -42, 12)

Craftie.Frame.ScrollRecipes.Results = Craftie.Frame.ScrollRecipes:CreateFontString(nil, "ARTWORK")
Craftie.Frame.ScrollRecipes.Results:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
Craftie.Frame.ScrollRecipes.Results:SetPoint("BOTTOMLEFT", 8, -20)
Craftie.Frame.ScrollRecipes.Results:SetText("")

Craftie.Frame.ScrollRecipes.Empty = Craftie.Frame.ScrollRecipes:CreateFontString(nil, "ARTWORK")
Craftie.Frame.ScrollRecipes.Empty:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
Craftie.Frame.ScrollRecipes.Empty:SetPoint("CENTER", -10, 0)
Craftie.Frame.ScrollRecipes.Empty:SetTextColor(1, 1, 1, 0.6)
Craftie.Frame.ScrollRecipes.Empty:SetText("")

--[==[
SEARCH RECIPES
]==]--
Craftie.Frame.Search={}
Craftie.Frame.Search.Recipes={}
Craftie.Frame.Search.Recipes = CreateFrame("Frame", nil, Craftie.Frame.ScrollParentRecipes, "BackdropTemplate", 2)
Craftie.Frame.Search.Recipes:SetWidth(150)
Craftie.Frame.Search.Recipes:SetHeight(24)
Craftie.Frame.Search.Recipes:SetPoint("TOPLEFT", 2, -2)
Craftie.Frame.Search.Recipes:SetBackdrop(Craftie.Backdrop.Opaque)
Craftie.Frame.Search.Recipes:SetBackdropColor(1, 0, 0, 1)
Craftie.Frame.Search.Recipes:SetBackdropBorderColor(1, 1, 1, 0.6)
Craftie.Frame.Search.Recipes:SetFrameStrata("MEDIUM")
--Craftie.Frame.Search.Recipes:SetFrameLevel(Craftie.Framelevel.Foreground)
Craftie.Frame.Search.Recipes.Text = CreateFrame("EditBox", nil, Craftie.Frame.Search.Recipes)
Craftie.Frame.Search.Recipes.Text:SetWidth(Craftie.Frame.Search.Recipes:GetWidth()-8)
Craftie.Frame.Search.Recipes.Text:SetHeight(Craftie.Frame.Search.Recipes:GetHeight())
Craftie.Frame.Search.Recipes.Text:SetFontObject(GameFontDisable)
Craftie.Frame.Search.Recipes.Text:SetFont(Craftie._G.Font.Style, 11, "OUTLINE")
Craftie.Frame.Search.Recipes.Text:SetPoint("TOPLEFT", 6, 0)
Craftie.Frame.Search.Recipes.Text:SetAutoFocus(false)
Craftie.Frame.Search.Recipes.Text:SetText(Craftie.Placeholder_Recipes)
Craftie.Frame.Search.Recipes.Text:SetScript("OnKeyUp", function(self, key)
  if (key == "ENTER") then
    local search_array = Craftie.Profession.Query
    local search_index = Craftie.Frame.Search.Recipes.Text:GetText()
    Craftie.OpenProfessionList(search_array, search_index)
    --Craftie.ClearFocusAll()
    Craftie.Frame.ScrollRecipesList.Child:SetVerticalScroll(1)
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

--[==[
Craftie.Frame.Button.Search.Recipes = CreateFrame("Button", nil, Craftie.Frame.Search.Recipes, "UIPanelButtonTemplate")
Craftie.Frame.Button.Search.Recipes:SetSize(24, 23)
Craftie.Frame.Button.Search.Recipes:SetPoint("TOPRIGHT", 25, 1)
Craftie.Frame.Button.Search.RecipesIcon = Craftie.Frame.Button.Search.Recipes:CreateTexture(nil, "ARTWORK")
Craftie.Frame.Button.Search.RecipesIcon:SetSize(12, 12)
Craftie.Frame.Button.Search.RecipesIcon:SetPoint("CENTER", 0, 0)
Craftie.Frame.Button.Search.RecipesIcon:SetTexture("Interface/Buttons/UI-OptionsButton")
Craftie.Frame.Button.Search.Recipes:SetScript("OnEnter", function(self)

end)

Craftie.Frame.Button.Search.Recipes:SetScript("OnLeave", function(self)

end)

Craftie.Frame.Button.Search.Recipes:SetScript("OnClick", function(self)

end)
]==]--

--[==[
CRAFT ITEM
]==]--

Craftie.Frame.CraftParent={}
Craftie.Frame.CraftParent= CreateFrame("Frame", Craftie.Frame.CraftParent, Craftie.Frame, "InsetFrameTemplate")
Craftie.Frame.CraftParent:SetWidth(300)
Craftie.Frame.CraftParent:SetHeight(Craftie._G.Height-88)
Craftie.Frame.CraftParent:SetPoint("TOPRIGHT", -8, -61)

Craftie.Frame.Craft = {}
Craftie.Frame.Craft = CreateFrame("Frame", Craftie.Frame.Craft, Craftie.Frame.CraftParent, "BackdropTemplate")
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
Craftie.Frame.Craft.Text:SetFont(Craftie._G.Font.Style, 12, "SLUG")
Craftie.Frame.Craft.Text:SetPoint("TOPLEFT", 40, -10)
Craftie.Frame.Craft.Text:SetText("")
--designed to mask over the entire craft frame
Craftie.Frame.Craft.HLink = Craftie.Frame.Craft:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Craft.HLink:SetFont(Craftie._G.Font.Style, 20, "SLUG")
Craftie.Frame.Craft.HLink:SetPoint("TOPLEFT", -4, -8)
Craftie.Frame.Craft.HLink:SetText("")
Craftie.Frame.Craft.HLink:SetScript("OnLeave", function(self)
  GameTooltip:Hide()
end)
Craftie.Frame.Craft.ID = Craftie.Frame.Craft:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Craft.ID:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
Craftie.Frame.Craft.ID:SetPoint("CENTER", 10, 0)
Craftie.Frame.Craft.ID:SetText("")
Craftie.Frame.Craft.ID:SetTextColor(1, 1, 1, 0)

Craftie.Frame.Craft.SkillIcon = Craftie.Frame.Craft:CreateTexture(nil, "ARTWORK")
Craftie.Frame.Craft.SkillIcon:SetSize(13, 13)
Craftie.Frame.Craft.SkillIcon:SetPoint("BOTTOMLEFT", 0, -154)
Craftie.Frame.Craft.SkillIcon:SetTexture("Interface/Icons/inv_misc_questionmark")
Craftie.Frame.Craft.SkillIcon:Hide()
Craftie.Frame.Craft.Skill = Craftie.Frame.Craft:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Craft.Skill:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
Craftie.Frame.Craft.Skill:SetPoint("BOTTOMLEFT", 15, -152)
Craftie.Frame.Craft.Skill:SetText("")
Craftie.Frame.Craft.Skill:SetTextColor(1, 1, 1, 0.7)
Craftie.Frame.Craft.Skill:Hide()
Craftie.Frame.Craft.SourceTitle = Craftie.Frame.Craft:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Craft.SourceTitle:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
Craftie.Frame.Craft.SourceTitle:SetPoint("BOTTOMLEFT", 15, -168)
Craftie.Frame.Craft.SourceTitle:SetText("Sources:")
Craftie.Frame.Craft.SourceTitle:SetTextColor(1, 1, 1, 1)
Craftie.Frame.Craft.SourceTitle:Hide()
Craftie.Frame.Craft.Source = Craftie.Frame.Craft:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Craft.Source:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
Craftie.Frame.Craft.Source:SetPoint("BOTTOMLEFT", 65, -168)
Craftie.Frame.Craft.Source:SetText("")
Craftie.Frame.Craft.Source:SetTextColor(1, 1, 1, 0.8)
Craftie.Frame.Craft.Source:Hide()

Craftie.Frame.Craft.Back = Craftie.Frame.CraftParent:CreateTexture(nil, "BACKGROUND")
Craftie.Frame.Craft.Back:SetSize(300, 110)
Craftie.Frame.Craft.Back:SetPoint("BOTTOMRIGHT", 0, 0)
Craftie.Frame.Craft.Back:SetHorizTile(true)
--Craftie.Frame.Craft.Back:SetTexture("Interface/FrameGeneral/UI-Background-Rock", "REPEAT")
Craftie.Frame.Craft.Back:SetTexture("Interface/Garrison/GarrisonMissionUIInfoBoxBackgroundTile", "REPEAT")

Craftie.Frame.Craft.Divider = Craftie.Frame.CraftParent:CreateTexture(nil, "ARTWORK")
Craftie.Frame.Craft.Divider:SetSize(400, 24)
Craftie.Frame.Craft.Divider:SetPoint("BOTTOMRIGHT", 98, 90)
Craftie.Frame.Craft.Divider:SetTexture("Interface/DialogFrame/UI-DialogBox-Divider")

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
  Craftie.Frame.Reagent.Main[i] = CreateFrame("Frame", Craftie.Frame.Reagent.Main[i], Craftie.Frame.CraftParent, "BackdropTemplate")
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
  Craftie.Frame.Reagent.Text[i]:SetFont(Craftie._G.Font.Style, 10, "SLUG")
  Craftie.Frame.Reagent.Text[i]:SetPoint("TOPLEFT", 2, -6)
  Craftie.Frame.Reagent.Text[i]:SetText(i)
  Craftie.Frame.Reagent.Text[i]:SetWidth(Craftie.Frame.Reagent_Width-10)
  Craftie.Frame.Reagent.Text[i]:SetHeight(Craftie.Frame.Reagent_Height-10)
  Craftie.Frame.Reagent.Text[i]:SetWordWrap(true)
  Craftie.Frame.Reagent.Text[i]:SetTextColor(1, 1, 1, 0.8)
  Craftie.Frame.Reagent.Data[i] = Craftie.Frame.Reagent.Main[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.Reagent.Data[i]:SetFont(Craftie._G.Font.Style, 10, "SLUG")
  --Craftie.Frame.Reagent.Data[i]:SetPoint("TOPLEFT", 0, 0)
  Craftie.Frame.Reagent.Data[i]:SetText(i)
  Craftie.Frame.Reagent.QuanI[i] = Craftie.Frame.Reagent.Main[i]:CreateFontString(nil, "OVERLAY")
  Craftie.Frame.Reagent.QuanI[i]:SetFont(Craftie._G.Font.Style, 11, "SLUG")
  Craftie.Frame.Reagent.QuanI[i]:SetPoint("TOPLEFT", -27, -20)
  Craftie.Frame.Reagent.QuanI[i]:SetText("3")
  Craftie.Frame.Reagent.Dash[i] = Craftie.Frame.Reagent.Main[i]:CreateFontString(nil, "OVERLAY")
  Craftie.Frame.Reagent.Dash[i]:SetFont(Craftie._G.Font.Style, 12, "SLUG")
  Craftie.Frame.Reagent.Dash[i]:SetPoint("TOPLEFT", -19, -20)
  Craftie.Frame.Reagent.Dash[i]:SetText("/")
  Craftie.Frame.Reagent.QuanR[i] = Craftie.Frame.Reagent.Main[i]:CreateFontString(nil, "OVERLAY")
  Craftie.Frame.Reagent.QuanR[i]:SetFont(Craftie._G.Font.Style, 11, "SLUG")
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

Craftie.Frame.ScrollRecipesList.Item={}
Craftie.Frame.ScrollRecipesList.Text={}
for i=1, Craftie.MAX_RECIPES do
  Craftie.Frame.ScrollRecipesList.Item[i] = CreateFrame("Button", Craftie.Frame.ScrollRecipesList.Item[i], Craftie.Frame.ScrollRecipesListChildFrame, "BackdropTemplate", -1)
  Craftie.Frame.ScrollRecipesList.Item[i]:SetWidth(Craftie.Frame.ScrollRecipes_Width-26) --scrollbar size
  Craftie.Frame.ScrollRecipesList.Item[i]:SetHeight(20)
  Craftie.Frame.ScrollRecipesList.Item[i]:SetPoint("TOPLEFT", 2, -i*18)
  Craftie.Frame.ScrollRecipesList.Item[i]:SetBackdrop(Craftie.Backdrop.General)
  Craftie.Frame.ScrollRecipesList.Item[i]:SetBackdropBorderColor(1, 1, 1, 0)
  Craftie.Frame.ScrollRecipesList.Item[i]:SetFrameLevel(Craftie.Framelevel.Background)
  Craftie.Frame.ScrollRecipesList.Item[i]:SetBackdropColor(1, 1, 1, 0)

  Craftie.Frame.ScrollRecipesList.Text[i] = Craftie.Frame.ScrollRecipesList.Item[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.ScrollRecipesList.Text[i]:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
  Craftie.Frame.ScrollRecipesList.Text[i]:SetPoint("TOPLEFT", 8, -5)
  Craftie.Frame.ScrollRecipesList.Text[i]:SetText("")
  Craftie.Frame.ScrollRecipesList.Text[i]:SetTextColor(1, 1, 1, 0.8)

  if (i % 2 == 0) then
    Craftie.Frame.ScrollRecipesList.Item[i]:SetBackdropColor(0.6, 0.7, 1, 0.1)
  end
  Craftie.Frame.ScrollRecipesList.Item[i]:SetScript("OnEnter", function(self)
    Craftie.Frame.ScrollRecipesList.Item[i]:SetBackdropColor(1, 1, 1, 0.2)
    Craftie.Frame.ScrollRecipesList.Text[i]:SetTextColor(1, 1, 0.8, 1)
  end)
  Craftie.Frame.ScrollRecipesList.Item[i]:SetScript("OnLeave", function(self)
    GameTooltip:Hide()
    Craftie.ClearSelectedItem("Recipes")
  end)
end
