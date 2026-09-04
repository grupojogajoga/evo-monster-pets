-- src/pet.lua

local Pet = {}
Pet.__index = Pet

-- Cache de funções globais para otimização de performance no loop de update
local min = math.min
local max = math.max

function Pet:new()
    local instance = {
        fome = 100,
        saude = 100,
        level = 1,
        estagio = 1, -- 1: Ovo/Bebê, 2: Criança, 3: Jovem, 4: Adulto, 5: Endgame
        virus = false,
        vivo = true,
        tick_timer = 0
    }
    setmetatable(instance, Pet)
    return instance
end

function Pet:update(dt)
    if not self.vivo then return end

    self.tick_timer = self.tick_timer + dt

    -- Processa o ciclo vital a cada 1 segundo (tempo ajustável conforme o framerate do lupinho)
    if self.tick_timer >= 1.0 then
        self.tick_timer = 0
        
        -- Degradação natural
        self.fome = max(self.fome - 1, 0)

        -- Dano progressivo se estiver infectado
        if self.virus then
            self.saude = max(self.saude - 2, 0)
        end

        self:verificarMorte()
    end
end

function Pet:alimentar(valor)
    if self.vivo then
        self.fome = min(self.fome + valor, 100)
    end
end

function Pet:curar()
    if self.vivo then
        self.virus = false
        self.saude = min(self.saude + 50, 100)
    end
end

function Pet:infeccionar()
    if self.vivo and not self.virus then
        self.virus = true
    end
end

function Pet:subirLevel()
    if not self.vivo or self.level >= 25 then return end
    
    self.level = self.level + 1
    self:verificarEvolucao()
end

function Pet:verificarEvolucao()
    if self.level == 3 then
        self.estagio = 2
    elseif self.level == 10 then
        self.estagio = 3
    elseif self.level == 20 then
        self.estagio = 4
    elseif self.level == 25 then
        self.estagio = 5 -- Condição de vitória / Endgame atingida
    end
end

function Pet:verificarMorte()
    if self.fome == 0 or self.saude == 0 then
        self.vivo = false
    end
end

return Pet