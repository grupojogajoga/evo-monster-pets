--[[
CURSOR DE MOUSE — LUPI (via D-pad)
Implementa um ponteiro de mouse controlado por D-pad para navegação por menus.
Seguir o mesmo padrão de maximum decoupling: lógica separada da renderização.
Implementado como um sistema completo com state + logic + draw.

Usado em EVO Monster Pets para seleção em menus (escolha de pets, diálogo, etc.).
]]

local Cursor = {}

-- Estado local do cursor (sem globals)
function Cursor.new(initial_state)
    local self = {
        x = initial_state and initial_state.x or 240,
        y = initial_state and initial_state.y or 135,
        velocidade = 3,
        visivel = true,
        ativo = false,
        modo = "selecione" -- "selecione", "menu", "conversa"
    }
    
    return self
end

-- Atualiza a posição do cursor usando input controller-first
function Cursor.update(self, input)
    if not self.ativo then return end
    
    if input.is_action("left", 1) then self.x = self.x - self.velocidade end
    if input.is_action("right", 1) then self.x = self.x + self.velocidade end
    if input.is_action("up", 1) then self.y = self.y - self.velocidade end
    if input.is_action("down", 1) then self.y = self.y + self.velocidade end
    
    -- Clamp para dentro da tela (480x270); ui.mid é a forma idiomática
    self.x = ui.mid(0, self.x, 480)
    self.y = ui.mid(0, self.y, 270)
    
    -- Detectar seleção quando BTN_Z é pressionado
    if input.is_action_pressed("confirm", 1) then
        self:selecionar()
    end
end

-- Renderiza o cursor na tela
function Cursor.draw(self, assets)
    if not self.visivel then return end
    
    -- Seta do cursor (contorno)
    ui.line(self.x, self.y, self.x + 10, self.y + 18, 15)
    ui.line(self.x, self.y, self.x + 5, self.y + 17, 15)
    ui.line(self.x + 5, self.y + 17, self.x + 10, self.y + 18, 15)
    
    -- Preenchimento escuro (use um índice real, não 0)
    ui.line(self.x + 2, self.y + 2, self.x + 8, self.y + 15, 1)
    ui.line(self.x + 3, self.y + 3, self.x + 7, self.y + 14, 1)
end

-- Detecta se um item foi selecionado
function Cursor.selecionar(self)
    -- Verificar colisão com elementos da interface (implementar quando os elementos existirem)
    -- Por enquanto, apenas logar a seleção
    ui.log("Cursor selecionou posição: " .. self.x .. "," .. self.y)
end

function Cursor.ativar(self, modo)
    self.ativo = true
    self.modo = modo or "selecione"
end

function Cursor.desativar(self)
    self.ativo = false
end

return Cursor