--[[
RYSA CHEAT - FULL EDITION
Menü: End tuşu
Tüm özellikler dahil
]]

if game.CoreGui:FindFirstChild("RysaUI") then game.CoreGui:FindFirstChild("RysaUI"):Destroy() end

local UIS=game:GetService("UserInputService")
local TS=game:GetService("TweenService")
local RS=game:GetService("RunService")
local LP=game:GetService("Players").LocalPlayer
local Players=game:GetService("Players")
local WS=game:GetService("Workspace")
local Lighting=game:GetService("Lighting")
local cam=WS.CurrentCamera

-- GLOBALS
local flying,ncOn,godOn,espOn,fcOn,avOn,fbOn,nfOn,aafkOn,aslowOn,spinOn,hitboxOn=false,false,false,false,false,false,false,false,false,false,false,false
local flyBV,flyBG,flyC,ncC,godC,espC,fcC,avC,fbC,nfC,aslowC,spinC,hitboxC
local keys={}
local flySpeed=80
local walkSpeed=16
local fovValue=70
local spinSpeed=20
local hitboxSize=5
local fcYaw,fcPitch=0,0
local fcPos=Vector3.zero
local origFog,origAmb

-- AIMBOT
local AIM={on=false,fov=150,showFov=true,smooth=5,pred=0.15,key="MouseButton2",part="Head",team=true,wall=true}
local FC=Drawing.new("Circle")
FC.Radius=AIM.fov FC.Color=Color3.fromRGB(255,255,255) FC.Thickness=1.5 FC.Filled=false FC.Visible=false FC.NumSides=60

-- BLADE BALL
local BB={AutoParry=false,ParryDist=35,ParryTime=0.45,SmartParry=false,AutoSpam=false,SpamDelay=0.08,HitboxExp=false,HitboxSize=15,AutoDodge=false,DodgeDist=12,BallESP=false,NoParticles=false,AutoEquip=false,AntiFling=false,AntiSlow=false,ParryDebounce=false,DodgeDebounce=false,lastSpam=0,BallHL=nil,BallBB=nil}

-- FLING
local FL={busy=false,allOn=false,stopFlag=false,touchOn=false,followOn=false,followTarget=nil,savedFPDH=nil}
pcall(function() FL.savedFPDH=WS.FallenPartsDestroyHeight end)

-- FUCK
local fuckActive=false
local fuckTarget=nil
local fuckConn=nil

local function gc() return LP.Character end
local function ghrp() local c=gc() return c and c:FindFirstChild("HumanoidRootPart") end
local function ghum() local c=gc() return c and c:FindFirstChildOfClass("Humanoid") end

local C={P=Color3.fromRGB(100,150,255),S=Color3.fromRGB(60,100,200),Bg=Color3.fromRGB(12,12,18),Sf=Color3.fromRGB(20,20,30),Hv=Color3.fromRGB(30,30,45),Tx=Color3.fromRGB(240,240,250),Tx2=Color3.fromRGB(150,150,170),Ac=Color3.fromRGB(100,200,255)}

local function Tw(o,d,p) return TS:Create(o,TweenInfo.new(d,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),p):Play() end

local function MkDrag(f,h)
local d,ds,sp=false,nil,nil
h.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then d=true ds=i.Position sp=f.Position end end)
UIS.InputChanged:Connect(function(i) if d and i.UserInputType==Enum.UserInputType.MouseMovement then local dt=i.Position-ds f.Position=UDim2.new(sp.X.Scale,sp.X.Offset+dt.X,sp.Y.Scale,sp.Y.Offset+dt.Y) end end)
UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then d=false end end)
end

local sg=Instance.new("ScreenGui")
sg.Name="RysaUI" sg.Parent=game.CoreGui sg.ZIndexBehavior=Enum.ZIndexBehavior.Sibling

local mf=Instance.new("Frame")
mf.Name="Main" mf.Parent=sg mf.BackgroundColor3=C.Bg mf.Position=UDim2.new(0.5,-450,0.5,-350) mf.Size=UDim2.new(0,900,0,700) mf.BorderSizePixel=0
local mc=Instance.new("UICorner") mc.CornerRadius=UDim.new(0,12) mc.Parent=mf

local hd=Instance.new("Frame")
hd.Name="Header" hd.Parent=mf hd.BackgroundColor3=C.Sf hd.Size=UDim2.new(1,0,0,60) hd.BorderSizePixel=0
local hc=Instance.new("UICorner") hc.CornerRadius=UDim.new(0,12) hc.Parent=hd
local hg=Instance.new("UIGradient") hg.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,C.Sf),ColorSequenceKeypoint.new(1,Color3.fromRGB(25,25,40))} hg.Parent=hd

local ttl=Instance.new("TextLabel")
ttl.Parent=hd ttl.BackgroundTransparency=1 ttl.Position=UDim2.new(0,20,0,15) ttl.Size=UDim2.new(0,300,0,30) ttl.Font=Enum.Font.GothamBold ttl.Text="RYSA CHEAT" ttl.TextColor3=C.Tx ttl.TextSize=24 ttl.TextXAlignment=Enum.TextXAlignment.Left

local sub=Instance.new("TextLabel")
sub.Parent=hd sub.BackgroundTransparency=1 sub.Position=UDim2.new(0,20,0,40) sub.Size=UDim2.new(0,300,0,15) sub.Font=Enum.Font.Gotham sub.Text="Full Edition" sub.TextColor3=C.Tx2 sub.TextSize=11 sub.TextXAlignment=Enum.TextXAlignment.Left

local sb=Instance.new("Frame")
sb.Name="Sidebar" sb.Parent=mf sb.BackgroundColor3=C.Bg sb.Position=UDim2.new(0,0,0,60) sb.Size=UDim2.new(0,200,0,640) sb.BorderSizePixel=0
local sbc=Instance.new("UICorner") sbc.CornerRadius=UDim.new(0,12) sbc.Parent=sb

local tc=Instance.new("Frame")
tc.Name="TabContainer" tc.Parent=sb tc.BackgroundTransparency=1 tc.Position=UDim2.new(0,0,0,10) tc.Size=UDim2.new(1,0,0,500)
local tl=Instance.new("UIListLayout") tl.Parent=tc tl.SortOrder=Enum.SortOrder.LayoutOrder tl.Padding=UDim.new(0,8)
local tp=Instance.new("UIPadding") tp.PaddingLeft=UDim.new(0,10) tp.PaddingRight=UDim.new(0,10) tp.Parent=tc

local pf=Instance.new("Frame")
pf.Name="Profile" pf.Parent=sb pf.BackgroundColor3=C.Sf pf.Position=UDim2.new(0,10,0,550) pf.Size=UDim2.new(0,180,0,80) pf.BorderSizePixel=0
local pfc=Instance.new("UICorner") pfc.CornerRadius=UDim.new(0,8) pfc.Parent=pf
local pfg=Instance.new("UIGradient") pfg.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,C.P),ColorSequenceKeypoint.new(1,C.S)} pfg.Transparency=NumberSequence.new{NumberSequenceKeypoint.new(0,0.8),NumberSequenceKeypoint.new(1,0.9)} pfg.Parent=pf

local av=Instance.new("ImageLabel")
av.Parent=pf av.BackgroundColor3=C.Hv av.Position=UDim2.new(0,10,0,10) av.Size=UDim2.new(0,50,0,50) av.Image="rbxthumb://type=AvatarHeadShot&id="..LP.UserId.."&w=420&h=420" av.BorderSizePixel=0
local avc=Instance.new("UICorner") avc.CornerRadius=UDim.new(0,6) avc.Parent=av

local pn=Instance.new("TextLabel")
pn.Parent=pf pn.BackgroundTransparency=1 pn.Position=UDim2.new(0,70,0,10) pn.Size=UDim2.new(0,100,0,20) pn.Font=Enum.Font.GothamBold pn.Text=LP.Name pn.TextColor3=C.Tx pn.TextSize=12 pn.TextXAlignment=Enum.TextXAlignment.Left

local ps=Instance.new("TextLabel")
ps.Parent=pf ps.BackgroundTransparency=1 ps.Position=UDim2.new(0,70,0,32) ps.Size=UDim2.new(0,100,0,15) ps.Font=Enum.Font.Gotham ps.Text="Premium • Lifetime" ps.TextColor3=C.Ac ps.TextSize=10 ps.TextXAlignment=Enum.TextXAlignment.Left

local cf=Instance.new("Frame")
cf.Name="Content" cf.Parent=mf cf.BackgroundColor3=C.Bg cf.Position=UDim2.new(0,200,0,60) cf.Size=UDim2.new(0,700,0,640) cf.BorderSizePixel=0
local cfc=Instance.new("UICorner") cfc.CornerRadius=UDim.new(0,12) cfc.Parent=cf

local cs=Instance.new("ScrollingFrame")
cs.Name="Scroll" cs.Parent=cf cs.BackgroundTransparency=1 cs.Size=UDim2.new(1,0,1,0) cs.ScrollBarThickness=4 cs.ScrollBarImageColor3=C.P cs.CanvasSize=UDim2.new(0,0,0,0)
local cl=Instance.new("UIListLayout") cl.Parent=cs cl.SortOrder=Enum.SortOrder.LayoutOrder cl.Padding=UDim.new(0,12)
local cp=Instance.new("UIPadding") cp.PaddingLeft=UDim.new(0,15) cp.PaddingRight=UDim.new(0,15) cp.PaddingTop=UDim.new(0,15) cp.PaddingBottom=UDim.new(0,15) cp.Parent=cs

MkDrag(mf,hd)

local tabs={}
local curTab=nil

local function CrTab(n,ic)
local tb=Instance.new("TextButton")
tb.Name=n tb.Parent=tc tb.BackgroundColor3=C.Bg tb.Size=UDim2.new(1,-20,0,45) tb.AutoButtonColor=false tb.BorderSizePixel=0 tb.Text=""
local tbc=Instance.new("UICorner") tbc.CornerRadius=UDim.new(0,8) tbc.Parent=tb

local tic=Instance.new("TextLabel")
tic.Parent=tb tic.BackgroundTransparency=1 tic.Position=UDim2.new(0,10,0,10) tic.Size=UDim2.new(0,25,0,25) tic.Font=Enum.Font.GothamBold tic.Text=ic tic.TextSize=16

local tl=Instance.new("TextLabel")
tl.Name="Label" tl.Parent=tb tl.BackgroundTransparency=1 tl.Position=UDim2.new(0,45,0,10) tl.Size=UDim2.new(0,130,0,25) tl.Font=Enum.Font.Gotham tl.Text=n tl.TextColor3=C.Tx2 tl.TextSize=13 tl.TextXAlignment=Enum.TextXAlignment.Left

local tct=Instance.new("Frame")
tct.Name="Content_"..n tct.Parent=cs tct.BackgroundTransparency=1 tct.Size=UDim2.new(1,-30,0,0) tct.Visible=false
local tcl=Instance.new("UIListLayout") tcl.Parent=tct tcl.SortOrder=Enum.SortOrder.LayoutOrder tcl.Padding=UDim.new(0,10)

tb.MouseEnter:Connect(function() if curTab~=tb then Tw(tb,0.2,{BackgroundColor3=C.Hv}) Tw(tl,0.2,{TextColor3=C.Tx}) end end)
tb.MouseLeave:Connect(function() if curTab~=tb then Tw(tb,0.2,{BackgroundColor3=C.Bg}) Tw(tl,0.2,{TextColor3=C.Tx2}) end end)

tb.MouseButton1Click:Connect(function()
if curTab then Tw(curTab,0.2,{BackgroundColor3=C.Bg}) curTab:FindFirstChild("Label").TextColor3=C.Tx2 for _,v in pairs(cs:GetChildren()) do if v:IsA("Frame") and v.Name:match("Content_") then v.Visible=false end end end
curTab=tb Tw(tb,0.2,{BackgroundColor3=C.Sf}) Tw(tl,0.2,{TextColor3=C.P}) tct.Visible=true cs.CanvasSize=UDim2.new(0,0,0,tcl.AbsoluteContentSize.Y+30)
end)

local items={}
function items:Btn(t,cb)
local b=Instance.new("TextButton")
b.Parent=tct b.BackgroundColor3=C.Sf b.Size=UDim2.new(1,0,0,45) b.AutoButtonColor=false b.BorderSizePixel=0 b.Font=Enum.Font.Gotham b.Text=t b.TextColor3=C.Tx b.TextSize=13
local bc=Instance.new("UICorner") bc.CornerRadius=UDim.new(0,8) bc.Parent=b
local bg=Instance.new("UIGradient") bg.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,C.Sf),ColorSequenceKeypoint.new(1,Color3.fromRGB(25,25,40))} bg.Parent=b
b.MouseEnter:Connect(function() Tw(b,0.2,{BackgroundColor3=C.Hv}) end)
b.MouseLeave:Connect(function() Tw(b,0.2,{BackgroundColor3=C.Sf}) end)
b.MouseButton1Click:Connect(function() pcall(cb) end)
tcl.Parent=tct cs.CanvasSize=UDim2.new(0,0,0,tcl.AbsoluteContentSize.Y+30)
end

function items:Tog(t,d,cb)
local tg=Instance.new("TextButton")
tg.Parent=tct tg.BackgroundColor3=C.Sf tg.Size=UDim2.new(1,0,0,45) tg.AutoButtonColor=false tg.BorderSizePixel=0 tg.Text=""
local tgc=Instance.new("UICorner") tgc.CornerRadius=UDim.new(0,8) tgc.Parent=tg
local tgg=Instance.new("UIGradient") tgg.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,C.Sf),ColorSequenceKeypoint.new(1,Color3.fromRGB(25,25,40))} tgg.Parent=tg

local lb=Instance.new("TextLabel")
lb.Parent=tg lb.BackgroundTransparency=1 lb.Position=UDim2.new(0,15,0,10) lb.Size=UDim2.new(0,400,0,25) lb.Font=Enum.Font.Gotham lb.Text=t lb.TextColor3=C.Tx lb.TextSize=13 lb.TextXAlignment=Enum.TextXAlignment.Left

local sw=Instance.new("Frame")
sw.Parent=tg sw.BackgroundColor3=C.Hv sw.Position=UDim2.new(0,620,0,12) sw.Size=UDim2.new(0,50,0,21) sw.BorderSizePixel=0
local swc=Instance.new("UICorner") swc.CornerRadius=UDim.new(1,0) swc.Parent=sw

local dt=Instance.new("Frame")
dt.Parent=sw dt.BackgroundColor3=C.Tx dt.Position=UDim2.new(0,2,0,2) dt.Size=UDim2.new(0,17,0,17) dt.BorderSizePixel=0
local dtc=Instance.new("UICorner") dtc.CornerRadius=UDim.new(1,0) dtc.Parent=dt

local st=d or false
local function upd() if st then Tw(sw,0.3,{BackgroundColor3=C.P}) Tw(dt,0.3,{Position=UDim2.new(0,31,0,2)}) else Tw(sw,0.3,{BackgroundColor3=C.Hv}) Tw(dt,0.3,{Position=UDim2.new(0,2,0,2)}) end end
if st then upd() pcall(cb,st) end

tg.MouseButton1Click:Connect(function() st=not st upd() pcall(cb,st) end)
tg.MouseEnter:Connect(function() Tw(tg,0.2,{BackgroundColor3=Color3.fromRGB(28,28,42)}) end)
tg.MouseLeave:Connect(function() Tw(tg,0.2,{BackgroundColor3=C.Sf}) end)
tcl.Parent=tct cs.CanvasSize=UDim2.new(0,0,0,tcl.AbsoluteContentSize.Y+30)
return {set=function(v) if v~=st then st=v upd() end end,get=function() return st end}
end

function items:Sld(t,mn,mx,d,cb)
local f=Instance.new("Frame")
f.Parent=tct f.BackgroundColor3=C.Sf f.Size=UDim2.new(1,0,0,50) f.BorderSizePixel=0
local fc=Instance.new("UICorner") fc.CornerRadius=UDim.new(0,8) fc.Parent=f

local lb=Instance.new("TextLabel")
lb.Parent=f lb.BackgroundTransparency=1 lb.Position=UDim2.new(0,15,0,5) lb.Size=UDim2.new(1,-30,0,20) lb.Font=Enum.Font.Gotham lb.TextColor3=C.Tx2 lb.TextSize=11 lb.TextXAlignment=Enum.TextXAlignment.Left lb.Text=t..": "..d

local bg=Instance.new("Frame")
bg.Parent=f bg.BackgroundColor3=C.Bg bg.Position=UDim2.new(0,15,0,28) bg.Size=UDim2.new(1,-30,0,12) bg.BorderSizePixel=0
local bgc=Instance.new("UICorner") bgc.CornerRadius=UDim.new(0,6) bgc.Parent=bg

local fl=Instance.new("Frame")
fl.Parent=bg fl.BackgroundColor3=C.P fl.Size=UDim2.new((d-mn)/(mx-mn),0,1,0) fl.BorderSizePixel=0
local flc=Instance.new("UICorner") flc.CornerRadius=UDim.new(0,6) flc.Parent=fl

local v=d
local dr=false
bg.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dr=true end end)
UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dr=false end end)
UIS.InputChanged:Connect(function(i) if dr and i.UserInputType==Enum.UserInputType.MouseMovement then local p=UIS:GetMouseLocation() local ap=bg.AbsolutePosition local sz=bg.AbsoluteSize.X local pc=math.clamp((p.X-ap.X)/sz,0,1) v=mn+(mx-mn)*pc if math.type(v)=="integer" then v=math.floor(v) else v=math.floor(v*10)/10 end fl.Size=UDim2.new(pc,0,1,0) lb.Text=t..": "..v pcall(cb,v) end end)
tcl.Parent=tct cs.CanvasSize=UDim2.new(0,0,0,tcl.AbsoluteContentSize.Y+30)
return {get=function() return v end}
end

tabs[n]=items
return items
end

-- TABS
local move=CrTab("Movement","🚀")
local combat=CrTab("Combat","⚔️")
local aim=CrTab("Aimbot","🎯")
local bb=CrTab("BladeBall","⚡")
local plr=CrTab("Players","👥")
local misc=CrTab("Misc","🔧")

-- MOVEMENT TAB
move:Tog("Fly",false,function(s)
if s then
local hrp=ghrp() local hum=ghum()
if not hrp or not hum then return end
flying=true if not ncOn then ncOn=true end hum.PlatformStand=true
flyBV=Instance.new("BodyVelocity") flyBV.MaxForce=Vector3.new(9e9,9e9,9e9) flyBV.Velocity=Vector3.zero flyBV.P=9000 flyBV.Parent=hrp
flyBG=Instance.new("BodyGyro") flyBG.MaxTorque=Vector3.new(9e9,9e9,9e9) flyBG.D=200 flyBG.P=40000 flyBG.Parent=hrp
flyC=RS.Heartbeat:Connect(function()
if not flying then return end
pcall(function()
local cf=cam.CFrame local d=Vector3.zero
if keys[Enum.KeyCode.W] then d=d+cf.LookVector end
if keys[Enum.KeyCode.S] then d=d-cf.LookVector end
if keys[Enum.KeyCode.A] then d=d-cf.RightVector end
if keys[Enum.KeyCode.D] then d=d+cf.RightVector end
if keys[Enum.KeyCode.Space] then d=d+Vector3.yAxis end
if keys[Enum.KeyCode.LeftShift] then d=d-Vector3.yAxis end
flyBV.Velocity=d.Magnitude>0 and d.Unit*flySpeed or Vector3.zero
flyBG.CFrame=cf
end)
end)
else
flying=false if flyC then flyC:Disconnect() flyC=nil end
pcall(function() if flyBV then flyBV:Destroy() end if flyBG then flyBG:Destroy() end ghum().PlatformStand=false end)
end
end)

local flySpd=move:Sld("Fly Speed",10,300,80,function(v) flySpeed=v end)
move:Tog("Noclip",false,function(s)
ncOn=s if ncC then ncC:Disconnect() ncC=nil end
if s then ncC=RS.Stepped:Connect(function() pcall(function() local c=gc() if not c then return end for _,p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end end) end) end
end)
move:Tog("Infinite Jump",false,function(s) end)
local wspd=move:Sld("WalkSpeed",16,500,16,function(v) walkSpeed=v pcall(function() ghum().WalkSpeed=v end) end)
move:Tog("Spin",false,function(s)
spinOn=s if spinC then spinC:Disconnect() spinC=nil end
pcall(function() local hrp=ghrp() if hrp then for _,v in ipairs(hrp:GetChildren()) do if v.Name=="SPIN" then v:Destroy() end end end end)
if s then local hrp=ghrp() if hrp then local bav=Instance.new("BodyAngularVelocity") bav.Name="SPIN" bav.MaxTorque=Vector3.new(0,9e9,0) bav.AngularVelocity=Vector3.new(0,spinSpeed,0) bav.P=500 bav.Parent=hrp
spinC=RS.Heartbeat:Connect(function() pcall(function() local b=ghrp() and ghrp():FindFirstChild("SPIN") if b then b.AngularVelocity=Vector3.new(0,spinSpeed,0) end end) end) end end
end)
local spnSpd=move:Sld("Spin Speed",1,100,20,function(v) spinSpeed=v end)
move:Tog("Freecam",false,function(s)
fcOn=s if fcC then fcC:Disconnect() fcC=nil end
if s then pcall(function() local cf=cam.CFrame fcPos=cf.Position local _,y,_=cf:ToEulerAnglesYXZ() fcYaw=y fcPitch=0 cam.CameraType=Enum.CameraType.Scriptable UIS.MouseBehavior=Enum.MouseBehavior.LockCenter local h=ghum() if h then h.WalkSpeed=0 end end)
fcC=RS.RenderStepped:Connect(function(dt) pcall(function() local delta=UIS:GetMouseDelta() fcYaw=fcYaw-delta.X*0.004 fcPitch=math.clamp(fcPitch-delta.Y*0.004,-1.4,1.4) local rot=CFrame.Angles(0,fcYaw,0)*CFrame.Angles(fcPitch,0,0) local speed=60*dt local d=Vector3.zero
if keys[Enum.KeyCode.W] then d=d+rot.LookVector end if keys[Enum.KeyCode.S] then d=d-rot.LookVector end if keys[Enum.KeyCode.A] then d=d-rot.RightVector end if keys[Enum.KeyCode.D] then d=d+rot.RightVector end if keys[Enum.KeyCode.Space] then d=d+Vector3.yAxis end if keys[Enum.KeyCode.LeftShift] then d=d-Vector3.yAxis end
if d.Magnitude>0 then fcPos=fcPos+d.Unit*speed end cam.CFrame=CFrame.new(fcPos)*rot UIS.MouseBehavior=Enum.MouseBehavior.LockCenter end) end)
else pcall(function() cam.CameraType=Enum.CameraType.Custom UIS.MouseBehavior=Enum.MouseBehavior.Default cam.CameraSubject=gc():FindFirstChildOfClass("Humanoid") local h=ghum() if h then h.WalkSpeed=walkSpeed end end) end
end)
local fovSld=move:Sld("FOV",70,120,70,function(v) fovValue=v pcall(function() cam.FieldOfView=v end) end)

-- COMBAT TAB
combat:Tog("God Mode",false,function(s)
godOn=s if godC then godC:Disconnect() godC=nil end
if s then godC=RS.Heartbeat:Connect(function() pcall(function() local h=ghum() if h then h.Health=h.MaxHealth end local hrp=ghrp() if hrp then hrp.Velocity=Vector3.new(math.clamp(hrp.Velocity.X,-100,100),math.clamp(hrp.Velocity.Y,-100,100),math.clamp(hrp.Velocity.Z,-100,100)) end end) end) end
end)
combat:Tog("Anti Void",false,function(s)
avOn=s if avC then avC:Disconnect() avC=nil end
if s then avC=RS.Heartbeat:Connect(function() pcall(function() local hrp=ghrp() if hrp and hrp.Position.Y<-50 then hrp.CFrame=CFrame.new(hrp.Position.X,50,hrp.Position.Z) hrp.Velocity=Vector3.zero end end) end) end
end)
combat:Tog("Hitbox Expander",false,function(s)
hitboxOn=s if hitboxC then hitboxC:Disconnect() hitboxC=nil end
if s then hitboxC=RS.Stepped:Connect(function() pcall(function() for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character then local head=p.Character:FindFirstChild("Head") if head then head.Size=Vector3.new(hitboxSize,hitboxSize,hitboxSize) head.Transparency=0.5 head.CanCollide=false head.Massless=true head.Material=Enum.Material.ForceField local mesh=head:FindFirstChildOfClass("SpecialMesh") if mesh then mesh:Destroy() end end end end end) end)
else pcall(function() for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character then local head=p.Character:FindFirstChild("Head") if head then head.Size=Vector3.new(2,1,1) head.Transparency=0 head.Material=Enum.Material.Plastic end end end end) end
end)
local hbSz=combat:Sld("Hitbox Size",1,20,5,function(v) hitboxSize=v end)
combat:Tog("ESP",false,function(s)
espOn=s if espC then espC:Disconnect() espC=nil end
if s then espC=RS.Heartbeat:Connect(function() for _,p in ipairs(Players:GetPlayers()) do if p~=LP then pcall(function() local c=p.Character if not c then return end
if not c:FindFirstChild("ESP") then local h=Instance.new("Highlight") h.Name="ESP" h.FillColor=C.Tx h.FillTransparency=0.8 h.OutlineColor=C.Tx h.Parent=c end
local head=c:FindFirstChild("Head") if head and not head:FindFirstChild("ESPN") then local bb=Instance.new("BillboardGui") bb.Name="ESPN" bb.Parent=head bb.Size=UDim2.new(0,200,0,30) bb.StudsOffset=Vector3.new(0,2.5,0) bb.AlwaysOnTop=true bb.MaxDistance=1000
local nl=Instance.new("TextLabel",bb) nl.BackgroundTransparency=1 nl.Size=UDim2.new(1,0,0.5,0) nl.Font=Enum.Font.GothamBold nl.TextColor3=C.Tx nl.TextStrokeTransparency=0.5 nl.TextStrokeColor3=Color3.new(0,0,0) nl.TextSize=14 nl.Text=p.DisplayName
local dl=Instance.new("TextLabel",bb) dl.BackgroundTransparency=1 dl.Size=UDim2.new(1,0,0.5,0) dl.Position=UDim2.new(0,0,0.5,0) dl.Font=Enum.Font.Gotham dl.TextColor3=C.Tx2 dl.TextStrokeTransparency=0.5 dl.TextStrokeColor3=Color3.new(0,0,0) dl.TextSize=10 dl.Text="" end
local espN=head and head:FindFirstChild("ESPN") if espN and ghrp() then local dist=math.floor((ghrp().Position-head.Position).Magnitude) local hum2=c:FindFirstChildOfClass("Humanoid") local hp=hum2 and math.floor(hum2.Health) or 0 local ch=espN:GetChildren() if ch[2] then ch[2].Text="HP: "..hp.." | "..dist.."m" end end
end) end end end)
else for _,p in ipairs(Players:GetPlayers()) do pcall(function() local c=p.Character if c then local e=c:FindFirstChild("ESP") if e then e:Destroy() end local head=c:FindFirstChild("Head") if head then local n=head:FindFirstChild("ESPN") if n then n:Destroy() end end end end) end end
end)
combat:Tog("Fullbright",false,function(s)
fbOn=s if fbC then fbC:Disconnect() fbC=nil end
if s then origAmb=Lighting.Ambient fbC=RS.Heartbeat:Connect(function() pcall(function() Lighting.Ambient=Color3.new(1,1,1) Lighting.Brightness=2 Lighting.OutdoorAmbient=Color3.new(1,1,1) end) end)
else pcall(function() if origAmb then Lighting.Ambient=origAmb end Lighting.Brightness=1 end) end
end)
combat:Tog("No Fog",false,function(s)
nfOn=s if nfC then nfC:Disconnect() nfC=nil end
if s then origFog=Lighting.FogEnd nfC=RS.Heartbeat:Connect(function() pcall(function() Lighting.FogEnd=1e9 end) end)
else pcall(function() if origFog then Lighting.FogEnd=origFog end end) end
end)
combat:Tog("Anti AFK",false,function(s)
aafkOn=s if s then pcall(function() if getconnections then for _,c in ipairs(getconnections(LP.Idled)) do c:Disable() end end end) end
end)
combat:Tog("Anti Slowdown",false,function(s)
aslowOn=s if aslowC then aslowC:Disconnect() aslowC=nil end
if s then aslowC=RS.Heartbeat:Connect(function() pcall(function() local h=ghum() if h and h.WalkSpeed<16 then h.WalkSpeed=walkSpeed end end) end) end
end)

-- AIMBOT TAB
aim:Tog("Aimbot",false,function(s) AIM.on=s FC.Visible=s and AIM.showFov end)
aim:Tog("Show FOV Circle",false,function(s) AIM.showFov=s FC.Visible=s and AIM.on end)
local fovSz=aim:Sld("FOV Size",10,500,150,function(v) AIM.fov=v FC.Radius=v end)
local smooth=aim:Sld("Smoothness",1,20,5,function(v) AIM.smooth=v end)
local pred=aim:Sld("Prediction",0,50,15,function(v) AIM.pred=v/100 end)
aim:Tog("Team Check",true,function(s) AIM.team=s end)
aim:Tog("Wall Check",true,function(s) AIM.wall=s end)

-- BLADE BALL TAB
bb:Tog("Auto Parry",false,function(s) BB.AutoParry=s end)
bb:Tog("Smart Parry",false,function(s) BB.SmartParry=s end)
local pDist=bb:Sld("Parry Distance",10,80,35,function(v) BB.ParryDist=v end)
local pTime=bb:Sld("Parry Timing",5,100,45,function(v) BB.ParryTime=v/100 end)
bb:Tog("Auto Dodge",false,function(s) BB.AutoDodge=s end)
local dDist=bb:Sld("Dodge Distance",5,30,12,function(v) BB.DodgeDist=v end)
bb:Tog("Auto Spam Click",false,function(s) BB.AutoSpam=s end)
local sDel=bb:Sld("Spam Delay",3,100,8,function(v) BB.SpamDelay=v/100 end)
bb:Tog("Ball ESP",false,function(s)
BB.BallESP=s
if s then
if not BB.BallHL then BB.BallHL=Instance.new("Highlight") BB.BallHL.Name="BallESP" BB.BallHL.FillTransparency=0.3 BB.BallHL.FillColor=Color3.fromRGB(255,50,50) end
if not BB.BallBB then BB.BallBB=Instance.new("BillboardGui") BB.BallBB.Name="BallInfo" BB.BallBB.Size=UDim2.fromOffset(150,30) BB.BallBB.StudsOffset=Vector3.new(0,3,0) BB.BallBB.AlwaysOnTop=true
local l=Instance.new("TextLabel") l.Size=UDim2.new(1,0,1,0) l.BackgroundTransparency=1 l.TextColor3=Color3.fromRGB(255,255,0) l.TextStrokeTransparency=0.3 l.Font=Enum.Font.GothamBold l.TextSize=12 l.Text="BALL" l.Parent=BB.BallBB end
else if BB.BallHL then BB.BallHL:Destroy() BB.BallHL=nil end if BB.BallBB then BB.BallBB:Destroy() BB.BallBB=nil end end
end)
bb:Tog("No Particles",false,function(s) BB.NoParticles=s end)
bb:Tog("Anti Fling",false,function(s) BB.AntiFling=s end)
bb:Tog("Anti Slow",false,function(s) BB.AntiSlow=s end)
bb:Tog("Auto Equip Sword",false,function(s) BB.AutoEquip=s end)
bb:Tog("Hitbox Expander",false,function(s) BB.HitboxExp=s end)
local bbHb=bb:Sld("Hitbox Size",5,30,15,function(v) BB.HitboxSize=v end)

-- PLAYERS TAB
plr:Btn("Refresh Players",function()
game:GetService("StarterGui"):SetCore("SendNotification",{Title="RYSA";Text="Players refreshed"})
end)
plr:Btn("Fling All",function()
if FL.allOn then FL.allOn=false FL.stopFlag=true return end
FL.allOn=true FL.stopFlag=false
task.spawn(function()
while FL.allOn and not FL.stopFlag do
local tg={} for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then local h=p.Character:FindFirstChildOfClass("Humanoid") if h and h.Health>0 then table.insert(tg,p) end end end
if #tg==0 then FL.allOn=false return end
for _,t in ipairs(tg) do if not FL.allOn or FL.stopFlag then return end task.wait(0.5) end
end
end)
end)
plr:Btn("Touch Fling",function()
if FL.touchOn then FL.touchOn=false return end
local hrp=ghrp() if not hrp then return end FL.touchOn=true
task.spawn(function()
local ml=0.1
while FL.touchOn do RS.Heartbeat:Wait() local c=gc() local h=c and c:FindFirstChild("HumanoidRootPart")
while FL.touchOn and not(c and c.Parent and h and h.Parent) do RS.Heartbeat:Wait() c=gc() h=c and c:FindFirstChild("HumanoidRootPart") end
if FL.touchOn and h and h.Parent then local v=h.Velocity h.Velocity=v*10000+Vector3.new(0,10000,0) RS.RenderStepped:Wait()
if c and c.Parent and h and h.Parent then h.Velocity=v end RS.Stepped:Wait()
if c and c.Parent and h and h.Parent then h.Velocity=v+Vector3.new(0,ml,0) ml=ml*-1 end end end
end)
end)
plr:Btn("Stop All",function() FL.allOn=false FL.stopFlag=true FL.touchOn=false fuckActive=false if fuckConn then fuckConn:Disconnect() fuckConn=nil end fuckTarget=nil
pcall(function() local hrp=ghrp() if hrp then for _,v in ipairs(hrp:GetChildren()) do if v:IsA("BodyMover") then v:Destroy() end end hrp.Velocity=Vector3.zero hrp.RotVelocity=Vector3.zero end local h=ghum() if h then h.PlatformStand=false end end)
task.wait(0.3) FL.busy=false FL.stopFlag=false
end)

-- MISC TAB
misc:Btn("Rejoin",function() pcall(function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,game.JobId,LP) end) end)
misc:Btn("Server Hop",function()
pcall(function()
local HS=game:GetService("HttpService")
local d=HS:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
for _,s in ipairs(d.data) do if s.id~=game.JobId and s.playing<s.maxPlayers then game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,s.id,LP) break end end
end)
end)
misc:Btn("Reset Character",function() pcall(function() ghum().Health=0 end) end)
misc:Btn("Anti Lag",function()
pcall(function()
for _,v in ipairs(WS:GetDescendants()) do pcall(function() if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") or v:IsA("Explosion") then v:Destroy() end end) end
for _,v in ipairs(Lighting:GetDescendants()) do pcall(function() if v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("DepthOfFieldEffect") then v:Destroy() end end) end
Lighting.GlobalShadows=false Lighting.FogEnd=1e9 pcall(function() settings().Rendering.QualityLevel=Enum.QualityLevel.Level01 end)
end)
end)
misc:Btn("Destroy GUI",function() sg:Destroy() end)

-- INPUT HANDLING
UIS.InputBegan:Connect(function(i,g) if not g and i.KeyCode then keys[i.KeyCode]=true if i.KeyCode==Enum.KeyCode.End then sg.Enabled=not sg.Enabled end end end)
UIS.InputEnded:Connect(function(i) if i.KeyCode then keys[i.KeyCode]=nil end end)
UIS.JumpRequest:Connect(function() pcall(function() ghum():ChangeState(Enum.HumanoidStateType.Jumping) end) end)

-- BLADE BALL FUNCTIONS
local function FindBall()
for _,obj in ipairs(WS:GetDescendants()) do if obj:IsA("BasePart") then local n=obj.Name:lower() if n=="ball" or n=="bladeball" or n=="blade" then return obj end end end return nil
end

local function GetBallSpeed(ball) if not ball then return 0 end return ball.AssemblyLinearVelocity.Magnitude end

local function IsBallComingToMe(ball)
if not ball then return false end local myRoot=ghrp() if not myRoot then return false end
local dist=(ball.Position-myRoot.Position).Magnitude if dist>BB.ParryDist then return false end
local ballVel=ball.AssemblyLinearVelocity if ballVel.Magnitude<5 then return false end
local toMe=(myRoot.Position-ball.Position).Unit local ballDir=ballVel.Unit local dot=toMe:Dot(ballDir) return dot>0.3
end

local function GetBallETA(ball)
if not ball then return math.huge end local myRoot=ghrp() if not myRoot then return math.huge end
local dist=(ball.Position-myRoot.Position).Magnitude local speed=ball.AssemblyLinearVelocity.Magnitude
if speed<1 then return math.huge end return dist/speed
end

local function FireParry() pcall(function() local char=gc() if char then for _,tool in ipairs(char:GetChildren()) do if tool:IsA("Tool") then tool:Activate() end end end end) end

local function RunAutoParry()
if BB.ParryDebounce or not gc() then return end local ball=FindBall() if not ball then return end
if IsBallComingToMe(ball) then local eta=GetBallETA(ball) if eta<BB.ParryTime then BB.ParryDebounce=true FireParry() task.delay(0.4,function() BB.ParryDebounce=false end) end end
end

local function RunAutoDodge()
if BB.DodgeDebounce or not gc() then return end local ball=FindBall() if not ball then return end
local myRoot=ghrp() if not myRoot then return end local dist=(ball.Position-myRoot.Position).Magnitude
if dist>BB.DodgeDist then return end if IsBallComingToMe(ball) then BB.DodgeDebounce=true
local ballDir=ball.AssemblyLinearVelocity.Unit local right=Vector3.new(-ballDir.Z,0,ballDir.X)
if math.random()>0.5 then right=-right end pcall(function() myRoot.CFrame=myRoot.CFrame+(right*8) end)
task.delay(0.5,function() BB.DodgeDebounce=false end) end
end

local function RunAutoSpam()
if not gc() then return end local now=tick() if now-BB.lastSpam<BB.SpamDelay then return end BB.lastSpam=now
pcall(function() local char=gc() if char then for _,tool in ipairs(char:GetChildren()) do if tool:IsA("Tool") then tool:Activate() end end end end)
end

local function UpdateBallESP()
if not BB.BallESP then return end local ball=FindBall()
if ball and BB.BallHL then pcall(function() BB.BallHL.Adornee=ball BB.BallHL.Parent=ball BB.BallBB.Adornee=ball BB.BallBB.Parent=ball
local myRoot=ghrp() if myRoot then local dist=math.floor((ball.Position-myRoot.Position).Magnitude) local speed=math.floor(GetBallSpeed(ball))
local label=BB.BallBB:FindFirstChildOfClass("TextLabel") if label then label.Text="BALL | "..dist.."m | "..speed.." spd" end end end) end
end

-- AIMBOT FUNCTIONS
local RP_AIM=RaycastParams.new() RP_AIM.FilterType=Enum.RaycastFilterType.Exclude
local function LOS(o,t) RP_AIM.FilterDescendantsInstances={LP.Character or {}} local r=WS:Raycast(o,t-o,RP_AIM) return not r or r.Distance>=(t-o).Magnitude*0.95 end

local function GetClosestTarget()
local closest=nil local shortest=AIM.fov local mousePos=UIS:GetMouseLocation()
for _,player in ipairs(Players:GetPlayers()) do if player~=LP and player.Character then
if AIM.team then local tool=player.Character:FindFirstChildOfClass("Tool") if not tool or not(tool.Name:lower():find("knife") or tool.Name:lower():find("gun")) then continue end end
local targetPart=player.Character:FindFirstChild(AIM.part) or player.Character:FindFirstChild("Head")
if targetPart then local screenPos,onScreen=cam:WorldToViewportPoint(targetPart.Position) if onScreen then
if AIM.wall then local visible=LOS(cam.CFrame.Position,targetPart.Position) if not visible then continue end end
local dist=(Vector2.new(screenPos.X,screenPos.Y)-mousePos).Magnitude
if dist<shortest then shortest=dist closest={Player=player,Part=targetPart,ScreenPos=screenPos} end
end end end end return closest
end

-- MAIN LOOPS
local bbClock=0
RS.Heartbeat:Connect(function(dt)
if not gc() or not ghum() or ghum().Health<=0 then return end
bbClock=bbClock+dt

if BB.SmartParry or BB.AutoParry then pcall(RunAutoParry) end
if BB.AutoDodge then pcall(RunAutoDodge) end
if BB.AutoSpam then pcall(RunAutoSpam) end
if BB.BallESP and bbClock>=0.1 then bbClock=0 pcall(UpdateBallESP) end

if BB.NoParticles then pcall(function() for _,v in ipairs(WS:GetDescendants()) do if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then v.Enabled=false end end end) end
if BB.AntiFling then pcall(function() local hrp=ghrp() if hrp and hrp.AssemblyLinearVelocity.Magnitude>100 then hrp.AssemblyLinearVelocity=Vector3.new(0,0,0) end end) end
if BB.AntiSlow then pcall(function() local h=ghum() if h and h.WalkSpeed<16 then h.WalkSpeed=16 end end) end
if BB.HitboxExp then pcall(function() for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character then local hrp=p.Character:FindFirstChild("HumanoidRootPart") if hrp then hrp.Size=Vector3.new(BB.HitboxSize,BB.HitboxSize,BB.HitboxSize) hrp.Transparency=0.7 hrp.CanCollide=false hrp.Material=Enum.Material.ForceField end end end end) end
if BB.AutoEquip and bbClock>=1 then pcall(function() local bp=LP:FindFirstChild("Backpack") if bp then for _,tool in ipairs(bp:GetChildren()) do if tool:IsA("Tool") then local hum=ghum() if hum then hum:EquipTool(tool) end break end end end end) end
end)

RS.RenderStepped:Connect(function()
if AIM.showFov and AIM.on then FC.Position=UIS:GetMouseLocation() FC.Visible=true else FC.Visible=false end
if AIM.on then local keyPressed=false
if AIM.key=="MouseButton1" then keyPressed=UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
elseif AIM.key=="MouseButton2" then keyPressed=UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
else keyPressed=UIS:IsKeyDown(Enum.KeyCode[AIM.key]) end
if keyPressed then local target=GetClosestTarget() if target then local mousePos=UIS:GetMouseLocation()
mousemoverel((target.ScreenPos.X-mousePos.X)/AIM.smooth,(target.ScreenPos.Y-mousePos.Y)/AIM.smooth) end end end
end)

RS.Heartbeat:Connect(function() pcall(function() local h=ghum() if h and not fcOn then if walkSpeed~=16 then h.WalkSpeed=walkSpeed end end end) end)

LP.CharacterAdded:Connect(function()
if flying then flying=false if flyC then flyC:Disconnect() flyC=nil end pcall(function() if flyBV then flyBV:Destroy() end if flyBG then flyBG:Destroy() end end) end
if ncOn then ncOn=false if ncC then ncC:Disconnect() ncC=nil end end
if fcOn then fcOn=false if fcC then fcC:Disconnect() fcC=nil end end
if spinOn then spinOn=false if spinC then spinC:Disconnect() spinC=nil end end
FL.allOn=false FL.stopFlag=true FL.touchOn=false fuckActive=false if fuckConn then fuckConn:Disconnect() fuckConn=nil end fuckTarget=nil
task.wait(2) FL.busy=false
end)

game:GetService("StarterGui"):SetCore("SendNotification",{Title="RYSA CHEAT";Text="Full Edition Loaded | Menu: End";Duration=3})
print("✅ RYSA CHEAT - FULL EDITION")
print("📌 Menü: End tuşu")
print("🚀 Movement - Fly, Noclip, Freecam, Spin")
print("⚔️ Combat - God, Hitbox, ESP, Fullbright")
print("🎯 Aimbot - FOV, Smooth, Prediction")
print("⚡ Blade Ball - Auto Parry, Dodge, ESP")
print("👥 Players - Fling, Touch Fling")
print("🔧 Misc - Rejoin, Server Hop, Anti Lag")
