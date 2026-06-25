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

local dimensions = {
  W = 294,
  H = 302,
}

Craftie.Frame.ScrollRecipesParent = CreateFrame("Frame", "Craftie.Frame.ScrollRecipesParent", Craftie.Frame, "InsetFrameTemplate")
Craftie.Frame.ScrollRecipesParent:SetWidth(dimensions.W)
Craftie.Frame.ScrollRecipesParent:SetHeight(dimensions.H+70)
Craftie.Frame.ScrollRecipesParent:SetPoint("TOPLEFT", 224, -100)
Craftie.Frame.ScrollRecipesParent:SetFrameStrata("MEDIUM")

Craftie.Frame.ScrollRecipesParent.Back = Craftie.Frame.ScrollRecipesParent:CreateTexture(nil, "BACKGROUND")
Craftie.Frame.ScrollRecipesParent.Back:SetSize(Craftie.Frame.ScrollRecipesParent:GetWidth()-20, Craftie.Frame.ScrollRecipesParent:GetHeight())
Craftie.Frame.ScrollRecipesParent.Back:SetPoint("TOPLEFT", 0, 0)
Craftie.Frame.ScrollRecipesParent.Back:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Background-Recipes.png")

Craftie.Frame.ScrollRecipesList = CreateFrame("Frame", "Craftie.Frame.ScrollRecipesList", Craftie.Frame.ScrollRecipesParent, "BackdropTemplate")
Craftie.Frame.ScrollRecipesList:SetWidth(dimensions.W-10)
Craftie.Frame.ScrollRecipesList:SetHeight(dimensions.H+20)
Craftie.Frame.ScrollRecipesList:SetPoint("CENTER", 2, -6)

Craftie.Frame.ScrollRecipesList.Child = CreateFrame("ScrollFrame", Craftie.Frame.ScrollRecipesList.Child, Craftie.Frame.ScrollRecipesList, "UIPanelScrollFrameTemplate")
Craftie.Frame.ScrollRecipesList.Child:SetPoint("TOPLEFT", Craftie.Frame.ScrollRecipesList, "TOPLEFT",         -2,-20)
Craftie.Frame.ScrollRecipesList.Child:SetPoint("BOTTOMRIGHT", Craftie.Frame.ScrollRecipesList, "BOTTOMRIGHT", 14, 10)
Craftie.Frame.ScrollRecipesListChildFrame = CreateFrame("Frame", "Craftie.Frame.ScrollRecipesListChildFrame", Craftie.Frame.ScrollRecipesList.Child)
Craftie.Frame.ScrollRecipesListChildFrame:SetSize(dimensions.W, dimensions.H)
Craftie.Frame.ScrollRecipesList.Child:SetScrollChild(Craftie.Frame.ScrollRecipesListChildFrame)
Craftie.Frame.ScrollRecipesList.Child.ScrollBar:ClearAllPoints()
Craftie.Frame.ScrollRecipesList.Child.ScrollBar:SetPoint("TOPLEFT", Craftie.Frame.ScrollRecipesList.Child, "TOPRIGHT",          0,-10)
Craftie.Frame.ScrollRecipesList.Child.ScrollBar:SetPoint("BOTTOMRIGHT", Craftie.Frame.ScrollRecipesList.Child, "BOTTOMRIGHT", -42, 10)

Craftie:ScrollBarFrame(Craftie.Frame.ScrollRecipesList.Child)

Craftie.Frame.ScrollRecipesResultsFrame = CreateFrame("Frame", "Craftie.Frame.ScrollRecipesResultsFrame", Craftie.Frame.ScrollRecipesParent, "BackdropTemplate", 25)
Craftie.Frame.ScrollRecipesResultsFrame:SetWidth(dimensions.W-6)
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
Craftie.Frame.DropdownRecipes = CreateFrame("Frame", "Craftie.Frame.DropdownRecipes", Craftie.Frame.ScrollRecipesParent, "UIDropDownMenuTemplate")
Craftie.Frame.DropdownRecipes:SetPoint("TOPLEFT", -14, -1)
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
UIDropDownMenu_SetWidth(Craftie.Frame.DropdownRecipes, dimensions.W-22)
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
Craftie.Frame.DropdownRecipes.Back:SetSize(dimensions.W-5, 28)
Craftie.Frame.DropdownRecipes.Back:SetPoint("TOPLEFT", 16, -4)
Craftie.Frame.DropdownRecipes.Back:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Dropdown-32.png")

--[==[
SEARCH RECIPES
]==]--
Craftie.Frame.Search.Recipes={}
Craftie.Frame.Search.Recipes = CreateFrame("Frame", "Craftie.Frame.Search.Recipes", Craftie.Frame.ScrollRecipesParent, "BackdropTemplate")
Craftie.Frame.Search.Recipes:SetWidth(dimensions.W -5)
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
  --Craftie:UpdateCrafterList()
  --Craftie:SelectCrafter(1, "")
  Craftie:ClearSearchFocus(false)
  if ((Craftie.Selected_Player_Index) and (Craftie.Selected_Name)) then
    Craftie:SelectCrafter(Craftie.Selected_Player_Index, Craftie.Selected_Name)
  else
    Craftie:UpdateCrafterList()
  end
end)
Craftie.Frame.Button.SearchRecipesClear:SetScript("OnEnter", function(self)
  Craftie.Frame.Button.SearchRecipesClearIcon:SetAlpha(0.8)
end)
Craftie.Frame.Button.SearchRecipesClear:SetScript("OnLeave", function(self)
  Craftie.Frame.Button.SearchRecipesClearIcon:SetAlpha(0.4)
end)

Craftie.Frame.ScrollRecipesListRow={}
Craftie.Frame.ScrollRecipesListBack={}
Craftie.Frame.ScrollRecipesListName={}
Craftie.Frame.ScrollRecipesListSelect={}
--Craftie.Frame.ScrollRecipesListHLink={}

for i=1, Craftie.MAX_RECIPES do
  Craftie.Frame.ScrollRecipesListRow[i] = CreateFrame("Button", Craftie.Frame.ScrollRecipesListRow[i], Craftie.Frame.ScrollRecipesListChildFrame, "BackdropTemplate", -1)
  Craftie.Frame.ScrollRecipesListRow[i]:SetWidth(dimensions.W-26) --scrollbar size
  Craftie.Frame.ScrollRecipesListRow[i]:SetHeight(20)
  Craftie.Frame.ScrollRecipesListRow[i]:SetPoint("TOPLEFT", 2, -i*Craftie.Frame.ScrollRecipesListRow[i]:GetHeight()+16)
  Craftie.Frame.ScrollRecipesListRow[i]:SetBackdrop(Craftie.Backdrop.Borderless)
  Craftie.Frame.ScrollRecipesListRow[i]:SetBackdropBorderColor(1, 1, 1, 0)
  Craftie.Frame.ScrollRecipesListRow[i]:SetBackdropColor(1, 1, 1, 0)
  Craftie.Frame.ScrollRecipesListRow[i]:SetFrameLevel(Craftie.Framelevel.Background)

  Craftie.Frame.ScrollRecipesListRow[i]:SetScript("OnEnter", function(self)
    if (Craftie.EnableScrollFrames) then
      self:SetBackdropColor(1, 0.9, 0.8, 0.2)
      Craftie.Frame.ScrollRecipesListName[i]:SetTextColor(1, 1, 0.8, 1)
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
  Craftie.Frame.ScrollRecipesListRow[i]:SetScript("OnLeave", function(self)
    if (Craftie.EnableScrollFrames) then
      self:SetBackdropColor(1, 0.9, 0.8, 0)
      GameTooltip:Hide()
      Craftie:SelectScrollItem("Recipes")
    end
    CraftieTooltip:Hide()
  end)

  Craftie.Frame.ScrollRecipesListBack[i] = Craftie.Frame.ScrollRecipesListRow[i]:CreateTexture(nil, "BACKGROUND")
  Craftie.Frame.ScrollRecipesListBack[i]:SetSize(dimensions.W-26, 20)
  Craftie.Frame.ScrollRecipesListBack[i]:SetPoint("TOPLEFT", 0, 0)
  Craftie.Frame.ScrollRecipesListBack[i]:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Background-Row1.png")
  Craftie.Frame.ScrollRecipesListBack[i]:SetAlpha(0.7)
  Craftie.Frame.ScrollRecipesListBack[i]:SetVertexColor(1, 0.8, 0.5)

  Craftie.Frame.ScrollRecipesListSelect[i] = Craftie.Frame.ScrollRecipesListRow[i]:CreateTexture(nil, "OVERLAY")
  Craftie.Frame.ScrollRecipesListSelect[i]:SetSize(dimensions.W -30, Craftie.Frame.ScrollRecipesListRow[i]:GetHeight())
  Craftie.Frame.ScrollRecipesListSelect[i]:SetPoint("CENTER", 0, 0)
  Craftie.Frame.ScrollRecipesListSelect[i]:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Row-Select.png")
  Craftie.Frame.ScrollRecipesListSelect[i]:SetBlendMode("ADD")
  Craftie.Frame.ScrollRecipesListSelect[i]:SetVertexColor(0.70, 0.70, 0.60)
  Craftie.Frame.ScrollRecipesListSelect[i]:SetAlpha(0.6)
  Craftie.Frame.ScrollRecipesListSelect[i]:Hide()

  Craftie.Frame.ScrollRecipesListName[i] = Craftie.Frame.ScrollRecipesListRow[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.ScrollRecipesListName[i]:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "SLUG")
  Craftie.Frame.ScrollRecipesListName[i]:SetPoint("TOPLEFT", 8, -5)
  Craftie.Frame.ScrollRecipesListName[i]:SetText("")
  Craftie.Frame.ScrollRecipesListName[i]:SetTextColor(1, 1, 1, 0.8)

  --[==[
  Craftie.Frame.ScrollRecipesListHLink[i] = Craftie.Frame.ScrollRecipesListRow[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.ScrollRecipesListHLink[i]:SetFont(Craftie._G.Font.Style, Craftie._G.Font.Size, "OUTLINE")
  Craftie.Frame.ScrollRecipesListHLink[i]:SetPoint("TOPLEFT", 8, -5)
  Craftie.Frame.ScrollRecipesListHLink[i]:SetText("")
  Craftie.Frame.ScrollRecipesListHLink[i]:SetTextColor(0, 1, 1, 1)
  --Craftie.Frame.ScrollRecipesListHLink[i]:Hide()
  ]==]--

  if (i % 2 == 0) then
    Craftie.Frame.ScrollRecipesListBack[i]:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Background-Row2.png")
  end
  if (i % 4 == 0) then
    Craftie.Frame.ScrollRecipesListBack[i]:SetTexture(Craftie._G.Path .. "Images/UI-Craftie-Background-Row4.png")
  end
end
