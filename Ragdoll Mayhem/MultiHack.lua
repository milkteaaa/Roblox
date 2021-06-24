local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local PlayerService = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = PlayerService.LocalPlayer
local Camera = Workspace.CurrentCamera

local PlayerFolder = Workspace.Characters

if not getgenv().Config then
getgenv().Config = {

	-- fov circle
	CircleVisible = true,
	CircleTransparency = 1,
	CircleColor = Color3.fromRGB(255,128,255),
	CircleThickness = 1,
	CircleNumSides = 30,
	CircleFilled = false,

	-- box, player names and health bar (not really useful for this game)
	OutlineVisible = true,
	TextVisible = true,
	HealthbarVisible = false,
	BoxVisible = true,

	Transparency = 1, -- yes
	Color = Color3.fromRGB(255,128,255), -- disable rainbow before using
	Thickness = 2, -- very buggy when health bar is on and thickness 5+
	Filled = false, -- not really useful

	Rainbow = false, -- rainbow boxes yay

	-- dont touch it or esp wont work
	PlayerPart = "Torso",
	ModelPart = "Torso",

	-- Aimbot
	Aimbot = true,
	Sensitivity = 0.5,
	-- SilentAim
	SilentAim = false,
	--Things related to aim and silent aim
	TeamCheck = false,
	FieldOfView = 100,
	Distance = 1000, -- related to esp too
	BodyPart = "Head"
}
end

local function GetCorners(Model)
	local CFrame, Size = Model:GetBoundingBox()
	local CornerTable = {
		Vector3.new(CFrame.X + Size.X / 2, CFrame.Y + Size.Y / 2, CFrame.Z), -- TopRight
		Vector3.new(CFrame.X - Size.X / 2, CFrame.Y + Size.Y / 2, CFrame.Z), -- TopLeft

		Vector3.new(CFrame.X - Size.X / 2, CFrame.Y - Size.Y / 2, CFrame.Z), -- BottomLeft
		Vector3.new(CFrame.X + Size.X / 2, CFrame.Y - Size.Y / 2, CFrame.Z), -- BottomRight
	}

	local xMin = Camera.ViewportSize.X
	local yMin = Camera.ViewportSize.Y
	local xMax = 0
	local yMax = 0
							
	for _, Corner in next, CornerTable do
		local Position = Camera:WorldToViewportPoint(Corner)

		if Position.X > xMax then
			xMax = Position.X
		end

		if Position.X < xMin then
			xMin = Position.X
		end

		if Position.Y > yMax then
			yMax = Position.Y
		end

		if Position.Y < yMin then
			yMin = Position.Y
		end
	end

	return xMax - xMin,yMax - yMin,xMin,yMin,xMax,yMax
end

local function CreateESP(Model, Info)
	local Text = Drawing.new("Text")
	local HealthOutline = Drawing.new("Square")
	local Health = Drawing.new("Square")
	local BoxOutline = Drawing.new("Square")
	local Box = Drawing.new("Square")

	local Render = RunService.RenderStepped:Connect(function()
		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(Config.PlayerPart) then
			if Model and Model:FindFirstChild(Config.ModelPart) then
				if Model:FindFirstChildOfClass("Humanoid") and Model:FindFirstChildOfClass("Humanoid").Health ~= 0 then
					if (LocalPlayer.Character[Config.PlayerPart].Position - Model[Config.ModelPart].Position).Magnitude <= Config.Distance then
						Camera = Workspace.CurrentCamera --update camera because game resets it
						local Vector, OnScreen = Camera:WorldToViewportPoint(Model[Config.ModelPart].Position)
						if OnScreen then
							local xSize,ySize,xMin,yMin,xMax,yMax = GetCorners(Model)

							Text.Visible = Config.TextVisible
							Text.Transparency = Config.Transparency
							Text.Color = Color3.fromRGB(255,255,255)
							Text.Text = tostring(Info)
							Text.Size = 20
							Text.Center = true
							Text.Outline = Config.OutlineVisible
							Text.OutlineColor = Color3.fromRGB(0,0,0)
							Text.Position = Vector2.new(xMax - xSize/2, yMax)

							HealthOutline.Visible = Config.HealthbarVisible and Config.OutlineVisible
							HealthOutline.Transparency = Config.Transparency
							HealthOutline.Color = Color3.fromRGB(0,0,0)
							HealthOutline.Thickness = 1
							HealthOutline.Filled = true

							HealthOutline.Size = Vector2.new(Config.Thickness + 2,-ySize-2)
							HealthOutline.Position = Vector2.new((xMin - 6) - Config.Thickness,yMax+1) -- dont know how to optimize it for box thinkness

							Health.Visible = Config.HealthbarVisible
							Health.Transparency = Config.Transparency
							Health.Color = Color3.fromRGB(255,0,0):Lerp(Color3.fromRGB(0,255,0), Model.Humanoid.Health/Model.Humanoid.MaxHealth)
							Health.Thickness = 1
							Health.Filled = true

							Health.Size = Vector2.new(Config.Thickness,0):Lerp(Vector2.new(Config.Thickness,-ySize),Model.Humanoid.Health/Model.Humanoid.MaxHealth)
							Health.Position = Vector2.new((xMin - 5) - Config.Thickness,yMax) -- dont know how to optimize it for box thinkness

							BoxOutline.Visible = Config.OutlineVisible
							BoxOutline.Transparency = Config.Transparency
							BoxOutline.Color = Color3.fromRGB(0,0,0)
							BoxOutline.Thickness = Config.Thickness + 2
							BoxOutline.Filled = false

							BoxOutline.Size = Vector2.new(xSize,ySize)
							BoxOutline.Position = Vector2.new(xMin,yMin)

							Box.Visible = Config.BoxVisible
							Box.Transparency = Config.Transparency
							Box.Color = Config.Color
							Box.Thickness = Config.Thickness
							Box.Filled = Config.Filled

							Box.Size = Vector2.new(xSize, ySize)
							Box.Position = Vector2.new(xMin, yMin)
						else
							Text.Visible = false
							HealthOutline.Visible = false
							Health.Visible = false
							BoxOutline.Visible = false
							Box.Visible = false
						end
					else
						Text.Visible = false
						HealthOutline.Visible = false
						Health.Visible = false
						BoxOutline.Visible = false
						Box.Visible = false
					end
				else
					Text.Visible = false
					HealthOutline.Visible = false
					Health.Visible = false
					BoxOutline.Visible = false
					Box.Visible = false
				end
			else
				warn("BoxESP: ModelPart.Parent ~= Model")
				Text.Visible = false
				HealthOutline.Visible = false
				Health.Visible = false
				BoxOutline.Visible = false
				Box.Visible = false
			end
		else
			warn("BoxESP: PlayerPart.Parent ~= Player.Character")
			Text.Visible = false
			HealthOutline.Visible = false
			Health.Visible = false
			BoxOutline.Visible = false
			Box.Visible = false
		end
	end)
	
	Model.AncestryChanged:Connect(function(Child, Parent)
		if not Parent then
			Render:Disconnect()
			Text:Remove()
			HealthOutline:Remove()
			Health:Remove()
			BoxOutline:Remove()
			Box:Remove()
		end
	end)
end

local function TeamCheck(Target)
	if Config.TeamCheck then
		if LocalPlayer.Team ~= Target.Team then
			return true
		else
			return false
		end
	end
	return true
end

local function GetTarget()
	local ClosestTarget = math.huge
	local Target = nil
	for _, Player in pairs(PlayerService:GetPlayers()) do
		if Player ~= LocalPlayer and Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
			if TeamCheck(Player) and Player.Character:FindFirstChildOfClass("Humanoid").Health ~= 0 then
				Camera = Workspace.CurrentCamera
				local Vector, OnScreen = Camera:WorldToViewportPoint(Player.Character:FindFirstChild(Config.BodyPart).Position)
				if OnScreen then
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
	return Target
end

local function returnHit(hit, args)
	CameraPosition = Camera.CFrame.Position
	local script = getcallingscript()
	if tostring(script) == "GarbageCode" then
		if table.find(args[3], LocalPlayer.Character, 1) and not table.find(args[3], Workspace.WaterCollision, 2) and not table.find(args[3], Workspace.Characters, 3) then
			--args[2] = Ray.new(CameraPosition, (hit.Position + Vector3.new(0, (CameraPosition - hit.Position).Magnitude / Config.Distance, 0) - CameraPosition).Unit * (Config.Distance * 10)) -- bad code
			args[2] = Ray.new(args[2].Origin, (hit.Position + Vector3.new(0, (CameraPosition - hit.Position).Magnitude / Config.Distance, 0) - CameraPosition).Unit * (Config.Distance * 10))
			return
		end
	end
end

local rawmetatable = getrawmetatable(game)
local namecall = rawmetatable.__namecall

setreadonly(rawmetatable, false)
rawmetatable.__namecall = newcclosure(function(...)
	local namecallmethod = getnamecallmethod()
	local args = {...}
	if namecallmethod == "FindPartOnRayWithIgnoreList" then
		if hit then
			returnHit(hit, args)
		end
	end
	return namecall(unpack(args))
end)
setreadonly(rawmetatable, true)

RunService.RenderStepped:Connect(function()
	if Config.Aimbot then
		if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
			local Target = GetTarget()
			if Target then
				local Mouse = UserInputService:GetMouseLocation()
				local TargetPos = Camera:WorldToViewportPoint(Target.Position)
				mousemoverel((TargetPos.X - Mouse.X) * Config.Sensitivity, (TargetPos.Y - Mouse.Y) * Config.Sensitivity)
			end
		end
	end

	if Config.SilentAim then
		hit = GetTarget()
	else
		hit = nil
	end
end)

local Circle = Drawing.new("Circle")
RunService.Heartbeat:Connect(function()
	if Circle then
		Circle.Visible = Config.CircleVisible
		Circle.Transparency = Config.CircleTransparency
		Circle.Color = Config.CircleColor

		Circle.Thickness = Config.CircleThickness
		Circle.NumSides = Config.CircleNumSides
		Circle.Radius = Config.FieldOfView
		Circle.Filled = Config.CircleFilled
		Circle.Position = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
	end
end)

for _, Player in pairs(PlayerFolder:GetChildren()) do
	if Player.Name ~= LocalPlayer.Name then
		if Player:WaitForChild("Humanoid", 5) then
			if Player.Humanoid.Health ~= 0 then
				CreateESP(Player, Player.Name)
			end
		end
	end
end

PlayerFolder.ChildAdded:Connect(function(Player)
	if Player.Name ~= LocalPlayer.Name then
		if Player:WaitForChild("Humanoid", 5) then
			if Player.Humanoid.Health ~= 0 then
				CreateESP(Player, Player.Name)
			end
		end
	end
end)
