Comp=Class('Comp')

function Comp:__construct(e)
    self.active=true
    self.e=e
end

function Comp:on()
    self.active=true;
end

function Comp:off()
    self.active=false;
end

function Comp:is_on()
    return self.active
end

--===================================#
--

C_Mario_Controls=Class('C_Mario_Controls', Comp)

function C_Mario_Controls:__construct(e)
    Comp.__construct(self, e)
    --==
    self.state='walk' -- 'walk' | 'run' | 'jump'
    -- self.__acc=nil
    self.old_r=false
    self.vy_tot = 0
end

--===================================#
--

C_Tile=Class('C_Tile', Comp)

function C_Tile:__construct(e, ix, iy, type, props)
    Comp.__construct(self, e)
    --==
    self.props=props or 0
    self.index = V2(ix,iy)
    self.type=type
end

function C_Tile:has_prop(property)
    return Bit.band(self.props, property) == property
end

function C_Tile:has_all_props(...)
    for _, property in ipairs({...}) do
        if not self:has_prop(property) then
            return false
        end
    end
    return true
end

function C_Tile:has_only_props(...)
    local n=self.props
    for _, property in ipairs({...}) do
        n=n-Bit.band(self.props, property)
    end
    return n==0
end

--===================================#
--

C_Gravity=Class('C_Gravity', Comp)

function C_Gravity:__construct(e)
    Comp.__construct(self, e)
    --==
end

--===================================#
--

C_MoveHrz=Class('C_MoveHrz', Comp)

function C_MoveHrz:__construct(e)
    Comp.__construct(self, e)
    --==
end

--===================================#
--

C_MoveVert=Class('C_MoveVert', Comp)

function C_MoveVert:__construct(e)
    Comp.__construct(self, e)
    --==
end

--===================================#
--

C_Anim=Class('C_Anim', Comp)

function C_Anim:__construct(e, atlas)
    Comp.__construct(self, e)
    --==
    self.atlas=atlas
    self.props=nil
    self.timer=0
    self.ox=0.5 -- ratio
    self.oy=1 -- ratio
    self.dir=1 -- 1 or -1
end

function C_Anim:set(name, ox, oy)
    self.props=self.atlas[name]
    self.ox=ox or self.ox
    self.oy=oy or self.oy
end



