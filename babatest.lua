--[[
RYSA CHEAT + BLADE BALL MODULE
Tüm özellikler tek menüde birleştirildi
Menü: RightShift (Sağ Shift)
]]

local TweenService=game:GetService("TweenService")
local UIS=game:GetService("UserInputService")
local LP=game:GetService("Players").LocalPlayer
local HS=game:GetService("HttpService")
local Players=game:GetService("Players")
local CoreGui=game:GetService("CoreGui")
local RunService=game:GetService("RunService")
local WS=game:GetService("Workspace")
local RS=game:GetService("ReplicatedStorage")
local TS=game:GetService("TeleportService")
local Lighting=game:GetService("Lighting")
local cam=WS.CurrentCamera
local mouse=LP:GetMouse()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

pcall(function() if CoreGui:FindFirstChild("RysaCheat") then CoreGui:FindFirstChild("RysaCheat"):Destroy() end end)
pcall(function() settings().Physics.AllowSleep=false end)
pcall(function() settings().Physics.PhysicsEnvironmentalThrottle=Enum.EnviromentalPhysicsThrottle.Disabled end)

local SKEY="RysaCheatCFG"
local DEF={toggleKey="RightShift",flyKey="F5",noclipKey="N",freecamKey="F6",godKey="G",espKey="",touchFlingKey="T",flingAllKey="",infJumpKey="",antiVoidKey="",fullbrightKey="",noFogKey="",antiAfkKey="",antiSlowKey="",autoload=false}
local function loadCFG() local s pcall(function() if readfile then s=HS:JSONDecode(readfile(SKEY..".json")) end end) if not s then s={} end for k,v in pairs(DEF) do if s[k]==nil then s[k]=v end end return s end
local function saveCFG(s) pcall(function() if writefile then writefile(SKEY..".json",HS:JSONEncode(s)) end end) end
local CFG=loadCFG()

local gui=Instance.new("ScreenGui") 
gui.Name="RysaCheat" 
gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling 
gui.ResetOnSpawn=false 
gui.Parent=LP:WaitForChild("PlayerGui")

local C={Bg=Color3.fromRGB(10,10,10),Bg2=Color3.fromRGB(18,18,18),Bg3=Color3.fromRGB(28,28,28),Ac=Color3.fromRGB(48,48,48),AcH=Color3.fromRGB(62,62,62),AcL=Color3.fromRGB(35,35,35),W=Color3.fromRGB(255,255,255),D=Color3.fromRGB(130,130,130),R=Color3.fromRGB(160,35,35),RH=Color3.fromRGB(200,50,50)}

--// YENI AIMBOT SİSTEMİ
local select = select
local pcall, getgenv, next, Vector2, mathclamp, type, mousemoverel = select(1, pcall, getgenv, next, Vector2.new, math.clamp, type, mousemoverel or (Input and Input.MouseMove))

pcall(function()
    getgenv().Aimbot.Functions:Exit()
end)

getgenv().Aimbot = {}
local Environment = getgenv().Aimbot

local RunService2 = game:GetService("RunService")
local UserInputService2 = game:GetService("UserInputService")
local TweenService2 = game:GetService("TweenService")
local Players2 = game:GetService("Players")
local Camera2 = workspace.CurrentCamera
local LocalPlayer2 = Players2.LocalPlayer

local RequiredDistance, Typing, Running, Animation, ServiceConnections = 2000, false, false, nil, {}

Environment.Settings = {
    Enabled = true,
    TeamCheck = false,
    AliveCheck = true,
    WallCheck = false,
    Sensitivity = 0,
    ThirdPerson = false,
    ThirdPersonSensitivity = 3,
    TriggerKey = "MouseButton2",
    Toggle = false,
    LockPart = "Head"
}

Environment.FOVSettings = {
    Enabled = true,
    Visible = true,
    Amount = 90,
    Color = Color3.fromRGB(255, 255, 255),
    LockedColor = Color3.fromRGB(255, 70, 70),
    Transparency = 0.5,
    Sides = 60,
    Thickness = 1,
    Filled = false
}

Environment.FOVCircle = Drawing.new("Circle")

local function CancelLock()
    Environment.Locked = nil
    if Animation then Animation:Cancel() end
    Environment.FOVCircle.Color = Environment.FOVSettings.Color
end

local function GetClosestPlayer()
    if not Environment.Locked then
        RequiredDistance = (Environment.FOVSettings.Enabled and Environment.FOVSettings.Amount or 2000)
        for _, v in next, Players2:GetPlayers() do
            if v ~= LocalPlayer2 then
                if v.Character and v.Character:FindFirstChild(Environment.Settings.LockPart) and v.Character:FindFirstChildOfClass("Humanoid") then
                    if Environment.Settings.TeamCheck and v.Team == LocalPlayer2.Team then continue end
                    if Environment.Settings.AliveCheck and v.Character:FindFirstChildOfClass("Humanoid").Health <= 0 then continue end
                    if Environment.Settings.WallCheck and #(Camera2:GetPartsObscuringTarget({v.Character[Environment.Settings.LockPart].Position}, v.Character:GetDescendants())) > 0 then continue end
                    
                    local Vector, OnScreen = Camera2:WorldToViewportPoint(v.Character[Environment.Settings.LockPart].Position)
                    local Distance = (Vector2(UserInputService2:GetMouseLocation().X, UserInputService2:GetMouseLocation().Y) - Vector2(Vector.X, Vector.Y)).Magnitude
                    if Distance < RequiredDistance and OnScreen then
                        RequiredDistance = Distance
                        Environment.Locked = v
                    end
                end
            end
        end
    else
        if (Vector2(UserInputService2:GetMouseLocation().X, UserInputService2:GetMouseLocation().Y) - Vector2(Camera2:WorldToViewportPoint(Environment.Locked.Character[Environment.Settings.LockPart].Position).X, Camera2:WorldToViewportPoint(Environment.Locked.Character[Environment.Settings.LockPart].Position).Y)).Magnitude > RequiredDistance then
            CancelLock()
        end
    end
end

ServiceConnections.TypingStartedConnection = UserInputService2.TextBoxFocused:Connect(function()
    Typing = true
end)

ServiceConnections.TypingEndedConnection = UserInputService2.TextBoxFocusReleased:Connect(function()
    Typing = false
end)

local function Load()
    ServiceConnections.RenderSteppedConnection = RunService2.RenderStepped:Connect(function()
        if Environment.FOVSettings.Enabled and Environment.Settings.Enabled then
            Environment.FOVCircle.Radius = Environment.FOVSettings.Amount
            Environment.FOVCircle.Thickness = Environment.FOVSettings.Thickness
            Environment.FOVCircle.Filled = Environment.FOVSettings.Filled
            Environment.FOVCircle.NumSides = Environment.FOVSettings.Sides
            Environment.FOVCircle.Color = Environment.FOVSettings.Color
            Environment.FOVCircle.Transparency = Environment.FOVSettings.Transparency
            Environment.FOVCircle.Visible = Environment.FOVSettings.Visible
            Environment.FOVCircle.Position = Vector2(UserInputService2:GetMouseLocation().X, UserInputService2:GetMouseLocation().Y)
        else
            Environment.FOVCircle.Visible = false
        end
        
        if Running and Environment.Settings.Enabled then
            GetClosestPlayer()
            if Environment.Locked then
                if Environment.Settings.ThirdPerson then
                    Environment.Settings.ThirdPersonSensitivity = mathclamp(Environment.Settings.ThirdPersonSensitivity, 0.1, 5)
                    local Vector = Camera2:WorldToViewportPoint(Environment.Locked.Character[Environment.Settings.LockPart].Position)
                    mousemoverel((Vector.X - UserInputService2:GetMouseLocation().X) * Environment.Settings.ThirdPersonSensitivity, (Vector.Y - UserInputService2:GetMouseLocation().Y) * Environment.Settings.ThirdPersonSensitivity)
                elseif Environment.Settings.Sensitivity > 0 then
                    Animation = TweenService2:Create(Camera2, TweenInfo.new(Environment.Settings.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera2.CFrame.Position, Environment.Locked.Character[Environment.Settings.LockPart].Position)})
                    Animation:Play()
                else
                    Camera2.CFrame = CFrame.new(Camera2.CFrame.Position, Environment.Locked.Character[Environment.Settings.LockPart].Position)
                end
            end
            Environment.FOVCircle.Color = Environment.FOVSettings.LockedColor
        end
    end)
    
    ServiceConnections.InputBeganConnection = UserInputService2.InputBegan:Connect(function(Input)
        if not Typing then
            pcall(function()
                if Input.KeyCode == Enum.KeyCode[Environment.Settings.TriggerKey] then
                    if Environment.Settings.Toggle then
                        Running = not Running
                        if not Running then
                            CancelLock()
                        end
                    else
                        Running = true
                    end
                end
            end)
            pcall(function()
                if Input.UserInputType == Enum.UserInputType[Environment.Settings.TriggerKey] then
                    if Environment.Settings.Toggle then
                        Running = not Running
                        if not Running then
                            CancelLock()
                        end
                    else
                        Running = true
                    end
                end
            end)
        end
    end)
    
    ServiceConnections.InputEndedConnection = UserInputService2.InputEnded:Connect(function(Input)
        if not Typing then
            if not Environment.Settings.Toggle then
                pcall(function()
                    if Input.KeyCode == Enum.KeyCode[Environment.Settings.TriggerKey] then
                        Running = false; CancelLock()
                    end
                end)
                pcall(function()
                    if Input.UserInputType == Enum.UserInputType[Environment.Settings.TriggerKey] then
                        Running = false; CancelLock()
                    end
                end)
            end
        end
    end)
end

Environment.Functions = {}

function Environment.Functions:Exit()
    for _, v in next, ServiceConnections do
        v:Disconnect()
    end
    if Environment.FOVCircle.Remove then Environment.FOVCircle:Remove() end
    getgenv().Aimbot.Functions = nil
    getgenv().Aimbot = nil
    Load = nil; GetClosestPlayer = nil; CancelLock = nil
end

function Environment.Functions:Restart()
    for _, v in next, ServiceConnections do
        v:Disconnect()
    end
    Load()
end

function Environment.Functions:ResetSettings()
    Environment.Settings = {
        Enabled = true,
        TeamCheck = false,
        AliveCheck = true,
        WallCheck = false,
        Sensitivity = 0,
        ThirdPerson = false,
        ThirdPersonSensitivity = 3,
        TriggerKey = "MouseButton2",
        Toggle = false,
        LockPart = "Head"
    }
    Environment.FOVSettings = {
        Enabled = true,
        Visible = true,
        Amount = 90,
        Color = Color3.fromRGB(255, 255, 255),
        LockedColor = Color3.fromRGB(255, 70, 70),
        Transparency = 0.5,
        Sides = 60,
        Thickness = 1,
        Filled = false
    }
end

Load()

-- BLADE BALL AYARLARI
local BladeBall = {
    AutoParry = false,
    ParryDistance = 35,
    ParryTiming = 0.45,
    SmartParry = false,
    AutoSpam = false,
    SpamDelay = 0.08,
    HitboxExpander = false,
    HitboxSize = 15,
    AutoDodge = false,
    DodgeDistance = 12,
    BallESP = false,
    NoParticles = false,
    AutoEquip = false,
    AntiFling = false,
    AntiSlow = false,
    
    ParryDebounce = false,
    DodgeDebounce = false,
    lastSpamTick = 0,
    BallHighlight = nil,
    BallBillboard = nil,
    ParryRemote = nil,
    ESPCache = {},
    OrigHitboxes = {},
    Connections = {},
}

local ESPObjects={}

local RP_AIM=RaycastParams.new() 
RP_AIM.FilterType=Enum.RaycastFilterType.Exclude
local function LOS(o,t) RP_AIM.FilterDescendantsInstances={LP.Character or {}} local r=WS:Raycast(o,t-o,RP_AIM) return not r or r.Distance>=(t-o).Magnitude*0.95 end

local function gc() return LP.Character end
local function ghrp() local c=gc() return c and c:FindFirstChild("HumanoidRootPart") end
local function ghum() local c=gc() return c and c:FindFirstChildOfClass("Humanoid") end
local function rc(p,r) Instance.new("UICorner",p).CornerRadius=UDim.new(0,r or 6) end
local function mkb(p,t,col) local b=Instance.new("TextButton") b.BackgroundColor3=col or C.Ac b.BorderSizePixel=0 b.Size=UDim2.new(1,0,0,28) b.Font=Enum.Font.Gotham b.TextColor3=C.W b.TextSize=11 b.AutoButtonColor=false b.Text=t b.Parent=p rc(b) return b end
local function hfx(b,ba,ho) b.MouseEnter:Connect(function() TweenService:Create(b,TweenInfo.new(0.08),{BackgroundColor3=ho}):Play() end) b.MouseLeave:Connect(function() TweenService:Create(b,TweenInfo.new(0.08),{BackgroundColor3=ba}):Play() end) end
local function sep(p,o) local s=Instance.new("Frame") s.Parent=p s.BackgroundColor3=C.Ac s.BorderSizePixel=0 s.Size=UDim2.new(1,0,0,1) s.LayoutOrder=o end
local function lbl(p,t,o) local l=Instance.new("TextLabel") l.Parent=p l.BackgroundTransparency=1 l.Size=UDim2.new(1,0,0,18) l.Font=Enum.Font.GothamBold l.TextColor3=C.D l.TextSize=10 l.TextXAlignment=Enum.TextXAlignment.Left l.Text="  "..t l.LayoutOrder=o end
local function mscr(p,pos,sz) local sf=Instance.new("ScrollingFrame") sf.Parent=p sf.Active=true sf.BackgroundColor3=C.Bg2 sf.BorderSizePixel=0 sf.Position=pos sf.Size=sz sf.ScrollBarThickness=3 sf.ScrollBarImageColor3=C.Ac sf.CanvasSize=UDim2.new(0,0,0,0) rc(sf,8) local pd=Instance.new("UIPadding",sf) pd.PaddingTop=UDim.new(0,4) pd.PaddingBottom=UDim.new(0,4) pd.PaddingLeft=UDim.new(0,4) pd.PaddingRight=UDim.new(0,4) local l=Instance.new("UIListLayout",sf) l.SortOrder=Enum.SortOrder.LayoutOrder l.Padding=UDim.new(0,2) l:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() sf.CanvasSize=UDim2.new(0,0,0,l.AbsoluteContentSize.Y+8) end) return sf end
local sliders={}
local function mkSlider(p,name,mn,mx,def,o) local f=Instance.new("Frame") f.Parent=p f.BackgroundColor3=C.Bg f.BorderSizePixel=0 f.Size=UDim2.new(1,0,0,34) f.LayoutOrder=o rc(f) local lb=Instance.new("TextLabel",f) lb.BackgroundTransparency=1 lb.Position=UDim2.new(0,8,0,0) lb.Size=UDim2.new(1,-16,0,16) lb.Font=Enum.Font.Gotham lb.TextColor3=C.D lb.TextSize=10 lb.TextXAlignment=Enum.TextXAlignment.Left lb.Text=name..": "..def local bg=Instance.new("Frame",f) bg.BackgroundColor3=C.Bg2 bg.BorderSizePixel=0 bg.Position=UDim2.new(0,8,0,19) bg.Size=UDim2.new(1,-16,0,10) rc(bg,4) local fl=Instance.new("Frame",bg) fl.BackgroundColor3=C.Ac fl.BorderSizePixel=0 fl.Size=UDim2.new(math.clamp((def-mn)/(mx-mn),0,1),0,1,0) rc(fl,4) local s={bg=bg,fill=fl,label=lb,name=name,min=mn,max=mx,val=def,dragging=false,cb=nil} bg.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then s.dragging=true end end) table.insert(sliders,s) return s end
local allToggles={}
local function mkToggle(p,name,o,cfgK) local f=Instance.new("Frame") f.Parent=p f.BackgroundColor3=C.Bg f.BorderSizePixel=0 f.Size=UDim2.new(1,0,0,26) f.LayoutOrder=o rc(f) local lb=Instance.new("TextLabel",f) lb.BackgroundTransparency=1 lb.Position=UDim2.new(0,8,0,0) lb.Size=UDim2.new(1,-100,1,0) lb.Font=Enum.Font.Gotham lb.TextColor3=C.W lb.TextSize=11 lb.TextXAlignment=Enum.TextXAlignment.Left lb.Text=name local kl=Instance.new("TextLabel",f) kl.BackgroundTransparency=1 kl.Position=UDim2.new(1,-96,0,0) kl.Size=UDim2.new(0,46,1,0) kl.Font=Enum.Font.Gotham kl.TextColor3=C.D kl.TextSize=8 kl.TextXAlignment=Enum.TextXAlignment.Right local ks=cfgK and CFG[cfgK] or "" kl.Text=ks~="" and "["..ks.."]" or "" local b=Instance.new("TextButton",f) b.BackgroundColor3=C.Bg2 b.BorderSizePixel=0 b.Position=UDim2.new(1,-44,0,3) b.Size=UDim2.new(0,36,0,20) b.Font=Enum.Font.GothamBold b.TextColor3=C.D b.TextSize=9 b.Text="OFF" b.AutoButtonColor=false rc(b,4) local st=false local cb=nil local function tog() st=not st b.Text=st and "ON" or "OFF" TweenService:Create(b,TweenInfo.new(0.12),{BackgroundColor3=st and C.Ac or C.Bg2}):Play() b.TextColor3=st and C.W or C.D if cb then cb(st) end end b.MouseButton1Click:Connect(tog) local obj={set=function(s) if s~=st then tog() end end,get=function() return st end,on=function(c) cb=c end,toggle=tog,cfgKey=cfgK,updateKeyLabel=function() local k=cfgK and CFG[cfgK] or "" kl.Text=k~="" and "["..k.."]" or "" end} table.insert(allToggles,obj) return obj end

print("✅ RYSA CHEAT - BAŞLANDI")
print("Menü: RightShift (Sağ Shift)")

--// AIMBOT SISTEMI (YENİ)
local select = select
local pcall, getgenv, next, Vector2, mathclamp, type, mousemoverel = select(1, pcall, getgenv, next, Vector2.new, math.clamp, type, mousemoverel or (Input and Input.MouseMove))

pcall(function()
    getgenv().Aimbot.Functions:Exit()
end)

getgenv().Aimbot = {}
local Environment = getgenv().Aimbot

local RunService2 = game:GetService("RunService")
local UserInputService2 = game:GetService("UserInputService")
local TweenService2 = game:GetService("TweenService")
local Players2 = game:GetService("Players")
local Camera2 = workspace.CurrentCamera
local LocalPlayer2 = Players2.LocalPlayer

local RequiredDistance, Typing, Running, Animation, ServiceConnections = 2000, false, false, nil, {}

Environment.Settings = {
    Enabled = true,
    TeamCheck = false,
    AliveCheck = true,
    WallCheck = false,
    Sensitivity = 0,
    ThirdPerson = false,
    ThirdPersonSensitivity = 3,
    TriggerKey = "MouseButton2",
    Toggle = false,
    LockPart = "Head"
}

Environment.FOVSettings = {
    Enabled = true,
    Visible = true,
    Amount = 90,
    Color = Color3.fromRGB(255, 255, 255),
    LockedColor = Color3.fromRGB(255, 70, 70),
    Transparency = 0.5,
    Sides = 60,
    Thickness = 1,
    Filled = false
}

Environment.FOVCircle = Drawing.new("Circle")

local function CancelLock()
    Environment.Locked = nil
    if Animation then Animation:Cancel() end
    Environment.FOVCircle.Color = Environment.FOVSettings.Color
end

local function GetClosestPlayer()
    if not Environment.Locked then
        RequiredDistance = (Environment.FOVSettings.Enabled and Environment.FOVSettings.Amount or 2000)
        for _, v in next, Players2:GetPlayers() do
            if v ~= LocalPlayer2 then
                if v.Character and v.Character:FindFirstChild(Environment.Settings.LockPart) and v.Character:FindFirstChildOfClass("Humanoid") then
                    if Environment.Settings.TeamCheck and v.Team == LocalPlayer2.Team then continue end
                    if Environment.Settings.AliveCheck and v.Character:FindFirstChildOfClass("Humanoid").Health <= 0 then continue end
                    if Environment.Settings.WallCheck and #(Camera2:GetPartsObscuringTarget({v.Character[Environment.Settings.LockPart].Position}, v.Character:GetDescendants())) > 0 then continue end
                    
                    local Vector, OnScreen = Camera2:WorldToViewportPoint(v.Character[Environment.Settings.LockPart].Position)
                    local Distance = (Vector2(UserInputService2:GetMouseLocation().X, UserInputService2:GetMouseLocation().Y) - Vector2(Vector.X, Vector.Y)).Magnitude
                    if Distance < RequiredDistance and OnScreen then
                        RequiredDistance = Distance
                        Environment.Locked = v
                    end
                end
            end
        end
    else
        if (Vector2(UserInputService2:GetMouseLocation().X, UserInputService2:GetMouseLocation().Y) - Vector2(Camera2:WorldToViewportPoint(Environment.Locked.Character[Environment.Settings.LockPart].Position).X, Camera2:WorldToViewportPoint(Environment.Locked.Character[Environment.Settings.LockPart].Position).Y)).Magnitude > RequiredDistance then
            CancelLock()
        end
    end
end

ServiceConnections.TypingStartedConnection = UserInputService2.TextBoxFocused:Connect(function()
    Typing = true
end)

ServiceConnections.TypingEndedConnection = UserInputService2.TextBoxFocusReleased:Connect(function()
    Typing = false
end)

local function Load()
    ServiceConnections.RenderSteppedConnection = RunService2.RenderStepped:Connect(function()
        if Environment.FOVSettings.Enabled and Environment.Settings.Enabled then
            Environment.FOVCircle.Radius = Environment.FOVSettings.Amount
            Environment.FOVCircle.Thickness = Environment.FOVSettings.Thickness
            Environment.FOVCircle.Filled = Environment.FOVSettings.Filled
            Environment.FOVCircle.NumSides = Environment.FOVSettings.Sides
            Environment.FOVCircle.Color = Environment.FOVSettings.Color
            Environment.FOVCircle.Transparency = Environment.FOVSettings.Transparency
            Environment.FOVCircle.Visible = Environment.FOVSettings.Visible
            Environment.FOVCircle.Position = Vector2(UserInputService2:GetMouseLocation().X, UserInputService2:GetMouseLocation().Y)
        else
            Environment.FOVCircle.Visible = false
        end
        
        if Running and Environment.Settings.Enabled then
            GetClosestPlayer()
            if Environment.Locked then
                if Environment.Settings.ThirdPerson then
                    Environment.Settings.ThirdPersonSensitivity = mathclamp(Environment.Settings.ThirdPersonSensitivity, 0.1, 5)
                    local Vector = Camera2:WorldToViewportPoint(Environment.Locked.Character[Environment.Settings.LockPart].Position)
                    mousemoverel((Vector.X - UserInputService2:GetMouseLocation().X) * Environment.Settings.ThirdPersonSensitivity, (Vector.Y - UserInputService2:GetMouseLocation().Y) * Environment.Settings.ThirdPersonSensitivity)
                elseif Environment.Settings.Sensitivity > 0 then
                    Animation = TweenService2:Create(Camera2, TweenInfo.new(Environment.Settings.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera2.CFrame.Position, Environment.Locked.Character[Environment.Settings.LockPart].Position)})
                    Animation:Play()
                else
                    Camera2.CFrame = CFrame.new(Camera2.CFrame.Position, Environment.Locked.Character[Environment.Settings.LockPart].Position)
                end
            end
            Environment.FOVCircle.Color = Environment.FOVSettings.LockedColor
        end
    end)
    
    ServiceConnections.InputBeganConnection = UserInputService2.InputBegan:Connect(function(Input)
        if not Typing then
            pcall(function()
                if Input.KeyCode == Enum.KeyCode[Environment.Settings.TriggerKey] then
                    if Environment.Settings.Toggle then
                        Running = not Running
                        if not Running then
                            CancelLock()
                        end
                    else
                        Running = true
                    end
                end
            end)
            pcall(function()
                if Input.UserInputType == Enum.UserInputType[Environment.Settings.TriggerKey] then
                    if Environment.Settings.Toggle then
                        Running = not Running
                        if not Running then
                            CancelLock()
                        end
                    else
                        Running = true
                    end
                end
            end)
        end
    end)
    
    ServiceConnections.InputEndedConnection = UserInputService2.InputEnded:Connect(function(Input)
        if not Typing then
            if not Environment.Settings.Toggle then
                pcall(function()
                    if Input.KeyCode == Enum.KeyCode[Environment.Settings.TriggerKey] then
                        Running = false; CancelLock()
                    end
                end)
                pcall(function()
                    if Input.UserInputType == Enum.UserInputType[Environment.Settings.TriggerKey] then
                        Running = false; CancelLock()
                    end
                end)
            end
        end
    end)
end

Environment.Functions = {}

function Environment.Functions:Exit()
    for _, v in next, ServiceConnections do
        v:Disconnect()
    end
    if Environment.FOVCircle.Remove then Environment.FOVCircle:Remove() end
    getgenv().Aimbot.Functions = nil
    getgenv().Aimbot = nil
    Load = nil; GetClosestPlayer = nil; CancelLock = nil
end

function Environment.Functions:Restart()
    for _, v in next, ServiceConnections do
        v:Disconnect()
    end
    Load()
end

function Environment.Functions:ResetSettings()
    Environment.Settings = {
        Enabled = true,
        TeamCheck = false,
        AliveCheck = true,
        WallCheck = false,
        Sensitivity = 0,
        ThirdPerson = false,
        ThirdPersonSensitivity = 3,
        TriggerKey = "MouseButton2",
        Toggle = false,
        LockPart = "Head"
    }
    Environment.FOVSettings = {
        Enabled = true,
        Visible = true,
        Amount = 90,
        Color = Color3.fromRGB(255, 255, 255),
        LockedColor = Color3.fromRGB(255, 70, 70),
        Transparency = 0.5,
        Sides = 60,
        Thickness = 1,
        Filled = false
    }
end

Load()

--// GAME LOGIC FONKSİYONLARI

local Fly={Active=false,Speed=50,Keybind="F5",Connection=nil,BodyVelocity=nil}
local Noclip={Active=false,Speed=50,Keybind="N",Connection=nil}
local Freecam={Active=false,Speed=50,Keybind="F6",Connection=nil,OriginalCFrame=nil}
local GodMode={Active=false,Keybind="G"}
local ESP={Active=false,Keybind="",ESPObjects={}}
local Fling={Active=false,Power=100,Keybind="T"}
local AntiVoid={Active=false,Keybind=""}
local Fullbright={Active=false,Keybind=""}
local NoFog={Active=false,Keybind=""}
local AntiAFK={Active=false,Keybind=""}
local AntiSlow={Active=false,Keybind=""}

local function startFly()
    if Fly.Active then return end
    Fly.Active=true
    local hrp=ghrp()
    if not hrp then return end
    
    Fly.BodyVelocity=Instance.new("BodyVelocity")
    Fly.BodyVelocity.Velocity=Vector3.new(0,0,0)
    Fly.BodyVelocity.MaxForce=Vector3.new(math.huge,math.huge,math.huge)
    Fly.BodyVelocity.Parent=hrp
    
    Fly.Connection=RunService.RenderStepped:Connect(function()
        if not Fly.Active or not ghrp() then return end
        local moveDir=Vector3.new(0,0,0)
        if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir=moveDir+cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir=moveDir-cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir=moveDir-cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir=moveDir+cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir=moveDir+Vector3.new(0,1,0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir=moveDir-Vector3.new(0,1,0) end
        if moveDir.Magnitude>0 then moveDir=moveDir.Unit end
        Fly.BodyVelocity.Velocity=moveDir*Fly.Speed
    end)
end

local function stopFly()
    Fly.Active=false
    if Fly.Connection then Fly.Connection:Disconnect() end
    if Fly.BodyVelocity then Fly.BodyVelocity:Destroy() end
    Fly.BodyVelocity=nil
end

local function startNoclip()
    if Noclip.Active then return end
    Noclip.Active=true
    local c=gc()
    if not c then return end
    for _,v in pairs(c:GetDescendants()) do
        if v:IsA("BasePart") then v.CanCollide=false end
    end
    Noclip.Connection=RunService.RenderStepped:Connect(function()
        if not Noclip.Active or not gc() then return end
        for _,v in pairs(gc():GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide=false end
        end
    end)
end

local function stopNoclip()
    Noclip.Active=false
    if Noclip.Connection then Noclip.Connection:Disconnect() end
    local c=gc()
    if c then
        for _,v in pairs(c:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide=true end
        end
    end
end

local function startFreecam()
    if Freecam.Active then return end
    Freecam.Active=true
    Freecam.OriginalCFrame=cam.CFrame
    
    Freecam.Connection=RunService.RenderStepped:Connect(function()
        if not Freecam.Active then return end
        local moveDir=Vector3.new(0,0,0)
        if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir=moveDir+cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir=moveDir-cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir=moveDir-cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir=moveDir+cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir=moveDir+Vector3.new(0,1,0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir=moveDir-Vector3.new(0,1,0) end
        if moveDir.Magnitude>0 then moveDir=moveDir.Unit end
        cam.CFrame=cam.CFrame+moveDir*Freecam.Speed*0.016
    end)
end

local function stopFreecam()
    Freecam.Active=false
    if Freecam.Connection then Freecam.Connection:Disconnect() end
    if Freecam.OriginalCFrame then cam.CFrame=Freecam.OriginalCFrame end
end

local function startGodMode()
    if GodMode.Active then return end
    GodMode.Active=true
    local hum=ghum()
    if hum then hum.MaxHealth=math.huge hum.Health=math.huge end
end

local function stopGodMode()
    GodMode.Active=false
    local hum=ghum()
    if hum then hum.MaxHealth=100 hum.Health=100 end
end

local function startESP()
    if ESP.Active then return end
    ESP.Active=true
    for _,v in pairs(Players:GetPlayers()) do
        if v~=LP and v.Character then
            local hrp=v.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local bb=Instance.new("BillboardGui")
                bb.Size=UDim2.new(4,0,5,0)
                bb.MaxDistance=math.huge
                bb.Parent=hrp
                local tl=Instance.new("TextLabel")
                tl.BackgroundTransparency=1
                tl.Size=UDim2.new(1,0,1,0)
                tl.TextColor3=Color3.fromRGB(255,0,0)
                tl.TextSize=14
                tl.Text=v.Name
                tl.Parent=bb
                table.insert(ESP.ESPObjects,{bb=bb,player=v})
            end
        end
    end
end

local function stopESP()
    ESP.Active=false
    for _,obj in pairs(ESP.ESPObjects) do
        if obj.bb then obj.bb:Destroy() end
    end
    ESP.ESPObjects={}
end

local function flingPlayer(target)
    if not target or not target.Character then return end
    local hrp=target.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local bv=Instance.new("BodyVelocity")
        bv.Velocity=Vector3.new(math.random(-100,100),math.random(50,100),math.random(-100,100))
        bv.MaxForce=Vector3.new(math.huge,math.huge,math.huge)
        bv.Parent=hrp
        game:GetService("Debris"):AddItem(bv,0.1)
    end
end

--// MENU UI

local mainFrame=Instance.new("Frame")
mainFrame.Name="MainMenu"
mainFrame.BackgroundColor3=C.Bg
mainFrame.BorderSizePixel=0
mainFrame.Size=UDim2.new(0,350,0,400)
mainFrame.Position=UDim2.new(0.5,-175,0.5,-200)
mainFrame.Visible=false
mainFrame.Parent=gui
rc(mainFrame,10)

local titleBar=Instance.new("Frame",mainFrame)
titleBar.BackgroundColor3=C.Bg2
titleBar.BorderSizePixel=0
titleBar.Size=UDim2.new(1,0,0,35)
rc(titleBar,10)

local titleLabel=Instance.new("TextLabel",titleBar)
titleLabel.BackgroundTransparency=1
titleLabel.Size=UDim2.new(1,-40,1,0)
titleLabel.Font=Enum.Font.GothamBold
titleLabel.TextColor3=C.W
titleLabel.TextSize=14
titleLabel.Text="RYSA CHEAT"

local closeBtn=Instance.new("TextButton",titleBar)
closeBtn.BackgroundColor3=C.R
closeBtn.BorderSizePixel=0
closeBtn.Position=UDim2.new(1,-30,0,5)
closeBtn.Size=UDim2.new(0,25,0,25)
closeBtn.Font=Enum.Font.GothamBold
closeBtn.TextColor3=C.W
closeBtn.TextSize=12
closeBtn.Text="X"
closeBtn.AutoButtonColor=false
rc(closeBtn,4)

closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible=false
end)

local tabContainer=Instance.new("Frame",mainFrame)
tabContainer.BackgroundColor3=C.Bg
tabContainer.BorderSizePixel=0
tabContainer.Position=UDim2.new(0,0,0,35)
tabContainer.Size=UDim2.new(1,0,0,30)

local tabLayout=Instance.new("UIListLayout",tabContainer)
tabLayout.FillDirection=Enum.FillDirection.Horizontal
tabLayout.SortOrder=Enum.SortOrder.LayoutOrder
tabLayout.Padding=UDim.new(0,2)

local tabs={"MOVE","COMBAT","AIMBOT","BLADE BALL","PLAYERS","TOOLS","EXT","CONFIG"}
local tabButtons={}
local contentFrames={}

for i,tabName in pairs(tabs) do
    local tabBtn=Instance.new("TextButton",tabContainer)
    tabBtn.BackgroundColor3=C.Bg2
    tabBtn.BorderSizePixel=0
    tabBtn.Size=UDim2.new(0,40,1,0)
    tabBtn.Font=Enum.Font.Gotham
    tabBtn.TextColor3=C.D
    tabBtn.TextSize=9
    tabBtn.Text=tabName
    tabBtn.AutoButtonColor=false
    tabBtn.LayoutOrder=i
    rc(tabBtn,4)
    
    local contentFrame=mscr(mainFrame,UDim2.new(0,0,0,65),UDim2.new(1,0,1,-65))
    contentFrame.Name=tabName
    contentFrame.Visible=(i==1)
    
    tabBtn.MouseButton1Click:Connect(function()
        for _,f in pairs(contentFrames) do f.Visible=false end
        contentFrame.Visible=true
        for _,b in pairs(tabButtons) do
            TweenService:Create(b,TweenInfo.new(0.1),{BackgroundColor3=C.Bg2,TextColor3=C.D}):Play()
        end
        TweenService:Create(tabBtn,TweenInfo.new(0.1),{BackgroundColor3=C.Ac,TextColor3=C.W}):Play()
    end)
    
    hfx(tabBtn,C.Bg2,C.Ac)
    table.insert(tabButtons,tabBtn)
    table.insert(contentFrames,contentFrame)
end

--// MOVE TAB
local moveTab=contentFrames[1]
lbl(moveTab,"MOVEMENT",1)
sep(moveTab,2)
mkToggle(moveTab,"Fly",3,"flyKey"):on(function(s) if s then startFly() else stopFly() end end)
mkToggle(moveTab,"Noclip",4,"noclipKey"):on(function(s) if s then startNoclip() else stopNoclip() end end)
mkToggle(moveTab,"Freecam",5,"freecamKey"):on(function(s) if s then startFreecam() else stopFreecam() end end)
mkSlider(moveTab,"Speed",10,200,50,6).cb=function(v) Fly.Speed=v Noclip.Speed=v Freecam.Speed=v end

--// COMBAT TAB
local combatTab=contentFrames[2]
lbl(combatTab,"COMBAT",1)
sep(combatTab,2)
mkToggle(combatTab,"God Mode",3,"godKey"):on(function(s) if s then startGodMode() else stopGodMode() end end)
mkToggle(combatTab,"Anti Void",4,"antiVoidKey"):on(function(s) AntiVoid.Active=s end)
mkToggle(combatTab,"Anti Slow",5,"antiSlowKey"):on(function(s) AntiSlow.Active=s end)

--// AIMBOT TAB
local aimbotTab=contentFrames[3]
lbl(aimbotTab,"AIMBOT",1)
sep(aimbotTab,2)
mkToggle(aimbotTab,"Aimbot Enabled",3):on(function(s) Environment.Settings.Enabled=s end)
mkToggle(aimbotTab,"FOV Visible",4):on(function(s) Environment.FOVSettings.Visible=s end)
mkSlider(aimbotTab,"FOV Size",10,500,90,5).cb=function(v) Environment.FOVSettings.Amount=v end
mkSlider(aimbotTab,"Sensitivity",0,1,0,6).cb=function(v) Environment.Settings.Sensitivity=v end

--// BLADE BALL TAB
local bladeBallTab=contentFrames[4]
lbl(bladeBallTab,"BLADE BALL",1)
sep(bladeBallTab,2)
mkToggle(bladeBallTab,"Auto Parry",3):on(function(s) BladeBall.AutoParry=s end)
mkToggle(bladeBallTab,"Smart Parry",4):on(function(s) BladeBall.SmartParry=s end)
mkToggle(bladeBallTab,"Auto Spam",5):on(function(s) BladeBall.AutoSpam=s end)
mkToggle(bladeBallTab,"Ball ESP",6):on(function(s) BladeBall.BallESP=s end)

--// PLAYERS TAB
local playersTab=contentFrames[5]
lbl(playersTab,"PLAYERS",1)
sep(playersTab,2)
mkToggle(playersTab,"ESP",7):on(function(s) if s then startESP() else stopESP() end end)
local flingBtn=mkb(playersTab,"Fling Closest",8)
flingBtn.MouseButton1Click:Connect(function()
    local closest=nil
    local closestDist=math.huge
    for _,v in pairs(Players:GetPlayers()) do
        if v~=LP and v.Character then
            local dist=(v.Character:FindFirstChild("HumanoidRootPart").Position-ghrp().Position).Magnitude
            if dist<closestDist then closestDist=dist closest=v end
        end
    end
    if closest then flingPlayer(closest) end
end)

--// TOOLS TAB
local toolsTab=contentFrames[6]
lbl(toolsTab,"TOOLS",1)
sep(toolsTab,2)
mkToggle(toolsTab,"Fullbright",3,"fullbrightKey"):on(function(s) Fullbright.Active=s end)
mkToggle(toolsTab,"No Fog",4,"noFogKey"):on(function(s) NoFog.Active=s end)

--// EXT TAB
local extTab=contentFrames[7]
lbl(extTab,"EXTENSIONS",1)
sep(extTab,2)
mkToggle(extTab,"Anti AFK",3,"antiAfkKey"):on(function(s) AntiAFK.Active=s end)

--// CONFIG TAB
local configTab=contentFrames[8]
lbl(configTab,"CONFIG",1)
sep(configTab,2)
local saveBtn=mkb(configTab,"Save Config",3)
saveBtn.MouseButton1Click:Connect(function() saveCFG(CFG) end)
local loadBtn=mkb(configTab,"Load Config",4)
loadBtn.MouseButton1Click:Connect(function() CFG=loadCFG() end)
local resetBtn=mkb(configTab,"Reset All",5)
resetBtn.MouseButton1Click:Connect(function() CFG=loadCFG() end)

--// MENU TOGGLE
UIS.InputBegan:Connect(function(input,gp)
    if gp then return end
    if input.KeyCode==Enum.KeyCode.RightShift then
        mainFrame.Visible=not mainFrame.Visible
    end
end)

--// SLIDER LOGIC
RunService.RenderStepped:Connect(function()
    for _,s in pairs(sliders) do
        if s.dragging then
            local mouse=LP:GetMouse()
            local relX=math.clamp(mouse.X-s.bg.AbsolutePosition.X,0,s.bg.AbsoluteSize.X)
            local pct=relX/s.bg.AbsoluteSize.X
            s.val=math.floor(s.min+pct*(s.max-s.min))
            s.fill.Size=UDim2.new(pct,0,1,0)
            s.label.Text=s.name..": "..s.val
            if s.cb then s.cb(s.val) end
        end
    end
end)

UIS.InputEnded:Connect(function(input,gp)
    if input.UserInputType==Enum.UserInputType.MouseButton1 then
        for _,s in pairs(sliders) do s.dragging=false end
    end
end)

print("✅ RYSA CHEAT - BAŞLANDI")
print("Menü: RightShift (Sağ Shift)")
