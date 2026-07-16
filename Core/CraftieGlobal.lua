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

Craftie._G = {
  Prefix = "Craftie",
  Width  = 860,
  Height = 500,
  Update = 20260908,
  Icon   = "Images/Icons/UI-Craftie-Icon",
  Author = "Porthias",
}

Craftie._G.Version = C_AddOns.GetAddOnMetadata(Craftie._G.Prefix, "version")

Craftie._G.Font={
  Style = {
    Alpha  = "Fonts/FRIZQT__.ttf",
    Numeric= "Fonts/ARIALN.ttf"
  },
  Size = 11,
  Flags = "SLUG"
}

Craftie._G.Path = "Interface/Addons/".. Craftie._G.Prefix .."/"
Craftie._G.Title = Craftie.Color.Theme .. Craftie._L.Title .. "|r"
Craftie._G.Stamp = Craftie._G.Title .. " v" .. Craftie._G.Version

--locales library must load first
Craftie.Game.Name = Craftie._L.Game[tonumber(string.sub(__Gversion, 1, 1))]

Craftie._G.Image = {
  Logo = {
    Header = Craftie._G.Path .. "Images/UI-Craftie-Logo-Header.png",
    --Icon = "", --small
  },
  Background = {
    Light =     Craftie._G.Path .. "Images/Backgrounds/UI-Craftie-Background-Light.png",
    Shadow=     Craftie._G.Path .. "Images/Backgrounds/UI-Craftie-Background-Shadow.png",
    Profession= Craftie._G.Path .. "Images/Backgrounds/professionbackgroundart", --dynamic
    Recipes   = Craftie._G.Path .. "Images/Backgrounds/UI-Craftie-Background-Recipes.png",
    Toast     = Craftie._G.Path .. "Images/Backgrounds/UI-Craftie-Craft-Toast.png",
    Bottom    = Craftie._G.Path .. "Images/Backgrounds/UI-Craftie-Shadow-Overlay.png",
  },
  Tooltip = {
    Side  = Craftie._G.Path .. "Images/Tooltip/UI-Craftie-Tooltip-Art-Side.png",
    Corner= Craftie._G.Path .. "Images/Tooltip/UI-Craftie-Tooltip-Art-Corner.png",
    Layout= "|T" .. Craftie._G.Path .. Craftie._G.Icon .. ".png:14:14|t",
  },
  Button = {
    Frame = Craftie._G.Path .. "Images/Buttons/UIFrameMetal-RightDouble.png",
    Clear = Craftie._G.Path .. "Images/Buttons/UI-Craftie-Button-Search-Clear.png",
    Delete= Craftie._G.Path .. "Images/Buttons/UI-Craftie-Button-Delete.png",
    Arrow = Craftie._G.Path .. "Images/Buttons/Helptip.png",
    Glow  = Craftie._G.Path .. "Images/Buttons/UI-Craftie-Reagent-Border-Glow.png"
  },
  Scrollbar = {
    Slider  = Craftie._G.Path .. "Images/Scrollbar/UI-Craftie-Scroll-Slider.png",
    Back    = Craftie._G.Path .. "Images/Scrollbar/UI-Craftie-Scroll-Back.png",
    Top     = Craftie._G.Path .. "Images/Scrollbar/UI-Craftie-Scroll-Top.png",
    Bot     = Craftie._G.Path .. "Images/Scrollbar/UI-Craftie-Scroll-Bot.png",
    Up      = Craftie._G.Path .. "Images/Scrollbar/UI-Craftie-Scroll-Up.png",
    Down    = Craftie._G.Path .. "Images/Scrollbar/UI-Craftie-Scroll-Dn.png",
    Footer  = Craftie._G.Path .. "Images/Scrollbar/UI-Craftie-Footer.png",
    Dropdown= Craftie._G.Path .. "Images/Scrollbar/UI-Craftie-Dropdown.png",
    Search  = Craftie._G.Path .. "Images/Scrollbar/UI-Craftie-Search.png",
  },
  Progress = {
    Bar = Craftie._G.Path .. "Images/ProgBar.png",
    Mask= Craftie._G.Path .. "Images/ProgBarMask.png",
  },
  TabBar = Craftie._G.Path .. "Images/Tabs/UI-Craftie-ProfBar", --dyanmic by version
  Tab = {
    Active = Craftie._G.Path .. "Images/Tabs/UI-CraftieBottomTab-Active.png",
    Inactive = Craftie._G.Path .. "Images/Tabs/UI-CraftieBottomTab-Inactive.png",
  },
  Row = { --textured
    Select = Craftie._G.Path .. "Images/Backgrounds/UI-Craftie-Row-Select.png",
    Craftie._G.Path .. "Images/Backgrounds/UI-Craftie-Background-Row1.png",
    Craftie._G.Path .. "Images/Backgrounds/UI-Craftie-Background-Row2.png",
    Craftie._G.Path .. "Images/Backgrounds/UI-Craftie-Background-Row3.png",
  }
}

--static
Craftie.MAX_REAGENTS= 6
Craftie.MAX_RECIPES = 400 --max for tbc current
Craftie.MAX_ITEMIDS = 60000 -- some items go up to 58k

--dynamic
Craftie.TOTAL_CRAFTERS= {}
Craftie.TOTAL_ORDERS  = {}
Craftie.ORDER_TIMER   = 5

Craftie.ProfessionDefault = Craftie:CopyTable(Craftie.Profession.Alchemy)

Craftie.Selected_Player_Index = 1
Craftie.Selected_Recipe_Index = 1
Craftie.Selected_ViewAll = "All Alchemy Recipes" --default
Craftie.Selected_Name = ""
Craftie.Preload = Craftie.Color.Gold .. "Loading Data...|r"
Craftie.Page = Craftie.Professions[1][2] --default
Craftie.Tab = 0

-- Global Frame
Craftie.Frame={}
Craftie.Frame = CreateFrame("Frame", 'Craftie.Frame', UIParent, "BasicFrameTemplate")

table.insert(UISpecialFrames, Craftie.Frame:GetName())

Craftie.Frame.Search={}

Craftie.EnableScrollFrames = true

Craftie.TabBar = {
  X = 42,
  Y = 70
}

function Craftie:TranslateLocaleProfession(name)
  for k,v in pairs(Craftie._L.Professions) do
    if (k == name) then
      return v[1]
    end
  end
end
