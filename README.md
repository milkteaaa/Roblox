# Roblox Scripts

## Silent Aim
```lua
getgenv().CircleTransparency = 0.25
getgenv().CircleThickness = 1.5
getgenv().CircleVisible = true
getgenv().CircleColor = Color3.new(1,1,1)
getgenv().CircleFilled = true
getgenv().GlobalRadius = 100
getgenv().GlobalDistance = 500
getgenv().SelectedPart = "Head"

loadstring(game:HttpGet(("https://raw.githubusercontent.com/AlexR32/Roblox/main/BRM%205.lua"), true))()
```
## GuiLibrary
```lua
local UILibrary = loadstring(game:HttpGet(("https://raw.githubusercontent.com/AlexR32/Roblox/main/UILibrary.lua"), true))()

UILibrary:ChangeName("Epic Library")
local Main = UILibrary:CreateCategory("Main")
local Other = UILibrary:CreateCategory("Other")
local Credits = UILibrary:CreateCategory("Credits")

Main:CreateToggle("Just Toggle", function(Toggle)
	print(Toggle)
end)

Main:CreateButton("Just Button", function()
	print("wow")
end)

Other:CreateToggle("Infinity Print", function(Toggle)
	_G.Toggle = Toggle
	spawn(function()
		while _G.Toggle do
			wait()
			print("Toggled")
		end
	end)
end)

Credits:CreateLabel("UI Lib: AlexR32#3232")
Credits:CreateLabel("Scripts: AlexR32#3232")
```
