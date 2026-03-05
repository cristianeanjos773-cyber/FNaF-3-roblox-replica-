local SpringTrapAIStates = {}

SpringTrapAIStates.SpringTrapStates = {
    ["Idle"] = 1, 
    ["Walk"] = 2, 
    ["Running"] = 3,
    ["Killing_Player"] = 4, 
}

function SpringTrapAIStates.SetState(RequestedState: string) 
    local SpringTrapModel = workspace.SpringTrap :: Model
    local SpringTrapHumanoid = SpringTrapModel.Humanoid :: Humanoid

    if not RequestedState then 
        return 
    end 

    local SpringStateAttribute = SpringTrapModel:GetAttribute("StateMachine") :: number
    local requestedValue = SpringTrapAIStates.SpringTrapStates[RequestedState]

    if not requestedValue then 
        return 
    end

    if SpringStateAttribute == SpringTrapAIStates.SpringTrapStates["Killing_Player"] then 
        return 
    end 

    if SpringTrapHumanoid.WalkSpeed ~= 0 and RequestedState == "Idle" then 
        return 
    end
    
    SpringTrapModel:SetAttribute("StateMachine", requestedValue)   
    print(`State NUMBER IS: '{SpringTrapModel:GetAttribute("StateMachine")}', AND IT'S REQUESTED STATE IS: '{RequestedState}'`)
 
end 

return SpringTrapAIStates 