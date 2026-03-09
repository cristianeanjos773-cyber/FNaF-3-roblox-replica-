--!strict
local RunService = game:GetService("RunService")
local SpringTrapAIStates = require(script.Parent.SpringTrapAIStates)
local SpringTrapCharacter = workspace.SpringTrap :: Model
local SpringTrapHumanoid = SpringTrapCharacter:FindFirstChild("Humanoid") :: Humanoid
local Night = workspace:GetAttribute("Night") :: number
local isMoving = false 
local TimeAccumulator: number = 0 
--local CameraParts = workspace.CameraParts :: Folder
local SpringTrapPath = workspace.SpringTrapPath

local SpringTrapService = {}


SpringTrapService.Time_To_Move = 10 - (Night * 1.5 )
SpringTrapService.Next_Move = 0 
SpringTrapService.TIME_TO_TELEPORT = Night * 1.5 

SpringTrapService.CamToPathMap = {
    ["Cam1"] = SpringTrapPath.Path1,
    ["Cam2"] = SpringTrapPath.Path2,
    ["Cam3"] = SpringTrapPath.Path3,
    ["Cam4"] = SpringTrapPath.Path4,
    ["Cam5"] = SpringTrapPath.Path5,
    ["Cam6"] = SpringTrapPath.Path6,
    ["Cam7"] = SpringTrapPath.Path7,
    ["Cam8"] = SpringTrapPath.Path8,
}


function SpringTrapService.Move_To_Place_Called(CameraBeingWatched: string) 
    SpringTrapAIStates.SetState("Idle") 
    task.wait(1)
    local CalledPart = SpringTrapService.CamToPathMap[CameraBeingWatched] :: BasePart
    SpringTrapCharacter:MoveTo(CalledPart.Position)

    --[[TODO:
    
    Criar um mapping de camera -> Path (A parte que o spring trap tem que andar.)
    Por exemplo:Camera1 -> Path1 

    ["Cam1"] = Workspace.Path1
    
    Usando o Par CameraBeingWatched como chave pra poder acessar a parte que o spring trap foi chamado. (A Called Part)

    ]]

end

function SpringTrapService.Kill_Player() 
    
end 

SpringTrapService.CurrentPathIndex = 1 

function SpringTrapService.FollowPath()
    local PathFolder = workspace.SpringTrapPath :: Folder
    local PathFolderParts = PathFolder:GetChildren()

    table.sort(PathFolderParts, function(Path1: Instance, Path2: Instance): boolean   
         local num0 = tonumber(string.match(Path1.Name, "%d+")) or 0
         local num1 = tonumber(string.match(Path2.Name, "%d+")) or 0
         return num0 < num1
    end)
    
    if SpringTrapService.CurrentPathIndex > #PathFolderParts then
        SpringTrapService.CurrentPathIndex = 1
    end

    local TargetPart = PathFolderParts[SpringTrapService.CurrentPathIndex] :: BasePart

    SpringTrapAIStates.SetState("Walk")
    SpringTrapHumanoid:MoveTo(TargetPart.Position, TargetPart)

    SpringTrapHumanoid.MoveToFinished:Wait()
    SpringTrapService.CurrentPathIndex += 1

    SpringTrapAIStates.SetState("Idle")

end


function SpringTrapService.StartAI() 
    RunService.Heartbeat:Connect(function(Delta: number)  
        if not isMoving then
            TimeAccumulator += Delta
        end

        if TimeAccumulator >= SpringTrapService.Time_To_Move and not isMoving then 
            TimeAccumulator = 0
            isMoving = true 
            
            task.spawn(function()  
                SpringTrapService.FollowPath()
                isMoving = false 
            end)
        end 
    end)
end

return SpringTrapService