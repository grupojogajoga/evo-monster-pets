-- Adaptador de input seguro controller-first
-- Adapta as diferenças entre console e lupinho, usa gamepad padrão P1

local Input = {}

local pad_states = {}

function Input.init()
    for i = 0, 3 do
        pad_states[i] = {}
    end
end

require("btn")

local BTN = require("btn")

local Input = {}

local pad_states = {}

function Input.init()
    for i = 0, 3 do
        pad_states[i] = {}
    end
end

function Input.update(frame)
    for i = 0, 3 do
        pad_states[i].BTN_Z = ui.btn(BTN.Z, i) ~= false
        pad_states[i].UP = ui.btn(BTN.UP, i) ~= false
        pad_states[i].DOWN = ui.btn(BTN.DOWN, i) ~= false
        pad_states[i].LEFT = ui.btn(BTN.LEFT, i) ~= false
        pad_states[i].RIGHT = ui.btn(BTN.RIGHT, i) ~= false
    end
end

function Input.is_action(action, player_idx)
    local key = action:upper()
    if player_idx and player_idx > 0 then
        return pad_states[player_idx][key] or false
    end
    return pad_states[1][key] or pad_states[0][key] or false
end

function Input.is_action_pressed(action, player_idx)
    if player_idx and player_idx > 0 then
        return ui.btnp(BTN.Z, player_idx) ~= false
    end
    return ui.btnp(BTN.Z) ~= false
end

return Input