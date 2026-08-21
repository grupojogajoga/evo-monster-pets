--[[
SISTEMA DE VÍRUS - LUPI
Separado da lógica principal de game.lua conforme practices.md
- Atualizar estado de doenças e risco de infecção
- Sem globals, injeção de dependência
]]

local VirusSystem = {}

function VirusSystem.update(state, input)
    -- Aleatorizar vírus esporadicamente (a cada 600 frames)
    if State.virus.timer <= 0 and State.virus.active == false then
        if math.random(1, 600) == 1 then
            State.virus.active = true
            State.virus.timer = 600
            State.pet.status = State.PET_STATUS_SICK
        end
    end
    
    State.virus.timer = State.virus.timer - 1
end

function VirusSystem.draw(state, assets)
    if state.virus.active then
        ui.circfill(state.virus.x, state.virus.y, 8, 2)
        ui.print("VIRUS", state.virus.x - 20, state.virus.y - 10, 7)
    end
end

return VirusSystem