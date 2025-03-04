local Player = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local NotificationUI = {}

-- Configuration Options
NotificationUI.Config = {
    -- Notification Styles
    Styles = {
        -- Bottom Right (Default)
        BottomRight = {
            Position = UDim2.new(1, -20, 1, -20),
            AnchorPoint = Vector2.new(1, 1),
            Size = UDim2.new(0, 300, 0, 100)
        },
        -- Center Screen
        Center = {
            Position = UDim2.new(0.5, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Size = UDim2.new(0, 400, 0, 150)
        }
    },
    
    -- Notification Types
    Types = {
        Info = Color3.fromRGB(100, 150, 250),     -- Soft Blue
        Success = Color3.fromRGB(100, 220, 100),  -- Soft Green
        Warning = Color3.fromRGB(250, 200, 50),   -- Soft Yellow
        Error = Color3.fromRGB(250, 100, 100)     -- Soft Red
    }
}

-- Create Notification Frame
function NotificationUI:CreateNotificationFrame(style)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = Player.LocalPlayer:WaitForChild("PlayerGui")
    
    local frame = Instance.new("Frame")
    frame.Size = style.Size
    frame.Position = style.Position
    frame.AnchorPoint = style.AnchorPoint
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
    
    -- Dark Glassmorphic Background
    local backdrop = Instance.new("Frame")
    backdrop.Size = UDim2.new(1, 0, 1, 0)
    backdrop.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    backdrop.BackgroundTransparency = 0.7
    backdrop.BorderSizePixel = 0
    backdrop.Parent = frame
    
    -- Blur-like Gradient Effect
    local blurEffect = Instance.new("UIGradient")
    blurEffect.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 30)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(40, 40, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 30))
    })
    blurEffect.Rotation = 45
    blurEffect.Parent = backdrop
    
    -- Corner Radius
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 15)
    uiCorner.Parent = frame
    
    -- Subtle Highlight Border
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = Color3.fromRGB(100, 100, 120)
    uiStroke.Transparency = 0.6
    uiStroke.Thickness = 1
    uiStroke.Parent = frame
    
    return frame, backdrop
end

-- Show Notification
function NotificationUI:Show(message, notificationType, style)
    style = style or self.Config.Styles.BottomRight
    notificationType = notificationType or "Info"
    
    local frame, backdrop = self:CreateNotificationFrame(style)
    
    -- Title Label
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Text = notificationType
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextColor3 = self.Config.Types[notificationType]
    titleLabel.TextSize = 18
    titleLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Parent = frame
    
    -- Message Label
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Text = message
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.TextColor3 = Color3.fromRGB(220, 220, 230)
    messageLabel.TextSize = 14
    messageLabel.Position = UDim2.new(0.05, 0, 0.3, 0)
    messageLabel.BackgroundTransparency = 1
    messageLabel.TextWrapped = true
    messageLabel.Size = UDim2.new(0.9, 0, 0.6, 0)
    messageLabel.Parent = frame
    
    -- Animation and Auto-Remove
    frame.AnchorPoint = style.AnchorPoint + Vector2.new(0, 0.1)
    frame.BackgroundTransparency = 1
    backdrop.BackgroundTransparency = 1
    
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local frameTween = TweenService:Create(frame, tweenInfo, {
        AnchorPoint = style.AnchorPoint,
        BackgroundTransparency = 0.3
    })
    
    local backdropTween = TweenService:Create(backdrop, tweenInfo, {
        BackgroundTransparency = 0.7
    })
    
    frameTween:Play()
    backdropTween:Play()
    
    -- Auto Remove
    task.delay(5, function()
        local fadeTween = TweenService:Create(frame, tweenInfo, {
            BackgroundTransparency = 1
        })
        local fadeBackdropTween = TweenService:Create(backdrop, tweenInfo, {
            BackgroundTransparency = 1
        })
        
        fadeTween:Play()
        fadeBackdropTween:Play()
        
        fadeTween.Completed:Wait()
        frame:Destroy()
    end)
end
return NotificationUI
