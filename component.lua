Comp = Class('Comp')

function Comp:__construct(e)
    self.active = true
    self.e = e
end

function Comp:on()
    self.active = true;
end

function Comp:off()
    self.active = false;
end

function Comp:is_on()
    return self.active
end

--===================================--
--



