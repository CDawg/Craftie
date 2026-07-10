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
-- Korean (Korea)

Craftie.LDetect = "koKR"
if GetLocale() ~= Craftie.LDetect then return end

Craftie._L = {
  Loaded= Craftie.LDetect, --detect what loaded

	Title = "크래프티",
  Game = {
    "클래식 애니버서리",
    "TBC 애니버서리",
    "WoTLK 애니버서리",
  },
  Placeholder_Players = "장인 검색...",
  Placeholder_Recipes = "레시피 검색...",
  Player_PageNameListing = "라이브러리",

  Notification = {
    Collecting = "Collecting",
    Outdated   = "has outdated data",
    Adding     = "Adding",
    Detected   = {"Detected", "Open", "to build your profile."},
  },

  MenuSelPlayers = {
    "모든 장인",
    "길드 장인"
  },
  MenuSelRecipes = "모든 장인 레시피 검색",

  MMTooltip = {
    {"왼쪽 클릭", "오픈 크래프티"},
    {"오른쪽 클릭", "크래프티 옵션"}
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
    Defaults = {
      Title = "Crafter Listing",
      {"Show The Game Library For Every Recipe", "Show the entire recipe library for each|nprofession within the player list for all phases [Recommended]"},
      {"Default Crafter Listing",                 "Default Listing: All Crafters or only Guild Crafters when opening Craftie"},
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
      {"Automatically Open The Crafter's Book", "When clicking the Crafter's profession link in chat automatically open their recipe book"}
    },
    Frame = {
      Title = "Frame Options",
      {"Frame Level", "Frame level to have Craftie open on other frames such as professions, auction, other addon frames, etc...|nLOW = Behind other frames|nHIGH = On top of other frames"},
      {"LOW", "MEDIUM", "HIGH"}
    }
  }
}
