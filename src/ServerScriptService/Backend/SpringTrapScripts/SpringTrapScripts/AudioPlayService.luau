local SpringTrapService = require(script.Parent.SpringTrapService)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CallToPlace = ReplicatedStorage.ReplicatedStorage.Remote_Events.CallToPlace :: RemoteEvent

local AudioPlayService = {}

function AudioPlayService.OnAudioPlayed() 
    CallToPlace.OnServerEvent:Connect(function(Player: Player, CameraBeingWatched: string)  
          SpringTrapService.Move_To_Place_Called(CameraBeingWatched)
    end)
end 

return AudioPlayService