--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AnimInstances = ReplicatedStorage.ReplicatedStorage.AnimInstances :: any
local SpringTrapFolder = AnimInstances.SpringTrapAnims :: any
local SpringTrapAIStates = require(script.Parent.SpringTrapAIStates)
local LoadedTracksCache = {}
local LastTrack: AnimationTrack? = nil 
local SpringTrapAnimController = {}

SpringTrapAnimController.StateToAnimation = {
    [SpringTrapAIStates.SpringTrapStates["Walk"]] = SpringTrapFolder["WalkAnimation"], 
    [SpringTrapAIStates.SpringTrapStates["Running"]] = SpringTrapFolder["RunAnimation"],
    [SpringTrapAIStates.SpringTrapStates["Idle"]] = SpringTrapFolder["IdleAnimation"]
}

function SpringTrapAnimController.PlaySpringTrapAnims(CurrentSpringTrapState: number, SpringTrapChar: Model) 
    local Animation = SpringTrapAnimController.StateToAnimation[CurrentSpringTrapState]
    local Humanoid = SpringTrapChar:FindFirstChild("Humanoid") :: Humanoid
    local Animator = Humanoid:FindFirstChild("Animator") :: Animator

    if not LoadedTracksCache[CurrentSpringTrapState] then 
        LoadedTracksCache[CurrentSpringTrapState] = Animator:LoadAnimation(Animation)
    end 

    local currentTrack = LoadedTracksCache[CurrentSpringTrapState]

    if LastTrack and LastTrack ~= currentTrack then 
        LastTrack:Stop(0.2)
    end 

    if not currentTrack.IsPlaying then 
        currentTrack:Play(0.2)
        LastTrack = currentTrack
    end 

end  

return SpringTrapAnimController 