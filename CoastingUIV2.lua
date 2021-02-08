local UserInput = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local PlayerService = game:GetService("Players")
local Mouse = PlayerService.LocalPlayer:GetMouse()

local Library = {
	LibraryColorTable = {},
	TabCount = 0,
	FirstTab = nil,
	CurrentlyBinding = false,
	RainbowColorValue = 0,
	HueSelectionPosition = 0,
	Cursor = true
}

local function AddCorner(Parent, Radius)
	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = Radius
	UICorner.Parent = Parent
end

local function AddListLayout(Parent, FillDirection, SortOrder)
	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.Parent = Parent
	UIListLayout.FillDirection = FillDirection
	UIListLayout.SortOrder = SortOrder
end

local function AddGridLayout(Parent, SortOrder, CellPadding, CellSize)
	local UIGridLayout = Instance.new("UIGridLayout")
	UIGridLayout.Parent = Parent
	UIGridLayout.SortOrder = SortOrder
	UIGridLayout.CellPadding = CellPadding
	UIGridLayout.CellSize = CellSize
end

local function AddPadding(Parent, PaddingLeft, PaddingTop)
	local UIPadding = Instance.new("UIPadding")
	UIPadding.Parent = Parent
	UIPadding.PaddingLeft = PaddingLeft
	UIPadding.PaddingTop = PaddingTop
end

local function DarkenObjectColor(Object, Amount)
	return Color3.fromRGB((Object.R * 255) - Amount, (Object.G * 255) - Amount, (Object.B * 255) - Amount)
end

local function MakeDraggable(TopbarObject, Object)
	local Dragging = nil
	local DragInput = nil
	local DragStart = nil
	local StartPosition = nil
	
	TopbarObject.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			Dragging = true
			DragStart = Input.Position
			StartPosition = Object.Position
			
			Input.Changed:Connect(function()
				if Input.UserInputState == Enum.UserInputState.End then
					Dragging = false
				end
			end)
		end
	end)
	
	TopbarObject.InputChanged:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
			DragInput = Input
		end
	end)
	
	UserInput.InputChanged:Connect(function(Input)
		if Input == DragInput and Dragging then
			local Delta = Input.Position - DragStart
			Object.Position = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
		end
	end)
end

function Library:Init(Config, LibraryParent)
	local UILibrary = Instance.new("ScreenGui")
	local Main = Instance.new("Frame")
	local Border = Instance.new("Frame")
	local Topbar = Instance.new("Frame")
	local HubName = Instance.new("TextLabel")
	local CustomLabel = Instance.new("TextLabel")
	local Holder = Instance.new("Frame")
	local ButtonHolder = Instance.new("Frame")
	local TabHolder = Instance.new("Frame")
	local Modal = Instance.new("TextButton")

	local LibraryInit = {}
	UILibrary.Name = HttpService:GenerateGUID(false)
	UILibrary.Parent = LibraryParent
	--UILibrary.DisplayOrder = 1
	UILibrary.IgnoreGuiInset = true
	UILibrary.ResetOnSpawn = false

	Main.Name = "Main"
	Main.Parent = UILibrary
	Main.AnchorPoint = Vector2.new(0.5,0.5)
	Main.BackgroundColor3 = Color3.fromRGB(30,30,30)
	Main.BorderColor3 = Color3.fromRGB(0,0,0)
	Main.BorderSizePixel = 0
	Main.Position = UDim2.new(0.5,0,0.5,0)
	Main.Size = UDim2.new(0,450,0,0)
	Main.ZIndex = 2
	AddCorner(Main, UDim.new(0,5))

	Border.Name = "Border"
	Border.Parent = Main
	Border.AnchorPoint = Vector2.new(0.5,0.5)
	Border.BackgroundColor3 = Config.Theme.MainColor
	Border.BackgroundTransparency = 1
	Border.BorderColor3 = Color3.fromRGB(0,0,0)
	Border.BorderSizePixel = 0
	Border.Position = UDim2.new(0.5,0,0.5,0)
	Border.Size = UDim2.new(1,2,1,2)
	AddCorner(Border, UDim.new(0,5))

	Topbar.Name = "Topbar"
	Topbar.Parent = Main
	Topbar.AnchorPoint = Vector2.new(0.5,0)
	Topbar.BackgroundColor3 = Color3.fromRGB(0,0,0)
	Topbar.BackgroundTransparency = 1
	Topbar.BorderColor3 = Color3.fromRGB(0,0,0)
	Topbar.BorderSizePixel = 0
	Topbar.Position = UDim2.new(0.5,0,0,0)
	Topbar.Size = UDim2.new(1,0,0,20)
	Topbar.ZIndex = 2

	HubName.Name = "HubName"
	HubName.Parent = Topbar
	HubName.AnchorPoint = Vector2.new(0.5,0)
	HubName.BackgroundColor3 = Color3.fromRGB(0,0,0)
	HubName.BackgroundTransparency = 1
	HubName.BorderColor3 = Color3.fromRGB(0,0,0)
	HubName.BorderSizePixel = 0
	HubName.Position = UDim2.new(0.5,0,0,0)
	HubName.Size = UDim2.new(1,-10,1,0)
	HubName.ZIndex = 2
	HubName.ClipsDescendants = true
	HubName.Font = Config.Theme.TextFont
	HubName.Text = Config.HubName
	HubName.TextColor3 = Color3.fromRGB(255,255,255)
	HubName.TextSize = 15
	HubName.TextStrokeTransparency = 0.75
	HubName.TextXAlignment = Enum.TextXAlignment.Left

	CustomLabel.Name = "CustomLabel"
	CustomLabel.Parent = Topbar
	CustomLabel.AnchorPoint = Vector2.new(0.5,0)
	CustomLabel.BackgroundColor3 = Color3.fromRGB(0,0,0)
	CustomLabel.BackgroundTransparency = 1
	CustomLabel.BorderColor3 = Color3.fromRGB(0,0,0)
	CustomLabel.BorderSizePixel = 0
	CustomLabel.Position = UDim2.new(0.5,0,0,0)
	CustomLabel.Size = UDim2.new(1,-10,1,0)
	CustomLabel.ZIndex = 2
	CustomLabel.ClipsDescendants = true
	CustomLabel.Font = Config.Theme.TextFont
	CustomLabel.Text = Config.CustomLabel
	CustomLabel.TextColor3 = Color3.fromRGB(255,255,255)
	CustomLabel.TextSize = 15
	CustomLabel.TextStrokeTransparency = 0.75
	CustomLabel.TextXAlignment = Enum.TextXAlignment.Right

	Holder.Name = "Holder"
	Holder.Parent = Main
	Holder.AnchorPoint = Vector2.new(0.5,0.5)
	Holder.BackgroundColor3 = Color3.fromRGB(0,0,0)
	Holder.BackgroundTransparency = 1
	Holder.BorderColor3 = Color3.fromRGB(0,0,0)
	Holder.BorderSizePixel = 0
	Holder.Position = UDim2.new(0.5,0,0.5,0)
	Holder.Size = UDim2.new(1,0,1,0)
	Holder.ClipsDescendants = true

	ButtonHolder.Name = "ButtonHolder"
	ButtonHolder.Parent = Holder
	ButtonHolder.AnchorPoint = Vector2.new(0.5,0)
	ButtonHolder.BackgroundColor3 = Config.Theme.MainColor
	ButtonHolder.BorderColor3 = Color3.fromRGB(0,0,0)
	ButtonHolder.BorderSizePixel = 0
	ButtonHolder.Position = UDim2.new(0.5,0,0,20)
	ButtonHolder.Size = UDim2.new(1,-15,0,25)
	ButtonHolder.ZIndex = 2
	AddCorner(ButtonHolder, UDim.new(0,5))
	AddListLayout(ButtonHolder, Enum.FillDirection.Horizontal, Enum.SortOrder.LayoutOrder)

	TabHolder.Name = "TabHolder"
	TabHolder.Parent = Holder
	TabHolder.AnchorPoint = Vector2.new(0.5,0)
	TabHolder.BackgroundColor3 = Color3.fromRGB(0,0,0)
	TabHolder.BackgroundTransparency = 1
	TabHolder.BorderColor3 = Color3.fromRGB(0,0,0)
	TabHolder.BorderSizePixel = 0
	TabHolder.Position = UDim2.new(0.5,0,0,45)
	TabHolder.Size = UDim2.new(1,-15,1,-45)
	TabHolder.ZIndex = 2

	Modal.Name = "Modal"
	Modal.Parent = Main
	Modal.BackgroundColor3 = Color3.fromRGB(0,0,0)
	Modal.BackgroundTransparency = 1
	Modal.BorderColor3 = Color3.fromRGB(0,0,0)
	Modal.BorderSizePixel = 0
	Modal.AutoButtonColor = false
	Modal.Modal = true
	Modal.Font = Config.Theme.TextFont
	Modal.Text = ""
	Modal.TextColor3 = Color3.fromRGB(255,255,255)
	Modal.TextSize = 15
	Modal.TextStrokeTransparency = 0.75
	Modal.TextTransparency = 1

	MakeDraggable(Topbar, Main)

	TweenService:Create(Main, TweenInfo.new(0.5, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {Size = UDim2.new(0,450,0,250)}):Play()
	TweenService:Create(Border, TweenInfo.new(0.5, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()

	local function CloseAllTabs()
		for _,Tab in pairs(TabHolder:GetChildren()) do
			if Tab:IsA("ScrollingFrame") then
				Tab.Visible = false
			end
		end
	end

	local function ResetAllTabButtons()
		for _,TabButton in pairs(ButtonHolder:GetChildren()) do
			if TabButton:IsA("TextButton") then
				TweenService:Create(TabButton, TweenInfo.new(0.3, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {BackgroundColor3 = Config.Theme.MainColor}):Play()
			end
		end
	end

	local function KeepFirstTabOpen()
		for _,Tab in pairs(TabHolder:GetChildren()) do
			if Tab:IsA("ScrollingFrame") then
				if Tab.Name == Library.FirstTab .. "Tab" then
					Tab.Visible = true
				else
					Tab.Visible = false
				end
			end
		end

		for _,TabButton in pairs(ButtonHolder:GetChildren()) do
			if TabButton:IsA("TextButton") then
				if TabButton.Name == Library.FirstTab .. "TabButton" then
					TweenService:Create(TabButton, TweenInfo.new(0.3, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {BackgroundColor3 = DarkenObjectColor(Config.Theme.MainColor, 15)}):Play()
				else
					TweenService:Create(TabButton, TweenInfo.new(0.3, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {BackgroundColor3 = Config.Theme.MainColor}):Play()
				end
			end
		end
	end

	local function ToggleUI()
		Library.UIOpen = not Library.UIOpen
		local MouseEnable = UserInput.MouseIconEnabled
		if Library.UIOpen then
			Modal.Modal = false
			Library.Cursor = MouseEnable
			TweenService:Create(Main, TweenInfo.new(0.5, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {Size = UDim2.new(0,450,0,0)}):Play()
			TweenService:Create(Border, TweenInfo.new(0.5, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
			TweenService:Create(Topbar, TweenInfo.new(0.5, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {Size = UDim2.new(1,0,0,0)}):Play()
		elseif not Library.UIOpen then
			Modal.Modal = true
			Library.Cursor = true
			TweenService:Create(Main, TweenInfo.new(0.5, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {Size = UDim2.new(0,450,0,250)}):Play()
			TweenService:Create(Border, TweenInfo.new(0.5, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
			TweenService:Create(Topbar, TweenInfo.new(0.5, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {Size = UDim2.new(1,0,0,15)}):Play()
		end
	end

	RunService.RenderStepped:Connect(function()
		Library.RainbowColorValue = Library.RainbowColorValue + 1/255
		Library.HueSelectionPosition = Library.HueSelectionPosition + 1
	
		if Library.RainbowColorValue >= 1 then
			Library.RainbowColorValue = 0
		end
	
		if Library.HueSelectionPosition == 105 then
			Library.HueSelectionPosition = 0
		end
		if Library.Cursor == true then
			UserInput.MouseIconEnabled = true
		else
			UserInput.MouseIconEnabled = false
		end
	end)	

	UserInput.InputBegan:Connect(function(Input)
		if Input.KeyCode == Config.UIKeybind then
			ToggleUI()
		end
	end)

	function LibraryInit:CreateTab(Name)
		local Tab = Instance.new("ScrollingFrame")
		local TabContentLayout = Instance.new("UIGridLayout")
		local TabButton = Instance.new("TextButton")
		local ButtonEnd = Instance.new("Frame")

		local TabElement = {}
		Library.TabCount = Library.TabCount + 1
		if Library.TabCount == 1 then
			Library.FirstTab = Name
		end

		Tab.Name = Name .. "Tab"
		Tab.Parent = TabHolder
		--Tab.Active = true
		Tab.BackgroundColor3 = Color3.fromRGB(0,0,0)
		Tab.BackgroundTransparency = 1
		Tab.BorderColor3 = Color3.fromRGB(0,0,0)
		Tab.BorderSizePixel = 0
		Tab.Size = UDim2.new(1,0,1,0)
		Tab.ZIndex = 2
		Tab.ScrollBarThickness = 0
		TabContentLayout.Name = "TabContentLayout"
		TabContentLayout.Parent = Tab
		TabContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
		TabContentLayout.CellPadding = UDim2.new(0, 25, 0, 25)
		TabContentLayout.CellSize = UDim2.new(0, 200, 0, 185)
		AddPadding(Tab, UDim.new(0,5), UDim.new(0,10))
		
		TabButton.Name = Name .. "TabButton"
		TabButton.Parent = ButtonHolder
		TabButton.BackgroundColor3 = Config.Theme.MainColor
		TabButton.BackgroundTransparency = 1
		TabButton.BorderColor3 = Color3.fromRGB(0,0,0)
		TabButton.BorderSizePixel = 0
		TabButton.Size = UDim2.new(0.2,0,0,25)
		TabButton.ZIndex = 2
		TabButton.Font = Config.Theme.TextFont
		TabButton.Text = Name
		TabButton.TextColor3 = Color3.fromRGB(255,255,255)
		TabButton.TextSize = 15
		TabButton.TextStrokeTransparency = 0.75

		ButtonEnd.Name = "ButtonEnd"
		ButtonEnd.Parent = TabButton
		ButtonEnd.AnchorPoint = Vector2.new(0.5,0.5)
		ButtonEnd.BackgroundColor3 = DarkenObjectColor(Config.Theme.MainColor, 15)
		ButtonEnd.BorderColor3 = Color3.fromRGB(0,0,0)
		ButtonEnd.BorderSizePixel = 0
		ButtonEnd.Position = UDim2.new(1,0,0.5,0)
		ButtonEnd.Size = UDim2.new(0,2,1,-5)
		ButtonEnd.ZIndex = 2

		Tab.Visible = true
		CloseAllTabs()
		ResetAllTabButtons()
		TweenService:Create(TabButton, TweenInfo.new(0.3, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {BackgroundColor3 = DarkenObjectColor(Config.Theme.MainColor, 15)}):Play()
		KeepFirstTabOpen()
		TabButton.MouseButton1Down:Connect(function()
			CloseAllTabs()
			ResetAllTabButtons()
			Tab.Visible = true
			TweenService:Create(TabButton, TweenInfo.new(0.3, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {BackgroundColor3 = DarkenObjectColor(Config.Theme.MainColor, 15)}):Play()
		end)

		function TabElement:CreateSection(Name)
			local Section = Instance.new("Frame")
			local SectionTitle = Instance.new("TextLabel")
			local SectionBorder = Instance.new("Frame")
			local SectionContent = Instance.new("ScrollingFrame")
			local SectionContentLayout = Instance.new("UIListLayout")

			local SectionElement = {}

			Section.Name = Name .. "Section"
			Section.Parent = Tab
			Section.BackgroundColor3 = Color3.fromRGB(30,30,30)
			Section.BorderColor3 = Color3.fromRGB(0,0,0)
			Section.BorderSizePixel = 0
			Section.Size = UDim2.new(0,100,0,100)
			Section.ZIndex = 4

			SectionTitle.Name = "SectionTitle"
			SectionTitle.Parent = Section
			SectionTitle.AnchorPoint = Vector2.new(0.5,0.5)
			SectionTitle.BackgroundColor3 = Color3.fromRGB(30,30,30)
			SectionTitle.BorderColor3 = Color3.fromRGB(0,0,0)
			SectionTitle.BorderSizePixel = 0
			SectionTitle.Position = UDim2.new(0.5,0,0,0)
			SectionTitle.Size = UDim2.new(0,100,0,15)
			SectionTitle.ZIndex = 4
			SectionTitle.Font = Config.Theme.TextFont
			SectionTitle.Text = Name
			SectionTitle.TextColor3 = Color3.fromRGB(255,255,255)
			SectionTitle.TextSize = 15
			SectionTitle.TextStrokeTransparency = 0.75

			SectionBorder.Name = "SectionBorder"
			SectionBorder.Parent = Section
			SectionBorder.AnchorPoint = Vector2.new(0.5,0.5)
			SectionBorder.BackgroundColor3 = Config.Theme.MainColor
			SectionBorder.BorderColor3 = Color3.fromRGB(0,0,0)
			SectionBorder.BorderSizePixel = 0
			SectionBorder.Position = UDim2.new(0.5,0,0.5,0)
			SectionBorder.Size = UDim2.new(1,2,1,2)
			SectionBorder.ZIndex = 3

			AddCorner(SectionBorder, UDim.new(0,5))
			AddCorner(Section, UDim.new(0,5))

			SectionContent.Name = "SectionContent"
			SectionContent.Parent = Section
			SectionContent.Active = true
			SectionContent.AnchorPoint = Vector2.new(0,1)
			SectionContent.BackgroundColor3 = Color3.fromRGB(0,0,0)
			SectionContent.BackgroundTransparency = 1
			SectionContent.BorderColor3 = Color3.fromRGB(0,0,0)
			SectionContent.BorderSizePixel = 0
			SectionContent.Position = UDim2.new(0,0,1,0)
			SectionContent.Size = UDim2.new(1,0,1,-10)
			SectionContent.ZIndex = 4
			SectionContent.BottomImage = ""
			SectionContent.MidImage = ""
			SectionContent.ScrollBarThickness = 0
			SectionContent.TopImage = ""
			SectionContentLayout.Parent = SectionContent
			SectionContentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			SectionContentLayout.SortOrder = Enum.SortOrder.LayoutOrder

			SectionContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				SectionContent.CanvasSize = UDim2.new(0,0,0,SectionContentLayout.AbsoluteContentSize.Y + 15)
			end)

			SectionTitle:GetPropertyChangedSignal("TextBounds"):Connect(function()
				if SectionTitle.Text ~= "" then
					SectionTitle.Size = UDim2.new(0,SectionTitle.TextBounds.X + 10,0,15)
				else
					SectionTitle.Size = UDim2.new(0,0,0,15)
				end
			end)
			
			function SectionElement:CreateLabel(Name, Text)
				local Label = Instance.new("TextLabel")

				Label.Name = Name .. "Label"
				Label.Parent = SectionContent
				Label.BackgroundColor3 = Color3.fromRGB(0,0,0)
				Label.BackgroundTransparency = 1
				Label.BorderColor3 = Color3.fromRGB(0,0,0)
				Label.BorderSizePixel = 0
				Label.RichText = true
				Label.Text = Text
				Label.TextSize = 15
				Label.TextWrapped = true
				Label.Size = UDim2.new(1,0,0,15)
				Label.ZIndex = 5
				Label.Font = Config.Theme.TextFont
				Label.TextColor3 = Color3.fromRGB(255,255,255)
				Label.TextStrokeTransparency = 0.75

				Label:GetPropertyChangedSignal("TextBounds"):Connect(function()
	                if Label.Text ~= "" then
	                    TweenService:Create(Label, TweenInfo.new(0.5, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, Label.TextBounds.Y)}):Play()
	                else
	                    TweenService:Create(Label, TweenInfo.new(0.5, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 0)}):Play()
	                end
            	end)
			end

			function SectionElement:CreateButton(Name, Callback)
				local Button = Instance.new("TextButton")

				Button.Name = Name .. "Button"
				Button.Parent = SectionContent
				Button.AnchorPoint = Vector2.new(0.5,0)
				Button.BackgroundColor3 = Config.Theme.MainColor
				Button.BorderColor3 = Color3.fromRGB(0,0,0)
				Button.BorderSizePixel = 0
				Button.Position = UDim2.new(0,0,0,0)
				Button.Size = UDim2.new(1,0,0,30)
				Button.ZIndex = 5
				Button.AutoButtonColor = false
				Button.Font = Config.Theme.TextFont
				Button.Text = Name
				Button.TextColor3 = Color3.fromRGB(255,255,255)
				Button.TextSize = 15
				Button.TextStrokeTransparency = 0.75

				Button.MouseButton1Down:Connect(function()
					TweenService:Create(Button, TweenInfo.new(0.25, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {BackgroundColor3 = DarkenObjectColor(Config.Theme.MainColor, 20)}):Play()
					Callback(Button)
				end)

				Button.MouseButton1Up:Connect(function()
					TweenService:Create(Button, TweenInfo.new(0.25, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {BackgroundColor3 = Config.Theme.MainColor}):Play()
				end)

				Button.InputEnded:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseMovement then
						TweenService:Create(Button, TweenInfo.new(0.25, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {BackgroundColor3 = Config.Theme.MainColor}):Play()
					end
				end)
			end

			function SectionElement:CreateToggle(Name, Preset,  Callback)
				local ToggleHolder = Instance.new("Frame")
				local Title = Instance.new("TextLabel")
				local Toggle = Instance.new("TextButton")
				local CheckboxTicked = Instance.new("ImageLabel")
				local CheckboxOutline = Instance.new("ImageLabel")
				local TickCover = Instance.new("Frame")

				local Toggled = false

				ToggleHolder.Name = Name .. "Toggle"
				ToggleHolder.Parent = SectionContent
				ToggleHolder.BackgroundColor3 = Color3.fromRGB(0,0,0)
				ToggleHolder.BackgroundTransparency = 1
				ToggleHolder.BorderColor3 = Color3.fromRGB(0,0,0)
				ToggleHolder.BorderSizePixel = 0
				ToggleHolder.Size = UDim2.new(1,0,0,30)
				ToggleHolder.ZIndex = 5

				Title.Name = "Title"
				Title.Parent = ToggleHolder
				Title.BackgroundColor3 = Color3.fromRGB(0,0,0)
				Title.BackgroundTransparency = 1
				Title.BorderColor3 = Color3.fromRGB(0,0,0)
				Title.BorderSizePixel = 0
				Title.Position = UDim2.new(0,10,0,0)
				Title.Size = UDim2.new(1,-50,1,0)
				Title.ZIndex = 5
				Title.Font = Config.Theme.TextFont
				Title.Text = Name
				Title.TextColor3 = Color3.fromRGB(185, 185, 185)
				Title.TextSize = 15
				Title.TextStrokeTransparency = 0.75
				Title.TextXAlignment = Enum.TextXAlignment.Left

				Toggle.Name = "Toggle"
				Toggle.Parent = ToggleHolder
				Toggle.AnchorPoint = Vector2.new(1,0.5)
				Toggle.BackgroundColor3 = Color3.fromRGB(0,0,0)
				Toggle.BackgroundTransparency = 1
				Toggle.BorderColor3 = Color3.fromRGB(0,0,0)
				Toggle.BorderSizePixel = 0
				Toggle.Position = UDim2.new(1,-10,0.5,0)
				Toggle.Size = UDim2.new(0,20,0,20)
				Toggle.ZIndex = 5
				Toggle.AutoButtonColor = false
				Toggle.Font = Config.Theme.TextFont
				Toggle.Text = ""
				Toggle.TextColor3 = Color3.fromRGB(185,185,185)
				Toggle.TextSize = 15
				Toggle.TextStrokeTransparency = 0.75

				CheckboxTicked.Name = "CheckboxTicked"
				CheckboxTicked.Parent = Toggle
				CheckboxTicked.BackgroundColor3 = Color3.fromRGB(0,0,0)
				CheckboxTicked.BackgroundTransparency = 1
				CheckboxTicked.BorderColor3 = Color3.fromRGB(0,0,0)
				CheckboxTicked.BorderSizePixel = 0
				CheckboxTicked.Position = UDim2.new(0.5,-12,0.5,-12)
				CheckboxTicked.Size = UDim2.new(0,24,0,24)
				CheckboxTicked.ZIndex = 5
				CheckboxTicked.Image = "rbxassetid://5416796675"
				CheckboxTicked.ImageColor3 = Color3.fromRGB(65,65,65)

				CheckboxOutline.Name = "CheckboxOutline"
				CheckboxOutline.Parent = Toggle
				CheckboxOutline.BackgroundColor3 = Color3.fromRGB(0,0,0)
				CheckboxOutline.BackgroundTransparency = 1
				CheckboxOutline.BorderColor3 = Color3.fromRGB(0,0,0)
				CheckboxOutline.BorderSizePixel = 0
				CheckboxOutline.Position = UDim2.new(0.5,-12,0.5,-12)
				CheckboxOutline.Size = UDim2.new(0,24,0,24)
				CheckboxOutline.ZIndex = 5
				CheckboxOutline.Image = "rbxassetid://5416796047"
				CheckboxOutline.ImageColor3 = Color3.fromRGB(65,65,65)

				TickCover.Name = "TickCover"
				TickCover.Parent = Toggle
				TickCover.BackgroundColor3 = Color3.fromRGB(30,30,30)
				TickCover.BorderColor3 = Color3.fromRGB(0,0,0)
				TickCover.BorderSizePixel = 0
				TickCover.Position = UDim2.new(0.5,-7,0.5,-7)
				TickCover.Size = UDim2.new(0,14,0,14)
				TickCover.ZIndex = 5

				local function SetState(State)
					if State then
						TweenService:Create(Title, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
						TweenService:Create(TickCover, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.new(0, 0, 0, 0)}):Play()
						TweenService:Create(CheckboxOutline, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {ImageColor3 = Config.Theme.MainColor}):Play()
						TweenService:Create(CheckboxTicked, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {ImageColor3 = Config.Theme.MainColor}):Play()
					elseif not State then
						TweenService:Create(Title, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextColor3 = Color3.fromRGB(185, 185, 185)}):Play()
						TweenService:Create(TickCover, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -7, 0.5, -7), Size = UDim2.new(0, 14, 0, 14)}):Play()
						TweenService:Create(CheckboxOutline, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {ImageColor3 = Color3.fromRGB(65, 65, 65)}):Play()
						TweenService:Create(CheckboxTicked, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {ImageColor3 = Color3.fromRGB(65, 65, 65)}):Play()
					end

					Callback(State)
				end

				Toggle.MouseButton1Down:Connect(function()
					Toggled = not Toggled
					SetState(Toggled)
				end)
				SetState(Preset)
			end
			function SectionElement:CreateSlider(Name, Min, Max, Preset, Precise, Callback)
				local SliderHolder = Instance.new("Frame")
				local Title = Instance.new("TextLabel")
				local SliderBackground = Instance.new("Frame")
				local SliderIndicator = Instance.new("Frame")
				local SliderValue = Instance.new("TextBox")

				local SliderDragging = false
				local StartingValue = Preset

				if StartingValue == nil then
					StartingValue = Preset
				end

				SliderHolder.Name = Name .. "Slider"
				SliderHolder.Parent = SectionContent
				SliderHolder.BackgroundColor3 = Color3.fromRGB(0,0,0)
				SliderHolder.BackgroundTransparency = 1
				SliderHolder.BorderColor3 = Color3.fromRGB(0,0,0)
				SliderHolder.BorderSizePixel = 0
				SliderHolder.Size = UDim2.new(1,0,0,50)
				SliderHolder.ZIndex = 5

				Title.Name = "Title"
				Title.Parent = SliderHolder
				Title.BackgroundColor3 = Color3.fromRGB(0,0,0)
				Title.BackgroundTransparency = 1
				Title.BorderColor3 = Color3.fromRGB(0,0,0)
				Title.Position = UDim2.new(0,10,0,0)
				Title.Size = UDim2.new(1,-75,0,30)
				Title.ZIndex = 5
				Title.Font = Config.Theme.TextFont
				Title.Text = Name
				Title.TextColor3 = Color3.fromRGB(255,255,255)
				Title.TextSize = 15
				Title.TextStrokeTransparency = 0.75
				Title.TextXAlignment = Enum.TextXAlignment.Left

				SliderBackground.Name = "SliderBackground"
				SliderBackground.Parent = SliderHolder
				SliderBackground.AnchorPoint = Vector2.new(0.5,0)
				SliderBackground.BackgroundColor3 = Color3.fromRGB(55,55,55)
				SliderBackground.BorderColor3 = Color3.fromRGB(0,0,0)
				SliderBackground.BorderSizePixel = 0
				SliderBackground.Position = UDim2.new(0.5,0,0,40)
				SliderBackground.Size = UDim2.new(1,-20,0,10)
				SliderBackground.ZIndex = 5
				AddCorner(SliderBackground, UDim.new(0,5))

				SliderIndicator.Name = "SliderIndicator"
				SliderIndicator.Parent = SliderBackground
				SliderIndicator.BackgroundColor3 = Config.Theme.MainColor
				SliderIndicator.BorderColor3 = Color3.fromRGB(0,0,0)
				SliderIndicator.BorderSizePixel = 0
				SliderIndicator.Size = UDim2.new(((StartingValue or Min) - Min) / (Max - Min), 0, 1, 0)
				SliderIndicator.ZIndex = 5
				AddCorner(SliderIndicator, UDim.new(0,5))

				SliderValue.Name = "SliderValue"
				SliderValue.Parent = SliderHolder
				SliderValue.AnchorPoint = Vector2.new(1,0)
				SliderValue.BackgroundColor3 = Color3.fromRGB(65,65,65)
				SliderValue.BorderColor3 = Color3.fromRGB(0,0,0)
				SliderValue.BorderSizePixel = 0
				SliderValue.Position = UDim2.new(1,-10,0,5)
				SliderValue.Size = UDim2.new(0,50,0,20)
				SliderValue.ZIndex = 5
				SliderValue.Font = Config.Theme.TextFont
				SliderValue.PlaceholderColor3 = Color3.fromRGB(255,255,255)
				SliderValue.Text = tostring(StartingValue or Precise and tonumber(string.format("%.2f", StartingValue)))
				SliderValue.TextColor3 = Color3.fromRGB(255,255,255)
				SliderValue.TextSize = 15
				SliderValue.TextStrokeTransparency = 0.75
				AddCorner(SliderValue, UDim.new(0,5))

				local function Sliding(Input)
					local SliderPosition = UDim2.new(math.clamp((Input.Position.X - SliderBackground.AbsolutePosition.X) / SliderBackground.AbsoluteSize.X, 0, 1), 0, 1, 0)
					TweenService:Create(SliderIndicator, TweenInfo.new(0.02, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {Size = SliderPosition}):Play()
		
					local NonSliderPreciseValue = math.floor(((SliderPosition.X.Scale * Max) / Max) * (Max - Min) + Min)
					local SliderPreciseValue = ((SliderPosition.X.Scale * Max) / Max) * (Max - Min) + Min
		
					local SlidingValue = (Precise and SliderPreciseValue or NonSliderPreciseValue)
					SlidingValue = tonumber(string.format("%.2f", SlidingValue))
		
					SliderValue.Text = tostring(SlidingValue)
					Callback(SlidingValue)
				end
		
				SliderValue.FocusLost:Connect(function()
					if not tonumber(SliderValue.Text) then
						SliderValue.Text = tostring(StartingValue or Precise and tonumber(string.format("%.2f", StartingValue)))
					elseif SliderValue.Text == "" or tonumber(SliderValue.Text) <= Min then
						SliderValue.Text = Min
					elseif SliderValue.Text == "" or tonumber(SliderValue.Text) >= Max then
						SliderValue.Text = Max
					end
		
					TweenService:Create(SliderIndicator, TweenInfo.new(0.02, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {Size = UDim2.new(((tonumber(SliderValue.Text) or Min) - Min) / (Max - Min), 0, 1, 0)}):Play()
					Callback(tonumber(SliderValue.Text))
				end)
		
				SliderIndicator.InputBegan:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						SliderDragging = true
					end
				end)
				
				SliderIndicator.InputEnded:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						SliderDragging = false
					end
				end)
				
				SliderIndicator.InputBegan:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						Sliding(Input)
					end
				end)
			
				UserInput.InputChanged:Connect(function(Input)
					if SliderDragging and Input.UserInputType == Enum.UserInputType.MouseMovement then
						Sliding(Input)
					end
				end)
			end
			function SectionElement:CreateColorPicker(Name, Preset, Callback)
				local ColorPickerHolder = Instance.new("Frame")
				local Title = Instance.new("TextLabel")
				local ColorPickerToggle = Instance.new("TextButton")
				local ColorPicker = Instance.new("Frame")
				local Hue = Instance.new("Frame")
				local UIGradient = Instance.new("UIGradient")
				local HueSelection = Instance.new("Frame")
				local Color = Instance.new("ImageLabel")
				local ColorSelection = Instance.new("Frame")
				local ValueG = Instance.new("TextBox")
				local ValueR = Instance.new("TextBox")
				local ValueB = Instance.new("TextBox")
				local RainbowToggle = Instance.new("Frame")
				local RainbowToggleTitle = Instance.new("TextLabel")
				local Toggle = Instance.new("TextButton")
				local CheckboxTicked = Instance.new("ImageLabel")
				local CheckboxOutline = Instance.new("ImageLabel")
				local TickCover = Instance.new("Frame")

				local ColorPickerToggled = false
				local OldToggleColor = Color3.fromRGB(0, 0, 0)
				local OldColor = Color3.fromRGB(0, 0, 0)
				local OldColorSelectionPosition = nil
				local OldHueSelectionPosition = nil
				local ColorH, ColorS, ColorV = 1, 1, 1
				local RainbowColorPicker = false
				local ColorPickerInput = nil
				local ColorInput = nil
				local HueInput = nil

				ColorPickerHolder.Name = Name .. "ColorPicker"
				ColorPickerHolder.Parent = SectionContent
				ColorPickerHolder.BackgroundColor3 = Color3.fromRGB(255,255,255)
				ColorPickerHolder.BackgroundTransparency = 1
				ColorPickerHolder.BorderColor3 = Color3.fromRGB(0,0,0)
				ColorPickerHolder.BorderSizePixel = 0
				ColorPickerHolder.ClipsDescendants = true
				ColorPickerHolder.Size = UDim2.new(1,0,0,30)

				Title.Name = "Title"
				Title.Parent = ColorPickerHolder
				Title.BackgroundColor3 = Color3.fromRGB(0,0,0)
				Title.BackgroundTransparency = 1
				Title.BorderColor3 = Color3.fromRGB(0,0,0)
				Title.BorderSizePixel = 0
				Title.Position = UDim2.new(0,10,0,0)
				Title.Size = UDim2.new(1,-75,0,30)
				Title.ZIndex = 5
				Title.Font = Config.Theme.TextFont
				Title.Text = Name
				Title.TextColor3 = Color3.fromRGB(255,255,255)
				Title.TextSize = 15
				Title.TextXAlignment = Enum.TextXAlignment.Left

				ColorPickerToggle.Name = "ColorPickerToggle"
				ColorPickerToggle.Parent = ColorPickerHolder
				ColorPickerToggle.AnchorPoint = Vector2.new(1, 0)
				ColorPickerToggle.BackgroundColor3 = Preset
				ColorPickerToggle.BorderColor3 = Color3.fromRGB(0,0,0)
				ColorPickerToggle.BorderSizePixel = 0
				ColorPickerToggle.Position = UDim2.new(1,-10,0,5)
				ColorPickerToggle.Size = UDim2.new(0,50,0,20)
				ColorPickerToggle.ZIndex = 5
				ColorPickerToggle.AutoButtonColor = false
				ColorPickerToggle.Font = Config.Theme.TextFont
				ColorPickerToggle.Text = ""
				ColorPickerToggle.TextColor3 = Color3.fromRGB(255,255,255)
				ColorPickerToggle.TextSize = 15
				ColorPickerToggle.TextStrokeTransparency = 0.75
				ColorPickerToggle.TextTransparency = 1
				AddCorner(ColorPickerToggle, UDim.new(0,5))

				ColorPicker.Name = "ColorPicker"
				ColorPicker.Parent = ColorPickerHolder
				ColorPicker.AnchorPoint = Vector2.new(0.5,0)
				ColorPicker.BackgroundColor3 = Color3.fromRGB(45,45,45)
				ColorPicker.BackgroundTransparency = 1
				ColorPicker.BorderColor3 = Color3.fromRGB(0,0,0)
				ColorPicker.BorderSizePixel = 0
				ColorPicker.Position = UDim2.new(0.5,0,0,30)
				ColorPicker.Size = UDim2.new(1,-10,0,165)
				ColorPicker.ZIndex = 10

				Hue.Name = "Hue"
				Hue.Parent = ColorPicker
				Hue.AnchorPoint = Vector2.new(1,0)
				Hue.BackgroundColor3 = Color3.fromRGB(255,255,255)
				Hue.BorderColor3 = Color3.fromRGB(0,0,0)
				Hue.BorderSizePixel = 0
				Hue.Position = UDim2.new(1,-10,0,5)
				Hue.Size = UDim2.new(0,20,0,100)
				Hue.ZIndex = 10
				AddCorner(Hue, UDim.new(0,5))

				UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(0.20, Color3.fromRGB(234, 255, 0)), ColorSequenceKeypoint.new(0.40, Color3.fromRGB(21, 255, 0)), ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.80, Color3.fromRGB(0, 17, 255)), ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 0, 251)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 4))}
				UIGradient.Rotation = 90
				UIGradient.Parent = Hue

				HueSelection.Name = "HueSelection"
				HueSelection.Parent = Hue
				HueSelection.AnchorPoint = Vector2.new(0.5,0.5)
				HueSelection.BackgroundColor3 = Color3.fromRGB(255,255,255)
				HueSelection.BorderColor3 = Color3.fromRGB(0,0,0)
				HueSelection.BorderSizePixel = 0
				HueSelection.Position = UDim2.new(0.5, 0, 1 - select(1, Color3.toHSV(Preset)))
				HueSelection.Size = UDim2.new(0,10,0,10)
				HueSelection.ZIndex = 10
				AddCorner(HueSelection, UDim.new(1,0))

				Color.Name = "Color"
				Color.Parent = ColorPicker
				Color.BackgroundColor3 = Preset
				Color.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Color.BorderSizePixel = 0
				Color.Position = UDim2.new(0, 10, 0, 5)
				Color.Size = UDim2.new(0, 145, 0, 100)
				Color.ZIndex = 10
				Color.Image = "rbxassetid://4155801252"
				AddCorner(Color, UDim.new(0,5))

				ColorSelection.Name = "ColorSelection"
				ColorSelection.Parent = Color
				ColorSelection.AnchorPoint = Vector2.new(0.5,0.5)
				ColorSelection.BackgroundColor3 = Color3.fromRGB(255,255,255)
				ColorSelection.BorderColor3 = Color3.fromRGB(0,0,0)
				ColorSelection.BorderSizePixel = 0
				ColorSelection.Position = UDim2.new(Preset and select(3, Color3.toHSV(Preset)))
				ColorSelection.Size = UDim2.new(0,10,0,10)
				ColorSelection.ZIndex = 10
				AddCorner(ColorSelection, UDim.new(1,0))

				ValueR.Name = "ValueR"
				ValueR.Parent = ColorPicker
				ValueR.BackgroundColor3 = Color3.fromRGB(45,45,45)
				ValueR.BorderColor3 = Color3.fromRGB(0,0,0)
				ValueR.BorderSizePixel = 0
				ValueR.Position = UDim2.new(0,10,0,115)
				ValueR.Size = UDim2.new(0,50,0,20)
				ValueR.ZIndex = 10
				ValueR.Font = Config.Theme.TextFont
				ValueG.PlaceholderColor3 = Color3.fromRGB(255,255,255)
				ValueR.Text = "R: 255"
				ValueR.TextColor3 = Color3.fromRGB(255,255,255)
				ValueR.TextSize = 15
				ValueG.TextStrokeTransparency = 0.75
				AddCorner(ValueR, UDim.new(0,5))

				ValueG.Name = "ValueG"
				ValueG.Parent = ColorPicker
				ValueG.BackgroundColor3 = Color3.fromRGB(45,45,45)
				ValueG.BorderColor3 = Color3.fromRGB(0,0,0)
				ValueG.BorderSizePixel = 0
				ValueG.Position = UDim2.new(0,65,0,115)
				ValueG.Size = UDim2.new(0,50,0,20)
				ValueG.ZIndex = 10
				ValueG.Font = Config.Theme.TextFont
				ValueG.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
				ValueG.Text = "G: 255"
				ValueG.TextColor3 = Color3.fromRGB(255,255,255)
				ValueG.TextSize = 15
				ValueG.TextStrokeTransparency = 0.75
				AddCorner(ValueG, UDim.new(0,5))

				ValueB.Name = "ValueB"
				ValueB.Parent = ColorPicker
				ValueB.BackgroundColor3 = Color3.fromRGB(45,45,45)
				ValueB.BorderColor3 = Color3.fromRGB(0,0,0)
				ValueB.BorderSizePixel = 0
				ValueB.Position = UDim2.new(0,120,0,115)
				ValueB.Size = UDim2.new(0,50,0,20)
				ValueB.ZIndex = 10
				ValueB.Font = Config.Theme.TextFont
				ValueG.PlaceholderColor3 = Color3.fromRGB(255,255,255)
				ValueB.Text = "B: 255"
				ValueB.TextColor3 = Color3.fromRGB(255,255,255)
				ValueB.TextSize = 15
				ValueG.TextStrokeTransparency = 0.75
				AddCorner(ValueB, UDim.new(0,5))

				RainbowToggle.Name = "RainbowToggle"
				RainbowToggle.Parent = ColorPicker
				RainbowToggle.BackgroundColor3 = Color3.fromRGB(0,0,0)
				RainbowToggle.BackgroundTransparency = 1
				RainbowToggle.BorderColor3 = Color3.fromRGB(0,0,0)
				RainbowToggle.BorderSizePixel = 0
				RainbowToggle.Position = UDim2.new(0,0,0,130)
				RainbowToggle.Size = UDim2.new(1,0,0,30)
				RainbowToggle.ZIndex = 5

				RainbowToggleTitle.Name = "RainbowToggleTitle"
				RainbowToggleTitle.Parent = RainbowToggle
				RainbowToggleTitle.BackgroundColor3 = Color3.fromRGB(0,0,0)
				RainbowToggleTitle.BackgroundTransparency = 1
				RainbowToggleTitle.BorderColor3 = Color3.fromRGB(0,0,0)
				RainbowToggleTitle.BorderSizePixel = 0
				RainbowToggleTitle.Position = UDim2.new(0,10,0,0)
				RainbowToggleTitle.Size = UDim2.new(1,-50,1,0)
				RainbowToggleTitle.ZIndex = 5
				RainbowToggleTitle.Font = Config.Theme.TextFont
				RainbowToggleTitle.Text = "Rainbow"
				RainbowToggleTitle.TextColor3 = Color3.fromRGB(185,185,185)
				RainbowToggleTitle.TextSize = 15
				RainbowToggleTitle.TextStrokeTransparency = 0.75
				RainbowToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

				Toggle.Name = "Toggle"
				Toggle.Parent = RainbowToggle
				Toggle.AnchorPoint = Vector2.new(1, 0.5)
				Toggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				Toggle.BackgroundTransparency = 1.000
				Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Toggle.BorderSizePixel = 0
				Toggle.Position = UDim2.new(1, -10, 0.5, 0)
				Toggle.Size = UDim2.new(0, 20, 0, 20)
				Toggle.ZIndex = 5
				Toggle.AutoButtonColor = false
				Toggle.Font = Config.Theme.TextFont
				Toggle.Text = ""
				Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
				Toggle.TextSize = 15
				Toggle.TextStrokeTransparency = 0.75

				CheckboxTicked.Name = "CheckboxTicked"
				CheckboxTicked.Parent = Toggle
				CheckboxTicked.BackgroundColor3 = Color3.fromRGB(0,0,0)
				CheckboxTicked.BackgroundTransparency = 1
				CheckboxTicked.BorderColor3 = Color3.fromRGB(0,0,0)
				CheckboxTicked.BorderSizePixel = 0
				CheckboxTicked.Position = UDim2.new(0.5,-12,0.5,-12)
				CheckboxTicked.Size = UDim2.new(0,24,0,24)
				CheckboxTicked.ZIndex = 5
				CheckboxTicked.Image = "rbxassetid://5416796675"
				CheckboxTicked.ImageColor3 = Color3.fromRGB(65,65,65)

				CheckboxOutline.Name = "CheckboxOutline"
				CheckboxOutline.Parent = Toggle
				CheckboxOutline.BackgroundColor3 = Color3.fromRGB(0,0,0)
				CheckboxOutline.BackgroundTransparency = 1
				CheckboxOutline.BorderColor3 = Color3.fromRGB(0,0,0)
				CheckboxOutline.BorderSizePixel = 0
				CheckboxOutline.Position = UDim2.new(0.5,-12,0.5,-12)
				CheckboxOutline.Size = UDim2.new(0,24,0,24)
				CheckboxOutline.ZIndex = 5
				CheckboxOutline.Image = "rbxassetid://5416796047"
				CheckboxOutline.ImageColor3 = Color3.fromRGB(65,65,65)

				TickCover.Name = "TickCover"
				TickCover.Parent = Toggle
				TickCover.BackgroundColor3 = Color3.fromRGB(30,30,30)
				TickCover.BorderColor3 = Color3.fromRGB(0,0,0)
				TickCover.BorderSizePixel = 0
				TickCover.Position = UDim2.new(0.5,-7,0.5,-7)
				TickCover.Size = UDim2.new(0,14,0,14)
				TickCover.ZIndex = 5

				local function SetRGBValues()
					ValueR.Text = ("R: " .. math.floor(ColorPickerToggle.BackgroundColor3.R * 255))
					ValueG.Text = ("G: " .. math.floor(ColorPickerToggle.BackgroundColor3.G * 255))
					ValueB.Text = ("B: " .. math.floor(ColorPickerToggle.BackgroundColor3.B * 255))
				end
		
				local function UpdateColorPicker()
					ColorPickerToggle.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
					Color.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)
		
					SetRGBValues()
					Callback(ColorPickerToggle.BackgroundColor3)
				end
		
				ColorH = 1 - (math.clamp(HueSelection.AbsolutePosition.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) / Hue.AbsoluteSize.Y)
				ColorS = (math.clamp(ColorSelection.AbsolutePosition.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) / Color.AbsoluteSize.X)
				ColorV = 1 - (math.clamp(ColorSelection.AbsolutePosition.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) / Color.AbsoluteSize.Y)
		
				ColorPickerToggle.BackgroundColor3 = Preset
				Color.BackgroundColor3 = Preset
				SetRGBValues()
				--Callback(Color.BackgroundColor3)
		
				Color.InputBegan:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						if RainbowColorPicker then return end
		
						if ColorInput then
							ColorInput:Disconnect()
						end
						
						ColorInput = RunService.RenderStepped:Connect(function()
							local ColorX = (math.clamp(Mouse.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) / Color.AbsoluteSize.X)
							local ColorY = (math.clamp(Mouse.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) / Color.AbsoluteSize.Y)
		
							ColorSelection.Position = UDim2.new(ColorX, 0, ColorY, 0)
							ColorS = ColorX
							ColorV = 1 - ColorY
		
							UpdateColorPicker()
						end)
					end
				end)
		
				Color.InputEnded:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						if ColorInput then
							ColorInput:Disconnect()
						end
					end
				end)
		
				Hue.InputBegan:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						if RainbowColorPicker then return end
		
						if HueInput then
							HueInput:Disconnect()
						end
						
						HueInput = RunService.RenderStepped:Connect(function()
							local HueY = (math.clamp(Mouse.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) / Hue.AbsoluteSize.Y)
		
							HueSelection.Position = UDim2.new(0.5, 0, HueY, 0)
							ColorH = 1 - HueY
		
							UpdateColorPicker()
						end)
					end
				end)
		
				Hue.InputEnded:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						if HueInput then
							HueInput:Disconnect()
						end
					end
				end)
		
				Toggle.MouseButton1Down:Connect(function()
					RainbowColorPicker = not RainbowColorPicker
				
					if ColorInput then
						ColorInput:Disconnect()
					end
		
					if HueInput then
						HueInput:Disconnect()
					end
		
					if RainbowColorPicker then
						TweenService:Create(RainbowToggleTitle, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
						TweenService:Create(TickCover, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.new(0, 0, 0, 0)}):Play()
						TweenService:Create(CheckboxOutline, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {ImageColor3 = Config.Theme.MainColor}):Play()
						TweenService:Create(CheckboxTicked, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {ImageColor3 = Config.Theme.MainColor}):Play()
		
						OldToggleColor = ColorPickerToggle.BackgroundColor3
						OldColor = Color.BackgroundColor3
						OldColorSelectionPosition = ColorSelection.Position
						OldHueSelectionPosition = HueSelection.Position
		
						while RainbowColorPicker and wait() do
							ColorPickerToggle.BackgroundColor3 = Color3.fromHSV(Library.RainbowColorValue, 1, 1)
							Color.BackgroundColor3 = Color3.fromHSV(Library.RainbowColorValue, 1, 1)
				
							ColorSelection.Position = UDim2.new(1, 0, 0, 0)
							HueSelection.Position = UDim2.new(0.5, 0, 0, Library.HueSelectionPosition)
				
							SetRGBValues()
							Callback(Color.BackgroundColor3)
						end
					elseif not RainbowColorPicker then
						ColorPickerToggle.BackgroundColor3 = OldToggleColor
						Color.BackgroundColor3 = OldColor
		
						ColorSelection.Position = OldColorSelectionPosition
						HueSelection.Position = OldHueSelectionPosition
		
						SetRGBValues()
						Callback(ColorPickerToggle.BackgroundColor3)
	
						TweenService:Create(RainbowToggleTitle, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextColor3 = Color3.fromRGB(185, 185, 185)}):Play()
						TweenService:Create(TickCover, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -7, 0.5, -7), Size = UDim2.new(0, 14, 0, 14)}):Play()
						TweenService:Create(CheckboxOutline, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {ImageColor3 = Color3.fromRGB(65, 65, 65)}):Play()
						TweenService:Create(CheckboxTicked, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {ImageColor3 = Color3.fromRGB(65, 65, 65)}):Play()
					end
				end)
	
				ColorPickerToggle.MouseButton1Down:Connect(function()
					ColorPickerToggled = not ColorPickerToggled
	
					if ColorPickerToggled then
						TweenService:Create(ColorPickerHolder, TweenInfo.new(0.5, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 195)}):Play()
					elseif not ColorPickerToggled then
						TweenService:Create(ColorPickerHolder, TweenInfo.new(0.5, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 30)}):Play()
					end
				end)
	
				table.insert(Library.LibraryColorTable, CheckboxOutline)
				table.insert(Library.LibraryColorTable, CheckboxTicked)
			end
			function SectionElement:CreateDropdown(Name, OptionTable, Preset, Callback)
				local DropdownHolder = Instance.new("Frame")
				local TitleToggle = Instance.new("TextButton")
				local Dropdown = Instance.new("Frame")
				local DropdownContentLayout = Instance.new("UIListLayout")

				local DropdownToggled = true
				local SelectedOption = OptionTable[Preset]

				DropdownHolder.Name = Name .. "Dropdown"
				DropdownHolder.Parent = SectionContent
				DropdownHolder.BackgroundColor3 = Color3.fromRGB(0,0,0)
				DropdownHolder.BackgroundTransparency = 1
				DropdownHolder.BorderColor3 = Color3.fromRGB(0,0,0)
				DropdownHolder.BorderSizePixel = 0
				DropdownHolder.ClipsDescendants = true
				DropdownHolder.Size = UDim2.new(1,0,0,35)
				DropdownHolder.ZIndex = 5

				TitleToggle.Name = "TitleToggle"
				TitleToggle.Parent = DropdownHolder
				TitleToggle.BackgroundColor3 = Color3.fromRGB(0,0,0)
				TitleToggle.BackgroundTransparency = 1
				TitleToggle.BorderColor3 = Color3.fromRGB(0,0,0)
				TitleToggle.BorderSizePixel = 0
				TitleToggle.Position = UDim2.new(0,10,0,0)
				TitleToggle.Size = UDim2.new(1,-10,0,30)
				TitleToggle.ZIndex = 5
				TitleToggle.Font = Config.Theme.TextFont
				TitleToggle.Text = Name .. " - " .. SelectedOption
				TitleToggle.TextColor3 = Color3.fromRGB(255,255,255)
				TitleToggle.TextSize = 15
				TitleToggle.TextStrokeTransparency = 0.75
				TitleToggle.TextXAlignment = Enum.TextXAlignment.Left

				Dropdown.Name = "Dropdown"
				Dropdown.Parent = DropdownHolder
				Dropdown.AnchorPoint = Vector2.new(0.5,0)
				Dropdown.BackgroundColor3 = Color3.fromRGB(45,45,45)
				Dropdown.BorderColor3 = Color3.fromRGB(0,0,0)
				Dropdown.BorderSizePixel = 0
				Dropdown.Position = UDim2.new(0.5,0,0,30)
				Dropdown.Size = UDim2.new(1,-20,0,0)
				Dropdown.ZIndex = 5
				AddCorner(Dropdown, UDim.new(0,5))

				DropdownContentLayout.Name = "DropdownContentLayout"
				DropdownContentLayout.Parent = Dropdown
				DropdownContentLayout.SortOrder = Enum.SortOrder.LayoutOrder

				local function ResetAllDropdownItems()
					for _, Button in pairs(Dropdown:GetChildren()) do
						if Button:IsA("TextButton") then
							TweenService:Create(Button, TweenInfo.new(0.25, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
						end
					end
				end

				local function ClearAllDropdownItems()
					for i, v in pairs(Dropdown:GetChildren()) do
						if v:IsA("TextButton") then
							v:Destroy()
						end
					end

					DropdownToggled = true
					TweenService:Create(TitleToggle, TweenInfo.new(0.5, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
					TweenService:Create(DropdownHolder, TweenInfo.new(0.5, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 30)}):Play()
					TweenService:Create(Dropdown, TweenInfo.new(0.5, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {Size = UDim2.new(1, -20, 0, 0)}):Play()
				end

				for _, Button in pairs(OptionTable) do
					local DropdownButton = Instance.new("TextButton")

					DropdownButton.Name = Button .. "DropdownButton"
					DropdownButton.Parent = Dropdown
					DropdownButton.BackgroundColor3 = Color3.fromRGB(0,0,0)
					DropdownButton.BackgroundTransparency = 1
					DropdownButton.BorderColor3 = Color3.fromRGB(0,0,0)
					DropdownButton.BorderSizePixel = 0
					DropdownButton.Size = UDim2.new(1,0,0,25)
					DropdownButton.ZIndex = 5
					DropdownButton.AutoButtonColor = false
					DropdownButton.Font = Enum.Font.SourceSansBold
					DropdownButton.Text = Button
					DropdownButton.TextColor3 = Color3.fromRGB(255,255,255)
					DropdownButton.TextSize = 15
					DropdownButton.TextStrokeTransparency = 0.75

					if Button == SelectedOption then
						DropdownButton.TextColor3 = Config.Theme.MainColor
					end

					DropdownButton.MouseButton1Down:Connect(function()
						SelectedOption = Button
						ResetAllDropdownItems()
						TitleToggle.Text = Name .. " - " .. SelectedOption
						TweenService:Create(DropdownButton, TweenInfo.new(0.35, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {TextColor3 = Config.Theme.MainColor}):Play()
						Callback(DropdownButton.Text)
					end)

					DropdownButton.InputBegan:Connect(function(Input)
						if Input.UserInputType == Enum.UserInputType.MouseMovement then
							TweenService:Create(DropdownButton, TweenInfo.new(0.35, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {BackgroundTransparency = 0.95}):Play()
						end
					end)

					DropdownButton.InputEnded:Connect(function(Input)
						if Input.UserInputType == Enum.UserInputType.MouseMovement then
							TweenService:Create(DropdownButton, TweenInfo.new(0.35, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
						end
					end)
				end
				
				TitleToggle.MouseButton1Down:Connect(function()
					DropdownToggled = not DropdownToggled
				
					if DropdownToggled then
						TweenService:Create(TitleToggle, TweenInfo.new(0.5, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
						TweenService:Create(DropdownHolder, TweenInfo.new(0.5, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 30)}):Play()
						TweenService:Create(Dropdown, TweenInfo.new(0.5, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {Size = UDim2.new(1, -20, 0, 0)}):Play()
					elseif not DropdownToggled then
						TweenService:Create(TitleToggle, TweenInfo.new(0.5, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(185, 185, 185)}):Play()
						TweenService:Create(DropdownHolder, TweenInfo.new(0.5, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 30 + DropdownContentLayout.AbsoluteContentSize.Y)}):Play()
						TweenService:Create(Dropdown, TweenInfo.new(0.5, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {Size = UDim2.new(1, -20, 0, DropdownContentLayout.AbsoluteContentSize.Y)}):Play()
					end
				end)
			end
			function SectionElement:CreateKeybind(Name, Preset, KeyboardOnly, HoldMode, Callback)
				local KeybindHolder = Instance.new("Frame")
				local Title = Instance.new("TextLabel")
				local KeybindButton = Instance.new("TextButton")

				local OldBind = Preset.Name
				local LoadFromPreset = false
				local JustBinded = false

				local NotAllowedKeys = {
					Return = true,
					Space = true,
					Tab = true,
					Unknown = true,
					MouseButton1 = true
				}

				local AllowedMouseTypes = {
					MouseButton2 = true,
					MouseButton3 = true
				}

				local ShortenedNames = {
					LeftShift = "LShift",
					RightShift = "RShift",
					LeftControl = "LCtrl",
					RightControl = "RCtrl",
					LeftAlt = "LAlt",
					RightAlt = "RAlt",
					CapsLock = "Caps",
					One = "1",
					Two = "2",
					Three = "3",
					Four = "4",
					Five = "5",
					Six = "6",
					Seven = "7",
					Eight = "8",
					Nine = "9",
					Zero = "0",
					KeypadOne = "Num-1",
					KeypadTwo = "Num-2",
					KeypadThree = "Num-3",
					KeypadFour = "Num-4",
					KeypadFive = "Num-5",
					KeypadSix = "Num-6",
					KeypadSeven = "Num-7",
					KeypadEight = "Num-8",
					KeypadNine = "Num-9",
					KeypadZero = "Num-0",
					Minus = "-",
					Equals = "=",
					Tilde = "~",
					LeftBracket = "[",
					RightBracket = "]",
					RightParenthesis = ")",
					LeftParenthesis = "(",
					Semicolon = ";",
					Quote = "'",
					BackSlash = "\\",
					Comma = ",",
					Period = ".",
					Slash = "/",
					Asterisk = "*",
					Plus = "+",
					Backquote = "`",
					MouseButton1 = "M1",
					MouseButton2 = "M2",
					MouseButton3 = "M3"
				}

				KeybindHolder.Name = Name .. "Keybind"
				KeybindHolder.Parent = SectionContent
				KeybindHolder.BackgroundColor3 = Color3.fromRGB(0,0,0)
				KeybindHolder.BackgroundTransparency = 1
				KeybindHolder.BorderColor3 = Color3.fromRGB(0,0,0)
				KeybindHolder.BorderSizePixel = 0
				KeybindHolder.Size = UDim2.new(1,0,0,30)

				Title.Name = "Title"
				Title.Parent = KeybindHolder
				Title.BackgroundColor3 = Color3.fromRGB(0,0,0)
				Title.BackgroundTransparency = 1
				Title.BorderColor3 = Color3.fromRGB(0,0,0)
				Title.BorderSizePixel = 0
				Title.Position = UDim2.new(0,10,0,0)
				Title.Size = UDim2.new(1,-75,0,30)
				Title.ZIndex = 5
				Title.Font = Config.Theme.TextFont
				Title.Text = Name
				Title.TextColor3 = Color3.fromRGB(255,255,255)
				Title.TextSize = 15
				Title.TextStrokeTransparency = 0.75
				Title.TextXAlignment = Enum.TextXAlignment.Left

				KeybindButton.Name = "KeybindButton"
				KeybindButton.Parent = KeybindHolder
				KeybindButton.AnchorPoint = Vector2.new(1,0)
				KeybindButton.BackgroundColor3 = Color3.fromRGB(65,65,65)
				KeybindButton.BorderColor3 = Color3.fromRGB(0,0,0)
				KeybindButton.BorderSizePixel = 0
				KeybindButton.Position = UDim2.new(1,-10,0,5)
				KeybindButton.Size = UDim2.new(0,50,0,20)
				KeybindButton.ZIndex = 5
				KeybindButton.AutoButtonColor = false
				KeybindButton.Font = Config.Theme.TextFont
				KeybindButton.Text = ShortenedNames[Preset.Name] or ShortenedNames[Preset] or Preset.Name or "None"
				KeybindButton.TextColor3 = Color3.fromRGB(255,255,255)
				KeybindButton.TextSize = 15
				KeybindButton.TextStrokeTransparency = 0.75
				AddCorner(KeybindButton, UDim.new(0,5))

				if LoadFromPreset then
					KeybindButton.Text = Preset
				end

				if Preset == Enum.KeyCode.Unknown or Preset == "Unknown" then
					KeybindButton.Text = "None"
				end

				KeybindButton.MouseButton1Click:Connect(function()
					if Library.CurrentlyBinding then return end

					KeybindButton.Text = "..."

					local Input, Bruh = UserInput.InputBegan:wait()
					Library.CurrentlyBinding = true

					if Input.KeyCode.Name == "Backspace" or Input.KeyCode.Name == "Delete" then
						KeybindButton.Text = "None"
						OldBind = Enum.KeyCode.Unknown.Name
						Library.CurrentlyBinding = false
						JustBinded = false
						return
					end
					
					if (Input.UserInputType ~= Enum.UserInputType.Keyboard and (AllowedMouseTypes[Input.UserInputType.Name]) and (not KeyboardOnly)) or (Input.KeyCode and (not NotAllowedKeys[Input.KeyCode.Name])) then
						local BindName = ((Input.UserInputType ~= Enum.UserInputType.Keyboard and Input.UserInputType.Name) or Input.KeyCode.Name)
						KeybindButton.Text = ShortenedNames[BindName] or BindName
						OldBind = BindName
						Library.CurrentlyBinding = false
						JustBinded = true
					else
						KeybindButton.Text = ShortenedNames[OldBind] or OldBind
						Library.CurrentlyBinding = false
					end
				end)
				
				if not HoldMode then
					UserInput.InputBegan:Connect(function(Input, Processed) 
						if not Processed then
							if UserInput:GetFocusedTextBox() then return end
							if OldBind == Enum.KeyCode.Unknown.Name then return end
							if JustBinded then JustBinded = false return end

							local BindName = ((Input.UserInputType ~= Enum.UserInputType.Keyboard and Input.UserInputType.Name) or Input.KeyCode.Name)

							if BindName == OldBind then 
								Callback(Input.KeyCode.Name)
							end
						end
					end)
				else
					UserInput.InputBegan:Connect(function(Input, Processed) 
						if not Processed then
							if UserInput:GetFocusedTextBox() then return end
							if OldBind == Enum.KeyCode.Unknown.Name then return end
							if JustBinded then JustBinded = false return end

							local BindName = ((Input.UserInputType ~= Enum.UserInputType.Keyboard and Input.UserInputType.Name) or Input.KeyCode.Name)

							if BindName == OldBind then 
								Callback(true)
							end
						end
					end)

					UserInput.InputEnded:Connect(function(Input, Processed) 
						if not Processed then
							if UserInput:GetFocusedTextBox() then return end
							if OldBind == Enum.KeyCode.Unknown.Name then return end
							if JustBinded then JustBinded = false return end

							local HoldModeToggled = false
							local BindName = ((Input.UserInputType ~= Enum.UserInputType.Keyboard and Input.UserInputType.Name) or Input.KeyCode.Name)

							if BindName == OldBind then 
								Callback(false)
							end
						end
					end)
				end
			end
			SectionContent.CanvasSize = UDim2.new(0, 0, 0, SectionContentLayout.AbsoluteContentSize.Y + 15)
			Tab.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y + 25)
			return SectionElement
		end
		return TabElement
	end
	return LibraryInit
end

return Library
