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

--https://warcraft.wiki.gg/wiki/API_GetLocale
--English (United States), enGB clients return enUS

Craftie.LDetect = "enUS"
if GetLocale() ~= Craftie.LDetect then return end

Craftie._L = {
  Loaded= Craftie.LDetect, --detect what loaded

	Title = "Craftie",
  Game = {
    "Classic Anniversary",
    "TBC Anniversary",
    "WoTLK Anniversary",
  },
  Placeholder_Players = "Search Crafters...",
  Placeholder_Recipes = "Search Recipes...",
  Player_PageNameListing = "Library",

  MenuSelPlayers = {
    "All Crafters",
    "Guild Crafters"
  },
  MenuSelRecipes = "Search All Crafter Recipes",
  MMTooltip = {
    {"Left Click", "Open Craftie"},
    {"Right Click", "Craftie Options"}
  }
}
