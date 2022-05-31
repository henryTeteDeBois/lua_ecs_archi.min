C_Body = Class('C_Body', Comp)

function C_Body:__construct(e, x, y, w, h)
    Comp.__construct(self, e)
    -- print(self.active)
    --==
    self.x = x or 0
    self.y = y or 0
    self.w = w or 1
    self.h = h or 1
    -- self.mass = 2
    --==
    self.draw_outline = true
    self.draw_outile_color = {0,1,0,1}
    --==
    GAME.bump_world:add(e, self.x, self.y, self.w, self.h)
end