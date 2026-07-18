local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleButton.Position = UDim2.new(0.05, 0, 0.4, 0)
ToggleButton.Size = UDim2.new(0, 100, 0, 50)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Text = "Fly: OFF"
ToggleButton.TextColor3 = Color3.fromRGB(255, 0, 0)
ToggleButton.TextSize = 20.000

UICorner.Parent = ToggleButton

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local camera = workspace.CurrentCamera

local flying = false
local speed = 50
local bv, bg

local function startFlying()
    bv = Instance.new("BodyVelocity")
    bv.maxForce = Vector3.new(1e5, 1e5, 1e5)
    bv.velocity = Vector3.new(0, 0, 0)
    bv.Parent = humanoidRootPart

    bg = Instance.new("BodyGyro")
    bg.maxTorque = Vector3.new(1e5, 1e5, 1e5)
    bg.cframe = humanoidRootPart.CFrame
    bg.Parent = humanoidRootPart

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then humanoid.PlatformStand = true end

    task.spawn(function()
        while flying and task.wait() do
            local moveDirection = Vector3.new(0, 0, 0)
            local lookVector = camera.CFrame.LookVector
            local rightVector = camera.CFrame.RightVector

            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
                moveDirection = moveDirection + lookVector
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
                moveDirection = moveDirection - lookVector
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
                moveDirection = moveDirection - rightVector
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
                moveDirection = moveDirection + rightVector
            end

            -- Fallback for mobile movement direction
            if moveDirection.Magnitude == 0 and humanoid then
                moveDirection = humanoid.MoveDirection
            end

            bv.velocity = moveDirection * speed
            bg.cframe = camera.CFrame
        end
    end)
end

local function stopFlying()
    if bv then bv:Destroy() end
    if bg then bg:Destroy() end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then humanoid.PlatformStand = false end
end

ToggleButton.MouseButton1Click:Connect(function()
    flying = not flying
    if flying then
        ToggleButton.Text = "Fly: ON"
        ToggleButton.TextColor3 = Color3.fromRGB(0, 255, 0)
        startFlying()
    else
        ToggleButton.Text = "Fly: OFF"
        ToggleButton.TextColor3 = Color3.fromRGB(255, 0, 0)
        stopFlying()
    end
end)

player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    if flying then
        startFlying()
    end
end)
