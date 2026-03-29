-- don't judge :rage:
local function DestroyYep()
    for x = 1,69 do
        if game.CoreGui:FindFirstChild("fu8rj82n") then
            game.CoreGui:FindFirstChild("fu8rj82n"):Destroy()
        end
    end
end

DestroyYep()
wait(0.069)

local Library = {}

function Library:CreateWindow(windowname,windowinfo)
    local fu8rj82n = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local FrameCorner = Instance.new("UICorner")
    local DashBoard = Instance.new("Frame")
    local DashBoardCorner = Instance.new("UICorner")
    local TabContainer = Instance.new("Frame")
    local TabContainer_2 = Instance.new("UIListLayout")
    local PageContainer = Instance.new("Frame")
    local PageContainerCorner = Instance.new("UICorner")
    local PageFolder = Instance.new("Folder")
    local Title = Instance.new("TextLabel")
    local Yep = Instance.new("TextButton")
    local Cre = Instance.new("ImageLabel")
    local YepTitle = Instance.new("TextLabel")
    local YepCorner = Instance.new("UICorner")

    fu8rj82n.Name = "fu8rj82n"
    fu8rj82n.Parent = game.CoreGui
    fu8rj82n.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    fu8rj82n.ResetOnSpawn = false

    Frame.Parent = fu8rj82n
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Frame.BorderColor3 = Color3.fromRGB(20, 20, 20)
    Frame.BorderSizePixel = 0
    Frame.Position = UDim2.new(0.289808273, 0, 0.313227266, 0)
    Frame.Size = UDim2.new(0, 432, 0, 285)

    FrameCorner.Name = "FrameCorner"
    FrameCorner.Parent = Frame

    DashBoard.Name = "DashBoard"
    DashBoard.Parent = Frame
    DashBoard.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    DashBoard.BorderColor3 = Color3.fromRGB(15, 15, 15)
    DashBoard.Position = UDim2.new(0.0185185205, 0, 0.16842106, 0)
    DashBoard.Size = UDim2.new(0, 107, 0, 223)

    DashBoardCorner.CornerRadius = UDim.new(0, 6)
    DashBoardCorner.Name = "DashBoardCorner"
    DashBoardCorner.Parent = DashBoard

    TabContainer.Name = "TabContainer"
    TabContainer.Parent = DashBoard
    TabContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    TabContainer.BackgroundTransparency = 1.000
    TabContainer.BorderColor3 = Color3.fromRGB(15, 15, 15)
    TabContainer.BorderSizePixel = 0
    TabContainer.Position = UDim2.new(0.0280373823, 0, 0.0391304344, 0)
    TabContainer.Size = UDim2.new(0, 100, 0, 214)

    TabContainer_2.Name = "TabContainer"
    TabContainer_2.Parent = TabContainer
    TabContainer_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabContainer_2.SortOrder = Enum.SortOrder.LayoutOrder
    TabContainer_2.Padding = UDim.new(0, 8)

    PageContainer.Name = "PageContainer"
    PageContainer.Parent = Frame
    PageContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    PageContainer.BorderColor3 = Color3.fromRGB(15, 15, 15)
    PageContainer.Position = UDim2.new(0.282407403, 0, 0.16842106, 0)
    PageContainer.Size = UDim2.new(0, 299, 0, 223)

    PageContainerCorner.CornerRadius = UDim.new(0, 6)
    PageContainerCorner.Name = "PageContainerCorner"
    PageContainerCorner.Parent = PageContainer

    PageFolder.Name = "PageFolder"
    PageFolder.Parent = PageContainer

    Title.Name = "Title"
    Title.Parent = Frame
    Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Title.BackgroundTransparency = 1.000
    Title.BorderColor3 = Color3.fromRGB(20, 20, 20)
    Title.BorderSizePixel = 0
    Title.Position = UDim2.new(0.0428240746, 0, 0.028070176, 0)
    Title.Size = UDim2.new(0, 355, 0, 33)
    Title.Font = Enum.Font.GothamSemibold
    Title.Text = windowname
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 14.000
    Title.TextXAlignment = Enum.TextXAlignment.Left

    Yep.Name = "Yep"
    Yep.Parent = Frame
    Yep.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Yep.BackgroundTransparency = 1.000
    Yep.BorderColor3 = Color3.fromRGB(20, 20, 20)
    Yep.BorderSizePixel = 0
    Yep.Position = UDim2.new(0.88499999, 0, 0.0495263338, 0)
    Yep.Size = UDim2.new(0, 38, 0, 22)
    Yep.AutoButtonColor = false
    Yep.Font = Enum.Font.SourceSans
    Yep.Text = ""
    Yep.TextColor3 = Color3.fromRGB(0, 0, 0)
    Yep.TextSize = 14.000

    Cre.Name = "Cre"
    Cre.Parent = Yep
    Cre.BackgroundTransparency = 1.000
    Cre.Size = UDim2.new(0, 38, 0, 21)
    Cre.Image = "rbxassetid://4384401360"
    Cre.ScaleType = Enum.ScaleType.Fit

    YepTitle.Name = "YepTitle"
    YepTitle.Parent = Yep
    YepTitle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    YepTitle.BackgroundTransparency = 1.000
    YepTitle.BorderColor3 = Color3.fromRGB(20, 20, 20)
    YepTitle.BorderSizePixel = 0
    YepTitle.Position = UDim2.new(1.57894742, 0, -0.318181813, 0)
    YepTitle.Size = UDim2.new(0, 128, 0, 33)
    YepTitle.Font = Enum.Font.GothamSemibold
    YepTitle.Text = windowinfo or "RYSA CHEAT"
    YepTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    YepTitle.TextSize = 9.000
    YepTitle.TextTransparency = 1.000

    YepCorner.Name = "YepCorner"
    YepCorner.Parent = YepTitle

    Cre.MouseEnter:Connect(function()
        YepTitle.BackgroundTransparency = 0.8
        YepTitle.TextTransparency = 0.5
        wait(0.05)
        YepTitle.BackgroundTransparency = 0.5
        YepTitle.TextTransparency = 0.3
        Cre.ImageColor3 = Color3.fromRGB(137, 246, 255)
        wait(0.05)
        YepTitle.BackgroundTransparency = 0
        YepTitle.TextTransparency = 0
    end)

    Cre.MouseLeave:Connect(function()
        YepTitle.BackgroundTransparency = 0.5
        YepTitle.TextTransparency = 0.3
        wait(0.05)
        YepTitle.BackgroundTransparency = 0.8
        YepTitle.TextTransparency = 0.5
        Cre.ImageColor3 = Color3.fromRGB(255,255,255)
        wait(0.05)
        YepTitle.BackgroundTransparency = 1
        YepTitle.TextTransparency = 1
    end)

    local UserInputService = game:GetService("UserInputService")

    local gui = Frame

    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    gui.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)

    local FrameVisible = true

    local PageYep = {}

    function PageYep:addPage(pagename,scrollsize,visible,elementspacing)
        local Tab = Instance.new("TextButton")
        local TabCorner = Instance.new("UICorner")
        local Home = Instance.new("ScrollingFrame")
        local PageLayout = Instance.new("UIListLayout")

        Tab.Name = "Tab"
        Tab.Parent = TabContainer
        Tab.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        Tab.BorderColor3 = Color3.fromRGB(15, 15, 15)
        Tab.Position = UDim2.new(-0.0250000004, 0, 0, 0)
        Tab.Size = UDim2.new(0, 106, 0, 26)
        Tab.AutoButtonColor = false
        Tab.Font = Enum.Font.GothamSemibold
        Tab.Text = pagename or "nil"
        Tab.TextColor3 = Color3.fromRGB(255, 255, 255)
        Tab.TextSize = 11.000
        Tab.TextTransparency = 0.300

        TabCorner.CornerRadius = UDim.new(0, 7)
        TabCorner.Name = "TabCorner"
        TabCorner.Parent = Tab

        Home.Name = "Page"
        Home.Parent = PageFolder
        Home.Active = true
        Home.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        Home.BackgroundTransparency = 1.000
        Home.BorderColor3 = Color3.fromRGB(15, 15, 15)
        Home.BorderSizePixel = 0
        Home.Position = UDim2.new(0, 0, 0.0391303785, 0)
        Home.Size = UDim2.new(0, 298, 0, 205)
        Home.ScrollBarThickness = 3
        Home.ScrollBarImageColor3 = Color3.fromRGB(5,5,5)
        Home.CanvasSize = UDim2.new(0,0,scrollsize,0) or UDim2.new(0,0,4,0)
        Home.Visible = visible or false

        PageLayout.Name = "PageLayout"
        PageLayout.Parent = Home
        PageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        PageLayout.Padding = UDim.new(0,elementspacing) or UDim.new(0,6)

        Tab.MouseButton1Down:Connect(function()
            Tab.TextSize = 9

            for i,v in pairs(PageFolder:GetChildren()) do
                v.Visible = false
            end
            wait(0.02)
            Home.Visible = true
            Tab.TextTransparency = 0
            Tab.TextSize = 11
            for i,v in pairs(TabContainer:GetChildren()) do
                if v:IsA("GuiButton") and v ~= Tab then
                    v.TextTransparency = 0.3
                end
            end
        end)

        if visible == true then
            Tab.TextTransparency = 0
            for i,v in pairs(PageFolder:GetChildren()) do
                if v:IsA("Frame") and v ~= Home then
                    v.Visible = false
                end
            end
        else
            Tab.TextTransparency = 0.3
        end

        Tab.MouseEnter:Connect(function()
            Tab.BackgroundColor3 = Color3.fromRGB(10,10,10)
        end)

        Tab.MouseLeave:Connect(function()
            Tab.BackgroundColor3 = Color3.fromRGB(15,15,15)
        end)

        local PageElements = {}

        function PageElements:addLabel(labelname,labelinfo)
            local LabelHolder = Instance.new("Frame")
            local LabelHolderCorner = Instance.new("UICorner")
            local LabelTitle = Instance.new("TextLabel")
            local LabelInfo = Instance.new("TextLabel")

            LabelHolder.Name = "LabelHolder"
            LabelHolder.Parent = Home
            LabelHolder.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
            LabelHolder.BorderColor3 = Color3.fromRGB(17, 17, 17)
            LabelHolder.BorderSizePixel = 0
            LabelHolder.Position = UDim2.new(0.0167785231, 0, 0, 0)
            LabelHolder.Size = UDim2.new(0, 288, 0, 26)

            LabelHolderCorner.CornerRadius = UDim.new(0, 5)
            LabelHolderCorner.Name = "LabelHolderCorner"
            LabelHolderCorner.Parent = LabelHolder

            LabelTitle.Name = "LabelTitle"
            LabelTitle.Parent = LabelHolder
            LabelTitle.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
            LabelTitle.BackgroundTransparency = 1.000
            LabelTitle.BorderColor3 = Color3.fromRGB(17, 17, 17)
            LabelTitle.BorderSizePixel = 0
            LabelTitle.Size = UDim2.new(0, 288, 0, 15)
            LabelTitle.Font = Enum.Font.GothamSemibold
            LabelTitle.Text = labelname or ""
            LabelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            LabelTitle.TextSize = 11.000

            LabelInfo.Name = "LabelInfo"
            LabelInfo.Parent = LabelHolder
            LabelInfo.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
            LabelInfo.BackgroundTransparency = 1.000
            LabelInfo.BorderColor3 = Color3.fromRGB(17, 17, 17)
            LabelInfo.BorderSizePixel = 0
            LabelInfo.Position = UDim2.new(0, 0, 0.653846145, 0)
            LabelInfo.Size = UDim2.new(0, 288, 0, 9)
            LabelInfo.Font = Enum.Font.GothamSemibold
            LabelInfo.Text = labelinfo or ""
            LabelInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
            LabelInfo.TextSize = 9.000
            LabelInfo.TextTransparency = 0.300
        end

        function PageElements:addButton(buttonname,callback)
            local ButtonHolder = Instance.new("Frame")
            local Button = Instance.new("TextButton")
            local ButtonCorner = Instance.new("UICorner")
            local ButtonHolderCorner = Instance.new("UICorner")

            local callback = callback or function () end

            ButtonHolder.Name = "ButtonHolder"
            ButtonHolder.Parent = Home
            ButtonHolder.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
            ButtonHolder.BorderColor3 = Color3.fromRGB(17, 17, 17)
            ButtonHolder.BorderSizePixel = 0
            ButtonHolder.Position = UDim2.new(0.0167785231, 0, 0, 0)
            ButtonHolder.Size = UDim2.new(0, 288, 0, 26)

            Button.Name = "Button"
            Button.Parent = ButtonHolder
            Button.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
            Button.BackgroundTransparency = 1.000
            Button.BorderColor3 = Color3.fromRGB(17, 17, 17)
            Button.BorderSizePixel = 0
            Button.Size = UDim2.new(0, 288, 0, 26)
            Button.AutoButtonColor = false
            Button.Font = Enum.Font.GothamSemibold
            Button.Text = buttonname
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextSize = 11.000

            ButtonCorner.CornerRadius = UDim.new(0, 5)
            ButtonCorner.Name = "ButtonCorner"
            ButtonCorner.Parent = Button

            ButtonHolderCorner.CornerRadius = UDim.new(0, 5)
            ButtonHolderCorner.Name = "ButtonHolderCorner"
            ButtonHolderCorner.Parent = ButtonHolder

            Button.MouseButton1Down:Connect(function()
                Button.TextSize = 9
                wait(0.1)
                Button.TextSize = 11
                pcall(callback)
            end)
        end

        function PageElements:addToggle(togglename,callback)
            local ToggleHolder = Instance.new("Frame")
            local ToggleHolderCorner = Instance.new("UICorner")
            local ToggleTitle = Instance.new("TextLabel")
            local ToggleButton = Instance.new("TextButton")
            local ToggleFrame = Instance.new("Frame")
            local ToggleFrameCorner = Instance.new("UICorner")
            local ToggleBall = Instance.new("Frame")
            local ToggleBallCorner = Instance.new("UICorner")

            local callback = callback or function() end
            local ToggleEnabled = false

            ToggleHolder.Name = "ToggleHolder"
            ToggleHolder.Parent = Home
            ToggleHolder.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
            ToggleHolder.BorderColor3 = Color3.fromRGB(17, 17, 17)
            ToggleHolder.BorderSizePixel = 0
            ToggleHolder.Position = UDim2.new(0.0167785231, 0, 0, 0)
            ToggleHolder.Size = UDim2.new(0, 288, 0, 26)

            ToggleHolderCorner.CornerRadius = UDim.new(0, 5)
            ToggleHolderCorner.Name = "ToggleHolderCorner"
            ToggleHolderCorner.Parent = ToggleHolder

            ToggleTitle.Name = "ToggleTitle"
            ToggleTitle.Parent = ToggleHolder
            ToggleTitle.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
            ToggleTitle.BackgroundTransparency = 1.000
            ToggleTitle.BorderColor3 = Color3.fromRGB(17, 17, 17)
            ToggleTitle.BorderSizePixel = 0
            ToggleTitle.Position = UDim2.new(0.024305556, 0, 0, 0)
            ToggleTitle.Size = UDim2.new(0, 195, 0, 24)
            ToggleTitle.Font = Enum.Font.GothamSemibold
            ToggleTitle.Text = togglename or ""
            ToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleTitle.TextSize = 11.000
            ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

            ToggleButton.Name = "ToggleButton"
            ToggleButton.Parent = ToggleHolder
            ToggleButton.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
            ToggleButton.BackgroundTransparency = 1.000
            ToggleButton.BorderColor3 = Color3.fromRGB(17, 17, 17)
            ToggleButton.Position = UDim2.new(0.802083313, 0, 1.17375305e-06, 0)
            ToggleButton.Size = UDim2.new(0, 57, 0, 25)
            ToggleButton.AutoButtonColor = false
            ToggleButton.Font = Enum.Font.SourceSans
            ToggleButton.Text = ""
            ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
            ToggleButton.TextSize = 14.000

            ToggleFrame.Name = "ToggleFrame"
            ToggleFrame.Parent = ToggleButton
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
            ToggleFrame.BorderColor3 = Color3.fromRGB(5, 5, 5)
            ToggleFrame.Position = UDim2.new(0.27192983, 0, 0.119999997, 0)
            ToggleFrame.Size = UDim2.new(0, 34, 0, 19)

            ToggleFrameCorner.Name = "ToggleFrameCorner"
            ToggleFrameCorner.Parent = ToggleFrame

            ToggleBall.Name = "ToggleBall"
            ToggleBall.Parent = ToggleFrame
            ToggleBall.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleBall.Position = UDim2.new(0.123000003, 0, 0.158000007, 0)
            ToggleBall.Size = UDim2.new(0, 14, 0, 12)

            ToggleBallCorner.CornerRadius = UDim.new(0, 100)
            ToggleBallCorner.Name = "ToggleBallCorner"
            ToggleBallCorner.Parent = ToggleBall

            ToggleButton.MouseButton1Down:Connect(function()
                ToggleEnabled = not ToggleEnabled
                if ToggleEnabled then
                    ToggleHolder.BackgroundColor3 = Color3.fromRGB(16,16,16)
                    ToggleBall:TweenPosition(UDim2.new(0.455, 0,0.158, 0),"Out","Linear",0.1)
                    wait(0.05)
                    ToggleHolder.BackgroundColor3 = Color3.fromRGB(17,17,17)
                    ToggleBall:TweenPosition(UDim2.new(0.455, 0,0.158, 0),"Out","Linear",0.1)
                else
                    ToggleHolder.BackgroundColor3 = Color3.fromRGB(16,16,16)
                    ToggleBall:TweenPosition(UDim2.new(0.123, 0,0.158, 0),"Out","Linear",0.1)
                    wait(0.05)
                    ToggleHolder.BackgroundColor3 = Color3.fromRGB(17,17,17)
                    ToggleBall:TweenPosition(UDim2.new(0.123, 0,0.158, 0),"Out","Linear",0.1)
                end
                pcall(callback,ToggleEnabled)
            end)
        end

        return PageElements
    end
    return PageYep
end

return Library


-- RYSA CHEAT MENU
local GUI = Library:CreateWindow("RYSA CHEAT", "Premium • Lifetime")

-- Settings Tab
local Settings = GUI:addPage("Settings", 1, true, 6)
Settings:addLabel("Settings", "Cheat Ayarları")
Settings:addButton("Test Button", function()
    game.StarterGui:SetCore("SendNotification", {Title = "RYSA"; Text = "Test Clicked"})
end)
Settings:addToggle("Enable Cheat", function(value)
    if value then
        game.StarterGui:SetCore("SendNotification", {Title = "RYSA"; Text = "Cheat Enabled"})
    else
        game.StarterGui:SetCore("SendNotification", {Title = "RYSA"; Text = "Cheat Disabled"})
    end
end)

-- Lua Executor Tab
local Executor = GUI:addPage("Executor", 1, false, 6)
Executor:addLabel("Lua Executor", "Script Çalıştır")
Executor:addButton("Execute", function()
    game.StarterGui:SetCore("SendNotification", {Title = "RYSA"; Text = "Executor Ready"})
end)

-- Local Tab
local Local = GUI:addPage("Local", 1, false, 6)
Local:addLabel("Local", "Oyuncu Özellikleri")
Local:addButton("Local Features", function()
    game.StarterGui:SetCore("SendNotification", {Title = "RYSA"; Text = "Local Features"})
end)
Local:addToggle("Sprint", function(value)
    if value then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 24
    else
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)

-- Players Tab
local Players = GUI:addPage("Players", 1, false, 6)
Players:addLabel("Players", "Oyuncu Listesi")
Players:addButton("Player List", function()
    game.StarterGui:SetCore("SendNotification", {Title = "RYSA"; Text = "Players Tab"})
end)

-- Server Tab
local Server = GUI:addPage("Server", 1, false, 6)
Server:addLabel("Server", "Sunucu Bilgisi")
Server:addButton("Server Info", function()
    game.StarterGui:SetCore("SendNotification", {Title = "RYSA"; Text = "Server Tab"})
end)

-- Misc Tab
local Misc = GUI:addPage("Misc", 1, false, 6)
Misc:addLabel("Misc", "Diğer Özellikler")
Misc:addButton("Miscellaneous", function()
    game.StarterGui:SetCore("SendNotification", {Title = "RYSA"; Text = "Misc Tab"})
end)

-- Menu Toggle
local menuOpen = true
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.End then
        menuOpen = not menuOpen
        game.CoreGui:FindFirstChild("fu8rj82n").Enabled = menuOpen
    end
end)

print("✅ RYSA CHEAT - BAŞLANDI")
print("Menü: End tuşu")
