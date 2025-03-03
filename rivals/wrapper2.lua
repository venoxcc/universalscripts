local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local LibWrapper = {}

-- CreateWindow function, wrapping OrionLib's MakeWindow
function LibWrapper:MakeWindow(config)
    -- Call Rayfield's CreateWindow, passing the config
    local window = Rayfield:CreateWindow({
        Name = config.Name,
        LoadingTitle = config.IntroText or "",
        LoadingSubtitle = "by ",
        Icon = config.Icon or "",
        KeySystem = false, -- Assuming you don't need Rayfield's KeySystem for this.
        ConfigurationSaving = {
            Enabled = config.SaveConfig or false,
            FolderName = config.ConfigFolder or "DefaultConfigFolder",
            FileName = "OrionConfig"
        },
    })

    -- Wrapper for the window to provide OrionLib-like functionality
    local windowWrapper = {}

    -- Add MakeTab functionality
    function windowWrapper:MakeTab(tabConfig)
        local tab = window:CreateTab(tabConfig.Name)
        
        local tabWrapper = {}

        -- Add Button functionality
        function tabWrapper:AddButton(buttonConfig)
            local button = tab:CreateButton({
                Name = buttonConfig.Name,
                Callback = buttonConfig.Callback,
            })
            return button
        end

        -- Add Toggle functionality
        function tabWrapper:AddToggle(toggleConfig)
            local toggle = tab:CreateToggle({
                Name = toggleConfig.Name,
                CurrentValue = toggleConfig.Default or false,
                Callback = toggleConfig.Callback
            })
            return toggle
        end

        -- Add ColorPicker functionality
        function tabWrapper:AddColorpicker(colorConfig)
            local colorPicker = tab:CreateColorpicker({
                Name = colorConfig.Name,
                Default = colorConfig.Default or Color3.fromRGB(255, 255, 255),
                Callback = colorConfig.Callback
            })
            return colorPicker
        end

        -- Add Slider functionality
        function tabWrapper:AddSlider(sliderConfig)
            local slider = tab:CreateSlider({
                Name = sliderConfig.Name,
                Range = {sliderConfig.Min or 0, sliderConfig.Max or 100},
                Increment = sliderConfig.Increment or 1,
                Suffix = sliderConfig.ValueName or "",
                CurrentValue = sliderConfig.Default or 50,
                Callback = sliderConfig.Callback
            })
            return slider
        end

        -- Add Input functionality
        function tabWrapper:AddTextbox(textboxConfig)
            local textbox = tab:CreateInput({
                Name = textboxConfig.Name,
                PlaceholderText = textboxConfig.Default or "Enter something...",
                RemoveTextAfterFocusLost = textboxConfig.TextDisappear or false,
                Callback = textboxConfig.Callback
            })
            return textbox
        end

        -- Add Dropdown functionality
        function tabWrapper:AddDropdown(dropdownConfig)
            local dropdown = tab:CreateDropdown({
                Name = dropdownConfig.Name,
                Options = dropdownConfig.Options or {},
                CurrentOption = dropdownConfig.Default or "",
                MultipleOptions = dropdownConfig.MultipleOptions or false,
                Callback = dropdownConfig.Callback
            })
            return dropdown
        end

        -- Add Keybind functionality
        function tabWrapper:AddBind(bindConfig)
            local keybind = tab:CreateKeybind({
                Name = bindConfig.Name,
                CurrentKeybind = bindConfig.Default or Enum.KeyCode.E,
                HoldToInteract = bindConfig.Hold or false,
                Callback = bindConfig.Callback
            })
            return keybind
        end

        -- Add Label functionality
        function tabWrapper:AddLabel(labelName)
            local label = tab:CreateLabel(labelName)
            return label
        end

        -- Add Paragraph functionality
        function tabWrapper:AddParagraph(paragraphConfig)
            local paragraph = tab:CreateParagraph({
                Title = paragraphConfig.Title or "Title",
                Content = paragraphConfig.Content or "Content"
            })
            return paragraph
        end

        return tabWrapper
    end

    return windowWrapper
end

LibWrapper.AddWindow = LibWrapper.MakeWindow

return LibWrapper
