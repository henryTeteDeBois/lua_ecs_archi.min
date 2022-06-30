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
    if cur and cur.on_enter then
        -- print('on enter=false', cur)
         cur.on_enter=false 
    end
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
            -- print('new state: ',c_sm.__cur_state,' => ',c_sm.__new_state)
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
            e:on('c_gravity', 'c_move_hrz', 'c_duck')
            e.c_move_hrz:preset(Preset.C_Move_Hrz.C_Wander_Stance)
        end

        if state.on_update then

            if c_b.on_ground then
                e:on('c_jump_act')
            end

            if not c_b.on_ground then
                e:off('c_jump_act')
            end
            if c_b.on_ground then
                print('on ground')
                local pad_d=love.keyboard.isDown('down')

                if pad_d then
                    c_sm:set(e.c_duck_stance)
                end
            end
        end

        if state.on_exit then
            e:off('c_duck')
        end
    end
end

--===================================#
--

S_HangPlatformStance=Tiny.processingSystem()
S_HangPlatformStance.active=false;

function S_HangPlatformStance:filter(e)
    return e:has_active('c_b', 'c_state_machine', 'c_hang_platform_stance')
end

function S_HangPlatformStance:process(e, dt)
    local c_b=e.c_b
    local c_sm=e.c_state_machine

    if c_b.hit_ground then
        e.c_hang_platform_stance.can_enter=true
    end

    if c_sm:is(C_HangPlatformStance) then
        local c_state=c_sm:get()
        local args = c_state.args
        local coll = args.coll
        local e_tl = c_state.args.coll.other

        if c_state.on_enter then
            e:off('c_gravity')
            e.c_hang_platform_stance.can_enter = false
        
            e.c_b.y=e_tl.c_b.y
            GAME.bump_world:update(e, c_b:left(), c_b:top(), c_b.w, c_b.h)

            e.c_move_hrz:preset(Preset.C_Move_Hrz.C_Hang_Platform_Stance)
        end

        if c_state.on_update then
            local pad_d=love.keyboard.isDown('down')
            local pad_u=love.keyboard.isDown('up')

            if pad_d then
                c_sm:set(e.c_hero_wander_st)
            elseif pad_u then
                c_sm:set(e.c_climb_platform_act, {coll=coll})
            end

            local tl_platf, _=GAME.bump_world:queryRect(c_b:left(), c_b:top(), c_b.w, 1, function(item)
                local c_tile=item.c_tile
                return Xtype.is(item, E_Tile) and c_tile:has_prop(Tl.Prop.Platform)
            end)
            if #tl_platf==0 then
                c_sm:set(e.c_hero_wander_st)
            end
        end

        if c_state.on_exit then
        end
    end
end


--===================================#
--

S_ClimbPlatformAct=Tiny.processingSystem()
S_ClimbPlatformAct.active=false;

function S_ClimbPlatformAct:filter(e)
    return e:has_active('c_b', 'c_state_machine', 'c_climb_platform_act')
end

function S_ClimbPlatformAct:process(e, dt)
    local c_b=e.c_b
    local c_sm=e.c_state_machine

    if c_sm:is(C_ClimbPlatformAct) then
        local state=c_sm:get()
        local args = state.args
        local coll = args.coll
        local e_tl = state.args.coll.other

        if state.on_enter then
            e:off('c_gravity', 'c_move_hrz')
            e.c_b.vx=0
        end

        if state.on_update then
            if e.c_anim.is_over then
                c_sm:set(e.c_hero_wander_st)
            end
        end

        if state.on_exit then
            e.c_b.y=e_tl.c_b:top()-e.c_b.h
            GAME.bump_world:update(e, c_b:left(), c_b:top(), c_b.w, c_b.h)
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

    if c_sm:is(C_ClimbCornerAct) then
        local state=c_sm:get()
        local args = state.args
        local coll = args.coll
        local e_tl = state.args.coll.other

        if state.on_enter then
            e:off('c_gravity', 'c_move_hrz')
            e.c_b.vx=0
            e.c_b.y=e_tl.c_b.y
            GAME.bump_world:update(e, c_b:left(), c_b:top(), c_b.w, c_b.h)
        end

        if state.on_update then
            if e.c_anim.is_over then
                c_sm:set(e.c_hero_wander_st)
            end
        end

        if state.on_exit then

            if coll.normal.x == -1 then
                e.c_b.x=e_tl.c_b:left()
            else
                e.c_b.x=e_tl.c_b:right()-e.c_b.w
            end

            e.c_b.y=e_tl.c_b:top()-e.c_b.h
            GAME.bump_world:update(e, c_b:left(), c_b:top(), c_b.w, c_b.h)
        end
    end
end

--===================================#
--

S_DuckStance=Tiny.processingSystem()
S_DuckStance.active=false;

function S_DuckStance:filter(e)
    return e:has_active('c_b', 'c_state_machine', 'c_duck_stance')
end

function S_DuckStance:process(e, dt)
    local c_b=e.c_b
    local c_sm=e.c_state_machine

    if c_sm:is(C_DuckStance) then
        local state=c_sm:get()
        local args = state.args
        -- local e_tl = state.args.coll.other

        if state.on_enter then
            e:off('c_move_hrz', 'c_jump_act', 'c_gravity')
            e.c_b.vx=0
            e.c_b.vy=0
        end

        if state.on_update then
            local pad_d=love.keyboard.isDown('down')
            local pad_a=love.keyboard.isDown('space')

            if not pad_d then
                c_sm:set(e.c_hero_wander_st)
            end

            if pad_a and c_b.standing_on_platform then
                c_b.ignore_platform=true
                print('c_b.ignore_platform = true')

                c_sm:set(e.c_hero_wander_st)
            end
        end

        if state.on_exit then
            -- e.c_b.y=e_tl.c_b:top()-e.c_b.h
            -- GAME.bump_world:update(e, c_b:left(), c_b:top(), c_b.w, c_b.h)
        end
    end
end

--===================================#
--

S_ClimbLadderStance=Tiny.processingSystem()
S_ClimbLadderStance.active=false;

function S_ClimbLadderStance:filter(e)
    return e:has_active('c_b', 'c_state_machine', 'c_climb_ladder_stance')
end

function S_ClimbLadderStance:process(e, dt)
    local c_b=e.c_b
    local c_sm=e.c_state_machine

    if c_sm:is(C_ClimbLadderStance) then
        local state=c_sm:get()
        local args = state.args
        local coll = args.coll
        local e_tl = state.args.coll.other

        if state.on_enter then
            e:off('c_move_hrz')
            e.c_b.vx=0
        end

        if state.on_update then
            -- if e.c_anim.is_over then
            --     c_sm:set(e.c_hero_wander_st)
            -- end
        end

        if state.on_exit then
            -- e.c_b.y=e_tl.c_b:top()-e.c_b.h
            -- GAME.bump_world:update(e, c_b:left(), c_b:top(), c_b.w, c_b.h)
        end
    end
end
