--[==[
Copyright ©2020 Porthias of Myzrael or Porthios of Myzrael

The contents of this addon, excluding third-party resources, are
copyrighted to Porthios with all rights reserved.
This addon is free to use and the authors hereby grants you the following rights:
1. You may make modifications to this addon for private use only, you
   may not publicize any portion of this addon.
2. Do not modify the name of this addon, including the addon folders.
3. This copyright notice shall be included in all copies or substantial
  portions of the Software.
All rights not explicitly addressed in this license are reserved by
the copyright holders.
]==]--

--Updates / Credits
Craftie.Contributors = {
  "Sweetembrace",
  "Addondev",
  "Zzaps",
  "Slicegirls",
  "Chilease",
}
Craftie.Developers = {
  "Porthias",
  "Portheas",
}

local credits = [==[
And a few nameless heroes on Dreamscythe
Written by Porthias|r (a.k.a. Port)
]==]

local dimensions = {
  W = Craftie.Frame:GetWidth()/2,
  H = Craftie.Frame:GetHeight()-124,
  X = 12,
  Y = -100,
}

Craftie.Updates = CreateFrame("Frame", "Craftie.Updates", Craftie.Frame)
Craftie.Updates:SetWidth(dimensions.W)
Craftie.Updates:SetHeight(dimensions.H)
Craftie.Updates:SetPoint("TOPLEFT", dimensions.X, dimensions.Y)
Craftie.Updates:SetFrameStrata("MEDIUM")

Craftie.UpdatesScrollFrame = CreateFrame("Frame", "Craftie.UpdatesScrollFrame", Craftie.Updates, "InsetFrameTemplate4")
Craftie.UpdatesScrollFrame:SetWidth(Craftie.Updates:GetWidth())
Craftie.UpdatesScrollFrame:SetHeight(Craftie.Updates:GetHeight())
Craftie.UpdatesScrollFrame:SetPoint("TOPLEFT", 0, 0)

Craftie.UpdatesScrollFrameBack = Craftie.UpdatesScrollFrame:CreateTexture(nil, "BACKGROUND")
Craftie.UpdatesScrollFrameBack:SetWidth(Craftie.UpdatesScrollFrame:GetWidth())
Craftie.UpdatesScrollFrameBack:SetHeight(Craftie.UpdatesScrollFrame:GetHeight())
Craftie.UpdatesScrollFrameBack:SetPoint("TOPLEFT", 0, 0)
Craftie.UpdatesScrollFrameBack:SetTexture(Craftie._G.Image.Background.Shadow)
Craftie.UpdatesScrollFrameBack:SetDesaturation(0.3)

Craftie.UpdatesScrollFrame.Child = CreateFrame("ScrollFrame", "Craftie.UpdatesScrollFrame.Child", Craftie.UpdatesScrollFrame, "UIPanelScrollFrameTemplate")
Craftie.UpdatesScrollFrame.Child:SetPoint("TOPLEFT", Craftie.UpdatesScrollFrame, "TOPLEFT", 5, -10)
Craftie.UpdatesScrollFrame.Child:SetPoint("BOTTOMRIGHT", Craftie.UpdatesScrollFrame, "BOTTOMRIGHT", 10, 10)
Craftie.UpdatesScrollFrameChildFrame = CreateFrame("Frame", "Craftie.UpdatesScrollFrameChildFrame", Craftie.UpdatesScrollFrame.Child)
Craftie.UpdatesScrollFrameChildFrame:SetSize(Craftie.Updates:GetWidth(), Craftie.Updates:GetHeight())
Craftie.UpdatesScrollFrame.Child:SetScrollChild(Craftie.UpdatesScrollFrameChildFrame)
Craftie.UpdatesScrollFrame.Child.ScrollBar:ClearAllPoints()
Craftie.UpdatesScrollFrame.Child.ScrollBar:SetPoint("TOPLEFT", Craftie.UpdatesScrollFrame.Child, "TOPRIGHT", -32, -5)
Craftie.UpdatesScrollFrame.Child.ScrollBar:SetPoint("BOTTOMRIGHT", Craftie.UpdatesScrollFrame.Child, "BOTTOMRIGHT", -11, 5)

Craftie:ScrollBarFrame(Craftie.UpdatesScrollFrame.Child)

Craftie.Updates.Data = CreateFrame("EditBox", "Craftie.Updates.Data", Craftie.UpdatesScrollFrameChildFrame)
Craftie.Updates.Data:SetWidth(Craftie.Updates:GetWidth()-20) --scrollbar
Craftie.Updates.Data:SetHeight(Craftie.Updates:GetHeight())
Craftie.Updates.Data:SetFont(Craftie._G.Font.Style.Alpha, Craftie._G.Font.Size, Craftie._G.Font.Flags)
Craftie.Updates.Data:SetPoint("TOPLEFT", 4, -4)
Craftie.Updates.Data:SetMultiLine(true)
Craftie.Updates.Data:ClearFocus()
Craftie.Updates.Data:SetAutoFocus(false)
Craftie.Updates:Hide()

local updates = Craftie.CHANGELOG:gsub("### ", "v"):gsub("*", Craftie.Color.Gold .. " >|r") .. "|n|n|n"
Craftie.Updates.Data:SetText(updates)

--[==[
CREDITS
]==]--
Craftie.Credit = CreateFrame("Frame", nil, Craftie.Frame)
Craftie.Credit:SetWidth(dimensions.W-30)
Craftie.Credit:SetHeight(dimensions.H)
Craftie.Credit:SetPoint("TOPLEFT", dimensions.W+16, dimensions.Y)
Craftie.Credit:SetFrameStrata("MEDIUM")

Craftie.CreditsScrollFrame = CreateFrame("Frame", "Craftie.CreditsScrollFrame", Craftie.Credit, "InsetFrameTemplate4")
Craftie.CreditsScrollFrame:SetWidth(Craftie.Credit:GetWidth())
Craftie.CreditsScrollFrame:SetHeight(Craftie.Credit:GetHeight()) --room for title
Craftie.CreditsScrollFrame:SetPoint("TOPLEFT", 0, 0)

Craftie.CreditsScrollFrameBack = Craftie.CreditsScrollFrame:CreateTexture(nil, "BACKGROUND")
Craftie.CreditsScrollFrameBack:SetWidth(Craftie.CreditsScrollFrame:GetWidth())
Craftie.CreditsScrollFrameBack:SetHeight(Craftie.CreditsScrollFrame:GetHeight())
Craftie.CreditsScrollFrameBack:SetPoint("TOPLEFT", 0, 0)
Craftie.CreditsScrollFrameBack:SetTexture(Craftie._G.Image.Background.Shadow)
Craftie.CreditsScrollFrameBack:SetDesaturation(0.3)

Craftie.CreditsScrollFrame.Child = CreateFrame("ScrollFrame", "Craftie.CreditsScrollFrame.Child", Craftie.CreditsScrollFrame, "UIPanelScrollFrameTemplate")
Craftie.CreditsScrollFrame.Child:SetPoint("TOPLEFT", Craftie.CreditsScrollFrame, "TOPLEFT", 5, -10)
Craftie.CreditsScrollFrame.Child:SetPoint("BOTTOMRIGHT", Craftie.CreditsScrollFrame, "BOTTOMRIGHT", 10, 10)
Craftie.CreditsScrollFrameChildFrame = CreateFrame("Frame", "Craftie.CreditsScrollFrameChildFrame", Craftie.CreditsScrollFrame.Child)
Craftie.CreditsScrollFrameChildFrame:SetSize(Craftie.Credit:GetWidth(), Craftie.Credit:GetHeight())
Craftie.CreditsScrollFrame.Child:SetScrollChild(Craftie.CreditsScrollFrameChildFrame)
Craftie.CreditsScrollFrame.Child.ScrollBar:ClearAllPoints()
Craftie.CreditsScrollFrame.Child.ScrollBar:SetPoint("TOPLEFT", Craftie.CreditsScrollFrame.Child, "TOPRIGHT", -32, -5)
Craftie.CreditsScrollFrame.Child.ScrollBar:SetPoint("BOTTOMRIGHT", Craftie.CreditsScrollFrame.Child, "BOTTOMRIGHT", -11, 5)

Craftie:ScrollBarFrame(Craftie.CreditsScrollFrame.Child)

Craftie.Credit.Data = CreateFrame("EditBox", nil, Craftie.CreditsScrollFrameChildFrame)
Craftie.Credit.Data:SetWidth(Craftie.Credit:GetWidth()-20)
Craftie.Credit.Data:SetHeight(Craftie.Credit:GetHeight())
--Craftie.Credit.Data:SetFontObject(GameFontWhite)
Craftie.Credit.Data:SetFont(Craftie._G.Font.Style.Alpha, Craftie._G.Font.Size+1, Craftie._G.Font.Flags)
Craftie.Credit.Data:SetPoint("TOPLEFT", 4, -4)
Craftie.Credit.Data:SetMultiLine(true)
Craftie.Credit.Data:ClearFocus()
Craftie.Credit.Data:SetAutoFocus(false)
Craftie.Credit.Data:SetText(credits)
Craftie.Credit:Hide()
