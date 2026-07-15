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

function Craftie:SaveDataBuild()
  local locale = GetLocale()
  local version = Craftie._G.Version

  --new account
  if (CraftieDB == nil) then
    ---@type table
    CraftieDB = {}
    Craftie:Notification("Building New Profile: " .. Craftie.Player.Realm .. "-" ..  Craftie.Player.Faction .. "-" .. Craftie.Player.Name, Craftie.CHAT.INFO)
  end

  if (CraftieDB[locale]==nil) then
    CraftieDB[locale]={}
  end
  if (CraftieDB[locale][version] == nil) then
    CraftieDB[locale][version] = {}
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
      CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"][v[2]:upper()] = {} --organize by prof
      CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CACHE"][v[2]:upper()] = {} --build an indexer used only for global searches
    end
  end

  for k,v in pairs(Craftie.Professions) do
    if (CraftieDB[locale][version][v[2]:upper()] == nil) then
      CraftieDB[locale][version][v[2]:upper()]={}
    end
  end

  --new characters, same realm
  if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name] == nil) then
    CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name] = {}
    CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["CONFIG"] = {}
    CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["ORDERS"] = {}
    CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["FAVS"] = {}
  else
    Craftie.Save.Account= CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]
    Craftie.Save.Player = CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]

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

    Craftie:Notification("Loading Profile: [" ..  Craftie.Player.Faction .. "] ".. Craftie.Player.Realm .. "-" .. Craftie.Player.Name, Craftie.CHAT.INFO)
  end

  Craftie.Save.Account= CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]
  Craftie.Save.Player = CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]
end

--always called when opening Craftie
function Craftie:LoadOptions()
  --if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["CONFIG"]
  if (Craftie.Save.Account ~= nil) then
    if (Craftie.Save.Player ~= nil) then
      if (Craftie.Save.Player.CONFIG ~= nil) then

        if (Craftie.Save.Player.CONFIG["LEVEL_COLOR"] == 0) then
          Craftie.Options.CheckboxCrafterThreshold:SetChecked(false)
        end
        if (Craftie.Save.Player.CONFIG["AUTO_OPEN"] == 0) then
          Craftie.Options.CheckboxCrafterOpen:SetChecked(false)
        end
        if (Craftie.Save.Player.CONFIG["PLAYER_LIST"] ~= nil) then
          Craftie.PlayerListFilter = Craftie.Save.Player.CONFIG["PLAYER_LIST"]
          Craftie.Frame.DropdownPlayers.text:SetText(Craftie._L.MenuSelPlayers[Craftie.PlayerListFilter])
          Craftie.Options.DropdownPlayerlist.text:SetText(Craftie._L.MenuSelPlayers[Craftie.PlayerListFilter])
          Craftie:UpdateCrafterList()
        end
        if (Craftie.Save.Player.CONFIG["GUILD_GREEN"] == 0) then
          Craftie.Options.CheckboxGuild:SetChecked(false)
        end

        if (Craftie.Save.Player.CONFIG["FRAME_LEVEL"] ~= nil) then
          for k,v in pairs(Craftie.FrameStrata) do
            if (k == Craftie.Save.Player.CONFIG["FRAME_LEVEL"]) then
              Craftie.Frame:SetFrameStrata(v)
              Craftie.Options.DropdownFrame.text:SetText(Craftie._L.Options.Frame[2][k])
              Craftie:Notification("FRAME_LEVEL " .. Craftie.Save.Player.CONFIG["FRAME_LEVEL"], Craftie.CHAT.SAVE)
            end
          end
        end

        for i,v in pairs(Craftie._L.Options.Notifications) do
          if (Craftie.Save.Player.CONFIG["ORDERNOTIF" .. i] == 0) then
            Craftie.Options.CheckboxNotif[i]:SetChecked(false)
          end
        end

      end
    end
  end
  Craftie:Notification("Craftie:LoadOptions()", Craftie.CHAT.FUNC)
end
