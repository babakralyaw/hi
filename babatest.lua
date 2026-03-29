-- RYSA CHEAT - FIXED
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

function Library:CreateWindow(windowname, windowinfo)
    local fu8rj82n = Instance.new("ScreenGui")
    fu8rj82n.Name = "fu8rj82n"
    fu8rj82n.Parent = game.CoreGui
    fu8rj82n.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    fu8rj82n.ResetOnSpawn = false

    local Frame = Instance.new("Frame")
    Frame.Parent = fu8rj82n
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Frame.BorderSizePixel = 0
    Frame.Position = UDim2.new(0.289808273, 0, 0.313227266, 0)
    Frame.Size = UDim2.new(0, 432, 0, 285)

    local FrameCorner = Instance.new("UICorner")
    FrameCorner.CornerRadius = UDim.new(0, 6)
    FrameCorner.Parent = Frame

    local DashBoard = Instance.new("Frame")
    DashBoard.Name = "DashBoard"
    DashBoard.Parent = Frame
    DashBoard.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    DashBoard.Position = UDim2.new(0.0185185205, 0, 0.16842106, 0)
    DashBoard.Size = UDim2.new(0, 107, 0, 223)
    DashBoard.BorderSizePixel = 0

    local DashBoardCorner = Instance.new("UICorner")
    DashBoardCorner.CornerRadius = UDim.new(0, 6)
    DashBoardCorner.Parent = DashBoard

    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = DashBoard
    TabContainer.BackgroundTransparency = 1
    TabContainer.BorderSizePixel = 0
    TabContainer.Position = UDim2.new(0.0280373823, 0, 0.0391304344, 0)
    TabContainer.Size = UDim2.new(0, 100, 0, 214)

    local TabLayout = Instance.new("UIListLayout")
    TabLayout.Parent = TabContainer
    TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabLayout.Padding = UDim.new(0, 8)

    local PageContainer = Instance.new("Frame")
    PageContainer.Name = "PageContainer"
    PageContainer.Parent = Frame
    PageContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    PageContainer.Position = UDim2.new(0.282407403, 0, 0.16842106, 0)
    PageContainer.Size = UDim2.new(0, 299, 0, 223)
    PageContainer.BorderSizePixel = 0

    local PageContainerCorner = Instance.new("UICorner")
    PageContainerCorner.CornerRadius = UDim.new(0, 6)
    PageContainerCorner.Parent = PageContainer

    local PageFolder = Instance.new("Folder")
    PageFolder.Name = "PageFolder"
    PageFolder.Parent = PageContainer

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = Frame
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0.0428240746, 0, 0.028070176, 0)
    Title.Size = UDim2.new(0, 355, 0, 33)
    Title.Font = Enum.Font.GothamSemibold
    Title.Text = windowname
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 14

    local UserInputService = game:GetService("UserInputService")
    local dragging = false
    local dragStart = nil
    local startPos = nil

    local function update(input)
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    Frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    Frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            if dragging and dragStart then
                update(input)
            end
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            update(input)
        end
    end)

    local PageYep = {}

    function PageYep:addPage(pagename, scrollsize, visible, elementspacing)
        local Tab = Instance.new("TextButton")
        Tab.Name = "Tab"
        Tab.Parent = TabContainer
        Tab.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        Tab.Size = UDim2.new(0, 106, 0, 26)
        Tab.AutoButtonColor = false
        Tab.Font = Enum.Font.GothamSemibold
        Tab.Text = pagename or "nil"
        Tab.TextColor3 = Color3.fromRGB(255, 255, 255)
        Tab.TextSize = 11
        Tab.TextTransparency = 0.3
        Tab.BorderSizePixel = 0

        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 7)
        TabCorner.Parent = Tab

        local Home = Instance.new("ScrollingFrame")
        Home.Name = "Page"
        Home.Parent = PageFolder
        Home.Active = true
        Home.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        Home.BackgroundTransparency = 1
        Home.BorderSizePixel = 0
        Home.Position = UDim2.new(0, 0, 0.0391303785, 0)
        Home.Size = UDim2.new(0, 298, 0, 205)
        Home.ScrollBarThickness = 3
        Home.ScrollBarImageColor3 = Color3.fromRGB(5, 5, 5)
        Home.CanvasSize = UDim2.new(0, 0, scrollsize or 4, 0)
        Home.Visible = visible or false

        local PageLayout = Instance.new("UIListLayout")
        PageLayout.Name = "PageLayout"
        PageLayout.Parent = Home
        PageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        PageLayout.Padding = UDim.new(0, elementspacing or 6)

        Tab.MouseButton1Down:Connect(function()
            for i, v in pairs(PageFolder:GetChildren()) do
                v.Visible = false
            end
            Home.Visible = true
            Tab.TextTransparency = 0
            for i, v in pairs(TabContainer:GetChildren()) do
                if v:IsA("GuiButton") and v ~= Tab then
                    v.TextTransparency = 0.3
                end
            end
        end)

        if visible == true then
            Tab.TextTransparency = 0
        end

        Tab.MouseEnter:Connect(function()
            Tab.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        end)

        Tab.MouseLeave:Connect(function()
            Tab.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        end)

        local PageElements = {}

        function PageElements:addLabel(labelname, labelinfo)
            local LabelHolder = Instance.new("Frame")
            LabelHolder.Name = "LabelHolder"
            LabelHolder.Parent = Home
            LabelHolder.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
            LabelHolder.BorderSizePixel = 0
            LabelHolder.Size = UDim2.new(0, 288, 0, 26)

            local LabelHolderCorner = Instance.new("UICorner")
            LabelHolderCorner.CornerRadius = UDim.new(0, 5)
            LabelHolderCorner.Parent = LabelHolder

            local LabelTitle = Instance.new("TextLabel")
            LabelTitle.Name = "LabelTitle"
            LabelTitle.Parent = LabelHolder
            LabelTitle.BackgroundTransparency = 1
            LabelTitle.Size = UDim2.new(0, 288, 0, 15)
            LabelTitle.Font = Enum.Font.GothamSemibold
            LabelTitle.Text = labelname or ""
            LabelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            LabelTitle.TextSize = 11

            local LabelInfo = Instance.new("TextLabel")
            LabelInfo.Name = "LabelInfo"
            LabelInfo.Parent = LabelHolder
            LabelInfo.BackgroundTransparency = 1
            LabelInfo.Position = UDim2.new(0, 0, 0.653846145, 0)
            LabelInfo.Size = UDim2.new(0, 288, 0, 9)
            LabelInfo.Font = Enum.Font.GothamSemibold
            LabelInfo.Text = labelinfo or ""
            LabelInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
            LabelInfo.TextSize = 9
            LabelInfo.TextTransparency = 0.3
        end

        function PageElements:addButton(buttonname, callback)
            local ButtonHolder = Instance.new("Frame")
            ButtonHolder.Name = "ButtonHolder"
            ButtonHolder.Parent = Home
            ButtonHolder.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
            ButtonHolder.BorderSizePixel = 0
            ButtonHolder.Size = UDim2.new(0, 288, 0, 26)

            local ButtonHolderCorner = Instance.new("UICorner")
            ButtonHolderCorner.CornerRadius = UDim.new(0, 5)
            ButtonHolderCorner.Parent = ButtonHolder

            local Button = Instance.new("TextButton")
            Button.Name = "Button"
            Button.Parent = ButtonHolder
            Button.BackgroundTransparency = 1
            Button.Size = UDim2.new(0, 288, 0, 26)
            Button.AutoButtonColor = false
            Button.Font = Enum.Font.GothamSemibold
            Button.Text = buttonname
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextSize = 11

            Button.MouseButton1Down:Connect(function()
                Button.TextSize = 9
                wait(0.1)
                Button.TextSize = 11
                pcall(callback)
            end)
        end

        function PageElements:addToggle(togglename, callback)
            local ToggleHolder = Instance.new("Frame")
            ToggleHolder.Name = "ToggleHolder"
            ToggleHolder.Parent = Home
            ToggleHolder.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
            ToggleHolder.BorderSizePixel = 0
            ToggleHolder.Size = UDim2.new(0, 288, 0, 26)

            local ToggleHolderCorner = Instance.new("UICorner")
            ToggleHolderCorner.CornerRadius = UDim.new(0, 5)
            ToggleHolderCorner.Parent = ToggleHolder

            local ToggleTitle = Instance.new("TextLabel")
            ToggleTitle.Name = "ToggleTitle"
            ToggleTitle.Parent = ToggleHolder
            ToggleTitle.BackgroundTransparency = 1
            ToggleTitle.Position = UDim2.new(0.024305556, 0, 0, 0)
            ToggleTitle.Size = UDim2.new(0, 195, 0, 24)
            ToggleTitle.Font = Enum.Font.GothamSemibold
            ToggleTitle.Text = togglename or ""
            ToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleTitle.TextSize = 11
            ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Name = "ToggleButton"
            ToggleButton.Parent = ToggleHolder
            ToggleButton.BackgroundTransparency = 1
            ToggleButton.Position = UDim2.new(0.802083313, 0, 0, 0)
            ToggleButton.Size = UDim2.new(0, 57, 0, 25)
            ToggleButton.AutoButtonColor = false
            ToggleButton.Text = ""

            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Name = "ToggleFrame"
            ToggleFrame.Parent = ToggleButton
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
            ToggleFrame.Position = UDim2.new(0.27192983, 0, 0.119999997, 0)
            ToggleFrame.Size = UDim2.new(0, 34, 0, 19)
            ToggleFrame.BorderSizePixel = 0

            local ToggleFrameCorner = Instance.new("UICorner")
            ToggleFrameCorner.Parent = ToggleFrame

            local ToggleBall = Instance.new("Frame")
            ToggleBall.Name = "ToggleBall"
            ToggleBall.Parent = ToggleFrame
            ToggleBall.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleBall.Position = UDim2.new(0.123000003, 0, 0.158000007, 0)
            ToggleBall.Size = UDim2.new(0, 14, 0, 12)
            ToggleBall.BorderSizePixel = 0

            local ToggleBallCorner = Instance.new("UICorner")
            ToggleBallCorner.CornerRadius = UDim.new(0, 100)
            ToggleBallCorner.Parent = ToggleBall

            local ToggleEnabled = false

            ToggleButton.MouseButton1Down:Connect(function()
                ToggleEnabled = not ToggleEnabled
                if ToggleEnabled then
                    ToggleBall:TweenPosition(UDim2.new(0.455, 0, 0.158, 0), "Out", "Linear", 0.1)
                else
                    ToggleBall:TweenPosition(UDim2.new(0.123, 0, 0.158, 0), "Out", "Linear", 0.1)
                end
                pcall(callback, ToggleEnabled)
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
