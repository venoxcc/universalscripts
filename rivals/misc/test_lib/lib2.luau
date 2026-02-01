
--! Orion Library
--! Recode@2024.1.5

--! Author: ttwiz_z (ttwizz)
--! License: MIT
--! GitHub: https://github.com/ttwizz/Roblox/blob/master/Orion.lua

--! Issues: https://github.com/ttwizz/Roblox/issues
--! Pull requests: https://github.com/ttwizz/Roblox/pulls
--! Discussions: https://github.com/ttwizz/Roblox/discussions

--! twix.cyou/pix


--? Source Code

local L_1_ = game:GetService("ScriptContext")
local L_2_ = game:GetService("UserInputService")
local L_3_ = game:GetService("TweenService")
local L_4_ = game:GetService("RunService")
local L_5_ = game:GetService("Players").LocalPlayer
local L_6_ = L_5_:GetMouse()
local L_7_ = game:GetService("HttpService")
local L_8_ = game:GetService("CoreGui")
local L_9_ = game:GetService("Debris")


if getfenv().getconnections then
    for _, L_33_forvar2 in next, getfenv().getconnections(L_1_.Error) do
        L_33_forvar2:Disable()
    end
end


local L_10_ = {
    Elements = {},
    ThemeObjects = {},
    Connections = {},
    Flags = {},
    Themes = {
        Default = {
            Main = Color3.fromRGB(15, 15, 20),
            Second = Color3.fromRGB(22, 22, 28),
            Stroke = Color3.fromRGB(40, 40, 50),
            Divider = Color3.fromRGB(40, 40, 50),
            Text = Color3.fromRGB(245, 245, 250),
            TextDark = Color3.fromRGB(130, 130, 150),
            Accent = Color3.fromRGB(88, 101, 242),
            AccentDark = Color3.fromRGB(71, 82, 196)
        }
    },
    SelectedTheme = "Default",
    SaveCfg = false
}

local L_11_ = {}


local L_12_ = Instance.new("ScreenGui")
L_12_.Name = string.lower(string.reverse(string.sub(L_7_:GenerateGUID(false), 1, 8)))
if getfenv().syn then
    getfenv().syn.protect_gui(L_12_)
    L_12_.Parent = L_8_
else
    xpcall(function()
        L_12_.Parent = getfenv().gethui and getfenv().gethui() or L_8_
    end, function()
        L_12_.DisplayOrder = 9e8
        L_12_.ResetOnSpawn = false
        L_12_.Parent = L_5_:WaitForChild("PlayerGui", math.huge)
    end)
end


local L_13_ = L_12_.Parent

function L_10_:IsRunning()
    return L_12_.Parent == L_13_
end


local function L_14_func(L_34_arg1, L_35_arg2)
    if not L_10_:IsRunning() then
        return
    end
    local L_36_ = L_34_arg1:Connect(L_35_arg2)
    table.insert(L_10_.Connections, L_36_)
    return L_36_
end


task.spawn(function()
    while L_10_:IsRunning() do
        task.wait()
    end
    for _, L_38_forvar2 in next, L_10_.Connections do
        L_38_forvar2:Disconnect()
    end
end)


local function L_15_func(L_39_arg1, L_40_arg2)
    pcall(function()
        local L_41_, L_42_, L_43_, L_44_ = false, nil
        L_14_func(L_39_arg1.InputBegan, function(L_45_arg1)
            if L_45_arg1.UserInputType == Enum.UserInputType.MouseButton1 or L_45_arg1.UserInputType == Enum.UserInputType.Touch then
                L_41_ = true
                L_43_ = L_45_arg1.Position
                L_44_ = L_40_arg2.Position
                L_45_arg1.Changed:Connect(function()
                    if L_45_arg1.UserInputState == Enum.UserInputState.End then
                        L_41_ = false
                    end
                end)
            end
        end)
        L_14_func(L_39_arg1.InputChanged, function(L_46_arg1)
            if L_46_arg1.UserInputType == Enum.UserInputType.MouseMovement or L_46_arg1.UserInputType == Enum.UserInputType.Touch then
                L_42_ = L_46_arg1
            end
        end)
        L_14_func(L_2_.InputChanged, function(L_47_arg1)
            if L_47_arg1 == L_42_ and L_41_ then
                local L_48_ = L_47_arg1.Position - L_43_
                L_40_arg2.Position = UDim2.new(L_44_.X.Scale, L_44_.X.Offset + L_48_.X, L_44_.Y.Scale, L_44_.Y.Offset + L_48_.Y)
            end
        end)
    end)
end


local function L_16_func(L_49_arg1, L_50_arg2, L_51_arg3)
    local L_52_ = Instance.new(L_49_arg1)
    for L_53_forvar1, L_54_forvar2 in next, L_50_arg2 or {} do
        L_52_[L_53_forvar1] = L_54_forvar2
    end
    for _, L_56_forvar2 in next, L_51_arg3 or {} do
        L_56_forvar2.Parent = L_52_
    end
    return L_52_
end


local function L_17_func(L_57_arg1, L_58_arg2)
    L_10_.Elements[L_57_arg1] = function(...)
        return L_58_arg2(...)
    end
end


local function L_18_func(L_59_arg1, ...)
    return L_10_.Elements[L_59_arg1](...)
end


local function L_19_func(L_60_arg1, L_61_arg2)
    for L_62_forvar1, L_63_forvar2 in next, L_61_arg2 do
        L_60_arg1[L_62_forvar1] = L_63_forvar2
    end
    return L_60_arg1
end


local function L_20_func(L_64_arg1, L_65_arg2)
    for _, L_67_forvar2 in next, L_65_arg2 do
        L_67_forvar2.Parent = L_64_arg1
    end
    return L_64_arg1
end


local function L_21_func(L_68_arg1, L_69_arg2)
    local L_70_ = math.floor(L_68_arg1 / L_69_arg2 + math.sign(L_68_arg1) * 0.5) * L_69_arg2
    if L_70_ < 0 then
        L_70_ = L_70_ + L_69_arg2
    end
    return L_70_
end


local function L_22_func(L_71_arg1)
    if L_71_arg1:IsA("Frame") or L_71_arg1:IsA("TextButton") then
        return "BackgroundColor3"
    elseif L_71_arg1:IsA("ScrollingFrame") then
        return "ScrollBarImageColor3"
    elseif L_71_arg1:IsA("UIStroke") then
        return "Color"
    elseif L_71_arg1:IsA("TextLabel") or L_71_arg1:IsA("TextBox") then
        return "TextColor3"
    elseif L_71_arg1:IsA("ImageLabel") or L_71_arg1:IsA("ImageButton") then
        return "ImageColor3"
    end
end


local function L_23_func(L_72_arg1, L_73_arg2)
    if not L_10_.ThemeObjects[L_73_arg2] then
        L_10_.ThemeObjects[L_73_arg2] = {}
    end
    table.insert(L_10_.ThemeObjects[L_73_arg2], L_72_arg1)
    L_72_arg1[L_22_func(L_72_arg1)] = L_10_.Themes[L_10_.SelectedTheme][L_73_arg2]
    return L_72_arg1
end


local function L_24_func(L_74_arg1)
    return {
        R = L_74_arg1.R * 255,
        G = L_74_arg1.G * 255,
        B = L_74_arg1.B * 255
    }
end


local function L_25_func(L_75_arg1)
    return Color3.fromRGB(L_75_arg1.R, L_75_arg1.G, L_75_arg1.B)
end


local function L_26_func(L_76_arg1)
    local L_77_ = L_7_:JSONDecode(L_76_arg1)
    for L_78_forvar1, L_79_forvar2 in next, L_77_ do
        if L_10_.Flags[L_78_forvar1] then
            task.spawn(function()
                if L_10_.Flags[L_78_forvar1].Type == "Colorpicker" then
                    L_10_.Flags[L_78_forvar1]:Set(L_25_func(L_79_forvar2))
                else
                    L_10_.Flags[L_78_forvar1]:Set(L_79_forvar2)
                end
            end)
        end
    end
end


local function L_27_func(L_80_arg1)
    local L_81_ = {}
    for L_82_forvar1, L_83_forvar2 in next, L_10_.Flags do
        if L_83_forvar2.Save then
            if L_83_forvar2.Type == "Colorpicker" then
                L_81_[L_82_forvar1] = L_24_func(L_83_forvar2.Value)
            else
                L_81_[L_82_forvar1] = L_83_forvar2.Value
            end
        end
    end
    if getfenv().writefile then
        getfenv().writefile(string.format("%s/%s.txt", L_10_["Folder"], L_80_arg1), L_7_:JSONEncode(L_81_))
    end
end


local L_28_ = {
    Enum.UserInputType.MouseButton1,
    Enum.UserInputType.MouseButton2,
    Enum.UserInputType.MouseButton3
}

local L_29_ = {
    Enum.KeyCode.Unknown,
    Enum.KeyCode.W,
    Enum.KeyCode.A,
    Enum.KeyCode.S,
    Enum.KeyCode.D,
    Enum.KeyCode.Up,
    Enum.KeyCode.Left,
    Enum.KeyCode.Down,
    Enum.KeyCode.Right,
    Enum.KeyCode.Slash,
    Enum.KeyCode.Tab,
    Enum.KeyCode.Backspace,
    Enum.KeyCode.Escape
}


local function L_30_func(L_84_arg1, L_85_arg2)
    for _, L_87_forvar2 in next, L_84_arg1 do
        if L_87_forvar2 == L_85_arg2 then
            return true
        end
    end
end


L_17_func("Corner", function(L_88_arg1, L_89_arg2)
    local L_90_ = L_16_func("UICorner", {
        CornerRadius = UDim.new(L_88_arg1 or 0, L_89_arg2 or 10)
    })
    return L_90_
end)


L_17_func("Stroke", function(L_91_arg1, L_92_arg2)
    local L_93_ = L_16_func("UIStroke", {
        Color = L_91_arg1 or Color3.fromRGB(255, 255, 255),
        Thickness = L_92_arg2 or 1
    })
    return L_93_
end)


L_17_func("List", function(L_94_arg1, L_95_arg2)
    local L_96_ = L_16_func("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(L_94_arg1 or 0, L_95_arg2 or 0)
    })
    return L_96_
end)


L_17_func("Padding", function(L_97_arg1, L_98_arg2, L_99_arg3, L_100_arg4)
    local L_101_ = L_16_func("UIPadding", {
        PaddingBottom = UDim.new(0, L_97_arg1 or 4),
        PaddingLeft = UDim.new(0, L_98_arg2 or 4),
        PaddingRight = UDim.new(0, L_99_arg3 or 4),
        PaddingTop = UDim.new(0, L_100_arg4 or 4)
    })
    return L_101_
end)


L_17_func("TFrame", function()
    local L_102_ = L_16_func("Frame", {
        BackgroundTransparency = 1
    })
    return L_102_
end)


L_17_func("Frame", function(L_103_arg1)
    local L_104_ = L_16_func("Frame", {
        BackgroundColor3 = L_103_arg1 or Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0
    })
    return L_104_
end)


L_17_func("RoundFrame", function(L_105_arg1, L_106_arg2, L_107_arg3)
    local L_108_ = L_16_func("Frame", {
        BackgroundColor3 = L_105_arg1 or Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0
    }, {
        L_16_func("UICorner", {
            CornerRadius = UDim.new(L_106_arg2, L_107_arg3)
        })
    })
    return L_108_
end)


L_17_func("Button", function()
    local L_109_ = L_16_func("TextButton", {
        Text = "",
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    })
    return L_109_
end)


L_17_func("ScrollFrame", function(L_110_arg1, L_111_arg2)
    local L_112_ = L_16_func("ScrollingFrame", {
        BackgroundTransparency = 1,
        MidImage = "",
        BottomImage = "",
        TopImage = "",
        ScrollBarImageColor3 = L_110_arg1,
        BorderSizePixel = 0,
        ScrollBarThickness = L_111_arg2 or 3,
        CanvasSize = UDim2.new(0, 0, 0, 0)
    })
    return L_112_
end)


L_17_func("Image", function(L_113_arg1)
    local L_114_ = L_16_func("ImageLabel", {
        Image = L_113_arg1,
        BackgroundTransparency = 1
    })
    if L_11_[L_113_arg1] then
        L_114_.Image = L_11_[L_113_arg1]
    end
    return L_114_
end)


L_17_func("ImageButton", function(L_115_arg1)
    local L_116_ = L_16_func("ImageButton", {
        Image = L_115_arg1,
        BackgroundTransparency = 1
    })
    return L_116_
end)


L_17_func("Label", function(L_117_arg1, L_118_arg2, L_119_arg3)
    local L_120_ = L_16_func("TextLabel", {
        Text = L_117_arg1 or "",
        TextColor3 = Color3.fromRGB(240, 240, 240),
        TextTransparency = L_119_arg3 or 0,
        TextSize = L_118_arg2 or 15,
        Font = Enum.Font.Gotham,
        RichText = true,
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    return L_120_
end)


local L_31_ = L_19_func(L_20_func(L_18_func("TFrame"), {
    L_19_func(L_18_func("List"), {
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Bottom,
        Padding = UDim.new(0, 5)
    })
}), {
    Position = UDim2.new(1, -25, 1, -25),
    Size = UDim2.new(0, 300, 1, -25),
    AnchorPoint = Vector2.new(1, 1),
    Parent = L_12_
})


function L_10_:MakeNotification(L_121_arg1)
    task.spawn(function()
        L_121_arg1.Name = L_121_arg1.Name or "Notification"
        L_121_arg1.Content = L_121_arg1.Content or "Test"
        L_121_arg1.Image = L_121_arg1.Image or ""
        L_121_arg1.Time = L_121_arg1.Time or 15
        local L_122_ = L_19_func(L_18_func("TFrame"), {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Parent = L_31_
        })
        local L_123_ = L_20_func(L_19_func(L_18_func("RoundFrame", L_10_.Themes[L_10_.SelectedTheme].Main, 0, 12), {
            Parent = L_122_,
            Size = UDim2.new(1, 0, 0, 0),
            Position = UDim2.new(1, -55, 0, 0),
            BackgroundTransparency = 0,
            AutomaticSize = Enum.AutomaticSize.Y
        }), {
            L_18_func("Stroke", L_10_.Themes[L_10_.SelectedTheme].Stroke, 1),
            L_18_func("Padding", 14, 14, 14, 14),
            L_20_func(L_19_func(L_18_func("RoundFrame", L_10_.Themes[L_10_.SelectedTheme].Accent, 0, 6), {
                Size = UDim2.new(0, 6, 0, 6),
                Position = UDim2.new(0, 0, 0, 7),
                Name = "Icon"
            }), {}),
            L_19_func(L_18_func("Label", L_121_arg1.Name, 14), {
                Size = UDim2.new(1, -16, 0, 20),
                Position = UDim2.new(0, 16, 0, 0),
                Font = Enum.Font.GothamBold,
                Name = "Title"
            }),
            L_19_func(L_18_func("Label", L_121_arg1.Content, 14), {
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 0, 25),
                Font = Enum.Font.GothamMedium,
                Name = "Content",
                AutomaticSize = Enum.AutomaticSize.Y,
                TextColor3 = Color3.fromRGB(200, 200, 200),
                TextWrapped = true
            })
        })
        L_3_:Create(L_123_, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {
            Position = UDim2.new(0, 0, 0, 0)
        }):Play()
        task.wait(L_121_arg1.Time - 0.88)
        -- L_3_:Create(L_123_.Icon, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
        --     ImageTransparency = 1
        -- }):Play()
        L_3_:Create(L_123_, TweenInfo.new(0.8, Enum.EasingStyle.Quint), {
            BackgroundTransparency = 0.6
        }):Play()
        task.wait(0.3)
        L_3_:Create(L_123_.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {
            Transparency = 0.9
        }):Play()
        L_3_:Create(L_123_.Title, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {
            TextTransparency = 0.4
        }):Play()
        L_3_:Create(L_123_.Content, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {
            TextTransparency = 0.5
        }):Play()
        task.wait(0.05)
        L_123_:TweenPosition(UDim2.new(1, 20, 0, 0), "In", "Quint", 0.8, true)
        L_9_:AddItem(L_123_, 1.35)
    end)
end


function L_10_:Init()
    pcall(function()
        if L_10_.SaveCfg and getfenv().isfile and getfenv().readfile and getfenv().isfile(string.format("%s/%s.txt", L_10_["Folder"], game.PlaceId)) then
            L_26_func(getfenv().readfile(string.format("%s/%s.txt", L_10_["Folder"], game.PlaceId)))
            L_10_:MakeNotification({
                Name = "Configuration",
                Content = string.format("Auto-loaded configuration for the place %s.", game.PlaceId),
                Time = 5
            })
        end
    end)
end


function L_10_:MakeWindow(L_124_arg1)
    local L_125_ = false
    local L_126_ = false
    local L_127_ = false
    L_124_arg1 = L_124_arg1 or {}
    L_124_arg1.Name = L_124_arg1.Name or "Orion Library"
    L_124_arg1.ConfigFolder = L_124_arg1.ConfigFolder or L_124_arg1.Name
    L_124_arg1.SaveConfig = L_124_arg1.SaveConfig or false
    L_124_arg1.TestMode = L_124_arg1.TestMode or false
    if L_124_arg1.IntroEnabled == nil then
        L_124_arg1.IntroEnabled = true
    end
    L_124_arg1.IntroText = L_124_arg1.IntroText or "Orion Library"
    L_124_arg1.CloseCallback = L_124_arg1.CloseCallback or function() end
    L_124_arg1.ShowIcon = L_124_arg1.ShowIcon or false
    L_124_arg1.Icon = L_124_arg1.Icon or ""
    L_124_arg1.IntroIcon = L_124_arg1.IntroIcon or ""
    L_10_.Folder = L_124_arg1.ConfigFolder
    L_10_.SaveCfg = L_124_arg1.SaveConfig
    if L_124_arg1.SaveConfig and getfenv().isfolder and getfenv().makefolder and not getfenv().isfolder(L_124_arg1.ConfigFolder) then
        getfenv().makefolder(L_124_arg1.ConfigFolder)
    end
    local L_128_ = L_23_func(L_20_func(L_19_func(L_18_func("ScrollFrame", Color3.fromRGB(255, 255, 255), 4), {
        Size = UDim2.new(1, -12, 1, -62)
    }), {
        L_18_func("List", 0, 4),
        L_18_func("Padding", 12, 6, 6, 12)
    }), "Divider")
    L_14_func(L_128_.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
        L_128_.CanvasSize = UDim2.new(0, 0, 0, L_128_.UIListLayout.AbsoluteContentSize.Y + 16)
    end)
    local L_129_ = L_20_func(L_19_func(L_18_func("Button"), {
        Size = UDim2.new(0.5, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0, 0),
        BackgroundTransparency = 1
    }), {
        L_23_func(L_19_func(L_16_func("TextLabel", {
            Text = "×",
            Font = Enum.Font.GothamBold,
            TextSize = 20,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 6, 0, 3),
            Size = UDim2.new(0, 22, 0, 22),
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center
        }), {}), "Text")
    })
    local L_130_ = L_20_func(L_19_func(L_18_func("Button"), {
        Size = UDim2.new(0.5, 0, 1, 0),
        BackgroundTransparency = 1
    }), {
        L_23_func(L_19_func(L_16_func("TextLabel", {
            Text = "—",
            Font = Enum.Font.GothamBold,
            TextSize = 16,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 6, 0, 5),
            Size = UDim2.new(0, 22, 0, 22),
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
            Name = "Ico"
        }), {}), "Text")
    })
    local L_131_ = L_19_func(L_18_func("TFrame"), {
        Size = UDim2.new(1, 0, 0, 56)
    })
    local L_132_ = L_23_func(L_20_func(L_19_func(L_18_func("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 12), {
        Size = UDim2.new(0, 160, 1, -56),
        Position = UDim2.new(0, 0, 0, 56)
    }), {
        L_23_func(L_19_func(L_18_func("Frame"), {
            Size = UDim2.new(1, 0, 0, 12),
            Position = UDim2.new(0, 0, 0, 0)
        }), "Second"),
        L_23_func(L_19_func(L_18_func("Frame"), {
            Size = UDim2.new(0, 12, 1, 0),
            Position = UDim2.new(1, -12, 0, 0)
        }), "Second"),
        L_23_func(L_19_func(L_18_func("Frame"), {
            Size = UDim2.new(0, 1, 1, 0),
            Position = UDim2.new(1, -1, 0, 0)
        }), "Stroke"),
        L_128_,
        L_20_func(L_19_func(L_18_func("TFrame"), {
            Size = UDim2.new(1, 0, 0, 54),
            Position = UDim2.new(0, 0, 1, -54)
        }), {
            L_23_func(L_19_func(L_18_func("Frame"), {
                Size = UDim2.new(1, -16, 0, 1),
                Position = UDim2.new(0, 8, 0, 0)
            }), "Stroke"),
            L_23_func(L_20_func(L_19_func(L_18_func("Frame"), {
                AnchorPoint = Vector2.new(0, 0.5),
                Size = UDim2.new(0, 36, 0, 36),
                Position = UDim2.new(0, 12, 0.5, 0),
                ClipsDescendants = true
            }), {
                L_19_func(L_18_func("Image", string.format("https://www.roblox.com/headshot-thumbnail/image?userId=%s&width=420&height=420&format=png", L_5_.UserId)), {
                    Size = UDim2.new(1, 0, 1, 0)
                }),
                L_18_func("Corner", 1)
            }), "Divider"),
            L_20_func(L_19_func(L_18_func("TFrame"), {
                AnchorPoint = Vector2.new(0, 0.5),
                Size = UDim2.new(0, 36, 0, 36),
                Position = UDim2.new(0, 12, 0.5, 0)
            }), {
                L_23_func(L_18_func("Stroke"), "Stroke"),
                L_18_func("Corner", 1)
            }),
            L_23_func(L_19_func(L_18_func("Label", L_5_.DisplayName, L_124_arg1.TestMode and 12 or 13), {
                Size = UDim2.new(1, -64, 0, 14),
                Position = L_124_arg1.TestMode and UDim2.new(0, 56, 0, 12) or UDim2.new(0, 56, 0, 20),
                Font = Enum.Font.GothamBold,
                ClipsDescendants = true
            }), "Text"),
            L_23_func(L_19_func(L_18_func("Label", "Tester", 11), {
                Size = UDim2.new(1, -64, 0, 12),
                Position = UDim2.new(0, 56, 1, -24),
                Visible = L_124_arg1.TestMode
            }), "TextDark")
        })
    }), "Second")
    local L_133_ = L_23_func(L_19_func(L_18_func("Label", L_124_arg1.Name, 14), {
        Size = UDim2.new(1, -30, 2, 0),
        Position = UDim2.new(0, 20, 0, -21),
        Font = Enum.Font.GothamBold,
        TextSize = 18
    }), "Text")
    local L_134_ = L_23_func(L_19_func(L_18_func("Frame"), {
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 1, -1)
    }), "Stroke")
    local L_135_ = L_23_func(L_20_func(L_19_func(L_18_func("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 12), {
        Parent = L_12_,
        Position = UDim2.new(0.5, -310, 0.5, -230),
        Size = UDim2.new(0, 620, 0, 460),
        ClipsDescendants = true
    }), {
        L_20_func(L_19_func(L_18_func("TFrame"), {
            Size = UDim2.new(1, 0, 0, 56),
            Name = "TopBar"
        }), {
            L_133_,
            L_134_,
            L_23_func(L_20_func(L_19_func(L_18_func("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 8), {
                Size = UDim2.new(0, 72, 0, 32),
                Position = UDim2.new(1, -88, 0, 12)
            }), {
                L_23_func(L_19_func(L_18_func("Frame"), {
                    Size = UDim2.new(0, 1, 1, -8),
                    Position = UDim2.new(0.5, 0, 0, 4)
                }), "Stroke"),
                L_129_,
                L_130_
            }), "Second")
        }),
        L_131_,
        L_132_
    }), "Main")
    if L_124_arg1.ShowIcon then
        L_133_.Position = UDim2.new(0, 50, 0, -24)
        local L_138_ = L_19_func(L_18_func("Image", L_124_arg1.Icon), {
            Size = UDim2.new(0, 20, 0, 20),
            Position = UDim2.new(0, 25, 0, 15)
        })
        L_138_.Parent = L_135_.TopBar
    end
    L_15_func(L_131_, L_135_)
    L_14_func(L_129_.MouseButton1Up, function()
        L_135_.Visible = false
        L_127_ = true
        L_10_:MakeNotification({
            Name = "Interface Hidden",
            Content = "Tap RightShift to reopen the interface",
            Time = 5
        })
        L_124_arg1.CloseCallback()
    end)
    L_14_func(L_2_.InputBegan, function(L_139_arg1)
        if L_139_arg1.KeyCode == Enum.KeyCode.RightShift and L_127_ then
            L_135_.Visible = true
        end
    end)
    L_14_func(L_130_.MouseButton1Up, function()
        if L_126_ then
            L_3_:Create(L_135_, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 620, 0, 460)
            }):Play()
            L_130_.Ico.Text = "—"
            task.wait(0.02)
            L_135_.ClipsDescendants = false
            L_132_.Visible = true
            L_134_.Visible = true
        else
            L_135_.ClipsDescendants = true
            L_134_.Visible = false
            L_130_.Ico.Text = "+"
            L_3_:Create(L_135_, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, L_133_.TextBounds.X + 140, 0, 50)
            }):Play()
            task.wait(0.1)
            L_132_.Visible = false
        end
        L_126_ = not L_126_
    end)
    local function L_136_func()
        L_135_.Visible = false
        local L_140_ = L_19_func(L_18_func("Image", L_124_arg1.IntroIcon), {
            Parent = L_12_,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.4, 0),
            Size = UDim2.new(0, 28, 0, 28),
            ImageColor3 = Color3.fromRGB(255, 255, 255),
            ImageTransparency = 1
        })
        local L_141_ = L_19_func(L_18_func("Label", L_124_arg1.IntroText, 14), {
            Parent = L_12_,
            Size = UDim2.new(1, 0, 1, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 19, 0.5, 0),
            TextXAlignment = Enum.TextXAlignment.Center,
            Font = Enum.Font.GothamBold,
            TextTransparency = 1
        })
        L_3_:Create(L_140_, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = 0,
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
        task.wait(0.8)
        L_3_:Create(L_140_, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, -(L_141_.TextBounds.X / 2), 0.5, 0)
        }):Play()
        task.wait(0.3)
        L_3_:Create(L_141_, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextTransparency = 0
        }):Play()
        task.wait(2)
        L_3_:Create(L_141_, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextTransparency = 1
        }):Play()
        L_135_.Visible = true
        L_9_:AddItem(L_140_, 0)
        L_9_:AddItem(L_141_, 0)
    end
    if L_124_arg1.IntroEnabled then
        L_136_func()
    end
    local L_137_ = {}
    function L_137_:MakeTab(L_142_arg1)
        L_142_arg1 = L_142_arg1 or {}
        L_142_arg1.Name = L_142_arg1.Name or "Tab"
        L_142_arg1.Icon = L_142_arg1.Icon or ""
        L_142_arg1.TestersOnly = L_142_arg1.TestersOnly or false
        local L_143_Background = L_16_func("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = L_10_.Themes[L_10_.SelectedTheme].Accent,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Name = "Background"
        }, {
            L_16_func("UICorner", {
                CornerRadius = UDim.new(0, 6)
            })
        })
        local L_143_Indicator = L_16_func("Frame", {
            Size = UDim2.new(0, 3, 0, 20),
            Position = UDim2.new(0, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundColor3 = L_10_.Themes[L_10_.SelectedTheme].Accent,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Name = "Indicator"
        }, {
            L_16_func("UICorner", {
                CornerRadius = UDim.new(0, 2)
            })
        })
        local L_143_ = L_20_func(L_19_func(L_18_func("Button"), {
            Size = UDim2.new(1, 0, 0, 38),
            Parent = L_128_,
            Visible = L_124_arg1.TestMode and L_142_arg1.TestersOnly or not L_142_arg1.TestersOnly
        }), {
            L_143_Background,
            L_143_Indicator,
            L_23_func(L_19_func(L_18_func("Label", L_142_arg1.Name, 13), {
                Size = UDim2.new(1, -24, 1, 0),
                Position = UDim2.new(0, 16, 0, 0),
                Font = Enum.Font.GothamMedium,
                TextTransparency = 0.35,
                Name = "Title"
            }), "Text")
        })
        local L_144_ = L_23_func(L_20_func(L_19_func(L_18_func("ScrollFrame", Color3.fromRGB(255, 255, 255), 3), {
            Size = UDim2.new(1, -160, 1, -56),
            Position = UDim2.new(0, 160, 0, 56),
            Parent = L_135_,
            Visible = false,
            Name = "ItemContainer"
        }), {
            L_18_func("List", 0, 8),
            L_18_func("Padding", 16, 16, 16, 16)
        }), "Divider")
        L_14_func(L_144_.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
            L_144_.CanvasSize = UDim2.new(0, 0, 0, L_144_.UIListLayout.AbsoluteContentSize.Y + 30)
        end)
        if not L_125_ then
            L_125_ = L_143_.Visible
            if L_125_ then
                L_143_.Indicator.BackgroundTransparency = 0
                L_143_.Background.BackgroundTransparency = 0.9
                L_143_.Title.TextTransparency = 0
                L_143_.Title.Font = Enum.Font.GothamBold
                L_144_.Visible = true
            end
        end
        L_14_func(L_143_.MouseEnter, function()
            if L_143_.Indicator.BackgroundTransparency == 1 then
                L_3_:Create(L_143_.Background, TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    BackgroundTransparency = 0.95
                }):Play()
            end
        end)
        L_14_func(L_143_.MouseLeave, function()
            if L_143_.Indicator.BackgroundTransparency == 1 then
                L_3_:Create(L_143_.Background, TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    BackgroundTransparency = 1
                }):Play()
            end
        end)
        L_14_func(L_143_.MouseButton1Down, function()
            for _, L_149_forvar2 in next, L_128_:GetChildren() do
                if L_149_forvar2:IsA("TextButton") then
                    L_149_forvar2.Title.Font = Enum.Font.GothamMedium
                    L_3_:Create(L_149_forvar2.Indicator, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundTransparency = 1
                    }):Play()
                    L_3_:Create(L_149_forvar2.Background, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundTransparency = 1
                    }):Play()
                    L_3_:Create(L_149_forvar2.Title, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        TextTransparency = 0.35
                    }):Play()
                end
            end
            for _, L_151_forvar2 in next, L_135_:GetChildren() do
                if L_151_forvar2.Name == "ItemContainer" then
                    L_151_forvar2.Visible = false
                end
            end
            L_3_:Create(L_143_.Indicator, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                BackgroundTransparency = 0
            }):Play()
            L_3_:Create(L_143_.Background, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                BackgroundTransparency = 0.9
            }):Play()
            L_3_:Create(L_143_.Title, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                TextTransparency = 0
            }):Play()
            L_143_.Title.Font = Enum.Font.GothamBold
            L_144_.Visible = true
        end)
        local function L_145_func(L_152_arg1)
            local L_153_ = {}
            function L_153_:AddLabel(L_155_arg1)
                local L_156_ = L_23_func(L_20_func(L_19_func(L_18_func("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
                    Size = UDim2.new(1, 0, 0, 30),
                    BackgroundTransparency = 0.7,
                    Parent = L_152_arg1
                }), {
                    L_23_func(L_19_func(L_18_func("Label", L_155_arg1, 15), {
                        Size = UDim2.new(1, -12, 1, 0),
                        Position = UDim2.new(0, 12, 0, 0),
                        Font = Enum.Font.GothamBold,
                        Name = "Content"
                    }), "Text"),
                    L_23_func(L_18_func("Stroke"), "Stroke")
                }), "Second")
                local L_157_ = {}
                function L_157_:Set(L_158_arg1)
                    L_156_.Content.Text = L_158_arg1
                end
                return L_157_
            end
            function L_153_:AddParagraph(L_159_arg1, L_160_arg2)
                L_159_arg1 = L_159_arg1 or "Text"
                L_160_arg2 = L_160_arg2 or "Content"
                local L_161_ = L_23_func(L_20_func(L_19_func(L_18_func("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
                    Size = UDim2.new(1, 0, 0, 30),
                    BackgroundTransparency = 0.7,
                    Parent = L_152_arg1
                }), {
                    L_23_func(L_19_func(L_18_func("Label", L_159_arg1, 15), {
                        Size = UDim2.new(1, -12, 0, 14),
                        Position = UDim2.new(0, 12, 0, 10),
                        Font = Enum.Font.GothamBold,
                        Name = "Title"
                    }), "Text"),
                    L_23_func(L_19_func(L_18_func("Label", "", 13), {
                        Size = UDim2.new(1, -24, 0, 0),
                        Position = UDim2.new(0, 12, 0, 26),
                        Font = Enum.Font.GothamMedium,
                        Name = "Content",
                        TextWrapped = true
                    }), "TextDark"),
                    L_23_func(L_18_func("Stroke"), "Stroke")
                }), "Second")
                L_14_func(L_161_.Content:GetPropertyChangedSignal("Text"), function()
                    L_161_.Content.Size = UDim2.new(1, -24, 0, L_161_.Content.TextBounds.Y)
                    L_161_.Size = UDim2.new(1, 0, 0, L_161_.Content.TextBounds.Y + 35)
                end)
                L_161_.Content.Text = L_160_arg2
                local L_162_ = {}
                function L_162_:Set(L_163_arg1)
                    L_161_.Content.Text = L_163_arg1
                end
                return L_162_
            end
            function L_153_:AddButton(L_164_arg1)
                L_164_arg1 = L_164_arg1 or {}
                L_164_arg1.Name = L_164_arg1.Name or "Button"
                L_164_arg1.Callback = L_164_arg1.Callback or function() end
                L_164_arg1.Icon = L_164_arg1.Icon or ""
                local L_165_ = {}
                local L_166_ = L_19_func(L_18_func("Button"), {
                    Size = UDim2.new(1, 0, 1, 0)
                })
                local L_167_ = L_23_func(L_20_func(L_19_func(L_18_func("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 8), {
                    Size = UDim2.new(1, 0, 0, 38),
                    Parent = L_152_arg1
                }), {
                    L_23_func(L_19_func(L_18_func("Label", L_164_arg1.Name, 14), {
                        Size = UDim2.new(1, -24, 1, 0),
                        Position = UDim2.new(0, 14, 0, 0),
                        Font = Enum.Font.GothamMedium,
                        Name = "Content"
                    }), "Text"),
                    L_166_
                }), "Second")
                L_14_func(L_166_.MouseEnter, function()
                    L_3_:Create(L_167_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(L_10_.Themes[L_10_.SelectedTheme].Second.R * 255 + 3, L_10_.Themes[L_10_.SelectedTheme].Second.G * 255 + 3, L_10_.Themes[L_10_.SelectedTheme].Second.B * 255 + 3)
                    }):Play()
                end)
                L_14_func(L_166_.MouseLeave, function()
                    L_3_:Create(L_167_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = L_10_.Themes[L_10_.SelectedTheme].Second
                    }):Play()
                end)
                L_14_func(L_166_.MouseButton1Up, function()
                    L_3_:Create(L_167_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(L_10_.Themes[L_10_.SelectedTheme].Second.R * 255 + 3, L_10_.Themes[L_10_.SelectedTheme].Second.G * 255 + 3, L_10_.Themes[L_10_.SelectedTheme].Second.B * 255 + 3)
                    }):Play()
                    task.spawn(L_164_arg1.Callback)
                end)
                L_14_func(L_166_.MouseButton1Down, function()
                    L_3_:Create(L_167_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(L_10_.Themes[L_10_.SelectedTheme].Second.R * 255 + 6, L_10_.Themes[L_10_.SelectedTheme].Second.G * 255 + 6, L_10_.Themes[L_10_.SelectedTheme].Second.B * 255 + 6)
                    }):Play()
                end)
                function L_165_:Set(L_168_arg1)
                    L_167_.Content.Text = L_168_arg1
                end
                return L_165_
            end
            function L_153_:AddToggle(L_169_arg1)
                L_169_arg1 = L_169_arg1 or {}
                L_169_arg1.Name = L_169_arg1.Name or "Toggle"
                L_169_arg1.Default = L_169_arg1.Default or false
                L_169_arg1.Callback = L_169_arg1.Callback or function() end
                L_169_arg1.Color = L_169_arg1.Color or L_10_.Themes[L_10_.SelectedTheme].Accent or Color3.fromRGB(88, 101, 242)
                L_169_arg1.Flag = L_169_arg1.Flag or nil
                L_169_arg1.Save = L_169_arg1.Save or false
                local L_170_ = {
                    Value = L_169_arg1.Default,
                    Save = L_169_arg1.Save
                }
                local L_171_ = L_19_func(L_18_func("Button"), {
                    Size = UDim2.new(1, 0, 1, 0)
                })
                local L_172_Knob = L_16_func("Frame", {
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = UDim2.new(0, 3, 0.5, 0),
                    AnchorPoint = Vector2.new(0, 0.5),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0,
                    Name = "Knob"
                }, {
                    L_16_func("UICorner", {
                        CornerRadius = UDim.new(1, 0)
                    })
                })
                local L_172_ = L_20_func(L_19_func(L_18_func("RoundFrame", L_10_.Themes.Default.Divider, 0, 11), {
                    Size = UDim2.new(0, 44, 0, 22),
                    Position = UDim2.new(1, -34, 0.5, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Name = "Switch"
                }), {
                    L_172_Knob
                })
                local L_173_ = L_23_func(L_20_func(L_19_func(L_18_func("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 8), {
                    Size = UDim2.new(1, 0, 0, 42),
                    Parent = L_152_arg1
                }), {
                    L_23_func(L_19_func(L_18_func("Label", L_169_arg1.Name, 14), {
                        Size = UDim2.new(1, -60, 1, 0),
                        Position = UDim2.new(0, 14, 0, 0),
                        Font = Enum.Font.GothamMedium,
                        Name = "Content"
                    }), "Text"),
                    L_172_,
                    L_171_
                }), "Second")
                function L_170_:Set(L_174_arg1)
                    L_170_.Value = L_174_arg1
                    L_3_:Create(L_172_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = L_170_.Value and L_169_arg1.Color or L_10_.Themes.Default.Divider
                    }):Play()
                    L_3_:Create(L_172_.Knob, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        Position = L_170_.Value and UDim2.new(1, -19, 0.5, 0) or UDim2.new(0, 3, 0.5, 0)
                    }):Play()
                    L_169_arg1.Callback(L_170_.Value)
                end
                L_170_:Set(L_170_.Value)
                L_14_func(L_171_.MouseEnter, function()
                    L_3_:Create(L_173_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(L_10_.Themes[L_10_.SelectedTheme].Second.R * 255 + 3, L_10_.Themes[L_10_.SelectedTheme].Second.G * 255 + 3, L_10_.Themes[L_10_.SelectedTheme].Second.B * 255 + 3)
                    }):Play()
                end)
                L_14_func(L_171_.MouseLeave, function()
                    L_3_:Create(L_173_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = L_10_.Themes[L_10_.SelectedTheme].Second
                    }):Play()
                end)
                L_14_func(L_171_.MouseButton1Up, function()
                    L_3_:Create(L_173_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(L_10_.Themes[L_10_.SelectedTheme].Second.R * 255 + 3, L_10_.Themes[L_10_.SelectedTheme].Second.G * 255 + 3, L_10_.Themes[L_10_.SelectedTheme].Second.B * 255 + 3)
                    }):Play()
                    L_27_func(game.PlaceId)
                    L_170_:Set(not L_170_.Value)
                end)
                L_14_func(L_171_.MouseButton1Down, function()
                    L_3_:Create(L_173_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(L_10_.Themes[L_10_.SelectedTheme].Second.R * 255 + 6, L_10_.Themes[L_10_.SelectedTheme].Second.G * 255 + 6, L_10_.Themes[L_10_.SelectedTheme].Second.B * 255 + 6)
                    }):Play()
                end)
                if L_169_arg1.Flag then
                    L_10_.Flags[L_169_arg1.Flag] = L_170_
                end
                return L_170_
            end
            function L_153_:AddSlider(L_175_arg1)
                L_175_arg1 = L_175_arg1 or {}
                L_175_arg1.Name = L_175_arg1.Name or "Slider"
                L_175_arg1.Min = L_175_arg1.Min or 0
                L_175_arg1.Max = L_175_arg1.Max or 100
                L_175_arg1.Increment = L_175_arg1.Increment or 1
                L_175_arg1.Default = L_175_arg1.Default or 50
                L_175_arg1.Callback = L_175_arg1.Callback or function() end
                L_175_arg1.ValueName = L_175_arg1.ValueName or ""
                L_175_arg1.Color = L_175_arg1.Color or L_10_.Themes[L_10_.SelectedTheme].Accent or Color3.fromRGB(88, 101, 242)
                L_175_arg1.Flag = L_175_arg1.Flag or nil
                L_175_arg1.Save = L_175_arg1.Save or false
                local L_176_ = {
                    Value = L_175_arg1.Default,
                    Save = L_175_arg1.Save
                }
                local L_177_ = false
                local L_178_Fill = L_16_func("Frame", {
                    Size = UDim2.new(0, 0, 1, 0),
                    BackgroundColor3 = L_175_arg1.Color,
                    BorderSizePixel = 0,
                    Name = "Fill"
                }, {
                    L_16_func("UICorner", {
                        CornerRadius = UDim.new(0, 3)
                    })
                })
                local L_178_Thumb = L_16_func("Frame", {
                    Size = UDim2.new(0, 14, 0, 14),
                    Position = UDim2.new(0, 0, 0.5, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0,
                    Name = "Thumb"
                }, {
                    L_16_func("UICorner", {
                        CornerRadius = UDim.new(1, 0)
                    })
                })
                local L_179_ = L_20_func(L_19_func(L_18_func("RoundFrame", L_10_.Themes.Default.Divider, 0, 3), {
                    Size = UDim2.new(1, -28, 0, 6),
                    Position = UDim2.new(0, 14, 0, 42),
                    Name = "Track"
                }), {
                    L_178_Fill,
                    L_178_Thumb
                })
                L_23_func(L_20_func(L_19_func(L_18_func("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 8), {
                    Size = UDim2.new(1, 0, 0, 56),
                    Parent = L_152_arg1
                }), {
                    L_23_func(L_19_func(L_18_func("Label", L_175_arg1.Name, 14), {
                        Size = UDim2.new(1, -70, 0, 14),
                        Position = UDim2.new(0, 14, 0, 12),
                        Font = Enum.Font.GothamMedium,
                        Name = "Content"
                    }), "Text"),
                    L_23_func(L_19_func(L_18_func("Label", "0", 13), {
                        Size = UDim2.new(0, 50, 0, 14),
                        Position = UDim2.new(1, -64, 0, 12),
                        Font = Enum.Font.GothamBold,
                        TextXAlignment = Enum.TextXAlignment.Right,
                        Name = "ValueLabel"
                    }), "Text"),
                    L_179_
                }), "Second")
                L_179_.InputBegan:Connect(function(L_180_arg1)
                    if L_180_arg1.UserInputType == Enum.UserInputType.MouseButton1 or L_180_arg1.UserInputType == Enum.UserInputType.Touch then
                        L_177_ = true
                    end
                end)
                L_179_.InputEnded:Connect(function(L_181_arg1)
                    if L_181_arg1.UserInputType == Enum.UserInputType.MouseButton1 or L_181_arg1.UserInputType == Enum.UserInputType.Touch then
                        L_177_ = false
                    end
                end)
                function L_176_:Set(L_182_arg1)
                    L_182_arg1 = math.clamp(L_21_func(L_182_arg1, L_175_arg1.Increment), L_175_arg1.Min, L_175_arg1.Max)
                    L_176_.Value = L_182_arg1
                    local fillPercent = (L_182_arg1 - L_175_arg1.Min) / (L_175_arg1.Max - L_175_arg1.Min)
                    L_3_:Create(L_178_Fill, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Size = UDim2.fromScale(fillPercent, 1)
                    }):Play()
                    L_3_:Create(L_178_Thumb, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Position = UDim2.new(fillPercent, 0, 0.5, 0)
                    }):Play()
                    L_179_.Parent.ValueLabel.Text = string.format("%s%s", L_182_arg1, L_175_arg1.ValueName ~= "" and " " .. L_175_arg1.ValueName or "")
                    L_175_arg1.Callback(L_182_arg1)
                end
                L_2_.InputChanged:Connect(function(L_183_arg1)
                    if L_177_ and (L_183_arg1.UserInputType == Enum.UserInputType.MouseMovement or L_183_arg1.UserInputType == Enum.UserInputType.Touch) then
                        local L_184_ = math.clamp((L_183_arg1.Position.X - L_179_.AbsolutePosition.X) / L_179_.AbsoluteSize.X, 0, 1)
                        L_176_:Set(L_175_arg1.Min + (L_175_arg1.Max - L_175_arg1.Min) * L_184_)
                        L_27_func(game.PlaceId)
                    end
                end)
                L_176_:Set(L_176_.Value)
                if L_175_arg1.Flag then
                    L_10_.Flags[L_175_arg1.Flag] = L_176_
                end
                return L_176_
            end
            function L_153_:AddDropdown(L_185_arg1)
                L_185_arg1 = L_185_arg1 or {}
                L_185_arg1.Name = L_185_arg1.Name or "Dropdown"
                L_185_arg1.Options = L_185_arg1.Options or {}
                L_185_arg1.Default = L_185_arg1.Default or ""
                L_185_arg1.Callback = L_185_arg1.Callback or function() end
                L_185_arg1.Flag = L_185_arg1.Flag or nil
                L_185_arg1.Save = L_185_arg1.Save or false
                local L_186_ = {
                    Value = L_185_arg1.Default,
                    Options = L_185_arg1.Options,
                    Buttons = {},
                    Toggled = false,
                    Type = "Dropdown",
                    Save = L_185_arg1.Save
                }
                local L_187_ = 5
                if not table.find(L_186_.Options, L_186_.Value) then
                    L_186_.Value = "..."
                end
                local L_188_ = L_18_func("List")
                local L_189_ = L_23_func(L_19_func(L_20_func(L_18_func("ScrollFrame", L_10_.Themes.Default.Stroke, 3), {
                    L_188_
                }), {
                    Parent = L_152_arg1,
                    Position = UDim2.new(0, 0, 0, 42),
                    Size = UDim2.new(1, 0, 1, -42),
                    ClipsDescendants = true
                }), "Divider")
                local L_190_ = L_19_func(L_18_func("Button"), {
                    Size = UDim2.new(1, 0, 1, 0)
                })
                local L_191_ = L_23_func(L_20_func(L_19_func(L_18_func("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 8), {
                    Size = UDim2.new(1, 0, 0, 42),
                    Parent = L_152_arg1,
                    ClipsDescendants = true
                }), {
                    L_189_,
                    L_19_func(L_20_func(L_18_func("TFrame"), {
                        L_23_func(L_19_func(L_18_func("Label", L_185_arg1.Name, 14), {
                            Size = UDim2.new(1, -12, 1, 0),
                            Position = UDim2.new(0, 14, 0, 0),
                            Font = Enum.Font.GothamMedium,
                            Name = "Content"
                        }), "Text"),
                        L_23_func(L_19_func(L_16_func("TextLabel", {
                            Text = "▾",
                            Font = Enum.Font.GothamBold,
                            TextSize = 14,
                            BackgroundTransparency = 1,
                            Size = UDim2.new(0, 20, 0, 20),
                            AnchorPoint = Vector2.new(0, 0.5),
                            Position = UDim2.new(1, -26, 0.5, 0),
                            TextXAlignment = Enum.TextXAlignment.Center,
                            TextYAlignment = Enum.TextYAlignment.Center,
                            Name = "Ico"
                        }), {}), "TextDark"),
                        L_23_func(L_19_func(L_18_func("Label", "Select", 13), {
                            Size = UDim2.new(1, -44, 1, 0),
                            Font = Enum.Font.Gotham,
                            Name = "Selected",
                            TextXAlignment = Enum.TextXAlignment.Right
                        }), "TextDark"),
                        L_23_func(L_19_func(L_18_func("Frame"), {
                            Size = UDim2.new(1, 0, 0, 1),
                            Position = UDim2.new(0, 0, 1, -1),
                            Name = "Line",
                            Visible = false
                        }), "Stroke"),
                        L_190_
                    }), {
                        Size = UDim2.new(1, 0, 0, 42),
                        ClipsDescendants = true,
                        Name = "F"
                    }),
                    L_18_func("Corner")
                }), "Second")
                L_14_func(L_188_:GetPropertyChangedSignal("AbsoluteContentSize"), function()
                    L_189_.CanvasSize = UDim2.new(0, 0, 0, L_188_.AbsoluteContentSize.Y)
                end)
                local function L_192_func(L_193_arg1)
                    for _, L_195_forvar2 in next, L_193_arg1 do
                        local L_196_ = L_23_func(L_19_func(L_20_func(L_18_func("Button", L_10_.Themes.Default.Stroke), {
                            L_18_func("Corner", 0, 6),
                            L_23_func(L_19_func(L_18_func("Label", L_195_forvar2, 13, 0.4), {
                                Position = UDim2.new(0, 12, 0, 0),
                                Size = UDim2.new(1, -12, 1, 0),
                                Name = "Title"
                            }), "Text")
                        }), {
                            Parent = L_189_,
                            Size = UDim2.new(1, 0, 0, 32),
                            BackgroundTransparency = 1,
                            ClipsDescendants = true
                        }), "Divider")
                        L_14_func(L_196_.MouseButton1Down, function()
                            L_186_:Set(L_195_forvar2)
                            L_27_func(game.PlaceId)
                        end)
                        L_186_.Buttons[L_195_forvar2] = L_196_
                    end
                end
                function L_186_:Refresh(L_197_arg1, L_198_arg2)
                    if L_198_arg2 then
                        for _, L_200_forvar2 in next, L_186_.Buttons do
                            L_9_:AddItem(L_200_forvar2, 0)
                        end
                        table.clear(L_186_.Options)
                        table.clear(L_186_.Buttons)
                    end
                    L_186_.Options = L_197_arg1
                    L_192_func(L_186_.Options)
                end
                function L_186_:Set(L_201_arg1)
                    if not table.find(L_186_.Options, L_201_arg1) then
                        L_186_.Value = "..."
                        L_191_.F.Selected.Text = L_186_.Value
                        for _, L_203_forvar2 in next, L_186_.Buttons do
                            L_3_:Create(L_203_forvar2, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                BackgroundTransparency = 1
                            }):Play()
                            L_3_:Create(L_203_forvar2.Title, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                TextTransparency = 0.4
                            }):Play()
                        end
                        return
                    end
                    L_186_.Value = L_201_arg1
                    L_191_.F.Selected.Text = L_186_.Value
                    for _, L_205_forvar2 in next, L_186_.Buttons do
                        L_3_:Create(L_205_forvar2, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            BackgroundTransparency = 1
                        }):Play()
                        L_3_:Create(L_205_forvar2.Title, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            TextTransparency = 0.4
                        }):Play()
                    end
                    L_3_:Create(L_186_.Buttons[L_201_arg1], TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        BackgroundTransparency = 0
                    }):Play()
                    L_3_:Create(L_186_.Buttons[L_201_arg1].Title, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        TextTransparency = 0
                    }):Play()
                    return L_185_arg1.Callback(L_186_.Value)
                end
                L_14_func(L_190_.MouseButton1Down, function()
                    L_186_.Toggled = not L_186_.Toggled
                    L_191_.F.Line.Visible = L_186_.Toggled
                    L_3_:Create(L_191_.F.Ico, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        Rotation = L_186_.Toggled and 180 or 0
                    }):Play()
                    if #L_186_.Options > L_187_ then
                        L_3_:Create(L_191_, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                            Size = L_186_.Toggled and UDim2.new(1, 0, 0, 42 + L_187_ * 32) or UDim2.new(1, 0, 0, 42)
                        }):Play()
                    else
                        L_3_:Create(L_191_, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                            Size = L_186_.Toggled and UDim2.new(1, 0, 0, L_188_.AbsoluteContentSize.Y + 42) or UDim2.new(1, 0, 0, 42)
                        }):Play()
                    end
                end)
                L_186_:Refresh(L_186_.Options, false)
                L_186_:Set(L_186_.Value)
                if L_185_arg1.Flag then
                    L_10_.Flags[L_185_arg1.Flag] = L_186_
                end
                return L_186_
            end
            local L_154_ = nil
            function L_153_:AddBind(L_206_arg1)
                L_206_arg1.Name = L_206_arg1.Name or "Bind"
                L_206_arg1.Default = L_206_arg1.Default or Enum.KeyCode.Unknown
                L_206_arg1.Hold = L_206_arg1.Hold or false
                L_206_arg1.Callback = L_206_arg1.Callback or function() end
                L_206_arg1.Flag = L_206_arg1.Flag or nil
                L_206_arg1.Save = L_206_arg1.Save or false
                local L_207_ = {
                    L_154_,
                    Binding = false,
                    Type = "Bind",
                    Save = L_206_arg1.Save
                }
                local L_208_ = false
                local L_209_ = L_19_func(L_18_func("Button"), {
                    Size = UDim2.new(1, 0, 1, 0)
                })
                local L_210_ = L_23_func(L_20_func(L_19_func(L_18_func("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 4), {
                    Size = UDim2.new(0, 24, 0, 24),
                    Position = UDim2.new(1, -12, 0.5, 0),
                    AnchorPoint = Vector2.new(1, 0.5)
                }), {
                    L_23_func(L_18_func("Stroke"), "Stroke"),
                    L_23_func(L_19_func(L_18_func("Label", L_206_arg1.Name, 14), {
                        Size = UDim2.new(1, 0, 1, 0),
                        Font = Enum.Font.GothamBold,
                        TextXAlignment = Enum.TextXAlignment.Center,
                        Name = "Value"
                    }), "Text")
                }), "Main")
                local L_211_ = L_23_func(L_20_func(L_19_func(L_18_func("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
                    Size = UDim2.new(1, 0, 0, 38),
                    Parent = L_152_arg1
                }), {
                    L_23_func(L_19_func(L_18_func("Label", L_206_arg1.Name, 15), {
                        Size = UDim2.new(1, -12, 1, 0),
                        Position = UDim2.new(0, 12, 0, 0),
                        Font = Enum.Font.GothamBold,
                        Name = "Content"
                    }), "Text"),
                    L_23_func(L_18_func("Stroke"), "Stroke"),
                    L_210_,
                    L_209_
                }), "Second")
                L_14_func(L_210_.Value:GetPropertyChangedSignal("Text"), function()
                    L_3_:Create(L_210_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        Size = UDim2.new(0, L_210_.Value.TextBounds.X + 16, 0, 24)
                    }):Play()
                end)
                L_14_func(L_209_.InputEnded, function(L_212_arg1)
                    if (L_212_arg1.UserInputType == Enum.UserInputType.MouseButton1 or L_212_arg1.UserInputType == Enum.UserInputType.Touch) and not L_207_.Binding then
                        L_207_.Binding = true
                        L_210_.Value.Text = ""
                    end
                end)
                function L_207_:Set(L_213_arg1)
                    L_207_.Binding = false
                    L_207_.Value = L_213_arg1 or L_207_.Value
                    L_207_.Value = L_207_.Value.Name or L_207_.Value
                    L_210_.Value.Text = L_207_.Value
                end
                L_14_func(L_2_.InputBegan, function(L_214_arg1)
                    if L_2_:GetFocusedTextBox() then
                        return
                    end
                    if (L_214_arg1.KeyCode.Name == L_207_.Value or L_214_arg1.UserInputType.Name == L_207_.Value) and not L_207_.Binding then
                        if L_206_arg1.Hold then
                            L_208_ = true
                            L_206_arg1.Callback(L_208_)
                        else
                            L_206_arg1.Callback()
                        end
                    elseif L_207_.Binding then
                        local L_215_
                        pcall(function()
                            if not L_30_func(L_29_, L_214_arg1.KeyCode) then
                                L_215_ = L_214_arg1.KeyCode
                            end
                        end)
                        pcall(function()
                            if L_30_func(L_28_, L_214_arg1.UserInputType) and not L_215_ then
                                L_215_ = L_214_arg1.UserInputType
                            end
                        end)
                        L_215_ = L_215_ or L_207_.Value
                        L_207_:Set(L_215_)
                        L_27_func(game.PlaceId)
                    end
                end)
                L_14_func(L_2_.InputEnded, function(L_216_arg1)
                    if (L_216_arg1.KeyCode.Name == L_207_.Value or L_216_arg1.UserInputType.Name == L_207_.Value) and L_206_arg1.Hold and L_208_ then
                        L_208_ = false
                        L_206_arg1.Callback(L_208_)
                    end
                end)
                L_14_func(L_209_.MouseEnter, function()
                    L_3_:Create(L_211_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(L_10_.Themes[L_10_.SelectedTheme].Second.R * 255 + 3, L_10_.Themes[L_10_.SelectedTheme].Second.G * 255 + 3, L_10_.Themes[L_10_.SelectedTheme].Second.B * 255 + 3)
                    }):Play()
                end)
                L_14_func(L_209_.MouseLeave, function()
                    L_3_:Create(L_211_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = L_10_.Themes[L_10_.SelectedTheme].Second
                    }):Play()
                end)
                L_14_func(L_209_.MouseButton1Up, function()
                    L_3_:Create(L_211_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(L_10_.Themes[L_10_.SelectedTheme].Second.R * 255 + 3, L_10_.Themes[L_10_.SelectedTheme].Second.G * 255 + 3, L_10_.Themes[L_10_.SelectedTheme].Second.B * 255 + 3)
                    }):Play()
                end)
                L_14_func(L_209_.MouseButton1Down, function()
                    L_3_:Create(L_211_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(L_10_.Themes[L_10_.SelectedTheme].Second.R * 255 + 6, L_10_.Themes[L_10_.SelectedTheme].Second.G * 255 + 6, L_10_.Themes[L_10_.SelectedTheme].Second.B * 255 + 6)
                    }):Play()
                end)
                L_207_:Set(L_206_arg1.Default)
                if L_206_arg1.Flag then
                    L_10_.Flags[L_206_arg1.Flag] = L_207_
                end
                return L_207_
            end
            function L_153_:AddTextbox(L_217_arg1)
                L_217_arg1 = L_217_arg1 or {}
                L_217_arg1.Name = L_217_arg1.Name or "Textbox"
                L_217_arg1.Default = L_217_arg1.Default or ""
                L_217_arg1.TextDisappear = L_217_arg1.TextDisappear or false
                L_217_arg1.Callback = L_217_arg1.Callback or function() end
                local L_218_ = L_19_func(L_18_func("Button"), {
                    Size = UDim2.new(1, 0, 1, 0)
                })
                local L_219_ = L_23_func(L_16_func("TextBox", {
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    PlaceholderColor3 = Color3.fromRGB(210, 210, 210),
                    PlaceholderText = "Input",
                    Font = Enum.Font.GothamMedium,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    TextSize = 14,
                    ClearTextOnFocus = false
                }), "Text")
                local L_220_ = L_23_func(L_20_func(L_19_func(L_18_func("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 4), {
                    Size = UDim2.new(0, 24, 0, 24),
                    Position = UDim2.new(1, -12, 0.5, 0),
                    AnchorPoint = Vector2.new(1, 0.5)
                }), {
                    L_23_func(L_18_func("Stroke"), "Stroke"),
                    L_219_
                }), "Main")
                local L_221_ = L_23_func(L_20_func(L_19_func(L_18_func("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
                    Size = UDim2.new(1, 0, 0, 38),
                    Parent = L_152_arg1
                }), {
                    L_23_func(L_19_func(L_18_func("Label", L_217_arg1.Name, 15), {
                        Size = UDim2.new(1, -12, 1, 0),
                        Position = UDim2.new(0, 12, 0, 0),
                        Font = Enum.Font.GothamBold,
                        Name = "Content"
                    }), "Text"),
                    L_23_func(L_18_func("Stroke"), "Stroke"),
                    L_220_,
                    L_218_
                }), "Second")
                L_14_func(L_219_:GetPropertyChangedSignal("Text"), function()
                    L_3_:Create(L_220_, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        Size = UDim2.new(0, L_219_.TextBounds.X + 16, 0, 24)
                    }):Play()
                end)
                L_14_func(L_219_.FocusLost, function()
                    L_217_arg1.Callback(L_219_.Text)
                    if L_217_arg1.TextDisappear then
                        L_219_.Text = ""
                    end
                end)
                L_219_.Text = L_217_arg1.Default
                L_14_func(L_218_.MouseEnter, function()
                    L_3_:Create(L_221_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(L_10_.Themes[L_10_.SelectedTheme].Second.R * 255 + 3, L_10_.Themes[L_10_.SelectedTheme].Second.G * 255 + 3, L_10_.Themes[L_10_.SelectedTheme].Second.B * 255 + 3)
                    }):Play()
                end)
                L_14_func(L_218_.MouseLeave, function()
                    L_3_:Create(L_221_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = L_10_.Themes[L_10_.SelectedTheme].Second
                    }):Play()
                end)
                L_14_func(L_218_.MouseButton1Up, function()
                    L_3_:Create(L_221_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(L_10_.Themes[L_10_.SelectedTheme].Second.R * 255 + 3, L_10_.Themes[L_10_.SelectedTheme].Second.G * 255 + 3, L_10_.Themes[L_10_.SelectedTheme].Second.B * 255 + 3)
                    }):Play()
                    L_219_:CaptureFocus()
                end)
                L_14_func(L_218_.MouseButton1Down, function()
                    L_3_:Create(L_221_, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Color3.fromRGB(L_10_.Themes[L_10_.SelectedTheme].Second.R * 255 + 6, L_10_.Themes[L_10_.SelectedTheme].Second.G * 255 + 6, L_10_.Themes[L_10_.SelectedTheme].Second.B * 255 + 6)
                    }):Play()
                end)
            end
            function L_153_:AddColorpicker(L_222_arg1)
                L_222_arg1 = L_222_arg1 or {}
                L_222_arg1.Name = L_222_arg1.Name or "Colorpicker"
                L_222_arg1.Default = L_222_arg1.Default or Color3.fromRGB(255, 255, 255)
                L_222_arg1.Callback = L_222_arg1.Callback or function() end
                L_222_arg1.Flag = L_222_arg1.Flag or nil
                L_222_arg1.Save = L_222_arg1.Save or false
                local L_223_, L_224_, L_225_ = 1, 1, 1
                local L_226_ = {
                    Value = L_222_arg1.Default,
                    Toggled = false,
                    Type = "Colorpicker",
                    Save = L_222_arg1.Save
                }
                local L_227_ = L_16_func("Frame", {
                    Size = UDim2.new(0, 12, 0, 12),
                    Position = UDim2.new(select(3, L_226_.Value:ToHSV())),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0
                }, {
                    L_16_func("UICorner", {
                        CornerRadius = UDim.new(1, 0)
                    }),
                    L_16_func("UIStroke", {
                        Color = Color3.fromRGB(0, 0, 0),
                        Thickness = 2
                    })
                })
                local L_228_ = L_16_func("Frame", {
                    Size = UDim2.new(0, 12, 0, 12),
                    Position = UDim2.new(0.5, 0, 1 - select(1, L_226_.Value:ToHSV())),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0
                }, {
                    L_16_func("UICorner", {
                        CornerRadius = UDim.new(1, 0)
                    }),
                    L_16_func("UIStroke", {
                        Color = Color3.fromRGB(0, 0, 0),
                        Thickness = 2
                    })
                })
                local L_229_ = L_16_func("Frame", {
                    Size = UDim2.new(1, -25, 1, 0),
                    Visible = false,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0
                }, {
                    L_16_func("UICorner", {
                        CornerRadius = UDim.new(0, 6)
                    }),
                    L_16_func("UIGradient", {
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
                        },
                        Transparency = NumberSequence.new{
                            NumberSequenceKeypoint.new(0, 0),
                            NumberSequenceKeypoint.new(1, 1)
                        }
                    }),
                    L_16_func("Frame", {
                        Size = UDim2.new(1, 0, 1, 0),
                        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                        BorderSizePixel = 0,
                        ZIndex = 0
                    }, {
                        L_16_func("UICorner", {
                            CornerRadius = UDim.new(0, 6)
                        }),
                        L_16_func("UIGradient", {
                            Rotation = 90,
                            Transparency = NumberSequence.new{
                                NumberSequenceKeypoint.new(0, 1),
                                NumberSequenceKeypoint.new(1, 0)
                            }
                        })
                    }),
                    L_227_
                })
                local L_230_ = L_16_func("Frame", {
                    Size = UDim2.new(0, 20, 1, 0),
                    Position = UDim2.new(1, -20, 0, 0),
                    Visible = false
                }, {
                    L_16_func("UIGradient", {
                        Rotation = 270,
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)),
                            ColorSequenceKeypoint.new(0.2, Color3.fromRGB(234, 255, 0)),
                            ColorSequenceKeypoint.new(0.4, Color3.fromRGB(21, 255, 0)),
                            ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 255)),
                            ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 17, 255)),
                            ColorSequenceKeypoint.new(0.9, Color3.fromRGB(255, 0, 251)),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4))
                        }
                    }),
                    L_16_func("UICorner", {
                        CornerRadius = UDim.new(0, 5)
                    }),
                    L_228_
                })
                local L_231_ = L_16_func("Frame", {
                    Position = UDim2.new(0, 0, 0, 32),
                    Size = UDim2.new(1, 0, 1, -32),
                    BackgroundTransparency = 1,
                    ClipsDescendants = true
                }, {
                    L_230_,
                    L_229_,
                    L_16_func("UIPadding", {
                        PaddingLeft = UDim.new(0, 35),
                        PaddingRight = UDim.new(0, 35),
                        PaddingBottom = UDim.new(0, 10),
                        PaddingTop = UDim.new(0, 17)
                    })
                })
                local L_232_ = L_19_func(L_18_func("Button"), {
                    Size = UDim2.new(1, 0, 1, 0)
                })
                local L_233_ = L_23_func(L_20_func(L_19_func(L_18_func("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 4), {
                    Size = UDim2.new(0, 24, 0, 24),
                    Position = UDim2.new(1, -12, 0.5, 0),
                    AnchorPoint = Vector2.new(1, 0.5)
                }), {
                    L_23_func(L_18_func("Stroke"), "Stroke")
                }), "Main")
                local L_234_ = L_23_func(L_20_func(L_19_func(L_18_func("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
                    Size = UDim2.new(1, 0, 0, 38),
                    Parent = L_152_arg1
                }), {
                    L_19_func(L_20_func(L_18_func("TFrame"), {
                        L_23_func(L_19_func(L_18_func("Label", L_222_arg1.Name, 15), {
                            Size = UDim2.new(1, -12, 1, 0),
                            Position = UDim2.new(0, 12, 0, 0),
                            Font = Enum.Font.GothamBold,
                            Name = "Content"
                        }), "Text"),
                        L_233_,
                        L_232_,
                        L_23_func(L_19_func(L_18_func("Frame"), {
                            Size = UDim2.new(1, 0, 0, 1),
                            Position = UDim2.new(0, 0, 1, -1),
                            Name = "Line",
                            Visible = false
                        }), "Stroke")
                    }), {
                        Size = UDim2.new(1, 0, 0, 38),
                        ClipsDescendants = true,
                        Name = "F"
                    }),
                    L_231_,
                    L_23_func(L_18_func("Stroke"), "Stroke")
                }), "Second")
                L_14_func(L_232_.MouseButton1Down, function()
                    L_226_.Toggled = not L_226_.Toggled
                    L_3_:Create(L_234_, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Size = L_226_.Toggled and UDim2.new(1, 0, 0, 148) or UDim2.new(1, 0, 0, 38)
                    }):Play()
                    L_229_.Visible = L_226_.Toggled
                    L_230_.Visible = L_226_.Toggled
                    L_234_.F.Line.Visible = L_226_.Toggled
                end)
                function L_226_:Set(L_238_arg1)
                    L_226_.Value = L_238_arg1
                    L_233_.BackgroundColor3 = L_226_.Value
                    L_222_arg1.Callback(L_226_.Value)
                end
                local function L_235_func()
                    L_233_.BackgroundColor3 = Color3.fromHSV(L_223_, L_224_, L_225_)
                    L_229_.BackgroundColor3 = Color3.fromHSV(L_223_, 1, 1)
                    L_226_:Set(L_233_.BackgroundColor3)
                    L_222_arg1.Callback(L_233_.BackgroundColor3)
                    L_27_func(game.PlaceId)
                end
                L_223_ = 1 - math.clamp(L_228_.AbsolutePosition.Y - L_230_.AbsolutePosition.Y, 0, L_230_.AbsoluteSize.Y) / L_230_.AbsoluteSize.Y
                L_224_ = math.clamp(L_227_.AbsolutePosition.X - L_229_.AbsolutePosition.X, 0, L_229_.AbsoluteSize.X) / L_229_.AbsoluteSize.X
                L_225_ = 1 - math.clamp(L_227_.AbsolutePosition.Y - L_229_.AbsolutePosition.Y, 0, L_229_.AbsoluteSize.Y) / L_229_.AbsoluteSize.Y
                local L_236_
                L_14_func(L_229_.InputBegan, function(L_239_arg1)
                    if L_239_arg1.UserInputType == Enum.UserInputType.MouseButton1 or L_239_arg1.UserInputType == Enum.UserInputType.Touch then
                        if L_236_ then
                            L_236_:Disconnect()
                        end
                        L_236_ = L_14_func(L_4_.RenderStepped, function()
                            local L_240_ = math.clamp(L_6_.X - L_229_.AbsolutePosition.X, 0, L_229_.AbsoluteSize.X) / L_229_.AbsoluteSize.X
                            local L_241_ = math.clamp(L_6_.Y - L_229_.AbsolutePosition.Y, 0, L_229_.AbsoluteSize.Y) / L_229_.AbsoluteSize.Y
                            L_227_.Position = UDim2.new(L_240_, 0, L_241_, 0)
                            L_224_ = L_240_
                            L_225_ = 1 - L_241_
                            L_235_func()
                        end)
                    end
                end)
                L_14_func(L_229_.InputEnded, function(L_242_arg1)
                    if (L_242_arg1.UserInputType == Enum.UserInputType.MouseButton1 or L_242_arg1.UserInputType == Enum.UserInputType.Touch) and L_236_ then
                        L_236_:Disconnect()
                    end
                end)
                local L_237_
                L_14_func(L_230_.InputBegan, function(L_243_arg1)
                    if L_243_arg1.UserInputType == Enum.UserInputType.MouseButton1 or L_243_arg1.UserInputType == Enum.UserInputType.Touch then
                        if L_237_ then
                            L_237_:Disconnect()
                        end
                        L_237_ = L_14_func(L_4_.RenderStepped, function()
                            local L_244_ = math.clamp(L_6_.Y - L_230_.AbsolutePosition.Y, 0, L_230_.AbsoluteSize.Y) / L_230_.AbsoluteSize.Y
                            L_228_.Position = UDim2.new(0.5, 0, L_244_, 0)
                            L_223_ = 1 - L_244_
                            L_235_func()
                        end)
                    end
                end)
                L_14_func(L_230_.InputEnded, function(L_245_arg1)
                    if (L_245_arg1.UserInputType == Enum.UserInputType.MouseButton1 or L_245_arg1.UserInputType == Enum.UserInputType.Touch) and L_237_ then
                        L_237_:Disconnect()
                    end
                end)
                L_226_:Set(L_226_.Value)
                if L_222_arg1.Flag then
                    L_10_.Flags[L_222_arg1.Flag] = L_226_
                end
                return L_226_
            end
            return L_153_
        end
        local L_146_ = {}
        function L_146_:AddSection(L_246_arg1)
            L_246_arg1.Name = L_246_arg1.Name or "Section"
            local L_247_ = L_20_func(L_19_func(L_18_func("TFrame"), {
                Size = UDim2.new(1, 0, 0, 26),
                Parent = L_144_
            }), {
                L_23_func(L_19_func(L_18_func("Label", L_246_arg1.Name, 14), {
                    Size = UDim2.new(1, -12, 0, 16),
                    Position = UDim2.new(0, 0, 0, 3),
                    Font = Enum.Font.GothamMedium
                }), "TextDark"),
                L_20_func(L_19_func(L_18_func("TFrame"), {
                    AnchorPoint = Vector2.new(0, 0),
                    Size = UDim2.new(1, 0, 1, -24),
                    Position = UDim2.new(0, 0, 0, 23),
                    Name = "Holder"
                }), {
                    L_18_func("List", 0, 6)
                })
            })
            L_14_func(L_247_.Holder.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
                L_247_.Size = UDim2.new(1, 0, 0, L_247_.Holder.UIListLayout.AbsoluteContentSize.Y + 31)
                L_247_.Holder.Size = UDim2.new(1, 0, 0, L_247_.Holder.UIListLayout.AbsoluteContentSize.Y)
            end)
            local L_248_ = {}
            for L_249_forvar1, L_250_forvar2 in next, L_145_func(L_247_.Holder) do
                L_248_[L_249_forvar1] = L_250_forvar2
            end
            return L_248_
        end
        for L_251_forvar1, L_252_forvar2 in next, L_145_func(L_144_) do
            L_146_[L_251_forvar1] = L_252_forvar2
        end
        return L_146_
    end
    return L_137_
end


function L_10_:Destroy()
    L_9_:AddItem(L_12_, 0)
end


return L_10_
