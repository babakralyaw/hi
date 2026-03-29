--[[
RYSA CHEAT - NEVERLOSE LIBRARY
Menü: End tuşu
]]

if game.CoreGui:FindFirstChild("Library") then
    game.CoreGui:FindFirstChild("Library"):Destroy()
end

local VLib = {RainbowColorValue = 0, HueSelectionPosition = 0}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()

coroutine.wrap(function()
    while wait() do
        VLib.RainbowColorValue = VLib.RainbowColorValue + 1 / 255
        VLib.HueSelectionPosition = VLib.HueSelectionPosition + 1

        if VLib.RainbowColorValue >= 1 then
            VLib.RainbowColorValue = 0
        end

        if VLib.HueSelectionPosition == 80 then
            VLib.HueSelectionPosition = 0
        end
    end
end)()

local function MakeDraggable(topbarobject, object)
    local Dragging = nil
    local DragInput = nil
    local DragStart = nil
    local StartPosition = nil

    local function Update(input)
        local Delta = input.Position - DragStart
        local pos = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
        local Tween = TweenService:Create(object, TweenInfo.new(0.2), {Position = pos})
        Tween:Play()
    end

    topbarobject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            DragStart = input.Position
            StartPosition = object.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    Dragging = false
                end
            end)
        end
    end)

    topbarobject.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            DragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == DragInput and Dragging then
            Update(input)
        end
    end)
end

local Library = Instance.new("ScreenGui")
Library.Name = "Library"
Library.Parent = game.CoreGui
Library.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local uitoggled = false
UserInputService.InputBegan:Connect(function(io, p)
    if io.KeyCode == Enum.KeyCode.End then
        if uitoggled == false then
            Library.Enabled = false
            uitoggled = true
        else
            Library.Enabled = true
            uitoggled = false
        end
    end
end)

function VLib:Window(text, textgame, textcircle)
    local FirstTab = false
    local MainFrame = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")
    local LeftFrame = Instance.new("Frame")
    local LeftFrameCorner = Instance.new("UICorner")
    local MainTitle = Instance.new("TextLabel")
    local Circle = Instance.new("Frame")
    local CircleCorner = Instance.new("UICorner")
    local CircleName = Instance.new("TextLabel")
    local GameTitle = Instance.new("TextLabel")
    local TabHolder = Instance.new("Frame")
    local TabHoldLayout = Instance.new("UIListLayout")
    local RainbowLine = Instance.new("Frame")
    local RainbowLineCorner = Instance.new("UICorner")
    local ContainerHold = Instance.new("Folder")
    local DragFrame = Instance.new("Frame")
    local Glow = Instance.new("ImageLabel")

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = Library
    MainFrame.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
    MainFrame.Position = UDim2.new(0.5, -325, 0.5, -250)
    MainFrame.Size = UDim2.new(0, 650, 0, 500)

    MainCorner.CornerRadius = UDim.new(0, 5)
    MainCorner.Name = "MainCorner"
    MainCorner.Parent = MainFrame

    LeftFrame.Name = "LeftFrame"
    LeftFrame.Parent = MainFrame
    LeftFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    LeftFrame.Position = UDim2.new(-0.000674468291, 0, -0.000149806539, 0)
    LeftFrame.Size = UDim2.new(0, 190, 0, 500)

    LeftFrameCorner.CornerRadius = UDim.new(0, 5)
    LeftFrameCorner.Name = "LeftFrameCorner"
    LeftFrameCorner.Parent = LeftFrame

    MainTitle.Name = "MainTitle"
    MainTitle.Parent = LeftFrame
    MainTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MainTitle.BackgroundTransparency = 1.000
    MainTitle.Position = UDim2.new(0.168, 0, 0.043, 0)
    MainTitle.Size = UDim2.new(0, 71, 0, 20)
    MainTitle.Font = Enum.Font.Gotham
    MainTitle.Text = text
    MainTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    MainTitle.TextSize = 25.000
    MainTitle.TextXAlignment = Enum.TextXAlignment.Left

    GameTitle.Name = "GameTitle"
    GameTitle.Parent = LeftFrame
    GameTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    GameTitle.BackgroundTransparency = 1.000
    GameTitle.Position = UDim2.new(0.168, 0, 0.089, 6)
    GameTitle.Size = UDim2.new(0, 71, 0, 20)
    GameTitle.Font = Enum.Font.Gotham
    GameTitle.Text = textgame
    GameTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    GameTitle.TextSize = 17.000
    GameTitle.TextTransparency = 0.400
    GameTitle.TextXAlignment = Enum.TextXAlignment.Left

    TabHolder.Name = "TabHolder"
    TabHolder.Parent = LeftFrame
    TabHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabHolder.BackgroundTransparency = 1.000
    TabHolder.Position = UDim2.new(0.0806451589, 0, 0.189360261, 0)
    TabHolder.Size = UDim2.new(0, 159, 0, 309)

    TabHoldLayout.Name = "TabHoldLayout"
    TabHoldLayout.Parent = TabHolder
    TabHoldLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabHoldLayout.Padding = UDim.new(0, 5)

    ContainerHold.Name = "ContainerHold"
    ContainerHold.Parent = MainFrame

    DragFrame.Name = "DragFrame"
    DragFrame.Parent = MainFrame
    DragFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DragFrame.BackgroundTransparency = 1.000
    DragFrame.Position = UDim2.new(0.30130294, 0, 0.00253164559, 0)
    DragFrame.Size = UDim2.new(0, 428, 0, 21)

    Glow.Name = "Glow"
    Glow.Parent = LeftFrame
    Glow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Glow.BackgroundTransparency = 1.000
    Glow.BorderSizePixel = 0
    Glow.Position = UDim2.new(0, -15, 0, -15)
    Glow.Size = UDim2.new(1, 30, 1, 30)
    Glow.ZIndex = 0
    Glow.Image = "rbxassetid://4996891970"
    Glow.ImageColor3 = Color3.fromRGB(15, 15, 15)
    Glow.ScaleType = Enum.ScaleType.Slice
    Glow.SliceCenter = Rect.new(20, 20, 280, 280)

    MakeDraggable(DragFrame, MainFrame)

    local Tabs = {}
    function Tabs:Tab(text)
        local Tab = Instance.new("TextButton")
        local TabCorner = Instance.new("UICorner")
        local Title = Instance.new("TextLabel")
        local UIGradient = Instance.new('UIGradient')
        Tab.Name = "Tab"
        Tab.Parent = TabHolder
        Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Tab.Size = UDim2.new(0, 170, 0, 35)
        Tab.AutoButtonColor = false
        Tab.Font = Enum.Font.SourceSans
        Tab.Text = ""
        Tab.TextColor3 = Color3.fromRGB(0, 0, 0)
        Tab.TextSize = 15.000
        Tab.BackgroundTransparency = 1

        UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(160, 207, 236)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(102, 152, 255))}
        UIGradient.Parent = Tab

        TabCorner.CornerRadius = UDim.new(0, 3)
        TabCorner.Name = "TabCorner"
        TabCorner.Parent = Tab

        Title.Name = "Title"
        Title.Parent = Tab
        Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Title.BackgroundTransparency = 1.000
        Title.Position = UDim2.new(0.0566037744, 0, 0.1, 0)
        Title.Size = UDim2.new(0, 150, 0, 29)
        Title.Font = Enum.Font.Gotham
        Title.Text = text
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.TextSize = 17.000
        Title.TextXAlignment = Enum.TextXAlignment.Left

        local Container = Instance.new("ScrollingFrame")
        local ContainerLayout = Instance.new("UIListLayout")

        Container.Name = "Container"
        Container.Parent = ContainerHold
        Container.Active = true
        Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Container.BackgroundTransparency = 1.000
        Container.BorderSizePixel = 0
        Container.Position = UDim2.new(0.34, 0, 0.0506329127, 0)
        Container.Size = UDim2.new(0, 420, 0, 450)
        Container.ScrollBarThickness = 5
        Container.CanvasSize = UDim2.new(0, 0, 0, 0)
        Container.Visible = false
        Container.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)

        ContainerLayout.Name = "ContainerLayout"
        ContainerLayout.Parent = Container
        ContainerLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ContainerLayout.Padding = UDim.new(0, 15)

        if FirstTab == false then
            FirstTab = true
            Tab.BackgroundTransparency = 0
            Container.Visible = true
        end
        Tab.MouseButton1Click:Connect(function()
            for i, v in next, ContainerHold:GetChildren() do
                if v.Name == "Container" then
                    v.Visible = false
                end
            end

            for i, v in next, TabHolder:GetChildren() do
                if v.ClassName == "TextButton" then
                    TweenService:Create(
                        v,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundTransparency = 1}
                    ):Play()
                    TweenService:Create(
                        Tab,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundTransparency = 0}
                    ):Play()
                end
            end
            Container.Visible = true
        end)
        local ContainerItems = {}
        function ContainerItems:Button(text, callback)
            local Button = Instance.new("TextButton")
            local ButtonCorner = Instance.new("UICorner")

            Button.Name = "Button"
            Button.Parent = Container
            Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Button.Size = UDim2.new(0, 405, 0, 40)
            Button.AutoButtonColor = false
            Button.Font = Enum.Font.Gotham
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextSize = 15.000
            Button.Text = text

            ButtonCorner.CornerRadius = UDim.new(0, 5)
            ButtonCorner.Name = "ButtonCorner"
            ButtonCorner.Parent = Button

            Button.MouseEnter:Connect(function()
                TweenService:Create(
                    Button,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad),
                    {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}
                ):Play()
            end)
            Button.MouseLeave:Connect(function()
                TweenService:Create(
                    Button,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad),
                    {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}
                ):Play()
            end)

            Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)

            Button.MouseButton1Click:Connect(function()
                pcall(callback)
                Button.TextSize = 0
                TweenService:Create(Button, TweenInfo.new(.2, Enum.EasingStyle.Quad), {TextSize = 17}):Play()
                wait(.2)
                TweenService:Create(Button, TweenInfo.new(.2, Enum.EasingStyle.Quad), {TextSize = 14}):Play()
            end)
        end
        function ContainerItems:Toggle(text, Default, callback)
            local Toggled = Default or false
            local Toggle = Instance.new("TextButton")
            local ToggleCorner = Instance.new("UICorner")
            local Title = Instance.new("TextLabel")
            local ToggleFrame = Instance.new("Frame")
            local ToggleFrameCorner = Instance.new("UICorner")
            local ToggleDot = Instance.new("Frame")
            local ToggleDotCorner = Instance.new("UICorner")
            local UIGradient_2 = Instance.new('UIGradient')
            Toggle.Name = "Toggle"
            Toggle.Parent = Container
            Toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Toggle.Size = UDim2.new(0, 405, 0, 40)
            Toggle.AutoButtonColor = false
            Toggle.Font = Enum.Font.Gotham
            Toggle.Text = ""
            Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
            Toggle.TextSize = 14.000

            ToggleCorner.CornerRadius = UDim.new(0, 5)
            ToggleCorner.Name = "ToggleCorner"
            ToggleCorner.Parent = Toggle

            Title.Name = "Title"
            Title.Parent = Toggle
            Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title.BackgroundTransparency = 1.000
            Title.Position = UDim2.new(0.0198511165, 0, 0, 0)
            Title.Size = UDim2.new(0, 430, 0, 40)
            Title.Font = Enum.Font.Gotham
            Title.Text = text
            Title.TextColor3 = Color3.fromRGB(255, 255, 255)
            Title.TextSize = 15.000
            Title.TextXAlignment = Enum.TextXAlignment.Left

            ToggleFrame.Name = "ToggleFrame"
            ToggleFrame.Parent = Toggle
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(22, 23, 27)
            ToggleFrame.Position = UDim2.new(0.88, 0, 0.21, 0)
            ToggleFrame.Size = UDim2.new(0, 40, 0, 22)

            ToggleFrameCorner.CornerRadius = UDim.new(1, 0)
            ToggleFrameCorner.Name = "ToggleFrameCorner"
            ToggleFrameCorner.Parent = ToggleFrame

            ToggleDot.Name = "ToggleDot"
            ToggleDot.Parent = ToggleFrame
            ToggleDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleDot.Position = UDim2.new(0.104999997, -3, 0.289000005, -4)
            ToggleDot.Size = UDim2.new(0, 16, 0, 16)

            UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(160, 207, 236)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(102, 152, 255))}
            UIGradient_2.Parent = ToggleDot

            ToggleDotCorner.CornerRadius = UDim.new(1, 0)
            ToggleDotCorner.Name = "ToggleDotCorner"
            ToggleDotCorner.Parent = ToggleDot

            Toggle.MouseEnter:Connect(function()
                TweenService:Create(
                    Toggle,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad),
                    {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}
                ):Play()
            end)
            Toggle.MouseLeave:Connect(function()
                TweenService:Create(
                    Toggle,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad),
                    {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}
                ):Play()
            end)

            if Toggled == true then
                UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(160, 207, 236)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(102, 152, 255))}
                TweenService:Create(
                    ToggleFrame,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad),
                    {BackgroundTransparency = 0}
                ):Play()
                TweenService:Create(
                    ToggleDot,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad),
                    {Position = UDim2.new(0.595, -3, 0.289000005, -4)}
                ):Play()
                pcall(callback, Toggled)
            else
                TweenService:Create(
                    ToggleFrame,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad),
                    {BackgroundTransparency = 1}
                ):Play()
                TweenService:Create(
                    ToggleDot,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad),
                    {Position = UDim2.new(0.104999997, -3, 0.289000005, -4)}
                ):Play()
            end

            Toggle.MouseButton1Click:Connect(function()
                if Toggled == false then
                    UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(160, 207, 236)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(102, 152, 255))}
                    TweenService:Create(
                        ToggleFrame,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad),
                        {BackgroundTransparency = 0}
                    ):Play()
                    TweenService:Create(
                        ToggleDot,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad),
                        {Position = UDim2.new(0.595, -3, 0.289000005, -4)}
                    ):Play()
                else
                    TweenService:Create(
                        ToggleFrame,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad),
                        {BackgroundTransparency = 1}
                    ):Play()
                    TweenService:Create(
                        ToggleDot,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad),
                        {Position = UDim2.new(0.104999997, -3, 0.289000005, -4)}
                    ):Play()
                end
                Toggled = not Toggled
                pcall(callback, Toggled)
            end)

            Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
        end
        return ContainerItems
    end
    return Tabs
end

local Rysa = VLib:Window("RYSA", "CHEAT", "")

local Home = Rysa:Tab("Home")
Home:Button("Test Button", function()
    print("Test")
end)
Home:Toggle("Test Toggle", false, function(state)
    print("Toggle:", state)
end)

print("✅ RYSA CHEAT - BAŞLANDI")
print("Menü: End tuşu")
