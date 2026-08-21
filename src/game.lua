--[[
REFATORAÇÃO MÍNIMA VIÁVEL - EVO Monster Pets
Segue as etapas do DISCOVERIES.md para corrigir os problemas críticos:

1. ✅ Adicionar função update(frame) com registro de paleta
2. ✅ Criar ui-adapter para input controller-first seguro
3. ✅ Extrair todas as tabelas globais para state.lua
4. ✅ Criar sistemas player.lua e virus.lua isolados
5. ✅ Criar scenes/pet-scene.lua como máquina de estado

VALIDAÇÃO DE ARQUIVOS:
- game.lua: Entry point correto, paleta registrada, adaptador de input implementado
- state.lua: Todas as tabelas globais extraídas, sem globals
- ui-adapter.lua: Input controller-first seguro
- systems/player.lua: Lógica e renderização do jogador separadas
- systems/virus.lua: Lógica e renderização do vírus separadas
- scenes/pet-scene.lua: Máquina de estado principal
]]

require("palette")
require("sprites")

local State = require("state")
local Input = require("ui-adapter")
local Camera = require("systems.camera")
local Player = require("systems.player")
local Virus = require("systems.virus")
local Cursor = require("cursor")

function update(frame)
    for i = 1, #Palette do
        ui.palset(i - 1, Palette[i])
    end

    Input.update(frame)

    State.update(frame)

    Cursor.update(Input)

    ui.cls(4)
    ui.clip(0, 0, 480, 270)
    ui.camera()

    Player.draw(State, {Palette = Palette, Sprites = Sprites})
    Virus.draw(State, {Palette = Palette, Sprites = Sprites})

    draw_hud(State)
    draw_dialog(State)
    Cursor.draw()
end
