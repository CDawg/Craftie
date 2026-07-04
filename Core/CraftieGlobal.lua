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
  Icon   = "UI-Craftie-Icon",
  Author = "Porthias",
}

Craftie._G.Version = C_AddOns.GetAddOnMetadata(Craftie._G.Prefix, "version")

Craftie._G.Font={}
Craftie._G.Font.Style = "Fonts/FRIZQT__.ttf"
Craftie._G.Font.StyleA= "Interface/Addons/Craftie/Fonts/AvantGarde.ttf"
Craftie._G.Font.StyleN= "Fonts/ARIALN.ttf" --numerical
Craftie._G.Font.Size  = 11

Craftie._G.Path = "Interface/Addons/".. Craftie._G.Prefix .."/"
Craftie._G.Title = Craftie.Color.Theme .. Craftie._L.Title .. "|r"
Craftie._G.Stamp = Craftie._G.Title .. " v" .. Craftie._G.Version

--locales library must load first
Craftie.Game.Name = Craftie._L.Game[tonumber(string.sub(__Gversion, 1, 1))]

Craftie.MAX_REAGENTS= 6
Craftie.MAX_RECIPES = 600
Craftie.MAX_CRAFTERS= 300   --per profession (TODO - make tis dynamic)
Craftie.MAX_ITEMIDS = 60000 -- some items go up to 58k
Craftie.MAX_ORDERS  = 100
Craftie.REQ_TIMER   = 5

Craftie.ProfessionDefault = Craftie:CopyTable(Craftie.Profession.Alchemy)
--Craftie.ProfessionSearch = Craftie:CopyTable(Craftie.Profession.Alchemy)

Craftie.Selected_Player_Index = 1
Craftie.Selected_Recipe_Index = 1
Craftie.Selected_ViewAll = "All Alchemy Recipes" --default
Craftie.Selected_Name = ""
Craftie.Preload = Craftie.Color.Gold .. "Loading Data...|r"
Craftie.Page = Craftie.Professions[1][1] --default
Craftie.Tab = 0

-- Global Frames
Craftie.Frame={}
Craftie.Frame = CreateFrame("Frame", 'Craftie.Frame', UIParent, "BasicFrameTemplate")
table.insert(UISpecialFrames, Craftie.Frame:GetName())

Craftie.Frame.Search={}

Craftie.EnableScrollFrames = true

Craftie.TabBar_X = 42
Craftie.TabBar_Y = 70

function Craftie:TranslateLocaleProfession(name)
  for k,v in pairs(Craftie._L.Professions) do
    if (k == name) then
      return v[1]
    end
  end
end
