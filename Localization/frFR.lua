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
-- French (France)

Craftie.LDetect = "frFR"
if GetLocale() ~= Craftie.LDetect then return end

Craftie._L = {
  Loaded= Craftie.LDetect, --detect what loaded

	Title = "Craftie",
  Game = {
    "Aniversaire Classique",
    "Aniversaire TBC",
    "Aniversaire WoTLK",
  },
  Placeholder_Players = "Rechercher les Artisans...",
  Placeholder_Recipes = "Rechercher les Recettes...",
  Player_PageNameListing = "Bibliothèque",

  MenuSelPlayers = {
    "Tous les Artisans",
    "Artisans de Guilde"
  },
  MenuSelRecipes = "Rechercher toutes les Recettes d'Artisanat",

  MMTooltip = {
    {"Clic gauche", "Ouvrir Craftie"},
    {"Clic droit", "Options de Craftie"}
  },

  Navigation = {"Métiers", "Ordres", "Mises à jour", "Aide"},

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
      header = "Player Listing",
      {"Show The Game Library For Every Recipe", "Show the entire recipe library for each|nprofession within the player list for all phases [Recommended]"},
      {"Default Player Listing",                 "Default Listing: All Crafters or only Guild Crafters when opening Craftie"},
    },
    Notifications = {
      header = "Order Notifications",
      {"Disable Notifications While In Raid",        "Disable incoming order notifications while in a Raid"},
      {"Disable Notifications While In An Instance", "Disable incoming order notifications while in an Instance"},
      {"Disable Notifications While In Combat",      "Disable incoming order notifications while in combat"},
    },
    Frame = {
      header = {"Frame Level", "Frame level to have Craftie open on other frames such as professions, auction, other addon frames, etc...|nLOW = Behind other frames|nHIGH = On top of other frames"},
      set = {"LOW", "MEDIUM", "HIGH"}
    }
  }
}
