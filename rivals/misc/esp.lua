-- open src > enjoy!  esp.lua

--// Variables
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera
local cache = {}

local bones = {
    {"Head", "UpperTorso"},
    {"UpperTorso", "RightUpperArm"},
    {"RightUpperArm", "RightLowerArm"},
    {"RightLowerArm", "RightHand"},
    {"UpperTorso", "LeftUpperArm"},
    {"LeftUpperArm", "LeftLowerArm"},
    {"LeftLowerArm", "LeftHand"},
    {"UpperTorso", "LowerTorso"},
    {"LowerTorso", "LeftUpperLeg"},
    {"LeftUpperLeg", "LeftLowerLeg"},
    {"LeftLowerLeg", "LeftFoot"},
    {"LowerTorso", "RightUpperLeg"},
    {"RightUpperLeg", "RightLowerLeg"},
    {"RightLowerLeg", "RightFoot"}
}

--// Settings
local ESP_SETTINGS = {
    BoxOutlineColor = Color3.new(0, 0, 0),
    BoxColor = Color3.new(1, 1, 1),
    NameColor = Color3.new(1, 1, 1),
    HealthOutlineColor = Color3.new(0, 0, 0),
    HealthHighColor = Color3.new(0, 1, 0),
    HealthLowColor = Color3.new(1, 0, 0),
    CharSize = Vector2.new(4, 6),
    Teamcheck = false,
    WallCheck = false,
    Enabled = false,
    ShowBox = false,
    BoxType = "2D",
    ShowName = false,
    ShowHealth = false,
    ShowDistance = false,
    ShowSkeletons = false,
    ShowTracer = false,
    TracerColor = Color3.new(1, 1, 1), 
    TracerThickness = 2,
    SkeletonsColor = Color3.new(1, 1, 1),
    TracerPosition = "Bottom",
}

local function create(class, properties)
    local drawing = Drawing.new(class)
    for property, value in pairs(properties) do
        drawing[property] = value
    end
    return drawing
end

local function cleanupEspElements(esp)
    -- Clean up box lines
    for _, line in ipairs(esp.boxLines or {}) do
        if typeof(line) == "table" and line.Remove then
            line:Remove()
        end
    end
    esp.boxLines = {}

    -- Clean up skeleton lines
    for _, lineData in ipairs(esp.skeletonlines or {}) do
        if typeof(lineData) == "table" and lineData[1] and lineData[1].Remove then
            lineData[1]:Remove()
        end
    end
    esp.skeletonlines = {}
    
    -- Hide all drawings
    for key, drawing in pairs(esp) do
        if typeof(drawing) == "table" and drawing.Visible ~= nil then
            drawing.Visible = false
        end
    end
end

local function createEsp(player)
    local esp = {
        boxOutline = create("Square", {
            Color = ESP_SETTINGS.BoxOutlineColor,
            Thickness = 3,
            Filled = false,
            Visible = false
        }),
        box = create("Square", {
            Color = ESP_SETTINGS.BoxColor,
            Thickness = 1,
            Filled = false,
            Visible = false
        }),
        name = create("Text", {
            Color = ESP_SETTINGS.NameColor,
            Outline = true,
            Center = true,
            Size = 13,
            Visible = false
        }),
        healthOutline = create("Line", {
            Thickness = 3,
            Color = ESP_SETTINGS.HealthOutlineColor,
            Visible = false
        }),
        health = create("Line", {
            Thickness = 1,
            Visible = false
        }),
        distance = create("Text", {
            Color = Color3.new(1, 1, 1),
            Size = 12,
            Outline = true,
            Center = true,
            Visible = false
        }),
        tracer = create("Line", {
            Thickness = ESP_SETTINGS.TracerThickness,
            Color = ESP_SETTINGS.TracerColor,
            Transparency = 1,
            Visible = false
        }),
        boxLines = {},
        skeletonlines = {}
    }

    cache[player] = esp
    return esp
end

local function isPlayerBehindWall(player)
    local character = player.Character
    if not character then
        return false
    end

    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then
        return false
    end

    local ray = Ray.new(camera.CFrame.Position, (rootPart.Position - camera.CFrame.Position).Unit * (rootPart.Position - camera.CFrame.Position).Magnitude)
    local hit, position = workspace:FindPartOnRayWithIgnoreList(ray, {localPlayer.Character, character})
    
    return hit and hit:IsA("Part")
end

local function removeEsp(player)
    local esp = cache[player]
    if not esp then return end

    cleanupEspElements(esp)
    
    -- Remove all drawing objects
    for key, drawing in pairs(esp) do
        if typeof(drawing) == "table" and drawing.Remove then
            drawing:Remove()
        end
    end

    cache[player] = nil
end

local function createCornerBoxLines(esp, boxPosition, boxSize)
    -- Clear existing box lines
    for _, line in ipairs(esp.boxLines) do
        if line.Remove then
            line:Remove()
        end
    end
    esp.boxLines = {}
    
    local lineW = (boxSize.X / 5)
    local lineH = (boxSize.Y / 6)
    local lineT = 1

    -- Create 16 lines for corner box
    for i = 1, 16 do
        local boxLine = create("Line", {
            Thickness = i <= 8 and 1 or 2,
            Color = i <= 8 and ESP_SETTINGS.BoxColor or ESP_SETTINGS.BoxOutlineColor,
            Transparency = 1,
            Visible = true
        })
        esp.boxLines[i] = boxLine
    end

    local boxLines = esp.boxLines

    -- top left
    boxLines[1].From = Vector2.new(boxPosition.X - lineT, boxPosition.Y - lineT)
    boxLines[1].To = Vector2.new(boxPosition.X + lineW, boxPosition.Y - lineT)

    boxLines[2].From = Vector2.new(boxPosition.X - lineT, boxPosition.Y - lineT)
    boxLines[2].To = Vector2.new(boxPosition.X - lineT, boxPosition.Y + lineH)

    -- top right
    boxLines[3].From = Vector2.new(boxPosition.X + boxSize.X - lineW, boxPosition.Y - lineT)
    boxLines[3].To = Vector2.new(boxPosition.X + boxSize.X + lineT, boxPosition.Y - lineT)

    boxLines[4].From = Vector2.new(boxPosition.X + boxSize.X + lineT, boxPosition.Y - lineT)
    boxLines[4].To = Vector2.new(boxPosition.X + boxSize.X + lineT, boxPosition.Y + lineH)

    -- bottom left
    boxLines[5].From = Vector2.new(boxPosition.X - lineT, boxPosition.Y + boxSize.Y - lineH)
    boxLines[5].To = Vector2.new(boxPosition.X - lineT, boxPosition.Y + boxSize.Y + lineT)

    boxLines[6].From = Vector2.new(boxPosition.X - lineT, boxPosition.Y + boxSize.Y + lineT)
    boxLines[6].To = Vector2.new(boxPosition.X + lineW, boxPosition.Y + boxSize.Y + lineT)

    -- bottom right
    boxLines[7].From = Vector2.new(boxPosition.X + boxSize.X - lineW, boxPosition.Y + boxSize.Y + lineT)
    boxLines[7].To = Vector2.new(boxPosition.X + boxSize.X + lineT, boxPosition.Y + boxSize.Y + lineT)

    boxLines[8].From = Vector2.new(boxPosition.X + boxSize.X + lineT, boxPosition.Y + boxSize.Y - lineH)
    boxLines[8].To = Vector2.new(boxPosition.X + boxSize.X + lineT, boxPosition.Y + boxSize.Y + lineT)

    -- inline
    boxLines[9].From = Vector2.new(boxPosition.X, boxPosition.Y)
    boxLines[9].To = Vector2.new(boxPosition.X, boxPosition.Y + lineH)

    boxLines[10].From = Vector2.new(boxPosition.X, boxPosition.Y)
    boxLines[10].To = Vector2.new(boxPosition.X + lineW, boxPosition.Y)

    boxLines[11].From = Vector2.new(boxPosition.X + boxSize.X - lineW, boxPosition.Y)
    boxLines[11].To = Vector2.new(boxPosition.X + boxSize.X, boxPosition.Y)

    boxLines[12].From = Vector2.new(boxPosition.X + boxSize.X, boxPosition.Y)
    boxLines[12].To = Vector2.new(boxPosition.X + boxSize.X, boxPosition.Y + lineH)

    boxLines[13].From = Vector2.new(boxPosition.X, boxPosition.Y + boxSize.Y - lineH)
    boxLines[13].To = Vector2.new(boxPosition.X, boxPosition.Y + boxSize.Y)

    boxLines[14].From = Vector2.new(boxPosition.X, boxPosition.Y + boxSize.Y)
    boxLines[14].To = Vector2.new(boxPosition.X + lineW, boxPosition.Y + boxSize.Y)

    boxLines[15].From = Vector2.new(boxPosition.X + boxSize.X - lineW, boxPosition.Y + boxSize.Y)
    boxLines[15].To = Vector2.new(boxPosition.X + boxSize.X, boxPosition.Y + boxSize.Y)

    boxLines[16].From = Vector2.new(boxPosition.X + boxSize.X, boxPosition.Y + boxSize.Y - lineH)
    boxLines[16].To = Vector2.new(boxPosition.X + boxSize.X, boxPosition.Y + boxSize.Y)
end

local function updateSkeletonLines(esp, player)
    -- Clean up existing skeleton lines
    for _, lineData in ipairs(esp.skeletonlines) do
        if lineData[1] and lineData[1].Remove then
            lineData[1]:Remove()
        end
    end
    esp.skeletonlines = {}
    
    -- Create new skeleton lines if needed
    if ESP_SETTINGS.ShowSkeletons and ESP_SETTINGS.Enabled and player.Character then
        for _, bonePair in ipairs(bones) do
            local parentBone, childBone = bonePair[1], bonePair[2]
            
            if player.Character:FindFirstChild(parentBone) and player.Character:FindFirstChild(childBone) then
                local skeletonLine = create("Line", {
                    Thickness = 2,
                    Color = ESP_SETTINGS.SkeletonsColor,
                    Transparency = 1,
                    Visible = true
                })
                table.insert(esp.skeletonlines, {skeletonLine, parentBone, childBone})
            end
        end
    end
end

local function updateSkeletonPositions(esp, player)
    for _, lineData in ipairs(esp.skeletonlines) do
        local skeletonLine, parentBone, childBone = lineData[1], lineData[2], lineData[3]
        
        if player.Character and 
           player.Character:FindFirstChild(parentBone) and 
           player.Character:FindFirstChild(childBone) then
            
            local parentPosition = camera:WorldToViewportPoint(player.Character[parentBone].Position)
            local childPosition = camera:WorldToViewportPoint(player.Character[childBone].Position)
            
            if parentPosition.Z > 0 and childPosition.Z > 0 then
                skeletonLine.From = Vector2.new(parentPosition.X, parentPosition.Y)
                skeletonLine.To = Vector2.new(childPosition.X, childPosition.Y)
                skeletonLine.Color = ESP_SETTINGS.SkeletonsColor
                skeletonLine.Visible = true
            else
                skeletonLine.Visible = false
            end
        else
            skeletonLine.Visible = false
        end
    end
end

local function updateEsp()
    for player, esp in pairs(cache) do
        local character = player.Character
        local team = player.Team
        
        -- Skip if player is on same team and teamcheck is enabled
        if ESP_SETTINGS.Teamcheck and team and team == localPlayer.Team then
            cleanupEspElements(esp)
            continue
        end
        
        if not character or not ESP_SETTINGS.Enabled then
            cleanupEspElements(esp)
            continue
        end
        
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        local head = character:FindFirstChild("Head")
        local humanoid = character:FindFirstChild("Humanoid")
        
        if not (rootPart and head and humanoid) then
            cleanupEspElements(esp)
            continue
        end
        
        -- Check if behind wall
        if ESP_SETTINGS.WallCheck and isPlayerBehindWall(player) then
            cleanupEspElements(esp)
            continue
        end
        
        local position, onScreen = camera:WorldToViewportPoint(rootPart.Position)
        
        if not onScreen then
            cleanupEspElements(esp)
            continue
        end
        
        -- Calculate ESP dimensions
        local charSize = (camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, 3, 0)).Y - 
                          camera:WorldToViewportPoint(rootPart.Position + Vector3.new(0, 2.6, 0)).Y) / 2
        local boxSize = Vector2.new(math.floor(charSize * 1.8), math.floor(charSize * 1.9))
        local boxPosition = Vector2.new(math.floor(position.X - charSize * 1.8 / 2), 
                                       math.floor(position.Y - charSize * 1.6 / 2))
        
        -- Update name ESP
        if ESP_SETTINGS.ShowName then
            esp.name.Text = string.lower(player.Name)
            esp.name.Position = Vector2.new(boxSize.X / 2 + boxPosition.X, boxPosition.Y - 16)
            esp.name.Color = ESP_SETTINGS.NameColor
            esp.name.Visible = true
        else
            esp.name.Visible = false
        end
        
        -- Update box ESP
        if ESP_SETTINGS.ShowBox then
            if ESP_SETTINGS.BoxType == "2D" then
                esp.boxOutline.Size = boxSize
                esp.boxOutline.Position = boxPosition
                esp.boxOutline.Color = ESP_SETTINGS.BoxOutlineColor
                esp.box.Size = boxSize
                esp.box.Position = boxPosition
                esp.box.Color = ESP_SETTINGS.BoxColor
                
                esp.box.Visible = true
                esp.boxOutline.Visible = true
                
                -- Clean up corner box lines if they exist
                for _, line in ipairs(esp.boxLines) do
                    if line.Remove then
                        line:Remove()
                    end
                end
                esp.boxLines = {}
                
            elseif ESP_SETTINGS.BoxType == "Corner Box Esp" then
                createCornerBoxLines(esp, boxPosition, boxSize)
                esp.box.Visible = false
                esp.boxOutline.Visible = false
            end
        else
            esp.box.Visible = false
            esp.boxOutline.Visible = false
            
            for _, line in ipairs(esp.boxLines) do
                if line.Remove then
                    line:Remove()
                end
            end
            esp.boxLines = {}
        end
        
        -- Update health ESP
        if ESP_SETTINGS.ShowHealth and humanoid then
            local healthPercentage = humanoid.Health / humanoid.MaxHealth
            
            esp.healthOutline.From = Vector2.new(boxPosition.X - 6, boxPosition.Y + boxSize.Y)
            esp.healthOutline.To = Vector2.new(esp.healthOutline.From.X, esp.healthOutline.From.Y - boxSize.Y)
            
            esp.health.From = Vector2.new(boxPosition.X - 5, boxPosition.Y + boxSize.Y)
            esp.health.To = Vector2.new(esp.health.From.X, esp.health.From.Y - healthPercentage * boxSize.Y)
            esp.health.Color = ESP_SETTINGS.HealthLowColor:Lerp(ESP_SETTINGS.HealthHighColor, healthPercentage)
            
            esp.healthOutline.Visible = true
            esp.health.Visible = true
        else
            esp.healthOutline.Visible = false
            esp.health.Visible = false
        end
        
        -- Update distance ESP
        if ESP_SETTINGS.ShowDistance then
            local distance = (camera.CFrame.p - rootPart.Position).Magnitude
            esp.distance.Text = string.format("%.1f studs", distance)
            esp.distance.Position = Vector2.new(boxPosition.X + boxSize.X / 2, boxPosition.Y + boxSize.Y + 5)
            esp.distance.Visible = true
        else
            esp.distance.Visible = false
        end
        
        -- Update skeleton ESP
        if ESP_SETTINGS.ShowSkeletons then
            if #esp.skeletonlines == 0 then
                updateSkeletonLines(esp, player)
            end
            updateSkeletonPositions(esp, player)
        else
            for _, lineData in ipairs(esp.skeletonlines) do
                if lineData[1] and lineData[1].Remove then
                    lineData[1].Visible = false
                end
            end
        end
        
        -- Update tracer ESP
        if ESP_SETTINGS.ShowTracer then
            local tracerY
            if ESP_SETTINGS.TracerPosition == "Top" then
                tracerY = 0
            elseif ESP_SETTINGS.TracerPosition == "Middle" then
                tracerY = camera.ViewportSize.Y / 2
            else
                tracerY = camera.ViewportSize.Y
            end
            
            esp.tracer.From = Vector2.new(camera.ViewportSize.X / 2, tracerY)
            esp.tracer.To = Vector2.new(position.X, position.Y)
            esp.tracer.Color = ESP_SETTINGS.TracerColor
            esp.tracer.Thickness = ESP_SETTINGS.TracerThickness
            esp.tracer.Visible = true
        else
            esp.tracer.Visible = false
        end
    end
end

-- Initialize ESP for existing players
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= localPlayer then
        createEsp(player)
    end
end

-- Add ESP for new players
Players.PlayerAdded:Connect(function(player)
    if player ~= localPlayer then
        createEsp(player)
    end
end)

-- Remove ESP for players who leave
Players.PlayerRemoving:Connect(function(player)
    removeEsp(player)
end)

-- Update ESP on each frame
RunService.RenderStepped:Connect(updateEsp)

return ESP_SETTINGS
