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
  Craftie:Notification("v" .. Craftie._G.Version .. " " .. Craftie.Game.Name .. " [" .. Craftie._L.Loaded .. "] Initializing. Type " .. SLASH_Craftie1 .. " for commands.", Craftie.CHAT.INFO)
  Craftie:AlphaSortProfessionLib() --sanity alpha sorting & version control
  Craftie:BuildReagentCaching()
  Craftie:BuildChatHooks()
  Craftie:SaveDataBuild()
  Craftie:BuildPersonalTooltip()
  Craftie:TabSelectBottom(1, false)
  Craftie:BuildTooltipHooks()

  Craftie.Frame:SetScript("OnHide", function(self)
    Craftie.OpenState = 0
    CraftieDialog:Hide()
    Craftie:CloseAllPlayerMenus() --clear out the player sub menus
    --Craftie:Notification("Craftie Closed", Craftie.CHAT.FUNC)
    PlaySound(SOUNDKIT.IG_SPELLBOOK_CLOSE)
  end)
  Craftie.Frame:SetScript("OnShow", function(self)
    Craftie.OpenState = 1
    CraftieDialog:Hide()
    Craftie:CloseAllPlayerMenus()
    --Craftie:Notification("Craftie Opened", Craftie.CHAT.FUNC)
    PlaySound(SOUNDKIT.IG_SPELLBOOK_OPEN)
    Craftie:LoadOptions()
  end)

  --whisper self to prep incoming comms
  Craftie:PacketSend(Craftie.Packet.Prefix.Load, Craftie.Player.Name, "WHISPER", Craftie.Player.Name)

  C_Timer.After(2, function()
    if (IsInGuild()) then
      Craftie:UpdatePlayerTooltip("GUILD")

      local function HookGuildFrame()
        if ((not GuildFrame) or Craftie.GuildFrameShowHooked) then
          return
        end

        GuildFrame:HookScript("OnShow", function(self)
          Craftie:Notification("GuildFrame:Show() == classic", Craftie.CHAT.FUNC)
          Craftie.GuildFrameUsing = 1
          Craftie:BuildGuildRosterTooltip()
        end)
        Craftie.GuildFrameShowHooked = true

        -- ADDON_LOADED can fire after the guild frame has already been shown.
        if (GuildFrame:IsShown()) then
          Craftie.GuildFrameUsing = 1
          Craftie:BuildGuildRosterTooltip()
        end
      end

      HookGuildFrame()

      local function HookCommunitiesFrame()
        if ((not CommunitiesFrame) or Craftie.CommunitiesFrameShowHooked) then
          return
        end

        CommunitiesFrame:HookScript("OnShow", function(self)
          Craftie:Notification("CommunitiesFrame:Show() == retail", Craftie.CHAT.FUNC)
          Craftie.GuildFrameUsing = 2
          Craftie:BuildGuildRosterTooltip()
        end)
        Craftie.CommunitiesFrameShowHooked = true
      end

      HookCommunitiesFrame()
      if (((not Craftie.GuildFrameShowHooked) or (not Craftie.CommunitiesFrameShowHooked)) and EventRegistry) then
        EventRegistry:RegisterFrameEventAndCallback("ADDON_LOADED", function(owner, loadedAddonName)
          if (loadedAddonName == "Blizzard_GuildUI") then
            HookGuildFrame()
            if (Craftie.GuildFrameShowHooked) then
              EventRegistry:UnregisterFrameEventAndCallback("ADDON_LOADED", owner)
            end
          elseif (loadedAddonName == "Blizzard_Communities") then
            HookCommunitiesFrame()
            if (Craftie.CommunitiesFrameShowHooked) then
              EventRegistry:UnregisterFrameEventAndCallback("ADDON_LOADED", owner)
            end
          end
        end)
      end
    end
    Craftie:GetProfessionEntry()
    Craftie:LoadOptions()
    Craftie:GetCraftOrders()

    --[==[
    local order = -1
    --convert from english to locale
    for k,v in pairs(Craftie.Professions) do
      order = order +1
      C_Timer.After(order*10, function()
        if (CraftieDB[GetLocale()][Craftie._G.Version][v[2]:upper()] == nil) then
          Craftie:Notification(Craftie.Color.Blue .. "[" .. k .. "/" .. #Craftie.Professions .. "] Locale ".. GetLocale() .. " Conversion|r " .. v[2] .. "...", Craftie.CHAT.INFO)
          Craftie:ProfessionLocaleConversion(v[2])
        end
      end)
    end
    ]==]--
    --Craftie:ProfessionLocaleConversion("Alchemy")
  end)
  --Craftie:BuildWorldRosterTooltip()
  --Craftie:ProfessionLocaleConversion("Alchemy", "enUS")
  --CommunitiesFrame.GuildInfoTab:GetScript("OnClick")( CommunitiesFrame.GuildInfoTab )
  Craftie:Notification("Craftie:Init()", Craftie.CHAT.FUNC)
end
