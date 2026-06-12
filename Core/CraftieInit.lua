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
  --Craftie:TabSelect(1) --default 1st profession
  Craftie:TabBottomSelect(1)
  Craftie.BuildChatHooks()
  Craftie:SaveData()
  Craftie:BuildPersonalTooltip()
  --Craftie:UpdatePlayerTooltip(false)

  Craftie.Frame:SetScript("OnHide", function(self)
    Craftie.OpenState = 0
    CraftieDialog:Hide()
    Craftie:CloseAllPlayerMenus() --clear out the player sub menus
    Craftie:Notification("Craftie Closed", Craftie.CHAT.FUNC)
    PlaySound(SOUNDKIT.IG_SPELLBOOK_CLOSE)
  end)
  Craftie.Frame:SetScript("OnShow", function(self)
    Craftie.OpenState = 1
    CraftieDialog:Hide()
    Craftie:CloseAllPlayerMenus()
    Craftie:Notification("Craftie Opened", Craftie.CHAT.FUNC)
    PlaySound(SOUNDKIT.IG_SPELLBOOK_OPEN)
  end)

  --whisper self to prep incoming comms
  Craftie:SendPacket(Craftie.Packet.Prefix.Load, Craftie.Player.Name, "WHISPER", Craftie.Player.Name)

  --print(Craftie.Player.Language)
end

--[==[
TODO
"frFR": French (France)
"deDE": German (Germany)
"enGB": English (Great Britain) if returned, can substitute 'enUS' for consistancy
"enUS": English (America)
"itIT": Italian (Italy)
"koKR": Korean (Korea) RTL - right-to-left
"zhCN": Chinese (China) (simplified) implemented LTR left-to-right in WoW
"zhTW": Chinese (Taiwan) (traditional) implemented LTR left-to-right in WoW
"ruRU": Russian (Russia)
"esES": Spanish (Spain)
"esMX": Spanish (Mexico)
"ptBR": Portuguese (Brazil)

]==]--