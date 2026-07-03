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
-- Chinese (Traditional, Taiwan)

Craftie.LDetect = "zhTW"
if GetLocale() ~= Craftie.LDetect then return end

Craftie._L = {
  Loaded= Craftie.LDetect, --detect what loaded

	Title = "工匠",
  Game = {
    "经典周年纪念版",
    "TBC周年纪念",
    "WoTLK周年纪念",
  },
  Placeholder_Players = "搜尋工匠...",
  Placeholder_Recipes = "搜尋配方...",
  Player_PageNameListing = "圖書館",

  MenuSelPlayers = {
    "所有工匠",
    "公會工匠"
  },
  MenuSelRecipes = "搜索所有工匠配方",
  MMTooltip = {
    {"左键单击", "打开工匠"},
    {"右键单击", "工匠选项"}
  }
}
