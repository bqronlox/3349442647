-- ==========================================
-- 白祈专属菜单 (账号绑定防泄露版)
-- 仅限账号 ID: 10497218129 使用
-- ==========================================
local MyUserId = 10497218129 -- 你的专属ID，填错会把自己踢出去

local CoreGui = game:GetService("CoreGui")
local Player = game.Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local UserInputService = game:GetService("UserInputService")

-- 🚨 身份验证拦截：如果 ID 不对，播放冰冰冰音频并踢人！
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
    punishSound.SoundId = "rbxassetid://17684982508" -- 冰冰冰音效
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
    BgColor = Color3.fromRGB(255, 255, 255),        
    TitleColor = Color3.fromRGB(152, 251, 152),     
    TextColor = Color3.fromRGB(60, 60, 60),         
    BtnColor = Color3.fromRGB(245, 245, 245),       
    BtnHover = Color3.fromRGB(220, 255, 220),       
    InputBg = Color3.fromRGB(250, 250, 250),        
    SwitchOff = Color3.fromRGB(210, 210, 210),      
    SwitchOn = Color3.fromRGB(100, 220, 130),       
    LineColor = Color3.fromRGB(200, 240, 200),
    ScrollBar = Color3.fromRGB(180, 230, 180),
    CloseHover = Color3.fromRGB(255, 100, 100),
    MinHover = Color3.fromRGB(255, 200, 100)
}

-- ==========================================
-- 1. 自动验证加载界面
-- ==========================================
local LoadingFrame = Instance.new("Frame")
LoadingFrame.Parent = ScreenGui
LoadingFrame.Size = UDim2.new(0.8, 0, 0.25, 0)
LoadingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
LoadingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingFrame.BackgroundColor3 = Theme.BgColor
LoadingFrame.BorderSizePixel = 0

local LoadSizeConstraint = Instance.new("UISizeConstraint") LoadSizeConstraint.MaxSize = Vector2.new(300, 150) LoadSizeConstraint.MinSize = Vector2.new(200, 100) LoadSizeConstraint.Parent = LoadingFrame
local LoadRatio = Instance.new("UIAspectRatioConstraint") LoadRatio.AspectRatio = 2 LoadRatio.Parent = LoadingFrame
local LoadCorner = Instance.new("UICorner") LoadCorner.CornerRadius = UDim.new(0, 8) LoadCorner.Parent = LoadingFrame
local LoadStroke = Instance.new("UIStroke") LoadStroke.Color = Theme.LineColor LoadStroke.Thickness = 1 LoadStroke.Parent = LoadingFrame

local LoadTitle = Instance.new("TextLabel")
LoadTitle.Parent = LoadingFrame
LoadTitle.Size = UDim2.new(1, 0, 0, 30)
LoadTitle.BackgroundTransparency = 1
LoadTitle.Text = "白祈 - 身份验证"
LoadTitle.TextColor3 = Theme.TitleColor
LoadTitle.Font = Enum.Font.GothamBold
LoadTitle.TextSize = 16
LoadTitle.Position = UDim2.new(0, 0, 0, 15)

local LoadStatus = Instance.new("TextLabel")
LoadStatus.Parent = LoadingFrame
LoadStatus.Size = UDim2.new(1, 0, 0, 30)
LoadStatus.BackgroundTransparency = 1
LoadStatus.Text = "正在确认账号信息..."
LoadStatus.TextColor3 = Theme.TextColor
LoadStatus.Font = Enum.Font.GothamMedium
LoadStatus.TextSize = 14
LoadStatus.Position = UDim2.new(0, 0, 0, 50)

-- ==========================================
-- 2. 主菜单界面
-- ==========================================
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0.8, 0, 0.6, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Theme.BgColor
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Visible = false

local MainSizeConstraint = Instance.new("UISizeConstraint") MainSizeConstraint.MaxSize = Vector2.new(450, 337.5) MainSizeConstraint.MinSize = Vector2.new(300, 225) MainSizeConstraint.Parent = MainFrame
local MainRatio = Instance.new("UIAspectRatioConstraint") MainRatio.AspectRatio = 4/3 MainRatio.Parent = MainFrame
local MainCorner = Instance.new("UICorner") MainCorner.CornerRadius = UDim.new(0, 8) MainCorner.Parent = MainFrame
local MainStroke = Instance.new("UIStroke") MainStroke.Color = Theme.LineColor MainStroke.Thickness = 1 MainStroke.Parent = MainFrame

-- 固定背景图
local BgImage = Instance.new("ImageLabel")
BgImage.Parent = MainFrame
BgImage.Size = UDim2.new(1, 0, 1, 0)
BgImage.BackgroundTransparency = 1
BgImage.ZIndex = 0
BgImage.Image = "https://raw.githubusercontent.com/bqronlox/3349442647/main/1785143788776.png" 
BgImage.ImageTransparency = 0.5 
BgImage.ScaleType = Enum.ScaleType.Crop
local BgImageCorner = Instance.new("UICorner") BgImageCorner.CornerRadius = UDim.new(0, 8) BgImageCorner.Parent = BgImage

-- 标题栏
local TitleBar = Instance.new("Frame")
TitleBar.Parent = MainFrame
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Theme.TitleColor
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 2
TitleBar.Active = true
local TitleBarCorner = Instance.new("UICorner") TitleBarCorner.CornerRadius = UDim.new(0, 8) TitleBarCorner.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Parent = TitleBar
TitleText.Size = UDim2.new(1, -80, 1, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "白祈专属菜单"
TitleText.TextColor3 = Theme.TextColor
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 15
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Position = UDim2.new(0, 15, 0, 0)

-- 最小化
local MinBtn = Instance.new("TextButton")
MinBtn.Parent = TitleBar
MinBtn.Size = UDim2.new(0, 40, 1, 0)
MinBtn.Position = UDim2.new(1, -80, 0, 0)
MinBtn.BackgroundTransparency = 1
MinBtn.Text = "-"
MinBtn.TextColor3 = Theme.TextColor
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 20
MinBtn.ZIndex = 3

-- 关闭
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = TitleBar
CloseBtn.Size = UDim2.new(0, 40, 1, 0)
CloseBtn.Position = UDim2.new(1, -40, 0, 0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Theme.TextColor
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16
CloseBtn.ZIndex = 3

-- 拖拽
local dragging, dragInput, dragStart, startPos
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if input.Target == MinBtn or input.Target == CloseBtn then return end
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
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

-- 滚动
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Parent = MainFrame
ScrollFrame.Size = UDim2.new(1, 0, 1, -40)
ScrollFrame.Position = UDim2.new(0, 0, 0, 40)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 820) 
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.ScrollBarImageColor3 = Theme.ScrollBar
ScrollFrame.ScrollBarImageTransparency = 0.3
ScrollFrame.ZIndex = 2 

-- ==========================================
-- 3. 悬浮球
-- ==========================================
local FloatBtn = Instance.new("TextButton")
FloatBtn.Parent = ScreenGui
FloatBtn.Size = UDim2.new(0, 50, 0, 50)
FloatBtn.Position = UDim2.new(0, 20, 0.5, -25) 
FloatBtn.BackgroundColor3 = Theme.TitleColor
FloatBtn.Text = "白"
FloatBtn.TextColor3 = Theme.TextColor
FloatBtn.Font = Enum.Font.GothamBold
FloatBtn.TextSize = 24
FloatBtn.BorderSizePixel = 0
FloatBtn.Visible = false
FloatBtn.Active = true
local FloatCorner = Instance.new("UICorner") FloatCorner.CornerRadius = UDim.new(1, 0) FloatCorner.Parent = FloatBtn
local FloatStroke = Instance.new("UIStroke") FloatStroke.Color = Theme.SwitchOn FloatStroke.Thickness = 2 FloatStroke.Parent = FloatBtn

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
        FloatBtn.Position = MainFrame.Position
        MainFrame.Visible = false
        FloatBtn.Visible = true
    end
end)
FloatBtn.MouseButton1Click:Connect(function()
    if isMinimized then
        isMinimized = false
        MainFrame.Position = FloatBtn.Position
        FloatBtn.Visible = false
        MainFrame.Visible = true
    end
end)

-- 组件函数
local function CreateToggle(text, yPos, initialValue, callback)
    local container = Instance.new("Frame")
    container.Parent = ScrollFrame
    container.Size = UDim2.new(0.9, 0, 0, 35)
    container.Position = UDim2.new(0.05, 0, 0, yPos)
    container.BackgroundColor3 = Theme.BtnColor
    container.BackgroundTransparency = 0.2
    container.BorderSizePixel = 0
    local containerCorner = Instance.new("UICorner") containerCorner.CornerRadius = UDim.new(0, 6) containerCorner.Parent = container
    local containerStroke = Instance.new("UIStroke") containerStroke.Color = Theme.LineColor containerStroke.Thickness = 1 containerStroke.Parent = container
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Parent = container
    textLabel.Size = UDim2.new(0.7, 0, 1, 0)
    textLabel.Position = UDim2.new(0.05, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = Theme.TextColor
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextSize = 13
    textLabel.TextXAlignment = Enum.TextXAlignment.Left

    local switchBg = Instance.new("Frame")
    switchBg.Parent = container
    switchBg.Size = UDim2.new(0, 40, 0, 20)
    switchBg.Position = UDim2.new(1, -50, 0.5, -10)
    switchBg.BackgroundColor3 = Theme.SwitchOff
    switchBg.BorderSizePixel = 0
    local switchBgCorner = Instance.new("UICorner") switchBgCorner.CornerRadius = UDim.new(1, 0) switchBgCorner.Parent = switchBg

    local switchDot = Instance.new("Frame")
    switchDot.Parent = switchBg
    switchDot.Size = UDim2.new(0, 16, 0, 16)
    switchDot.Position = UDim2.new(0, 2, 0.5, -8)
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
            if animated then TweenService:Create(switchDot, TweenInfo.new(0.2), {Position = UDim2.new(1, -18, 0.5, -8)}):Play() else switchDot.Position = UDim2.new(1, -18, 0.5, -8) end
        else
            switchBg.BackgroundColor3 = Theme.SwitchOff
            if animated then TweenService:Create(switchDot, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -8)}):Play() else switchDot.Position = UDim2.new(0, 2, 0.5, -8) end
        end
    end
    UpdateUI(false)
    clickBtn.MouseButton1Click:Connect(function() isOn = not isOn UpdateUI(true) callback(isOn) end)
    return {SetState = function(state) isOn = state UpdateUI(true) end, Frame = container}
end

local function CreateInput(placeholder, yPos, textColor)
    local input = Instance.new("TextBox")
    input.Parent = ScrollFrame
    input.Size = UDim2.new(0.9, 0, 0, 30)
    input.Position = UDim2.new(0.05, 0, 0, yPos)
    input.BackgroundColor3 = Theme.InputBg
    input.BackgroundTransparency = 0.2
    input.Text = ""
    input.PlaceholderText = placeholder
    input.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    input.TextColor3 = textColor or Theme.TextColor
    input.Font = Enum.Font.GothamBold
    input.TextSize = 13
    input.BorderSizePixel = 0
    local corner = Instance.new("UICorner") corner.CornerRadius = UDim.new(0, 6) corner.Parent = input
    local stroke = Instance.new("UIStroke") stroke.Color = Theme.LineColor stroke.Thickness = 1 stroke.Parent = input
    return input
end

-- ==========================================
-- 功能实现区域
-- ==========================================
local SpeedInput = CreateInput("输入行走速度", 20, Theme.TextColor) SpeedInput.Text = "100"
local speedActive = false
CreateToggle("自定义速度", 60, false, function(Value)
    speedActive = Value local char = Player.Character
    if char and char:FindFirstChild("Humanoid") then if speedActive then char.Humanoid.WalkSpeed = tonumber(SpeedInput.Text) or 16 else char.Humanoid.WalkSpeed = 16 end end
end)
SpeedInput.FocusLost:Connect(function() if speedActive then local char = Player.Character if char and char:FindFirstChild("Humanoid") then char.Humanoid.WalkSpeed = tonumber(SpeedInput.Text) or 16 end end end)

local JumpInput = CreateInput("输入跳跃力", 105, Theme.TextColor) JumpInput.Text = "100"
local jumpActive = false
CreateToggle("自定义跳跃", 145, false, function(Value)
    jumpActive = Value local char = Player.Character
    if char and char:FindFirstChild("Humanoid") then if jumpActive then char.Humanoid.JumpPower = tonumber(JumpInput.Text) or 50 char.Humanoid.UseJumpPower = true else char.Humanoid.JumpPower = 50 end end
end)
JumpInput.FocusLost:Connect(function() if jumpActive then local char = Player.Character if char and char:FindFirstChild("Humanoid") then char.Humanoid.JumpPower = tonumber(JumpInput.Text) or 50 char.Humanoid.UseJumpPower = true end end end)

local PulseInput = CreateInput("输入脉冲推力 (建议1-5)", 190, Color3.fromRGB(0, 150, 100)) PulseInput.Text = "2" 
local pulseActive = false local renderConnection = nil local originalSpeed = 16 
CreateToggle("脉冲加速", 230, false, function(Value)
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
local boostToggleData = CreateToggle("极速冲刺 (FOV增强)", 310, false, function(Value)
    isBoosting = Value
    if isBoosting then TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {FieldOfView = 110}):Play() else TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {FieldOfView = defaultFOV}):Play() end
end)
local BoostFrame = boostToggleData.Frame BoostFrame.Visible = false 
CreateToggle("开启飞行", 270, false, function(Value)
    isFlying = Value local char = Player.Character
    if not char then return end local hrp = char:FindFirstChild("HumanoidRootPart") local hum = char:FindFirstChild("Humanoid") if not hrp or not hum then return end
    if isFlying then
        BoostFrame.Visible = true if isLanding then isLanding = false end hum.PlatformStand = true
        local bv = Instance.new("BodyVelocity", hrp) bv.Name = "LocalFly" bv.MaxForce = Vector3.new(1e9, 1e9, 1e9) bv.Velocity = Vector3.new(0, 0, 0)
        local bg = Instance.new("BodyGyro", hrp) bg.Name = "LocalFlyGyro" bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9) bg.P = 1e4 bg.CFrame = hrp.CFrame
        if flyConnection then flyConnection:Disconnect() end
        flyConnection = RunService.RenderStepped:Connect(function()
            if not isFlying or not char or not char.Parent then return end
            local currentHrp = char:FindFirstChild("HumanoidRootPart") local currentHum = char:FindFirstChild("Humanoid")
            if currentHrp and currentHum and currentHrp:FindFirstChild("LocalFly") then
                local bvInBody = currentHrp.LocalFly local bgInBody = currentHrp:FindFirstChild("LocalFlyGyro") local moveDir = currentHum.MoveDirection local currentFlySpeed = isBoosting and 200 or 50 
                if bgInBody then bgInBody.CFrame = workspace.CurrentCamera.CFrame end
                if moveDir.Magnitude > 0.1 then bvInBody.Velocity = moveDir * currentFlySpeed else bvInBody.Velocity = Vector3.new(0, 0, 0) end
            end
        end)
    else
        BoostFrame.Visible = false boostToggleData.SetState(false) isBoosting = false hum.PlatformStand = false hum.AutoRotate = true 
        TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.5), {FieldOfView = defaultFOV}):Play() isLanding = true
    end
end)

local isLocked = false local lockConnection = nil local lockedCFrame = nil
CreateToggle("角色锁定", 350, false, function(Value)
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

local TargetInput = CreateInput("输入玩家ID (留空=锁最近)", 390, Color3.fromRGB(200, 100, 100))
local aimbotActive = false local aimbotConnection = nil
CreateToggle("锁定玩家", 430, false, function(Value)
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

local NpcInput = CreateInput("输入NPC名称 (留空=锁最近)", 470, Color3.fromRGB(0, 150, 100))
local aimbotNpcActive = false local aimbotNpcConnection = nil local currentNpcTarget = nil local lastScanTime = 0 
CreateToggle("自动锁定NPC", 510, false, function(Value)
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
CreateToggle("究极暴力甩飞 (上方输ID)", 550, false, function(Value)
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

local isShieldActive = false
CreateToggle("主动反击盾", 590, false, function(Value)
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

local isAntiFling = false local antiFlingConnection = nil
CreateToggle("防甩飞", 630, false, function(Value)
    isAntiFling = Value local char = Player.Character
    if not char then return end
    if isAntiFling then
        antiFlingConnection = RunService.Heartbeat:Connect(function()
            if isAntiFling and char and char:FindFirstChild("HumanoidRootPart") then local hrp = char.HumanoidRootPart if hrp.Velocity.Magnitude > 150 or hrp.RotVelocity.Magnitude > 20 then hrp.Velocity = Vector3.new(0, 0, 0) hrp.RotVelocity = Vector3.new(0, 0, 0) end end
        end)
    else if antiFlingConnection then antiFlingConnection:Disconnect() end end
end)

local MusicInput = CreateInput("输入音乐数字ID", 670, Theme.TextColor)
local musicActive = false local currentMusic = nil
CreateToggle("播放本地音乐", 710, false, function(Value)
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

-- ==========================================
-- 底部按钮与关闭逻辑
-- ==========================================
local closeMenuBtn = Instance.new("TextButton")
closeMenuBtn.Parent = ScrollFrame
closeMenuBtn.Size = UDim2.new(0.9, 0, 0, 32)
closeMenuBtn.Position = UDim2.new(0.05, 0, 0, 760) 
closeMenuBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 200)
closeMenuBtn.Text = "关闭菜单"
closeMenuBtn.TextColor3 = Color3.fromRGB(150, 50, 50)
closeMenuBtn.Font = Enum.Font.GothamBold
closeMenuBtn.TextSize = 14
closeMenuBtn.BorderSizePixel = 0
local closeMenuBtnCorner = Instance.new("UICorner") closeMenuBtnCorner.CornerRadius = UDim.new(0, 6) closeMenuBtnCorner.Parent = closeMenuBtn

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
            if hrp:FindFirstChild("LocalFly") then hrp.LocalFly:Destroy() end if hrp:FindFirstChild("LocalFlyGyro") then hrp.LocalFlyGyro:Destroy() end if hrp:FindFirstChild("FlingSpin") then hrp.FlingSpin:Destroy() end if hrp:FindFirstChild("MySpin") then hrp.MySpin:Destroy() end
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

closeMenuBtn.MouseEnter:Connect(function() if closeMenuBtn.Active then closeMenuBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 150) end end)
closeMenuBtn.MouseLeave:Connect(function() if closeMenuBtn.Active then closeMenuBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 200) end end)
CloseBtn.MouseEnter:Connect(function() CloseBtn.BackgroundColor3 = Theme.CloseHover end)
CloseBtn.MouseLeave:Connect(function() CloseBtn.BackgroundColor3 = Color3.fromRGB(0,0,0) CloseBtn.BackgroundTransparency = 1 end)
MinBtn.MouseEnter:Connect(function() MinBtn.BackgroundColor3 = Theme.MinHover end)
MinBtn.MouseLeave:Connect(function() MinBtn.BackgroundColor3 = Color3.fromRGB(0,0,0) MinBtn.BackgroundTransparency = 1 end)

-- ==========================================
-- 自动验证加载逻辑
-- ==========================================
task.spawn(function()
    task.wait(1.5)
    LoadStatus.Text = "身份确认成功"
    LoadStatus.TextColor3 = Theme.TitleColor
    task.wait(0.5)
    
    local fadeTween = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(LoadingFrame, fadeTween, {BackgroundTransparency = 1}):Play()
    TweenService:Create(LoadStroke, fadeTween, {Transparency = 1}):Play()
    
    for _, obj in pairs(LoadingFrame:GetDescendants()) do
        if obj:IsA("TextLabel") then TweenService:Create(obj, fadeTween, {TextTransparency = 1}):Play() end
    end
    
    task.wait(0.4)
    LoadingFrame:Destroy()
    
    MainFrame.Visible = true
    Player.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end)
