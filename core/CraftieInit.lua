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
  Craftie.TabBottomSelect(1, false)
  Craftie.OpenProfessionList(Craftie.Profession.Query, "")

  if (CraftieDB == nil) then
    CraftieDB = {}
    Craftie.Notification("New Profile: " .. Craftie.player.realm .. "-" ..  Craftie.player.faction .. "-" .. Craftie.player.name, true)
  end

  if (CraftieDB[Craftie.player.realm] == nil) then
    CraftieDB[Craftie.player.realm] = {}
    CraftieDB[Craftie.player.realm][Craftie.player.faction] = {}
    CraftieDB[Craftie.player.realm][Craftie.player.faction][Craftie.player.name] = {}
    CraftieDB[Craftie.player.realm][Craftie.player.faction][Craftie.player.name]["CONFIG"] = {}

    if (CraftieDB[Craftie.player.realm][Craftie.player.faction]["CRAFTERS"] == nil) then
      CraftieDB[Craftie.player.realm][Craftie.player.faction]["CRAFTERS"] = {} --shared across characters for server & faction
    end

    Craftie.Notification("Building Profile: " .. Craftie.player.realm .. "-" ..  Craftie.player.faction)
  else
    if (CraftieDB[Craftie.player.realm][Craftie.player.faction][Craftie.player.name]["CONFIG"]["POS_MAIN"]) then
      local FramePos = {}
      FramePos = Craftie.Split(CraftieDB[Craftie.player.realm][Craftie.player.faction][Craftie.player.name]["CONFIG"]["POS_MAIN"], ",")
      Craftie.Frame:ClearAllPoints()
      Craftie.Frame:SetPoint(FramePos[1], tonumber(FramePos[2]), tonumber(FramePos[3]))
    end
    if (CraftieDB[Craftie.player.realm][Craftie.player.faction][Craftie.player.name]["CONFIG"]["POS_MINIMAP"]) then
 	    local minimapIconPos = Craftie.Split(CraftieDB[Craftie.player.realm][Craftie.player.faction][Craftie.player.name]["CONFIG"]["POS_MINIMAP"], ",")
	    if ((minimapIconPos[1]) and (minimapIconPos[2])) then
        Craftie.UpdateMapButton()
	      Craftie.Frame.Button.Minimap:SetPoint("TOPLEFT", Minimap, "TOPLEFT", minimapIconPos[1]+126, minimapIconPos[2]+22)
      end
    end
    --if (CraftieDB[Craftie.player.realm][Craftie.player.faction][Craftie.player.name]["CONFIG"]["SHARE"]) then
      -- disable sharing across characters of same server and faction?
    --end

    Craftie.Notification("Loading Profile: " .. Craftie.player.realm .. "-" ..  Craftie.player.faction .. "-" .. Craftie.player.name)
  end

  print(Craftie._G.Stamp .. " Loaded. Type " .. SLASH_Craftie1 .. " to open.")

   --whisper self to prep incoming comms
  Craftie.SendPacket(Craftie.Packet.Prefix.Load, Craftie.player.name, "WHISPER", Craftie.player.name)
end

C_Timer.After(0.5, function()
  Craftie.Init()
end)
