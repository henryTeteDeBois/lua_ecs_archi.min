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

