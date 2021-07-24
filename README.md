# Roblox

## BRM 5 Silent Aim
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
## BracketV3
```lua
local Config = {
	WindowName = "Example Library",
	Color = Color3.fromRGB(255,128,0),
	Keybind = Enum.KeyCode.RightBracket
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/BracketV3.lua"))()
local Window = Library:CreateWindow(Config, game:GetService("CoreGui"))

local Tab1 = Window:CreateTab("Example")
local Tab2 = Window:CreateTab("UI Settings")

local Section1 = Tab1:CreateSection("First Section")
local Section2 = Tab1:CreateSection("Second Section")
local Section3 = Tab2:CreateSection("Menu")
--local Section4 = Tab2:CreateSection("Configuration")
--local Section5 = Tab2:CreateSection("Misc")

Section1:CreateLabel("Label 1")
-------------
local Button1 = Section1:CreateButton("Button 1", function()
	print("Click Button 1")
end)
Button1:AddToolTip("Button 1 ToolTip")
-------------
local Toggle1 = Section1:CreateToggle("Toggle 1", function(State)
	print(State)
end)
Toggle1:AddToolTip("Toggle 1 ToolTip")
Toggle1:CreateKeybind("Y", function(Key)
	print(Key)
end)
-------------
local Slider1 = Section1:CreateSlider("Slider 1", 0,100,true, function(Value)
	print(Value)
end)
Slider1:AddToolTip("Slider 1 ToolTip")
Slider1:SetValue(50)
-------------
local Dropdown1 = Section1:CreateDropdown("Dropdown 1")
local Option1 = Dropdown1:AddOption("Option 1", function(String)
	print(String)
end)
local Option2 = Dropdown1:AddOption("Option 2", function(String)
	print(String)
end)
local Option3 = Dropdown1:AddOption("Option 3", function(String)
	print(String)
end)
Option1:SetOption()
-------------
Section2:CreateLabel("Label 2\nMultiline")
-------------
local Button2 = Section2:CreateButton("Button 2\nMultiline", function()
	print("Click Button 2")
end)
Button2:AddToolTip("Button 2 ToolTip\nMultiline")
-------------
local Toggle2 = Section2:CreateToggle("Toggle 2\nMultiline", function(State)
	print(State)
end)
Toggle2:AddToolTip("Toggle 2 ToolTip\nMultiline")
Toggle2:CreateKeybind("U", function(Key)
	print(Key)
end)
-------------
local Slider2 = Section2:CreateSlider("Slider 2\nMultiline", 0,100,false, function(Value)
	print(Value)
end)
Slider2:AddToolTip("Slider 2 ToolTip\nMultiline")
Slider2:SetValue(25)
-------------
local Dropdown2 = Section2:CreateDropdown("Dropdown 2\nMultiline")
local Option4 = Dropdown2:AddOption("Option 4", function(String)
	print(String)
end)
local Option5 = Dropdown2:AddOption("Option 5", function(String)
	print(String)
end)
local Option6 = Dropdown2:AddOption("Option 6", function(String)
	print(String)
end)
Option6:SetOption()
-------------
local Toggle3 = Section3:CreateToggle("UI Toggle", function(State)
	Window:Toggle(State)
end)
Toggle3:AddToolTip("Open/Close " .. Config.WindowName)
Toggle3:SetState(true)
Toggle3:CreateKeybind(tostring(Config.Keybind):gsub("Enum.KeyCode.", ""), function(Key)
	Config.Keybind = Enum.KeyCode[Key]
end)
local Slider3 = Section3:CreateSlider("Tile Size",0,1000,true, function(Value)
	Window:SetTileSize(Value)
end)
Slider3:AddToolTip("Set Background Tile Size")
Slider3:SetValue(500)
local Colorpicker3 = Section3:CreateColorpicker("UI Color", function(Color)
	Window:ChangeColor(Color)
end)
Colorpicker3:UpdateColor(Config.Color)
Colorpicker3:AddToolTip("Change library color")
```
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
