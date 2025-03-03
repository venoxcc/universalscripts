local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local OrionLib = {}

-- CreateWindow function, returning a window wrapper
function OrionLib:CreateWindow(config)
    -- Create the window using Rayfield's CreateWindow function
    local windowConfig = {
        Name = config.Name or "Default Name",
        DisableRayfieldPrompts = false,
        DisableBuildWarnings = false,
        SaveConfig = config.SaveConfig or false,
        ConfigurationSaving = {
            Enabled = true,
            FolderName = nil, 
            FileName = config.ConfigFolder or "DefaultFolder",
        },
        LoadingTitle = config.IntroText or "",
        Icon = 0,
        KeySystem = false,
    }
    local window = Rayfield:CreateWindow(windowConfig)

    -- Window wrapper object to handle method chaining
    local windowWrapper = {}

    -- Adding methods to the windowWrapper to allow chaining
    function windowWrapper:CreateTab(tabConfig)
        local tab = window:CreateTab(tabConfig.Name)
        
        -- Tab wrapper to allow for chained method calls
        local tabWrapper = {}

        function tabWrapper:CreateButton(name, callback)
            local button = tab:CreateButton({
                Name = name,
                Callback = callback
            })
            local buttonWrapper = {}
            function buttonWrapper:Set(name)
                button:Set(name)
            end
            return buttonWrapper
        end
        tabWrapper.AddButton = tabWrapper.CreateButton

        function tabWrapper:CreateSection(name)
            local section = tab:CreateSection(name)
            local sectionWrapper = {}
            function sectionWrapper:Set(name)
                section:Set(name)
            end
            return sectionWrapper
        end
        tabWrapper.AddSection = tabWrapper.CreateSection

        function tabWrapper:CreateToggle(name, currentValue, callback)
            local toggle = tab:CreateToggle({
                Name = name,
                CurrentValue = currentValue,
                Callback = callback
            })
            local toggleWrapper = {}
            function toggleWrapper:Set(value)
                toggle:Set(value)
            end
            return toggleWrapper
        end
        tabWrapper.AddToggle = tabWrapper.CreateToggle

        function tabWrapper:CreateColorpicker(name, color, callback)
            local colorPicker = tab:CreateColorpicker({
                Name = name,
                Default = color or Color3.fromRGB(255, 255, 255),
                Callback = callback
            })
            local colorPickerWrapper = {}
            function colorPickerWrapper:Set(color)
                colorPicker:Set(color)
            end
            return colorPickerWrapper
        end
        tabWrapper.AddColorpicker = tabWrapper.CreateColorpicker

        function tabWrapper:CreateSlider(name, range, increment, suffix, currentValue, callback)
            local slider = tab:CreateSlider({
                Name = name,
                Range = range,
                Increment = increment,
                Suffix = suffix,
                CurrentValue = currentValue,
                Callback = callback
            })
            local sliderWrapper = {}
            function sliderWrapper:Set(value)
                slider:Set(value)
            end
            return sliderWrapper
        end
        tabWrapper.AddSlider = tabWrapper.CreateSlider

        function tabWrapper:CreateInput(name, placeholderText, removeTextAfterFocusLost, callback)
            local input = tab:CreateInput({
                Name = name,
                PlaceholderText = placeholderText,
                RemoveTextAfterFocusLost = removeTextAfterFocusLost,
                Callback = callback
            })
            return input
        end
        tabWrapper.AddInput = tabWrapper.CreateInput

        function tabWrapper:CreateDropdown(name, options, currentOption, multipleOptions, callback)
            local dropdown = tab:CreateDropdown({
                Name = name,
                Options = options,
                CurrentOption = currentOption,
                MultipleOptions = multipleOptions,
                Callback = callback
            })
            local dropdownWrapper = {}
            function dropdownWrapper:Set(options)
                dropdown:Set(options)
            end
            return dropdownWrapper
        end
        tabWrapper.AddDropdown = tabWrapper.CreateDropdown

        function tabWrapper:CreateKeybind(name, currentKeybind, holdToInteract, callback)
            local keybind = tab:CreateKeybind({
                Name = name,
                CurrentKeybind = currentKeybind,
                HoldToInteract = holdToInteract,
                Callback = callback
            })
            local keybindWrapper = {}
            function keybindWrapper:Set(keybind)
                keybind:Set(keybind)
            end
            return keybindWrapper
        end
        tabWrapper.AddKeybind = tabWrapper.CreateKeybind

        function tabWrapper:CreateLabel(name)
            local label = tab:CreateLabel(name)
            local labelWrapper = {}
            function labelWrapper:Set(name)
                label:Set(name)
            end
            return labelWrapper
        end
        tabWrapper.AddLabel = tabWrapper.CreateLabel

        function tabWrapper:CreateParagraph(title, content)
            local paragraph = tab:CreateParagraph({
                Title = title,
                Content = content
            })
            local paragraphWrapper = {}
            function paragraphWrapper:Set(title, content)
                paragraph:Set({Title = title, Content = content})
            end
            return paragraphWrapper
        end
        tabWrapper.AddParagraph = tabWrapper.CreateParagraph

        return tabWrapper
    end
    windowWrapper.AddTab = windowWrapper.CreateTab

    -- You can chain method calls
    return windowWrapper
end

OrionLib.AddWindow = OrionLib.CreateWindow
OrionLib.Load = OrionLib.CreateWindow

return OrionLib
