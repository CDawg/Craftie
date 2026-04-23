--[==[
Copyright ©2026 Porthias of Dreamscythe

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

--function OnEvent(self, event)
--	print("Craftie.Event " .. event)
--end

Craftie._G.Width = 820
Craftie._G.Height= 460

Craftie.Frame = {}
Craftie.Frame = CreateFrame("Frame", Craftie.Frame, UIParent, "ButtonFrameTemplate")
Craftie.Frame:SetWidth(Craftie._G.Width)
Craftie.Frame:SetHeight(Craftie._G.Height)
--Craftie.Frame:SetPoint("CENTER", 0, -140)
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
  -- CraftieDB[Craftie.player.combine]["CONFIG"]["MAINPOS"] = point .. "," .. xOfs .. "," .. yOfs
  Craftie.Notification("[" .. Craftie.player.combine .. "]" .. point .. "," .. xOfs .. "," .. yOfs, true)
end)

Craftie.Icon = Craftie.Frame:CreateTexture(nil, "ARTWORK")
Craftie.Icon:SetSize(54, 54)
Craftie.Icon:SetPoint("TOPLEFT", -4, 4)
Craftie.Icon:SetTexture(Craftie._G.dir .. "images/icon_default.tga")
--Craftie.Icon:SetTexture(Craftie._G.dir .. "images/Trade_Engraving")

Craftie.Frame.Title = Craftie.Frame:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Title:SetFont(Craftie._G.font, 14, "OUTLINE")
Craftie.Frame.Title:SetPoint("TOPLEFT", 65, -5)
Craftie.Frame.Title:SetText("Alchemy")

Craftie.Frame.Parent = {}

--[==[
Craftie.Frame.Header = Craftie.Frame:CreateTexture(nil, "ARTWORK")
Craftie.Frame.Header:SetSize(200, 60)
Craftie.Frame.Header:SetPoint("TOPLEFT", 0, 0)
Craftie.Frame.Header:SetTexture("Interface/ACHIEVEMENTFRAME/UI-Achievement-ComparisonHeader")
]==]--

Craftie.MAX_REAGENTS = 6
Craftie.MAX_RECIPES = 600

function Craftie.TabSelect(tab)
  for i=1, #Craftie.Professions do
    Craftie.Tab.Frame[i].Glow:Hide()
    Craftie.Tab.Frame[i].Shadow:Show()
  end
  Craftie.Tab.Frame[tab].Glow:Show()
  Craftie.Tab.Frame[tab].Shadow:Hide()
end

--light background template
--Interface/Glues/COMMON/UIFrameTooltipGluesBackground

Craftie.Tab={}
Craftie.Tab.Frame={}

local placeholder_recipes = "Search Recipes..."
local placeholder_players = "Search Players..."

--for i=1, #Craftie.Professions do
for i,v in pairs(Craftie.Professions) do
  Craftie.Tab.Frame[i] = CreateFrame("Button", Craftie.Tab.Frame[i], Craftie.Frame, "BackdropTemplate")
  Craftie.Tab.Frame[i]:SetWidth(40)
  Craftie.Tab.Frame[i]:SetHeight(40)
  Craftie.Tab.Frame[i]:SetPoint("TOPLEFT", -40, (-i*44)-28)
  Craftie.Tab.Frame[i]:SetBackdrop(Craftie.Backdrop.General)
  Craftie.Tab.Frame[i]:SetBackdropColor(0, 1, 0, 0)
  Craftie.Tab.Frame[i]:SetBackdropBorderColor(1, 1, 1, 0)
  Craftie.Tab.Frame[i].Border = Craftie.Tab.Frame[i]:CreateTexture(nil, "BORDER")
  Craftie.Tab.Frame[i].Border:SetSize(60, 60)
  Craftie.Tab.Frame[i].Border:SetPoint("TOPLEFT", -20, 14)
  Craftie.Tab.Frame[i].Border:SetTexture("Interface/SPELLBOOK/SpellBook-SkillLineTab")
  Craftie.Tab.Frame[i].Border:SetRotation(-math.pi)
  Craftie.Tab.Frame[i].Icon = Craftie.Tab.Frame[i]:CreateTexture(nil, "ARTWORK")
  Craftie.Tab.Frame[i].Icon:SetSize(Craftie.Tab.Frame[i]:GetWidth()-9, Craftie.Tab.Frame[i]:GetHeight()-9)
  Craftie.Tab.Frame[i].Icon:SetPoint("TOPLEFT", 7, -5)
  Craftie.Tab.Frame[i].Icon:SetTexture("Interface/Icons/" .. v[2])
  Craftie.Tab.Frame[i].Icon:SetDesaturation(0.30)
  Craftie.Tab.Frame[i].Icon:SetDrawLayer("ARTWORK", -2)
  --Craftie.Tab.Frame[i].Icon:SetMask("Interface/ChatFrame/UI-ChatIcon-HotS")
  Craftie.Tab.Frame[i].Shadow = CreateFrame("Frame", Craftie.Tab.Frame[i].Shadow, Craftie.Frame, "BackdropTemplate")
  Craftie.Tab.Frame[i].Shadow:SetWidth(32)
  Craftie.Tab.Frame[i].Shadow:SetHeight(32)
  Craftie.Tab.Frame[i].Shadow:SetPoint("TOPLEFT", -33, (-i*44)-32)
  Craftie.Tab.Frame[i].Shadow:SetBackdrop(Craftie.Backdrop.General)
  Craftie.Tab.Frame[i].Shadow:SetBackdropColor(0, 0, 0, 0.6)
  Craftie.Tab.Frame[i].Shadow:SetBackdropBorderColor(1, 1, 1, 0)
  Craftie.Tab.Frame[i].Shadow:SetFrameStrata("DIALOG")

  Craftie.Tab.Frame[i].Glow = Craftie.Tab.Frame[i]:CreateTexture(nil, "ARTWORK")
  Craftie.Tab.Frame[i].Glow:SetSize(Craftie.Tab.Frame[i]:GetWidth()-9, Craftie.Tab.Frame[i]:GetHeight()-9)
  Craftie.Tab.Frame[i].Glow:SetPoint("TOPLEFT", 7, -5)
  Craftie.Tab.Frame[i].Glow:SetTexture("Interface/Buttons/CheckButtonHilight")
  Craftie.Tab.Frame[i].Glow:SetBlendMode("ADD")
  Craftie.Tab.Frame[i].Glow:SetDrawLayer("ARTWORK", 6)
  Craftie.Tab.Frame[i].Glow:Hide()
  Craftie.Tab.Frame[i].Select = Craftie.Tab.Frame[i]:CreateTexture(nil, "ARTWORK")
  Craftie.Tab.Frame[i].Select:SetSize(Craftie.Tab.Frame[i]:GetWidth()-9, Craftie.Tab.Frame[i]:GetHeight()-9)
  Craftie.Tab.Frame[i].Select:SetPoint("TOPLEFT", 7, -5)
  Craftie.Tab.Frame[i].Select:SetTexture("Interface/Buttons/ButtonHilight-Square")
  Craftie.Tab.Frame[i].Select:SetBlendMode("ADD")
  Craftie.Tab.Frame[i].Select:SetDrawLayer("ARTWORK", 7)
  Craftie.Tab.Frame[i].Select:Hide()
  Craftie.Tab.Frame[i]:SetScript("OnEnter", function(self)
    Craftie.Tab.Frame[i].Select:Show()
    --GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:AddLine("|cffffffff" .. v[1] .. "|r")
    GameTooltip:Show()
  end)
  Craftie.Tab.Frame[i]:SetScript("OnLeave", function()
    Craftie.Tab.Frame[i].Select:Hide()
    GameTooltip:Hide()
  end)
  Craftie.Tab.Frame[i]:SetScript("OnClick", function(self)
    Craftie.ClearFocusAll()
    Craftie.TabSelect(i)
    Craftie.Frame.Title:SetText(v[1])
    --Craftie.Tab.Frame[i].Border:SetTexture("Interface/FriendsFrame/UI-FriendsFrameTab")

    Craftie.Profession.Query = Craftie.Profession[v[1]]
    C_Timer.After(0.30, function() --give it time to register
      local search_index = Craftie.Frame.Search.Recipes.Text:GetText()
      if (search_index == placeholder_recipes) then
        search_index = ""
      end
      Craftie.OpenProfessionList(Craftie.Profession.Query, search_index)
    end)
  end)
end
--Interface/COMMON/GreyBorder64-Left
--SPELLBOOK/SpellBook-SkillLineTab

--[==[
local TabOne = CreateFrame("Button", "fTabOne", Craftie.Frame, "TabButtonTemplate")
	TabOne:SetPoint("BOTTOMLEFT", Craftie.Frame,"TOPLEFT", 0, 0)
	TabOne:SetSize(100,100)
	TabOne:SetText("ARRRRRRRRG")
  TabOne:SetRotation(-math.pi/2)
]==]--

Craftie.Frame.Search = {}
--ACHIEVEMENTFRAME/UI-Achievement-ComparisonHeader

function Craftie.ClearFocusAll()
  Craftie.Frame.Search.Recipes.Text:ClearFocus()
  if (Craftie.Frame.Search.Recipes.Text:GetText() == "") then
    Craftie.Frame.Search.Recipes.Text:SetText(placeholder_recipes)
    Craftie.Frame.Search.Recipes.Text:SetFontObject(GameFontDisable)
  end

  Craftie.Frame.Search.Player.Text:ClearFocus()
  if (Craftie.Frame.Search.Player.Text:GetText() == "") then
    Craftie.Frame.Search.Player.Text:SetText(placeholder_players)
    Craftie.Frame.Search.Player.Text:SetFontObject(GameFontDisable)
  end
end

Craftie.Frame.Parent.Scroll = {}

Craftie.Frame.Parent.Scroll.Players = CreateFrame("Frame", Craftie.Frame.ScrollParent, Craftie.Frame, "InsetFrameTemplate")
Craftie.Frame.Parent.Scroll.Players:SetWidth(210)
Craftie.Frame.Parent.Scroll.Players:SetHeight(Craftie._G.Height-88)
Craftie.Frame.Parent.Scroll.Players:SetPoint("TOPLEFT", 2, -61)

Craftie.Frame.Parent.Scroll.Players.Back = Craftie.Frame.Parent.Scroll.Players:CreateTexture(nil, "BACKGROUND")
Craftie.Frame.Parent.Scroll.Players.Back:SetSize(Craftie.Frame.Parent.Scroll.Players:GetWidth()+88, Craftie.Frame.Parent.Scroll.Players:GetHeight()+62)
Craftie.Frame.Parent.Scroll.Players.Back:SetPoint("TOPLEFT", 0, 0)
--Craftie.Frame.Parent.Scroll.Players.Back:SetTexture("Interface/EncounterJournal/UI-EJ-Classic")
Craftie.Frame.Parent.Scroll.Players.Back:SetTexture("Interface/Garrison/TalentTreeChromie")
--Craftie.Frame.Parent.Scroll.Players.Back:SetRotation(-math.pi/2)
--Craftie.Frame.Parent.Scroll.Players.Back:SetDesaturation(0.84)
--Craftie.Frame.Parent.Back:SetTexture("Interface/ACHIEVEMENTFRAME/UI-Achievement-Parchment-Horizontal")
--UI-Achievement-Parchment-Horizontal-Desaturated
--LoadScreens/LoadScreen-LeftBookend

--[==[
Craftie.Frame.Parent.Scroll.Players.Top = Craftie.Frame.Parent.Scroll.Players:CreateTexture(nil, "BACKGROUND")
Craftie.Frame.Parent.Scroll.Players.Top:SetSize(60, Craftie.Frame.Parent.Scroll.Players:GetWidth()-8)
Craftie.Frame.Parent.Scroll.Players.Top:SetPoint("TOPLEFT", 80, 70)
Craftie.Frame.Parent.Scroll.Players.Top:SetTexture(Craftie._G.dir .. "images/LoadScreen-LeftBookend.png")
Craftie.Frame.Parent.Scroll.Players.Top:SetDesaturation(0.10)
--Craftie.Frame.Parent.Scroll.Players.Top:SetRotation(-math.pi/2)
Craftie.Frame.Parent.Scroll.Players.Top:SetRotation(math.pi/2)
--Craftie.Frame.Parent.Scroll.Players.Left:SetBlendMode("ADD")

Craftie.Frame.Parent.Scroll.Players.Right = Craftie.Frame.Parent.Scroll.Players:CreateTexture(nil, "BACKGROUND")
Craftie.Frame.Parent.Scroll.Players.Right:SetSize(Craftie.Frame.Parent.Scroll.Players:GetWidth()-90, Craftie.Frame.Parent.Scroll.Players:GetHeight())
Craftie.Frame.Parent.Scroll.Players.Right:SetPoint("TOPLEFT", Craftie.Frame.Parent.Scroll.Players:GetWidth()/2-20, 0)
Craftie.Frame.Parent.Scroll.Players.Right:SetTexture(Craftie._G.dir .. "images/LoadScreen-LeftBookend.png")
Craftie.Frame.Parent.Scroll.Players.Right:SetDesaturation(0.40)
]==]--

Craftie.Frame.Scroll = {}

Craftie.Frame.Scroll.Players = {}
Craftie.Frame.Scroll.Players.List = {}
Craftie.Frame.Scroll.Players_Width = 210
Craftie.Frame.Scroll.Players_Height= Craftie._G.Height-90
Craftie.Frame.Scroll.Players = CreateFrame("Frame", nil, Craftie.Frame.Parent.Scroll.Players)
Craftie.Frame.Scroll.Players:SetWidth(Craftie.Frame.Scroll.Players_Width)
Craftie.Frame.Scroll.Players:SetHeight(Craftie.Frame.Scroll.Players_Height)
Craftie.Frame.Scroll.Players:SetPoint("TOPLEFT", 0, 0) --low, due to the portrait frame
Craftie.Frame.Scroll.Players:SetFrameStrata("DIALOG")

Craftie.Frame.Scroll.Players.List = CreateFrame("Frame", Craftie.Frame.Scroll.Players.List, Craftie.Frame.Scroll.Players, "BackdropTemplate")
Craftie.Frame.Scroll.Players.List:SetWidth(Craftie.Frame.Scroll.Players_Width)
Craftie.Frame.Scroll.Players.List:SetHeight(Craftie.Frame.Scroll.Players_Height)
Craftie.Frame.Scroll.Players.List:SetPoint("CENTER", 0, 0)
Craftie.Frame.Scroll.Players.List:SetBackdrop(Craftie.Backdrop.General)
Craftie.Frame.Scroll.Players.List:SetBackdropColor(0, 0, 0, 0.8)
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

--QUESTFRAME/QuestBookBG

Craftie.Frame.Search.Player = CreateFrame("Frame", nil, Craftie.Frame.Parent.Scroll.Players, "BackdropTemplate", 2)
Craftie.Frame.Search.Player:SetWidth(150)
Craftie.Frame.Search.Player:SetHeight(24)
Craftie.Frame.Search.Player:SetPoint("TOPLEFT", 4, -1)
Craftie.Frame.Search.Player:SetBackdrop(Craftie.Backdrop.Opaque)
Craftie.Frame.Search.Player:SetBackdropColor(1, 0, 0, 1)
Craftie.Frame.Search.Player:SetBackdropBorderColor(1, 1, 1, 0.4)
Craftie.Frame.Search.Player:SetFrameStrata("TOOLTIP")
Craftie.Frame.Search.Player:SetFrameLevel(Craftie.Framelevel.Foreground)
Craftie.Frame.Search.Player.Text = CreateFrame("EditBox", nil, Craftie.Frame.Search.Player)
Craftie.Frame.Search.Player.Text:SetWidth(Craftie.Frame.Search.Player:GetWidth()-6)
Craftie.Frame.Search.Player.Text:SetHeight(Craftie.Frame.Search.Player:GetHeight())
Craftie.Frame.Search.Player.Text:SetFontObject(GameFontDisable)
Craftie.Frame.Search.Player.Text:SetPoint("TOPLEFT", 6, 0)
Craftie.Frame.Search.Player.Text:SetAutoFocus(false)
Craftie.Frame.Search.Player.Text:SetText(placeholder_players)
Craftie.Frame.Search.Player.Text:SetScript("OnKeyUp", function(self, key)
  if (key == "ENTER") then
    --local search_array = Craftie.Profession.Query
    --local search_index = Craftie.Frame.Search.Player.Text:GetText()
    --Craftie.OpenProfessionList(search_array, search_index)
    Craftie.ClearFocusAll()
  end
end)
Craftie.Frame.Search.Player.Text:SetScript("OnMouseDown", function(self)
    local search_index = Craftie.Frame.Search.Player.Text:GetText()
    if (search_index == placeholder_players) then
      Craftie.Frame.Search.Player.Text:SetText("")
      Craftie.Frame.Search.Player.Text:SetFontObject(GameFontWhite)
    end
end)
Craftie.Frame.Search.Player.Text:SetScript("OnEditFocusLost", function(self)
  --Craftie.Frame.Search.Player.Text:SetText(placeholder_recipes)
end)


--Craftie.Frame.Scroll.Players.List.Item = {}

Craftie.Frame.Parent.Scroll = {}

Craftie.Frame.Parent.Scroll.Recipes = CreateFrame("Frame", Craftie.Frame.ScrollParent, Craftie.Frame, "InsetFrameTemplate")
Craftie.Frame.Parent.Scroll.Recipes:SetWidth(300)
Craftie.Frame.Parent.Scroll.Recipes:SetHeight(Craftie._G.Height-88)
Craftie.Frame.Parent.Scroll.Recipes:SetPoint("TOPLEFT", 212, -61)

Craftie.Frame.Parent.Scroll.Recipes.Back = Craftie.Frame.Parent.Scroll.Recipes:CreateTexture(nil, "BACKGROUND")
Craftie.Frame.Parent.Scroll.Recipes.Back:SetSize(Craftie.Frame.Parent.Scroll.Recipes:GetWidth()+166, Craftie.Frame.Parent.Scroll.Recipes:GetHeight()+185)
Craftie.Frame.Parent.Scroll.Recipes.Back:SetPoint("TOPLEFT", 6, -5)
Craftie.Frame.Parent.Scroll.Recipes.Back:SetTexture("Interface/QUESTFRAME/QuestBookBG")

Craftie.Frame.Scroll.Recipes = {}
Craftie.Frame.Scroll.Recipes.List = {}
Craftie.Frame.Scroll.Recipes_Width = 300
Craftie.Frame.Scroll.Recipes_Height= Craftie._G.Height-90
Craftie.Frame.Scroll.Recipes = CreateFrame("Frame", nil, Craftie.Frame.Parent.Scroll.Recipes)

Craftie.Frame.Scroll.Recipes:SetWidth(Craftie.Frame.Scroll.Recipes_Width)
Craftie.Frame.Scroll.Recipes:SetHeight(Craftie.Frame.Scroll.Recipes_Height)
Craftie.Frame.Scroll.Recipes:SetPoint("TOPLEFT", 0, 0)
Craftie.Frame.Scroll.Recipes:SetFrameStrata("DIALOG")

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
Craftie.Frame.Scroll.Recipes.Results:SetFont(Craftie._G.font, 12, "OUTLINE")
Craftie.Frame.Scroll.Recipes.Results:SetPoint("BOTTOMRIGHT", 0, -20)
Craftie.Frame.Scroll.Recipes.Results:SetText("")

Craftie.Frame.Scroll.Recipes.Empty = Craftie.Frame.Scroll.Recipes:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Scroll.Recipes.Empty:SetFont(Craftie._G.font, 12, "OUTLINE")
Craftie.Frame.Scroll.Recipes.Empty:SetPoint("CENTER", -10, 0)
Craftie.Frame.Scroll.Recipes.Empty:SetTextColor(1, 1, 1, 0.6)
Craftie.Frame.Scroll.Recipes.Empty:SetText("")

Craftie.Frame.Scroll.Recipes.List.Item = {}

Craftie.Frame.Scroll.Text={}
Craftie.Frame.Scroll.Select={}

Craftie.Frame.Search.Recipes = CreateFrame("Frame", nil, Craftie.Frame.Parent.Scroll.Recipes, "BackdropTemplate", 2)
Craftie.Frame.Search.Recipes:SetWidth(150)
Craftie.Frame.Search.Recipes:SetHeight(24)
Craftie.Frame.Search.Recipes:SetPoint("TOPLEFT", 2, -2)
Craftie.Frame.Search.Recipes:SetBackdrop(Craftie.Backdrop.Opaque)
Craftie.Frame.Search.Recipes:SetBackdropColor(1, 0, 0, 1)
Craftie.Frame.Search.Recipes:SetBackdropBorderColor(1, 1, 1, 0.6)
Craftie.Frame.Search.Recipes:SetFrameStrata("TOOLTIP")
Craftie.Frame.Search.Recipes:SetFrameLevel(Craftie.Framelevel.Foreground)
Craftie.Frame.Search.Recipes.Text = CreateFrame("EditBox", nil, Craftie.Frame.Search.Recipes)
Craftie.Frame.Search.Recipes.Text:SetWidth(200)
Craftie.Frame.Search.Recipes.Text:SetHeight(35)
Craftie.Frame.Search.Recipes.Text:SetFontObject(GameFontDisable)
Craftie.Frame.Search.Recipes.Text:SetPoint("TOPLEFT", 6, 4)
Craftie.Frame.Search.Recipes.Text:SetAutoFocus(false)
Craftie.Frame.Search.Recipes.Text:SetText(placeholder_recipes)
Craftie.Frame.Search.Recipes.Text:SetScript("OnKeyUp", function(self, key)
  if (key == "ENTER") then
    local search_array = Craftie.Profession.Query
    local search_index = Craftie.Frame.Search.Recipes.Text:GetText()
    Craftie.OpenProfessionList(search_array, search_index)
    Craftie.ClearFocusAll()
  end
end)
Craftie.Frame.Search.Recipes.Text:SetScript("OnMouseDown", function(self)
    local search_index = Craftie.Frame.Search.Recipes.Text:GetText()
    if (search_index == placeholder_recipes) then
      Craftie.Frame.Search.Recipes.Text:SetText("")
      Craftie.Frame.Search.Recipes.Text:SetFontObject(GameFontWhite)
    end
end)
Craftie.Frame.Search.Recipes.Text:SetScript("OnEditFocusLost", function(self)
  --Craftie.Frame.Search.Recipes.Text:SetText(placeholder_recipes)
end)

local function SetItemTooltip(frame, itemID, enchant)
  --GameTooltip:SetOwner(frame, "ANCHOR_CURSOR")
  GameTooltip:SetOwner(frame, "ANCHOR_CURSOR_RIGHT")
  if (enchant) then
    GameTooltip:SetHyperlink("enchant:" .. itemID .. ":0:0:0:0:0:0:0")
  else
    GameTooltip:SetHyperlink("item:" .. itemID .. ":0:0:0:0:0:0:0")
  end
  GameTooltip:AddLine("|nCraftie")
  GameTooltip:Show()
end

function Craftie.ItemDetails(item)
  local reagent = {}
  Craftie.Frame.Craft:Show()
  Craftie.ClearFocusAll()
  for i=1, Craftie.MAX_REAGENTS do
    reagent[i] = 0
     Craftie.Frame.Reagent.Main[i]:Hide()
    if (not isempty(item[6][i])) then
      local r = 0
      local inv_count= C_Item.GetItemCount(item[6][i][1])
      local inv_req = item[6][i][2]

      --reset
      Craftie.Frame.Reagent.Text[i]:SetTextColor(1, 1, 1, 0.8)
      Craftie.Frame.Reagent.Icon[i]:SetAlpha(0.5)
      Craftie.Frame.Reagent.Main[i]:SetBackdropBorderColor(1, 1, 1, 0.6)

      r = getKeyFromValue(Craftie.Reagent, item[6][i][1], 1)
      Craftie.Frame.Reagent.Text[i]:SetText(Craftie.Reagent[r][2])
      Craftie.Frame.Reagent.Data[i]:SetText(Craftie.Reagent[r][1])
      Craftie.Frame.Reagent.QuanI[i]:SetText(inv_count)
      Craftie.Frame.Reagent.QuanR[i]:SetText(inv_req)
      Craftie.Frame.Reagent.Icon[i]:SetTexture(C_Item.GetItemIconByID(Craftie.Reagent[r][1]))
      Craftie.Frame.Reagent.Main[i]:Show()
      if (inv_count >= inv_req) then
        Craftie.Frame.Reagent.Main[i]:SetBackdropBorderColor(1, 1, 0.6, 0.9)
        Craftie.Frame.Reagent.Icon[i]:SetAlpha(1)
        Craftie.Frame.Reagent.Text[i]:SetTextColor(1, 1, 1, 1)
      end
      --print("craftie count " .. Craftie.Reagent[r][2] .. ": " .. item[6][i][2] .. " | " .. inv_count)
    end
  end
  Craftie.Frame.Craft.ID:SetText(item[4])
  Craftie.Frame.Craft.Text:SetText(item[2])
  local item_detail = item[4]
  local is_enchant = false
  --local get_tooltip = C_Item.GetItemByID(item[4])
  if (item_detail == "") then --blank or possibly enchant
    local name, subtext, icon, castTime, minRange, maxRange, spellID, originalIcon = GetSpellInfo(item[1])
    --print("spell? " .. name .. " | " .. icon)
    Craftie.Frame.Craft.ID:SetText(item[1])
    Craftie.Frame.Craft.Icon:SetTexture(icon)
    is_enchant = true
    --GameTooltip:SetHyperlink("enchant:" .. 7418 .. ":0:0:0:0:0:0:0")
  else
    Craftie.Frame.Craft.Icon:SetTexture(C_Item.GetItemIconByID(item_detail))
  end

    C_Timer.After(0.12, function() --give it time to register
      Craftie.Frame.Craft.Text:SetTextColor(1, 1, 1, 1)
      if (is_enchant) then
        Craftie.Frame.Craft.HLink:SetText("ENCHANT DATA TEXT HERE")
        --print(is_enchant)
        Craftie.Frame.Craft.HLink:SetScript("OnEnter", function(self)
          SetItemTooltip(Craftie.Frame.Craft.HLink, Craftie.Frame.Craft.ID:GetText(), true)
        end)
      else
        local name, link, quality, level, minlevel, type, subtype = GetItemInfo(item_detail)
        Craftie.Frame.Craft.HLink:SetText(link)
        if (quality ~= nil) then
          local r, g, b, qs = C_Item.GetItemQualityColor(quality)
          Craftie.Frame.Craft.Text:SetTextColor(r, g, b, 1)
        end
        Craftie.Frame.Craft.HLink:SetScript("OnEnter", function(self)
          SetItemTooltip(Craftie.Frame.Craft.HLink, Craftie.Frame.Craft.ID:GetText(), false)
        end)
      end
      Craftie.Frame.Craft.HLink:SetTextColor(1, 1, 1, 0) --hide/alpha
    end)
end

Craftie.item_selected = 1

Craftie.Frame.Parent.Craft= {}
Craftie.Frame.Parent.Craft= CreateFrame("Frame", Craftie.Frame.Parent.Craft, Craftie.Frame, "InsetFrameTemplate")
Craftie.Frame.Parent.Craft:SetWidth(300)
Craftie.Frame.Parent.Craft:SetHeight(Craftie._G.Height-88)
Craftie.Frame.Parent.Craft:SetPoint("TOPRIGHT", -8, -61)
--[==[
Craftie.Frame.Parent.Back = Craftie.Frame.Parent.Craft:CreateTexture(nil, "BACKGROUND")
Craftie.Frame.Parent.Back:SetSize(Craftie.Frame.Parent.Craft:GetWidth(), Craftie.Frame.Parent.Craft:GetHeight())
Craftie.Frame.Parent.Back:SetPoint("TOPLEFT", 0, 0)
Craftie.Frame.Parent.Back:SetTexture("Interface/ACHIEVEMENTFRAME/UI-GuildAchievement-Parchment-Horizontal-Desaturated")
--Craftie.Frame.Parent.Back:SetTexture("Interface/ACHIEVEMENTFRAME/UI-Achievement-Parchment-Horizontal")
--UI-Achievement-Parchment-Horizontal-Desaturated
]==]--

Craftie.Frame.Craft = {}
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
Craftie.Frame.Craft.Text = Craftie.Frame.Craft:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Craft.Text:SetFont(Craftie._G.font, 12, "OUTLINE")
Craftie.Frame.Craft.Text:SetPoint("TOPLEFT", 40, -10)
Craftie.Frame.Craft.Text:SetText("")
--designed to mask over the entire craft frame
Craftie.Frame.Craft.HLink = Craftie.Frame.Craft:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Craft.HLink:SetFont(Craftie._G.font, 20, "OUTLINE")
Craftie.Frame.Craft.HLink:SetPoint("TOPLEFT", -4, -8)
Craftie.Frame.Craft.HLink:SetText("")
--Craftie.Frame.Craft.HLink:SetWidth(300)
Craftie.Frame.Craft.ID = Craftie.Frame.Craft:CreateFontString(nil, "ARTWORK")
Craftie.Frame.Craft.ID:SetFont(Craftie._G.font, 12, "OUTLINE")
Craftie.Frame.Craft.ID:SetPoint("CENTER", 10, 0)
Craftie.Frame.Craft.ID:SetText("")
Craftie.Frame.Craft.ID:SetTextColor(1, 1, 1, 0)
Craftie.Frame.Craft:Hide()

--Craftie.Frame.Craft.HLink:SetScript("OnEnter", function(self)
  --SetItemTooltip(Craftie.Frame.Craft.HLink, Craftie.Frame.Craft.ID:GetText(), false)
--end)
Craftie.Frame.Craft.HLink:SetScript("OnLeave", function(self)
  GameTooltip:Hide()
end)

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
Craftie.Frame.Reagent_PosY  = 50
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

function Craftie.ClearSelectedItem()
  for i=1, Craftie.MAX_RECIPES do
    Craftie.Frame.Scroll.Recipes.List.Item[i]:SetBackdropColor(1, 1, 1, 0)
    Craftie.Frame.Scroll.Recipes.List.Item[Craftie.item_selected]:SetBackdropColor(0.6, 0.7, 1, 0.5)
    Craftie.Frame.Scroll.Text[Craftie.item_selected]:SetTextColor(1, 1, 0.8, 1)
    Craftie.Frame.Scroll.Text[i]:SetTextColor(1, 1, 1, 0.8)
    if (i % 2 == 0) then
      Craftie.Frame.Scroll.Recipes.List.Item[i]:SetBackdropColor(0.8, 0.9, 1, 0.1)
    end
  end
end

--for i=1, #Craftie.Profession.Query do
for i=1, Craftie.MAX_RECIPES do
  Craftie.Frame.Scroll.Recipes.List.Item[i] = CreateFrame("Button", Craftie.Frame.Scroll.Recipes.List.Item[i], Craftie.Frame.Scroll.Recipes.ListChildFrame, "BackdropTemplate", -1)
  Craftie.Frame.Scroll.Recipes.List.Item[i]:SetWidth(Craftie.Frame.Scroll.Recipes_Width-26) --scrollbar size
  Craftie.Frame.Scroll.Recipes.List.Item[i]:SetHeight(20)
  Craftie.Frame.Scroll.Recipes.List.Item[i]:SetPoint("TOPLEFT", 2, -i*18)
  Craftie.Frame.Scroll.Recipes.List.Item[i]:SetBackdrop(Craftie.Backdrop.General)
  Craftie.Frame.Scroll.Recipes.List.Item[i]:SetBackdropBorderColor(1, 1, 1, 0)
  Craftie.Frame.Scroll.Recipes.List.Item[i]:SetFrameLevel(Craftie.Framelevel.Background)
  Craftie.Frame.Scroll.Recipes.List.Item[i]:SetBackdropColor(1, 1, 1, 0)

  Craftie.Frame.Scroll.Text[i] = Craftie.Frame.Scroll.Recipes.List.Item[i]:CreateFontString(nil, "ARTWORK")
  Craftie.Frame.Scroll.Text[i]:SetFont(Craftie._G.font, 12, "OUTLINE")
  Craftie.Frame.Scroll.Text[i]:SetPoint("TOPLEFT", 8, -4)
  Craftie.Frame.Scroll.Text[i]:SetText("")
  Craftie.Frame.Scroll.Text[i]:SetTextColor(1, 1, 1, 0.8)

  if (i % 2 == 0) then
    Craftie.Frame.Scroll.Recipes.List.Item[i]:SetBackdropColor(0.6, 0.7, 1, 0.1)
  end
  Craftie.Frame.Scroll.Recipes.List.Item[i]:SetScript("OnEnter", function(self)
    Craftie.Frame.Scroll.Recipes.List.Item[i]:SetBackdropColor(1, 1, 1, 0.2)
    Craftie.Frame.Scroll.Text[i]:SetTextColor(1, 1, 0.8, 1)
  end)
  Craftie.Frame.Scroll.Recipes.List.Item[i]:SetScript("OnLeave", function(self)
    GameTooltip:Hide()
    Craftie.ClearSelectedItem()
  end)

  --[==[
  Craftie.Frame.Scroll.Recipes.List.Item[i]:SetScript("OnClick", function()
    Craftie.ItemDetails(Craftie.Profession.Query[i])
    --print(Craftie.Profession.Query[i][2])
    Craftie.item_selected = i
    Craftie.ClearSelectedItem()

  --Craftie.SendPacket(lualzw.compress("3,1001110010010101"), "WHISPER", false)
  --Craftie.SendPacket("3[86]1110010010101", "WHISPER", false)
  --Craftie.SendPacket("WHISPER", false)
  end)
  ]==]--
end

function Craftie.ResetSearch()
  Craftie.Frame.Search.Recipes.Text:SetText("")
  Craftie.OpenProfessionList(prof, "")
end

function Craftie.OpenProfessionList(prof, search) --need to add player
  --print("prof count " .. #prof)
  local total_recipes = #prof
  local total_search = 0
  Craftie.Frame.Scroll.Recipes.Results:SetText("")
  Craftie.Frame.Scroll.Recipes.Empty:SetText("")
  --Craftie.Frame.Scroll.Recipes.List:SetBackdropColor(0.1, 0.6, 1, 0) --slight blue  
  if (search:len() >= 3) then
    local matches = SortTableByMatch(prof, search)
    if (matches >= 1) then
      total_recipes = matches
    else
      matches = 0
      total_recipes = 0
      Craftie.Frame.Scroll.Recipes.Empty:SetText('No Recipes|n"' .. search .. '"')
    end
    Craftie.Frame.Scroll.Recipes.Results:SetText(matches .. " |cfffffb63Result(s)")
  else
    SortTableByString(prof)
    Craftie.Frame.Scroll.Recipes.Results:SetText(total_recipes .. " |cfffffb63Result(s)")
  end
  for i=1, Craftie.MAX_RECIPES do
    Craftie.Frame.Scroll.Recipes.List.Item[i]:Hide()
  end

  C_Timer.After(0.12, function()
    for i=1, total_recipes do
      Craftie.Frame.Scroll.Text[i]:SetText(prof[i][2])
      Craftie.Frame.Scroll.Recipes.List.Item[i]:SetScript("OnClick", function()
        Craftie.ItemDetails(prof[i])
        --print(prof[i][2])
        Craftie.item_selected = i
        Craftie.ClearSelectedItem()

        --Craftie.SendPacket(lualzw.compress("3,1001110010010101"), "WHISPER", false)
        --Craftie.SendPacket("3[86]1110010010101", "WHISPER", false)
        --Craftie.SendPacket("WHISPER", false)
      end)
      Craftie.Frame.Scroll.Recipes.List.Item[i]:Show()
    end
    Craftie.Profession.Query = prof

    local prof_list = getKeyFromValue(Craftie.Professions, Craftie.Frame.Title:GetText(), 1)
    local prof_color = split(Craftie.Professions[prof_list][3], ",")
    Craftie.Frame.Scroll.Recipes.List:SetBackdropColor(prof_color[1], prof_color[2], prof_color[3], 0.14)
    --print(prof_color)
  end)
end

C_Timer.After(1, function()
  Craftie.TabSelect(1)
  Craftie.OpenProfessionList(Craftie.Profession.Query, "")
end)

--[==[
for i=1, 4 do
  Craftie.SlotGrid.VerticalTimerX = Craftie.SlotGrid.VerticalTimerX+Craftie.Slot_w
  Craftie.SlotGrid.VerticalTimer[i]= Craftie.FrameMain:CreateFontString(nil, "ARTWORK")
  Craftie.SlotGrid.VerticalTimer[i]:SetFont(Craftie._G.font, 12, "OUTLINE")
  Craftie.SlotGrid.VerticalTimer[i]:SetPoint("TOPLEFT", Craftie.SlotGrid.VerticalTimerX-Craftie.Slot_w+5, -28)
  Craftie.SlotGrid.VerticalTimer[i]:SetText("")
  Craftie.SlotGrid.VerticalTimer[i]:Hide()
]==]--

--[==[
Craftie.Frame.Scroll.Recipes.text = CreateFrame("EditBox", nil, Craftie.Frame.Scroll.Recipes.ListChildFrame)
Craftie.Frame.Scroll.Recipes.text:SetWidth(Craftie.Frame.Scroll.Recipes_Width-20)
Craftie.Frame.Scroll.Recipes.text:SetHeight(Craftie.Frame.Scroll.Recipes_Height)
Craftie.Frame.Scroll.Recipes.text:SetFontObject(GameFontWhite)
Craftie.Frame.Scroll.Recipes.text:SetPoint("TOPLEFT", 4, -4)
Craftie.Frame.Scroll.Recipes.text:SetMultiLine(true)
Craftie.Frame.Scroll.Recipes.text:ClearFocus(self)
Craftie.Frame.Scroll.Recipes.text:SetAutoFocus(false)
Craftie.Frame.Scroll.Recipes.text:SetText(arrayToString(texthere))
]==]--

--[==[
--Craftie.Frame.Background = CreateFrame("Frame", Craftie.Frame.Background, Craftie.Frame, "BasicFrameTemplateWithInset", -6)
Craftie.Frame.Background = CreateFrame("Frame", Craftie.Frame.Background, Craftie.Frame, "EtherealFrameTemplate", -6)
Craftie.Frame.Background:SetWidth(Craftie._G.Width)
Craftie.Frame.Background:SetHeight(Craftie._G.Height)
Craftie.Frame.Background:SetPoint("CENTER", 0, 0)
--Craftie.Frame.Background:SetBackdrop(Craftie.Backdrop.General)
--Craftie.Frame.Background:SetBackdrop(BACKDROP_DARK_DIALOG_32_32)
--Craftie.Frame.Background:SetBackdropColor(0, 0, 0, 1)
--Craftie.Frame.Background:SetBackdropBorderColor(1, 1, 1, 0.6)
Craftie.Frame.Background:SetFrameLevel(Craftie.Framelevel.Background)

--Craftie.KeyBindsSetOnLoad = 1
]==]--

