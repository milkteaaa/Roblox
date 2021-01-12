local Workspace = game:GetService("Workspace")
local PlayerService = game:GetService("Players")
local RobloxGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = PlayerService.LocalPlayer

game.StarterGui:SetCore("SendNotification", {
    Title = "TPR:R Hax";
    Text = "Welcome " .. Player.Name .. "!";
    Duration = 10
})

local DefaultConfig = {
    PrimaryColor = Color3.fromRGB(50, 50, 100),
    SecondaryColor = Color3.fromRGB(25, 25, 50),
    AccentColor = Color3.fromRGB(15, 15, 25),
    TextColor =  Color3.new(1,1,1),
    Font = Enum.Font.SourceSansSemibold,
    TextSize = 18,
    HeaderWidth = 250,
    HeaderHeight = 35,
    EntryMargin = 1,
    AnimationDuration = 0.5,
    AnimationEasingStyle = Enum.EasingStyle.Linear,
    DefaultEntryHeight = 45
}

if _G.Config == nil then
    _G.Config = DefaultConfig
end

local DropLibCore = loadstring(game:HttpGet("https://gitlab.com/0x45.xyz/droplib/-/raw/master/drop-minified.lua"))()
local DropLib = DropLibCore:Init(_G.Config, RobloxGui)

local Main = DropLib:CreateCategory("Main")
local Sound = Main:CreateSection("Sound")
local Bio = Main:CreateSection("Bio")
local Misc = Main:CreateSection("Misc")

local Achievement = DropLib:CreateCategory("Achievements")
local Lobby = Achievement:CreateSection("Lobby")
local FNAF = Achievement:CreateSection("FNAF")
local FNAF2 = Achievement:CreateSection("FNAF 2")
local FNAF3 = Achievement:CreateSection("FNAF 3")
local FNAF4 = Achievement:CreateSection("FNAF 4")
local FNAFUCN = Achievement:CreateSection("FNAF UCN")

local Credit = DropLib:CreateCategory("Credits")
local LibCreator = Credit:CreateSection("DropLib Creator")
local ScriptCreator = Credit:CreateSection("Script Creator")

local LibMenu = DropLib:CreateCategory("DropLib")
local LibConfig = LibMenu:CreateSection("Config")

Sound:CreateTextBox("SoundId", function(SoundId)
    _G.SoundId = SoundId
end, nil, true, "142376088")

Sound:CreateSlider("Volume", function(Volume)
    _G.Volume = Volume
end, 0, 10, 0.5, true, 0.5)

Sound:CreateSlider("Pitch", function(Pitch)
    _G.Pitch = Pitch
end, 0, 20, 0.25, true, 1)

Sound:CreateSelector("Type", function(Type)
    _G.Type = Type
end, function(GetType)
    return {"PlayOnce", "Looping"}
end, "Looping")

Sound:CreateButton("Play Sound", function()
    if _G.SoundId == nil then
        _G.SoundId = "142376088"
        print("TPRR Hax | SoundId Set To Default")
    end
    if _G.Volume == nil then
        _G.Volume = 0.5
        print("TPRR Hax | Volume Set To Default")
    end
    if _G.Pitch == nil then
        _G.Pitch = 1
        print("TPRR Hax | Pitch Set To Default")
    end
    if _G.Type == nil then
        _G.Type = "Looping"
        print("TPRR Hax | Type Set To Default")
    end
    ReplicatedStorage.Events.AnimatronicSound:FireServer("AlexR32#2514 Was Here", _G.SoundId, _G.Volume, _G.Type, _G.Pitch)
    print("TPRR Hax | Sound Playing | SoundId: " .. _G.SoundId, "Volume: " .. _G.Volume, "Pitch: " .. _G.Pitch, "Type: " .. _G.Type)
end)

Sound:CreateButton("Stop Sound", function()
    ReplicatedStorage.Events.AnimatronicSoundLoopStop:FireServer("AlexR32#2514 Was Here")
    print("TPRR Hax | Sound Stopped")
end)

if game.PlaceId ~= 373513488 then
    Bio:CreateSwitch("Toggle Name", function(ToggleName)
        ReplicatedStorage.Events.ToggleName:FireServer(ToggleName)
    end, true)

    Bio:CreateTextBox("Change Name", function(Name)
        ReplicatedStorage.Events.NameChange:FireServer(Name)
        print("TPRR Hax | Name: " .. Name)
    end, nil, true, nil)

    Bio:CreateTextBox("Change Image", function(DecalId)
        ReplicatedStorage.Events.ImageChange:FireServer(DecalId)
        print("TPRR Hax | Decal: " .. DecalId)
    end, nil, true, nil)

    Bio:CreateTextBox("Change Description", function(Description)
        ReplicatedStorage.Events.DescChange:FireServer(Description)
        print("TPRR Hax | Description: " .. Description)
    end, nil, true, nil)

    Misc:CreateSwitch("Tape AutoFarm", function(TAF)
        _G.TAF = TAF
        spawn(function()
            while _G.TAF do
                wait(0.5)
                for I,Tape in pairs(Workspace:GetChildren()) do
                    if Tape:IsA("Part") and Tape.Name == "Tape" then
                        local PlayerRootPart = Player.Character.HumanoidRootPart
                        Tape.CFrame = PlayerRootPart.CFrame
                    end
                end
            end
        end) 
    end)
elseif game.PlaceId == 373513488 then
    Bio:CreateTextLabel("This Section Does Not Work\nIn The Lobby")
    Misc:CreateTextLabel("This Section Does Not Work\nIn The Lobby")
end

if game.PlaceId == 373513488 then
    Lobby:CreateButton("Unlock Hitbox Badges", function()
        local Character = Player.Character
        local HumanoidRootPart = Character.HumanoidRootPart

        HumanoidRootPart.CFrame = Workspace.BadgeHitboxes.TopFreddy.Part.CFrame
        wait(1)
        HumanoidRootPart.CFrame = Workspace.BadgeHitboxes.GlitchworldLobby.Part.CFrame
        wait(0.5)
        Character:BreakJoints()
    end)
elseif game.PlaceId ~= 373513488 then
    Lobby:CreateTextLabel("This Section Only For Lobby")
end

if game.PlaceId == 599951915 then
    FNAF:CreateButton("Unlock Hitbox Badges", function()
        local Character = Player.Character
        local HumanoidRootPart = Character.HumanoidRootPart

        HumanoidRootPart.CFrame = Workspace.BadgeHitboxes.SecretBathroom:FindFirstChild("Part").CFrame
        wait(1)
        HumanoidRootPart.CFrame = Workspace.BadgeHitboxes.CrimeScene.Part.CFrame
        wait(1)
        HumanoidRootPart.CFrame = Workspace.BadgeHitboxes.GlitchworldFnaf1.Part.CFrame
        wait(0.5)
        Character:BreakJoints()
    end)

    FNAF:CreateButton("Unlock \"Deja Vu?\" Badge", function()
        Workspace.SpawnCars:FireServer(true)
    end)

    FNAF:CreateButton("Unlock \"Frogger\" Badge", function()
        ReplicatedStorage.Spawn:InvokeServer("Happy Frog")

        for _,Car in pairs(Workspace.CarSpawn.Part:GetChildren()) do
            if Car:IsA("MeshPart") and Car.Name == "Car" then
                local PlayerRootPart = Player.Character.HumanoidRootPart
                PlayerRootPart.CFrame = Car.CFrame
            end
        end
    end)
    FNAF:CreateTextLabel("You Need Happy Frog For This\nAchievement")
elseif game.PlaceId ~= 599951915 then
    FNAF:CreateTextLabel("This Section Only For FNAF")
end

if game.PlaceId == 599952427 then
    FNAF2:CreateButton("Unlock Hitbox Badges", function()
        local Character = Player.Character
        local HumanoidRootPart = Character.HumanoidRootPart

        HumanoidRootPart.CFrame = Workspace.BadgeHitboxes.ChihiroFreddy.Part.CFrame
        wait(1)
        HumanoidRootPart.CFrame = Workspace.BadgeHitboxes.VentRepair.Part.CFrame
        wait(1)
        HumanoidRootPart.CFrame = Workspace.BadgeHitboxes.GlitchworldFnaf2.Part.CFrame
        wait(1)
        HumanoidRootPart.CFrame = Workspace.BadgeHitboxes.Crusher.Part.CFrame
        wait(0.5)
        Character:BreakJoints()
    end)
elseif game.PlaceId ~= 599952427 then
    FNAF2:CreateTextLabel("This Section Only For FNAF 2")
end

if game.PlaceId == 2588849144 then
    FNAF3:CreateButton("Unlock Hitbox Badges", function()
        local Character = Player.Character
        local HumanoidRootPart = Character.HumanoidRootPart

        HumanoidRootPart.CFrame = Workspace.BadgeHitboxes.GlitchworldFnaf3.Part.CFrame
        wait(1)
        HumanoidRootPart.CFrame = Workspace.BadgeHitboxes.Clocktower.Part.CFrame
        wait(0.5)
        Character:BreakJoints()
    end)
elseif game.PlaceId ~= 2588849144 then
    FNAF3:CreateTextLabel("This Section Only For FNAF 3")
end

if game.PlaceId == 2588857580 then
    FNAF4:CreateButton("Unlock Hitbox Badges", function()
        local Character = Player.Character
        local HumanoidRootPart = Character.HumanoidRootPart

        HumanoidRootPart.CFrame = Workspace.BadgeHitboxes.Sewers:FindFirstChild("Part").CFrame
        wait(1)
        HumanoidRootPart.CFrame = Workspace.BadgeHitboxes.CircusTentTop.Part.CFrame
        wait(1)
        HumanoidRootPart.CFrame = Workspace.BadgeHitboxes.GlitchworldFnaf4.Part.CFrame
        wait(0.5)
        Character:BreakJoints()
    end)
elseif game.PlaceId ~= 2588857580 then
    FNAF4:CreateTextLabel("This Section Only For FNAF 4")
end

if game.PlaceId == 4691657826 then
    FNAFUCN:CreateButton("Unlock Hitbox Badges", function()
        local Character = Player.Character
        local HumanoidRootPart = Character.HumanoidRootPart

        HumanoidRootPart.CFrame = Workspace.BadgeHitboxes.UCNLava.Part.CFrame
        wait(1)
        HumanoidRootPart.CFrame = Workspace.BadgeHitboxes.GlitchworldUCN.Part.CFrame
        wait(0.5)
        Character:BreakJoints()
    end)
elseif game.PlaceId ~= 4691657826 then
    FNAFUCN:CreateTextLabel("This Section Only For FNAF UCN")
end

LibCreator:CreateTextLabel("cheb45 @ v3rmillion.net")
LibCreator:CreateTextLabel("cheb#5214 @ discord.com")

ScriptCreator:CreateTextLabel("Alex332Rus @ v3rmillion.net")
ScriptCreator:CreateTextLabel("AlexR32#2514 @ discord.com")

LibConfig:CreateColorPicker("Primary Color", function(Color)
    _G.Config.PrimaryColor = Color
end, true, _G.Config.PrimaryColor)

LibConfig:CreateColorPicker("Secondary Color", function(Color)
    _G.Config.SecondaryColor = Color
end, true, _G.Config.SecondaryColor)

LibConfig:CreateColorPicker("Accent Color", function(Color)
    _G.Config.AccentColor = Color
end, true, _G.Config.AccentColor)

LibConfig:CreateColorPicker("Text Color", function(Color)
    _G.Config.TextColor = Color
end, true, _G.Config.TextColor)

LibConfig:CreateSelector("Text Font", function(Font)
    _G.Config.Font = Enum.Font[Font]
end, function(GetFont)
    return {"Legacy","Arial","ArialBold","SourceSans","SourceSansBold","SourceSansSemibold","SourceSansLight","SourceSansItalic","Bodoni","Garamond","Cartoon","Code","Highway","SciFi","Arcade","Fantasy","Antique","Gotham","GothamSemibold","GothamBold","GothamBlack"}
end, string.sub(tostring(_G.Config.Font),11))

LibConfig:CreateSlider("Text Size", function(Size)
    _G.Config.TextSize = Size
end, 0, 100, 1, true, _G.Config.TextSize)

LibConfig:CreateSlider("Header Width", function(Size)
    _G.Config.HeaderWidth = Size
end, 0, 500, 1, true, _G.Config.HeaderWidth)

LibConfig:CreateSlider("Header Height", function(Size)
    _G.Config.HeaderHeight = Size
end, 0, 100, 1, true, _G.Config.HeaderHeight)

LibConfig:CreateSlider("Entry Margin", function(Size)
    _G.Config.EntryMargin = Size
end, 0, 100, 1, true, _G.Config.EntryMargin)

LibConfig:CreateSlider("Animation Duration", function(Time)
    _G.Config.AnimationDuration = Time
end, 0, 2, 0.1, true, _G.Config.AnimationDuration)

LibConfig:CreateSelector("Animation Easing Style", function(EasingStyle)
    _G.Config.AnimationEasingStyle = Enum.EasingStyle[EasingStyle]
end, function(GetEasingStyle)
    return {"Linear", "Sine","Quad","Quart","Quint"}
end, string.sub(tostring(_G.Config.AnimationEasingStyle),18))

--[[
LibConfig:CreateSlider("Entry Height", function(Size)
    _G.Config.DefaultEntryHeight = Size
end, 0, 100, 1, true, _G.Config.DefaultEntryHeight)
]]

LibConfig:CreateButton("Update Config", function()
    DropLib:LoadConfig(_G.Config)
    DropLib:RecursiveUpdateGui()
end)

LibMenu:CreateButton("Destroy", function()
    DropLib:CleanUp()
end)

-- https://gitlab.com/0x45.xyz/droplib
-- loadstring(game:HttpGet(("https://raw.githubusercontent.com/AlexR32/Roblox/main/TPRRHax.lua"), true))()
