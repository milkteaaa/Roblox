local UserInput = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local GuiLibrary = {}

function Tween(O,T,S)
    TweenService:Create(O,TweenInfo.new(T),S):Play()
end

function GuiLibrary:CreateGui(GuiName)
	local GuiLibrary = Instance.new("ScreenGui")
	local Gui = Instance.new("TextLabel")
	local CategoryFolder = Instance.new("Frame")

	local CategoryTable = {}
	local ToggleGui = true

	GuiLibrary.Name = "GuiLibrary " .. GuiName
	GuiLibrary.Parent = game:GetService("Players").LocalPlayer.PlayerGui
	GuiLibrary.ResetOnSpawn = false

	Gui.Name = GuiName
	Gui.Parent = GuiLibrary
	Gui.BackgroundColor3 = Color3.fromRGB(0,0,0)
	Gui.BackgroundTransparency = 0.5
	Gui.BorderColor3 = Color3.fromRGB(0,0,0)
	Gui.BorderSizePixel = 0
	Gui.Position = UDim2.new(0,20,0,20)
	Gui.Size = UDim2.new(0,200,0,80)
	Gui.Font = Enum.Font.Code
	Gui.Text = GuiName
	Gui.TextColor3 = Color3.fromRGB(255,0,255)
	Gui.TextSize = 15
	Gui.TextStrokeTransparency = 0.75
	Gui.TextYAlignment = Enum.TextYAlignment.Top

	CategoryFolder.Name = "CategoryFolder"
	CategoryFolder.Parent = Gui
	CategoryFolder.AnchorPoint = Vector2.new(1,0)
	CategoryFolder.BackgroundColor3 = Color3.fromRGB(0,0,0)
	CategoryFolder.BackgroundTransparency = 1
	CategoryFolder.BorderColor3 = Color3.fromRGB(0,0,0)
	CategoryFolder.BorderSizePixel = 0
	CategoryFolder.Position = UDim2.new(1,0,0,15)
	CategoryFolder.Size = UDim2.new(1,-5,1,-20)

	function CategoryTable:CreateCategory(CategoryName)
		local Category = Instance.new("TextLabel")
		local FunctionFolder = Instance.new("Frame")
		local UIListLayout = Instance.new("UIListLayout")

		local FunctionTable = {}

		Category.Name = CategoryName
		Category.Parent = CategoryFolder
		Category.AnchorPoint = Vector2.new(1,1)
		Category.BackgroundColor3 = Color3.fromRGB(0,0,0)
		Category.BackgroundTransparency = 1
		Category.BorderColor3 = Color3.fromRGB(0,0,0)
		Category.BorderSizePixel = 0
		Category.Position = UDim2.new(1,0,1,0)
		Category.Size = UDim2.new(1,0,0,30)
		Category.Font = Enum.Font.Code
		Category.Text = CategoryName
		Category.TextColor3 = Color3.fromRGB(0,255,255)
		Category.TextSize = 15
		Category.TextStrokeTransparency = 0.75
		Category.TextXAlignment = Enum.TextXAlignment.Left
		Category.TextYAlignment = Enum.TextYAlignment.Top

		FunctionFolder.Name = "FunctionFolder"
		FunctionFolder.Parent = Category
		FunctionFolder.AnchorPoint = Vector2.new(1,0)
		FunctionFolder.BackgroundColor3 = Color3.fromRGB(0,0,0)
		FunctionFolder.BackgroundTransparency = 1
		FunctionFolder.BorderColor3 = Color3.fromRGB(0,0,0)
		FunctionFolder.BorderSizePixel = 0
		FunctionFolder.Position = UDim2.new(1,0,0,15)
		FunctionFolder.Size = UDim2.new(1,-5,1,-15)

		UIListLayout.Parent = FunctionFolder
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		
		function FunctionTable:CreateFunction(FunctionName)
			local Function = Instance.new("TextButton")
			local FunctionToggle = Instance.new("TextLabel")

			Function.Name = FunctionName
			Function.Parent = FunctionTable
			Function.BackgroundColor3 = Color3.fromRGB(0,0,0)
			Function.BackgroundTransparency = 1
			Function.BorderColor3 = Color3.fromRGB(0,0,0)
			Function.BorderSizePixel = 0
			Function.Size = UDim2.new(1,0,1,0)
			Function.AutoButtonColor = false
			Function.Font = Enum.Font.Code
			Function.Text = FunctionName
			Function.TextColor3 = Color3.fromRGB(255,255,255)
			Function.TextSize = 15
			Function.TextStrokeTransparency = 0.75
			Function.TextXAlignment = Enum.TextXAlignment.Left

			FunctionToggle.Name = FunctionName .. " Toggle"
			FunctionToggle.Parent = Function
			FunctionToggle.AnchorPoint = Vector2.new(1,0)
			FunctionToggle.BackgroundColor3 = Color3.fromRGB(0,0,0)
			FunctionToggle.BackgroundTransparency = 1
			FunctionToggle.BorderColor3 = Color3.fromRGB(0,0,0)
			FunctionToggle.BorderSizePixel = 0
			FunctionToggle.Position = UDim2.new(1,-10,0,0)
			FunctionToggle.Size = UDim2.new(0,40,1,0)
			FunctionToggle.Font = Enum.Font.Code
			FunctionToggle.Text = "false"
			FunctionToggle.TextColor3 = Color3.fromRGB(255,0,0)
			FunctionToggle.TextSize = 15
			FunctionToggle.TextStrokeTransparency = 0.75
		end
	end
	UserInput.InputBegan:Connect(function(Input)
		if Input.KeyCode == Enum.KeyCode.Insert then
			if ToggleGui then
				Tween(Gui, 1, {
					Position = Gui.Position - UDim2.new(0,0,0,Gui.Size.Y.Offset * 2)
				})
				ToggleGui = false
			else
				Tween(Gui, 1, {
					Position = UDim2.new(0,20,0,20)
				})
				ToggleGui = true
			end
		end
	end)
end

return GuiLibrary
