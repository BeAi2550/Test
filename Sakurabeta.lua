--// Player & Services
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// Main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GalaxyToggleUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = playerGui

--// Galaxy Frame
local mainFrame = Instance.new("ImageLabel")
mainFrame.Name = "GalaxyPanel"
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
mainFrame.BackgroundTransparency = 1
mainFrame.Image = "rbxassetid://11223853964"
mainFrame.ScaleType = Enum.ScaleType.Crop
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = ScreenGui

--// Inner Panel
local innerFrame = Instance.new("Frame")
innerFrame.Size = UDim2.new(1, -20, 1, -20)
innerFrame.Position = UDim2.new(0, 10, 0, 10)
innerFrame.BackgroundColor3 = Color3.fromRGB(40, 0, 70)
innerFrame.BackgroundTransparency = 0.3
innerFrame.BorderSizePixel = 0
innerFrame.Parent = mainFrame

--// Close Button
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(180, 80, 80)
closeButton.Text = "✖"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.TextScaled = true
closeButton.Parent = mainFrame

--// Toggle Button (Mobile Friendly)
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 120, 0, 45)
toggleButton.Position = UDim2.new(0, 10, 1, -55)
toggleButton.BackgroundColor3 = Color3.fromRGB(180, 100, 255)
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.Text = "🌌 Toggle GUI"
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextScaled = true
toggleButton.AutoButtonColor = true
toggleButton.Parent = ScreenGui

--// Remote Setup
local args = {}
local ObtainOFA = ReplicatedStorage:WaitForChild("GlobalUsedRemotes", 9e9):WaitForChild("ObtainOFA", 9e9)

--// Toggle Function with Tween
local tweenInfo = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local function toggleGUI()
	if mainFrame.Visible then
		local tweenOut = TweenService:Create(mainFrame, tweenInfo, {Size = UDim2.new(0, 0, 0, 0)})
		tweenOut:Play()
		tweenOut.Completed:Wait()
		mainFrame.Visible = false
	else
		mainFrame.Visible = true
		mainFrame.Size = UDim2.new(0, 0, 0, 0)
		local tweenIn = TweenService:Create(mainFrame, tweenInfo, {Size = UDim2.new(0, 300, 0, 200)})
		tweenIn:Play()
		-- Fire remote on show
		ObtainOFA:FireServer(unpack(args))
	end
end

--// Connections
toggleButton.MouseButton1Click:Connect(toggleGUI)
closeButton.MouseButton1Click:Connect(toggleGUI)

--// Remote Trigger Button
local remoteButton = Instance.new("TextButton")
remoteButton.Size = UDim2.new(0, 140, 0, 40)
remoteButton.Position = UDim2.new(0.5, -70, 0.5, -20)
remoteButton.BackgroundColor3 = Color3.fromRGB(100, 50, 200)
remoteButton.TextColor3 = Color3.new(1, 1, 1)
remoteButton.Text = "🔥 Get OFA"
remoteButton.Font = Enum.Font.GothamBold
remoteButton.TextScaled = true
remoteButton.Parent = innerFrame

--// On click, fire the remote
remoteButton.MouseButton1Click:Connect(function()
	ObtainOFA:FireServer(unpack(args))
end)
