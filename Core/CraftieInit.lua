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

function Craftie:Init()
  Craftie:AlphaSortProfessionLib() --sanity alpha sorting & version control
  Craftie:BuildReagentGaps()
  Craftie:TabSelect(1) --default 1st profession
  --Craftie:OpenProfessionList(Craftie.ProfessionDefault, "", "")
  Craftie:TabBottomSelect(1)
  Craftie.BuildChatHooks()
  Craftie:SaveData()

  Craftie.Frame:SetScript("OnHide", function(self)
    Craftie.OpenState = 0
    Craftie:CloseAllPlayerMenus() --clear out the player sub menus
    Craftie:Notification("Craftie Closed", Craftie.TYPE.FUNC)
    PlaySound(SOUNDKIT.IG_SPELLBOOK_CLOSE)
  end)
  Craftie.Frame:SetScript("OnShow", function(self)
    Craftie.OpenState = 1
    Craftie:CloseAllPlayerMenus()
    Craftie:Notification("Craftie Opened", Craftie.TYPE.FUNC)
    PlaySound(SOUNDKIT.IG_SPELLBOOK_OPEN)
  end)

  --whisper self to prep incoming comms
  Craftie:SendPacket(Craftie.Packet.Prefix.Load, Craftie.Player.Name, "WHISPER", Craftie.Player.Name)

  Craftie:UpdateCrafterList()
end
