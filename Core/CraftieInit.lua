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

function Craftie.Init()
  Craftie.BuildReagentGaps()
  Craftie.TabSelect(1, false) --default 1st profession
  Craftie.OpenProfessionList(Craftie.Profession.Query, "")
  Craftie.TabBottomSelect(1, false)
  Craftie.AlphaSortProfessionLib()

  --new account
  if (CraftieDB == nil) then
    CraftieDB = {}
    Craftie.Notification("Building New Profile: " .. Craftie.Player.Realm .. "-" ..  Craftie.Player.Faction .. "-" .. Craftie.Player.Name)
  end

  --new realm, build everything
  if (CraftieDB[Craftie.Player.Realm] == nil) then
    CraftieDB[Craftie.Player.Realm] = {}
    CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction] = {}
    CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name] = {}
    CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["CONFIG"] = {}
  end

  --diff faction
  if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction] == nil) then
    CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction] = {}
  end

  --crafter directory may be shared with factions. dont overwrite
  if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CRAFTERS"] == nil) then
    Craftie.Notification("Building New Crafter Directory: " .. Craftie.Player.Realm .. "-" ..  Craftie.Player.Faction)
    CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CRAFTERS"] = {} --shared across characters for server & faction
    for k,v in pairs(Craftie.Professions) do
      CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["CRAFTERS"][v[1]:upper()] = {} --organize by prof
    end
  end

  if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name] == nil) then
    CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name] = {}
    CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["CONFIG"] = {}
  else
    if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["CONFIG"]["POS_MAIN"]) then
      local FramePos = {}
      FramePos = Craftie.Split(CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["CONFIG"]["POS_MAIN"], ",")
      Craftie.Frame:ClearAllPoints()
      Craftie.Frame:SetPoint(FramePos[1], tonumber(FramePos[2]), tonumber(FramePos[3]))
    end

    if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["CONFIG"]["POS_MINIMAP"]) then
      local minimapIconPos = Craftie.Split(CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["CONFIG"]["POS_MINIMAP"], ",")
      if ((minimapIconPos[1]) and (minimapIconPos[2])) then
        Craftie.UpdateMapButton()
        Craftie.Frame.Button.Minimap:SetPoint("TOPLEFT", Minimap, "TOPLEFT", minimapIconPos[1]+126, minimapIconPos[2]+22)
      end
    end
    --if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["CONFIG"]["SHARE"]) then
      --disable sharing across characters of same server and faction?
    --end

    Craftie.Notification("Loading Profile: " .. Craftie.Player.Realm .. "-" ..  Craftie.Player.Faction .. "-" .. Craftie.Player.Name)

    --print(Craftie._G.Stamp .. " Loaded. Type " .. SLASH_Craftie1 .. " to open.")
    Craftie.Notification("Loaded. Type " .. SLASH_Craftie1 .. " to open.")

    --whisper self to prep incoming comms
    Craftie.SendPacket(Craftie.Packet.Prefix.Load, Craftie.Player.Name, "WHISPER", Craftie.Player.Name)
  end
end

C_Timer.After(0.3, function()
  Craftie.Init()
end)
