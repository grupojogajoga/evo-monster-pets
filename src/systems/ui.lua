-- ==========================================
-- SAMPLE HUD DRAW FUNCTION - EVOLUIR PARA MÓDULO REAL
-- ==========================================

local function draw_hud(state)
    -- Draw health bar
    ui.circfill(50, 50, 10, 2)
    ui.circfill(50, 50, 10, state.pet.life > 50 and 12 or state.pet.life > 25 and 14 or 4)
    
    -- Draw hunger indicator
    ui.rectfill(50, 70, 50 + state.pet.hunger, 75, 12)
    ui.rect(50, 70, 100, 10, 15)
    
    -- Draw level indicator
    ui.print("NIVEL " .. state.pet.level, 350, 250, 12)
    
    -- Draw inventory status
    ui.print("MED: " .. state.inventory.medicine .. "  COM: " .. state.inventory.food, 200, 250, 12)
end

-- ==========================================
-- SAMPLE DIALOG DRAW FUNCTION - EVOLUIR PARA MÓDULO REAL
-- ==========================================

local function draw_dialog(state)
    if state.dialog_counter < 60 then return end
    
    ui.rectfill(100, 200, 380, 240, 1)
    ui.rect(100, 200, 280, 40, 12)
    ui.print("Olá! Eu sou um monstro fofo!", 120, 220, 12)
    
    if state.pet_speak_counter > 120 then
        ui.print("Toque em mim para brincar!", 140, 240, 12)
    end
end

return {
    draw_hud = draw_hud,
    draw_dialog = draw_dialog,
}