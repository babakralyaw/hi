--[[
    ╔════════════════════════════════════════════════════════════════════╗
    ║                   RYSA STYLE CHEAT v4.0                       ║
    ║        Professional ESP | Aimbot | Wallshot | Full Features        ║
    ║              With Friend List & Complete Color Config              ║
    ╚════════════════════════════════════════════════════════════════════╝
]]

--// Cache
local select = select
local pcall, getgenv, next, Vector2, Vector3, mathclamp, type = select(1, pcall, getgenv, next, Vector2.new, Vector3.new, math.clamp, type)

--// Prevent Multiple Instances
pcall(function()
    getgenv().CHEAT.Functions:Exit()
end)

--// Environment Setup
getgenv().CHEAT = {}
local Environment = getgenv().CHEAT

--// Services
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

--// Variables
local Typing = false
local ServiceConnections = {}
local ESPObjects = {}
local MenuOpen = true
local SelectedTab = 1
local FriendList = {}
local ScrollOffset = 0

--// Main Settings (NO KEY BINDINGS - USER SETS THEM)
Environment.Settings = {
    Enabled = true,
    AimbotEnabled = false,
    ESPEnabled = true,
    WallshotEnabled = false,
    NoClipEnabled = false,
    
    TeamCheck = false,
    AliveCheck = true,
    WallCheck = false,
    
    MaxDistance = 500,
    AimbotSensitivity = 0.5,
    AimbotSmoothing = 0.1,
    LockPart = "Head"
}

--// ESP Settings
Environment.ESPSettings = {
    BoxEnabled = true,
    BoxColor = Color3.fromRGB(0, 255, 0),
    BoxThickness = 2,
    
    NameEnabled = true,
    NameColor = Color3.fromRGB(255, 255, 255),
    NameSize = 13,
    
    HealthEnabled = true,
    HealthBarWidth = 50,
    HealthBarHeight = 4,
    HealthBarColor = Color3.fromRGB(0, 255, 0),
    
    DistanceEnabled = true,
    DistanceColor = Color3.fromRGB(200, 200, 200),
    DistanceSize = 11,
    
    ChineseHatEnabled = true,
    ChineseHatColor = Color3.fromRGB(255, 200, 0),
    ChineseHatSize = 30,
    
    EnemyColor = Color3.fromRGB(255, 0, 0),
    AllyColor = Color3.fromRGB(0, 255, 0),
    FriendColor = Color3.fromRGB(0, 150, 255),
    
    SkeletonEnabled = true,
    SkeletonColor = Color3.fromRGB(100, 200, 255),
    SkeletonThickness = 1,
    
    Transparency = 0.7,
    OutlineEnabled = true,
    OutlineThickness = 1,
    OutlineColor = Color3.fromRGB(0, 0, 0)
}

--// FOV Settings
Environment.FOVSettings = {
    Enabled = true,
    Visible = true,
    Amount = 150,
    Color = Color3.fromRGB(0, 255, 0),
    LockedColor = Color3.fromRGB(255, 0, 0),
    Transparency = 0.5,
    Sides = 60,
    Thickness = 2,
    Filled = false
}

--// Aimbot Settings
Environment.AimbotSettings = {
    Enabled = false,
    Smoothing = 0.15,
    Prediction = true,
    PredictionAmount = 0.5,
    VisibleCheck = true,
    HeadPriority = true,
    BodyPriority = false,
    AutoShoot = false,
    AutoShootDelay = 0.1,
    IgnoreFriends = true
}

--// Wallshot Settings
Environment.WallshotSettings = {
    Enabled = false,
    PenetrationPower = 1.0,
    IgnoreWalls = true,
    IgnoreObjects = true,
    RaycastVisualize = false,
    RaycastColor = Color3.fromRGB(0, 255, 255)
}

--// Advanced Settings
Environment.AdvancedSettings = {
    ShowHeadDots = true,
    HeadDotSize = 4,
    HeadDotColor = Color3.fromRGB(255, 255, 0),
    CullDistance = 1000,
    OptimizationMode = true,
    AntiAim = false,
    AntiAimYaw = 0,
    AntiAimPitch = 0,
    ShowFPS = true
}

--// Menu Settings
Environment.MenuSettings = {
    MenuVisible = true,
    MenuPosition = UDim2.new(0, 20, 0, 20),
    MenuSize = UDim2.new(0, 400, 0, 700),
    MenuColor = Color3.fromRGB(15, 15, 25),
    MenuTransparency = 0.05,
    AccentColor = Color3.fromRGB(0, 150, 255),
    TextColor = Color3.fromRGB(255, 255, 255),
    HeaderColor = Color3.fromRGB(30, 30, 50),
    TabColor = Color3.fromRGB(25, 25, 40),
    TabHoverColor = Color3.fromRGB(35, 35, 55)
}

--// FOV Circle
Environment.FOVCircle = Drawing.new("Circle")

--// Menu UI Elements
local MenuUI = {
    MainFrame = nil,
    Header = nil,
    Tabs = {},
    TabButtons = {},
    Elements = {},
    PlayerList = {},
    FPS = nil
}

--// Create Menu UI
local function CreateMenuUI()
    local MainFrame = Drawing.new("Square")
    MainFrame.Size = Environment.MenuSettings.MenuSize
    MainFrame.Position = Environment.MenuSettings.MenuPosition
    MainFrame.Color = Environment.MenuSettings.MenuColor
    MainFrame.Filled = true
    MainFrame.Transparency = Environment.MenuSettings.MenuTransparency
    MainFrame.Thickness = 2
    MainFrame.BorderColor = Environment.MenuSettings.AccentColor
    
    MenuUI.MainFrame = MainFrame
    
    -- Header
    local Header = Drawing.new("Text")
    Header.Text = "⚙ NEVERLOSE CHEAT v4.0"
    Header.Size = 16
    Header.Color = Environment.MenuSettings.AccentColor
    Header.Position = Vector2.new(Environment.MenuSettings.MenuPosition.X.Offset + 15, Environment.MenuSettings.MenuPosition.Y.Offset + 10)
    Header.Center = false
    Header.Outline = true
    Header.OutlineColor = Color3.fromRGB(0, 0, 0)
    
    MenuUI.Header = Header
    table.insert(MenuUI.Elements, Header)
    
    -- FPS Counter
    local FPS = Drawing.new("Text")
    FPS.Size = 12
    FPS.Color = Color3.fromRGB(0, 255, 0)
    FPS.Position = Vector2.new(Environment.MenuSettings.MenuPosition.X.Offset + 350, Environment.MenuSettings.MenuPosition.Y.Offset + 10)
    FPS.Center = false
    FPS.Outline = true
    FPS.OutlineColor = Color3.fromRGB(0, 0, 0)
    
    MenuUI.FPS = FPS
    table.insert(MenuUI.Elements, FPS)
end

--// Create ESP Box
local function CreateESPBox(Player)
    if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then
        return nil
    end
    
    local ESPBox = {
        NameLabel = Drawing.new("Text"),
        HealthBar = Drawing.new("Square"),
        HealthBarBG = Drawing.new("Square"),
        DistanceLabel = Drawing.new("Text"),
        BoxOutline = Drawing.new("Square"),
        BoxFill = Drawing.new("Square"),
        HeadDot = Drawing.new("Circle"),
        ChineseHat = Drawing.new("Circle"),
        SkeletonLines = {},
        Player = Player
    }
    
    -- Configure Name Label
    ESPBox.NameLabel.Size = Environment.ESPSettings.NameSize
    ESPBox.NameLabel.Color = Environment.ESPSettings.NameColor
    ESPBox.NameLabel.Center = true
    ESPBox.NameLabel.Outline = true
    ESPBox.NameLabel.OutlineColor = Color3.fromRGB(0, 0, 0)
    
    -- Configure Health Bar Background
    ESPBox.HealthBarBG.Color = Color3.fromRGB(50, 50, 50)
    ESPBox.HealthBarBG.Filled = true
    ESPBox.HealthBarBG.Thickness = 1
    
    -- Configure Health Bar
    ESPBox.HealthBar.Filled = true
    ESPBox.HealthBar.Thickness = 1
    
    -- Configure Distance Label
    ESPBox.DistanceLabel.Size = Environment.ESPSettings.DistanceSize
    ESPBox.DistanceLabel.Color = Environment.ESPSettings.DistanceColor
    ESPBox.DistanceLabel.Center = true
    ESPBox.DistanceLabel.Outline = true
    ESPBox.DistanceLabel.OutlineColor = Color3.fromRGB(0, 0, 0)
    
    -- Configure Box
    ESPBox.BoxOutline.Filled = false
    ESPBox.BoxOutline.Thickness = Environment.ESPSettings.OutlineThickness
    ESPBox.BoxOutline.Color = Environment.ESPSettings.OutlineColor
    
    ESPBox.BoxFill.Filled = false
    ESPBox.BoxFill.Thickness = Environment.ESPSettings.BoxThickness
    
    -- Configure Head Dot
    ESPBox.HeadDot.Filled = true
    ESPBox.HeadDot.Radius = Environment.AdvancedSettings.HeadDotSize
    ESPBox.HeadDot.Color = Environment.AdvancedSettings.HeadDotColor
    
    -- Configure Chinese Hat
    ESPBox.ChineseHat.Filled = false
    ESPBox.ChineseHat.Radius = Environment.ESPSettings.ChineseHatSize
    ESPBox.ChineseHat.Color = Environment.ESPSettings.ChineseHatColor
    ESPBox.ChineseHat.Thickness = 2
    
    return ESPBox
end


--// Update ESP Box
local function UpdateESPBox(ESPBox)
    if not ESPBox.Player or not ESPBox.Player.Character then
        return false
    end
    
    local Character = ESPBox.Player.Character
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    local Head = Character:FindFirstChild("Head")
    
    if not HumanoidRootPart or not Humanoid then
        return false
    end
    
    -- Distance Check
    local Distance = (Camera.CFrame.Position - HumanoidRootPart.Position).Magnitude
    if Distance > Environment.AdvancedSettings.CullDistance then
        ESPBox.NameLabel.Visible = false
        ESPBox.HealthBar.Visible = false
        ESPBox.HealthBarBG.Visible = false
        ESPBox.DistanceLabel.Visible = false
        ESPBox.BoxOutline.Visible = false
        ESPBox.BoxFill.Visible = false
        ESPBox.HeadDot.Visible = false
        ESPBox.ChineseHat.Visible = false
        return true
    end
    
    -- Team Check
    if Environment.Settings.TeamCheck and ESPBox.Player.Team == LocalPlayer.Team then
        ESPBox.NameLabel.Visible = false
        ESPBox.HealthBar.Visible = false
        ESPBox.HealthBarBG.Visible = false
        ESPBox.DistanceLabel.Visible = false
        ESPBox.BoxOutline.Visible = false
        ESPBox.BoxFill.Visible = false
        ESPBox.HeadDot.Visible = false
        ESPBox.ChineseHat.Visible = false
        return true
    end
    
    -- Alive Check
    if Environment.Settings.AliveCheck and Humanoid.Health <= 0 then
        ESPBox.NameLabel.Visible = false
        ESPBox.HealthBar.Visible = false
        ESPBox.HealthBarBG.Visible = false
        ESPBox.DistanceLabel.Visible = false
        ESPBox.BoxOutline.Visible = false
        ESPBox.BoxFill.Visible = false
        ESPBox.HeadDot.Visible = false
        ESPBox.ChineseHat.Visible = false
        return true
    end
    
    -- Get Screen Position
    local Vector, OnScreen = Camera:WorldToViewportPoint(HumanoidRootPart.Position)
    
    if not OnScreen then
        ESPBox.NameLabel.Visible = false
        ESPBox.HealthBar.Visible = false
        ESPBox.HealthBarBG.Visible = false
        ESPBox.DistanceLabel.Visible = false
        ESPBox.BoxOutline.Visible = false
        ESPBox.BoxFill.Visible = false
        ESPBox.HeadDot.Visible = false
        ESPBox.ChineseHat.Visible = false
        return true
    end
    
    -- Determine Color (Friend Check)
    local IsFriend = FriendList[ESPBox.Player.Name] or false
    local IsEnemy = not Environment.Settings.TeamCheck or ESPBox.Player.Team ~= LocalPlayer.Team
    local BoxColor
    
    if IsFriend then
        BoxColor = Environment.ESPSettings.FriendColor
    elseif IsEnemy then
        BoxColor = Environment.ESPSettings.EnemyColor
    else
        BoxColor = Environment.ESPSettings.AllyColor
    end
    
    -- Update Box
    if Environment.ESPSettings.BoxEnabled then
        local BoxSize = Vector2.new(50, 80)
        local BoxPosition = Vector2.new(Vector.X - BoxSize.X / 2, Vector.Y - BoxSize.Y / 2)
        
        ESPBox.BoxOutline.Size = BoxSize
        ESPBox.BoxOutline.Position = BoxPosition
        ESPBox.BoxOutline.Visible = true
        
        ESPBox.BoxFill.Size = BoxSize
        ESPBox.BoxFill.Position = BoxPosition
        ESPBox.BoxFill.Color = BoxColor
        ESPBox.BoxFill.Visible = true
    end
    
    -- Update Name
    if Environment.ESPSettings.NameEnabled then
        local NameText = ESPBox.Player.Name
        if IsFriend then
            NameText = "★ " .. NameText .. " ★"
        end
        ESPBox.NameLabel.Text = NameText
        ESPBox.NameLabel.Position = Vector2.new(Vector.X, Vector.Y - 50)
        ESPBox.NameLabel.Visible = true
    end
    
    -- Update Health Bar
    if Environment.ESPSettings.HealthEnabled then
        local HealthPercent = Humanoid.Health / Humanoid.MaxHealth
        local BarWidth = Environment.ESPSettings.HealthBarWidth
        
        ESPBox.HealthBarBG.Size = Vector2.new(BarWidth, Environment.ESPSettings.HealthBarHeight)
        ESPBox.HealthBarBG.Position = Vector2.new(Vector.X - BarWidth / 2, Vector.Y + 45)
        ESPBox.HealthBarBG.Visible = true
        
        ESPBox.HealthBar.Size = Vector2.new(BarWidth * HealthPercent, Environment.ESPSettings.HealthBarHeight)
        ESPBox.HealthBar.Position = Vector2.new(Vector.X - BarWidth / 2, Vector.Y + 45)
        ESPBox.HealthBar.Color = HealthPercent > 0.5 and Color3.fromRGB(0, 255, 0) or HealthPercent > 0.25 and Color3.fromRGB(255, 255, 0) or Color3.fromRGB(255, 0, 0)
        ESPBox.HealthBar.Visible = true
    end
    
    -- Update Distance
    if Environment.ESPSettings.DistanceEnabled then
        ESPBox.DistanceLabel.Text = string.format("%.0f m", Distance)
        ESPBox.DistanceLabel.Position = Vector2.new(Vector.X, Vector.Y + 60)
        ESPBox.DistanceLabel.Visible = true
    end
    
    -- Update Head Dot
    if Environment.AdvancedSettings.ShowHeadDots and Head then
        local HeadVector = Camera:WorldToViewportPoint(Head.Position)
        ESPBox.HeadDot.Position = Vector2.new(HeadVector.X, HeadVector.Y)
        ESPBox.HeadDot.Visible = true
    end
    
    -- Update Chinese Hat
    if Environment.ESPSettings.ChineseHatEnabled and Head then
        local HeadVector = Camera:WorldToViewportPoint(Head.Position)
        ESPBox.ChineseHat.Position = Vector2.new(HeadVector.X, HeadVector.Y)
        ESPBox.ChineseHat.Visible = true
    end
    
    return true
end

--// Remove ESP Box
local function RemoveESPBox(Player)
    if ESPObjects[Player] then
        for _, Drawing in pairs(ESPObjects[Player]) do
            if Drawing and Drawing.Remove then
                pcall(function() Drawing:Remove() end)
            end
        end
        ESPObjects[Player] = nil
    end
end

--// Clear All ESP
local function ClearAllESP()
    for Player, _ in next, ESPObjects do
        RemoveESPBox(Player)
    end
end

--// Get Closest Player
local function GetClosestPlayer()
    local ClosestPlayer = nil
    local ClosestDistance = Environment.FOVSettings.Amount
    
    for _, Player in next, Players:GetPlayers() do
        if Player ~= LocalPlayer then
            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                if Environment.Settings.AliveCheck then
                    local Humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
                    if not Humanoid or Humanoid.Health <= 0 then continue end
                end
                
                if Environment.Settings.TeamCheck and Player.Team == LocalPlayer.Team then
                    continue
                end
                
                -- Ignore Friends in Aimbot
                if Environment.AimbotSettings.IgnoreFriends and FriendList[Player.Name] then
                    continue
                end
                
                local Vector, OnScreen = Camera:WorldToViewportPoint(Player.Character.HumanoidRootPart.Position)
                if OnScreen then
                    local Distance = (Vector2(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2(Vector.X, Vector.Y)).Magnitude
                    if Distance < ClosestDistance then
                        ClosestDistance = Distance
                        ClosestPlayer = Player
                    end
                end
            end
        end
    end
    
    return ClosestPlayer
end

--// Aimbot Function
local function AimbotTick()
    if not Environment.AimbotSettings.Enabled then
        Environment.FOVCircle.Color = Environment.FOVSettings.Color
        return
    end
    
    local TargetPlayer = GetClosestPlayer()
    if not TargetPlayer or not TargetPlayer.Character then
        Environment.FOVCircle.Color = Environment.FOVSettings.Color
        return
    end
    
    local TargetPart = TargetPlayer.Character:FindFirstChild(Environment.Settings.LockPart)
    if not TargetPart then
        Environment.FOVCircle.Color = Environment.FOVSettings.Color
        return
    end
    
    -- Prediction
    local TargetPosition = TargetPart.Position
    if Environment.AimbotSettings.Prediction then
        local Humanoid = TargetPlayer.Character:FindFirstChildOfClass("Humanoid")
        if Humanoid then
            TargetPosition = TargetPosition + (TargetPlayer.Character.HumanoidRootPart.Velocity * Environment.AimbotSettings.PredictionAmount)
        end
    end
    
    -- Smooth Aimbot
    local Direction = (TargetPosition - Camera.CFrame.Position).Unit
    local NewCFrame = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + Direction)
    Camera.CFrame = Camera.CFrame:Lerp(NewCFrame, Environment.AimbotSettings.Smoothing)
    
    -- Update FOV Circle Color
    Environment.FOVCircle.Color = Environment.FOVSettings.LockedColor
end

--// NoClip Function
local function NoClipTick()
    if not Environment.Settings.NoClipEnabled or not LocalPlayer.Character then
        return
    end
    
    for _, Part in pairs(LocalPlayer.Character:GetDescendants()) do
        if Part:IsA("BasePart") then
            Part.CanCollide = false
        end
    end
end

--// Add Friend
function Environment.Functions:AddFriend(PlayerName)
    FriendList[PlayerName] = true
    print("✓ Added " .. PlayerName .. " to friend list")
end

--// Remove Friend
function Environment.Functions:RemoveFriend(PlayerName)
    FriendList[PlayerName] = nil
    print("✓ Removed " .. PlayerName .. " from friend list")
end

--// Get Friend List
function Environment.Functions:GetFriendList()
    return FriendList
end

--// Toggle Aimbot
function Environment.Functions:ToggleAimbot()
    Environment.AimbotSettings.Enabled = not Environment.AimbotSettings.Enabled
    print(Environment.AimbotSettings.Enabled and "✓ Aimbot Enabled" or "✗ Aimbot Disabled")
end

--// Toggle ESP
function Environment.Functions:ToggleESP()
    Environment.Settings.ESPEnabled = not Environment.Settings.ESPEnabled
    print(Environment.Settings.ESPEnabled and "✓ ESP Enabled" or "✗ ESP Disabled")
end

--// Toggle NoClip
function Environment.Functions:ToggleNoClip()
    Environment.Settings.NoClipEnabled = not Environment.Settings.NoClipEnabled
    print(Environment.Settings.NoClipEnabled and "✓ NoClip Enabled" or "✗ NoClip Disabled")
end

--// Toggle Wallshot
function Environment.Functions:ToggleWallshot()
    Environment.WallshotSettings.Enabled = not Environment.WallshotSettings.Enabled
    print(Environment.WallshotSettings.Enabled and "✓ Wallshot Enabled" or "✗ Wallshot Disabled")
end

--// Toggle Menu
function Environment.Functions:ToggleMenu()
    MenuOpen = not MenuOpen
    print(MenuOpen and "✓ Menu Opened" or "✗ Menu Closed")
end

--// Typing Check
ServiceConnections.TypingStartedConnection = UserInputService.TextBoxFocused:Connect(function()
    Typing = true
end)

ServiceConnections.TypingEndedConnection = UserInputService.TextBoxFocusReleased:Connect(function()
    Typing = false
end)


--// Main Loop
local LastFPS = 0
local FPSCounter = 0

local function Load()
    CreateMenuUI()
    
    ServiceConnections.RenderSteppedConnection = RunService.RenderStepped:Connect(function()
        -- FPS Counter
        FPSCounter = FPSCounter + 1
        if tick() % 1 < 0.016 then
            LastFPS = FPSCounter
            FPSCounter = 0
        end
        
        if MenuUI.FPS and Environment.AdvancedSettings.ShowFPS then
            MenuUI.FPS.Text = "FPS: " .. LastFPS
            MenuUI.FPS.Visible = MenuOpen
        end
        
        -- FOV Circle
        if Environment.FOVSettings.Enabled and Environment.Settings.ESPEnabled then
            Environment.FOVCircle.Radius = Environment.FOVSettings.Amount
            Environment.FOVCircle.Thickness = Environment.FOVSettings.Thickness
            Environment.FOVCircle.Filled = Environment.FOVSettings.Filled
            Environment.FOVCircle.NumSides = Environment.FOVSettings.Sides
            Environment.FOVCircle.Color = Environment.FOVSettings.Color
            Environment.FOVCircle.Transparency = Environment.FOVSettings.Transparency
            Environment.FOVCircle.Visible = Environment.FOVSettings.Visible
            Environment.FOVCircle.Position = Vector2(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
        else
            Environment.FOVCircle.Visible = false
        end
        
        -- ESP
        if Environment.Settings.ESPEnabled then
            for _, Player in next, Players:GetPlayers() do
                if Player ~= LocalPlayer then
                    if not ESPObjects[Player] then
                        ESPObjects[Player] = CreateESPBox(Player)
                    end
                    
                    if ESPObjects[Player] then
                        UpdateESPBox(ESPObjects[Player])
                    end
                end
            end
        else
            ClearAllESP()
        end
        
        -- Aimbot
        AimbotTick()
        
        -- NoClip
        if Environment.Settings.NoClipEnabled then
            NoClipTick()
        end
        
        -- Update Menu
        if MenuUI.MainFrame then
            MenuUI.MainFrame.Visible = MenuOpen
            for _, Element in pairs(MenuUI.Elements) do
                if Element then
                    Element.Visible = MenuOpen
                end
            end
        end
    end)
    
    ServiceConnections.PlayerRemovedConnection = Players.PlayerRemoving:Connect(function(Player)
        RemoveESPBox(Player)
    end)
end

--// Functions
Environment.Functions = {}

function Environment.Functions:Exit()
    for _, Connection in next, ServiceConnections do
        if Connection and Connection.Disconnect then
            pcall(function() Connection:Disconnect() end)
        end
    end
    ClearAllESP()
    if Environment.FOVCircle and Environment.FOVCircle.Remove then
        pcall(function() Environment.FOVCircle:Remove() end)
    end
    for _, Element in pairs(MenuUI.Elements) do
        if Element and Element.Remove then
            pcall(function() Element:Remove() end)
        end
    end
    getgenv().CHEAT = nil
end

function Environment.Functions:Restart()
    for _, Connection in next, ServiceConnections do
        if Connection and Connection.Disconnect then
            pcall(function() Connection:Disconnect() end)
        end
    end
    ClearAllESP()
    Load()
end

function Environment.Functions:ResetSettings()
    Environment.Settings = {
        Enabled = true,
        AimbotEnabled = false,
        ESPEnabled = true,
        WallshotEnabled = false,
        NoClipEnabled = false,
        TeamCheck = false,
        AliveCheck = true,
        WallCheck = false,
        MaxDistance = 500,
        AimbotSensitivity = 0.5,
        AimbotSmoothing = 0.1,
        LockPart = "Head"
    }
end

--// Load
Load()

print("╔════════════════════════════════════════════════════════════╗")
print("║          ✓ RYSA CHEAT v2.0 LOADED                    ║")
print("║                                                            ║")
print("║  TOGGLE COMMANDS (NO KEY BINDINGS):                        ║")
print("║  getgenv().CHEAT.Functions:ToggleAimbot()                  ║")
print("║  getgenv().CHEAT.Functions:ToggleESP()                     ║")
print("║  getgenv().CHEAT.Functions:ToggleNoClip()                  ║")
print("║  getgenv().CHEAT.Functions:ToggleWallshot()                ║")
print("║  getgenv().CHEAT.Functions:ToggleMenu()                    ║")
print("║                                                            ║")
print("║  FRIEND LIST COMMANDS:                                     ║")
print("║  getgenv().CHEAT.Functions:AddFriend('PlayerName')         ║")
print("║  getgenv().CHEAT.Functions:RemoveFriend('PlayerName')      ║")
print("║  getgenv().CHEAT.Functions:GetFriendList()                 ║")
print("║                                                            ║")
print("║  SETTINGS:                                                 ║")
print("║  getgenv().CHEAT.Settings                                  ║")
print("║  getgenv().CHEAT.ESPSettings                               ║")
print("║  getgenv().CHEAT.AimbotSettings                            ║")
print("║  getgenv().CHEAT.FOVSettings                               ║")
print("║  getgenv().CHEAT.WallshotSettings                          ║")
print("║  getgenv().CHEAT.AdvancedSettings                          ║")
print("║  getgenv().CHEAT.MenuSettings                              ║")
print("║                                                            ║")
print("║  AIMBOT AÇINCA DIREKT KİTLENİR!                            ║")
print("║  (Aimbot enabled = instant lock)                           ║")
print("║                                                            ║")
print("╚════════════════════════════════════════════════════════════╝")
