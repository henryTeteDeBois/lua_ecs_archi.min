--===================================#
--

StateComp=Class('StateComp', Comp)

function StateComp:__construct(e)
    Comp.__construct(self, e)
    --==
    self.on_enter=false
    self.on_update=false
    self.on_exit=false
    --==
    self.is_entering_ok=false
    self.is_exiting_ok=false
    --==
    self.args={}
end

--===================================#
--

C_StateMachine=Class('C_StateMachine', Comp)

function C_StateMachine:__construct(e)
    Comp.__construct(self, e)
    --==
    self.__cur_state=nil
    self.__new_state=nil
end

function C_StateMachine:set(state_comp, args_table)
    self.__new_state=state_comp
    if self.__new_state then
        self.__new_state.args=args_table
    end
end

function C_StateMachine:get()
    return self.__cur_state
end

function C_StateMachine:is(comp_class_name)
    return Xtype.is(self:get(), comp_class_name)
end

--===================================#
--

C_HeroWanderSt=Class('C_HeroWanderSt', StateComp)

function C_HeroWanderSt:__construct(e)
    StateComp.__construct(self, e)
    --==
end

--===================================#
--

C_ClimbCornerAct=Class('C_ClimbCornerAct', StateComp)

function C_ClimbCornerAct:__construct(e)
    StateComp.__construct(self, e)
    --==
    self.is_climbing=false
end

--===================================#
--

C_HangPlatformStance=Class('C_HangPlatformStance', StateComp)

function C_HangPlatformStance:__construct(e)
    StateComp.__construct(self, e)
    --==
    self.is_hanging=false
end

--===================================#
--

C_ClimbPlatformAct=Class('C_ClimbPlatformAct', StateComp)

function C_ClimbPlatformAct:__construct(e)
    StateComp.__construct(self, e)
    --==
end

--===================================#
--

C_ClimbPlatformState=Class('C_ClimbPlatformState', StateComp)

function C_ClimbPlatformState:__construct(e)
    StateComp.__construct(self, e)
    --==
    self.is_climbing=false
end

--===================================#
--

C_ClimbLadderStance=Class('C_ClimbLadderStance', StateComp)

function C_ClimbLadderStance:__construct(e)
    StateComp.__construct(self, e)
      --==
      self.is_hanging=false
end

--===================================#
--

C_DuckStance=Class('C_DuckStance', StateComp)

function C_DuckStance:__construct(e)
    StateComp.__construct(self, e)
    --==
end


