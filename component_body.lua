C_Body=Class('C_Body', Comp)

function C_Body:__construct(e, x, y, w, h)
    Comp.__construct(self, e)
    --== physic
    self.x=x or 0
    self.y=y or 0
    self.w=w or 1
    self.h=h or 1
    self.vx=0
    self.vy=0
    --==
    self.acc_y=0
    self.acc_x=0
    -- self.jmp_*$
    --== collision
    self.colls = {}
    self.on_ground = false
    -- self.on_platform=false
    -- self.on_ladder=false
    --== a mettre coté components ?
    self.is_on_ground=false
    
    -- self.is_platform_hanging=false
    -- self.is_platform_climbing=false

    -- self.is_corner_hanging=false    
    -- self.is_ladder_climbing=false
    
    -- self.can_platform_hang=false
    -- self.can_platform_climb=false

    -- self.can_corner_climb=false

    -- self.can_ladder_climb_up=false
    -- self.can_ladder_climb_down=false
    --==
    self.draw_outline=true
    self.draw_outile_color={0,1,0,1}
    --==
    GAME.bump_world:add(e, self.x, self.y, self.w, self.h)
end

function C_Body:bot()
    return self:top()+self.h
end

function C_Body:top()
    return self.y
end

function C_Body:right()
    return self:left()+self.w
end

function C_Body:left()
    return self.x
end

function C_Body:mid_x()
    return self:left()+self.w*.5
end

function C_Body:mid_y()
    return self:top()+self.h*.5
end

function C_Body:mid()
    return V2(self:mid_x(), self:mid_y())
end