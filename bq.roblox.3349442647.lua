-- ==========================================
-- 白祈专属菜单 (自适应屏幕 + 解密特效版)
-- 🔑 密码: 3349442647
-- ==========================================

local CoreGui = game:GetService("CoreGui")
local Player = game.Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local UserInputService = game:GetService("UserInputService")

if CoreGui:FindFirstChild("BaiQiMenu") then CoreGui:FindFirstChild("BaiQiMenu"):Destroy() end
if SoundService:FindFirstChild("BaiQiMusic") then SoundService.BaiQiMusic:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BaiQiMenu"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- 主题颜色
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
    ScrollBar = Color3.fromRGB(180, 230, 180)       
}

-- ==========================================
-- 1. 卡密验证界面 (自适应居中)
-- ==========================================
local KeyFrame = Instance.new("Frame")
KeyFrame.Parent = ScreenGui
KeyFrame.Size = UDim2.new(0.8, 0, 0.25, 0) -- 使用比例
KeyFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
KeyFrame.AnchorPoint = Vector2.new(0.5, 0.5) -- 中心锚点
KeyFrame.BackgroundColor3 = Theme.BgColor
KeyFrame.BorderSizePixel = 0
KeyFrame.Active = true
KeyFrame.Draggable = true

-- 限制最大和最小尺寸
local KeySizeConstraint = Instance.new("UISizeConstraint")
KeySizeConstraint.MaxSize = Vector2.new(350, 180)
KeySizeConstraint.MinSize = Vector2.new(250, 150)
KeySizeConstraint.Parent = KeyFrame

local KeyRatio = Instance.new("UIAspectRatioConstraint")
KeyRatio.AspectRatio = 1.6
KeyRatio.Parent = KeyFrame

local KeyCorner = Instance.new("UICorner") KeyCorner.CornerRadius = UDim.new(0, 8) KeyCorner.Parent = KeyFrame
local KeyStroke = Instance.new("UIStroke") KeyStroke.Color = Theme.LineColor KeyStroke.Thickness = 1 KeyStroke.Parent = KeyFrame

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Parent = KeyFrame
KeyTitle.Size = UDim2.new(1, 0, 0, 40)
KeyTitle.BackgroundColor3 = Theme.TitleColor
KeyTitle.Text = "🍃 白祈 - 验证系统"
KeyTitle.TextColor3 = Theme.TextColor
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextSize = 16
KeyTitle.BorderSizePixel = 0
local KeyTitleCorner = Instance.new("UICorner") KeyTitleCorner.CornerRadius = UDim.new(0, 8) KeyTitleCorner.Parent = KeyTitle

local KeyBox = Instance.new("TextBox")
KeyBox.Parent = KeyFrame
KeyBox.Size = UDim2.new(0.8, 0, 0, 35)
KeyBox.Position = UDim2.new(0.1, 0, 0.4, 0)
KeyBox.BackgroundColor3 = Theme.InputBg
KeyBox.Text = ""
KeyBox.PlaceholderText = "请输入密码..."
KeyBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
KeyBox.TextColor3 = Theme.TextColor
KeyBox.Font = Enum.Font.GothamBold
KeyBox.TextSize = 14
KeyBox.BorderSizePixel = 0
local KeyBoxCorner = Instance.new("UICorner") KeyBoxCorner.CornerRadius = UDim.new(0, 6) KeyBoxCorner.Parent = KeyBox
local KeyBoxStroke = Instance.new("UIStroke") KeyBoxStroke.Color = Theme.LineColor KeyBoxStroke.Thickness = 1 KeyBoxStroke.Parent = KeyBox

local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Parent = KeyFrame
SubmitBtn.Size = UDim2.new(0.8, 0, 0, 35)
SubmitBtn.Position = UDim2.new(0.1, 0, 0.7, 0)
SubmitBtn.BackgroundColor3 = Theme.TitleColor
SubmitBtn.Text = "验证并启动"
SubmitBtn.TextColor3 = Theme.TextColor
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextSize = 14
SubmitBtn.BorderSizePixel = 0
local SubmitBtnCorner = Instance.new("UICorner") SubmitBtnCorner.CornerRadius = UDim.new(0, 6) SubmitBtnCorner.Parent = SubmitBtn

-- ==========================================
-- 2. 主菜单界面 (自适应居中 + 强制4:3)
-- ==========================================
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0.8, 0, 0.6, 0) -- 初始占屏幕大小，通过约束控制
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5) -- 中心锚点
MainFrame.BackgroundColor3 = Theme.BgColor
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Visible = false

-- 强制约束主菜单的尺寸
local MainSizeConstraint = Instance.new("UISizeConstraint")
MainSizeConstraint.MaxSize = Vector2.new(450, 337.5) -- 4:3 最大尺寸
MainSizeConstraint.MinSize = Vector2.new(300, 225)  -- 4:3 最小尺寸
MainSizeConstraint.Parent = MainFrame

local MainRatio = Instance.new("UIAspectRatioConstraint")
MainRatio.AspectRatio = 4/3
MainRatio.Parent = MainFrame

local MainCorner = Instance.new("UICorner") MainCorner.CornerRadius = UDim.new(0, 8) MainCorner.Parent = MainFrame
local MainStroke = Instance.new("UIStroke") MainStroke.Color = Theme.LineColor MainStroke.Thickness = 1 MainStroke.Parent = MainFrame

local MainTitle = Instance.new("TextButton") 
MainTitle.Parent = MainFrame
MainTitle.Size = UDim2.new(1, 0, 0, 40)
MainTitle.BackgroundColor3 = Theme.TitleColor
MainTitle.Text = "🍃 白祈专属菜单 (点我最小化)"
MainTitle.TextColor3 = Theme.TextColor
MainTitle.Font = Enum.Font.GothamBold
MainTitle.TextSize = 16
MainTitle.BorderSizePixel = 0
MainTitle.AutoButtonColor = false
local MainTitleCorner = Instance.new("UICorner") MainTitleCorner.CornerRadius = UDim.new(0, 8) MainTitleCorner.Parent = MainTitle

-- 标题栏拖拽逻辑
local dragging, dragInput, dragStart, startPos
MainTitle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
MainTitle.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- 滚动容器
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Parent = MainFrame
ScrollFrame.Size = UDim2.new(1, 0, 1, -40)
ScrollFrame.Position = UDim2.new(0, 0, 0, 40)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 850) 
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.ScrollBarImageColor3 = Theme.ScrollBar
ScrollFrame.ScrollBarImageTransparency = 0.3
ScrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
ScrollFrame.ClipsDescendants = true

-- ==========================================
-- 3. 悬浮球 (最小化状态)
-- ==========================================
local FloatBtn = Instance.new("TextButton")
FloatBtn.Parent = ScreenGui
FloatBtn.Size = UDim2.new(0, 50, 0, 50)
FloatBtn.Position = UDim2.new(0, 20, 0.5, -25) 
FloatBtn.BackgroundColor3 = Theme.TitleColor
FloatBtn.Text = "🍃"
FloatBtn.TextColor3 = Theme.TextColor
FloatBtn.Font = Enum.Font.GothamBold
FloatBtn.TextSize = 24
FloatBtn.BorderSizePixel = 0
FloatBtn.Visible = false
FloatBtn.Active = true
local FloatCorner = Instance.new("UICorner") FloatCorner.CornerRadius = UDim.new(1, 0) FloatCorner.Parent = FloatBtn
local FloatStroke = Instance.new("UIStroke") FloatStroke.Color = Theme.SwitchOn FloatStroke.Thickness = 2 FloatStroke.Parent = FloatBtn

-- 悬浮球拖拽
local floatDragging, floatDragInput, floatDragStart, floatStartPos
FloatBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        floatDragging = true
        floatDragStart = input.Position
        floatStartPos = FloatBtn.Position
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

-- 折叠/展开 逻辑
local isMinimized = false
MainTitle.MouseButton1Click:Connect(function()
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

-- 🎛️ 组件生成函数
local function CreateToggle(text, yPos, initialValue, callback)
    local container = Instance.new("Frame")
    container.Parent = ScrollFrame
    container.Size = UDim2.new(0.9, 0, 0, 35)
    container.Position = UDim2.new(0.05, 0, 0, yPos)
    container.BackgroundColor3 = Theme.BtnColor
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
    textLabel.Font = Enum.Font.GothamMedium
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

-- 辅助通知函数
local function OrionNotify(title, text, color)
    local note = Instance.new("TextLabel")
    note.Parent = ScreenGui
    note.Size = UDim2.new(0, 250, 0, 50)
    note.Position = UDim2.new(0.5, -125, 0.8, 0)
    note.BackgroundColor3 = Theme.BgColor
    note.BackgroundTransparency = 0.1
    note.Text = title .. "\n" .. text
    note.TextColor3 = Theme.TextColor
    note.Font = Enum.Font.GothamBold
    note.TextSize = 14
    note.TextScaled = true
    local corner = Instance.new("UICorner") corner.CornerRadius = UDim.new(0, 6) corner.Parent = note
    local stroke = Instance.new("UIStroke") stroke.Color = color or Theme.TitleColor stroke.Thickness = 2 stroke.Parent = note
    task.delay(3, function()
        local tween = TweenService:Create(note, TweenInfo.new(0.5), {BackgroundTransparency = 1, TextTransparency = 1})
        tween:Play() task.wait(0.5) note:Destroy()
    end)
end

-- ==========================================
-- 功能实现区域
-- ==========================================
-- 1. 速度
local SpeedInput = CreateInput("输入行走速度 (默认16)", 20, Theme.TextColor)
SpeedInput.Text = "100"
local speedActive = false
CreateToggle("开启自定义速度", 60, false, function(Value)
    speedActive = Value
    local char = Player.Character
    if char and char:FindFirstChild("Humanoid") then
        if speedActive then char.Humanoid.WalkSpeed = tonumber(SpeedInput.Text) or 16 else char.Humanoid.WalkSpeed = 16 end
    end
end)
SpeedInput.FocusLost:Connect(function() if speedActive then local char = Player.Character if char and char:FindFirstChild("Humanoid") then char.Humanoid.WalkSpeed = tonumber(SpeedInput.Text) or 16 end end end)

-- 2. 跳跃
local JumpInput = CreateInput("输入跳跃力 (默认50)", 105, Theme.TextColor)
JumpInput.Text = "100"
local jumpActive = false
CreateToggle("开启自定义跳跃", 145, false, function(Value)
    jumpActive = Value
    local char = Player.Character
    if char and char:FindFirstChild("Humanoid") then
        if jumpActive then char.Humanoid.JumpPower = tonumber(JumpInput.Text) or 50 char.Humanoid.UseJumpPower = true else char.Humanoid.JumpPower = 50 end
    end
end)
JumpInput.FocusLost:Connect(function() if jumpActive then local char = Player.Character if char and char:FindFirstChild("Humanoid") then char.Humanoid.JumpPower = tonumber(JumpInput.Text) or 50 char.Humanoid.UseJumpPower = true end end end)

-- 3. 脉冲加速
local PulseInput = CreateInput("输入脉冲推力 (建议1-5)", 190, Color3.fromRGB(0, 150, 100))
PulseInput.Text = "2" 
local pulseActive = false
local renderConnection = nil
local originalSpeed = 16 
CreateToggle("开启脉冲加速", 230, false, function(Value)
    pulseActive = Value
    local char = Player.Character
    if pulseActive then
        if char and char:FindFirstChild("Humanoid") then originalSpeed = char.Humanoid.WalkSpeed end
        renderConnection = RunService.RenderStepped:Connect(function()
            if not pulseActive then return end
            local char = Player.Character
            if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
                local moveDir = char.Humanoid.MoveDirection
                local speedVal = tonumber(PulseInput.Text) or 2 
                if moveDir.Magnitude > 0 then char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + (moveDir * speedVal) end
            end
        end)
    else
        if renderConnection then renderConnection:Disconnect() end
        if char and char:FindFirstChild("Humanoid") then char.Humanoid.WalkSpeed = originalSpeed end
    end
end)

-- 4. 飞行
local isFlying = false
local isBoosting = false
local isLanding = false
local flyConnection = nil
local defaultFOV = workspace.CurrentCamera.FieldOfView 

local boostToggleData = CreateToggle("🔥 极速冲刺 (FOV增强)", 310, false, function(Value)
    isBoosting = Value
    if isBoosting then TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {FieldOfView = 110}):Play()
    else TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {FieldOfView = defaultFOV}):Play() end
end)
local BoostFrame = boostToggleData.Frame
BoostFrame.Visible = false 

CreateToggle("开启飞行", 270, false, function(Value)
    isFlying = Value
    local char = Player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    if not hrp or not hum then return end
    if isFlying then
        BoostFrame.Visible = true
        if isLanding then isLanding = false end
        hum.PlatformStand = true
        local bv = Instance.new("BodyVelocity", hrp) bv.Name = "LocalFly" bv.MaxForce = Vector3.new(1e9, 1e9, 1e9) bv.Velocity = Vector3.new(0, 0, 0)
        local bg = Instance.new("BodyGyro", hrp) bg.Name = "LocalFlyGyro" bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9) bg.P = 1e4 bg.CFrame = hrp.CFrame
        if flyConnection then flyConnection:Disconnect() end
        flyConnection = RunService.RenderStepped:Connect(function()
            if not isFlying or not char or not char.Parent then return end
            local currentHrp = char:FindFirstChild("HumanoidRootPart")
            local currentHum = char:FindFirstChild("Humanoid")
            if currentHrp and currentHum and currentHrp:FindFirstChild("LocalFly") then
                local bvInBody = currentHrp.LocalFly
                local bgInBody = currentHrp:FindFirstChild("LocalFlyGyro")
                local moveDir = currentHum.MoveDirection
                local currentFlySpeed = isBoosting and 200 or 50 
                if bgInBody then bgInBody.CFrame = workspace.CurrentCamera.CFrame end
                if moveDir.Magnitude > 0.1 then bvInBody.Velocity = moveDir * currentFlySpeed else bvInBody.Velocity = Vector3.new(0, 0, 0) end
            end
        end)
    else
        BoostFrame.Visible = false boostToggleData.SetState(false) isBoosting = false
        hum.PlatformStand = false hum.AutoRotate = true 
        TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.5), {FieldOfView = defaultFOV}):Play()
        isLanding = true
    end
end)

-- 5. 角色锁定
local isLocked = false local lockConnection = nil local lockedCFrame = nil
CreateToggle("角色锁定", 350, false, function(Value)
    isLocked = Value local char = Player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    if isLocked then
        lockedCFrame = char.HumanoidRootPart.CFrame
        lockConnection = RunService.RenderStepped:Connect(function() 
            if isLocked and char and char:FindFirstChild("HumanoidRootPart") then 
                char.HumanoidRootPart.CFrame = lockedCFrame char.HumanoidRootPart.Velocity = Vector3.new(0,0,0) char.HumanoidRootPart.RotVelocity = Vector3.new(0,0,0)
            end 
        end)
    else 
        if lockConnection then lockConnection:Disconnect() end 
        lockedCFrame = nil 
        if char and char:FindFirstChild("HumanoidRootPart") then char.HumanoidRootPart.Velocity = Vector3.new(0,0,0) char.HumanoidRootPart.RotVelocity = Vector3.new(0,0,0) end
    end
end)

-- 6. 玩家自瞄
local TargetInput = CreateInput("输入玩家ID (留空=锁最近)", 390, Color3.fromRGB(200, 100, 100))
local aimbotActive = false local aimbotConnection = nil
CreateToggle("锁定玩家", 430, false, function(Value)
    aimbotActive = Value
    if aimbotActive then
        OrionNotify("🎯 锁定玩家", "已开启，留空自动锁最近", Theme.TitleColor)
        aimbotConnection = RunService.RenderStepped:Connect(function()
            if not aimbotActive then return end
            local targetIdString = string.gsub(TargetInput.Text, "%s+", "")
            local targetHrp = nil local cam = workspace.CurrentCamera
            if targetIdString ~= "" then
                local targetId = tonumber(targetIdString)
                if targetId then for _, p in pairs(Player:GetPlayers()) do if p ~= Player and p.UserId == targetId and p.Character then local hrp = p.Character:FindFirstChild("HumanoidRootPart") local hum = p.Character:FindFirstChild("Humanoid") if hrp and hum and hum.Health > 0 then targetHrp = hrp break end end end end
            end
            if not targetHrp then
                local closestDist = math.huge local myPos = cam.CFrame.Position
                for _, p in pairs(Player:GetPlayers()) do if p ~= Player and p.Character then local hrp = p.Character:FindFirstChild("HumanoidRootPart") local hum = p.Character:FindFirstChild("Humanoid") if hrp and hum and hum.Health > 0 then local dist = (hrp.Position - myPos).Magnitude if dist < closestDist then closestDist = dist targetHrp = hrp end end end end
            end
            if targetHrp then
                local targetCFrame = CFrame.lookAt(cam.CFrame.Position, targetHrp.Position)
                cam.CFrame = cam.CFrame:Lerp(targetCFrame, 0.2)
            end
        end)
    else if aimbotConnection then aimbotConnection:Disconnect() aimbotConnection = nil end OrionNotify("🎯 解除锁定", "已恢复自由视角。", Theme.TitleColor) end
end)

-- 7. NPC自瞄
local NpcInput = CreateInput("输入NPC名称 (留空=锁最近)", 470, Color3.fromRGB(0, 150, 100))
local aimbotNpcActive = false local aimbotNpcConnection = nil local currentNpcTarget = nil local lastScanTime = 0 
CreateToggle("自动锁定NPC", 510, false, function(Value)
    aimbotNpcActive = Value currentNpcTarget = nil 
    if aimbotNpcActive then
        OrionNotify("🎯 锁定NPC", "已开启，留空自动锁最近", Theme.TitleColor)
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
            if currentNpcTarget and currentNpcTarget.Parent then
                local hrp = currentNpcTarget:FindFirstChild("HumanoidRootPart")
                if hrp then cam.CFrame = cam.CFrame:Lerp(CFrame.lookAt(cam.CFrame.Position, hrp.Position), 0.2) end
            end
        end)
    else if aimbotNpcConnection then aimbotNpcConnection:Disconnect() aimbotNpcConnection = nil end currentNpcTarget = nil OrionNotify("🎯 解除锁定", "已恢复自由视角。", Theme.TitleColor) end
end)

-- 8. 究极暴力甩飞
local isTrackingFling = false local savedCFrame = nil local trackingConnection = nil
CreateToggle("究极暴力甩飞 (上方输ID)", 550, false, function(Value)
    isTrackingFling = Value local char = Player.Character
    if not char then return end local hrp = char:FindFirstChild("HumanoidRootPart") local hum = char:FindFirstChild("Humanoid")
    if not hrp or not hum then return end
    if isTrackingFling then
        savedCFrame = hrp.CFrame hum.PlatformStand = false 
        OrionNotify("🌪️ 狂暴甩飞启动", "正在粉碎目标物理引擎...", Color3.fromRGB(255, 100, 100))
        trackingConnection = RunService.RenderStepped:Connect(function()
            if not isTrackingFling then return end
            local targetIdString = string.gsub(TargetInput.Text, "%s+", "") local targetPlayer = nil
            if targetIdString ~= "" then local targetId = tonumber(targetIdString) if targetId then for _, p in pairs(Player:GetPlayers()) do if p ~= Player and p.UserId == targetId then targetPlayer = p break end end end end
            if not targetPlayer then
                local closestDist = math.huge
                for _, p in pairs(Player:GetPlayers()) do if p ~= Player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid").Health > 0 then local dist = (p.Character.HumanoidRootPart.Position - workspace.CurrentCamera.CFrame.Position).Magnitude if dist < closestDist then closestDist = dist targetPlayer = p end end end
            end
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
        if savedCFrame then hrp.CFrame = savedCFrame savedCFrame = nil OrionNotify("🏠 安全回城", "已返回起始位置。", Theme.TitleColor) end
    end
end)

-- 9. 主动反击盾
local isShieldActive = false
CreateToggle("主动反击盾", 590, false, function(Value)
    isShieldActive = Value
    if isShieldActive then
        if not _G.MyHttpPostHooked then
            local oldPost = HttpService.PostAsync
            HttpService.PostAsync = function(self, url, data, contentType)
                if tostring(url):find("discord") or tostring(url):find("webhook") or tostring(url):find("http") then
                    OrionNotify("⚔️ 成功反击！", "已拦截请求并反制！", Color3.fromRGB(255, 100, 100))
                    task.spawn(function() for i = 1, 20 do pcall(function() oldPost(self, url, '{"content": "你被反向入侵了！"}', contentType) end) task.wait(0.1) end end)
                    return "{}"
                end
                return oldPost(self, url, data, contentType)
            end
            _G.MyHttpPostHooked = true
        end
        task.spawn(function()
            while isShieldActive do
                task.wait(2) local playScripts = Player:FindFirstChild("PlayerScripts")
                if playScripts then for _, scriptObj in pairs(playScripts:GetDescendants()) do if (scriptObj:IsA("LocalScript") or scriptObj:IsA("ModuleScript")) and scriptObj.Name ~= "BaiQiMenu" then local ok, src = pcall(function() return scriptObj.Source end) if ok and src and (src:find("webhook") or src:find("HttpPost") or src:find("discord")) then scriptObj:Destroy() end end end end
            end
        end)
        OrionNotify("🛡️ 盾激活", "已开启自动反制！", Theme.TitleColor)
    end
end)

-- 10. 防甩飞
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

-- 11. 纯本地音乐播放器
local MusicInput = CreateInput("输入音乐数字ID (仅自己可听)", 670, Theme.TextColor)
local musicActive = false local currentMusic = nil
CreateToggle("播放本地音乐", 710, false, function(Value)
    musicActive = Value local idString = MusicInput.Text
    if musicActive then
        if idString == "" then OrionNotify("⚠️ 提示", "请先在上方输入音频ID！", Color3.fromRGB(255, 200, 0)) return end
        local soundId = tonumber(idString) if not soundId then OrionNotify("⚠️ 提示", "音频ID必须是纯数字！", Color3.fromRGB(255, 200, 0)) return end
        if SoundService:FindFirstChild("BaiQiMusic") then SoundService.BaiQiMusic:Destroy() end
        currentMusic = Instance.new("Sound") currentMusic.Name = "BaiQiMusic" currentMusic.Parent = SoundService currentMusic.SoundId = "rbxassetid://" .. soundId currentMusic.Volume = 1 currentMusic.Looped = true
        local success = pcall(function() currentMusic:Play() end)
        if success then OrionNotify("🎵 正在播放", "如果没声音，可能是音频失效或受限。", Theme.TitleColor) else OrionNotify("❌ 播放失败", "该音频可能已失效或受版权保护。", Color3.fromRGB(255, 100, 100)) end
    else
        if currentMusic then currentMusic:Destroy() currentMusic = nil end
        if SoundService:FindFirstChild("BaiQiMusic") then SoundService.BaiQiMusic:Destroy() end
    end
end)

-- ==========================================
-- 12. 关闭菜单按钮
-- ==========================================
local closeBtn = Instance.new("TextButton")
closeBtn.Parent = ScrollFrame
closeBtn.Size = UDim2.new(0.9, 0, 0, 32)
closeBtn.Position = UDim2.new(0.05, 0, 0, 770) 
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 200)
closeBtn.Text = "销毁/关闭菜单"
closeBtn.TextColor3 = Color3.fromRGB(150, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.BorderSizePixel = 0
local closeBtnCorner = Instance.new("UICorner") closeBtnCorner.CornerRadius = UDim.new(0, 6) closeBtnCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
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
    FloatBtn.Visible = false closeBtn.Text = "正在关闭..." closeBtn.Active = false
    
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
        -- 因为是中心锚点，不需要改坐标，直接原地缩小
        local tween = TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0, 0, 0, 0)})
        tween:Play()
        tween.Completed:Connect(function() ScreenGui:Destroy() end)
    end)
end)
closeBtn.MouseEnter:Connect(function() if closeBtn.Active then closeBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 150) end end)
closeBtn.MouseLeave:Connect(function() if closeBtn.Active then closeBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 200) end end)

-- ==========================================
-- 3. 验证逻辑 (带黑客解密特效)
-- ==========================================
SubmitBtn.MouseButton1Click:Connect(function()
    SubmitBtn.Active = false
    local inputPassword = string.gsub(KeyBox.Text, "^%s*(.-)%s*$", "%1")
    
    if inputPassword == "3349442647" then
        task.spawn(function()
            local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*"
            local targetText = "验证成功"
            
            for i = 1, 18 do
                local randomStr = ""
                for j = 1, 4 do
                    local randIndex = math.random(1, #chars)
                    randomStr = randomStr .. string.sub(chars, randIndex, randIndex)
                end
                SubmitBtn.Text = randomStr
                SubmitBtn.TextColor3 = Color3.fromRGB(math.random(100, 255), math.random(100, 255), math.random(100, 255))
                task.wait(0.05) 
            end
            
            SubmitBtn.Text = targetText
            SubmitBtn.TextColor3 = Theme.TextColor
            KeyBox.Text = "" 
            
            task.wait(0.4)
            
            local fadeTween = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            TweenService:Create(KeyFrame, fadeTween, {BackgroundTransparency = 1}):Play()
            TweenService:Create(KeyStroke, fadeTween, {Transparency = 1}):Play()
            
            for _, obj in pairs(KeyFrame:GetDescendants()) do
                if obj:IsA("GuiObject") then
                    TweenService:Create(obj, fadeTween, {BackgroundTransparency = 1}):Play()
                    if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
                        TweenService:Create(obj, fadeTween, {TextTransparency = 1}):Play()
                    end
                elseif obj:IsA("UIStroke") then
                    TweenService:Create(obj, fadeTween, {Transparency = 1}):Play()
                end
            end
            
            task.wait(0.4)
            KeyFrame:Destroy() 
            
            MainFrame.Visible = true
            Player.Idled:Connect(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end)
    else
        KeyBox.Text = "密码错误！"
        task.wait(1)
        KeyBox.Text = ""
        SubmitBtn.Active = true
        SubmitBtn.Text = "验证并启动"
    end
end)
