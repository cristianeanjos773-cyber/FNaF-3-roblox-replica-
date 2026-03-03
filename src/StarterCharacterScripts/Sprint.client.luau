local UserInputService = game:GetService("UserInputService")
local Running_Speed = 32
local Normal_Speed = 16 
local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:FindFirstChild("Humanoid") :: Humanoid

UserInputService.InputBegan:Connect(function(Input: InputObject, GameProcessed: boolean)

    if GameProcessed then 
        return 
    end

    if Input.KeyCode == Enum.KeyCode.LeftShift then 
        Humanoid.WalkSpeed = Running_Speed
    end 
end)

UserInputService.InputEnded:Connect(function(Input: InputObject, GameProcessed: boolean)

    if GameProcessed then 
        return 
    end

    if Input.KeyCode == Enum.KeyCode.LeftShift then 
        Humanoid.WalkSpeed = Normal_Speed 
    end 
end)