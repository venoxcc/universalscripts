local OrionWrapper = {}

local library = loadstring(game:HttpGet(("https://raw.githubusercontent.com/weakhoes/Roblox-UI-Libs/refs/heads/main/Elerium%20%5BIMGUI%5D%20Lib/Elerium%20%5BIMGUI%5D%20Lib%20Source.lua")))()

local function createTab(window, name)
    return window:AddTab(name)
end

local function createSection(tab, name)
    return tab:AddFolder(name)
end

function OrionWrapper:Init()
    self.Windows = {}
    return self
end

function OrionWrapper:MakeWindow(config)
    local window = library:AddWindow(config.Name, {})
    self.Windows[config.Name] = window
    return {
        Tabs = {},
        CreateTab = function(name)
            local tab = createTab(window, name)
            self.Windows[config.Name].Tabs[name] = tab
            return tab
        end
    }
end

function OrionWrapper:MakeTab(config)
    local window = self.Windows[config.Window]
    if not window then
        error("Window not found: " .. tostring(config.Window))
    end
    local tab = window.Tabs[config.Name] or createTab(window, config.Name)
    return {
        CreateSection = function(name)
            return createSection(tab, name)
        end,
        CreateButton = function(buttonConfig)
            return tab:AddButton(buttonConfig.Title, buttonConfig.Callback)
        end,
        CreateToggle = function(toggleConfig)
            local switch = tab:AddSwitch(toggleConfig.Name, toggleConfig.Callback)
            if toggleConfig.Default then
                switch:Set(toggleConfig.Default)
            end
            return switch
        end,
        CreateSlider = function(sliderConfig)
            local slider = tab:AddSlider(sliderConfig.Name, sliderConfig.Callback, {
                ["min"] = sliderConfig.Min,
                ["max"] = sliderConfig.Max,
            })
            if sliderConfig.Default then
                slider:Set(sliderConfig.Default)
            end
            return slider
        end,
        CreateTextbox = function(textboxConfig)
            return tab:AddTextBox(textboxConfig.Name, textboxConfig.Callback, {
                ["clear"] = textboxConfig.ClearOnFocus or true
            })
        end,
        CreateKeybind = function(keybindConfig)
            local keybind = tab:AddKeybind(keybindConfig.Name, keybindConfig.Callback, {
                ["standard"] = keybindConfig.Default or Enum.KeyCode.RightShift
            })
            return keybind
        end,
        CreateDropdown = function(dropdownConfig)
            local dropdown = tab:AddDropdown(dropdownConfig.Name, dropdownConfig.Callback)
            for _, option in ipairs(dropdownConfig.Options) do
                dropdown:Add(option)
            end
            return dropdown
        end,
        CreateColorPicker = function(colorPickerConfig)
            local colorPicker = tab:AddColorPicker(colorPickerConfig.Callback)
            if colorPickerConfig.Default then
                colorPicker:Set(colorPickerConfig.Default)
            end
            return colorPicker
        end,
        CreateLabel = function(labelConfig)
            return tab:AddLabel(labelConfig.Text)
        end
    }
end

return OrionWrapper
