--===================================#
--

C_JumpAct=Class('C_JumpAct', StateComp)

function C_JumpAct:__construct(e)
    StateComp.__construct(self, e)
    --==
    self.impulse_y=-358 
end
