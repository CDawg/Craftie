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
    CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["ORDERS"] = {}
    CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["FAVS"] = {}
  end

  --same server, diff faction
  if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction] == nil) then
    CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction] = {}
  end

  --crafter directory shared with same faction and server. do not overwrite
  if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"] == nil) then
    Craftie:Notification("Building New Crafter Directory: " .. Craftie.Player.Realm .. "-" ..  Craftie.Player.Faction, Craftie.CHAT.INFO)
    CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"] = {} --binary link object
    CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CACHE"]= {} --cache list built for multi search indexing

    for k,v in pairs(Craftie.Professions) do
      CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"][v[1]:upper()] = {} --organize by prof
      CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CACHE"][v[1]:upper()] = {} --build an indexer used only for global searches
    end
  end

  --new characters, same realm
  if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name] == nil) then
    CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name] = {}
    CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["CONFIG"] = {}
    CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["ORDERS"] = {}
    CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["FAVS"] = {}
  else
    Craftie.Save.Player.CONFIG= CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["CONFIG"]
    Craftie.Save.Player.ORDERS= CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["ORDERS"]
    Craftie.Save.Player.FAVS  = CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["FAVS"]

    if (Craftie.Save.Player.CONFIG["POS_MAIN"] ~= nil) then
      local FramePos = {}
      FramePos = Craftie:Split(Craftie.Save.Player.CONFIG["POS_MAIN"], ",")
      Craftie.Frame:ClearAllPoints()
      Craftie.Frame:SetPoint(FramePos[1], tonumber(FramePos[2]), tonumber(FramePos[3]))
    end

    if (Craftie.Save.Player.CONFIG["POS_LOGGER"] ~= nil) then
      local FramePos = {}
      FramePos = Craftie:Split(Craftie.Save.Player.CONFIG["POS_LOGGER"], ",")
      Craftie.Logger:ClearAllPoints()
      Craftie.Logger:SetPoint(FramePos[1], tonumber(FramePos[2]), tonumber(FramePos[3]))
    end

    if (Craftie.Save.Player.CONFIG["DEBUGLEVEL"] ~= nil) then
      Craftie.DEBUGLEVEL = tonumber(Craftie.Save.Player.CONFIG["DEBUGLEVEL"])
    end

    if (Craftie.Save.Player.CONFIG["POS_MINIMAP"] ~= nil) then
      local minimapIconPos = Craftie:Split(Craftie.Save.Player.CONFIG["POS_MINIMAP"], ",")
      --print("Getpoint " .. Craftie.Frame.Button.Minimap:GetPoint())
      --print("Setpoint " .. "TOPLEFT, Minimap, TOPLEFT" .. "," .. minimapIconPos[1] .. "," .. minimapIconPos[2])
      Craftie:UpdateMapButton()
      Craftie.Frame.Button.Minimap:SetPoint("TOPLEFT", Minimap, "TOPLEFT", minimapIconPos[1], minimapIconPos[2])
    end

    Craftie:Notification("Loading Profile: [" ..  Craftie.Player.Faction .. "]".. Craftie.Player.Realm .. "-" .. Craftie.Player.Name, Craftie.CHAT.INFO)
  end

  Craftie.Save.Player.CONFIG= CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["CONFIG"]
  Craftie.Save.Player.ORDERS= CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["ORDERS"]
  Craftie.Save.Player.FAVS  = CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["FAVS"]
  Craftie.Save.Account.BLOB = CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"]
  Craftie.Save.Account.CACHE= CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CACHE"]
end
