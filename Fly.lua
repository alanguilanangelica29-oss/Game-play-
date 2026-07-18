local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "FlyGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,180,0,80)
frame.Position = UDim2.new(0.3,0,0.3,0)
frame.BackgroundColor3 = Color3.fromRGB(35,35,35)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local button = Instance.new("TextButton")
button.Size = UDim2.new(1,-10,1,-10)
button.Position = UDim2.new(0,5,0,5)
button.Text = "Fly: OFF"
button.Parent = frame

local flyEnabled = false

button.MouseButton1Click:Connect(function()
	flyEnabled = not flyEnabled
	button.Text = flyEnabled and "Fly: ON" or "Fly: OFF"

	if flyEnabled then
		print("Enable your own game's fly system here.")
	else
		print("Disable your own game's fly system here.")
	end
end)
