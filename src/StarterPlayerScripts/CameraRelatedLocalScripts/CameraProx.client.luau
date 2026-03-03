--!strict
local CameraProxPart = workspace:WaitForChild("ProxCameraPart") :: Part
local CameraProx = CameraProxPart:WaitForChild("CameraProx") :: ProximityPrompt
local Player = game:GetService("Players").LocalPlayer :: Player
local Character = Player.Character or Player.CharacterAdded:Wait() :: Model
local Humanoid = Character:WaitForChild("Humanoid") :: Humanoid 
local PlayerGui = Player.PlayerGui
local CameraGui = PlayerGui:WaitForChild("CameraGui") :: ScreenGui

CameraProx.Triggered:Connect(function()  
    CameraGui.Enabled = true
    Humanoid.WalkSpeed = 0
    Humanoid.JumpHeight = 0 
    CameraProx.Enabled = false
end)