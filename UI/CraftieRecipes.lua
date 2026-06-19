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

Craftie.Frame.ScrollRecipes_Width = 294
Craftie.Frame.ScrollRecipes_Height= Craftie._G.Height-158

Craftie.Frame.ScrollRecipesParent = CreateFrame("Frame", "Craftie.Frame.ScrollRecipesParent", Craftie.Frame, "InsetFrameTemplate")
Craftie.Frame.ScrollRecipesParent:SetWidth(Craftie.Frame.ScrollRecipes_Width)
Craftie.Frame.ScrollRecipesParent:SetHeight(Craftie._G.Height-88)
Craftie.Frame.ScrollRecipesParent:SetPoint("TOPLEFT", 216, -62)
Craftie.Frame.ScrollRecipesParent:SetFrameStrata("MEDIUM")

Craftie.Frame.ScrollRecipesParent.Back = Craftie.Frame.ScrollRecipesParent:CreateTexture(nil, "BACKGROUND")
Craftie.Frame.ScrollRecipesParent.Back:SetSize(Craftie.Frame.ScrollRecipesParent:GetWidth()-20, Craftie.Frame.ScrollRecipesParent:GetHeight())
Craftie.Frame.ScrollRecipesParent.Back:SetPoint("TOPLEFT", 0, 0)
Craftie.Frame.ScrollRecipesParent.Back:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Background-Recipes.png")

Craftie.Frame.ScrollRecipesList = CreateFrame("Frame", "Craftie.Frame.ScrollRecipesList", Craftie.Frame.ScrollRecipesParent, "BackdropTemplate")
Craftie.Frame.ScrollRecipesList:SetWidth(Craftie.Frame.ScrollRecipes_Width-10)
Craftie.Frame.ScrollRecipesList:SetHeight(Craftie.Frame.ScrollRecipes_Height+20)
Craftie.Frame.ScrollRecipesList:SetPoint("CENTER", 2, -6)

Craftie.Frame.ScrollRecipesList.Child = CreateFrame("ScrollFrame", Craftie.Frame.ScrollRecipesList.Child, Craftie.Frame.ScrollRecipesList, "UIPanelScrollFrameTemplate")
Craftie.Frame.ScrollRecipesList.Child:SetPoint("TOPLEFT", Craftie.Frame.ScrollRecipesList, "TOPLEFT",         -2,-20)
Craftie.Frame.ScrollRecipesList.Child:SetPoint("BOTTOMRIGHT", Craftie.Frame.ScrollRecipesList, "BOTTOMRIGHT", 14, 10)
Craftie.Frame.ScrollRecipesListChildFrame = CreateFrame("Frame", "Craftie.Frame.ScrollRecipesListChildFrame", Craftie.Frame.ScrollRecipesList.Child)
Craftie.Frame.ScrollRecipesListChildFrame:SetSize(Craftie.Frame.ScrollRecipes_Width, Craftie.Frame.ScrollRecipes_Height)
Craftie.Frame.ScrollRecipesList.Child:SetScrollChild(Craftie.Frame.ScrollRecipesListChildFrame)
Craftie.Frame.ScrollRecipesList.Child.ScrollBar:ClearAllPoints()
Craftie.Frame.ScrollRecipesList.Child.ScrollBar:SetPoint("TOPLEFT", Craftie.Frame.ScrollRecipesList.Child, "TOPRIGHT",          0,-10)
Craftie.Frame.ScrollRecipesList.Child.ScrollBar:SetPoint("BOTTOMRIGHT", Craftie.Frame.ScrollRecipesList.Child, "BOTTOMRIGHT", -42, 10)

Craftie:ScrollBarFrame(Craftie.Frame.ScrollRecipesList.Child)

Craftie.Frame.ScrollRecipesResultsFrame = CreateFrame("Frame", "Craftie.Frame.ScrollRecipesResultsFrame", Craftie.Frame.ScrollRecipesParent, "BackdropTemplate", 25)
Craftie.Frame.ScrollRecipesResultsFrame:SetWidth(Craftie.Frame.ScrollRecipes_Width-6)
Craftie.Frame.ScrollRecipesResultsFrame:SetHeight(25)
Craftie.Frame.ScrollRecipesResultsFrame:SetPoint("BOTTOMLEFT", 3, 0)
Craftie.Frame.ScrollRecipesResultsFrame:SetFrameLevel(50)
Craftie.Frame.ScrollRecipesResultsBack = Craftie.Frame.ScrollRecipesResultsFrame:CreateTexture(nil, "ARTWORK")
Craftie.Frame.ScrollRecipesResultsBack:SetSize(Craftie.Frame.ScrollRecipesResultsFrame:GetWidth(), 32)
Craftie.Frame.ScrollRecipesResultsBack:SetPoint("TOPLEFT", 0, 10)
Craftie.Frame.ScrollRecipesResultsBack:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Footer-32.png")
Craftie.Frame.ScrollRecipesResults = Craftie.Frame.ScrollRecipesResultsFrame:CreateFontString(nil, "ARTWORK")
Craftie.Frame.ScrollRecipesResults:SetFont(Craftie._G.Font.StyleN, Craftie._G.Font.Size+2, "SLUG")
Craftie.Frame.ScrollRecipesResults:SetPoint("TOPLEFT", 8, -4)
Craftie.Frame.ScrollRecipesResults:SetText("")

Craftie.Frame.ScrollRecipesLoading = Craftie.Frame.ScrollRecipesParent:CreateFontString(nil, "OVERLAY")
Craftie.Frame.ScrollRecipesLoading:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size+2, "OUTLINE | SLUG")
Craftie.Frame.ScrollRecipesLoading:SetPoint("CENTER", -2, 40)
Craftie.Frame.ScrollRecipesLoading:SetTextColor(1, 1, 0.9, 0.8)
Craftie.Frame.ScrollRecipesLoading:SetText("Loading...")

Craftie.Frame.ScrollRecipesEmpty = Craftie.Frame.ScrollRecipesParent:CreateFontString(nil, "OVERLAY")
Craftie.Frame.ScrollRecipesEmpty:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "OUTLINE | SLUG")
Craftie.Frame.ScrollRecipesEmpty:SetPoint("CENTER", -10, 0)
Craftie.Frame.ScrollRecipesEmpty:SetTextColor(1, 1, 1, 0.8)
Craftie.Frame.ScrollRecipesEmpty:SetText("")
Craftie.Frame.ScrollRecipesEmpty:Hide()

Craftie.MenuSelRecipes = {"Search All Crafter Recipes"}
Craftie.Frame.DropdownRecipes={}
Craftie.Frame.DropdownRecipes = CreateFrame("Frame", "Craftie.Frame.DropdownRecipes", Craftie.Frame.ScrollPlayersParent, "UIDropDownMenuTemplate")
Craftie.Frame.DropdownRecipes:SetPoint("TOPLEFT", 198, -1)
Craftie.Frame.DropdownRecipes.displayMode = "MENU"
--Craftie.Frame.DropdownRecipes:SetBackdrop(Craftie.Backdrop.Borderless)
--Craftie.Frame.DropdownRecipes:SetBackdropBorderColor(1, 1, 1, 0)
Craftie.Frame.DropdownRecipes.text = Craftie.Frame.DropdownRecipes:CreateFontString(nil, "ARTWORK")
Craftie.Frame.DropdownRecipes.text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "OUTLINE | SLUG")
Craftie.Frame.DropdownRecipes.text:SetPoint("TOPLEFT", Craftie.Frame.DropdownRecipes, "TOPLEFT", 25, -8)
Craftie.Frame.DropdownRecipes.text:SetText(Craftie.MenuSelRecipes[1])
Craftie.Frame.DropdownRecipes.OnClick = function(self, checked)
  Craftie.Frame.DropdownRecipes.text:SetText(Craftie.MenuSelRecipes[self.value])
  print(self.value)
end
UIDropDownMenu_SetWidth(Craftie.Frame.DropdownRecipes, Craftie.Frame.ScrollRecipes_Width-22)
UIDropDownMenu_Initialize(Craftie.Frame.DropdownRecipes, function(self, level)
  local info = UIDropDownMenu_CreateInfo()
  for k,v in pairs(Craftie.MenuSelRecipes) do
    --info.notCheckable = 1
    info.padding = 2
    info.text = v
    info.value= k
    info.justifyH = "LEFT"
    info.disabled = false
    info.func = self.OnClick
    UIDropDownMenu_AddButton(info, level)
  end
end)
_G[Craftie.Frame.DropdownRecipes:GetName() .. "Left"]:Hide()
_G[Craftie.Frame.DropdownRecipes:GetName() .. "Middle"]:Hide()
_G[Craftie.Frame.DropdownRecipes:GetName() .. "Right"]:Hide()
Craftie.Frame.DropdownRecipes.Back = Craftie.Frame.DropdownRecipes:CreateTexture(nil, "BORDER")
Craftie.Frame.DropdownRecipes.Back:SetSize(Craftie.Frame.ScrollRecipes_Width-5, 28)
Craftie.Frame.DropdownRecipes.Back:SetPoint("TOPLEFT", 16, -4)
Craftie.Frame.DropdownRecipes.Back:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Dropdown-32.png")

--[==[
SEARCH RECIPES
]==]--
Craftie.Frame.Search.Recipes={}
Craftie.Frame.Search.Recipes = CreateFrame("Frame", "Craftie.Frame.Search.Recipes", Craftie.Frame.ScrollRecipesParent, "BackdropTemplate")
Craftie.Frame.Search.Recipes:SetWidth(Craftie.Frame.ScrollRecipes_Width-5)
Craftie.Frame.Search.Recipes:SetHeight(24)
Craftie.Frame.Search.Recipes:SetPoint("TOPLEFT", 2, -25)
--Craftie.Frame.Search.Recipes:SetBackdrop(Craftie.Backdrop.Opaque)
--Craftie.Frame.Search.Recipes:SetBackdropColor(0, 0, 0, 1)
--Craftie.Frame.Search.Recipes:SetBackdropBorderColor(1, 1, 1, 0.5)
Craftie.Frame.Search.Recipes:SetFrameLevel(50)

--Craftie.Frame.Search.Recipes:Hide()

Craftie.Frame.Search.Recipes.Back = Craftie.Frame.Search.Recipes:CreateTexture(nil, "ARTWORK")
Craftie.Frame.Search.Recipes.Back:SetSize(Craftie.Frame.Search.Recipes:GetWidth(), 28)
Craftie.Frame.Search.Recipes.Back:SetPoint("TOPLEFT", 0, -2)
Craftie.Frame.Search.Recipes.Back:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Search-32.png")
--Craftie.Frame.Search.Recipes.Back:SetRotation(-math.pi)
--Craftie.Frame.Search.Recipes.Back:SetAlpha(0.8)

Craftie.Frame.Search.Recipes.Icon = Craftie.Frame.Search.Recipes:CreateTexture(nil, "OVERLAY")
Craftie.Frame.Search.Recipes.Icon:SetSize(18, 18)
Craftie.Frame.Search.Recipes.Icon:SetPoint("TOPLEFT", 4, -4)
Craftie.Frame.Search.Recipes.Icon:SetTexture("Interface/COMMON/UI-Searchbox-Icon")
Craftie.Frame.Search.Recipes.Icon:SetAlpha(0.3)
Craftie.Frame.Search.Recipes.Text = CreateFrame("EditBox", nil, Craftie.Frame.Search.Recipes)
Craftie.Frame.Search.Recipes.Text:SetWidth(Craftie.Frame.Search.Recipes:GetWidth()-52)
Craftie.Frame.Search.Recipes.Text:SetHeight(Craftie.Frame.Search.Recipes:GetHeight())
Craftie.Frame.Search.Recipes.Text:SetFontObject(GameFontDisable)
Craftie.Frame.Search.Recipes.Text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "OUTLINE")
Craftie.Frame.Search.Recipes.Text:SetPoint("TOPLEFT", 22, 0)
Craftie.Frame.Search.Recipes.Text:SetAutoFocus(false)
Craftie.Frame.Search.Recipes.Text:SetText(Craftie.Placeholder_Recipes)
Craftie.Frame.Search.Recipes.Text:SetScript("OnKeyUp", function(self, key)
  if (key == "ENTER") then
    local search_array = Craftie.ProfessionDefault --what player is selected?
    local search_index = self:GetText()
    if (Craftie.Selected_Name ~= "") then
      Craftie:OpenProfessionList(search_array, search_index, Craftie.Selected_Name)
    else
      print("search library within " .. Craftie.Page)
      Craftie:OpenProfessionList(search_array, search_index, "")
    end

    Craftie.Frame.ScrollRecipesList.Child:SetVerticalScroll(1)
  end
end)
Craftie.Frame.Search.Recipes.Text:SetScript("OnMouseDown", function(self)
    local search_index = self:GetText()
    if (search_index == Craftie.Placeholder_Recipes) then
      self:SetText("")
      self:SetFontObject(GameFontWhite)
    end
end)
Craftie.Frame.Search.Recipes.Text:SetScript("OnEditFocusLost", function(self)
  --Craftie.Frame.Search.Recipes.Text:SetText(Craftie.Placeholder_Recipes)
end)
Craftie.Frame.Button.SearchRecipesClear = CreateFrame("Button", nil, Craftie.Frame.Search.Recipes, "BackdropTemplate")
Craftie.Frame.Button.SearchRecipesClear:SetSize(24, 23)
Craftie.Frame.Button.SearchRecipesClear:SetPoint("TOPLEFT", Craftie.Frame.Search.Recipes:GetWidth()-24, -1)
Craftie.Frame.Button.SearchRecipesClearIcon = Craftie.Frame.Button.SearchRecipesClear:CreateTexture(nil, "ARTWORK")
Craftie.Frame.Button.SearchRecipesClearIcon:SetSize(18, 18)
Craftie.Frame.Button.SearchRecipesClearIcon:SetPoint("CENTER", 0, 0)
Craftie.Frame.Button.SearchRecipesClearIcon:SetTexture(Craftie._G.Path ..  "Images/UI-Craftie-Button-Search-Clear.png")
Craftie.Frame.Button.SearchRecipesClearIcon:SetAlpha(0.4)
Craftie.Frame.Button.SearchRecipesClear:SetScript("OnClick", function(self)
  Craftie.Frame.Search.Recipes.Text:SetText("")
  Craftie:CloseAllPlayerMenus()
  Craftie:UpdateCrafterList()
  Craftie:SelectCrafter(1, "")
end)
Craftie.Frame.Button.SearchRecipesClear:SetScript("OnEnter", function(self)
  Craftie.Frame.Button.SearchRecipesClearIcon:SetAlpha(0.8)
end)
Craftie.Frame.Button.SearchRecipesClear:SetScript("OnLeave", function(self)
  Craftie.Frame.Button.SearchRecipesClearIcon:SetAlpha(0.4)
end)

--[==[
CRAFT FRAME
]==]--
Craftie.Frame.CraftParent={}
Craftie.Frame.CraftParent= CreateFrame("Frame", "Craftie.Frame.CraftParent", Craftie.Frame, "BackdropTemplate")
Craftie.Frame.CraftParent:SetWidth(300)
Craftie.Frame.CraftParent:SetHeight(Craftie._G.Height-88)
--Craftie.Frame.CraftParent:SetHeight(180)
Craftie.Frame.CraftParent:SetPoint("TOPRIGHT", -8, -62)
Craftie.Frame.CraftParent:SetFrameStrata("MEDIUM")

Craftie.Frame.CraftBackTop={}
Craftie.Frame.CraftBackTop= CreateFrame("Frame", "Craftie.Frame.CraftBackTop", Craftie.Frame.CraftParent, "InsetFrameTemplate4")
Craftie.Frame.CraftBackTop:SetWidth(300)
Craftie.Frame.CraftBackTop:SetHeight(190)
Craftie.Frame.CraftBackTop:SetPoint("TOPRIGHT", 0, 0)
Craftie.Frame.CraftBackTopArt = Craftie.Frame.CraftParent:CreateTexture(nil, "BACKGROUND")
Craftie.Frame.CraftBackTopArt:SetWidth(Craftie.Frame.CraftBackTop:GetWidth()-6)
Craftie.Frame.CraftBackTopArt:SetHeight(Craftie.Frame.CraftBackTop:GetHeight()-6)
Craftie.Frame.CraftBackTopArt:SetPoint("TOPLEFT", 2, -4)
Craftie.Frame.CraftBackTopArt:SetTexture(Craftie._G.Path .. "Images/professionbackgroundartalchemy.png")
Craftie.Frame.CraftBackTopArt:SetVertexColor(.8, .8, .8) --darker
Craftie.Frame.CraftBackTopArt:SetDesaturation(0.3)

Craftie.Frame.Craft = {}
Craftie.Frame.Craft = CreateFrame("Frame", "Craftie.Frame.Craft", Craftie.Frame.CraftParent, "BackdropTemplate")
Craftie.Frame.Craft:SetWidth(220)
Craftie.Frame.Craft:SetHeight(35)
Craftie.Frame.Craft:SetPoint("TOPLEFT", 14, -20)
Craftie.Frame.Craft:SetBackdrop(Craftie.Backdrop.General)
Craftie.Frame.Craft:SetBackdropColor(0, 1, 0, 0)
Craftie.Frame.Craft:SetBackdropBorderColor(1, 1, 1, 0)
Craftie.Frame.Craft:SetHyperlinksEnabled(true)
Craftie.Frame.Craft:SetScript("OnHyperlinkClick", function(self, link, text, button)
  if (Craftie.EnableScrollFrames) then
    SetItemRef(link, text, button, self)
    ItemRefTooltip:Hide()
  end
end)
Craftie.Frame.Craft:Hide()

--[==[
CRAFT MAIN ITEM
]==]--
Craftie.Frame.Craft.Back = Craftie.Frame.Craft:CreateTexture(nil, "BACKGROUND")
Craftie.Frame.Craft.Back:SetSize(310, 50)
Craftie.Frame.Craft.Back:SetPoint("TOPLEFT", -4, 6)
Craftie.Frame.Craft.Back:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Craft-Toast.png")

Craftie.Frame.Craft.Icon = Craftie.Frame.Craft:CreateTexture(nil, "ARTWORK")
Craftie.Frame.Craft.Icon:SetSize(35, 35)
Craftie.Frame.Craft.Icon:SetPoint("TOPLEFT", 0, 0)
Craftie.Frame.Craft.Icon:SetTexture("Interface/Icons/inv_misc_questionmark")
Craftie.Frame.Craft.Icon:SetMask("Interface/Masks/CircleMaskScalable")
Craftie.Frame.Craft.Icon:Hide()
Craftie.Frame.Craft.Border = Craftie.Frame.Craft:CreateTexture(nil, "OVERLAY")
Craftie.Frame.Craft.Border:SetSize(75, 75)
Craftie.Frame.Craft.Border:SetPoint("CENTER", -92, 0)
Craftie.Frame.Craft.Border:SetTexture("Interface/UNITPOWERBARALT/WowUI_Circular_Frame")
Craftie.Frame.Craft.Border:SetVertexColor(0.48, 0.48, 0.48)
Craftie.Frame.Craft.Glow = Craftie.Frame.Craft:CreateTexture(nil, "BORDER")
Craftie.Frame.Craft.Glow:SetSize(75, 75)
Craftie.Frame.Craft.Glow:SetPoint("CENTER", -92, 0)
Craftie.Frame.Craft.Glow:SetTexture("Interface/UNITPOWERBARALT/PandarenTraining_Circular_Flash")
Craftie.Frame.Craft.Glow:SetBlendMode("ADD")

Craftie.Frame.Craft.Text = Craftie.Frame.Craft:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Craft.Text:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size+1, "SLUG")
Craftie.Frame.Craft.Text:SetPoint("TOPLEFT", 45, -6)
--Craftie.Frame.Craft.Text:SetPoint("TOPLEFT", 45, -12)
Craftie.Frame.Craft.Text:SetWidth(200)
Craftie.Frame.Craft.Text:SetJustifyV("TOP")
Craftie.Frame.Craft.Text:SetJustifyH("LEFT")
Craftie.Frame.Craft.Text:SetWordWrap(true)
Craftie.Frame.Craft.Text:SetText("")
--designed to mask over the entire craft frame
Craftie.Frame.Craft.HLink = Craftie.Frame.Craft:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Craft.HLink:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size+9, "SLUG")
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

Craftie.Frame.CraftBackMid={}
Craftie.Frame.CraftBackMid= CreateFrame("Frame", "Craftie.Frame.CraftBackMid", Craftie.Frame.CraftParent, "InsetFrameTemplate3")
Craftie.Frame.CraftBackMid:SetWidth(300)
Craftie.Frame.CraftBackMid:SetHeight(50)
Craftie.Frame.CraftBackMid:SetPoint("TOPRIGHT", 0, -194)
--Craftie.Frame.CraftBackMid:SetFrameStrata("MEDIUM")

Craftie.Frame.Craft.SkillIcon = Craftie.Frame.CraftBackMid:CreateTexture(nil, "ARTWORK")
Craftie.Frame.Craft.SkillIcon:SetSize(13, 13)
Craftie.Frame.Craft.SkillIcon:SetPoint("TOPLEFT", 10, -10)
Craftie.Frame.Craft.SkillIcon:SetTexture("Interface/Icons/inv_misc_questionmark")
Craftie.Frame.Craft.SkillIcon:Hide()
Craftie.Frame.Craft.SkillText = Craftie.Frame.CraftBackMid:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Craft.SkillText:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
Craftie.Frame.Craft.SkillText:SetPoint("TOPLEFT", 25, -10)
Craftie.Frame.Craft.SkillText:SetText("")
Craftie.Frame.Craft.SkillText:SetTextColor(1, 1, 1, 0.7)
Craftie.Frame.Craft.SkillText:Hide()
Craftie.Frame.Craft.SourceTitle = Craftie.Frame.CraftBackMid:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Craft.SourceTitle:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
Craftie.Frame.Craft.SourceTitle:SetPoint("TOPLEFT", 25, -28)
Craftie.Frame.Craft.SourceTitle:SetText("Sources:")
Craftie.Frame.Craft.SourceTitle:SetTextColor(1, 1, 1, 1)
Craftie.Frame.Craft.SourceTitle:Hide()
Craftie.Frame.Craft.SourceText = Craftie.Frame.CraftBackMid:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Craft.SourceText:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
Craftie.Frame.Craft.SourceText:SetPoint("TOPLEFT", 75, -28)
Craftie.Frame.Craft.SourceText:SetText("")
Craftie.Frame.Craft.SourceText:SetTextColor(1, 1, 1, 0.8)
Craftie.Frame.Craft.SourceText:Hide()

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
  Craftie.Frame.Reagent.Main[i] = CreateFrame("Frame", Craftie.Frame.Reagent.Main[i], Craftie.Frame.CraftParent, "BackdropTemplate")
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

Craftie.Frame.ScrollRecipesListItem={}
Craftie.Frame.ScrollRecipesListBack={}
Craftie.Frame.ScrollRecipesListText={}
Craftie.Frame.ScrollRecipesListSelect={}
Craftie.Frame.ScrollRecipesListHLink={}

for i=1, Craftie.MAX_RECIPES do
  Craftie.Frame.ScrollRecipesListItem[i] = CreateFrame("Button", Craftie.Frame.ScrollRecipesListItem[i], Craftie.Frame.ScrollRecipesListChildFrame, "BackdropTemplate", -1)
  Craftie.Frame.ScrollRecipesListItem[i]:SetWidth(Craftie.Frame.ScrollRecipes_Width-26) --scrollbar size
  Craftie.Frame.ScrollRecipesListItem[i]:SetHeight(20)
  Craftie.Frame.ScrollRecipesListItem[i]:SetPoint("TOPLEFT", 2, -i*Craftie.Frame.ScrollRecipesListItem[i]:GetHeight()+16)
  Craftie.Frame.ScrollRecipesListItem[i]:SetBackdrop(Craftie.Backdrop.Borderless)
  Craftie.Frame.ScrollRecipesListItem[i]:SetBackdropBorderColor(1, 1, 1, 0)
  Craftie.Frame.ScrollRecipesListItem[i]:SetFrameLevel(Craftie.Framelevel.Background)
  Craftie.Frame.ScrollRecipesListItem[i]:SetBackdropColor(1, 1, 1, 0)

  Craftie.Frame.ScrollRecipesListItem[i]:SetScript("OnEnter", function(self)
    if (Craftie.EnableScrollFrames) then
      self:SetBackdropColor(1, 0.9, 0.8, 0.2)
      Craftie.Frame.ScrollRecipesListText[i]:SetTextColor(1, 1, 0.8, 1)
    end

    --[==[
    CraftieTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
    CraftieTooltip:ClearLines()
    CraftieTooltip:AddLine(" ")
    CraftieTooltip:AddLine("|CFF4D4D4DShift + Left Click")
    CraftieTooltip:AddLine("|CFF4D4D4DPaste Link In Chat")
    --CraftieTooltip:AddLine(" ")
    --CraftieTooltip:AddDoubleLine(Craftie.Page, profLevel .. "/" .. Craftie.PROFMAXLEVEL)
    CraftieTooltip:Show()
    ]==]--
  end)
  Craftie.Frame.ScrollRecipesListItem[i]:SetScript("OnLeave", function(self)
    if (Craftie.EnableScrollFrames) then
      self:SetBackdropColor(1, 0.9, 0.8, 0)
      GameTooltip:Hide()
      Craftie:SelectScrollItem("Recipes")
    end
    CraftieTooltip:Hide()
  end)

  Craftie.Frame.ScrollRecipesListBack[i] = Craftie.Frame.ScrollRecipesListItem[i]:CreateTexture(nil, "BACKGROUND")
  Craftie.Frame.ScrollRecipesListBack[i]:SetSize(Craftie.Frame.ScrollRecipes_Width-26, 20)
  Craftie.Frame.ScrollRecipesListBack[i]:SetPoint("TOPLEFT", 0, 0)
  Craftie.Frame.ScrollRecipesListBack[i]:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Background-Row1.png")
  Craftie.Frame.ScrollRecipesListBack[i]:SetAlpha(0.7)
  Craftie.Frame.ScrollRecipesListBack[i]:SetVertexColor(1, 0.8, 0.5)

  Craftie.Frame.ScrollRecipesListSelect[i] = Craftie.Frame.ScrollRecipesListItem[i]:CreateTexture(nil, "OVERLAY")
  Craftie.Frame.ScrollRecipesListSelect[i]:SetSize(Craftie.Frame.ScrollRecipes_Width-30, Craftie.Frame.ScrollRecipesListItem[i]:GetHeight())
  Craftie.Frame.ScrollRecipesListSelect[i]:SetPoint("CENTER", 0, 0)
  Craftie.Frame.ScrollRecipesListSelect[i]:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Row-Select.png")
  Craftie.Frame.ScrollRecipesListSelect[i]:SetBlendMode("ADD")
  Craftie.Frame.ScrollRecipesListSelect[i]:SetVertexColor(0.70, 0.70, 0.60)
  Craftie.Frame.ScrollRecipesListSelect[i]:SetAlpha(0.6)
  Craftie.Frame.ScrollRecipesListSelect[i]:Hide()

  Craftie.Frame.ScrollRecipesListText[i] = Craftie.Frame.ScrollRecipesListItem[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.ScrollRecipesListText[i]:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
  Craftie.Frame.ScrollRecipesListText[i]:SetPoint("TOPLEFT", 8, -5)
  Craftie.Frame.ScrollRecipesListText[i]:SetText("")
  Craftie.Frame.ScrollRecipesListText[i]:SetTextColor(1, 1, 1, 0.8)

  Craftie.Frame.ScrollRecipesListHLink[i] = Craftie.Frame.ScrollRecipesListItem[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.ScrollRecipesListHLink[i]:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "OUTLINE")
  Craftie.Frame.ScrollRecipesListHLink[i]:SetPoint("TOPLEFT", 8, -5)
  Craftie.Frame.ScrollRecipesListHLink[i]:SetText("")
  Craftie.Frame.ScrollRecipesListHLink[i]:SetTextColor(0, 1, 1, 1)
  --Craftie.Frame.ScrollRecipesListHLink[i]:Hide()

  if (i % 2 == 0) then
    Craftie.Frame.ScrollRecipesListBack[i]:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Background-Row2.png")
  end
  if (i % 4 == 0) then
    Craftie.Frame.ScrollRecipesListBack[i]:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Background-Row4.png")
  end
end

Craftie.Frame.CraftBackBot={}
Craftie.Frame.CraftBackBot= CreateFrame("Frame", "Craftie.Frame.CraftBackBot", Craftie.Frame.CraftParent, "InsetFrameTemplate3")
Craftie.Frame.CraftBackBot:SetWidth(300)
Craftie.Frame.CraftBackBot:SetHeight(125)
Craftie.Frame.CraftBackBot:SetPoint("TOPRIGHT", 0, -248)

Craftie.Frame.CraftRequestParent = CreateFrame("Frame", "Craftie.Frame.CraftRequestParent", Craftie.Frame.CraftParent, "BackdropTemplate", 5)
Craftie.Frame.CraftRequestParent:SetWidth(300)
Craftie.Frame.CraftRequestParent:SetHeight(125)
--Craftie.Frame.CraftRequestParent:SetBackdrop(Craftie.Backdrop.General)
--Craftie.Frame.CraftRequestParent:SetBackdropColor(0, 1, 0, 1)
Craftie.Frame.CraftRequestParent:SetPoint("TOPRIGHT", 0, -248)
--Craftie.Frame.CraftRequestParent:SetFrameLevel(50)

Craftie.Frame.CraftBackBot.Request = CreateFrame("Button", nil, Craftie.Frame.CraftRequestParent, "UIPanelButtonTemplate")
Craftie.Frame.CraftBackBot.Request:SetSize(100, 24)
Craftie.Frame.CraftBackBot.Request:SetPoint("TOPLEFT", 20, -20)
Craftie.Frame.CraftBackBot.Request:SetText("Request")
Craftie.Frame.CraftBackBot.Request:SetScript("OnClick", function(self)

end)
