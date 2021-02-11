# Roblox

## Blackhawk Rescue Mission 5
```lua
getgenv().Config = {
	CircleEnabled = false,
	CircleTransparency = 0.25,
	CircleColor = Color3.fromRGB(255,255,255),
	CircleThickness = 1.5,
	CircleNumSides = 30,
	CircleFilled = false,

	TracerEnabled = false,
	TracerTransparency = 0.25,
	TracerColor = Color3.fromRGB(255,0,0),
	TracerThickness = 2,

	InfoEnabled = false,
	InfoDistance = false,
	InfoPosition = Vector2.new(0,25),
	InfoTransparency = 0.25,
	InfoSize = 20,
	InfoOutline = false,
	InfoFont = 1,

	SilentAim = false,
	VisibiltyCheck = false,
	FieldOfView = 100,
	Distance = 1000,
	TargetMode = "NPC",
	BodyPart = "Head",
	FieldOfViewMode = "Cursor"
}
-- github.com/AlexR32/Roblox
loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/BlackhawkRescueMission5.lua"))()
```
### Changelog
* Attempt to fix FPS drop (x2)
* Config changed (x2)
* Little rewrite due to fps drop fix
## BRM5 ESP Cut
```lua
getgenv().Config = {
    TracerEnabled = false,
    TracerTransparency = 0.25,
    TracerColor = Color3.fromRGB(255,0,0),
    TracerThickness = 2,

    InfoEnabled = false,
    InfoDistance = false,
    InfoPosition = Vector2.new(0,25),
    InfoTransparency = 0.25,
    InfoSize = 15,
    InfoOutline = false,
    InfoFont = 1,

    Distance = 1000,
    HitPart = "Head"
}
-- ESP Only
-- github.com/AlexR32/Roblox
loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/BRM5ESPCut.lua"))()
```
## CoastingUI V2
```lua
local CoreGui = game:GetService("CoreGui")
local Config = {
	Theme = {
		MainColor = Color3.fromRGB(75,75,255),
		TextFont = Enum.Font.SourceSansBold,
		EasingStyle = Enum.EasingStyle.Quart
	},
	HubName = "CoastingUI", -- nil dont work anymore, use ""
	CustomLabel = "Version: 2.3.5", -- nil dont work anymore, use ""
	UIKeybind = Enum.KeyCode.RightShift
}

local CoastingCore = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/CoastingUIV2.lua"))()
local Coasting = CoastingCore:Init(Config, CoreGui)

local Main = Coasting:CreateTab("Main")
local Credits = Coasting:CreateTab("Credits")
local Settings = Coasting:CreateTab("Settings")

local MainSection = Main:CreateSection("Section")
local CoastingUISec = Credits:CreateSection("Developers")
local SettingsSection = Settings:CreateSection("...")

MainSection:CreateLabel("", "Label")

MainSection:CreateButton("Button", function()
    print("Button")
end)

MainSection:CreateToggle("Toggle", true, function(Boolean)
    print(Boolean)
end)

MainSection:CreateSlider("Slider", 0, 100, 50, false, function(Number)
    print(Number)
end)

MainSection:CreateColorPicker("ColorPicker",Color3.new(1,1,1),function(Color)
	print(Color)
end)

MainSection:CreateDropdown("Dropdown", {"Text1","Text2"}, 2, function(String)
    print(String)
end)

CoastingUISec:CreateLabel("Dev1", "coasts @v3rmillion.net coasts#7386 @discord.com (Original Version Dev)")
CoastingUISec:CreateLabel("Dev2", "Alex332Rus @v3rmillion.net AlexR32#3232 @discord.com (V2 Dev)")

SettingsSection:CreateKeybind("UI Toggle", Config.UIKeybind, true, false, function(Key)
    Config.UIKeybind = Enum.KeyCode[Key]
end)
```
### Changelog
* Rewrited some things
## TPR:R Hax
```lua
getgenv().Config = {
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
    DefaultEntryHeight = 45,

    SoundId = 142376088,
    Volume = 0.5,
    Type = "Looping",
    Pitch = 1,

    RC = false, -- don't touch it
    AF = false -- don't touch it
}

loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/TPRRHax.lua"))()
```
