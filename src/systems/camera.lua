--[[
SISTEMA DA CÂMARA - LUPI
Seguir as guardrails do practices.md:
- Separação entre lógica e renderização
- Injeção de dependência: receber world, camera e state como parâmetros
- Injeção mínima: apenas o que é necessário
- Sem globals, sem estado mutável compartilhado
- Usar ui.camera() antes do HUD
- clamp a câmera para não sair dos limites do mapa
]]

local Camera = {}

-- Atualiza os limites da câmera baseado na posição do jogador
-- Receber apenas o estado necessário (posição do jogador)
function Camera.update(player_x, player_y)
    -- Centralizar jogador na tela
    Camera.x = player_x - 240
    Camera.y = player_y - 135
    
    -- Clamp para não sair dos limites (mapa 480×270, tela 480×270)
    if Camera.x < 0 then Camera.x = 0 end
    if Camera.y < 0 then Camera.y = 0 end
    if Camera.x > 0 then Camera.x = 0 end
    if Camera.y > 0 then Camera.y = 0 end
end

function Camera.apply()
    ui.camera(Camera.x, Camera.y)
end

return Camera