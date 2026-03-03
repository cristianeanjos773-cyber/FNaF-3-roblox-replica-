--!strict 
local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local MyCoins = DataStoreService:GetDataStore("MyCoins")

local function GetData(Player: Player)
     local leaderstats = Player:FindFirstChild("leaderstats") :: Folder
     local Coins = leaderstats:FindFirstChild("Coins") :: IntValue

     local Success, Data = pcall(function()  
         return MyCoins:GetAsync(tostring(Player.UserId))
    end)

    if not Success then 
        Coins.Value = 0
        return 
    end
    
    Coins.Value = Data 

end 

local function SaveData(Player: Player)
     local leaderstats = Player:FindFirstChild("leaderstats") :: Folder
     local Coins = leaderstats:FindFirstChild("Coins") :: IntValue

     local Success, Err = pcall(function()  
        return MyCoins:SetAsync(tostring(Player.UserId), Coins.Value)
     end)

    if not Success then 
        warn(Err)
    else
        warn("Success!")
    end

end

local function WatchPlayersJumping()
    local HumanoidArray = {}
    
    for _, player in Players:GetPlayers() do
        task.spawn(function()
             local Character = player.Character or player.CharacterAdded:Wait() :: Model
             local Humanoid = Character:FindFirstChild("Humanoid") :: Humanoid
            table.insert(HumanoidArray, Humanoid)
        end)
    end

    for _, Humanoids: Humanoid in HumanoidArray do  
        local Character = Humanoids.Parent :: Model 
        local Player = Players:GetPlayerFromCharacter(Character) :: Player

        Humanoids:GetPropertyChangedSignal("Jump"):Connect(function() 
            local leaderstats = Player:FindFirstChild("leaderstats") :: Folder
            local Coins = leaderstats:FindFirstChild("Coins") :: IntValue
            Coins.Value = Coins.Value + 50 
       end)
    end 

end

Players.PlayerAdded:Connect(function(Player: Player)  
     local leaderstats = Instance.new("Folder")
     local Coins = Instance.new("IntValue")
 
     leaderstats.Name = "leaderstats"
     Coins.Name = "Coins"
     leaderstats.Parent = Player
     Coins.Parent = leaderstats
     GetData(Player)
     WatchPlayersJumping()
     
end)


Players.PlayerRemoving:Connect(function(Player: Player)  
    SaveData(Player)
end)

game:BindToClose(function() 
    for _, player in ipairs(Players:GetPlayers()) do
        SaveData(player)
    end
end)