-- ==========================================
-- 卡密验证系统 (普通密码版)
-- ==========================================

-- ⚠️⚠️⚠️ 在这里修改你的密码 ⚠️⚠️⚠️
local MyPassword = "新机拉萨哟↑ 七恰萨哟↓ 吸咕吸怕哟↑ 黑够怕哟↓ 那嘎够吸抛哟↑" 
-------------------------------------------

local ScreenGui = Instance.new("ScreenGui")
local UI = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Frame = Instance.new("Frame")
local Key = Instance.new("TextBox")
local Start = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

UI.Name = "KeySystemUI"
UI.Parent = ScreenGui
UI.Active = true
UI.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
UI.BorderSizePixel = 0
UI.Position = UDim2.new(0.5, -150, 0.5, -100)
UI.Size = UDim2.new(0, 300, 0, 200)
UI.Draggable = true

Title.Name = "Title"
Title.Parent = UI
Title.BackgroundColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0.05, 0)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "请输入卡密以使用菜单"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextScaled = true

Frame.Parent = Title
Frame.BackgroundColor3 = Color3.new(0, 0.5, 1)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.1, 0, 1, 0)
Frame.Size = UDim2.new(0.8, 0, 0, 2)

Key.Name = "KeyBox"
Key.Parent = UI
Key.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
Key.BorderSizePixel = 0
Key.Position = UDim2.new(0.1, 0, 0.35, 0)
Key.Size = UDim2.new(0.8, 0, 0, 40)
Key.Font = Enum.Font.Gotham
Key.PlaceholderText = "在此输入密钥..."
Key.Text = ""
Key.TextColor3 = Color3.new(1, 1, 1)
Key.TextScaled = true

Start.Name = "StartBtn"
Start.Parent = UI
Start.BackgroundColor3 = Color3.new(0, 0.5, 1)
Start.BorderSizePixel = 0
Start.Position = UDim2.new(0.25, 0, 0.65, 0)
Start.Size = UDim2.new(0.5, 0, 0, 40)
Start.Font = Enum.Font.GothamBold
Start.Text = "验证并启动"
Start.TextColor3 = Color3.new(1, 1, 1)
Start.TextScaled = true

-- 点击验证逻辑
Start.MouseButton1Click:Connect(function()
    if Key.Text == MyPassword then
        ScreenGui:Destroy() -- 密码正确，销毁窗口
        
        -- ==========================================
        -- 加载 OrionLib 悬浮窗
        -- ==========================================
        local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()
        
        local Window = OrionLib:MakeWindow({
            Name = "白祈的菜单", 
            HidePremium = false, 
            SaveConfig = true, 
            IntroText = "验证成功，正在启动...", 
            ConfigFolder = "MyScriptConfig"
        })

        local Tab1 = Window:MakeTab({
            Name = "基础功能",
            Icon = "rbxassetid://4483345998",
            PremiumOnly = false
        })

        Tab1:AddButton({
            Name = "人物加速 (速度100)",
            Callback = function()
                local player = game.Players.LocalPlayer
                if player and player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid.WalkSpeed = 100
                    OrionLib:MakeNotification({Name = "加速成功", Content = "行走速度已设为 100", Time = 3})
                end
            end
        })
        
        Tab1:AddButton({
            Name = "超级跳跃 (跳跃力100)",
            Callback = function()
                local player = game.Players.LocalPlayer
                if player and player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid.JumpPower = 100
                    player.Character.Humanoid.UseJumpPower = true
                    OrionLib:MakeNotification({Name = "跳跃增强", Content = "跳跃力已设为 100", Time = 3})
                end
            end
        })

        local Tab2 = Window:MakeTab({
            Name = "其他",
            Icon = "rbxassetid://6031090990",
            PremiumOnly = false
        })

        Tab2:AddButton({
            Name = "关闭菜单",
            Callback = function()
                OrionLib:Destroy()
            end
        })

        OrionLib:Init()
        
    else
        -- 密码错误
        game.Players.LocalPlayer:Kick("卡密错误！请获取正确的卡密。")
    end
end 
