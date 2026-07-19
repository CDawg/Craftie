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

-- https://warcraft.wiki.gg/wiki/API_GetLocale
-- Italian (Italy)

Craftie.LDetect = "itIT"
if GetLocale() ~= Craftie.LDetect then return end

Craftie._L = {
  Loaded= Craftie.LDetect, --detect what loaded

	Title = "Artigiano",
  Game = {
    "Aniversario Classico",
    "Aniversario TBC",
    "Aniversario WoTLK",
  },
  Placeholder_Players = "Cerca Artigiani...",
  Placeholder_Recipes = "Cerca Ricette...",
  Player_PageNameListing = "Biblioteca",

  Notification = {
    Collecting = "Collecting",
    Outdated   = "has outdated data",
    Adding     = "Adding",
    Detected   = {"Detected", "Open", "to build your profile."},
  },

  MenuSelPlayers = {
    "Tutti gli Artigiani",
    "Artigiani del Gilda"
  },
  MenuSelRecipes = "Cerca tutte le Ricette degli Artigiani",

  MMTooltip = {
    {"Left Click", "Open Craftie"},
    {"Shift + Left Click", "Craftie Options"},
    {"Right Click", "Craftie Orders"}
  },

  Navigation = {"Professions", "Orders", "Updates", "Help"},

  --translate
  Professions = {
    Alchemy       = {"Alchemy", "Elixir Master", "Potion Master", "Transmute Master"},
    Blacksmithing = {"Blacksmithing", "Armorsmith", "Weaponsmith", "Master Swordsmith", "Master Hammersmith", "Master Axesmith"},
    Cooking       = {"Cooking"},
    Enchanting    = {"Enchanting"},
    Engineering   = {"Engineering", "Gnomish Engineer", "Goblin Engineer"},
    Leatherworking= {"Leatherworking"},
    Tailoring     = {"Tailoring", "Mooncloth Tailoring", "Shadoweave Tailoring", "Spellfire Tailoring"},
    Jewelcrafting = {"Jewelcrafting"},
    Inscription   = {"Inscription"}
  },

  Options = {
    Crafters = {
      Title = "Crafter Listing",
      {"Show The Library For Every Recipe", "Show the entire recipe library for each|nprofession within the player list for all phases [Recommended]"},
      {"Default Crafter Listing",           "Default Listing: All Crafters or only Guild Crafters when opening Craftie"},
      {"Show Guild Crafters In Green",      "Identify guild members in the Crafter list as the iconic guild green color"},
    },
    Notifications = {
      Title = "Order Notifications",
      {"Disable Notifications While In Raid",        "Disable incoming order notifications while in a Raid"},
      {"Disable Notifications While In An Instance", "Disable incoming order notifications while in an Instance"},
      {"Disable Notifications While In Combat",      "Disable incoming order notifications while in combat"},
    },
    Recipes = {
      Title = "Recipe Listing",
      {"Show Crafter's Leveling Color Thresholds", "Show the Crafter's leveling threshold colors. [Gray, Green, Yellow, and Orange]"},
      {"Automatically Open The Crafter's Recipe Book", "When clicking the Crafter's profession link in chat, automatically open their recipe book"}
    },
    Frame = {
      Title = "Frame Options",
      {"Frame Level", "Craftie frame level determines the z-order layer on top of other frames/addons|nLOW         = Behind other frames|nMEDIUM = Between layers|nHIGH        = Above most frames [Default - Recommended]"},
      {"HIGH", "MEDIUM", "LOW"},
    },
  }
}