-- ==========================================
-- 白祈专属菜单 (最终完美版)
-- 仅限账号 ID: 10497218129 使用
-- ==========================================
local MyUserId = 10497218129 

local CoreGui = game:GetService("CoreGui")
local Player = game.Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local UserInputService = game:GetService("UserInputService")

-- 🚨 身份验证拦截
if Player.UserId ~= MyUserId then
    local badGui = Instance.new("ScreenGui")
    badGui.Name = "PunishGui"
    badGui.Parent = CoreGui
    badGui.IgnoreGuiInset = true
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    bg.BorderSizePixel = 0
    bg.Parent = badGui
    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 0, 50)
    text.Position = UDim2.new(0, 0, 0.5, -25)
    text.BackgroundTransparency = 1
    text.Text = "警告：未授权访问\n即将断开连接..."
    text.TextColor3 = Color3.fromRGB(255, 50, 50)
    text.TextScaled = true
    text.Font = Enum.Font.GothamBold
    text.Parent = bg
    local punishSound = Instance.new("Sound")
    punishSound.SoundId = "rbxassetid://17684982508" 
    punishSound.Parent = SoundService
    punishSound.Volume = 3
    punishSound:Play()
    task.wait(3.5) 
    Player:Kick("身份验证失败：此脚本已绑定专属账号。")
    return
end

if CoreGui:FindFirstChild("BaiQiMenu") then CoreGui:FindFirstChild("BaiQiMenu"):Destroy() end
if SoundService:FindFirstChild("BaiQiMusic") then SoundService.BaiQiMusic:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BaiQiMenu"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local Theme = {
    BgColor = Color3.fromRGB(245, 248, 250),        
    TitleColor = Color3.fromRGB(130, 200, 150),     
    TextColor = Color3.fromRGB(40, 40, 40),         
    BtnColor = Color3.fromRGB(255, 255, 255),       
    InputBg = Color3.fromRGB(240, 242, 245),        
    SwitchOff = Color3.fromRGB(200, 200, 200),      
    SwitchOn = Color3.fromRGB(130, 200, 150),       
    LineColor = Color3.fromRGB(220, 225, 230),
    TabBgColor = Color3.fromRGB(235, 240, 235),
}

-- ==========================================
-- 1. 加载界面
-- ==========================================
local LoadingFrame = Instance.new("Frame")
LoadingFrame.Parent = ScreenGui
LoadingFrame.Size = UDim2.new(0, 180, 0, 70) 
LoadingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
LoadingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingFrame.BackgroundColor3 = Theme.BgColor
LoadingFrame.BorderSizePixel = 0
local LoadCorner = Instance.new("UICorner") LoadCorner.CornerRadius = UDim.new(0, 10) LoadCorner.Parent = LoadingFrame
local LoadStroke = Instance.new("UIStroke") LoadStroke.Color = Theme.LineColor LoadStroke.Thickness = 1 LoadStroke.Parent = LoadingFrame

local LoadTitle = Instance.new("TextLabel")
LoadTitle.Parent = LoadingFrame
LoadTitle.Size = UDim2.new(1, 0, 0, 25)
LoadTitle.BackgroundTransparency = 1
LoadTitle.Text = "白祈验证"
LoadTitle.TextColor3 = Theme.TitleColor
LoadTitle.Font = Enum.Font.GothamBold
LoadTitle.TextSize = 14
LoadTitle.Position = UDim2.new(0, 0, 0, 10)

local LoadStatus = Instance.new("TextLabel")
LoadStatus.Parent = LoadingFrame
LoadStatus.Size = UDim2.new(1, 0, 0, 25)
LoadStatus.BackgroundTransparency = 1
LoadStatus.Text = "确认账号中..."
LoadStatus.TextColor3 = Theme.TextColor
LoadStatus.Font = Enum.Font.GothamMedium
LoadStatus.TextSize = 12
LoadStatus.Position = UDim2.new(0, 0, 0, 35)

-- ==========================================
-- 2. 主菜单界面
-- ==========================================
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0.90, 0, 0.70, 0) 
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Theme.BgColor
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Visible = false
MainFrame.ClipsDescendants = true
local MainCorner = Instance.new("UICorner") MainCorner.CornerRadius = UDim.new(0, 10) MainCorner.Parent = MainFrame
local MainStroke = Instance.new("UIStroke") MainStroke.Color = Theme.LineColor MainStroke.Thickness = 1.5 MainStroke.Parent = MainFrame

-- 背景图
local BgImage = Instance.new("ImageLabel")
BgImage.Parent = MainFrame
BgImage.Size = UDim2.new(1, 0, 1, 0)
BgImage.BackgroundTransparency = 1
BgImage.ZIndex = 0
BgImage.Image = "https://raw.githubusercontent.com/bqronlox/3349442647/main/1785143788776.png" 
BgImage.ImageTransparency = 0.85
BgImage.ScaleType = Enum.ScaleType.Crop
local BgImageCorner = Instance.new("UICorner") BgImageCorner.CornerRadius = UDim.new(0, 10) BgImageCorner.Parent = BgImage

-- 标题栏
local TitleBar = Instance.new("Frame")
TitleBar.Parent = MainFrame
TitleBar.Size = UDim2.new(1, 0, 0, 35) 
TitleBar.BackgroundColor3 = Theme.TitleColor
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 10 
TitleBar.Active = true
local TitleBarCorner = Instance.new("UICorner") TitleBarCorner.CornerRadius = UDim.new(0, 10) TitleBarCorner.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Parent = TitleBar
TitleText.Size = UDim2.new(1, -70, 1, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "白祈专属菜单"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 13
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Position = UDim2.new(0, 12, 0, 0)
TitleText.ZIndex = 11

-- 最小化/关闭
local MinBtn = Instance.new("TextButton") MinBtn.Parent = TitleBar MinBtn.Size = UDim2.new(0, 35, 1, 0) MinBtn.Position = UDim2.new(1, -70, 0, 0) MinBtn.BackgroundTransparency = 1 MinBtn.Text = "-" MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255) MinBtn.Font = Enum.Font.GothamBold MinBtn.TextSize = 18 MinBtn.ZIndex = 11
local CloseBtn = Instance.new("TextButton") CloseBtn.Parent = TitleBar CloseBtn.Size = UDim2.new(0, 35, 1, 0) CloseBtn.Position = UDim2.new(1, -35, 0, 0) CloseBtn.BackgroundTransparency = 1 CloseBtn.Text = "X" CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255) CloseBtn.Font = Enum.Font.GothamBold CloseBtn.TextSize = 13 CloseBtn.ZIndex = 11

-- 拖拽
local dragging, dragInput, dragStart, startPos
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if input.Target == MinBtn or input.Target == CloseBtn then return end
        dragging = true dragStart = input.Position startPos = MainFrame.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- ==========================================
-- 3. 左侧分类栏
-- ==========================================
local TabBar = Instance.new("Frame")
TabBar.Parent = MainFrame
TabBar.Size = UDim2.new(1/6, 0, 1, -35)
TabBar.Position = UDim2.new(0, 0, 0, 35)
TabBar.BackgroundColor3 = Theme.TabBgColor
TabBar.BackgroundTransparency = 0.2
TabBar.BorderSizePixel = 0
TabBar.ZIndex = 2

local function CreateTabButton(text, yPos)
    local btn = Instance.new("TextButton")
    btn.Parent = TabBar
    btn.Size = UDim2.new(0.9, 0, 0, 24) 
    btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(255,255,255)
    btn.BackgroundTransparency = 1
    btn.Text = text
    btn.TextColor3 = Theme.TextColor
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.ZIndex = 3
    
    local corner = Instance.new("UICorner") corner.CornerRadius = UDim.new(0, 4) corner.Parent = btn
    local indicator = Instance.new("Frame") indicator.Parent = btn indicator.Size = UDim2.new(0, 2, 0.6, 0) indicator.Position = UDim2.new(0, -2, 0.2, 0) indicator.BackgroundColor3 = Theme.TitleColor indicator.BorderSizePixel = 0 indicator.Visible = false
    local indCorner = Instance.new("UICorner") indCorner.CornerRadius = UDim.new(1, 0) indCorner.Parent = indicator

    btn.MouseEnter:Connect(function() if not indicator.Visible then btn.BackgroundTransparency = 0.5 end end)
    btn.MouseLeave:Connect(function() if not indicator.Visible then btn.BackgroundTransparency = 1 end end)
    return {Button = btn, Indicator = indicator}
end

-- ==========================================
-- 4. 右侧内容区
-- ==========================================
local ContentArea = Instance.new("Frame")
ContentArea.Parent = MainFrame
ContentArea.Size = UDim2.new(5/6, 0, 1, -35)
ContentArea.Position = UDim2.new(1/6, 0, 0, 35)
ContentArea.BackgroundTransparency = 1
ContentArea.ZIndex = 2

local function CreatePage()
    local sf = Instance.new("ScrollingFrame")
    sf.Parent = ContentArea
    sf.Size = UDim2.new(1, 0, 1, 0)
    sf.BackgroundTransparency = 1
    sf.BorderSizePixel = 0
    sf.CanvasSize = UDim2.new(0, 0, 0, 320) 
    sf.ScrollBarThickness = 2
    sf.ScrollBarImageColor3 = Theme.TitleColor
    sf.ScrollBarImageTransparency = 0.3
    sf.Visible = false
    return sf
end

local Page1 = CreatePage() -- 基础
local Page2 = CreatePage() -- 战斗
local Page3 = CreatePage() -- 系统

local currentTab = nil
local tabs = {}
local function SwitchTab(page, tabData)
    for _, p in pairs({Page1, Page2, Page3}) do p.Visible = false end
    for _, t in pairs(tabs) do t.Indicator.Visible = false; t.Button.BackgroundTransparency = 1 end
    page.Visible = true tabData.Indicator.Visible = true tabData.Button.BackgroundTransparency = 0.2
end

tabs[1] = CreateTabButton("基础", 10)
tabs[2] = CreateTabButton("战斗", 38)
tabs[3] = CreateTabButton("系统", 66)

tabs[1].Button.MouseButton1Click:Connect(function() SwitchTab(Page1, tabs[1]) end)
tabs[2].Button.MouseButton1Click:Connect(function() SwitchTab(Page2, tabs[2]) end)
tabs[3].Button.MouseButton1Click:Connect(function() SwitchTab(Page3, tabs[3]) end)
SwitchTab(Page1, tabs[1])

-- ==========================================
-- 5. 悬浮球
-- ==========================================
local FloatBtn = Instance.new("TextButton")
FloatBtn.Parent = ScreenGui
FloatBtn.Size = UDim2.new(0, 36, 0, 36)
FloatBtn.AnchorPoint = Vector2.new(0.5, 0.5)
FloatBtn.Position = UDim2.new(0.5, 0, 0.5, 0) 
FloatBtn.BackgroundColor3 = Theme.TitleColor
FloatBtn.Text = "白"
FloatBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatBtn.Font = Enum.Font.GothamBold
FloatBtn.TextSize = 16
FloatBtn.BorderSizePixel = 0
FloatBtn.Visible = false
FloatBtn.Active = true
local FloatCorner = Instance.new("UICorner") FloatCorner.CornerRadius = UDim.new(1, 0) FloatCorner.Parent = FloatBtn
local FloatStroke = Instance.new("UIStroke") FloatStroke.Color = Color3.fromRGB(255,255,255) FloatStroke.Thickness = 1.5 FloatStroke.Transparency = 0.5 FloatStroke.Parent = FloatBtn

local floatDragging, floatDragInput, floatDragStart, floatStartPos
FloatBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        floatDragging = true floatDragStart = input.Position floatStartPos = FloatBtn.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then floatDragging = false end end)
    end
end)
FloatBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then floatDragInput = input end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == floatDragInput and floatDragging then
        local delta = input.Position - floatDragStart
        FloatBtn.Position = UDim2.new(floatStartPos.X.Scale, floatStartPos.X.Offset + delta.X, floatStartPos.Y.Scale, floatStartPos.Y.Offset + delta.Y)
    end
end)

local isMinimized = false
MinBtn.MouseButton1Click:Connect(function()
    if not isMinimized then
        isMinimized = true 
        local centerX = MainFrame.AbsolutePosition.X + MainFrame.AbsoluteSize.X / 2
        local centerY = MainFrame.AbsolutePosition.Y + MainFrame.AbsoluteSize.Y / 2
        FloatBtn.Position = UDim2.fromOffset(centerX, centerY)
        MainFrame.Visible = false 
        FloatBtn.Visible = true
    end
end)

FloatBtn.MouseButton1Click:Connect(function()
    if isMinimized then
        isMinimized = false 
        local screenSize = ScreenGui.AbsoluteSize
        local limitX = math.clamp(FloatBtn.AbsolutePosition.X, MainFrame.AbsoluteSize.X / 2, screenSize.X - MainFrame.AbsoluteSize.X / 2)
        local limitY = math.clamp(FloatBtn.AbsolutePosition.Y, MainFrame.AbsoluteSize.Y / 2, screenSize.Y - MainFrame.AbsoluteSize.Y / 2)
        
        MainFrame.Position = UDim2.fromOffset(limitX, limitY)
        FloatBtn.Visible = false 
        MainFrame.Visible = true
    end
end)

-- ==========================================
-- 6. 极简组件
-- ==========================================
local function CreateToggle(parentPage, text, yPos, initialValue, callback)
    local container = Instance.new("Frame")
    container.Parent = parentPage
    container.Size = UDim2.new(0.96, 0, 0, 24)
    container.Position = UDim2.new(0.02, 0, 0, yPos)
    container.BackgroundColor3 = Theme.BtnColor
    container.BackgroundTransparency = 0.1
    container.BorderSizePixel = 0
    local containerCorner = Instance.new("UICorner") containerCorner.CornerRadius = UDim.new(0, 4) containerCorner.Parent = container
    local containerStroke = Instance.new("UIStroke") containerStroke.Color = Theme.LineColor containerStroke.Thickness = 1 containerStroke.Parent = container
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Parent = container
    textLabel.Size = UDim2.new(0.75, 0, 1, 0)
    textLabel.Position = UDim2.new(0.03, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = Theme.TextColor
    textLabel.Font = Enum.Font.GothamMedium
    textLabel.TextSize = 11 
    textLabel.TextXAlignment = Enum.TextXAlignment.Left

    local switchBg = Instance.new("Frame")
    switchBg.Parent = container
    switchBg.Size = UDim2.new(0, 28, 0, 14) 
    switchBg.Position = UDim2.new(1, -32, 0.5, -7)
    switchBg.BackgroundColor3 = Theme.SwitchOff
    switchBg.BorderSizePixel = 0
    local switchBgCorner = Instance.new("UICorner") switchBgCorner.CornerRadius = UDim.new(1, 0) switchBgCorner.Parent = switchBg

    local switchDot = Instance.new("Frame")
    switchDot.Parent = switchBg
    switchDot.Size = UDim2.new(0, 10, 0, 10) 
    switchDot.Position = UDim2.new(0, 2, 0.5, -5)
    switchDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    switchDot.BorderSizePixel = 0
    local switchDotCorner = Instance.new("UICorner") switchDotCorner.CornerRadius = UDim.new(1, 0) switchDotCorner.Parent = switchDot

    local clickBtn = Instance.new("TextButton")
    clickBtn.Parent = container
    clickBtn.Size = UDim2.new(1, 0, 1, 0)
    clickBtn.BackgroundTransparency = 1
    clickBtn.Text = ""

    local isOn = initialValue
    local function UpdateUI(animated)
        if isOn then
            switchBg.BackgroundColor3 = Theme.SwitchOn
            if animated then TweenService:Create(switchDot, TweenInfo.new(0.2), {Position = UDim2.new(1, -12, 0.5, -5)}):Play() else switchDot.Position = UDim2.new(1, -12, 0.5, -5) end
        else
            switchBg.BackgroundColor3 = Theme.SwitchOff
            if animated then TweenService:Create(switchDot, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -5)}):Play() else switchDot.Position = UDim2.new(0, 2, 0.5, -5) end
        end
    end
    UpdateUI(false)
    clickBtn.MouseButton1Click:Connect(function() isOn = not isOn UpdateUI(true) callback(isOn) end)
    return {SetState = function(state) isOn = state UpdateUI(true) end, Frame = container}
end

local function CreateInput(parentPage, placeholder, yPos, textColor)
    local input = Instance.new("TextBox")
    input.Parent = parentPage
    input.Size = UDim2.new(0.96, 0, 0, 24) 
    input.Position = UDim2.new(0.02, 0, 0, yPos)
    input.BackgroundColor3 = Theme.InputBg
    input.BackgroundTransparency = 0.1
    input.Text = ""
    input.PlaceholderText = placeholder
    input.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    input.TextColor3 = textColor or Theme.TextColor
    input.Font = Enum.Font.GothamMedium
    input.TextSize = 11
    input.BorderSizePixel = 0
    local corner = Instance.new("UICorner") corner.CornerRadius = UDim.new(0, 4) corner.Parent = input
    local stroke = Instance.new("UIStroke") stroke.Color = Theme.LineColor stroke.Thickness = 1 stroke.Parent = input
    return input
end

-- ==========================================
-- 7. 功能实现 (基础)
-- ==========================================
local SpeedInput = CreateInput(Page1, "输入行走速度", 8, Theme.TextColor) SpeedInput.Text = "100"
local speedActive = false
CreateToggle(Page1, "自定义速度", 36, false, function(Value)
    speedActive = Value local char = Player.Character
    if char and char:FindFirstChild("Humanoid") then if speedActive then char.Humanoid.WalkSpeed = tonumber(SpeedInput.Text) or 16 else char.Humanoid.WalkSpeed = 16 end end
end)
SpeedInput.FocusLost:Connect(function() if speedActive then local char = Player.Character if char and char:FindFirstChild("Humanoid") then char.Humanoid.WalkSpeed = tonumber(SpeedInput.Text) or 16 end end end)

local JumpInput = CreateInput(Page1, "输入跳跃力", 64, Theme.TextColor) JumpInput.Text = "100"
local jumpActive = false
CreateToggle(Page1, "自定义跳跃", 92, false, function(Value)
    jumpActive = Value local char = Player.Character
    if char and char:FindFirstChild("Humanoid") then if jumpActive then char.Humanoid.JumpPower = tonumber(JumpInput.Text) or 50 char.Humanoid.UseJumpPower = true else char.Humanoid.JumpPower = 50 end end
end)
JumpInput.FocusLost:Connect(function() if jumpActive then local char = Player.Character if char and char:FindFirstChild("Humanoid") then char.Humanoid.JumpPower = tonumber(JumpInput.Text) or 50 char.Humanoid.UseJumpPower = true end end end)

local PulseInput = CreateInput(Page1, "输入脉冲推力 (建议1-5)", 120, Color3.fromRGB(0, 150, 100)) PulseInput.Text = "2" 
local pulseActive = false local renderConnection = nil local originalSpeed = 16 
CreateToggle(Page1, "脉冲加速", 148, false, function(Value)
    pulseActive = Value local char = Player.Character
    if pulseActive then
        if char and char:FindFirstChild("Humanoid") then originalSpeed = char.Humanoid.WalkSpeed end
        renderConnection = RunService.RenderStepped:Connect(function()
            if not pulseActive then return end local char = Player.Character
            if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
                local moveDir = char.Humanoid.MoveDirection local speedVal = tonumber(PulseInput.Text) or 2 
                if moveDir.Magnitude > 0 then char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + (moveDir * speedVal) end
            end
        end)
    else
        if renderConnection then renderConnection:Disconnect() end
        if char and char:FindFirstChild("Humanoid") then char.Humanoid.WalkSpeed = originalSpeed end
    end
end)

local isFlying = false local isBoosting = false local isLanding = false local flyConnection = nil local defaultFOV = workspace.CurrentCamera.FieldOfView 
local boostToggleData = CreateToggle(Page1, "极速冲刺 (FOV增强)", 204, false, function(Value)
    isBoosting = Value
    if isBoosting then TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {FieldOfView = 110}):Play() else TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {FieldOfView = defaultFOV}):Play() end
end)
local BoostFrame = boostToggleData.Frame BoostFrame.Visible = false 

-- 🚀 完美悬浮飞行 (摇杆+视角联合控制)
CreateToggle(Page1, "开启飞行 (视角控制)", 176, false, function(Value)
    isFlying = Value 
    local char = Player.Character
    if not char then return end 
    local hrp = char:FindFirstChild("HumanoidRootPart") 
    local hum = char:FindFirstChild("Humanoid") 
    if not hrp or not hum then return end
    
    if isFlying then
        BoostFrame.Visible = true 
        if isLanding then isLanding = false end 
        
        hum.PlatformStand = false 
        
        local bf = Instance.new("BodyForce", hrp)
        bf.Name = "FlyForce"
        bf.Force = Vector3.new(0, workspace.Gravity * hrp.AssemblyMass, 0)
        
        local bg = Instance.new("BodyGyro", hrp)
        bg.Name = "FlyGyro"
        bg.P = 1e4
        bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
        bg.CFrame = hrp.CFrame
        
        local bv = Instance.new("BodyVelocity", hrp) 
        bv.Name = "FlyVel" 
        bv.MaxForce = Vector3.new(1e9, 1e9, 1e9) 
        bv.Velocity = Vector3.new(0, 0, 0)
        
        if flyConnection then flyConnection:Disconnect() end
        flyConnection = RunService.RenderStepped:Connect(function()
            if not isFlying or not char or not char.Parent then return end
            local currentHrp = char:FindFirstChild("HumanoidRootPart") 
            local currentHum = char:FindFirstChild("Humanoid")
            
            if currentHrp and currentHum and currentHrp:FindFirstChild("FlyVel") then
                local bvInBody = currentHrp.FlyVel
                local bgInBody = currentHrp.FlyGyro
                local moveDir = currentHum.MoveDirection
                local cam = workspace.CurrentCamera
                local currentFlySpeed = isBoosting and 200 or 50 
                
                if currentHum:GetState() ~= Enum.HumanoidStateType.Flying and currentHum:GetState() ~= Enum.HumanoidStateType.Freefall then
                    currentHum:ChangeState(Enum.HumanoidStateType.Freefall)
                end
                
                if bgInBody then bgInBody.CFrame = cam.CFrame end
                
                if moveDir.Magnitude > 0.1 then 
                    local flyDir = (cam.CFrame.LookVector * (-moveDir.Z) + cam.CFrame.RightVector * moveDir.X).Unit
                    bvInBody.Velocity = flyDir * currentFlySpeed 
                else 
                    bvInBody.Velocity = Vector3.new(0, 0, 0) 
                end
            end
        end)
    else
        BoostFrame.Visible = false 
        boostToggleData.SetState(false) 
        isBoosting = false 
        
        hum.PlatformStand = false 
        hum:ChangeState(Enum.HumanoidStateType.GettingUp)
        
        if hrp:FindFirstChild("FlyForce") then hrp.FlyForce:Destroy() end
        if hrp:FindFirstChild("FlyVel") then hrp.FlyVel:Destroy() end
        if hrp:FindFirstChild("FlyGyro") then hrp.FlyGyro:Destroy() end
        
        TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.5), {FieldOfView = defaultFOV}):Play() 
        isLanding = true
    end
end)

-- ==========================================
-- 8. 功能实现 (战斗)
-- ==========================================
local isLocked = false local lockConnection = nil local lockedCFrame = nil
CreateToggle(Page2, "角色锁定", 8, false, function(Value)
    isLocked = Value local char = Player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    if isLocked then
        lockedCFrame = char.HumanoidRootPart.CFrame
        lockConnection = RunService.RenderStepped:Connect(function() if isLocked and char and char:FindFirstChild("HumanoidRootPart") then char.HumanoidRootPart.CFrame = lockedCFrame char.HumanoidRootPart.Velocity = Vector3.new(0,0,0) char.HumanoidRootPart.RotVelocity = Vector3.new(0,0,0) end end)
    else 
        if lockConnection then lockConnection:Disconnect() end lockedCFrame = nil 
        if char and char:FindFirstChild("HumanoidRootPart") then char.HumanoidRootPart.Velocity = Vector3.new(0,0,0) char.HumanoidRootPart.RotVelocity = Vector3.new(0,0,0) end
    end
end)

local TargetInput = CreateInput(Page2, "输入玩家ID (留空=最近)", 36, Color3.fromRGB(200, 100, 100))
local aimbotActive = false local aimbotConnection = nil
CreateToggle(Page2, "锁定玩家", 64, false, function(Value)
    aimbotActive = Value
    if aimbotActive then
        aimbotConnection = RunService.RenderStepped:Connect(function()
            if not aimbotActive then return end
            local targetIdString = string.gsub(TargetInput.Text, "%s+", "") local targetHrp = nil local cam = workspace.CurrentCamera
            if targetIdString ~= "" then local targetId = tonumber(targetIdString) if targetId then for _, p in pairs(Player:GetPlayers()) do if p ~= Player and p.UserId == targetId and p.Character then local hrp = p.Character:FindFirstChild("HumanoidRootPart") local hum = p.Character:FindFirstChild("Humanoid") if hrp and hum and hum.Health > 0 then targetHrp = hrp break end end end end end
            if not targetHrp then local closestDist = math.huge local myPos = cam.CFrame.Position for _, p in pairs(Player:GetPlayers()) do if p ~= Player and p.Character then local hrp = p.Character:FindFirstChild("HumanoidRootPart") local hum = p.Character:FindFirstChild("Humanoid") if hrp and hum and hum.Health > 0 then local dist = (hrp.Position - myPos).Magnitude if dist < closestDist then closestDist = dist targetHrp = hrp end end end end end
            if targetHrp then local targetCFrame = CFrame.lookAt(cam.CFrame.Position, targetHrp.Position) cam.CFrame = cam.CFrame:Lerp(targetCFrame, 0.2) end
        end)
    else if aimbotConnection then aimbotConnection:Disconnect() aimbotConnection = nil end end
end)

local NpcInput = CreateInput(Page2, "输入NPC名称 (留空=最近)", 92, Color3.fromRGB(0, 150, 100))
local aimbotNpcActive = false local aimbotNpcConnection = nil local currentNpcTarget = nil local lastScanTime = 0 
CreateToggle(Page2, "自动锁定NPC", 120, false, function(Value)
    aimbotNpcActive = Value currentNpcTarget = nil 
    if aimbotNpcActive then
        aimbotNpcConnection = RunService.RenderStepped:Connect(function()
            if not aimbotNpcActive then return end
            local cam = workspace.CurrentCamera local myPos = cam.CFrame.Position
            if tick() - lastScanTime > 0.5 then
                lastScanTime = tick() local targetName = string.gsub(NpcInput.Text, "%s+", "") local closestDist = math.huge local bestHrp = nil
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("Model") and obj:FindFirstChild("HumanoidRootPart") and obj:FindFirstChild("Humanoid") then
                        local isPlayer = false for _, p in pairs(Player:GetPlayers()) do if p.Character == obj then isPlayer = true break end end
                        if not isPlayer and obj.Humanoid.Health > 0 then
                            local match = false if targetName == "" then match = true elseif string.find(string.lower(obj.Name), string.lower(targetName)) then match = true end
                            if match then local hrp = obj.HumanoidRootPart local dist = (hrp.Position - myPos).Magnitude if dist < closestDist and dist < 2000 then closestDist = dist currentNpcTarget = obj bestHrp = hrp end end
                        end
                    end
                end
                if not bestHrp then currentNpcTarget = nil end
            end
            if currentNpcTarget and currentNpcTarget.Parent then local hrp = currentNpcTarget:FindFirstChild("HumanoidRootPart") if hrp then cam.CFrame = cam.CFrame:Lerp(CFrame.lookAt(cam.CFrame.Position, hrp.Position), 0.2) end end
        end)
    else if aimbotNpcConnection then aimbotNpcConnection:Disconnect() aimbotNpcConnection = nil end currentNpcTarget = nil end
end)

local isTrackingFling = false local savedCFrame = nil local trackingConnection = nil
CreateToggle(Page2, "究极暴力甩飞", 148, false, function(Value)
    isTrackingFling = Value local char = Player.Character
    if not char then return end local hrp = char:FindFirstChild("HumanoidRootPart") local hum = char:FindFirstChild("Humanoid") if not hrp or not hum then return end
    if isTrackingFling then
        savedCFrame = hrp.CFrame hum.PlatformStand = false 
        trackingConnection = RunService.RenderStepped:Connect(function()
            if not isTrackingFling then return end
            local targetIdString = string.gsub(TargetInput.Text, "%s+", "") local targetPlayer = nil
            if targetIdString ~= "" then local targetId = tonumber(targetIdString) if targetId then for _, p in pairs(Player:GetPlayers()) do if p ~= Player and p.UserId == targetId then targetPlayer = p break end end end end
            if not targetPlayer then local closestDist = math.huge for _, p in pairs(Player:GetPlayers()) do if p ~= Player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid").Health > 0 then local dist = (p.Character.HumanoidRootPart.Position - workspace.CurrentCamera.CFrame.Position).Magnitude if dist < closestDist then closestDist = dist targetPlayer = p end end end end
            if targetPlayer and targetPlayer.Character then
                local targetHrp = targetPlayer.Character:FindFirstChild("HumanoidRootPart") local currentChar = Player.Character
                if targetHrp and currentChar and currentChar:FindFirstChild("HumanoidRootPart") then
                    local myHrp = currentChar.HumanoidRootPart
                    myHrp.CFrame = targetHrp.CFrame myHrp.Velocity = Vector3.new(0, 0, 0) 
                    local targetBav = targetHrp:FindFirstChild("FlingSpin")
                    if not targetBav then targetBav = Instance.new("BodyAngularVelocity", targetHrp) targetBav.Name = "FlingSpin" targetBav.AngularVelocity = Vector3.new(999999, 999999, 999999) targetBav.MaxTorque = Vector3.new(math.huge, math.huge, math.huge) end
                    local targetBv = targetHrp:FindFirstChild("FlingVel")
                    if not targetBv then targetBv = Instance.new("BodyVelocity", targetHrp) targetBv.Name = "FlingVel" targetBv.Velocity = Vector3.new(math.random(-1000, 1000), 3000, math.random(-1000, 1000)) targetBv.MaxForce = Vector3.new(math.huge, math.huge, math.huge) end
                end
            end
        end)
    else
        if trackingConnection then trackingConnection:Disconnect() trackingConnection = nil end
        if savedCFrame then hrp.CFrame = savedCFrame savedCFrame = nil end
    end
end)

-- 🚨 强力防甩飞 (坐标锚定)
local isAntiFling = false local antiFlingConnection = nil
CreateToggle(Page2, "强力防甩飞", 176, false, function(Value)
    isAntiFling = Value 
    local char = Player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    if isAntiFling then
        local anchorCF = hrp.CFrame 
        antiFlingConnection = RunService.RenderStepped:Connect(function()
            if isAntiFling and char and char:FindFirstChild("HumanoidRootPart") then
                local currentHrp = char.HumanoidRootPart
                if currentHrp.Velocity.Magnitude > 100 or currentHrp.RotVelocity.Magnitude > 10 then
                    currentHrp.Velocity = Vector3.new(0, 0, 0)
                    currentHrp.RotVelocity = Vector3.new(0, 0, 0)
                    currentHrp.CFrame = anchorCF
                else
                    anchorCF = currentHrp.CFrame
                end
            end
        end)
    else 
        if antiFlingConnection then antiFlingConnection:Disconnect() end 
    end
end)

-- ==========================================
-- 9. 功能实现 (系统)
-- ==========================================
local isShieldActive = false
CreateToggle(Page3, "主动反击盾", 8, false, function(Value)
    isShieldActive = Value
    if isShieldActive then
        if not _G.MyHttpPostHooked then
            local oldPost = HttpService.PostAsync
            HttpService.PostAsync = function(self, url, data, contentType)
                if tostring(url):find("discord") or tostring(url):find("webhook") or tostring(url):find("http") then
                    task.spawn(function() for i = 1, 20 do pcall(function() oldPost(self, url, '{"content": "Blocked"}', contentType) end) task.wait(0.1) end end)
                    return "{}"
                end
                return oldPost(self, url, data, contentType)
            end
            _G.MyHttpPostHooked = true
        end
        task.spawn(function()
            while isShieldActive do
                task.wait(2)
                local playScripts = Player:FindFirstChild("PlayerScripts")
                if playScripts then for _, scriptObj in pairs(playScripts:GetDescendants()) do if (scriptObj:IsA("LocalScript") or scriptObj:IsA("ModuleScript")) and scriptObj.Name ~= "BaiQiMenu" then local ok, src = pcall(function() return scriptObj.Source end) if ok and src and (src:find("webhook") or src:find("HttpPost") or src:find("discord")) then scriptObj:Destroy() end end end end
            end
        end)
    end
end)

local MusicInput = CreateInput(Page3, "输入音乐数字ID", 36, Theme.TextColor)
local musicActive = false local currentMusic = nil
CreateToggle(Page3, "播放本地音乐", 64, false, function(Value)
    musicActive = Value local idString = MusicInput.Text
    if musicActive then
        if idString == "" then return end
        local soundId = tonumber(idString) if not soundId then return end
        if SoundService:FindFirstChild("BaiQiMusic") then SoundService.BaiQiMusic:Destroy() end
        currentMusic = Instance.new("Sound") currentMusic.Name = "BaiQiMusic" currentMusic.Parent = SoundService currentMusic.SoundId = "rbxassetid://" .. soundId currentMusic.Volume = 1 currentMusic.Looped = true
        currentMusic:Play()
    else
        if currentMusic then currentMusic:Destroy() currentMusic = nil end
        if SoundService:FindFirstChild("BaiQiMusic") then SoundService.BaiQiMusic:Destroy() end
    end
end)

local closeMenuBtn = Instance.new("TextButton")
closeMenuBtn.Parent = Page3
closeMenuBtn.Size = UDim2.new(0.96, 0, 0, 24) 
closeMenuBtn.Position = UDim2.new(0.02, 0, 0, 92) 
closeMenuBtn.BackgroundColor3 = Color3.fromRGB(255, 235, 235)
closeMenuBtn.Text = "关闭菜单"
closeMenuBtn.TextColor3 = Color3.fromRGB(200, 60, 60)
closeMenuBtn.Font = Enum.Font.GothamBold
closeMenuBtn.TextSize = 11
closeMenuBtn.BorderSizePixel = 0
local closeMenuBtnCorner = Instance.new("UICorner") closeMenuBtnCorner.CornerRadius = UDim.new(0, 4) closeMenuBtnCorner.Parent = closeMenuBtn
local closeMenuBtnStroke = Instance.new("UIStroke") closeMenuBtnStroke.Color = Color3.fromRGB(255, 200, 200) closeMenuBtnStroke.Thickness = 1 closeMenuBtnStroke.Parent = closeMenuBtn

-- ==========================================
-- 10. 关闭逻辑
-- ==========================================
local function DestroyMenu()
    if renderConnection then renderConnection:Disconnect() end if flyConnection then flyConnection:Disconnect() end if lockConnection then lockConnection:Disconnect() end if aimbotConnection then aimbotConnection:Disconnect() end if aimbotNpcConnection then aimbotNpcConnection:Disconnect() end if trackingConnection then trackingConnection:Disconnect() end if antiFlingConnection then antiFlingConnection:Disconnect() end
    
    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.5), {FieldOfView = defaultFOV}):Play()
    
    local char = Player.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart") local hum = char:FindFirstChild("Humanoid")
        if hum then hum.PlatformStand = false hum.WalkSpeed = 16 hum.JumpPower = 50 hum.AutoRotate = true end
        if hrp then
            hrp.Velocity = Vector3.new(0, 0, 0) hrp.RotVelocity = Vector3.new(0, 0, 0) 
            if hrp:FindFirstChild("LocalFly") then hrp.LocalFly:Destroy() end if hrp:FindFirstChild("LocalFlyGyro") then hrp.LocalFlyGyro:Destroy() end if hrp:FindFirstChild("FlingSpin") then hrp.FlingSpin:Destroy() end if hrp:FindFirstChild("MySpin") then hrp.MySpin:Destroy() end if hrp:FindFirstChild("FlyForce") then hrp.FlyForce:Destroy() end if hrp:FindFirstChild("FlyVel") then hrp.FlyVel:Destroy() end if hrp:FindFirstChild("FlyGyro") then hrp.FlyGyro:Destroy() end
        end
    end

    if SoundService:FindFirstChild("BaiQiMusic") then SoundService.BaiQiMusic:Destroy() end
    FloatBtn.Visible = false 
    closeMenuBtn.Active = false
    
    local fadeTweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Linear)
    for _, obj in pairs(MainFrame:GetDescendants()) do
        if obj:IsA("GuiObject") then
            TweenService:Create(obj, fadeTweenInfo, {BackgroundTransparency = 1}):Play()
            if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then TweenService:Create(obj, fadeTweenInfo, {TextTransparency = 1}):Play() if obj:IsA("TextBox") then TweenService:Create(obj, fadeTweenInfo, {PlaceholderColor3 = Theme.BgColor}):Play() end end
            if obj:IsA("ImageLabel") or obj:IsA("ImageButton") then TweenService:Create(obj, fadeTweenInfo, {ImageTransparency = 1}):Play() end
        elseif obj:IsA("UIStroke") then TweenService:Create(obj, fadeTweenInfo, {Transparency = 1}):Play() end
    end
    TweenService:Create(MainFrame, fadeTweenInfo, {BackgroundTransparency = 1}):Play()
    TweenService:Create(MainStroke, fadeTweenInfo, {Transparency = 1}):Play()

    task.delay(0.4, function()
        local tweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.In, 0, false, 0.5)
        local tween = TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0, 0, 0, 0)})
        tween:Play()
        tween.Completed:Connect(function() ScreenGui:Destroy() end)
    end)
end

closeMenuBtn.MouseButton1Click:Connect(DestroyMenu)
CloseBtn.MouseButton1Click:Connect(DestroyMenu) 

closeMenuBtn.MouseEnter:Connect(function() if closeMenuBtn.Active then closeMenuBtn.BackgroundColor3 = Color3.fromRGB(255, 210, 210) end end)
closeMenuBtn.MouseLeave:Connect(function() if closeMenuBtn.Active then closeMenuBtn.BackgroundColor3 = Color3.fromRGB(255, 235, 235) end end)
CloseBtn.MouseEnter:Connect(function() CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80) end)
CloseBtn.MouseLeave:Connect(function() CloseBtn.BackgroundColor3 = Color3.fromRGB(0,0,0) CloseBtn.BackgroundTransparency = 1 end)
MinBtn.MouseEnter:Connect(function() MinBtn.BackgroundColor3 = Color3.fromRGB(255, 180, 100) end)
MinBtn.MouseLeave:Connect(function() MinBtn.BackgroundColor3 = Color3.fromRGB(0,0,0) MinBtn.BackgroundTransparency = 1 end)

-- ==========================================
-- 加载完成
-- ==========================================
task.spawn(function()
    task.wait(1.2)
    LoadStatus.Text = "确认成功"
    LoadStatus.TextColor3 = Theme.TitleColor
    task.wait(0.3)
    
    local fadeTween = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(LoadingFrame, fadeTween, {BackgroundTransparency = 1}):Play()
    TweenService:Create(LoadStroke, fadeTween, {Transparency = 1}):Play()
    
    for _, obj in pairs(LoadingFrame:GetDescendants()) do
        if obj:IsA("TextLabel") then TweenService:Create(obj, fadeTween, {TextTransparency = 1}):Play() end
    end
    
    task.wait(0.3)
    LoadingFrame:Destroy()
    
    MainFrame.Visible = true
    Player.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end)
