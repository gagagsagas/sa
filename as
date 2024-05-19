if game.PlaceId == 2753915549 then
    World1 = true
elseif game.PlaceId == 4442272183 then
    World2 = true
elseif game.PlaceId == 7449423635 then
    World3 = true
end

do  
	local ui = game:GetService("CoreGui"):FindFirstChild("UILibrary") 
	 if ui then 
		ui:Destroy() 
	end 
end
_G.Logo = 17543996941
_G.Color = Color3.fromRGB(255, 0, 0)
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")
local tween = game:service"TweenService"
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local GuiService = game:GetService("GuiService")

local function tablefound(ta, object)
	for i,v in pairs(ta) do
		if v == object then
			return true
		end
	end
	return false
end

local ActualTypes = {
	RoundFrame = "ImageLabel",
	Shadow = "ImageLabel",
	Circle = "ImageLabel",
	CircleButton = "ImageButton",
	Frame = "Frame",
	Label = "TextLabel",
	Button = "TextButton",
	SmoothButton = "ImageButton",
	Box = "TextBox",
	ScrollingFrame = "ScrollingFrame",
	Menu = "ImageButton",
	NavBar = "ImageButton"
}

local Properties = {
	RoundFrame = {
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5554237731",
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(3,3,297,297)
	},
	SmoothButton = {
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5554237731",
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(3,3,297,297)
	},
	Shadow = {
		Name = "Shadow",
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5554236805",
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(23,23,277,277),
		Size = UDim2.froMoncale(1,1) + UDim2.fromOffset(30,30),
		Position = UDim2.fromOffset(-15,-15)
	},
	Circle = {
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5554831670"
	},
	CircleButton = {
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		Image = "http://www.roblox.com/asset/?id=5554831670"
	},
	Frame = {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.froMoncale(1,1)
	},
	Label = {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(5,0),
		Size = UDim2.froMoncale(1,1) - UDim2.fromOffset(5,0),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left
	},
	Button = {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(5,0),
		Size = UDim2.froMoncale(1,1) - UDim2.fromOffset(5,0),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left
	},
	Box = {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(5,0),
		Size = UDim2.froMoncale(1,1) - UDim2.fromOffset(5,0),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left
	},
	ScrollingFrame = {
		BackgroundTransparency = 1,
		ScrollBarThickness = 0,
		CanvasSize = UDim2.froMoncale(0,0),
		Size = UDim2.froMoncale(1,1)
	},
	Menu = {
		Name = "More",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5555108481",
		Size = UDim2.fromOffset(20,20),
		Position = UDim2.froMoncale(1,0.5) - UDim2.fromOffset(25,10)
	},
	NavBar = {
		Name = "SheetToggle",
		Image = "http://www.roblox.com/asset/?id=5576439039",
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(20,20),
		Position = UDim2.fromOffset(5,5),
		AutoButtonColor = false
	}
}

local Types = {
	"RoundFrame",
	"Shadow",
	"Circle",
	"CircleButton",
	"Frame",
	"Label",
	"Button",
	"SmoothButton",
	"Box",
	"ScrollingFrame",
	"Menu",
	"NavBar"
}

function FindType(String)
	for _, Type in next, Types do
		if Type:sub(1, #String):lower() == String:lower() then
			return Type
		end
	end
	return false
end

local Objects = {}

function Objects.new(Type)
	local TargetType = FindType(Type)
	if TargetType then
		local NewImage = Instance.new(ActualTypes[TargetType])
		if Properties[TargetType] then
			for Property, Value in next, Properties[TargetType] do
				NewImage[Property] = Value
			end
		end
		return NewImage
	else
		return Instance.new(Type)
	end
end

local function GetXY(GuiObject)
	local Max, May = GuiObject.AbsoluteSize.X, GuiObject.AbsoluteSize.Y
	local Px, Py = math.clamp(Mouse.X - GuiObject.AbsolutePosition.X, 0, Max), math.clamp(Mouse.Y - GuiObject.AbsolutePosition.Y, 0, May)
	return Px/Max, Py/May
end

local function CircleAnim(GuiObject, EndColour, StartColour)
	local PX, PY = GetXY(GuiObject)
	local Circle = Objects.new("Shadow")
	Circle.Size = UDim2.froMoncale(0,0)
	Circle.Position = UDim2.froMoncale(PX,PY)
	Circle.ImageColor3 = StartColour or GuiObject.ImageColor3
	Circle.ZIndex = 200
	Circle.Parent = GuiObject
	local Size = GuiObject.AbsoluteSize.X
	TweenService:Create(Circle, TweenInfo.new(0.5), {Position = UDim2.froMoncale(PX,PY) - UDim2.fromOffset(Size/2,Size/2), ImageTransparency = 1, ImageColor3 = EndColour, Size = UDim2.fromOffset(Size,Size)}):Play()
	spawn(function()
		wait(0.5)
		Circle:Destroy()
	end)
end

local function MakeDraggable(topbarobject, object)
	local Dragging = nil
	local DragInput = nil
	local DragStart = nil
	local StartPosition = nil

	local function Update(input)
		local Delta = input.Position - DragStart
		local pos =
			UDim2.new(
				StartPosition.X.Scale,
				StartPosition.X.Offset + Delta.X,
				StartPosition.Y.Scale,
				StartPosition.Y.Offset + Delta.Y
			)
		local Tween = TweenService:Create(object, TweenInfo.new(0.2), {Position = pos})
		Tween:Play()
	end

	topbarobject.InputBegan:Connect(
		function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				DragStart = input.Position
				StartPosition = object.Position

				input.Changed:Connect(
					function()
						if input.UserInputState == Enum.UserInputState.End then
							Dragging = false
						end
					end
				)
			end
		end
	)

	topbarobject.InputChanged:Connect(
		function(input)
			if
				input.UserInputType == Enum.UserInputType.MouseMovement or
				input.UserInputType == Enum.UserInputType.Touch
			then
				DragInput = input
			end
		end
	)

	UserInputService.InputChanged:Connect(
		function(input)
			if input == DragInput and Dragging then
				Update(input)
			end
		end
	)
end

local UIConfig = {Bind = Enum.KeyCode.RightControl}
local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
local length = 20
local randoMontring = ""

math.randoMoneed(os.time())

charTable = {}
for c in chars:gmatch "." do
	table.insert(charTable, c)
end

for i = 1, length do
	randoMontring = randoMontring .. charTable[math.random(1, #charTable)]
end

for i, v in pairs(game.CoreGui:WaitForChild("RobloxGui"):WaitForChild("Modules"):GetChildren()) do
	if v.ClassName == "ScreenGui" then
		for i1, v1 in pairs(v:GetChildren()) do
			if v1.Name == "Main" then
				do
					local ui = v
					if ui then
						ui:Destroy()
					end
				end
			end
		end
	end
end
function CircleClick(Button, X, Y)
	coroutine.resume(
		coroutine.create(
			function()
				local Circle = Instance.new("ImageLabel")
				Circle.Parent = Button
				Circle.Name = "Circle"
				Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Circle.BackgroundTransparency = 1.000
				Circle.ZIndex = 10
				Circle.Image = "rbxassetid://266543268"
				Circle.ImageColor3 = Color3.fromRGB(255, 255, 255)
				Circle.ImageTransparency = 0.7
				local NewX = X - Circle.AbsolutePosition.X
				local NewY = Y - Circle.AbsolutePosition.Y
				Circle.Position = UDim2.new(0, NewX, 0, NewY)

				local Time = 0.2
				Circle:TweenSizeAndPosition(
					UDim2.new(0, 30.25, 0, 30.25),
					UDim2.new(0, NewX - 15, 0, NewY - 10),
					"Out",
					"Quad",
					Time,
					false,
					nil
				)
				for i = 1, 10 do
					Circle.ImageTransparency = Circle.ImageTransparency + 0.01
					wait(Time / 10)
				end
				Circle:Destroy()
			end
		)
	)
end
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
function dragify(Frame, object)
	dragToggle = nil
	dragSpeed = .25
	dragInput = nil
	dragStart = nil
	dragPos = nil

	function updateInput(input)
		Delta = input.Position - dragStart
		Position =
			UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
		game:GetService("TweenService"):Create(object, TweenInfo.new(dragSpeed), {Position = Position}):Play()
	end

	Frame.InputBegan:Connect(
		function(input)
			if
				(input.UserInputType == Enum.UserInputType.MouseButton1 or
					input.UserInputType == Enum.UserInputType.Touch)
			then
				dragToggle = true
				dragStart = input.Position
				startPos = object.Position
				input.Changed:Connect(
					function()
						if (input.UserInputState == Enum.UserInputState.End) then
							dragToggle = false
						end
					end
				)
			end
		end
	)

	Frame.InputChanged:Connect(
		function(input)
			if
				(input.UserInputType == Enum.UserInputType.MouseMovement or
					input.UserInputType == Enum.UserInputType.Touch)
			then
				dragInput = input
			end
		end
	)

	game:GetService("UserInputService").InputChanged:Connect(
	function(input)
		if (input == dragInput and dragToggle) then
			updateInput(input)
		end
	end
	)
end

local UI = Instance.new("ScreenGui")
UI.Name = randoMontring
UI.Parent = game.CoreGui:WaitForChild("RobloxGui"):WaitForChild("Modules")
UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

library = {}

function library:Destroy()
	library:Destroy()
end



function library:Evil(text,text2,logo)
	local Main = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local Top = Instance.new("Frame")
	local TabHolder = Instance.new("Frame")
	local UICorner_2 = Instance.new("UICorner")
	local TabContainer = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local UIPadding = Instance.new("UIPadding")
	local Logo = Instance.new("ImageLabel")
	local Title = Instance.new("TextLabel")
	local Title2 = Instance.new("TextLabel")
	local Welcome = Instance.new("TextLabel")

	Main.Name = "Main"
	Main.Parent = UI
	Main.BackgroundColor3 = Color3.fromRGB(11, 12, 13)
	Main.Position = UDim2.new(0.5, 0, 0.5, 0)
	Main.Size = UDim2.new(0, 0, 0, 0)
	Main.ClipsDescendants = true
	Main.AnchorPoint = Vector2.new(0.5, 0.5)

	Main:TweenSize(UDim2.new(0,585,0,400),"Out","Quad",0.4,true)
	
    local Top2 = Instance.new("Frame")
    Top2.Name = "Top2"
	Top2.Parent = Main
	Top2.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	Top2.BackgroundTransparency = 0
	Top2.Position = UDim2.new(0, 0, 0, 0)
	Top2.Size = UDim2.new(0, 585, 0, 45)

    local UICorner_59 = Instance.new("UICorner")
    UICorner_59.CornerRadius = UDim.new(0, 5)
	UICorner_59.Parent = Top2

	local UIStroke96 = Instance.new("UIStroke")
	UIStroke96.Thickness = 3.2
	UIStroke96.Parent = Main
	UIStroke96.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke96.LineJoinMode = Enum.LineJoinMode.Round
	UIStroke96.Color = Color3.fromRGB(0, 0, 255)
	UIStroke96.Transparency = 0.10
	
	Logo.Name = "Logo"
	Logo.Parent = Main
	Logo.Active = true
	Logo.AnchorPoint = Vector2.new(0,0)
	Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Logo.BackgroundTransparency = 1.000
	Logo.Position = UDim2.new(0, 10, 0, 10)
	Logo.Size = UDim2.new(0, 30, 0, 30)
	Logo.ImageTransparency = 0
	Logo.Image = "rbxassetid://"..(logo or 13732317842)

	Title.Name = "Title"
	Title.Parent = Main
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1.000
	Title.Position = UDim2.new(0, 45, 0, 10)
	Title.Size = UDim2.new(0, 483, 0, 31)
	Title.Font = Enum.Font.GothamMedium
	Title.Text = text
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 17.000
	Title.TextWrapped = true
	Title.TextXAlignment = Enum.TextXAlignment.Left

	Title2.Name = "Title2"
	Title2.Parent = Main
	Title2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title2.BackgroundTransparency = 1.000
	Title2.Position = UDim2.new(0, 95, 0, 10)
	Title2.Size = UDim2.new(0, 483, 0, 31)
	Title2.Font = Enum.Font.GothamMedium
	Title2.Text = text2
	Title2.TextColor3 = Color3.fromRGB(0, 0, 255)
	Title2.TextSize = 17.000
	Title2.TextWrapped = true
	Title2.TextXAlignment = Enum.TextXAlignment.Left

	local UiToggle_UiStroke1 = Instance.new("UIStroke")

	UiToggle_UiStroke1.Color = Color3.fromRGB(25,25,25)
	UiToggle_UiStroke1.Thickness = 2
	UiToggle_UiStroke1.Name = "UiToggle_UiStroke1"
	UiToggle_UiStroke1.Parent = Main

	UICorner.CornerRadius = UDim.new(0, 6)
	UICorner.Parent = Main

	Top.Name = "Top"
	Top.Parent = Main
	Top.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Top.BackgroundTransparency = 1
	Top.Position = UDim2.new(0.021956088, 0, 0, 10)
	Top.Size = UDim2.new(0, 565, 0, 39)
	
	local ClickFrame = Instance.new("Frame")
	ClickFrame.Name = "Top"
	ClickFrame.Parent = Main
	ClickFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ClickFrame.BackgroundTransparency = 1
	ClickFrame.Position = UDim2.new(0, 0, 0, 0)
	ClickFrame.Size = UDim2.new(0, 600, 0, 35)

	TabHolder.Name = "TabHolder"
	TabHolder.Parent = Top
	TabHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabHolder.Position = UDim2.new(0, 120, 0, 0)
	TabHolder.BackgroundTransparency = 1.000
	TabHolder.Size = UDim2.new(0, 450, 0, 38)

	UICorner_2.Parent = TabHolder

	TabContainer.Name = "TabContainer"
	TabContainer.Parent = TabHolder
	TabContainer.Active = true
	TabContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabContainer.BackgroundTransparency = 1.000
	TabContainer.Size = UDim2.new(0, 450, 0, 38)
	TabContainer.CanvasSize = UDim2.new(2, 0, 0, 0)
	TabContainer.ScrollBarThickness = 1
	TabContainer.VerticalScrollBarInset = Enum.ScrollBarInset.Always

	UIListLayout.Parent = TabContainer
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 10)
	UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
	function()
		TabContainer.CanvasSize = UDim2.new(0, UIListLayout.AbsoluteContentSize.X, 0, 0)
	end)
	UIPadding.Parent = TabContainer
	UIPadding.PaddingLeft = UDim.new(0, 5)
	UIPadding.PaddingTop = UDim.new(0, 5)
	local Bottom = Instance.new("Frame")
	Bottom.Name = "Bottom"
	Bottom.Parent = Main
	Bottom.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	Bottom.BackgroundTransparency = 1.000
	Bottom.Position = UDim2.new(0.0119760484, 7, 0, 55)
	Bottom.Size = UDim2.new(0, 500, 0, 320)

	local uitoggled = false
	UserInputService.InputBegan:Connect(
		function(io, p)
			if io.KeyCode == UIConfig.Bind then
				if uitoggled == false then
					Main:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.4, true) wait(0.4) UI.Enabled = false
					uitoggled = true
				else
					UI.Enabled = true
					Main:TweenSize(UDim2.new(0, 585, 0, 400), Enum.EasingDirection.Out, Enum.EasingStyle.Quart,0.4,true)
					uitoggled = false
				end
			end
		end
	)

	dragify(ClickFrame, Main)
	local tabs = {}
	local S = false
	function tabs:CraftTab(Name,icon)
		local FrameTab = Instance.new("Frame")
		local Tab = Instance.new("TextButton")
		local UICorner_3 = Instance.new("UICorner")
		local UICorner_Tab = Instance.new("UICorner")
		local ImageLabel = Instance.new("ImageLabel")
		local TextLabel = Instance.new("TextLabel")
		icon = 123

		FrameTab.Name = "FrameTab"
		FrameTab.Parent = Tab
		FrameTab.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
		FrameTab.BackgroundTransparency = 0
		FrameTab.Position = UDim2.new(0, 0, 0, 22)
		--FrameTab.Size = UDim2.new(0, 80, 0, 2)
		FrameTab.Size = UDim2.new(0, 0, 0, 2)
        FrameTab.Visible = false

		UICorner_Tab.CornerRadius = UDim.new(0, 3)
		UICorner_Tab.Parent = FrameTab

		Tab.Name = "Tab"
		Tab.Parent = TabContainer
		Tab.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
		Tab.Size = UDim2.new(0, 80, 0, 20)
		Tab.BackgroundTransparency = 1.00
		Tab.Text = ""
		UICorner_3.CornerRadius = UDim.new(0, 3)
		UICorner_3.Parent = Tab

		ImageLabel.Parent = Tab
		ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ImageLabel.Position = UDim2.new(0, 5, 0.2, 0)
		ImageLabel.Size = UDim2.new(0, 20, 0, 30)
		ImageLabel.Image = "http://www.roblox.com/asset/?id=" .. icon
		ImageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255)
		ImageLabel.ImageTransparency = 0.2
		ImageLabel.BackgroundTransparency = 1

		TextLabel.Parent = Tab
		TextLabel.Text = Name.." "

		TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.Position = UDim2.new(0, 0, 0, 0)
		TextLabel.Size = UDim2.new(0, 80, 0, 30)
		TextLabel.Font = Enum.Font.GothamBold
		TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.TextSize = 12.300
		TextLabel.TextTransparency = 0.200

		if TextLabel.Name == Name.." " then
			Tab.Size = UDim2.new(0, 60 + TextLabel.TextBounds.X, 0, 15)
		end

		local Page = Instance.new("ScrollingFrame")
		local Left = Instance.new("ScrollingFrame")
		local Right = Instance.new("ScrollingFrame")
		local UIListLayout_5 = Instance.new("UIListLayout")
		local UIPadding_5 = Instance.new("UIPadding")

		Page.Name = "Page"
		Page.Parent = Bottom
		Page.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Page.BackgroundTransparency = 1.000
		Page.Size = UDim2.new(0, 600, 0, 335)
		Page.ScrollBarThickness = 0
		Page.CanvasSize = UDim2.new(0, 0, 0, 0)
		Page.Visible = false

		Left.Name = "Left"
		Left.Parent = Page
		Left.Active = true
		Left.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Left.BackgroundTransparency = 10
		Left.Size = UDim2.new(0, 274, 0, 335)
		Left.ScrollBarThickness = 0
		Left.CanvasSize = UDim2.new(0, 0, 0, 0)

		Right.Name = "Right"
		Right.Parent = Page
		Right.Active = true
		Right.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Right.BackgroundTransparency = 10
		Right.Size = UDim2.new(0, 274, 0, 335)
		Right.ScrollBarThickness = 0
		Right.CanvasSize = UDim2.new(0, 0, 0, 0)

		local LeftList = Instance.new("UIListLayout")
		local RightList = Instance.new("UIListLayout")

		LeftList.Parent = Left
		LeftList.SortOrder = Enum.SortOrder.LayoutOrder
		LeftList.Padding = UDim.new(0, 5)

		RightList.Parent = Right
		RightList.SortOrder = Enum.SortOrder.LayoutOrder
		RightList.Padding = UDim.new(0, 5)

		UIListLayout_5.Parent = Page
		UIListLayout_5.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout_5.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_5.Padding = UDim.new(0, 13)

		UIPadding_5.Parent = Page

		if S == false then
			S = true
			Page.Visible = true
			TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.TextTransparency = 0
			ImageLabel.ImageTransparency = 0
			ImageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255)
			FrameTab.Size = UDim2.new(0, 80, 0, 2)
            FrameTab.Visible = true
		end

		Tab.MouseButton1Click:Connect(
			function()
				for _, x in next, TabContainer:GetChildren() do
					if x.Name == "Tab" then
						TweenService:Create(
							x.TextLabel,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{TextColor3 = Color3.fromRGB(255, 255, 255)}
						):Play()
						TweenService:Create(
							x.ImageLabel,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{ImageColor3 = Color3.fromRGB(255, 255, 255)}
						):Play()
						TweenService:Create(
							x.ImageLabel,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{ImageTransparency = 0.2}
						):Play()
						TweenService:Create(
							x.TextLabel,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{TextTransparency = 0.2}
						):Play()
                        TweenService:Create(
							x.FrameTab,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Size = UDim2.new(0, 0, 0, 2)}
						):Play()
						for index, y in next, Bottom:GetChildren() do
							TweenService:Create(
								y,
								TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
								{Position = UDim2.new(0,1500,0,0)}
							):Play()
							y.Visible = false
						end
                        x.FrameTab.Visible = false
					end
				end
				TweenService:Create(
					TextLabel,
					TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextColor3 = Color3.fromRGB(255, 255, 255)}
				):Play()
				TweenService:Create(
					ImageLabel,
					TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{ImageColor3 = Color3.fromRGB(255, 255, 255)}
				):Play()
				TweenService:Create(
					ImageLabel,
					TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{ImageTransparency = 0}
				):Play()
				TweenService:Create(
					TextLabel,
					TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextTransparency = 0}
				):Play()
                FrameTab.Visible = true
				TweenService:Create(
                    FrameTab,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {Size = UDim2.new(0, 80, 0, 2)}
                ):Play()
				Page.Position = UDim2.new(0,0,0,1500)
				TweenService:Create(
					Page,
					TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
					{Position = UDim2.new(0,0,0,0)}
				):Play()
				Page.Visible = true
			end
		)

		local function GetType(value)
			if value == 1 then
				return Left
			elseif value == 2 then
				return Right
			else
				return Left
			end
		end

		game:GetService("RunService").Stepped:Connect(function()
			pcall(function()
				Right.CanvasSize = UDim2.new(0,0,0,RightList.AbsoluteContentSize.Y + 5)
				Left.CanvasSize = UDim2.new(0,0,0,LeftList.AbsoluteContentSize.Y + 5)
			end)
		end)

		local sections = {}
		function sections:CraftPage(Name,side)

			if side == nil then
				return Left
			end

			local Section = Instance.new("Frame")
			local UICorner_5 = Instance.new("UICorner")
			local Top_2 = Instance.new("Frame")
			local Line = Instance.new("Frame")
			local Sectionname = Instance.new("TextLabel")
			local SectionContainer = Instance.new("Frame")
			local SectionContainer_2 = Instance.new("Frame")
			local UIListLayout_2 = Instance.new("UIListLayout")
			local UIPadding_2 = Instance.new("UIPadding")

			Section.Name = "Section"
			Section.Parent = GetType(side)
			Section.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			Section.ClipsDescendants = true
			Section.Transparency = 0
			Section.Size = UDim2.new(0, 240, 0, 400)

			UICorner_5.CornerRadius = UDim.new(0, 5)
			UICorner_5.Parent = Section

			Top_2.Name = "Top"
			Top_2.Parent = Section
			Top_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Top_2.BackgroundTransparency = 1.000
			Top_2.BorderColor3 = Color3.fromRGB(27, 42, 53)
			Top_2.Size = UDim2.new(0, 238, 0, 31)

			Line.Name = "Line"
			Line.Parent = Top_2
			Line.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Line.BorderSizePixel = 0
			Line.Size = UDim2.new(0, 274, 0, 1)

			Sectionname.Name = "Sectionname"
			Sectionname.Parent = Top_2
			Sectionname.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Sectionname.BackgroundTransparency = 1.000
			Sectionname.Position = UDim2.new(0.0591227226, 0, 0.0222222228, 0)
			Sectionname.Size = UDim2.new(0, 224, 0, 24)
			Sectionname.Font = Enum.Font.GothamBold
			Sectionname.Text = Name
			Sectionname.TextColor3 = Color3.fromRGB(0, 0, 255)
			Sectionname.TextSize = 14.000
			Sectionname.TextTransparency = 0
			Sectionname.TextXAlignment = Enum.TextXAlignment.Left

			SectionContainer.Name = "SectionContainer"
			SectionContainer.Parent = Top_2
			SectionContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SectionContainer.BackgroundTransparency = 1.000
			SectionContainer.BorderSizePixel = 0
			SectionContainer.Position = UDim2.new(0, 0, 0.796416223, 0)
			SectionContainer.Size = UDim2.new(0, 239, 0, 318)

			SectionContainer_2.Name = "SectionContainer_2"
			SectionContainer_2.Parent = Top_2
			SectionContainer_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SectionContainer_2.BackgroundTransparency = 1.000
			SectionContainer_2.BorderSizePixel = 0
			SectionContainer_2.Position = UDim2.new(0, 0, 0.796416223, 0)
			SectionContainer_2.Size = UDim2.new(0, 239, 0, 318)

			UIListLayout_2.Parent = SectionContainer
			UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout_2.Padding = UDim.new(0, 10)

			UIPadding_2.Parent = SectionContainer
			UIPadding_2.PaddingLeft = UDim.new(0, 5)

			UIListLayout_2:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
			function()

				Section.Size = UDim2.new(1, 0, 0, UIListLayout_2.AbsoluteContentSize.Y + 35)
			end
			)

			local functionitem = {}

			function functionitem:Label(text)
				local textas = {}
				local Label = Instance.new("Frame")
				local Text = Instance.new("TextLabel")
				Label.Name = "Label"
				Label.Parent = SectionContainer
				Label.AnchorPoint = Vector2.new(0.5, 0.5)
				Label.BackgroundTransparency = 1.000
				Label.Size = UDim2.new(0, 265, 0, 30)

				local Label22 = Instance.new("Frame")
				Label22.Name = "Label22"
				Label22.Parent = Label
				Label22.AnchorPoint = Vector2.new(0, 0.5)
				Label22.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
				Label22.Position = UDim2.new(0,0,0.5,0)
				Label22.Size = UDim2.new(0, 45, 0, 2)

				local Label23 = Instance.new("Frame")
				Label23.Name = "Label23"
				Label23.Parent = Label
				Label23.AnchorPoint = Vector2.new(0, 0.5)
				Label23.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
				Label23.Position = UDim2.new(0,216,0.5,0)
				Label23.Size = UDim2.new(0, 45, 0, 2)

				Text.Name = "Text"
				Text.Parent = Label
				Text.AnchorPoint = Vector2.new(0.5, 0.5)
				Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Text.BackgroundTransparency = 1.000
				Text.Position = UDim2.new(0.5, 0, 0.5, 0)
				Text.Size = UDim2.new(0, 53, 0, 150)
				Text.ZIndex = 16
				Text.Font = Enum.Font.GothamBold
				Text.Text = text
				Text.TextColor3 = Color3.fromRGB(255, 255, 255)
				Text.TextSize = 12.000
				function textas.Refresh(newtext)
					Text.Text = newtext
				end
				return textas
			end
			function functionitem:Seperator(text)
				local textas = {}
				local Label = Instance.new("Frame")
				local Text = Instance.new("TextLabel")
				Label.Name = "Label"
				Label.Parent = SectionContainer
				Label.AnchorPoint = Vector2.new(0.5, 0.5)
				Label.BackgroundTransparency = 1.000
				Label.Size = UDim2.new(0, 265, 0, 30)

				local Label22 = Instance.new("Frame")
				Label22.Name = "Label22"
				Label22.Parent = Label
				Label22.AnchorPoint = Vector2.new(0, 0.5)
				Label22.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
				Label22.Position = UDim2.new(0,0,0.5,0)
				Label22.Size = UDim2.new(0, 45, 0, 2)

				local Label23 = Instance.new("Frame")
				Label23.Name = "Label23"
				Label23.Parent = Label
				Label23.AnchorPoint = Vector2.new(0, 0.5)
				Label23.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
				Label23.Position = UDim2.new(0,216,0.5,0)
				Label23.Size = UDim2.new(0, 45, 0, 2)

				Text.Name = "Text"
				Text.Parent = Label
				Text.AnchorPoint = Vector2.new(0.5, 0.5)
				Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Text.BackgroundTransparency = 1.000
				Text.Position = UDim2.new(0.5, 0, 0.5, 0)
				Text.Size = UDim2.new(0, 53, 0, 150)
				Text.ZIndex = 16
				Text.Font = Enum.Font.GothamBold
				Text.Text = text
				Text.TextColor3 = Color3.fromRGB(255, 255, 255)
				Text.TextSize = 12.000
				function textas.Refresh(newtext)
					Text.Text = newtext
				end
				return textas
			end
			function functionitem:LabelLog(text)
				local textas = {}
				local Label = Instance.new("Frame")
				local Text = Instance.new("TextLabel")
				Label.Name = "Label"
				Label.Parent = SectionContainer
				Label.AnchorPoint = Vector2.new(0.5, 0.5)
				Label.BackgroundTransparency = 1.000
				Label.Size = UDim2.new(0, 265, 0, 30)

				Text.Name = "Text"
				Text.Parent = Label
				Text.AnchorPoint = Vector2.new(0.5, 0.5)
				Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Text.BackgroundTransparency = 1.000
				Text.Position = UDim2.new(0.5, 0, 0.5, 0)
				Text.Size = UDim2.new(0, 53, 0, 12)
				Text.ZIndex = 16
				Text.Font = Enum.Font.GothamBold
				Text.Text = text
				Text.TextColor3 = Color3.fromRGB(255, 255, 255)
				Text.TextSize = 12.000
				function textas:Refresh(newtext)
					Text.Text = newtext
				end
                function textas:Color(Color)
					Text.TextColor3 = Color
				end
				return textas
			end

			function functionitem:ButtonTog(Title, default, callback)
				local b3Func = {}
				local callback = callback or function()
				end
				local Tgs = default
				local Button_2 = Instance.new("Frame")
				local UICorner_21 = Instance.new("UICorner")
				local TextLabel_4 = Instance.new("TextLabel")
				local TextButton_4 = Instance.new("TextButton")

				Button_2.Name = "Button"
				Button_2.Parent = SectionContainer
				Button_2.BackgroundColor3 = Color3.fromRGB(33, 132, 112)
				Button_2.Size = UDim2.new(0, 265, 0, 30)
				Button_2.ZIndex = 16

				if default then
					Button_2.BackgroundColor3 = Color3.fromRGB(33, 132, 112)
				else
					Button_2.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
				end

				UICorner_21.CornerRadius = UDim.new(0, 4)
				UICorner_21.Parent = Button_2

				TextLabel_4.Parent = Button_2
				TextLabel_4.AnchorPoint = Vector2.new(0.5, 0.5)
				TextLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel_4.BackgroundTransparency = 1.000
				TextLabel_4.Position = UDim2.new(0.5, 0, 0.5, 0)
				TextLabel_4.Size = UDim2.new(0, 40, 0, 12)
				TextLabel_4.ZIndex = 16
				TextLabel_4.Font = Enum.Font.GothamBold
				TextLabel_4.Text = tostring(Title)
				TextLabel_4.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel_4.TextSize = 12.000

				TextButton_4.Parent = Button_2
				TextButton_4.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				TextButton_4.BackgroundTransparency = 1.000
				TextButton_4.BorderSizePixel = 0
				TextButton_4.ClipsDescendants = true
				TextButton_4.Size = UDim2.new(1, 0, 1, 0)
				TextButton_4.ZIndex = 16
				TextButton_4.AutoButtonColor = false
				TextButton_4.Font = Enum.Font.Gotham
				TextButton_4.Text = ""
				TextButton_4.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextButton_4.TextSize = 14.000

				TextButton_4.MouseButton1Click:Connect(
					function()
						Tgs = not Tgs
						b3Func:Update(Tgs)
						CircleClick(Button_2, Mouse.X, Mouse.Y)
					end
				)

				if default then
					TweenService:Create(
						Button_2,
						TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{
							BackgroundColor3 = state and Color3.fromRGB(0, 0, 255) or Color3.fromRGB(33, 132, 112)
						}
					):Play()
					callback(default)
					Tgs = default
				end
				function b3Func:Update(state)
					TweenService:Create(
						Button_2,
						TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{
							BackgroundColor3 = state and Color3.fromRGB(33, 132, 112) or Color3.fromRGB(0, 0, 255)
						}
					):Play()
					callback(state)
					Tgs = state
				end

				return b3Func
			end


			function functionitem:Button(Name, callback)
				local Button = Instance.new("Frame")
				local UICorner_6 = Instance.new("UICorner")
				local TextLabel_3 = Instance.new("TextLabel")
				local TextButton = Instance.new("TextButton")

				Button.Name = "Button"
				Button.Parent = SectionContainer
				Button.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
				Button.Size = UDim2.new(0, 265, 0, 30)
				Button.ZIndex = 16

				UICorner_6.CornerRadius = UDim.new(0, 4)
				UICorner_6.Parent = Button

				TextLabel_3.Parent = Button
				TextLabel_3.AnchorPoint = Vector2.new(0.5, 0.5)
				TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel_3.BackgroundTransparency = 1.000
				TextLabel_3.Position = UDim2.new(0.5, 0, 0.5, 0)
				TextLabel_3.Size = UDim2.new(0, 40, 0, 12)
				TextLabel_3.ZIndex = 16
				TextLabel_3.Font = Enum.Font.GothamBold
				TextLabel_3.Text = Name
				TextLabel_3.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel_3.TextSize = 14.000

				TextButton.Parent = Button
				TextButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				TextButton.BackgroundTransparency = 1.000
				TextButton.BorderSizePixel = 0
				TextButton.ClipsDescendants = true
				TextButton.Size = UDim2.new(1, 0, 1, 0)
				TextButton.ZIndex = 16
				TextButton.AutoButtonColor = false
				TextButton.Font = Enum.Font.Gotham
				TextButton.Text = ""
				TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextButton.TextSize = 14.000

				TextButton.MouseEnter:Connect(function()
					TweenService:Create(
						Button,
						TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{BackgroundTransparency = 0.5}
					):Play()
				end)

				TextButton.MouseLeave:Connect(function()
					TweenService:Create(
						Button,
						TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{BackgroundTransparency = 0}
					):Play()
				end)

				TextButton.MouseButton1Click:Connect(function()
					CircleClick(Button, Mouse.X, Mouse.Y)
					TextLabel_3.TextSize = 0
					TweenService:Create(
						TextLabel_3,
						TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
						{TextSize = 12}
					):Play()
					callback()
				end)
			end

			function functionitem:Toggle(Name, default, callback)
				local Tgo = default or false 
				local MainToggle = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local Text = Instance.new("TextLabel")
				local MainToggle_2 = Instance.new("ImageLabel")
				local UICorner_2 = Instance.new("UICorner")
				local MainToggle_3 = Instance.new("ImageLabel")
				local UICorner_3 = Instance.new("UICorner")
				local TextButton = Instance.new("TextButton")

				MainToggle.Name = "MainToggle"
				MainToggle.Parent = SectionContainer
				MainToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				MainToggle.BackgroundTransparency = 1
				MainToggle.BorderSizePixel = 0
				MainToggle.ClipsDescendants = true
				MainToggle.Size = UDim2.new(0, 265, 0, 45)
				MainToggle.ZIndex = 16

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = MainToggle

				Text.Name = "Text"
				Text.Parent = MainToggle
				Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Text.BackgroundTransparency = 1.000
				Text.Position = UDim2.new(0, 45, 0, 16)
				Text.Size = UDim2.new(0, 100, 0, 12)
				Text.ZIndex = 16
				Text.Font = Enum.Font.GothamBold
				Text.Text = Name
				Text.TextColor3 = Color3.fromRGB(255, 255, 255)
				Text.TextSize = 14.000
				Text.TextTransparency = 0.2
				Text.TextXAlignment = Enum.TextXAlignment.Left

				MainToggle_3.Name = "MainToggle"
				MainToggle_3.Parent = MainToggle
				MainToggle_3.AnchorPoint = Vector2.new(0.5, 0.5)
				MainToggle_3.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
				MainToggle_3.ClipsDescendants = true
				MainToggle_3.Position = UDim2.new(0, 15, 0.5, 0)
				MainToggle_3.Size = UDim2.new(0, 25, 0, 25)
				MainToggle_3.ZIndex = 16
				MainToggle_3.Image = "http://www.roblox.com/asset/?id="
				MainToggle_3.ImageColor3 = Color3.fromRGB(255, 255, 255)
				MainToggle_3.Visible = true

				UICorner_3.CornerRadius = UDim.new(0, 5)
				UICorner_3.Parent = MainToggle_3

				TextButton.Name = ""
				TextButton.Parent = MainToggle
				TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextButton.BackgroundTransparency = 1.000
				TextButton.BorderSizePixel = 0
				TextButton.Position = UDim2.new(0, 0, 0, 0)
				TextButton.Size = UDim2.new(0, 265, 0, 35)
				TextButton.ZIndex = 16
				TextButton.AutoButtonColor = false
				TextButton.Font = Enum.Font.Gotham
				TextButton.Text = ""
				TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextButton.TextSize = 14.000

				if default == true then
					MainToggle_3.BackgroundColor3 = Color3.fromRGB(30, 50, 30)
					MainToggle_3:TweenSize(UDim2.new(0, 20, 0, 20),"In","Quad",0.1,true)
					MainToggle_3.Image = "http://www.roblox.com/asset/?id=6023426926"
                    UICorner_3.CornerRadius = UDim.new(0, 100)
					pcall(callback,true)
				end

				TextButton.MouseButton1Click:Connect(function()
					if Tgo == false then
						Tgo = true
						MainToggle_3.BackgroundColor3 = Color3.fromRGB(113, 255, 78)
						MainToggle_3:TweenSize(UDim2.new(0, 25, 0, 25),"In","Quad",0.2,true)
						MainToggle_3.Image = "http://www.roblox.com/asset/?id=6023426926"
                        UICorner_3.CornerRadius = UDim.new(0, 100)
					else
						Tgo = false
						MainToggle_3.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
						MainToggle_3.Image = "http://www.roblox.com/asset/?id=00"
						MainToggle_3:TweenSize(UDim2.new(0, 25, 0, 25),"In","Quad",0.2,true)
                        UICorner_3.CornerRadius = UDim.new(0, 5)
					end
					CircleClick(TextButton, Mouse.X, Mouse.Y)
					pcall(callback,Tgo)
				end)
                local TogleFunc = {}
				function TogleFunc:Turn(default1)
					local Tgo1 = default1 or false 
					if Tgo1 == false then
						Tgo1 = true
						MainToggle_3.BackgroundColor3 = Color3.fromRGB(113, 255, 78)
						MainToggle_3:TweenSize(UDim2.new(0, 25, 0, 25),"In","Quad",0.2,true)
						MainToggle_3.Image = "http://www.roblox.com/asset/?id=6023426926"
                        UICorner_3.CornerRadius = UDim.new(0, 100)
					else
						Tgo1 = false
						MainToggle_3.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
						MainToggle_3.Image = "http://www.roblox.com/asset/?id=00"
						MainToggle_3:TweenSize(UDim2.new(0, 25, 0, 25),"In","Quad",0.2,true)
                        UICorner_3.CornerRadius = UDim.new(0, 5)
					end
					pcall(callback,Tgo1)
			    end
				return TogleFunc
            end

			function functionitem:Textbox(Name, Placeholder, callback)
				local Textbox = Instance.new("Frame")
				local UICorner_16 = Instance.new("UICorner")
				local Text_5 = Instance.new("TextLabel")
				local TextboxHoler = Instance.new("Frame")
				local UICorner_17 = Instance.new("UICorner")
				local HeadTitle = Instance.new("TextBox")
				Textbox.Name = "Textbox"
				Textbox.Parent = SectionContainer
				Textbox.BackgroundColor3 = Color3.fromRGB(1, 2, 3)
				Textbox.BackgroundTransparency = 0.700
				Textbox.BorderSizePixel = 0
				Textbox.ClipsDescendants = true
				Textbox.Size = UDim2.new(0, 265, 0, 60)
				Textbox.ZIndex = 16

				UICorner_16.CornerRadius = UDim.new(0, 4)
				UICorner_16.Parent = Textbox

				Text_5.Name = "Text"
				Text_5.Parent = Textbox
				Text_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Text_5.BackgroundTransparency = 1.000
				Text_5.Position = UDim2.new(0, 10, 0, 10)
				Text_5.Size = UDim2.new(0, 43, 0, 12)
				Text_5.ZIndex = 16
				Text_5.Font = Enum.Font.GothamBold
				Text_5.Text = Name
				Text_5.TextColor3 = Color3.fromRGB(0, 0, 255)
				Text_5.TextSize = 11.000
				Text_5.TextXAlignment = Enum.TextXAlignment.Left

				TextboxHoler.Name = "TextboxHoler"
				TextboxHoler.Parent = Textbox
				TextboxHoler.AnchorPoint = Vector2.new(0.5, 0.5)
				TextboxHoler.BackgroundColor3 = Color3.fromRGB(13, 13, 15)
				TextboxHoler.BackgroundTransparency = 1.000
				TextboxHoler.BorderSizePixel = 0
				TextboxHoler.Position = UDim2.new(0.5, 0, 0.5, 13)
				TextboxHoler.Size = UDim2.new(0.970000029, 0, 0, 30)

				UICorner_17.CornerRadius = UDim.new(0, 8)
				UICorner_17.Parent = TextboxHoler

				HeadTitle.Name = "HeadTitle"
				HeadTitle.Parent = TextboxHoler
				HeadTitle.AnchorPoint = Vector2.new(0.5, 0.5)
				HeadTitle.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
				HeadTitle.BackgroundTransparency = 1.000
				HeadTitle.BorderSizePixel = 0
				HeadTitle.ClipsDescendants = true
				HeadTitle.Position = UDim2.new(0.5, 3, 0.5, 0)
				HeadTitle.Size = UDim2.new(0.949999988, 0, 0, 25)
				HeadTitle.ZIndex = 16
				HeadTitle.Font = Enum.Font.GothamBold
				HeadTitle.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
				HeadTitle.PlaceholderText = Placeholder
				HeadTitle.Text = ""
				HeadTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
				HeadTitle.TextSize = 13.000
				HeadTitle.TextXAlignment = Enum.TextXAlignment.Center
				
				local ButtonColor44 = Instance.new("UIStroke")
				
				ButtonColor44.Thickness = 1.6
				ButtonColor44.Name = ""
				ButtonColor44.Parent = HeadTitle
				ButtonColor44.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				ButtonColor44.LineJoinMode = Enum.LineJoinMode.Round
				ButtonColor44.Color = Color3.fromRGB(0, 0, 255)
				ButtonColor44.Transparency = 0
				
				HeadTitle.FocusLost:Connect(
				function(ep)
					if ep then
						if #HeadTitle.Text > 0 then
							callback(HeadTitle.Text)
							HeadTitle.Text = HeadTitle.Text
						end
					end
				end)
			end

			function functionitem:Dropdown(text, list, default, callback)
				local Dropfunc = {}

				local MainDropDown = Instance.new("Frame")
				local UICorner_7 = Instance.new("UICorner")
				local MainDropDown_2 = Instance.new("Frame")
				local UICorner_8 = Instance.new("UICorner")
				local v = Instance.new("TextButton")
				local Text_2 = Instance.new("TextLabel")
				local ImageButton = Instance.new("ImageButton")
				local Scroll_IteMon = Instance.new("ScrollingFrame")
				local UIListLayout_3 = Instance.new("UIListLayout")
				local UIPadding_3 = Instance.new("UIPadding")

				local MainDropDown_3 = Instance.new("Frame")
				MainDropDown_3.Name = "MainDropDown"
				MainDropDown_3.Parent = SectionContainer
				MainDropDown_3.BackgroundColor3 = Color3.fromRGB(1, 2, 3)
				MainDropDown_3.Position = UDim2.new(0,0,2,0)
				MainDropDown_3.BackgroundTransparency = 1
				MainDropDown_3.BorderSizePixel = 0
				MainDropDown_3.ClipsDescendants = true
				MainDropDown_3.Size = UDim2.new(0, 265, 0, 15)
				MainDropDown_3.ZIndex = 16

				local Text_3 = Instance.new("TextLabel")

				Text_3.Name = "Text_3"
				Text_3.Parent = MainDropDown_3
				Text_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Text_3.BackgroundTransparency = 1.000
				Text_3.Size = UDim2.new(0, 62, 0, 12)
				Text_3.ZIndex = 16
				Text_3.Font = Enum.Font.GothamBold
				Text_3.Text = text
				Text_3.TextColor3 = Color3.fromRGB(255, 255, 255)
				Text_3.TextSize = 12.000
				Text_3.TextXAlignment = Enum.TextXAlignment.Left

				MainDropDown_2.Name = "MainDropDown"
				MainDropDown_2.Parent = MainDropDown
				MainDropDown_2.BackgroundColor3 = Color3.fromRGB(1, 2, 3)
				MainDropDown_2.BackgroundTransparency = 0.700
				MainDropDown_2.BorderSizePixel = 0
				MainDropDown_2.ClipsDescendants = true
				MainDropDown_2.Size = UDim2.new(1, 0, 0, 35)
				MainDropDown_2.ZIndex = 16

				UICorner_8.CornerRadius = UDim.new(0, 4)
				UICorner_8.Parent = MainDropDown_2

				MainDropDown.Name = "MainDropDown"
				MainDropDown.Parent = SectionContainer
				MainDropDown.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
				MainDropDown.BackgroundTransparency = 0.700
				MainDropDown.BorderSizePixel = 0
				MainDropDown.ClipsDescendants = true
				MainDropDown.Size = UDim2.new(0, 265, 0, 35)
				MainDropDown.ZIndex = 16

				UICorner_7.CornerRadius = UDim.new(0, 4)
				UICorner_7.Parent = MainDropDown


				v.Name = "v"
				v.Parent = MainDropDown_2
				v.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				v.BackgroundTransparency = 1.000
				v.BorderSizePixel = 0
				v.Size = UDim2.new(1, 0, 1, 0)
				v.ZIndex = 16
				v.AutoButtonColor = false
				v.Font = Enum.Font.GothamBold
				v.Text = ""
				v.TextColor3 = Color3.fromRGB(255, 255, 255)
				v.TextSize = 12.000
				function getpro()
					if default then
						if table.find(list, default) then
							callback(default)
							return default
						else
							return ""
						end
					else
						return ""
					end
				end
				Text_2.Name = "Text"
				Text_2.Parent = MainDropDown_2
				Text_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Text_2.BackgroundTransparency = 1.000
				Text_2.Size = UDim2.new(0, 265, 0, 35)
				Text_2.ZIndex = 16
				Text_2.Font = Enum.Font.GothamBold
				Text_2.Text = getpro()
				Text_2.TextColor3 = Color3.fromRGB(255, 255, 255)
				Text_2.TextSize = 13.000
				Text_2.TextXAlignment = Enum.TextXAlignment.Center

				local Main_ImageButton = Instance.new("Frame")
				Main_ImageButton.Name = "Main_ImageButton"
				Main_ImageButton.AnchorPoint = Vector2.new(0, 0.5)
				Main_ImageButton.Parent = MainDropDown_2
				Main_ImageButton.BackgroundColor3  = Color3.fromRGB(40, 40, 40)
				Main_ImageButton.Size = UDim2.new(0, 20, 0, 20)
				Main_ImageButton.Position = UDim2.new(1, -25, 0.5, 1)
				Main_ImageButton.ZIndex = 16

				ImageButton.Parent = Main_ImageButton
				ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ImageButton.BackgroundTransparency = 1
				ImageButton.Position = UDim2.new(0, 3, 0, 5)
				ImageButton.Size = UDim2.new(0, 13, 0, 13)
				ImageButton.ZIndex = 16
				ImageButton.Image = "http://www.roblox.com/asset/?id=6282522798"

				local UICorner_35 = Instance.new("UICorner")
				UICorner_35.CornerRadius = UDim.new(0, 5)
				UICorner_35.Parent = Main_ImageButton

				Scroll_IteMon.Name = "Scroll_IteMon"
				Scroll_IteMon.Parent = MainDropDown
				Scroll_IteMon.Active = true
				Scroll_IteMon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Scroll_IteMon.BackgroundTransparency = 1.000
				Scroll_IteMon.BorderSizePixel = 0
				Scroll_IteMon.Position = UDim2.new(0, 0, 0, 35)
				Scroll_IteMon.Size = UDim2.new(1, 0, 1, -35)
				Scroll_IteMon.ZIndex = 16
				Scroll_IteMon.CanvasSize = UDim2.new(0, 0, 0, 265)
				Scroll_IteMon.ScrollBarThickness = 0

				UIListLayout_3.Parent = Scroll_IteMon
				UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout_3.Padding = UDim.new(0, 5)
				UIListLayout_2:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
				function()
					Scroll_IteMon.CanvasSize = UDim2.new(1, 0, 0, UIListLayout_2.AbsoluteContentSize.Y+40)
				end
				)
				UIPadding_3.Parent = Scroll_IteMon
				UIPadding_3.PaddingLeft = UDim.new(0, 10)
				UIPadding_3.PaddingTop = UDim.new(0, 5)

				function Dropfunc:TogglePanel(state)
					TweenService:Create(
						MainDropDown,
						TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Size = state and UDim2.new(0, 265, 0, 299) or UDim2.new(0, 265, 0, 35)}
					):Play()
					TweenService:Create(
						ImageButton,
						TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Rotation = state and 180 or 0}
					):Play()
				end
				local Tof = false
				ImageButton.MouseButton1Click:Connect(
					function()
						Tof = not Tof
						Dropfunc:TogglePanel(Tof)
					end
				)
				v.MouseButton1Click:Connect(
					function()
						Tof = not Tof
						Dropfunc:TogglePanel(Tof)
					end
				)
				function Dropfunc:Clear()
					for i, v in next, Scroll_IteMon:GetChildren() do
						if v:IsA("TextButton") then 
							v:Destroy()
						end
					end
				end

				function Dropfunc:Add(Text)
					local _5 = Instance.new("TextButton")
					local UICorner_9 = Instance.new("UICorner")
					_5.Name = Text
					_5.Parent = Scroll_IteMon
					_5.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
					_5.BorderSizePixel = 0
					_5.ClipsDescendants = true
					_5.Size = UDim2.new(1, -10, 0, 30)
					_5.ZIndex = 17
					_5.AutoButtonColor = false
					_5.Font = Enum.Font.GothamBold
					_5.Text = Text
					_5.TextColor3 = Color3.fromRGB(255, 255, 255)
					_5.TextSize = 12.000

					UICorner_9.CornerRadius = UDim.new(0, 4)
					UICorner_9.Parent = _5

					_5.MouseButton1Click:Connect(
						function()
							if _x == nil then
								Tof = false
								Dropfunc:TogglePanel(Tof)
								callback(Text)
								Text_2.Text = Text
								_x = nil
							end
						end
					)
				end
				for i, v in next, list do
					Dropfunc:Add(v)
				end


				return Dropfunc
			end

			function functionitem:MultiDropdown(Name, list, default, callback)
				local Dropfunc = {}

				local MainDropDown = Instance.new("Frame")
				local UICorner_7 = Instance.new("UICorner")
				local MainDropDown_2 = Instance.new("Frame")
				local UICorner_8 = Instance.new("UICorner")
				local v = Instance.new("TextButton")
				local Text_2 = Instance.new("TextLabel")
				local ImageButton = Instance.new("ImageButton")
				local Scroll_IteMon = Instance.new("ScrollingFrame")
				local UIListLayout_3 = Instance.new("UIListLayout")
				local UIPadding_3 = Instance.new("UIPadding")

				local MainDropDown_3 = Instance.new("Frame")

				MainDropDown_3.Name = "MainDropDown"
				MainDropDown_3.Parent = SectionContainer
				MainDropDown_3.BackgroundColor3 = Color3.fromRGB(1, 2, 3)
				MainDropDown_3.Position = UDim2.new(0,0,2,0)
				MainDropDown_3.BackgroundTransparency = 1
				MainDropDown_3.BorderSizePixel = 0
				MainDropDown_3.ClipsDescendants = true
				MainDropDown_3.Size = UDim2.new(0, 265, 0, 15)
				MainDropDown_3.ZIndex = 16

				local Text_3 = Instance.new("TextLabel")

				Text_3.Name = "Text_3"
				Text_3.Parent = MainDropDown_3
				Text_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Text_3.BackgroundTransparency = 1.000
				Text_3.Size = UDim2.new(0, 62, 0, 12)
				Text_3.ZIndex = 16
				Text_3.Font = Enum.Font.GothamBold
				Text_3.Text = Name
				Text_3.TextColor3 = Color3.fromRGB(255, 255, 255)
				Text_3.TextSize = 12.000
				Text_3.TextXAlignment = Enum.TextXAlignment.Left

				MainDropDown_2.Name = "MainDropDown"
				MainDropDown_2.Parent = MainDropDown
				MainDropDown_2.BackgroundColor3 = Color3.fromRGB(1, 2, 3)
				MainDropDown_2.BackgroundTransparency = 0.700
				MainDropDown_2.BorderSizePixel = 0
				MainDropDown_2.ClipsDescendants = true
				MainDropDown_2.Size = UDim2.new(1, 0, 0, 35)
				MainDropDown_2.ZIndex = 16

				UICorner_8.CornerRadius = UDim.new(0, 4)
				UICorner_8.Parent = MainDropDown_2

				MainDropDown.Name = "MainDropDown"
				MainDropDown.Parent = SectionContainer
				MainDropDown.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
				MainDropDown.BackgroundTransparency = 0.700
				MainDropDown.BorderSizePixel = 0
				MainDropDown.ClipsDescendants = true
				MainDropDown.Size = UDim2.new(0, 265, 0, 35)
				MainDropDown.ZIndex = 16

				UICorner_7.CornerRadius = UDim.new(0, 4)
				UICorner_7.Parent = MainDropDown

				v.Name = "v"
				v.Parent = MainDropDown_2
				v.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				v.BackgroundTransparency = 1.000
				v.BorderSizePixel = 0
				v.Size = UDim2.new(1, 0, 1, 0)
				v.ZIndex = 16
				v.AutoButtonColor = false
				v.Font = Enum.Font.GothamBold
				v.Text = ""
				v.TextColor3 = Color3.fromRGB(255, 255, 255)
				v.TextSize = 12.000
				function getpro()
					if default then
						for i, v in next, default do
							if table.find(list, v) then
								callback(default)
								return table.concat(default, ", ")
							else
								return ""
							end
						end
					else
						return ""
					end
				end

				Text_2.Name = "Text"
				Text_2.Parent = MainDropDown_2
				Text_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Text_2.BackgroundTransparency = 1.000
				Text_2.Size = UDim2.new(0, 265, 0, 35)
				Text_2.ZIndex = 16
				Text_2.Font = Enum.Font.GothamBold
				Text_2.Text = getpro()
				Text_2.TextColor3 = Color3.fromRGB(255, 255, 255)
				Text_2.TextSize = 13.000
				Text_2.TextXAlignment = Enum.TextXAlignment.Center

				ImageButton.Parent = MainDropDown_2
				ImageButton.AnchorPoint = Vector2.new(0, 0.5)
				ImageButton.BackgroundTransparency = 1.000
				ImageButton.Position = UDim2.new(1, -25, 0.5, 0)
				ImageButton.Size = UDim2.new(0, 12, 0, 12)
				ImageButton.ZIndex = 16
				ImageButton.Image = "http://www.roblox.com/asset/?id=6282522798"
				local DropTable = {}
				Scroll_IteMon.Name = "Scroll_IteMon"
				Scroll_IteMon.Parent = MainDropDown
				Scroll_IteMon.Active = true
				Scroll_IteMon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Scroll_IteMon.BackgroundTransparency = 1.000
				Scroll_IteMon.BorderSizePixel = 0
				Scroll_IteMon.Position = UDim2.new(0, 0, 0, 35)
				Scroll_IteMon.Size = UDim2.new(1, 0, 1, -35)
				Scroll_IteMon.ZIndex = 16
				Scroll_IteMon.CanvasSize = UDim2.new(0, 0, 0, 265)
				Scroll_IteMon.ScrollBarThickness = 0

				UIListLayout_3.Parent = Scroll_IteMon
				UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout_3.Padding = UDim.new(0, 5)
				UIListLayout_2:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
				function()
					Scroll_IteMon.CanvasSize = UDim2.new(1, 0, 0, UIListLayout_2.AbsoluteContentSize.Y+40)
				end
				)
				UIPadding_3.Parent = Scroll_IteMon
				UIPadding_3.PaddingLeft = UDim.new(0, 10)
				UIPadding_3.PaddingTop = UDim.new(0, 5)

				function Dropfunc:TogglePanel(state)
					TweenService:Create(
						MainDropDown,
						TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Size = state and UDim2.new(0, 265, 0, 200) or UDim2.new(0, 265, 0, 35)}
					):Play()
					TweenService:Create(
						ImageButton,
						TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Rotation = state and 180 or 0}
					):Play()
				end
				local Tof = false
				ImageButton.MouseButton1Click:Connect(
					function()
						Tof = not Tof
						Dropfunc:TogglePanel(Tof)
					end
				)
				v.MouseButton1Click:Connect(
					function()
						Tof = not Tof
						Dropfunc:TogglePanel(Tof)
					end
				)
				function Dropfunc:Add(Text)
					local _5 = Instance.new("TextButton")
					local UICorner_9 = Instance.new("UICorner")
					_5.Name = Text
					_5.Parent = Scroll_IteMon
					_5.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
					_5.BorderSizePixel = 0
					_5.ClipsDescendants = true
					_5.Size = UDim2.new(1, -10, 0, 30)
					_5.ZIndex = 17
					_5.AutoButtonColor = false
					_5.Font = Enum.Font.GothamBold
					_5.Text = Text
					_5.TextColor3 = Color3.fromRGB(255, 255, 255)
					_5.TextSize = 12.000

					UICorner_9.CornerRadius = UDim.new(0, 4)
					UICorner_9.Parent = _5
					_5.MouseButton1Click:Connect(
						function()
							if not table.find(DropTable, Text) then
								table.insert(DropTable, Text)
								callback(DropTable, Text)
								Text_2.Text = table.concat(DropTable, ", ")
								TweenService:Create(
									_5,
									TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
									{TextColor3 = Color3.fromRGB(0, 0, 255)}
								):Play()
							else
								TweenService:Create(
									_5,
									TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
									{TextColor3 = Color3.fromRGB(255, 255, 255)}
								):Play()
								for i2, v2 in pairs(DropTable) do
									if v2 == Text then
										table.remove(DropTable, i2)
										Text_2.Text = table.concat(DropTable, ", ")
									end
								end
								callback(DropTable, Text)
							end
						end
					)
				end
				function Dropfunc:Clear()
					for i, v in next, Scroll_IteMon:GetChildren() do
						if v:IsA("TextButton")  then 
							v:Destroy()

						end
					end 
				end

				for i, v in next, list do
					Dropfunc:Add(v)
				end
				return Dropfunc
			end

			function functionitem:Slider(text,floor,min,max,de,callback)
				local SliderFrame = Instance.new("Frame")
				local LabelNameSlider = Instance.new("TextLabel")
				local ShowValueFrame = Instance.new("Frame")
				local CustomValue = Instance.new("TextBox")
				local ShowValueFrameUICorner = Instance.new("UICorner")
				local ValueFrame = Instance.new("Frame")
				local ValueFrameUICorner = Instance.new("UICorner")
				local PartValue = Instance.new("Frame")
				local PartValueUICorner = Instance.new("UICorner")
				local MainValue = Instance.new("Frame")
				local MainValueUICorner = Instance.new("UICorner")
				local sliderfunc = {}

				SliderFrame.Name = "SliderFrame"
				SliderFrame.Parent = SectionContainer
				SliderFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
				SliderFrame.Position = UDim2.new(0.109489053, 0, 0.708609283, 0)
				SliderFrame.Size = UDim2.new(0, 265, 0, 45)

				local UICorner_7 = Instance.new("UICorner")
				UICorner_7.CornerRadius = UDim.new(0, 4)
				UICorner_7.Parent = SliderFrame

				LabelNameSlider.Name = "LabelNameSlider"
				LabelNameSlider.Parent = SliderFrame
				LabelNameSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				LabelNameSlider.BackgroundTransparency = 1.000
				LabelNameSlider.Position = UDim2.new(0.0729926974, 0, 0.0396823473, 0)
				LabelNameSlider.Size = UDim2.new(0, 182, 0, 25)
				LabelNameSlider.Font = Enum.Font.GothamBold
				LabelNameSlider.Text = tostring(text)
				LabelNameSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
				LabelNameSlider.TextSize = 11.000
				LabelNameSlider.TextXAlignment = Enum.TextXAlignment.Left

				ShowValueFrame.Name = "ShowValueFrame"
				ShowValueFrame.Parent = SliderFrame
				ShowValueFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				ShowValueFrame.Position = UDim2.new(0.733576655, 0, 0.0656082779, 0)
				ShowValueFrame.Size = UDim2.new(0, 58, 0, 21)

				CustomValue.Name = "CustomValue"
				CustomValue.Parent = ShowValueFrame
				CustomValue.AnchorPoint = Vector2.new(0.5, 0.5)
				CustomValue.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				CustomValue.Position = UDim2.new(0.5, 0, 0.5, 0)
				CustomValue.Size = UDim2.new(0, 55, 0, 21)
				CustomValue.Font = Enum.Font.GothamBold
				CustomValue.Text = "50"
				CustomValue.TextColor3 = Color3.fromRGB(255, 255, 255)
				CustomValue.TextSize = 11.000

				ShowValueFrameUICorner.CornerRadius = UDim.new(0, 4)
				ShowValueFrameUICorner.Name = "ShowValueFrameUICorner"
				ShowValueFrameUICorner.Parent = ShowValueFrame

				ValueFrame.Name = "ValueFrame"
				ValueFrame.Parent = SliderFrame
				ValueFrame.AnchorPoint = Vector2.new(0.5, 0.5)
				ValueFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				ValueFrame.Position = UDim2.new(0.5, 0, 0.8, 0)
				ValueFrame.Size = UDim2.new(0, 200, 0, 5)

				ValueFrameUICorner.CornerRadius = UDim.new(0, 30)
				ValueFrameUICorner.Name = "ValueFrameUICorner"
				ValueFrameUICorner.Parent = ValueFrame

				PartValue.Name = "PartValue"
				PartValue.Parent = ValueFrame
				PartValue.AnchorPoint = Vector2.new(0.5, 0.5)
				PartValue.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				PartValue.BackgroundTransparency = 1.000
				PartValue.Position = UDim2.new(0.5, 0, 0.8, 0)
				PartValue.Size = UDim2.new(0, 200, 0, 5)

				PartValueUICorner.CornerRadius = UDim.new(0, 30)
				PartValueUICorner.Name = "PartValueUICorner"
				PartValueUICorner.Parent = PartValue

				MainValue.Name = "MainValue"
				MainValue.Parent = ValueFrame
				MainValue.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
				MainValue.Size = UDim2.new((de or 0) / max, 0, 0, 5)
				MainValue.BorderSizePixel = 0

				MainValueUICorner.CornerRadius = UDim.new(0, 30)
				MainValueUICorner.Name = "MainValueUICorner"
				MainValueUICorner.Parent = MainValue


				local ConneValue = Instance.new("Frame")
				ConneValue.Name = "ConneValue"
				ConneValue.Parent = PartValue
				ConneValue.AnchorPoint = Vector2.new(0.7, 0.7)
				ConneValue.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
				ConneValue.Position = UDim2.new((de or 0)/max, 0.5, 0.5,0, 0)
				ConneValue.Size = UDim2.new(0, 10, 0, 10)
				ConneValue.BorderSizePixel = 0
	
				local UICorner = Instance.new("UICorner")
				UICorner.CornerRadius = UDim.new(0, 10)
				UICorner.Parent = ConneValue


				if floor == true then
					CustomValue.Text =  tostring(de and string.format((de / max) * (max - min) + min) or 0)
				else
					CustomValue.Text =  tostring(de and math.floor((de / max) * (max - min) + min) or 0)
				end

				local function move(input)
					local pos =
						UDim2.new(
							math.clamp((input.Position.X - ValueFrame.AbsolutePosition.X) / ValueFrame.AbsoluteSize.X, 0, 1),
							0,
							0.5,
							0
						)
					local pos1 =
						UDim2.new(
							math.clamp((input.Position.X - ValueFrame.AbsolutePosition.X) / ValueFrame.AbsoluteSize.X, 0, 1),
							0,
							0,
							5
						)
					MainValue:TweenSize(pos1, "Out", "Sine", 0.2, true)
					ConneValue:TweenPosition(pos, "Out", "Sine", 0.2, true)
					if floor == true then
						local value = string.format("%.0f",((pos.X.Scale * max) / max) * (max - min) + min)
						CustomValue.Text = tostring(value)
						callback(value)
					else
						local value = math.floor(((pos.X.Scale * max) / max) * (max - min) + min)
						CustomValue.Text = tostring(value)
						callback(value)
					end
				end
				local dragging = false
				ConneValue.InputBegan:Connect(
					function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							dragging = true
						end
					end)
				ConneValue.InputEnded:Connect(
					function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							dragging = false
						end
					end)
				SliderFrame.InputBegan:Connect(
					function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							dragging = true
						end
					end)
				SliderFrame.InputEnded:Connect(
					function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							dragging = false
						end
					end)
				ValueFrame.InputBegan:Connect(
					function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							dragging = true
						end
					end)
				ValueFrame.InputEnded:Connect(
					function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							dragging = false
						end
					end)
					game:GetService("UserInputService").InputChanged:Connect(function(input)
						if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
							move(input)
						end
					end)
					CustomValue.FocusLost:Connect(function()
						if CustomValue.Text == "" then
							CustomValue.Text  = de
						end
						if  tonumber(CustomValue.Text) > max then
							CustomValue.Text  = max
						end
						MainValue:TweenSize(UDim2.new((CustomValue.Text or 0) / max, 0, 0, 5), "Out", "Sine", 0.2, true)
						ConneValue:TweenPosition(UDim2.new((CustomValue.Text or 0)/max, 0,0.6, 0) , "Out", "Sine", 0.2, true)
						if floor == true then
							CustomValue.Text = tostring(CustomValue.Text and string.format("%.0f",(CustomValue.Text / max) * (max - min) + min) )
						else
							CustomValue.Text = tostring(CustomValue.Text and math.floor( (CustomValue.Text / max) * (max - min) + min) )
						end
						pcall(callback, CustomValue.Text)
					end)
					
					function sliderfunc:Update(value)
						MainValue:TweenSize(UDim2.new((value or 0) / max, 0, 0, 5), "Out", "Sine", 0.2, true)
						ConneValue:TweenPosition(UDim2.new((value or 0)/max, 0.5, 0.5,0, 0) , "Out", "Sine", 0.2, true)
						CustomValue.Text = value
						pcall(function()
							callback(value)
						end)
					end
				return sliderfunc
			end
			return functionitem
		end
		return sections
	end
	return tabs
end

local ScreenGui = Instance.new("ScreenGui")
local ImageButton = Instance.new("ImageButton")
local UICorner = Instance.new("UICorner")
		
ScreenGui.Name = "ImageButton"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

ImageButton.Parent = ScreenGui
ImageButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ImageButton.BorderSizePixel = 0
ImageButton.Position = UDim2.new(0.120833337, 0, 0.0952890813, 0)
ImageButton.Size = UDim2.new(0, 50, 0, 50)
ImageButton.Draggable = true
ImageButton.Image = "http://www.roblox.com/asset/?id="..(_G.Logo)
ImageButton.MouseButton1Down:connect(function()
	game:GetService("VirtualInputManager"):SendKeyEvent(true,305,false,game)
	game:GetService("VirtualInputManager"):SendKeyEvent(false,305,false,game)
end)
UICorner.Parent = ImageButton
    
function TP(P1)
    Distance = (P1.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if Distance < 250 then
        Speed = 500
    elseif Distance < 500 then
        Speed = 400
    elseif Distance < 1000 then
        Speed = 350
    elseif Distance >= 1000 then
        Speed = 300
    end
    game:GetService("TweenService"):Create(
        game.Players.LocalPlayer.Character.HumanoidRootPart,
        TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
        {CFrame = P1}
    ):Play()
end
    
    function InfAb()
        if InfAbility then
            if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility") then
                local inf = Instance.new("ParticleEmitter")
                inf.Acceleration = Vector3.new(0,0,0)
                inf.Archivable = true
                inf.Drag = 20
                inf.EmissionDirection = Enum.NormalId.Top
                inf.Enabled = true
                inf.Lifetime = NumberRange.new(0,0)
                inf.LightInfluence = 0
                inf.LockedToPart = true
                inf.Name = "Agility"
                inf.Rate = 500
                local numberKeypoints2 = {
                    NumberSequenceKeypoint.new(0, 0);
                    NumberSequenceKeypoint.new(1, 4); 
                }
                inf.Size = NumberSequence.new(numberKeypoints2)
                inf.RotSpeed = NumberRange.new(9999, 99999)
                inf.Rotation = NumberRange.new(0, 0)
                inf.Speed = NumberRange.new(30, 30)
                inf.SpreadAngle = Vector2.new(0,0,0,0)
                inf.Texture = ""
                inf.VelocityInheritance = 0
                inf.ZOffset = 2
                inf.Transparency = NumberSequence.new(0)
                inf.Color = ColorSequence.new(Color3.fromRGB(0,0,0),Color3.fromRGB(0,0,0))
                inf.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
            end
        else
            if game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility") then
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility"):Destroy()
            end
        end
    end
    
    local LocalPlayer = game:GetService'Players'.LocalPlayer
    local originalstam = LocalPlayer.Character.Energy.Value
    function infinitestam()
        LocalPlayer.Character.Energy.Changed:connect(function()
            if InfiniteEnergy then
                LocalPlayer.Character.Energy.Value = originalstam
            end 
        end)
    end
    
    spawn(function()
        pcall(function()
            while wait(.1) do
                if InfiniteEnergy then
                    wait(0.1)
                    originalstam = LocalPlayer.Character.Energy.Value
                    infinitestam()
                end
            end
        end)
    end)
    
    function NoDodgeCool()
        if nododgecool then
            for i,v in next, getgc() do
                if game:GetService("Players").LocalPlayer.Character.Dodge then
                    if typeof(v) == "function" and getfenv(v).script == game:GetService("Players").LocalPlayer.Character.Dodge then
                        for i2,v2 in next, getupvalues(v) do
                            if tostring(v2) == "0.1" then
                            repeat wait(.1)
                                setupvalue(v,i2,0)
                            until not nododgecool
                            end
                        end
                    end
                end
            end
        end
    end
    function CheckQuest()
        local Lv = game:GetService("Players").LocalPlayer.Data.Level.Value
        if World1 then
            if Lv == 1 or Lv <= 9 or SelectMonster == "Bandit" or SelectArea == 'Jungle' then -- Bandit
                Mon = "Bandit"
                NameQuest = "BanditQuest1"
                LevelQuest = 1
                NameMon = "Bandit"
                CFrameQuest = CFrame.new(1060.9383544922, 16.455066680908, 1547.7841796875)
                CFrameMon = CFrame.new(1038.5533447266, 41.296249389648, 1576.5098876953)
            elseif Lv == 10 or Lv <= 14 or SelectMonster == "Monkey" or SelectArea == 'Jungle' then -- Monkey
                Mon = "Monkey"
                NameQuest = "JungleQuest"
                LevelQuest = 1
                NameMon = "Monkey"
                CFrameQuest = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
                CFrameMon = CFrame.new(-1448.1446533203, 50.851993560791, 63.60718536377)
            elseif Lv == 15 or Lv <= 29 or SelectMonster == "Gorilla" or SelectArea == 'Jungle' then -- Gorilla
                Mon = "Gorilla"
                NameQuest = "JungleQuest"
                LevelQuest = 2
                NameMon = "Gorilla"
                CFrameQuest = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
                CFrameMon = CFrame.new(-1142.6488037109, 40.462348937988, -515.39227294922)
            elseif Lv == 30 or Lv <= 39 or SelectMonster == "Pirate" or SelectArea == 'Buggy' then -- Pirate
                Mon = "Pirate"
                NameQuest = "BuggyQuest1"
                LevelQuest = 1
                NameMon = "Pirate"
                CFrameQuest = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)
                CFrameMon = CFrame.new(-1103.513427734375, 13.752052307128906, 3896.091064453125)
            elseif Lv == 40 or Lv <= 59 or SelectMonster == "Brute" or SelectArea == 'Buggy' then -- Brute
                Mon = "Brute"
                NameQuest = "BuggyQuest1"
                LevelQuest = 2
                NameMon = "Brute"
                CFrameQuest = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)
                CFrameMon = CFrame.new(-1387.5324707031, 24.592035293579, 4100.9575195313)
            elseif Lv == 60 or Lv <= 74 or SelectMonster == "Desert Bandit" or SelectArea == 'Desert' then -- Desert Bandit
                Mon = "Desert Bandit"
                NameQuest = "DesertQuest"
                LevelQuest = 1
                NameMon = "Desert Bandit"
                CFrameQuest = CFrame.new(896.51721191406, 6.4384617805481, 4390.1494140625)
                CFrameMon = CFrame.new(984.99896240234, 16.109552383423, 4417.91015625)
            elseif Lv == 75 or Lv <= 89 or SelectMonster == "Desert Officer" or SelectArea == 'Desert' then -- Desert Officer
                Mon = "Desert Officer"
                NameQuest = "DesertQuest"
                LevelQuest = 2
                NameMon = "Desert Officer"
                CFrameQuest = CFrame.new(896.51721191406, 6.4384617805481, 4390.1494140625)
                CFrameMon = CFrame.new(1547.1510009766, 14.452038764954, 4381.8002929688)
            elseif Lv == 90 or Lv <= 99 or SelectMonster == "Snow Bandit" or SelectArea == 'Snow' then -- Snow Bandit
                Mon = "Snow Bandit"
                NameQuest = "SnowQuest"
                LevelQuest = 1
                NameMon = "Snow Bandit"
                CFrameQuest = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
                CFrameMon = CFrame.new(1356.3028564453, 105.76865386963, -1328.2418212891)
            elseif Lv == 100 or Lv <= 119 or SelectMonster == "Snowman" or SelectArea == 'Snow' then -- Snowman
                Mon = "Snowman"
                NameQuest = "SnowQuest"
                LevelQuest = 2
                NameMon = "Snowman"
                CFrameQuest = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
                CFrameMon = CFrame.new(1218.7956542969, 138.01184082031, -1488.0262451172)
            elseif Lv == 120 or Lv <= 149 or SelectMonster == "Chief Petty Officer" or SelectArea == 'Marine' then -- Chief Petty Officer
                Mon = "Chief Petty Officer"
                NameQuest = "MarineQuest2"
                LevelQuest = 1
                NameMon = "Chief Petty Officer"
                CFrameQuest = CFrame.new(-5035.49609375, 28.677835464478, 4324.1840820313)
                CFrameMon = CFrame.new(-4931.1552734375, 65.793113708496, 4121.8393554688)
            elseif Lv == 150 or Lv <= 174 or SelectMonster == "Sky Bandit" or SelectArea == 'Sky' then -- Sky Bandit
                Mon = "Sky Bandit"
                NameQuest = "SkyQuest"
                LevelQuest = 1
                NameMon = "Sky Bandit"
                CFrameQuest = CFrame.new(-4842.1372070313, 717.69543457031, -2623.0483398438)
                CFrameMon = CFrame.new(-4955.6411132813, 365.46365356445, -2908.1865234375)
            elseif Lv == 175 or Lv <= 189 or SelectMonster == "Dark Master" or SelectArea == 'Sky' then -- Dark Master
                Mon = "Dark Master"
                NameQuest = "SkyQuest"
                LevelQuest = 2
                NameMon = "Dark Master"
                CFrameQuest = CFrame.new(-4842.1372070313, 717.69543457031, -2623.0483398438)
                CFrameMon = CFrame.new(-5148.1650390625, 439.04571533203, -2332.9611816406)
            elseif Lv == 190 or Lv <= 209 or SelectMonster == "Prisoner" or SelectArea == 'Prison' then -- Prisoner
                Mon = "Prisoner"
                NameQuest = "PrisonerQuest"
                LevelQuest = 1
                NameMon = "Prisoner"
                CFrameQuest = CFrame.new(5310.60547, 0.350014925, 474.946594, 0.0175017118, 0, 0.999846935, 0, 1, 0, -0.999846935,
                    0, 0.0175017118)
                CFrameMon = CFrame.new(4937.31885, 0.332031399, 649.574524, 0.694649816, 0, -0.719348073, 0, 1, 0,
                    0.719348073, 0, 0.694649816)
            elseif Lv == 210 or Lv <= 249 or SelectMonster == "Dangerous Prisoner" or SelectArea == 'Prison' then -- Dangerous Prisoner
                Mon = "Dangerous Prisoner"
                NameQuest = "PrisonerQuest"
                LevelQuest = 2
                NameMon = "Dangerous Prisoner"
                CFrameQuest = CFrame.new(5310.60547, 0.350014925, 474.946594, 0.0175017118, 0, 0.999846935, 0, 1, 0, -0.999846935,
                    0, 0.0175017118)
                CFrameMon = CFrame.new(5099.6626, 0.351562679, 1055.7583, 0.898906827, 0, -0.438139856, 0, 1, 0, 0.438139856,
                    0, 0.898906827)
            elseif Lv == 250 or Lv <= 274 or SelectMonster == "Toga Warrior" or SelectArea == 'Colosseum' then -- Toga Warrior
                Mon = "Toga Warrior"
                NameQuest = "ColosseumQuest"
                LevelQuest = 1
                NameMon = "Toga Warrior"
                CFrameQuest = CFrame.new(-1577.7890625, 7.4151420593262, -2984.4838867188)
                CFrameMon = CFrame.new(-1872.5166015625, 49.080215454102, -2913.810546875)
            elseif Lv == 275 or Lv <= 299 or SelectMonster == "Gladiator" or SelectArea == 'Colosseum' then -- Gladiator
                Mon = "Gladiator"
                NameQuest = "ColosseumQuest"
                LevelQuest = 2
                NameMon = "Gladiator"
                CFrameQuest = CFrame.new(-1577.7890625, 7.4151420593262, -2984.4838867188)
                CFrameMon = CFrame.new(-1521.3740234375, 81.203170776367, -3066.3139648438)
            elseif Lv == 300 or Lv <= 324 or SelectMonster == "Military Soldier" or SelectArea == 'Magma' then -- Military Soldier
                Mon = "Military Soldier"
                NameQuest = "MagmaQuest"
                LevelQuest = 1
                NameMon = "Military Soldier"
                CFrameQuest = CFrame.new(-5316.1157226563, 12.262831687927, 8517.00390625)
                CFrameMon = CFrame.new(-5369.0004882813, 61.24352645874, 8556.4921875)
            elseif Lv == 325 or Lv <= 374 or SelectMonster == "Military Spy" or SelectArea == 'Magma' then -- Military Spy
                Mon = "Military Spy"
                NameQuest = "MagmaQuest"
                LevelQuest = 2
                NameMon = "Military Spy"
                CFrameQuest = CFrame.new(-5316.1157226563, 12.262831687927, 8517.00390625)
                CFrameMon = CFrame.new(-5787.00293, 75.8262634, 8651.69922, 0.838590562, 0, -0.544762194, 0, 1, 0,
                    0.544762194, 0, 0.838590562)
            elseif Lv == 375 or Lv <= 399 or SelectMonster == "Fishman Warrior" or SelectArea == 'Fishman' then -- Fishman Warrior
                Mon = "Fishman Warrior"
                NameQuest = "FishmanQuest"
                LevelQuest = 1
                NameMon = "Fishman Warrior"
                CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
                CFrameMon = CFrame.new(60844.10546875, 98.462875366211, 1298.3985595703)
                if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
                        Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
                end
            elseif Lv == 400 or Lv <= 449 or SelectMonster == "Fishman Commando" or SelectArea == 'Fishman' then -- Fishman Commando
                Mon = "Fishman Commando"
                NameQuest = "FishmanQuest"
                LevelQuest = 2
                NameMon = "Fishman Commando"
                CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
                CFrameMon = CFrame.new(61738.3984375, 64.207321166992, 1433.8375244141)
                if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
                        Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
                end
            elseif Lv == 450 or Lv <= 474 or SelectMonster == "God's Guard" or SelectArea == 'Sky Island' then -- God's Guard
                Mon = "God's Guard"
                NameQuest = "SkyExp1Quest"
                LevelQuest = 1
                NameMon = "God's Guard"
                CFrameQuest = CFrame.new(-4721.8603515625, 845.30297851563, -1953.8489990234)
                CFrameMon = CFrame.new(-4628.0498046875, 866.92877197266, -1931.2352294922)
                if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
                        Vector3.new(-4607.82275, 872.54248, -1667.55688))
                end
            elseif Lv == 475 or Lv <= 524 or SelectMonster == "Shanda" or SelectArea == 'Sky Island' then -- Shanda
                Mon = "Shanda"
                NameQuest = "SkyExp1Quest"
                LevelQuest = 2
                NameMon = "Shanda"
                CFrameQuest = CFrame.new(-7863.1596679688, 5545.5190429688, -378.42266845703)
                CFrameMon = CFrame.new(-7685.1474609375, 5601.0751953125, -441.38876342773)
                if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
                        Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
                end
            elseif Lv == 525 or Lv <= 549 or SelectMonster == "Royal Squad" or SelectArea == 'Sky Island' then -- Royal Squad
                Mon = "Royal Squad"
                NameQuest = "SkyExp2Quest"
                LevelQuest = 1
                NameMon = "Royal Squad"
                CFrameQuest = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125)
                CFrameMon = CFrame.new(-7654.2514648438, 5637.1079101563, -1407.7550048828)
            elseif Lv == 550 or Lv <= 624 or SelectMonster == "Royal Soldier" or SelectArea == 'Sky Island' then -- Royal Soldier
                Mon = "Royal Soldier"
                NameQuest = "SkyExp2Quest"
                LevelQuest = 2
                NameMon = "Royal Soldier"
                CFrameQuest = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125)
                CFrameMon = CFrame.new(-7760.4106445313, 5679.9077148438, -1884.8112792969)
            elseif Lv == 625 or Lv <= 649 or SelectMonster == "Galley Pirate" or SelectArea == 'Fountain' then -- Galley Pirate
                Mon = "Galley Pirate"
                NameQuest = "FountainQuest"
                LevelQuest = 1
                NameMon = "Galley Pirate"
                CFrameQuest = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
                CFrameMon = CFrame.new(5557.1684570313, 152.32717895508, 3998.7758789063)
            elseif Lv >= 650 or SelectMonster == "Galley Captain" or SelectArea == 'Fountain' then -- Galley Captain
                Mon = "Galley Captain"
                NameQuest = "FountainQuest"
                LevelQuest = 2
                NameMon = "Galley Captain"
                CFrameQuest = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
                CFrameMon = CFrame.new(5677.6772460938, 92.786109924316, 4966.6323242188)
            end
        end
        if World2 then
            if Lv == 700 or Lv <= 724 or SelectMonster == "Raider" or SelectArea == 'Area 1' then -- Raider
                Mon = "Raider"
                NameQuest = "Area1Quest"
                LevelQuest = 1
                NameMon = "Raider"
                CFrameQuest = CFrame.new(-427.72567749023, 72.99634552002, 1835.9426269531)
                CFrameMon = CFrame.new(68.874565124512, 93.635643005371, 2429.6752929688)
            elseif Lv == 725 or Lv <= 774 or SelectMonster == "Mercenary" or SelectArea == 'Area 1' then -- Mercenary
                Mon = "Mercenary"
                NameQuest = "Area1Quest"
                LevelQuest = 2
                NameMon = "Mercenary"
                CFrameQuest = CFrame.new(-427.72567749023, 72.99634552002, 1835.9426269531)
                CFrameMon = CFrame.new(-864.85009765625, 122.47104644775, 1453.1505126953)
            elseif Lv == 775 or Lv <= 799 or SelectMonster == "Swan Pirate" or SelectArea == 'Area 2' then -- Swan Pirate
                Mon = "Swan Pirate"
                NameQuest = "Area2Quest"
                LevelQuest = 1
                NameMon = "Swan Pirate"
                CFrameQuest = CFrame.new(635.61151123047, 73.096351623535, 917.81298828125)
                CFrameMon = CFrame.new(1065.3669433594, 137.64012145996, 1324.3798828125)
            elseif Lv == 800 or Lv <= 874 or SelectMonster == "Factory Staff" or SelectArea == 'Area 2' then -- Factory Staff
                Mon = "Factory Staff"
                NameQuest = "Area2Quest"
                LevelQuest = 2
                NameMon = "Factory Staff"
                CFrameQuest = CFrame.new(635.61151123047, 73.096351623535, 917.81298828125)
                CFrameMon = CFrame.new(533.22045898438, 128.46876525879, 355.62615966797)
            elseif Lv == 875 or Lv <= 899 or SelectMonster == "Marine Lieutenant" or SelectArea == 'Marine' then -- Marine Lieutenant
                Mon = "Marine Lieutenant"
                NameQuest = "MarineQuest3"
                LevelQuest = 1
                NameMon = "Marine Lieutenant"
                CFrameQuest = CFrame.new(-2440.9934082031, 73.04190826416, -3217.7082519531)
                CFrameMon = CFrame.new(-2489.2622070313, 84.613594055176, -3151.8830566406)
            elseif Lv == 900 or Lv <= 949 or SelectMonster == "Marine Captain" or SelectArea == 'Marine' then -- Marine Captain
                Mon = "Marine Captain"
                NameQuest = "MarineQuest3"
                LevelQuest = 2
                NameMon = "Marine Captain"
                CFrameQuest = CFrame.new(-2440.9934082031, 73.04190826416, -3217.7082519531)
                CFrameMon = CFrame.new(-2335.2026367188, 79.786659240723, -3245.8674316406)
            elseif Lv == 950 or Lv <= 974 or SelectMonster == "Zombie" or SelectArea == 'Zombie' then -- Zombie
                Mon = "Zombie"
                NameQuest = "ZombieQuest"
                LevelQuest = 1
                NameMon = "Zombie"
                CFrameQuest = CFrame.new(-5494.3413085938, 48.505931854248, -794.59094238281)
                CFrameMon = CFrame.new(-5536.4970703125, 101.08577728271, -835.59075927734)
            elseif Lv == 975 or Lv <= 999 or SelectMonster == "Vampire" or SelectArea == 'Zombie' then -- Vampire
                Mon = "Vampire"
                NameQuest = "ZombieQuest"
                LevelQuest = 2
                NameMon = "Vampire"
                CFrameQuest = CFrame.new(-5494.3413085938, 48.505931854248, -794.59094238281)
                CFrameMon = CFrame.new(-5806.1098632813, 16.722528457642, -1164.4384765625)
            elseif Lv == 1000 or Lv <= 1049 or SelectMonster == "Snow Trooper" or SelectArea == 'Snow Mountain' then -- Snow Trooper
                Mon = "Snow Trooper"
                NameQuest = "SnowMountainQuest"
                LevelQuest = 1
                NameMon = "Snow Trooper"
                CFrameQuest = CFrame.new(607.05963134766, 401.44781494141, -5370.5546875)
                CFrameMon = CFrame.new(535.21051025391, 432.74209594727, -5484.9165039063)
            elseif Lv == 1050 or Lv <= 1099 or SelectMonster == "Winter Warrior" or SelectArea == 'Snow Mountain' then -- Winter Warrior
                Mon = "Winter Warrior"
                NameQuest = "SnowMountainQuest"
                LevelQuest = 2
                NameMon = "Winter Warrior"
                CFrameQuest = CFrame.new(607.05963134766, 401.44781494141, -5370.5546875)
                CFrameMon = CFrame.new(1234.4449462891, 456.95419311523, -5174.130859375)
            elseif Lv == 1100 or Lv <= 1124 or SelectMonster == "Lab Subordinate" or SelectArea == 'Ice Fire' then -- Lab Subordinate
                Mon = "Lab Subordinate"
                NameQuest = "IceSideQuest"
                LevelQuest = 1
                NameMon = "Lab Subordinate"
                CFrameQuest = CFrame.new(-6061.841796875, 15.926671981812, -4902.0385742188)
                CFrameMon = CFrame.new(-5720.5576171875, 63.309471130371, -4784.6103515625)
            elseif Lv == 1125 or Lv <= 1174 or SelectMonster == "Horned Warrior" or SelectArea == 'Ice Fire' then -- Horned Warrior
                Mon = "Horned Warrior"
                NameQuest = "IceSideQuest"
                LevelQuest = 2
                NameMon = "Horned Warrior"
                CFrameQuest = CFrame.new(-6061.841796875, 15.926671981812, -4902.0385742188)
                CFrameMon = CFrame.new(-6292.751953125, 91.181983947754, -5502.6499023438)
            elseif Lv == 1175 or Lv <= 1199 or SelectMonster == "Magma Ninja" or SelectArea == 'Ice Fire' then -- Magma Ninja
                Mon = "Magma Ninja"
                NameQuest = "FireSideQuest"
                LevelQuest = 1
                NameMon = "Magma Ninja"
                CFrameQuest = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813)
                CFrameMon = CFrame.new(-5461.8388671875, 130.36347961426, -5836.4702148438)
            elseif Lv == 1200 or Lv <= 1249 or SelectMonster == "Lava Pirate" or SelectArea == 'Ice Fire' then -- Lava Pirate
                Mon = "Lava Pirate"
                NameQuest = "FireSideQuest"
                LevelQuest = 2
                NameMon = "Lava Pirate"
                CFrameQuest = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813)
                CFrameMon = CFrame.new(-5251.1889648438, 55.164535522461, -4774.4096679688)
            elseif Lv == 1250 or Lv <= 1274 or SelectMonster == "Ship Deckhand" or SelectArea == 'Ship' then -- Ship Deckhand
                Mon = "Ship Deckhand"
                NameQuest = "ShipQuest1"
                LevelQuest = 1
                NameMon = "Ship Deckhand"
                CFrameQuest = CFrame.new(1040.2927246094, 125.08293151855, 32911.0390625)
                CFrameMon = CFrame.new(921.12365722656, 125.9839553833, 33088.328125)
                if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
                        Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                end
            elseif Lv == 1275 or Lv <= 1299 or SelectMonster == "Ship Engineer" or SelectArea == 'Ship' then -- Ship Engineer
                Mon = "Ship Engineer"
                NameQuest = "ShipQuest1"
                LevelQuest = 2
                NameMon = "Ship Engineer"
                CFrameQuest = CFrame.new(1040.2927246094, 125.08293151855, 32911.0390625)
                CFrameMon = CFrame.new(886.28179931641, 40.47790145874, 32800.83203125)
                if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
                        Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                end
            elseif Lv == 1300 or Lv <= 1324 or SelectMonster == "Ship Steward" or SelectArea == 'Ship' then -- Ship Steward
                Mon = "Ship Steward"
                NameQuest = "ShipQuest2"
                LevelQuest = 1
                NameMon = "Ship Steward"
                CFrameQuest = CFrame.new(971.42065429688, 125.08293151855, 33245.54296875)
                CFrameMon = CFrame.new(943.85504150391, 129.58183288574, 33444.3671875)
                if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
                        Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                end
            elseif Lv == 1325 or Lv <= 1349 or SelectMonster == "Ship Officer" or SelectArea == 'Ship' then -- Ship Officer
                Mon = "Ship Officer"
                NameQuest = "ShipQuest2"
                LevelQuest = 2
                NameMon = "Ship Officer"
                CFrameQuest = CFrame.new(971.42065429688, 125.08293151855, 33245.54296875)
                CFrameMon = CFrame.new(955.38458251953, 181.08335876465, 33331.890625)
                if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
                        Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                end
            elseif Lv == 1350 or Lv <= 1374 or SelectMonster == "Arctic Warrior" or SelectArea == 'Frost' then -- Arctic Warrior
                Mon = "Arctic Warrior"
                NameQuest = "FrostQuest"
                LevelQuest = 1
                NameMon = "Arctic Warrior"
                CFrameQuest = CFrame.new(5668.1372070313, 28.202531814575, -6484.6005859375)
                CFrameMon = CFrame.new(5935.4541015625, 77.26016998291, -6472.7568359375)
                if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",
                        Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422))
                end
            elseif Lv == 1375 or Lv <= 1424 or SelectMonster == "Snow Lurker" or SelectArea == 'Frost' then -- Snow Lurker
                Mon = "Snow Lurker"
                NameQuest = "FrostQuest"
                LevelQuest = 2
                NameMon = "Snow Lurker"
                CFrameQuest = CFrame.new(5668.1372070313, 28.202531814575, -6484.6005859375)
                CFrameMon = CFrame.new(5628.482421875, 57.574996948242, -6618.3481445313)
            elseif Lv == 1425 or Lv <= 1449 or SelectMonster == "Sea Soldier" or SelectArea == 'Forgotten' then -- Sea Soldier
                Mon = "Sea Soldier"
                NameQuest = "ForgottenQuest"
                LevelQuest = 1
                NameMon = "Sea Soldier"
                CFrameQuest = CFrame.new(-3054.5827636719, 236.87213134766, -10147.790039063)
                CFrameMon = CFrame.new(-3185.0153808594, 58.789089202881, -9663.6064453125)
            elseif Lv >= 1450 or SelectMonster == "Water Fighter" or SelectArea == 'Forgotten' then -- Water Fighter
                Mon = "Water Fighter"
                NameQuest = "ForgottenQuest"
                LevelQuest = 2
                NameMon = "Water Fighter"
                CFrameQuest = CFrame.new(-3054.5827636719, 236.87213134766, -10147.790039063)
                CFrameMon = CFrame.new(-3262.9301757813, 298.69036865234, -10552.529296875)
            end
        end
        if World3 then
            if Lv == 1500 or Lv <= 1524 or SelectMonster == "Pirate Millionaire" or SelectArea == 'Pirate Port' then -- Pirate Millionaire
                Mon = "Pirate Millionaire"
                NameQuest = "PiratePortQuest"
                LevelQuest = 1
                NameMon = "Pirate Millionaire"
                CFrameQuest = CFrame.new(-289.61752319336, 43.819011688232, 5580.0903320313)
                CFrameMon = CFrame.new(-435.68109130859, 189.69866943359, 5551.0756835938)
            elseif Lv == 1525 or Lv <= 1574 or SelectMonster == "Pistol Billionaire" or SelectArea == 'Pirate Port' then -- Pistol Billoonaire
                Mon = "Pistol Billionaire"
                NameQuest = "PiratePortQuest"
                LevelQuest = 2
                NameMon = "Pistol Billionaire"
                CFrameQuest = CFrame.new(-289.61752319336, 43.819011688232, 5580.0903320313)
                CFrameMon = CFrame.new(-236.53652954102, 217.46676635742, 6006.0883789063)
            elseif Lv == 1575 or Lv <= 1599 or SelectMonster == "Dragon Crew Warrior" or SelectArea == 'Amazon' then -- Dragon Crew Warrior
                Mon = "Dragon Crew Warrior"
                NameQuest = "AmazonQuest"
                LevelQuest = 1
                NameMon = "Dragon Crew Warrior"
                CFrameQuest = CFrame.new(5833.1147460938, 51.60498046875, -1103.0693359375)
                CFrameMon = CFrame.new(6301.9975585938, 104.77153015137, -1082.6075439453)
            elseif Lv == 1600 or Lv <= 1624 or SelectMonster == "Dragon Crew Archer" or SelectArea == 'Amazon' then -- Dragon Crew Archer
                Mon = "Dragon Crew Archer"
                NameQuest = "AmazonQuest"
                LevelQuest = 2
                NameMon = "Dragon Crew Archer"
                CFrameQuest = CFrame.new(5833.1147460938, 51.60498046875, -1103.0693359375)
                CFrameMon = CFrame.new(6831.1171875, 441.76708984375, 446.58615112305)
            elseif Lv == 1625 or Lv <= 1649 or SelectMonster == "Female Islander" or SelectArea == 'Amazon' then -- Female Islander
                Mon = "Female Islander"
                NameQuest = "AmazonQuest2"
                LevelQuest = 1
                NameMon = "Female Islander"
                CFrameQuest = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422)
                CFrameMon = CFrame.new(5792.5166015625, 848.14392089844, 1084.1818847656)
            elseif Lv == 1650 or Lv <= 1699 or SelectMonster == "Giant Islander" or SelectArea == 'Amazon' then -- Giant Islander
                Mon = "Giant Islander"
                NameQuest = "AmazonQuest2"
                LevelQuest = 2
                NameMon = "Giant Islander"
                CFrameQuest = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422)
                CFrameMon = CFrame.new(5009.5068359375, 664.11071777344, -40.960144042969)
            elseif Lv == 1700 or Lv <= 1724 or SelectMonster == "Marine Commodore" or SelectArea == 'Marine Tree' then -- Marine Commodore
                Mon = "Marine Commodore"
                NameQuest = "MarineTreeIsland"
                LevelQuest = 1
                NameMon = "Marine Commodore"
                CFrameQuest = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813)
                CFrameMon = CFrame.new(2198.0063476563, 128.71075439453, -7109.5043945313)
            elseif Lv == 1725 or Lv <= 1774 or SelectMonster == "Marine Rear Admiral" or SelectArea == 'Marine Tree' then -- Marine Rear Admiral
                Mon = "Marine Rear Admiral"
                NameQuest = "MarineTreeIsland"
                LevelQuest = 2
                NameMon = "Marine Rear Admiral"
                CFrameQuest = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813)
                CFrameMon = CFrame.new(3294.3142089844, 385.41125488281, -7048.6342773438)
            elseif Lv == 1775 or Lv <= 1799 or SelectMonster == "Fishman Raider" or SelectArea == 'Deep Forest' then -- Fishman Raide
                Mon = "Fishman Raider"
                NameQuest = "DeepForestIsland3"
                LevelQuest = 1
                NameMon = "Fishman Raider"
                CFrameQuest = CFrame.new(-10582.759765625, 331.78845214844, -8757.666015625)
                CFrameMon = CFrame.new(-10553.268554688, 521.38439941406, -8176.9458007813)
            elseif Lv == 1800 or Lv <= 1824 or SelectMonster == "Fishman Captain" or SelectArea == 'Deep Forest' then -- Fishman Captain
                Mon = "Fishman Captain"
                NameQuest = "DeepForestIsland3"
                LevelQuest = 2
                NameMon = "Fishman Captain"
                CFrameQuest = CFrame.new(-10583.099609375, 331.78845214844, -8759.4638671875)
                CFrameMon = CFrame.new(-10789.401367188, 427.18637084961, -9131.4423828125)
            elseif Lv == 1825 or Lv <= 1849 or SelectMonster == "Forest Pirate" or SelectArea == 'Deep Forest' then -- Forest Pirate
                Mon = "Forest Pirate"
                NameQuest = "DeepForestIsland"
                LevelQuest = 1
                NameMon = "Forest Pirate"
                CFrameQuest = CFrame.new(-13232.662109375, 332.40396118164, -7626.4819335938)
                CFrameMon = CFrame.new(-13489.397460938, 400.30349731445, -7770.251953125)
            elseif Lv == 1850 or Lv <= 1899 or SelectMonster == "Mythological Pirate" or SelectArea == 'Deep Forest' then -- Mythological Pirate
                Mon = "Mythological Pirate"
                NameQuest = "DeepForestIsland"
                LevelQuest = 2
                NameMon = "Mythological Pirate"
                CFrameQuest = CFrame.new(-13232.662109375, 332.40396118164, -7626.4819335938)
                CFrameMon = CFrame.new(-13508.616210938, 582.46228027344, -6985.3037109375)
            elseif Lv == 1900 or Lv <= 1924 or SelectMonster == "Jungle Pirate" or SelectArea == 'Deep Forest' then -- Jungle Pirate
                Mon = "Jungle Pirate"
                NameQuest = "DeepForestIsland2"
                LevelQuest = 1
                NameMon = "Jungle Pirate"
                CFrameQuest = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
                CFrameMon = CFrame.new(-12267.103515625, 459.75262451172, -10277.200195313)
            elseif Lv == 1925 or Lv <= 1974 or SelectMonster == "Musketeer Pirate" or SelectArea == 'Deep Forest' then -- Musketeer Pirate
                Mon = "Musketeer Pirate"
                NameQuest = "DeepForestIsland2"
                LevelQuest = 2
                NameMon = "Musketeer Pirate"
                CFrameQuest = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
                CFrameMon = CFrame.new(-13291.5078125, 520.47338867188, -9904.638671875)
            elseif Lv == 1975 or Lv <= 1999 or SelectMonster == "Reborn Skeleton" or SelectArea == 'Haunted Castle' then
                Mon = "Reborn Skeleton"
                NameQuest = "HauntedQuest1"
                LevelQuest = 1
                NameMon = "Reborn Skeleton"
                CFrameQuest = CFrame.new(-9480.80762, 142.130661, 5566.37305, -0.00655503059, 4.52954225e-08, -0.999978542,
                    2.04920472e-08, 1, 4.51620679e-08, 0.999978542, -2.01955679e-08, -0.00655503059)
                CFrameMon = CFrame.new(-8761.77148, 183.431747, 6168.33301, 0.978073597, -1.3950732e-05, -0.208259016,
                    -1.08073925e-06, 1, -7.20630269e-05, 0.208259016, 7.07080399e-05, 0.978073597)
            elseif Lv == 2000 or Lv <= 2024 or SelectMonster == "Living Zombie" or SelectArea == 'Haunted Castle' then
                Mon = "Living Zombie"
                NameQuest = "HauntedQuest1"
                LevelQuest = 2
                NameMon = "Living Zombie"
                CFrameQuest = CFrame.new(-9480.80762, 142.130661, 5566.37305, -0.00655503059, 4.52954225e-08, -0.999978542,
                    2.04920472e-08, 1, 4.51620679e-08, 0.999978542, -2.01955679e-08, -0.00655503059)
                CFrameMon = CFrame.new(-10103.7529, 238.565979, 6179.75977, 0.999474227, 2.77547141e-08, 0.0324240364,
                    -2.58006327e-08, 1, -6.06848474e-08, -0.0324240364, 5.98163865e-08, 0.999474227)
            elseif Lv == 2025 or Lv <= 2049 or SelectMonster == "Demonic Soul" or SelectArea == 'Haunted Castle' then
                Mon = "Demonic Soul"
                NameQuest = "HauntedQuest2"
                LevelQuest = 1
                NameMon = "Demonic Soul"
                CFrameQuest = CFrame.new(-9516.9931640625, 178.00651550293, 6078.4653320313)
                CFrameMon = CFrame.new(-9712.03125, 204.69589233398, 6193.322265625)
            elseif Lv == 2050 or Lv <= 2074 or SelectMonster == "Posessed Mummy" or SelectArea == 'Haunted Castle' then
                Mon = "Posessed Mummy"
                NameQuest = "HauntedQuest2"
                LevelQuest = 2
                NameMon = "Posessed Mummy"
                CFrameQuest = CFrame.new(-9516.9931640625, 178.00651550293, 6078.4653320313)
                CFrameMon = CFrame.new(-9545.7763671875, 69.619895935059, 6339.5615234375)
            elseif Lv == 2075 or Lv <= 2099 or SelectMonster == "Peanut Scout" or SelectArea == 'Nut Island' then
                Mon = "Peanut Scout"
                NameQuest = "NutsIslandQuest"
                LevelQuest = 1
                NameMon = "Peanut Scout"
                CFrameQuest = CFrame.new(-2105.53198, 37.2495995, -10195.5088, -0.766061664, 0, -0.642767608, 0, 1, 0,
                    0.642767608, 0, -0.766061664)
                CFrameMon = CFrame.new(-2150.587890625, 122.49767303467, -10358.994140625)
            elseif Lv == 2100 or Lv <= 2124 or SelectMonster == "Peanut President" or SelectArea == 'Nut Island' then
                Mon = "Peanut President"
                NameQuest = "NutsIslandQuest"
                LevelQuest = 2
                NameMon = "Peanut President"
                CFrameQuest = CFrame.new(-2105.53198, 37.2495995, -10195.5088, -0.766061664, 0, -0.642767608, 0, 1, 0,
                    0.642767608, 0, -0.766061664)
                CFrameMon = CFrame.new(-2150.587890625, 122.49767303467, -10358.994140625)
            elseif Lv == 2125 or Lv <= 2149 or SelectMonster == "Ice Cream Chef" or SelectArea == 'Ice Cream Island' then
                Mon = "Ice Cream Chef"
                NameQuest = "IceCreamIslandQuest"
                LevelQuest = 1
                NameMon = "Ice Cream Chef"
                CFrameQuest = CFrame.new(-819.376709, 64.9259796, -10967.2832, -0.766061664, 0, 0.642767608, 0, 1, 0,
                    -0.642767608, 0, -0.766061664)
                CFrameMon = CFrame.new(-789.941528, 209.382889, -11009.9805, -0.0703101531, -0, -0.997525156, -0, 1.00000012,
                    -0, 0.997525275, 0, -0.0703101456)
            elseif Lv == 2150 or Lv <= 2199 or SelectMonster == "Ice Cream Commander" or SelectArea == 'Ice Cream Island' then
                Mon = "Ice Cream Commander"
                NameQuest = "IceCreamIslandQuest"
                LevelQuest = 2
                NameMon = "Ice Cream Commander"
                CFrameQuest = CFrame.new(-819.376709, 64.9259796, -10967.2832, -0.766061664, 0, 0.642767608, 0, 1, 0,
                    -0.642767608, 0, -0.766061664)
                CFrameMon = CFrame.new(-789.941528, 209.382889, -11009.9805, -0.0703101531, -0, -0.997525156, -0, 1.00000012,
                    -0, 0.997525275, 0, -0.0703101456)
            elseif Lv == 2200 or Lv <= 2224 or SelectMonster == "Cookie Crafter" or SelectArea == 'Cake Island' then
                Mon = "Cookie Crafter"
                NameQuest = "CakeQuest1"
                LevelQuest = 1
                NameMon = "Cookie Crafter"
                CFrameQuest = CFrame.new(-2022.29858, 36.9275894, -12030.9766, -0.961273909, 0, -0.275594592, 0, 1, 0,
                    0.275594592, 0, -0.961273909)
                CFrameMon = CFrame.new(-2321.71216, 36.699482, -12216.7871, -0.780074954, 0, 0.625686109, 0, 1, 0,
                    -0.625686109, 0, -0.780074954)
            elseif Lv == 2225 or Lv <= 2249 or SelectMonster == "Cake Guard" or SelectArea == 'Cake Island' then
                Mon = "Cake Guard"
                NameQuest = "CakeQuest1"
                LevelQuest = 2
                NameMon = "Cake Guard"
                CFrameQuest = CFrame.new(-2022.29858, 36.9275894, -12030.9766, -0.961273909, 0, -0.275594592, 0, 1, 0,
                    0.275594592, 0, -0.961273909)
                CFrameMon = CFrame.new(-1418.11011, 36.6718941, -12255.7324, 0.0677844882, 0, 0.997700036, 0, 1, 0,
                    -0.997700036, 0, 0.0677844882)
            elseif Lv == 2250 or Lv <= 2274 or SelectMonster == "Baking Staff" or SelectArea == 'Cake Island' then
                Mon = "Baking Staff"
                NameQuest = "CakeQuest2"
                LevelQuest = 1
                NameMon = "Baking Staff"
                CFrameQuest = CFrame.new(-1928.31763, 37.7296638, -12840.626, 0.951068401, -0, -0.308980465, 0, 1, -0,
                    0.308980465, 0, 0.951068401)
                CFrameMon = CFrame.new(-1980.43848, 36.6716766, -12983.8418, -0.254443765, 0, -0.967087567, 0, 1, 0,
                    0.967087567, 0, -0.254443765)
            elseif Lv == 2275 or Lv <= 2299 or SelectMonster == "Head Baker" or SelectArea == 'Cake Island' then
                Mon = "Head Baker"
                NameQuest = "CakeQuest2"
                LevelQuest = 2
                NameMon = "Head Baker"
                CFrameQuest = CFrame.new(-1928.31763, 37.7296638, -12840.626, 0.951068401, -0, -0.308980465, 0, 1, -0,
                    0.308980465, 0, 0.951068401)
                CFrameMon = CFrame.new(-2251.5791, 52.2714615, -13033.3965, -0.991971016, 0, -0.126466095, 0, 1, 0,
                    0.126466095, 0, -0.991971016)
            elseif Lv == 2300 or Lv <= 2324 or SelectMonster == "Cocoa Warrior" or SelectArea == 'Choco Island' then
                Mon = "Cocoa Warrior"
                NameQuest = "ChocQuest1"
                LevelQuest = 1
                NameMon = "Cocoa Warrior"
                CFrameQuest = CFrame.new(231.75, 23.9003029, -12200.292, -1, 0, 0, 0, 1, 0, 0, 0, -1)
                CFrameMon = CFrame.new(167.978516, 26.2254658, -12238.874, -0.939700961, 0, 0.341998369, 0, 1, 0,
                    -0.341998369, 0, -0.939700961)
            elseif Lv == 2325 or Lv <= 2349 or SelectMonster == "Chocolate Bar Battler" or SelectArea == 'Choco Island' then
                Mon = "Chocolate Bar Battler"
                NameQuest = "ChocQuest1"
                LevelQuest = 2
                NameMon = "Chocolate Bar Battler"
                CFrameQuest = CFrame.new(231.75, 23.9003029, -12200.292, -1, 0, 0, 0, 1, 0, 0, 0, -1)
                CFrameMon = CFrame.new(701.312073, 25.5824986, -12708.2148, -0.342042685, 0, -0.939684391, 0, 1, 0,
                    0.939684391, 0, -0.342042685)
            elseif Lv == 2350 or Lv <= 2374 or SelectMonster == "Sweet Thief" or SelectArea == 'Choco Island' then
                Mon = "Sweet Thief"
                NameQuest = "ChocQuest2"
                LevelQuest = 1
                NameMon = "Sweet Thief"
                CFrameQuest = CFrame.new(151.198242, 23.8907146, -12774.6172, 0.422592998, 0, 0.906319618, 0, 1, 0, -0.906319618,
                    0, 0.422592998)
                CFrameMon = CFrame.new(-140.258301, 25.5824986, -12652.3115, 0.173624337, -0, -0.984811902, 0, 1, -0,
                    0.984811902, 0, 0.173624337)
            elseif Lv == 2375 or Lv <= 2400 or SelectMonster == "Candy Rebel" or SelectArea == 'Choco Island' then
                Mon = "Candy Rebel"
                NameQuest = "ChocQuest2"
                LevelQuest = 2
                NameMon = "Candy Rebel"
                CFrameQuest = CFrame.new(151.198242, 23.8907146, -12774.6172, 0.422592998, 0, 0.906319618, 0, 1, 0, -0.906319618,
                    0, 0.422592998)
                CFrameMon = CFrame.new(47.9231453, 25.5824986, -13029.2402, -0.819156051, 0, -0.573571265, 0, 1, 0,
                    0.573571265, 0, -0.819156051)
            elseif Lv == 2400 or Lv <= 2424 or SelectMonster == "Candy Pirate" or SelectArea == 'Candy Island' then
                Mon = "Candy Pirate"
                NameQuest = "CandyQuest1"
                LevelQuest = 1
                NameMon = "Candy Pirate"
                CFrameQuest = CFrame.new(-1149.328, 13.5759039, -14445.6143, -0.156446099, 0, -0.987686574, 0, 1, 0, 0.987686574,
                    0, -0.156446099)
                CFrameMon = CFrame.new(-1437.56348, 17.1481285, -14385.6934, 0.173624337, -0, -0.984811902, 0, 1, -0,
                    0.984811902, 0, 0.173624337)
                elseif Lv == 2425 or Lv <= 2449 or SelectMonster == "Snow Demon" or SelectArea == 'Candy Island' then
                    Mon = "Snow Demon"
                    NameQuest = "CandyQuest1"
                    LevelQuest = 2
                    NameMon = "Snow Demon"
                    CFrameQuest = CFrame.new(-1149.328, 13.5759039, -14445.6143, -0.156446099, 0, -0.987686574, 0, 1, 0, 0.987686574,
                    0, -0.156446099)
                CFrameMon = CFrame.new(-683.8216552734375, 73.99142456054688, -14395.048828125)
            elseif Lv == 2450 or Lv <= 2475 or SelectMonster == "Isle Outlaw" or SelectArea == 'Tiki Out Post' then
                Mon = "Isle Outlaw"
                NameQuest = "TikiQuest1"
                LevelQuest = 1
                NameMon = "Isle Outlaw"
                CFrameMon = CFrame.new(-16139.3896484375, 73.87037658691406, -129.36663818359375)
                CFrameQuest = CFrame.new(-16547.54296875, 57.4870719909668, -173.22247314453125)
            elseif Lv == 2475 or Lv <= 2499 or SelectMonster == "Island Boy" or SelectArea == 'Island Boy' then
                Mon = "Island Boy"
                NameQuest = "TikiQuest1"
                LevelQuest = 2
                NameMon = "Island Boy"
                CFrameMon = CFrame.new(-16139.3896484375, 73.87037658691406, -129.36663818359375)
                CFrameQuest = CFrame.new(-16547.54296875, 57.4870719909668, -173.22247314453125)
            elseif Lv == 2500 or Lv <= 2524 or SelectMonster == "Sun-kissed Warrior" or SelectArea == 'Sun-kissed Warrior' then
                Mon = "Sun-kissed Warrior"
                NameQuest = "TikiQuest2"
                LevelQuest = 1
                NameMon = "Sun-kissed Warrior"
                CFrameMon = CFrame.new(-16597.333984375, 83.66167449951172, 1093.4403076171875)
                CFrameQuest = CFrame.new(-16539.6171875, 55.66054153442383, 1051.3416748046875)
            elseif Lv > 2525 or SelectMonster == "Isle Champion" or SelectArea == 'Isle Champion' then
                Mon = "Isle Champion"
                NameQuest = "TikiQuest2"
                LevelQuest = 2
                NameMon = "Isle Champion"
                CFrameMon = CFrame.new(-16597.333984375, 83.66167449951172, 1093.4403076171875)
                CFrameQuest = CFrame.new(-16539.6171875, 55.66054153442383, 1051.3416748046875)
            end
        end
    end
    
    function fly()
        local mouse=game:GetService("Players").LocalPlayer:GetMouse''
        localplayer=game:GetService("Players").LocalPlayer
        game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart")
        local torso = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
        local speedSET=25
        local keys={a=false,d=false,w=false,s=false}
        local e1
        local e2
        local function start()
            local pos = Instance.new("BodyPosition",torso)
            local gyro = Instance.new("BodyGyro",torso)
            pos.Name="EPIXPOS"
            pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
            pos.position = torso.Position
            gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            gyro.CFrame = torso.CFrame
            repeat
                    wait()
                    localplayer.Character.Humanoid.PlatforMontand=true
                    local new=gyro.CFrame - gyro.CFrame.p + pos.position
                    if not keys.w and not keys.s and not keys.a and not keys.d then
                    speed=1
                    end
                    if keys.w then
                    new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
                    speed=speed+speedSET
                    end
                    if keys.s then
                    new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
                    speed=speed+speedSET
                    end
                    if keys.d then
                    new = new * CFrame.new(speed,0,0)
                    speed=speed+speedSET
                    end
                    if keys.a then
                    new = new * CFrame.new(-speed,0,0)
                    speed=speed+speedSET
                    end
                    if speed>speedSET then
                    speed=speedSET
                    end
                    pos.position=new.p
                    if keys.w then
                    gyro.CFrame = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad(speed*15),0,0)
                    elseif keys.s then
                    gyro.CFrame = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(math.rad(speed*15),0,0)
                    else
                    gyro.CFrame = workspace.CurrentCamera.CoordinateFrame
                    end
            until not Fly
            if gyro then 
                    gyro:Destroy() 
            end
            if pos then 
                    pos:Destroy() 
            end
            flying=false
            localplayer.Character.Humanoid.PlatforMontand=false
            speed=0
        end
        e1=mouse.KeyDown:connect(function(key)
            if not torso or not torso.Parent then 
                    flying=false e1:disconnect() e2:disconnect() return 
            end
            if key=="w" then
                keys.w=true
            elseif key=="s" then
                keys.s=true
            elseif key=="a" then
                keys.a=true
            elseif key=="d" then
                keys.d=true
            end
        end)
        e2=mouse.KeyUp:connect(function(key)
            if key=="w" then
                keys.w=false
            elseif key=="s" then
                keys.s=false
            elseif key=="a" then
                keys.a=false
            elseif key=="d" then
                keys.d=false
            end
        end)
        start()
    end
    
    function Click()
        game:GetService'VirtualUser':CaptureController()
        game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
    end
    
    function AutoHaki()
        if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("HasBuso") then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
        end
    end
    
    function UnEquipWeapon(Weapon)
        if game.Players.LocalPlayer.Character:FindFirstChild(Weapon) then
            _G.NotAutoEquip = true
            wait(.5)
            game.Players.LocalPlayer.Character:FindFirstChild(Weapon).Parent = game.Players.LocalPlayer.Backpack
            wait(.1)
            _G.NotAutoEquip = false
        end
    end
    
    function EquipWeapon(ToolSe)
        if not _G.NotAutoEquip then
            if game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe) then
                Tool = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe)
                wait(.1)
                game.Players.LocalPlayer.Character.Humanoid:EquipTool(Tool)
            end
        end
    end
    
    function topos(Pos)
        Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
        if game.Players.LocalPlayer.Character.Humanoid.Sit == true then game.Players.LocalPlayer.Character.Humanoid.Sit = false end
        pcall(function() tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(Distance/210, Enum.EasingStyle.Linear),{CFrame = Pos}) end)
        tween:Play()
        if Distance <= 250 then
            tween:Cancel()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Pos
        end
        if _G.StopTween == true then
            tween:Cancel()
            _G.Clip = false
        end
    end
    
    function GetDistance(target)
        return math.floor((target.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)
    end
    
    function TP1(Pos)
    Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if Distance < 360 then
        Speed = 800
    elseif Distance < 1000 then
        Speed = 300
    elseif Distance < 360 then
        Speed = 800
    elseif Distance >= 1000 then
        Speed = 300
    end
    game:GetService("TweenService"):Create(
        game.Players.LocalPlayer.Character.HumanoidRootPart,
        TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
        {CFrame = Pos}
    ):Play()
end
    
    function TP(Pos)
        Distance = (Pos.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
        if Distance < 250 then
            Speed = 600
        elseif Distance >= 1000 then
            Speed = 200
        end
        game:GetService("TweenService"):Create(
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
            {CFrame = Pos}
        ):Play()
        _G.Clip = true
        wait(Distance/Speed)
        _G.Clip = false
    end
    
    spawn(function()
        pcall(function()
            while wait() do
                if _G.AutoAdvanceDungeon or _G.AutoDoughtBoss or _G.Auto_DungeonMobAura or _G.AutoFarmChest or _G.AutoFarmBossHallow or _G.AutoFarMonwanGlasses or _G.AutoLongSword or _G.AutoBlackSpikeycoat or _G.AutoElectricClaw or _G.AutoFarmGunMastery or _G.AutoHolyTorch or _G.AutoLawRaid or _G.AutoFarmBoss or _G.AutoTwinHooks or _G.AutoOpenSwanDoor or _G.AutoDragon_Trident or _G.AutoSaber or _G.AutoFarmFruitMastery or _G.AutoFarmGunMastery or _G.TeleportIsland or _G.Auto_EvoRace or _G.AutoFarmAllMonBypassType or _G.AutoObservationv2 or _G.AutoMusketeerHat or _G.AutoEctoplasm or _G.AutoRengoku or _G.Auto_Rainbow_Haki or _G.AutoObservation or _G.AutoDarkDagger or _G.Safe_Mode or _G.MasteryFruit or _G.AutoBudySword or _G.AutoOderSword or _G.AutoBounty or _G.AutoAllBoss or _G.Auto_Bounty or _G.AutoSharkman or _G.Auto_Mastery_Fruit or _G.Auto_Mastery_Gun or _G.Auto_Dungeon or _G.Auto_Cavender or _G.Auto_Pole or _G.Auto_Kill_Ply or _G.Auto_Factory or _G.AutoSecondSea or _G.TeleportPly or _G.AutoBartilo or _G.Auto_DarkBoss or _G.GrabChest or _G.AutoFarmBounty or _G.Holy_Torch or _G.AutoFarm or _G.Clip or FarmBoss or _G.AutoElitehunter or _G.AutoThirdSea or _G.Auto_Bone or _G.AutoFarmCandy or _G.Autowaden or _G.Autogay or _G.Autopole or _G.Autosaw or AutoFarmChest == true then
                    if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
                        local Noclip = Instance.new("BodyVelocity")
                        Noclip.Name = "BodyClip"
                        Noclip.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
                        Noclip.MaxForce = Vector3.new(100000,100000,100000)
                        Noclip.Velocity = Vector3.new(0,0,0)
                    end
                end
            end
        end)
    end)
    
    spawn(function()
        pcall(function()
            game:GetService("RunService").Stepped:Connect(function()
                if _G.AutoAdvanceDungeon or _G.AutoDoughtBoss or _G.Auto_DungeonMobAura or _G.AutoFarmChest or _G.AutoFarmBossHallow or _G.AutoFarMonwanGlasses or _G.AutoLongSword or _G.AutoBlackSpikeycoat or _G.AutoElectricClaw or _G.AutoFarmGunMastery or _G.AutoHolyTorch or _G.AutoLawRaid or _G.AutoFarmBoss or _G.AutoTwinHooks or _G.AutoOpenSwanDoor or _G.AutoDragon_Trident or _G.AutoSaber or _G.NOCLIP or _G.AutoFarmFruitMastery or _G.AutoFarmGunMastery or _G.TeleportIsland or _G.Auto_EvoRace or _G.AutoFarmAllMonBypassType or _G.AutoObservationv2 or _G.AutoMusketeerHat or _G.AutoEctoplasm or _G.AutoRengoku or _G.Auto_Rainbow_Haki or _G.AutoObservation or _G.AutoDarkDagger or _G.Safe_Mode or _G.MasteryFruit or _G.AutoBudySword or _G.AutoOderSword or _G.AutoBounty or _G.AutoAllBoss or _G.Auto_Bounty or _G.AutoSharkman or _G.Auto_Mastery_Fruit or _G.Auto_Mastery_Gun or _G.Auto_Dungeon or _G.Auto_Cavender or _G.Auto_Pole or _G.Auto_Kill_Ply or _G.Auto_Factory or _G.AutoSecondSea or _G.TeleportPly or _G.AutoBartilo or _G.Auto_DarkBoss or _G.GrabChest or _G.AutoFarmBounty or _G.Holy_Torch or _G.AutoFarm or _G.Clip or _G.AutoElitehunter or _G.AutoThirdSea or _G.Auto_Bone or _G.AutoFarmCandy or _G.Autowaden or _G.Autogay or _G.Autopole or _G.Autosaw or AutoFarmChest == true then
                    for _, v in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
                        if v:IsA("BasePart") then
                            v.CanCollide = false    
                        end
                    end
                end
            end)
        end)
    end)
    
    spawn(function()
        while wait() do
            if _G.AutoDoughtBoss or _G.Auto_DungeonMobAura or _G.AutoFarmChest or _G.AutoFarmBossHallow or _G.AutoFarMonwanGlasses or _G.AutoLongSword or _G.AutoBlackSpikeycoat or _G.AutoElectricClaw or _G.AutoFarmGunMastery or _G.AutoHolyTorch or _G.AutoLawRaid or _G.AutoFarmBoss or _G.AutoTwinHooks or _G.AutoOpenSwanDoor or _G.AutoDragon_Trident or _G.AutoSaber or _G.NOCLIP or _G.AutoFarmFruitMastery or _G.AutoFarmGunMastery or _G.TeleportIsland or _G.Auto_EvoRace or _G.AutoFarmAllMonBypassType or _G.AutoObservationv2 or _G.AutoMusketeerHat or _G.AutoEctoplasm or _G.AutoRengoku or _G.Auto_Rainbow_Haki or _G.AutoObservation or _G.AutoDarkDagger or _G.Safe_Mode or _G.MasteryFruit or _G.AutoBudySword or _G.AutoOderSword or _G.AutoAllBoss or _G.Auto_Bounty or _G.AutoSharkman or _G.Auto_Mastery_Fruit or _G.Auto_Mastery_Gun or _G.Auto_Dungeon or _G.Auto_Cavender or _G.Auto_Pole or _G.Auto_Kill_Ply or _G.Auto_Factory or _G.AutoSecondSea or _G.TeleportPly or _G.AutoBartilo or _G.Auto_DarkBoss or _G.AutoFarm or _G.Clip or _G.AutoElitehunter or _G.AutoThirdSea or _G.Auto_Bone or _G.AutoFarmCandy or _G.Autowaden or _G.Autogay or _G.Autopole or _G.Autosaw == true then
                pcall(function()
                    game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("Ken",true)
                end)
            end    
        end
    end)
    
    function StopTween(target)
        if not target then
            _G.StopTween = true
            wait()
            topos(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
            wait()
            if game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy()
            end
            _G.StopTween = false
            _G.Clip = false
        end
    end
    
    spawn(function()
        pcall(function()
            while wait() do
                for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do  
                    if v:IsA("Tool") then
                        if v:FindFirstChild("RemoteFunctionShoot") then 
                            SelectWeaponGun = v.Name
                        end
                    end
                end
            end
        end)
    end)
    
    game:GetService("Players").LocalPlayer.Idled:connect(function()
        game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)



local Win = library:Evil("Direct","",_G.Logo )

local MainT = Win:CraftTab('Main')
local Main = MainT:CraftPage('Main',1)
local Weapon = MainT:CraftPage('Main Item',1)
local AutoFarm = Main:Toggle("Auto Farm Level",_G.AutoFarm,function(value)
    _G.AutoFarm = value
            StopTween(_G.AutoFarm)
            
        end)    
        
        spawn(function()
            while wait() do
                if _G.AutoFarm then
                    pcall(function()
                        local QuestTitle = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
                        if not string.find(QuestTitle, NameMon) then
                            StartMagnet = false
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                        end
                        if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                            StartMagnet = false
                            CheckQuest()
                            repeat wait() TP1(CFrameQuest) until (CFrameQuest.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not _G.AutoFarm
                            if (CFrameQuest.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 then
                                wait(1.2)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest",NameQuest,LevelQuest)
                                wait(0.5)
                            end
                        elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                            CheckQuest()
                            if game:GetService("Workspace").Enemies:FindFirstChild(Mon) then
                                for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                    if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                        if v.Name == Mon then
                                            if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) then
                                                repeat task.wait()
                                                    EquipWeapon(_G.SelectWeapon)
                                                    AutoHaki()                                            
                                                    PosMon = v.HumanoidRootPart.CFrame
                                                    TP1(v.HumanoidRootPart.CFrame * CFrame.new(0,25,15))
                                                    v.HumanoidRootPart.CanCollide = false
                                                    v.Humanoid.WalkSpeed = 0
                                                    v.Head.CanCollide = false
                                                    v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                                    StartMagnet = true
                                                    game:GetService'VirtualUser':CaptureController()
                                                    game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                                                until not _G.AutoFarm or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                            else
                                                StartMagnet = false
                                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                                            end
                                        end
                                    end
                                end
                            else
                                TP1(CFrameMon)
                                StartMagnet = false
                                if game:GetService("ReplicatedStorage"):FindFirstChild(Mon) then
                                TP1(game:GetService("ReplicatedStorage"):FindFirstChild(Mon).HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                end
                            end
                        end
                    end)
                end
            end
        end) 
        
        Main:Seperator("「 Ectoplasm 」")
            
        Main:Toggle("Auto Farm Ectoplasm",_G.AutoEctoplasm,function(value)
            _G.AutoEctoplasm = value
            StopTween(_G.AutoEctoplasm)
        end)
        
        spawn(function()
            pcall(function()
                while wait() do
                    if _G.AutoEctoplasm then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Ship Deckhand") or game:GetService("Workspace").Enemies:FindFirstChild("Ship Engineer") or game:GetService("Workspace").Enemies:FindFirstChild("Ship Steward") or game:GetService("Workspace").Enemies:FindFirstChild("Ship Officer") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if string.find(v.Name, "Ship") then
                                    repeat task.wait()
                                        EquipWeapon(_G.SelectWeapon)
                                        AutoHaki()
                                        if string.find(v.Name,"Ship") then
                                            v.HumanoidRootPart.CanCollide = false
                                            v.Head.CanCollide = false
                                            v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                            topos(v.HumanoidRootPart.CFrame * CFrame.new(0,25,15))
                                            game:GetService'VirtualUser':CaptureController()
                                            game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                                            EctoplasmMon = v.HumanoidRootPart.CFrame
                                            StartEctoplasmMagnet = true
                                        else
                                            StartEctoplasmMagnet = false
                                            topos(CFrame.new(911.35827636719, 125.95812988281, 33159.5390625))
                                        end
                                    until _G.AutoEctoplasm == false or not v.Parent or v.Humanoid.Health <= 0
                                end
                            end
                        else
                            StartEctoplasmMagnet = false
                            local Distance = (Vector3.new(911.35827636719, 125.95812988281, 33159.5390625) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                            if Distance > 18000 then
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                            end
                            topos(CFrame.new(911.35827636719, 125.95812988281, 33159.5390625))
                        end
                    end
                end
            end)
        end)
        
        Main:Seperator("「 Bone 」")
        
        local BoneFarm = Main:Toggle("Auto Farm Bone",_G.Auto_Bone,function(value)
            _G.Auto_Bone = value
            StopTween(_G.Auto_Bone)
        end)
        
        spawn(function()
            while wait() do 
                if _G.Auto_Bone and World3 then
                    pcall(function()
                        if game:GetService("Workspace").Enemies:FindFirstChild("Reborn Skeleton") or game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie") or game:GetService("Workspace").Enemies:FindFirstChild("Demonic Soul") or game:GetService("Workspace").Enemies:FindFirstChild("Posessed Mummy") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "Reborn Skeleton" or v.Name == "Living Zombie" or v.Name == "Demonic Soul" or v.Name == "Posessed Mummy" then
                                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                        repeat task.wait()
                                            AutoHaki()
                                            EquipWeapon(_G.SelectWeapon)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.Humanoid.WalkSpeed = 0
                                            v.Head.CanCollide = false 
                                            StartMagnetBoneMon = true
                                            PosMonBone = v.HumanoidRootPart.CFrame
                                            topos(v.HumanoidRootPart.CFrame * CFrame.new(0,25,15))
                                            game:GetService("VirtualUser"):CaptureController()
                                            game:GetService("VirtualUser"):Button1Down(Vector2.new(1280,672))
                                        until not _G.Auto_Bone or not v.Parent or v.Humanoid.Health <= 0
                                    end
                                end
                            end
                        else
                            topos(CFrame.new(-9466.72949, 171.162918, 6132.01514))
                            StartMagnetBoneMon = false
                            for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do 
                                if v.Name == "Reborn Skeleton" then
                                    topos(v.HumanoidRootPart.CFrame * CFrame.new(2,20,2))
                                elseif v.Name == "Living Zombie" then
                                    topos(v.HumanoidRootPart.CFrame * CFrame.new(2,20,2))
                                elseif v.Name == "Demonic Soul" then
                                    topos(v.HumanoidRootPart.CFrame * CFrame.new(2,20,2))
                                elseif v.Name == "Posessed Mummy" then
                                    topos(v.HumanoidRootPart.CFrame * CFrame.new(2,20,2))
                                end
                            end
                        end
                    end)
                end
            end
        end)
        
        Main:Toggle("Auto Random Surprise",_G.Auto_Random_Bone,function(value)
            _G.Auto_Random_Bone = value
        end)
        
        spawn(function()
            pcall(function()
                while wait(.1) do
                    if _G.Auto_Random_Bone then    
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones","Buy",1,1)
                    end
                end
            end)
        end)
            
            Main:Button("Checking Bone", function()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Checking Bone", 
            Text = ("Your Bone : "..(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones","Check")))
        })
        wait(1)
    end)
        
        Main:Seperator("「 Farm Chest 」")
        
        Main:Button("Tp Chest (Risky!)",function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptpastebin/raw/main/chestfarm"))()
        end)
        
        Main:Toggle("Auto Farm Chest (Tween)",false,function(value)
     AutoFarmChest = value
     StopTween(AutoFarmChest)
     end)
     
     _G.MagnitudeAdd = 0
    spawn(function()
        while wait() do 
            if AutoFarmChest then
                for i,v in pairs(game:GetService("Workspace"):GetChildren()) do 
                    if v.Name:find("Chest") then
                        if game:GetService("Workspace"):FindFirstChild(v.Name) then
                            if (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5000+_G.MagnitudeAdd then
                                repeat wait()
                                    if game:GetService("Workspace"):FindFirstChild(v.Name) then
                                        topos(v.CFrame)
                                    end
                                until AutoFarmChest == false or not v.Parent
                                topos(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
                                _G.MagnitudeAdd = _G.MagnitudeAdd+1500
                                break
                            end
                        end
                    end
                end
            end
        end
        end)
    
        Main:Seperator("「 Auto Seas 」")
    
            Main:Toggle("Auto Second Sea",_G.AutoSecondSea,function(value)
                _G.AutoSecondSea = value
                StopTween(_G.AutoSecondSea)
            end)
        
            spawn(function()
                while wait() do 
                    if _G.AutoSecondSea then
                        pcall(function()
                            local MyLevel = game:GetService("Players").LocalPlayer.Data.Level.Value
                            if MyLevel >= 700 and World1 then
                                if game:GetService("Workspace").Map.Ice.Door.CanCollide == false and game:GetService("Workspace").Map.Ice.Door.Transparency == 1 then
                                    local CFrame1 = CFrame.new(4849.29883, 5.65138149, 719.611877)
                                    repeat topos(CFrame1) wait() until (CFrame1.Position-game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or _G.AutoSecondSea == false
                                    wait(1.1)
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("DressrosaQuestProgress","Detective")
                                    wait(0.5)
                                    EquipWeapon("Key")
                                    repeat topos(CFrame.new(1347.7124, 37.3751602, -1325.6488)) wait() until (Vector3.new(1347.7124, 37.3751602, -1325.6488)-game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or _G.AutoSecondSea == false
                                    wait(0.5)
                                else
                                    if game:GetService("Workspace").Map.Ice.Door.CanCollide == false and game:GetService("Workspace").Map.Ice.Door.Transparency == 1 then
                                        if game:GetService("Workspace").Enemies:FindFirstChild("Ice Admiral [Boss]") then
                                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                                if v.Name == "Ice Admiral [Boss]" then
                                                    if not v.Humanoid.Health <= 0 then
                                                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                                            OldCFrameSecond = v.HumanoidRootPart.CFrame
                                                            repeat task.wait()
                                                                AutoHaki()
                                                                EquipWeapon(_G.SelectWeapon)
                                                                v.HumanoidRootPart.CanCollide = false
                                                                v.Humanoid.WalkSpeed = 0
                                                                v.Head.CanCollide = false
                                                                v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                                                v.HumanoidRootPart.CFrame = OldCFrameSecond
                                                                topos(v.HumanoidRootPart.CFrame * CFrame.new(0,25,15))
                                                                game:GetService("VirtualUser"):CaptureController()
                                                                game:GetService("VirtualUser"):Button1Down(Vector2.new(1280,672))
                                                                sethiddenproperty(game:GetService("Players").LocalPlayer,"SimulationRadius",math.huge)
                                                            until not _G.AutoSecondSea or not v.Parent or v.Humanoid.Health <= 0
                                                        end
                                                    else 
                                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
                                                    end
                                                end
                                            end
                                        else
                                            if game:GetService("ReplicatedStorage"):FindFirstChild("Ice Admiral [Boss]") then
                                                topos(game:GetService("ReplicatedStorage"):FindFirstChild("Ice Admiral [Boss]").HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                            end
                                        end
                                    end
                                end
                            end
                        end)
                    end
                end
            end)
    
            Main:Toggle("Auto Third Sea",_G.AutoThirdSea,function(value)
                _G.AutoThirdSea = value
                StopTween(_G.AutoThirdSea)
            end)
        
            spawn(function()
                while wait() do
                    if _G.AutoThirdSea then
                        pcall(function()
                            if game:GetService("Players").LocalPlayer.Data.Level.Value >= 1500 and World2 then
                                _G.AutoFarm = false
                                if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ZQuestProgress","Check") == 0 then
                                    topos(CFrame.new(-1926.3221435547, 12.819851875305, 1738.3092041016))
                                    if (CFrame.new(-1926.3221435547, 12.819851875305, 1738.3092041016).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                                        wait(1.5)
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ZQuestProgress","Begin")
                                    end
                                    wait(1.8)
                                    if game:GetService("Workspace").Enemies:FindFirstChild("rip_indra [Boss]") then
                                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                            if v.Name == "rip_indra [Boss]" then
                                                OldCFrameThird = v.HumanoidRootPart.CFrame
                                                repeat task.wait()
                                                    AutoHaki()
                                                    EquipWeapon(_G.SelectWeapon)
                                                    topos(v.HumanoidRootPart.CFrame * CFrame.new(0,25,15))
                                                    v.HumanoidRootPart.CFrame = OldCFrameThird
                                                    v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                                    v.HumanoidRootPart.CanCollide = false
                                                    v.Humanoid.WalkSpeed = 0
                                                    game:GetService'VirtualUser':CaptureController()
                                                    game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
                                                    sethiddenproperty(game:GetService("Players").LocalPlayer,"SimulationRadius",math.huge)
                                                until _G.AutoThirdSea == false or v.Humanoid.Health <= 0 or not v.Parent
                                            end
                                        end
                                    elseif not game:GetService("Workspace").Enemies:FindFirstChild("rip_indra [Boss]") and (CFrame.new(-26880.93359375, 22.848554611206, 473.18951416016).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1000 then
                                        topos(CFrame.new(-26880.93359375, 22.848554611206, 473.18951416016))
                                    end
                                end
                            end
                        end)
                    end
                end
            end)
        
        
        Main:Seperator("「 Factory 」")
            Main:Toggle("Auto Farm Factory",_G.AutoFactory,function(value)
                _G.AutoFactory = value
                StopTween(_G.AutoFactory)
            end)
        
            spawn(function()
                while wait() do
                    pcall(function()
                        if _G.AutoFactory then
                            if game:GetService("Workspace").Enemies:FindFirstChild("Core") then
                                for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                    if v.Name == "Core" and v.Humanoid.Health > 0 then
                                        repeat task.wait()
                                            AutoHaki()         
                                            EquipWeapon(_G.SelectWeapon)           
                                            topos(CFrame.new(448.46756, 199.356781, -441.389252))                                  
                                            game:GetService("VirtualUser"):CaptureController()
                                            game:GetService("VirtualUser"):Button1Down(Vector2.new(1280,672))
                                        until v.Humanoid.Health <= 0 or _G.AutoFactory == false
                                    end
                                end
                            else
                                topos(CFrame.new(448.46756, 199.356781, -441.389252))
                            end
                        end
                    end)
                end
            end)

            getgenv().A = require(game:GetService("ReplicatedStorage").CombatFramework.RigLib).wrapAttackAnimationAsync 
            getgenv().B = require(game.Players.LocalPlayer.PlayerScripts.CombatFramework.Particle).play
            spawn(function()
                while wait() do
                 require(game:GetService("ReplicatedStorage").CombatFramework.RigLib).wrapAttackAnimationAsync =function(a1,a2,a3,a4,a5)
                      local GetBladeHits = require(game:GetService("ReplicatedStorage").CombatFramework.RigLib).getBladeHits(a2,a3,a4)
                        if GetBladeHits then
                           require(game:GetService("ReplicatedStorage").CombatFramework.RigLib).play = function() end
                           a1:Play(0.2, 0.2, 0.2)
                           a5(GetBladeHits)
                           require(game:GetService("ReplicatedStorage").CombatFramework.RigLib).play = getgenv().B 
                           wait(.5)
                           a1:Stop()
                        end
                     end
                end
            end)

            Weapon:Seperator("「 Auto Sword 」")
	
            Weapon:Toggle("Auto Waden Sword", _G.Autowaden,function(value)
                  _G.Autowaden = value
                 StopTween( _G.Autowaden)
             end)
             
             Weapon:Toggle("Auto Waden Sword Hop", _G.Autowadenhop,function(value)
                  _G.Autowadenhop = value
             end)
             
             spawn(function()
                 while wait() do
                     if  _G.Autowaden and World1 then
                         pcall(function()
                             if game:GetService("Workspace").Enemies:FindFirstChild("Chief Warden [Boss]") then
                                 for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                     if v.Name == "Chief Warden [Boss]" then
                                         if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                             repeat task.wait()
                                                 AutoHaki()
                                                 EquipWeapon(_G.SelectWeapon)
                                                 v.HumanoidRootPart.CanCollide = false
                                                 v.Humanoid.WalkSpeed = 0
                                                 v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                                 topos(v.HumanoidRootPart.CFrame * CFrame.new(0,25,15))
                                                 game:GetService("VirtualUser"):CaptureController()
                                                 game:GetService("VirtualUser"):Button1Down(Vector2.new(1280,672))
                                                 sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius",math.huge)
                                             until not  _G.Autowaden or not v.Parent or v.Humanoid.Health <= 0
                                         end
                                     end
                                 end
                             else
                             topos(CFrame.new(5186.14697265625, 24.86684226989746, 832.1885375976562))
                                 if game:GetService("ReplicatedStorage"):FindFirstChild("Chief Warden [Boss]") then
                                     topos(game:GetService("ReplicatedStorage"):FindFirstChild("Chief Warden [Boss]").HumanoidRootPart.CFrame * CFrame.new(2,20,2))
                                 else
                                     if  _G.Autowadenhop then
                                         Hop()
                                     end
                                 end
                             end
                         end)
                     end
                 end
             end)
             
             Weapon:Toggle("Auto Greybeard", _G.Autodoughking,function(value)
                  _G.Autogay = value
                 StopTween( _G.Autogay)
             end)
             
             Weapon:Toggle("Auto Greybeard Hop", _G.AutodoughkingHop,function(value)
                  _G.Autogayhop = value
             end)
             
             spawn(function()
                 while wait() do
                     if  _G.Autogay and World1 then
                         pcall(function()
                             if game:GetService("Workspace").Enemies:FindFirstChild("Greybeard") then
                                 for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                     if v.Name == "Greybeard" then
                                         if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                             repeat task.wait()
                                                 AutoHaki()
                                                 EquipWeapon(_G.SelectWeapon)
                                                 v.HumanoidRootPart.CanCollide = false
                                                 v.Humanoid.WalkSpeed = 0
                                                 v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                                 topos(v.HumanoidRootPart.CFrame * CFrame.new(0,25,15))
                                                 game:GetService("VirtualUser"):CaptureController()
                                                 game:GetService("VirtualUser"):Button1Down(Vector2.new(1280,672))
                                                 sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius",math.huge)
                                             until not  _G.Autogay or not v.Parent or v.Humanoid.Health <= 0
                                         end
                                     end
                                 end
                             else
                             topos(CFrame.new(-5023.38330078125, 28.65203285217285, 4332.3818359375))
                                 if game:GetService("ReplicatedStorage"):FindFirstChild("Greybeard") then
                                     topos(game:GetService("ReplicatedStorage"):FindFirstChild("Greybeard").HumanoidRootPart.CFrame * CFrame.new(2,20,2))
                                 else
                                     if  _G.Autogayhop then
                                         Hop()
                                     end
                                 end
                             end
                         end)
                     end
                 end
             end)
             
             Weapon:Toggle("Auto Pole v1", _G.Autodoughking,function(value)
                  _G.Autopole = value
                 StopTween( _G.Autopole)
             end)
             
             Weapon:Toggle("Auto Pole v1 Hop", _G.AutodoughkingHop,function(value)
                  _G.Autopolehop = value
             end)
             
             spawn(function()
                 while wait() do
                     if  _G.Autopole and World1 then
                         pcall(function()
                             if game:GetService("Workspace").Enemies:FindFirstChild("Thunder God [Boss]") then
                                 for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                     if v.Name == "Thunder God [Boss]" then
                                         if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                             repeat task.wait()
                                                 AutoHaki()
                                                 EquipWeapon(_G.SelectWeapon)
                                                 v.HumanoidRootPart.CanCollide = false
                                                 v.Humanoid.WalkSpeed = 0
                                                 v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                                 topos(v.HumanoidRootPart.CFrame * CFrame.new(0,25,15))
                                                 game:GetService("VirtualUser"):CaptureController()
                                                 game:GetService("VirtualUser"):Button1Down(Vector2.new(1280,672))
                                                 sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius",math.huge)
                                             until not  _G.Autopole or not v.Parent or v.Humanoid.Health <= 0
                                         end
                                     end
                                 end
                             else
                             topos(CFrame.new(-7748.0185546875, 5606.80615234375, -2305.898681640625))
                                 if game:GetService("ReplicatedStorage"):FindFirstChild("Thunder God [Boss]") then
                                     topos(game:GetService("ReplicatedStorage"):FindFirstChild("Thunder God [Boss]").HumanoidRootPart.CFrame * CFrame.new(2,20,2))
                                 else
                                     if  _G.Autopolehop then
                                         Hop()
                                     end
                                 end
                             end
                         end)
                     end
                 end
             end)
             
             Weapon:Toggle("Auto Sharks saw", _G.Autodoughking,function(value)
                  _G.Autosaw = value
                 StopTween( _G.Autopole)
             end)
             
             Weapon:Toggle("Auto Shark Saw Hop", _G.AutodoughkingHop,function(value)
                  _G.Autosawhop = value
             end)
             
             spawn(function()
                 while wait() do
                     if  _G.Autosaw and World1 then
                         pcall(function()
                             if game:GetService("Workspace").Enemies:FindFirstChild("The Saw [Boss]") then
                                 for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                     if v.Name == "The Saw [Boss]" then
                                         if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                             repeat task.wait()
                                                 AutoHaki()
                                                 EquipWeapon(_G.SelectWeapon)
                                                 v.HumanoidRootPart.CanCollide = false
                                                 v.Humanoid.WalkSpeed = 0
                                                 v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                                 topos(v.HumanoidRootPart.CFrame * CFrame.new(0,25,15))
                                                 game:GetService("VirtualUser"):CaptureController()
                                                 game:GetService("VirtualUser"):Button1Down(Vector2.new(1280,672))
                                                 sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius",math.huge)
                                             until not  _G.Autosaw or not v.Parent or v.Humanoid.Health <= 0
                                         end
                                     end
                                 end
                             else
                             topos(CFrame.new(-690.33081054688, 15.09425163269, 1582.2380371094))
                                 if game:GetService("ReplicatedStorage"):FindFirstChild("The Saw [Boss]") then
                                     topos(game:GetService("ReplicatedStorage"):FindFirstChild("The Saw [Boss]").HumanoidRootPart.CFrame * CFrame.new(2,40,2))
                                 else
                                     if  _G.Autosawhop then
                                         Hop()
                                     end
                                 end
                             end
                         end)
                     end
                 end
             end)
             
            Weapon:Line()
            
         Weapon:Seperator("「 Auto Dough 」")
             
             local MobKilled = Weapon:Label("Killed")
             
             spawn(function()
                 while wait() do
                     pcall(function()
                         if string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 88 then
                             MobKilled:Set("Defeat : "..string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"),39,41))
                         elseif string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 87 then
                             MobKilled:Set("Defeat : "..string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"),39,40))
                         elseif string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 86 then
                             MobKilled:Set("Defeat : "..string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"),39,39))
                         else
                             MobKilled:Set("Boss Is Spawning")
                         end
                     end)
                 end
             end)
             
             Weapon:Toggle("Auto Spikey Trident",_G.AutoDoughtBoss,function(value)
                 _G.AutoDoughtBoss = value
                 StopTween(_G.AutoDoughtBoss)
             end)
             
             spawn(function()
                 while wait() do
                     pcall(function()
                         if string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 88 then
                             KillMob = (tonumber(string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"),39,41)) - 500)
                         elseif string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 87 then
                             KillMob = (tonumber(string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"),40,41)) - 500)
                         elseif string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 86 then
                             KillMob = (tonumber(string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"),41,41)) - 500)
                         end
                     end)
                 end
             end)
             
             spawn(function()
                 while wait() do
                     if _G.AutoDoughtBoss then
                         pcall(function()
                             if game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince") then
                                 for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                     if v.Name == "Cake Prince" then
                                         if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                             repeat task.wait()
                                                 AutoHaki()
                                                 EquipWeapon(_G.SelectWeapon)
                                                 v.HumanoidRootPart.CanCollide = false
                                                 v.Humanoid.WalkSpeed = 0
                                                 v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                                 topos(v.HumanoidRootPart.CFrame * CFrame.new(0,25,15))
                                                 game:GetService("VirtualUser"):CaptureController()
                                                 game:GetService("VirtualUser"):Button1Down(Vector2.new(1280,672))
                                                 sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius",math.huge)
                                             until not _G.AutoDoughtBoss or not v.Parent or v.Humanoid.Health <= 0
                                         end
                                     end
                                 end
                             else
                                 if game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince") then
                                     topos(game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince").HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                 else
                                     if KillMob == 0 then
                                         game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner",true)
                                     end                    
                                     if game:GetService("Workspace").Map.CakeLoaf.BigMirror.Other.Transparency == 1 then
                                         if game:GetService("Workspace").Enemies:FindFirstChild("Cookie Crafter") or game:GetService("Workspace").Enemies:FindFirstChild("Cake Guard") or game:GetService("Workspace").Enemies:FindFirstChild("Baking Staff") or game:GetService("Workspace").Enemies:FindFirstChild("Head Baker") then
                                             for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                                 if v.Name == "Cookie Crafter" or v.Name == "Cake Guard" or v.Name == "Baking Staff" or v.Name == "Head Baker" then
                                                     if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                                         repeat task.wait()
                                                             AutoHaki()
                                                             EquipWeapon(_G.SelectWeapon)
                                                             v.HumanoidRootPart.CanCollide = false
                                                             v.Humanoid.WalkSpeed = 0
                                                             v.Head.CanCollide = false 
                                                             v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                                             MagnetDought = true
                                                             PosMonDoughtOpenDoor = v.HumanoidRootPart.CFrame
                                                             topos(v.HumanoidRootPart.CFrame * CFrame.new(0,25,15))
                                                             game:GetService("VirtualUser"):CaptureController()
                                                             game:GetService("VirtualUser"):Button1Down(Vector2.new(1280,672))
                                                         until not _G.AutoDoughtBoss or not v.Parent or v.Humanoid.Health <= 0 or game:GetService("Workspace").Map.CakeLoaf.BigMirror.Other.Transparency == 0 or game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince") or game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince") or KillMob == 0
                                                     end
                                                 end
                                             end
                                         else
                                             topos(CFrame.new(-2091.911865234375, 70.00884246826172, -12142.8359375))
                                             MagnetDought = false
                                             if game:GetService("ReplicatedStorage"):FindFirstChild("Cookie Crafter") then
                                                 topos(game:GetService("ReplicatedStorage"):FindFirstChild("Cookie Crafter").HumanoidRootPart.CFrame * CFrame.new(0,30,0)) 
                                             else
                                                 if game:GetService("ReplicatedStorage"):FindFirstChild("Cake Guard") then
                                                     topos(game:GetService("ReplicatedStorage"):FindFirstChild("Cake Guard").HumanoidRootPart.CFrame * CFrame.new(0,30,0)) 
                                                 else
                                                     if game:GetService("ReplicatedStorage"):FindFirstChild("Baking Staff") then
                                                         topos(game:GetService("ReplicatedStorage"):FindFirstChild("Baking Staff").HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                                     else
                                                         if game:GetService("ReplicatedStorage"):FindFirstChild("Head Baker") then
                                                             topos(game:GetService("ReplicatedStorage"):FindFirstChild("Head Baker").HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                                         end
                                                     end
                                                 end
                                             end                       
                                         end
                                     else
                                         if game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince") then
                                             topos(game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince").HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                         else
                                             if game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince") then
                                                 topos(game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince").HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                             end
                                         end
                                     end
                                 end
                             end
                         end)
                     end
                 end
             end)
             
         Weapon:Seperator("「 Auto Buddy Sword 」")
             
            Weapon:Toggle("Auto Buddy Sword",_G.AutoBudySword,function(value)
                 _G.AutoBudySword = value
                 StopTween(_G.AutoBudySword)
             end)
             
             Weapon:Toggle("Auto Buddy Sword Hop",_G.AutoBudySwordHop,function(value)
                 _G.AutoBudySwordHop = value
             end)
             
             spawn(function()
                 while wait() do
                     if _G.AutoBudySword then
                         pcall(function()
                             if game:GetService("Workspace").Enemies:FindFirstChild("Cake Queen [Boss]") then
                                 for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                     if v.Name == "Cake Queen [Boss]" then
                                         if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                             repeat task.wait()
                                                 AutoHaki()
                                                 EquipWeapon(_G.SelectWeapon)
                                                 v.HumanoidRootPart.CanCollide = false
                                                 v.Humanoid.WalkSpeed = 0
                                                 v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                                 topos(v.HumanoidRootPart.CFrame * CFrame.new(0,25,15))
                                                 game:GetService("VirtualUser"):CaptureController()
                                                 game:GetService("VirtualUser"):Button1Down(Vector2.new(1280,672))
                                                 sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius",math.huge)
                                             until not _G.AutoBudySword or not v.Parent or v.Humanoid.Health <= 0
                                         end
                                     end
                                 end
                             else
                                 if game:GetService("ReplicatedStorage"):FindFirstChild("Cake Queen [Boss]") then
                                     topos(game:GetService("ReplicatedStorage"):FindFirstChild("Cake Queen [Boss]").HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                 else
                                     if _G.AutoBudySwordHop then
                                         Hop()
                                     end
                                 end
                             end
                         end)
                     end
                 end
             end)
             
             Weapon:Seperator("「 Auto Elite 」")
             
             local EliteProgress = Weapon:Label("")
             
             spawn(function()
                 pcall(function()
                     while wait() do
                         EliteProgress:Set("Elite Progress : "..game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter","Progress"))
                     end
                 end)
             end)
             
             Weapon:Toggle("Auto Elite Hunter",_G.AutoElitehunter,function(value)
                 _G.AutoElitehunter = value
                 game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                 StopTween(_G.AutoElitehunter)
             end)
             
             spawn(function()
                 while wait() do
                     if _G.AutoElitehunter and World3 then
                         pcall(function()
                             local QuestTitle = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
                             if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                                 repeat  wait()
                                     topos(CFrame.new(-5418.892578125, 313.74130249023, -2826.2260742188)) 
                                 until not _G.AutoElitehunter or (Vector3.new(-5418.892578125, 313.74130249023, -2826.2260742188)-game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3
                                 if (Vector3.new(-5418.892578125, 313.74130249023, -2826.2260742188)-game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 then
                                     wait(1.1)
                                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter")
                                     wait(0.5)
                                 end
                             elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                                 if string.find(QuestTitle,"Diablo") or string.find(QuestTitle,"Deandre") or string.find(QuestTitle,"Urban") then
                                     if game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or game:GetService("Workspace").Enemies:FindFirstChild("Deandre") or game:GetService("Workspace").Enemies:FindFirstChild("Urban") then
                                         for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                             if v.Name == "Diablo" or v.Name == "Deandre" or v.Name == "Urban" then
                                                 if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                                     repeat task.wait()
                                                         AutoHaki()
                                                         EquipWeapon(_G.SelectWeapon)
                                                         v.HumanoidRootPart.CanCollide = false
                                                         v.Humanoid.WalkSpeed = 0
                                                         v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                                         topos(v.HumanoidRootPart.CFrame * CFrame.new(0,25,15))
                                                         game:GetService("VirtualUser"):CaptureController()
                                                         game:GetService("VirtualUser"):Button1Down(Vector2.new(1280,672))
                                                         sethiddenproperty(game:GetService("Players").LocalPlayer,"SimulationRadius",math.huge)
                                                     until _G.AutoElitehunter == false or v.Humanoid.Health <= 0 or not v.Parent
                                                 end
                                             end
                                         end
                                     else
                                         if game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") then
                                             topos(game:GetService("ReplicatedStorage"):FindFirstChild("Diablo").HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                         elseif game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") then
                                             topos(game:GetService("ReplicatedStorage"):FindFirstChild("Deandre").HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                         elseif game:GetService("ReplicatedStorage"):FindFirstChild("Urban") then
                                             topos(game:GetService("ReplicatedStorage"):FindFirstChild("Urban").HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                         else
                                             if _G.AutoEliteHunterHop then
                                                 Hop()
                                             else
                                                 topos(CFrame.new(-5418.892578125, 313.74130249023, -2826.2260742188))
                                             end
                                         end
                                     end                    
                                 end
                             end
                         end)
                     end
                 end
             end)
             
             Weapon:Toggle("Auto Elite Hunter Hop",_G.AutoEliteHunterHop,function(value)
                 _G.AutoEliteHunterHop = value
             end)
             
             Weapon:Seperator("「 Hallow Scythe 」")
             
             Weapon:Toggle("Auto Hallow Scythe",_G.AutoFarmBossHallow,function(value)
                 _G.AutoFarmBossHallow = value
                 StopTween(_G.AutoFarmBossHallow)
             end)
             
             Weapon:Toggle("Auto Hallow Scythe Hop",_G.AutoFarmBossHallowHop,function(value)
                 _G.AutoFarmBossHallowHop = value
             end)
             
             spawn(function()
                 while wait() do
                     if _G.AutoFarmBossHallow then
                         pcall(function()
                             if game:GetService("Workspace").Enemies:FindFirstChild("Soul Reaper") then
                                 for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                     if string.find(v.Name , "Soul Reaper") then
                                         repeat task.wait()
                                             EquipWeapon(_G.SelectWeapon)
                                             AutoHaki()
                                             v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                             topos(v.HumanoidRootPart.CFrame*CFrame.new(0,25,15))
                                             game:GetService("VirtualUser"):CaptureController()
                                             game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 670))
                                             v.HumanoidRootPart.Transparency = 1
                                             sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius",math.huge)
                                         until v.Humanoid.Health <= 0 or _G.AutoFarmBossHallow == false
                                     end
                                 end
                             elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Hallow Essence") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Hallow Essence") then
                                 repeat topos(CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125)) wait() until (CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 8                        
                                 EquipWeapon("Hallow Essence")
                             else
                                 if game:GetService("ReplicatedStorage"):FindFirstChild("Soul Reaper") then
                                     topos(game:GetService("ReplicatedStorage"):FindFirstChild("Soul Reaper").HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                 else
                                     if _G.AutoFarmBossHallowHop then
                                         Hop()
                                     end
                                 end
                             end
                         end)
                     end
                 end
             end)
             
             Weapon:Seperator("「 Dark Dagger 」")
             
             Weapon:Toggle("Auto Dark Dagger",_G.AutoDarkDagger,function(value)
                 _G.AutoDarkDagger = value
                 StopTween(_G.AutoDarkDagger)
             end)
                 
             spawn(function()
                 pcall(function()
                     while wait() do
                         if _G.AutoDarkDagger then
                             if game:GetService("Workspace").Enemies:FindFirstChild("rip_indra True Form") or game:GetService("Workspace").Enemies:FindFirstChild("rip_indra") then
                                 for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                     if v.Name == ("rip_indra True Form" or v.Name == "rip_indra") and v.Humanoid.Health > 0 and v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                                         repeat task.wait()
                                             pcall(function()
                                                 AutoHaki()
                                                 EquipWeapon(_G.SelectWeapon)
                                                 v.HumanoidRootPart.CanCollide = false
                                                 v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                                 topos(v.HumanoidRootPart.CFrame * CFrame.new(0,25,15))
                                                 game:GetService("VirtualUser"):CaptureController()
                                                 game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 670),workspace.CurrentCamera.CFrame)
                                             end)
                                         until _G.AutoDarkDagger == false or v.Humanoid.Health <= 0
                                     end
                                 end
                             else
                                 topos(CFrame.new(-5344.822265625, 423.98541259766, -2725.0930175781))
                             end
                         end
                     end
                 end)
             end)
             
             Weapon:Toggle("Auto Dark Dagger Hop",_G.AutoDarkDagger_Hop,function(value)
                 _G.AutoDarkDagger_Hop = value
             end)
             
             spawn(function()
                 pcall(function()
                     while wait() do
                         if (_G.AutoDarkDagger_Hop and _G.AutoDarkDagger) and World3 and not game:GetService("ReplicatedStorage"):FindFirstChild("rip_indra True Form") and not game:GetService("Workspace").Enemies:FindFirstChild("rip_indra True Form") then
                             Hop()
                         end
                     end
                 end)
             end)
             
             Weapon:Seperator("「 Swan Glasses 」")
             
             Weapon:Toggle("Auto Swan Glasses",_G.AutoFarMonwanGlasses,function(value)
                 _G.AutoFarMonwanGlasses = value
                 StopTween(_G.AutoFarMonwanGlasses)
             end)
             
             spawn(function()
                 pcall(function()
                     while wait() do
                         if _G.AutoFarMonwanGlasses then
                             if game:GetService("Workspace").Enemies:FindFirstChild("Don Swan [Boss]") then
                                 for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                     if v.Name == "Don Swan [Boss]" and v.Humanoid.Health > 0 and v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                                         repeat task.wait()
                                             pcall(function()
                                                 AutoHaki()
                                                 EquipWeapon(_G.SelectWeapon)
                                                 v.HumanoidRootPart.CanCollide = false
                                                 v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                                 topos(v.HumanoidRootPart.CFrame * CFrame.new(0,25,15))
                                                 game:GetService("VirtualUser"):CaptureController()
                                                 game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 670))
                                                 sethiddenproperty(game:GetService("Players").LocalPlayer,"SimulationRadius",math.huge)
                                             end)
                                         until _G.AutoFarMonwanGlasses == false or v.Humanoid.Health <= 0
                                     end
                                 end
                             else 
                                 repeat task.wait()
                                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(2284.912109375, 15.537666320801, 905.48291015625)) 
                                 until (CFrame.new(2284.912109375, 15.537666320801, 905.48291015625).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 4 or _G.AutoFarMonwanGlasses == false
                             end
                         end
                     end
                 end)
             end)
             
             Weapon:Toggle("Auto Swan Glasses Hop",_G.AutoFarMonwanGlasses_Hop,function(value)
                 _G.AutoFarMonwanGlasses_Hop = value
             end)
             
             spawn(function()
                 pcall(function()
                     while wait(.1) do
                         if (_G.AutoFarMonwanGlasses and _G.AutoFarMonwanGlasses_Hop) and World2 and not game:GetService("ReplicatedStorage"):FindFirstChild("Don Swan [Boss]") and not game:GetService("Workspace").Enemies:FindFirstChild("Don Swan [Boss]") then
                             Hop()
                         end
                     end
                 end)
             end)
             
             Weapon:Seperator("「 Saber 」")
             
             Weapon:Toggle("Auto Saber",_G.AutoSaber,function(value)
                 _G.AutoSaber = value
                 StopTween(_G.AutoSaber)
             end)
             
             Weapon:Toggle("Auto Saber Hop",_G.AutoSaber_Hop,function(value)
                 _G.AutoSaber_Hop = value
             end)
             
             spawn(function()
                 while wait() do
                     if _G.AutoSaber then
                         pcall(function()
                             if game:GetService("Workspace").Enemies:FindFirstChild("Saber Expert [Boss]") then
                                 for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                     if v.Name == "Saber Expert [Boss]" then
                                         if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                             PosMonSaber = v.HumanoidRootPart.CFrame
                                             repeat task.wait()
                                                 AutoHaki()
                                                 EquipWeapon(_G.SelectWeapon)
                                                 v.HumanoidRootPart.CanCollide = false
                                                 v.Humanoid.WalkSpeed = 0
                                                 v.HumanoidRootPart.CFrame = PosMonSaber
                                                 topos(v.HumanoidRootPart.CFrame * CFrame.new(0,25,15))
                                                 v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                                 game:GetService("VirtualUser"):CaptureController()
                                                 game:GetService("VirtualUser"):Button1Down(Vector2.new(1280,672))
                                                 sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius",math.huge)
                                             until not _G.AutoSaber or not v.Parent or v.Humanoid.Health <= 0
                                         end
                                     end
                                 end
                             else
                                 if game:GetService("ReplicatedStorage"):FindFirstChild("Saber Expert [Boss]") then
                                     topos(game:GetService("ReplicatedStorage"):FindFirstChild("Saber Expert [Boss]").HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                 else
                                     if _G.AutoSaber_Hop then
                                         Hop()
                                     end
                                 end
                             end
                         end)
                     end
                 end
             end)
             
             Weapon:Seperator("「 Legendary Sword 」")
             
             Weapon:Toggle("Auto Legendary Sword",_G.AutoBuyLegendarySword,function(value)
                 _G.AutoBuyLegendarySword = value
             end)
             
             spawn(function()
                 while wait() do
                     if _G.AutoBuyLegendarySword then
                         pcall(function()
                             local args = {
                                 [1] = "LegendarySwordDealer",
                                 [2] = "1"
                             }
                             game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                             local args = {
                                 [1] = "LegendarySwordDealer",
                                 [2] = "2"
                             }
                             game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                             local args = {
                                 [1] = "LegendarySwordDealer",
                                 [2] = "3"
                             }
                             game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                             if _G.AutoBuyLegendarySword_Hop and _G.AutoBuyLegendarySword and World2 then
                                 wait(10)
                                 Hop()
                             end
                         end)
                     end 
                 end
             end)
             
             Weapon:Toggle("Auto Legendary Sword Hop",_G.AutoBuyLegendarySword_Hop,function(value)
                 _G.AutoBuyLegendarySword_Hop = value
             end)
             
             Weapon:Seperator("「 Enchancement Colour 」")
             
             Weapon:Toggle("Auto Enchancement Colour",_G.AutoBuyEnchancementColour,function(value)
                 _G.AutoBuyEnchancementColour = value
             end)
             
             Weapon:Toggle("Auto Enchancement Hop",_G.AutoBuyEnchancementColour_Hop,function(value)
                 _G.AutoBuyEnchancementColour_Hop = value
             end)
             
             spawn(function()
                 while wait() do
                     if _G.AutoBuyEnchancementColour then
                         local args = {
                             [1] = "ColorsDealer",
                             [2] = "2"
                         }
                         game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                         if _G.AutoBuyEnchancementColour_Hop and _G.AutoBuyEnchancementColour and not World1 then
                             wait(10)
                             Hop()
                         end
                     end 
                 end
             end)
             
         Weapon:Seperator("「 Auto Rengoko 」")
             
                 Weapon:Toggle("Auto Rengoku",_G.AutoRengoku,function(value)
                 _G.AutoRengoku = value
                 StopTween(_G.AutoRengoku)
             end)
             
             spawn(function()
                 pcall(function()
                     while wait() do
                         if _G.AutoRengoku then
                             if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Hidden Key") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Hidden Key") then
                                 EquipWeapon("Hidden Key")
                                 topos(CFrame.new(6571.1201171875, 299.23028564453, -6967.841796875))
                             elseif game:GetService("Workspace").Enemies:FindFirstChild("Snow Lurker") or game:GetService("Workspace").Enemies:FindFirstChild("Arctic Warrior") then
                                 for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                     if (v.Name == "Snow Lurker" or v.Name == "Arctic Warrior") and v.Humanoid.Health > 0 then
                                         repeat task.wait()
                                             EquipWeapon(_G.SelectWeapon)
                                             AutoHaki()
                                             v.HumanoidRootPart.CanCollide = false
                                             v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                             RengokuMon = v.HumanoidRootPart.CFrame
                                             topos(v.HumanoidRootPart.CFrame * CFrame.new(0,25,15))
                                             game:GetService'VirtualUser':CaptureController()
                                             game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                                             StartRengokuMagnet = true
                                         until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Hidden Key") or _G.AutoRengoku == false or not v.Parent or v.Humanoid.Health <= 0
                                         StartRengokuMagnet = false
                                     end
                                 end
                             else
                                 StartRengokuMagnet = false
                                 topos(CFrame.new(5439.716796875, 84.420944213867, -6715.1635742188))
                             end
                         end
                     end
                 end)
             end)
         Weapon:Seperator("「 Auto Yama 」")
             
             Weapon:Toggle("Auto Yama",_G.AutoYama,function(value)
                 _G.AutoYama = value
                 StopTween(_G.AutoYama)
             end)
             
             spawn(function()
                 while wait() do
                     if _G.AutoYama then
                         if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter","Progress") >= 30 then
                             repeat wait(.1)
                                 fireclickdetector(game:GetService("Workspace").Map.Waterfall.SealedKatana.Handle.ClickDetector)
                             until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Yama") or not _G.AutoYama
                         end
                     end
                 end
             end)
            
             Weapon:Line()
             Weapon:Seperator("「 Fighting Style 」")
             Weapon:Line()
             
             Weapon:Toggle("Auto Superhuman",_G.AutoSuperhuman,function(value)
                 _G.AutoSuperhuman = value
             end)
             
             spawn(function()
                 pcall(function()
                     while wait() do 
                         if _G.AutoSuperhuman then
                             if game.Players.LocalPlayer.Backpack:FindFirstChild("Combat") or game.Players.LocalPlayer.Character:FindFirstChild("Combat") and game:GetService("Players")["LocalPlayer"].Data.Beli.Value >= 150000 then
                                 UnEquipWeapon("Combat")
                                 wait(.1)
                                 game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBlackLeg")
                             end   
                             if game.Players.LocalPlayer.Character:FindFirstChild("Superhuman") or game.Players.LocalPlayer.Backpack:FindFirstChild("Superhuman") then
                                 _G.SelectWeapon = "Superhuman"
                             end  
                             if game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") or game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") or game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") or game.Players.LocalPlayer.Character:FindFirstChild("Electro") or game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate") or game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate") or game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw") or game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw") then
                                 if game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg").Level.Value <= 299 then
                                     _G.SelectWeapon = "Black Leg"
                                 end
                                 if game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") and game.Players.LocalPlayer.Backpack:FindFirstChild("Electro").Level.Value <= 299 then
                                     _G.SelectWeapon = "Electro"
                                 end
                                 if game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate") and game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate").Level.Value <= 299 then
                                     _G.SelectWeapon = "Fishman Karate"
                                 end
                                 if game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw") and game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw").Level.Value <= 299 then
                                     _G.SelectWeapon = "Dragon Claw"
                                 end
                                 if game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg").Level.Value >= 300 and game:GetService("Players")["LocalPlayer"].Data.Beli.Value >= 300000 then
                                     UnEquipWeapon("Black Leg")
                                     wait(.1)
                                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")
                                 end
                                 if game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 300 and game:GetService("Players")["LocalPlayer"].Data.Beli.Value >= 300000 then
                                     UnEquipWeapon("Black Leg")
                                     wait(.1)
                                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")
                                 end
                                 if game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") and game.Players.LocalPlayer.Backpack:FindFirstChild("Electro").Level.Value >= 300 and game:GetService("Players")["LocalPlayer"].Data.Beli.Value >= 750000 then
                                     UnEquipWeapon("Electro")
                                     wait(.1)
                                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyFishmanKarate")
                                 end
                                 if game.Players.LocalPlayer.Character:FindFirstChild("Electro") and game.Players.LocalPlayer.Character:FindFirstChild("Electro").Level.Value >= 300 and game:GetService("Players")["LocalPlayer"].Data.Beli.Value >= 750000 then
                                     UnEquipWeapon("Electro")
                                     wait(.1)
                                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyFishmanKarate")
                                 end
                                 if game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate") and game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate").Level.Value >= 300 and game:GetService("Players")["Localplayer"].Data.Fragments.Value >= 1500 then
                                     UnEquipWeapon("Fishman Karate")
                                     wait(.1)
                                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","1")
                                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","2") 
                                 end
                                 if game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate") and game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate").Level.Value >= 300 and game:GetService("Players")["Localplayer"].Data.Fragments.Value >= 1500 then
                                     UnEquipWeapon("Fishman Karate")
                                     wait(.1)
                                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","1")
                                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","2") 
                                 end
                                 if game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw") and game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw").Level.Value >= 300 and game:GetService("Players")["LocalPlayer"].Data.Beli.Value >= 3000000 then
                                     UnEquipWeapon("Dragon Claw")
                                     wait(.1)
                                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman")
                                 end
                                 if game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw") and game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw").Level.Value >= 300 and game:GetService("Players")["LocalPlayer"].Data.Beli.Value >= 3000000 then
                                     UnEquipWeapon("Dragon Claw")
                                     wait(.1)
                                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman")
                                 end 
                             end
                         end
                     end
                 end)
             end)
             
             Weapon:Toggle("Auto DeathStep",_G.AutoDeathStep,function(value)
                 _G.AutoDeathStep = value
             end)
             
             spawn(function()
                 while wait() do wait()
                     if _G.AutoDeathStep then
                         if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Black Leg") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Black Leg") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Death Step") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Death Step") then
                             if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Black Leg") and game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Black Leg").Level.Value >= 450 then
                                 game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep")
                                 _G.SelectWeapon = "Death Step"
                             end  
                             if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Black Leg") and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 450 then
                                 game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep")
                                 _G.SelectWeapon = "Death Step"
                             end  
                             if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Black Leg") and game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Black Leg").Level.Value <= 449 then
                                 _G.SelectWeapon = "Black Leg"
                             end 
                         else 
                             game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBlackLeg")
                         end
                     end
                 end
             end)
             
             Weapon:Toggle("Auto Sharkman Karate",_G.AutoSharkman,function(value)
                 _G.AutoSharkman = value
             end)
             
             spawn(function()
                 pcall(function()
                     while wait() do
                         if _G.AutoSharkman then
                             game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyFishmanKarate")
                             if string.find(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate"), "keys") then  
                                 if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Water Key") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Water Key") then
                                     topos(CFrame.new(-2604.6958, 239.432526, -10315.1982, 0.0425701365, 0, -0.999093413, 0, 1, 0, 0.999093413, 0, 0.0425701365))
                                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate")
                                 elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("Fishman Karate") and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Fishman Karate").Level.Value >= 400 then
                                 else 
                                     Mon = "Tide Keeper [Boss]"
                                     if game:GetService("Workspace").Enemies:FindFirstChild(Mon) then   
                                         for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                             if v.Name == Mon then    
                                                 OldCFrameShark = v.HumanoidRootPart.CFrame
                                                 repeat task.wait()
                                                     AutoHaki()
                                                     EquipWeapon(_G.SelectWeapon)
                                                     v.Head.CanCollide = false
                                                     v.Humanoid.WalkSpeed = 0
                                                     v.HumanoidRootPart.CanCollide = false
                                                     v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                                     v.HumanoidRootPart.CFrame = OldCFrameShark
                                                     topos(v.HumanoidRootPart.CFrame*CFrame.new(0,30,0))
                                                     game:GetService("VirtualUser"):CaptureController()
                                                     game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 670))
                                                     sethiddenproperty(game:GetService("Players").LocalPlayer,"SimulationRadius",math.huge)
                                                 until not v.Parent or v.Humanoid.Health <= 0 or _G.AutoSharkman == false or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Water Key") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Water Key")
                                             end
                                         end
                                     else
                                         topos(CFrame.new(-3570.18652, 123.328949, -11555.9072, 0.465199202, -1.3857326e-08, 0.885206044, 4.0332897e-09, 1, 1.35347511e-08, -0.885206044, -2.72606271e-09, 0.465199202))
                                         wait(3)
                                     end
                                 end
                             else 
                                 game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate")
                             end
                         end
                     end
                 end)
             end)
             
             Weapon:Toggle("Auto Electric Claw",_G.AutoElectricClaw,function(value)
                 _G.AutoElectricClaw = value
                 StopTween(_G.AutoElectricClaw)
             end)
             
             spawn(function()
                 pcall(function()
                     while wait() do 
                         if _G.AutoElectricClaw then
                             if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Electro") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Electro") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Electric Claw") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Electric Claw") then
                                 if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Electro") and game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Electro").Level.Value >= 400 then
                                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
                                     _G.SelectWeapon = "Electric Claw"
                                 end  
                                 if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Electro") and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Electro").Level.Value >= 400 then
                                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
                                     _G.SelectWeapon = "Electric Claw"
                                 end  
                                 if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Electro") and game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Electro").Level.Value <= 399 then
                                     _G.SelectWeapon = "Electro"
                                 end 
                             else
                                 game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")
                             end
                         end
                         if _G.AutoElectricClaw then
                             if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Electro") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Electro") then
                                 if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Electro") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Electro") and game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Electro").Level.Value >= 400 or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Electro").Level.Value >= 400 then
                                     if _G.AutoFarm == false then
                                         repeat task.wait()
                                             topos(CFrame.new(-10371.4717, 330.764496, -10131.4199))
                                         until not _G.AutoElectricClaw or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - CFrame.new(-10371.4717, 330.764496, -10131.4199).Position).Magnitude <= 10
                                         game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw","Start")
                                         wait(2)
                                         repeat task.wait()
                                             topos(CFrame.new(-12550.532226563, 336.22631835938, -7510.4233398438))
                                         until not _G.AutoElectricClaw or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - CFrame.new(-12550.532226563, 336.22631835938, -7510.4233398438).Position).Magnitude <= 10
                                         wait(1)
                                         repeat task.wait()
                                             topos(CFrame.new(-10371.4717, 330.764496, -10131.4199))
                                         until not _G.AutoElectricClaw or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - CFrame.new(-10371.4717, 330.764496, -10131.4199).Position).Magnitude <= 10
                                         wait(1)
                                         game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
                                     elseif _G.AutoFarm == true then
                                         _G.AutoFarm = false
                                         wait(1)
                                         repeat task.wait()
                                             topos(CFrame.new(-10371.4717, 330.764496, -10131.4199))
                                         until not _G.AutoElectricClaw or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - CFrame.new(-10371.4717, 330.764496, -10131.4199).Position).Magnitude <= 10
                                         game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw","Start")
                                         wait(2)
                                         repeat task.wait()
                                             topos(CFrame.new(-12550.532226563, 336.22631835938, -7510.4233398438))
                                         until not _G.AutoElectricClaw or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - CFrame.new(-12550.532226563, 336.22631835938, -7510.4233398438).Position).Magnitude <= 10
                                         wait(1)
                                         repeat task.wait()
                                             topos(CFrame.new(-10371.4717, 330.764496, -10131.4199))
                                         until not _G.AutoElectricClaw or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - CFrame.new(-10371.4717, 330.764496, -10131.4199).Position).Magnitude <= 10
                                         wait(1)
                                         game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
                                         _G.SelectWeapon = "Electric Claw"
                                         wait(.1)
                                         _G.AutoFarm = true
                                     end
                                 end
                             end
                         end
                     end
                 end)
             end)
             
             Weapon:Toggle("Auto Dragon Talon",_G.AutoDragonTalon,function(value)
                 _G.AutoDragonTalon = value
             end)
             
             spawn(function()
                 while wait() do
                     if _G.AutoDragonTalon then
                         if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dragon Claw") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dragon Claw") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dragon Talon") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dragon Talon") then
                             if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dragon Claw") and game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dragon Claw").Level.Value >= 400 then
                                 game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon")
                                 _G.SelectWeapon = "Dragon Talon"
                             end  
                             if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dragon Claw") and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dragon Claw").Level.Value >= 400 then
                                 game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon")
                                 _G.SelectWeapon = "Dragon Talon"
                             end  
                             if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dragon Claw") and game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dragon Claw").Level.Value <= 399 then
                                 _G.SelectWeapon = "Dragon Claw"
                             end 
                         else 
                             game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","2")
                         end
                     end
                 end
             end)
             
             Weapon:Seperator("「 Other 」")
             
             Weapon:Toggle("Auto Musketeer Hat",_G.AutoMusketeerHat,function(value)
                 _G.AutoMusketeerHat = value
                 StopTween(_G.AutoMusketeerHat)
             end)
             
             spawn(function()
                 pcall(function()
                     while wait(.1) do
                         if _G.AutoMusketeerHat then
                             if game:GetService("Players").LocalPlayer.Data.Level.Value >= 1800 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress").KilledBandits == false then
                                 if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Forest Pirate") and string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                                     if game:GetService("Workspace").Enemies:FindFirstChild("Forest Pirate") then
                                         for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                             if v.Name == "Forest Pirate" then
                                                 repeat task.wait()
                                                     pcall(function()
                                                         EquipWeapon(_G.SelectWeapon)
                                                         AutoHaki()
                                                         v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                                         topos(v.HumanoidRootPart.CFrame * CFrame.new(0,25,15))
                                                         v.HumanoidRootPart.CanCollide = false
                                                         game:GetService'VirtualUser':CaptureController()
                                                         game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                                                         MusketeerHatMon = v.HumanoidRootPart.CFrame
                                                         StartMagnetMusketeerhat = true
                                                     end)
                                                 until _G.AutoMusketeerHat == false or not v.Parent or v.Humanoid.Health <= 0 or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                                 StartMagnetMusketeerhat = false
                                             end
                                         end
                                     else
                                         StartMagnetMusketeerhat = false
                                         topos(CFrame.new(-13206.452148438, 425.89199829102, -7964.5537109375))
                                     end
                                 else
                                     topos(CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125))
                                     if (Vector3.new(-12443.8671875, 332.40396118164, -7675.4892578125) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
                                         wait(1.5)
                                         game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest","CitizenQuest",1)
                                     end
                                 end
                             elseif game:GetService("Players").LocalPlayer.Data.Level.Value >= 1800 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress").KilledBoss == false then
                                 if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible and string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") and game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                                     if game:GetService("Workspace").Enemies:FindFirstChild("Captain Elephant [Boss]") then
                                         for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                             if v.Name == "Captain Elephant [Boss]" then
                                                 OldCFrameElephant = v.HumanoidRootPart.CFrame
                                                 repeat task.wait()
                                                     pcall(function()
                                                         EquipWeapon(_G.SelectWeapon)
                                                         AutoHaki()
                                                         v.HumanoidRootPart.CanCollide = false
                                                         v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                                         topos(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                                         v.HumanoidRootPart.CanCollide = false
                                                         v.HumanoidRootPart.CFrame = OldCFrameElephant
                                                         game:GetService("VirtualUser"):CaptureController()
                                                         game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                                         sethiddenproperty(game:GetService("Players").LocalPlayer,"SimulationRadius",math.huge)
                                                     end)
                                                 until _G.AutoMusketeerHat == false or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                             end
                                         end
                                     else
                                         topos(CFrame.new(-13374.889648438, 421.27752685547, -8225.208984375))
                                     end
                                 else
                                     topos(CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125))
                                     if (CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 4 then
                                         wait(1.5)
                                         game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen")
                                     end
                                 end
                             elseif game:GetService("Players").LocalPlayer.Data.Level.Value >= 1800 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen") == 2 then
                                 topos(CFrame.new(-12512.138671875, 340.39279174805, -9872.8203125))
                             end
                         end
                     end
                 end)
             end)
             
             Weapon:Toggle("Auto Rainbow Haki",_G.Auto_Rainbow_Haki,function(value)
                 _G.Auto_Rainbow_Haki = value
                 StopTween(_G.Auto_Rainbow_Haki)
             end)
             
             spawn(function()
                 pcall(function()
                     while wait(.1) do
                         if _G.Auto_Rainbow_Haki then
                             if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                                 topos(CFrame.new(-11892.0703125, 930.57672119141, -8760.1591796875))
                                 if (Vector3.new(-11892.0703125, 930.57672119141, -8760.1591796875) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
                                     wait(1.5)
                                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("HornedMan","Bet")
                                 end
                             elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true and string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Stone") then
                                 if game:GetService("Workspace").Enemies:FindFirstChild("Stone [Boss]") then
                                     for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                         if v.Name == "Stone [Boss]" then
                                             OldCFrameRainbow = v.HumanoidRootPart.CFrame
                                             repeat task.wait()
                                                 EquipWeapon(_G.SelectWeapon)
                                                 topos(v.HumanoidRootPart.CFrame * CFrame.new(0,25,15))
                                                 v.HumanoidRootPart.CanCollide = false
                                                 v.HumanoidRootPart.CFrame = OldCFrameRainbow
                                                 v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                                 game:GetService("VirtualUser"):CaptureController()
                                                 game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                                 sethiddenproperty(game:GetService("Players").LocalPlayer,"SimulationRadius",math.huge)
                                             until _G.Auto_Rainbow_Haki == false or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                         end
                                     end
                                 else
                                     topos(CFrame.new(-1086.11621, 38.8425903, 6768.71436, 0.0231462717, -0.592676699, 0.805107772, 2.03251839e-05, 0.805323839, 0.592835128, -0.999732077, -0.0137055516, 0.0186523199))
                                 end
                             elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true and string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Island Empress") then
                                 if game:GetService("Workspace").Enemies:FindFirstChild("Island Empress [Boss]") then
                                     for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                         if v.Name == "Island Empress [Boss]" then
                                             OldCFrameRainbow = v.HumanoidRootPart.CFrame
                                             repeat task.wait()
                                                 EquipWeapon(_G.SelectWeapon)
                                                 topos(v.HumanoidRootPart.CFrame * CFrame.new(0,25,15))
                                                 v.HumanoidRootPart.CanCollide = false
                                                 v.HumanoidRootPart.CFrame = OldCFrameRainbow
                                                 v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                                 game:GetService("VirtualUser"):CaptureController()
                                                 game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                                 sethiddenproperty(game:GetService("Players").LocalPlayer,"SimulationRadius",math.huge)
                                             until _G.Auto_Rainbow_Haki == false or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                         end
                                     end
                                 else
                                     topos(CFrame.new(5713.98877, 601.922974, 202.751251, -0.101080291, -0, -0.994878292, -0, 1, -0, 0.994878292, 0, -0.101080291))
                                 end
                             elseif string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Kilo Admiral") then
                                 if game:GetService("Workspace").Enemies:FindFirstChild("Kilo Admiral [Boss]") then
                                     for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                         if v.Name == "Kilo Admiral [Boss]" then
                                             OldCFrameRainbow = v.HumanoidRootPart.CFrame
                                             repeat task.wait()
                                                 EquipWeapon(_G.SelectWeapon)
                                                 topos(v.HumanoidRootPart.CFrame * CFrame.new(0,25,15))
                                                 v.HumanoidRootPart.CanCollide = false
                                                 v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                                 v.HumanoidRootPart.CFrame = OldCFrameRainbow
                                                 game:GetService("VirtualUser"):CaptureController()
                                                 game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                                 sethiddenproperty(game:GetService("Players").LocalPlayer,"SimulationRadius",math.huge)
                                             until _G.Auto_Rainbow_Haki == false or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                         end
                                     end
                                 else
                                     topos(CFrame.new(2877.61743, 423.558685, -7207.31006, -0.989591599, -0, -0.143904909, -0, 1.00000012, -0, 0.143904924, 0, -0.989591479))
                                 end
                             elseif string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") then
                                 if game:GetService("Workspace").Enemies:FindFirstChild("Captain Elephant [Boss]") then
                                     for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                         if v.Name == "Captain Elephant [Boss]" then
                                             OldCFrameRainbow = v.HumanoidRootPart.CFrame
                                             repeat task.wait()
                                                 EquipWeapon(_G.SelectWeapon)
                                                 topos(v.HumanoidRootPart.CFrame * CFrame.new(0,25,15))
                                                 v.HumanoidRootPart.CanCollide = false
                                                 v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                                 v.HumanoidRootPart.CFrame = OldCFrameRainbow
                                                 game:GetService("VirtualUser"):CaptureController()
                                                 game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                                 sethiddenproperty(game:GetService("Players").LocalPlayer,"SimulationRadius",math.huge)
                                             until _G.Auto_Rainbow_Haki == false or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                         end
                                     end
                                 else
                                     topos(CFrame.new(-13485.0283, 331.709259, -8012.4873, 0.714521289, 7.98849911e-08, 0.69961375, -1.02065748e-07, 1, -9.94383065e-09, -0.69961375, -6.43015241e-08, 0.714521289))
                                 end
                             elseif string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Beautiful Pirate") then
                                 if game:GetService("Workspace").Enemies:FindFirstChild("Beautiful Pirate [Boss]") then
                                     for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                         if v.Name == "Beautiful Pirate [Boss]" then
                                             OldCFrameRainbow = v.HumanoidRootPart.CFrame
                                             repeat task.wait()
                                                 EquipWeapon(_G.SelectWeapon)
                                                 topos(v.HumanoidRootPart.CFrame * CFrame.new(0,25,15))
                                                 v.HumanoidRootPart.CanCollide = false
                                                 v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                                 v.HumanoidRootPart.CFrame = OldCFrameRainbow
                                                 game:GetService("VirtualUser"):CaptureController()
                                                 game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                                 sethiddenproperty(game:GetService("Players").LocalPlayer,"SimulationRadius",math.huge)
                                             until _G.Auto_Rainbow_Haki == false or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                         end
                                     end
                                 else
                                     topos(CFrame.new(5312.3598632813, 20.141201019287, -10.158538818359))
                                 end
                             else
                                 topos(CFrame.new(-11892.0703125, 930.57672119141, -8760.1591796875))
                                 if (Vector3.new(-11892.0703125, 930.57672119141, -8760.1591796875) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
                                     wait(1.5)
                                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("HornedMan","Bet")
                                 end
                             end
                         end
                     end
                 end)
             end)
             
             Weapon:Toggle("Auto Observation Haki v2",_G.AutoObservationv2,function(value)
                 _G.AutoObservationv2 = value
                 StopTween(_G.AutoObservationv2)
             end)
             
             spawn(function()
                 while wait() do
                     pcall(function()
                         if _G.AutoObservationv2 then
                             if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen") == 3 then
                                 _G.AutoMusketeerHat = false
                                 if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Banana") and  game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Apple") and game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Pineapple") then
                                     repeat 
                                         topos(CFrame.new(-12444.78515625, 332.40396118164, -7673.1806640625)) 
                                         wait() 
                                     until not _G.AutoObservationv2 or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-12444.78515625, 332.40396118164, -7673.1806640625)).Magnitude <= 10
                                     wait(.5)
                                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen")
                                 elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Fruit Bowl") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Fruit Bowl") then
                                     repeat 
                                         topos(CFrame.new(-10920.125, 624.20275878906, -10266.995117188)) 
                                         wait() 
                                     until not _G.AutoObservationv2 or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-10920.125, 624.20275878906, -10266.995117188)).Magnitude <= 10
                                     wait(.5)
                                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk2","Start")
                                     wait(1)
                                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk2","Buy")
                                 else
                                     for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
                                         if v.Name == "Apple" or v.Name == "Banana" or v.Name == "Pineapple" then
                                             v.Handle.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,1,10)
                                             wait()
                                             firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,v.Handle,0)    
                                             wait()
                                         end
                                     end   
                                 end
                             else
                                 _G.AutoMusketeerHat = true
                             end
                         end
                     end)
                 end
             end)
            
             
             
             Weapon:Toggle("Auto Evo Race",_G.Auto_EvoRace,function(value)
                 _G.Auto_EvoRace = value
                 StopTween(_G.Auto_EvoRace)
             end)
             
             spawn(function()
                 pcall(function()
                     while wait(.1) do
                         if _G.Auto_EvoRace then
                             if not game:GetService("Players").LocalPlayer.Data.Race:FindFirstChild("Evolved") then
                                 if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist","1") == 0 then
                                     topos(CFrame.new(-2779.83521, 72.9661407, -3574.02002, -0.730484903, 6.39014104e-08, -0.68292886, 3.59963224e-08, 1, 5.50667032e-08, 0.68292886, 1.56424669e-08, -0.730484903))
                                     if (Vector3.new(-2779.83521, 72.9661407, -3574.02002) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 4 then
                                         wait(1.3)
                                         game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist","2")
                                     end
                                 elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist","1") == 1 then
                                     pcall(function()
                                         if not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flower 1") and not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Flower 1") then
                                             topos(game:GetService("Workspace").Flower1.CFrame)
                                         elseif not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flower 2") and not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Flower 2") then
                                             topos(game:GetService("Workspace").Flower2.CFrame)
                                         elseif not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flower 3") and not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Flower 3") then
                                             if game:GetService("Workspace").Enemies:FindFirstChild("Zombie") then
                                                 for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                                     if v.Name == "Zombie" then
                                                         repeat task.wait()
                                                             AutoHaki()
                                                             EquipWeapon(_G.SelectWeapon)
                                                             topos(v.HumanoidRootPart.CFrame * CFrame.new(0,25,15))
                                                             v.HumanoidRootPart.CanCollide = false
                                                             v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                                             game:GetService("VirtualUser"):CaptureController()
                                                             game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                                             PosMonEvo = v.HumanoidRootPart.CFrame
                                                             StartEvoMagnet = true
                                                         until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flower 3") or not v.Parent or v.Humanoid.Health <= 0 or _G.Auto_EvoRace == false
                                                         StartEvoMagnet = false
                                                     end
                                                 end
                                             else
                                                 StartEvoMagnet = false
                                                 topos(CFrame.new(-5685.9233398438, 48.480125427246, -853.23724365234))
                                             end
                                         end
                                     end)
                                 elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist","1") == 2 then
                                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist","3")
                                 end
                             end
                         end
                     end
                 end)
             end)
             
             Weapon:Toggle("Auto Bartlio Quest",_G.AutoBartilo,function(value)
                 _G.AutoBartilo = value
             end)
             
             spawn(function()
                 pcall(function()
                     while wait(.1) do
                         if _G.AutoBartilo then
                             if game:GetService("Players").LocalPlayer.Data.Level.Value >= 800 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 0 then
                                 if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Swan Pirates") and string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then 
                                     if game:GetService("Workspace").Enemies:FindFirstChild("Swan Pirate") then
                                         Mon = "Swan Pirate"
                                         for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                             if v.Name == Mon then
                                                 pcall(function()
                                                     repeat task.wait()
                                                         sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                                         EquipWeapon(_G.SelectWeapon)
                                                         AutoHaki()
                                                         v.HumanoidRootPart.Transparency = 1
                                                         v.HumanoidRootPart.CanCollide = false
                                                         v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                                         topos(v.HumanoidRootPart.CFrame * CFrame.new(0,25,15))													
                                                         PosMonBarto =  v.HumanoidRootPart.CFrame
                                                         game:GetService'VirtualUser':CaptureController()
                                                         game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                                                         AutoBartiloBring = true
                                                     until not v.Parent or v.Humanoid.Health <= 0 or _G.AutoBartilo == false or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                                     AutoBartiloBring = false
                                                 end)
                                             end
                                         end
                                     else
                                         repeat topos(CFrame.new(932.624451, 156.106079, 1180.27466, -0.973085582, 4.55137119e-08, -0.230443969, 2.67024713e-08, 1, 8.47491108e-08, 0.230443969, 7.63147128e-08, -0.973085582)) wait() until not _G.AutoBartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(932.624451, 156.106079, 1180.27466, -0.973085582, 4.55137119e-08, -0.230443969, 2.67024713e-08, 1, 8.47491108e-08, 0.230443969, 7.63147128e-08, -0.973085582)).Magnitude <= 10
                                     end
                                 else
                                     repeat topos(CFrame.new(-456.28952, 73.0200958, 299.895966)) wait() until not _G.AutoBartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-456.28952, 73.0200958, 299.895966)).Magnitude <= 10
                                     wait(1.1)
                                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest","BartiloQuest",1)
                                 end 
                             elseif game:GetService("Players").LocalPlayer.Data.Level.Value >= 800 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 1 then
                                 if game:GetService("Workspace").Enemies:FindFirstChild("Jeremy [Boss]") then
                                     Mon = "Jeremy [Boss]"
                                     for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                         if v.Name == Mon then
                                             OldCFrameBartlio = v.HumanoidRootPart.CFrame
                                             repeat task.wait()
                                                 sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                                 EquipWeapon(_G.SelectWeapon)
                                                 AutoHaki()
                                                 v.HumanoidRootPart.Transparency = 1
                                                 v.HumanoidRootPart.CanCollide = false
                                                 v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                                 v.HumanoidRootPart.CFrame = OldCFrameBartlio
                                                 topos(v.HumanoidRootPart.CFrame * CFrame.new(0,25,15))
                                                 game:GetService'VirtualUser':CaptureController()
                                                 game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                                                 sethiddenproperty(game:GetService("Players").LocalPlayer,"SimulationRadius",math.huge)
                                             until not v.Parent or v.Humanoid.Health <= 0 or _G.AutoBartilo == false
                                         end
                                     end
                                 elseif game:GetService("ReplicatedStorage"):FindFirstChild("Jeremy [Boss]") then
                                     repeat topos(CFrame.new(-456.28952, 73.0200958, 299.895966)) wait() until not _G.AutoBartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-456.28952, 73.0200958, 299.895966)).Magnitude <= 10
                                     wait(1.1)
                                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo")
                                     wait(1)
                                     repeat topos(CFrame.new(2099.88159, 448.931, 648.997375)) wait() until not _G.AutoBartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(2099.88159, 448.931, 648.997375)).Magnitude <= 10
                                     wait(2)
                                 else
                                     repeat topos(CFrame.new(2099.88159, 448.931, 648.997375)) wait() until not _G.AutoBartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(2099.88159, 448.931, 648.997375)).Magnitude <= 10
                                 end
                             elseif game:GetService("Players").LocalPlayer.Data.Level.Value >= 800 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 2 then
                                 repeat topos(CFrame.new(-1850.49329, 13.1789551, 1750.89685)) wait() until not _G.AutoBartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-1850.49329, 13.1789551, 1750.89685)).Magnitude <= 10
                                 wait(1)
                                 repeat topos(CFrame.new(-1858.87305, 19.3777466, 1712.01807)) wait() until not _G.AutoBartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-1858.87305, 19.3777466, 1712.01807)).Magnitude <= 10
                                 wait(1)
                                 repeat topos(CFrame.new(-1803.94324, 16.5789185, 1750.89685)) wait() until not _G.AutoBartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-1803.94324, 16.5789185, 1750.89685)).Magnitude <= 10
                                 wait(1)
                                 repeat topos(CFrame.new(-1858.55835, 16.8604317, 1724.79541)) wait() until not _G.AutoBartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-1858.55835, 16.8604317, 1724.79541)).Magnitude <= 10
                                 wait(1)
                                 repeat topos(CFrame.new(-1869.54224, 15.987854, 1681.00659)) wait() until not _G.AutoBartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-1869.54224, 15.987854, 1681.00659)).Magnitude <= 10
                                 wait(1)
                                 repeat topos(CFrame.new(-1800.0979, 16.4978027, 1684.52368)) wait() until not _G.AutoBartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-1800.0979, 16.4978027, 1684.52368)).Magnitude <= 10
                                 wait(1)
                                 repeat topos(CFrame.new(-1819.26343, 14.795166, 1717.90625)) wait() until not _G.AutoBartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-1819.26343, 14.795166, 1717.90625)).Magnitude <= 10
                                 wait(1)
                                 repeat topos(CFrame.new(-1813.51843, 14.8604736, 1724.79541)) wait() until not _G.AutoBartilo or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-1813.51843, 14.8604736, 1724.79541)).Magnitude <= 10
                             end
                         end 
                     end
                 end)
             end)
             
             Weapon:Toggle("Auto Holy Torch",_G.AutoHolyTorch,function(value)
                 _G.AutoHolyTorch = value
                 StopTween(_G.AutoHolyTorch)
             end)
             
             spawn(function()
                 while wait() do
                     if _G.AutoHolyTorch then
                         pcall(function()
                             wait(1)
                             TP(CFrame.new(-10752, 417, -9366))
                             wait(1)
                             TP(CFrame.new(-11672, 334, -9474))
                             wait(1)
                             TP(CFrame.new(-12132, 521, -10655))
                             wait(1)
                             TP(CFrame.new(-13336, 486, -6985))
                             wait(1)
                             TP(CFrame.new(-13489, 332, -7925))
                         end)
                     end
                 end
             end)
             
             spawn(function()
                 while task.wait() do
                     pcall(function()
                         if _G.BringMonster then
                             CheckQuest()
                             for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                 if _G.AutoFarm and StartMagnet and v.Name == Mon and (Mon == "Factory Staff" or Mon == "Monkey" or Mon == "Dragon Crew Warrior" or Mon == "Dragon Crew Archer") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 220 then
                                     v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                     v.HumanoidRootPart.CFrame = PosMon
                                     v.Humanoid:ChangeState(14)
                                     v.HumanoidRootPart.CanCollide = false
                                     v.Head.CanCollide = false
                                     if v.Humanoid:FindFirstChild("Animator") then
                                         v.Humanoid.Animator:Destroy()
                                     end
                                     sethiddenproperty(game:GetService("Players").LocalPlayer,"SimulationRadius",math.huge)
                                 elseif _G.AutoFarm and StartMagnet and v.Name == Mon and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 275 then
                                     v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                     v.HumanoidRootPart.CFrame = PosMon
                                     v.Humanoid:ChangeState(14)
                                     v.HumanoidRootPart.CanCollide = false
                                     v.Head.CanCollide = false
                                     if v.Humanoid:FindFirstChild("Animator") then
                                         v.Humanoid.Animator:Destroy()
                                     end
                                     sethiddenproperty(game:GetService("Players").LocalPlayer,"SimulationRadius",math.huge)
                                 end
                                 if _G.AutoEctoplasm and StartEctoplasmMagnet then
                                     if string.find(v.Name, "Ship") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - EctoplasmMon.Position).Magnitude <= 250 then
                                         v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                         v.HumanoidRootPart.CFrame = EctoplasmMon
                                         v.Humanoid:ChangeState(14)
                                         v.HumanoidRootPart.CanCollide = false
                                         v.Head.CanCollide = false
                                         if v.Humanoid:FindFirstChild("Animator") then
                                             v.Humanoid.Animator:Destroy()
                                         end
                                         sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                     end
                                 end
                                 if _G.AutoRengoku and StartRengokuMagnet then
                                     if (v.Name == "Snow Lurker" or v.Name == "Arctic Warrior") and (v.HumanoidRootPart.Position - RengokuMon.Position).Magnitude <= 250 and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                         v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                         v.Humanoid:ChangeState(14)
                                         v.HumanoidRootPart.CanCollide = false
                                         v.Head.CanCollide = false
                                         v.HumanoidRootPart.CFrame = RengokuMon
                                         if v.Humanoid:FindFirstChild("Animator") then
                                             v.Humanoid.Animator:Destroy()
                                         end
                                         sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                     end
                                 end
                                 if _G.AutoMusketeerHat and StartMagnetMusketeerhat then
                                     if v.Name == "Forest Pirate" and (v.HumanoidRootPart.Position - MusketeerHatMon.Position).Magnitude <= 250 and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                         v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                         v.Humanoid:ChangeState(14)
                                         v.HumanoidRootPart.CanCollide = false
                                         v.Head.CanCollide = false
                                         v.HumanoidRootPart.CFrame = MusketeerHatMon
                                         if v.Humanoid:FindFirstChild("Animator") then
                                             v.Humanoid.Animator:Destroy()
                                         end
                                         sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                     end
                                 end
                                 if _G.Auto_EvoRace and StartEvoMagnet then
                                     if v.Name == "Zombie" and (v.HumanoidRootPart.Position - PosMonEvo.Position).Magnitude <= 250 and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                         v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                         v.Humanoid:ChangeState(14)
                                         v.HumanoidRootPart.CanCollide = false
                                         v.Head.CanCollide = false
                                         v.HumanoidRootPart.CFrame = PosMonEvo
                                         if v.Humanoid:FindFirstChild("Animator") then
                                             v.Humanoid.Animator:Destroy()
                                         end
                                         sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                     end
                                 end
                                 if _G.AutoBartilo and AutoBartiloBring then
                                     if v.Name == "Swan Pirate" and (v.HumanoidRootPart.Position - PosMonBarto.Position).Magnitude <= 250 and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                         v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                         v.Humanoid:ChangeState(14)
                                         v.HumanoidRootPart.CanCollide = false
                                         v.Head.CanCollide = false
                                         v.HumanoidRootPart.CFrame = PosMonBarto
                                         if v.Humanoid:FindFirstChild("Animator") then
                                             v.Humanoid.Animator:Destroy()
                                         end
                                         sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                     end
                                 end
                                 if _G.AutoFarmFruitMastery and StartMasteryFruitMagnet then
                                     if v.Name == "Monkey" then
                                         if (v.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= 250 and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                             v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                             v.Humanoid:ChangeState(14)
                                             v.HumanoidRootPart.CanCollide = false
                                             v.Head.CanCollide = false
                                             v.HumanoidRootPart.CFrame = PosMonMasteryFruit
                                             if v.Humanoid:FindFirstChild("Animator") then
                                                 v.Humanoid.Animator:Destroy()
                                             end
                                             sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                         end
                                     elseif v.Name == "Factory Staff" then
                                         if (v.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= 250 and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                             v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                             v.Humanoid:ChangeState(14)
                                             v.HumanoidRootPart.CanCollide = false
                                             v.Head.CanCollide = false
                                             v.HumanoidRootPart.CFrame = PosMonMasteryFruit
                                             if v.Humanoid:FindFirstChild("Animator") then
                                                 v.Humanoid.Animator:Destroy()
                                             end
                                             sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                         end
                                     elseif v.Name == Mon then
                                         if (v.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= 250 and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                             v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                             v.Humanoid:ChangeState(14)
                                             v.HumanoidRootPart.CanCollide = false
                                             v.Head.CanCollide = false
                                             v.HumanoidRootPart.CFrame = PosMonMasteryFruit
                                             if v.Humanoid:FindFirstChild("Animator") then
                                                 v.Humanoid.Animator:Destroy()
                                             end
                                             sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                         end
                                     end
                                 end
                                 if _G.AutoFarmGunMastery and StartMasteryGunMagnet then
                                     if v.Name == "Monkey" then
                                         if (v.HumanoidRootPart.Position - PosMonMasteryGun.Position).Magnitude <= 250 and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                             v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                             v.Humanoid:ChangeState(14)
                                             v.HumanoidRootPart.CanCollide = false
                                             v.Head.CanCollide = false
                                             v.HumanoidRootPart.CFrame = PosMonMasteryGun
                                             if v.Humanoid:FindFirstChild("Animator") then
                                                 v.Humanoid.Animator:Destroy()
                                             end
                                             sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                         end
                                     elseif v.Name == "Factory Staff" then
                                         if (v.HumanoidRootPart.Position - PosMonMasteryGun.Position).Magnitude <= 250 and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                             v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                             v.Humanoid:ChangeState(14)
                                             v.HumanoidRootPart.CanCollide = false
                                             v.Head.CanCollide = false
                                             v.HumanoidRootPart.CFrame = PosMonMasteryGun
                                             if v.Humanoid:FindFirstChild("Animator") then
                                                 v.Humanoid.Animator:Destroy()
                                             end
                                             sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                         end
                                     elseif v.Name == Mon then
                                         if (v.HumanoidRootPart.Position - PosMonMasteryGun.Position).Magnitude <= 250 and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                             v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                             v.Humanoid:ChangeState(14)
                                             v.HumanoidRootPart.CanCollide = false
                                             v.Head.CanCollide = false
                                             v.HumanoidRootPart.CFrame = PosMonMasteryGun
                                             if v.Humanoid:FindFirstChild("Animator") then
                                                 v.Humanoid.Animator:Destroy()
                                             end
                                             sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                         end
                                     end
                                 end
                                 if _G.Auto_Bone and StartMagnetBoneMon then
                                     if (v.Name == "Reborn Skeleton" or v.Name == "Living Zombie" or v.Name == "Demonic Soul" or v.Name == "Posessed Mummy") and (v.HumanoidRootPart.Position - PosMonBone.Position).Magnitude <= 250 and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                         v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                         v.Humanoid:ChangeState(14)
                                         v.HumanoidRootPart.CanCollide = false
                                         v.Head.CanCollide = false
                                         v.HumanoidRootPart.CFrame = PosMonBone
                                         if v.Humanoid:FindFirstChild("Animator") then
                                             v.Humanoid.Animator:Destroy()
                                         end
                                         sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                     end
                                 end
                                 if _G.AutoDoughtBoss and MagnetDought then
                                     if (v.Name == "Cookie Crafter" or v.Name == "Cake Guard" or v.Name == "Baking Staff" or v.Name == "Head Baker") and (v.HumanoidRootPart.Position - PosMonDoughtOpenDoor.Position).Magnitude <= 250 and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                         v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                         v.Humanoid:ChangeState(14)
                                         v.HumanoidRootPart.CanCollide = false
                                         v.Head.CanCollide = false
                                         v.HumanoidRootPart.CFrame = PosMonDoughtOpenDoor
                                         if v.Humanoid:FindFirstChild("Animator") then
                                             v.Humanoid.Animator:Destroy()
                                         end
                                         sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                     end
                                 end
                                 if _G.AutoCandy and StartMagnetCandy then
                                     if (v.HumanoidRootPart.Position - PosMonCandy.Position).Magnitude <= 250 and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                         v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                         v.Humanoid:ChangeState(14)
                                         v.HumanoidRootPart.CanCollide = false
                                         v.Head.CanCollide = false
                                         v.HumanoidRootPart.CFrame = PosMonCandy
                                         if v.Humanoid:FindFirstChild("Animator") then
                                             v.Humanoid.Animator:Destroy()
                                         end
                                         sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                     end
                                 end
                             end
                         end
                     end)
                 end
             end)
             
             Main:Seperator("「 Mastery 」")
             
             Main:Toggle("Auto Farm BF Mastery",_G.AutoFarmFruitMastery,function(value)
                 _G.AutoFarmFruitMastery = value
                 StopTween(_G.AutoFarmFruitMastery)
                 if _G.AutoFarmFruitMastery == false then
                     UseSkill = false 
                 end
             end)
             
             spawn(function()
                 while wait() do
                     if _G.AutoFarmFruitMastery then
                         pcall(function()
                             local QuestTitle = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
                             if not string.find(QuestTitle, NameMon) then
                                 Magnet = false
                                 UseSkill = false
                                 game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                             end
                             if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                                 StartMasteryFruitMagnet = false
                                 UseSkill = false
                                 CheckQuest()
                                 repeat wait()
                                     topos(CFrameQuest)
                                 until (CFrameQuest.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not _G.AutoFarmFruitMastery
                                 if (CFrameQuest.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 then
                                     wait(1.2)
                                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest",NameQuest,LevelQuest)
                                     wait(0.5)
                                 end
                             elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                                 CheckQuest()
                                 if game:GetService("Workspace").Enemies:FindFirstChild(Mon) then
                                     for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                         if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                             if v.Name == Mon then
                                                 if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) then
                                                     HealthMon = v.Humanoid.MaxHealth * _G.Kill_At/100
                                                     repeat task.wait()
                                                         if v.Humanoid.Health <= HealthMon then
                                                             AutoHaki()
                                                             EquipWeapon(game:GetService("Players").LocalPlayer.Data.DevilFruit.Value)
                                                             topos(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                                             v.HumanoidRootPart.CanCollide = false
                                                             PosMonMasteryFruit = v.HumanoidRootPart.CFrame
                                                             v.Humanoid.WalkSpeed = 0
                                                             v.Head.CanCollide = false
                                                             UseSkill = true
                                                         else           
                                                             UseSkill = false 
                                                             AutoHaki()
                                                             EquipWeapon(_G.SelectWeapon)
                                                             topos(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                                             v.HumanoidRootPart.CanCollide = false
                                                             v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                                             PosMonMasteryFruit = v.HumanoidRootPart.CFrame
                                                             v.Humanoid.WalkSpeed = 0
                                                             v.Head.CanCollide = false
                                                         end
                                                         StartMasteryFruitMagnet = true
                                                         game:GetService'VirtualUser':CaptureController()
                                                         game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                                                     until not _G.AutoFarmFruitMastery or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                                 else
                                                     UseSkill = false
                                                     StartMasteryFruitMagnet = false
                                                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                                                 end
                                             end
                                         end
                                     end
                                 else
                                     StartMasteryFruitMagnet = false   
                                     UseSkill = false 
                                     local Mob = game:GetService("ReplicatedStorage"):FindFirstChild(Mon) 
                                     if Mob then
                                         topos(Mob.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                     else
                                         if game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Y <= 1 then
                                             game:GetService("Players").LocalPlayer.Character.Humanoid.Jump = true
                                             task.wait()
                                             game:GetService("Players").LocalPlayer.Character.Humanoid.Jump = false
                                         end
                                     end
                                 end
                             end
                         end)
                     end
                 end
             end)
             
             spawn(function()
                 while wait() do
                     if UseSkill then
                         pcall(function()
                             CheckQuest()
                             for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                 if game:GetService("Players").LocalPlayer.Character:FindFirstChild(game:GetService("Players").LocalPlayer.Data.DevilFruit.Value) then
                                     MasBF = game:GetService("Players").LocalPlayer.Character[game:GetService("Players").LocalPlayer.Data.DevilFruit.Value].Level.Value
                                 elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(game:GetService("Players").LocalPlayer.Data.DevilFruit.Value) then
                                     MasBF = game:GetService("Players").LocalPlayer.Backpack[game:GetService("Players").LocalPlayer.Data.DevilFruit.Value].Level.Value
                                 end
                                 if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dragon-Dragon") then                      
                                     if _G.SkillZ then
                                         local args = {
                                             [1] = PosMonMasteryFruit.Position
                                         }
                                         game:GetService("Players").LocalPlayer.Character[game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args))                        
                                         game:GetService("VirtualInputManager"):SendKeyEvent(true,"Z",false,game)
                                         game:GetService("VirtualInputManager"):SendKeyEvent(false,"Z",false,game)
                                     end
                                     if _G.SkillX then          
                                         local args = {
                                             [1] = PosMonMasteryFruit.Position
                                         }
                                         game:GetService("Players").LocalPlayer.Character[game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args))               
                                         game:GetService("VirtualInputManager"):SendKeyEvent(true,"X",false,game)
                                         game:GetService("VirtualInputManager"):SendKeyEvent(false,"X",false,game)
                                     end
                                     if _G.SkillC then
                                         local args = {
                                             [1] = PosMonMasteryFruit.Position
                                         }
                                         game:GetService("Players").LocalPlayer.Character[game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args))                          
                                         game:GetService("VirtualInputManager"):SendKeyEvent(true,"C",false,game)
                                         wait(2)
                                         game:GetService("VirtualInputManager"):SendKeyEvent(false,"C",false,game)
                                     end
                                 elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("Venom-Venom") then   
                                     if _G.SkillZ then
                                         local args = {
                                             [1] = PosMonMasteryFruit.Position
                                         }
                                         game:GetService("Players").LocalPlayer.Character[game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args))                        
                                         game:GetService("VirtualInputManager"):SendKeyEvent(true,"Z",false,game)
                                         game:GetService("VirtualInputManager"):SendKeyEvent(false,"Z",false,game)
                                     end
                                     if _G.SkillX then        
                                         local args = {
                                             [1] = PosMonMasteryFruit.Position
                                         }
                                         game:GetService("Players").LocalPlayer.Character[game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args))               
                                         game:GetService("VirtualInputManager"):SendKeyEvent(true,"X",false,game)
                                         game:GetService("VirtualInputManager"):SendKeyEvent(false,"X",false,game)
                                     end
                                     if _G.SkillC then 
                                         local args = {
                                             [1] = PosMonMasteryFruit.Position
                                         }
                                         game:GetService("Players").LocalPlayer.Character[game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args))                          
                                         game:GetService("VirtualInputManager"):SendKeyEvent(true,"C",false,game)
                                         wait(2)
                                         game:GetService("VirtualInputManager"):SendKeyEvent(false,"C",false,game)
                                     end
                                 elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("Human-Human: Buddha") then
                                     if _G.SkillZ and game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Size == Vector3.new(2, 2.0199999809265, 1) then
                                         local args = {
                                             [1] = PosMonMasteryFruit.Position
                                         }
                                         game:GetService("Players").LocalPlayer.Character[game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args))                         
                                         game:GetService("VirtualInputManager"):SendKeyEvent(true,"Z",false,game)
                                         game:GetService("VirtualInputManager"):SendKeyEvent(false,"Z",false,game)
                                     end
                                     if _G.SkillX then
                                         local args = {
                                             [1] = PosMonMasteryFruit.Position
                                         }
                                         game:GetService("Players").LocalPlayer.Character[game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args))                           
                                         game:GetService("VirtualInputManager"):SendKeyEvent(true,"X",false,game)
                                         game:GetService("VirtualInputManager"):SendKeyEvent(false,"X",false,game)
                                     end
                                     if _G.SkillC then
                                         local args = {
                                             [1] = PosMonMasteryFruit.Position
                                         }
                                         game:GetService("Players").LocalPlayer.Character[game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args))                           
                                         game:GetService("VirtualInputManager"):SendKeyEvent(true,"C",false,game)
                                         game:GetService("VirtualInputManager"):SendKeyEvent(false,"C",false,game)
                                     end
                                     if _G.SkillV then
                                         local args = {
                                             [1] = PosMonMasteryFruit.Position
                                         }
                                         game:GetService("Players").LocalPlayer.Character[game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args))
                                         game:GetService("VirtualInputManager"):SendKeyEvent(true,"V",false,game)
                                         game:GetService("VirtualInputManager"):SendKeyEvent(false,"V",false,game)
                                     end
                                 elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild(game:GetService("Players").LocalPlayer.Data.DevilFruit.Value) then
                                     if _G.SkillZ then 
                                         local args = {
                                             [1] = PosMonMasteryFruit.Position
                                         }
                                         game:GetService("Players").LocalPlayer.Character[game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args))                         
                                         game:GetService("VirtualInputManager"):SendKeyEvent(true,"Z",false,game)
                                         game:GetService("VirtualInputManager"):SendKeyEvent(false,"Z",false,game)
                                     end
                                     if _G.SkillX then
                                         local args = {
                                             [1] = PosMonMasteryFruit.Position
                                         }
                                         game:GetService("Players").LocalPlayer.Character[game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args))                           
                                         game:GetService("VirtualInputManager"):SendKeyEvent(true,"X",false,game)
                                         game:GetService("VirtualInputManager"):SendKeyEvent(false,"X",false,game)
                                     end
                                     if _G.SkillC then
                                         local args = {
                                             [1] = PosMonMasteryFruit.Position
                                         }
                                         game:GetService("Players").LocalPlayer.Character[game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args))                           
                                         game:GetService("VirtualInputManager"):SendKeyEvent(true,"C",false,game)
                                         game:GetService("VirtualInputManager"):SendKeyEvent(false,"C",false,game)
                                     end
                                     if _G.SkillV then
                                         local args = {
                                             [1] = PosMonMasteryFruit.Position
                                         }
                                         game:GetService("Players").LocalPlayer.Character[game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteEvent:FireServer(unpack(args))
                                         game:GetService("VirtualInputManager"):SendKeyEvent(true,"V",false,game)
                                         game:GetService("VirtualInputManager"):SendKeyEvent(false,"V",false,game)
                                     end
                                 end
                             end
                         end)
                     end
                 end
             end)
             
             spawn(function()
                 game:GetService("RunService").RenderStepped:Connect(function()
                     pcall(function()
                         if UseSkill then
                             for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Notifications:GetChildren()) do
                                 if v.Name == "NotificationTemplate" then
                                     if string.find(v.Text,"Skill locked!") then
                                         v:Destroy()
                                     end
                                 end
                             end
                         end
                     end)
                 end)
             end)
             
             spawn(function()
                 pcall(function()
                     game:GetService("RunService").RenderStepped:Connect(function()
                         if UseSkill then
                             local args = {
                                 [1] = PosMonMasteryFruit.Position
                             }
                             game:GetService("Players").LocalPlayer.Character[game:GetService("Players").LocalPlayer.Data.DevilFruit.Value].RemoteEvent:FireServer(unpack(args))
                         end
                     end)
                 end)
             end)
             
             Main:Toggle("Auto Farm Gun Mastery",_G.AutoFarmGunMastery,function(value)
                 _G.AutoFarmGunMastery = value
                 StopTween(_G.AutoFarmGunMastery)
             end)
             
             spawn(function()
                 pcall(function()
                     while wait() do
                         if _G.AutoFarmGunMastery then
                             local QuestTitle = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
                             if not string.find(QuestTitle, NameMon) then
                                 Magnet = false                                      
                                 game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                             end
                             if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                                 StartMasteryGunMagnet = false
                                 CheckQuest()
                                 topos(CFrameQuest)
                                 if (CFrameQuest.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                                     wait(1.2)
                                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest, LevelQuest)
                                 end
                             elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                                 CheckQuest()
                                 if game:GetService("Workspace").Enemies:FindFirstChild(Mon) then
                                     pcall(function()
                                         for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                             if v.Name == Mon then
                                                 repeat task.wait()
                                                     if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) then
                                                         HealthMin = v.Humanoid.MaxHealth * _G.Kill_At/100
                                                         if v.Humanoid.Health <= HealthMin then                                                
                                                             EquipWeapon(SelectWeaponGun)
                                                             topos(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                                             v.Humanoid.WalkSpeed = 0
                                                             v.HumanoidRootPart.CanCollide = false
                                                             v.HumanoidRootPart.Size = Vector3.new(2,2,1)
                                                             v.Head.CanCollide = false                                                
                                                             local args = {
                                                                 [1] = v.HumanoidRootPart.Position,
                                                                 [2] = v.HumanoidRootPart
                                                             }
                                                             game:GetService("Players").LocalPlayer.Character[SelectWeaponGun].RemoteFunctionShoot:InvokeServer(unpack(args))
                                                         else
                                                             AutoHaki()
                                                             EquipWeapon(_G.SelectWeapon)
                                                             v.Humanoid.WalkSpeed = 0
                                                             v.HumanoidRootPart.CanCollide = false
                                                             v.Head.CanCollide = false               
                                                             v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                                             topos(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                                             game:GetService'VirtualUser':CaptureController()
                                                             game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                                                         end
                                                         StartMasteryGunMagnet = true 
                                                         PosMonMasteryGun = v.HumanoidRootPart.CFrame
                                                     else
                                                         StartMasteryGunMagnet = false
                                                         game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                                                     end
                                                 until v.Humanoid.Health <= 0 or _G.AutoFarmGunMastery == false or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                                 StartMasteryGunMagnet = false
                                             end
                                         end
                                     end)
                                 else
                                     StartMasteryGunMagnet = false
                                     local Mob = game:GetService("ReplicatedStorage"):FindFirstChild(Mon) 
                                     if Mob then
                                         topos(Mob.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                     else
                                         if game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Y <= 1 then
                                             game:GetService("Players").LocalPlayer.Character.Humanoid.Jump = true
                                             task.wait()
                                             game:GetService("Players").LocalPlayer.Character.Humanoid.Jump = false
                                         end
                                     end
                                 end 
                             end
                         end
                     end
                 end)
             end)
             
             _G.Kill_At = 25
             Main:Slider("Kill At %",1,100,25,function(value)
                 _G.Kill_At = value
             end)
             
         function CheckBossQuest()
             if First_Sea then
                 if SelectBoss == "The Gorilla King [Boss]" then
                     BossMon = "The Gorilla King [Boss]"
                     NameQuestBoss = "JungleQuest"
                     LevelQuestBoss = 3
                     RewardBoss = "Reward:\n$2,000\n7,000 Exp."
                     CFrameQuestBoss = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
                     CFrameBoss = CFrame.new(-1088.75977, 8.13463783, -488.559906, -0.707134247, 0, 0.707079291, 0, 1, 0, -0.707079291, 0, -0.707134247)
                 elseif SelectBoss == "Bobby [Boss]" then
                     BossMon = "Bobby [Boss]"
                     NameQuestBoss = "BuggyQuest1"
                     LevelQuestBoss = 3
                     RewardBoss = "Reward:\n$8,000\n35,000 Exp."
                     CFrameQuestBoss = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)
                     CFrameBoss = CFrame.new(-1087.3760986328, 46.949409484863, 4040.1462402344)
                 elseif SelectBoss == "The Saw [Boss]" then
                     BossMon = "The Saw [Boss]"
                     CFrameBoss = CFrame.new(-784.89715576172, 72.427383422852, 1603.5822753906)
                 elseif SelectBoss == "Yeti [Boss]" then
                     BossMon = "Yeti [Boss]"
                     NameQuestBoss = "SnowQuest"
                     LevelQuestBoss = 3
                     RewardBoss = "Reward:\n$10,000\n180,000 Exp."
                     CFrameQuestBoss = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
                     CFrameBoss = CFrame.new(1218.7956542969, 138.01184082031, -1488.0262451172)
                 elseif SelectBoss == "Mob Leader [Boss]" then
                     BossMon = "Mob Leader [Boss]"
                     CFrameBoss = CFrame.new(-2844.7307128906, 7.4180502891541, 5356.6723632813)
                 elseif SelectBoss == "Vice Admiral [Boss]" then
                     BossMon = "Vice Admiral [Boss]"
                     NameQuestBoss = "MarineQuest2"
                     LevelQuestBoss = 2
                     RewardBoss = "Reward:\n$10,000\n180,000 Exp."
                     CFrameQuestBoss = CFrame.new(-5036.2465820313, 28.677835464478, 4324.56640625)
                     CFrameBoss = CFrame.new(-5006.5454101563, 88.032081604004, 4353.162109375)
                 elseif SelectBoss == "Saber Expert [Boss]" then
                     BossMon = "Saber Expert [Boss]"
                     CFrameBoss = CFrame.new(-1458.89502, 29.8870335, -50.633564)
                 elseif SelectBoss == "Warden [Boss]" then
                     BossMon = "Warden [Boss]"
                     NameQuestBoss = "ImpelQuest"
                     LevelQuestBoss = 1
                     RewardBoss = "Reward:\n$6,000\n850,000 Exp."
                     CFrameBoss = CFrame.new(5278.04932, 2.15167475, 944.101929, 0.220546961, -4.49946401e-06, 0.975376427, -1.95412576e-05, 1, 9.03162072e-06, -0.975376427, -2.10519756e-05, 0.220546961)
                     CFrameQuestBoss= CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635)
                 elseif SelectBoss == "Chief Warden [Boss]" then
                     BossMon = "Chief Warden [Boss]"
                     NameQuestBoss = "ImpelQuest"
                     LevelQuestBoss = 2
                     RewardBoss = "Reward:\n$10,000\n1,000,000 Exp."
                     CFrameBoss = CFrame.new(5206.92578, 0.997753382, 814.976746, 0.342041343, -0.00062915677, 0.939684749, 0.00191645394, 0.999998152, -2.80422337e-05, -0.939682961, 0.00181045406, 0.342041939)
                     CFrameQuestBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635)
                 elseif SelectBoss == "Swan [Boss]" then
                     BossMon = "Swan [Boss]"
                     NameQuestBoss = "ImpelQuest"
                     LevelQuestBoss = 3
                     RewardBoss = "Reward:\n$15,000\n1,600,000 Exp."
                     CFrameBoss = CFrame.new(5325.09619, 7.03906584, 719.570679, -0.309060812, 0, 0.951042235, 0, 1, 0, -0.951042235, 0, -0.309060812)
                     CFrameQuestBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635)
                 elseif SelectBoss == "Magma Admiral [Boss]" then
                     BossMon = "Magma Admiral [Boss]"
                     NameQuestBoss = "MagmaQuest"
                     LevelQuestBoss = 3
                     RewardBoss = "Reward:\n$15,000\n2,800,000 Exp."
                     CFrameQuestBoss = CFrame.new(-5314.6220703125, 12.262420654297, 8517.279296875)
                     CFrameBoss = CFrame.new(-5765.8969726563, 82.92064666748, 8718.3046875)
                 elseif SelectBoss == "Fishman Lord [Boss]" then
                     BossMon = "Fishman Lord [Boss]"
                     NameQuestBoss = "FishmanQuest"
                     LevelQuestBoss = 3
                     RewardBoss = "Reward:\n$15,000\n4,000,000 Exp."
                     CFrameQuestBoss = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
                     CFrameBoss = CFrame.new(61260.15234375, 30.950881958008, 1193.4329833984)
                 elseif SelectBoss == "Wysper [Boss]" then
                     BossMon = "Wysper [Boss]"
                     NameQuestBoss = "SkyExp1Quest"
                     LevelQuestBoss = 3
                     RewardBoss = "Reward:\n$15,000\n4,800,000 Exp."
                     CFrameQuestBoss = CFrame.new(-7861.947265625, 5545.517578125, -379.85974121094)
                     CFrameBoss = CFrame.new(-7866.1333007813, 5576.4311523438, -546.74816894531)
                 elseif SelectBoss == "Thunder God [Boss]" then
                     BossMon = "Thunder God [Boss]"
                     NameQuestBoss = "SkyExp2Quest"
                     LevelQuestBoss = 3
                     RewardBoss = "Reward:\n$20,000\n5,800,000 Exp."
                     CFrameQuestBoss = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125)
                     CFrameBoss = CFrame.new(-7994.984375, 5761.025390625, -2088.6479492188)
                 elseif SelectBoss == "Cyborg [Boss]" then
                     BossMon = "Cyborg [Boss]"
                     NameQuestBoss = "FountainQuest"
                     LevelQuestBoss = 3
                     RewardBoss = "Reward:\n$20,000\n7,500,000 Exp."
                     CFrameQuestBoss = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
                     CFrameBoss = CFrame.new(6094.0249023438, 73.770050048828, 3825.7348632813)
                 elseif SelectBoss == "Ice Admiral [Boss]" then
                     BossMon = "Ice Admiral [Boss]"
                     CFrameBoss = CFrame.new(1266.08948, 26.1757946, -1399.57678, -0.573599219, 0, -0.81913656, 0, 1, 0, 0.81913656, 0, -0.573599219)
                     
                 elseif SelectBoss == "Greybeard" then
                     BossMon = "Greybeard"
                     CFrameBoss = CFrame.new(-5081.3452148438, 85.221641540527, 4257.3588867188)
                 end
             end
             if Second_Sea then
                 if SelectBoss == "Diamond [Boss]" then
                     BossMon = "Diamond [Boss]"
                     NameQuestBoss = "Area1Quest"
                     LevelQuestBoss = 3
                     RewardBoss = "Reward:\n$25,000\n9,000,000 Exp."
                     CFrameQuestBoss = CFrame.new(-427.5666809082, 73.313781738281, 1835.4208984375)
                     CFrameBoss = CFrame.new(-1576.7166748047, 198.59265136719, 13.724286079407)
                 elseif SelectBoss == "Jeremy [Boss]" then
                     BossMon = "Jeremy [Boss]"
                     NameQuestBoss = "Area2Quest"
                     LevelQuestBoss = 3
                     RewardBoss = "Reward:\n$25,000\n11,500,000 Exp."
                     CFrameQuestBoss = CFrame.new(636.79943847656, 73.413787841797, 918.00415039063)
                     CFrameBoss = CFrame.new(2006.9261474609, 448.95666503906, 853.98284912109)
                 elseif SelectBoss == "Fajita [Boss]" then
                     BossMon = "Fajita [Boss]"
                     NameQuestBoss = "MarineQuest3"
                     LevelQuestBoss = 3
                     RewardBoss = "Reward:\n$25,000\n15,000,000 Exp."
                     CFrameQuestBoss = CFrame.new(-2441.986328125, 73.359344482422, -3217.5324707031)
                     CFrameBoss = CFrame.new(-2172.7399902344, 103.32216644287, -4015.025390625)
                 elseif SelectBoss == "Don Swan [Boss]" then
                     BossMon = "Don Swan [Boss]"
                     CFrameBoss = CFrame.new(2286.2004394531, 15.177839279175, 863.8388671875)
                 elseif SelectBoss == "Smoke Admiral [Boss]" then
                     BossMon = "Smoke Admiral [Boss]"
                     NameQuestBoss = "IceSideQuest"
                     LevelQuestBoss = 3
                     RewardBoss = "Reward:\n$20,000\n25,000,000 Exp."
                     CFrameQuestBoss = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813)
                     CFrameBoss = CFrame.new(-5275.1987304688, 20.757257461548, -5260.6669921875)
                 elseif SelectBoss == "Awakened Ice Admiral [Boss]" then
                     BossMon = "Awakened Ice Admiral [Boss]"
                     NameQuestBoss = "FrostQuest"
                     LevelQuestBoss = 3
                     RewardBoss = "Reward:\n$20,000\n36,000,000 Exp."
                     CFrameQuestBoss = CFrame.new(5668.9780273438, 28.519989013672, -6483.3520507813)
                     CFrameBoss = CFrame.new(6403.5439453125, 340.29766845703, -6894.5595703125)
                 elseif SelectBoss == "Tide Keeper [Boss]" then
                     BossMon = "Tide Keeper [Boss]"
                     NameQuestBoss = "ForgottenQuest"
                     LevelQuestBoss = 3
                     RewardBoss = "Reward:\n$12,500\n38,000,000 Exp."
                     CFrameQuestBoss = CFrame.new(-3053.9814453125, 237.18954467773, -10145.0390625)
                     CFrameBoss = CFrame.new(-3795.6423339844, 105.88877105713, -11421.307617188)
                 elseif SelectBoss == "Darkbeard" then
                     BossMon = "Darkbeard"
                     CFrameMon = CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531)
                 elseif SelectBoss == "Cursed Captain" then
                     BossMon = "Cursed Captain"
                     CFrameBoss = CFrame.new(916.928589, 181.092773, 33422)
                 elseif SelectBoss == "Order" then
                     BossMon = "Order"
                     CFrameBoss = CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875)
                 end
             end
             if Third_Sea then
                 if SelectBoss == "Stone [Boss]" then
                     BossMon = "Stone [Boss]"
                     NameQuestBoss = "PiratePortQuest"
                     LevelQuestBoss = 3
                     RewardBoss = "Reward:\n$25,000\n40,000,000 Exp."
                     CFrameQuestBoss = CFrame.new(-289.76705932617, 43.819011688232, 5579.9384765625)
                     CFrameBoss = CFrame.new(-1027.6512451172, 92.404174804688, 6578.8530273438)
                 elseif SelectBoss == "Island Empress [Boss]" then
                     BossMon = "Island Empress [Boss]"
                     NameQuestBoss = "AmazonQuest2"
                     LevelQuestBoss = 3
                     RewardBoss = "Reward:\n$30,000\n52,000,000 Exp."
                     CFrameQuestBoss = CFrame.new(5445.9541015625, 601.62945556641, 751.43792724609)
                     CFrameBoss = CFrame.new(5543.86328125, 668.97399902344, 199.0341796875)
                 elseif SelectBoss == "Kilo Admiral [Boss]" then
                     BossMon = "Kilo Admiral [Boss]"
                     NameQuestBoss = "MarineTreeIsland"
                     LevelQuestBoss = 3
                     RewardBoss = "Reward:\n$35,000\n56,000,000 Exp."
                     CFrameQuestBoss = CFrame.new(2179.3010253906, 28.731239318848, -6739.9741210938)
                     CFrameBoss = CFrame.new(2764.2233886719, 432.46154785156, -7144.4580078125)
                 elseif SelectBoss == "Captain Elephant [Boss]" then
                     BossMon = "Captain Elephant [Boss]"
                     NameQuestBoss = "DeepForestIsland"
                     LevelQuestBoss = 3
                     RewardBoss = "Reward:\n$40,000\n67,000,000 Exp."
                     CFrameQuestBoss = CFrame.new(-13232.682617188, 332.40396118164, -7626.01171875)
                     CFrameBoss = CFrame.new(-13376.7578125, 433.28689575195, -8071.392578125)
                 elseif SelectBoss == "Beautiful Pirate [Boss]" then
                     BossMon = "Beautiful Pirate [Boss]"
                     NameQuestBoss = "DeepForestIsland2"
                     LevelQuestBoss = 3
                     RewardBoss = "Reward:\n$50,000\n70,000,000 Exp."
                     CFrameQuestBoss = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
                     CFrameBoss = CFrame.new(5283.609375, 22.56223487854, -110.78285217285)
                 elseif SelectBoss == "Cake Queen [Boss]" then
                     BossMon = "Cake Queen [Boss]"
                     NameQuestBoss = "IceCreamIslandQuest"
                     LevelQuestBoss = 3
                     RewardBoss = "Reward:\n$30,000\n112,500,000 Exp."
                     CFrameQuestBoss = CFrame.new(-819.376709, 64.9259796, -10967.2832, -0.766061664, 0, 0.642767608, 0, 1, 0, -0.642767608, 0, -0.766061664)
                     CFrameBoss = CFrame.new(-678.648804, 381.353943, -11114.2012, -0.908641815, 0.00149294338, 0.41757378, 0.00837114919, 0.999857843, 0.0146408929, -0.417492568, 0.0167988986, -0.90852499)
                 elseif SelectBoss == "Longma [Boss]" then
                     BossMon = "Longma [Boss]"
                     CFrameBoss = CFrame.new(-10238.875976563, 389.7912902832, -9549.7939453125)
                 elseif SelectBoss == "Soul Reaper" then
                     BossMon = "Soul Reaper"
                     CFrameBoss = CFrame.new(-9524.7890625, 315.80429077148, 6655.7192382813)
                 elseif SelectBoss == "rip_indra True Form" then
                     BossMon = "rip_indra True Form"
                     CFrameBoss = CFrame.new(-5415.3920898438, 505.74133300781, -2814.0166015625)
                 end
             end
         end
         Main:Seperator("「 Mastery Skill 」")
             
             Main:Toggle("Skill Z",true,function(value)
                 _G.SkillZ = value
             end)
             
             Main:Toggle("Skill X",true,function(value)
                 _G.SkillX = value
             end)
             
             Main:Toggle("Skill C",true,function(value)
                 _G.SkillC = value
             end)
             
             Main:Toggle("Skill V",true,function(value)
                 _G.SkillV = value
             end)
             
             
             Main:Seperator("「 Bosses 」")
             
             local Boss = {}
             
             for i, v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
                 if string.find(v.Name, "Boss") then
                     if v.Name == "Ice Admiral [Boss]" then
                         else
                         table.insert(Boss, v.Name)
                     end
                 end
             end
             
             local BossName = Main:Dropdown("Select Boss",Boss,function(value)
                 _G.SelectBoss = value
             end)
             
             Main:Button("Refresh Boss",function()
                 BossName:Clear()
                     for i, v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
                     if string.find(v.Name, "Boss") then
                         BossName:Add(v.Name) 
                     end
                 end
             end)
             
             Main:Toggle("Auto Farm Boss",_G.AutoFarmBoss,function(value)
              CheckBossQuest()
             if AutoBossQuest == false then
                 wait(1)
                 topos(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
             end
                 game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                 _G.AutoFarmBoss = value
                 StopTween(_G.AutoFarmBoss)
             end)
             
           Main:Toggle("Auto Farm All Boss",_G.AutoAllBoss,function(value)
                 _G.AutoAllBoss = value
                 StopTween(_G.AutoAllBoss)
             end)
             
             Main:Toggle("Auto Farm All Boss Hop",_G.AutoAllBossHop,function(value)
                 _G.AutoAllBossHop = value
             end)
             
             spawn(function()
                 while wait() do
                     if _G.AutoAllBoss then
                         pcall(function()
                             for i,v in pairs(game.ReplicatedStorage:GetChildren()) do
                                 if string.find(v.Name,"Boss") then
                                     if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 17000 then
                                         repeat task.wait()
                                             AutoHaki()
                                             EquipWeapon(_G.SelectWeapon)
                                             v.Humanoid.WalkSpeed = 0
                                             v.HumanoidRootPart.CanCollide = false
                                             v.Head.CanCollide = false
                                             v.HumanoidRootPart.Size = Vector3.new(80,80,80)
                                             topos(v.HumanoidRootPart.CFrame*CFrame.new(2,20,2))
                                             game:GetService'VirtualUser':CaptureController()
                                             game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                                             sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius",math.huge)
                                         until v.Humanoid.Health <= 0 or _G.AutoAllBoss == false or not v.Parent
                                     end
                                 else
                                     if _G.AutoAllBossHop then
                                         Hop()
                                     end
                                 end
                             end
                         end)
                     end
                 end
             end)
             
             spawn(function()
                 while wait() do
                     if _G.AutoFarmBoss then
                         pcall(function()
                             if game:GetService("Workspace").Enemies:FindFirstChild(_G.SelectBoss) then
                                 for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                     if v.Name == _G.SelectBoss then
                                         if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                             repeat task.wait()
                                                 AutoHaki()
                                                 EquipWeapon(_G.SelectWeapon)
                                                 v.HumanoidRootPart.CanCollide = false
                                                 v.Humanoid.WalkSpeed = 0
                                                 v.HumanoidRootPart.Size = Vector3.new(80,80,80)                             
                                                 topos(v.HumanoidRootPart.CFrame * CFrame.new(2,10,5))
                                                 game:GetService("VirtualUser"):CaptureController()
                                                 game:GetService("VirtualUser"):Button1Down(Vector2.new(1280,672))
                                                 sethiddenproperty(game:GetService("Players").LocalPlayer,"SimulationRadius",math.huge)
                                             until not _G.AutoFarmBoss or not v.Parent or v.Humanoid.Health <= 0
                                         end
                                     end
                                 end
                             else
                                 if game:GetService("ReplicatedStorage"):FindFirstChild(_G.SelectBoss) then
                                     topos(game:GetService("ReplicatedStorage"):FindFirstChild(_G.SelectBoss).HumanoidRootPart.CFrame * CFrame.new(5,10,2))
                                 end
                             end
                         end)
                     end
                 end
             end)
         spawn(function()
                 while wait() do
                     if _G.AutoAllBoss then
                         pcall(function()
                             for i,v in pairs(game.ReplicatedStorage:GetChildren()) do
                                 if string.find(v.Name,"Boss") then
                                     if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 17000 then
                                         repeat task.wait()
                                             AutoHaki()
                                             EquipWeapon(_G.SelectWeapon)
                                             v.Humanoid.WalkSpeed = 0
                                             v.HumanoidRootPart.CanCollide = false
                                             v.Head.CanCollide = false
                                             v.HumanoidRootPart.Size = Vector3.new(80,80,80)
                                             topos(v.HumanoidRootPart.CFrame*CFrame.new(2,20,2))
                                             game:GetService'VirtualUser':CaptureController()
                                             game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                                             sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius",math.huge)
                                         until v.Humanoid.Health <= 0 or _G.AutoAllBoss == false or not v.Parent
                                     end
                                 else
                                     if _G.AutoAllBossHop then
                                         Hop()
                                     end
                                 end
                             end
                         end)
                     end
                 end
             end)
             
             Main:Seperator("「 Observation 」")
             
             local ObservationRange = Main:Label("")
             
             spawn(function()
                 while wait() do
                     pcall(function()
                         ObservationRange:Set("Observation Range Level : "..math.floor(game:GetService("Players").LocalPlayer.VisionRadius.Value))
                     end)
                 end
             end)
             
             Main:Toggle("Auto Farm Observation",_G.AutoObservation,function(value)
                 _G.AutoObservation = value
                 StopTween(_G.AutoObservation)
             end)
             
             spawn(function()
                 while wait() do
                     pcall(function()
                         if _G.AutoObservation then
                             repeat task.wait()
                                 if not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
                                     game:GetService('VirtualUser'):CaptureController()
                                     game:GetService('VirtualUser'):SetKeyDown('0x65')
                                     wait(2)
                                     game:GetService('VirtualUser'):SetKeyUp('0x65')
                                 end
                             until game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") or not _G.AutoObservation
                         end
                     end)
                 end
             end)
             
             Main:Toggle("Auto Farm Observation Hop",_G.AutoObservation_Hop,function(value)
                 _G.AutoObservation_Hop = value
             end)
             
             spawn(function()
                 pcall(function()
                     while wait() do
                         if _G.AutoObservation then
                             if game:GetService("Players").LocalPlayer.VisionRadius.Value >= 3000 then
                                 game:GetService("StarterGui"):SetCore("SendNotification", {
                                     Icon = "rbxassetid://0";
                                     Title = "Observation", 
                                     Text = "You Have Max Points"
                                 })
                                 wait(2)
                             else
                                 if World2 then
                                     if game:GetService("Workspace").Enemies:FindFirstChild("Lava Pirate") then
                                         if game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
                                             repeat task.wait()
                                                 game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Enemies:FindFirstChild("Lava Pirate").HumanoidRootPart.CFrame * CFrame.new(3,0,0)
                                             until _G.AutoObservation == false or not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
                                         else
                                             repeat task.wait()
                                                 game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Enemies:FindFirstChild("Lava Pirate").HumanoidRootPart.CFrame * CFrame.new(0,50,0)+
                                                     wait(1)
                                                 if not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") and _G.AutoObservation_Hop == true then
                                                     game:GetService("TeleportService"):Teleport(game.PlaceId,game:GetService("Players").LocalPlayer)
                                                 end
                                             until _G.AutoObservation == false or game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
                                         end
                                     else
                                         topos(CFrame.new(-5478.39209, 15.9775667, -5246.9126))
                                     end
                                 elseif World1 then
                                     if game:GetService("Workspace").Enemies:FindFirstChild("Galley Captain") then
                                         if game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
                                             repeat task.wait()
                                                 game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Enemies:FindFirstChild("Galley Captain").HumanoidRootPart.CFrame * CFrame.new(3,0,0)
                                             until _G.AutoObservation == false or not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
                                         else
                                             repeat task.wait()
                                                 game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Enemies:FindFirstChild("Galley Captain").HumanoidRootPart.CFrame * CFrame.new(0,50,0)
                                                 wait(1)
                                                 if not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") and _G.AutoObservation_Hop == true then
                                                     game:GetService("TeleportService"):Teleport(game.PlaceId,game:GetService("Players").LocalPlayer)
                                                 end
                                             until _G.AutoObservation == false or game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
                                         end
                                     else
                                         topos(CFrame.new(5533.29785, 88.1079102, 4852.3916))
                                     end
                                 elseif World3 then
                                     if game:GetService("Workspace").Enemies:FindFirstChild("Giant Islander") then
                                         if game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
                                             repeat task.wait()
                                                 game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Enemies:FindFirstChild("Giant Islander").HumanoidRootPart.CFrame * CFrame.new(3,0,0)
                                             until _G.AutoObservation == false or not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
                                         else
                                             repeat task.wait()
                                                 game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Enemies:FindFirstChild("Giant Islander").HumanoidRootPart.CFrame * CFrame.new(0,50,0)
                                                 wait(1)
                                                 if not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") and _G.AutoObservation_Hop == true then
                                                     game:GetService("TeleportService"):Teleport(game.PlaceId,game:GetService("Players").LocalPlayer)
                                                 end
                                             until _G.AutoObservation == false or game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
                                         end
                                     else
                                         topos(CFrame.new(4530.3540039063, 656.75695800781, -131.60952758789))
                                     end
                                 end
                             end
                         end
                     end
                 end)
             end)
             
                  Main:Seperator("「 Law Boss 」")
             
             Main:Toggle("Auto Law Boss", _G.AutoOderSword,function(value)
                  _G.AutoOderSword = value
                 StopTween( _G.AutoOderSword)
             end)
             
             Main:Toggle("Auto Law Boss Hop", _G.AutoOderSwordHop,function(value)
                  _G.AutoOderSwordHop = value
             end)
             
             spawn(function()
                 while wait() do
                     if  _G.AutoOderSword then
                         pcall(function()
                             if game:GetService("Workspace").Enemies:FindFirstChild("Order") then
                                 for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                     if v.Name == "Order" then
                                         if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                             repeat task.wait()
                                                 AutoHaki()
                                                 EquipWeapon(_G.SelectWeapon)
                                                 v.HumanoidRootPart.CanCollide = false
                                                 v.Humanoid.WalkSpeed = 0
                                                 v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                                 topos(v.HumanoidRootPart.CFrame * CFrame.new(2,20,2))
                                                 game:GetService("VirtualUser"):CaptureController()
                                                 game:GetService("VirtualUser"):Button1Down(Vector2.new(1280,672))
                                                 sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius",math.huge)
                                             until not  _G.AutoOderSword or not v.Parent or v.Humanoid.Health <= 0
                                         end
                                     end
                                 end
                             else
                                 if game:GetService("ReplicatedStorage"):FindFirstChild("Order") then
                                     topos(game:GetService("ReplicatedStorage"):FindFirstChild("Order").HumanoidRootPart.CFrame * CFrame.new(2,20,2))
                                 else
                                     if  _G.AutoOderSwordHop then
                                         Hop()
                                     end
                                 end
                             end
                         end)
                     end
                 end
             end)
             
             Main:Button("Buy Microchip Law Boss",function()
             local args = {
                [1] = "BlackbeardReward",
                [2] = "Microchip",
                [3] = "2"
             }
             game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
         end)
         
             Main:Button("Start Go To Raid Law Boss",function()
                 if World2 then
                     fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
                 end
             end)
             
             Weapon:Seperator("「 Advance Dungeon 」")
             
             Weapon:Toggle("Auto Advance Dungeon",_G.AutoAdvanceDungeon,function(value)
                 _G.AutoAdvanceDungeon = value
                 StopTween(_G.AutoAdvanceDungeon)
             end)
             
             spawn(function()
                 while wait() do
                     if _G.AutoAdvanceDungeon then
                         pcall(function()
                             if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Bird-Bird: Phoenix") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Bird-Bird: Phoenix") then
                                 if game.Players.LocalPlayer.Backpack:FindFirstChild(game.Players.LocalPlayer.Data.DevilFruit.Value) then
                                     if game.Players.LocalPlayer.Backpack:FindFirstChild(game.Players.LocalPlayer.Data.DevilFruit.Value).Level.Value >= 400 then
                                         topos(CFrame.new(-2812.76708984375, 254.803466796875, -12595.560546875))
                                         if (CFrame.new(-2812.76708984375, 254.803466796875, -12595.560546875).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                                             wait(1.5)
                                             game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SickScientist","Check")
                                             game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SickScientist","Heal")
                                         end
                                     end
                                 elseif game.Players.LocalPlayer.Character:FindFirstChild(game.Players.LocalPlayer.Data.DevilFruit.Value) then
                                     if game.Players.LocalPlayer.Character:FindFirstChild(game.Players.LocalPlayer.Data.DevilFruit.Value).Level.Value >= 400 then
                                         topos(CFrame.new(-2812.76708984375, 254.803466796875, -12595.560546875))
                                         if (CFrame.new(-2812.76708984375, 254.803466796875, -12595.560546875).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                                             wait(1.5)
                                             game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SickScientist","Check")
                                             game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SickScientist","Heal")
                                         end
                                     end
                                 end
                             end
                         end)
                     end
                 end
             end)
