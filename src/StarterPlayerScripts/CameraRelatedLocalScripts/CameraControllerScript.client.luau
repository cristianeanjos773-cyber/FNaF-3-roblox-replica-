--!strict
-- agora sim vai ficar epico nescau!!!
-- tenho certeza que voce nem ta mais olhando

local Players = game:GetService("Players")
local Player = Players.LocalPlayer :: Player
local Character = Player.Character or Player.CharacterAdded:Wait() :: Model
local Humanoid = Character:WaitForChild("Humanoid") :: Humanoid 
local PlayerGui = Player.PlayerGui 
local CameraGui = PlayerGui:WaitForChild("CameraGui") :: ScreenGui
local CameraButtonsFolder = CameraGui:WaitForChild("CameraButtons") :: Folder
local CameraParts = workspace:WaitForChild("CameraParts") :: Folder
local CameraProx = workspace:WaitForChild("ProxCameraPart"):WaitForChild("CameraProx") :: ProximityPrompt
local PlayerCamera = workspace.CurrentCamera :: Camera

local CameraCFramesArr = {
   (CameraParts:WaitForChild("Cam1") :: Part).CFrame,
   (CameraParts:WaitForChild("Cam2") :: Part).CFrame,
   (CameraParts:WaitForChild("Cam3") :: Part).CFrame, 
   (CameraParts:WaitForChild("Cam4") :: Part).CFrame,
   (CameraParts:WaitForChild("Cam5") :: Part).CFrame, 
}

local Map_Cam_Button_To_CFrame = {
    ["Cam1"] = CameraCFramesArr[1],
    ["Cam2"] = CameraCFramesArr[2],
    ["Cam3"] = CameraCFramesArr[3],
    ["Cam4"] = CameraCFramesArr[4],
    ["Cam5"] = CameraCFramesArr[5],  
}

local function _ManageCamera()
    for _, Buttons in CameraButtonsFolder:GetChildren() do 
        local Button = Buttons :: GuiButton
        Button.Activated:Connect(function() 
             PlayerCamera.CameraType = Enum.CameraType.Scriptable 
             PlayerCamera.CFrame = Map_Cam_Button_To_CFrame[Button.Name] 
             print(Button.Name, PlayerCamera.CFrame)
        end) 
    end
end

local LeaveButton = CameraGui:WaitForChild("Leave") :: TextButton

LeaveButton.Activated:Connect(function()  
     CameraProx.Enabled = true 
     CameraGui.Enabled = false 
     Humanoid.WalkSpeed = 16
     Humanoid.JumpHeight = 7.2
     PlayerCamera.CameraType = Enum.CameraType.Custom
end)

_ManageCamera()