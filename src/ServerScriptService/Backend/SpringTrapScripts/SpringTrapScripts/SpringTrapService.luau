local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SpringTrapAIStates = require(script.Parent.SpringTrapAIStates)
local SpringTrapCharacter = workspace.SpringTrap :: Model
local SpringTrapHumanoid = SpringTrapCharacter.Humanoid :: Humanoid
local Night = workspace:GetAttribute("Night") :: number
local TimeAccumulator: number = 0 
local SpringTrapService = {}


SpringTrapService.Time_To_Move = Night * 0.4 
SpringTrapService.Next_Move = 0 


function SpringTrapService.MoveToPlaceCalled(CalledPart: Part) 
    
end

function SpringTrapService.KillPlayer() 
    
end 

function SpringTrapService.FollowPath()
   local PathFolder = workspace.SpringTrapPath :: Folder
   local PathFolderParts = PathFolder:GetChildren()
   local PartToMoveIndex = 1
   SpringTrapHumanoid:MoveTo(PathFolderParts[PartToMoveIndex])

   SpringTrapHumanoid.MoveToFinished:Connect(function()  
       PartToMoveIndex += 1
       SpringTrapHumanoid:MoveTo(PathFolderParts[PartToMoveIndex])
   end)

end 

function SpringTrapService.StartAI() 
     RunService.Heartbeat:Connect(function(Delta: number)  
         TimeAccumulator += Delta

         if TimeAccumulator >= SpringTrapService.Time_To_Move then 
            TimeAccumulator = 0
            SpringTrapAIStates.SetState("Walk")
         end 
         
         local CurrentState = SpringTrapCharacter:GetAttribute("StateMachine") :: number

         if CurrentState == SpringTrapAIStates["SpringTrapStates"]["Walk"] then 
            SpringTrapService.FollowPath()
         end 

    end)
end 

return SpringTrapService