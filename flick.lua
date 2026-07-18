local cam = workspace.CurrentCamera
local power = 120
local delay = 0.0001

-- Biến kiểm tra trạng thái
_G.FlickEnabled = false 

-- Tạo giao diện nút bấm trên điện thoại
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")

ScreenGui.Parent = game:GetService("CoreGui")
ToggleButton.Parent = ScreenGui

-- Chỉnh giao diện nút
ToggleButton.Size = UDim2.new(0, 100, 0, 50)
ToggleButton.Position = UDim2.new(0.5, -50, 0.1, 0) -- Nằm ở giữa phía trên màn hình
ToggleButton.Text = "Flick: OFF"
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Màu đỏ khi tắt
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Draggable = true -- Bạn có thể kéo nút này đi chỗ khác cho đỡ vướng

-- Hàm xử lý xoay cam
local function startFlick()
    while _G.FlickEnabled do
        cam.CFrame = cam.CFrame * CFrame.Angles(0, math.rad(power), 0)
        task.wait(delay)
        cam.CFrame = cam.CFrame * CFrame.Angles(0, math.rad(-power), 0)
        task.wait(delay)
    end
end

-- Xử lý khi chạm vào nút
ToggleButton.MouseButton1Click:Connect(function()
    _G.FlickEnabled = not _G.FlickEnabled
    
    if _G.FlickEnabled then
        ToggleButton.Text = "Flick: ON"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Đổi sang màu xanh khi bật
        task.spawn(startFlick)
    else
        ToggleButton.Text = "Flick: OFF"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Đổi về màu đỏ khi tắt
    end
end)
