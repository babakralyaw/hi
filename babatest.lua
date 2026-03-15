--[[
AVOCAT HUB - PROFESSIONAL AIMBOT + ESP EKLENTİSİ
Tüm ayarlar menüye eklendi
F7 ile menü
]]

local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LP:GetMouse()
local CoreGui = game:GetService("CoreGui")

-- Ana menüyü bul
local MainGui = CoreGui:FindFirstChild("AvocatHub") or LP.PlayerGui:FindFirstChild("AvocatHub")
if not MainGui then
    warn("Avocat Hub bulunamadı! Önce ana scripti çalıştır.")
    return
end

-- Aimbot ayarları
local AimbotSettings = {
    Enabled = false,
    Key = "MouseButton2", -- Sağ tık
    FOV = 150,
    ShowFOV = true,
    FOVColor = Color3.fromRGB(255, 255, 255),
    FOVFilled = false,
    Smoothness = 5,
    Prediction = 0.15,
    TargetPart = "Head", -- Head, Torso, Root, Random
    TeamCheck = true,
    WallCheck = true,
    VisibilityCheck = true,
    SilentAim = false,
    AutoShoot = false,
    
    -- ESP Ayarları
    ESP = {
        Enabled = true,
        Boxes = true,
        BoxColor = Color3.fromRGB(255, 255, 255),
        BoxOutline = true,
        Names = true,
        NameColor = Color3.fromRGB(255, 255, 255),
        Distance = true,
        DistanceColor = Color3.fromRGB(255, 255, 0),
        HealthBar = true,
        HealthBarColor = Color3.fromRGB(0, 255, 0),
        Tracer = false,
        TracerColor = Color3.fromRGB(255, 255, 255),
        HeadDot = false,
        HeadDotColor = Color3.fromRGB(255, 0, 0),
        Skeleton = false,
        SkeletonColor = Color3.fromRGB(255, 255, 255),
        TeamColor = true,
        CustomColors = {
            Killer = Color3.fromRGB(255, 0, 0),
            Innocent = Color3.fromRGB(255, 255, 255),
            Sheriff = Color3.fromRGB(0, 255, 0),
            Self = Color3.fromRGB(0, 255, 255)
        }
    }
}

-- FOV çemberi
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1.5
FOVCircle.NumSides = 60
FOVCircle.Radius = AimbotSettings.FOV
FOVCircle.Color = AimbotSettings.FOVColor
FOVCircle.Filled = AimbotSettings.FOVFilled
FOVCircle.Visible = false

-- ESP nesneleri
local ESPObjects = {}

-- Renk tablosu
local Colors = {
    Bg = Color3.fromRGB(10, 10, 10),
    Bg2 = Color3.fromRGB(18, 18, 18),
    Ac = Color3.fromRGB(48, 48, 48),
    AcH = Color3.fromRGB(62, 62, 62),
    W = Color3.fromRGB(255, 255, 255),
    D = Color3.fromRGB(130, 130, 130),
    R = Color3.fromRGB(160, 35, 35)
}

-- Yardımcı fonksiyonlar
local function CreateDrag(frame, obj)
    local dragging, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = obj.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

local function RoundCorner(frame, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 6)
    corner.Parent = frame
end

local function CreateButton(parent, text, color, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.BackgroundColor3 = color or Colors.Ac
    btn.BorderSizePixel = 0
    btn.Size = UDim2.new(1, -10, 0, 28)
    btn.Font = Enum.Font.Gotham
    btn.Text = text
    btn.TextColor3 = Colors.W
    btn.TextSize = 11
    btn.AutoButtonColor = false
    RoundCorner(btn, 6)
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.08), {BackgroundColor3 = Colors.AcH}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.08), {BackgroundColor3 = color or Colors.Ac}):Play()
    end)
    
    if callback then
        btn.MouseButton1Click:Connect(callback)
    end
    
    return btn
end

local function CreateToggle(parent, text, setting, defaultValue)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundColor3 = Colors.Bg
    frame.BorderSizePixel = 0
    frame.Size = UDim2.new(1, -10, 0, 28)
    RoundCorner(frame, 6)
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 8, 0, 0)
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Font = Enum.Font.Gotham
    label.Text = text
    label.TextColor3 = Colors.W
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local toggle = Instance.new("TextButton")
    toggle.Parent = frame
    toggle.BackgroundColor3 = defaultValue and Colors.Ac or Colors.Bg2
    toggle.BorderSizePixel = 0
    toggle.Position = UDim2.new(1, -44, 0, 4)
    toggle.Size = UDim2.new(0, 36, 0, 20)
    toggle.Font = Enum.Font.GothamBold
    toggle.Text = defaultValue and "ON" or "OFF"
    toggle.TextColor3 = defaultValue and Colors.W or Colors.D
    toggle.TextSize = 9
    toggle.AutoButtonColor = false
    RoundCorner(toggle, 4)
    
    local state = defaultValue
    
    toggle.MouseButton1Click:Connect(function()
        state = not state
        toggle.BackgroundColor3 = state and Colors.Ac or Colors.Bg2
        toggle.Text = state and "ON" or "OFF"
        toggle.TextColor3 = state and Colors.W or Colors.D
        setting(state)
    end)
    
    return {
        set = function(s)
            if s ~= state then
                state = s
                toggle.BackgroundColor3 = state and Colors.Ac or Colors.Bg2
                toggle.Text = state and "ON" or "OFF"
                toggle.TextColor3 = state and Colors.W or Colors.D
                setting(state)
            end
        end,
        get = function() return state end
    }
end

local function CreateSlider(parent, text, setting, min, max, defaultValue, format)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundColor3 = Colors.Bg
    frame.BorderSizePixel = 0
    frame.Size = UDim2.new(1, -10, 0, 40)
    RoundCorner(frame, 6)
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 8, 0, 5)
    label.Size = UDim2.new(1, -60, 0, 16)
    label.Font = Enum.Font.Gotham
    label.Text = text .. ": " .. (format and format(defaultValue) or defaultValue)
    label.TextColor3 = Colors.D
    label.TextSize = 10
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Parent = frame
    valueLabel.BackgroundTransparency = 1
    valueLabel.Position = UDim2.new(1, -50, 0, 5)
    valueLabel.Size = UDim2.new(0, 40, 0, 16)
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.Text = format and format(defaultValue) or defaultValue
    valueLabel.TextColor3 = Colors.W
    valueLabel.TextSize = 10
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    
    local sliderBg = Instance.new("Frame")
    sliderBg.Parent = frame
    sliderBg.BackgroundColor3 = Colors.Bg2
    sliderBg.BorderSizePixel = 0
    sliderBg.Position = UDim2.new(0, 8, 0, 24)
    sliderBg.Size = UDim2.new(1, -16, 0, 10)
    RoundCorner(sliderBg, 4)
    
    local fill = Instance.new("Frame")
    fill.Parent = sliderBg
    fill.BackgroundColor3 = Colors.Ac
    fill.BorderSizePixel = 0
    fill.Size = UDim2.new((defaultValue - min) / (max - min), 0, 1, 0)
    RoundCorner(fill, 4)
    
    local dragging = false
    local value = defaultValue
    
    sliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local pos = UIS:GetMouseLocation()
            local absPos = sliderBg.AbsolutePosition
            local size = sliderBg.AbsoluteSize.X
            local percent = math.clamp((pos.X - absPos.X) / size, 0, 1)
            value = min + (max - min) * percent
            if math.type(value) == "integer" then
                value = math.floor(value)
            else
                value = math.floor(value * 10) / 10
            end
            fill.Size = UDim2.new(percent, 0, 1, 0)
            label.Text = text .. ": " .. (format and format(value) or value)
            valueLabel.Text = format and format(value) or value
            setting(value)
        end
    end)
end

local function CreateDropdown(parent, text, setting, options, defaultValue)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundColor3 = Colors.Bg
    frame.BorderSizePixel = 0
    frame.Size = UDim2.new(1, -10, 0, 36)
    RoundCorner(frame, 6)
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 8, 0, 0)
    label.Size = UDim2.new(0.5, -15, 1, 0)
    label.Font = Enum.Font.Gotham
    label.Text = text
    label.TextColor3 = Colors.W
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local dropdown = Instance.new("TextButton")
    dropdown.Parent = frame
    dropdown.BackgroundColor3 = Colors.Bg2
    dropdown.BorderSizePixel = 0
    dropdown.Position = UDim2.new(0.5, -5, 0, 4)
    dropdown.Size = UDim2.new(0.5, -10, 0, 28)
    dropdown.Font = Enum.Font.Gotham
    dropdown.Text = defaultValue
    dropdown.TextColor3 = Colors.W
    dropdown.TextSize = 10
    dropdown.AutoButtonColor = false
    RoundCorner(dropdown, 6)
    
    local dropFrame = Instance.new("Frame")
    dropFrame.Parent = frame
    dropFrame.BackgroundColor3 = Colors.Bg2
    dropFrame.BorderSizePixel = 0
    dropFrame.Position = UDim2.new(0.5, -5, 0, 32)
    dropFrame.Size = UDim2.new(0.5, -10, 0, 0)
    dropFrame.ClipsDescendants = true
    dropFrame.Visible = false
    RoundCorner(dropFrame, 6)
    
    local dropList = Instance.new("UIListLayout")
    dropList.Parent = dropFrame
    dropList.SortOrder = Enum.SortOrder.LayoutOrder
    
    local open = false
    
    for _, option in ipairs(options) do
        local btn = Instance.new("TextButton")
        btn.Parent = dropFrame
        btn.BackgroundColor3 = Colors.Bg2
        btn.BorderSizePixel = 0
        btn.Size = UDim2.new(1, 0, 0, 28)
        btn.Font = Enum.Font.Gotham
        btn.Text = option
        btn.TextColor3 = Colors.D
        btn.TextSize = 10
        btn.AutoButtonColor = false
        
        btn.MouseEnter:Connect(function()
            btn.BackgroundColor3 = Colors.Ac
            btn.TextColor3 = Colors.W
        end)
        
        btn.MouseLeave:Connect(function()
            btn.BackgroundColor3 = Colors.Bg2
            btn.TextColor3 = Colors.D
        end)
        
        btn.MouseButton1Click:Connect(function()
            dropdown.Text = option
            setting(option)
            dropFrame.Visible = false
            open = false
            frame.Size = UDim2.new(1, -10, 0, 36)
        end)
    end
    
    dropdown.MouseButton1Click:Connect(function()
        open = not open
        dropFrame.Visible = open
        if open then
            local count = #options
            dropFrame.Size = UDim2.new(0.5, -10, 0, count * 28)
            frame.Size = UDim2.new(1, -10, 0, 36 + count * 28)
        else
            dropFrame.Size = UDim2.new(0.5, -10, 0, 0)
            frame.Size = UDim2.new(1, -10, 0, 36)
        end
    end)
end

local function CreateColorPicker(parent, text, setting, defaultColor)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundColor3 = Colors.Bg
    frame.BorderSizePixel = 0
    frame.Size = UDim2.new(1, -10, 0, 36)
    RoundCorner(frame, 6)
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 8, 0, 0)
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Font = Enum.Font.Gotham
    label.Text = text
    label.TextColor3 = Colors.W
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local colorBox = Instance.new("Frame")
    colorBox.Parent = frame
    colorBox.BackgroundColor3 = defaultColor
    colorBox.BorderSizePixel = 1
    colorBox.BorderColor3 = Colors.W
    colorBox.Position = UDim2.new(1, -44, 0, 8)
    colorBox.Size = UDim2.new(0, 36, 0, 20)
    RoundCorner(colorBox, 4)
    
    -- Basit renk seçici (R,G,B sliderları eklenebilir)
    colorBox.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            -- Renk seçici dialog eklenebilir
        end
    end)
end

-- Aimbot paneli oluştur
local AimbotPanel = Instance.new("Frame")
AimbotPanel.Parent = MainGui
AimbotPanel.BackgroundColor3 = Colors.Bg
AimbotPanel.BorderSizePixel = 0
AimbotPanel.AnchorPoint = Vector2.new(0.5, 0.5)
AimbotPanel.Position = UDim2.new(0.5, 0, 0.5, 0)
AimbotPanel.Size = UDim2.new(0, 400, 0, 500)
AimbotPanel.ClipsDescendants = true
AimbotPanel.Visible = false
RoundCorner(AimbotPanel, 10)
Instance.new("UIStroke", AimbotPanel).Color = Colors.Ac

-- Başlık çubuğu
local TitleBar = Instance.new("Frame")
TitleBar.Parent = AimbotPanel
TitleBar.BackgroundColor3 = Colors.Bg2
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2.new(1, 0, 0, 30)
RoundCorner(TitleBar, 10)

local Title = Instance.new("TextLabel")
Title.Parent = TitleBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "AIMBOT & ESP"
Title.TextColor3 = Colors.W
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = TitleBar
CloseBtn.BackgroundColor3 = Colors.Bg2
CloseBtn.BorderSizePixel = 0
CloseBtn.Position = UDim2.new(1, -28, 0, 0)
CloseBtn.Size = UDim2.new(0, 28, 0, 30)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Colors.D
CloseBtn.TextSize = 11
CloseBtn.AutoButtonColor = false
RoundCorner(CloseBtn, 6)

CloseBtn.MouseEnter:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.08), {BackgroundColor3 = Colors.R}):Play()
end)
CloseBtn.MouseLeave:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.08), {BackgroundColor3 = Colors.Bg2}):Play()
end)

CloseBtn.MouseButton1Click:Connect(function()
    AimbotPanel.Visible = false
end)

CreateDrag(TitleBar, AimbotPanel)

-- Scroll frame
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Parent = AimbotPanel
ScrollFrame.BackgroundColor3 = Colors.Bg
ScrollFrame.BorderSizePixel = 0
ScrollFrame.Position = UDim2.new(0, 0, 0, 34)
ScrollFrame.Size = UDim2.new(1, 0, 1, -34)
ScrollFrame.ScrollBarThickness = 3
ScrollFrame.ScrollBarImageColor3 = Colors.Ac
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

local Padding = Instance.new("UIPadding")
Padding.Parent = ScrollFrame
Padding.PaddingTop = UDim.new(0, 4)
Padding.PaddingBottom = UDim.new(0, 4)
Padding.PaddingLeft = UDim.new(0, 4)
Padding.PaddingRight = UDim.new(0, 4)

local ListLayout = Instance.new("UIListLayout")
ListLayout.Parent = ScrollFrame
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Padding = UDim.new(0, 4)

-- Aimbot Ayarları
local Section1 = Instance.new("TextLabel")
Section1.Parent = ScrollFrame
Section1.BackgroundColor3 = Colors.Bg2
Section1.BorderSizePixel = 0
Section1.Size = UDim2.new(1, -10, 0, 20)
Section1.Font = Enum.Font.GothamBold
Section1.Text = "  AIMBOT SETTINGS"
Section1.TextColor3 = Colors.D
Section1.TextSize = 10
Section1.TextXAlignment = Enum.TextXAlignment.Left
RoundCorner(Section1, 6)

-- Aimbot toggle
local aimToggle = CreateToggle(ScrollFrame, "Aimbot", function(state)
    AimbotSettings.Enabled = state
    FOVCircle.Visible = state and AimbotSettings.ShowFOV
end, false)

-- Key seçimi
local keys = {}
for _, key in ipairs({"MouseButton1", "MouseButton2", "LeftAlt", "LeftControl", "LeftShift", "RightShift", "X", "C", "V", "B"}) do
    table.insert(keys, key)
end
CreateDropdown(ScrollFrame, "Aimbot Key", function(value)
    AimbotSettings.Key = value
end, keys, "MouseButton2")

-- Target part
CreateDropdown(ScrollFrame, "Target Part", function(value)
    AimbotSettings.TargetPart = value
end, {"Head", "Torso", "Root", "Random"}, "Head")

-- FOV ayarları
CreateToggle(ScrollFrame, "Show FOV Circle", function(state)
    AimbotSettings.ShowFOV = state
    FOVCircle.Visible = state and AimbotSettings.Enabled
end, true)

CreateSlider(ScrollFrame, "FOV Size", function(value)
    AimbotSettings.FOV = value
    FOVCircle.Radius = value
end, 10, 500, 150)

CreateColorPicker(ScrollFrame, "FOV Color", function(color)
    AimbotSettings.FOVColor = color
    FOVCircle.Color = color
end, Color3.fromRGB(255, 255, 255))

CreateToggle(ScrollFrame, "FOV Filled", function(state)
    AimbotSettings.FOVFilled = state
    FOVCircle.Filled = state
end, false)

-- Smoothing ve prediction
CreateSlider(ScrollFrame, "Smoothness", function(value)
    AimbotSettings.Smoothness = value
end, 1, 20, 5, function(v) return v .. "x" end)

CreateSlider(ScrollFrame, "Prediction", function(value)
    AimbotSettings.Prediction = value / 100
end, 0, 50, 15, function(v) return v/100 .. "s" end)

-- Checkler
CreateToggle(ScrollFrame, "Team Check", function(state)
    AimbotSettings.TeamCheck = state
end, true)

CreateToggle(ScrollFrame, "Wall Check", function(state)
    AimbotSettings.WallCheck = state
end, true)

CreateToggle(ScrollFrame, "Visibility Check", function(state)
    AimbotSettings.VisibilityCheck = state
end, true)

CreateToggle(ScrollFrame, "Silent Aim", function(state)
    AimbotSettings.SilentAim = state
end, false)

CreateToggle(ScrollFrame, "Auto Shoot", function(state)
    AimbotSettings.AutoShoot = state
end, false)

-- ESP Ayarları
local Section2 = Instance.new("TextLabel")
Section2.Parent = ScrollFrame
Section2.BackgroundColor3 = Colors.Bg2
Section2.BorderSizePixel = 0
Section2.Size = UDim2.new(1, -10, 0, 20)
Section2.Font = Enum.Font.GothamBold
Section2.Text = "  ESP SETTINGS"
Section2.TextColor3 = Colors.D
Section2.TextSize = 10
Section2.TextXAlignment = Enum.TextXAlignment.Left
RoundCorner(Section2, 6)

-- ESP toggle
CreateToggle(ScrollFrame, "ESP Enabled", function(state)
    AimbotSettings.ESP.Enabled = state
end, true)

-- ESP bileşenleri
CreateToggle(ScrollFrame, "Show Boxes", function(state)
    AimbotSettings.ESP.Boxes = state
end, true)

CreateColorPicker(ScrollFrame, "Box Color", function(color)
    AimbotSettings.ESP.BoxColor = color
end, Color3.fromRGB(255, 255, 255))

CreateToggle(ScrollFrame, "Box Outline", function(state)
    AimbotSettings.ESP.BoxOutline = state
end, true)

CreateToggle(ScrollFrame, "Show Names", function(state)
    AimbotSettings.ESP.Names = state
end, true)

CreateColorPicker(ScrollFrame, "Name Color", function(color)
    AimbotSettings.ESP.NameColor = color
end, Color3.fromRGB(255, 255, 255))

CreateToggle(ScrollFrame, "Show Distance", function(state)
    AimbotSettings.ESP.Distance = state
end, true)

CreateColorPicker(ScrollFrame, "Distance Color", function(color)
    AimbotSettings.ESP.DistanceColor = color
end, Color3.fromRGB(255, 255, 0))

CreateToggle(ScrollFrame, "Health Bar", function(state)
    AimbotSettings.ESP.HealthBar = state
end, true)

CreateToggle(ScrollFrame, "Tracer", function(state)
    AimbotSettings.ESP.Tracer = state
end, false)

CreateColorPicker(ScrollFrame, "Tracer Color", function(color)
    AimbotSettings.ESP.TracerColor = color
end, Color3.fromRGB(255, 255, 255))

CreateToggle(ScrollFrame, "Head Dot", function(state)
    AimbotSettings.ESP.HeadDot = state
end, false)

CreateColorPicker(ScrollFrame, "Head Dot Color", function(color)
    AimbotSettings.ESP.HeadDotColor = color
end, Color3.fromRGB(255, 0, 0))

CreateToggle(ScrollFrame, "Skeleton", function(state)
    AimbotSettings.ESP.Skeleton = state
end, false)

CreateColorPicker(ScrollFrame, "Skeleton Color", function(color)
    AimbotSettings.ESP.SkeletonColor = color
end, Color3.fromRGB(255, 255, 255))

-- Role renkleri
local Section3 = Instance.new("TextLabel")
Section3.Parent = ScrollFrame
Section3.BackgroundColor3 = Colors.Bg2
Section3.BorderSizePixel = 0
Section3.Size = UDim2.new(1, -10, 0, 20)
Section3.Font = Enum.Font.GothamBold
Section3.Text = "  ROLE COLORS"
Section3.TextColor3 = Colors.D
Section3.TextSize = 10
Section3.TextXAlignment = Enum.TextXAlignment.Left
RoundCorner(Section3, 6)

CreateColorPicker(ScrollFrame, "Killer Color", function(color)
    AimbotSettings.ESP.CustomColors.Killer = color
end, Color3.fromRGB(255, 0, 0))

CreateColorPicker(ScrollFrame, "Innocent Color", function(color)
    AimbotSettings.ESP.CustomColors.Innocent = color
end, Color3.fromRGB(255, 255, 255))

CreateColorPicker(ScrollFrame, "Sheriff Color", function(color)
    AimbotSettings.ESP.CustomColors.Sheriff = color
end, Color3.fromRGB(0, 255, 0))

CreateColorPicker(ScrollFrame, "Self Color", function(color)
    AimbotSettings.ESP.CustomColors.Self = color
end, Color3.fromRGB(0, 255, 255))

CreateToggle(ScrollFrame, "Use Team Colors", function(state)
    AimbotSettings.ESP.TeamColor = state
end, true)

-- CanvasSize güncelle
task.wait()
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 20)

-- Ana menüye buton ekle
local MainMenu = MainGui:FindFirstChild("MainFrame")
if MainMenu then
    local TopBar = MainMenu:FindFirstChild("Top")
    if TopBar then
        local AimbotBtn = Instance.new("TextButton")
        AimbotBtn.Parent = TopBar
        AimbotBtn.BackgroundColor3 = Colors.Bg2
        AimbotBtn.BorderSizePixel = 0
        AimbotBtn.Position = UDim2.new(1, -80, 0, 0)
        AimbotBtn.Size = UDim2.new(0, 50, 0, 30)
        AimbotBtn.Font = Enum.Font.GothamBold
        AimbotBtn.Text = "AIM"
        AimbotBtn.TextColor3 = Colors.W
        AimbotBtn.TextSize = 11
        AimbotBtn.AutoButtonColor = false
        RoundCorner(AimbotBtn, 6)
        
        AimbotBtn.MouseEnter:Connect(function()
            TweenService:Create(AimbotBtn, TweenInfo.new(0.08), {BackgroundColor3 = Colors.Ac}):Play()
        end)
        AimbotBtn.MouseLeave:Connect(function()
            TweenService:Create(AimbotBtn, TweenInfo.new(0.08), {BackgroundColor3 = Colors.Bg2}):Play()
        end)
        
        AimbotBtn.MouseButton1Click:Connect(function()
            AimbotPanel.Visible = not AimbotPanel.Visible
        end)
    end
end

-- ESP oluşturma fonksiyonları
local function GetPlayerRole(player)
    if player == LP then return "Self" end
    
    local char = player.Character
    if not char then return "Innocent" end
    
    local tool = char:FindFirstChildOfClass("Tool")
    if tool then
        if tool.Name:lower():find("knife") or tool.Name:lower():find("gun") then
            return "Killer"
        end
    end
    
    return "Innocent"
end

local function GetPlayerColor(player)
    if not AimbotSettings.ESP.TeamColor then
        return AimbotSettings.ESP.BoxColor
    end
    
    local role = GetPlayerRole(player)
    return AimbotSettings.ESP.CustomColors[role] or AimbotSettings.ESP.BoxColor
end

local function CreateESP(player)
    if player == LP then return end
    
    ESPObjects[player] = {
        Box = Drawing.new("Square"),
        BoxOutline = Drawing.new("Square"),
        Name = Drawing.new("Text"),
        Distance = Drawing.new("Text"),
        HealthBar = Drawing.new("Square"),
        HealthBarBg = Drawing.new("Square"),
        Tracer = Drawing.new("Line"),
        HeadDot = Drawing.new("Circle")
    }
    
    -- Box
    ESPObjects[player].Box.Thickness = 1.5
    ESPObjects[player].Box.Filled = false
    ESPObjects[player].Box.Visible = false
    
    ESPObjects[player].BoxOutline.Thickness = 3
    ESPObjects[player].BoxOutline.Color = Color3.fromRGB(0, 0, 0)
    ESPObjects[player].BoxOutline.Filled = false
    ESPObjects[player].BoxOutline.Visible = false
    
    -- Name
    ESPObjects[player].Name.Size = 14
    ESPObjects[player].Name.Center = true
    ESPObjects[player].Name.Outline = true
    ESPObjects[player].Name.OutlineColor = Color3.fromRGB(0, 0, 0)
    ESPObjects[player].Name.Visible = false
    
    -- Distance
    ESPObjects[player].Distance.Size = 12
    ESPObjects[player].Distance.Center = true
    ESPObjects[player].Distance.Outline = true
    ESPObjects[player].Distance.Visible = false
    
    -- HealthBar
    ESPObjects[player].HealthBarBg.Filled = true
    ESPObjects[player].HealthBarBg.Color = Color3.fromRGB(30, 30, 30)
    ESPObjects[player].HealthBarBg.Visible = false
    
    ESPObjects[player].HealthBar.Filled = true
    ESPObjects[player].HealthBar.Visible = false
    
    -- Tracer
    ESPObjects[player].Tracer.Thickness = 1.5
    ESPObjects[player].Tracer.Visible = false
    
    -- HeadDot
    ESPObjects[player].HeadDot.Thickness = 1
    ESPObjects[player].HeadDot.NumSides = 30
    ESPObjects[player].HeadDot.Radius = 4
    ESPObjects[player].HeadDot.Filled = true
    ESPObjects[player].HeadDot.Visible = false
end

-- Mevcut oyuncular için ESP oluştur
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LP then
        CreateESP(player)
    end
end

-- Yeni oyuncular için
Players.PlayerAdded:Connect(function(player)
    if player ~= LP then
        CreateESP(player)
    end
end)

-- Oyuncu ayrıldığında
Players.PlayerRemoving:Connect(function(player)
    if ESPObjects[player] then
        for _, obj in pairs(ESPObjects[player]) do
            pcall(function() obj:Remove() end)
        end
        ESPObjects[player] = nil
    end
end)

-- Line of sight kontrolü
local RaycastParams = RaycastParams.new()
RaycastParams.FilterType = Enum.RaycastFilterType.Exclude

local function IsVisible(from, to, ignore)
    RaycastParams.FilterDescendantsInstances = ignore
    local result = workspace:Raycast(from, to - from, RaycastParams)
    return not result
end

-- Aimbot hedef bulma
local function GetClosestTarget()
    local closest = nil
    local shortestDist = AimbotSettings.FOV
    local mousePos = UIS:GetMouseLocation()
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LP and player.Character then
            -- Team check
            if AimbotSettings.TeamCheck then
                local role = GetPlayerRole(player)
                if role == "Innocent" or role == "Sheriff" then
                    continue
                end
            end
            
            local targetPart = player.Character:FindFirstChild(AimbotSettings.TargetPart)
            if not targetPart then
                targetPart = player.Character:FindFirstChild("Head")
            end
            
            if targetPart then
                local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                
                if onScreen or not AimbotSettings.VisibilityCheck then
                    -- Wall check
                    if AimbotSettings.WallCheck then
                        local visible = IsVisible(
                            Camera.CFrame.Position,
                            targetPart.Position,
                            {LP.Character, player.Character}
                        )
                        if not visible then
                            continue
                        end
                    end
                    
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                    if dist < shortestDist then
                        shortestDist = dist
                        closest = {
                            Player = player,
                            Part = targetPart,
                            ScreenPos = screenPos,
                            Position = targetPart.Position
                        }
                    end
                end
            end
        end
    end
    
    return closest
end

-- Ana döngü
RunService.RenderStepped:Connect(function()
    -- FOV çemberi
    if AimbotSettings.ShowFOV and AimbotSettings.Enabled then
        FOVCircle.Position = UIS:GetMouseLocation()
        FOVCircle.Visible = true
    else
        FOVCircle.Visible = false
    end
    
    -- Aimbot
    if AimbotSettings.Enabled then
        local keyPressed = false
        if AimbotSettings.Key == "MouseButton1" then
            keyPressed = UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
        elseif AimbotSettings.Key == "MouseButton2" then
            keyPressed = UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
        else
            keyPressed = UIS:IsKeyDown(Enum.KeyCode[AimbotSettings.Key])
        end
        
        if keyPressed then
            local target = GetClosestTarget()
            if target then
                local targetPos = target.Position
                
                -- Prediction
                if AimbotSettings.Prediction > 0 then
                    local velocity = target.Part.AssemblyLinearVelocity or Vector3.zero
                    targetPos = targetPos + velocity * AimbotSettings.Prediction
                end
                
                -- Smooth aim
                if AimbotSettings.Smoothness > 1 then
                    local currentPos = Camera.CFrame.Position
                    local targetCF = CFrame.lookAt(currentPos, targetPos)
                    Camera.CFrame = Camera.CFrame:Lerp(targetCF, 1 / AimbotSettings.Smoothness)
                else
                    Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, targetPos)
                end
                
                -- Auto shoot
                if AimbotSettings.AutoShoot then
                    local tool = LP.Character and LP.Character:FindFirstChildOfClass("Tool")
                    if tool then
                        tool:Activate()
                    end
                end
            end
        end
    end
    
    -- ESP
    if AimbotSettings.ESP.Enabled then
        for player, objects in pairs(ESPObjects) do
            if player and player.Character then
                local root = player.Character:FindFirstChild("HumanoidRootPart")
                local head = player.Character:FindFirstChild("Head")
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                
                if root and head and humanoid and humanoid.Health > 0 then
                    local rootPos, rootVis = Camera:WorldToViewportPoint(root.Position)
                    local headPos, headVis = Camera:WorldToViewportPoint(head.Position)
                    
                    if rootVis or headVis then
                        local color = GetPlayerColor(player)
                        local distance = (LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") and 
                                         (LP.Character.HumanoidRootPart.Position - root.Position).Magnitude) or 0
                        
                        -- 2D Box
                        local size = Vector2.new(4000 / distance, 5000 / distance)
                        local boxPos = Vector2.new(rootPos.X - size.X/2, rootPos.Y - size.Y/2)
                        
                        if AimbotSettings.ESP.Boxes then
                            objects.Box.Color = color
                            objects.Box.Size = size
                            objects.Box.Position = boxPos
                            objects.Box.Visible = true
                            
                            if AimbotSettings.ESP.BoxOutline then
                                objects.BoxOutline.Position = boxPos
                                objects.BoxOutline.Size = size
                                objects.BoxOutline.Visible = true
                            end
                        else
                            objects.Box.Visible = false
                            objects.BoxOutline.Visible = false
                        end
                        
                        -- Name
                        if AimbotSettings.ESP.Names then
                            objects.Name.Text = player.Name
                            objects.Name.Position = Vector2.new(rootPos.X, rootPos.Y - size.Y/2 - 20)
                            objects.Name.Color = AimbotSettings.ESP.NameColor
                            objects.Name.Visible = true
                        else
                            objects.Name.Visible = false
                        end
                        
                        -- Distance
                        if AimbotSettings.ESP.Distance then
                            objects.Distance.Text = string.format("%.1fm", distance)
                            objects.Distance.Position = Vector2.new(rootPos.X, rootPos.Y + size.Y/2 + 5)
                            objects.Distance.Color = AimbotSettings.ESP.DistanceColor
                            objects.Distance.Visible = true
                        else
                            objects.Distance.Visible = false
                        end
                        
                        -- Health Bar
                        if AimbotSettings.ESP.HealthBar then
                            local healthPercent = humanoid.Health / humanoid.MaxHealth
                            
                            objects.HealthBarBg.Size = Vector2.new(4, size.Y + 4)
                            objects.HealthBarBg.Position = Vector2.new(boxPos.X - 6, boxPos.Y - 2)
                            objects.HealthBarBg.Visible = true
                            
                            objects.HealthBar.Color = Color3.fromRGB(
                                255 - (255 * healthPercent),
                                255 * healthPercent,
                                0
                            )
                            objects.HealthBar.Size = Vector2.new(4, (size.Y + 4) * healthPercent)
                            objects.HealthBar.Position = Vector2.new(boxPos.X - 6, boxPos.Y - 2 + (size.Y + 4) * (1 - healthPercent))
                            objects.HealthBar.Visible = true
                        else
                            objects.HealthBarBg.Visible = false
                            objects.HealthBar.Visible = false
                        end
                        
                        -- Tracer
                        if AimbotSettings.ESP.Tracer then
                            objects.Tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                            objects.Tracer.To = Vector2.new(rootPos.X, rootPos.Y)
                            objects.Tracer.Color = AimbotSettings.ESP.TracerColor
                            objects.Tracer.Visible = true
                        else
                            objects.Tracer.Visible = false
                        end
                        
                        -- Head Dot
                        if AimbotSettings.ESP.HeadDot and headVis then
                            objects.HeadDot.Position = Vector2.new(headPos.X, headPos.Y)
                            objects.HeadDot.Color = AimbotSettings.ESP.HeadDotColor
                            objects.HeadDot.Visible = true
                        else
                            objects.HeadDot.Visible = false
                        end
                    else
                        objects.Box.Visible = false
                        objects.BoxOutline.Visible = false
                        objects.Name.Visible = false
                        objects.Distance.Visible = false
                        objects.HealthBarBg.Visible = false
                        objects.HealthBar.Visible = false
                        objects.Tracer.Visible = false
                        objects.HeadDot.Visible = false
                    end
                else
                    objects.Box.Visible = false
                    objects.BoxOutline.Visible = false
                    objects.Name.Visible = false
                    objects.Distance.Visible = false
                    objects.HealthBarBg.Visible = false
                    objects.HealthBar.Visible = false
                    objects.Tracer.Visible = false
                    objects.HeadDot.Visible = false
                end
            end
        end
    else
        for _, objects in pairs(ESPObjects) do
            objects.Box.Visible = false
            objects.BoxOutline.Visible = false
            objects.Name.Visible = false
            objects.Distance.Visible = false
            objects.HealthBarBg.Visible = false
            objects.HealthBar.Visible = false
            objects.Tracer.Visible = false
            objects.HeadDot.Visible = false
        end
    end
end)

print("✅ Aimbot + ESP eklentisi yüklendi!")
print("📌 Ana menüdeki 'AIM' butonuna tıkla")
