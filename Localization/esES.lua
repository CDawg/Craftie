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
-- Spanish (Spain)

Craftie.LDetect = "esES"
if GetLocale() ~= Craftie.LDetect then return end

Craftie._L = {
  Loaded= Craftie.LDetect, --detect what loaded

	Title = "Astuto",
  Game = {
    "Aniversario Clásico",
    "Aniversario TBC",
    "Aniversario WoTLK",
  },
  Placeholder_Players = "Buscar Aartesanos...",
  Placeholder_Recipes = "Buscar Recetas...",
  Player_PageNameListing = "Biblioteca",

  MenuSelPlayers = {
    "Todos los artesanos",
    "Artesanos del gremio"
  },
  MenuSelRecipes = "Buscar todos los recetas de artesanos",

  MMTooltip = {
    {"Clic izquierdo", "Manualidad abierta"},
    {"Clic derecho", "Opciones artesanales"}
  },

  Navigation = {"Profesiones", "Órdenes", "Actualizaciones", "Ayuda"},

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
  }
}
