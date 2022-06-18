--===================================#
--

S_StateMachineHandler=Tiny.processingSystem()
S_StateMachineHandler.active=false;

function S_StateMachineHandler:filter(e)
    return e:has_active('c_state_machine')
end

function S_StateMachineHandler:process(e, dt)
    local c_sm=e.c_state_machine
    local cur = c_sm.__cur_state
    local new = c_sm.__new_state

    --== only once
    if cur and cur.on_enter then cur.on_enter=fase end
    -- if cur and cur.on_exit then cur.on_exit=fase end

    --== state change
    if cur ~= new then
        if cur and not cur.on_exit then
            cur.on_enter=false
            cur.on_update=false
            cur.on_exit=true

        elseif not cur or (cur and cur.on_exit) then
            
            if cur then
                cur.on_exit=false
            end

            if new then
                new.on_enter=true
                new.on_update=true
                new.on_exit=false
            end

            c_sm.__cur_state = c_sm.__new_state
        end
    end
end

--===================================#
--

S_HeroWanderSt=Tiny.processingSystem()
S_HeroWanderSt.active=false;

function S_HeroWanderSt:filter(e)
    return e:has_active('c_b', 'c_state_machine', 'c_hero_wander_st')
end

function S_HeroWanderSt:process(e, dt)
    local c_b=e.c_b
    local c_sm=e.c_state_machine

    if c_sm:is(C_HeroWanderSt) then
        local state=c_sm:get()

        if state.on_enter then
            e:on('c_gravity', 'c_move_hrz')
            -- self.c_move_hrz:settings(Settings.Move_Hrz.Hero_Wander)
        end

        if state.on_update then
        end

        if state.on_exit then            
        end
    end
end

--===================================#
--

S_ClimbCornerAct=Tiny.processingSystem()
S_ClimbCornerAct.active=false;

function S_ClimbCornerAct:filter(e)
    return e:has_active('c_b', 'c_state_machine', 'c_climb_corner_act')
end

function S_ClimbCornerAct:process(e, dt)
    local c_b=e.c_b
    local c_sm=e.c_state_machine

    if c_sm:is(C_HeroWanderSt) then
        local state=c_sm:get()

        if state.on_enter then
        end

        if state.on_update then
        end

        if state.on_exit then
        end
    end
end

--===================================#
--

S_HangOnLadderSt=Tiny.processingSystem()
S_HangOnLadderSt.active=false;

function S_HangOnLadderSt:filter(e)
    return e:has_active('c_b', 'c_state_machine', 'c_hang_on_ladder_st')
end

function S_HangOnLadderSt:process(e, dt)
    local c_b=e.c_b
    local c_sm=e.c_state_machine

    if c_sm:is(C_HeroWanderSt) then
        local state=c_sm:get()

        if state.on_enter then
        end

        if state.on_update then
        end

        if state.on_exit then            
        end
    end
end

--===================================#
--

S_HangOnPlatfSt=Tiny.processingSystem()
S_HangOnPlatfSt.active=false;

function S_HangOnPlatfSt:filter(e)
    return e:has_active('c_b', 'c_state_machine', 'c_hang_on_platf_st')
end

function S_HangOnPlatfSt:process(e, dt)
    local c_b=e.c_b
    local c_sm=e.c_state_machine

    if c_sm:is(C_HeroWanderSt) then
        local state=c_sm:get()

        if state.on_enter then
        end

        if state.on_update then
        end

        if state.on_exit then            
        end
    end
end