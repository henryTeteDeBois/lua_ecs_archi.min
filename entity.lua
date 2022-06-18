Entity=Class('Entity')

local __set_comp=function(self, value, ...)
    local comps_attribute_as_string={...}
    for _, comp_name in ipairs(comps_attribute_as_string) do
        local comp=self[comp_name]
        if comp then
            comp.active=value
        end
    end
end

function Entity:__construct(e)
    GAME.tiny_world:addEntity(e)
end

function Entity:on(...)
  --print('on', ...)
    __set_comp(self, true, ...)
end

function Entity:off(...)
  --print('off', ...)
    __set_comp(self, false, ...)
end

function Entity:all_off()
    for k, v in pairs(self) do
        if Xtype.is(v, Comp) then
            v:off()
        end
    end
end

function Entity:has_active(...)
    local comps_attribute_as_string={...}
    for _, comp_name in ipairs(comps_attribute_as_string) do
        local comp=self[comp_name]
        -- print(self, comp_name, comp, comp.active)

        if not comp or not comp.active then
            return false
        end
    end
    return true
end

--===================================#
-- FOO

E_Foo=Class('E_Foo', Entity)

function E_Foo:__construct(x, y, w, h)
    Entity:__construct(self)
    --==
    self.c_b=C_Body(self, x, y, w, h)
    self.c_gravity=C_Gravity(self)
    self.c_move_hrz=C_MoveHrz(self)
    self.c_move_vert=C_MoveVert(self)
    --==
    self.c_anim=C_Anim(self, Atlas.Hero)
    self.c_anim:set('run')
    --== states
    self.c_state_machine=C_StateMachine(self)
    self.c_hero_wander_st=C_HeroWanderSt(self)

    self.c_state_machine:set(self.c_hero_wander_st)

    -- self.c_climb_corner_state = C_ClimbCornerState()
    self.c_hang_platform_state = C_HangPlatformState()
    -- self.c_climb_ladder_state = C_ClimbLadderState()

    self:off('c_move_vert')
end

--===================================#

-- TILE

E_Tile=Class('E_Tile', Entity)

function E_Tile:__construct(ix, iy, type)
    Entity:__construct(self)
    --== tile collision properties
    local props=0
    if type==Tl.Type.Wall or type==Tl.Type.LadW or type==Tl.Type.Platform then
        props=props+Tl.Prop.Ground
    end
    if type==Tl.Type.Wall or type==Tl.Type.LadW then
        props=props+Tl.Prop.Ceil
    end
    if type==Tl.Type.Platform then
        props=props+Tl.Prop.Platform
    end
    if type==Tl.Type.LadW or type==Tl.Type.Lad then
        props=props+Tl.Prop.Ladder
    end
    if type==Tl.Type.LadW or type==Tl.Type.Wall then
        props=props+Tl.Prop.Wall
    end
    --==
    self.c_b=C_Body(self, (ix-1)*Tl.Dim, (iy-1)*Tl.Dim, Tl.Dim, Tl.Dim)
    self.c_tile=C_Tile(self, ix, iy, type,props)
    --==
    -- if type == Tl.Type.Empty then
    self.c_b.draw_outline=false
    -- end
    --== C_Tile ?
    self.ix=ix
    self.iy=iy
    self.type=type
end
