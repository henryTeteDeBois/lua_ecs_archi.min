S_DrawBodyOutline = Tiny.processingSystem()
S_DrawBodyOutline.active = false;

function S_DrawBodyOutline:filter(e)
    return e:has_active('c_b') and e.c_b.draw_outline == true
end

function S_DrawBodyOutline:process(e, dt)
    local c_b = e.c_b
    
    love.graphics.setColor(unpack(c_b.draw_outile_color))
    love.graphics.setLineWidth(1)
    love.graphics.rectangle('line', c_b.x, c_b.y, c_b.w, c_b.h)
    
    -- hitbox origin
    -- love.graphics.setColor(unpack(c_b.draw_hitbox_color))
    -- love.graphics.line(c_b.x, c_b.y-3, c_b.x, c_b.y+3)
    -- love.graphics.line(c_b.x-3, c_b.y, c_b.x+3, c_b.y)
    -- love.graphics.setColor(1,1,1)
    -- love.graphics.line(c_b.x, c_b.y-2, c_b.x, c_b.y+2)
    -- love.graphics.line(c_b.x-2, c_b.y, c_b.x+2, c_b.y)
    love.graphics.setColor(1,1,1)
end