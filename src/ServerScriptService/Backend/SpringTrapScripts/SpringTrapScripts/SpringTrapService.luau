local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CallToPlace = ReplicatedStorage.Remote_Events.CallToPlace :: RemoteEvent
local RunService = game:GetService("RunService")
local SpringTrapAIStates = require(script.Parent.SpringTrapAIStates)
local SpringTrapCharacter = workspace.SpringTrap :: Model
local SpringTrapHumanoid = SpringTrapCharacter.Humanoid :: Humanoid
local Night = workspace:GetAttribute("Night") :: number
local TimeAccumulator: number = 0 
local SpringTrapService = {}


SpringTrapService.Time_To_Move = 10 - (Night * 1.5 )
SpringTrapService.Next_Move = 0 
SpringTrapService.TIME_TO_TELEPORT = Night * 1.5 


function SpringTrapService.Move_To_Place_Called(CalledPart: Part) 
    CallToPlace.OnServerEvent:Connect(function()  
   
   end)
end

function SpringTrapService.Kill_Player() 
    
end 

SpringTrapService.CurrentPathIndex = 1 

function SpringTrapService.FollowPath()
    local PathFolder = workspace.SpringTrapPath :: Folder
    local PathFolderParts = PathFolder:GetChildren()
    
    SpringTrapAIStates.SetState("Walk")

    while SpringTrapService.CurrentPathIndex <= #PathFolderParts do
        local TargetPart = PathFolderParts[SpringTrapService.CurrentPathIndex]
        SpringTrapHumanoid:MoveTo(TargetPart.Position, TargetPart)
        
        SpringTrapHumanoid.MoveToFinished:Wait()
        SpringTrapService.CurrentPathIndex += 1
        
        local CurrentState = SpringTrapCharacter:GetAttribute("StateMachine")
        if CurrentState ~= SpringTrapAIStates.SpringTrapStates["Walk"] then
            break 
        end
    end

    if SpringTrapService.CurrentPathIndex > #PathFolderParts then
        SpringTrapService.CurrentPathIndex = math.random(1, #PathFolderParts)
    end
end 

function SpringTrapService.StartAI() 
     RunService.Heartbeat:Connect(function(Delta: number)  
         TimeAccumulator += Delta

         local CurrentState = SpringTrapCharacter:GetAttribute("StateMachine") :: number
    
         if TimeAccumulator >= SpringTrapService.Time_To_Move then 
            print(TimeAccumulator, SpringTrapService.Time_To_Move)
            TimeAccumulator = 0

            if CurrentState ~= SpringTrapAIStates["SpringTrapStates"]["Walk"] then 
               SpringTrapAIStates.SetState("Walk")
            end

         end 
         

         if CurrentState == SpringTrapAIStates["SpringTrapStates"]["Walk"] then 
            SpringTrapService.FollowPath()
         end 

    end)
end 

return SpringTrapService