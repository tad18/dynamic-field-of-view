-- skid off it all i want idc 😭


-- @tad5 on discord

-- made by tad aka tero712

local FOVSettings = {
    ShowFOV = true,
    Radius = 200, 
    Color = Color3.fromRGB(255, 255, 255),
    Transparency = 0.5,
    Thickness = 1,
    Filled = false,
    Rainbow = true,
    SpacingFactor = 1.2, 
    DotRadius = 2,
    RotationSpeed = 1 
}


local ShowFOV = FOVSettings.ShowFOV
local Radius = FOVSettings.Radius
local Transparency = FOVSettings.Transparency
local Filled = FOVSettings.Filled
local Thickness = FOVSettings.Thickness
local Color = FOVSettings.Color
local Rainbow = FOVSettings.Rainbow
local SpacingFactor = FOVSettings.SpacingFactor
local DotRadius = FOVSettings.DotRadius
local RotationSpeed = FOVSettings.RotationSpeed

local NumCircles = 72 

local dwRunService = game:GetService("RunService")
local fovCircles = {} 


for i = 1, NumCircles do
    local fovCircle = Drawing.new("Circle")
    fovCircle.Visible = ShowFOV
    fovCircle.Thickness = Thickness
    fovCircle.Transparency = Transparency
    fovCircle.NumSides = 50 
    fovCircle.Color = Color
    fovCircle.Filled = Filled

    fovCircles[i] = fovCircle
end

-- Get the UserInputService
local userInputService = game:GetService("UserInputService")

-- Function to update the circle positions
local function updateCirclePositions()
    -- Get the mouse position
    local mousePosition = userInputService:GetMouseLocation()
    local centerX, centerY = mousePosition.X, mousePosition.Y
    
    -- Calculate angle between each small circle
    local angleStep = 2 * math.pi / NumCircles
    
    -- Calculate rotation angle based on time
    local rotationAngle = tick() * RotationSpeed
    
    -- Calculate positions of each small circle around the larger circle with spacing and rotation
    for i, fovCircle in ipairs(fovCircles) do
        local angle = i * angleStep * SpacingFactor + rotationAngle -- Add rotation angle
        local offsetX = Radius * math.cos(angle)
        local offsetY = Radius * math.sin(angle)
        
        -- Set position of the small circle
        fovCircle.Position = Vector2.new(centerX + offsetX, centerY + offsetY)
        fovCircle.Radius = DotRadius -- Adjust size of small circles
    end
end

-- Run the update function every frame
dwRunService.RenderStepped:Connect(updateCirclePositions)


if Rainbow then
    dwRunService.RenderStepped:Connect(function()
        local hue = tick() % 10 / 10
        local rainbow = Color3.fromHSV(hue, 1, 1)
        
        for _, fovCircle in ipairs(fovCircles) do
            fovCircle.Color = rainbow
        end
    end)
end
