-- Extracted global state from game.lua
-- Sem globals, sem estado mutável compartilhado, com injeção de dependência

local Palette = require("palette")
local Sprites = require("sprites")

local BTN = require("btn")

local State = {}

-- Estados do jogo
State.SCREEN_TITLE = 1
State.SCREEN_PET_CHOICE = 2
State.SCREEN_PET = 3
State.SCREEN_BOOK = 4
State.SCREEN_MEDICINE = 5
State.SCREEN_FOOD = 6
State.SCREEN_BATTLE = 7
State.SCREEN_END = 8

-- Estados do pet
State.PET_STATUS_NORMAL = 1
State.PET_STATUS_HUNGRY = 2
State.PET_STATUS_SICK = 3
State.PET_STATUS_TALK = 4

-- Estado do pet
State.pet = {
    x = 240,
    y = 180,
    color = 12,
    level = 1,
    exp = 0,
    life = 100,
    hunger = 50,
    talk_counter = 0,
    status = State.PET_STATUS_NORMAL,
    stage = 1,
    can_walk = true,
}

-- Informações do vírus
State.virus = {
    x = 0,
    y = 0,
    active = false,
    timer = 0,
}

-- Contadores de fala
State.dialog_counter = 0
State.pet_speak_counter = 0

-- Controle de menu e entrada
State.menu_selection = 1
State.button_pressed = false
State.current_scene = State.SCREEN_PET

-- Gerenciamento de alimentos e medicamentos
State.food = {
    x = 0,
    y = 0,
    active = false,
}

State.medicine = {
    x = 0,
    y = 0,
    active = false,
}

State.inventory = {
    medicine = 0,
    food = 0,
}

-- Estado da batalha
State.battle = {
    state = State.BATTLE_STATE_READY,
    player_health = 100,
    enemy_health = 100,
}

State.BATTLE_STATE_READY = 1
State.BATTLE_STATE_ACTIVE = 2
State.BATTLE_STATE_PLAYER_TURN = 3
State.BATTLE_STATE_ENEMY_TURN = 4

-- Estado do livro
State.book = {
    entry_count = 0,
}

-- Inicializa o estado com valores padrão
function State.init()
    State.pet = {
        x = 240,
        y = 180,
        color = 12,
        level = 1,
        exp = 0,
        life = 100,
        hunger = 50,
        talk_counter = 0,
        status = State.PET_STATUS_NORMAL,
        stage = 1,
        can_walk = true,
    }
    
    State.virus = {
        x = 0,
        y = 0,
        active = false,
        timer = 0,
    }
    
    State.dialog_counter = 0
    State.pet_speak_counter = 0
    State.menu_selection = 1
    State.current_scene = State.SCREEN_PET
    
    State.food = {
        x = 0,
        y = 0,
        active = false,
    }
    
    State.medicine = {
        x = 0,
        y = 0,
        active = false,
    }
    
    State.inventory = {
        medicine = 0,
        food = 0,
    }
    
    State.battle = {
        state = State.BATTLE_STATE_READY,
        player_health = 100,
        enemy_health = 100,
    }
    
    State.book = {
        entry_count = 0,
    }
end

-- Atualiza a lógica do estado (não desenha)
function State.update(input)
    local btn_z = input.is_action_pressed("confirm", 1)
    
    if btn_z and not State.button_pressed then
        State.button_pressed = true
        if State.current_scene == State.SCREEN_TITLE then
            State.current_scene = State.SCREEN_PET_CHOICE
        elseif State.current_scene == State.SCREEN_PET_CHOICE then
            State.current_scene = State.SCREEN_PET
        elseif State.current_scene == State.SCREEN_PET then
            if State.pet.x > 200 then
                State.current_scene = State.SCREEN_BOOK
            end
        end
    elseif not btn_z then
        State.button_pressed = false
    end
    
    State.dialog_counter = State.dialog_counter + 1
    State.pet_speak_counter = State.pet_speak_counter + 1
    
    if State.pet.hunger > 100 then
        State.pet.hunger = 100
    end
    
    State.virus.timer = State.virus.timer - 1
    if State.virus.timer <= 0 and State.virus.active then
        State.virus.active = false
    end
end

return State