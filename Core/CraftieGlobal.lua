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
  Author = "Porthias",
  Width  = 820,
  Height = 460,
  Prefix = "Craftie",
  Update = 20260608,
  Icon   = "UI-Craftie-Icon",
}

Craftie._G.Version = C_AddOns.GetAddOnMetadata(Craftie._G.Prefix, "version")

Craftie._G.Font={}
Craftie._G.Font.Style= "Interface/Addons/Craftie/Fonts/FRIZQT__.ttf"
Craftie._G.Font.Size = 11
Craftie._G.Font.Color = "|cffFF9524"

Craftie._G.Path = "Interface/Addons/Craftie/"
Craftie._G.Title = Craftie._G.Font.Color .. Craftie._G.Prefix .. "|r"
Craftie._G.Stamp = Craftie._G.Title .. " v" .. Craftie._G.Version

Craftie.LogKey = 0
Craftie.SortOrder = 0
function Craftie:Notification(msg, type)
  local logstring= ""
  if (Craftie.DEBUG <= 0) then
    Craftie.DEBUG = 1 --prevent errors, but always show chat
  end
  if (type[1] <= Craftie.DEBUG) then
    print(Craftie._G.Title .. " " .. type[2] .. ": " .. msg)
  end
  --print("type: " .. type[1] .. " | " .. type[2])
  --log everything, regardless of debug mode
  if (Craftie.Frame ~= nil) then
    Craftie:Log(type[2], msg)
  end
end

Craftie.MAX_REAGENTS = 6
Craftie.MAX_RECIPES = 600
Craftie.MAX_PLAYERS = 300 --per profession
Craftie.MAX_ITEMIDS = 60000 -- some items go up to 58k

Craftie.ProfessionDefault = Craftie:CopyTable(Craftie.Profession.Alchemy)
--Craftie.ProfessionSearch = Craftie:CopyTable(Craftie.Profession.Alchemy)

Craftie.Placeholder_Players = "Search Crafters..."
Craftie.Placeholder_Recipes = "Search Recipes..."
Craftie.Selected_Players = 1
Craftie.Selected_Recipes = 1
Craftie.Selected_ViewAll = "All Alchemy Recipes" --default
Craftie.Selected_Name = ""
Craftie.Preload = "|cFF27CCF5Loading Data...|r"
Craftie.Page = "Alchemy" --default

-- Global Frames
Craftie.Frame={}
--Craftie.Frame = CreateFrame("Frame", 'Craftie.Frame', UIParent, "ButtonFrameTemplate")
Craftie.Frame = CreateFrame("Frame", 'Craftie.Frame', UIParent, "BasicFrameTemplate")
Craftie.Frame.Search={}

Craftie.EnableScrollFrames = true

Craftie.TabBar_X = 42
Craftie.TabBar_Y = 50
