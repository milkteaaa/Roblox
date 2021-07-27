local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local PlayerService = game:GetService("Players")
local LocalPlayer = PlayerService.LocalPlayer
local Camera = Workspace.CurrentCamera

local NPCFolder = Workspace.Custom:FindFirstChild("-1") or Workspace.Custom:FindFirstChild("1")

if not getgenv().Config then
	getgenv().Config = {
		CircleEnabled = true,
		CircleTransparency = 1,
		CircleColor = Color3.fromRGB(255,128,0),

		CircleThickness = 1,
		CircleNumSides = 30,
		CircleFilled = false,

		SilentAim = true,
		FieldOfView = 100,
		Distance = 1000,
		TargetMode = "NPC",
		BodyPart = "Head"
	}
end

local UIConfig = {
    WindowName = "Blackhawk Rescue Mission 5",
	Color = Color3.fromRGB(255,128,64),
	Keybind = Enum.KeyCode.RightShift
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/BracketV3.lua"))()
local Window = Library:CreateWindow(Config, game:GetService("CoreGui"))

local Tab1 = Window:CreateTab("Main")
local Tab2 = Window:CreateTab("UI Settings")

local Section1 = Tab1:CreateSection("Aimbot")
local Section2 = Tab1:CreateSection("Circle")
local Section3 = Tab2:CreateSection("Menu")
local Section4 = Tab2:CreateSection("Background")

local Toggle1 = Section1:CreateToggle("Silent Aim", function(State)
	Config.SilentAim = State
end)
Toggle1:SetState(Config.SilentAim)
-------------
local Slider1 = Section1:CreateSlider("Field Of View", 0,500,true, function(Value)
	Config.FieldOfView = Value
end)
Slider1:SetValue(Config.FieldOfView)
-------------
local Slider2 = Section1:CreateSlider("Distance", 0,10000,true, function(Value)
	Config.Distance = Value
end)
Slider2:SetValue(Config.Distance)
-------------
local Dropdown1 = Section1:CreateDropdown("Target")
local Option1 = Dropdown1:AddOption("NPC", function(String)
	Config.TargetMode = "NPC"
end)
local Option2 = Dropdown1:AddOption("Player", function(String)
	Config.TargetMode = "Player"
end)
if Config.TargetMode == "NPC" then
	Option1:SetOption()
elseif Config.TargetMode == "Player" then
	Option2:SetOption()
end
-------------
local Dropdown2 = Section1:CreateDropdown("Aim Part")
local Option3 = Dropdown2:AddOption("Head", function(String)
	Config.BodyPart = "Head"
end)
local Option4 = Dropdown2:AddOption("Torso", function(String)
	Config.BodyPart = "Torso"
end)
if Config.BodyPart = "Head" then
	Option3:SetOption()
elseif Config.BodyPart = "Torso" then
	Option4:SetOption()
end
-------------
local Toggle2 = Section2:CreateToggle("Enable Circle", function(State)
	Config.CircleEnabled = State
end)
Toggle2:SetState(Config.CircleEnabled)
-------------
local Slider3 = Section2:CreateSlider("Circle Transparency", 0,1,false, function(Value)
	Config.CircleTransparency = Value
end)
Slider3:SetValue(Config.CircleTransparency)
-------------
local Colorpicker2 = Section2:CreateColorpicker("Circle Color", function(Color)
	Config.CircleColor = Color
end)
Colorpicker2:UpdateColor(Config.CircleColor)
-------------
local Slider4 = Section2:CreateSlider("Circle Thickness", 1,5,true, function(Value)
	Config.CircleThickness = Value
end)
Slider4:SetValue(25)

local Slider5 = Section2:CreateSlider("Circle NumSides", 3,100,true, function(Value)
	Config.CircleNumSides = Value
end)
Slider5:SetValue(Config.CircleNumSides)

local Toggle3 = Section2:CreateToggle("Circle Filled", function(State)
	Config.CircleFilled = State
end)
Toggle3:SetState(Config.CircleFilled)
-------------
local Toggle4 = Section3:CreateToggle("UI Toggle", function(State)
	Window:Toggle(State)
end)
Toggle4:CreateKeybind(tostring(Config.Keybind):gsub("Enum.KeyCode.", ""), function(Key)
	Config.Keybind = Enum.KeyCode[Key]
end)
Toggle4:SetState(true)

local Colorpicker3 = Section3:CreateColorpicker("UI Color", function(Color)
	Window:ChangeColor(Color)
end)
Colorpicker3:UpdateColor(Config.Color)

local Dropdown3 = Section4:CreateDropdown("Image")
local Option7 = Dropdown3:AddOption("Default", function(String)
	Window:SetBackground("2151741365")
end)
local Option8 = Dropdown3:AddOption("Hearts", function(String)
	Window:SetBackground("6073763717")
end)
local Option9 = Dropdown3:AddOption("Abstract", function(String)
	Window:SetBackground("6073743871")
end)
local Option10 = Dropdown3:AddOption("Hexagon", function(String)
	Window:SetBackground("6073628839")
end)
local Option11 = Dropdown3:AddOption("Circles", function(String)
	Window:SetBackground("6071579801")
end)
local Option12 = Dropdown3:AddOption("Lace With Flowers", function(String)
	Window:SetBackground("6071575925")
end)
local Option13 = Dropdown3:AddOption("Floral", function(String)
	Window:SetBackground("5553946656")
end)
Option7:SetOption()

local Colorpicker4 = Section4:CreateColorpicker("Color", function(Color)
	Window:SetBackgroundColor(Color)
end)
Colorpicker4:UpdateColor(Color3.new(1,1,1))

local Slider6 = Section4:CreateSlider("Transparency",0,1,false, function(Value)
	Window:SetBackgroundTransparency(Value)
end)
Slider6:SetValue(0)

local Slider7 = Section4:CreateSlider("Tile Scale",0,1,false, function(Value)
	Window:SetTileScale(Value)
end)
Slider7:SetValue(0.5)

-- functions
local function returnCharacter(Target)
	if Target then
		if Target:IsA("Player") and Target.Character then
			return Workspace:FindFirstChild(Target.Name)
		else
			return Target
		end
	end
end

local function returnTeam(Target)
	if LocalPlayer.TeamColor ~= Target.TeamColor then
		return true
	else
		return false
	end
	return true
end

local function returnHealth(Target)
	if returnCharacter(Target) then
		local TargetCharacter = returnCharacter(Target)
		if TargetCharacter:FindFirstChildOfClass("Humanoid") and TargetCharacter:FindFirstChildOfClass("Humanoid").Health >= 0 then
			return true
		else
			return false
		end
	end
	return true
end

function GetTarget()
	local ClosestTarget = math.huge
	local Target = nil
	if Config.TargetMode == "NPC" then
		if NPCFolder then
			for _, NPC in pairs(NPCFolder:GetChildren()) do -- get all npcs
				if NPC:FindFirstChildOfClass("Humanoid") and not NPC:FindFirstChildOfClass("Humanoid"):FindFirstChild("Free") then -- get rid of hostages
					if NPC:FindFirstChildOfClass("Humanoid") and NPC:FindFirstChildOfClass("Humanoid").Health >= 0 then -- check health
						local Vector, InViewport = Camera:WorldToViewportPoint(NPC:FindFirstChild(Config.BodyPart).Position)
						if InViewport then
							local CameraPosition = Camera.CFrame.Position
							if Workspace:FindPartOnRayWithIgnoreList(Ray.new(CameraPosition, (NPC:FindFirstChild(Config.BodyPart).Position - CameraPosition).Unit * Config.Distance), {NPC}) then
								local DistanceMagnitude = (LocalPlayer.Character:FindFirstChild(Config.BodyPart).Position - NPC:FindFirstChild(Config.BodyPart).Position).Magnitude
								local VectorMagnitude = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(Vector.X, Vector.Y)).Magnitude
								if VectorMagnitude < ClosestTarget and VectorMagnitude <= Config.FieldOfView and DistanceMagnitude <= Config.Distance then
									Target = NPC:FindFirstChild(Config.BodyPart)
									ClosestTarget = VectorMagnitude
								end
							end
						end
					end
				end
			end
		end
	elseif Config.TargetMode == "Player" then
		for _, Player in pairs(PlayerService:GetChildren()) do
			if Player ~= LocalPlayer and Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
				if Player.Chracter.Humanoid.Health >= 0 then
					if Player.Team ~= LocalPlayer.Team then
						local Vector, InViewport = Camera:WorldToViewportPoint(Player.Character:FindFirstChild(Config.BodyPart).Position)
						if InViewport then
							local CameraPosition = Camera.CFrame.Position
							if Workspace:FindPartOnRayWithIgnoreList(Ray.new(CameraPosition, (Player.Character:FindFirstChild(Config.BodyPart).Position - CameraPosition).Unit * Config.Distance), {Player}) then
								local DistanceMagnitude = (LocalPlayer.Character:FindFirstChild(Config.BodyPart).Position - Player.Character:FindFirstChild(Config.BodyPart).Position).Magnitude
								local VectorMagnitude = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(Vector.X, Vector.Y)).Magnitude
								if VectorMagnitude < ClosestTarget and VectorMagnitude <= Config.FieldOfView and DistanceMagnitude <= Config.Distance then
									Target = Player.Character:FindFirstChild(Config.BodyPart)
									ClosestTarget = VectorMagnitude
								end
							end
						end
					end
				end
			end
		end
	end
	return Target
end

-- silent aim
local function returnHit(hit, args)
	CameraPosition = Camera.CFrame.Position
	if args[2].Origin == CameraPosition then
		args[2] = Ray.new(args[2].Origin, (hit.Position + Vector3.new(0, (CameraPosition - hit.Position).Magnitude / Config.Distance, 0) - CameraPosition).Unit * (Config.Distance * 10))
		return
	end
end

local rawmetatable = getrawmetatable(game)
local old

setreadonly(rawmetatable, false)
old = hookfunction(rawmetatable.__namecall, function(...)
	local namecallmethod = getnamecallmethod()
	local args = {...}
	if namecallmethod == "FindPartOnRayWithIgnoreList" then
		if hit then
			returnHit(hit, args)
		end
	end
	return old(unpack(args))
end)
setreadonly(rawmetatable, true)

RunService.Heartbeat:Connect(function()
	if Config.SilentAim then
		hit = GetTarget()
	else
		hit = nil
	end
end)
-- circle
local Circle = Drawing.new("Circle")
RunService.Heartbeat:Connect(function()
	if Circle then
		Circle.Visible = Config.CircleEnabled
		Circle.Transparency = Config.CircleTransparency
		Circle.Color = Config.CircleColor

		Circle.Thickness = Config.CircleThickness
		Circle.NumSides = Config.CircleNumSides
		Circle.Radius = Config.FieldOfView
		Circle.Filled = Config.CircleFilled
		Circle.Position = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
	end
end)
