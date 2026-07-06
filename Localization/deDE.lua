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
-- German (Germany), deAT, deCH clients return deDE

Craftie.LDetect = "deDE"
if GetLocale() ~= Craftie.LDetect then return end

Craftie._L = {
  Loaded= Craftie.LDetect, --detect what loaded

	Title = "Craftie",
  Game = {
    "Klassisches Jubiläum",
    "TBC-Jubiläum",
    "WOTLK-Jubiläum",
  },
  Placeholder_Players = "Suche nach Handwerkern...",
  Placeholder_Recipes = "Suche nach Rezepten...",
  Player_PageNameListing = "Bibliothek",

  MenuSelPlayers = {
    "Alle Handwerker",
    "Gilden Handwerker"
  },
  MenuSelRecipes = "Alle Bastelrezepte durchsuchen",

  MMTooltip = {
    {"Linksklick", "Öffne Craftie"},
    {"Rechtsklick", "Craftie-Optionen"}
  },

  Navigation = {"Berufe", "Bestellungen", "Aktualisierungen", "Helfen"},

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
    Library = {
      "Show The Profession Library For Every Recipe",
      "Show the entire recipe library for each|nprofession within the player list for all phases"
    },
    Notifications = {
      header = "Order Notifications",
      {"Disable Notifications While In Raid",        "Disable incoming order notifications while in a Raid"},
      {"Disable Notifications While In An Instance", "Disable incoming order notifications while in an Instance"},
      {"Disable Notifications While In Combat",      "Disable incoming order notifications while in combat"},
    },
    Frame = {
      header = "",
      set = {"LOW", "MEDIUM", "HIGH"}
    }
  }
}
