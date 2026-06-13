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

function Craftie:SaveData()

  --new account
  if (CraftieDB == nil) then
    CraftieDB = {}
    Craftie:Notification("Building New Profile: " .. Craftie.Player.Realm .. "-" ..  Craftie.Player.Faction .. "-" .. Craftie.Player.Name, Craftie.CHAT.INFO)
  end

  --new realm, build everything
  if (CraftieDB[Craftie.Player.Realm] == nil) then
    CraftieDB[Craftie.Player.Realm] = {}
    CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction] = {}
    CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name] = {}
    CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["CONFIG"] = {}
    CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["FAVS"] = {}
  end

  --diff faction
  if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction] == nil) then
    CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction] = {}
  end

  --crafter directory shared with same faction and server. dont overwrite
  if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"] == nil) then
    Craftie:Notification("Building New Crafter Directory: " .. Craftie.Player.Realm .. "-" ..  Craftie.Player.Faction, Craftie.CHAT.INFO)
    CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"] = {} --shared across characters for server & faction
    CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CACHE"] = {} --shared across characters for server & faction
    for k,v in pairs(Craftie.Professions) do
      CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"][v[1]:upper()] = {} --organize by prof
      CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CACHE"][v[1]:upper()] = {} --build an indexer used only for global searches
    end
  end

  if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name] == nil) then
    CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name] = {}
    CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["CONFIG"] = {}
  else
    if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["CONFIG"]["POS_MAIN"]) then
      local FramePos = {}
      FramePos = Craftie:Split(CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["CONFIG"]["POS_MAIN"], ",")
      Craftie.Frame:ClearAllPoints()
      Craftie.Frame:SetPoint(FramePos[1], tonumber(FramePos[2]), tonumber(FramePos[3]))
    end
    if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["CONFIG"]["POS_LOGGER"]) then
      local FramePos = {}
      FramePos = Craftie:Split(CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["CONFIG"]["POS_LOGGER"], ",")
      Craftie.Logger:ClearAllPoints()
      Craftie.Logger:SetPoint(FramePos[1], tonumber(FramePos[2]), tonumber(FramePos[3]))
    end

    if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["CONFIG"]["DEBUGLEVEL"]) then
      Craftie.DEBUGLEVEL = tonumber(CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["CONFIG"]["DEBUGLEVEL"])
    end

    if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["CONFIG"]["POS_MINIMAP"]) then
      local minimapIconPos = Craftie:Split(CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["CONFIG"]["POS_MINIMAP"], ",")
      --print("Getpoint " .. Craftie.Frame.Button.Minimap:GetPoint())
      --print("Setpoint " .. "TOPLEFT, Minimap, TOPLEFT" .. "," .. minimapIconPos[1] .. "," .. minimapIconPos[2])
      Craftie:UpdateMapButton()
      Craftie.Frame.Button.Minimap:SetPoint("TOPLEFT", Minimap, "TOPLEFT", minimapIconPos[1], minimapIconPos[2])
    end

    --if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["CONFIG"]["SHARE"]) then
      --disable sharing across characters of same server and faction?
    --end

    Craftie:Notification("Loading Profile: [" ..  Craftie.Player.Faction .. "]".. Craftie.Player.Realm .. "-" .. Craftie.Player.Name, Craftie.CHAT.INFO)

    Craftie:Notification("Loaded. Type " .. SLASH_Craftie1 .. " for commands.", Craftie.CHAT.INFO)
  end
end
