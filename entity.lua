Entity=Class('Entity')

local __set_comp=function(self, value, ...)
    local comps_attribute_as_string={...}
    for _, comp_name in ipairs(comps_attribute_as_string) do
        local comp=self[comp_name]
        if comp then
            comp.active=false
        end
    end
end

function Entity:__construct(e)
    GAME.tiny_world:addEntity(e)
end

function Entity:on(...)
    __set_comp(self, true, ...)
end

function Entity:off(...)
    __set_comp(self, false, ...)
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
    self.c_mario_controls=C_Mario_Controls(self)
end

--===================================#

-- TILE

E_Tile=Class('E_Tile', Entity)

function E_Tile:__construct(ix, iy, type)
    Entity:__construct(self)
    --==
    self.c_b=C_Body(self, (ix-1)*16, (iy-1)*16, 16, 16)

    --== C_Tile ?
    self.ix=ix
    self.iy=iy
    self.type=type
    if type == Tl.Type.Empty then
        self.c_b.draw_outline=false
    end
end
