local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,150,0,60)
frame.Position = UDim2.new(0.1,0,0.2,0)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local button = Instance.new("TextButton")
button.Size = UDim2.new(1,0,1,0)
button.Text = "Fly: OFF"
button.Parent = frame

local flying = false
local bv

button.MouseButton1Click:Connect(function()
	local char = player.Character or player.CharacterAdded:Wait()
	local hrp = char:WaitForChild("HumanoidRootPart")

	if not flying then
		flying = true
		button.Text = "Fly: ON"

		bv = Instance.new("BodyVelocity")
		bv.MaxForce = Vector3.new(1e5,1e5,1e5)
		bv.Parent = hrp

		RunService:BindToRenderStep("Fly", Enum.RenderPriority.Character.Value, function()
			local move = Vector3.zero

			if UIS:IsKeyDown(Enum.KeyCode.W) then move += workspace.CurrentCamera.CFrame.LookVector end
			if UIS:IsKeyDown(Enum.KeyCode.S) then move -= workspace.CurrentCamera.CFrame.LookVector end
			if UIS:IsKeyDown(Enum.KeyCode.A) then move -= workspace.CurrentCamera.CFrame.RightVector end
			if UIS:IsKeyDown(Enum.KeyCode.D) then move += workspace.CurrentCamera.CFrame.RightVector end

			if bv then
				bv.Velocity = move * 50
			end
		end)
	else
		flying = false
		button.Text = "Fly: OFF"

		RunService:UnbindFromRenderStep("Fly")

		if bv then
			bv:Destroy()
			bv = nil
		end
	end
end)
