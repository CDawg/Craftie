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

   --whisper self to prep incoming comms
  Craftie.SendPacket(Craftie.Packet.Prefix.Load, Craftie.player.name, "WHISPER", Craftie.player.name)

  --TOCADB[TOCA.player.combine]["CONFIG"]["MAINPOS"] = point .. "," .. xOfs .. "," .. yOfs
  --CraftieDB[TOCA.player.combine]["CONFIG"]["MAINPOS"] = point .. "," .. xOfs .. "," .. yOfs

  if (CraftieDB == nil) then
    CraftieDB = {}
  end

  --build everything bassed off of server, then faction
  if (CraftieDB[Craftie.player.realm] == nil) then
    CraftieDB[Craftie.player.realm] = {}
    if (CraftieDB[Craftie.player.realm][Craftie.player.faction] == nil) then
      CraftieDB[Craftie.player.realm][Craftie.player.faction] = {}
    end
  end

  print(Craftie.Stamp .. " Loaded. Type " .. Craftie._G.CMD .. " to open.")
end

C_Timer.After(0.5, function()
  Craftie.Init()
end)
