--[[
SISTEMA DE PLAYER - LUPI
Separação entre lógica e renderização conforme practices.md:
- Lógica: posição, movimento, estado
- Renderização: apenas desenhar
- Sem globals, injeção de dependência
]]

local PlayerSystem = {}

-- Lógica do jogador: estado + movimento + física
function PlayerSystem.update(player_state, input, camera)
    -- Movimento básico com teclado/gamepad
    local speed = 3
    local new_x = player_state.x
    local new_y = player_state.y
    
    if input.is_action("left", 1) then
        new_x = new_x - speed
    elseif input.is_action("right", 1) then
        new_x = new_x + speed
    end
    
    if input.is_action("up", 1) then
        new_y = new_y - speed
    elseif input.is_action("down", 1) then
        new_y = new_y + speed
    end
    
    -- Limitar dentro da tela
    if new_x < 0 then new_x = 0 end
    if new_y < 0 then new_y = 0 end
    if new_x > 480 - 16 then new_x = 480 - 16 end
    if new_y > 270 - 16 then new_y = 270 - 16 end
    
    player_state.x = new_x
    player_state.y = new_y
    
    -- Atualizar limites da câmera com base na posição do jogador
    camera:update_bounds(new_x, new_y)
end

-- Renderização do jogador: apenas desenhar o estado
function PlayerSystem.draw(player_state, assets)
    -- Usar ui.circfill para desenhar o pet como um círculo
    ui.circfill(player_state.x, player_state.y, 14, player_state.color)
    
    -- Desenhar o corpo (retângulo abaixo do círculo)
    ui.rect(player_state.x-6, player_state.y+5, 12, 8, player_state.color)
end

return PlayerSystem